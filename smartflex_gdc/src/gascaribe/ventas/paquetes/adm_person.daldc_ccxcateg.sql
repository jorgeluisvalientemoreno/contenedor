CREATE OR REPLACE PACKAGE adm_person.daldc_ccxcateg
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  11/06/2024   Adrianavg   OSF-2813: Migrar del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuCCXCATEG_ID in LDC_CCXCATEG.CCXCATEG_ID%type
	)
	IS
		SELECT LDC_CCXCATEG.*,LDC_CCXCATEG.rowid
		FROM LDC_CCXCATEG
		WHERE
		    CCXCATEG_ID = inuCCXCATEG_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_CCXCATEG.*,LDC_CCXCATEG.rowid
		FROM LDC_CCXCATEG
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_CCXCATEG  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_CCXCATEG is table of styLDC_CCXCATEG index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_CCXCATEG;

	/* Tipos referenciando al registro */
	type tytbCCXCATEG_ID is table of LDC_CCXCATEG.CCXCATEG_ID%type index by binary_integer;
	type tytbCATEANT is table of LDC_CCXCATEG.CATEANT%type index by binary_integer;
	type tytbPLCOMANT is table of LDC_CCXCATEG.PLCOMANT%type index by binary_integer;
	type tytbCATEACT is table of LDC_CCXCATEG.CATEACT%type index by binary_integer;
	type tytbPLCOMACT is table of LDC_CCXCATEG.PLCOMACT%type index by binary_integer;
	type tytbCONFIGACT is table of LDC_CCXCATEG.CONFIGACT%type index by binary_integer;
	type tytbUSUARIO is table of LDC_CCXCATEG.USUARIO%type index by binary_integer;
	type tytbFECREG is table of LDC_CCXCATEG.FECREG%type index by binary_integer;
	type tytbTERMINAL is table of LDC_CCXCATEG.TERMINAL%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_CCXCATEG is record
	(
		CCXCATEG_ID   tytbCCXCATEG_ID,
		CATEANT   tytbCATEANT,
		PLCOMANT   tytbPLCOMANT,
		CATEACT   tytbCATEACT,
		PLCOMACT   tytbPLCOMACT,
		CONFIGACT   tytbCONFIGACT,
		USUARIO   tytbUSUARIO,
		FECREG   tytbFECREG,
		TERMINAL   tytbTERMINAL,
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
		inuCCXCATEG_ID in LDC_CCXCATEG.CCXCATEG_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuCCXCATEG_ID in LDC_CCXCATEG.CCXCATEG_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuCCXCATEG_ID in LDC_CCXCATEG.CCXCATEG_ID%type
	);

	PROCEDURE getRecord
	(
		inuCCXCATEG_ID in LDC_CCXCATEG.CCXCATEG_ID%type,
		orcRecord out nocopy styLDC_CCXCATEG
	);

	FUNCTION frcGetRcData
	(
		inuCCXCATEG_ID in LDC_CCXCATEG.CCXCATEG_ID%type
	)
	RETURN styLDC_CCXCATEG;

	FUNCTION frcGetRcData
	RETURN styLDC_CCXCATEG;

	FUNCTION frcGetRecord
	(
		inuCCXCATEG_ID in LDC_CCXCATEG.CCXCATEG_ID%type
	)
	RETURN styLDC_CCXCATEG;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_CCXCATEG
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_CCXCATEG in styLDC_CCXCATEG
	);

	PROCEDURE insRecord
	(
		ircLDC_CCXCATEG in styLDC_CCXCATEG,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_CCXCATEG in out nocopy tytbLDC_CCXCATEG
	);

	PROCEDURE delRecord
	(
		inuCCXCATEG_ID in LDC_CCXCATEG.CCXCATEG_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_CCXCATEG in out nocopy tytbLDC_CCXCATEG,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_CCXCATEG in styLDC_CCXCATEG,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_CCXCATEG in out nocopy tytbLDC_CCXCATEG,
		inuLock in number default 1
	);

	PROCEDURE updCATEANT
	(
		inuCCXCATEG_ID in LDC_CCXCATEG.CCXCATEG_ID%type,
		inuCATEANT$ in LDC_CCXCATEG.CATEANT%type,
		inuLock in number default 0
	);

	PROCEDURE updPLCOMANT
	(
		inuCCXCATEG_ID in LDC_CCXCATEG.CCXCATEG_ID%type,
		inuPLCOMANT$ in LDC_CCXCATEG.PLCOMANT%type,
		inuLock in number default 0
	);

	PROCEDURE updCATEACT
	(
		inuCCXCATEG_ID in LDC_CCXCATEG.CCXCATEG_ID%type,
		inuCATEACT$ in LDC_CCXCATEG.CATEACT%type,
		inuLock in number default 0
	);

	PROCEDURE updPLCOMACT
	(
		inuCCXCATEG_ID in LDC_CCXCATEG.CCXCATEG_ID%type,
		inuPLCOMACT$ in LDC_CCXCATEG.PLCOMACT%type,
		inuLock in number default 0
	);

	PROCEDURE updCONFIGACT
	(
		inuCCXCATEG_ID in LDC_CCXCATEG.CCXCATEG_ID%type,
		isbCONFIGACT$ in LDC_CCXCATEG.CONFIGACT%type,
		inuLock in number default 0
	);

	PROCEDURE updUSUARIO
	(
		inuCCXCATEG_ID in LDC_CCXCATEG.CCXCATEG_ID%type,
		isbUSUARIO$ in LDC_CCXCATEG.USUARIO%type,
		inuLock in number default 0
	);

	PROCEDURE updFECREG
	(
		inuCCXCATEG_ID in LDC_CCXCATEG.CCXCATEG_ID%type,
		idtFECREG$ in LDC_CCXCATEG.FECREG%type,
		inuLock in number default 0
	);

	PROCEDURE updTERMINAL
	(
		inuCCXCATEG_ID in LDC_CCXCATEG.CCXCATEG_ID%type,
		isbTERMINAL$ in LDC_CCXCATEG.TERMINAL%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetCCXCATEG_ID
	(
		inuCCXCATEG_ID in LDC_CCXCATEG.CCXCATEG_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CCXCATEG.CCXCATEG_ID%type;

	FUNCTION fnuGetCATEANT
	(
		inuCCXCATEG_ID in LDC_CCXCATEG.CCXCATEG_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CCXCATEG.CATEANT%type;

	FUNCTION fnuGetPLCOMANT
	(
		inuCCXCATEG_ID in LDC_CCXCATEG.CCXCATEG_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CCXCATEG.PLCOMANT%type;

	FUNCTION fnuGetCATEACT
	(
		inuCCXCATEG_ID in LDC_CCXCATEG.CCXCATEG_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CCXCATEG.CATEACT%type;

	FUNCTION fnuGetPLCOMACT
	(
		inuCCXCATEG_ID in LDC_CCXCATEG.CCXCATEG_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CCXCATEG.PLCOMACT%type;

	FUNCTION fsbGetCONFIGACT
	(
		inuCCXCATEG_ID in LDC_CCXCATEG.CCXCATEG_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CCXCATEG.CONFIGACT%type;

	FUNCTION fsbGetUSUARIO
	(
		inuCCXCATEG_ID in LDC_CCXCATEG.CCXCATEG_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CCXCATEG.USUARIO%type;

	FUNCTION fdtGetFECREG
	(
		inuCCXCATEG_ID in LDC_CCXCATEG.CCXCATEG_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CCXCATEG.FECREG%type;

	FUNCTION fsbGetTERMINAL
	(
		inuCCXCATEG_ID in LDC_CCXCATEG.CCXCATEG_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CCXCATEG.TERMINAL%type;


	PROCEDURE LockByPk
	(
		inuCCXCATEG_ID in LDC_CCXCATEG.CCXCATEG_ID%type,
		orcLDC_CCXCATEG  out styLDC_CCXCATEG
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_CCXCATEG  out styLDC_CCXCATEG
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_CCXCATEG;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALDC_CCXCATEG
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_CCXCATEG';
	 cnuGeEntityId constant varchar2(30) := 3119; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuCCXCATEG_ID in LDC_CCXCATEG.CCXCATEG_ID%type
	)
	IS
		SELECT LDC_CCXCATEG.*,LDC_CCXCATEG.rowid
		FROM LDC_CCXCATEG
		WHERE  CCXCATEG_ID = inuCCXCATEG_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_CCXCATEG.*,LDC_CCXCATEG.rowid
		FROM LDC_CCXCATEG
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_CCXCATEG is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_CCXCATEG;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_CCXCATEG default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.CCXCATEG_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuCCXCATEG_ID in LDC_CCXCATEG.CCXCATEG_ID%type,
		orcLDC_CCXCATEG  out styLDC_CCXCATEG
	)
	IS
		rcError styLDC_CCXCATEG;
	BEGIN
		rcError.CCXCATEG_ID := inuCCXCATEG_ID;

		Open cuLockRcByPk
		(
			inuCCXCATEG_ID
		);

		fetch cuLockRcByPk into orcLDC_CCXCATEG;
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
		orcLDC_CCXCATEG  out styLDC_CCXCATEG
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_CCXCATEG;
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
		itbLDC_CCXCATEG  in out nocopy tytbLDC_CCXCATEG
	)
	IS
	BEGIN
			rcRecOfTab.CCXCATEG_ID.delete;
			rcRecOfTab.CATEANT.delete;
			rcRecOfTab.PLCOMANT.delete;
			rcRecOfTab.CATEACT.delete;
			rcRecOfTab.PLCOMACT.delete;
			rcRecOfTab.CONFIGACT.delete;
			rcRecOfTab.USUARIO.delete;
			rcRecOfTab.FECREG.delete;
			rcRecOfTab.TERMINAL.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_CCXCATEG  in out nocopy tytbLDC_CCXCATEG,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_CCXCATEG);

		for n in itbLDC_CCXCATEG.first .. itbLDC_CCXCATEG.last loop
			rcRecOfTab.CCXCATEG_ID(n) := itbLDC_CCXCATEG(n).CCXCATEG_ID;
			rcRecOfTab.CATEANT(n) := itbLDC_CCXCATEG(n).CATEANT;
			rcRecOfTab.PLCOMANT(n) := itbLDC_CCXCATEG(n).PLCOMANT;
			rcRecOfTab.CATEACT(n) := itbLDC_CCXCATEG(n).CATEACT;
			rcRecOfTab.PLCOMACT(n) := itbLDC_CCXCATEG(n).PLCOMACT;
			rcRecOfTab.CONFIGACT(n) := itbLDC_CCXCATEG(n).CONFIGACT;
			rcRecOfTab.USUARIO(n) := itbLDC_CCXCATEG(n).USUARIO;
			rcRecOfTab.FECREG(n) := itbLDC_CCXCATEG(n).FECREG;
			rcRecOfTab.TERMINAL(n) := itbLDC_CCXCATEG(n).TERMINAL;
			rcRecOfTab.row_id(n) := itbLDC_CCXCATEG(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuCCXCATEG_ID in LDC_CCXCATEG.CCXCATEG_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuCCXCATEG_ID
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
		inuCCXCATEG_ID in LDC_CCXCATEG.CCXCATEG_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuCCXCATEG_ID = rcData.CCXCATEG_ID
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
		inuCCXCATEG_ID in LDC_CCXCATEG.CCXCATEG_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuCCXCATEG_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuCCXCATEG_ID in LDC_CCXCATEG.CCXCATEG_ID%type
	)
	IS
		rcError styLDC_CCXCATEG;
	BEGIN		rcError.CCXCATEG_ID:=inuCCXCATEG_ID;

		Load
		(
			inuCCXCATEG_ID
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
		inuCCXCATEG_ID in LDC_CCXCATEG.CCXCATEG_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuCCXCATEG_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuCCXCATEG_ID in LDC_CCXCATEG.CCXCATEG_ID%type,
		orcRecord out nocopy styLDC_CCXCATEG
	)
	IS
		rcError styLDC_CCXCATEG;
	BEGIN		rcError.CCXCATEG_ID:=inuCCXCATEG_ID;

		Load
		(
			inuCCXCATEG_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuCCXCATEG_ID in LDC_CCXCATEG.CCXCATEG_ID%type
	)
	RETURN styLDC_CCXCATEG
	IS
		rcError styLDC_CCXCATEG;
	BEGIN
		rcError.CCXCATEG_ID:=inuCCXCATEG_ID;

		Load
		(
			inuCCXCATEG_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuCCXCATEG_ID in LDC_CCXCATEG.CCXCATEG_ID%type
	)
	RETURN styLDC_CCXCATEG
	IS
		rcError styLDC_CCXCATEG;
	BEGIN
		rcError.CCXCATEG_ID:=inuCCXCATEG_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuCCXCATEG_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuCCXCATEG_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_CCXCATEG
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_CCXCATEG
	)
	IS
		rfLDC_CCXCATEG tyrfLDC_CCXCATEG;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_CCXCATEG.*, LDC_CCXCATEG.rowid FROM LDC_CCXCATEG';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_CCXCATEG for sbFullQuery;

		fetch rfLDC_CCXCATEG bulk collect INTO otbResult;

		close rfLDC_CCXCATEG;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_CCXCATEG.*, LDC_CCXCATEG.rowid FROM LDC_CCXCATEG';
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
		ircLDC_CCXCATEG in styLDC_CCXCATEG
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_CCXCATEG,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_CCXCATEG in styLDC_CCXCATEG,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_CCXCATEG.CCXCATEG_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|CCXCATEG_ID');
			raise ex.controlled_error;
		end if;

		insert into LDC_CCXCATEG
		(
			CCXCATEG_ID,
			CATEANT,
			PLCOMANT,
			CATEACT,
			PLCOMACT,
			CONFIGACT,
			USUARIO,
			FECREG,
			TERMINAL
		)
		values
		(
			ircLDC_CCXCATEG.CCXCATEG_ID,
			ircLDC_CCXCATEG.CATEANT,
			ircLDC_CCXCATEG.PLCOMANT,
			ircLDC_CCXCATEG.CATEACT,
			ircLDC_CCXCATEG.PLCOMACT,
			ircLDC_CCXCATEG.CONFIGACT,
			ircLDC_CCXCATEG.USUARIO,
			ircLDC_CCXCATEG.FECREG,
			ircLDC_CCXCATEG.TERMINAL
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_CCXCATEG));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_CCXCATEG in out nocopy tytbLDC_CCXCATEG
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_CCXCATEG,blUseRowID);
		forall n in iotbLDC_CCXCATEG.first..iotbLDC_CCXCATEG.last
			insert into LDC_CCXCATEG
			(
				CCXCATEG_ID,
				CATEANT,
				PLCOMANT,
				CATEACT,
				PLCOMACT,
				CONFIGACT,
				USUARIO,
				FECREG,
				TERMINAL
			)
			values
			(
				rcRecOfTab.CCXCATEG_ID(n),
				rcRecOfTab.CATEANT(n),
				rcRecOfTab.PLCOMANT(n),
				rcRecOfTab.CATEACT(n),
				rcRecOfTab.PLCOMACT(n),
				rcRecOfTab.CONFIGACT(n),
				rcRecOfTab.USUARIO(n),
				rcRecOfTab.FECREG(n),
				rcRecOfTab.TERMINAL(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuCCXCATEG_ID in LDC_CCXCATEG.CCXCATEG_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_CCXCATEG;
	BEGIN
		rcError.CCXCATEG_ID := inuCCXCATEG_ID;

		if inuLock=1 then
			LockByPk
			(
				inuCCXCATEG_ID,
				rcData
			);
		end if;


		delete
		from LDC_CCXCATEG
		where
       		CCXCATEG_ID=inuCCXCATEG_ID;
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
		rcError  styLDC_CCXCATEG;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_CCXCATEG
		where
			rowid = iriRowID
		returning
			CCXCATEG_ID
		into
			rcError.CCXCATEG_ID;
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
		iotbLDC_CCXCATEG in out nocopy tytbLDC_CCXCATEG,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_CCXCATEG;
	BEGIN
		FillRecordOfTables(iotbLDC_CCXCATEG, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_CCXCATEG.first .. iotbLDC_CCXCATEG.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CCXCATEG.first .. iotbLDC_CCXCATEG.last
				delete
				from LDC_CCXCATEG
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_CCXCATEG.first .. iotbLDC_CCXCATEG.last loop
					LockByPk
					(
						rcRecOfTab.CCXCATEG_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CCXCATEG.first .. iotbLDC_CCXCATEG.last
				delete
				from LDC_CCXCATEG
				where
		         	CCXCATEG_ID = rcRecOfTab.CCXCATEG_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_CCXCATEG in styLDC_CCXCATEG,
		inuLock in number default 0
	)
	IS
		nuCCXCATEG_ID	LDC_CCXCATEG.CCXCATEG_ID%type;
	BEGIN
		if ircLDC_CCXCATEG.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_CCXCATEG.rowid,rcData);
			end if;
			update LDC_CCXCATEG
			set
				CATEANT = ircLDC_CCXCATEG.CATEANT,
				PLCOMANT = ircLDC_CCXCATEG.PLCOMANT,
				CATEACT = ircLDC_CCXCATEG.CATEACT,
				PLCOMACT = ircLDC_CCXCATEG.PLCOMACT,
				CONFIGACT = ircLDC_CCXCATEG.CONFIGACT,
				USUARIO = ircLDC_CCXCATEG.USUARIO,
				FECREG = ircLDC_CCXCATEG.FECREG,
				TERMINAL = ircLDC_CCXCATEG.TERMINAL
			where
				rowid = ircLDC_CCXCATEG.rowid
			returning
				CCXCATEG_ID
			into
				nuCCXCATEG_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_CCXCATEG.CCXCATEG_ID,
					rcData
				);
			end if;

			update LDC_CCXCATEG
			set
				CATEANT = ircLDC_CCXCATEG.CATEANT,
				PLCOMANT = ircLDC_CCXCATEG.PLCOMANT,
				CATEACT = ircLDC_CCXCATEG.CATEACT,
				PLCOMACT = ircLDC_CCXCATEG.PLCOMACT,
				CONFIGACT = ircLDC_CCXCATEG.CONFIGACT,
				USUARIO = ircLDC_CCXCATEG.USUARIO,
				FECREG = ircLDC_CCXCATEG.FECREG,
				TERMINAL = ircLDC_CCXCATEG.TERMINAL
			where
				CCXCATEG_ID = ircLDC_CCXCATEG.CCXCATEG_ID
			returning
				CCXCATEG_ID
			into
				nuCCXCATEG_ID;
		end if;
		if
			nuCCXCATEG_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_CCXCATEG));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_CCXCATEG in out nocopy tytbLDC_CCXCATEG,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_CCXCATEG;
	BEGIN
		FillRecordOfTables(iotbLDC_CCXCATEG,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_CCXCATEG.first .. iotbLDC_CCXCATEG.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CCXCATEG.first .. iotbLDC_CCXCATEG.last
				update LDC_CCXCATEG
				set
					CATEANT = rcRecOfTab.CATEANT(n),
					PLCOMANT = rcRecOfTab.PLCOMANT(n),
					CATEACT = rcRecOfTab.CATEACT(n),
					PLCOMACT = rcRecOfTab.PLCOMACT(n),
					CONFIGACT = rcRecOfTab.CONFIGACT(n),
					USUARIO = rcRecOfTab.USUARIO(n),
					FECREG = rcRecOfTab.FECREG(n),
					TERMINAL = rcRecOfTab.TERMINAL(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_CCXCATEG.first .. iotbLDC_CCXCATEG.last loop
					LockByPk
					(
						rcRecOfTab.CCXCATEG_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CCXCATEG.first .. iotbLDC_CCXCATEG.last
				update LDC_CCXCATEG
				SET
					CATEANT = rcRecOfTab.CATEANT(n),
					PLCOMANT = rcRecOfTab.PLCOMANT(n),
					CATEACT = rcRecOfTab.CATEACT(n),
					PLCOMACT = rcRecOfTab.PLCOMACT(n),
					CONFIGACT = rcRecOfTab.CONFIGACT(n),
					USUARIO = rcRecOfTab.USUARIO(n),
					FECREG = rcRecOfTab.FECREG(n),
					TERMINAL = rcRecOfTab.TERMINAL(n)
				where
					CCXCATEG_ID = rcRecOfTab.CCXCATEG_ID(n)
;
		end if;
	END;
	PROCEDURE updCATEANT
	(
		inuCCXCATEG_ID in LDC_CCXCATEG.CCXCATEG_ID%type,
		inuCATEANT$ in LDC_CCXCATEG.CATEANT%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CCXCATEG;
	BEGIN
		rcError.CCXCATEG_ID := inuCCXCATEG_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCCXCATEG_ID,
				rcData
			);
		end if;

		update LDC_CCXCATEG
		set
			CATEANT = inuCATEANT$
		where
			CCXCATEG_ID = inuCCXCATEG_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CATEANT:= inuCATEANT$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPLCOMANT
	(
		inuCCXCATEG_ID in LDC_CCXCATEG.CCXCATEG_ID%type,
		inuPLCOMANT$ in LDC_CCXCATEG.PLCOMANT%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CCXCATEG;
	BEGIN
		rcError.CCXCATEG_ID := inuCCXCATEG_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCCXCATEG_ID,
				rcData
			);
		end if;

		update LDC_CCXCATEG
		set
			PLCOMANT = inuPLCOMANT$
		where
			CCXCATEG_ID = inuCCXCATEG_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PLCOMANT:= inuPLCOMANT$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCATEACT
	(
		inuCCXCATEG_ID in LDC_CCXCATEG.CCXCATEG_ID%type,
		inuCATEACT$ in LDC_CCXCATEG.CATEACT%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CCXCATEG;
	BEGIN
		rcError.CCXCATEG_ID := inuCCXCATEG_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCCXCATEG_ID,
				rcData
			);
		end if;

		update LDC_CCXCATEG
		set
			CATEACT = inuCATEACT$
		where
			CCXCATEG_ID = inuCCXCATEG_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CATEACT:= inuCATEACT$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPLCOMACT
	(
		inuCCXCATEG_ID in LDC_CCXCATEG.CCXCATEG_ID%type,
		inuPLCOMACT$ in LDC_CCXCATEG.PLCOMACT%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CCXCATEG;
	BEGIN
		rcError.CCXCATEG_ID := inuCCXCATEG_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCCXCATEG_ID,
				rcData
			);
		end if;

		update LDC_CCXCATEG
		set
			PLCOMACT = inuPLCOMACT$
		where
			CCXCATEG_ID = inuCCXCATEG_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PLCOMACT:= inuPLCOMACT$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCONFIGACT
	(
		inuCCXCATEG_ID in LDC_CCXCATEG.CCXCATEG_ID%type,
		isbCONFIGACT$ in LDC_CCXCATEG.CONFIGACT%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CCXCATEG;
	BEGIN
		rcError.CCXCATEG_ID := inuCCXCATEG_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCCXCATEG_ID,
				rcData
			);
		end if;

		update LDC_CCXCATEG
		set
			CONFIGACT = isbCONFIGACT$
		where
			CCXCATEG_ID = inuCCXCATEG_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CONFIGACT:= isbCONFIGACT$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updUSUARIO
	(
		inuCCXCATEG_ID in LDC_CCXCATEG.CCXCATEG_ID%type,
		isbUSUARIO$ in LDC_CCXCATEG.USUARIO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CCXCATEG;
	BEGIN
		rcError.CCXCATEG_ID := inuCCXCATEG_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCCXCATEG_ID,
				rcData
			);
		end if;

		update LDC_CCXCATEG
		set
			USUARIO = isbUSUARIO$
		where
			CCXCATEG_ID = inuCCXCATEG_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.USUARIO:= isbUSUARIO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFECREG
	(
		inuCCXCATEG_ID in LDC_CCXCATEG.CCXCATEG_ID%type,
		idtFECREG$ in LDC_CCXCATEG.FECREG%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CCXCATEG;
	BEGIN
		rcError.CCXCATEG_ID := inuCCXCATEG_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCCXCATEG_ID,
				rcData
			);
		end if;

		update LDC_CCXCATEG
		set
			FECREG = idtFECREG$
		where
			CCXCATEG_ID = inuCCXCATEG_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FECREG:= idtFECREG$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updTERMINAL
	(
		inuCCXCATEG_ID in LDC_CCXCATEG.CCXCATEG_ID%type,
		isbTERMINAL$ in LDC_CCXCATEG.TERMINAL%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CCXCATEG;
	BEGIN
		rcError.CCXCATEG_ID := inuCCXCATEG_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCCXCATEG_ID,
				rcData
			);
		end if;

		update LDC_CCXCATEG
		set
			TERMINAL = isbTERMINAL$
		where
			CCXCATEG_ID = inuCCXCATEG_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TERMINAL:= isbTERMINAL$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetCCXCATEG_ID
	(
		inuCCXCATEG_ID in LDC_CCXCATEG.CCXCATEG_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CCXCATEG.CCXCATEG_ID%type
	IS
		rcError styLDC_CCXCATEG;
	BEGIN

		rcError.CCXCATEG_ID := inuCCXCATEG_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCCXCATEG_ID
			 )
		then
			 return(rcData.CCXCATEG_ID);
		end if;
		Load
		(
		 		inuCCXCATEG_ID
		);
		return(rcData.CCXCATEG_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCATEANT
	(
		inuCCXCATEG_ID in LDC_CCXCATEG.CCXCATEG_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CCXCATEG.CATEANT%type
	IS
		rcError styLDC_CCXCATEG;
	BEGIN

		rcError.CCXCATEG_ID := inuCCXCATEG_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCCXCATEG_ID
			 )
		then
			 return(rcData.CATEANT);
		end if;
		Load
		(
		 		inuCCXCATEG_ID
		);
		return(rcData.CATEANT);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetPLCOMANT
	(
		inuCCXCATEG_ID in LDC_CCXCATEG.CCXCATEG_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CCXCATEG.PLCOMANT%type
	IS
		rcError styLDC_CCXCATEG;
	BEGIN

		rcError.CCXCATEG_ID := inuCCXCATEG_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCCXCATEG_ID
			 )
		then
			 return(rcData.PLCOMANT);
		end if;
		Load
		(
		 		inuCCXCATEG_ID
		);
		return(rcData.PLCOMANT);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCATEACT
	(
		inuCCXCATEG_ID in LDC_CCXCATEG.CCXCATEG_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CCXCATEG.CATEACT%type
	IS
		rcError styLDC_CCXCATEG;
	BEGIN

		rcError.CCXCATEG_ID := inuCCXCATEG_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCCXCATEG_ID
			 )
		then
			 return(rcData.CATEACT);
		end if;
		Load
		(
		 		inuCCXCATEG_ID
		);
		return(rcData.CATEACT);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetPLCOMACT
	(
		inuCCXCATEG_ID in LDC_CCXCATEG.CCXCATEG_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CCXCATEG.PLCOMACT%type
	IS
		rcError styLDC_CCXCATEG;
	BEGIN

		rcError.CCXCATEG_ID := inuCCXCATEG_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCCXCATEG_ID
			 )
		then
			 return(rcData.PLCOMACT);
		end if;
		Load
		(
		 		inuCCXCATEG_ID
		);
		return(rcData.PLCOMACT);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetCONFIGACT
	(
		inuCCXCATEG_ID in LDC_CCXCATEG.CCXCATEG_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CCXCATEG.CONFIGACT%type
	IS
		rcError styLDC_CCXCATEG;
	BEGIN

		rcError.CCXCATEG_ID := inuCCXCATEG_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCCXCATEG_ID
			 )
		then
			 return(rcData.CONFIGACT);
		end if;
		Load
		(
		 		inuCCXCATEG_ID
		);
		return(rcData.CONFIGACT);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetUSUARIO
	(
		inuCCXCATEG_ID in LDC_CCXCATEG.CCXCATEG_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CCXCATEG.USUARIO%type
	IS
		rcError styLDC_CCXCATEG;
	BEGIN

		rcError.CCXCATEG_ID := inuCCXCATEG_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCCXCATEG_ID
			 )
		then
			 return(rcData.USUARIO);
		end if;
		Load
		(
		 		inuCCXCATEG_ID
		);
		return(rcData.USUARIO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetFECREG
	(
		inuCCXCATEG_ID in LDC_CCXCATEG.CCXCATEG_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CCXCATEG.FECREG%type
	IS
		rcError styLDC_CCXCATEG;
	BEGIN

		rcError.CCXCATEG_ID := inuCCXCATEG_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCCXCATEG_ID
			 )
		then
			 return(rcData.FECREG);
		end if;
		Load
		(
		 		inuCCXCATEG_ID
		);
		return(rcData.FECREG);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetTERMINAL
	(
		inuCCXCATEG_ID in LDC_CCXCATEG.CCXCATEG_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CCXCATEG.TERMINAL%type
	IS
		rcError styLDC_CCXCATEG;
	BEGIN

		rcError.CCXCATEG_ID := inuCCXCATEG_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCCXCATEG_ID
			 )
		then
			 return(rcData.TERMINAL);
		end if;
		Load
		(
		 		inuCCXCATEG_ID
		);
		return(rcData.TERMINAL);
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
end DALDC_CCXCATEG;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALDC_CCXCATEG
BEGIN
    pkg_utilidades.prAplicarPermisos('DALDC_CCXCATEG', 'ADM_PERSON'); 
END;
/

