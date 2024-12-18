CREATE OR REPLACE PACKAGE ADM_PERSON.DALDC_LOTES_ORDENES

is
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     : 
    Descripcion	 : 
    
    Parametro	    Descripcion
    ============	==============================
    
    Historia de Modificaciones
    Fecha   	           Autor            Modificacion
    ====================   =========        ====================
    05/06/2024              PAcosta         OSF-2777: Cambio de esquema ADM_PERSON                              
    ****************************************************************/  
    
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuID_LOTE in LDC_LOTES_ORDENES.ID_LOTE%type
	)
	IS
		SELECT LDC_LOTES_ORDENES.*,LDC_LOTES_ORDENES.rowid
		FROM LDC_LOTES_ORDENES
		WHERE
		    ID_LOTE = inuID_LOTE;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_LOTES_ORDENES.*,LDC_LOTES_ORDENES.rowid
		FROM LDC_LOTES_ORDENES
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_LOTES_ORDENES  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_LOTES_ORDENES is table of styLDC_LOTES_ORDENES index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_LOTES_ORDENES;

	/* Tipos referenciando al registro */
	type tytbID_LOTE is table of LDC_LOTES_ORDENES.ID_LOTE%type index by binary_integer;
	type tytbID_SESSION is table of LDC_LOTES_ORDENES.ID_SESSION%type index by binary_integer;
	type tytbUSER_ID is table of LDC_LOTES_ORDENES.USER_ID%type index by binary_integer;
	type tytbCREATE_DATE is table of LDC_LOTES_ORDENES.CREATE_DATE%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_LOTES_ORDENES is record
	(
		ID_LOTE   tytbID_LOTE,
		ID_SESSION   tytbID_SESSION,
		USER_ID   tytbUSER_ID,
		CREATE_DATE   tytbCREATE_DATE,
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
		inuID_LOTE in LDC_LOTES_ORDENES.ID_LOTE%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuID_LOTE in LDC_LOTES_ORDENES.ID_LOTE%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuID_LOTE in LDC_LOTES_ORDENES.ID_LOTE%type
	);

	PROCEDURE getRecord
	(
		inuID_LOTE in LDC_LOTES_ORDENES.ID_LOTE%type,
		orcRecord out nocopy styLDC_LOTES_ORDENES
	);

	FUNCTION frcGetRcData
	(
		inuID_LOTE in LDC_LOTES_ORDENES.ID_LOTE%type
	)
	RETURN styLDC_LOTES_ORDENES;

	FUNCTION frcGetRcData
	RETURN styLDC_LOTES_ORDENES;

	FUNCTION frcGetRecord
	(
		inuID_LOTE in LDC_LOTES_ORDENES.ID_LOTE%type
	)
	RETURN styLDC_LOTES_ORDENES;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_LOTES_ORDENES
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_LOTES_ORDENES in styLDC_LOTES_ORDENES
	);

	PROCEDURE insRecord
	(
		ircLDC_LOTES_ORDENES in styLDC_LOTES_ORDENES,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_LOTES_ORDENES in out nocopy tytbLDC_LOTES_ORDENES
	);

	PROCEDURE delRecord
	(
		inuID_LOTE in LDC_LOTES_ORDENES.ID_LOTE%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_LOTES_ORDENES in out nocopy tytbLDC_LOTES_ORDENES,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_LOTES_ORDENES in styLDC_LOTES_ORDENES,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_LOTES_ORDENES in out nocopy tytbLDC_LOTES_ORDENES,
		inuLock in number default 1
	);

	PROCEDURE updID_SESSION
	(
		inuID_LOTE in LDC_LOTES_ORDENES.ID_LOTE%type,
		inuID_SESSION$ in LDC_LOTES_ORDENES.ID_SESSION%type,
		inuLock in number default 0
	);

	PROCEDURE updUSER_ID
	(
		inuID_LOTE in LDC_LOTES_ORDENES.ID_LOTE%type,
		inuUSER_ID$ in LDC_LOTES_ORDENES.USER_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updCREATE_DATE
	(
		inuID_LOTE in LDC_LOTES_ORDENES.ID_LOTE%type,
		idtCREATE_DATE$ in LDC_LOTES_ORDENES.CREATE_DATE%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetID_LOTE
	(
		inuID_LOTE in LDC_LOTES_ORDENES.ID_LOTE%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_LOTES_ORDENES.ID_LOTE%type;

	FUNCTION fnuGetID_SESSION
	(
		inuID_LOTE in LDC_LOTES_ORDENES.ID_LOTE%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_LOTES_ORDENES.ID_SESSION%type;

	FUNCTION fnuGetUSER_ID
	(
		inuID_LOTE in LDC_LOTES_ORDENES.ID_LOTE%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_LOTES_ORDENES.USER_ID%type;

	FUNCTION fdtGetCREATE_DATE
	(
		inuID_LOTE in LDC_LOTES_ORDENES.ID_LOTE%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_LOTES_ORDENES.CREATE_DATE%type;


	PROCEDURE LockByPk
	(
		inuID_LOTE in LDC_LOTES_ORDENES.ID_LOTE%type,
		orcLDC_LOTES_ORDENES  out styLDC_LOTES_ORDENES
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_LOTES_ORDENES  out styLDC_LOTES_ORDENES
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_LOTES_ORDENES;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALDC_LOTES_ORDENES
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO6013';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_LOTES_ORDENES';
	 cnuGeEntityId constant varchar2(30) := 2190; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuID_LOTE in LDC_LOTES_ORDENES.ID_LOTE%type
	)
	IS
		SELECT LDC_LOTES_ORDENES.*,LDC_LOTES_ORDENES.rowid
		FROM LDC_LOTES_ORDENES
		WHERE  ID_LOTE = inuID_LOTE
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_LOTES_ORDENES.*,LDC_LOTES_ORDENES.rowid
		FROM LDC_LOTES_ORDENES
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_LOTES_ORDENES is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_LOTES_ORDENES;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_LOTES_ORDENES default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.ID_LOTE);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuID_LOTE in LDC_LOTES_ORDENES.ID_LOTE%type,
		orcLDC_LOTES_ORDENES  out styLDC_LOTES_ORDENES
	)
	IS
		rcError styLDC_LOTES_ORDENES;
	BEGIN
		rcError.ID_LOTE := inuID_LOTE;

		Open cuLockRcByPk
		(
			inuID_LOTE
		);

		fetch cuLockRcByPk into orcLDC_LOTES_ORDENES;
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
		orcLDC_LOTES_ORDENES  out styLDC_LOTES_ORDENES
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_LOTES_ORDENES;
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
		itbLDC_LOTES_ORDENES  in out nocopy tytbLDC_LOTES_ORDENES
	)
	IS
	BEGIN
			rcRecOfTab.ID_LOTE.delete;
			rcRecOfTab.ID_SESSION.delete;
			rcRecOfTab.USER_ID.delete;
			rcRecOfTab.CREATE_DATE.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_LOTES_ORDENES  in out nocopy tytbLDC_LOTES_ORDENES,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_LOTES_ORDENES);

		for n in itbLDC_LOTES_ORDENES.first .. itbLDC_LOTES_ORDENES.last loop
			rcRecOfTab.ID_LOTE(n) := itbLDC_LOTES_ORDENES(n).ID_LOTE;
			rcRecOfTab.ID_SESSION(n) := itbLDC_LOTES_ORDENES(n).ID_SESSION;
			rcRecOfTab.USER_ID(n) := itbLDC_LOTES_ORDENES(n).USER_ID;
			rcRecOfTab.CREATE_DATE(n) := itbLDC_LOTES_ORDENES(n).CREATE_DATE;
			rcRecOfTab.row_id(n) := itbLDC_LOTES_ORDENES(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuID_LOTE in LDC_LOTES_ORDENES.ID_LOTE%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuID_LOTE
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
		inuID_LOTE in LDC_LOTES_ORDENES.ID_LOTE%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuID_LOTE = rcData.ID_LOTE
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
		inuID_LOTE in LDC_LOTES_ORDENES.ID_LOTE%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuID_LOTE
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuID_LOTE in LDC_LOTES_ORDENES.ID_LOTE%type
	)
	IS
		rcError styLDC_LOTES_ORDENES;
	BEGIN		rcError.ID_LOTE:=inuID_LOTE;

		Load
		(
			inuID_LOTE
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
		inuID_LOTE in LDC_LOTES_ORDENES.ID_LOTE%type
	)
	IS
	BEGIN
		Load
		(
			inuID_LOTE
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuID_LOTE in LDC_LOTES_ORDENES.ID_LOTE%type,
		orcRecord out nocopy styLDC_LOTES_ORDENES
	)
	IS
		rcError styLDC_LOTES_ORDENES;
	BEGIN		rcError.ID_LOTE:=inuID_LOTE;

		Load
		(
			inuID_LOTE
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuID_LOTE in LDC_LOTES_ORDENES.ID_LOTE%type
	)
	RETURN styLDC_LOTES_ORDENES
	IS
		rcError styLDC_LOTES_ORDENES;
	BEGIN
		rcError.ID_LOTE:=inuID_LOTE;

		Load
		(
			inuID_LOTE
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuID_LOTE in LDC_LOTES_ORDENES.ID_LOTE%type
	)
	RETURN styLDC_LOTES_ORDENES
	IS
		rcError styLDC_LOTES_ORDENES;
	BEGIN
		rcError.ID_LOTE:=inuID_LOTE;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuID_LOTE
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuID_LOTE
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_LOTES_ORDENES
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_LOTES_ORDENES
	)
	IS
		rfLDC_LOTES_ORDENES tyrfLDC_LOTES_ORDENES;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_LOTES_ORDENES.*, LDC_LOTES_ORDENES.rowid FROM LDC_LOTES_ORDENES';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_LOTES_ORDENES for sbFullQuery;

		fetch rfLDC_LOTES_ORDENES bulk collect INTO otbResult;

		close rfLDC_LOTES_ORDENES;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_LOTES_ORDENES.*, LDC_LOTES_ORDENES.rowid FROM LDC_LOTES_ORDENES';
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
		ircLDC_LOTES_ORDENES in styLDC_LOTES_ORDENES
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_LOTES_ORDENES,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_LOTES_ORDENES in styLDC_LOTES_ORDENES,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_LOTES_ORDENES.ID_LOTE is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ID_LOTE');
			raise ex.controlled_error;
		end if;

		insert into LDC_LOTES_ORDENES
		(
			ID_LOTE,
			ID_SESSION,
			USER_ID,
			CREATE_DATE
		)
		values
		(
			ircLDC_LOTES_ORDENES.ID_LOTE,
			ircLDC_LOTES_ORDENES.ID_SESSION,
			ircLDC_LOTES_ORDENES.USER_ID,
			ircLDC_LOTES_ORDENES.CREATE_DATE
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_LOTES_ORDENES));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_LOTES_ORDENES in out nocopy tytbLDC_LOTES_ORDENES
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_LOTES_ORDENES,blUseRowID);
		forall n in iotbLDC_LOTES_ORDENES.first..iotbLDC_LOTES_ORDENES.last
			insert into LDC_LOTES_ORDENES
			(
				ID_LOTE,
				ID_SESSION,
				USER_ID,
				CREATE_DATE
			)
			values
			(
				rcRecOfTab.ID_LOTE(n),
				rcRecOfTab.ID_SESSION(n),
				rcRecOfTab.USER_ID(n),
				rcRecOfTab.CREATE_DATE(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuID_LOTE in LDC_LOTES_ORDENES.ID_LOTE%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_LOTES_ORDENES;
	BEGIN
		rcError.ID_LOTE := inuID_LOTE;

		if inuLock=1 then
			LockByPk
			(
				inuID_LOTE,
				rcData
			);
		end if;


		delete
		from LDC_LOTES_ORDENES
		where
       		ID_LOTE=inuID_LOTE;
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
		rcError  styLDC_LOTES_ORDENES;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_LOTES_ORDENES
		where
			rowid = iriRowID
		returning
			ID_LOTE
		into
			rcError.ID_LOTE;
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
		iotbLDC_LOTES_ORDENES in out nocopy tytbLDC_LOTES_ORDENES,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_LOTES_ORDENES;
	BEGIN
		FillRecordOfTables(iotbLDC_LOTES_ORDENES, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_LOTES_ORDENES.first .. iotbLDC_LOTES_ORDENES.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_LOTES_ORDENES.first .. iotbLDC_LOTES_ORDENES.last
				delete
				from LDC_LOTES_ORDENES
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_LOTES_ORDENES.first .. iotbLDC_LOTES_ORDENES.last loop
					LockByPk
					(
						rcRecOfTab.ID_LOTE(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_LOTES_ORDENES.first .. iotbLDC_LOTES_ORDENES.last
				delete
				from LDC_LOTES_ORDENES
				where
		         	ID_LOTE = rcRecOfTab.ID_LOTE(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_LOTES_ORDENES in styLDC_LOTES_ORDENES,
		inuLock in number default 0
	)
	IS
		nuID_LOTE	LDC_LOTES_ORDENES.ID_LOTE%type;
	BEGIN
		if ircLDC_LOTES_ORDENES.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_LOTES_ORDENES.rowid,rcData);
			end if;
			update LDC_LOTES_ORDENES
			set
				ID_SESSION = ircLDC_LOTES_ORDENES.ID_SESSION,
				USER_ID = ircLDC_LOTES_ORDENES.USER_ID,
				CREATE_DATE = ircLDC_LOTES_ORDENES.CREATE_DATE
			where
				rowid = ircLDC_LOTES_ORDENES.rowid
			returning
				ID_LOTE
			into
				nuID_LOTE;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_LOTES_ORDENES.ID_LOTE,
					rcData
				);
			end if;

			update LDC_LOTES_ORDENES
			set
				ID_SESSION = ircLDC_LOTES_ORDENES.ID_SESSION,
				USER_ID = ircLDC_LOTES_ORDENES.USER_ID,
				CREATE_DATE = ircLDC_LOTES_ORDENES.CREATE_DATE
			where
				ID_LOTE = ircLDC_LOTES_ORDENES.ID_LOTE
			returning
				ID_LOTE
			into
				nuID_LOTE;
		end if;
		if
			nuID_LOTE is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_LOTES_ORDENES));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_LOTES_ORDENES in out nocopy tytbLDC_LOTES_ORDENES,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_LOTES_ORDENES;
	BEGIN
		FillRecordOfTables(iotbLDC_LOTES_ORDENES,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_LOTES_ORDENES.first .. iotbLDC_LOTES_ORDENES.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_LOTES_ORDENES.first .. iotbLDC_LOTES_ORDENES.last
				update LDC_LOTES_ORDENES
				set
					ID_SESSION = rcRecOfTab.ID_SESSION(n),
					USER_ID = rcRecOfTab.USER_ID(n),
					CREATE_DATE = rcRecOfTab.CREATE_DATE(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_LOTES_ORDENES.first .. iotbLDC_LOTES_ORDENES.last loop
					LockByPk
					(
						rcRecOfTab.ID_LOTE(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_LOTES_ORDENES.first .. iotbLDC_LOTES_ORDENES.last
				update LDC_LOTES_ORDENES
				SET
					ID_SESSION = rcRecOfTab.ID_SESSION(n),
					USER_ID = rcRecOfTab.USER_ID(n),
					CREATE_DATE = rcRecOfTab.CREATE_DATE(n)
				where
					ID_LOTE = rcRecOfTab.ID_LOTE(n)
;
		end if;
	END;
	PROCEDURE updID_SESSION
	(
		inuID_LOTE in LDC_LOTES_ORDENES.ID_LOTE%type,
		inuID_SESSION$ in LDC_LOTES_ORDENES.ID_SESSION%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_LOTES_ORDENES;
	BEGIN
		rcError.ID_LOTE := inuID_LOTE;
		if inuLock=1 then
			LockByPk
			(
				inuID_LOTE,
				rcData
			);
		end if;

		update LDC_LOTES_ORDENES
		set
			ID_SESSION = inuID_SESSION$
		where
			ID_LOTE = inuID_LOTE;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ID_SESSION:= inuID_SESSION$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updUSER_ID
	(
		inuID_LOTE in LDC_LOTES_ORDENES.ID_LOTE%type,
		inuUSER_ID$ in LDC_LOTES_ORDENES.USER_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_LOTES_ORDENES;
	BEGIN
		rcError.ID_LOTE := inuID_LOTE;
		if inuLock=1 then
			LockByPk
			(
				inuID_LOTE,
				rcData
			);
		end if;

		update LDC_LOTES_ORDENES
		set
			USER_ID = inuUSER_ID$
		where
			ID_LOTE = inuID_LOTE;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.USER_ID:= inuUSER_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCREATE_DATE
	(
		inuID_LOTE in LDC_LOTES_ORDENES.ID_LOTE%type,
		idtCREATE_DATE$ in LDC_LOTES_ORDENES.CREATE_DATE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_LOTES_ORDENES;
	BEGIN
		rcError.ID_LOTE := inuID_LOTE;
		if inuLock=1 then
			LockByPk
			(
				inuID_LOTE,
				rcData
			);
		end if;

		update LDC_LOTES_ORDENES
		set
			CREATE_DATE = idtCREATE_DATE$
		where
			ID_LOTE = inuID_LOTE;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CREATE_DATE:= idtCREATE_DATE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetID_LOTE
	(
		inuID_LOTE in LDC_LOTES_ORDENES.ID_LOTE%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_LOTES_ORDENES.ID_LOTE%type
	IS
		rcError styLDC_LOTES_ORDENES;
	BEGIN

		rcError.ID_LOTE := inuID_LOTE;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_LOTE
			 )
		then
			 return(rcData.ID_LOTE);
		end if;
		Load
		(
		 		inuID_LOTE
		);
		return(rcData.ID_LOTE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetID_SESSION
	(
		inuID_LOTE in LDC_LOTES_ORDENES.ID_LOTE%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_LOTES_ORDENES.ID_SESSION%type
	IS
		rcError styLDC_LOTES_ORDENES;
	BEGIN

		rcError.ID_LOTE := inuID_LOTE;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_LOTE
			 )
		then
			 return(rcData.ID_SESSION);
		end if;
		Load
		(
		 		inuID_LOTE
		);
		return(rcData.ID_SESSION);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetUSER_ID
	(
		inuID_LOTE in LDC_LOTES_ORDENES.ID_LOTE%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_LOTES_ORDENES.USER_ID%type
	IS
		rcError styLDC_LOTES_ORDENES;
	BEGIN

		rcError.ID_LOTE := inuID_LOTE;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_LOTE
			 )
		then
			 return(rcData.USER_ID);
		end if;
		Load
		(
		 		inuID_LOTE
		);
		return(rcData.USER_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetCREATE_DATE
	(
		inuID_LOTE in LDC_LOTES_ORDENES.ID_LOTE%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_LOTES_ORDENES.CREATE_DATE%type
	IS
		rcError styLDC_LOTES_ORDENES;
	BEGIN

		rcError.ID_LOTE := inuID_LOTE;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_LOTE
			 )
		then
			 return(rcData.CREATE_DATE);
		end if;
		Load
		(
		 		inuID_LOTE
		);
		return(rcData.CREATE_DATE);
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
end DALDC_LOTES_ORDENES;
/
PROMPT Otorgando permisos de ejecucion a DALDC_LOTES_ORDENES
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_LOTES_ORDENES', 'ADM_PERSON');
END;
/