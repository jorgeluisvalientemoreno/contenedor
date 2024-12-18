CREATE OR REPLACE PACKAGE ADM_PERSON.DALDC_ITEMS_CONEXIONES
is  
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     : DALDC_ITEMS_CONEXIONES
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
		inuITCONIDRG in LDC_ITEMS_CONEXIONES.ITCONIDRG%type
	)
	IS
		SELECT LDC_ITEMS_CONEXIONES.*,LDC_ITEMS_CONEXIONES.rowid
		FROM LDC_ITEMS_CONEXIONES
		WHERE
		    ITCONIDRG = inuITCONIDRG;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_ITEMS_CONEXIONES.*,LDC_ITEMS_CONEXIONES.rowid
		FROM LDC_ITEMS_CONEXIONES
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_ITEMS_CONEXIONES  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_ITEMS_CONEXIONES is table of styLDC_ITEMS_CONEXIONES index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_ITEMS_CONEXIONES;

	/* Tipos referenciando al registro */
	type tytbITCONIDRG is table of LDC_ITEMS_CONEXIONES.ITCONIDRG%type index by binary_integer;
	type tytbITCONDEPA is table of LDC_ITEMS_CONEXIONES.ITCONDEPA%type index by binary_integer;
	type tytbITCONLOCA is table of LDC_ITEMS_CONEXIONES.ITCONLOCA%type index by binary_integer;
	type tytbITCONSUCA is table of LDC_ITEMS_CONEXIONES.ITCONSUCA%type index by binary_integer;
	type tytbITCONITFI is table of LDC_ITEMS_CONEXIONES.ITCONITFI%type index by binary_integer;
	type tytbITCONITVA is table of LDC_ITEMS_CONEXIONES.ITCONITVA%type index by binary_integer;
	type tytbITCONTIPO1 is table of LDC_ITEMS_CONEXIONES.ITCONTIPO1%type index by binary_integer;
	type tytbITCONTIPO2 is table of LDC_ITEMS_CONEXIONES.ITCONTIPO2%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_ITEMS_CONEXIONES is record
	(
		ITCONIDRG   tytbITCONIDRG,
		ITCONDEPA   tytbITCONDEPA,
		ITCONLOCA   tytbITCONLOCA,
		ITCONSUCA   tytbITCONSUCA,
		ITCONITFI   tytbITCONITFI,
		ITCONITVA   tytbITCONITVA,
		ITCONTIPO1   tytbITCONTIPO1,
		ITCONTIPO2   tytbITCONTIPO2,
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
		inuITCONIDRG in LDC_ITEMS_CONEXIONES.ITCONIDRG%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuITCONIDRG in LDC_ITEMS_CONEXIONES.ITCONIDRG%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuITCONIDRG in LDC_ITEMS_CONEXIONES.ITCONIDRG%type
	);

	PROCEDURE getRecord
	(
		inuITCONIDRG in LDC_ITEMS_CONEXIONES.ITCONIDRG%type,
		orcRecord out nocopy styLDC_ITEMS_CONEXIONES
	);

	FUNCTION frcGetRcData
	(
		inuITCONIDRG in LDC_ITEMS_CONEXIONES.ITCONIDRG%type
	)
	RETURN styLDC_ITEMS_CONEXIONES;

	FUNCTION frcGetRcData
	RETURN styLDC_ITEMS_CONEXIONES;

	FUNCTION frcGetRecord
	(
		inuITCONIDRG in LDC_ITEMS_CONEXIONES.ITCONIDRG%type
	)
	RETURN styLDC_ITEMS_CONEXIONES;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_ITEMS_CONEXIONES
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_ITEMS_CONEXIONES in styLDC_ITEMS_CONEXIONES
	);

	PROCEDURE insRecord
	(
		ircLDC_ITEMS_CONEXIONES in styLDC_ITEMS_CONEXIONES,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_ITEMS_CONEXIONES in out nocopy tytbLDC_ITEMS_CONEXIONES
	);

	PROCEDURE delRecord
	(
		inuITCONIDRG in LDC_ITEMS_CONEXIONES.ITCONIDRG%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_ITEMS_CONEXIONES in out nocopy tytbLDC_ITEMS_CONEXIONES,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_ITEMS_CONEXIONES in styLDC_ITEMS_CONEXIONES,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_ITEMS_CONEXIONES in out nocopy tytbLDC_ITEMS_CONEXIONES,
		inuLock in number default 1
	);

	PROCEDURE updITCONDEPA
	(
		inuITCONIDRG in LDC_ITEMS_CONEXIONES.ITCONIDRG%type,
		inuITCONDEPA$ in LDC_ITEMS_CONEXIONES.ITCONDEPA%type,
		inuLock in number default 0
	);

	PROCEDURE updITCONLOCA
	(
		inuITCONIDRG in LDC_ITEMS_CONEXIONES.ITCONIDRG%type,
		inuITCONLOCA$ in LDC_ITEMS_CONEXIONES.ITCONLOCA%type,
		inuLock in number default 0
	);

	PROCEDURE updITCONSUCA
	(
		inuITCONIDRG in LDC_ITEMS_CONEXIONES.ITCONIDRG%type,
		inuITCONSUCA$ in LDC_ITEMS_CONEXIONES.ITCONSUCA%type,
		inuLock in number default 0
	);

	PROCEDURE updITCONITFI
	(
		inuITCONIDRG in LDC_ITEMS_CONEXIONES.ITCONIDRG%type,
		inuITCONITFI$ in LDC_ITEMS_CONEXIONES.ITCONITFI%type,
		inuLock in number default 0
	);

	PROCEDURE updITCONITVA
	(
		inuITCONIDRG in LDC_ITEMS_CONEXIONES.ITCONIDRG%type,
		inuITCONITVA$ in LDC_ITEMS_CONEXIONES.ITCONITVA%type,
		inuLock in number default 0
	);

	PROCEDURE updITCONTIPO1
	(
		inuITCONIDRG in LDC_ITEMS_CONEXIONES.ITCONIDRG%type,
		isbITCONTIPO1$ in LDC_ITEMS_CONEXIONES.ITCONTIPO1%type,
		inuLock in number default 0
	);

	PROCEDURE updITCONTIPO2
	(
		inuITCONIDRG in LDC_ITEMS_CONEXIONES.ITCONIDRG%type,
		isbITCONTIPO2$ in LDC_ITEMS_CONEXIONES.ITCONTIPO2%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetITCONIDRG
	(
		inuITCONIDRG in LDC_ITEMS_CONEXIONES.ITCONIDRG%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_CONEXIONES.ITCONIDRG%type;

	FUNCTION fnuGetITCONDEPA
	(
		inuITCONIDRG in LDC_ITEMS_CONEXIONES.ITCONIDRG%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_CONEXIONES.ITCONDEPA%type;

	FUNCTION fnuGetITCONLOCA
	(
		inuITCONIDRG in LDC_ITEMS_CONEXIONES.ITCONIDRG%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_CONEXIONES.ITCONLOCA%type;

	FUNCTION fnuGetITCONSUCA
	(
		inuITCONIDRG in LDC_ITEMS_CONEXIONES.ITCONIDRG%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_CONEXIONES.ITCONSUCA%type;

	FUNCTION fnuGetITCONITFI
	(
		inuITCONIDRG in LDC_ITEMS_CONEXIONES.ITCONIDRG%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_CONEXIONES.ITCONITFI%type;

	FUNCTION fnuGetITCONITVA
	(
		inuITCONIDRG in LDC_ITEMS_CONEXIONES.ITCONIDRG%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_CONEXIONES.ITCONITVA%type;

	FUNCTION fsbGetITCONTIPO1
	(
		inuITCONIDRG in LDC_ITEMS_CONEXIONES.ITCONIDRG%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_CONEXIONES.ITCONTIPO1%type;

	FUNCTION fsbGetITCONTIPO2
	(
		inuITCONIDRG in LDC_ITEMS_CONEXIONES.ITCONIDRG%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_CONEXIONES.ITCONTIPO2%type;


	PROCEDURE LockByPk
	(
		inuITCONIDRG in LDC_ITEMS_CONEXIONES.ITCONIDRG%type,
		orcLDC_ITEMS_CONEXIONES  out styLDC_ITEMS_CONEXIONES
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_ITEMS_CONEXIONES  out styLDC_ITEMS_CONEXIONES
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_ITEMS_CONEXIONES;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALDC_ITEMS_CONEXIONES
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_ITEMS_CONEXIONES';
	 cnuGeEntityId constant varchar2(30) := 8518; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuITCONIDRG in LDC_ITEMS_CONEXIONES.ITCONIDRG%type
	)
	IS
		SELECT LDC_ITEMS_CONEXIONES.*,LDC_ITEMS_CONEXIONES.rowid
		FROM LDC_ITEMS_CONEXIONES
		WHERE  ITCONIDRG = inuITCONIDRG
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_ITEMS_CONEXIONES.*,LDC_ITEMS_CONEXIONES.rowid
		FROM LDC_ITEMS_CONEXIONES
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_ITEMS_CONEXIONES is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_ITEMS_CONEXIONES;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_ITEMS_CONEXIONES default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.ITCONIDRG);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuITCONIDRG in LDC_ITEMS_CONEXIONES.ITCONIDRG%type,
		orcLDC_ITEMS_CONEXIONES  out styLDC_ITEMS_CONEXIONES
	)
	IS
		rcError styLDC_ITEMS_CONEXIONES;
	BEGIN
		rcError.ITCONIDRG := inuITCONIDRG;

		Open cuLockRcByPk
		(
			inuITCONIDRG
		);

		fetch cuLockRcByPk into orcLDC_ITEMS_CONEXIONES;
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
		orcLDC_ITEMS_CONEXIONES  out styLDC_ITEMS_CONEXIONES
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_ITEMS_CONEXIONES;
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
		itbLDC_ITEMS_CONEXIONES  in out nocopy tytbLDC_ITEMS_CONEXIONES
	)
	IS
	BEGIN
			rcRecOfTab.ITCONIDRG.delete;
			rcRecOfTab.ITCONDEPA.delete;
			rcRecOfTab.ITCONLOCA.delete;
			rcRecOfTab.ITCONSUCA.delete;
			rcRecOfTab.ITCONITFI.delete;
			rcRecOfTab.ITCONITVA.delete;
			rcRecOfTab.ITCONTIPO1.delete;
			rcRecOfTab.ITCONTIPO2.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_ITEMS_CONEXIONES  in out nocopy tytbLDC_ITEMS_CONEXIONES,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_ITEMS_CONEXIONES);

		for n in itbLDC_ITEMS_CONEXIONES.first .. itbLDC_ITEMS_CONEXIONES.last loop
			rcRecOfTab.ITCONIDRG(n) := itbLDC_ITEMS_CONEXIONES(n).ITCONIDRG;
			rcRecOfTab.ITCONDEPA(n) := itbLDC_ITEMS_CONEXIONES(n).ITCONDEPA;
			rcRecOfTab.ITCONLOCA(n) := itbLDC_ITEMS_CONEXIONES(n).ITCONLOCA;
			rcRecOfTab.ITCONSUCA(n) := itbLDC_ITEMS_CONEXIONES(n).ITCONSUCA;
			rcRecOfTab.ITCONITFI(n) := itbLDC_ITEMS_CONEXIONES(n).ITCONITFI;
			rcRecOfTab.ITCONITVA(n) := itbLDC_ITEMS_CONEXIONES(n).ITCONITVA;
			rcRecOfTab.ITCONTIPO1(n) := itbLDC_ITEMS_CONEXIONES(n).ITCONTIPO1;
			rcRecOfTab.ITCONTIPO2(n) := itbLDC_ITEMS_CONEXIONES(n).ITCONTIPO2;
			rcRecOfTab.row_id(n) := itbLDC_ITEMS_CONEXIONES(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuITCONIDRG in LDC_ITEMS_CONEXIONES.ITCONIDRG%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuITCONIDRG
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
		inuITCONIDRG in LDC_ITEMS_CONEXIONES.ITCONIDRG%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuITCONIDRG = rcData.ITCONIDRG
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
		inuITCONIDRG in LDC_ITEMS_CONEXIONES.ITCONIDRG%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuITCONIDRG
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuITCONIDRG in LDC_ITEMS_CONEXIONES.ITCONIDRG%type
	)
	IS
		rcError styLDC_ITEMS_CONEXIONES;
	BEGIN		rcError.ITCONIDRG:=inuITCONIDRG;

		Load
		(
			inuITCONIDRG
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
		inuITCONIDRG in LDC_ITEMS_CONEXIONES.ITCONIDRG%type
	)
	IS
	BEGIN
		Load
		(
			inuITCONIDRG
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuITCONIDRG in LDC_ITEMS_CONEXIONES.ITCONIDRG%type,
		orcRecord out nocopy styLDC_ITEMS_CONEXIONES
	)
	IS
		rcError styLDC_ITEMS_CONEXIONES;
	BEGIN		rcError.ITCONIDRG:=inuITCONIDRG;

		Load
		(
			inuITCONIDRG
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuITCONIDRG in LDC_ITEMS_CONEXIONES.ITCONIDRG%type
	)
	RETURN styLDC_ITEMS_CONEXIONES
	IS
		rcError styLDC_ITEMS_CONEXIONES;
	BEGIN
		rcError.ITCONIDRG:=inuITCONIDRG;

		Load
		(
			inuITCONIDRG
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuITCONIDRG in LDC_ITEMS_CONEXIONES.ITCONIDRG%type
	)
	RETURN styLDC_ITEMS_CONEXIONES
	IS
		rcError styLDC_ITEMS_CONEXIONES;
	BEGIN
		rcError.ITCONIDRG:=inuITCONIDRG;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuITCONIDRG
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuITCONIDRG
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_ITEMS_CONEXIONES
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_ITEMS_CONEXIONES
	)
	IS
		rfLDC_ITEMS_CONEXIONES tyrfLDC_ITEMS_CONEXIONES;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_ITEMS_CONEXIONES.*, LDC_ITEMS_CONEXIONES.rowid FROM LDC_ITEMS_CONEXIONES';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_ITEMS_CONEXIONES for sbFullQuery;

		fetch rfLDC_ITEMS_CONEXIONES bulk collect INTO otbResult;

		close rfLDC_ITEMS_CONEXIONES;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_ITEMS_CONEXIONES.*, LDC_ITEMS_CONEXIONES.rowid FROM LDC_ITEMS_CONEXIONES';
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
		ircLDC_ITEMS_CONEXIONES in styLDC_ITEMS_CONEXIONES
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_ITEMS_CONEXIONES,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_ITEMS_CONEXIONES in styLDC_ITEMS_CONEXIONES,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_ITEMS_CONEXIONES.ITCONIDRG is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ITCONIDRG');
			raise ex.controlled_error;
		end if;

		insert into LDC_ITEMS_CONEXIONES
		(
			ITCONIDRG,
			ITCONDEPA,
			ITCONLOCA,
			ITCONSUCA,
			ITCONITFI,
			ITCONITVA,
			ITCONTIPO1,
			ITCONTIPO2
		)
		values
		(
			ircLDC_ITEMS_CONEXIONES.ITCONIDRG,
			ircLDC_ITEMS_CONEXIONES.ITCONDEPA,
			ircLDC_ITEMS_CONEXIONES.ITCONLOCA,
			ircLDC_ITEMS_CONEXIONES.ITCONSUCA,
			ircLDC_ITEMS_CONEXIONES.ITCONITFI,
			ircLDC_ITEMS_CONEXIONES.ITCONITVA,
			ircLDC_ITEMS_CONEXIONES.ITCONTIPO1,
			ircLDC_ITEMS_CONEXIONES.ITCONTIPO2
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_ITEMS_CONEXIONES));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_ITEMS_CONEXIONES in out nocopy tytbLDC_ITEMS_CONEXIONES
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_ITEMS_CONEXIONES,blUseRowID);
		forall n in iotbLDC_ITEMS_CONEXIONES.first..iotbLDC_ITEMS_CONEXIONES.last
			insert into LDC_ITEMS_CONEXIONES
			(
				ITCONIDRG,
				ITCONDEPA,
				ITCONLOCA,
				ITCONSUCA,
				ITCONITFI,
				ITCONITVA,
				ITCONTIPO1,
				ITCONTIPO2
			)
			values
			(
				rcRecOfTab.ITCONIDRG(n),
				rcRecOfTab.ITCONDEPA(n),
				rcRecOfTab.ITCONLOCA(n),
				rcRecOfTab.ITCONSUCA(n),
				rcRecOfTab.ITCONITFI(n),
				rcRecOfTab.ITCONITVA(n),
				rcRecOfTab.ITCONTIPO1(n),
				rcRecOfTab.ITCONTIPO2(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuITCONIDRG in LDC_ITEMS_CONEXIONES.ITCONIDRG%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_ITEMS_CONEXIONES;
	BEGIN
		rcError.ITCONIDRG := inuITCONIDRG;

		if inuLock=1 then
			LockByPk
			(
				inuITCONIDRG,
				rcData
			);
		end if;


		delete
		from LDC_ITEMS_CONEXIONES
		where
       		ITCONIDRG=inuITCONIDRG;
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
		rcError  styLDC_ITEMS_CONEXIONES;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_ITEMS_CONEXIONES
		where
			rowid = iriRowID
		returning
			ITCONIDRG
		into
			rcError.ITCONIDRG;
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
		iotbLDC_ITEMS_CONEXIONES in out nocopy tytbLDC_ITEMS_CONEXIONES,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_ITEMS_CONEXIONES;
	BEGIN
		FillRecordOfTables(iotbLDC_ITEMS_CONEXIONES, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_ITEMS_CONEXIONES.first .. iotbLDC_ITEMS_CONEXIONES.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ITEMS_CONEXIONES.first .. iotbLDC_ITEMS_CONEXIONES.last
				delete
				from LDC_ITEMS_CONEXIONES
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_ITEMS_CONEXIONES.first .. iotbLDC_ITEMS_CONEXIONES.last loop
					LockByPk
					(
						rcRecOfTab.ITCONIDRG(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ITEMS_CONEXIONES.first .. iotbLDC_ITEMS_CONEXIONES.last
				delete
				from LDC_ITEMS_CONEXIONES
				where
		         	ITCONIDRG = rcRecOfTab.ITCONIDRG(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_ITEMS_CONEXIONES in styLDC_ITEMS_CONEXIONES,
		inuLock in number default 0
	)
	IS
		nuITCONIDRG	LDC_ITEMS_CONEXIONES.ITCONIDRG%type;
	BEGIN
		if ircLDC_ITEMS_CONEXIONES.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_ITEMS_CONEXIONES.rowid,rcData);
			end if;
			update LDC_ITEMS_CONEXIONES
			set
				ITCONDEPA = ircLDC_ITEMS_CONEXIONES.ITCONDEPA,
				ITCONLOCA = ircLDC_ITEMS_CONEXIONES.ITCONLOCA,
				ITCONSUCA = ircLDC_ITEMS_CONEXIONES.ITCONSUCA,
				ITCONITFI = ircLDC_ITEMS_CONEXIONES.ITCONITFI,
				ITCONITVA = ircLDC_ITEMS_CONEXIONES.ITCONITVA,
				ITCONTIPO1 = ircLDC_ITEMS_CONEXIONES.ITCONTIPO1,
				ITCONTIPO2 = ircLDC_ITEMS_CONEXIONES.ITCONTIPO2
			where
				rowid = ircLDC_ITEMS_CONEXIONES.rowid
			returning
				ITCONIDRG
			into
				nuITCONIDRG;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_ITEMS_CONEXIONES.ITCONIDRG,
					rcData
				);
			end if;

			update LDC_ITEMS_CONEXIONES
			set
				ITCONDEPA = ircLDC_ITEMS_CONEXIONES.ITCONDEPA,
				ITCONLOCA = ircLDC_ITEMS_CONEXIONES.ITCONLOCA,
				ITCONSUCA = ircLDC_ITEMS_CONEXIONES.ITCONSUCA,
				ITCONITFI = ircLDC_ITEMS_CONEXIONES.ITCONITFI,
				ITCONITVA = ircLDC_ITEMS_CONEXIONES.ITCONITVA,
				ITCONTIPO1 = ircLDC_ITEMS_CONEXIONES.ITCONTIPO1,
				ITCONTIPO2 = ircLDC_ITEMS_CONEXIONES.ITCONTIPO2
			where
				ITCONIDRG = ircLDC_ITEMS_CONEXIONES.ITCONIDRG
			returning
				ITCONIDRG
			into
				nuITCONIDRG;
		end if;
		if
			nuITCONIDRG is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_ITEMS_CONEXIONES));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_ITEMS_CONEXIONES in out nocopy tytbLDC_ITEMS_CONEXIONES,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_ITEMS_CONEXIONES;
	BEGIN
		FillRecordOfTables(iotbLDC_ITEMS_CONEXIONES,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_ITEMS_CONEXIONES.first .. iotbLDC_ITEMS_CONEXIONES.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ITEMS_CONEXIONES.first .. iotbLDC_ITEMS_CONEXIONES.last
				update LDC_ITEMS_CONEXIONES
				set
					ITCONDEPA = rcRecOfTab.ITCONDEPA(n),
					ITCONLOCA = rcRecOfTab.ITCONLOCA(n),
					ITCONSUCA = rcRecOfTab.ITCONSUCA(n),
					ITCONITFI = rcRecOfTab.ITCONITFI(n),
					ITCONITVA = rcRecOfTab.ITCONITVA(n),
					ITCONTIPO1 = rcRecOfTab.ITCONTIPO1(n),
					ITCONTIPO2 = rcRecOfTab.ITCONTIPO2(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_ITEMS_CONEXIONES.first .. iotbLDC_ITEMS_CONEXIONES.last loop
					LockByPk
					(
						rcRecOfTab.ITCONIDRG(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ITEMS_CONEXIONES.first .. iotbLDC_ITEMS_CONEXIONES.last
				update LDC_ITEMS_CONEXIONES
				SET
					ITCONDEPA = rcRecOfTab.ITCONDEPA(n),
					ITCONLOCA = rcRecOfTab.ITCONLOCA(n),
					ITCONSUCA = rcRecOfTab.ITCONSUCA(n),
					ITCONITFI = rcRecOfTab.ITCONITFI(n),
					ITCONITVA = rcRecOfTab.ITCONITVA(n),
					ITCONTIPO1 = rcRecOfTab.ITCONTIPO1(n),
					ITCONTIPO2 = rcRecOfTab.ITCONTIPO2(n)
				where
					ITCONIDRG = rcRecOfTab.ITCONIDRG(n)
;
		end if;
	END;
	PROCEDURE updITCONDEPA
	(
		inuITCONIDRG in LDC_ITEMS_CONEXIONES.ITCONIDRG%type,
		inuITCONDEPA$ in LDC_ITEMS_CONEXIONES.ITCONDEPA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ITEMS_CONEXIONES;
	BEGIN
		rcError.ITCONIDRG := inuITCONIDRG;
		if inuLock=1 then
			LockByPk
			(
				inuITCONIDRG,
				rcData
			);
		end if;

		update LDC_ITEMS_CONEXIONES
		set
			ITCONDEPA = inuITCONDEPA$
		where
			ITCONIDRG = inuITCONIDRG;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ITCONDEPA:= inuITCONDEPA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updITCONLOCA
	(
		inuITCONIDRG in LDC_ITEMS_CONEXIONES.ITCONIDRG%type,
		inuITCONLOCA$ in LDC_ITEMS_CONEXIONES.ITCONLOCA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ITEMS_CONEXIONES;
	BEGIN
		rcError.ITCONIDRG := inuITCONIDRG;
		if inuLock=1 then
			LockByPk
			(
				inuITCONIDRG,
				rcData
			);
		end if;

		update LDC_ITEMS_CONEXIONES
		set
			ITCONLOCA = inuITCONLOCA$
		where
			ITCONIDRG = inuITCONIDRG;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ITCONLOCA:= inuITCONLOCA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updITCONSUCA
	(
		inuITCONIDRG in LDC_ITEMS_CONEXIONES.ITCONIDRG%type,
		inuITCONSUCA$ in LDC_ITEMS_CONEXIONES.ITCONSUCA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ITEMS_CONEXIONES;
	BEGIN
		rcError.ITCONIDRG := inuITCONIDRG;
		if inuLock=1 then
			LockByPk
			(
				inuITCONIDRG,
				rcData
			);
		end if;

		update LDC_ITEMS_CONEXIONES
		set
			ITCONSUCA = inuITCONSUCA$
		where
			ITCONIDRG = inuITCONIDRG;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ITCONSUCA:= inuITCONSUCA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updITCONITFI
	(
		inuITCONIDRG in LDC_ITEMS_CONEXIONES.ITCONIDRG%type,
		inuITCONITFI$ in LDC_ITEMS_CONEXIONES.ITCONITFI%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ITEMS_CONEXIONES;
	BEGIN
		rcError.ITCONIDRG := inuITCONIDRG;
		if inuLock=1 then
			LockByPk
			(
				inuITCONIDRG,
				rcData
			);
		end if;

		update LDC_ITEMS_CONEXIONES
		set
			ITCONITFI = inuITCONITFI$
		where
			ITCONIDRG = inuITCONIDRG;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ITCONITFI:= inuITCONITFI$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updITCONITVA
	(
		inuITCONIDRG in LDC_ITEMS_CONEXIONES.ITCONIDRG%type,
		inuITCONITVA$ in LDC_ITEMS_CONEXIONES.ITCONITVA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ITEMS_CONEXIONES;
	BEGIN
		rcError.ITCONIDRG := inuITCONIDRG;
		if inuLock=1 then
			LockByPk
			(
				inuITCONIDRG,
				rcData
			);
		end if;

		update LDC_ITEMS_CONEXIONES
		set
			ITCONITVA = inuITCONITVA$
		where
			ITCONIDRG = inuITCONIDRG;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ITCONITVA:= inuITCONITVA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updITCONTIPO1
	(
		inuITCONIDRG in LDC_ITEMS_CONEXIONES.ITCONIDRG%type,
		isbITCONTIPO1$ in LDC_ITEMS_CONEXIONES.ITCONTIPO1%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ITEMS_CONEXIONES;
	BEGIN
		rcError.ITCONIDRG := inuITCONIDRG;
		if inuLock=1 then
			LockByPk
			(
				inuITCONIDRG,
				rcData
			);
		end if;

		update LDC_ITEMS_CONEXIONES
		set
			ITCONTIPO1 = isbITCONTIPO1$
		where
			ITCONIDRG = inuITCONIDRG;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ITCONTIPO1:= isbITCONTIPO1$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updITCONTIPO2
	(
		inuITCONIDRG in LDC_ITEMS_CONEXIONES.ITCONIDRG%type,
		isbITCONTIPO2$ in LDC_ITEMS_CONEXIONES.ITCONTIPO2%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ITEMS_CONEXIONES;
	BEGIN
		rcError.ITCONIDRG := inuITCONIDRG;
		if inuLock=1 then
			LockByPk
			(
				inuITCONIDRG,
				rcData
			);
		end if;

		update LDC_ITEMS_CONEXIONES
		set
			ITCONTIPO2 = isbITCONTIPO2$
		where
			ITCONIDRG = inuITCONIDRG;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ITCONTIPO2:= isbITCONTIPO2$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetITCONIDRG
	(
		inuITCONIDRG in LDC_ITEMS_CONEXIONES.ITCONIDRG%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_CONEXIONES.ITCONIDRG%type
	IS
		rcError styLDC_ITEMS_CONEXIONES;
	BEGIN

		rcError.ITCONIDRG := inuITCONIDRG;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuITCONIDRG
			 )
		then
			 return(rcData.ITCONIDRG);
		end if;
		Load
		(
		 		inuITCONIDRG
		);
		return(rcData.ITCONIDRG);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetITCONDEPA
	(
		inuITCONIDRG in LDC_ITEMS_CONEXIONES.ITCONIDRG%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_CONEXIONES.ITCONDEPA%type
	IS
		rcError styLDC_ITEMS_CONEXIONES;
	BEGIN

		rcError.ITCONIDRG := inuITCONIDRG;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuITCONIDRG
			 )
		then
			 return(rcData.ITCONDEPA);
		end if;
		Load
		(
		 		inuITCONIDRG
		);
		return(rcData.ITCONDEPA);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetITCONLOCA
	(
		inuITCONIDRG in LDC_ITEMS_CONEXIONES.ITCONIDRG%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_CONEXIONES.ITCONLOCA%type
	IS
		rcError styLDC_ITEMS_CONEXIONES;
	BEGIN

		rcError.ITCONIDRG := inuITCONIDRG;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuITCONIDRG
			 )
		then
			 return(rcData.ITCONLOCA);
		end if;
		Load
		(
		 		inuITCONIDRG
		);
		return(rcData.ITCONLOCA);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetITCONSUCA
	(
		inuITCONIDRG in LDC_ITEMS_CONEXIONES.ITCONIDRG%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_CONEXIONES.ITCONSUCA%type
	IS
		rcError styLDC_ITEMS_CONEXIONES;
	BEGIN

		rcError.ITCONIDRG := inuITCONIDRG;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuITCONIDRG
			 )
		then
			 return(rcData.ITCONSUCA);
		end if;
		Load
		(
		 		inuITCONIDRG
		);
		return(rcData.ITCONSUCA);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetITCONITFI
	(
		inuITCONIDRG in LDC_ITEMS_CONEXIONES.ITCONIDRG%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_CONEXIONES.ITCONITFI%type
	IS
		rcError styLDC_ITEMS_CONEXIONES;
	BEGIN

		rcError.ITCONIDRG := inuITCONIDRG;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuITCONIDRG
			 )
		then
			 return(rcData.ITCONITFI);
		end if;
		Load
		(
		 		inuITCONIDRG
		);
		return(rcData.ITCONITFI);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetITCONITVA
	(
		inuITCONIDRG in LDC_ITEMS_CONEXIONES.ITCONIDRG%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_CONEXIONES.ITCONITVA%type
	IS
		rcError styLDC_ITEMS_CONEXIONES;
	BEGIN

		rcError.ITCONIDRG := inuITCONIDRG;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuITCONIDRG
			 )
		then
			 return(rcData.ITCONITVA);
		end if;
		Load
		(
		 		inuITCONIDRG
		);
		return(rcData.ITCONITVA);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetITCONTIPO1
	(
		inuITCONIDRG in LDC_ITEMS_CONEXIONES.ITCONIDRG%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_CONEXIONES.ITCONTIPO1%type
	IS
		rcError styLDC_ITEMS_CONEXIONES;
	BEGIN

		rcError.ITCONIDRG := inuITCONIDRG;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuITCONIDRG
			 )
		then
			 return(rcData.ITCONTIPO1);
		end if;
		Load
		(
		 		inuITCONIDRG
		);
		return(rcData.ITCONTIPO1);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetITCONTIPO2
	(
		inuITCONIDRG in LDC_ITEMS_CONEXIONES.ITCONIDRG%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_CONEXIONES.ITCONTIPO2%type
	IS
		rcError styLDC_ITEMS_CONEXIONES;
	BEGIN

		rcError.ITCONIDRG := inuITCONIDRG;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuITCONIDRG
			 )
		then
			 return(rcData.ITCONTIPO2);
		end if;
		Load
		(
		 		inuITCONIDRG
		);
		return(rcData.ITCONTIPO2);
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
end DALDC_ITEMS_CONEXIONES;
/
PROMPT Otorgando permisos de ejecucion a DALDC_ITEMS_CONEXIONES
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_ITEMS_CONEXIONES', 'ADM_PERSON');
END;
/