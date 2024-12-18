CREATE OR REPLACE PACKAGE ADM_PERSON.DALDC_ANTIC_CONTR
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
    06/06/2024              PAcosta         OSF-2778: Cambio de esquema ADM_PERSON                              
    ****************************************************************/    
    
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuIDCONTRATO in LDC_ANTIC_CONTR.IDCONTRATO%type
	)
	IS
		SELECT LDC_ANTIC_CONTR.*,LDC_ANTIC_CONTR.rowid
		FROM LDC_ANTIC_CONTR
		WHERE
		    IDCONTRATO = inuIDCONTRATO;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_ANTIC_CONTR.*,LDC_ANTIC_CONTR.rowid
		FROM LDC_ANTIC_CONTR
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_ANTIC_CONTR  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_ANTIC_CONTR is table of styLDC_ANTIC_CONTR index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_ANTIC_CONTR;

	/* Tipos referenciando al registro */
	type tytbPORANTICIPO is table of LDC_ANTIC_CONTR.PORANTICIPO%type index by binary_integer;
	type tytbIDCONTRATO is table of LDC_ANTIC_CONTR.IDCONTRATO%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_ANTIC_CONTR is record
	(
		PORANTICIPO   tytbPORANTICIPO,
		IDCONTRATO   tytbIDCONTRATO,
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
		inuIDCONTRATO in LDC_ANTIC_CONTR.IDCONTRATO%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuIDCONTRATO in LDC_ANTIC_CONTR.IDCONTRATO%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuIDCONTRATO in LDC_ANTIC_CONTR.IDCONTRATO%type
	);

	PROCEDURE getRecord
	(
		inuIDCONTRATO in LDC_ANTIC_CONTR.IDCONTRATO%type,
		orcRecord out nocopy styLDC_ANTIC_CONTR
	);

	FUNCTION frcGetRcData
	(
		inuIDCONTRATO in LDC_ANTIC_CONTR.IDCONTRATO%type
	)
	RETURN styLDC_ANTIC_CONTR;

	FUNCTION frcGetRcData
	RETURN styLDC_ANTIC_CONTR;

	FUNCTION frcGetRecord
	(
		inuIDCONTRATO in LDC_ANTIC_CONTR.IDCONTRATO%type
	)
	RETURN styLDC_ANTIC_CONTR;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_ANTIC_CONTR
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_ANTIC_CONTR in styLDC_ANTIC_CONTR
	);

	PROCEDURE insRecord
	(
		ircLDC_ANTIC_CONTR in styLDC_ANTIC_CONTR,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_ANTIC_CONTR in out nocopy tytbLDC_ANTIC_CONTR
	);

	PROCEDURE delRecord
	(
		inuIDCONTRATO in LDC_ANTIC_CONTR.IDCONTRATO%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_ANTIC_CONTR in out nocopy tytbLDC_ANTIC_CONTR,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_ANTIC_CONTR in styLDC_ANTIC_CONTR,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_ANTIC_CONTR in out nocopy tytbLDC_ANTIC_CONTR,
		inuLock in number default 1
	);

	PROCEDURE updPORANTICIPO
	(
		inuIDCONTRATO in LDC_ANTIC_CONTR.IDCONTRATO%type,
		inuPORANTICIPO$ in LDC_ANTIC_CONTR.PORANTICIPO%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetPORANTICIPO
	(
		inuIDCONTRATO in LDC_ANTIC_CONTR.IDCONTRATO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ANTIC_CONTR.PORANTICIPO%type;

	FUNCTION fnuGetIDCONTRATO
	(
		inuIDCONTRATO in LDC_ANTIC_CONTR.IDCONTRATO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ANTIC_CONTR.IDCONTRATO%type;


	PROCEDURE LockByPk
	(
		inuIDCONTRATO in LDC_ANTIC_CONTR.IDCONTRATO%type,
		orcLDC_ANTIC_CONTR  out styLDC_ANTIC_CONTR
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_ANTIC_CONTR  out styLDC_ANTIC_CONTR
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_ANTIC_CONTR;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALDC_ANTIC_CONTR
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_ANTIC_CONTR';
	 cnuGeEntityId constant varchar2(30) := 373; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuIDCONTRATO in LDC_ANTIC_CONTR.IDCONTRATO%type
	)
	IS
		SELECT LDC_ANTIC_CONTR.*,LDC_ANTIC_CONTR.rowid
		FROM LDC_ANTIC_CONTR
		WHERE  IDCONTRATO = inuIDCONTRATO
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_ANTIC_CONTR.*,LDC_ANTIC_CONTR.rowid
		FROM LDC_ANTIC_CONTR
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_ANTIC_CONTR is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_ANTIC_CONTR;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_ANTIC_CONTR default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.IDCONTRATO);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuIDCONTRATO in LDC_ANTIC_CONTR.IDCONTRATO%type,
		orcLDC_ANTIC_CONTR  out styLDC_ANTIC_CONTR
	)
	IS
		rcError styLDC_ANTIC_CONTR;
	BEGIN
		rcError.IDCONTRATO := inuIDCONTRATO;

		Open cuLockRcByPk
		(
			inuIDCONTRATO
		);

		fetch cuLockRcByPk into orcLDC_ANTIC_CONTR;
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
		orcLDC_ANTIC_CONTR  out styLDC_ANTIC_CONTR
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_ANTIC_CONTR;
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
		itbLDC_ANTIC_CONTR  in out nocopy tytbLDC_ANTIC_CONTR
	)
	IS
	BEGIN
			rcRecOfTab.PORANTICIPO.delete;
			rcRecOfTab.IDCONTRATO.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_ANTIC_CONTR  in out nocopy tytbLDC_ANTIC_CONTR,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_ANTIC_CONTR);

		for n in itbLDC_ANTIC_CONTR.first .. itbLDC_ANTIC_CONTR.last loop
			rcRecOfTab.PORANTICIPO(n) := itbLDC_ANTIC_CONTR(n).PORANTICIPO;
			rcRecOfTab.IDCONTRATO(n) := itbLDC_ANTIC_CONTR(n).IDCONTRATO;
			rcRecOfTab.row_id(n) := itbLDC_ANTIC_CONTR(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuIDCONTRATO in LDC_ANTIC_CONTR.IDCONTRATO%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuIDCONTRATO
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
		inuIDCONTRATO in LDC_ANTIC_CONTR.IDCONTRATO%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuIDCONTRATO = rcData.IDCONTRATO
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
		inuIDCONTRATO in LDC_ANTIC_CONTR.IDCONTRATO%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuIDCONTRATO
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuIDCONTRATO in LDC_ANTIC_CONTR.IDCONTRATO%type
	)
	IS
		rcError styLDC_ANTIC_CONTR;
	BEGIN		rcError.IDCONTRATO:=inuIDCONTRATO;

		Load
		(
			inuIDCONTRATO
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
		inuIDCONTRATO in LDC_ANTIC_CONTR.IDCONTRATO%type
	)
	IS
	BEGIN
		Load
		(
			inuIDCONTRATO
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuIDCONTRATO in LDC_ANTIC_CONTR.IDCONTRATO%type,
		orcRecord out nocopy styLDC_ANTIC_CONTR
	)
	IS
		rcError styLDC_ANTIC_CONTR;
	BEGIN		rcError.IDCONTRATO:=inuIDCONTRATO;

		Load
		(
			inuIDCONTRATO
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuIDCONTRATO in LDC_ANTIC_CONTR.IDCONTRATO%type
	)
	RETURN styLDC_ANTIC_CONTR
	IS
		rcError styLDC_ANTIC_CONTR;
	BEGIN
		rcError.IDCONTRATO:=inuIDCONTRATO;

		Load
		(
			inuIDCONTRATO
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuIDCONTRATO in LDC_ANTIC_CONTR.IDCONTRATO%type
	)
	RETURN styLDC_ANTIC_CONTR
	IS
		rcError styLDC_ANTIC_CONTR;
	BEGIN
		rcError.IDCONTRATO:=inuIDCONTRATO;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuIDCONTRATO
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuIDCONTRATO
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_ANTIC_CONTR
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_ANTIC_CONTR
	)
	IS
		rfLDC_ANTIC_CONTR tyrfLDC_ANTIC_CONTR;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_ANTIC_CONTR.*, LDC_ANTIC_CONTR.rowid FROM LDC_ANTIC_CONTR';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_ANTIC_CONTR for sbFullQuery;

		fetch rfLDC_ANTIC_CONTR bulk collect INTO otbResult;

		close rfLDC_ANTIC_CONTR;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_ANTIC_CONTR.*, LDC_ANTIC_CONTR.rowid FROM LDC_ANTIC_CONTR';
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
		ircLDC_ANTIC_CONTR in styLDC_ANTIC_CONTR
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_ANTIC_CONTR,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_ANTIC_CONTR in styLDC_ANTIC_CONTR,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_ANTIC_CONTR.IDCONTRATO is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|IDCONTRATO');
			raise ex.controlled_error;
		end if;

		insert into LDC_ANTIC_CONTR
		(
			PORANTICIPO,
			IDCONTRATO
		)
		values
		(
			ircLDC_ANTIC_CONTR.PORANTICIPO,
			ircLDC_ANTIC_CONTR.IDCONTRATO
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_ANTIC_CONTR));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_ANTIC_CONTR in out nocopy tytbLDC_ANTIC_CONTR
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_ANTIC_CONTR,blUseRowID);
		forall n in iotbLDC_ANTIC_CONTR.first..iotbLDC_ANTIC_CONTR.last
			insert into LDC_ANTIC_CONTR
			(
				PORANTICIPO,
				IDCONTRATO
			)
			values
			(
				rcRecOfTab.PORANTICIPO(n),
				rcRecOfTab.IDCONTRATO(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuIDCONTRATO in LDC_ANTIC_CONTR.IDCONTRATO%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_ANTIC_CONTR;
	BEGIN
		rcError.IDCONTRATO := inuIDCONTRATO;

		if inuLock=1 then
			LockByPk
			(
				inuIDCONTRATO,
				rcData
			);
		end if;


		delete
		from LDC_ANTIC_CONTR
		where
       		IDCONTRATO=inuIDCONTRATO;
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
		rcError  styLDC_ANTIC_CONTR;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_ANTIC_CONTR
		where
			rowid = iriRowID
		returning
			PORANTICIPO
		into
			rcError.PORANTICIPO;
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
		iotbLDC_ANTIC_CONTR in out nocopy tytbLDC_ANTIC_CONTR,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_ANTIC_CONTR;
	BEGIN
		FillRecordOfTables(iotbLDC_ANTIC_CONTR, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_ANTIC_CONTR.first .. iotbLDC_ANTIC_CONTR.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ANTIC_CONTR.first .. iotbLDC_ANTIC_CONTR.last
				delete
				from LDC_ANTIC_CONTR
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_ANTIC_CONTR.first .. iotbLDC_ANTIC_CONTR.last loop
					LockByPk
					(
						rcRecOfTab.IDCONTRATO(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ANTIC_CONTR.first .. iotbLDC_ANTIC_CONTR.last
				delete
				from LDC_ANTIC_CONTR
				where
		         	IDCONTRATO = rcRecOfTab.IDCONTRATO(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_ANTIC_CONTR in styLDC_ANTIC_CONTR,
		inuLock in number default 0
	)
	IS
		nuIDCONTRATO	LDC_ANTIC_CONTR.IDCONTRATO%type;
	BEGIN
		if ircLDC_ANTIC_CONTR.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_ANTIC_CONTR.rowid,rcData);
			end if;
			update LDC_ANTIC_CONTR
			set
				PORANTICIPO = ircLDC_ANTIC_CONTR.PORANTICIPO
			where
				rowid = ircLDC_ANTIC_CONTR.rowid
			returning
				IDCONTRATO
			into
				nuIDCONTRATO;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_ANTIC_CONTR.IDCONTRATO,
					rcData
				);
			end if;

			update LDC_ANTIC_CONTR
			set
				PORANTICIPO = ircLDC_ANTIC_CONTR.PORANTICIPO
			where
				IDCONTRATO = ircLDC_ANTIC_CONTR.IDCONTRATO
			returning
				IDCONTRATO
			into
				nuIDCONTRATO;
		end if;
		if
			nuIDCONTRATO is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_ANTIC_CONTR));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_ANTIC_CONTR in out nocopy tytbLDC_ANTIC_CONTR,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_ANTIC_CONTR;
	BEGIN
		FillRecordOfTables(iotbLDC_ANTIC_CONTR,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_ANTIC_CONTR.first .. iotbLDC_ANTIC_CONTR.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ANTIC_CONTR.first .. iotbLDC_ANTIC_CONTR.last
				update LDC_ANTIC_CONTR
				set
					PORANTICIPO = rcRecOfTab.PORANTICIPO(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_ANTIC_CONTR.first .. iotbLDC_ANTIC_CONTR.last loop
					LockByPk
					(
						rcRecOfTab.IDCONTRATO(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ANTIC_CONTR.first .. iotbLDC_ANTIC_CONTR.last
				update LDC_ANTIC_CONTR
				SET
					PORANTICIPO = rcRecOfTab.PORANTICIPO(n)
				where
					IDCONTRATO = rcRecOfTab.IDCONTRATO(n)
;
		end if;
	END;
	PROCEDURE updPORANTICIPO
	(
		inuIDCONTRATO in LDC_ANTIC_CONTR.IDCONTRATO%type,
		inuPORANTICIPO$ in LDC_ANTIC_CONTR.PORANTICIPO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ANTIC_CONTR;
	BEGIN
		rcError.IDCONTRATO := inuIDCONTRATO;
		if inuLock=1 then
			LockByPk
			(
				inuIDCONTRATO,
				rcData
			);
		end if;

		update LDC_ANTIC_CONTR
		set
			PORANTICIPO = inuPORANTICIPO$
		where
			IDCONTRATO = inuIDCONTRATO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PORANTICIPO:= inuPORANTICIPO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetPORANTICIPO
	(
		inuIDCONTRATO in LDC_ANTIC_CONTR.IDCONTRATO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ANTIC_CONTR.PORANTICIPO%type
	IS
		rcError styLDC_ANTIC_CONTR;
	BEGIN

		rcError.IDCONTRATO := inuIDCONTRATO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuIDCONTRATO
			 )
		then
			 return(rcData.PORANTICIPO);
		end if;
		Load
		(
		 		inuIDCONTRATO
		);
		return(rcData.PORANTICIPO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetIDCONTRATO
	(
		inuIDCONTRATO in LDC_ANTIC_CONTR.IDCONTRATO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ANTIC_CONTR.IDCONTRATO%type
	IS
		rcError styLDC_ANTIC_CONTR;
	BEGIN

		rcError.IDCONTRATO := inuIDCONTRATO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuIDCONTRATO
			 )
		then
			 return(rcData.IDCONTRATO);
		end if;
		Load
		(
		 		inuIDCONTRATO
		);
		return(rcData.IDCONTRATO);
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
end DALDC_ANTIC_CONTR;
/
PROMPT Otorgando permisos de ejecucion a DALDC_ANTIC_CONTR
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_ANTIC_CONTR', 'ADM_PERSON');
END;
/