CREATE OR REPLACE PACKAGE adm_person.daldc_tipoinfo
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  11/06/2024   Adrianavg   OSF-2813: Migrar del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuTIPOINFO_ID in LDC_TIPOINFO.TIPOINFO_ID%type
	)
	IS
		SELECT LDC_TIPOINFO.*,LDC_TIPOINFO.rowid
		FROM LDC_TIPOINFO
		WHERE
		    TIPOINFO_ID = inuTIPOINFO_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_TIPOINFO.*,LDC_TIPOINFO.rowid
		FROM LDC_TIPOINFO
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_TIPOINFO  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_TIPOINFO is table of styLDC_TIPOINFO index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_TIPOINFO;

	/* Tipos referenciando al registro */
	type tytbTIPOINFO_ID is table of LDC_TIPOINFO.TIPOINFO_ID%type index by binary_integer;
	type tytbCOMMENT_TYPE_ID is table of LDC_TIPOINFO.COMMENT_TYPE_ID%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_TIPOINFO is record
	(
		TIPOINFO_ID   tytbTIPOINFO_ID,
		COMMENT_TYPE_ID   tytbCOMMENT_TYPE_ID,
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
		inuTIPOINFO_ID in LDC_TIPOINFO.TIPOINFO_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuTIPOINFO_ID in LDC_TIPOINFO.TIPOINFO_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuTIPOINFO_ID in LDC_TIPOINFO.TIPOINFO_ID%type
	);

	PROCEDURE getRecord
	(
		inuTIPOINFO_ID in LDC_TIPOINFO.TIPOINFO_ID%type,
		orcRecord out nocopy styLDC_TIPOINFO
	);

	FUNCTION frcGetRcData
	(
		inuTIPOINFO_ID in LDC_TIPOINFO.TIPOINFO_ID%type
	)
	RETURN styLDC_TIPOINFO;

	FUNCTION frcGetRcData
	RETURN styLDC_TIPOINFO;

	FUNCTION frcGetRecord
	(
		inuTIPOINFO_ID in LDC_TIPOINFO.TIPOINFO_ID%type
	)
	RETURN styLDC_TIPOINFO;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_TIPOINFO
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_TIPOINFO in styLDC_TIPOINFO
	);

	PROCEDURE insRecord
	(
		ircLDC_TIPOINFO in styLDC_TIPOINFO,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_TIPOINFO in out nocopy tytbLDC_TIPOINFO
	);

	PROCEDURE delRecord
	(
		inuTIPOINFO_ID in LDC_TIPOINFO.TIPOINFO_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_TIPOINFO in out nocopy tytbLDC_TIPOINFO,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_TIPOINFO in styLDC_TIPOINFO,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_TIPOINFO in out nocopy tytbLDC_TIPOINFO,
		inuLock in number default 1
	);

	PROCEDURE updCOMMENT_TYPE_ID
	(
		inuTIPOINFO_ID in LDC_TIPOINFO.TIPOINFO_ID%type,
		inuCOMMENT_TYPE_ID$ in LDC_TIPOINFO.COMMENT_TYPE_ID%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetTIPOINFO_ID
	(
		inuTIPOINFO_ID in LDC_TIPOINFO.TIPOINFO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPOINFO.TIPOINFO_ID%type;

	FUNCTION fnuGetCOMMENT_TYPE_ID
	(
		inuTIPOINFO_ID in LDC_TIPOINFO.TIPOINFO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPOINFO.COMMENT_TYPE_ID%type;


	PROCEDURE LockByPk
	(
		inuTIPOINFO_ID in LDC_TIPOINFO.TIPOINFO_ID%type,
		orcLDC_TIPOINFO  out styLDC_TIPOINFO
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_TIPOINFO  out styLDC_TIPOINFO
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_TIPOINFO;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALDC_TIPOINFO
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_TIPOINFO';
	 cnuGeEntityId constant varchar2(30) := 2946; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuTIPOINFO_ID in LDC_TIPOINFO.TIPOINFO_ID%type
	)
	IS
		SELECT LDC_TIPOINFO.*,LDC_TIPOINFO.rowid
		FROM LDC_TIPOINFO
		WHERE  TIPOINFO_ID = inuTIPOINFO_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_TIPOINFO.*,LDC_TIPOINFO.rowid
		FROM LDC_TIPOINFO
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_TIPOINFO is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_TIPOINFO;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_TIPOINFO default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.TIPOINFO_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuTIPOINFO_ID in LDC_TIPOINFO.TIPOINFO_ID%type,
		orcLDC_TIPOINFO  out styLDC_TIPOINFO
	)
	IS
		rcError styLDC_TIPOINFO;
	BEGIN
		rcError.TIPOINFO_ID := inuTIPOINFO_ID;

		Open cuLockRcByPk
		(
			inuTIPOINFO_ID
		);

		fetch cuLockRcByPk into orcLDC_TIPOINFO;
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
		orcLDC_TIPOINFO  out styLDC_TIPOINFO
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_TIPOINFO;
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
		itbLDC_TIPOINFO  in out nocopy tytbLDC_TIPOINFO
	)
	IS
	BEGIN
			rcRecOfTab.TIPOINFO_ID.delete;
			rcRecOfTab.COMMENT_TYPE_ID.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_TIPOINFO  in out nocopy tytbLDC_TIPOINFO,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_TIPOINFO);

		for n in itbLDC_TIPOINFO.first .. itbLDC_TIPOINFO.last loop
			rcRecOfTab.TIPOINFO_ID(n) := itbLDC_TIPOINFO(n).TIPOINFO_ID;
			rcRecOfTab.COMMENT_TYPE_ID(n) := itbLDC_TIPOINFO(n).COMMENT_TYPE_ID;
			rcRecOfTab.row_id(n) := itbLDC_TIPOINFO(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuTIPOINFO_ID in LDC_TIPOINFO.TIPOINFO_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuTIPOINFO_ID
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
		inuTIPOINFO_ID in LDC_TIPOINFO.TIPOINFO_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuTIPOINFO_ID = rcData.TIPOINFO_ID
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
		inuTIPOINFO_ID in LDC_TIPOINFO.TIPOINFO_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuTIPOINFO_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuTIPOINFO_ID in LDC_TIPOINFO.TIPOINFO_ID%type
	)
	IS
		rcError styLDC_TIPOINFO;
	BEGIN		rcError.TIPOINFO_ID:=inuTIPOINFO_ID;

		Load
		(
			inuTIPOINFO_ID
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
		inuTIPOINFO_ID in LDC_TIPOINFO.TIPOINFO_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuTIPOINFO_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuTIPOINFO_ID in LDC_TIPOINFO.TIPOINFO_ID%type,
		orcRecord out nocopy styLDC_TIPOINFO
	)
	IS
		rcError styLDC_TIPOINFO;
	BEGIN		rcError.TIPOINFO_ID:=inuTIPOINFO_ID;

		Load
		(
			inuTIPOINFO_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuTIPOINFO_ID in LDC_TIPOINFO.TIPOINFO_ID%type
	)
	RETURN styLDC_TIPOINFO
	IS
		rcError styLDC_TIPOINFO;
	BEGIN
		rcError.TIPOINFO_ID:=inuTIPOINFO_ID;

		Load
		(
			inuTIPOINFO_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuTIPOINFO_ID in LDC_TIPOINFO.TIPOINFO_ID%type
	)
	RETURN styLDC_TIPOINFO
	IS
		rcError styLDC_TIPOINFO;
	BEGIN
		rcError.TIPOINFO_ID:=inuTIPOINFO_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuTIPOINFO_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuTIPOINFO_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_TIPOINFO
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_TIPOINFO
	)
	IS
		rfLDC_TIPOINFO tyrfLDC_TIPOINFO;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_TIPOINFO.*, LDC_TIPOINFO.rowid FROM LDC_TIPOINFO';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_TIPOINFO for sbFullQuery;

		fetch rfLDC_TIPOINFO bulk collect INTO otbResult;

		close rfLDC_TIPOINFO;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_TIPOINFO.*, LDC_TIPOINFO.rowid FROM LDC_TIPOINFO';
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
		ircLDC_TIPOINFO in styLDC_TIPOINFO
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_TIPOINFO,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_TIPOINFO in styLDC_TIPOINFO,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_TIPOINFO.TIPOINFO_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|TIPOINFO_ID');
			raise ex.controlled_error;
		end if;

		insert into LDC_TIPOINFO
		(
			TIPOINFO_ID,
			COMMENT_TYPE_ID
		)
		values
		(
			ircLDC_TIPOINFO.TIPOINFO_ID,
			ircLDC_TIPOINFO.COMMENT_TYPE_ID
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_TIPOINFO));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_TIPOINFO in out nocopy tytbLDC_TIPOINFO
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_TIPOINFO,blUseRowID);
		forall n in iotbLDC_TIPOINFO.first..iotbLDC_TIPOINFO.last
			insert into LDC_TIPOINFO
			(
				TIPOINFO_ID,
				COMMENT_TYPE_ID
			)
			values
			(
				rcRecOfTab.TIPOINFO_ID(n),
				rcRecOfTab.COMMENT_TYPE_ID(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuTIPOINFO_ID in LDC_TIPOINFO.TIPOINFO_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_TIPOINFO;
	BEGIN
		rcError.TIPOINFO_ID := inuTIPOINFO_ID;

		if inuLock=1 then
			LockByPk
			(
				inuTIPOINFO_ID,
				rcData
			);
		end if;


		delete
		from LDC_TIPOINFO
		where
       		TIPOINFO_ID=inuTIPOINFO_ID;
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
		rcError  styLDC_TIPOINFO;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_TIPOINFO
		where
			rowid = iriRowID
		returning
			TIPOINFO_ID
		into
			rcError.TIPOINFO_ID;
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
		iotbLDC_TIPOINFO in out nocopy tytbLDC_TIPOINFO,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_TIPOINFO;
	BEGIN
		FillRecordOfTables(iotbLDC_TIPOINFO, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_TIPOINFO.first .. iotbLDC_TIPOINFO.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_TIPOINFO.first .. iotbLDC_TIPOINFO.last
				delete
				from LDC_TIPOINFO
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_TIPOINFO.first .. iotbLDC_TIPOINFO.last loop
					LockByPk
					(
						rcRecOfTab.TIPOINFO_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_TIPOINFO.first .. iotbLDC_TIPOINFO.last
				delete
				from LDC_TIPOINFO
				where
		         	TIPOINFO_ID = rcRecOfTab.TIPOINFO_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_TIPOINFO in styLDC_TIPOINFO,
		inuLock in number default 0
	)
	IS
		nuTIPOINFO_ID	LDC_TIPOINFO.TIPOINFO_ID%type;
	BEGIN
		if ircLDC_TIPOINFO.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_TIPOINFO.rowid,rcData);
			end if;
			update LDC_TIPOINFO
			set
				COMMENT_TYPE_ID = ircLDC_TIPOINFO.COMMENT_TYPE_ID
			where
				rowid = ircLDC_TIPOINFO.rowid
			returning
				TIPOINFO_ID
			into
				nuTIPOINFO_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_TIPOINFO.TIPOINFO_ID,
					rcData
				);
			end if;

			update LDC_TIPOINFO
			set
				COMMENT_TYPE_ID = ircLDC_TIPOINFO.COMMENT_TYPE_ID
			where
				TIPOINFO_ID = ircLDC_TIPOINFO.TIPOINFO_ID
			returning
				TIPOINFO_ID
			into
				nuTIPOINFO_ID;
		end if;
		if
			nuTIPOINFO_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_TIPOINFO));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_TIPOINFO in out nocopy tytbLDC_TIPOINFO,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_TIPOINFO;
	BEGIN
		FillRecordOfTables(iotbLDC_TIPOINFO,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_TIPOINFO.first .. iotbLDC_TIPOINFO.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_TIPOINFO.first .. iotbLDC_TIPOINFO.last
				update LDC_TIPOINFO
				set
					COMMENT_TYPE_ID = rcRecOfTab.COMMENT_TYPE_ID(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_TIPOINFO.first .. iotbLDC_TIPOINFO.last loop
					LockByPk
					(
						rcRecOfTab.TIPOINFO_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_TIPOINFO.first .. iotbLDC_TIPOINFO.last
				update LDC_TIPOINFO
				SET
					COMMENT_TYPE_ID = rcRecOfTab.COMMENT_TYPE_ID(n)
				where
					TIPOINFO_ID = rcRecOfTab.TIPOINFO_ID(n)
;
		end if;
	END;
	PROCEDURE updCOMMENT_TYPE_ID
	(
		inuTIPOINFO_ID in LDC_TIPOINFO.TIPOINFO_ID%type,
		inuCOMMENT_TYPE_ID$ in LDC_TIPOINFO.COMMENT_TYPE_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_TIPOINFO;
	BEGIN
		rcError.TIPOINFO_ID := inuTIPOINFO_ID;
		if inuLock=1 then
			LockByPk
			(
				inuTIPOINFO_ID,
				rcData
			);
		end if;

		update LDC_TIPOINFO
		set
			COMMENT_TYPE_ID = inuCOMMENT_TYPE_ID$
		where
			TIPOINFO_ID = inuTIPOINFO_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.COMMENT_TYPE_ID:= inuCOMMENT_TYPE_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetTIPOINFO_ID
	(
		inuTIPOINFO_ID in LDC_TIPOINFO.TIPOINFO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPOINFO.TIPOINFO_ID%type
	IS
		rcError styLDC_TIPOINFO;
	BEGIN

		rcError.TIPOINFO_ID := inuTIPOINFO_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuTIPOINFO_ID
			 )
		then
			 return(rcData.TIPOINFO_ID);
		end if;
		Load
		(
		 		inuTIPOINFO_ID
		);
		return(rcData.TIPOINFO_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCOMMENT_TYPE_ID
	(
		inuTIPOINFO_ID in LDC_TIPOINFO.TIPOINFO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPOINFO.COMMENT_TYPE_ID%type
	IS
		rcError styLDC_TIPOINFO;
	BEGIN

		rcError.TIPOINFO_ID := inuTIPOINFO_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuTIPOINFO_ID
			 )
		then
			 return(rcData.COMMENT_TYPE_ID);
		end if;
		Load
		(
		 		inuTIPOINFO_ID
		);
		return(rcData.COMMENT_TYPE_ID);
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
end DALDC_TIPOINFO;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALDC_TIPOINFO
BEGIN
    pkg_utilidades.prAplicarPermisos('DALDC_TIPOINFO', 'ADM_PERSON'); 
END;
/ 
