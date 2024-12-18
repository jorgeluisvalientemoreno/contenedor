CREATE OR REPLACE PACKAGE adm_person.daldc_contra_ica_geogra
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  11/06/2024   Adrianavg   OSF-2813: Migrar del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuCONT_ICA_GEOG_ID in LDC_CONTRA_ICA_GEOGRA.CONT_ICA_GEOG_ID%type
	)
	IS
		SELECT LDC_CONTRA_ICA_GEOGRA.*,LDC_CONTRA_ICA_GEOGRA.rowid
		FROM LDC_CONTRA_ICA_GEOGRA
		WHERE
		    CONT_ICA_GEOG_ID = inuCONT_ICA_GEOG_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_CONTRA_ICA_GEOGRA.*,LDC_CONTRA_ICA_GEOGRA.rowid
		FROM LDC_CONTRA_ICA_GEOGRA
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_CONTRA_ICA_GEOGRA  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_CONTRA_ICA_GEOGRA is table of styLDC_CONTRA_ICA_GEOGRA index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_CONTRA_ICA_GEOGRA;

	/* Tipos referenciando al registro */
	type tytbCONT_ICA_GEOG_ID is table of LDC_CONTRA_ICA_GEOGRA.CONT_ICA_GEOG_ID%type index by binary_integer;
	type tytbCONT_ICA_GEOG_CONTRA is table of LDC_CONTRA_ICA_GEOGRA.CONT_ICA_GEOG_CONTRA%type index by binary_integer;
	type tytbCONT_ICA_GEOG_DEPARTAM is table of LDC_CONTRA_ICA_GEOGRA.CONT_ICA_GEOG_DEPARTAM%type index by binary_integer;
	type tytbCONT_ICA_GEOG_LOCALIDA is table of LDC_CONTRA_ICA_GEOGRA.CONT_ICA_GEOG_LOCALIDA%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_CONTRA_ICA_GEOGRA is record
	(
		CONT_ICA_GEOG_ID   tytbCONT_ICA_GEOG_ID,
		CONT_ICA_GEOG_CONTRA   tytbCONT_ICA_GEOG_CONTRA,
		CONT_ICA_GEOG_DEPARTAM   tytbCONT_ICA_GEOG_DEPARTAM,
		CONT_ICA_GEOG_LOCALIDA   tytbCONT_ICA_GEOG_LOCALIDA,
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
		inuCONT_ICA_GEOG_ID in LDC_CONTRA_ICA_GEOGRA.CONT_ICA_GEOG_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuCONT_ICA_GEOG_ID in LDC_CONTRA_ICA_GEOGRA.CONT_ICA_GEOG_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuCONT_ICA_GEOG_ID in LDC_CONTRA_ICA_GEOGRA.CONT_ICA_GEOG_ID%type
	);

	PROCEDURE getRecord
	(
		inuCONT_ICA_GEOG_ID in LDC_CONTRA_ICA_GEOGRA.CONT_ICA_GEOG_ID%type,
		orcRecord out nocopy styLDC_CONTRA_ICA_GEOGRA
	);

	FUNCTION frcGetRcData
	(
		inuCONT_ICA_GEOG_ID in LDC_CONTRA_ICA_GEOGRA.CONT_ICA_GEOG_ID%type
	)
	RETURN styLDC_CONTRA_ICA_GEOGRA;

	FUNCTION frcGetRcData
	RETURN styLDC_CONTRA_ICA_GEOGRA;

	FUNCTION frcGetRecord
	(
		inuCONT_ICA_GEOG_ID in LDC_CONTRA_ICA_GEOGRA.CONT_ICA_GEOG_ID%type
	)
	RETURN styLDC_CONTRA_ICA_GEOGRA;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_CONTRA_ICA_GEOGRA
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_CONTRA_ICA_GEOGRA in styLDC_CONTRA_ICA_GEOGRA
	);

	PROCEDURE insRecord
	(
		ircLDC_CONTRA_ICA_GEOGRA in styLDC_CONTRA_ICA_GEOGRA,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_CONTRA_ICA_GEOGRA in out nocopy tytbLDC_CONTRA_ICA_GEOGRA
	);

	PROCEDURE delRecord
	(
		inuCONT_ICA_GEOG_ID in LDC_CONTRA_ICA_GEOGRA.CONT_ICA_GEOG_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_CONTRA_ICA_GEOGRA in out nocopy tytbLDC_CONTRA_ICA_GEOGRA,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_CONTRA_ICA_GEOGRA in styLDC_CONTRA_ICA_GEOGRA,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_CONTRA_ICA_GEOGRA in out nocopy tytbLDC_CONTRA_ICA_GEOGRA,
		inuLock in number default 1
	);

	PROCEDURE updCONT_ICA_GEOG_CONTRA
	(
		inuCONT_ICA_GEOG_ID in LDC_CONTRA_ICA_GEOGRA.CONT_ICA_GEOG_ID%type,
		inuCONT_ICA_GEOG_CONTRA$ in LDC_CONTRA_ICA_GEOGRA.CONT_ICA_GEOG_CONTRA%type,
		inuLock in number default 0
	);

	PROCEDURE updCONT_ICA_GEOG_DEPARTAM
	(
		inuCONT_ICA_GEOG_ID in LDC_CONTRA_ICA_GEOGRA.CONT_ICA_GEOG_ID%type,
		inuCONT_ICA_GEOG_DEPARTAM$ in LDC_CONTRA_ICA_GEOGRA.CONT_ICA_GEOG_DEPARTAM%type,
		inuLock in number default 0
	);

	PROCEDURE updCONT_ICA_GEOG_LOCALIDA
	(
		inuCONT_ICA_GEOG_ID in LDC_CONTRA_ICA_GEOGRA.CONT_ICA_GEOG_ID%type,
		inuCONT_ICA_GEOG_LOCALIDA$ in LDC_CONTRA_ICA_GEOGRA.CONT_ICA_GEOG_LOCALIDA%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetCONT_ICA_GEOG_ID
	(
		inuCONT_ICA_GEOG_ID in LDC_CONTRA_ICA_GEOGRA.CONT_ICA_GEOG_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONTRA_ICA_GEOGRA.CONT_ICA_GEOG_ID%type;

	FUNCTION fnuGetCONT_ICA_GEOG_CONTRA
	(
		inuCONT_ICA_GEOG_ID in LDC_CONTRA_ICA_GEOGRA.CONT_ICA_GEOG_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONTRA_ICA_GEOGRA.CONT_ICA_GEOG_CONTRA%type;

	FUNCTION fnuGetCONT_ICA_GEOG_DEPARTAM
	(
		inuCONT_ICA_GEOG_ID in LDC_CONTRA_ICA_GEOGRA.CONT_ICA_GEOG_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONTRA_ICA_GEOGRA.CONT_ICA_GEOG_DEPARTAM%type;

	FUNCTION fnuGetCONT_ICA_GEOG_LOCALIDA
	(
		inuCONT_ICA_GEOG_ID in LDC_CONTRA_ICA_GEOGRA.CONT_ICA_GEOG_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONTRA_ICA_GEOGRA.CONT_ICA_GEOG_LOCALIDA%type;


	PROCEDURE LockByPk
	(
		inuCONT_ICA_GEOG_ID in LDC_CONTRA_ICA_GEOGRA.CONT_ICA_GEOG_ID%type,
		orcLDC_CONTRA_ICA_GEOGRA  out styLDC_CONTRA_ICA_GEOGRA
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_CONTRA_ICA_GEOGRA  out styLDC_CONTRA_ICA_GEOGRA
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_CONTRA_ICA_GEOGRA;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALDC_CONTRA_ICA_GEOGRA
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_CONTRA_ICA_GEOGRA';
	 cnuGeEntityId constant varchar2(30) := 8685; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuCONT_ICA_GEOG_ID in LDC_CONTRA_ICA_GEOGRA.CONT_ICA_GEOG_ID%type
	)
	IS
		SELECT LDC_CONTRA_ICA_GEOGRA.*,LDC_CONTRA_ICA_GEOGRA.rowid
		FROM LDC_CONTRA_ICA_GEOGRA
		WHERE  CONT_ICA_GEOG_ID = inuCONT_ICA_GEOG_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_CONTRA_ICA_GEOGRA.*,LDC_CONTRA_ICA_GEOGRA.rowid
		FROM LDC_CONTRA_ICA_GEOGRA
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_CONTRA_ICA_GEOGRA is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_CONTRA_ICA_GEOGRA;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_CONTRA_ICA_GEOGRA default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.CONT_ICA_GEOG_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuCONT_ICA_GEOG_ID in LDC_CONTRA_ICA_GEOGRA.CONT_ICA_GEOG_ID%type,
		orcLDC_CONTRA_ICA_GEOGRA  out styLDC_CONTRA_ICA_GEOGRA
	)
	IS
		rcError styLDC_CONTRA_ICA_GEOGRA;
	BEGIN
		rcError.CONT_ICA_GEOG_ID := inuCONT_ICA_GEOG_ID;

		Open cuLockRcByPk
		(
			inuCONT_ICA_GEOG_ID
		);

		fetch cuLockRcByPk into orcLDC_CONTRA_ICA_GEOGRA;
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
		orcLDC_CONTRA_ICA_GEOGRA  out styLDC_CONTRA_ICA_GEOGRA
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_CONTRA_ICA_GEOGRA;
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
		itbLDC_CONTRA_ICA_GEOGRA  in out nocopy tytbLDC_CONTRA_ICA_GEOGRA
	)
	IS
	BEGIN
			rcRecOfTab.CONT_ICA_GEOG_ID.delete;
			rcRecOfTab.CONT_ICA_GEOG_CONTRA.delete;
			rcRecOfTab.CONT_ICA_GEOG_DEPARTAM.delete;
			rcRecOfTab.CONT_ICA_GEOG_LOCALIDA.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_CONTRA_ICA_GEOGRA  in out nocopy tytbLDC_CONTRA_ICA_GEOGRA,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_CONTRA_ICA_GEOGRA);

		for n in itbLDC_CONTRA_ICA_GEOGRA.first .. itbLDC_CONTRA_ICA_GEOGRA.last loop
			rcRecOfTab.CONT_ICA_GEOG_ID(n) := itbLDC_CONTRA_ICA_GEOGRA(n).CONT_ICA_GEOG_ID;
			rcRecOfTab.CONT_ICA_GEOG_CONTRA(n) := itbLDC_CONTRA_ICA_GEOGRA(n).CONT_ICA_GEOG_CONTRA;
			rcRecOfTab.CONT_ICA_GEOG_DEPARTAM(n) := itbLDC_CONTRA_ICA_GEOGRA(n).CONT_ICA_GEOG_DEPARTAM;
			rcRecOfTab.CONT_ICA_GEOG_LOCALIDA(n) := itbLDC_CONTRA_ICA_GEOGRA(n).CONT_ICA_GEOG_LOCALIDA;
			rcRecOfTab.row_id(n) := itbLDC_CONTRA_ICA_GEOGRA(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuCONT_ICA_GEOG_ID in LDC_CONTRA_ICA_GEOGRA.CONT_ICA_GEOG_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuCONT_ICA_GEOG_ID
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
		inuCONT_ICA_GEOG_ID in LDC_CONTRA_ICA_GEOGRA.CONT_ICA_GEOG_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuCONT_ICA_GEOG_ID = rcData.CONT_ICA_GEOG_ID
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
		inuCONT_ICA_GEOG_ID in LDC_CONTRA_ICA_GEOGRA.CONT_ICA_GEOG_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuCONT_ICA_GEOG_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuCONT_ICA_GEOG_ID in LDC_CONTRA_ICA_GEOGRA.CONT_ICA_GEOG_ID%type
	)
	IS
		rcError styLDC_CONTRA_ICA_GEOGRA;
	BEGIN		rcError.CONT_ICA_GEOG_ID:=inuCONT_ICA_GEOG_ID;

		Load
		(
			inuCONT_ICA_GEOG_ID
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
		inuCONT_ICA_GEOG_ID in LDC_CONTRA_ICA_GEOGRA.CONT_ICA_GEOG_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuCONT_ICA_GEOG_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuCONT_ICA_GEOG_ID in LDC_CONTRA_ICA_GEOGRA.CONT_ICA_GEOG_ID%type,
		orcRecord out nocopy styLDC_CONTRA_ICA_GEOGRA
	)
	IS
		rcError styLDC_CONTRA_ICA_GEOGRA;
	BEGIN		rcError.CONT_ICA_GEOG_ID:=inuCONT_ICA_GEOG_ID;

		Load
		(
			inuCONT_ICA_GEOG_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuCONT_ICA_GEOG_ID in LDC_CONTRA_ICA_GEOGRA.CONT_ICA_GEOG_ID%type
	)
	RETURN styLDC_CONTRA_ICA_GEOGRA
	IS
		rcError styLDC_CONTRA_ICA_GEOGRA;
	BEGIN
		rcError.CONT_ICA_GEOG_ID:=inuCONT_ICA_GEOG_ID;

		Load
		(
			inuCONT_ICA_GEOG_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuCONT_ICA_GEOG_ID in LDC_CONTRA_ICA_GEOGRA.CONT_ICA_GEOG_ID%type
	)
	RETURN styLDC_CONTRA_ICA_GEOGRA
	IS
		rcError styLDC_CONTRA_ICA_GEOGRA;
	BEGIN
		rcError.CONT_ICA_GEOG_ID:=inuCONT_ICA_GEOG_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuCONT_ICA_GEOG_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuCONT_ICA_GEOG_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_CONTRA_ICA_GEOGRA
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_CONTRA_ICA_GEOGRA
	)
	IS
		rfLDC_CONTRA_ICA_GEOGRA tyrfLDC_CONTRA_ICA_GEOGRA;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_CONTRA_ICA_GEOGRA.*, LDC_CONTRA_ICA_GEOGRA.rowid FROM LDC_CONTRA_ICA_GEOGRA';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_CONTRA_ICA_GEOGRA for sbFullQuery;

		fetch rfLDC_CONTRA_ICA_GEOGRA bulk collect INTO otbResult;

		close rfLDC_CONTRA_ICA_GEOGRA;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_CONTRA_ICA_GEOGRA.*, LDC_CONTRA_ICA_GEOGRA.rowid FROM LDC_CONTRA_ICA_GEOGRA';
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
		ircLDC_CONTRA_ICA_GEOGRA in styLDC_CONTRA_ICA_GEOGRA
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_CONTRA_ICA_GEOGRA,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_CONTRA_ICA_GEOGRA in styLDC_CONTRA_ICA_GEOGRA,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_CONTRA_ICA_GEOGRA.CONT_ICA_GEOG_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|CONT_ICA_GEOG_ID');
			raise ex.controlled_error;
		end if;

		insert into LDC_CONTRA_ICA_GEOGRA
		(
			CONT_ICA_GEOG_ID,
			CONT_ICA_GEOG_CONTRA,
			CONT_ICA_GEOG_DEPARTAM,
			CONT_ICA_GEOG_LOCALIDA
		)
		values
		(
			ircLDC_CONTRA_ICA_GEOGRA.CONT_ICA_GEOG_ID,
			ircLDC_CONTRA_ICA_GEOGRA.CONT_ICA_GEOG_CONTRA,
			ircLDC_CONTRA_ICA_GEOGRA.CONT_ICA_GEOG_DEPARTAM,
			ircLDC_CONTRA_ICA_GEOGRA.CONT_ICA_GEOG_LOCALIDA
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_CONTRA_ICA_GEOGRA));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_CONTRA_ICA_GEOGRA in out nocopy tytbLDC_CONTRA_ICA_GEOGRA
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_CONTRA_ICA_GEOGRA,blUseRowID);
		forall n in iotbLDC_CONTRA_ICA_GEOGRA.first..iotbLDC_CONTRA_ICA_GEOGRA.last
			insert into LDC_CONTRA_ICA_GEOGRA
			(
				CONT_ICA_GEOG_ID,
				CONT_ICA_GEOG_CONTRA,
				CONT_ICA_GEOG_DEPARTAM,
				CONT_ICA_GEOG_LOCALIDA
			)
			values
			(
				rcRecOfTab.CONT_ICA_GEOG_ID(n),
				rcRecOfTab.CONT_ICA_GEOG_CONTRA(n),
				rcRecOfTab.CONT_ICA_GEOG_DEPARTAM(n),
				rcRecOfTab.CONT_ICA_GEOG_LOCALIDA(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuCONT_ICA_GEOG_ID in LDC_CONTRA_ICA_GEOGRA.CONT_ICA_GEOG_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_CONTRA_ICA_GEOGRA;
	BEGIN
		rcError.CONT_ICA_GEOG_ID := inuCONT_ICA_GEOG_ID;

		if inuLock=1 then
			LockByPk
			(
				inuCONT_ICA_GEOG_ID,
				rcData
			);
		end if;


		delete
		from LDC_CONTRA_ICA_GEOGRA
		where
       		CONT_ICA_GEOG_ID=inuCONT_ICA_GEOG_ID;
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
		rcError  styLDC_CONTRA_ICA_GEOGRA;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_CONTRA_ICA_GEOGRA
		where
			rowid = iriRowID
		returning
			CONT_ICA_GEOG_ID
		into
			rcError.CONT_ICA_GEOG_ID;
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
		iotbLDC_CONTRA_ICA_GEOGRA in out nocopy tytbLDC_CONTRA_ICA_GEOGRA,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_CONTRA_ICA_GEOGRA;
	BEGIN
		FillRecordOfTables(iotbLDC_CONTRA_ICA_GEOGRA, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_CONTRA_ICA_GEOGRA.first .. iotbLDC_CONTRA_ICA_GEOGRA.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CONTRA_ICA_GEOGRA.first .. iotbLDC_CONTRA_ICA_GEOGRA.last
				delete
				from LDC_CONTRA_ICA_GEOGRA
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_CONTRA_ICA_GEOGRA.first .. iotbLDC_CONTRA_ICA_GEOGRA.last loop
					LockByPk
					(
						rcRecOfTab.CONT_ICA_GEOG_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CONTRA_ICA_GEOGRA.first .. iotbLDC_CONTRA_ICA_GEOGRA.last
				delete
				from LDC_CONTRA_ICA_GEOGRA
				where
		         	CONT_ICA_GEOG_ID = rcRecOfTab.CONT_ICA_GEOG_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_CONTRA_ICA_GEOGRA in styLDC_CONTRA_ICA_GEOGRA,
		inuLock in number default 0
	)
	IS
		nuCONT_ICA_GEOG_ID	LDC_CONTRA_ICA_GEOGRA.CONT_ICA_GEOG_ID%type;
	BEGIN
		if ircLDC_CONTRA_ICA_GEOGRA.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_CONTRA_ICA_GEOGRA.rowid,rcData);
			end if;
			update LDC_CONTRA_ICA_GEOGRA
			set
				CONT_ICA_GEOG_CONTRA = ircLDC_CONTRA_ICA_GEOGRA.CONT_ICA_GEOG_CONTRA,
				CONT_ICA_GEOG_DEPARTAM = ircLDC_CONTRA_ICA_GEOGRA.CONT_ICA_GEOG_DEPARTAM,
				CONT_ICA_GEOG_LOCALIDA = ircLDC_CONTRA_ICA_GEOGRA.CONT_ICA_GEOG_LOCALIDA
			where
				rowid = ircLDC_CONTRA_ICA_GEOGRA.rowid
			returning
				CONT_ICA_GEOG_ID
			into
				nuCONT_ICA_GEOG_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_CONTRA_ICA_GEOGRA.CONT_ICA_GEOG_ID,
					rcData
				);
			end if;

			update LDC_CONTRA_ICA_GEOGRA
			set
				CONT_ICA_GEOG_CONTRA = ircLDC_CONTRA_ICA_GEOGRA.CONT_ICA_GEOG_CONTRA,
				CONT_ICA_GEOG_DEPARTAM = ircLDC_CONTRA_ICA_GEOGRA.CONT_ICA_GEOG_DEPARTAM,
				CONT_ICA_GEOG_LOCALIDA = ircLDC_CONTRA_ICA_GEOGRA.CONT_ICA_GEOG_LOCALIDA
			where
				CONT_ICA_GEOG_ID = ircLDC_CONTRA_ICA_GEOGRA.CONT_ICA_GEOG_ID
			returning
				CONT_ICA_GEOG_ID
			into
				nuCONT_ICA_GEOG_ID;
		end if;
		if
			nuCONT_ICA_GEOG_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_CONTRA_ICA_GEOGRA));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_CONTRA_ICA_GEOGRA in out nocopy tytbLDC_CONTRA_ICA_GEOGRA,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_CONTRA_ICA_GEOGRA;
	BEGIN
		FillRecordOfTables(iotbLDC_CONTRA_ICA_GEOGRA,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_CONTRA_ICA_GEOGRA.first .. iotbLDC_CONTRA_ICA_GEOGRA.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CONTRA_ICA_GEOGRA.first .. iotbLDC_CONTRA_ICA_GEOGRA.last
				update LDC_CONTRA_ICA_GEOGRA
				set
					CONT_ICA_GEOG_CONTRA = rcRecOfTab.CONT_ICA_GEOG_CONTRA(n),
					CONT_ICA_GEOG_DEPARTAM = rcRecOfTab.CONT_ICA_GEOG_DEPARTAM(n),
					CONT_ICA_GEOG_LOCALIDA = rcRecOfTab.CONT_ICA_GEOG_LOCALIDA(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_CONTRA_ICA_GEOGRA.first .. iotbLDC_CONTRA_ICA_GEOGRA.last loop
					LockByPk
					(
						rcRecOfTab.CONT_ICA_GEOG_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CONTRA_ICA_GEOGRA.first .. iotbLDC_CONTRA_ICA_GEOGRA.last
				update LDC_CONTRA_ICA_GEOGRA
				SET
					CONT_ICA_GEOG_CONTRA = rcRecOfTab.CONT_ICA_GEOG_CONTRA(n),
					CONT_ICA_GEOG_DEPARTAM = rcRecOfTab.CONT_ICA_GEOG_DEPARTAM(n),
					CONT_ICA_GEOG_LOCALIDA = rcRecOfTab.CONT_ICA_GEOG_LOCALIDA(n)
				where
					CONT_ICA_GEOG_ID = rcRecOfTab.CONT_ICA_GEOG_ID(n)
;
		end if;
	END;
	PROCEDURE updCONT_ICA_GEOG_CONTRA
	(
		inuCONT_ICA_GEOG_ID in LDC_CONTRA_ICA_GEOGRA.CONT_ICA_GEOG_ID%type,
		inuCONT_ICA_GEOG_CONTRA$ in LDC_CONTRA_ICA_GEOGRA.CONT_ICA_GEOG_CONTRA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CONTRA_ICA_GEOGRA;
	BEGIN
		rcError.CONT_ICA_GEOG_ID := inuCONT_ICA_GEOG_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCONT_ICA_GEOG_ID,
				rcData
			);
		end if;

		update LDC_CONTRA_ICA_GEOGRA
		set
			CONT_ICA_GEOG_CONTRA = inuCONT_ICA_GEOG_CONTRA$
		where
			CONT_ICA_GEOG_ID = inuCONT_ICA_GEOG_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CONT_ICA_GEOG_CONTRA:= inuCONT_ICA_GEOG_CONTRA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCONT_ICA_GEOG_DEPARTAM
	(
		inuCONT_ICA_GEOG_ID in LDC_CONTRA_ICA_GEOGRA.CONT_ICA_GEOG_ID%type,
		inuCONT_ICA_GEOG_DEPARTAM$ in LDC_CONTRA_ICA_GEOGRA.CONT_ICA_GEOG_DEPARTAM%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CONTRA_ICA_GEOGRA;
	BEGIN
		rcError.CONT_ICA_GEOG_ID := inuCONT_ICA_GEOG_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCONT_ICA_GEOG_ID,
				rcData
			);
		end if;

		update LDC_CONTRA_ICA_GEOGRA
		set
			CONT_ICA_GEOG_DEPARTAM = inuCONT_ICA_GEOG_DEPARTAM$
		where
			CONT_ICA_GEOG_ID = inuCONT_ICA_GEOG_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CONT_ICA_GEOG_DEPARTAM:= inuCONT_ICA_GEOG_DEPARTAM$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCONT_ICA_GEOG_LOCALIDA
	(
		inuCONT_ICA_GEOG_ID in LDC_CONTRA_ICA_GEOGRA.CONT_ICA_GEOG_ID%type,
		inuCONT_ICA_GEOG_LOCALIDA$ in LDC_CONTRA_ICA_GEOGRA.CONT_ICA_GEOG_LOCALIDA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CONTRA_ICA_GEOGRA;
	BEGIN
		rcError.CONT_ICA_GEOG_ID := inuCONT_ICA_GEOG_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCONT_ICA_GEOG_ID,
				rcData
			);
		end if;

		update LDC_CONTRA_ICA_GEOGRA
		set
			CONT_ICA_GEOG_LOCALIDA = inuCONT_ICA_GEOG_LOCALIDA$
		where
			CONT_ICA_GEOG_ID = inuCONT_ICA_GEOG_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CONT_ICA_GEOG_LOCALIDA:= inuCONT_ICA_GEOG_LOCALIDA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetCONT_ICA_GEOG_ID
	(
		inuCONT_ICA_GEOG_ID in LDC_CONTRA_ICA_GEOGRA.CONT_ICA_GEOG_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONTRA_ICA_GEOGRA.CONT_ICA_GEOG_ID%type
	IS
		rcError styLDC_CONTRA_ICA_GEOGRA;
	BEGIN

		rcError.CONT_ICA_GEOG_ID := inuCONT_ICA_GEOG_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONT_ICA_GEOG_ID
			 )
		then
			 return(rcData.CONT_ICA_GEOG_ID);
		end if;
		Load
		(
		 		inuCONT_ICA_GEOG_ID
		);
		return(rcData.CONT_ICA_GEOG_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCONT_ICA_GEOG_CONTRA
	(
		inuCONT_ICA_GEOG_ID in LDC_CONTRA_ICA_GEOGRA.CONT_ICA_GEOG_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONTRA_ICA_GEOGRA.CONT_ICA_GEOG_CONTRA%type
	IS
		rcError styLDC_CONTRA_ICA_GEOGRA;
	BEGIN

		rcError.CONT_ICA_GEOG_ID := inuCONT_ICA_GEOG_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONT_ICA_GEOG_ID
			 )
		then
			 return(rcData.CONT_ICA_GEOG_CONTRA);
		end if;
		Load
		(
		 		inuCONT_ICA_GEOG_ID
		);
		return(rcData.CONT_ICA_GEOG_CONTRA);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCONT_ICA_GEOG_DEPARTAM
	(
		inuCONT_ICA_GEOG_ID in LDC_CONTRA_ICA_GEOGRA.CONT_ICA_GEOG_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONTRA_ICA_GEOGRA.CONT_ICA_GEOG_DEPARTAM%type
	IS
		rcError styLDC_CONTRA_ICA_GEOGRA;
	BEGIN

		rcError.CONT_ICA_GEOG_ID := inuCONT_ICA_GEOG_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONT_ICA_GEOG_ID
			 )
		then
			 return(rcData.CONT_ICA_GEOG_DEPARTAM);
		end if;
		Load
		(
		 		inuCONT_ICA_GEOG_ID
		);
		return(rcData.CONT_ICA_GEOG_DEPARTAM);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCONT_ICA_GEOG_LOCALIDA
	(
		inuCONT_ICA_GEOG_ID in LDC_CONTRA_ICA_GEOGRA.CONT_ICA_GEOG_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONTRA_ICA_GEOGRA.CONT_ICA_GEOG_LOCALIDA%type
	IS
		rcError styLDC_CONTRA_ICA_GEOGRA;
	BEGIN

		rcError.CONT_ICA_GEOG_ID := inuCONT_ICA_GEOG_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONT_ICA_GEOG_ID
			 )
		then
			 return(rcData.CONT_ICA_GEOG_LOCALIDA);
		end if;
		Load
		(
		 		inuCONT_ICA_GEOG_ID
		);
		return(rcData.CONT_ICA_GEOG_LOCALIDA);
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
end DALDC_CONTRA_ICA_GEOGRA;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALDC_CONTRA_ICA_GEOGRA
BEGIN
    pkg_utilidades.prAplicarPermisos('DALDC_CONTRA_ICA_GEOGRA', 'ADM_PERSON'); 
END;
/
