CREATE OR REPLACE PACKAGE ADM_PERSON.DALDC_PERILOGC
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
		inuPERICODI in LDC_PERILOGC.PERICODI%type
	)
	IS
		SELECT LDC_PERILOGC.*,LDC_PERILOGC.rowid
		FROM LDC_PERILOGC
		WHERE
		    PERICODI = inuPERICODI;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_PERILOGC.*,LDC_PERILOGC.rowid
		FROM LDC_PERILOGC
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_PERILOGC  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_PERILOGC is table of styLDC_PERILOGC index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_PERILOGC;

	/* Tipos referenciando al registro */
	type tytbPERICODI is table of LDC_PERILOGC.PERICODI%type index by binary_integer;
	type tytbPERILINE is table of LDC_PERILOGC.PERILINE%type index by binary_integer;
	type tytbPERIMENS is table of LDC_PERILOGC.PERIMENS%type index by binary_integer;
	type tytbPERICARG is table of LDC_PERILOGC.PERICARG%type index by binary_integer;
	type tytbPERIDATE is table of LDC_PERILOGC.PERIDATE%type index by binary_integer;
	type tytbPERICONS is table of LDC_PERILOGC.PERICONS%type index by binary_integer;
	type tytbPERIPEFA is table of LDC_PERILOGC.PERIPEFA%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_PERILOGC is record
	(
		PERICODI   tytbPERICODI,
		PERILINE   tytbPERILINE,
		PERIMENS   tytbPERIMENS,
		PERICARG   tytbPERICARG,
		PERIDATE   tytbPERIDATE,
		PERICONS   tytbPERICONS,
		PERIPEFA   tytbPERIPEFA,
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
		inuPERICODI in LDC_PERILOGC.PERICODI%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuPERICODI in LDC_PERILOGC.PERICODI%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuPERICODI in LDC_PERILOGC.PERICODI%type
	);

	PROCEDURE getRecord
	(
		inuPERICODI in LDC_PERILOGC.PERICODI%type,
		orcRecord out nocopy styLDC_PERILOGC
	);

	FUNCTION frcGetRcData
	(
		inuPERICODI in LDC_PERILOGC.PERICODI%type
	)
	RETURN styLDC_PERILOGC;

	FUNCTION frcGetRcData
	RETURN styLDC_PERILOGC;

	FUNCTION frcGetRecord
	(
		inuPERICODI in LDC_PERILOGC.PERICODI%type
	)
	RETURN styLDC_PERILOGC;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_PERILOGC
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_PERILOGC in styLDC_PERILOGC
	);

	PROCEDURE insRecord
	(
		ircLDC_PERILOGC in styLDC_PERILOGC,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_PERILOGC in out nocopy tytbLDC_PERILOGC
	);

	PROCEDURE delRecord
	(
		inuPERICODI in LDC_PERILOGC.PERICODI%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_PERILOGC in out nocopy tytbLDC_PERILOGC,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_PERILOGC in styLDC_PERILOGC,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_PERILOGC in out nocopy tytbLDC_PERILOGC,
		inuLock in number default 1
	);

	PROCEDURE updPERILINE
	(
		inuPERICODI in LDC_PERILOGC.PERICODI%type,
		isbPERILINE$ in LDC_PERILOGC.PERILINE%type,
		inuLock in number default 0
	);

	PROCEDURE updPERIMENS
	(
		inuPERICODI in LDC_PERILOGC.PERICODI%type,
		isbPERIMENS$ in LDC_PERILOGC.PERIMENS%type,
		inuLock in number default 0
	);

	PROCEDURE updPERICARG
	(
		inuPERICODI in LDC_PERILOGC.PERICODI%type,
		inuPERICARG$ in LDC_PERILOGC.PERICARG%type,
		inuLock in number default 0
	);

	PROCEDURE updPERIDATE
	(
		inuPERICODI in LDC_PERILOGC.PERICODI%type,
		idtPERIDATE$ in LDC_PERILOGC.PERIDATE%type,
		inuLock in number default 0
	);

	PROCEDURE updPERICONS
	(
		inuPERICODI in LDC_PERILOGC.PERICODI%type,
		inuPERICONS$ in LDC_PERILOGC.PERICONS%type,
		inuLock in number default 0
	);

	PROCEDURE updPERIPEFA
	(
		inuPERICODI in LDC_PERILOGC.PERICODI%type,
		inuPERIPEFA$ in LDC_PERILOGC.PERIPEFA%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetPERICODI
	(
		inuPERICODI in LDC_PERILOGC.PERICODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PERILOGC.PERICODI%type;

	FUNCTION fsbGetPERILINE
	(
		inuPERICODI in LDC_PERILOGC.PERICODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PERILOGC.PERILINE%type;

	FUNCTION fsbGetPERIMENS
	(
		inuPERICODI in LDC_PERILOGC.PERICODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PERILOGC.PERIMENS%type;

	FUNCTION fnuGetPERICARG
	(
		inuPERICODI in LDC_PERILOGC.PERICODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PERILOGC.PERICARG%type;

	FUNCTION fdtGetPERIDATE
	(
		inuPERICODI in LDC_PERILOGC.PERICODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PERILOGC.PERIDATE%type;

	FUNCTION fnuGetPERICONS
	(
		inuPERICODI in LDC_PERILOGC.PERICODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PERILOGC.PERICONS%type;

	FUNCTION fnuGetPERIPEFA
	(
		inuPERICODI in LDC_PERILOGC.PERICODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PERILOGC.PERIPEFA%type;


	PROCEDURE LockByPk
	(
		inuPERICODI in LDC_PERILOGC.PERICODI%type,
		orcLDC_PERILOGC  out styLDC_PERILOGC
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_PERILOGC  out styLDC_PERILOGC
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_PERILOGC;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALDC_PERILOGC
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_PERILOGC';
	 cnuGeEntityId constant varchar2(30) := 4506; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuPERICODI in LDC_PERILOGC.PERICODI%type
	)
	IS
		SELECT LDC_PERILOGC.*,LDC_PERILOGC.rowid
		FROM LDC_PERILOGC
		WHERE  PERICODI = inuPERICODI
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_PERILOGC.*,LDC_PERILOGC.rowid
		FROM LDC_PERILOGC
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_PERILOGC is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_PERILOGC;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_PERILOGC default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.PERICODI);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuPERICODI in LDC_PERILOGC.PERICODI%type,
		orcLDC_PERILOGC  out styLDC_PERILOGC
	)
	IS
		rcError styLDC_PERILOGC;
	BEGIN
		rcError.PERICODI := inuPERICODI;

		Open cuLockRcByPk
		(
			inuPERICODI
		);

		fetch cuLockRcByPk into orcLDC_PERILOGC;
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
		orcLDC_PERILOGC  out styLDC_PERILOGC
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_PERILOGC;
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
		itbLDC_PERILOGC  in out nocopy tytbLDC_PERILOGC
	)
	IS
	BEGIN
			rcRecOfTab.PERICODI.delete;
			rcRecOfTab.PERILINE.delete;
			rcRecOfTab.PERIMENS.delete;
			rcRecOfTab.PERICARG.delete;
			rcRecOfTab.PERIDATE.delete;
			rcRecOfTab.PERICONS.delete;
			rcRecOfTab.PERIPEFA.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_PERILOGC  in out nocopy tytbLDC_PERILOGC,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_PERILOGC);

		for n in itbLDC_PERILOGC.first .. itbLDC_PERILOGC.last loop
			rcRecOfTab.PERICODI(n) := itbLDC_PERILOGC(n).PERICODI;
			rcRecOfTab.PERILINE(n) := itbLDC_PERILOGC(n).PERILINE;
			rcRecOfTab.PERIMENS(n) := itbLDC_PERILOGC(n).PERIMENS;
			rcRecOfTab.PERICARG(n) := itbLDC_PERILOGC(n).PERICARG;
			rcRecOfTab.PERIDATE(n) := itbLDC_PERILOGC(n).PERIDATE;
			rcRecOfTab.PERICONS(n) := itbLDC_PERILOGC(n).PERICONS;
			rcRecOfTab.PERIPEFA(n) := itbLDC_PERILOGC(n).PERIPEFA;
			rcRecOfTab.row_id(n) := itbLDC_PERILOGC(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuPERICODI in LDC_PERILOGC.PERICODI%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuPERICODI
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
		inuPERICODI in LDC_PERILOGC.PERICODI%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuPERICODI = rcData.PERICODI
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
		inuPERICODI in LDC_PERILOGC.PERICODI%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuPERICODI
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuPERICODI in LDC_PERILOGC.PERICODI%type
	)
	IS
		rcError styLDC_PERILOGC;
	BEGIN		rcError.PERICODI:=inuPERICODI;

		Load
		(
			inuPERICODI
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
		inuPERICODI in LDC_PERILOGC.PERICODI%type
	)
	IS
	BEGIN
		Load
		(
			inuPERICODI
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuPERICODI in LDC_PERILOGC.PERICODI%type,
		orcRecord out nocopy styLDC_PERILOGC
	)
	IS
		rcError styLDC_PERILOGC;
	BEGIN		rcError.PERICODI:=inuPERICODI;

		Load
		(
			inuPERICODI
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuPERICODI in LDC_PERILOGC.PERICODI%type
	)
	RETURN styLDC_PERILOGC
	IS
		rcError styLDC_PERILOGC;
	BEGIN
		rcError.PERICODI:=inuPERICODI;

		Load
		(
			inuPERICODI
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuPERICODI in LDC_PERILOGC.PERICODI%type
	)
	RETURN styLDC_PERILOGC
	IS
		rcError styLDC_PERILOGC;
	BEGIN
		rcError.PERICODI:=inuPERICODI;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuPERICODI
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuPERICODI
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_PERILOGC
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_PERILOGC
	)
	IS
		rfLDC_PERILOGC tyrfLDC_PERILOGC;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_PERILOGC.*, LDC_PERILOGC.rowid FROM LDC_PERILOGC';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_PERILOGC for sbFullQuery;

		fetch rfLDC_PERILOGC bulk collect INTO otbResult;

		close rfLDC_PERILOGC;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_PERILOGC.*, LDC_PERILOGC.rowid FROM LDC_PERILOGC';
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
		ircLDC_PERILOGC in styLDC_PERILOGC
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_PERILOGC,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_PERILOGC in styLDC_PERILOGC,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_PERILOGC.PERICODI is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|PERICODI');
			raise ex.controlled_error;
		end if;

		insert into LDC_PERILOGC
		(
			PERICODI,
			PERILINE,
			PERIMENS,
			PERICARG,
			PERIDATE,
			PERICONS,
			PERIPEFA
		)
		values
		(
			ircLDC_PERILOGC.PERICODI,
			ircLDC_PERILOGC.PERILINE,
			ircLDC_PERILOGC.PERIMENS,
			ircLDC_PERILOGC.PERICARG,
			ircLDC_PERILOGC.PERIDATE,
			ircLDC_PERILOGC.PERICONS,
			ircLDC_PERILOGC.PERIPEFA
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_PERILOGC));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_PERILOGC in out nocopy tytbLDC_PERILOGC
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_PERILOGC,blUseRowID);
		forall n in iotbLDC_PERILOGC.first..iotbLDC_PERILOGC.last
			insert into LDC_PERILOGC
			(
				PERICODI,
				PERILINE,
				PERIMENS,
				PERICARG,
				PERIDATE,
				PERICONS,
				PERIPEFA
			)
			values
			(
				rcRecOfTab.PERICODI(n),
				rcRecOfTab.PERILINE(n),
				rcRecOfTab.PERIMENS(n),
				rcRecOfTab.PERICARG(n),
				rcRecOfTab.PERIDATE(n),
				rcRecOfTab.PERICONS(n),
				rcRecOfTab.PERIPEFA(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuPERICODI in LDC_PERILOGC.PERICODI%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_PERILOGC;
	BEGIN
		rcError.PERICODI := inuPERICODI;

		if inuLock=1 then
			LockByPk
			(
				inuPERICODI,
				rcData
			);
		end if;


		delete
		from LDC_PERILOGC
		where
       		PERICODI=inuPERICODI;
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
		rcError  styLDC_PERILOGC;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_PERILOGC
		where
			rowid = iriRowID
		returning
			PERICODI
		into
			rcError.PERICODI;
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
		iotbLDC_PERILOGC in out nocopy tytbLDC_PERILOGC,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_PERILOGC;
	BEGIN
		FillRecordOfTables(iotbLDC_PERILOGC, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_PERILOGC.first .. iotbLDC_PERILOGC.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_PERILOGC.first .. iotbLDC_PERILOGC.last
				delete
				from LDC_PERILOGC
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_PERILOGC.first .. iotbLDC_PERILOGC.last loop
					LockByPk
					(
						rcRecOfTab.PERICODI(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_PERILOGC.first .. iotbLDC_PERILOGC.last
				delete
				from LDC_PERILOGC
				where
		         	PERICODI = rcRecOfTab.PERICODI(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_PERILOGC in styLDC_PERILOGC,
		inuLock in number default 0
	)
	IS
		nuPERICODI	LDC_PERILOGC.PERICODI%type;
	BEGIN
		if ircLDC_PERILOGC.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_PERILOGC.rowid,rcData);
			end if;
			update LDC_PERILOGC
			set
				PERILINE = ircLDC_PERILOGC.PERILINE,
				PERIMENS = ircLDC_PERILOGC.PERIMENS,
				PERICARG = ircLDC_PERILOGC.PERICARG,
				PERIDATE = ircLDC_PERILOGC.PERIDATE,
				PERICONS = ircLDC_PERILOGC.PERICONS,
				PERIPEFA = ircLDC_PERILOGC.PERIPEFA
			where
				rowid = ircLDC_PERILOGC.rowid
			returning
				PERICODI
			into
				nuPERICODI;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_PERILOGC.PERICODI,
					rcData
				);
			end if;

			update LDC_PERILOGC
			set
				PERILINE = ircLDC_PERILOGC.PERILINE,
				PERIMENS = ircLDC_PERILOGC.PERIMENS,
				PERICARG = ircLDC_PERILOGC.PERICARG,
				PERIDATE = ircLDC_PERILOGC.PERIDATE,
				PERICONS = ircLDC_PERILOGC.PERICONS,
				PERIPEFA = ircLDC_PERILOGC.PERIPEFA
			where
				PERICODI = ircLDC_PERILOGC.PERICODI
			returning
				PERICODI
			into
				nuPERICODI;
		end if;
		if
			nuPERICODI is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_PERILOGC));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_PERILOGC in out nocopy tytbLDC_PERILOGC,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_PERILOGC;
	BEGIN
		FillRecordOfTables(iotbLDC_PERILOGC,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_PERILOGC.first .. iotbLDC_PERILOGC.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_PERILOGC.first .. iotbLDC_PERILOGC.last
				update LDC_PERILOGC
				set
					PERILINE = rcRecOfTab.PERILINE(n),
					PERIMENS = rcRecOfTab.PERIMENS(n),
					PERICARG = rcRecOfTab.PERICARG(n),
					PERIDATE = rcRecOfTab.PERIDATE(n),
					PERICONS = rcRecOfTab.PERICONS(n),
					PERIPEFA = rcRecOfTab.PERIPEFA(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_PERILOGC.first .. iotbLDC_PERILOGC.last loop
					LockByPk
					(
						rcRecOfTab.PERICODI(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_PERILOGC.first .. iotbLDC_PERILOGC.last
				update LDC_PERILOGC
				SET
					PERILINE = rcRecOfTab.PERILINE(n),
					PERIMENS = rcRecOfTab.PERIMENS(n),
					PERICARG = rcRecOfTab.PERICARG(n),
					PERIDATE = rcRecOfTab.PERIDATE(n),
					PERICONS = rcRecOfTab.PERICONS(n),
					PERIPEFA = rcRecOfTab.PERIPEFA(n)
				where
					PERICODI = rcRecOfTab.PERICODI(n)
;
		end if;
	END;
	PROCEDURE updPERILINE
	(
		inuPERICODI in LDC_PERILOGC.PERICODI%type,
		isbPERILINE$ in LDC_PERILOGC.PERILINE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_PERILOGC;
	BEGIN
		rcError.PERICODI := inuPERICODI;
		if inuLock=1 then
			LockByPk
			(
				inuPERICODI,
				rcData
			);
		end if;

		update LDC_PERILOGC
		set
			PERILINE = isbPERILINE$
		where
			PERICODI = inuPERICODI;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PERILINE:= isbPERILINE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPERIMENS
	(
		inuPERICODI in LDC_PERILOGC.PERICODI%type,
		isbPERIMENS$ in LDC_PERILOGC.PERIMENS%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_PERILOGC;
	BEGIN
		rcError.PERICODI := inuPERICODI;
		if inuLock=1 then
			LockByPk
			(
				inuPERICODI,
				rcData
			);
		end if;

		update LDC_PERILOGC
		set
			PERIMENS = isbPERIMENS$
		where
			PERICODI = inuPERICODI;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PERIMENS:= isbPERIMENS$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPERICARG
	(
		inuPERICODI in LDC_PERILOGC.PERICODI%type,
		inuPERICARG$ in LDC_PERILOGC.PERICARG%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_PERILOGC;
	BEGIN
		rcError.PERICODI := inuPERICODI;
		if inuLock=1 then
			LockByPk
			(
				inuPERICODI,
				rcData
			);
		end if;

		update LDC_PERILOGC
		set
			PERICARG = inuPERICARG$
		where
			PERICODI = inuPERICODI;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PERICARG:= inuPERICARG$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPERIDATE
	(
		inuPERICODI in LDC_PERILOGC.PERICODI%type,
		idtPERIDATE$ in LDC_PERILOGC.PERIDATE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_PERILOGC;
	BEGIN
		rcError.PERICODI := inuPERICODI;
		if inuLock=1 then
			LockByPk
			(
				inuPERICODI,
				rcData
			);
		end if;

		update LDC_PERILOGC
		set
			PERIDATE = idtPERIDATE$
		where
			PERICODI = inuPERICODI;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PERIDATE:= idtPERIDATE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPERICONS
	(
		inuPERICODI in LDC_PERILOGC.PERICODI%type,
		inuPERICONS$ in LDC_PERILOGC.PERICONS%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_PERILOGC;
	BEGIN
		rcError.PERICODI := inuPERICODI;
		if inuLock=1 then
			LockByPk
			(
				inuPERICODI,
				rcData
			);
		end if;

		update LDC_PERILOGC
		set
			PERICONS = inuPERICONS$
		where
			PERICODI = inuPERICODI;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PERICONS:= inuPERICONS$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPERIPEFA
	(
		inuPERICODI in LDC_PERILOGC.PERICODI%type,
		inuPERIPEFA$ in LDC_PERILOGC.PERIPEFA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_PERILOGC;
	BEGIN
		rcError.PERICODI := inuPERICODI;
		if inuLock=1 then
			LockByPk
			(
				inuPERICODI,
				rcData
			);
		end if;

		update LDC_PERILOGC
		set
			PERIPEFA = inuPERIPEFA$
		where
			PERICODI = inuPERICODI;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PERIPEFA:= inuPERIPEFA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetPERICODI
	(
		inuPERICODI in LDC_PERILOGC.PERICODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PERILOGC.PERICODI%type
	IS
		rcError styLDC_PERILOGC;
	BEGIN

		rcError.PERICODI := inuPERICODI;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPERICODI
			 )
		then
			 return(rcData.PERICODI);
		end if;
		Load
		(
		 		inuPERICODI
		);
		return(rcData.PERICODI);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetPERILINE
	(
		inuPERICODI in LDC_PERILOGC.PERICODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PERILOGC.PERILINE%type
	IS
		rcError styLDC_PERILOGC;
	BEGIN

		rcError.PERICODI := inuPERICODI;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPERICODI
			 )
		then
			 return(rcData.PERILINE);
		end if;
		Load
		(
		 		inuPERICODI
		);
		return(rcData.PERILINE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetPERIMENS
	(
		inuPERICODI in LDC_PERILOGC.PERICODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PERILOGC.PERIMENS%type
	IS
		rcError styLDC_PERILOGC;
	BEGIN

		rcError.PERICODI := inuPERICODI;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPERICODI
			 )
		then
			 return(rcData.PERIMENS);
		end if;
		Load
		(
		 		inuPERICODI
		);
		return(rcData.PERIMENS);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetPERICARG
	(
		inuPERICODI in LDC_PERILOGC.PERICODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PERILOGC.PERICARG%type
	IS
		rcError styLDC_PERILOGC;
	BEGIN

		rcError.PERICODI := inuPERICODI;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPERICODI
			 )
		then
			 return(rcData.PERICARG);
		end if;
		Load
		(
		 		inuPERICODI
		);
		return(rcData.PERICARG);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetPERIDATE
	(
		inuPERICODI in LDC_PERILOGC.PERICODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PERILOGC.PERIDATE%type
	IS
		rcError styLDC_PERILOGC;
	BEGIN

		rcError.PERICODI := inuPERICODI;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPERICODI
			 )
		then
			 return(rcData.PERIDATE);
		end if;
		Load
		(
		 		inuPERICODI
		);
		return(rcData.PERIDATE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetPERICONS
	(
		inuPERICODI in LDC_PERILOGC.PERICODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PERILOGC.PERICONS%type
	IS
		rcError styLDC_PERILOGC;
	BEGIN

		rcError.PERICODI := inuPERICODI;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPERICODI
			 )
		then
			 return(rcData.PERICONS);
		end if;
		Load
		(
		 		inuPERICODI
		);
		return(rcData.PERICONS);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetPERIPEFA
	(
		inuPERICODI in LDC_PERILOGC.PERICODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PERILOGC.PERIPEFA%type
	IS
		rcError styLDC_PERILOGC;
	BEGIN

		rcError.PERICODI := inuPERICODI;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPERICODI
			 )
		then
			 return(rcData.PERIPEFA);
		end if;
		Load
		(
		 		inuPERICODI
		);
		return(rcData.PERIPEFA);
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
end DALDC_PERILOGC;
/
PROMPT Otorgando permisos de ejecucion a DALDC_PERILOGC
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_PERILOGC', 'ADM_PERSON');
END;
/