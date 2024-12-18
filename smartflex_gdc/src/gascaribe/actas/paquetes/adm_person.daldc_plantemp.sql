CREATE OR REPLACE PACKAGE ADM_PERSON.DALDC_PLANTEMP
is  
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     : DALDC_PLANTEMP
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
		inuPLTECODI in LDC_PLANTEMP.PLTECODI%type
	)
	IS
		SELECT LDC_PLANTEMP.*,LDC_PLANTEMP.rowid
		FROM LDC_PLANTEMP
		WHERE
		    PLTECODI = inuPLTECODI;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_PLANTEMP.*,LDC_PLANTEMP.rowid
		FROM LDC_PLANTEMP
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_PLANTEMP  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_PLANTEMP is table of styLDC_PLANTEMP index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_PLANTEMP;

	/* Tipos referenciando al registro */
	type tytbPLTECODI is table of LDC_PLANTEMP.PLTECODI%type index by binary_integer;
	type tytbPLTEXSTE is table of LDC_PLANTEMP.PLTEXSTE%type index by binary_integer;
	type tytbPLTEVATE is table of LDC_PLANTEMP.PLTEVATE%type index by binary_integer;
	type tytbPLTETIPO is table of LDC_PLANTEMP.PLTETIPO%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_PLANTEMP is record
	(
		PLTECODI   tytbPLTECODI,
		PLTEXSTE   tytbPLTEXSTE,
		PLTEVATE   tytbPLTEVATE,
		PLTETIPO   tytbPLTETIPO,
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
		inuPLTECODI in LDC_PLANTEMP.PLTECODI%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuPLTECODI in LDC_PLANTEMP.PLTECODI%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuPLTECODI in LDC_PLANTEMP.PLTECODI%type
	);

	PROCEDURE getRecord
	(
		inuPLTECODI in LDC_PLANTEMP.PLTECODI%type,
		orcRecord out nocopy styLDC_PLANTEMP
	);

	FUNCTION frcGetRcData
	(
		inuPLTECODI in LDC_PLANTEMP.PLTECODI%type
	)
	RETURN styLDC_PLANTEMP;

	FUNCTION frcGetRcData
	RETURN styLDC_PLANTEMP;

	FUNCTION frcGetRecord
	(
		inuPLTECODI in LDC_PLANTEMP.PLTECODI%type
	)
	RETURN styLDC_PLANTEMP;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_PLANTEMP
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_PLANTEMP in styLDC_PLANTEMP
	);

	PROCEDURE insRecord
	(
		ircLDC_PLANTEMP in styLDC_PLANTEMP,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_PLANTEMP in out nocopy tytbLDC_PLANTEMP
	);

	PROCEDURE delRecord
	(
		inuPLTECODI in LDC_PLANTEMP.PLTECODI%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_PLANTEMP in out nocopy tytbLDC_PLANTEMP,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_PLANTEMP in styLDC_PLANTEMP,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_PLANTEMP in out nocopy tytbLDC_PLANTEMP,
		inuLock in number default 1
	);

	PROCEDURE updPLTEXSTE
	(
		inuPLTECODI in LDC_PLANTEMP.PLTECODI%type,
		inuPLTEXSTE$ in LDC_PLANTEMP.PLTEXSTE%type,
		inuLock in number default 0
	);

	PROCEDURE updPLTEVATE
	(
		inuPLTECODI in LDC_PLANTEMP.PLTECODI%type,
		inuPLTEVATE$ in LDC_PLANTEMP.PLTEVATE%type,
		inuLock in number default 0
	);

	PROCEDURE updPLTETIPO
	(
		inuPLTECODI in LDC_PLANTEMP.PLTECODI%type,
		isbPLTETIPO$ in LDC_PLANTEMP.PLTETIPO%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetPLTECODI
	(
		inuPLTECODI in LDC_PLANTEMP.PLTECODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PLANTEMP.PLTECODI%type;

	FUNCTION fnuGetPLTEXSTE
	(
		inuPLTECODI in LDC_PLANTEMP.PLTECODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PLANTEMP.PLTEXSTE%type;

	FUNCTION fnuGetPLTEVATE
	(
		inuPLTECODI in LDC_PLANTEMP.PLTECODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PLANTEMP.PLTEVATE%type;

	FUNCTION fsbGetPLTETIPO
	(
		inuPLTECODI in LDC_PLANTEMP.PLTECODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PLANTEMP.PLTETIPO%type;


	PROCEDURE LockByPk
	(
		inuPLTECODI in LDC_PLANTEMP.PLTECODI%type,
		orcLDC_PLANTEMP  out styLDC_PLANTEMP
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_PLANTEMP  out styLDC_PLANTEMP
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_PLANTEMP;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALDC_PLANTEMP
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_PLANTEMP';
	 cnuGeEntityId constant varchar2(30) := 8434; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuPLTECODI in LDC_PLANTEMP.PLTECODI%type
	)
	IS
		SELECT LDC_PLANTEMP.*,LDC_PLANTEMP.rowid
		FROM LDC_PLANTEMP
		WHERE  PLTECODI = inuPLTECODI
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_PLANTEMP.*,LDC_PLANTEMP.rowid
		FROM LDC_PLANTEMP
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_PLANTEMP is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_PLANTEMP;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_PLANTEMP default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.PLTECODI);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuPLTECODI in LDC_PLANTEMP.PLTECODI%type,
		orcLDC_PLANTEMP  out styLDC_PLANTEMP
	)
	IS
		rcError styLDC_PLANTEMP;
	BEGIN
		rcError.PLTECODI := inuPLTECODI;

		Open cuLockRcByPk
		(
			inuPLTECODI
		);

		fetch cuLockRcByPk into orcLDC_PLANTEMP;
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
		orcLDC_PLANTEMP  out styLDC_PLANTEMP
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_PLANTEMP;
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
		itbLDC_PLANTEMP  in out nocopy tytbLDC_PLANTEMP
	)
	IS
	BEGIN
			rcRecOfTab.PLTECODI.delete;
			rcRecOfTab.PLTEXSTE.delete;
			rcRecOfTab.PLTEVATE.delete;
			rcRecOfTab.PLTETIPO.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_PLANTEMP  in out nocopy tytbLDC_PLANTEMP,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_PLANTEMP);

		for n in itbLDC_PLANTEMP.first .. itbLDC_PLANTEMP.last loop
			rcRecOfTab.PLTECODI(n) := itbLDC_PLANTEMP(n).PLTECODI;
			rcRecOfTab.PLTEXSTE(n) := itbLDC_PLANTEMP(n).PLTEXSTE;
			rcRecOfTab.PLTEVATE(n) := itbLDC_PLANTEMP(n).PLTEVATE;
			rcRecOfTab.PLTETIPO(n) := itbLDC_PLANTEMP(n).PLTETIPO;
			rcRecOfTab.row_id(n) := itbLDC_PLANTEMP(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuPLTECODI in LDC_PLANTEMP.PLTECODI%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuPLTECODI
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
		inuPLTECODI in LDC_PLANTEMP.PLTECODI%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuPLTECODI = rcData.PLTECODI
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
		inuPLTECODI in LDC_PLANTEMP.PLTECODI%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuPLTECODI
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuPLTECODI in LDC_PLANTEMP.PLTECODI%type
	)
	IS
		rcError styLDC_PLANTEMP;
	BEGIN		rcError.PLTECODI:=inuPLTECODI;

		Load
		(
			inuPLTECODI
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
		inuPLTECODI in LDC_PLANTEMP.PLTECODI%type
	)
	IS
	BEGIN
		Load
		(
			inuPLTECODI
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuPLTECODI in LDC_PLANTEMP.PLTECODI%type,
		orcRecord out nocopy styLDC_PLANTEMP
	)
	IS
		rcError styLDC_PLANTEMP;
	BEGIN		rcError.PLTECODI:=inuPLTECODI;

		Load
		(
			inuPLTECODI
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuPLTECODI in LDC_PLANTEMP.PLTECODI%type
	)
	RETURN styLDC_PLANTEMP
	IS
		rcError styLDC_PLANTEMP;
	BEGIN
		rcError.PLTECODI:=inuPLTECODI;

		Load
		(
			inuPLTECODI
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuPLTECODI in LDC_PLANTEMP.PLTECODI%type
	)
	RETURN styLDC_PLANTEMP
	IS
		rcError styLDC_PLANTEMP;
	BEGIN
		rcError.PLTECODI:=inuPLTECODI;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuPLTECODI
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuPLTECODI
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_PLANTEMP
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_PLANTEMP
	)
	IS
		rfLDC_PLANTEMP tyrfLDC_PLANTEMP;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_PLANTEMP.*, LDC_PLANTEMP.rowid FROM LDC_PLANTEMP';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_PLANTEMP for sbFullQuery;

		fetch rfLDC_PLANTEMP bulk collect INTO otbResult;

		close rfLDC_PLANTEMP;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_PLANTEMP.*, LDC_PLANTEMP.rowid FROM LDC_PLANTEMP';
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
		ircLDC_PLANTEMP in styLDC_PLANTEMP
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_PLANTEMP,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_PLANTEMP in styLDC_PLANTEMP,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_PLANTEMP.PLTECODI is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|PLTECODI');
			raise ex.controlled_error;
		end if;

		insert into LDC_PLANTEMP
		(
			PLTECODI,
			PLTEXSTE,
			PLTEVATE,
			PLTETIPO
		)
		values
		(
			ircLDC_PLANTEMP.PLTECODI,
			ircLDC_PLANTEMP.PLTEXSTE,
			ircLDC_PLANTEMP.PLTEVATE,
			ircLDC_PLANTEMP.PLTETIPO
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_PLANTEMP));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_PLANTEMP in out nocopy tytbLDC_PLANTEMP
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_PLANTEMP,blUseRowID);
		forall n in iotbLDC_PLANTEMP.first..iotbLDC_PLANTEMP.last
			insert into LDC_PLANTEMP
			(
				PLTECODI,
				PLTEXSTE,
				PLTEVATE,
				PLTETIPO
			)
			values
			(
				rcRecOfTab.PLTECODI(n),
				rcRecOfTab.PLTEXSTE(n),
				rcRecOfTab.PLTEVATE(n),
				rcRecOfTab.PLTETIPO(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuPLTECODI in LDC_PLANTEMP.PLTECODI%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_PLANTEMP;
	BEGIN
		rcError.PLTECODI := inuPLTECODI;

		if inuLock=1 then
			LockByPk
			(
				inuPLTECODI,
				rcData
			);
		end if;


		delete
		from LDC_PLANTEMP
		where
       		PLTECODI=inuPLTECODI;
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
		rcError  styLDC_PLANTEMP;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_PLANTEMP
		where
			rowid = iriRowID
		returning
			PLTECODI
		into
			rcError.PLTECODI;
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
		iotbLDC_PLANTEMP in out nocopy tytbLDC_PLANTEMP,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_PLANTEMP;
	BEGIN
		FillRecordOfTables(iotbLDC_PLANTEMP, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_PLANTEMP.first .. iotbLDC_PLANTEMP.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_PLANTEMP.first .. iotbLDC_PLANTEMP.last
				delete
				from LDC_PLANTEMP
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_PLANTEMP.first .. iotbLDC_PLANTEMP.last loop
					LockByPk
					(
						rcRecOfTab.PLTECODI(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_PLANTEMP.first .. iotbLDC_PLANTEMP.last
				delete
				from LDC_PLANTEMP
				where
		         	PLTECODI = rcRecOfTab.PLTECODI(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_PLANTEMP in styLDC_PLANTEMP,
		inuLock in number default 0
	)
	IS
		nuPLTECODI	LDC_PLANTEMP.PLTECODI%type;
	BEGIN
		if ircLDC_PLANTEMP.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_PLANTEMP.rowid,rcData);
			end if;
			update LDC_PLANTEMP
			set
				PLTEXSTE = ircLDC_PLANTEMP.PLTEXSTE,
				PLTEVATE = ircLDC_PLANTEMP.PLTEVATE,
				PLTETIPO = ircLDC_PLANTEMP.PLTETIPO
			where
				rowid = ircLDC_PLANTEMP.rowid
			returning
				PLTECODI
			into
				nuPLTECODI;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_PLANTEMP.PLTECODI,
					rcData
				);
			end if;

			update LDC_PLANTEMP
			set
				PLTEXSTE = ircLDC_PLANTEMP.PLTEXSTE,
				PLTEVATE = ircLDC_PLANTEMP.PLTEVATE,
				PLTETIPO = ircLDC_PLANTEMP.PLTETIPO
			where
				PLTECODI = ircLDC_PLANTEMP.PLTECODI
			returning
				PLTECODI
			into
				nuPLTECODI;
		end if;
		if
			nuPLTECODI is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_PLANTEMP));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_PLANTEMP in out nocopy tytbLDC_PLANTEMP,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_PLANTEMP;
	BEGIN
		FillRecordOfTables(iotbLDC_PLANTEMP,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_PLANTEMP.first .. iotbLDC_PLANTEMP.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_PLANTEMP.first .. iotbLDC_PLANTEMP.last
				update LDC_PLANTEMP
				set
					PLTEXSTE = rcRecOfTab.PLTEXSTE(n),
					PLTEVATE = rcRecOfTab.PLTEVATE(n),
					PLTETIPO = rcRecOfTab.PLTETIPO(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_PLANTEMP.first .. iotbLDC_PLANTEMP.last loop
					LockByPk
					(
						rcRecOfTab.PLTECODI(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_PLANTEMP.first .. iotbLDC_PLANTEMP.last
				update LDC_PLANTEMP
				SET
					PLTEXSTE = rcRecOfTab.PLTEXSTE(n),
					PLTEVATE = rcRecOfTab.PLTEVATE(n),
					PLTETIPO = rcRecOfTab.PLTETIPO(n)
				where
					PLTECODI = rcRecOfTab.PLTECODI(n)
;
		end if;
	END;
	PROCEDURE updPLTEXSTE
	(
		inuPLTECODI in LDC_PLANTEMP.PLTECODI%type,
		inuPLTEXSTE$ in LDC_PLANTEMP.PLTEXSTE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_PLANTEMP;
	BEGIN
		rcError.PLTECODI := inuPLTECODI;
		if inuLock=1 then
			LockByPk
			(
				inuPLTECODI,
				rcData
			);
		end if;

		update LDC_PLANTEMP
		set
			PLTEXSTE = inuPLTEXSTE$
		where
			PLTECODI = inuPLTECODI;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PLTEXSTE:= inuPLTEXSTE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPLTEVATE
	(
		inuPLTECODI in LDC_PLANTEMP.PLTECODI%type,
		inuPLTEVATE$ in LDC_PLANTEMP.PLTEVATE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_PLANTEMP;
	BEGIN
		rcError.PLTECODI := inuPLTECODI;
		if inuLock=1 then
			LockByPk
			(
				inuPLTECODI,
				rcData
			);
		end if;

		update LDC_PLANTEMP
		set
			PLTEVATE = inuPLTEVATE$
		where
			PLTECODI = inuPLTECODI;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PLTEVATE:= inuPLTEVATE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPLTETIPO
	(
		inuPLTECODI in LDC_PLANTEMP.PLTECODI%type,
		isbPLTETIPO$ in LDC_PLANTEMP.PLTETIPO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_PLANTEMP;
	BEGIN
		rcError.PLTECODI := inuPLTECODI;
		if inuLock=1 then
			LockByPk
			(
				inuPLTECODI,
				rcData
			);
		end if;

		update LDC_PLANTEMP
		set
			PLTETIPO = isbPLTETIPO$
		where
			PLTECODI = inuPLTECODI;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PLTETIPO:= isbPLTETIPO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetPLTECODI
	(
		inuPLTECODI in LDC_PLANTEMP.PLTECODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PLANTEMP.PLTECODI%type
	IS
		rcError styLDC_PLANTEMP;
	BEGIN

		rcError.PLTECODI := inuPLTECODI;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPLTECODI
			 )
		then
			 return(rcData.PLTECODI);
		end if;
		Load
		(
		 		inuPLTECODI
		);
		return(rcData.PLTECODI);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetPLTEXSTE
	(
		inuPLTECODI in LDC_PLANTEMP.PLTECODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PLANTEMP.PLTEXSTE%type
	IS
		rcError styLDC_PLANTEMP;
	BEGIN

		rcError.PLTECODI := inuPLTECODI;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPLTECODI
			 )
		then
			 return(rcData.PLTEXSTE);
		end if;
		Load
		(
		 		inuPLTECODI
		);
		return(rcData.PLTEXSTE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetPLTEVATE
	(
		inuPLTECODI in LDC_PLANTEMP.PLTECODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PLANTEMP.PLTEVATE%type
	IS
		rcError styLDC_PLANTEMP;
	BEGIN

		rcError.PLTECODI := inuPLTECODI;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPLTECODI
			 )
		then
			 return(rcData.PLTEVATE);
		end if;
		Load
		(
		 		inuPLTECODI
		);
		return(rcData.PLTEVATE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetPLTETIPO
	(
		inuPLTECODI in LDC_PLANTEMP.PLTECODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PLANTEMP.PLTETIPO%type
	IS
		rcError styLDC_PLANTEMP;
	BEGIN

		rcError.PLTECODI := inuPLTECODI;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPLTECODI
			 )
		then
			 return(rcData.PLTETIPO);
		end if;
		Load
		(
		 		inuPLTECODI
		);
		return(rcData.PLTETIPO);
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
end DALDC_PLANTEMP;
/
PROMPT Otorgando permisos de ejecucion a DALDC_PLANTEMP
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_PLANTEMP', 'ADM_PERSON');
END;
/