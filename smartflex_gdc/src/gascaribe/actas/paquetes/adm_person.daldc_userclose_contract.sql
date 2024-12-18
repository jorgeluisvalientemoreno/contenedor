CREATE OR REPLACE PACKAGE adm_person.daldc_userclose_contract
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  11/06/2024   Adrianavg   OSF-2813: Migrar del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuID_USERCLOSE_CONTRACT in LDC_USERCLOSE_CONTRACT.ID_USERCLOSE_CONTRACT%type
	)
	IS
		SELECT LDC_USERCLOSE_CONTRACT.*,LDC_USERCLOSE_CONTRACT.rowid
		FROM LDC_USERCLOSE_CONTRACT
		WHERE
		    ID_USERCLOSE_CONTRACT = inuID_USERCLOSE_CONTRACT;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_USERCLOSE_CONTRACT.*,LDC_USERCLOSE_CONTRACT.rowid
		FROM LDC_USERCLOSE_CONTRACT
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_USERCLOSE_CONTRACT  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_USERCLOSE_CONTRACT is table of styLDC_USERCLOSE_CONTRACT index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_USERCLOSE_CONTRACT;

	/* Tipos referenciando al registro */
	type tytbID_USERCLOSE_CONTRACT is table of LDC_USERCLOSE_CONTRACT.ID_USERCLOSE_CONTRACT%type index by binary_integer;
	type tytbUSER_REQUEST_APROVE is table of LDC_USERCLOSE_CONTRACT.USER_REQUEST_APROVE%type index by binary_integer;
	type tytbUSER_APROVE is table of LDC_USERCLOSE_CONTRACT.USER_APROVE%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_USERCLOSE_CONTRACT is record
	(
		ID_USERCLOSE_CONTRACT   tytbID_USERCLOSE_CONTRACT,
		USER_REQUEST_APROVE   tytbUSER_REQUEST_APROVE,
		USER_APROVE   tytbUSER_APROVE,
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
		inuID_USERCLOSE_CONTRACT in LDC_USERCLOSE_CONTRACT.ID_USERCLOSE_CONTRACT%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuID_USERCLOSE_CONTRACT in LDC_USERCLOSE_CONTRACT.ID_USERCLOSE_CONTRACT%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuID_USERCLOSE_CONTRACT in LDC_USERCLOSE_CONTRACT.ID_USERCLOSE_CONTRACT%type
	);

	PROCEDURE getRecord
	(
		inuID_USERCLOSE_CONTRACT in LDC_USERCLOSE_CONTRACT.ID_USERCLOSE_CONTRACT%type,
		orcRecord out nocopy styLDC_USERCLOSE_CONTRACT
	);

	FUNCTION frcGetRcData
	(
		inuID_USERCLOSE_CONTRACT in LDC_USERCLOSE_CONTRACT.ID_USERCLOSE_CONTRACT%type
	)
	RETURN styLDC_USERCLOSE_CONTRACT;

	FUNCTION frcGetRcData
	RETURN styLDC_USERCLOSE_CONTRACT;

	FUNCTION frcGetRecord
	(
		inuID_USERCLOSE_CONTRACT in LDC_USERCLOSE_CONTRACT.ID_USERCLOSE_CONTRACT%type
	)
	RETURN styLDC_USERCLOSE_CONTRACT;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_USERCLOSE_CONTRACT
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_USERCLOSE_CONTRACT in styLDC_USERCLOSE_CONTRACT
	);

	PROCEDURE insRecord
	(
		ircLDC_USERCLOSE_CONTRACT in styLDC_USERCLOSE_CONTRACT,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_USERCLOSE_CONTRACT in out nocopy tytbLDC_USERCLOSE_CONTRACT
	);

	PROCEDURE delRecord
	(
		inuID_USERCLOSE_CONTRACT in LDC_USERCLOSE_CONTRACT.ID_USERCLOSE_CONTRACT%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_USERCLOSE_CONTRACT in out nocopy tytbLDC_USERCLOSE_CONTRACT,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_USERCLOSE_CONTRACT in styLDC_USERCLOSE_CONTRACT,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_USERCLOSE_CONTRACT in out nocopy tytbLDC_USERCLOSE_CONTRACT,
		inuLock in number default 1
	);

	PROCEDURE updUSER_REQUEST_APROVE
	(
		inuID_USERCLOSE_CONTRACT in LDC_USERCLOSE_CONTRACT.ID_USERCLOSE_CONTRACT%type,
		isbUSER_REQUEST_APROVE$ in LDC_USERCLOSE_CONTRACT.USER_REQUEST_APROVE%type,
		inuLock in number default 0
	);

	PROCEDURE updUSER_APROVE
	(
		inuID_USERCLOSE_CONTRACT in LDC_USERCLOSE_CONTRACT.ID_USERCLOSE_CONTRACT%type,
		isbUSER_APROVE$ in LDC_USERCLOSE_CONTRACT.USER_APROVE%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetID_USERCLOSE_CONTRACT
	(
		inuID_USERCLOSE_CONTRACT in LDC_USERCLOSE_CONTRACT.ID_USERCLOSE_CONTRACT%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_USERCLOSE_CONTRACT.ID_USERCLOSE_CONTRACT%type;

	FUNCTION fsbGetUSER_REQUEST_APROVE
	(
		inuID_USERCLOSE_CONTRACT in LDC_USERCLOSE_CONTRACT.ID_USERCLOSE_CONTRACT%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_USERCLOSE_CONTRACT.USER_REQUEST_APROVE%type;

	FUNCTION fsbGetUSER_APROVE
	(
		inuID_USERCLOSE_CONTRACT in LDC_USERCLOSE_CONTRACT.ID_USERCLOSE_CONTRACT%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_USERCLOSE_CONTRACT.USER_APROVE%type;


	PROCEDURE LockByPk
	(
		inuID_USERCLOSE_CONTRACT in LDC_USERCLOSE_CONTRACT.ID_USERCLOSE_CONTRACT%type,
		orcLDC_USERCLOSE_CONTRACT  out styLDC_USERCLOSE_CONTRACT
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_USERCLOSE_CONTRACT  out styLDC_USERCLOSE_CONTRACT
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_USERCLOSE_CONTRACT;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALDC_USERCLOSE_CONTRACT
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO807';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_USERCLOSE_CONTRACT';
	 cnuGeEntityId constant varchar2(30) := 5802; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuID_USERCLOSE_CONTRACT in LDC_USERCLOSE_CONTRACT.ID_USERCLOSE_CONTRACT%type
	)
	IS
		SELECT LDC_USERCLOSE_CONTRACT.*,LDC_USERCLOSE_CONTRACT.rowid
		FROM LDC_USERCLOSE_CONTRACT
		WHERE  ID_USERCLOSE_CONTRACT = inuID_USERCLOSE_CONTRACT
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_USERCLOSE_CONTRACT.*,LDC_USERCLOSE_CONTRACT.rowid
		FROM LDC_USERCLOSE_CONTRACT
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_USERCLOSE_CONTRACT is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_USERCLOSE_CONTRACT;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_USERCLOSE_CONTRACT default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.ID_USERCLOSE_CONTRACT);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuID_USERCLOSE_CONTRACT in LDC_USERCLOSE_CONTRACT.ID_USERCLOSE_CONTRACT%type,
		orcLDC_USERCLOSE_CONTRACT  out styLDC_USERCLOSE_CONTRACT
	)
	IS
		rcError styLDC_USERCLOSE_CONTRACT;
	BEGIN
		rcError.ID_USERCLOSE_CONTRACT := inuID_USERCLOSE_CONTRACT;

		Open cuLockRcByPk
		(
			inuID_USERCLOSE_CONTRACT
		);

		fetch cuLockRcByPk into orcLDC_USERCLOSE_CONTRACT;
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
		orcLDC_USERCLOSE_CONTRACT  out styLDC_USERCLOSE_CONTRACT
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_USERCLOSE_CONTRACT;
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
		itbLDC_USERCLOSE_CONTRACT  in out nocopy tytbLDC_USERCLOSE_CONTRACT
	)
	IS
	BEGIN
			rcRecOfTab.ID_USERCLOSE_CONTRACT.delete;
			rcRecOfTab.USER_REQUEST_APROVE.delete;
			rcRecOfTab.USER_APROVE.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_USERCLOSE_CONTRACT  in out nocopy tytbLDC_USERCLOSE_CONTRACT,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_USERCLOSE_CONTRACT);

		for n in itbLDC_USERCLOSE_CONTRACT.first .. itbLDC_USERCLOSE_CONTRACT.last loop
			rcRecOfTab.ID_USERCLOSE_CONTRACT(n) := itbLDC_USERCLOSE_CONTRACT(n).ID_USERCLOSE_CONTRACT;
			rcRecOfTab.USER_REQUEST_APROVE(n) := itbLDC_USERCLOSE_CONTRACT(n).USER_REQUEST_APROVE;
			rcRecOfTab.USER_APROVE(n) := itbLDC_USERCLOSE_CONTRACT(n).USER_APROVE;
			rcRecOfTab.row_id(n) := itbLDC_USERCLOSE_CONTRACT(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuID_USERCLOSE_CONTRACT in LDC_USERCLOSE_CONTRACT.ID_USERCLOSE_CONTRACT%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuID_USERCLOSE_CONTRACT
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
		inuID_USERCLOSE_CONTRACT in LDC_USERCLOSE_CONTRACT.ID_USERCLOSE_CONTRACT%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuID_USERCLOSE_CONTRACT = rcData.ID_USERCLOSE_CONTRACT
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
		inuID_USERCLOSE_CONTRACT in LDC_USERCLOSE_CONTRACT.ID_USERCLOSE_CONTRACT%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuID_USERCLOSE_CONTRACT
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuID_USERCLOSE_CONTRACT in LDC_USERCLOSE_CONTRACT.ID_USERCLOSE_CONTRACT%type
	)
	IS
		rcError styLDC_USERCLOSE_CONTRACT;
	BEGIN		rcError.ID_USERCLOSE_CONTRACT:=inuID_USERCLOSE_CONTRACT;

		Load
		(
			inuID_USERCLOSE_CONTRACT
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
		inuID_USERCLOSE_CONTRACT in LDC_USERCLOSE_CONTRACT.ID_USERCLOSE_CONTRACT%type
	)
	IS
	BEGIN
		Load
		(
			inuID_USERCLOSE_CONTRACT
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuID_USERCLOSE_CONTRACT in LDC_USERCLOSE_CONTRACT.ID_USERCLOSE_CONTRACT%type,
		orcRecord out nocopy styLDC_USERCLOSE_CONTRACT
	)
	IS
		rcError styLDC_USERCLOSE_CONTRACT;
	BEGIN		rcError.ID_USERCLOSE_CONTRACT:=inuID_USERCLOSE_CONTRACT;

		Load
		(
			inuID_USERCLOSE_CONTRACT
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuID_USERCLOSE_CONTRACT in LDC_USERCLOSE_CONTRACT.ID_USERCLOSE_CONTRACT%type
	)
	RETURN styLDC_USERCLOSE_CONTRACT
	IS
		rcError styLDC_USERCLOSE_CONTRACT;
	BEGIN
		rcError.ID_USERCLOSE_CONTRACT:=inuID_USERCLOSE_CONTRACT;

		Load
		(
			inuID_USERCLOSE_CONTRACT
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuID_USERCLOSE_CONTRACT in LDC_USERCLOSE_CONTRACT.ID_USERCLOSE_CONTRACT%type
	)
	RETURN styLDC_USERCLOSE_CONTRACT
	IS
		rcError styLDC_USERCLOSE_CONTRACT;
	BEGIN
		rcError.ID_USERCLOSE_CONTRACT:=inuID_USERCLOSE_CONTRACT;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuID_USERCLOSE_CONTRACT
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuID_USERCLOSE_CONTRACT
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_USERCLOSE_CONTRACT
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_USERCLOSE_CONTRACT
	)
	IS
		rfLDC_USERCLOSE_CONTRACT tyrfLDC_USERCLOSE_CONTRACT;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_USERCLOSE_CONTRACT.*, LDC_USERCLOSE_CONTRACT.rowid FROM LDC_USERCLOSE_CONTRACT';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_USERCLOSE_CONTRACT for sbFullQuery;

		fetch rfLDC_USERCLOSE_CONTRACT bulk collect INTO otbResult;

		close rfLDC_USERCLOSE_CONTRACT;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_USERCLOSE_CONTRACT.*, LDC_USERCLOSE_CONTRACT.rowid FROM LDC_USERCLOSE_CONTRACT';
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
		ircLDC_USERCLOSE_CONTRACT in styLDC_USERCLOSE_CONTRACT
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_USERCLOSE_CONTRACT,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_USERCLOSE_CONTRACT in styLDC_USERCLOSE_CONTRACT,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_USERCLOSE_CONTRACT.ID_USERCLOSE_CONTRACT is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ID_USERCLOSE_CONTRACT');
			raise ex.controlled_error;
		end if;

		insert into LDC_USERCLOSE_CONTRACT
		(
			ID_USERCLOSE_CONTRACT,
			USER_REQUEST_APROVE,
			USER_APROVE
		)
		values
		(
			ircLDC_USERCLOSE_CONTRACT.ID_USERCLOSE_CONTRACT,
			ircLDC_USERCLOSE_CONTRACT.USER_REQUEST_APROVE,
			ircLDC_USERCLOSE_CONTRACT.USER_APROVE
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_USERCLOSE_CONTRACT));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_USERCLOSE_CONTRACT in out nocopy tytbLDC_USERCLOSE_CONTRACT
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_USERCLOSE_CONTRACT,blUseRowID);
		forall n in iotbLDC_USERCLOSE_CONTRACT.first..iotbLDC_USERCLOSE_CONTRACT.last
			insert into LDC_USERCLOSE_CONTRACT
			(
				ID_USERCLOSE_CONTRACT,
				USER_REQUEST_APROVE,
				USER_APROVE
			)
			values
			(
				rcRecOfTab.ID_USERCLOSE_CONTRACT(n),
				rcRecOfTab.USER_REQUEST_APROVE(n),
				rcRecOfTab.USER_APROVE(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuID_USERCLOSE_CONTRACT in LDC_USERCLOSE_CONTRACT.ID_USERCLOSE_CONTRACT%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_USERCLOSE_CONTRACT;
	BEGIN
		rcError.ID_USERCLOSE_CONTRACT := inuID_USERCLOSE_CONTRACT;

		if inuLock=1 then
			LockByPk
			(
				inuID_USERCLOSE_CONTRACT,
				rcData
			);
		end if;


		delete
		from LDC_USERCLOSE_CONTRACT
		where
       		ID_USERCLOSE_CONTRACT=inuID_USERCLOSE_CONTRACT;
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
		rcError  styLDC_USERCLOSE_CONTRACT;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_USERCLOSE_CONTRACT
		where
			rowid = iriRowID
		returning
			ID_USERCLOSE_CONTRACT
		into
			rcError.ID_USERCLOSE_CONTRACT;
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
		iotbLDC_USERCLOSE_CONTRACT in out nocopy tytbLDC_USERCLOSE_CONTRACT,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_USERCLOSE_CONTRACT;
	BEGIN
		FillRecordOfTables(iotbLDC_USERCLOSE_CONTRACT, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_USERCLOSE_CONTRACT.first .. iotbLDC_USERCLOSE_CONTRACT.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_USERCLOSE_CONTRACT.first .. iotbLDC_USERCLOSE_CONTRACT.last
				delete
				from LDC_USERCLOSE_CONTRACT
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_USERCLOSE_CONTRACT.first .. iotbLDC_USERCLOSE_CONTRACT.last loop
					LockByPk
					(
						rcRecOfTab.ID_USERCLOSE_CONTRACT(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_USERCLOSE_CONTRACT.first .. iotbLDC_USERCLOSE_CONTRACT.last
				delete
				from LDC_USERCLOSE_CONTRACT
				where
		         	ID_USERCLOSE_CONTRACT = rcRecOfTab.ID_USERCLOSE_CONTRACT(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_USERCLOSE_CONTRACT in styLDC_USERCLOSE_CONTRACT,
		inuLock in number default 0
	)
	IS
		nuID_USERCLOSE_CONTRACT	LDC_USERCLOSE_CONTRACT.ID_USERCLOSE_CONTRACT%type;
	BEGIN
		if ircLDC_USERCLOSE_CONTRACT.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_USERCLOSE_CONTRACT.rowid,rcData);
			end if;
			update LDC_USERCLOSE_CONTRACT
			set
				USER_REQUEST_APROVE = ircLDC_USERCLOSE_CONTRACT.USER_REQUEST_APROVE,
				USER_APROVE = ircLDC_USERCLOSE_CONTRACT.USER_APROVE
			where
				rowid = ircLDC_USERCLOSE_CONTRACT.rowid
			returning
				ID_USERCLOSE_CONTRACT
			into
				nuID_USERCLOSE_CONTRACT;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_USERCLOSE_CONTRACT.ID_USERCLOSE_CONTRACT,
					rcData
				);
			end if;

			update LDC_USERCLOSE_CONTRACT
			set
				USER_REQUEST_APROVE = ircLDC_USERCLOSE_CONTRACT.USER_REQUEST_APROVE,
				USER_APROVE = ircLDC_USERCLOSE_CONTRACT.USER_APROVE
			where
				ID_USERCLOSE_CONTRACT = ircLDC_USERCLOSE_CONTRACT.ID_USERCLOSE_CONTRACT
			returning
				ID_USERCLOSE_CONTRACT
			into
				nuID_USERCLOSE_CONTRACT;
		end if;
		if
			nuID_USERCLOSE_CONTRACT is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_USERCLOSE_CONTRACT));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_USERCLOSE_CONTRACT in out nocopy tytbLDC_USERCLOSE_CONTRACT,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_USERCLOSE_CONTRACT;
	BEGIN
		FillRecordOfTables(iotbLDC_USERCLOSE_CONTRACT,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_USERCLOSE_CONTRACT.first .. iotbLDC_USERCLOSE_CONTRACT.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_USERCLOSE_CONTRACT.first .. iotbLDC_USERCLOSE_CONTRACT.last
				update LDC_USERCLOSE_CONTRACT
				set
					USER_REQUEST_APROVE = rcRecOfTab.USER_REQUEST_APROVE(n),
					USER_APROVE = rcRecOfTab.USER_APROVE(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_USERCLOSE_CONTRACT.first .. iotbLDC_USERCLOSE_CONTRACT.last loop
					LockByPk
					(
						rcRecOfTab.ID_USERCLOSE_CONTRACT(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_USERCLOSE_CONTRACT.first .. iotbLDC_USERCLOSE_CONTRACT.last
				update LDC_USERCLOSE_CONTRACT
				SET
					USER_REQUEST_APROVE = rcRecOfTab.USER_REQUEST_APROVE(n),
					USER_APROVE = rcRecOfTab.USER_APROVE(n)
				where
					ID_USERCLOSE_CONTRACT = rcRecOfTab.ID_USERCLOSE_CONTRACT(n)
;
		end if;
	END;
	PROCEDURE updUSER_REQUEST_APROVE
	(
		inuID_USERCLOSE_CONTRACT in LDC_USERCLOSE_CONTRACT.ID_USERCLOSE_CONTRACT%type,
		isbUSER_REQUEST_APROVE$ in LDC_USERCLOSE_CONTRACT.USER_REQUEST_APROVE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_USERCLOSE_CONTRACT;
	BEGIN
		rcError.ID_USERCLOSE_CONTRACT := inuID_USERCLOSE_CONTRACT;
		if inuLock=1 then
			LockByPk
			(
				inuID_USERCLOSE_CONTRACT,
				rcData
			);
		end if;

		update LDC_USERCLOSE_CONTRACT
		set
			USER_REQUEST_APROVE = isbUSER_REQUEST_APROVE$
		where
			ID_USERCLOSE_CONTRACT = inuID_USERCLOSE_CONTRACT;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.USER_REQUEST_APROVE:= isbUSER_REQUEST_APROVE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updUSER_APROVE
	(
		inuID_USERCLOSE_CONTRACT in LDC_USERCLOSE_CONTRACT.ID_USERCLOSE_CONTRACT%type,
		isbUSER_APROVE$ in LDC_USERCLOSE_CONTRACT.USER_APROVE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_USERCLOSE_CONTRACT;
	BEGIN
		rcError.ID_USERCLOSE_CONTRACT := inuID_USERCLOSE_CONTRACT;
		if inuLock=1 then
			LockByPk
			(
				inuID_USERCLOSE_CONTRACT,
				rcData
			);
		end if;

		update LDC_USERCLOSE_CONTRACT
		set
			USER_APROVE = isbUSER_APROVE$
		where
			ID_USERCLOSE_CONTRACT = inuID_USERCLOSE_CONTRACT;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.USER_APROVE:= isbUSER_APROVE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetID_USERCLOSE_CONTRACT
	(
		inuID_USERCLOSE_CONTRACT in LDC_USERCLOSE_CONTRACT.ID_USERCLOSE_CONTRACT%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_USERCLOSE_CONTRACT.ID_USERCLOSE_CONTRACT%type
	IS
		rcError styLDC_USERCLOSE_CONTRACT;
	BEGIN

		rcError.ID_USERCLOSE_CONTRACT := inuID_USERCLOSE_CONTRACT;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_USERCLOSE_CONTRACT
			 )
		then
			 return(rcData.ID_USERCLOSE_CONTRACT);
		end if;
		Load
		(
		 		inuID_USERCLOSE_CONTRACT
		);
		return(rcData.ID_USERCLOSE_CONTRACT);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetUSER_REQUEST_APROVE
	(
		inuID_USERCLOSE_CONTRACT in LDC_USERCLOSE_CONTRACT.ID_USERCLOSE_CONTRACT%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_USERCLOSE_CONTRACT.USER_REQUEST_APROVE%type
	IS
		rcError styLDC_USERCLOSE_CONTRACT;
	BEGIN

		rcError.ID_USERCLOSE_CONTRACT := inuID_USERCLOSE_CONTRACT;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_USERCLOSE_CONTRACT
			 )
		then
			 return(rcData.USER_REQUEST_APROVE);
		end if;
		Load
		(
		 		inuID_USERCLOSE_CONTRACT
		);
		return(rcData.USER_REQUEST_APROVE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetUSER_APROVE
	(
		inuID_USERCLOSE_CONTRACT in LDC_USERCLOSE_CONTRACT.ID_USERCLOSE_CONTRACT%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_USERCLOSE_CONTRACT.USER_APROVE%type
	IS
		rcError styLDC_USERCLOSE_CONTRACT;
	BEGIN

		rcError.ID_USERCLOSE_CONTRACT := inuID_USERCLOSE_CONTRACT;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_USERCLOSE_CONTRACT
			 )
		then
			 return(rcData.USER_APROVE);
		end if;
		Load
		(
		 		inuID_USERCLOSE_CONTRACT
		);
		return(rcData.USER_APROVE);
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
end DALDC_USERCLOSE_CONTRACT;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALDC_USERCLOSE_CONTRACT
BEGIN
    pkg_utilidades.prAplicarPermisos('DALDC_USERCLOSE_CONTRACT', 'ADM_PERSON'); 
END;
/
