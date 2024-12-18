CREATE OR REPLACE PACKAGE ADM_PERSON.DALDC_EQUI_CAUSAL_SSPD
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
		inuPACKAGE_TYPE_ID in LDC_EQUI_CAUSAL_SSPD.PACKAGE_TYPE_ID%type,
		inuCAUSAL_ID in LDC_EQUI_CAUSAL_SSPD.CAUSAL_ID%type
	)
	IS
		SELECT LDC_EQUI_CAUSAL_SSPD.*,LDC_EQUI_CAUSAL_SSPD.rowid
		FROM LDC_EQUI_CAUSAL_SSPD
		WHERE
		    PACKAGE_TYPE_ID = inuPACKAGE_TYPE_ID
		    and CAUSAL_ID = inuCAUSAL_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_EQUI_CAUSAL_SSPD.*,LDC_EQUI_CAUSAL_SSPD.rowid
		FROM LDC_EQUI_CAUSAL_SSPD
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_EQUI_CAUSAL_SSPD  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_EQUI_CAUSAL_SSPD is table of styLDC_EQUI_CAUSAL_SSPD index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_EQUI_CAUSAL_SSPD;

	/* Tipos referenciando al registro */
	type tytbPACKAGE_TYPE_ID is table of LDC_EQUI_CAUSAL_SSPD.PACKAGE_TYPE_ID%type index by binary_integer;
	type tytbCAUSAL_ID is table of LDC_EQUI_CAUSAL_SSPD.CAUSAL_ID%type index by binary_integer;
	type tytbCAUSAL_SSPD_ID is table of LDC_EQUI_CAUSAL_SSPD.CAUSAL_SSPD_ID%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_EQUI_CAUSAL_SSPD is record
	(
		PACKAGE_TYPE_ID   tytbPACKAGE_TYPE_ID,
		CAUSAL_ID   tytbCAUSAL_ID,
		CAUSAL_SSPD_ID   tytbCAUSAL_SSPD_ID,
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
		inuPACKAGE_TYPE_ID in LDC_EQUI_CAUSAL_SSPD.PACKAGE_TYPE_ID%type,
		inuCAUSAL_ID in LDC_EQUI_CAUSAL_SSPD.CAUSAL_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuPACKAGE_TYPE_ID in LDC_EQUI_CAUSAL_SSPD.PACKAGE_TYPE_ID%type,
		inuCAUSAL_ID in LDC_EQUI_CAUSAL_SSPD.CAUSAL_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuPACKAGE_TYPE_ID in LDC_EQUI_CAUSAL_SSPD.PACKAGE_TYPE_ID%type,
		inuCAUSAL_ID in LDC_EQUI_CAUSAL_SSPD.CAUSAL_ID%type
	);

	PROCEDURE getRecord
	(
		inuPACKAGE_TYPE_ID in LDC_EQUI_CAUSAL_SSPD.PACKAGE_TYPE_ID%type,
		inuCAUSAL_ID in LDC_EQUI_CAUSAL_SSPD.CAUSAL_ID%type,
		orcRecord out nocopy styLDC_EQUI_CAUSAL_SSPD
	);

	FUNCTION frcGetRcData
	(
		inuPACKAGE_TYPE_ID in LDC_EQUI_CAUSAL_SSPD.PACKAGE_TYPE_ID%type,
		inuCAUSAL_ID in LDC_EQUI_CAUSAL_SSPD.CAUSAL_ID%type
	)
	RETURN styLDC_EQUI_CAUSAL_SSPD;

	FUNCTION frcGetRcData
	RETURN styLDC_EQUI_CAUSAL_SSPD;

	FUNCTION frcGetRecord
	(
		inuPACKAGE_TYPE_ID in LDC_EQUI_CAUSAL_SSPD.PACKAGE_TYPE_ID%type,
		inuCAUSAL_ID in LDC_EQUI_CAUSAL_SSPD.CAUSAL_ID%type
	)
	RETURN styLDC_EQUI_CAUSAL_SSPD;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_EQUI_CAUSAL_SSPD
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_EQUI_CAUSAL_SSPD in styLDC_EQUI_CAUSAL_SSPD
	);

	PROCEDURE insRecord
	(
		ircLDC_EQUI_CAUSAL_SSPD in styLDC_EQUI_CAUSAL_SSPD,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_EQUI_CAUSAL_SSPD in out nocopy tytbLDC_EQUI_CAUSAL_SSPD
	);

	PROCEDURE delRecord
	(
		inuPACKAGE_TYPE_ID in LDC_EQUI_CAUSAL_SSPD.PACKAGE_TYPE_ID%type,
		inuCAUSAL_ID in LDC_EQUI_CAUSAL_SSPD.CAUSAL_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_EQUI_CAUSAL_SSPD in out nocopy tytbLDC_EQUI_CAUSAL_SSPD,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_EQUI_CAUSAL_SSPD in styLDC_EQUI_CAUSAL_SSPD,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_EQUI_CAUSAL_SSPD in out nocopy tytbLDC_EQUI_CAUSAL_SSPD,
		inuLock in number default 1
	);

	PROCEDURE updCAUSAL_SSPD_ID
	(
		inuPACKAGE_TYPE_ID in LDC_EQUI_CAUSAL_SSPD.PACKAGE_TYPE_ID%type,
		inuCAUSAL_ID in LDC_EQUI_CAUSAL_SSPD.CAUSAL_ID%type,
		inuCAUSAL_SSPD_ID$ in LDC_EQUI_CAUSAL_SSPD.CAUSAL_SSPD_ID%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetPACKAGE_TYPE_ID
	(
		inuPACKAGE_TYPE_ID in LDC_EQUI_CAUSAL_SSPD.PACKAGE_TYPE_ID%type,
		inuCAUSAL_ID in LDC_EQUI_CAUSAL_SSPD.CAUSAL_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_EQUI_CAUSAL_SSPD.PACKAGE_TYPE_ID%type;

	FUNCTION fnuGetCAUSAL_ID
	(
		inuPACKAGE_TYPE_ID in LDC_EQUI_CAUSAL_SSPD.PACKAGE_TYPE_ID%type,
		inuCAUSAL_ID in LDC_EQUI_CAUSAL_SSPD.CAUSAL_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_EQUI_CAUSAL_SSPD.CAUSAL_ID%type;

	FUNCTION fnuGetCAUSAL_SSPD_ID
	(
		inuPACKAGE_TYPE_ID in LDC_EQUI_CAUSAL_SSPD.PACKAGE_TYPE_ID%type,
		inuCAUSAL_ID in LDC_EQUI_CAUSAL_SSPD.CAUSAL_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_EQUI_CAUSAL_SSPD.CAUSAL_SSPD_ID%type;


	PROCEDURE LockByPk
	(
		inuPACKAGE_TYPE_ID in LDC_EQUI_CAUSAL_SSPD.PACKAGE_TYPE_ID%type,
		inuCAUSAL_ID in LDC_EQUI_CAUSAL_SSPD.CAUSAL_ID%type,
		orcLDC_EQUI_CAUSAL_SSPD  out styLDC_EQUI_CAUSAL_SSPD
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_EQUI_CAUSAL_SSPD  out styLDC_EQUI_CAUSAL_SSPD
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_EQUI_CAUSAL_SSPD;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALDC_EQUI_CAUSAL_SSPD
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_EQUI_CAUSAL_SSPD';
	 cnuGeEntityId constant varchar2(30) := 8846; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuPACKAGE_TYPE_ID in LDC_EQUI_CAUSAL_SSPD.PACKAGE_TYPE_ID%type,
		inuCAUSAL_ID in LDC_EQUI_CAUSAL_SSPD.CAUSAL_ID%type
	)
	IS
		SELECT LDC_EQUI_CAUSAL_SSPD.*,LDC_EQUI_CAUSAL_SSPD.rowid
		FROM LDC_EQUI_CAUSAL_SSPD
		WHERE  PACKAGE_TYPE_ID = inuPACKAGE_TYPE_ID
			and CAUSAL_ID = inuCAUSAL_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_EQUI_CAUSAL_SSPD.*,LDC_EQUI_CAUSAL_SSPD.rowid
		FROM LDC_EQUI_CAUSAL_SSPD
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_EQUI_CAUSAL_SSPD is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_EQUI_CAUSAL_SSPD;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_EQUI_CAUSAL_SSPD default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.PACKAGE_TYPE_ID);
		sbPk:=sbPk||','||ut_convert.fsbToChar(rcI.CAUSAL_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuPACKAGE_TYPE_ID in LDC_EQUI_CAUSAL_SSPD.PACKAGE_TYPE_ID%type,
		inuCAUSAL_ID in LDC_EQUI_CAUSAL_SSPD.CAUSAL_ID%type,
		orcLDC_EQUI_CAUSAL_SSPD  out styLDC_EQUI_CAUSAL_SSPD
	)
	IS
		rcError styLDC_EQUI_CAUSAL_SSPD;
	BEGIN
		rcError.PACKAGE_TYPE_ID := inuPACKAGE_TYPE_ID;
		rcError.CAUSAL_ID := inuCAUSAL_ID;

		Open cuLockRcByPk
		(
			inuPACKAGE_TYPE_ID,
			inuCAUSAL_ID
		);

		fetch cuLockRcByPk into orcLDC_EQUI_CAUSAL_SSPD;
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
		orcLDC_EQUI_CAUSAL_SSPD  out styLDC_EQUI_CAUSAL_SSPD
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_EQUI_CAUSAL_SSPD;
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
		itbLDC_EQUI_CAUSAL_SSPD  in out nocopy tytbLDC_EQUI_CAUSAL_SSPD
	)
	IS
	BEGIN
			rcRecOfTab.PACKAGE_TYPE_ID.delete;
			rcRecOfTab.CAUSAL_ID.delete;
			rcRecOfTab.CAUSAL_SSPD_ID.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_EQUI_CAUSAL_SSPD  in out nocopy tytbLDC_EQUI_CAUSAL_SSPD,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_EQUI_CAUSAL_SSPD);

		for n in itbLDC_EQUI_CAUSAL_SSPD.first .. itbLDC_EQUI_CAUSAL_SSPD.last loop
			rcRecOfTab.PACKAGE_TYPE_ID(n) := itbLDC_EQUI_CAUSAL_SSPD(n).PACKAGE_TYPE_ID;
			rcRecOfTab.CAUSAL_ID(n) := itbLDC_EQUI_CAUSAL_SSPD(n).CAUSAL_ID;
			rcRecOfTab.CAUSAL_SSPD_ID(n) := itbLDC_EQUI_CAUSAL_SSPD(n).CAUSAL_SSPD_ID;
			rcRecOfTab.row_id(n) := itbLDC_EQUI_CAUSAL_SSPD(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuPACKAGE_TYPE_ID in LDC_EQUI_CAUSAL_SSPD.PACKAGE_TYPE_ID%type,
		inuCAUSAL_ID in LDC_EQUI_CAUSAL_SSPD.CAUSAL_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuPACKAGE_TYPE_ID,
			inuCAUSAL_ID
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
		inuPACKAGE_TYPE_ID in LDC_EQUI_CAUSAL_SSPD.PACKAGE_TYPE_ID%type,
		inuCAUSAL_ID in LDC_EQUI_CAUSAL_SSPD.CAUSAL_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuPACKAGE_TYPE_ID = rcData.PACKAGE_TYPE_ID AND
			inuCAUSAL_ID = rcData.CAUSAL_ID
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
		inuPACKAGE_TYPE_ID in LDC_EQUI_CAUSAL_SSPD.PACKAGE_TYPE_ID%type,
		inuCAUSAL_ID in LDC_EQUI_CAUSAL_SSPD.CAUSAL_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuPACKAGE_TYPE_ID,
			inuCAUSAL_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuPACKAGE_TYPE_ID in LDC_EQUI_CAUSAL_SSPD.PACKAGE_TYPE_ID%type,
		inuCAUSAL_ID in LDC_EQUI_CAUSAL_SSPD.CAUSAL_ID%type
	)
	IS
		rcError styLDC_EQUI_CAUSAL_SSPD;
	BEGIN		rcError.PACKAGE_TYPE_ID:=inuPACKAGE_TYPE_ID;		rcError.CAUSAL_ID:=inuCAUSAL_ID;

		Load
		(
			inuPACKAGE_TYPE_ID,
			inuCAUSAL_ID
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
		inuPACKAGE_TYPE_ID in LDC_EQUI_CAUSAL_SSPD.PACKAGE_TYPE_ID%type,
		inuCAUSAL_ID in LDC_EQUI_CAUSAL_SSPD.CAUSAL_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuPACKAGE_TYPE_ID,
			inuCAUSAL_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuPACKAGE_TYPE_ID in LDC_EQUI_CAUSAL_SSPD.PACKAGE_TYPE_ID%type,
		inuCAUSAL_ID in LDC_EQUI_CAUSAL_SSPD.CAUSAL_ID%type,
		orcRecord out nocopy styLDC_EQUI_CAUSAL_SSPD
	)
	IS
		rcError styLDC_EQUI_CAUSAL_SSPD;
	BEGIN		rcError.PACKAGE_TYPE_ID:=inuPACKAGE_TYPE_ID;		rcError.CAUSAL_ID:=inuCAUSAL_ID;

		Load
		(
			inuPACKAGE_TYPE_ID,
			inuCAUSAL_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuPACKAGE_TYPE_ID in LDC_EQUI_CAUSAL_SSPD.PACKAGE_TYPE_ID%type,
		inuCAUSAL_ID in LDC_EQUI_CAUSAL_SSPD.CAUSAL_ID%type
	)
	RETURN styLDC_EQUI_CAUSAL_SSPD
	IS
		rcError styLDC_EQUI_CAUSAL_SSPD;
	BEGIN
		rcError.PACKAGE_TYPE_ID:=inuPACKAGE_TYPE_ID;
		rcError.CAUSAL_ID:=inuCAUSAL_ID;

		Load
		(
			inuPACKAGE_TYPE_ID,
			inuCAUSAL_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuPACKAGE_TYPE_ID in LDC_EQUI_CAUSAL_SSPD.PACKAGE_TYPE_ID%type,
		inuCAUSAL_ID in LDC_EQUI_CAUSAL_SSPD.CAUSAL_ID%type
	)
	RETURN styLDC_EQUI_CAUSAL_SSPD
	IS
		rcError styLDC_EQUI_CAUSAL_SSPD;
	BEGIN
		rcError.PACKAGE_TYPE_ID:=inuPACKAGE_TYPE_ID;
		rcError.CAUSAL_ID:=inuCAUSAL_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuPACKAGE_TYPE_ID,
			inuCAUSAL_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuPACKAGE_TYPE_ID,
			inuCAUSAL_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_EQUI_CAUSAL_SSPD
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_EQUI_CAUSAL_SSPD
	)
	IS
		rfLDC_EQUI_CAUSAL_SSPD tyrfLDC_EQUI_CAUSAL_SSPD;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_EQUI_CAUSAL_SSPD.*, LDC_EQUI_CAUSAL_SSPD.rowid FROM LDC_EQUI_CAUSAL_SSPD';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_EQUI_CAUSAL_SSPD for sbFullQuery;

		fetch rfLDC_EQUI_CAUSAL_SSPD bulk collect INTO otbResult;

		close rfLDC_EQUI_CAUSAL_SSPD;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_EQUI_CAUSAL_SSPD.*, LDC_EQUI_CAUSAL_SSPD.rowid FROM LDC_EQUI_CAUSAL_SSPD';
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
		ircLDC_EQUI_CAUSAL_SSPD in styLDC_EQUI_CAUSAL_SSPD
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_EQUI_CAUSAL_SSPD,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_EQUI_CAUSAL_SSPD in styLDC_EQUI_CAUSAL_SSPD,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_EQUI_CAUSAL_SSPD.PACKAGE_TYPE_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|PACKAGE_TYPE_ID');
			raise ex.controlled_error;
		end if;
		if ircLDC_EQUI_CAUSAL_SSPD.CAUSAL_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|CAUSAL_ID');
			raise ex.controlled_error;
		end if;

		insert into LDC_EQUI_CAUSAL_SSPD
		(
			PACKAGE_TYPE_ID,
			CAUSAL_ID,
			CAUSAL_SSPD_ID
		)
		values
		(
			ircLDC_EQUI_CAUSAL_SSPD.PACKAGE_TYPE_ID,
			ircLDC_EQUI_CAUSAL_SSPD.CAUSAL_ID,
			ircLDC_EQUI_CAUSAL_SSPD.CAUSAL_SSPD_ID
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_EQUI_CAUSAL_SSPD));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_EQUI_CAUSAL_SSPD in out nocopy tytbLDC_EQUI_CAUSAL_SSPD
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_EQUI_CAUSAL_SSPD,blUseRowID);
		forall n in iotbLDC_EQUI_CAUSAL_SSPD.first..iotbLDC_EQUI_CAUSAL_SSPD.last
			insert into LDC_EQUI_CAUSAL_SSPD
			(
				PACKAGE_TYPE_ID,
				CAUSAL_ID,
				CAUSAL_SSPD_ID
			)
			values
			(
				rcRecOfTab.PACKAGE_TYPE_ID(n),
				rcRecOfTab.CAUSAL_ID(n),
				rcRecOfTab.CAUSAL_SSPD_ID(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuPACKAGE_TYPE_ID in LDC_EQUI_CAUSAL_SSPD.PACKAGE_TYPE_ID%type,
		inuCAUSAL_ID in LDC_EQUI_CAUSAL_SSPD.CAUSAL_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_EQUI_CAUSAL_SSPD;
	BEGIN
		rcError.PACKAGE_TYPE_ID := inuPACKAGE_TYPE_ID;
		rcError.CAUSAL_ID := inuCAUSAL_ID;

		if inuLock=1 then
			LockByPk
			(
				inuPACKAGE_TYPE_ID,
				inuCAUSAL_ID,
				rcData
			);
		end if;


		delete
		from LDC_EQUI_CAUSAL_SSPD
		where
       		PACKAGE_TYPE_ID=inuPACKAGE_TYPE_ID and
       		CAUSAL_ID=inuCAUSAL_ID;
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
		rcError  styLDC_EQUI_CAUSAL_SSPD;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_EQUI_CAUSAL_SSPD
		where
			rowid = iriRowID
		returning
			PACKAGE_TYPE_ID,
			CAUSAL_ID
		into
			rcError.PACKAGE_TYPE_ID,
			rcError.CAUSAL_ID;
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
		iotbLDC_EQUI_CAUSAL_SSPD in out nocopy tytbLDC_EQUI_CAUSAL_SSPD,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_EQUI_CAUSAL_SSPD;
	BEGIN
		FillRecordOfTables(iotbLDC_EQUI_CAUSAL_SSPD, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_EQUI_CAUSAL_SSPD.first .. iotbLDC_EQUI_CAUSAL_SSPD.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_EQUI_CAUSAL_SSPD.first .. iotbLDC_EQUI_CAUSAL_SSPD.last
				delete
				from LDC_EQUI_CAUSAL_SSPD
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_EQUI_CAUSAL_SSPD.first .. iotbLDC_EQUI_CAUSAL_SSPD.last loop
					LockByPk
					(
						rcRecOfTab.PACKAGE_TYPE_ID(n),
						rcRecOfTab.CAUSAL_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_EQUI_CAUSAL_SSPD.first .. iotbLDC_EQUI_CAUSAL_SSPD.last
				delete
				from LDC_EQUI_CAUSAL_SSPD
				where
		         	PACKAGE_TYPE_ID = rcRecOfTab.PACKAGE_TYPE_ID(n) and
		         	CAUSAL_ID = rcRecOfTab.CAUSAL_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_EQUI_CAUSAL_SSPD in styLDC_EQUI_CAUSAL_SSPD,
		inuLock in number default 0
	)
	IS
		nuPACKAGE_TYPE_ID	LDC_EQUI_CAUSAL_SSPD.PACKAGE_TYPE_ID%type;
		nuCAUSAL_ID	LDC_EQUI_CAUSAL_SSPD.CAUSAL_ID%type;
	BEGIN
		if ircLDC_EQUI_CAUSAL_SSPD.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_EQUI_CAUSAL_SSPD.rowid,rcData);
			end if;
			update LDC_EQUI_CAUSAL_SSPD
			set
				CAUSAL_SSPD_ID = ircLDC_EQUI_CAUSAL_SSPD.CAUSAL_SSPD_ID
			where
				rowid = ircLDC_EQUI_CAUSAL_SSPD.rowid
			returning
				PACKAGE_TYPE_ID,
				CAUSAL_ID
			into
				nuPACKAGE_TYPE_ID,
				nuCAUSAL_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_EQUI_CAUSAL_SSPD.PACKAGE_TYPE_ID,
					ircLDC_EQUI_CAUSAL_SSPD.CAUSAL_ID,
					rcData
				);
			end if;

			update LDC_EQUI_CAUSAL_SSPD
			set
				CAUSAL_SSPD_ID = ircLDC_EQUI_CAUSAL_SSPD.CAUSAL_SSPD_ID
			where
				PACKAGE_TYPE_ID = ircLDC_EQUI_CAUSAL_SSPD.PACKAGE_TYPE_ID and
				CAUSAL_ID = ircLDC_EQUI_CAUSAL_SSPD.CAUSAL_ID
			returning
				PACKAGE_TYPE_ID,
				CAUSAL_ID
			into
				nuPACKAGE_TYPE_ID,
				nuCAUSAL_ID;
		end if;
		if
			nuPACKAGE_TYPE_ID is NULL OR
			nuCAUSAL_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_EQUI_CAUSAL_SSPD));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_EQUI_CAUSAL_SSPD in out nocopy tytbLDC_EQUI_CAUSAL_SSPD,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_EQUI_CAUSAL_SSPD;
	BEGIN
		FillRecordOfTables(iotbLDC_EQUI_CAUSAL_SSPD,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_EQUI_CAUSAL_SSPD.first .. iotbLDC_EQUI_CAUSAL_SSPD.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_EQUI_CAUSAL_SSPD.first .. iotbLDC_EQUI_CAUSAL_SSPD.last
				update LDC_EQUI_CAUSAL_SSPD
				set
					CAUSAL_SSPD_ID = rcRecOfTab.CAUSAL_SSPD_ID(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_EQUI_CAUSAL_SSPD.first .. iotbLDC_EQUI_CAUSAL_SSPD.last loop
					LockByPk
					(
						rcRecOfTab.PACKAGE_TYPE_ID(n),
						rcRecOfTab.CAUSAL_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_EQUI_CAUSAL_SSPD.first .. iotbLDC_EQUI_CAUSAL_SSPD.last
				update LDC_EQUI_CAUSAL_SSPD
				SET
					CAUSAL_SSPD_ID = rcRecOfTab.CAUSAL_SSPD_ID(n)
				where
					PACKAGE_TYPE_ID = rcRecOfTab.PACKAGE_TYPE_ID(n) and
					CAUSAL_ID = rcRecOfTab.CAUSAL_ID(n)
;
		end if;
	END;
	PROCEDURE updCAUSAL_SSPD_ID
	(
		inuPACKAGE_TYPE_ID in LDC_EQUI_CAUSAL_SSPD.PACKAGE_TYPE_ID%type,
		inuCAUSAL_ID in LDC_EQUI_CAUSAL_SSPD.CAUSAL_ID%type,
		inuCAUSAL_SSPD_ID$ in LDC_EQUI_CAUSAL_SSPD.CAUSAL_SSPD_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_EQUI_CAUSAL_SSPD;
	BEGIN
		rcError.PACKAGE_TYPE_ID := inuPACKAGE_TYPE_ID;
		rcError.CAUSAL_ID := inuCAUSAL_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPACKAGE_TYPE_ID,
				inuCAUSAL_ID,
				rcData
			);
		end if;

		update LDC_EQUI_CAUSAL_SSPD
		set
			CAUSAL_SSPD_ID = inuCAUSAL_SSPD_ID$
		where
			PACKAGE_TYPE_ID = inuPACKAGE_TYPE_ID and
			CAUSAL_ID = inuCAUSAL_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CAUSAL_SSPD_ID:= inuCAUSAL_SSPD_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetPACKAGE_TYPE_ID
	(
		inuPACKAGE_TYPE_ID in LDC_EQUI_CAUSAL_SSPD.PACKAGE_TYPE_ID%type,
		inuCAUSAL_ID in LDC_EQUI_CAUSAL_SSPD.CAUSAL_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_EQUI_CAUSAL_SSPD.PACKAGE_TYPE_ID%type
	IS
		rcError styLDC_EQUI_CAUSAL_SSPD;
	BEGIN

		rcError.PACKAGE_TYPE_ID := inuPACKAGE_TYPE_ID;
		rcError.CAUSAL_ID := inuCAUSAL_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPACKAGE_TYPE_ID,
		 		inuCAUSAL_ID
			 )
		then
			 return(rcData.PACKAGE_TYPE_ID);
		end if;
		Load
		(
		 		inuPACKAGE_TYPE_ID,
		 		inuCAUSAL_ID
		);
		return(rcData.PACKAGE_TYPE_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCAUSAL_ID
	(
		inuPACKAGE_TYPE_ID in LDC_EQUI_CAUSAL_SSPD.PACKAGE_TYPE_ID%type,
		inuCAUSAL_ID in LDC_EQUI_CAUSAL_SSPD.CAUSAL_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_EQUI_CAUSAL_SSPD.CAUSAL_ID%type
	IS
		rcError styLDC_EQUI_CAUSAL_SSPD;
	BEGIN

		rcError.PACKAGE_TYPE_ID := inuPACKAGE_TYPE_ID;
		rcError.CAUSAL_ID := inuCAUSAL_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPACKAGE_TYPE_ID,
		 		inuCAUSAL_ID
			 )
		then
			 return(rcData.CAUSAL_ID);
		end if;
		Load
		(
		 		inuPACKAGE_TYPE_ID,
		 		inuCAUSAL_ID
		);
		return(rcData.CAUSAL_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCAUSAL_SSPD_ID
	(
		inuPACKAGE_TYPE_ID in LDC_EQUI_CAUSAL_SSPD.PACKAGE_TYPE_ID%type,
		inuCAUSAL_ID in LDC_EQUI_CAUSAL_SSPD.CAUSAL_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_EQUI_CAUSAL_SSPD.CAUSAL_SSPD_ID%type
	IS
		rcError styLDC_EQUI_CAUSAL_SSPD;
	BEGIN

		rcError.PACKAGE_TYPE_ID := inuPACKAGE_TYPE_ID;
		rcError.CAUSAL_ID := inuCAUSAL_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPACKAGE_TYPE_ID,
		 		inuCAUSAL_ID
			 )
		then
			 return(rcData.CAUSAL_SSPD_ID);
		end if;
		Load
		(
		 		inuPACKAGE_TYPE_ID,
		 		inuCAUSAL_ID
		);
		return(rcData.CAUSAL_SSPD_ID);
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
end DALDC_EQUI_CAUSAL_SSPD;
/
PROMPT Otorgando permisos de ejecucion a DALDC_EQUI_CAUSAL_SSPD
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_EQUI_CAUSAL_SSPD', 'ADM_PERSON');
END;
/