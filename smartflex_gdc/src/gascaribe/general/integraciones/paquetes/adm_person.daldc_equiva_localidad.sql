CREATE OR REPLACE PACKAGE adm_person.daldc_equiva_localidad
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  12/06/2024   Adrianavg   OSF-2779: Se migra del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuGEOGRAP_LOCATION_ID in LDC_EQUIVA_LOCALIDAD.GEOGRAP_LOCATION_ID%type
	)
	IS
		SELECT LDC_EQUIVA_LOCALIDAD.*,LDC_EQUIVA_LOCALIDAD.rowid
		FROM LDC_EQUIVA_LOCALIDAD
		WHERE
		    GEOGRAP_LOCATION_ID = inuGEOGRAP_LOCATION_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_EQUIVA_LOCALIDAD.*,LDC_EQUIVA_LOCALIDAD.rowid
		FROM LDC_EQUIVA_LOCALIDAD
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_EQUIVA_LOCALIDAD  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_EQUIVA_LOCALIDAD is table of styLDC_EQUIVA_LOCALIDAD index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_EQUIVA_LOCALIDAD;

	/* Tipos referenciando al registro */
	type tytbGEOGRAP_LOCATION_ID is table of LDC_EQUIVA_LOCALIDAD.GEOGRAP_LOCATION_ID%type index by binary_integer;
	type tytbDEPARTAMENTO is table of LDC_EQUIVA_LOCALIDAD.DEPARTAMENTO%type index by binary_integer;
	type tytbMUNICIPIO is table of LDC_EQUIVA_LOCALIDAD.MUNICIPIO%type index by binary_integer;
	type tytbPOBLACION is table of LDC_EQUIVA_LOCALIDAD.POBLACION%type index by binary_integer;
	type tytbSERVICIOEXCLU is table of LDC_EQUIVA_LOCALIDAD.SERVICIOEXCLU%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_EQUIVA_LOCALIDAD is record
	(
		GEOGRAP_LOCATION_ID   tytbGEOGRAP_LOCATION_ID,
		DEPARTAMENTO   tytbDEPARTAMENTO,
		MUNICIPIO   tytbMUNICIPIO,
		POBLACION   tytbPOBLACION,
		SERVICIOEXCLU   tytbSERVICIOEXCLU,
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
		inuGEOGRAP_LOCATION_ID in LDC_EQUIVA_LOCALIDAD.GEOGRAP_LOCATION_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuGEOGRAP_LOCATION_ID in LDC_EQUIVA_LOCALIDAD.GEOGRAP_LOCATION_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuGEOGRAP_LOCATION_ID in LDC_EQUIVA_LOCALIDAD.GEOGRAP_LOCATION_ID%type
	);

	PROCEDURE getRecord
	(
		inuGEOGRAP_LOCATION_ID in LDC_EQUIVA_LOCALIDAD.GEOGRAP_LOCATION_ID%type,
		orcRecord out nocopy styLDC_EQUIVA_LOCALIDAD
	);

	FUNCTION frcGetRcData
	(
		inuGEOGRAP_LOCATION_ID in LDC_EQUIVA_LOCALIDAD.GEOGRAP_LOCATION_ID%type
	)
	RETURN styLDC_EQUIVA_LOCALIDAD;

	FUNCTION frcGetRcData
	RETURN styLDC_EQUIVA_LOCALIDAD;

	FUNCTION frcGetRecord
	(
		inuGEOGRAP_LOCATION_ID in LDC_EQUIVA_LOCALIDAD.GEOGRAP_LOCATION_ID%type
	)
	RETURN styLDC_EQUIVA_LOCALIDAD;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_EQUIVA_LOCALIDAD
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_EQUIVA_LOCALIDAD in styLDC_EQUIVA_LOCALIDAD
	);

	PROCEDURE insRecord
	(
		ircLDC_EQUIVA_LOCALIDAD in styLDC_EQUIVA_LOCALIDAD,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_EQUIVA_LOCALIDAD in out nocopy tytbLDC_EQUIVA_LOCALIDAD
	);

	PROCEDURE delRecord
	(
		inuGEOGRAP_LOCATION_ID in LDC_EQUIVA_LOCALIDAD.GEOGRAP_LOCATION_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_EQUIVA_LOCALIDAD in out nocopy tytbLDC_EQUIVA_LOCALIDAD,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_EQUIVA_LOCALIDAD in styLDC_EQUIVA_LOCALIDAD,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_EQUIVA_LOCALIDAD in out nocopy tytbLDC_EQUIVA_LOCALIDAD,
		inuLock in number default 1
	);

	PROCEDURE updDEPARTAMENTO
	(
		inuGEOGRAP_LOCATION_ID in LDC_EQUIVA_LOCALIDAD.GEOGRAP_LOCATION_ID%type,
		isbDEPARTAMENTO$ in LDC_EQUIVA_LOCALIDAD.DEPARTAMENTO%type,
		inuLock in number default 0
	);

	PROCEDURE updMUNICIPIO
	(
		inuGEOGRAP_LOCATION_ID in LDC_EQUIVA_LOCALIDAD.GEOGRAP_LOCATION_ID%type,
		isbMUNICIPIO$ in LDC_EQUIVA_LOCALIDAD.MUNICIPIO%type,
		inuLock in number default 0
	);

	PROCEDURE updPOBLACION
	(
		inuGEOGRAP_LOCATION_ID in LDC_EQUIVA_LOCALIDAD.GEOGRAP_LOCATION_ID%type,
		isbPOBLACION$ in LDC_EQUIVA_LOCALIDAD.POBLACION%type,
		inuLock in number default 0
	);

	PROCEDURE updSERVICIOEXCLU
	(
		inuGEOGRAP_LOCATION_ID in LDC_EQUIVA_LOCALIDAD.GEOGRAP_LOCATION_ID%type,
		isbSERVICIOEXCLU$ in LDC_EQUIVA_LOCALIDAD.SERVICIOEXCLU%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetGEOGRAP_LOCATION_ID
	(
		inuGEOGRAP_LOCATION_ID in LDC_EQUIVA_LOCALIDAD.GEOGRAP_LOCATION_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_EQUIVA_LOCALIDAD.GEOGRAP_LOCATION_ID%type;

	FUNCTION fsbGetDEPARTAMENTO
	(
		inuGEOGRAP_LOCATION_ID in LDC_EQUIVA_LOCALIDAD.GEOGRAP_LOCATION_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_EQUIVA_LOCALIDAD.DEPARTAMENTO%type;

	FUNCTION fsbGetMUNICIPIO
	(
		inuGEOGRAP_LOCATION_ID in LDC_EQUIVA_LOCALIDAD.GEOGRAP_LOCATION_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_EQUIVA_LOCALIDAD.MUNICIPIO%type;

	FUNCTION fsbGetPOBLACION
	(
		inuGEOGRAP_LOCATION_ID in LDC_EQUIVA_LOCALIDAD.GEOGRAP_LOCATION_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_EQUIVA_LOCALIDAD.POBLACION%type;

	FUNCTION fsbGetSERVICIOEXCLU
	(
		inuGEOGRAP_LOCATION_ID in LDC_EQUIVA_LOCALIDAD.GEOGRAP_LOCATION_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_EQUIVA_LOCALIDAD.SERVICIOEXCLU%type;


	PROCEDURE LockByPk
	(
		inuGEOGRAP_LOCATION_ID in LDC_EQUIVA_LOCALIDAD.GEOGRAP_LOCATION_ID%type,
		orcLDC_EQUIVA_LOCALIDAD  out styLDC_EQUIVA_LOCALIDAD
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_EQUIVA_LOCALIDAD  out styLDC_EQUIVA_LOCALIDAD
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_EQUIVA_LOCALIDAD;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALDC_EQUIVA_LOCALIDAD
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_EQUIVA_LOCALIDAD';
	 cnuGeEntityId constant varchar2(30) := 8776; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuGEOGRAP_LOCATION_ID in LDC_EQUIVA_LOCALIDAD.GEOGRAP_LOCATION_ID%type
	)
	IS
		SELECT LDC_EQUIVA_LOCALIDAD.*,LDC_EQUIVA_LOCALIDAD.rowid
		FROM LDC_EQUIVA_LOCALIDAD
		WHERE  GEOGRAP_LOCATION_ID = inuGEOGRAP_LOCATION_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_EQUIVA_LOCALIDAD.*,LDC_EQUIVA_LOCALIDAD.rowid
		FROM LDC_EQUIVA_LOCALIDAD
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_EQUIVA_LOCALIDAD is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_EQUIVA_LOCALIDAD;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_EQUIVA_LOCALIDAD default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.GEOGRAP_LOCATION_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuGEOGRAP_LOCATION_ID in LDC_EQUIVA_LOCALIDAD.GEOGRAP_LOCATION_ID%type,
		orcLDC_EQUIVA_LOCALIDAD  out styLDC_EQUIVA_LOCALIDAD
	)
	IS
		rcError styLDC_EQUIVA_LOCALIDAD;
	BEGIN
		rcError.GEOGRAP_LOCATION_ID := inuGEOGRAP_LOCATION_ID;

		Open cuLockRcByPk
		(
			inuGEOGRAP_LOCATION_ID
		);

		fetch cuLockRcByPk into orcLDC_EQUIVA_LOCALIDAD;
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
		orcLDC_EQUIVA_LOCALIDAD  out styLDC_EQUIVA_LOCALIDAD
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_EQUIVA_LOCALIDAD;
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
		itbLDC_EQUIVA_LOCALIDAD  in out nocopy tytbLDC_EQUIVA_LOCALIDAD
	)
	IS
	BEGIN
			rcRecOfTab.GEOGRAP_LOCATION_ID.delete;
			rcRecOfTab.DEPARTAMENTO.delete;
			rcRecOfTab.MUNICIPIO.delete;
			rcRecOfTab.POBLACION.delete;
			rcRecOfTab.SERVICIOEXCLU.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_EQUIVA_LOCALIDAD  in out nocopy tytbLDC_EQUIVA_LOCALIDAD,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_EQUIVA_LOCALIDAD);

		for n in itbLDC_EQUIVA_LOCALIDAD.first .. itbLDC_EQUIVA_LOCALIDAD.last loop
			rcRecOfTab.GEOGRAP_LOCATION_ID(n) := itbLDC_EQUIVA_LOCALIDAD(n).GEOGRAP_LOCATION_ID;
			rcRecOfTab.DEPARTAMENTO(n) := itbLDC_EQUIVA_LOCALIDAD(n).DEPARTAMENTO;
			rcRecOfTab.MUNICIPIO(n) := itbLDC_EQUIVA_LOCALIDAD(n).MUNICIPIO;
			rcRecOfTab.POBLACION(n) := itbLDC_EQUIVA_LOCALIDAD(n).POBLACION;
			rcRecOfTab.SERVICIOEXCLU(n) := itbLDC_EQUIVA_LOCALIDAD(n).SERVICIOEXCLU;
			rcRecOfTab.row_id(n) := itbLDC_EQUIVA_LOCALIDAD(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuGEOGRAP_LOCATION_ID in LDC_EQUIVA_LOCALIDAD.GEOGRAP_LOCATION_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuGEOGRAP_LOCATION_ID
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
		inuGEOGRAP_LOCATION_ID in LDC_EQUIVA_LOCALIDAD.GEOGRAP_LOCATION_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuGEOGRAP_LOCATION_ID = rcData.GEOGRAP_LOCATION_ID
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
		inuGEOGRAP_LOCATION_ID in LDC_EQUIVA_LOCALIDAD.GEOGRAP_LOCATION_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuGEOGRAP_LOCATION_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuGEOGRAP_LOCATION_ID in LDC_EQUIVA_LOCALIDAD.GEOGRAP_LOCATION_ID%type
	)
	IS
		rcError styLDC_EQUIVA_LOCALIDAD;
	BEGIN		rcError.GEOGRAP_LOCATION_ID:=inuGEOGRAP_LOCATION_ID;

		Load
		(
			inuGEOGRAP_LOCATION_ID
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
		inuGEOGRAP_LOCATION_ID in LDC_EQUIVA_LOCALIDAD.GEOGRAP_LOCATION_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuGEOGRAP_LOCATION_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuGEOGRAP_LOCATION_ID in LDC_EQUIVA_LOCALIDAD.GEOGRAP_LOCATION_ID%type,
		orcRecord out nocopy styLDC_EQUIVA_LOCALIDAD
	)
	IS
		rcError styLDC_EQUIVA_LOCALIDAD;
	BEGIN		rcError.GEOGRAP_LOCATION_ID:=inuGEOGRAP_LOCATION_ID;

		Load
		(
			inuGEOGRAP_LOCATION_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuGEOGRAP_LOCATION_ID in LDC_EQUIVA_LOCALIDAD.GEOGRAP_LOCATION_ID%type
	)
	RETURN styLDC_EQUIVA_LOCALIDAD
	IS
		rcError styLDC_EQUIVA_LOCALIDAD;
	BEGIN
		rcError.GEOGRAP_LOCATION_ID:=inuGEOGRAP_LOCATION_ID;

		Load
		(
			inuGEOGRAP_LOCATION_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuGEOGRAP_LOCATION_ID in LDC_EQUIVA_LOCALIDAD.GEOGRAP_LOCATION_ID%type
	)
	RETURN styLDC_EQUIVA_LOCALIDAD
	IS
		rcError styLDC_EQUIVA_LOCALIDAD;
	BEGIN
		rcError.GEOGRAP_LOCATION_ID:=inuGEOGRAP_LOCATION_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuGEOGRAP_LOCATION_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuGEOGRAP_LOCATION_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_EQUIVA_LOCALIDAD
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_EQUIVA_LOCALIDAD
	)
	IS
		rfLDC_EQUIVA_LOCALIDAD tyrfLDC_EQUIVA_LOCALIDAD;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_EQUIVA_LOCALIDAD.*, LDC_EQUIVA_LOCALIDAD.rowid FROM LDC_EQUIVA_LOCALIDAD';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_EQUIVA_LOCALIDAD for sbFullQuery;

		fetch rfLDC_EQUIVA_LOCALIDAD bulk collect INTO otbResult;

		close rfLDC_EQUIVA_LOCALIDAD;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_EQUIVA_LOCALIDAD.*, LDC_EQUIVA_LOCALIDAD.rowid FROM LDC_EQUIVA_LOCALIDAD';
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
		ircLDC_EQUIVA_LOCALIDAD in styLDC_EQUIVA_LOCALIDAD
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_EQUIVA_LOCALIDAD,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_EQUIVA_LOCALIDAD in styLDC_EQUIVA_LOCALIDAD,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_EQUIVA_LOCALIDAD.GEOGRAP_LOCATION_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|GEOGRAP_LOCATION_ID');
			raise ex.controlled_error;
		end if;

		insert into LDC_EQUIVA_LOCALIDAD
		(
			GEOGRAP_LOCATION_ID,
			DEPARTAMENTO,
			MUNICIPIO,
			POBLACION,
			SERVICIOEXCLU
		)
		values
		(
			ircLDC_EQUIVA_LOCALIDAD.GEOGRAP_LOCATION_ID,
			ircLDC_EQUIVA_LOCALIDAD.DEPARTAMENTO,
			ircLDC_EQUIVA_LOCALIDAD.MUNICIPIO,
			ircLDC_EQUIVA_LOCALIDAD.POBLACION,
			ircLDC_EQUIVA_LOCALIDAD.SERVICIOEXCLU
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_EQUIVA_LOCALIDAD));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_EQUIVA_LOCALIDAD in out nocopy tytbLDC_EQUIVA_LOCALIDAD
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_EQUIVA_LOCALIDAD,blUseRowID);
		forall n in iotbLDC_EQUIVA_LOCALIDAD.first..iotbLDC_EQUIVA_LOCALIDAD.last
			insert into LDC_EQUIVA_LOCALIDAD
			(
				GEOGRAP_LOCATION_ID,
				DEPARTAMENTO,
				MUNICIPIO,
				POBLACION,
				SERVICIOEXCLU
			)
			values
			(
				rcRecOfTab.GEOGRAP_LOCATION_ID(n),
				rcRecOfTab.DEPARTAMENTO(n),
				rcRecOfTab.MUNICIPIO(n),
				rcRecOfTab.POBLACION(n),
				rcRecOfTab.SERVICIOEXCLU(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuGEOGRAP_LOCATION_ID in LDC_EQUIVA_LOCALIDAD.GEOGRAP_LOCATION_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_EQUIVA_LOCALIDAD;
	BEGIN
		rcError.GEOGRAP_LOCATION_ID := inuGEOGRAP_LOCATION_ID;

		if inuLock=1 then
			LockByPk
			(
				inuGEOGRAP_LOCATION_ID,
				rcData
			);
		end if;


		delete
		from LDC_EQUIVA_LOCALIDAD
		where
       		GEOGRAP_LOCATION_ID=inuGEOGRAP_LOCATION_ID;
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
		rcError  styLDC_EQUIVA_LOCALIDAD;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_EQUIVA_LOCALIDAD
		where
			rowid = iriRowID
		returning
			GEOGRAP_LOCATION_ID
		into
			rcError.GEOGRAP_LOCATION_ID;
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
		iotbLDC_EQUIVA_LOCALIDAD in out nocopy tytbLDC_EQUIVA_LOCALIDAD,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_EQUIVA_LOCALIDAD;
	BEGIN
		FillRecordOfTables(iotbLDC_EQUIVA_LOCALIDAD, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_EQUIVA_LOCALIDAD.first .. iotbLDC_EQUIVA_LOCALIDAD.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_EQUIVA_LOCALIDAD.first .. iotbLDC_EQUIVA_LOCALIDAD.last
				delete
				from LDC_EQUIVA_LOCALIDAD
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_EQUIVA_LOCALIDAD.first .. iotbLDC_EQUIVA_LOCALIDAD.last loop
					LockByPk
					(
						rcRecOfTab.GEOGRAP_LOCATION_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_EQUIVA_LOCALIDAD.first .. iotbLDC_EQUIVA_LOCALIDAD.last
				delete
				from LDC_EQUIVA_LOCALIDAD
				where
		         	GEOGRAP_LOCATION_ID = rcRecOfTab.GEOGRAP_LOCATION_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_EQUIVA_LOCALIDAD in styLDC_EQUIVA_LOCALIDAD,
		inuLock in number default 0
	)
	IS
		nuGEOGRAP_LOCATION_ID	LDC_EQUIVA_LOCALIDAD.GEOGRAP_LOCATION_ID%type;
	BEGIN
		if ircLDC_EQUIVA_LOCALIDAD.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_EQUIVA_LOCALIDAD.rowid,rcData);
			end if;
			update LDC_EQUIVA_LOCALIDAD
			set
				DEPARTAMENTO = ircLDC_EQUIVA_LOCALIDAD.DEPARTAMENTO,
				MUNICIPIO = ircLDC_EQUIVA_LOCALIDAD.MUNICIPIO,
				POBLACION = ircLDC_EQUIVA_LOCALIDAD.POBLACION,
				SERVICIOEXCLU = ircLDC_EQUIVA_LOCALIDAD.SERVICIOEXCLU
			where
				rowid = ircLDC_EQUIVA_LOCALIDAD.rowid
			returning
				GEOGRAP_LOCATION_ID
			into
				nuGEOGRAP_LOCATION_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_EQUIVA_LOCALIDAD.GEOGRAP_LOCATION_ID,
					rcData
				);
			end if;

			update LDC_EQUIVA_LOCALIDAD
			set
				DEPARTAMENTO = ircLDC_EQUIVA_LOCALIDAD.DEPARTAMENTO,
				MUNICIPIO = ircLDC_EQUIVA_LOCALIDAD.MUNICIPIO,
				POBLACION = ircLDC_EQUIVA_LOCALIDAD.POBLACION,
				SERVICIOEXCLU = ircLDC_EQUIVA_LOCALIDAD.SERVICIOEXCLU
			where
				GEOGRAP_LOCATION_ID = ircLDC_EQUIVA_LOCALIDAD.GEOGRAP_LOCATION_ID
			returning
				GEOGRAP_LOCATION_ID
			into
				nuGEOGRAP_LOCATION_ID;
		end if;
		if
			nuGEOGRAP_LOCATION_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_EQUIVA_LOCALIDAD));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_EQUIVA_LOCALIDAD in out nocopy tytbLDC_EQUIVA_LOCALIDAD,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_EQUIVA_LOCALIDAD;
	BEGIN
		FillRecordOfTables(iotbLDC_EQUIVA_LOCALIDAD,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_EQUIVA_LOCALIDAD.first .. iotbLDC_EQUIVA_LOCALIDAD.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_EQUIVA_LOCALIDAD.first .. iotbLDC_EQUIVA_LOCALIDAD.last
				update LDC_EQUIVA_LOCALIDAD
				set
					DEPARTAMENTO = rcRecOfTab.DEPARTAMENTO(n),
					MUNICIPIO = rcRecOfTab.MUNICIPIO(n),
					POBLACION = rcRecOfTab.POBLACION(n),
					SERVICIOEXCLU = rcRecOfTab.SERVICIOEXCLU(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_EQUIVA_LOCALIDAD.first .. iotbLDC_EQUIVA_LOCALIDAD.last loop
					LockByPk
					(
						rcRecOfTab.GEOGRAP_LOCATION_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_EQUIVA_LOCALIDAD.first .. iotbLDC_EQUIVA_LOCALIDAD.last
				update LDC_EQUIVA_LOCALIDAD
				SET
					DEPARTAMENTO = rcRecOfTab.DEPARTAMENTO(n),
					MUNICIPIO = rcRecOfTab.MUNICIPIO(n),
					POBLACION = rcRecOfTab.POBLACION(n),
					SERVICIOEXCLU = rcRecOfTab.SERVICIOEXCLU(n)
				where
					GEOGRAP_LOCATION_ID = rcRecOfTab.GEOGRAP_LOCATION_ID(n)
;
		end if;
	END;
	PROCEDURE updDEPARTAMENTO
	(
		inuGEOGRAP_LOCATION_ID in LDC_EQUIVA_LOCALIDAD.GEOGRAP_LOCATION_ID%type,
		isbDEPARTAMENTO$ in LDC_EQUIVA_LOCALIDAD.DEPARTAMENTO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_EQUIVA_LOCALIDAD;
	BEGIN
		rcError.GEOGRAP_LOCATION_ID := inuGEOGRAP_LOCATION_ID;
		if inuLock=1 then
			LockByPk
			(
				inuGEOGRAP_LOCATION_ID,
				rcData
			);
		end if;

		update LDC_EQUIVA_LOCALIDAD
		set
			DEPARTAMENTO = isbDEPARTAMENTO$
		where
			GEOGRAP_LOCATION_ID = inuGEOGRAP_LOCATION_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DEPARTAMENTO:= isbDEPARTAMENTO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updMUNICIPIO
	(
		inuGEOGRAP_LOCATION_ID in LDC_EQUIVA_LOCALIDAD.GEOGRAP_LOCATION_ID%type,
		isbMUNICIPIO$ in LDC_EQUIVA_LOCALIDAD.MUNICIPIO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_EQUIVA_LOCALIDAD;
	BEGIN
		rcError.GEOGRAP_LOCATION_ID := inuGEOGRAP_LOCATION_ID;
		if inuLock=1 then
			LockByPk
			(
				inuGEOGRAP_LOCATION_ID,
				rcData
			);
		end if;

		update LDC_EQUIVA_LOCALIDAD
		set
			MUNICIPIO = isbMUNICIPIO$
		where
			GEOGRAP_LOCATION_ID = inuGEOGRAP_LOCATION_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.MUNICIPIO:= isbMUNICIPIO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPOBLACION
	(
		inuGEOGRAP_LOCATION_ID in LDC_EQUIVA_LOCALIDAD.GEOGRAP_LOCATION_ID%type,
		isbPOBLACION$ in LDC_EQUIVA_LOCALIDAD.POBLACION%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_EQUIVA_LOCALIDAD;
	BEGIN
		rcError.GEOGRAP_LOCATION_ID := inuGEOGRAP_LOCATION_ID;
		if inuLock=1 then
			LockByPk
			(
				inuGEOGRAP_LOCATION_ID,
				rcData
			);
		end if;

		update LDC_EQUIVA_LOCALIDAD
		set
			POBLACION = isbPOBLACION$
		where
			GEOGRAP_LOCATION_ID = inuGEOGRAP_LOCATION_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.POBLACION:= isbPOBLACION$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSERVICIOEXCLU
	(
		inuGEOGRAP_LOCATION_ID in LDC_EQUIVA_LOCALIDAD.GEOGRAP_LOCATION_ID%type,
		isbSERVICIOEXCLU$ in LDC_EQUIVA_LOCALIDAD.SERVICIOEXCLU%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_EQUIVA_LOCALIDAD;
	BEGIN
		rcError.GEOGRAP_LOCATION_ID := inuGEOGRAP_LOCATION_ID;
		if inuLock=1 then
			LockByPk
			(
				inuGEOGRAP_LOCATION_ID,
				rcData
			);
		end if;

		update LDC_EQUIVA_LOCALIDAD
		set
			SERVICIOEXCLU = isbSERVICIOEXCLU$
		where
			GEOGRAP_LOCATION_ID = inuGEOGRAP_LOCATION_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SERVICIOEXCLU:= isbSERVICIOEXCLU$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetGEOGRAP_LOCATION_ID
	(
		inuGEOGRAP_LOCATION_ID in LDC_EQUIVA_LOCALIDAD.GEOGRAP_LOCATION_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_EQUIVA_LOCALIDAD.GEOGRAP_LOCATION_ID%type
	IS
		rcError styLDC_EQUIVA_LOCALIDAD;
	BEGIN

		rcError.GEOGRAP_LOCATION_ID := inuGEOGRAP_LOCATION_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuGEOGRAP_LOCATION_ID
			 )
		then
			 return(rcData.GEOGRAP_LOCATION_ID);
		end if;
		Load
		(
		 		inuGEOGRAP_LOCATION_ID
		);
		return(rcData.GEOGRAP_LOCATION_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetDEPARTAMENTO
	(
		inuGEOGRAP_LOCATION_ID in LDC_EQUIVA_LOCALIDAD.GEOGRAP_LOCATION_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_EQUIVA_LOCALIDAD.DEPARTAMENTO%type
	IS
		rcError styLDC_EQUIVA_LOCALIDAD;
	BEGIN

		rcError.GEOGRAP_LOCATION_ID := inuGEOGRAP_LOCATION_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuGEOGRAP_LOCATION_ID
			 )
		then
			 return(rcData.DEPARTAMENTO);
		end if;
		Load
		(
		 		inuGEOGRAP_LOCATION_ID
		);
		return(rcData.DEPARTAMENTO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetMUNICIPIO
	(
		inuGEOGRAP_LOCATION_ID in LDC_EQUIVA_LOCALIDAD.GEOGRAP_LOCATION_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_EQUIVA_LOCALIDAD.MUNICIPIO%type
	IS
		rcError styLDC_EQUIVA_LOCALIDAD;
	BEGIN

		rcError.GEOGRAP_LOCATION_ID := inuGEOGRAP_LOCATION_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuGEOGRAP_LOCATION_ID
			 )
		then
			 return(rcData.MUNICIPIO);
		end if;
		Load
		(
		 		inuGEOGRAP_LOCATION_ID
		);
		return(rcData.MUNICIPIO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetPOBLACION
	(
		inuGEOGRAP_LOCATION_ID in LDC_EQUIVA_LOCALIDAD.GEOGRAP_LOCATION_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_EQUIVA_LOCALIDAD.POBLACION%type
	IS
		rcError styLDC_EQUIVA_LOCALIDAD;
	BEGIN

		rcError.GEOGRAP_LOCATION_ID := inuGEOGRAP_LOCATION_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuGEOGRAP_LOCATION_ID
			 )
		then
			 return(rcData.POBLACION);
		end if;
		Load
		(
		 		inuGEOGRAP_LOCATION_ID
		);
		return(rcData.POBLACION);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetSERVICIOEXCLU
	(
		inuGEOGRAP_LOCATION_ID in LDC_EQUIVA_LOCALIDAD.GEOGRAP_LOCATION_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_EQUIVA_LOCALIDAD.SERVICIOEXCLU%type
	IS
		rcError styLDC_EQUIVA_LOCALIDAD;
	BEGIN

		rcError.GEOGRAP_LOCATION_ID := inuGEOGRAP_LOCATION_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuGEOGRAP_LOCATION_ID
			 )
		then
			 return(rcData.SERVICIOEXCLU);
		end if;
		Load
		(
		 		inuGEOGRAP_LOCATION_ID
		);
		return(rcData.SERVICIOEXCLU);
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
end DALDC_EQUIVA_LOCALIDAD;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALDC_EQUIVA_LOCALIDAD
BEGIN
    pkg_utilidades.prAplicarPermisos('DALDC_EQUIVA_LOCALIDAD', 'ADM_PERSON'); 
END;
/ 
