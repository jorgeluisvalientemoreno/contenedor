CREATE OR REPLACE PACKAGE ADM_PERSON.DALDC_FNB_COMMENT
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
    04/05/2024              PAcosta         OSF-2776: Cambio de esquema ADM_PERSON                              
    ****************************************************************/
    
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuCOMMENT_ID in LDC_FNB_COMMENT.COMMENT_ID%type
	)
	IS
		SELECT LDC_FNB_COMMENT.*,LDC_FNB_COMMENT.rowid
		FROM LDC_FNB_COMMENT
		WHERE
		    COMMENT_ID = inuCOMMENT_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_FNB_COMMENT.*,LDC_FNB_COMMENT.rowid
		FROM LDC_FNB_COMMENT
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_FNB_COMMENT  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_FNB_COMMENT is table of styLDC_FNB_COMMENT index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_FNB_COMMENT;

	/* Tipos referenciando al registro */
	type tytbCOMMENT_ID is table of LDC_FNB_COMMENT.COMMENT_ID%type index by binary_integer;
	type tytbREGISTER_DATE is table of LDC_FNB_COMMENT.REGISTER_DATE%type index by binary_integer;
	type tytbSALE_COMMENT is table of LDC_FNB_COMMENT.SALE_COMMENT%type index by binary_integer;
	type tytbPACKAGE_ID is table of LDC_FNB_COMMENT.PACKAGE_ID%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_FNB_COMMENT is record
	(
		COMMENT_ID   tytbCOMMENT_ID,
		REGISTER_DATE   tytbREGISTER_DATE,
		SALE_COMMENT   tytbSALE_COMMENT,
		PACKAGE_ID   tytbPACKAGE_ID,
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
		inuCOMMENT_ID in LDC_FNB_COMMENT.COMMENT_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuCOMMENT_ID in LDC_FNB_COMMENT.COMMENT_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuCOMMENT_ID in LDC_FNB_COMMENT.COMMENT_ID%type
	);

	PROCEDURE getRecord
	(
		inuCOMMENT_ID in LDC_FNB_COMMENT.COMMENT_ID%type,
		orcRecord out nocopy styLDC_FNB_COMMENT
	);

	FUNCTION frcGetRcData
	(
		inuCOMMENT_ID in LDC_FNB_COMMENT.COMMENT_ID%type
	)
	RETURN styLDC_FNB_COMMENT;

	FUNCTION frcGetRcData
	RETURN styLDC_FNB_COMMENT;

	FUNCTION frcGetRecord
	(
		inuCOMMENT_ID in LDC_FNB_COMMENT.COMMENT_ID%type
	)
	RETURN styLDC_FNB_COMMENT;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_FNB_COMMENT
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_FNB_COMMENT in styLDC_FNB_COMMENT
	);

	PROCEDURE insRecord
	(
		ircLDC_FNB_COMMENT in styLDC_FNB_COMMENT,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_FNB_COMMENT in out nocopy tytbLDC_FNB_COMMENT
	);

	PROCEDURE delRecord
	(
		inuCOMMENT_ID in LDC_FNB_COMMENT.COMMENT_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_FNB_COMMENT in out nocopy tytbLDC_FNB_COMMENT,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_FNB_COMMENT in styLDC_FNB_COMMENT,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_FNB_COMMENT in out nocopy tytbLDC_FNB_COMMENT,
		inuLock in number default 1
	);

	PROCEDURE updREGISTER_DATE
	(
		inuCOMMENT_ID in LDC_FNB_COMMENT.COMMENT_ID%type,
		idtREGISTER_DATE$ in LDC_FNB_COMMENT.REGISTER_DATE%type,
		inuLock in number default 0
	);

	PROCEDURE updSALE_COMMENT
	(
		inuCOMMENT_ID in LDC_FNB_COMMENT.COMMENT_ID%type,
		isbSALE_COMMENT$ in LDC_FNB_COMMENT.SALE_COMMENT%type,
		inuLock in number default 0
	);

	PROCEDURE updPACKAGE_ID
	(
		inuCOMMENT_ID in LDC_FNB_COMMENT.COMMENT_ID%type,
		inuPACKAGE_ID$ in LDC_FNB_COMMENT.PACKAGE_ID%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetCOMMENT_ID
	(
		inuCOMMENT_ID in LDC_FNB_COMMENT.COMMENT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_FNB_COMMENT.COMMENT_ID%type;

	FUNCTION fdtGetREGISTER_DATE
	(
		inuCOMMENT_ID in LDC_FNB_COMMENT.COMMENT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_FNB_COMMENT.REGISTER_DATE%type;

	FUNCTION fsbGetSALE_COMMENT
	(
		inuCOMMENT_ID in LDC_FNB_COMMENT.COMMENT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_FNB_COMMENT.SALE_COMMENT%type;

	FUNCTION fnuGetPACKAGE_ID
	(
		inuCOMMENT_ID in LDC_FNB_COMMENT.COMMENT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_FNB_COMMENT.PACKAGE_ID%type;


	PROCEDURE LockByPk
	(
		inuCOMMENT_ID in LDC_FNB_COMMENT.COMMENT_ID%type,
		orcLDC_FNB_COMMENT  out styLDC_FNB_COMMENT
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_FNB_COMMENT  out styLDC_FNB_COMMENT
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_FNB_COMMENT;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALDC_FNB_COMMENT
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'RNP54';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_FNB_COMMENT';
	  cnuGeEntityId constant varchar2(30) := 507; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuCOMMENT_ID in LDC_FNB_COMMENT.COMMENT_ID%type
	)
	IS
		SELECT LDC_FNB_COMMENT.*,LDC_FNB_COMMENT.rowid
		FROM LDC_FNB_COMMENT
		WHERE  COMMENT_ID = inuCOMMENT_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_FNB_COMMENT.*,LDC_FNB_COMMENT.rowid
		FROM LDC_FNB_COMMENT
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_FNB_COMMENT is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_FNB_COMMENT;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_FNB_COMMENT default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.COMMENT_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuCOMMENT_ID in LDC_FNB_COMMENT.COMMENT_ID%type,
		orcLDC_FNB_COMMENT  out styLDC_FNB_COMMENT
	)
	IS
		rcError styLDC_FNB_COMMENT;
	BEGIN
		rcError.COMMENT_ID := inuCOMMENT_ID;

		Open cuLockRcByPk
		(
			inuCOMMENT_ID
		);

		fetch cuLockRcByPk into orcLDC_FNB_COMMENT;
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
		orcLDC_FNB_COMMENT  out styLDC_FNB_COMMENT
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_FNB_COMMENT;
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
		itbLDC_FNB_COMMENT  in out nocopy tytbLDC_FNB_COMMENT
	)
	IS
	BEGIN
			rcRecOfTab.COMMENT_ID.delete;
			rcRecOfTab.REGISTER_DATE.delete;
			rcRecOfTab.SALE_COMMENT.delete;
			rcRecOfTab.PACKAGE_ID.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_FNB_COMMENT  in out nocopy tytbLDC_FNB_COMMENT,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_FNB_COMMENT);

		for n in itbLDC_FNB_COMMENT.first .. itbLDC_FNB_COMMENT.last loop
			rcRecOfTab.COMMENT_ID(n) := itbLDC_FNB_COMMENT(n).COMMENT_ID;
			rcRecOfTab.REGISTER_DATE(n) := itbLDC_FNB_COMMENT(n).REGISTER_DATE;
			rcRecOfTab.SALE_COMMENT(n) := itbLDC_FNB_COMMENT(n).SALE_COMMENT;
			rcRecOfTab.PACKAGE_ID(n) := itbLDC_FNB_COMMENT(n).PACKAGE_ID;
			rcRecOfTab.row_id(n) := itbLDC_FNB_COMMENT(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuCOMMENT_ID in LDC_FNB_COMMENT.COMMENT_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuCOMMENT_ID
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
		inuCOMMENT_ID in LDC_FNB_COMMENT.COMMENT_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuCOMMENT_ID = rcData.COMMENT_ID
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
		inuCOMMENT_ID in LDC_FNB_COMMENT.COMMENT_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuCOMMENT_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuCOMMENT_ID in LDC_FNB_COMMENT.COMMENT_ID%type
	)
	IS
		rcError styLDC_FNB_COMMENT;
	BEGIN		rcError.COMMENT_ID:=inuCOMMENT_ID;

		Load
		(
			inuCOMMENT_ID
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
		inuCOMMENT_ID in LDC_FNB_COMMENT.COMMENT_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuCOMMENT_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuCOMMENT_ID in LDC_FNB_COMMENT.COMMENT_ID%type,
		orcRecord out nocopy styLDC_FNB_COMMENT
	)
	IS
		rcError styLDC_FNB_COMMENT;
	BEGIN		rcError.COMMENT_ID:=inuCOMMENT_ID;

		Load
		(
			inuCOMMENT_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuCOMMENT_ID in LDC_FNB_COMMENT.COMMENT_ID%type
	)
	RETURN styLDC_FNB_COMMENT
	IS
		rcError styLDC_FNB_COMMENT;
	BEGIN
		rcError.COMMENT_ID:=inuCOMMENT_ID;

		Load
		(
			inuCOMMENT_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuCOMMENT_ID in LDC_FNB_COMMENT.COMMENT_ID%type
	)
	RETURN styLDC_FNB_COMMENT
	IS
		rcError styLDC_FNB_COMMENT;
	BEGIN
		rcError.COMMENT_ID:=inuCOMMENT_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuCOMMENT_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuCOMMENT_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_FNB_COMMENT
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_FNB_COMMENT
	)
	IS
		rfLDC_FNB_COMMENT tyrfLDC_FNB_COMMENT;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_FNB_COMMENT.*, LDC_FNB_COMMENT.rowid FROM LDC_FNB_COMMENT';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_FNB_COMMENT for sbFullQuery;

		fetch rfLDC_FNB_COMMENT bulk collect INTO otbResult;

		close rfLDC_FNB_COMMENT;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_FNB_COMMENT.*, LDC_FNB_COMMENT.rowid FROM LDC_FNB_COMMENT';
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
		ircLDC_FNB_COMMENT in styLDC_FNB_COMMENT
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_FNB_COMMENT,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_FNB_COMMENT in styLDC_FNB_COMMENT,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_FNB_COMMENT.COMMENT_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|COMMENT_ID');
			raise ex.controlled_error;
		end if;

		insert into LDC_FNB_COMMENT
		(
			COMMENT_ID,
			REGISTER_DATE,
			SALE_COMMENT,
			PACKAGE_ID
		)
		values
		(
			ircLDC_FNB_COMMENT.COMMENT_ID,
			ircLDC_FNB_COMMENT.REGISTER_DATE,
			ircLDC_FNB_COMMENT.SALE_COMMENT,
			ircLDC_FNB_COMMENT.PACKAGE_ID
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_FNB_COMMENT));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_FNB_COMMENT in out nocopy tytbLDC_FNB_COMMENT
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_FNB_COMMENT,blUseRowID);
		forall n in iotbLDC_FNB_COMMENT.first..iotbLDC_FNB_COMMENT.last
			insert into LDC_FNB_COMMENT
			(
				COMMENT_ID,
				REGISTER_DATE,
				SALE_COMMENT,
				PACKAGE_ID
			)
			values
			(
				rcRecOfTab.COMMENT_ID(n),
				rcRecOfTab.REGISTER_DATE(n),
				rcRecOfTab.SALE_COMMENT(n),
				rcRecOfTab.PACKAGE_ID(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuCOMMENT_ID in LDC_FNB_COMMENT.COMMENT_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_FNB_COMMENT;
	BEGIN
		rcError.COMMENT_ID := inuCOMMENT_ID;

		if inuLock=1 then
			LockByPk
			(
				inuCOMMENT_ID,
				rcData
			);
		end if;


		delete
		from LDC_FNB_COMMENT
		where
       		COMMENT_ID=inuCOMMENT_ID;
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
		rcError  styLDC_FNB_COMMENT;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_FNB_COMMENT
		where
			rowid = iriRowID
		returning
			COMMENT_ID
		into
			rcError.COMMENT_ID;
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
		iotbLDC_FNB_COMMENT in out nocopy tytbLDC_FNB_COMMENT,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_FNB_COMMENT;
	BEGIN
		FillRecordOfTables(iotbLDC_FNB_COMMENT, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_FNB_COMMENT.first .. iotbLDC_FNB_COMMENT.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_FNB_COMMENT.first .. iotbLDC_FNB_COMMENT.last
				delete
				from LDC_FNB_COMMENT
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_FNB_COMMENT.first .. iotbLDC_FNB_COMMENT.last loop
					LockByPk
					(
						rcRecOfTab.COMMENT_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_FNB_COMMENT.first .. iotbLDC_FNB_COMMENT.last
				delete
				from LDC_FNB_COMMENT
				where
		         	COMMENT_ID = rcRecOfTab.COMMENT_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_FNB_COMMENT in styLDC_FNB_COMMENT,
		inuLock in number default 0
	)
	IS
		nuCOMMENT_ID	LDC_FNB_COMMENT.COMMENT_ID%type;
	BEGIN
		if ircLDC_FNB_COMMENT.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_FNB_COMMENT.rowid,rcData);
			end if;
			update LDC_FNB_COMMENT
			set
				REGISTER_DATE = ircLDC_FNB_COMMENT.REGISTER_DATE,
				SALE_COMMENT = ircLDC_FNB_COMMENT.SALE_COMMENT,
				PACKAGE_ID = ircLDC_FNB_COMMENT.PACKAGE_ID
			where
				rowid = ircLDC_FNB_COMMENT.rowid
			returning
				COMMENT_ID
			into
				nuCOMMENT_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_FNB_COMMENT.COMMENT_ID,
					rcData
				);
			end if;

			update LDC_FNB_COMMENT
			set
				REGISTER_DATE = ircLDC_FNB_COMMENT.REGISTER_DATE,
				SALE_COMMENT = ircLDC_FNB_COMMENT.SALE_COMMENT,
				PACKAGE_ID = ircLDC_FNB_COMMENT.PACKAGE_ID
			where
				COMMENT_ID = ircLDC_FNB_COMMENT.COMMENT_ID
			returning
				COMMENT_ID
			into
				nuCOMMENT_ID;
		end if;
		if
			nuCOMMENT_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_FNB_COMMENT));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_FNB_COMMENT in out nocopy tytbLDC_FNB_COMMENT,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_FNB_COMMENT;
	BEGIN
		FillRecordOfTables(iotbLDC_FNB_COMMENT,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_FNB_COMMENT.first .. iotbLDC_FNB_COMMENT.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_FNB_COMMENT.first .. iotbLDC_FNB_COMMENT.last
				update LDC_FNB_COMMENT
				set
					REGISTER_DATE = rcRecOfTab.REGISTER_DATE(n),
					SALE_COMMENT = rcRecOfTab.SALE_COMMENT(n),
					PACKAGE_ID = rcRecOfTab.PACKAGE_ID(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_FNB_COMMENT.first .. iotbLDC_FNB_COMMENT.last loop
					LockByPk
					(
						rcRecOfTab.COMMENT_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_FNB_COMMENT.first .. iotbLDC_FNB_COMMENT.last
				update LDC_FNB_COMMENT
				SET
					REGISTER_DATE = rcRecOfTab.REGISTER_DATE(n),
					SALE_COMMENT = rcRecOfTab.SALE_COMMENT(n),
					PACKAGE_ID = rcRecOfTab.PACKAGE_ID(n)
				where
					COMMENT_ID = rcRecOfTab.COMMENT_ID(n)
;
		end if;
	END;
	PROCEDURE updREGISTER_DATE
	(
		inuCOMMENT_ID in LDC_FNB_COMMENT.COMMENT_ID%type,
		idtREGISTER_DATE$ in LDC_FNB_COMMENT.REGISTER_DATE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_FNB_COMMENT;
	BEGIN
		rcError.COMMENT_ID := inuCOMMENT_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCOMMENT_ID,
				rcData
			);
		end if;

		update LDC_FNB_COMMENT
		set
			REGISTER_DATE = idtREGISTER_DATE$
		where
			COMMENT_ID = inuCOMMENT_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.REGISTER_DATE:= idtREGISTER_DATE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSALE_COMMENT
	(
		inuCOMMENT_ID in LDC_FNB_COMMENT.COMMENT_ID%type,
		isbSALE_COMMENT$ in LDC_FNB_COMMENT.SALE_COMMENT%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_FNB_COMMENT;
	BEGIN
		rcError.COMMENT_ID := inuCOMMENT_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCOMMENT_ID,
				rcData
			);
		end if;

		update LDC_FNB_COMMENT
		set
			SALE_COMMENT = isbSALE_COMMENT$
		where
			COMMENT_ID = inuCOMMENT_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SALE_COMMENT:= isbSALE_COMMENT$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPACKAGE_ID
	(
		inuCOMMENT_ID in LDC_FNB_COMMENT.COMMENT_ID%type,
		inuPACKAGE_ID$ in LDC_FNB_COMMENT.PACKAGE_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_FNB_COMMENT;
	BEGIN
		rcError.COMMENT_ID := inuCOMMENT_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCOMMENT_ID,
				rcData
			);
		end if;

		update LDC_FNB_COMMENT
		set
			PACKAGE_ID = inuPACKAGE_ID$
		where
			COMMENT_ID = inuCOMMENT_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PACKAGE_ID:= inuPACKAGE_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetCOMMENT_ID
	(
		inuCOMMENT_ID in LDC_FNB_COMMENT.COMMENT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_FNB_COMMENT.COMMENT_ID%type
	IS
		rcError styLDC_FNB_COMMENT;
	BEGIN

		rcError.COMMENT_ID := inuCOMMENT_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCOMMENT_ID
			 )
		then
			 return(rcData.COMMENT_ID);
		end if;
		Load
		(
		 		inuCOMMENT_ID
		);
		return(rcData.COMMENT_ID);
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
		inuCOMMENT_ID in LDC_FNB_COMMENT.COMMENT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_FNB_COMMENT.REGISTER_DATE%type
	IS
		rcError styLDC_FNB_COMMENT;
	BEGIN

		rcError.COMMENT_ID := inuCOMMENT_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCOMMENT_ID
			 )
		then
			 return(rcData.REGISTER_DATE);
		end if;
		Load
		(
		 		inuCOMMENT_ID
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
	FUNCTION fsbGetSALE_COMMENT
	(
		inuCOMMENT_ID in LDC_FNB_COMMENT.COMMENT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_FNB_COMMENT.SALE_COMMENT%type
	IS
		rcError styLDC_FNB_COMMENT;
	BEGIN

		rcError.COMMENT_ID := inuCOMMENT_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCOMMENT_ID
			 )
		then
			 return(rcData.SALE_COMMENT);
		end if;
		Load
		(
		 		inuCOMMENT_ID
		);
		return(rcData.SALE_COMMENT);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetPACKAGE_ID
	(
		inuCOMMENT_ID in LDC_FNB_COMMENT.COMMENT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_FNB_COMMENT.PACKAGE_ID%type
	IS
		rcError styLDC_FNB_COMMENT;
	BEGIN

		rcError.COMMENT_ID := inuCOMMENT_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCOMMENT_ID
			 )
		then
			 return(rcData.PACKAGE_ID);
		end if;
		Load
		(
		 		inuCOMMENT_ID
		);
		return(rcData.PACKAGE_ID);
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
end DALDC_FNB_COMMENT;
/
PROMPT Otorgando permisos de ejecucion a DALDC_FNB_COMMENT
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_FNB_COMMENT', 'ADM_PERSON');
END;
/