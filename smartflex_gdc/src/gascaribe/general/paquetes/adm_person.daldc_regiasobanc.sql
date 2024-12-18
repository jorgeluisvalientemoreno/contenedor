CREATE OR REPLACE PACKAGE ADM_PERSON.DALDC_REGIASOBANC
is
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     : DALDC_REGIASOBANC
    Descripcion	 : 
    
    Parametro	    Descripcion
    ============	==============================
    
    Historia de Modificaciones
    Fecha   	           Autor            Modificacion
    ====================   =========        ====================
    07/06/2024              PAcosta         OSF-2812: Cambio de esquema ADM_PERSON                                
    ****************************************************************/   
    
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuREGIASOBANC_ID in LDC_REGIASOBANC.REGIASOBANC_ID%type
	)
	IS
		SELECT LDC_REGIASOBANC.*,LDC_REGIASOBANC.rowid
		FROM LDC_REGIASOBANC
		WHERE
		    REGIASOBANC_ID = inuREGIASOBANC_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_REGIASOBANC.*,LDC_REGIASOBANC.rowid
		FROM LDC_REGIASOBANC
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_REGIASOBANC  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_REGIASOBANC is table of styLDC_REGIASOBANC index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_REGIASOBANC;

	/* Tipos referenciando al registro */
	type tytbDESCRIPTION is table of LDC_REGIASOBANC.DESCRIPTION%type index by binary_integer;
	type tytbARCHASOBANC_ID is table of LDC_REGIASOBANC.ARCHASOBANC_ID%type index by binary_integer;
	type tytbREGIASOBANC_ID is table of LDC_REGIASOBANC.REGIASOBANC_ID%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_REGIASOBANC is record
	(
		DESCRIPTION   tytbDESCRIPTION,
		ARCHASOBANC_ID   tytbARCHASOBANC_ID,
		REGIASOBANC_ID   tytbREGIASOBANC_ID,
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
		inuREGIASOBANC_ID in LDC_REGIASOBANC.REGIASOBANC_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuREGIASOBANC_ID in LDC_REGIASOBANC.REGIASOBANC_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuREGIASOBANC_ID in LDC_REGIASOBANC.REGIASOBANC_ID%type
	);

	PROCEDURE getRecord
	(
		inuREGIASOBANC_ID in LDC_REGIASOBANC.REGIASOBANC_ID%type,
		orcRecord out nocopy styLDC_REGIASOBANC
	);

	FUNCTION frcGetRcData
	(
		inuREGIASOBANC_ID in LDC_REGIASOBANC.REGIASOBANC_ID%type
	)
	RETURN styLDC_REGIASOBANC;

	FUNCTION frcGetRcData
	RETURN styLDC_REGIASOBANC;

	FUNCTION frcGetRecord
	(
		inuREGIASOBANC_ID in LDC_REGIASOBANC.REGIASOBANC_ID%type
	)
	RETURN styLDC_REGIASOBANC;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_REGIASOBANC
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_REGIASOBANC in styLDC_REGIASOBANC
	);

	PROCEDURE insRecord
	(
		ircLDC_REGIASOBANC in styLDC_REGIASOBANC,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_REGIASOBANC in out nocopy tytbLDC_REGIASOBANC
	);

	PROCEDURE delRecord
	(
		inuREGIASOBANC_ID in LDC_REGIASOBANC.REGIASOBANC_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_REGIASOBANC in out nocopy tytbLDC_REGIASOBANC,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_REGIASOBANC in styLDC_REGIASOBANC,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_REGIASOBANC in out nocopy tytbLDC_REGIASOBANC,
		inuLock in number default 1
	);

	PROCEDURE updDESCRIPTION
	(
		inuREGIASOBANC_ID in LDC_REGIASOBANC.REGIASOBANC_ID%type,
		isbDESCRIPTION$ in LDC_REGIASOBANC.DESCRIPTION%type,
		inuLock in number default 0
	);

	PROCEDURE updARCHASOBANC_ID
	(
		inuREGIASOBANC_ID in LDC_REGIASOBANC.REGIASOBANC_ID%type,
		inuARCHASOBANC_ID$ in LDC_REGIASOBANC.ARCHASOBANC_ID%type,
		inuLock in number default 0
	);

	FUNCTION fsbGetDESCRIPTION
	(
		inuREGIASOBANC_ID in LDC_REGIASOBANC.REGIASOBANC_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_REGIASOBANC.DESCRIPTION%type;

	FUNCTION fnuGetARCHASOBANC_ID
	(
		inuREGIASOBANC_ID in LDC_REGIASOBANC.REGIASOBANC_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_REGIASOBANC.ARCHASOBANC_ID%type;

	FUNCTION fnuGetREGIASOBANC_ID
	(
		inuREGIASOBANC_ID in LDC_REGIASOBANC.REGIASOBANC_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_REGIASOBANC.REGIASOBANC_ID%type;


	PROCEDURE LockByPk
	(
		inuREGIASOBANC_ID in LDC_REGIASOBANC.REGIASOBANC_ID%type,
		orcLDC_REGIASOBANC  out styLDC_REGIASOBANC
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_REGIASOBANC  out styLDC_REGIASOBANC
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_REGIASOBANC;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALDC_REGIASOBANC
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_REGIASOBANC';
	 cnuGeEntityId constant varchar2(30) := 56; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuREGIASOBANC_ID in LDC_REGIASOBANC.REGIASOBANC_ID%type
	)
	IS
		SELECT LDC_REGIASOBANC.*,LDC_REGIASOBANC.rowid
		FROM LDC_REGIASOBANC
		WHERE  REGIASOBANC_ID = inuREGIASOBANC_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_REGIASOBANC.*,LDC_REGIASOBANC.rowid
		FROM LDC_REGIASOBANC
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_REGIASOBANC is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_REGIASOBANC;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_REGIASOBANC default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.REGIASOBANC_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuREGIASOBANC_ID in LDC_REGIASOBANC.REGIASOBANC_ID%type,
		orcLDC_REGIASOBANC  out styLDC_REGIASOBANC
	)
	IS
		rcError styLDC_REGIASOBANC;
	BEGIN
		rcError.REGIASOBANC_ID := inuREGIASOBANC_ID;

		Open cuLockRcByPk
		(
			inuREGIASOBANC_ID
		);

		fetch cuLockRcByPk into orcLDC_REGIASOBANC;
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
		orcLDC_REGIASOBANC  out styLDC_REGIASOBANC
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_REGIASOBANC;
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
		itbLDC_REGIASOBANC  in out nocopy tytbLDC_REGIASOBANC
	)
	IS
	BEGIN
			rcRecOfTab.DESCRIPTION.delete;
			rcRecOfTab.ARCHASOBANC_ID.delete;
			rcRecOfTab.REGIASOBANC_ID.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_REGIASOBANC  in out nocopy tytbLDC_REGIASOBANC,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_REGIASOBANC);

		for n in itbLDC_REGIASOBANC.first .. itbLDC_REGIASOBANC.last loop
			rcRecOfTab.DESCRIPTION(n) := itbLDC_REGIASOBANC(n).DESCRIPTION;
			rcRecOfTab.ARCHASOBANC_ID(n) := itbLDC_REGIASOBANC(n).ARCHASOBANC_ID;
			rcRecOfTab.REGIASOBANC_ID(n) := itbLDC_REGIASOBANC(n).REGIASOBANC_ID;
			rcRecOfTab.row_id(n) := itbLDC_REGIASOBANC(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuREGIASOBANC_ID in LDC_REGIASOBANC.REGIASOBANC_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuREGIASOBANC_ID
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
		inuREGIASOBANC_ID in LDC_REGIASOBANC.REGIASOBANC_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuREGIASOBANC_ID = rcData.REGIASOBANC_ID
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
		inuREGIASOBANC_ID in LDC_REGIASOBANC.REGIASOBANC_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuREGIASOBANC_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuREGIASOBANC_ID in LDC_REGIASOBANC.REGIASOBANC_ID%type
	)
	IS
		rcError styLDC_REGIASOBANC;
	BEGIN		rcError.REGIASOBANC_ID:=inuREGIASOBANC_ID;

		Load
		(
			inuREGIASOBANC_ID
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
		inuREGIASOBANC_ID in LDC_REGIASOBANC.REGIASOBANC_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuREGIASOBANC_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuREGIASOBANC_ID in LDC_REGIASOBANC.REGIASOBANC_ID%type,
		orcRecord out nocopy styLDC_REGIASOBANC
	)
	IS
		rcError styLDC_REGIASOBANC;
	BEGIN		rcError.REGIASOBANC_ID:=inuREGIASOBANC_ID;

		Load
		(
			inuREGIASOBANC_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuREGIASOBANC_ID in LDC_REGIASOBANC.REGIASOBANC_ID%type
	)
	RETURN styLDC_REGIASOBANC
	IS
		rcError styLDC_REGIASOBANC;
	BEGIN
		rcError.REGIASOBANC_ID:=inuREGIASOBANC_ID;

		Load
		(
			inuREGIASOBANC_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuREGIASOBANC_ID in LDC_REGIASOBANC.REGIASOBANC_ID%type
	)
	RETURN styLDC_REGIASOBANC
	IS
		rcError styLDC_REGIASOBANC;
	BEGIN
		rcError.REGIASOBANC_ID:=inuREGIASOBANC_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuREGIASOBANC_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuREGIASOBANC_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_REGIASOBANC
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_REGIASOBANC
	)
	IS
		rfLDC_REGIASOBANC tyrfLDC_REGIASOBANC;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_REGIASOBANC.*, LDC_REGIASOBANC.rowid FROM LDC_REGIASOBANC';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_REGIASOBANC for sbFullQuery;

		fetch rfLDC_REGIASOBANC bulk collect INTO otbResult;

		close rfLDC_REGIASOBANC;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_REGIASOBANC.*, LDC_REGIASOBANC.rowid FROM LDC_REGIASOBANC';
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
		ircLDC_REGIASOBANC in styLDC_REGIASOBANC
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_REGIASOBANC,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_REGIASOBANC in styLDC_REGIASOBANC,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_REGIASOBANC.REGIASOBANC_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|REGIASOBANC_ID');
			raise ex.controlled_error;
		end if;

		insert into LDC_REGIASOBANC
		(
			DESCRIPTION,
			ARCHASOBANC_ID,
			REGIASOBANC_ID
		)
		values
		(
			ircLDC_REGIASOBANC.DESCRIPTION,
			ircLDC_REGIASOBANC.ARCHASOBANC_ID,
			ircLDC_REGIASOBANC.REGIASOBANC_ID
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_REGIASOBANC));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_REGIASOBANC in out nocopy tytbLDC_REGIASOBANC
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_REGIASOBANC,blUseRowID);
		forall n in iotbLDC_REGIASOBANC.first..iotbLDC_REGIASOBANC.last
			insert into LDC_REGIASOBANC
			(
				DESCRIPTION,
				ARCHASOBANC_ID,
				REGIASOBANC_ID
			)
			values
			(
				rcRecOfTab.DESCRIPTION(n),
				rcRecOfTab.ARCHASOBANC_ID(n),
				rcRecOfTab.REGIASOBANC_ID(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuREGIASOBANC_ID in LDC_REGIASOBANC.REGIASOBANC_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_REGIASOBANC;
	BEGIN
		rcError.REGIASOBANC_ID := inuREGIASOBANC_ID;

		if inuLock=1 then
			LockByPk
			(
				inuREGIASOBANC_ID,
				rcData
			);
		end if;


		delete
		from LDC_REGIASOBANC
		where
       		REGIASOBANC_ID=inuREGIASOBANC_ID;
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
		rcError  styLDC_REGIASOBANC;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_REGIASOBANC
		where
			rowid = iriRowID
		returning
			DESCRIPTION
		into
			rcError.DESCRIPTION;
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
		iotbLDC_REGIASOBANC in out nocopy tytbLDC_REGIASOBANC,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_REGIASOBANC;
	BEGIN
		FillRecordOfTables(iotbLDC_REGIASOBANC, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_REGIASOBANC.first .. iotbLDC_REGIASOBANC.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_REGIASOBANC.first .. iotbLDC_REGIASOBANC.last
				delete
				from LDC_REGIASOBANC
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_REGIASOBANC.first .. iotbLDC_REGIASOBANC.last loop
					LockByPk
					(
						rcRecOfTab.REGIASOBANC_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_REGIASOBANC.first .. iotbLDC_REGIASOBANC.last
				delete
				from LDC_REGIASOBANC
				where
		         	REGIASOBANC_ID = rcRecOfTab.REGIASOBANC_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_REGIASOBANC in styLDC_REGIASOBANC,
		inuLock in number default 0
	)
	IS
		nuREGIASOBANC_ID	LDC_REGIASOBANC.REGIASOBANC_ID%type;
	BEGIN
		if ircLDC_REGIASOBANC.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_REGIASOBANC.rowid,rcData);
			end if;
			update LDC_REGIASOBANC
			set
				DESCRIPTION = ircLDC_REGIASOBANC.DESCRIPTION,
				ARCHASOBANC_ID = ircLDC_REGIASOBANC.ARCHASOBANC_ID
			where
				rowid = ircLDC_REGIASOBANC.rowid
			returning
				REGIASOBANC_ID
			into
				nuREGIASOBANC_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_REGIASOBANC.REGIASOBANC_ID,
					rcData
				);
			end if;

			update LDC_REGIASOBANC
			set
				DESCRIPTION = ircLDC_REGIASOBANC.DESCRIPTION,
				ARCHASOBANC_ID = ircLDC_REGIASOBANC.ARCHASOBANC_ID
			where
				REGIASOBANC_ID = ircLDC_REGIASOBANC.REGIASOBANC_ID
			returning
				REGIASOBANC_ID
			into
				nuREGIASOBANC_ID;
		end if;
		if
			nuREGIASOBANC_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_REGIASOBANC));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_REGIASOBANC in out nocopy tytbLDC_REGIASOBANC,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_REGIASOBANC;
	BEGIN
		FillRecordOfTables(iotbLDC_REGIASOBANC,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_REGIASOBANC.first .. iotbLDC_REGIASOBANC.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_REGIASOBANC.first .. iotbLDC_REGIASOBANC.last
				update LDC_REGIASOBANC
				set
					DESCRIPTION = rcRecOfTab.DESCRIPTION(n),
					ARCHASOBANC_ID = rcRecOfTab.ARCHASOBANC_ID(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_REGIASOBANC.first .. iotbLDC_REGIASOBANC.last loop
					LockByPk
					(
						rcRecOfTab.REGIASOBANC_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_REGIASOBANC.first .. iotbLDC_REGIASOBANC.last
				update LDC_REGIASOBANC
				SET
					DESCRIPTION = rcRecOfTab.DESCRIPTION(n),
					ARCHASOBANC_ID = rcRecOfTab.ARCHASOBANC_ID(n)
				where
					REGIASOBANC_ID = rcRecOfTab.REGIASOBANC_ID(n)
;
		end if;
	END;
	PROCEDURE updDESCRIPTION
	(
		inuREGIASOBANC_ID in LDC_REGIASOBANC.REGIASOBANC_ID%type,
		isbDESCRIPTION$ in LDC_REGIASOBANC.DESCRIPTION%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_REGIASOBANC;
	BEGIN
		rcError.REGIASOBANC_ID := inuREGIASOBANC_ID;
		if inuLock=1 then
			LockByPk
			(
				inuREGIASOBANC_ID,
				rcData
			);
		end if;

		update LDC_REGIASOBANC
		set
			DESCRIPTION = isbDESCRIPTION$
		where
			REGIASOBANC_ID = inuREGIASOBANC_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DESCRIPTION:= isbDESCRIPTION$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updARCHASOBANC_ID
	(
		inuREGIASOBANC_ID in LDC_REGIASOBANC.REGIASOBANC_ID%type,
		inuARCHASOBANC_ID$ in LDC_REGIASOBANC.ARCHASOBANC_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_REGIASOBANC;
	BEGIN
		rcError.REGIASOBANC_ID := inuREGIASOBANC_ID;
		if inuLock=1 then
			LockByPk
			(
				inuREGIASOBANC_ID,
				rcData
			);
		end if;

		update LDC_REGIASOBANC
		set
			ARCHASOBANC_ID = inuARCHASOBANC_ID$
		where
			REGIASOBANC_ID = inuREGIASOBANC_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ARCHASOBANC_ID:= inuARCHASOBANC_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fsbGetDESCRIPTION
	(
		inuREGIASOBANC_ID in LDC_REGIASOBANC.REGIASOBANC_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_REGIASOBANC.DESCRIPTION%type
	IS
		rcError styLDC_REGIASOBANC;
	BEGIN

		rcError.REGIASOBANC_ID := inuREGIASOBANC_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuREGIASOBANC_ID
			 )
		then
			 return(rcData.DESCRIPTION);
		end if;
		Load
		(
		 		inuREGIASOBANC_ID
		);
		return(rcData.DESCRIPTION);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetARCHASOBANC_ID
	(
		inuREGIASOBANC_ID in LDC_REGIASOBANC.REGIASOBANC_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_REGIASOBANC.ARCHASOBANC_ID%type
	IS
		rcError styLDC_REGIASOBANC;
	BEGIN

		rcError.REGIASOBANC_ID := inuREGIASOBANC_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuREGIASOBANC_ID
			 )
		then
			 return(rcData.ARCHASOBANC_ID);
		end if;
		Load
		(
		 		inuREGIASOBANC_ID
		);
		return(rcData.ARCHASOBANC_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetREGIASOBANC_ID
	(
		inuREGIASOBANC_ID in LDC_REGIASOBANC.REGIASOBANC_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_REGIASOBANC.REGIASOBANC_ID%type
	IS
		rcError styLDC_REGIASOBANC;
	BEGIN

		rcError.REGIASOBANC_ID := inuREGIASOBANC_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuREGIASOBANC_ID
			 )
		then
			 return(rcData.REGIASOBANC_ID);
		end if;
		Load
		(
		 		inuREGIASOBANC_ID
		);
		return(rcData.REGIASOBANC_ID);
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
end DALDC_REGIASOBANC;
/
PROMPT Otorgando permisos de ejecucion a DALDC_REGIASOBANC
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_REGIASOBANC', 'ADM_PERSON');
END;
/