CREATE OR REPLACE PACKAGE ADM_PERSON.DALDC_INSTAL_GASODOM_FNB
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
		inuCONSECUTIVE in LDC_INSTAL_GASODOM_FNB.CONSECUTIVE%type
	)
	IS
		SELECT LDC_INSTAL_GASODOM_FNB.*,LDC_INSTAL_GASODOM_FNB.rowid
		FROM LDC_INSTAL_GASODOM_FNB
		WHERE
		    CONSECUTIVE = inuCONSECUTIVE;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_INSTAL_GASODOM_FNB.*,LDC_INSTAL_GASODOM_FNB.rowid
		FROM LDC_INSTAL_GASODOM_FNB
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_INSTAL_GASODOM_FNB  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_INSTAL_GASODOM_FNB is table of styLDC_INSTAL_GASODOM_FNB index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_INSTAL_GASODOM_FNB;

	/* Tipos referenciando al registro */
	type tytbCONSECUTIVE is table of LDC_INSTAL_GASODOM_FNB.CONSECUTIVE%type index by binary_integer;
	type tytbPACKAGE_ID is table of LDC_INSTAL_GASODOM_FNB.PACKAGE_ID%type index by binary_integer;
	type tytbSUBSCRIPTION_ID is table of LDC_INSTAL_GASODOM_FNB.SUBSCRIPTION_ID%type index by binary_integer;
	type tytbSUPPLIER_ID is table of LDC_INSTAL_GASODOM_FNB.SUPPLIER_ID%type index by binary_integer;
	type tytbREGISTER_DATE is table of LDC_INSTAL_GASODOM_FNB.REGISTER_DATE%type index by binary_integer;
	type tytbINSTALLATION_DATE is table of LDC_INSTAL_GASODOM_FNB.INSTALLATION_DATE%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_INSTAL_GASODOM_FNB is record
	(
		CONSECUTIVE   tytbCONSECUTIVE,
		PACKAGE_ID   tytbPACKAGE_ID,
		SUBSCRIPTION_ID   tytbSUBSCRIPTION_ID,
		SUPPLIER_ID   tytbSUPPLIER_ID,
		REGISTER_DATE   tytbREGISTER_DATE,
		INSTALLATION_DATE   tytbINSTALLATION_DATE,
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
		inuCONSECUTIVE in LDC_INSTAL_GASODOM_FNB.CONSECUTIVE%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuCONSECUTIVE in LDC_INSTAL_GASODOM_FNB.CONSECUTIVE%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuCONSECUTIVE in LDC_INSTAL_GASODOM_FNB.CONSECUTIVE%type
	);

	PROCEDURE getRecord
	(
		inuCONSECUTIVE in LDC_INSTAL_GASODOM_FNB.CONSECUTIVE%type,
		orcRecord out nocopy styLDC_INSTAL_GASODOM_FNB
	);

	FUNCTION frcGetRcData
	(
		inuCONSECUTIVE in LDC_INSTAL_GASODOM_FNB.CONSECUTIVE%type
	)
	RETURN styLDC_INSTAL_GASODOM_FNB;

	FUNCTION frcGetRcData
	RETURN styLDC_INSTAL_GASODOM_FNB;

	FUNCTION frcGetRecord
	(
		inuCONSECUTIVE in LDC_INSTAL_GASODOM_FNB.CONSECUTIVE%type
	)
	RETURN styLDC_INSTAL_GASODOM_FNB;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_INSTAL_GASODOM_FNB
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_INSTAL_GASODOM_FNB in styLDC_INSTAL_GASODOM_FNB
	);

	PROCEDURE insRecord
	(
		ircLDC_INSTAL_GASODOM_FNB in styLDC_INSTAL_GASODOM_FNB,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_INSTAL_GASODOM_FNB in out nocopy tytbLDC_INSTAL_GASODOM_FNB
	);

	PROCEDURE delRecord
	(
		inuCONSECUTIVE in LDC_INSTAL_GASODOM_FNB.CONSECUTIVE%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_INSTAL_GASODOM_FNB in out nocopy tytbLDC_INSTAL_GASODOM_FNB,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_INSTAL_GASODOM_FNB in styLDC_INSTAL_GASODOM_FNB,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_INSTAL_GASODOM_FNB in out nocopy tytbLDC_INSTAL_GASODOM_FNB,
		inuLock in number default 1
	);

	PROCEDURE updPACKAGE_ID
	(
		inuCONSECUTIVE in LDC_INSTAL_GASODOM_FNB.CONSECUTIVE%type,
		inuPACKAGE_ID$ in LDC_INSTAL_GASODOM_FNB.PACKAGE_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updSUBSCRIPTION_ID
	(
		inuCONSECUTIVE in LDC_INSTAL_GASODOM_FNB.CONSECUTIVE%type,
		inuSUBSCRIPTION_ID$ in LDC_INSTAL_GASODOM_FNB.SUBSCRIPTION_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updSUPPLIER_ID
	(
		inuCONSECUTIVE in LDC_INSTAL_GASODOM_FNB.CONSECUTIVE%type,
		inuSUPPLIER_ID$ in LDC_INSTAL_GASODOM_FNB.SUPPLIER_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updREGISTER_DATE
	(
		inuCONSECUTIVE in LDC_INSTAL_GASODOM_FNB.CONSECUTIVE%type,
		idtREGISTER_DATE$ in LDC_INSTAL_GASODOM_FNB.REGISTER_DATE%type,
		inuLock in number default 0
	);

	PROCEDURE updINSTALLATION_DATE
	(
		inuCONSECUTIVE in LDC_INSTAL_GASODOM_FNB.CONSECUTIVE%type,
		idtINSTALLATION_DATE$ in LDC_INSTAL_GASODOM_FNB.INSTALLATION_DATE%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetCONSECUTIVE
	(
		inuCONSECUTIVE in LDC_INSTAL_GASODOM_FNB.CONSECUTIVE%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_INSTAL_GASODOM_FNB.CONSECUTIVE%type;

	FUNCTION fnuGetPACKAGE_ID
	(
		inuCONSECUTIVE in LDC_INSTAL_GASODOM_FNB.CONSECUTIVE%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_INSTAL_GASODOM_FNB.PACKAGE_ID%type;

	FUNCTION fnuGetSUBSCRIPTION_ID
	(
		inuCONSECUTIVE in LDC_INSTAL_GASODOM_FNB.CONSECUTIVE%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_INSTAL_GASODOM_FNB.SUBSCRIPTION_ID%type;

	FUNCTION fnuGetSUPPLIER_ID
	(
		inuCONSECUTIVE in LDC_INSTAL_GASODOM_FNB.CONSECUTIVE%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_INSTAL_GASODOM_FNB.SUPPLIER_ID%type;

	FUNCTION fdtGetREGISTER_DATE
	(
		inuCONSECUTIVE in LDC_INSTAL_GASODOM_FNB.CONSECUTIVE%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_INSTAL_GASODOM_FNB.REGISTER_DATE%type;

	FUNCTION fdtGetINSTALLATION_DATE
	(
		inuCONSECUTIVE in LDC_INSTAL_GASODOM_FNB.CONSECUTIVE%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_INSTAL_GASODOM_FNB.INSTALLATION_DATE%type;


	PROCEDURE LockByPk
	(
		inuCONSECUTIVE in LDC_INSTAL_GASODOM_FNB.CONSECUTIVE%type,
		orcLDC_INSTAL_GASODOM_FNB  out styLDC_INSTAL_GASODOM_FNB
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_INSTAL_GASODOM_FNB  out styLDC_INSTAL_GASODOM_FNB
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_INSTAL_GASODOM_FNB;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALDC_INSTAL_GASODOM_FNB
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_INSTAL_GASODOM_FNB';
	 cnuGeEntityId constant varchar2(30) := 1453; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuCONSECUTIVE in LDC_INSTAL_GASODOM_FNB.CONSECUTIVE%type
	)
	IS
		SELECT LDC_INSTAL_GASODOM_FNB.*,LDC_INSTAL_GASODOM_FNB.rowid
		FROM LDC_INSTAL_GASODOM_FNB
		WHERE  CONSECUTIVE = inuCONSECUTIVE
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_INSTAL_GASODOM_FNB.*,LDC_INSTAL_GASODOM_FNB.rowid
		FROM LDC_INSTAL_GASODOM_FNB
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_INSTAL_GASODOM_FNB is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_INSTAL_GASODOM_FNB;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_INSTAL_GASODOM_FNB default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.CONSECUTIVE);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuCONSECUTIVE in LDC_INSTAL_GASODOM_FNB.CONSECUTIVE%type,
		orcLDC_INSTAL_GASODOM_FNB  out styLDC_INSTAL_GASODOM_FNB
	)
	IS
		rcError styLDC_INSTAL_GASODOM_FNB;
	BEGIN
		rcError.CONSECUTIVE := inuCONSECUTIVE;

		Open cuLockRcByPk
		(
			inuCONSECUTIVE
		);

		fetch cuLockRcByPk into orcLDC_INSTAL_GASODOM_FNB;
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
		orcLDC_INSTAL_GASODOM_FNB  out styLDC_INSTAL_GASODOM_FNB
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_INSTAL_GASODOM_FNB;
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
		itbLDC_INSTAL_GASODOM_FNB  in out nocopy tytbLDC_INSTAL_GASODOM_FNB
	)
	IS
	BEGIN
			rcRecOfTab.CONSECUTIVE.delete;
			rcRecOfTab.PACKAGE_ID.delete;
			rcRecOfTab.SUBSCRIPTION_ID.delete;
			rcRecOfTab.SUPPLIER_ID.delete;
			rcRecOfTab.REGISTER_DATE.delete;
			rcRecOfTab.INSTALLATION_DATE.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_INSTAL_GASODOM_FNB  in out nocopy tytbLDC_INSTAL_GASODOM_FNB,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_INSTAL_GASODOM_FNB);

		for n in itbLDC_INSTAL_GASODOM_FNB.first .. itbLDC_INSTAL_GASODOM_FNB.last loop
			rcRecOfTab.CONSECUTIVE(n) := itbLDC_INSTAL_GASODOM_FNB(n).CONSECUTIVE;
			rcRecOfTab.PACKAGE_ID(n) := itbLDC_INSTAL_GASODOM_FNB(n).PACKAGE_ID;
			rcRecOfTab.SUBSCRIPTION_ID(n) := itbLDC_INSTAL_GASODOM_FNB(n).SUBSCRIPTION_ID;
			rcRecOfTab.SUPPLIER_ID(n) := itbLDC_INSTAL_GASODOM_FNB(n).SUPPLIER_ID;
			rcRecOfTab.REGISTER_DATE(n) := itbLDC_INSTAL_GASODOM_FNB(n).REGISTER_DATE;
			rcRecOfTab.INSTALLATION_DATE(n) := itbLDC_INSTAL_GASODOM_FNB(n).INSTALLATION_DATE;
			rcRecOfTab.row_id(n) := itbLDC_INSTAL_GASODOM_FNB(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuCONSECUTIVE in LDC_INSTAL_GASODOM_FNB.CONSECUTIVE%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuCONSECUTIVE
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
		inuCONSECUTIVE in LDC_INSTAL_GASODOM_FNB.CONSECUTIVE%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuCONSECUTIVE = rcData.CONSECUTIVE
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
		inuCONSECUTIVE in LDC_INSTAL_GASODOM_FNB.CONSECUTIVE%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuCONSECUTIVE
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuCONSECUTIVE in LDC_INSTAL_GASODOM_FNB.CONSECUTIVE%type
	)
	IS
		rcError styLDC_INSTAL_GASODOM_FNB;
	BEGIN		rcError.CONSECUTIVE:=inuCONSECUTIVE;

		Load
		(
			inuCONSECUTIVE
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
		inuCONSECUTIVE in LDC_INSTAL_GASODOM_FNB.CONSECUTIVE%type
	)
	IS
	BEGIN
		Load
		(
			inuCONSECUTIVE
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuCONSECUTIVE in LDC_INSTAL_GASODOM_FNB.CONSECUTIVE%type,
		orcRecord out nocopy styLDC_INSTAL_GASODOM_FNB
	)
	IS
		rcError styLDC_INSTAL_GASODOM_FNB;
	BEGIN		rcError.CONSECUTIVE:=inuCONSECUTIVE;

		Load
		(
			inuCONSECUTIVE
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuCONSECUTIVE in LDC_INSTAL_GASODOM_FNB.CONSECUTIVE%type
	)
	RETURN styLDC_INSTAL_GASODOM_FNB
	IS
		rcError styLDC_INSTAL_GASODOM_FNB;
	BEGIN
		rcError.CONSECUTIVE:=inuCONSECUTIVE;

		Load
		(
			inuCONSECUTIVE
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuCONSECUTIVE in LDC_INSTAL_GASODOM_FNB.CONSECUTIVE%type
	)
	RETURN styLDC_INSTAL_GASODOM_FNB
	IS
		rcError styLDC_INSTAL_GASODOM_FNB;
	BEGIN
		rcError.CONSECUTIVE:=inuCONSECUTIVE;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuCONSECUTIVE
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuCONSECUTIVE
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_INSTAL_GASODOM_FNB
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_INSTAL_GASODOM_FNB
	)
	IS
		rfLDC_INSTAL_GASODOM_FNB tyrfLDC_INSTAL_GASODOM_FNB;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_INSTAL_GASODOM_FNB.*, LDC_INSTAL_GASODOM_FNB.rowid FROM LDC_INSTAL_GASODOM_FNB';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_INSTAL_GASODOM_FNB for sbFullQuery;

		fetch rfLDC_INSTAL_GASODOM_FNB bulk collect INTO otbResult;

		close rfLDC_INSTAL_GASODOM_FNB;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_INSTAL_GASODOM_FNB.*, LDC_INSTAL_GASODOM_FNB.rowid FROM LDC_INSTAL_GASODOM_FNB';
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
		ircLDC_INSTAL_GASODOM_FNB in styLDC_INSTAL_GASODOM_FNB
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_INSTAL_GASODOM_FNB,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_INSTAL_GASODOM_FNB in styLDC_INSTAL_GASODOM_FNB,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_INSTAL_GASODOM_FNB.CONSECUTIVE is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|CONSECUTIVE');
			raise ex.controlled_error;
		end if;

		insert into LDC_INSTAL_GASODOM_FNB
		(
			CONSECUTIVE,
			PACKAGE_ID,
			SUBSCRIPTION_ID,
			SUPPLIER_ID,
			REGISTER_DATE,
			INSTALLATION_DATE
		)
		values
		(
			ircLDC_INSTAL_GASODOM_FNB.CONSECUTIVE,
			ircLDC_INSTAL_GASODOM_FNB.PACKAGE_ID,
			ircLDC_INSTAL_GASODOM_FNB.SUBSCRIPTION_ID,
			ircLDC_INSTAL_GASODOM_FNB.SUPPLIER_ID,
			ircLDC_INSTAL_GASODOM_FNB.REGISTER_DATE,
			ircLDC_INSTAL_GASODOM_FNB.INSTALLATION_DATE
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_INSTAL_GASODOM_FNB));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_INSTAL_GASODOM_FNB in out nocopy tytbLDC_INSTAL_GASODOM_FNB
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_INSTAL_GASODOM_FNB,blUseRowID);
		forall n in iotbLDC_INSTAL_GASODOM_FNB.first..iotbLDC_INSTAL_GASODOM_FNB.last
			insert into LDC_INSTAL_GASODOM_FNB
			(
				CONSECUTIVE,
				PACKAGE_ID,
				SUBSCRIPTION_ID,
				SUPPLIER_ID,
				REGISTER_DATE,
				INSTALLATION_DATE
			)
			values
			(
				rcRecOfTab.CONSECUTIVE(n),
				rcRecOfTab.PACKAGE_ID(n),
				rcRecOfTab.SUBSCRIPTION_ID(n),
				rcRecOfTab.SUPPLIER_ID(n),
				rcRecOfTab.REGISTER_DATE(n),
				rcRecOfTab.INSTALLATION_DATE(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuCONSECUTIVE in LDC_INSTAL_GASODOM_FNB.CONSECUTIVE%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_INSTAL_GASODOM_FNB;
	BEGIN
		rcError.CONSECUTIVE := inuCONSECUTIVE;

		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVE,
				rcData
			);
		end if;


		delete
		from LDC_INSTAL_GASODOM_FNB
		where
       		CONSECUTIVE=inuCONSECUTIVE;
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
		rcError  styLDC_INSTAL_GASODOM_FNB;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_INSTAL_GASODOM_FNB
		where
			rowid = iriRowID
		returning
			CONSECUTIVE
		into
			rcError.CONSECUTIVE;
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
		iotbLDC_INSTAL_GASODOM_FNB in out nocopy tytbLDC_INSTAL_GASODOM_FNB,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_INSTAL_GASODOM_FNB;
	BEGIN
		FillRecordOfTables(iotbLDC_INSTAL_GASODOM_FNB, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_INSTAL_GASODOM_FNB.first .. iotbLDC_INSTAL_GASODOM_FNB.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_INSTAL_GASODOM_FNB.first .. iotbLDC_INSTAL_GASODOM_FNB.last
				delete
				from LDC_INSTAL_GASODOM_FNB
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_INSTAL_GASODOM_FNB.first .. iotbLDC_INSTAL_GASODOM_FNB.last loop
					LockByPk
					(
						rcRecOfTab.CONSECUTIVE(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_INSTAL_GASODOM_FNB.first .. iotbLDC_INSTAL_GASODOM_FNB.last
				delete
				from LDC_INSTAL_GASODOM_FNB
				where
		         	CONSECUTIVE = rcRecOfTab.CONSECUTIVE(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_INSTAL_GASODOM_FNB in styLDC_INSTAL_GASODOM_FNB,
		inuLock in number default 0
	)
	IS
		nuCONSECUTIVE	LDC_INSTAL_GASODOM_FNB.CONSECUTIVE%type;
	BEGIN
		if ircLDC_INSTAL_GASODOM_FNB.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_INSTAL_GASODOM_FNB.rowid,rcData);
			end if;
			update LDC_INSTAL_GASODOM_FNB
			set
				PACKAGE_ID = ircLDC_INSTAL_GASODOM_FNB.PACKAGE_ID,
				SUBSCRIPTION_ID = ircLDC_INSTAL_GASODOM_FNB.SUBSCRIPTION_ID,
				SUPPLIER_ID = ircLDC_INSTAL_GASODOM_FNB.SUPPLIER_ID,
				REGISTER_DATE = ircLDC_INSTAL_GASODOM_FNB.REGISTER_DATE,
				INSTALLATION_DATE = ircLDC_INSTAL_GASODOM_FNB.INSTALLATION_DATE
			where
				rowid = ircLDC_INSTAL_GASODOM_FNB.rowid
			returning
				CONSECUTIVE
			into
				nuCONSECUTIVE;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_INSTAL_GASODOM_FNB.CONSECUTIVE,
					rcData
				);
			end if;

			update LDC_INSTAL_GASODOM_FNB
			set
				PACKAGE_ID = ircLDC_INSTAL_GASODOM_FNB.PACKAGE_ID,
				SUBSCRIPTION_ID = ircLDC_INSTAL_GASODOM_FNB.SUBSCRIPTION_ID,
				SUPPLIER_ID = ircLDC_INSTAL_GASODOM_FNB.SUPPLIER_ID,
				REGISTER_DATE = ircLDC_INSTAL_GASODOM_FNB.REGISTER_DATE,
				INSTALLATION_DATE = ircLDC_INSTAL_GASODOM_FNB.INSTALLATION_DATE
			where
				CONSECUTIVE = ircLDC_INSTAL_GASODOM_FNB.CONSECUTIVE
			returning
				CONSECUTIVE
			into
				nuCONSECUTIVE;
		end if;
		if
			nuCONSECUTIVE is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_INSTAL_GASODOM_FNB));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_INSTAL_GASODOM_FNB in out nocopy tytbLDC_INSTAL_GASODOM_FNB,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_INSTAL_GASODOM_FNB;
	BEGIN
		FillRecordOfTables(iotbLDC_INSTAL_GASODOM_FNB,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_INSTAL_GASODOM_FNB.first .. iotbLDC_INSTAL_GASODOM_FNB.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_INSTAL_GASODOM_FNB.first .. iotbLDC_INSTAL_GASODOM_FNB.last
				update LDC_INSTAL_GASODOM_FNB
				set
					PACKAGE_ID = rcRecOfTab.PACKAGE_ID(n),
					SUBSCRIPTION_ID = rcRecOfTab.SUBSCRIPTION_ID(n),
					SUPPLIER_ID = rcRecOfTab.SUPPLIER_ID(n),
					REGISTER_DATE = rcRecOfTab.REGISTER_DATE(n),
					INSTALLATION_DATE = rcRecOfTab.INSTALLATION_DATE(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_INSTAL_GASODOM_FNB.first .. iotbLDC_INSTAL_GASODOM_FNB.last loop
					LockByPk
					(
						rcRecOfTab.CONSECUTIVE(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_INSTAL_GASODOM_FNB.first .. iotbLDC_INSTAL_GASODOM_FNB.last
				update LDC_INSTAL_GASODOM_FNB
				SET
					PACKAGE_ID = rcRecOfTab.PACKAGE_ID(n),
					SUBSCRIPTION_ID = rcRecOfTab.SUBSCRIPTION_ID(n),
					SUPPLIER_ID = rcRecOfTab.SUPPLIER_ID(n),
					REGISTER_DATE = rcRecOfTab.REGISTER_DATE(n),
					INSTALLATION_DATE = rcRecOfTab.INSTALLATION_DATE(n)
				where
					CONSECUTIVE = rcRecOfTab.CONSECUTIVE(n)
;
		end if;
	END;
	PROCEDURE updPACKAGE_ID
	(
		inuCONSECUTIVE in LDC_INSTAL_GASODOM_FNB.CONSECUTIVE%type,
		inuPACKAGE_ID$ in LDC_INSTAL_GASODOM_FNB.PACKAGE_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_INSTAL_GASODOM_FNB;
	BEGIN
		rcError.CONSECUTIVE := inuCONSECUTIVE;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVE,
				rcData
			);
		end if;

		update LDC_INSTAL_GASODOM_FNB
		set
			PACKAGE_ID = inuPACKAGE_ID$
		where
			CONSECUTIVE = inuCONSECUTIVE;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PACKAGE_ID:= inuPACKAGE_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSUBSCRIPTION_ID
	(
		inuCONSECUTIVE in LDC_INSTAL_GASODOM_FNB.CONSECUTIVE%type,
		inuSUBSCRIPTION_ID$ in LDC_INSTAL_GASODOM_FNB.SUBSCRIPTION_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_INSTAL_GASODOM_FNB;
	BEGIN
		rcError.CONSECUTIVE := inuCONSECUTIVE;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVE,
				rcData
			);
		end if;

		update LDC_INSTAL_GASODOM_FNB
		set
			SUBSCRIPTION_ID = inuSUBSCRIPTION_ID$
		where
			CONSECUTIVE = inuCONSECUTIVE;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SUBSCRIPTION_ID:= inuSUBSCRIPTION_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSUPPLIER_ID
	(
		inuCONSECUTIVE in LDC_INSTAL_GASODOM_FNB.CONSECUTIVE%type,
		inuSUPPLIER_ID$ in LDC_INSTAL_GASODOM_FNB.SUPPLIER_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_INSTAL_GASODOM_FNB;
	BEGIN
		rcError.CONSECUTIVE := inuCONSECUTIVE;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVE,
				rcData
			);
		end if;

		update LDC_INSTAL_GASODOM_FNB
		set
			SUPPLIER_ID = inuSUPPLIER_ID$
		where
			CONSECUTIVE = inuCONSECUTIVE;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SUPPLIER_ID:= inuSUPPLIER_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updREGISTER_DATE
	(
		inuCONSECUTIVE in LDC_INSTAL_GASODOM_FNB.CONSECUTIVE%type,
		idtREGISTER_DATE$ in LDC_INSTAL_GASODOM_FNB.REGISTER_DATE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_INSTAL_GASODOM_FNB;
	BEGIN
		rcError.CONSECUTIVE := inuCONSECUTIVE;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVE,
				rcData
			);
		end if;

		update LDC_INSTAL_GASODOM_FNB
		set
			REGISTER_DATE = idtREGISTER_DATE$
		where
			CONSECUTIVE = inuCONSECUTIVE;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.REGISTER_DATE:= idtREGISTER_DATE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updINSTALLATION_DATE
	(
		inuCONSECUTIVE in LDC_INSTAL_GASODOM_FNB.CONSECUTIVE%type,
		idtINSTALLATION_DATE$ in LDC_INSTAL_GASODOM_FNB.INSTALLATION_DATE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_INSTAL_GASODOM_FNB;
	BEGIN
		rcError.CONSECUTIVE := inuCONSECUTIVE;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVE,
				rcData
			);
		end if;

		update LDC_INSTAL_GASODOM_FNB
		set
			INSTALLATION_DATE = idtINSTALLATION_DATE$
		where
			CONSECUTIVE = inuCONSECUTIVE;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.INSTALLATION_DATE:= idtINSTALLATION_DATE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetCONSECUTIVE
	(
		inuCONSECUTIVE in LDC_INSTAL_GASODOM_FNB.CONSECUTIVE%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_INSTAL_GASODOM_FNB.CONSECUTIVE%type
	IS
		rcError styLDC_INSTAL_GASODOM_FNB;
	BEGIN

		rcError.CONSECUTIVE := inuCONSECUTIVE;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVE
			 )
		then
			 return(rcData.CONSECUTIVE);
		end if;
		Load
		(
		 		inuCONSECUTIVE
		);
		return(rcData.CONSECUTIVE);
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
		inuCONSECUTIVE in LDC_INSTAL_GASODOM_FNB.CONSECUTIVE%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_INSTAL_GASODOM_FNB.PACKAGE_ID%type
	IS
		rcError styLDC_INSTAL_GASODOM_FNB;
	BEGIN

		rcError.CONSECUTIVE := inuCONSECUTIVE;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVE
			 )
		then
			 return(rcData.PACKAGE_ID);
		end if;
		Load
		(
		 		inuCONSECUTIVE
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
	FUNCTION fnuGetSUBSCRIPTION_ID
	(
		inuCONSECUTIVE in LDC_INSTAL_GASODOM_FNB.CONSECUTIVE%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_INSTAL_GASODOM_FNB.SUBSCRIPTION_ID%type
	IS
		rcError styLDC_INSTAL_GASODOM_FNB;
	BEGIN

		rcError.CONSECUTIVE := inuCONSECUTIVE;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVE
			 )
		then
			 return(rcData.SUBSCRIPTION_ID);
		end if;
		Load
		(
		 		inuCONSECUTIVE
		);
		return(rcData.SUBSCRIPTION_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetSUPPLIER_ID
	(
		inuCONSECUTIVE in LDC_INSTAL_GASODOM_FNB.CONSECUTIVE%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_INSTAL_GASODOM_FNB.SUPPLIER_ID%type
	IS
		rcError styLDC_INSTAL_GASODOM_FNB;
	BEGIN

		rcError.CONSECUTIVE := inuCONSECUTIVE;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVE
			 )
		then
			 return(rcData.SUPPLIER_ID);
		end if;
		Load
		(
		 		inuCONSECUTIVE
		);
		return(rcData.SUPPLIER_ID);
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
		inuCONSECUTIVE in LDC_INSTAL_GASODOM_FNB.CONSECUTIVE%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_INSTAL_GASODOM_FNB.REGISTER_DATE%type
	IS
		rcError styLDC_INSTAL_GASODOM_FNB;
	BEGIN

		rcError.CONSECUTIVE := inuCONSECUTIVE;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVE
			 )
		then
			 return(rcData.REGISTER_DATE);
		end if;
		Load
		(
		 		inuCONSECUTIVE
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
	FUNCTION fdtGetINSTALLATION_DATE
	(
		inuCONSECUTIVE in LDC_INSTAL_GASODOM_FNB.CONSECUTIVE%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_INSTAL_GASODOM_FNB.INSTALLATION_DATE%type
	IS
		rcError styLDC_INSTAL_GASODOM_FNB;
	BEGIN

		rcError.CONSECUTIVE := inuCONSECUTIVE;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVE
			 )
		then
			 return(rcData.INSTALLATION_DATE);
		end if;
		Load
		(
		 		inuCONSECUTIVE
		);
		return(rcData.INSTALLATION_DATE);
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
end DALDC_INSTAL_GASODOM_FNB;
/
PROMPT Otorgando permisos de ejecucion a DALDC_INSTAL_GASODOM_FNB
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_INSTAL_GASODOM_FNB', 'ADM_PERSON');
END;
/