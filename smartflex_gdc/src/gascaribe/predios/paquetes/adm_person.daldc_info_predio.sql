CREATE OR REPLACE PACKAGE ADM_PERSON.DALDC_INFO_PREDIO
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
		inuLDC_INFO_PREDIO_ID in LDC_INFO_PREDIO.LDC_INFO_PREDIO_ID%type
	)
	IS
		SELECT LDC_INFO_PREDIO.*,LDC_INFO_PREDIO.rowid
		FROM LDC_INFO_PREDIO
		WHERE
		    LDC_INFO_PREDIO_ID = inuLDC_INFO_PREDIO_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_INFO_PREDIO.*,LDC_INFO_PREDIO.rowid
		FROM LDC_INFO_PREDIO
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_INFO_PREDIO  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_INFO_PREDIO is table of styLDC_INFO_PREDIO index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_INFO_PREDIO;

	/* Tipos referenciando al registro */
	type tytbMULTIVIVIENDA is table of LDC_INFO_PREDIO.MULTIVIVIENDA%type index by binary_integer;
	type tytbLDC_INFO_PREDIO_ID is table of LDC_INFO_PREDIO.LDC_INFO_PREDIO_ID%type index by binary_integer;
	type tytbPREMISE_ID is table of LDC_INFO_PREDIO.PREMISE_ID%type index by binary_integer;
	type tytbIS_ZONA is table of LDC_INFO_PREDIO.IS_ZONA%type index by binary_integer;
	type tytbPORC_PENETRACION is table of LDC_INFO_PREDIO.PORC_PENETRACION%type index by binary_integer;
	type tytbPNO is table of LDC_INFO_PREDIO.PNO%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_INFO_PREDIO is record
	(
		MULTIVIVIENDA   tytbMULTIVIVIENDA,
		LDC_INFO_PREDIO_ID   tytbLDC_INFO_PREDIO_ID,
		PREMISE_ID   tytbPREMISE_ID,
		IS_ZONA   tytbIS_ZONA,
		PORC_PENETRACION   tytbPORC_PENETRACION,
		PNO	tytbPNO, 
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
		inuLDC_INFO_PREDIO_ID in LDC_INFO_PREDIO.LDC_INFO_PREDIO_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuLDC_INFO_PREDIO_ID in LDC_INFO_PREDIO.LDC_INFO_PREDIO_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuLDC_INFO_PREDIO_ID in LDC_INFO_PREDIO.LDC_INFO_PREDIO_ID%type
	);

	PROCEDURE getRecord
	(
		inuLDC_INFO_PREDIO_ID in LDC_INFO_PREDIO.LDC_INFO_PREDIO_ID%type,
		orcRecord out nocopy styLDC_INFO_PREDIO
	);

	FUNCTION frcGetRcData
	(
		inuLDC_INFO_PREDIO_ID in LDC_INFO_PREDIO.LDC_INFO_PREDIO_ID%type
	)
	RETURN styLDC_INFO_PREDIO;

	FUNCTION frcGetRcData
	RETURN styLDC_INFO_PREDIO;

	FUNCTION frcGetRecord
	(
		inuLDC_INFO_PREDIO_ID in LDC_INFO_PREDIO.LDC_INFO_PREDIO_ID%type
	)
	RETURN styLDC_INFO_PREDIO;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_INFO_PREDIO
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_INFO_PREDIO in styLDC_INFO_PREDIO
	);

	PROCEDURE insRecord
	(
		ircLDC_INFO_PREDIO in styLDC_INFO_PREDIO,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_INFO_PREDIO in out nocopy tytbLDC_INFO_PREDIO
	);

	PROCEDURE delRecord
	(
		inuLDC_INFO_PREDIO_ID in LDC_INFO_PREDIO.LDC_INFO_PREDIO_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_INFO_PREDIO in out nocopy tytbLDC_INFO_PREDIO,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_INFO_PREDIO in styLDC_INFO_PREDIO,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_INFO_PREDIO in out nocopy tytbLDC_INFO_PREDIO,
		inuLock in number default 1
	);

	PROCEDURE updMULTIVIVIENDA
	(
		inuLDC_INFO_PREDIO_ID in LDC_INFO_PREDIO.LDC_INFO_PREDIO_ID%type,
		inuMULTIVIVIENDA$ in LDC_INFO_PREDIO.MULTIVIVIENDA%type,
		inuLock in number default 0
	);

	PROCEDURE updPREMISE_ID
	(
		inuLDC_INFO_PREDIO_ID in LDC_INFO_PREDIO.LDC_INFO_PREDIO_ID%type,
		inuPREMISE_ID$ in LDC_INFO_PREDIO.PREMISE_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updIS_ZONA
	(
		inuLDC_INFO_PREDIO_ID in LDC_INFO_PREDIO.LDC_INFO_PREDIO_ID%type,
		isbIS_ZONA$ in LDC_INFO_PREDIO.IS_ZONA%type,
		inuLock in number default 0
	);

	PROCEDURE updPORC_PENETRACION
	(
		inuLDC_INFO_PREDIO_ID in LDC_INFO_PREDIO.LDC_INFO_PREDIO_ID%type,
		inuPORC_PENETRACION$ in LDC_INFO_PREDIO.PORC_PENETRACION%type,
		inuLock in number default 0
	);

	PROCEDURE updPNO
	(
		inuLDC_INFO_PREDIO_ID in LDC_INFO_PREDIO.LDC_INFO_PREDIO_ID%type,
		isbPNO$ in LDC_INFO_PREDIO.PNO%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetMULTIVIVIENDA
	(
		inuLDC_INFO_PREDIO_ID in LDC_INFO_PREDIO.LDC_INFO_PREDIO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_INFO_PREDIO.MULTIVIVIENDA%type;

	FUNCTION fnuGetLDC_INFO_PREDIO_ID
	(
		inuLDC_INFO_PREDIO_ID in LDC_INFO_PREDIO.LDC_INFO_PREDIO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_INFO_PREDIO.LDC_INFO_PREDIO_ID%type;

	FUNCTION fnuGetPREMISE_ID
	(
		inuLDC_INFO_PREDIO_ID in LDC_INFO_PREDIO.LDC_INFO_PREDIO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_INFO_PREDIO.PREMISE_ID%type;

	FUNCTION fsbGetIS_ZONA
	(
		inuLDC_INFO_PREDIO_ID in LDC_INFO_PREDIO.LDC_INFO_PREDIO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_INFO_PREDIO.IS_ZONA%type;

	FUNCTION fnuGetPORC_PENETRACION
	(
		inuLDC_INFO_PREDIO_ID in LDC_INFO_PREDIO.LDC_INFO_PREDIO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_INFO_PREDIO.PORC_PENETRACION%type;

	FUNCTION fsbGetPNO
	(
		inuLDC_INFO_PREDIO_ID in LDC_INFO_PREDIO.LDC_INFO_PREDIO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_INFO_PREDIO.PNO%type;

	PROCEDURE LockByPk
	(
		inuLDC_INFO_PREDIO_ID in LDC_INFO_PREDIO.LDC_INFO_PREDIO_ID%type,
		orcLDC_INFO_PREDIO  out styLDC_INFO_PREDIO
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_INFO_PREDIO  out styLDC_INFO_PREDIO
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_INFO_PREDIO;
/

CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALDC_INFO_PREDIO
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_INFO_PREDIO';
	 cnuGeEntityId constant varchar2(30) := 8108; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuLDC_INFO_PREDIO_ID in LDC_INFO_PREDIO.LDC_INFO_PREDIO_ID%type
	)
	IS
		SELECT LDC_INFO_PREDIO.*,LDC_INFO_PREDIO.rowid
		FROM LDC_INFO_PREDIO
		WHERE  LDC_INFO_PREDIO_ID = inuLDC_INFO_PREDIO_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_INFO_PREDIO.*,LDC_INFO_PREDIO.rowid
		FROM LDC_INFO_PREDIO
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_INFO_PREDIO is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_INFO_PREDIO;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_INFO_PREDIO default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.LDC_INFO_PREDIO_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuLDC_INFO_PREDIO_ID in LDC_INFO_PREDIO.LDC_INFO_PREDIO_ID%type,
		orcLDC_INFO_PREDIO  out styLDC_INFO_PREDIO
	)
	IS
		rcError styLDC_INFO_PREDIO;
	BEGIN
		rcError.LDC_INFO_PREDIO_ID := inuLDC_INFO_PREDIO_ID;

		Open cuLockRcByPk
		(
			inuLDC_INFO_PREDIO_ID
		);

		fetch cuLockRcByPk into orcLDC_INFO_PREDIO;
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
			raise Ex.CONTROLLED_ERROR;
		when Ex.RESOURCE_BUSY THEN
			if cuLockRcByPk%isopen then
				close cuLockRcByPk;
			end if;
			Errors.setError(cnuAPPTABLEBUSSY,fsbPrimaryKey(rcError)||'|'|| fsbGetMessageDescription );
			raise Ex.controlled_error;
		when others then
			if cuLockRcByPk%isopen then
				close cuLockRcByPk;
			end if;
			raise;
	END;
	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_INFO_PREDIO  out styLDC_INFO_PREDIO
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_INFO_PREDIO;
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
			raise Ex.CONTROLLED_ERROR;
		when Ex.RESOURCE_BUSY THEN
			if cuLockRcbyRowId%isopen then
				close cuLockRcbyRowId;
			end if;
			Errors.setError(cnuAPPTABLEBUSSY,'rowid=['||irirowid||']|'||fsbGetMessageDescription );
			raise Ex.controlled_error;
		when others then
			if cuLockRcbyRowId%isopen then
				close cuLockRcbyRowId;
			end if;
			raise;
	END;
	PROCEDURE DelRecordOfTables
	(
		itbLDC_INFO_PREDIO  in out nocopy tytbLDC_INFO_PREDIO
	)
	IS
	BEGIN
			rcRecOfTab.MULTIVIVIENDA.delete;
			rcRecOfTab.LDC_INFO_PREDIO_ID.delete;
			rcRecOfTab.PREMISE_ID.delete;
			rcRecOfTab.IS_ZONA.delete;
			rcRecOfTab.PORC_PENETRACION.delete;
			rcRecOfTab.PNO.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_INFO_PREDIO  in out nocopy tytbLDC_INFO_PREDIO,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_INFO_PREDIO);

		for n in itbLDC_INFO_PREDIO.first .. itbLDC_INFO_PREDIO.last loop
			rcRecOfTab.MULTIVIVIENDA(n) := itbLDC_INFO_PREDIO(n).MULTIVIVIENDA;
			rcRecOfTab.LDC_INFO_PREDIO_ID(n) := itbLDC_INFO_PREDIO(n).LDC_INFO_PREDIO_ID;
			rcRecOfTab.PREMISE_ID(n) := itbLDC_INFO_PREDIO(n).PREMISE_ID;
			rcRecOfTab.IS_ZONA(n) := itbLDC_INFO_PREDIO(n).IS_ZONA;
			rcRecOfTab.PORC_PENETRACION(n) := itbLDC_INFO_PREDIO(n).PORC_PENETRACION;
			rcRecOfTab.PNO(n) := itbLDC_INFO_PREDIO(n).PNO;
			rcRecOfTab.row_id(n) := itbLDC_INFO_PREDIO(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuLDC_INFO_PREDIO_ID in LDC_INFO_PREDIO.LDC_INFO_PREDIO_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuLDC_INFO_PREDIO_ID
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
		inuLDC_INFO_PREDIO_ID in LDC_INFO_PREDIO.LDC_INFO_PREDIO_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuLDC_INFO_PREDIO_ID = rcData.LDC_INFO_PREDIO_ID
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
		inuLDC_INFO_PREDIO_ID in LDC_INFO_PREDIO.LDC_INFO_PREDIO_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuLDC_INFO_PREDIO_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuLDC_INFO_PREDIO_ID in LDC_INFO_PREDIO.LDC_INFO_PREDIO_ID%type
	)
	IS
		rcError styLDC_INFO_PREDIO;
	BEGIN		rcError.LDC_INFO_PREDIO_ID:=inuLDC_INFO_PREDIO_ID;

		Load
		(
			inuLDC_INFO_PREDIO_ID
		);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise Ex.CONTROLLED_ERROR;
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
            raise Ex.CONTROLLED_ERROR;
	END;
	PROCEDURE ValDuplicate
	(
		inuLDC_INFO_PREDIO_ID in LDC_INFO_PREDIO.LDC_INFO_PREDIO_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuLDC_INFO_PREDIO_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise Ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuLDC_INFO_PREDIO_ID in LDC_INFO_PREDIO.LDC_INFO_PREDIO_ID%type,
		orcRecord out nocopy styLDC_INFO_PREDIO
	)
	IS
		rcError styLDC_INFO_PREDIO;
	BEGIN		rcError.LDC_INFO_PREDIO_ID:=inuLDC_INFO_PREDIO_ID;

		Load
		(
			inuLDC_INFO_PREDIO_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise Ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuLDC_INFO_PREDIO_ID in LDC_INFO_PREDIO.LDC_INFO_PREDIO_ID%type
	)
	RETURN styLDC_INFO_PREDIO
	IS
		rcError styLDC_INFO_PREDIO;
	BEGIN
		rcError.LDC_INFO_PREDIO_ID:=inuLDC_INFO_PREDIO_ID;

		Load
		(
			inuLDC_INFO_PREDIO_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise Ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuLDC_INFO_PREDIO_ID in LDC_INFO_PREDIO.LDC_INFO_PREDIO_ID%type
	)
	RETURN styLDC_INFO_PREDIO
	IS
		rcError styLDC_INFO_PREDIO;
	BEGIN
		rcError.LDC_INFO_PREDIO_ID:=inuLDC_INFO_PREDIO_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuLDC_INFO_PREDIO_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuLDC_INFO_PREDIO_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise Ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_INFO_PREDIO
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_INFO_PREDIO
	)
	IS
		rfLDC_INFO_PREDIO tyrfLDC_INFO_PREDIO;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_INFO_PREDIO.*, LDC_INFO_PREDIO.rowid FROM LDC_INFO_PREDIO';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_INFO_PREDIO for sbFullQuery;

		fetch rfLDC_INFO_PREDIO bulk collect INTO otbResult;

		close rfLDC_INFO_PREDIO;
		if otbResult.count = 0  then
			raise no_data_found;
		end if;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription);
			raise Ex.CONTROLLED_ERROR;
	END;
	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor
	IS
		rfQuery tyRefCursor;
		sbSQL VARCHAR2 (32000) := 'select LDC_INFO_PREDIO.*, LDC_INFO_PREDIO.rowid FROM LDC_INFO_PREDIO';
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
			raise Ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecord
	(
		ircLDC_INFO_PREDIO in styLDC_INFO_PREDIO
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_INFO_PREDIO,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_INFO_PREDIO in styLDC_INFO_PREDIO,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_INFO_PREDIO.LDC_INFO_PREDIO_ID is NULL then
			Errors.setError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|LDC_INFO_PREDIO_ID');
			raise Ex.controlled_error;
		end if;

		insert into LDC_INFO_PREDIO
		(
			MULTIVIVIENDA,
			LDC_INFO_PREDIO_ID,
			PREMISE_ID,
			IS_ZONA,
			PORC_PENETRACION,
			PNO
		)
		values
		(
			ircLDC_INFO_PREDIO.MULTIVIVIENDA,
			ircLDC_INFO_PREDIO.LDC_INFO_PREDIO_ID,
			ircLDC_INFO_PREDIO.PREMISE_ID,
			ircLDC_INFO_PREDIO.IS_ZONA,
			ircLDC_INFO_PREDIO.PORC_PENETRACION,
			ircLDC_INFO_PREDIO.PNO
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_INFO_PREDIO));
			raise Ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_INFO_PREDIO in out nocopy tytbLDC_INFO_PREDIO
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_INFO_PREDIO,blUseRowID);
		forall n in iotbLDC_INFO_PREDIO.first..iotbLDC_INFO_PREDIO.last
			insert into LDC_INFO_PREDIO
			(
				MULTIVIVIENDA,
				LDC_INFO_PREDIO_ID,
				PREMISE_ID,
				IS_ZONA,
				PORC_PENETRACION,
				PNO
			)
			values
			(
				rcRecOfTab.MULTIVIVIENDA(n),
				rcRecOfTab.LDC_INFO_PREDIO_ID(n),
				rcRecOfTab.PREMISE_ID(n),
				rcRecOfTab.IS_ZONA(n),
				rcRecOfTab.PORC_PENETRACION(n),
				rcRecOfTab.PNO(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise Ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuLDC_INFO_PREDIO_ID in LDC_INFO_PREDIO.LDC_INFO_PREDIO_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_INFO_PREDIO;
	BEGIN
		rcError.LDC_INFO_PREDIO_ID := inuLDC_INFO_PREDIO_ID;

		if inuLock=1 then
			LockByPk
			(
				inuLDC_INFO_PREDIO_ID,
				rcData
			);
		end if;


		delete
		from LDC_INFO_PREDIO
		where
       		LDC_INFO_PREDIO_ID=inuLDC_INFO_PREDIO_ID;
            if sql%notfound then
                raise no_data_found;
            end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
         raise Ex.CONTROLLED_ERROR;
		when Ex.RECORD_HAVE_CHILDREN then
			Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise Ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	)
	IS
		rcRecordNull cuRecord%rowtype;
		rcError  styLDC_INFO_PREDIO;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_INFO_PREDIO
		where
			rowid = iriRowID
		returning
			MULTIVIVIENDA
		into
			rcError.MULTIVIVIENDA;
            if sql%notfound then
			 raise no_data_found;
		    end if;
            if rcData.rowID=iriRowID then
			 rcData := rcRecordNull;
		    end if;
	EXCEPTION
		when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' rowid=['||iriRowID||']');
            raise Ex.CONTROLLED_ERROR;
		when Ex.RECORD_HAVE_CHILDREN then
            Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription||' '||' rowid=['||iriRowID||']');
            raise Ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecords
	(
		iotbLDC_INFO_PREDIO in out nocopy tytbLDC_INFO_PREDIO,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_INFO_PREDIO;
	BEGIN
		FillRecordOfTables(iotbLDC_INFO_PREDIO, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_INFO_PREDIO.first .. iotbLDC_INFO_PREDIO.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_INFO_PREDIO.first .. iotbLDC_INFO_PREDIO.last
				delete
				from LDC_INFO_PREDIO
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_INFO_PREDIO.first .. iotbLDC_INFO_PREDIO.last loop
					LockByPk
					(
						rcRecOfTab.LDC_INFO_PREDIO_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_INFO_PREDIO.first .. iotbLDC_INFO_PREDIO.last
				delete
				from LDC_INFO_PREDIO
				where
		         	LDC_INFO_PREDIO_ID = rcRecOfTab.LDC_INFO_PREDIO_ID(n);
		end if;
	EXCEPTION
            when Ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise Ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_INFO_PREDIO in styLDC_INFO_PREDIO,
		inuLock in number default 0
	)
	IS
		nuLDC_INFO_PREDIO_ID	LDC_INFO_PREDIO.LDC_INFO_PREDIO_ID%type;
	BEGIN
		if ircLDC_INFO_PREDIO.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_INFO_PREDIO.rowid,rcData);
			end if;
			update LDC_INFO_PREDIO
			set
				MULTIVIVIENDA = ircLDC_INFO_PREDIO.MULTIVIVIENDA,
				PREMISE_ID = ircLDC_INFO_PREDIO.PREMISE_ID,
				IS_ZONA = ircLDC_INFO_PREDIO.IS_ZONA,
				PORC_PENETRACION = ircLDC_INFO_PREDIO.PORC_PENETRACION,
				PNO = ircLDC_INFO_PREDIO.PNO
			where
				rowid = ircLDC_INFO_PREDIO.rowid
			returning
				LDC_INFO_PREDIO_ID
			into
				nuLDC_INFO_PREDIO_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_INFO_PREDIO.LDC_INFO_PREDIO_ID,
					rcData
				);
			end if;

			update LDC_INFO_PREDIO
			set
				MULTIVIVIENDA = ircLDC_INFO_PREDIO.MULTIVIVIENDA,
				PREMISE_ID = ircLDC_INFO_PREDIO.PREMISE_ID,
				IS_ZONA = ircLDC_INFO_PREDIO.IS_ZONA,
				PORC_PENETRACION = ircLDC_INFO_PREDIO.PORC_PENETRACION,
				PNO = ircLDC_INFO_PREDIO.PNO
			where
				LDC_INFO_PREDIO_ID = ircLDC_INFO_PREDIO.LDC_INFO_PREDIO_ID
			returning
				LDC_INFO_PREDIO_ID
			into
				nuLDC_INFO_PREDIO_ID;
		end if;
		if
			nuLDC_INFO_PREDIO_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_INFO_PREDIO));
			raise Ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_INFO_PREDIO in out nocopy tytbLDC_INFO_PREDIO,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_INFO_PREDIO;
	BEGIN
		FillRecordOfTables(iotbLDC_INFO_PREDIO,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_INFO_PREDIO.first .. iotbLDC_INFO_PREDIO.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_INFO_PREDIO.first .. iotbLDC_INFO_PREDIO.last
				update LDC_INFO_PREDIO
				set
					MULTIVIVIENDA = rcRecOfTab.MULTIVIVIENDA(n),
					PREMISE_ID = rcRecOfTab.PREMISE_ID(n),
					IS_ZONA = rcRecOfTab.IS_ZONA(n),
					PORC_PENETRACION = rcRecOfTab.PORC_PENETRACION(n),
					PNO = rcRecOfTab.PNO(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_INFO_PREDIO.first .. iotbLDC_INFO_PREDIO.last loop
					LockByPk
					(
						rcRecOfTab.LDC_INFO_PREDIO_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_INFO_PREDIO.first .. iotbLDC_INFO_PREDIO.last
				update LDC_INFO_PREDIO
				SET
					MULTIVIVIENDA = rcRecOfTab.MULTIVIVIENDA(n),
					PREMISE_ID = rcRecOfTab.PREMISE_ID(n),
					IS_ZONA = rcRecOfTab.IS_ZONA(n),
					PORC_PENETRACION = rcRecOfTab.PORC_PENETRACION(n),
					PNO = rcRecOfTab.PNO(n)
				where
					LDC_INFO_PREDIO_ID = rcRecOfTab.LDC_INFO_PREDIO_ID(n)
;
		end if;
	END;
	PROCEDURE updMULTIVIVIENDA
	(
		inuLDC_INFO_PREDIO_ID in LDC_INFO_PREDIO.LDC_INFO_PREDIO_ID%type,
		inuMULTIVIVIENDA$ in LDC_INFO_PREDIO.MULTIVIVIENDA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_INFO_PREDIO;
	BEGIN
		rcError.LDC_INFO_PREDIO_ID := inuLDC_INFO_PREDIO_ID;
		if inuLock=1 then
			LockByPk
			(
				inuLDC_INFO_PREDIO_ID,
				rcData
			);
		end if;

		update LDC_INFO_PREDIO
		set
			MULTIVIVIENDA = inuMULTIVIVIENDA$
		where
			LDC_INFO_PREDIO_ID = inuLDC_INFO_PREDIO_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.MULTIVIVIENDA:= inuMULTIVIVIENDA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise Ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPREMISE_ID
	(
		inuLDC_INFO_PREDIO_ID in LDC_INFO_PREDIO.LDC_INFO_PREDIO_ID%type,
		inuPREMISE_ID$ in LDC_INFO_PREDIO.PREMISE_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_INFO_PREDIO;
	BEGIN
		rcError.LDC_INFO_PREDIO_ID := inuLDC_INFO_PREDIO_ID;
		if inuLock=1 then
			LockByPk
			(
				inuLDC_INFO_PREDIO_ID,
				rcData
			);
		end if;

		update LDC_INFO_PREDIO
		set
			PREMISE_ID = inuPREMISE_ID$
		where
			LDC_INFO_PREDIO_ID = inuLDC_INFO_PREDIO_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PREMISE_ID:= inuPREMISE_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise Ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updIS_ZONA
	(
		inuLDC_INFO_PREDIO_ID in LDC_INFO_PREDIO.LDC_INFO_PREDIO_ID%type,
		isbIS_ZONA$ in LDC_INFO_PREDIO.IS_ZONA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_INFO_PREDIO;
	BEGIN
		rcError.LDC_INFO_PREDIO_ID := inuLDC_INFO_PREDIO_ID;
		if inuLock=1 then
			LockByPk
			(
				inuLDC_INFO_PREDIO_ID,
				rcData
			);
		end if;

		update LDC_INFO_PREDIO
		set
			IS_ZONA = isbIS_ZONA$
		where
			LDC_INFO_PREDIO_ID = inuLDC_INFO_PREDIO_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.IS_ZONA:= isbIS_ZONA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise Ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPORC_PENETRACION
	(
		inuLDC_INFO_PREDIO_ID in LDC_INFO_PREDIO.LDC_INFO_PREDIO_ID%type,
		inuPORC_PENETRACION$ in LDC_INFO_PREDIO.PORC_PENETRACION%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_INFO_PREDIO;
	BEGIN
		rcError.LDC_INFO_PREDIO_ID := inuLDC_INFO_PREDIO_ID;
		if inuLock=1 then
			LockByPk
			(
				inuLDC_INFO_PREDIO_ID,
				rcData
			);
		end if;

		update LDC_INFO_PREDIO
		set
			PORC_PENETRACION = inuPORC_PENETRACION$
		where
			LDC_INFO_PREDIO_ID = inuLDC_INFO_PREDIO_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PORC_PENETRACION:= inuPORC_PENETRACION$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise Ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPNO
	(
		inuLDC_INFO_PREDIO_ID in LDC_INFO_PREDIO.LDC_INFO_PREDIO_ID%type,
		isbPNO$ in LDC_INFO_PREDIO.PNO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_INFO_PREDIO;
	BEGIN
		rcError.LDC_INFO_PREDIO_ID := inuLDC_INFO_PREDIO_ID;
		if inuLock=1 then
			LockByPk
			(
				inuLDC_INFO_PREDIO_ID,
				rcData
			);
		end if;

		update LDC_INFO_PREDIO
		set
			PNO = isbPNO$
		where
			LDC_INFO_PREDIO_ID = inuLDC_INFO_PREDIO_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PNO:= isbPNO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise Ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetMULTIVIVIENDA
	(
		inuLDC_INFO_PREDIO_ID in LDC_INFO_PREDIO.LDC_INFO_PREDIO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_INFO_PREDIO.MULTIVIVIENDA%type
	IS
		rcError styLDC_INFO_PREDIO;
	BEGIN

		rcError.LDC_INFO_PREDIO_ID := inuLDC_INFO_PREDIO_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuLDC_INFO_PREDIO_ID
			 )
		then
			 return(rcData.MULTIVIVIENDA);
		end if;
		Load
		(
		 		inuLDC_INFO_PREDIO_ID
		);
		return(rcData.MULTIVIVIENDA);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise Ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetLDC_INFO_PREDIO_ID
	(
		inuLDC_INFO_PREDIO_ID in LDC_INFO_PREDIO.LDC_INFO_PREDIO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_INFO_PREDIO.LDC_INFO_PREDIO_ID%type
	IS
		rcError styLDC_INFO_PREDIO;
	BEGIN

		rcError.LDC_INFO_PREDIO_ID := inuLDC_INFO_PREDIO_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuLDC_INFO_PREDIO_ID
			 )
		then
			 return(rcData.LDC_INFO_PREDIO_ID);
		end if;
		Load
		(
		 		inuLDC_INFO_PREDIO_ID
		);
		return(rcData.LDC_INFO_PREDIO_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise Ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetPREMISE_ID
	(
		inuLDC_INFO_PREDIO_ID in LDC_INFO_PREDIO.LDC_INFO_PREDIO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_INFO_PREDIO.PREMISE_ID%type
	IS
		rcError styLDC_INFO_PREDIO;
	BEGIN

		rcError.LDC_INFO_PREDIO_ID := inuLDC_INFO_PREDIO_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuLDC_INFO_PREDIO_ID
			 )
		then
			 return(rcData.PREMISE_ID);
		end if;
		Load
		(
		 		inuLDC_INFO_PREDIO_ID
		);
		return(rcData.PREMISE_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise Ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetIS_ZONA
	(
		inuLDC_INFO_PREDIO_ID in LDC_INFO_PREDIO.LDC_INFO_PREDIO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_INFO_PREDIO.IS_ZONA%type
	IS
		rcError styLDC_INFO_PREDIO;
	BEGIN

		rcError.LDC_INFO_PREDIO_ID := inuLDC_INFO_PREDIO_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuLDC_INFO_PREDIO_ID
			 )
		then
			 return(rcData.IS_ZONA);
		end if;
		Load
		(
		 		inuLDC_INFO_PREDIO_ID
		);
		return(rcData.IS_ZONA);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise Ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetPORC_PENETRACION
	(
		inuLDC_INFO_PREDIO_ID in LDC_INFO_PREDIO.LDC_INFO_PREDIO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_INFO_PREDIO.PORC_PENETRACION%type
	IS
		rcError styLDC_INFO_PREDIO;
	BEGIN

		rcError.LDC_INFO_PREDIO_ID := inuLDC_INFO_PREDIO_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuLDC_INFO_PREDIO_ID
			 )
		then
			 return(rcData.PORC_PENETRACION);
		end if;
		Load
		(
		 		inuLDC_INFO_PREDIO_ID
		);
		return(rcData.PORC_PENETRACION);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise Ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetPNO
	(
		inuLDC_INFO_PREDIO_ID in LDC_INFO_PREDIO.LDC_INFO_PREDIO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_INFO_PREDIO.PNO%type
	IS
		rcError styLDC_INFO_PREDIO;
	BEGIN

		rcError.LDC_INFO_PREDIO_ID := inuLDC_INFO_PREDIO_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuLDC_INFO_PREDIO_ID
			 )
		then
			 return(rcData.PNO);
		end if;
		Load
		(
		 		inuLDC_INFO_PREDIO_ID
		);
		return(rcData.PNO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise Ex.CONTROLLED_ERROR;
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
end DALDC_INFO_PREDIO;
/
PROMPT Otorgando permisos de ejecucion a DALDC_INFO_PREDIO
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_INFO_PREDIO', 'ADM_PERSON');
END;
/