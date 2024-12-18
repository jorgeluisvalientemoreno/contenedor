CREATE OR REPLACE PACKAGE ADM_PERSON.DALDC_PROMO_FNB
is
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     : DALDC_PROMO_FNB
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
		inuPROMO_FNB_ID in LDC_PROMO_FNB.PROMO_FNB_ID%type
	)
	IS
		SELECT LDC_PROMO_FNB.*,LDC_PROMO_FNB.rowid
		FROM LDC_PROMO_FNB
		WHERE
		    PROMO_FNB_ID = inuPROMO_FNB_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_PROMO_FNB.*,LDC_PROMO_FNB.rowid
		FROM LDC_PROMO_FNB
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_PROMO_FNB  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_PROMO_FNB is table of styLDC_PROMO_FNB index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_PROMO_FNB;

	/* Tipos referenciando al registro */
	type tytbPROMO_FNB_ID is table of LDC_PROMO_FNB.PROMO_FNB_ID%type index by binary_integer;
	type tytbSUBLINE_ID is table of LDC_PROMO_FNB.SUBLINE_ID%type index by binary_integer;
	type tytbINITIAL_DATE is table of LDC_PROMO_FNB.INITIAL_DATE%type index by binary_integer;
	type tytbFINAL_DATE is table of LDC_PROMO_FNB.FINAL_DATE%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_PROMO_FNB is record
	(
		PROMO_FNB_ID   tytbPROMO_FNB_ID,
		SUBLINE_ID   tytbSUBLINE_ID,
		INITIAL_DATE   tytbINITIAL_DATE,
		FINAL_DATE   tytbFINAL_DATE,
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
		inuPROMO_FNB_ID in LDC_PROMO_FNB.PROMO_FNB_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuPROMO_FNB_ID in LDC_PROMO_FNB.PROMO_FNB_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuPROMO_FNB_ID in LDC_PROMO_FNB.PROMO_FNB_ID%type
	);

	PROCEDURE getRecord
	(
		inuPROMO_FNB_ID in LDC_PROMO_FNB.PROMO_FNB_ID%type,
		orcRecord out nocopy styLDC_PROMO_FNB
	);

	FUNCTION frcGetRcData
	(
		inuPROMO_FNB_ID in LDC_PROMO_FNB.PROMO_FNB_ID%type
	)
	RETURN styLDC_PROMO_FNB;

	FUNCTION frcGetRcData
	RETURN styLDC_PROMO_FNB;

	FUNCTION frcGetRecord
	(
		inuPROMO_FNB_ID in LDC_PROMO_FNB.PROMO_FNB_ID%type
	)
	RETURN styLDC_PROMO_FNB;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_PROMO_FNB
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_PROMO_FNB in styLDC_PROMO_FNB
	);

	PROCEDURE insRecord
	(
		ircLDC_PROMO_FNB in styLDC_PROMO_FNB,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_PROMO_FNB in out nocopy tytbLDC_PROMO_FNB
	);

	PROCEDURE delRecord
	(
		inuPROMO_FNB_ID in LDC_PROMO_FNB.PROMO_FNB_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_PROMO_FNB in out nocopy tytbLDC_PROMO_FNB,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_PROMO_FNB in styLDC_PROMO_FNB,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_PROMO_FNB in out nocopy tytbLDC_PROMO_FNB,
		inuLock in number default 1
	);

	PROCEDURE updSUBLINE_ID
	(
		inuPROMO_FNB_ID in LDC_PROMO_FNB.PROMO_FNB_ID%type,
		inuSUBLINE_ID$ in LDC_PROMO_FNB.SUBLINE_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updINITIAL_DATE
	(
		inuPROMO_FNB_ID in LDC_PROMO_FNB.PROMO_FNB_ID%type,
		idtINITIAL_DATE$ in LDC_PROMO_FNB.INITIAL_DATE%type,
		inuLock in number default 0
	);

	PROCEDURE updFINAL_DATE
	(
		inuPROMO_FNB_ID in LDC_PROMO_FNB.PROMO_FNB_ID%type,
		idtFINAL_DATE$ in LDC_PROMO_FNB.FINAL_DATE%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetPROMO_FNB_ID
	(
		inuPROMO_FNB_ID in LDC_PROMO_FNB.PROMO_FNB_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROMO_FNB.PROMO_FNB_ID%type;

	FUNCTION fnuGetSUBLINE_ID
	(
		inuPROMO_FNB_ID in LDC_PROMO_FNB.PROMO_FNB_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROMO_FNB.SUBLINE_ID%type;

	FUNCTION fdtGetINITIAL_DATE
	(
		inuPROMO_FNB_ID in LDC_PROMO_FNB.PROMO_FNB_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROMO_FNB.INITIAL_DATE%type;

	FUNCTION fdtGetFINAL_DATE
	(
		inuPROMO_FNB_ID in LDC_PROMO_FNB.PROMO_FNB_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROMO_FNB.FINAL_DATE%type;


	PROCEDURE LockByPk
	(
		inuPROMO_FNB_ID in LDC_PROMO_FNB.PROMO_FNB_ID%type,
		orcLDC_PROMO_FNB  out styLDC_PROMO_FNB
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_PROMO_FNB  out styLDC_PROMO_FNB
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_PROMO_FNB;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALDC_PROMO_FNB
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_PROMO_FNB';
	 cnuGeEntityId constant varchar2(30) := 8793; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuPROMO_FNB_ID in LDC_PROMO_FNB.PROMO_FNB_ID%type
	)
	IS
		SELECT LDC_PROMO_FNB.*,LDC_PROMO_FNB.rowid
		FROM LDC_PROMO_FNB
		WHERE  PROMO_FNB_ID = inuPROMO_FNB_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_PROMO_FNB.*,LDC_PROMO_FNB.rowid
		FROM LDC_PROMO_FNB
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_PROMO_FNB is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_PROMO_FNB;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_PROMO_FNB default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.PROMO_FNB_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuPROMO_FNB_ID in LDC_PROMO_FNB.PROMO_FNB_ID%type,
		orcLDC_PROMO_FNB  out styLDC_PROMO_FNB
	)
	IS
		rcError styLDC_PROMO_FNB;
	BEGIN
		rcError.PROMO_FNB_ID := inuPROMO_FNB_ID;

		Open cuLockRcByPk
		(
			inuPROMO_FNB_ID
		);

		fetch cuLockRcByPk into orcLDC_PROMO_FNB;
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
		orcLDC_PROMO_FNB  out styLDC_PROMO_FNB
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_PROMO_FNB;
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
		itbLDC_PROMO_FNB  in out nocopy tytbLDC_PROMO_FNB
	)
	IS
	BEGIN
			rcRecOfTab.PROMO_FNB_ID.delete;
			rcRecOfTab.SUBLINE_ID.delete;
			rcRecOfTab.INITIAL_DATE.delete;
			rcRecOfTab.FINAL_DATE.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_PROMO_FNB  in out nocopy tytbLDC_PROMO_FNB,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_PROMO_FNB);

		for n in itbLDC_PROMO_FNB.first .. itbLDC_PROMO_FNB.last loop
			rcRecOfTab.PROMO_FNB_ID(n) := itbLDC_PROMO_FNB(n).PROMO_FNB_ID;
			rcRecOfTab.SUBLINE_ID(n) := itbLDC_PROMO_FNB(n).SUBLINE_ID;
			rcRecOfTab.INITIAL_DATE(n) := itbLDC_PROMO_FNB(n).INITIAL_DATE;
			rcRecOfTab.FINAL_DATE(n) := itbLDC_PROMO_FNB(n).FINAL_DATE;
			rcRecOfTab.row_id(n) := itbLDC_PROMO_FNB(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuPROMO_FNB_ID in LDC_PROMO_FNB.PROMO_FNB_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuPROMO_FNB_ID
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
		inuPROMO_FNB_ID in LDC_PROMO_FNB.PROMO_FNB_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuPROMO_FNB_ID = rcData.PROMO_FNB_ID
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
		inuPROMO_FNB_ID in LDC_PROMO_FNB.PROMO_FNB_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuPROMO_FNB_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuPROMO_FNB_ID in LDC_PROMO_FNB.PROMO_FNB_ID%type
	)
	IS
		rcError styLDC_PROMO_FNB;
	BEGIN		rcError.PROMO_FNB_ID:=inuPROMO_FNB_ID;

		Load
		(
			inuPROMO_FNB_ID
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
		inuPROMO_FNB_ID in LDC_PROMO_FNB.PROMO_FNB_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuPROMO_FNB_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuPROMO_FNB_ID in LDC_PROMO_FNB.PROMO_FNB_ID%type,
		orcRecord out nocopy styLDC_PROMO_FNB
	)
	IS
		rcError styLDC_PROMO_FNB;
	BEGIN		rcError.PROMO_FNB_ID:=inuPROMO_FNB_ID;

		Load
		(
			inuPROMO_FNB_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuPROMO_FNB_ID in LDC_PROMO_FNB.PROMO_FNB_ID%type
	)
	RETURN styLDC_PROMO_FNB
	IS
		rcError styLDC_PROMO_FNB;
	BEGIN
		rcError.PROMO_FNB_ID:=inuPROMO_FNB_ID;

		Load
		(
			inuPROMO_FNB_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuPROMO_FNB_ID in LDC_PROMO_FNB.PROMO_FNB_ID%type
	)
	RETURN styLDC_PROMO_FNB
	IS
		rcError styLDC_PROMO_FNB;
	BEGIN
		rcError.PROMO_FNB_ID:=inuPROMO_FNB_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuPROMO_FNB_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuPROMO_FNB_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_PROMO_FNB
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_PROMO_FNB
	)
	IS
		rfLDC_PROMO_FNB tyrfLDC_PROMO_FNB;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_PROMO_FNB.*, LDC_PROMO_FNB.rowid FROM LDC_PROMO_FNB';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_PROMO_FNB for sbFullQuery;

		fetch rfLDC_PROMO_FNB bulk collect INTO otbResult;

		close rfLDC_PROMO_FNB;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_PROMO_FNB.*, LDC_PROMO_FNB.rowid FROM LDC_PROMO_FNB';
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
		ircLDC_PROMO_FNB in styLDC_PROMO_FNB
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_PROMO_FNB,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_PROMO_FNB in styLDC_PROMO_FNB,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_PROMO_FNB.PROMO_FNB_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|PROMO_FNB_ID');
			raise ex.controlled_error;
		end if;

		insert into LDC_PROMO_FNB
		(
			PROMO_FNB_ID,
			SUBLINE_ID,
			INITIAL_DATE,
			FINAL_DATE
		)
		values
		(
			ircLDC_PROMO_FNB.PROMO_FNB_ID,
			ircLDC_PROMO_FNB.SUBLINE_ID,
			ircLDC_PROMO_FNB.INITIAL_DATE,
			ircLDC_PROMO_FNB.FINAL_DATE
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_PROMO_FNB));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_PROMO_FNB in out nocopy tytbLDC_PROMO_FNB
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_PROMO_FNB,blUseRowID);
		forall n in iotbLDC_PROMO_FNB.first..iotbLDC_PROMO_FNB.last
			insert into LDC_PROMO_FNB
			(
				PROMO_FNB_ID,
				SUBLINE_ID,
				INITIAL_DATE,
				FINAL_DATE
			)
			values
			(
				rcRecOfTab.PROMO_FNB_ID(n),
				rcRecOfTab.SUBLINE_ID(n),
				rcRecOfTab.INITIAL_DATE(n),
				rcRecOfTab.FINAL_DATE(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuPROMO_FNB_ID in LDC_PROMO_FNB.PROMO_FNB_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_PROMO_FNB;
	BEGIN
		rcError.PROMO_FNB_ID := inuPROMO_FNB_ID;

		if inuLock=1 then
			LockByPk
			(
				inuPROMO_FNB_ID,
				rcData
			);
		end if;


		delete
		from LDC_PROMO_FNB
		where
       		PROMO_FNB_ID=inuPROMO_FNB_ID;
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
		rcError  styLDC_PROMO_FNB;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_PROMO_FNB
		where
			rowid = iriRowID
		returning
			PROMO_FNB_ID
		into
			rcError.PROMO_FNB_ID;
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
		iotbLDC_PROMO_FNB in out nocopy tytbLDC_PROMO_FNB,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_PROMO_FNB;
	BEGIN
		FillRecordOfTables(iotbLDC_PROMO_FNB, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_PROMO_FNB.first .. iotbLDC_PROMO_FNB.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_PROMO_FNB.first .. iotbLDC_PROMO_FNB.last
				delete
				from LDC_PROMO_FNB
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_PROMO_FNB.first .. iotbLDC_PROMO_FNB.last loop
					LockByPk
					(
						rcRecOfTab.PROMO_FNB_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_PROMO_FNB.first .. iotbLDC_PROMO_FNB.last
				delete
				from LDC_PROMO_FNB
				where
		         	PROMO_FNB_ID = rcRecOfTab.PROMO_FNB_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_PROMO_FNB in styLDC_PROMO_FNB,
		inuLock in number default 0
	)
	IS
		nuPROMO_FNB_ID	LDC_PROMO_FNB.PROMO_FNB_ID%type;
	BEGIN
		if ircLDC_PROMO_FNB.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_PROMO_FNB.rowid,rcData);
			end if;
			update LDC_PROMO_FNB
			set
				SUBLINE_ID = ircLDC_PROMO_FNB.SUBLINE_ID,
				INITIAL_DATE = ircLDC_PROMO_FNB.INITIAL_DATE,
				FINAL_DATE = ircLDC_PROMO_FNB.FINAL_DATE
			where
				rowid = ircLDC_PROMO_FNB.rowid
			returning
				PROMO_FNB_ID
			into
				nuPROMO_FNB_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_PROMO_FNB.PROMO_FNB_ID,
					rcData
				);
			end if;

			update LDC_PROMO_FNB
			set
				SUBLINE_ID = ircLDC_PROMO_FNB.SUBLINE_ID,
				INITIAL_DATE = ircLDC_PROMO_FNB.INITIAL_DATE,
				FINAL_DATE = ircLDC_PROMO_FNB.FINAL_DATE
			where
				PROMO_FNB_ID = ircLDC_PROMO_FNB.PROMO_FNB_ID
			returning
				PROMO_FNB_ID
			into
				nuPROMO_FNB_ID;
		end if;
		if
			nuPROMO_FNB_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_PROMO_FNB));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_PROMO_FNB in out nocopy tytbLDC_PROMO_FNB,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_PROMO_FNB;
	BEGIN
		FillRecordOfTables(iotbLDC_PROMO_FNB,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_PROMO_FNB.first .. iotbLDC_PROMO_FNB.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_PROMO_FNB.first .. iotbLDC_PROMO_FNB.last
				update LDC_PROMO_FNB
				set
					SUBLINE_ID = rcRecOfTab.SUBLINE_ID(n),
					INITIAL_DATE = rcRecOfTab.INITIAL_DATE(n),
					FINAL_DATE = rcRecOfTab.FINAL_DATE(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_PROMO_FNB.first .. iotbLDC_PROMO_FNB.last loop
					LockByPk
					(
						rcRecOfTab.PROMO_FNB_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_PROMO_FNB.first .. iotbLDC_PROMO_FNB.last
				update LDC_PROMO_FNB
				SET
					SUBLINE_ID = rcRecOfTab.SUBLINE_ID(n),
					INITIAL_DATE = rcRecOfTab.INITIAL_DATE(n),
					FINAL_DATE = rcRecOfTab.FINAL_DATE(n)
				where
					PROMO_FNB_ID = rcRecOfTab.PROMO_FNB_ID(n)
;
		end if;
	END;
	PROCEDURE updSUBLINE_ID
	(
		inuPROMO_FNB_ID in LDC_PROMO_FNB.PROMO_FNB_ID%type,
		inuSUBLINE_ID$ in LDC_PROMO_FNB.SUBLINE_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_PROMO_FNB;
	BEGIN
		rcError.PROMO_FNB_ID := inuPROMO_FNB_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPROMO_FNB_ID,
				rcData
			);
		end if;

		update LDC_PROMO_FNB
		set
			SUBLINE_ID = inuSUBLINE_ID$
		where
			PROMO_FNB_ID = inuPROMO_FNB_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SUBLINE_ID:= inuSUBLINE_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updINITIAL_DATE
	(
		inuPROMO_FNB_ID in LDC_PROMO_FNB.PROMO_FNB_ID%type,
		idtINITIAL_DATE$ in LDC_PROMO_FNB.INITIAL_DATE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_PROMO_FNB;
	BEGIN
		rcError.PROMO_FNB_ID := inuPROMO_FNB_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPROMO_FNB_ID,
				rcData
			);
		end if;

		update LDC_PROMO_FNB
		set
			INITIAL_DATE = idtINITIAL_DATE$
		where
			PROMO_FNB_ID = inuPROMO_FNB_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.INITIAL_DATE:= idtINITIAL_DATE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFINAL_DATE
	(
		inuPROMO_FNB_ID in LDC_PROMO_FNB.PROMO_FNB_ID%type,
		idtFINAL_DATE$ in LDC_PROMO_FNB.FINAL_DATE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_PROMO_FNB;
	BEGIN
		rcError.PROMO_FNB_ID := inuPROMO_FNB_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPROMO_FNB_ID,
				rcData
			);
		end if;

		update LDC_PROMO_FNB
		set
			FINAL_DATE = idtFINAL_DATE$
		where
			PROMO_FNB_ID = inuPROMO_FNB_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FINAL_DATE:= idtFINAL_DATE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetPROMO_FNB_ID
	(
		inuPROMO_FNB_ID in LDC_PROMO_FNB.PROMO_FNB_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROMO_FNB.PROMO_FNB_ID%type
	IS
		rcError styLDC_PROMO_FNB;
	BEGIN

		rcError.PROMO_FNB_ID := inuPROMO_FNB_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPROMO_FNB_ID
			 )
		then
			 return(rcData.PROMO_FNB_ID);
		end if;
		Load
		(
		 		inuPROMO_FNB_ID
		);
		return(rcData.PROMO_FNB_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetSUBLINE_ID
	(
		inuPROMO_FNB_ID in LDC_PROMO_FNB.PROMO_FNB_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROMO_FNB.SUBLINE_ID%type
	IS
		rcError styLDC_PROMO_FNB;
	BEGIN

		rcError.PROMO_FNB_ID := inuPROMO_FNB_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPROMO_FNB_ID
			 )
		then
			 return(rcData.SUBLINE_ID);
		end if;
		Load
		(
		 		inuPROMO_FNB_ID
		);
		return(rcData.SUBLINE_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetINITIAL_DATE
	(
		inuPROMO_FNB_ID in LDC_PROMO_FNB.PROMO_FNB_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROMO_FNB.INITIAL_DATE%type
	IS
		rcError styLDC_PROMO_FNB;
	BEGIN

		rcError.PROMO_FNB_ID := inuPROMO_FNB_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPROMO_FNB_ID
			 )
		then
			 return(rcData.INITIAL_DATE);
		end if;
		Load
		(
		 		inuPROMO_FNB_ID
		);
		return(rcData.INITIAL_DATE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetFINAL_DATE
	(
		inuPROMO_FNB_ID in LDC_PROMO_FNB.PROMO_FNB_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROMO_FNB.FINAL_DATE%type
	IS
		rcError styLDC_PROMO_FNB;
	BEGIN

		rcError.PROMO_FNB_ID := inuPROMO_FNB_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPROMO_FNB_ID
			 )
		then
			 return(rcData.FINAL_DATE);
		end if;
		Load
		(
		 		inuPROMO_FNB_ID
		);
		return(rcData.FINAL_DATE);
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
end DALDC_PROMO_FNB;
/
PROMPT Otorgando permisos de ejecucion a DALDC_PROMO_FNB
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_PROMO_FNB', 'ADM_PERSON');
END;
/