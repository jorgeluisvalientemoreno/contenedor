CREATE OR REPLACE PACKAGE adm_person.DALDC_IMCOSEEL
is
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     : DALDC_IMCOSEEL
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
		inuICSECODI in LDC_IMCOSEEL.ICSECODI%type
	)
	IS
		SELECT LDC_IMCOSEEL.*,LDC_IMCOSEEL.rowid
		FROM LDC_IMCOSEEL
		WHERE
		    ICSECODI = inuICSECODI;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_IMCOSEEL.*,LDC_IMCOSEEL.rowid
		FROM LDC_IMCOSEEL
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_IMCOSEEL  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_IMCOSEEL is table of styLDC_IMCOSEEL index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_IMCOSEEL;

	/* Tipos referenciando al registro */
	type tytbICSECODI is table of LDC_IMCOSEEL.ICSECODI%type index by binary_integer;
	type tytbICSESUEL is table of LDC_IMCOSEEL.ICSESUEL%type index by binary_integer;
	type tytbICSEELEM is table of LDC_IMCOSEEL.ICSEELEM%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_IMCOSEEL is record
	(
		ICSECODI   tytbICSECODI,
		ICSESUEL   tytbICSESUEL,
		ICSEELEM   tytbICSEELEM,
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
		inuICSECODI in LDC_IMCOSEEL.ICSECODI%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuICSECODI in LDC_IMCOSEEL.ICSECODI%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuICSECODI in LDC_IMCOSEEL.ICSECODI%type
	);

	PROCEDURE getRecord
	(
		inuICSECODI in LDC_IMCOSEEL.ICSECODI%type,
		orcRecord out nocopy styLDC_IMCOSEEL
	);

	FUNCTION frcGetRcData
	(
		inuICSECODI in LDC_IMCOSEEL.ICSECODI%type
	)
	RETURN styLDC_IMCOSEEL;

	FUNCTION frcGetRcData
	RETURN styLDC_IMCOSEEL;

	FUNCTION frcGetRecord
	(
		inuICSECODI in LDC_IMCOSEEL.ICSECODI%type
	)
	RETURN styLDC_IMCOSEEL;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_IMCOSEEL
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_IMCOSEEL in styLDC_IMCOSEEL
	);

	PROCEDURE insRecord
	(
		ircLDC_IMCOSEEL in styLDC_IMCOSEEL,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_IMCOSEEL in out nocopy tytbLDC_IMCOSEEL
	);

	PROCEDURE delRecord
	(
		inuICSECODI in LDC_IMCOSEEL.ICSECODI%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_IMCOSEEL in out nocopy tytbLDC_IMCOSEEL,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_IMCOSEEL in styLDC_IMCOSEEL,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_IMCOSEEL in out nocopy tytbLDC_IMCOSEEL,
		inuLock in number default 1
	);

	PROCEDURE updICSESUEL
	(
		inuICSECODI in LDC_IMCOSEEL.ICSECODI%type,
		isbICSESUEL$ in LDC_IMCOSEEL.ICSESUEL%type,
		inuLock in number default 0
	);

	PROCEDURE updICSEELEM
	(
		inuICSECODI in LDC_IMCOSEEL.ICSECODI%type,
		isbICSEELEM$ in LDC_IMCOSEEL.ICSEELEM%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetICSECODI
	(
		inuICSECODI in LDC_IMCOSEEL.ICSECODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_IMCOSEEL.ICSECODI%type;

	FUNCTION fsbGetICSESUEL
	(
		inuICSECODI in LDC_IMCOSEEL.ICSECODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_IMCOSEEL.ICSESUEL%type;

	FUNCTION fsbGetICSEELEM
	(
		inuICSECODI in LDC_IMCOSEEL.ICSECODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_IMCOSEEL.ICSEELEM%type;


	PROCEDURE LockByPk
	(
		inuICSECODI in LDC_IMCOSEEL.ICSECODI%type,
		orcLDC_IMCOSEEL  out styLDC_IMCOSEEL
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_IMCOSEEL  out styLDC_IMCOSEEL
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_IMCOSEEL;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALDC_IMCOSEEL
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_IMCOSEEL';
	 cnuGeEntityId constant varchar2(30) := 4106; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuICSECODI in LDC_IMCOSEEL.ICSECODI%type
	)
	IS
		SELECT LDC_IMCOSEEL.*,LDC_IMCOSEEL.rowid
		FROM LDC_IMCOSEEL
		WHERE  ICSECODI = inuICSECODI
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_IMCOSEEL.*,LDC_IMCOSEEL.rowid
		FROM LDC_IMCOSEEL
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_IMCOSEEL is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_IMCOSEEL;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_IMCOSEEL default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.ICSECODI);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuICSECODI in LDC_IMCOSEEL.ICSECODI%type,
		orcLDC_IMCOSEEL  out styLDC_IMCOSEEL
	)
	IS
		rcError styLDC_IMCOSEEL;
	BEGIN
		rcError.ICSECODI := inuICSECODI;

		Open cuLockRcByPk
		(
			inuICSECODI
		);

		fetch cuLockRcByPk into orcLDC_IMCOSEEL;
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
		orcLDC_IMCOSEEL  out styLDC_IMCOSEEL
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_IMCOSEEL;
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
		itbLDC_IMCOSEEL  in out nocopy tytbLDC_IMCOSEEL
	)
	IS
	BEGIN
			rcRecOfTab.ICSECODI.delete;
			rcRecOfTab.ICSESUEL.delete;
			rcRecOfTab.ICSEELEM.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_IMCOSEEL  in out nocopy tytbLDC_IMCOSEEL,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_IMCOSEEL);

		for n in itbLDC_IMCOSEEL.first .. itbLDC_IMCOSEEL.last loop
			rcRecOfTab.ICSECODI(n) := itbLDC_IMCOSEEL(n).ICSECODI;
			rcRecOfTab.ICSESUEL(n) := itbLDC_IMCOSEEL(n).ICSESUEL;
			rcRecOfTab.ICSEELEM(n) := itbLDC_IMCOSEEL(n).ICSEELEM;
			rcRecOfTab.row_id(n) := itbLDC_IMCOSEEL(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuICSECODI in LDC_IMCOSEEL.ICSECODI%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuICSECODI
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
		inuICSECODI in LDC_IMCOSEEL.ICSECODI%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuICSECODI = rcData.ICSECODI
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
		inuICSECODI in LDC_IMCOSEEL.ICSECODI%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuICSECODI
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuICSECODI in LDC_IMCOSEEL.ICSECODI%type
	)
	IS
		rcError styLDC_IMCOSEEL;
	BEGIN		rcError.ICSECODI:=inuICSECODI;

		Load
		(
			inuICSECODI
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
		inuICSECODI in LDC_IMCOSEEL.ICSECODI%type
	)
	IS
	BEGIN
		Load
		(
			inuICSECODI
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuICSECODI in LDC_IMCOSEEL.ICSECODI%type,
		orcRecord out nocopy styLDC_IMCOSEEL
	)
	IS
		rcError styLDC_IMCOSEEL;
	BEGIN		rcError.ICSECODI:=inuICSECODI;

		Load
		(
			inuICSECODI
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuICSECODI in LDC_IMCOSEEL.ICSECODI%type
	)
	RETURN styLDC_IMCOSEEL
	IS
		rcError styLDC_IMCOSEEL;
	BEGIN
		rcError.ICSECODI:=inuICSECODI;

		Load
		(
			inuICSECODI
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuICSECODI in LDC_IMCOSEEL.ICSECODI%type
	)
	RETURN styLDC_IMCOSEEL
	IS
		rcError styLDC_IMCOSEEL;
	BEGIN
		rcError.ICSECODI:=inuICSECODI;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuICSECODI
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuICSECODI
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_IMCOSEEL
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_IMCOSEEL
	)
	IS
		rfLDC_IMCOSEEL tyrfLDC_IMCOSEEL;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_IMCOSEEL.*, LDC_IMCOSEEL.rowid FROM LDC_IMCOSEEL';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_IMCOSEEL for sbFullQuery;

		fetch rfLDC_IMCOSEEL bulk collect INTO otbResult;

		close rfLDC_IMCOSEEL;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_IMCOSEEL.*, LDC_IMCOSEEL.rowid FROM LDC_IMCOSEEL';
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
		ircLDC_IMCOSEEL in styLDC_IMCOSEEL
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_IMCOSEEL,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_IMCOSEEL in styLDC_IMCOSEEL,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_IMCOSEEL.ICSECODI is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ICSECODI');
			raise ex.controlled_error;
		end if;

		insert into LDC_IMCOSEEL
		(
			ICSECODI,
			ICSESUEL,
			ICSEELEM
		)
		values
		(
			ircLDC_IMCOSEEL.ICSECODI,
			ircLDC_IMCOSEEL.ICSESUEL,
			ircLDC_IMCOSEEL.ICSEELEM
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_IMCOSEEL));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_IMCOSEEL in out nocopy tytbLDC_IMCOSEEL
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_IMCOSEEL,blUseRowID);
		forall n in iotbLDC_IMCOSEEL.first..iotbLDC_IMCOSEEL.last
			insert into LDC_IMCOSEEL
			(
				ICSECODI,
				ICSESUEL,
				ICSEELEM
			)
			values
			(
				rcRecOfTab.ICSECODI(n),
				rcRecOfTab.ICSESUEL(n),
				rcRecOfTab.ICSEELEM(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuICSECODI in LDC_IMCOSEEL.ICSECODI%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_IMCOSEEL;
	BEGIN
		rcError.ICSECODI := inuICSECODI;

		if inuLock=1 then
			LockByPk
			(
				inuICSECODI,
				rcData
			);
		end if;


		delete
		from LDC_IMCOSEEL
		where
       		ICSECODI=inuICSECODI;
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
		rcError  styLDC_IMCOSEEL;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_IMCOSEEL
		where
			rowid = iriRowID
		returning
			ICSECODI
		into
			rcError.ICSECODI;
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
		iotbLDC_IMCOSEEL in out nocopy tytbLDC_IMCOSEEL,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_IMCOSEEL;
	BEGIN
		FillRecordOfTables(iotbLDC_IMCOSEEL, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_IMCOSEEL.first .. iotbLDC_IMCOSEEL.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_IMCOSEEL.first .. iotbLDC_IMCOSEEL.last
				delete
				from LDC_IMCOSEEL
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_IMCOSEEL.first .. iotbLDC_IMCOSEEL.last loop
					LockByPk
					(
						rcRecOfTab.ICSECODI(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_IMCOSEEL.first .. iotbLDC_IMCOSEEL.last
				delete
				from LDC_IMCOSEEL
				where
		         	ICSECODI = rcRecOfTab.ICSECODI(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_IMCOSEEL in styLDC_IMCOSEEL,
		inuLock in number default 0
	)
	IS
		nuICSECODI	LDC_IMCOSEEL.ICSECODI%type;
	BEGIN
		if ircLDC_IMCOSEEL.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_IMCOSEEL.rowid,rcData);
			end if;
			update LDC_IMCOSEEL
			set
				ICSESUEL = ircLDC_IMCOSEEL.ICSESUEL,
				ICSEELEM = ircLDC_IMCOSEEL.ICSEELEM
			where
				rowid = ircLDC_IMCOSEEL.rowid
			returning
				ICSECODI
			into
				nuICSECODI;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_IMCOSEEL.ICSECODI,
					rcData
				);
			end if;

			update LDC_IMCOSEEL
			set
				ICSESUEL = ircLDC_IMCOSEEL.ICSESUEL,
				ICSEELEM = ircLDC_IMCOSEEL.ICSEELEM
			where
				ICSECODI = ircLDC_IMCOSEEL.ICSECODI
			returning
				ICSECODI
			into
				nuICSECODI;
		end if;
		if
			nuICSECODI is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_IMCOSEEL));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_IMCOSEEL in out nocopy tytbLDC_IMCOSEEL,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_IMCOSEEL;
	BEGIN
		FillRecordOfTables(iotbLDC_IMCOSEEL,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_IMCOSEEL.first .. iotbLDC_IMCOSEEL.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_IMCOSEEL.first .. iotbLDC_IMCOSEEL.last
				update LDC_IMCOSEEL
				set
					ICSESUEL = rcRecOfTab.ICSESUEL(n),
					ICSEELEM = rcRecOfTab.ICSEELEM(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_IMCOSEEL.first .. iotbLDC_IMCOSEEL.last loop
					LockByPk
					(
						rcRecOfTab.ICSECODI(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_IMCOSEEL.first .. iotbLDC_IMCOSEEL.last
				update LDC_IMCOSEEL
				SET
					ICSESUEL = rcRecOfTab.ICSESUEL(n),
					ICSEELEM = rcRecOfTab.ICSEELEM(n)
				where
					ICSECODI = rcRecOfTab.ICSECODI(n)
;
		end if;
	END;
	PROCEDURE updICSESUEL
	(
		inuICSECODI in LDC_IMCOSEEL.ICSECODI%type,
		isbICSESUEL$ in LDC_IMCOSEEL.ICSESUEL%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_IMCOSEEL;
	BEGIN
		rcError.ICSECODI := inuICSECODI;
		if inuLock=1 then
			LockByPk
			(
				inuICSECODI,
				rcData
			);
		end if;

		update LDC_IMCOSEEL
		set
			ICSESUEL = isbICSESUEL$
		where
			ICSECODI = inuICSECODI;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ICSESUEL:= isbICSESUEL$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updICSEELEM
	(
		inuICSECODI in LDC_IMCOSEEL.ICSECODI%type,
		isbICSEELEM$ in LDC_IMCOSEEL.ICSEELEM%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_IMCOSEEL;
	BEGIN
		rcError.ICSECODI := inuICSECODI;
		if inuLock=1 then
			LockByPk
			(
				inuICSECODI,
				rcData
			);
		end if;

		update LDC_IMCOSEEL
		set
			ICSEELEM = isbICSEELEM$
		where
			ICSECODI = inuICSECODI;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ICSEELEM:= isbICSEELEM$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetICSECODI
	(
		inuICSECODI in LDC_IMCOSEEL.ICSECODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_IMCOSEEL.ICSECODI%type
	IS
		rcError styLDC_IMCOSEEL;
	BEGIN

		rcError.ICSECODI := inuICSECODI;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuICSECODI
			 )
		then
			 return(rcData.ICSECODI);
		end if;
		Load
		(
		 		inuICSECODI
		);
		return(rcData.ICSECODI);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetICSESUEL
	(
		inuICSECODI in LDC_IMCOSEEL.ICSECODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_IMCOSEEL.ICSESUEL%type
	IS
		rcError styLDC_IMCOSEEL;
	BEGIN

		rcError.ICSECODI := inuICSECODI;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuICSECODI
			 )
		then
			 return(rcData.ICSESUEL);
		end if;
		Load
		(
		 		inuICSECODI
		);
		return(rcData.ICSESUEL);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetICSEELEM
	(
		inuICSECODI in LDC_IMCOSEEL.ICSECODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_IMCOSEEL.ICSEELEM%type
	IS
		rcError styLDC_IMCOSEEL;
	BEGIN

		rcError.ICSECODI := inuICSECODI;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuICSECODI
			 )
		then
			 return(rcData.ICSEELEM);
		end if;
		Load
		(
		 		inuICSECODI
		);
		return(rcData.ICSEELEM);
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
end DALDC_IMCOSEEL;
/
PROMPT Otorgando permisos de ejecucion a DALDC_IMCOSEEL
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_IMCOSEEL', 'ADM_PERSON');
END;
/