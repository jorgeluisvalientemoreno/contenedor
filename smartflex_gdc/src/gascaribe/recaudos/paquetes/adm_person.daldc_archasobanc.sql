CREATE OR REPLACE PACKAGE adm_person.DALDC_ARCHASOBANC
is
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     : DALDC_ARCHASOBANC
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
		inuARCHASOBANC_ID in LDC_ARCHASOBANC.ARCHASOBANC_ID%type
	)
	IS
		SELECT LDC_ARCHASOBANC.*,LDC_ARCHASOBANC.rowid
		FROM LDC_ARCHASOBANC
		WHERE
		    ARCHASOBANC_ID = inuARCHASOBANC_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_ARCHASOBANC.*,LDC_ARCHASOBANC.rowid
		FROM LDC_ARCHASOBANC
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_ARCHASOBANC  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_ARCHASOBANC is table of styLDC_ARCHASOBANC index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_ARCHASOBANC;

	/* Tipos referenciando al registro */
	type tytbDESCRIPTION is table of LDC_ARCHASOBANC.DESCRIPTION%type index by binary_integer;
	type tytbARCHASOBANC_ID is table of LDC_ARCHASOBANC.ARCHASOBANC_ID%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_ARCHASOBANC is record
	(
		DESCRIPTION   tytbDESCRIPTION,
		ARCHASOBANC_ID   tytbARCHASOBANC_ID,
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
		inuARCHASOBANC_ID in LDC_ARCHASOBANC.ARCHASOBANC_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuARCHASOBANC_ID in LDC_ARCHASOBANC.ARCHASOBANC_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuARCHASOBANC_ID in LDC_ARCHASOBANC.ARCHASOBANC_ID%type
	);

	PROCEDURE getRecord
	(
		inuARCHASOBANC_ID in LDC_ARCHASOBANC.ARCHASOBANC_ID%type,
		orcRecord out nocopy styLDC_ARCHASOBANC
	);

	FUNCTION frcGetRcData
	(
		inuARCHASOBANC_ID in LDC_ARCHASOBANC.ARCHASOBANC_ID%type
	)
	RETURN styLDC_ARCHASOBANC;

	FUNCTION frcGetRcData
	RETURN styLDC_ARCHASOBANC;

	FUNCTION frcGetRecord
	(
		inuARCHASOBANC_ID in LDC_ARCHASOBANC.ARCHASOBANC_ID%type
	)
	RETURN styLDC_ARCHASOBANC;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_ARCHASOBANC
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_ARCHASOBANC in styLDC_ARCHASOBANC
	);

	PROCEDURE insRecord
	(
		ircLDC_ARCHASOBANC in styLDC_ARCHASOBANC,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_ARCHASOBANC in out nocopy tytbLDC_ARCHASOBANC
	);

	PROCEDURE delRecord
	(
		inuARCHASOBANC_ID in LDC_ARCHASOBANC.ARCHASOBANC_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_ARCHASOBANC in out nocopy tytbLDC_ARCHASOBANC,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_ARCHASOBANC in styLDC_ARCHASOBANC,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_ARCHASOBANC in out nocopy tytbLDC_ARCHASOBANC,
		inuLock in number default 1
	);

	PROCEDURE updDESCRIPTION
	(
		inuARCHASOBANC_ID in LDC_ARCHASOBANC.ARCHASOBANC_ID%type,
		isbDESCRIPTION$ in LDC_ARCHASOBANC.DESCRIPTION%type,
		inuLock in number default 0
	);

	FUNCTION fsbGetDESCRIPTION
	(
		inuARCHASOBANC_ID in LDC_ARCHASOBANC.ARCHASOBANC_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ARCHASOBANC.DESCRIPTION%type;

	FUNCTION fnuGetARCHASOBANC_ID
	(
		inuARCHASOBANC_ID in LDC_ARCHASOBANC.ARCHASOBANC_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ARCHASOBANC.ARCHASOBANC_ID%type;


	PROCEDURE LockByPk
	(
		inuARCHASOBANC_ID in LDC_ARCHASOBANC.ARCHASOBANC_ID%type,
		orcLDC_ARCHASOBANC  out styLDC_ARCHASOBANC
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_ARCHASOBANC  out styLDC_ARCHASOBANC
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_ARCHASOBANC;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALDC_ARCHASOBANC
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_ARCHASOBANC';
	 cnuGeEntityId constant varchar2(30) := 55; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuARCHASOBANC_ID in LDC_ARCHASOBANC.ARCHASOBANC_ID%type
	)
	IS
		SELECT LDC_ARCHASOBANC.*,LDC_ARCHASOBANC.rowid
		FROM LDC_ARCHASOBANC
		WHERE  ARCHASOBANC_ID = inuARCHASOBANC_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_ARCHASOBANC.*,LDC_ARCHASOBANC.rowid
		FROM LDC_ARCHASOBANC
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_ARCHASOBANC is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_ARCHASOBANC;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_ARCHASOBANC default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.ARCHASOBANC_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuARCHASOBANC_ID in LDC_ARCHASOBANC.ARCHASOBANC_ID%type,
		orcLDC_ARCHASOBANC  out styLDC_ARCHASOBANC
	)
	IS
		rcError styLDC_ARCHASOBANC;
	BEGIN
		rcError.ARCHASOBANC_ID := inuARCHASOBANC_ID;

		Open cuLockRcByPk
		(
			inuARCHASOBANC_ID
		);

		fetch cuLockRcByPk into orcLDC_ARCHASOBANC;
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
		orcLDC_ARCHASOBANC  out styLDC_ARCHASOBANC
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_ARCHASOBANC;
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
		itbLDC_ARCHASOBANC  in out nocopy tytbLDC_ARCHASOBANC
	)
	IS
	BEGIN
			rcRecOfTab.DESCRIPTION.delete;
			rcRecOfTab.ARCHASOBANC_ID.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_ARCHASOBANC  in out nocopy tytbLDC_ARCHASOBANC,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_ARCHASOBANC);

		for n in itbLDC_ARCHASOBANC.first .. itbLDC_ARCHASOBANC.last loop
			rcRecOfTab.DESCRIPTION(n) := itbLDC_ARCHASOBANC(n).DESCRIPTION;
			rcRecOfTab.ARCHASOBANC_ID(n) := itbLDC_ARCHASOBANC(n).ARCHASOBANC_ID;
			rcRecOfTab.row_id(n) := itbLDC_ARCHASOBANC(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuARCHASOBANC_ID in LDC_ARCHASOBANC.ARCHASOBANC_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuARCHASOBANC_ID
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
		inuARCHASOBANC_ID in LDC_ARCHASOBANC.ARCHASOBANC_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuARCHASOBANC_ID = rcData.ARCHASOBANC_ID
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
		inuARCHASOBANC_ID in LDC_ARCHASOBANC.ARCHASOBANC_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuARCHASOBANC_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuARCHASOBANC_ID in LDC_ARCHASOBANC.ARCHASOBANC_ID%type
	)
	IS
		rcError styLDC_ARCHASOBANC;
	BEGIN		rcError.ARCHASOBANC_ID:=inuARCHASOBANC_ID;

		Load
		(
			inuARCHASOBANC_ID
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
		inuARCHASOBANC_ID in LDC_ARCHASOBANC.ARCHASOBANC_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuARCHASOBANC_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuARCHASOBANC_ID in LDC_ARCHASOBANC.ARCHASOBANC_ID%type,
		orcRecord out nocopy styLDC_ARCHASOBANC
	)
	IS
		rcError styLDC_ARCHASOBANC;
	BEGIN		rcError.ARCHASOBANC_ID:=inuARCHASOBANC_ID;

		Load
		(
			inuARCHASOBANC_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuARCHASOBANC_ID in LDC_ARCHASOBANC.ARCHASOBANC_ID%type
	)
	RETURN styLDC_ARCHASOBANC
	IS
		rcError styLDC_ARCHASOBANC;
	BEGIN
		rcError.ARCHASOBANC_ID:=inuARCHASOBANC_ID;

		Load
		(
			inuARCHASOBANC_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuARCHASOBANC_ID in LDC_ARCHASOBANC.ARCHASOBANC_ID%type
	)
	RETURN styLDC_ARCHASOBANC
	IS
		rcError styLDC_ARCHASOBANC;
	BEGIN
		rcError.ARCHASOBANC_ID:=inuARCHASOBANC_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuARCHASOBANC_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuARCHASOBANC_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_ARCHASOBANC
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_ARCHASOBANC
	)
	IS
		rfLDC_ARCHASOBANC tyrfLDC_ARCHASOBANC;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_ARCHASOBANC.*, LDC_ARCHASOBANC.rowid FROM LDC_ARCHASOBANC';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_ARCHASOBANC for sbFullQuery;

		fetch rfLDC_ARCHASOBANC bulk collect INTO otbResult;

		close rfLDC_ARCHASOBANC;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_ARCHASOBANC.*, LDC_ARCHASOBANC.rowid FROM LDC_ARCHASOBANC';
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
		ircLDC_ARCHASOBANC in styLDC_ARCHASOBANC
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_ARCHASOBANC,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_ARCHASOBANC in styLDC_ARCHASOBANC,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_ARCHASOBANC.ARCHASOBANC_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ARCHASOBANC_ID');
			raise ex.controlled_error;
		end if;

		insert into LDC_ARCHASOBANC
		(
			DESCRIPTION,
			ARCHASOBANC_ID
		)
		values
		(
			ircLDC_ARCHASOBANC.DESCRIPTION,
			ircLDC_ARCHASOBANC.ARCHASOBANC_ID
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_ARCHASOBANC));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_ARCHASOBANC in out nocopy tytbLDC_ARCHASOBANC
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_ARCHASOBANC,blUseRowID);
		forall n in iotbLDC_ARCHASOBANC.first..iotbLDC_ARCHASOBANC.last
			insert into LDC_ARCHASOBANC
			(
				DESCRIPTION,
				ARCHASOBANC_ID
			)
			values
			(
				rcRecOfTab.DESCRIPTION(n),
				rcRecOfTab.ARCHASOBANC_ID(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuARCHASOBANC_ID in LDC_ARCHASOBANC.ARCHASOBANC_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_ARCHASOBANC;
	BEGIN
		rcError.ARCHASOBANC_ID := inuARCHASOBANC_ID;

		if inuLock=1 then
			LockByPk
			(
				inuARCHASOBANC_ID,
				rcData
			);
		end if;


		delete
		from LDC_ARCHASOBANC
		where
       		ARCHASOBANC_ID=inuARCHASOBANC_ID;
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
		rcError  styLDC_ARCHASOBANC;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_ARCHASOBANC
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
		iotbLDC_ARCHASOBANC in out nocopy tytbLDC_ARCHASOBANC,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_ARCHASOBANC;
	BEGIN
		FillRecordOfTables(iotbLDC_ARCHASOBANC, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_ARCHASOBANC.first .. iotbLDC_ARCHASOBANC.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ARCHASOBANC.first .. iotbLDC_ARCHASOBANC.last
				delete
				from LDC_ARCHASOBANC
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_ARCHASOBANC.first .. iotbLDC_ARCHASOBANC.last loop
					LockByPk
					(
						rcRecOfTab.ARCHASOBANC_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ARCHASOBANC.first .. iotbLDC_ARCHASOBANC.last
				delete
				from LDC_ARCHASOBANC
				where
		         	ARCHASOBANC_ID = rcRecOfTab.ARCHASOBANC_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_ARCHASOBANC in styLDC_ARCHASOBANC,
		inuLock in number default 0
	)
	IS
		nuARCHASOBANC_ID	LDC_ARCHASOBANC.ARCHASOBANC_ID%type;
	BEGIN
		if ircLDC_ARCHASOBANC.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_ARCHASOBANC.rowid,rcData);
			end if;
			update LDC_ARCHASOBANC
			set
				DESCRIPTION = ircLDC_ARCHASOBANC.DESCRIPTION
			where
				rowid = ircLDC_ARCHASOBANC.rowid
			returning
				ARCHASOBANC_ID
			into
				nuARCHASOBANC_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_ARCHASOBANC.ARCHASOBANC_ID,
					rcData
				);
			end if;

			update LDC_ARCHASOBANC
			set
				DESCRIPTION = ircLDC_ARCHASOBANC.DESCRIPTION
			where
				ARCHASOBANC_ID = ircLDC_ARCHASOBANC.ARCHASOBANC_ID
			returning
				ARCHASOBANC_ID
			into
				nuARCHASOBANC_ID;
		end if;
		if
			nuARCHASOBANC_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_ARCHASOBANC));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_ARCHASOBANC in out nocopy tytbLDC_ARCHASOBANC,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_ARCHASOBANC;
	BEGIN
		FillRecordOfTables(iotbLDC_ARCHASOBANC,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_ARCHASOBANC.first .. iotbLDC_ARCHASOBANC.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ARCHASOBANC.first .. iotbLDC_ARCHASOBANC.last
				update LDC_ARCHASOBANC
				set
					DESCRIPTION = rcRecOfTab.DESCRIPTION(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_ARCHASOBANC.first .. iotbLDC_ARCHASOBANC.last loop
					LockByPk
					(
						rcRecOfTab.ARCHASOBANC_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ARCHASOBANC.first .. iotbLDC_ARCHASOBANC.last
				update LDC_ARCHASOBANC
				SET
					DESCRIPTION = rcRecOfTab.DESCRIPTION(n)
				where
					ARCHASOBANC_ID = rcRecOfTab.ARCHASOBANC_ID(n)
;
		end if;
	END;
	PROCEDURE updDESCRIPTION
	(
		inuARCHASOBANC_ID in LDC_ARCHASOBANC.ARCHASOBANC_ID%type,
		isbDESCRIPTION$ in LDC_ARCHASOBANC.DESCRIPTION%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ARCHASOBANC;
	BEGIN
		rcError.ARCHASOBANC_ID := inuARCHASOBANC_ID;
		if inuLock=1 then
			LockByPk
			(
				inuARCHASOBANC_ID,
				rcData
			);
		end if;

		update LDC_ARCHASOBANC
		set
			DESCRIPTION = isbDESCRIPTION$
		where
			ARCHASOBANC_ID = inuARCHASOBANC_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DESCRIPTION:= isbDESCRIPTION$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fsbGetDESCRIPTION
	(
		inuARCHASOBANC_ID in LDC_ARCHASOBANC.ARCHASOBANC_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ARCHASOBANC.DESCRIPTION%type
	IS
		rcError styLDC_ARCHASOBANC;
	BEGIN

		rcError.ARCHASOBANC_ID := inuARCHASOBANC_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuARCHASOBANC_ID
			 )
		then
			 return(rcData.DESCRIPTION);
		end if;
		Load
		(
		 		inuARCHASOBANC_ID
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
		inuARCHASOBANC_ID in LDC_ARCHASOBANC.ARCHASOBANC_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ARCHASOBANC.ARCHASOBANC_ID%type
	IS
		rcError styLDC_ARCHASOBANC;
	BEGIN

		rcError.ARCHASOBANC_ID := inuARCHASOBANC_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuARCHASOBANC_ID
			 )
		then
			 return(rcData.ARCHASOBANC_ID);
		end if;
		Load
		(
		 		inuARCHASOBANC_ID
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
	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	) IS
	Begin
	    blDAO_USE_CACHE := iblUseCache;
	END;

begin
    GetDAO_USE_CACHE;
end DALDC_ARCHASOBANC;
/
PROMPT Otorgando permisos de ejecucion a DALDC_ARCHASOBANC
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_ARCHASOBANC', 'ADM_PERSON');
END;
/