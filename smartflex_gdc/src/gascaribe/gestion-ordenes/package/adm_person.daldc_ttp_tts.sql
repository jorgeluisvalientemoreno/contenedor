CREATE OR REPLACE PACKAGE adm_person.daldc_ttp_tts
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  11/06/2024   Adrianavg   OSF-2813: Migrar del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuTTP_TTS_ID in LDC_TTP_TTS.TTP_TTS_ID%type
	)
	IS
		SELECT LDC_TTP_TTS.*,LDC_TTP_TTS.rowid
		FROM LDC_TTP_TTS
		WHERE
		    TTP_TTS_ID = inuTTP_TTS_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_TTP_TTS.*,LDC_TTP_TTS.rowid
		FROM LDC_TTP_TTS
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_TTP_TTS  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_TTP_TTS is table of styLDC_TTP_TTS index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_TTP_TTS;

	/* Tipos referenciando al registro */
	type tytbTTP_TTS_ID is table of LDC_TTP_TTS.TTP_TTS_ID%type index by binary_integer;
	type tytbTTP_ID is table of LDC_TTP_TTS.TTP_ID%type index by binary_integer;
	type tytbTTS_ID is table of LDC_TTP_TTS.TTS_ID%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_TTP_TTS is record
	(
		TTP_TTS_ID   tytbTTP_TTS_ID,
		TTP_ID   tytbTTP_ID,
		TTS_ID   tytbTTS_ID,
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
		inuTTP_TTS_ID in LDC_TTP_TTS.TTP_TTS_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuTTP_TTS_ID in LDC_TTP_TTS.TTP_TTS_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuTTP_TTS_ID in LDC_TTP_TTS.TTP_TTS_ID%type
	);

	PROCEDURE getRecord
	(
		inuTTP_TTS_ID in LDC_TTP_TTS.TTP_TTS_ID%type,
		orcRecord out nocopy styLDC_TTP_TTS
	);

	FUNCTION frcGetRcData
	(
		inuTTP_TTS_ID in LDC_TTP_TTS.TTP_TTS_ID%type
	)
	RETURN styLDC_TTP_TTS;

	FUNCTION frcGetRcData
	RETURN styLDC_TTP_TTS;

	FUNCTION frcGetRecord
	(
		inuTTP_TTS_ID in LDC_TTP_TTS.TTP_TTS_ID%type
	)
	RETURN styLDC_TTP_TTS;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_TTP_TTS
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_TTP_TTS in styLDC_TTP_TTS
	);

	PROCEDURE insRecord
	(
		ircLDC_TTP_TTS in styLDC_TTP_TTS,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_TTP_TTS in out nocopy tytbLDC_TTP_TTS
	);

	PROCEDURE delRecord
	(
		inuTTP_TTS_ID in LDC_TTP_TTS.TTP_TTS_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_TTP_TTS in out nocopy tytbLDC_TTP_TTS,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_TTP_TTS in styLDC_TTP_TTS,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_TTP_TTS in out nocopy tytbLDC_TTP_TTS,
		inuLock in number default 1
	);

	PROCEDURE updTTP_ID
	(
		inuTTP_TTS_ID in LDC_TTP_TTS.TTP_TTS_ID%type,
		inuTTP_ID$ in LDC_TTP_TTS.TTP_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updTTS_ID
	(
		inuTTP_TTS_ID in LDC_TTP_TTS.TTP_TTS_ID%type,
		inuTTS_ID$ in LDC_TTP_TTS.TTS_ID%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetTTP_TTS_ID
	(
		inuTTP_TTS_ID in LDC_TTP_TTS.TTP_TTS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TTP_TTS.TTP_TTS_ID%type;

	FUNCTION fnuGetTTP_ID
	(
		inuTTP_TTS_ID in LDC_TTP_TTS.TTP_TTS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TTP_TTS.TTP_ID%type;

	FUNCTION fnuGetTTS_ID
	(
		inuTTP_TTS_ID in LDC_TTP_TTS.TTP_TTS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TTP_TTS.TTS_ID%type;


	PROCEDURE LockByPk
	(
		inuTTP_TTS_ID in LDC_TTP_TTS.TTP_TTS_ID%type,
		orcLDC_TTP_TTS  out styLDC_TTP_TTS
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_TTP_TTS  out styLDC_TTP_TTS
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_TTP_TTS;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALDC_TTP_TTS
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_TTP_TTS';
	 cnuGeEntityId constant varchar2(30) := 8179; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuTTP_TTS_ID in LDC_TTP_TTS.TTP_TTS_ID%type
	)
	IS
		SELECT LDC_TTP_TTS.*,LDC_TTP_TTS.rowid
		FROM LDC_TTP_TTS
		WHERE  TTP_TTS_ID = inuTTP_TTS_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_TTP_TTS.*,LDC_TTP_TTS.rowid
		FROM LDC_TTP_TTS
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_TTP_TTS is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_TTP_TTS;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_TTP_TTS default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.TTP_TTS_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuTTP_TTS_ID in LDC_TTP_TTS.TTP_TTS_ID%type,
		orcLDC_TTP_TTS  out styLDC_TTP_TTS
	)
	IS
		rcError styLDC_TTP_TTS;
	BEGIN
		rcError.TTP_TTS_ID := inuTTP_TTS_ID;

		Open cuLockRcByPk
		(
			inuTTP_TTS_ID
		);

		fetch cuLockRcByPk into orcLDC_TTP_TTS;
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
		orcLDC_TTP_TTS  out styLDC_TTP_TTS
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_TTP_TTS;
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
		itbLDC_TTP_TTS  in out nocopy tytbLDC_TTP_TTS
	)
	IS
	BEGIN
			rcRecOfTab.TTP_TTS_ID.delete;
			rcRecOfTab.TTP_ID.delete;
			rcRecOfTab.TTS_ID.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_TTP_TTS  in out nocopy tytbLDC_TTP_TTS,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_TTP_TTS);

		for n in itbLDC_TTP_TTS.first .. itbLDC_TTP_TTS.last loop
			rcRecOfTab.TTP_TTS_ID(n) := itbLDC_TTP_TTS(n).TTP_TTS_ID;
			rcRecOfTab.TTP_ID(n) := itbLDC_TTP_TTS(n).TTP_ID;
			rcRecOfTab.TTS_ID(n) := itbLDC_TTP_TTS(n).TTS_ID;
			rcRecOfTab.row_id(n) := itbLDC_TTP_TTS(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuTTP_TTS_ID in LDC_TTP_TTS.TTP_TTS_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuTTP_TTS_ID
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
		inuTTP_TTS_ID in LDC_TTP_TTS.TTP_TTS_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuTTP_TTS_ID = rcData.TTP_TTS_ID
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
		inuTTP_TTS_ID in LDC_TTP_TTS.TTP_TTS_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuTTP_TTS_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuTTP_TTS_ID in LDC_TTP_TTS.TTP_TTS_ID%type
	)
	IS
		rcError styLDC_TTP_TTS;
	BEGIN		rcError.TTP_TTS_ID:=inuTTP_TTS_ID;

		Load
		(
			inuTTP_TTS_ID
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
		inuTTP_TTS_ID in LDC_TTP_TTS.TTP_TTS_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuTTP_TTS_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuTTP_TTS_ID in LDC_TTP_TTS.TTP_TTS_ID%type,
		orcRecord out nocopy styLDC_TTP_TTS
	)
	IS
		rcError styLDC_TTP_TTS;
	BEGIN		rcError.TTP_TTS_ID:=inuTTP_TTS_ID;

		Load
		(
			inuTTP_TTS_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuTTP_TTS_ID in LDC_TTP_TTS.TTP_TTS_ID%type
	)
	RETURN styLDC_TTP_TTS
	IS
		rcError styLDC_TTP_TTS;
	BEGIN
		rcError.TTP_TTS_ID:=inuTTP_TTS_ID;

		Load
		(
			inuTTP_TTS_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuTTP_TTS_ID in LDC_TTP_TTS.TTP_TTS_ID%type
	)
	RETURN styLDC_TTP_TTS
	IS
		rcError styLDC_TTP_TTS;
	BEGIN
		rcError.TTP_TTS_ID:=inuTTP_TTS_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuTTP_TTS_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuTTP_TTS_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_TTP_TTS
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_TTP_TTS
	)
	IS
		rfLDC_TTP_TTS tyrfLDC_TTP_TTS;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_TTP_TTS.*, LDC_TTP_TTS.rowid FROM LDC_TTP_TTS';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_TTP_TTS for sbFullQuery;

		fetch rfLDC_TTP_TTS bulk collect INTO otbResult;

		close rfLDC_TTP_TTS;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_TTP_TTS.*, LDC_TTP_TTS.rowid FROM LDC_TTP_TTS';
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
		ircLDC_TTP_TTS in styLDC_TTP_TTS
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_TTP_TTS,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_TTP_TTS in styLDC_TTP_TTS,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_TTP_TTS.TTP_TTS_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|TTP_TTS_ID');
			raise ex.controlled_error;
		end if;

		insert into LDC_TTP_TTS
		(
			TTP_TTS_ID,
			TTP_ID,
			TTS_ID
		)
		values
		(
			ircLDC_TTP_TTS.TTP_TTS_ID,
			ircLDC_TTP_TTS.TTP_ID,
			ircLDC_TTP_TTS.TTS_ID
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_TTP_TTS));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_TTP_TTS in out nocopy tytbLDC_TTP_TTS
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_TTP_TTS,blUseRowID);
		forall n in iotbLDC_TTP_TTS.first..iotbLDC_TTP_TTS.last
			insert into LDC_TTP_TTS
			(
				TTP_TTS_ID,
				TTP_ID,
				TTS_ID
			)
			values
			(
				rcRecOfTab.TTP_TTS_ID(n),
				rcRecOfTab.TTP_ID(n),
				rcRecOfTab.TTS_ID(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuTTP_TTS_ID in LDC_TTP_TTS.TTP_TTS_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_TTP_TTS;
	BEGIN
		rcError.TTP_TTS_ID := inuTTP_TTS_ID;

		if inuLock=1 then
			LockByPk
			(
				inuTTP_TTS_ID,
				rcData
			);
		end if;


		delete
		from LDC_TTP_TTS
		where
       		TTP_TTS_ID=inuTTP_TTS_ID;
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
		rcError  styLDC_TTP_TTS;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_TTP_TTS
		where
			rowid = iriRowID
		returning
			TTP_TTS_ID
		into
			rcError.TTP_TTS_ID;
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
		iotbLDC_TTP_TTS in out nocopy tytbLDC_TTP_TTS,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_TTP_TTS;
	BEGIN
		FillRecordOfTables(iotbLDC_TTP_TTS, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_TTP_TTS.first .. iotbLDC_TTP_TTS.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_TTP_TTS.first .. iotbLDC_TTP_TTS.last
				delete
				from LDC_TTP_TTS
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_TTP_TTS.first .. iotbLDC_TTP_TTS.last loop
					LockByPk
					(
						rcRecOfTab.TTP_TTS_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_TTP_TTS.first .. iotbLDC_TTP_TTS.last
				delete
				from LDC_TTP_TTS
				where
		         	TTP_TTS_ID = rcRecOfTab.TTP_TTS_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_TTP_TTS in styLDC_TTP_TTS,
		inuLock in number default 0
	)
	IS
		nuTTP_TTS_ID	LDC_TTP_TTS.TTP_TTS_ID%type;
	BEGIN
		if ircLDC_TTP_TTS.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_TTP_TTS.rowid,rcData);
			end if;
			update LDC_TTP_TTS
			set
				TTP_ID = ircLDC_TTP_TTS.TTP_ID,
				TTS_ID = ircLDC_TTP_TTS.TTS_ID
			where
				rowid = ircLDC_TTP_TTS.rowid
			returning
				TTP_TTS_ID
			into
				nuTTP_TTS_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_TTP_TTS.TTP_TTS_ID,
					rcData
				);
			end if;

			update LDC_TTP_TTS
			set
				TTP_ID = ircLDC_TTP_TTS.TTP_ID,
				TTS_ID = ircLDC_TTP_TTS.TTS_ID
			where
				TTP_TTS_ID = ircLDC_TTP_TTS.TTP_TTS_ID
			returning
				TTP_TTS_ID
			into
				nuTTP_TTS_ID;
		end if;
		if
			nuTTP_TTS_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_TTP_TTS));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_TTP_TTS in out nocopy tytbLDC_TTP_TTS,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_TTP_TTS;
	BEGIN
		FillRecordOfTables(iotbLDC_TTP_TTS,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_TTP_TTS.first .. iotbLDC_TTP_TTS.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_TTP_TTS.first .. iotbLDC_TTP_TTS.last
				update LDC_TTP_TTS
				set
					TTP_ID = rcRecOfTab.TTP_ID(n),
					TTS_ID = rcRecOfTab.TTS_ID(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_TTP_TTS.first .. iotbLDC_TTP_TTS.last loop
					LockByPk
					(
						rcRecOfTab.TTP_TTS_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_TTP_TTS.first .. iotbLDC_TTP_TTS.last
				update LDC_TTP_TTS
				SET
					TTP_ID = rcRecOfTab.TTP_ID(n),
					TTS_ID = rcRecOfTab.TTS_ID(n)
				where
					TTP_TTS_ID = rcRecOfTab.TTP_TTS_ID(n)
;
		end if;
	END;
	PROCEDURE updTTP_ID
	(
		inuTTP_TTS_ID in LDC_TTP_TTS.TTP_TTS_ID%type,
		inuTTP_ID$ in LDC_TTP_TTS.TTP_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_TTP_TTS;
	BEGIN
		rcError.TTP_TTS_ID := inuTTP_TTS_ID;
		if inuLock=1 then
			LockByPk
			(
				inuTTP_TTS_ID,
				rcData
			);
		end if;

		update LDC_TTP_TTS
		set
			TTP_ID = inuTTP_ID$
		where
			TTP_TTS_ID = inuTTP_TTS_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TTP_ID:= inuTTP_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updTTS_ID
	(
		inuTTP_TTS_ID in LDC_TTP_TTS.TTP_TTS_ID%type,
		inuTTS_ID$ in LDC_TTP_TTS.TTS_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_TTP_TTS;
	BEGIN
		rcError.TTP_TTS_ID := inuTTP_TTS_ID;
		if inuLock=1 then
			LockByPk
			(
				inuTTP_TTS_ID,
				rcData
			);
		end if;

		update LDC_TTP_TTS
		set
			TTS_ID = inuTTS_ID$
		where
			TTP_TTS_ID = inuTTP_TTS_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TTS_ID:= inuTTS_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetTTP_TTS_ID
	(
		inuTTP_TTS_ID in LDC_TTP_TTS.TTP_TTS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TTP_TTS.TTP_TTS_ID%type
	IS
		rcError styLDC_TTP_TTS;
	BEGIN

		rcError.TTP_TTS_ID := inuTTP_TTS_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuTTP_TTS_ID
			 )
		then
			 return(rcData.TTP_TTS_ID);
		end if;
		Load
		(
		 		inuTTP_TTS_ID
		);
		return(rcData.TTP_TTS_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetTTP_ID
	(
		inuTTP_TTS_ID in LDC_TTP_TTS.TTP_TTS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TTP_TTS.TTP_ID%type
	IS
		rcError styLDC_TTP_TTS;
	BEGIN

		rcError.TTP_TTS_ID := inuTTP_TTS_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuTTP_TTS_ID
			 )
		then
			 return(rcData.TTP_ID);
		end if;
		Load
		(
		 		inuTTP_TTS_ID
		);
		return(rcData.TTP_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetTTS_ID
	(
		inuTTP_TTS_ID in LDC_TTP_TTS.TTP_TTS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TTP_TTS.TTS_ID%type
	IS
		rcError styLDC_TTP_TTS;
	BEGIN

		rcError.TTP_TTS_ID := inuTTP_TTS_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuTTP_TTS_ID
			 )
		then
			 return(rcData.TTS_ID);
		end if;
		Load
		(
		 		inuTTP_TTS_ID
		);
		return(rcData.TTS_ID);
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
end DALDC_TTP_TTS;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALDC_TTP_TTS
BEGIN
    pkg_utilidades.prAplicarPermisos('DALDC_TTP_TTS', 'ADM_PERSON'); 
END;
/
