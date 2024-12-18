CREATE OR REPLACE PACKAGE adm_person.daldc_prod_comerc_sector
IS
    /******************************************************************************************
	Autor: Harrinson Henao Camelo/Horbath
    Nombre Objeto: DALDC_PROD_COMERC_SECTOR
    Tipo de objeto: Paquete de primer nivel de la tabla LDC_PROD_COMERC_SECTOR
	Fecha: 25-01-2022
	Ticket: CA918
	Descripcion:    Paquete de primer nivel de tipo DA que contiene los metodos y funciones
                    de la tabla LDC_PROD_COMERC_SECTOR

	Historia de modificaciones
	Fecha		Autor			    Descripcion
	25-01-2022	hahenao.horbath	    Creacion
    12/06/2024  Adrianavg           OSF-2779: Se migra del esquema OPEN al esquema ADM_PERSON
	******************************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuPRODUCT_ID in LDC_PROD_COMERC_SECTOR.PRODUCT_ID%type
	)
	IS
		SELECT LDC_PROD_COMERC_SECTOR.*,LDC_PROD_COMERC_SECTOR.rowid
		FROM LDC_PROD_COMERC_SECTOR
		WHERE
		    PRODUCT_ID = inuPRODUCT_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_PROD_COMERC_SECTOR.*,LDC_PROD_COMERC_SECTOR.rowid
		FROM LDC_PROD_COMERC_SECTOR
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_PROD_COMERC_SECTOR  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_PROD_COMERC_SECTOR is table of styLDC_PROD_COMERC_SECTOR index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_PROD_COMERC_SECTOR;

	/* Tipos referenciando al registro */
	type tytbNOMBRE_ESTABLEC is table of LDC_PROD_COMERC_SECTOR.NOMBRE_ESTABLEC%type index by binary_integer;
	type tytbLAST_UPDATE_DATE is table of LDC_PROD_COMERC_SECTOR.LAST_UPDATE_DATE%type index by binary_integer;
	type tytbLAST_USER_UPDATE is table of LDC_PROD_COMERC_SECTOR.LAST_USER_UPDATE%type index by binary_integer;
	type tytbPRODUCT_ID is table of LDC_PROD_COMERC_SECTOR.PRODUCT_ID%type index by binary_integer;
	type tytbCOMERCIAL_SECTOR_ID is table of LDC_PROD_COMERC_SECTOR.COMERCIAL_SECTOR_ID%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_PROD_COMERC_SECTOR is record
	(
		NOMBRE_ESTABLEC   tytbNOMBRE_ESTABLEC,
		LAST_UPDATE_DATE   tytbLAST_UPDATE_DATE,
		LAST_USER_UPDATE   tytbLAST_USER_UPDATE,
		PRODUCT_ID   tytbPRODUCT_ID,
		COMERCIAL_SECTOR_ID   tytbCOMERCIAL_SECTOR_ID,
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
		inuPRODUCT_ID in LDC_PROD_COMERC_SECTOR.PRODUCT_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuPRODUCT_ID in LDC_PROD_COMERC_SECTOR.PRODUCT_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuPRODUCT_ID in LDC_PROD_COMERC_SECTOR.PRODUCT_ID%type
	);

	PROCEDURE getRecord
	(
		inuPRODUCT_ID in LDC_PROD_COMERC_SECTOR.PRODUCT_ID%type,
		orcRecord out nocopy styLDC_PROD_COMERC_SECTOR
	);

	FUNCTION frcGetRcData
	(
		inuPRODUCT_ID in LDC_PROD_COMERC_SECTOR.PRODUCT_ID%type
	)
	RETURN styLDC_PROD_COMERC_SECTOR;

	FUNCTION frcGetRcData
	RETURN styLDC_PROD_COMERC_SECTOR;

	FUNCTION frcGetRecord
	(
		inuPRODUCT_ID in LDC_PROD_COMERC_SECTOR.PRODUCT_ID%type
	)
	RETURN styLDC_PROD_COMERC_SECTOR;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_PROD_COMERC_SECTOR
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_PROD_COMERC_SECTOR in styLDC_PROD_COMERC_SECTOR
	);

	PROCEDURE insRecord
	(
		ircLDC_PROD_COMERC_SECTOR in styLDC_PROD_COMERC_SECTOR,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_PROD_COMERC_SECTOR in out nocopy tytbLDC_PROD_COMERC_SECTOR
	);

	PROCEDURE delRecord
	(
		inuPRODUCT_ID in LDC_PROD_COMERC_SECTOR.PRODUCT_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_PROD_COMERC_SECTOR in out nocopy tytbLDC_PROD_COMERC_SECTOR,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_PROD_COMERC_SECTOR in styLDC_PROD_COMERC_SECTOR,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_PROD_COMERC_SECTOR in out nocopy tytbLDC_PROD_COMERC_SECTOR,
		inuLock in number default 1
	);

	PROCEDURE updNOMBRE_ESTABLEC
	(
		inuPRODUCT_ID in LDC_PROD_COMERC_SECTOR.PRODUCT_ID%type,
		isbNOMBRE_ESTABLEC$ in LDC_PROD_COMERC_SECTOR.NOMBRE_ESTABLEC%type,
		inuLock in number default 0
	);

	PROCEDURE updLAST_UPDATE_DATE
	(
		inuPRODUCT_ID in LDC_PROD_COMERC_SECTOR.PRODUCT_ID%type,
		idtLAST_UPDATE_DATE$ in LDC_PROD_COMERC_SECTOR.LAST_UPDATE_DATE%type,
		inuLock in number default 0
	);

	PROCEDURE updLAST_USER_UPDATE
	(
		inuPRODUCT_ID in LDC_PROD_COMERC_SECTOR.PRODUCT_ID%type,
		isbLAST_USER_UPDATE$ in LDC_PROD_COMERC_SECTOR.LAST_USER_UPDATE%type,
		inuLock in number default 0
	);

	PROCEDURE updCOMERCIAL_SECTOR_ID
	(
		inuPRODUCT_ID in LDC_PROD_COMERC_SECTOR.PRODUCT_ID%type,
		inuCOMERCIAL_SECTOR_ID$ in LDC_PROD_COMERC_SECTOR.COMERCIAL_SECTOR_ID%type,
		inuLock in number default 0
	);

	FUNCTION fsbGetNOMBRE_ESTABLEC
	(
		inuPRODUCT_ID in LDC_PROD_COMERC_SECTOR.PRODUCT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROD_COMERC_SECTOR.NOMBRE_ESTABLEC%type;

	FUNCTION fdtGetLAST_UPDATE_DATE
	(
		inuPRODUCT_ID in LDC_PROD_COMERC_SECTOR.PRODUCT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROD_COMERC_SECTOR.LAST_UPDATE_DATE%type;

	FUNCTION fsbGetLAST_USER_UPDATE
	(
		inuPRODUCT_ID in LDC_PROD_COMERC_SECTOR.PRODUCT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROD_COMERC_SECTOR.LAST_USER_UPDATE%type;

	FUNCTION fnuGetPRODUCT_ID
	(
		inuPRODUCT_ID in LDC_PROD_COMERC_SECTOR.PRODUCT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROD_COMERC_SECTOR.PRODUCT_ID%type;

	FUNCTION fnuGetCOMERCIAL_SECTOR_ID
	(
		inuPRODUCT_ID in LDC_PROD_COMERC_SECTOR.PRODUCT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROD_COMERC_SECTOR.COMERCIAL_SECTOR_ID%type;


	PROCEDURE LockByPk
	(
		inuPRODUCT_ID in LDC_PROD_COMERC_SECTOR.PRODUCT_ID%type,
		orcLDC_PROD_COMERC_SECTOR  out styLDC_PROD_COMERC_SECTOR
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_PROD_COMERC_SECTOR  out styLDC_PROD_COMERC_SECTOR
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_PROD_COMERC_SECTOR;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALDC_PROD_COMERC_SECTOR
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'CA918';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_PROD_COMERC_SECTOR';
	 cnuGeEntityId constant varchar2(30) := 4172; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuPRODUCT_ID in LDC_PROD_COMERC_SECTOR.PRODUCT_ID%type
	)
	IS
		SELECT LDC_PROD_COMERC_SECTOR.*,LDC_PROD_COMERC_SECTOR.rowid
		FROM LDC_PROD_COMERC_SECTOR
		WHERE  PRODUCT_ID = inuPRODUCT_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_PROD_COMERC_SECTOR.*,LDC_PROD_COMERC_SECTOR.rowid
		FROM LDC_PROD_COMERC_SECTOR
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_PROD_COMERC_SECTOR is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_PROD_COMERC_SECTOR;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_PROD_COMERC_SECTOR default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.PRODUCT_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuPRODUCT_ID in LDC_PROD_COMERC_SECTOR.PRODUCT_ID%type,
		orcLDC_PROD_COMERC_SECTOR  out styLDC_PROD_COMERC_SECTOR
	)
	IS
		rcError styLDC_PROD_COMERC_SECTOR;
	BEGIN
		rcError.PRODUCT_ID := inuPRODUCT_ID;

		Open cuLockRcByPk
		(
			inuPRODUCT_ID
		);

		fetch cuLockRcByPk into orcLDC_PROD_COMERC_SECTOR;
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
		orcLDC_PROD_COMERC_SECTOR  out styLDC_PROD_COMERC_SECTOR
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_PROD_COMERC_SECTOR;
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
		itbLDC_PROD_COMERC_SECTOR  in out nocopy tytbLDC_PROD_COMERC_SECTOR
	)
	IS
	BEGIN
			rcRecOfTab.NOMBRE_ESTABLEC.delete;
			rcRecOfTab.LAST_UPDATE_DATE.delete;
			rcRecOfTab.LAST_USER_UPDATE.delete;
			rcRecOfTab.PRODUCT_ID.delete;
			rcRecOfTab.COMERCIAL_SECTOR_ID.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_PROD_COMERC_SECTOR  in out nocopy tytbLDC_PROD_COMERC_SECTOR,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_PROD_COMERC_SECTOR);

		for n in itbLDC_PROD_COMERC_SECTOR.first .. itbLDC_PROD_COMERC_SECTOR.last loop
			rcRecOfTab.NOMBRE_ESTABLEC(n) := itbLDC_PROD_COMERC_SECTOR(n).NOMBRE_ESTABLEC;
			rcRecOfTab.LAST_UPDATE_DATE(n) := itbLDC_PROD_COMERC_SECTOR(n).LAST_UPDATE_DATE;
			rcRecOfTab.LAST_USER_UPDATE(n) := itbLDC_PROD_COMERC_SECTOR(n).LAST_USER_UPDATE;
			rcRecOfTab.PRODUCT_ID(n) := itbLDC_PROD_COMERC_SECTOR(n).PRODUCT_ID;
			rcRecOfTab.COMERCIAL_SECTOR_ID(n) := itbLDC_PROD_COMERC_SECTOR(n).COMERCIAL_SECTOR_ID;
			rcRecOfTab.row_id(n) := itbLDC_PROD_COMERC_SECTOR(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuPRODUCT_ID in LDC_PROD_COMERC_SECTOR.PRODUCT_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuPRODUCT_ID
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
		inuPRODUCT_ID in LDC_PROD_COMERC_SECTOR.PRODUCT_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuPRODUCT_ID = rcData.PRODUCT_ID
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
		inuPRODUCT_ID in LDC_PROD_COMERC_SECTOR.PRODUCT_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuPRODUCT_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuPRODUCT_ID in LDC_PROD_COMERC_SECTOR.PRODUCT_ID%type
	)
	IS
		rcError styLDC_PROD_COMERC_SECTOR;
	BEGIN		rcError.PRODUCT_ID:=inuPRODUCT_ID;

		Load
		(
			inuPRODUCT_ID
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
		inuPRODUCT_ID in LDC_PROD_COMERC_SECTOR.PRODUCT_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuPRODUCT_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuPRODUCT_ID in LDC_PROD_COMERC_SECTOR.PRODUCT_ID%type,
		orcRecord out nocopy styLDC_PROD_COMERC_SECTOR
	)
	IS
		rcError styLDC_PROD_COMERC_SECTOR;
	BEGIN		rcError.PRODUCT_ID:=inuPRODUCT_ID;

		Load
		(
			inuPRODUCT_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuPRODUCT_ID in LDC_PROD_COMERC_SECTOR.PRODUCT_ID%type
	)
	RETURN styLDC_PROD_COMERC_SECTOR
	IS
		rcError styLDC_PROD_COMERC_SECTOR;
	BEGIN
		rcError.PRODUCT_ID:=inuPRODUCT_ID;

		Load
		(
			inuPRODUCT_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuPRODUCT_ID in LDC_PROD_COMERC_SECTOR.PRODUCT_ID%type
	)
	RETURN styLDC_PROD_COMERC_SECTOR
	IS
		rcError styLDC_PROD_COMERC_SECTOR;
	BEGIN
		rcError.PRODUCT_ID:=inuPRODUCT_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuPRODUCT_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuPRODUCT_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_PROD_COMERC_SECTOR
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_PROD_COMERC_SECTOR
	)
	IS
		rfLDC_PROD_COMERC_SECTOR tyrfLDC_PROD_COMERC_SECTOR;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_PROD_COMERC_SECTOR.*, LDC_PROD_COMERC_SECTOR.rowid FROM LDC_PROD_COMERC_SECTOR';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_PROD_COMERC_SECTOR for sbFullQuery;

		fetch rfLDC_PROD_COMERC_SECTOR bulk collect INTO otbResult;

		close rfLDC_PROD_COMERC_SECTOR;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_PROD_COMERC_SECTOR.*, LDC_PROD_COMERC_SECTOR.rowid FROM LDC_PROD_COMERC_SECTOR';
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
		ircLDC_PROD_COMERC_SECTOR in styLDC_PROD_COMERC_SECTOR
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_PROD_COMERC_SECTOR,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_PROD_COMERC_SECTOR in styLDC_PROD_COMERC_SECTOR,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_PROD_COMERC_SECTOR.PRODUCT_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|PRODUCT_ID');
			raise ex.controlled_error;
		end if;

		insert into LDC_PROD_COMERC_SECTOR
		(
			NOMBRE_ESTABLEC,
			LAST_UPDATE_DATE,
			LAST_USER_UPDATE,
			PRODUCT_ID,
			COMERCIAL_SECTOR_ID
		)
		values
		(
			ircLDC_PROD_COMERC_SECTOR.NOMBRE_ESTABLEC,
			ircLDC_PROD_COMERC_SECTOR.LAST_UPDATE_DATE,
			ircLDC_PROD_COMERC_SECTOR.LAST_USER_UPDATE,
			ircLDC_PROD_COMERC_SECTOR.PRODUCT_ID,
			ircLDC_PROD_COMERC_SECTOR.COMERCIAL_SECTOR_ID
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_PROD_COMERC_SECTOR));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_PROD_COMERC_SECTOR in out nocopy tytbLDC_PROD_COMERC_SECTOR
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_PROD_COMERC_SECTOR,blUseRowID);
		forall n in iotbLDC_PROD_COMERC_SECTOR.first..iotbLDC_PROD_COMERC_SECTOR.last
			insert into LDC_PROD_COMERC_SECTOR
			(
				NOMBRE_ESTABLEC,
				LAST_UPDATE_DATE,
				LAST_USER_UPDATE,
				PRODUCT_ID,
				COMERCIAL_SECTOR_ID
			)
			values
			(
				rcRecOfTab.NOMBRE_ESTABLEC(n),
				rcRecOfTab.LAST_UPDATE_DATE(n),
				rcRecOfTab.LAST_USER_UPDATE(n),
				rcRecOfTab.PRODUCT_ID(n),
				rcRecOfTab.COMERCIAL_SECTOR_ID(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuPRODUCT_ID in LDC_PROD_COMERC_SECTOR.PRODUCT_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_PROD_COMERC_SECTOR;
	BEGIN
		rcError.PRODUCT_ID := inuPRODUCT_ID;

		if inuLock=1 then
			LockByPk
			(
				inuPRODUCT_ID,
				rcData
			);
		end if;


		delete
		from LDC_PROD_COMERC_SECTOR
		where
       		PRODUCT_ID=inuPRODUCT_ID;
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
		rcError  styLDC_PROD_COMERC_SECTOR;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_PROD_COMERC_SECTOR
		where
			rowid = iriRowID
		returning
			NOMBRE_ESTABLEC
		into
			rcError.NOMBRE_ESTABLEC;
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
		iotbLDC_PROD_COMERC_SECTOR in out nocopy tytbLDC_PROD_COMERC_SECTOR,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_PROD_COMERC_SECTOR;
	BEGIN
		FillRecordOfTables(iotbLDC_PROD_COMERC_SECTOR, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_PROD_COMERC_SECTOR.first .. iotbLDC_PROD_COMERC_SECTOR.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_PROD_COMERC_SECTOR.first .. iotbLDC_PROD_COMERC_SECTOR.last
				delete
				from LDC_PROD_COMERC_SECTOR
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_PROD_COMERC_SECTOR.first .. iotbLDC_PROD_COMERC_SECTOR.last loop
					LockByPk
					(
						rcRecOfTab.PRODUCT_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_PROD_COMERC_SECTOR.first .. iotbLDC_PROD_COMERC_SECTOR.last
				delete
				from LDC_PROD_COMERC_SECTOR
				where
		         	PRODUCT_ID = rcRecOfTab.PRODUCT_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_PROD_COMERC_SECTOR in styLDC_PROD_COMERC_SECTOR,
		inuLock in number default 0
	)
	IS
		nuPRODUCT_ID	LDC_PROD_COMERC_SECTOR.PRODUCT_ID%type;
	BEGIN
		if ircLDC_PROD_COMERC_SECTOR.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_PROD_COMERC_SECTOR.rowid,rcData);
			end if;
			update LDC_PROD_COMERC_SECTOR
			set
				NOMBRE_ESTABLEC = ircLDC_PROD_COMERC_SECTOR.NOMBRE_ESTABLEC,
				LAST_UPDATE_DATE = ircLDC_PROD_COMERC_SECTOR.LAST_UPDATE_DATE,
				LAST_USER_UPDATE = ircLDC_PROD_COMERC_SECTOR.LAST_USER_UPDATE,
				COMERCIAL_SECTOR_ID = ircLDC_PROD_COMERC_SECTOR.COMERCIAL_SECTOR_ID
			where
				rowid = ircLDC_PROD_COMERC_SECTOR.rowid
			returning
				PRODUCT_ID
			into
				nuPRODUCT_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_PROD_COMERC_SECTOR.PRODUCT_ID,
					rcData
				);
			end if;

			update LDC_PROD_COMERC_SECTOR
			set
				NOMBRE_ESTABLEC = ircLDC_PROD_COMERC_SECTOR.NOMBRE_ESTABLEC,
				LAST_UPDATE_DATE = ircLDC_PROD_COMERC_SECTOR.LAST_UPDATE_DATE,
				LAST_USER_UPDATE = ircLDC_PROD_COMERC_SECTOR.LAST_USER_UPDATE,
				COMERCIAL_SECTOR_ID = ircLDC_PROD_COMERC_SECTOR.COMERCIAL_SECTOR_ID
			where
				PRODUCT_ID = ircLDC_PROD_COMERC_SECTOR.PRODUCT_ID
			returning
				PRODUCT_ID
			into
				nuPRODUCT_ID;
		end if;
		if
			nuPRODUCT_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_PROD_COMERC_SECTOR));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_PROD_COMERC_SECTOR in out nocopy tytbLDC_PROD_COMERC_SECTOR,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_PROD_COMERC_SECTOR;
	BEGIN
		FillRecordOfTables(iotbLDC_PROD_COMERC_SECTOR,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_PROD_COMERC_SECTOR.first .. iotbLDC_PROD_COMERC_SECTOR.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_PROD_COMERC_SECTOR.first .. iotbLDC_PROD_COMERC_SECTOR.last
				update LDC_PROD_COMERC_SECTOR
				set
					NOMBRE_ESTABLEC = rcRecOfTab.NOMBRE_ESTABLEC(n),
					LAST_UPDATE_DATE = rcRecOfTab.LAST_UPDATE_DATE(n),
					LAST_USER_UPDATE = rcRecOfTab.LAST_USER_UPDATE(n),
					COMERCIAL_SECTOR_ID = rcRecOfTab.COMERCIAL_SECTOR_ID(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_PROD_COMERC_SECTOR.first .. iotbLDC_PROD_COMERC_SECTOR.last loop
					LockByPk
					(
						rcRecOfTab.PRODUCT_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_PROD_COMERC_SECTOR.first .. iotbLDC_PROD_COMERC_SECTOR.last
				update LDC_PROD_COMERC_SECTOR
				SET
					NOMBRE_ESTABLEC = rcRecOfTab.NOMBRE_ESTABLEC(n),
					LAST_UPDATE_DATE = rcRecOfTab.LAST_UPDATE_DATE(n),
					LAST_USER_UPDATE = rcRecOfTab.LAST_USER_UPDATE(n),
					COMERCIAL_SECTOR_ID = rcRecOfTab.COMERCIAL_SECTOR_ID(n)
				where
					PRODUCT_ID = rcRecOfTab.PRODUCT_ID(n)
;
		end if;
	END;
	PROCEDURE updNOMBRE_ESTABLEC
	(
		inuPRODUCT_ID in LDC_PROD_COMERC_SECTOR.PRODUCT_ID%type,
		isbNOMBRE_ESTABLEC$ in LDC_PROD_COMERC_SECTOR.NOMBRE_ESTABLEC%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_PROD_COMERC_SECTOR;
	BEGIN
		rcError.PRODUCT_ID := inuPRODUCT_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPRODUCT_ID,
				rcData
			);
		end if;

		update LDC_PROD_COMERC_SECTOR
		set
			NOMBRE_ESTABLEC = isbNOMBRE_ESTABLEC$
		where
			PRODUCT_ID = inuPRODUCT_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.NOMBRE_ESTABLEC:= isbNOMBRE_ESTABLEC$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updLAST_UPDATE_DATE
	(
		inuPRODUCT_ID in LDC_PROD_COMERC_SECTOR.PRODUCT_ID%type,
		idtLAST_UPDATE_DATE$ in LDC_PROD_COMERC_SECTOR.LAST_UPDATE_DATE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_PROD_COMERC_SECTOR;
	BEGIN
		rcError.PRODUCT_ID := inuPRODUCT_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPRODUCT_ID,
				rcData
			);
		end if;

		update LDC_PROD_COMERC_SECTOR
		set
			LAST_UPDATE_DATE = idtLAST_UPDATE_DATE$
		where
			PRODUCT_ID = inuPRODUCT_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.LAST_UPDATE_DATE:= idtLAST_UPDATE_DATE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updLAST_USER_UPDATE
	(
		inuPRODUCT_ID in LDC_PROD_COMERC_SECTOR.PRODUCT_ID%type,
		isbLAST_USER_UPDATE$ in LDC_PROD_COMERC_SECTOR.LAST_USER_UPDATE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_PROD_COMERC_SECTOR;
	BEGIN
		rcError.PRODUCT_ID := inuPRODUCT_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPRODUCT_ID,
				rcData
			);
		end if;

		update LDC_PROD_COMERC_SECTOR
		set
			LAST_USER_UPDATE = isbLAST_USER_UPDATE$
		where
			PRODUCT_ID = inuPRODUCT_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.LAST_USER_UPDATE:= isbLAST_USER_UPDATE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCOMERCIAL_SECTOR_ID
	(
		inuPRODUCT_ID in LDC_PROD_COMERC_SECTOR.PRODUCT_ID%type,
		inuCOMERCIAL_SECTOR_ID$ in LDC_PROD_COMERC_SECTOR.COMERCIAL_SECTOR_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_PROD_COMERC_SECTOR;
	BEGIN
		rcError.PRODUCT_ID := inuPRODUCT_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPRODUCT_ID,
				rcData
			);
		end if;

		update LDC_PROD_COMERC_SECTOR
		set
			COMERCIAL_SECTOR_ID = inuCOMERCIAL_SECTOR_ID$
		where
			PRODUCT_ID = inuPRODUCT_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.COMERCIAL_SECTOR_ID:= inuCOMERCIAL_SECTOR_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fsbGetNOMBRE_ESTABLEC
	(
		inuPRODUCT_ID in LDC_PROD_COMERC_SECTOR.PRODUCT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROD_COMERC_SECTOR.NOMBRE_ESTABLEC%type
	IS
		rcError styLDC_PROD_COMERC_SECTOR;
	BEGIN

		rcError.PRODUCT_ID := inuPRODUCT_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPRODUCT_ID
			 )
		then
			 return(rcData.NOMBRE_ESTABLEC);
		end if;
		Load
		(
		 		inuPRODUCT_ID
		);
		return(rcData.NOMBRE_ESTABLEC);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetLAST_UPDATE_DATE
	(
		inuPRODUCT_ID in LDC_PROD_COMERC_SECTOR.PRODUCT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROD_COMERC_SECTOR.LAST_UPDATE_DATE%type
	IS
		rcError styLDC_PROD_COMERC_SECTOR;
	BEGIN

		rcError.PRODUCT_ID := inuPRODUCT_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPRODUCT_ID
			 )
		then
			 return(rcData.LAST_UPDATE_DATE);
		end if;
		Load
		(
		 		inuPRODUCT_ID
		);
		return(rcData.LAST_UPDATE_DATE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetLAST_USER_UPDATE
	(
		inuPRODUCT_ID in LDC_PROD_COMERC_SECTOR.PRODUCT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROD_COMERC_SECTOR.LAST_USER_UPDATE%type
	IS
		rcError styLDC_PROD_COMERC_SECTOR;
	BEGIN

		rcError.PRODUCT_ID := inuPRODUCT_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPRODUCT_ID
			 )
		then
			 return(rcData.LAST_USER_UPDATE);
		end if;
		Load
		(
		 		inuPRODUCT_ID
		);
		return(rcData.LAST_USER_UPDATE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetPRODUCT_ID
	(
		inuPRODUCT_ID in LDC_PROD_COMERC_SECTOR.PRODUCT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROD_COMERC_SECTOR.PRODUCT_ID%type
	IS
		rcError styLDC_PROD_COMERC_SECTOR;
	BEGIN

		rcError.PRODUCT_ID := inuPRODUCT_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPRODUCT_ID
			 )
		then
			 return(rcData.PRODUCT_ID);
		end if;
		Load
		(
		 		inuPRODUCT_ID
		);
		return(rcData.PRODUCT_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCOMERCIAL_SECTOR_ID
	(
		inuPRODUCT_ID in LDC_PROD_COMERC_SECTOR.PRODUCT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PROD_COMERC_SECTOR.COMERCIAL_SECTOR_ID%type
	IS
		rcError styLDC_PROD_COMERC_SECTOR;
	BEGIN

		rcError.PRODUCT_ID := inuPRODUCT_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPRODUCT_ID
			 )
		then
			 return(rcData.COMERCIAL_SECTOR_ID);
		end if;
		Load
		(
		 		inuPRODUCT_ID
		);
		return(rcData.COMERCIAL_SECTOR_ID);
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
end DALDC_PROD_COMERC_SECTOR;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALDC_PROD_COMERC_SECTOR
BEGIN
    pkg_utilidades.prAplicarPermisos('DALDC_PROD_COMERC_SECTOR', 'ADM_PERSON'); 
END;
/ 