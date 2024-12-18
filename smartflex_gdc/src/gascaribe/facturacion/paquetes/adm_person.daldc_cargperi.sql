CREATE OR REPLACE PACKAGE ADM_PERSON.DALDC_CARGPERI
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
		inuCAPECODI in LDC_CARGPERI.CAPECODI%type
	)
	IS
		SELECT LDC_CARGPERI.*,LDC_CARGPERI.rowid
		FROM LDC_CARGPERI
		WHERE
		    CAPECODI = inuCAPECODI;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_CARGPERI.*,LDC_CARGPERI.rowid
		FROM LDC_CARGPERI
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_CARGPERI  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_CARGPERI is table of styLDC_CARGPERI index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_CARGPERI;

	/* Tipos referenciando al registro */
	type tytbCAPECODI is table of LDC_CARGPERI.CAPECODI%type index by binary_integer;
	type tytbCAPENAME is table of LDC_CARGPERI.CAPENAME%type index by binary_integer;
	type tytbCAPEEVEN is table of LDC_CARGPERI.CAPEEVEN%type index by binary_integer;
	type tytbCAPECANT is table of LDC_CARGPERI.CAPECANT%type index by binary_integer;
	type tytbCAPERUTA is table of LDC_CARGPERI.CAPERUTA%type index by binary_integer;
	type tytbCAPEDATE is table of LDC_CARGPERI.CAPEDATE%type index by binary_integer;
	type tytbCAPEUSER is table of LDC_CARGPERI.CAPEUSER%type index by binary_integer;
	type tytbCAPETERM is table of LDC_CARGPERI.CAPETERM%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_CARGPERI is record
	(
		CAPECODI   tytbCAPECODI,
		CAPENAME   tytbCAPENAME,
		CAPEEVEN   tytbCAPEEVEN,
		CAPECANT   tytbCAPECANT,
		CAPERUTA   tytbCAPERUTA,
		CAPEDATE   tytbCAPEDATE,
		CAPEUSER   tytbCAPEUSER,
		CAPETERM   tytbCAPETERM,
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
		inuCAPECODI in LDC_CARGPERI.CAPECODI%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuCAPECODI in LDC_CARGPERI.CAPECODI%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuCAPECODI in LDC_CARGPERI.CAPECODI%type
	);

	PROCEDURE getRecord
	(
		inuCAPECODI in LDC_CARGPERI.CAPECODI%type,
		orcRecord out nocopy styLDC_CARGPERI
	);

	FUNCTION frcGetRcData
	(
		inuCAPECODI in LDC_CARGPERI.CAPECODI%type
	)
	RETURN styLDC_CARGPERI;

	FUNCTION frcGetRcData
	RETURN styLDC_CARGPERI;

	FUNCTION frcGetRecord
	(
		inuCAPECODI in LDC_CARGPERI.CAPECODI%type
	)
	RETURN styLDC_CARGPERI;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_CARGPERI
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_CARGPERI in styLDC_CARGPERI
	);

	PROCEDURE insRecord
	(
		ircLDC_CARGPERI in styLDC_CARGPERI,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_CARGPERI in out nocopy tytbLDC_CARGPERI
	);

	PROCEDURE delRecord
	(
		inuCAPECODI in LDC_CARGPERI.CAPECODI%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_CARGPERI in out nocopy tytbLDC_CARGPERI,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_CARGPERI in styLDC_CARGPERI,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_CARGPERI in out nocopy tytbLDC_CARGPERI,
		inuLock in number default 1
	);

	PROCEDURE updCAPENAME
	(
		inuCAPECODI in LDC_CARGPERI.CAPECODI%type,
		isbCAPENAME$ in LDC_CARGPERI.CAPENAME%type,
		inuLock in number default 0
	);

	PROCEDURE updCAPEEVEN
	(
		inuCAPECODI in LDC_CARGPERI.CAPECODI%type,
		isbCAPEEVEN$ in LDC_CARGPERI.CAPEEVEN%type,
		inuLock in number default 0
	);

	PROCEDURE updCAPECANT
	(
		inuCAPECODI in LDC_CARGPERI.CAPECODI%type,
		inuCAPECANT$ in LDC_CARGPERI.CAPECANT%type,
		inuLock in number default 0
	);

	PROCEDURE updCAPERUTA
	(
		inuCAPECODI in LDC_CARGPERI.CAPECODI%type,
		isbCAPERUTA$ in LDC_CARGPERI.CAPERUTA%type,
		inuLock in number default 0
	);

	PROCEDURE updCAPEDATE
	(
		inuCAPECODI in LDC_CARGPERI.CAPECODI%type,
		idtCAPEDATE$ in LDC_CARGPERI.CAPEDATE%type,
		inuLock in number default 0
	);

	PROCEDURE updCAPEUSER
	(
		inuCAPECODI in LDC_CARGPERI.CAPECODI%type,
		isbCAPEUSER$ in LDC_CARGPERI.CAPEUSER%type,
		inuLock in number default 0
	);

	PROCEDURE updCAPETERM
	(
		inuCAPECODI in LDC_CARGPERI.CAPECODI%type,
		isbCAPETERM$ in LDC_CARGPERI.CAPETERM%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetCAPECODI
	(
		inuCAPECODI in LDC_CARGPERI.CAPECODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CARGPERI.CAPECODI%type;

	FUNCTION fsbGetCAPENAME
	(
		inuCAPECODI in LDC_CARGPERI.CAPECODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CARGPERI.CAPENAME%type;

	FUNCTION fsbGetCAPEEVEN
	(
		inuCAPECODI in LDC_CARGPERI.CAPECODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CARGPERI.CAPEEVEN%type;

	FUNCTION fnuGetCAPECANT
	(
		inuCAPECODI in LDC_CARGPERI.CAPECODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CARGPERI.CAPECANT%type;

	FUNCTION fsbGetCAPERUTA
	(
		inuCAPECODI in LDC_CARGPERI.CAPECODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CARGPERI.CAPERUTA%type;

	FUNCTION fdtGetCAPEDATE
	(
		inuCAPECODI in LDC_CARGPERI.CAPECODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CARGPERI.CAPEDATE%type;

	FUNCTION fsbGetCAPEUSER
	(
		inuCAPECODI in LDC_CARGPERI.CAPECODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CARGPERI.CAPEUSER%type;

	FUNCTION fsbGetCAPETERM
	(
		inuCAPECODI in LDC_CARGPERI.CAPECODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CARGPERI.CAPETERM%type;


	PROCEDURE LockByPk
	(
		inuCAPECODI in LDC_CARGPERI.CAPECODI%type,
		orcLDC_CARGPERI  out styLDC_CARGPERI
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_CARGPERI  out styLDC_CARGPERI
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_CARGPERI;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALDC_CARGPERI
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_CARGPERI';
	 cnuGeEntityId constant varchar2(30) := 4505; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuCAPECODI in LDC_CARGPERI.CAPECODI%type
	)
	IS
		SELECT LDC_CARGPERI.*,LDC_CARGPERI.rowid
		FROM LDC_CARGPERI
		WHERE  CAPECODI = inuCAPECODI
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_CARGPERI.*,LDC_CARGPERI.rowid
		FROM LDC_CARGPERI
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_CARGPERI is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_CARGPERI;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_CARGPERI default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.CAPECODI);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuCAPECODI in LDC_CARGPERI.CAPECODI%type,
		orcLDC_CARGPERI  out styLDC_CARGPERI
	)
	IS
		rcError styLDC_CARGPERI;
	BEGIN
		rcError.CAPECODI := inuCAPECODI;

		Open cuLockRcByPk
		(
			inuCAPECODI
		);

		fetch cuLockRcByPk into orcLDC_CARGPERI;
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
		orcLDC_CARGPERI  out styLDC_CARGPERI
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_CARGPERI;
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
		itbLDC_CARGPERI  in out nocopy tytbLDC_CARGPERI
	)
	IS
	BEGIN
			rcRecOfTab.CAPECODI.delete;
			rcRecOfTab.CAPENAME.delete;
			rcRecOfTab.CAPEEVEN.delete;
			rcRecOfTab.CAPECANT.delete;
			rcRecOfTab.CAPERUTA.delete;
			rcRecOfTab.CAPEDATE.delete;
			rcRecOfTab.CAPEUSER.delete;
			rcRecOfTab.CAPETERM.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_CARGPERI  in out nocopy tytbLDC_CARGPERI,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_CARGPERI);

		for n in itbLDC_CARGPERI.first .. itbLDC_CARGPERI.last loop
			rcRecOfTab.CAPECODI(n) := itbLDC_CARGPERI(n).CAPECODI;
			rcRecOfTab.CAPENAME(n) := itbLDC_CARGPERI(n).CAPENAME;
			rcRecOfTab.CAPEEVEN(n) := itbLDC_CARGPERI(n).CAPEEVEN;
			rcRecOfTab.CAPECANT(n) := itbLDC_CARGPERI(n).CAPECANT;
			rcRecOfTab.CAPERUTA(n) := itbLDC_CARGPERI(n).CAPERUTA;
			rcRecOfTab.CAPEDATE(n) := itbLDC_CARGPERI(n).CAPEDATE;
			rcRecOfTab.CAPEUSER(n) := itbLDC_CARGPERI(n).CAPEUSER;
			rcRecOfTab.CAPETERM(n) := itbLDC_CARGPERI(n).CAPETERM;
			rcRecOfTab.row_id(n) := itbLDC_CARGPERI(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuCAPECODI in LDC_CARGPERI.CAPECODI%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuCAPECODI
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
		inuCAPECODI in LDC_CARGPERI.CAPECODI%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuCAPECODI = rcData.CAPECODI
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
		inuCAPECODI in LDC_CARGPERI.CAPECODI%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuCAPECODI
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuCAPECODI in LDC_CARGPERI.CAPECODI%type
	)
	IS
		rcError styLDC_CARGPERI;
	BEGIN		rcError.CAPECODI:=inuCAPECODI;

		Load
		(
			inuCAPECODI
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
		inuCAPECODI in LDC_CARGPERI.CAPECODI%type
	)
	IS
	BEGIN
		Load
		(
			inuCAPECODI
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuCAPECODI in LDC_CARGPERI.CAPECODI%type,
		orcRecord out nocopy styLDC_CARGPERI
	)
	IS
		rcError styLDC_CARGPERI;
	BEGIN		rcError.CAPECODI:=inuCAPECODI;

		Load
		(
			inuCAPECODI
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuCAPECODI in LDC_CARGPERI.CAPECODI%type
	)
	RETURN styLDC_CARGPERI
	IS
		rcError styLDC_CARGPERI;
	BEGIN
		rcError.CAPECODI:=inuCAPECODI;

		Load
		(
			inuCAPECODI
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuCAPECODI in LDC_CARGPERI.CAPECODI%type
	)
	RETURN styLDC_CARGPERI
	IS
		rcError styLDC_CARGPERI;
	BEGIN
		rcError.CAPECODI:=inuCAPECODI;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuCAPECODI
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuCAPECODI
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_CARGPERI
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_CARGPERI
	)
	IS
		rfLDC_CARGPERI tyrfLDC_CARGPERI;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_CARGPERI.*, LDC_CARGPERI.rowid FROM LDC_CARGPERI';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_CARGPERI for sbFullQuery;

		fetch rfLDC_CARGPERI bulk collect INTO otbResult;

		close rfLDC_CARGPERI;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_CARGPERI.*, LDC_CARGPERI.rowid FROM LDC_CARGPERI';
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
		ircLDC_CARGPERI in styLDC_CARGPERI
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_CARGPERI,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_CARGPERI in styLDC_CARGPERI,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_CARGPERI.CAPECODI is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|CAPECODI');
			raise ex.controlled_error;
		end if;

		insert into LDC_CARGPERI
		(
			CAPECODI,
			CAPENAME,
			CAPEEVEN,
			CAPECANT,
			CAPERUTA,
			CAPEDATE,
			CAPEUSER,
			CAPETERM
		)
		values
		(
			ircLDC_CARGPERI.CAPECODI,
			ircLDC_CARGPERI.CAPENAME,
			ircLDC_CARGPERI.CAPEEVEN,
			ircLDC_CARGPERI.CAPECANT,
			ircLDC_CARGPERI.CAPERUTA,
			ircLDC_CARGPERI.CAPEDATE,
			ircLDC_CARGPERI.CAPEUSER,
			ircLDC_CARGPERI.CAPETERM
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_CARGPERI));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_CARGPERI in out nocopy tytbLDC_CARGPERI
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_CARGPERI,blUseRowID);
		forall n in iotbLDC_CARGPERI.first..iotbLDC_CARGPERI.last
			insert into LDC_CARGPERI
			(
				CAPECODI,
				CAPENAME,
				CAPEEVEN,
				CAPECANT,
				CAPERUTA,
				CAPEDATE,
				CAPEUSER,
				CAPETERM
			)
			values
			(
				rcRecOfTab.CAPECODI(n),
				rcRecOfTab.CAPENAME(n),
				rcRecOfTab.CAPEEVEN(n),
				rcRecOfTab.CAPECANT(n),
				rcRecOfTab.CAPERUTA(n),
				rcRecOfTab.CAPEDATE(n),
				rcRecOfTab.CAPEUSER(n),
				rcRecOfTab.CAPETERM(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuCAPECODI in LDC_CARGPERI.CAPECODI%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_CARGPERI;
	BEGIN
		rcError.CAPECODI := inuCAPECODI;

		if inuLock=1 then
			LockByPk
			(
				inuCAPECODI,
				rcData
			);
		end if;


		delete
		from LDC_CARGPERI
		where
       		CAPECODI=inuCAPECODI;
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
		rcError  styLDC_CARGPERI;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_CARGPERI
		where
			rowid = iriRowID
		returning
			CAPECODI
		into
			rcError.CAPECODI;
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
		iotbLDC_CARGPERI in out nocopy tytbLDC_CARGPERI,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_CARGPERI;
	BEGIN
		FillRecordOfTables(iotbLDC_CARGPERI, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_CARGPERI.first .. iotbLDC_CARGPERI.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CARGPERI.first .. iotbLDC_CARGPERI.last
				delete
				from LDC_CARGPERI
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_CARGPERI.first .. iotbLDC_CARGPERI.last loop
					LockByPk
					(
						rcRecOfTab.CAPECODI(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CARGPERI.first .. iotbLDC_CARGPERI.last
				delete
				from LDC_CARGPERI
				where
		         	CAPECODI = rcRecOfTab.CAPECODI(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_CARGPERI in styLDC_CARGPERI,
		inuLock in number default 0
	)
	IS
		nuCAPECODI	LDC_CARGPERI.CAPECODI%type;
	BEGIN
		if ircLDC_CARGPERI.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_CARGPERI.rowid,rcData);
			end if;
			update LDC_CARGPERI
			set
				CAPENAME = ircLDC_CARGPERI.CAPENAME,
				CAPEEVEN = ircLDC_CARGPERI.CAPEEVEN,
				CAPECANT = ircLDC_CARGPERI.CAPECANT,
				CAPERUTA = ircLDC_CARGPERI.CAPERUTA,
				CAPEDATE = ircLDC_CARGPERI.CAPEDATE,
				CAPEUSER = ircLDC_CARGPERI.CAPEUSER,
				CAPETERM = ircLDC_CARGPERI.CAPETERM
			where
				rowid = ircLDC_CARGPERI.rowid
			returning
				CAPECODI
			into
				nuCAPECODI;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_CARGPERI.CAPECODI,
					rcData
				);
			end if;

			update LDC_CARGPERI
			set
				CAPENAME = ircLDC_CARGPERI.CAPENAME,
				CAPEEVEN = ircLDC_CARGPERI.CAPEEVEN,
				CAPECANT = ircLDC_CARGPERI.CAPECANT,
				CAPERUTA = ircLDC_CARGPERI.CAPERUTA,
				CAPEDATE = ircLDC_CARGPERI.CAPEDATE,
				CAPEUSER = ircLDC_CARGPERI.CAPEUSER,
				CAPETERM = ircLDC_CARGPERI.CAPETERM
			where
				CAPECODI = ircLDC_CARGPERI.CAPECODI
			returning
				CAPECODI
			into
				nuCAPECODI;
		end if;
		if
			nuCAPECODI is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_CARGPERI));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_CARGPERI in out nocopy tytbLDC_CARGPERI,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_CARGPERI;
	BEGIN
		FillRecordOfTables(iotbLDC_CARGPERI,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_CARGPERI.first .. iotbLDC_CARGPERI.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CARGPERI.first .. iotbLDC_CARGPERI.last
				update LDC_CARGPERI
				set
					CAPENAME = rcRecOfTab.CAPENAME(n),
					CAPEEVEN = rcRecOfTab.CAPEEVEN(n),
					CAPECANT = rcRecOfTab.CAPECANT(n),
					CAPERUTA = rcRecOfTab.CAPERUTA(n),
					CAPEDATE = rcRecOfTab.CAPEDATE(n),
					CAPEUSER = rcRecOfTab.CAPEUSER(n),
					CAPETERM = rcRecOfTab.CAPETERM(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_CARGPERI.first .. iotbLDC_CARGPERI.last loop
					LockByPk
					(
						rcRecOfTab.CAPECODI(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CARGPERI.first .. iotbLDC_CARGPERI.last
				update LDC_CARGPERI
				SET
					CAPENAME = rcRecOfTab.CAPENAME(n),
					CAPEEVEN = rcRecOfTab.CAPEEVEN(n),
					CAPECANT = rcRecOfTab.CAPECANT(n),
					CAPERUTA = rcRecOfTab.CAPERUTA(n),
					CAPEDATE = rcRecOfTab.CAPEDATE(n),
					CAPEUSER = rcRecOfTab.CAPEUSER(n),
					CAPETERM = rcRecOfTab.CAPETERM(n)
				where
					CAPECODI = rcRecOfTab.CAPECODI(n)
;
		end if;
	END;
	PROCEDURE updCAPENAME
	(
		inuCAPECODI in LDC_CARGPERI.CAPECODI%type,
		isbCAPENAME$ in LDC_CARGPERI.CAPENAME%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CARGPERI;
	BEGIN
		rcError.CAPECODI := inuCAPECODI;
		if inuLock=1 then
			LockByPk
			(
				inuCAPECODI,
				rcData
			);
		end if;

		update LDC_CARGPERI
		set
			CAPENAME = isbCAPENAME$
		where
			CAPECODI = inuCAPECODI;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CAPENAME:= isbCAPENAME$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCAPEEVEN
	(
		inuCAPECODI in LDC_CARGPERI.CAPECODI%type,
		isbCAPEEVEN$ in LDC_CARGPERI.CAPEEVEN%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CARGPERI;
	BEGIN
		rcError.CAPECODI := inuCAPECODI;
		if inuLock=1 then
			LockByPk
			(
				inuCAPECODI,
				rcData
			);
		end if;

		update LDC_CARGPERI
		set
			CAPEEVEN = isbCAPEEVEN$
		where
			CAPECODI = inuCAPECODI;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CAPEEVEN:= isbCAPEEVEN$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCAPECANT
	(
		inuCAPECODI in LDC_CARGPERI.CAPECODI%type,
		inuCAPECANT$ in LDC_CARGPERI.CAPECANT%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CARGPERI;
	BEGIN
		rcError.CAPECODI := inuCAPECODI;
		if inuLock=1 then
			LockByPk
			(
				inuCAPECODI,
				rcData
			);
		end if;

		update LDC_CARGPERI
		set
			CAPECANT = inuCAPECANT$
		where
			CAPECODI = inuCAPECODI;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CAPECANT:= inuCAPECANT$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCAPERUTA
	(
		inuCAPECODI in LDC_CARGPERI.CAPECODI%type,
		isbCAPERUTA$ in LDC_CARGPERI.CAPERUTA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CARGPERI;
	BEGIN
		rcError.CAPECODI := inuCAPECODI;
		if inuLock=1 then
			LockByPk
			(
				inuCAPECODI,
				rcData
			);
		end if;

		update LDC_CARGPERI
		set
			CAPERUTA = isbCAPERUTA$
		where
			CAPECODI = inuCAPECODI;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CAPERUTA:= isbCAPERUTA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCAPEDATE
	(
		inuCAPECODI in LDC_CARGPERI.CAPECODI%type,
		idtCAPEDATE$ in LDC_CARGPERI.CAPEDATE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CARGPERI;
	BEGIN
		rcError.CAPECODI := inuCAPECODI;
		if inuLock=1 then
			LockByPk
			(
				inuCAPECODI,
				rcData
			);
		end if;

		update LDC_CARGPERI
		set
			CAPEDATE = idtCAPEDATE$
		where
			CAPECODI = inuCAPECODI;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CAPEDATE:= idtCAPEDATE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCAPEUSER
	(
		inuCAPECODI in LDC_CARGPERI.CAPECODI%type,
		isbCAPEUSER$ in LDC_CARGPERI.CAPEUSER%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CARGPERI;
	BEGIN
		rcError.CAPECODI := inuCAPECODI;
		if inuLock=1 then
			LockByPk
			(
				inuCAPECODI,
				rcData
			);
		end if;

		update LDC_CARGPERI
		set
			CAPEUSER = isbCAPEUSER$
		where
			CAPECODI = inuCAPECODI;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CAPEUSER:= isbCAPEUSER$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCAPETERM
	(
		inuCAPECODI in LDC_CARGPERI.CAPECODI%type,
		isbCAPETERM$ in LDC_CARGPERI.CAPETERM%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CARGPERI;
	BEGIN
		rcError.CAPECODI := inuCAPECODI;
		if inuLock=1 then
			LockByPk
			(
				inuCAPECODI,
				rcData
			);
		end if;

		update LDC_CARGPERI
		set
			CAPETERM = isbCAPETERM$
		where
			CAPECODI = inuCAPECODI;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CAPETERM:= isbCAPETERM$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetCAPECODI
	(
		inuCAPECODI in LDC_CARGPERI.CAPECODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CARGPERI.CAPECODI%type
	IS
		rcError styLDC_CARGPERI;
	BEGIN

		rcError.CAPECODI := inuCAPECODI;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCAPECODI
			 )
		then
			 return(rcData.CAPECODI);
		end if;
		Load
		(
		 		inuCAPECODI
		);
		return(rcData.CAPECODI);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetCAPENAME
	(
		inuCAPECODI in LDC_CARGPERI.CAPECODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CARGPERI.CAPENAME%type
	IS
		rcError styLDC_CARGPERI;
	BEGIN

		rcError.CAPECODI := inuCAPECODI;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCAPECODI
			 )
		then
			 return(rcData.CAPENAME);
		end if;
		Load
		(
		 		inuCAPECODI
		);
		return(rcData.CAPENAME);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetCAPEEVEN
	(
		inuCAPECODI in LDC_CARGPERI.CAPECODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CARGPERI.CAPEEVEN%type
	IS
		rcError styLDC_CARGPERI;
	BEGIN

		rcError.CAPECODI := inuCAPECODI;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCAPECODI
			 )
		then
			 return(rcData.CAPEEVEN);
		end if;
		Load
		(
		 		inuCAPECODI
		);
		return(rcData.CAPEEVEN);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCAPECANT
	(
		inuCAPECODI in LDC_CARGPERI.CAPECODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CARGPERI.CAPECANT%type
	IS
		rcError styLDC_CARGPERI;
	BEGIN

		rcError.CAPECODI := inuCAPECODI;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCAPECODI
			 )
		then
			 return(rcData.CAPECANT);
		end if;
		Load
		(
		 		inuCAPECODI
		);
		return(rcData.CAPECANT);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetCAPERUTA
	(
		inuCAPECODI in LDC_CARGPERI.CAPECODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CARGPERI.CAPERUTA%type
	IS
		rcError styLDC_CARGPERI;
	BEGIN

		rcError.CAPECODI := inuCAPECODI;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCAPECODI
			 )
		then
			 return(rcData.CAPERUTA);
		end if;
		Load
		(
		 		inuCAPECODI
		);
		return(rcData.CAPERUTA);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetCAPEDATE
	(
		inuCAPECODI in LDC_CARGPERI.CAPECODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CARGPERI.CAPEDATE%type
	IS
		rcError styLDC_CARGPERI;
	BEGIN

		rcError.CAPECODI := inuCAPECODI;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCAPECODI
			 )
		then
			 return(rcData.CAPEDATE);
		end if;
		Load
		(
		 		inuCAPECODI
		);
		return(rcData.CAPEDATE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetCAPEUSER
	(
		inuCAPECODI in LDC_CARGPERI.CAPECODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CARGPERI.CAPEUSER%type
	IS
		rcError styLDC_CARGPERI;
	BEGIN

		rcError.CAPECODI := inuCAPECODI;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCAPECODI
			 )
		then
			 return(rcData.CAPEUSER);
		end if;
		Load
		(
		 		inuCAPECODI
		);
		return(rcData.CAPEUSER);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetCAPETERM
	(
		inuCAPECODI in LDC_CARGPERI.CAPECODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CARGPERI.CAPETERM%type
	IS
		rcError styLDC_CARGPERI;
	BEGIN

		rcError.CAPECODI := inuCAPECODI;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCAPECODI
			 )
		then
			 return(rcData.CAPETERM);
		end if;
		Load
		(
		 		inuCAPECODI
		);
		return(rcData.CAPETERM);
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
end DALDC_CARGPERI;
/
PROMPT Otorgando permisos de ejecucion a DALDC_CARGPERI
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_CARGPERI', 'ADM_PERSON');
END;
/