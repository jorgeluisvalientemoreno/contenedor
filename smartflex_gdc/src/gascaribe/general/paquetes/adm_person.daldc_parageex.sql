CREATE OR REPLACE PACKAGE adm_person.DALDC_PARAGEEX
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
    17/06/2024              PAcosta         OSF-2780: Cambio de esquema ADM_PERSON                              
    ****************************************************************/   
    
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		isbPAGECODI in LDC_PARAGEEX.PAGECODI%type
	)
	IS
		SELECT LDC_PARAGEEX.*,LDC_PARAGEEX.rowid
		FROM LDC_PARAGEEX
		WHERE
		    PAGECODI = isbPAGECODI;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_PARAGEEX.*,LDC_PARAGEEX.rowid
		FROM LDC_PARAGEEX
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_PARAGEEX  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_PARAGEEX is table of styLDC_PARAGEEX index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_PARAGEEX;

	/* Tipos referenciando al registro */
	type tytbPAGECODI is table of LDC_PARAGEEX.PAGECODI%type index by binary_integer;
	type tytbPAGEVANU is table of LDC_PARAGEEX.PAGEVANU%type index by binary_integer;
	type tytbPAGEVAST is table of LDC_PARAGEEX.PAGEVAST%type index by binary_integer;
	type tytbPAGEDESC is table of LDC_PARAGEEX.PAGEDESC%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_PARAGEEX is record
	(
		PAGECODI   tytbPAGECODI,
		PAGEVANU   tytbPAGEVANU,
		PAGEVAST   tytbPAGEVAST,
		PAGEDESC   tytbPAGEDESC,
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
		isbPAGECODI in LDC_PARAGEEX.PAGECODI%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		isbPAGECODI in LDC_PARAGEEX.PAGECODI%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		isbPAGECODI in LDC_PARAGEEX.PAGECODI%type
	);

	PROCEDURE getRecord
	(
		isbPAGECODI in LDC_PARAGEEX.PAGECODI%type,
		orcRecord out nocopy styLDC_PARAGEEX
	);

	FUNCTION frcGetRcData
	(
		isbPAGECODI in LDC_PARAGEEX.PAGECODI%type
	)
	RETURN styLDC_PARAGEEX;

	FUNCTION frcGetRcData
	RETURN styLDC_PARAGEEX;

	FUNCTION frcGetRecord
	(
		isbPAGECODI in LDC_PARAGEEX.PAGECODI%type
	)
	RETURN styLDC_PARAGEEX;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_PARAGEEX
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_PARAGEEX in styLDC_PARAGEEX
	);

	PROCEDURE insRecord
	(
		ircLDC_PARAGEEX in styLDC_PARAGEEX,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_PARAGEEX in out nocopy tytbLDC_PARAGEEX
	);

	PROCEDURE delRecord
	(
		isbPAGECODI in LDC_PARAGEEX.PAGECODI%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_PARAGEEX in out nocopy tytbLDC_PARAGEEX,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_PARAGEEX in styLDC_PARAGEEX,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_PARAGEEX in out nocopy tytbLDC_PARAGEEX,
		inuLock in number default 1
	);

	PROCEDURE updPAGEVANU
	(
		isbPAGECODI in LDC_PARAGEEX.PAGECODI%type,
		inuPAGEVANU$ in LDC_PARAGEEX.PAGEVANU%type,
		inuLock in number default 0
	);

	PROCEDURE updPAGEVAST
	(
		isbPAGECODI in LDC_PARAGEEX.PAGECODI%type,
		isbPAGEVAST$ in LDC_PARAGEEX.PAGEVAST%type,
		inuLock in number default 0
	);

	PROCEDURE updPAGEDESC
	(
		isbPAGECODI in LDC_PARAGEEX.PAGECODI%type,
		isbPAGEDESC$ in LDC_PARAGEEX.PAGEDESC%type,
		inuLock in number default 0
	);

	FUNCTION fsbGetPAGECODI
	(
		isbPAGECODI in LDC_PARAGEEX.PAGECODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PARAGEEX.PAGECODI%type;

	FUNCTION fnuGetPAGEVANU
	(
		isbPAGECODI in LDC_PARAGEEX.PAGECODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PARAGEEX.PAGEVANU%type;

	FUNCTION fsbGetPAGEVAST
	(
		isbPAGECODI in LDC_PARAGEEX.PAGECODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PARAGEEX.PAGEVAST%type;

	FUNCTION fsbGetPAGEDESC
	(
		isbPAGECODI in LDC_PARAGEEX.PAGECODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PARAGEEX.PAGEDESC%type;


	PROCEDURE LockByPk
	(
		isbPAGECODI in LDC_PARAGEEX.PAGECODI%type,
		orcLDC_PARAGEEX  out styLDC_PARAGEEX
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_PARAGEEX  out styLDC_PARAGEEX
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_PARAGEEX;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALDC_PARAGEEX
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO1';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_PARAGEEX';
	 cnuGeEntityId constant varchar2(30) := 5814; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		isbPAGECODI in LDC_PARAGEEX.PAGECODI%type
	)
	IS
		SELECT LDC_PARAGEEX.*,LDC_PARAGEEX.rowid
		FROM LDC_PARAGEEX
		WHERE  PAGECODI = isbPAGECODI
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_PARAGEEX.*,LDC_PARAGEEX.rowid
		FROM LDC_PARAGEEX
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_PARAGEEX is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_PARAGEEX;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_PARAGEEX default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.PAGECODI);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		isbPAGECODI in LDC_PARAGEEX.PAGECODI%type,
		orcLDC_PARAGEEX  out styLDC_PARAGEEX
	)
	IS
		rcError styLDC_PARAGEEX;
	BEGIN
		rcError.PAGECODI := isbPAGECODI;

		Open cuLockRcByPk
		(
			isbPAGECODI
		);

		fetch cuLockRcByPk into orcLDC_PARAGEEX;
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
		orcLDC_PARAGEEX  out styLDC_PARAGEEX
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_PARAGEEX;
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
		itbLDC_PARAGEEX  in out nocopy tytbLDC_PARAGEEX
	)
	IS
	BEGIN
			rcRecOfTab.PAGECODI.delete;
			rcRecOfTab.PAGEVANU.delete;
			rcRecOfTab.PAGEVAST.delete;
			rcRecOfTab.PAGEDESC.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_PARAGEEX  in out nocopy tytbLDC_PARAGEEX,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_PARAGEEX);

		for n in itbLDC_PARAGEEX.first .. itbLDC_PARAGEEX.last loop
			rcRecOfTab.PAGECODI(n) := itbLDC_PARAGEEX(n).PAGECODI;
			rcRecOfTab.PAGEVANU(n) := itbLDC_PARAGEEX(n).PAGEVANU;
			rcRecOfTab.PAGEVAST(n) := itbLDC_PARAGEEX(n).PAGEVAST;
			rcRecOfTab.PAGEDESC(n) := itbLDC_PARAGEEX(n).PAGEDESC;
			rcRecOfTab.row_id(n) := itbLDC_PARAGEEX(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		isbPAGECODI in LDC_PARAGEEX.PAGECODI%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			isbPAGECODI
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
		isbPAGECODI in LDC_PARAGEEX.PAGECODI%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			isbPAGECODI = rcData.PAGECODI
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
		isbPAGECODI in LDC_PARAGEEX.PAGECODI%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			isbPAGECODI
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		isbPAGECODI in LDC_PARAGEEX.PAGECODI%type
	)
	IS
		rcError styLDC_PARAGEEX;
	BEGIN		rcError.PAGECODI:=isbPAGECODI;

		Load
		(
			isbPAGECODI
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
		isbPAGECODI in LDC_PARAGEEX.PAGECODI%type
	)
	IS
	BEGIN
		Load
		(
			isbPAGECODI
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		isbPAGECODI in LDC_PARAGEEX.PAGECODI%type,
		orcRecord out nocopy styLDC_PARAGEEX
	)
	IS
		rcError styLDC_PARAGEEX;
	BEGIN		rcError.PAGECODI:=isbPAGECODI;

		Load
		(
			isbPAGECODI
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		isbPAGECODI in LDC_PARAGEEX.PAGECODI%type
	)
	RETURN styLDC_PARAGEEX
	IS
		rcError styLDC_PARAGEEX;
	BEGIN
		rcError.PAGECODI:=isbPAGECODI;

		Load
		(
			isbPAGECODI
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		isbPAGECODI in LDC_PARAGEEX.PAGECODI%type
	)
	RETURN styLDC_PARAGEEX
	IS
		rcError styLDC_PARAGEEX;
	BEGIN
		rcError.PAGECODI:=isbPAGECODI;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			isbPAGECODI
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			isbPAGECODI
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_PARAGEEX
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_PARAGEEX
	)
	IS
		rfLDC_PARAGEEX tyrfLDC_PARAGEEX;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_PARAGEEX.*, LDC_PARAGEEX.rowid FROM LDC_PARAGEEX';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_PARAGEEX for sbFullQuery;

		fetch rfLDC_PARAGEEX bulk collect INTO otbResult;

		close rfLDC_PARAGEEX;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_PARAGEEX.*, LDC_PARAGEEX.rowid FROM LDC_PARAGEEX';
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
		ircLDC_PARAGEEX in styLDC_PARAGEEX
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_PARAGEEX,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_PARAGEEX in styLDC_PARAGEEX,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_PARAGEEX.PAGECODI is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|PAGECODI');
			raise ex.controlled_error;
		end if;

		insert into LDC_PARAGEEX
		(
			PAGECODI,
			PAGEVANU,
			PAGEVAST,
			PAGEDESC
		)
		values
		(
			ircLDC_PARAGEEX.PAGECODI,
			ircLDC_PARAGEEX.PAGEVANU,
			ircLDC_PARAGEEX.PAGEVAST,
			ircLDC_PARAGEEX.PAGEDESC
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_PARAGEEX));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_PARAGEEX in out nocopy tytbLDC_PARAGEEX
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_PARAGEEX,blUseRowID);
		forall n in iotbLDC_PARAGEEX.first..iotbLDC_PARAGEEX.last
			insert into LDC_PARAGEEX
			(
				PAGECODI,
				PAGEVANU,
				PAGEVAST,
				PAGEDESC
			)
			values
			(
				rcRecOfTab.PAGECODI(n),
				rcRecOfTab.PAGEVANU(n),
				rcRecOfTab.PAGEVAST(n),
				rcRecOfTab.PAGEDESC(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		isbPAGECODI in LDC_PARAGEEX.PAGECODI%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_PARAGEEX;
	BEGIN
		rcError.PAGECODI := isbPAGECODI;

		if inuLock=1 then
			LockByPk
			(
				isbPAGECODI,
				rcData
			);
		end if;


		delete
		from LDC_PARAGEEX
		where
       		PAGECODI=isbPAGECODI;
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
		rcError  styLDC_PARAGEEX;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_PARAGEEX
		where
			rowid = iriRowID
		returning
			PAGECODI
		into
			rcError.PAGECODI;
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
		iotbLDC_PARAGEEX in out nocopy tytbLDC_PARAGEEX,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_PARAGEEX;
	BEGIN
		FillRecordOfTables(iotbLDC_PARAGEEX, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_PARAGEEX.first .. iotbLDC_PARAGEEX.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_PARAGEEX.first .. iotbLDC_PARAGEEX.last
				delete
				from LDC_PARAGEEX
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_PARAGEEX.first .. iotbLDC_PARAGEEX.last loop
					LockByPk
					(
						rcRecOfTab.PAGECODI(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_PARAGEEX.first .. iotbLDC_PARAGEEX.last
				delete
				from LDC_PARAGEEX
				where
		         	PAGECODI = rcRecOfTab.PAGECODI(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_PARAGEEX in styLDC_PARAGEEX,
		inuLock in number default 0
	)
	IS
		sbPAGECODI	LDC_PARAGEEX.PAGECODI%type;
	BEGIN
		if ircLDC_PARAGEEX.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_PARAGEEX.rowid,rcData);
			end if;
			update LDC_PARAGEEX
			set
				PAGEVANU = ircLDC_PARAGEEX.PAGEVANU,
				PAGEVAST = ircLDC_PARAGEEX.PAGEVAST,
				PAGEDESC = ircLDC_PARAGEEX.PAGEDESC
			where
				rowid = ircLDC_PARAGEEX.rowid
			returning
				PAGECODI
			into
				sbPAGECODI;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_PARAGEEX.PAGECODI,
					rcData
				);
			end if;

			update LDC_PARAGEEX
			set
				PAGEVANU = ircLDC_PARAGEEX.PAGEVANU,
				PAGEVAST = ircLDC_PARAGEEX.PAGEVAST,
				PAGEDESC = ircLDC_PARAGEEX.PAGEDESC
			where
				PAGECODI = ircLDC_PARAGEEX.PAGECODI
			returning
				PAGECODI
			into
				sbPAGECODI;
		end if;
		if
			sbPAGECODI is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_PARAGEEX));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_PARAGEEX in out nocopy tytbLDC_PARAGEEX,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_PARAGEEX;
	BEGIN
		FillRecordOfTables(iotbLDC_PARAGEEX,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_PARAGEEX.first .. iotbLDC_PARAGEEX.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_PARAGEEX.first .. iotbLDC_PARAGEEX.last
				update LDC_PARAGEEX
				set
					PAGEVANU = rcRecOfTab.PAGEVANU(n),
					PAGEVAST = rcRecOfTab.PAGEVAST(n),
					PAGEDESC = rcRecOfTab.PAGEDESC(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_PARAGEEX.first .. iotbLDC_PARAGEEX.last loop
					LockByPk
					(
						rcRecOfTab.PAGECODI(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_PARAGEEX.first .. iotbLDC_PARAGEEX.last
				update LDC_PARAGEEX
				SET
					PAGEVANU = rcRecOfTab.PAGEVANU(n),
					PAGEVAST = rcRecOfTab.PAGEVAST(n),
					PAGEDESC = rcRecOfTab.PAGEDESC(n)
				where
					PAGECODI = rcRecOfTab.PAGECODI(n)
;
		end if;
	END;
	PROCEDURE updPAGEVANU
	(
		isbPAGECODI in LDC_PARAGEEX.PAGECODI%type,
		inuPAGEVANU$ in LDC_PARAGEEX.PAGEVANU%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_PARAGEEX;
	BEGIN
		rcError.PAGECODI := isbPAGECODI;
		if inuLock=1 then
			LockByPk
			(
				isbPAGECODI,
				rcData
			);
		end if;

		update LDC_PARAGEEX
		set
			PAGEVANU = inuPAGEVANU$
		where
			PAGECODI = isbPAGECODI;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PAGEVANU:= inuPAGEVANU$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPAGEVAST
	(
		isbPAGECODI in LDC_PARAGEEX.PAGECODI%type,
		isbPAGEVAST$ in LDC_PARAGEEX.PAGEVAST%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_PARAGEEX;
	BEGIN
		rcError.PAGECODI := isbPAGECODI;
		if inuLock=1 then
			LockByPk
			(
				isbPAGECODI,
				rcData
			);
		end if;

		update LDC_PARAGEEX
		set
			PAGEVAST = isbPAGEVAST$
		where
			PAGECODI = isbPAGECODI;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PAGEVAST:= isbPAGEVAST$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPAGEDESC
	(
		isbPAGECODI in LDC_PARAGEEX.PAGECODI%type,
		isbPAGEDESC$ in LDC_PARAGEEX.PAGEDESC%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_PARAGEEX;
	BEGIN
		rcError.PAGECODI := isbPAGECODI;
		if inuLock=1 then
			LockByPk
			(
				isbPAGECODI,
				rcData
			);
		end if;

		update LDC_PARAGEEX
		set
			PAGEDESC = isbPAGEDESC$
		where
			PAGECODI = isbPAGECODI;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PAGEDESC:= isbPAGEDESC$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fsbGetPAGECODI
	(
		isbPAGECODI in LDC_PARAGEEX.PAGECODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PARAGEEX.PAGECODI%type
	IS
		rcError styLDC_PARAGEEX;
	BEGIN

		rcError.PAGECODI := isbPAGECODI;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		isbPAGECODI
			 )
		then
			 return(rcData.PAGECODI);
		end if;
		Load
		(
		 		isbPAGECODI
		);
		return(rcData.PAGECODI);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetPAGEVANU
	(
		isbPAGECODI in LDC_PARAGEEX.PAGECODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PARAGEEX.PAGEVANU%type
	IS
		rcError styLDC_PARAGEEX;
	BEGIN

		rcError.PAGECODI := isbPAGECODI;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		isbPAGECODI
			 )
		then
			 return(rcData.PAGEVANU);
		end if;
		Load
		(
		 		isbPAGECODI
		);
		return(rcData.PAGEVANU);
	EXCEPTION
		when no_data_found then
			RETURN NULL;
	END;
	FUNCTION fsbGetPAGEVAST
	(
		isbPAGECODI in LDC_PARAGEEX.PAGECODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PARAGEEX.PAGEVAST%type
	IS
		rcError styLDC_PARAGEEX;
	BEGIN

		rcError.PAGECODI := isbPAGECODI;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		isbPAGECODI
			 )
		then
			 return(rcData.PAGEVAST);
		end if;
		Load
		(
		 		isbPAGECODI
		);
		return(rcData.PAGEVAST);
	EXCEPTION
		when no_data_found then
			RETURN NULL;
	END;
	FUNCTION fsbGetPAGEDESC
	(
		isbPAGECODI in LDC_PARAGEEX.PAGECODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PARAGEEX.PAGEDESC%type
	IS
		rcError styLDC_PARAGEEX;
	BEGIN

		rcError.PAGECODI := isbPAGECODI;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		isbPAGECODI
			 )
		then
			 return(rcData.PAGEDESC);
		end if;
		Load
		(
		 		isbPAGECODI
		);
		return(rcData.PAGEDESC);
	EXCEPTION
		when no_data_found then
			RETURN NULL;
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
end DALDC_PARAGEEX;
/
PROMPT Otorgando permisos de ejecucion a DALDC_PARAGEEX
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_PARAGEEX', 'ADM_PERSON');
END;
/