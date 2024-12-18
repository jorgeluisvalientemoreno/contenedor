CREATE OR REPLACE PACKAGE adm_person.daldc_tipo_construccion
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  11/06/2024   Adrianavg   OSF-2813: Migrar del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuID_TIPO_CONSTRUCCION in LDC_TIPO_CONSTRUCCION.ID_TIPO_CONSTRUCCION%type
	)
	IS
		SELECT LDC_TIPO_CONSTRUCCION.*,LDC_TIPO_CONSTRUCCION.rowid
		FROM LDC_TIPO_CONSTRUCCION
		WHERE
		    ID_TIPO_CONSTRUCCION = inuID_TIPO_CONSTRUCCION;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_TIPO_CONSTRUCCION.*,LDC_TIPO_CONSTRUCCION.rowid
		FROM LDC_TIPO_CONSTRUCCION
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_TIPO_CONSTRUCCION  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_TIPO_CONSTRUCCION is table of styLDC_TIPO_CONSTRUCCION index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_TIPO_CONSTRUCCION;

	/* Tipos referenciando al registro */
	type tytbID_TIPO_CONSTRUCCION is table of LDC_TIPO_CONSTRUCCION.ID_TIPO_CONSTRUCCION%type index by binary_integer;
	type tytbDESC_TIPO_CONSTRUCION is table of LDC_TIPO_CONSTRUCCION.DESC_TIPO_CONSTRUCION%type index by binary_integer;
	type tytbDESC_PISOS is table of LDC_TIPO_CONSTRUCCION.DESC_PISOS%type index by binary_integer;
	type tytbDESC_UNIDAD is table of LDC_TIPO_CONSTRUCCION.DESC_UNIDAD%type index by binary_integer;
	type tytbDESC_TORRE is table of LDC_TIPO_CONSTRUCCION.DESC_TORRE%type index by binary_integer;
	type tytbDESC_TIPO_UNIDAD is table of LDC_TIPO_CONSTRUCCION.DESC_TIPO_UNIDAD%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_TIPO_CONSTRUCCION is record
	(
		ID_TIPO_CONSTRUCCION   tytbID_TIPO_CONSTRUCCION,
		DESC_TIPO_CONSTRUCION   tytbDESC_TIPO_CONSTRUCION,
		DESC_PISOS   tytbDESC_PISOS,
		DESC_UNIDAD   tytbDESC_UNIDAD,
		DESC_TORRE   tytbDESC_TORRE,
		DESC_TIPO_UNIDAD   tytbDESC_TIPO_UNIDAD,
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
		inuID_TIPO_CONSTRUCCION in LDC_TIPO_CONSTRUCCION.ID_TIPO_CONSTRUCCION%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuID_TIPO_CONSTRUCCION in LDC_TIPO_CONSTRUCCION.ID_TIPO_CONSTRUCCION%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuID_TIPO_CONSTRUCCION in LDC_TIPO_CONSTRUCCION.ID_TIPO_CONSTRUCCION%type
	);

	PROCEDURE getRecord
	(
		inuID_TIPO_CONSTRUCCION in LDC_TIPO_CONSTRUCCION.ID_TIPO_CONSTRUCCION%type,
		orcRecord out nocopy styLDC_TIPO_CONSTRUCCION
	);

	FUNCTION frcGetRcData
	(
		inuID_TIPO_CONSTRUCCION in LDC_TIPO_CONSTRUCCION.ID_TIPO_CONSTRUCCION%type
	)
	RETURN styLDC_TIPO_CONSTRUCCION;

	FUNCTION frcGetRcData
	RETURN styLDC_TIPO_CONSTRUCCION;

	FUNCTION frcGetRecord
	(
		inuID_TIPO_CONSTRUCCION in LDC_TIPO_CONSTRUCCION.ID_TIPO_CONSTRUCCION%type
	)
	RETURN styLDC_TIPO_CONSTRUCCION;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_TIPO_CONSTRUCCION
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_TIPO_CONSTRUCCION in styLDC_TIPO_CONSTRUCCION
	);

	PROCEDURE insRecord
	(
		ircLDC_TIPO_CONSTRUCCION in styLDC_TIPO_CONSTRUCCION,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_TIPO_CONSTRUCCION in out nocopy tytbLDC_TIPO_CONSTRUCCION
	);

	PROCEDURE delRecord
	(
		inuID_TIPO_CONSTRUCCION in LDC_TIPO_CONSTRUCCION.ID_TIPO_CONSTRUCCION%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_TIPO_CONSTRUCCION in out nocopy tytbLDC_TIPO_CONSTRUCCION,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_TIPO_CONSTRUCCION in styLDC_TIPO_CONSTRUCCION,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_TIPO_CONSTRUCCION in out nocopy tytbLDC_TIPO_CONSTRUCCION,
		inuLock in number default 1
	);

	PROCEDURE updDESC_TIPO_CONSTRUCION
	(
		inuID_TIPO_CONSTRUCCION in LDC_TIPO_CONSTRUCCION.ID_TIPO_CONSTRUCCION%type,
		isbDESC_TIPO_CONSTRUCION$ in LDC_TIPO_CONSTRUCCION.DESC_TIPO_CONSTRUCION%type,
		inuLock in number default 0
	);

	PROCEDURE updDESC_PISOS
	(
		inuID_TIPO_CONSTRUCCION in LDC_TIPO_CONSTRUCCION.ID_TIPO_CONSTRUCCION%type,
		isbDESC_PISOS$ in LDC_TIPO_CONSTRUCCION.DESC_PISOS%type,
		inuLock in number default 0
	);

	PROCEDURE updDESC_UNIDAD
	(
		inuID_TIPO_CONSTRUCCION in LDC_TIPO_CONSTRUCCION.ID_TIPO_CONSTRUCCION%type,
		isbDESC_UNIDAD$ in LDC_TIPO_CONSTRUCCION.DESC_UNIDAD%type,
		inuLock in number default 0
	);

	PROCEDURE updDESC_TORRE
	(
		inuID_TIPO_CONSTRUCCION in LDC_TIPO_CONSTRUCCION.ID_TIPO_CONSTRUCCION%type,
		isbDESC_TORRE$ in LDC_TIPO_CONSTRUCCION.DESC_TORRE%type,
		inuLock in number default 0
	);

	PROCEDURE updDESC_TIPO_UNIDAD
	(
		inuID_TIPO_CONSTRUCCION in LDC_TIPO_CONSTRUCCION.ID_TIPO_CONSTRUCCION%type,
		isbDESC_TIPO_UNIDAD$ in LDC_TIPO_CONSTRUCCION.DESC_TIPO_UNIDAD%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetID_TIPO_CONSTRUCCION
	(
		inuID_TIPO_CONSTRUCCION in LDC_TIPO_CONSTRUCCION.ID_TIPO_CONSTRUCCION%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPO_CONSTRUCCION.ID_TIPO_CONSTRUCCION%type;

	FUNCTION fsbGetDESC_TIPO_CONSTRUCION
	(
		inuID_TIPO_CONSTRUCCION in LDC_TIPO_CONSTRUCCION.ID_TIPO_CONSTRUCCION%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPO_CONSTRUCCION.DESC_TIPO_CONSTRUCION%type;

	FUNCTION fsbGetDESC_PISOS
	(
		inuID_TIPO_CONSTRUCCION in LDC_TIPO_CONSTRUCCION.ID_TIPO_CONSTRUCCION%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPO_CONSTRUCCION.DESC_PISOS%type;

	FUNCTION fsbGetDESC_UNIDAD
	(
		inuID_TIPO_CONSTRUCCION in LDC_TIPO_CONSTRUCCION.ID_TIPO_CONSTRUCCION%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPO_CONSTRUCCION.DESC_UNIDAD%type;

	FUNCTION fsbGetDESC_TORRE
	(
		inuID_TIPO_CONSTRUCCION in LDC_TIPO_CONSTRUCCION.ID_TIPO_CONSTRUCCION%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPO_CONSTRUCCION.DESC_TORRE%type;

	FUNCTION fsbGetDESC_TIPO_UNIDAD
	(
		inuID_TIPO_CONSTRUCCION in LDC_TIPO_CONSTRUCCION.ID_TIPO_CONSTRUCCION%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPO_CONSTRUCCION.DESC_TIPO_UNIDAD%type;


	PROCEDURE LockByPk
	(
		inuID_TIPO_CONSTRUCCION in LDC_TIPO_CONSTRUCCION.ID_TIPO_CONSTRUCCION%type,
		orcLDC_TIPO_CONSTRUCCION  out styLDC_TIPO_CONSTRUCCION
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_TIPO_CONSTRUCCION  out styLDC_TIPO_CONSTRUCCION
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_TIPO_CONSTRUCCION;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALDC_TIPO_CONSTRUCCION
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_TIPO_CONSTRUCCION';
	 cnuGeEntityId constant varchar2(30) := 2856; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuID_TIPO_CONSTRUCCION in LDC_TIPO_CONSTRUCCION.ID_TIPO_CONSTRUCCION%type
	)
	IS
		SELECT LDC_TIPO_CONSTRUCCION.*,LDC_TIPO_CONSTRUCCION.rowid
		FROM LDC_TIPO_CONSTRUCCION
		WHERE  ID_TIPO_CONSTRUCCION = inuID_TIPO_CONSTRUCCION
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_TIPO_CONSTRUCCION.*,LDC_TIPO_CONSTRUCCION.rowid
		FROM LDC_TIPO_CONSTRUCCION
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_TIPO_CONSTRUCCION is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_TIPO_CONSTRUCCION;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_TIPO_CONSTRUCCION default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.ID_TIPO_CONSTRUCCION);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuID_TIPO_CONSTRUCCION in LDC_TIPO_CONSTRUCCION.ID_TIPO_CONSTRUCCION%type,
		orcLDC_TIPO_CONSTRUCCION  out styLDC_TIPO_CONSTRUCCION
	)
	IS
		rcError styLDC_TIPO_CONSTRUCCION;
	BEGIN
		rcError.ID_TIPO_CONSTRUCCION := inuID_TIPO_CONSTRUCCION;

		Open cuLockRcByPk
		(
			inuID_TIPO_CONSTRUCCION
		);

		fetch cuLockRcByPk into orcLDC_TIPO_CONSTRUCCION;
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
		orcLDC_TIPO_CONSTRUCCION  out styLDC_TIPO_CONSTRUCCION
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_TIPO_CONSTRUCCION;
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
		itbLDC_TIPO_CONSTRUCCION  in out nocopy tytbLDC_TIPO_CONSTRUCCION
	)
	IS
	BEGIN
			rcRecOfTab.ID_TIPO_CONSTRUCCION.delete;
			rcRecOfTab.DESC_TIPO_CONSTRUCION.delete;
			rcRecOfTab.DESC_PISOS.delete;
			rcRecOfTab.DESC_UNIDAD.delete;
			rcRecOfTab.DESC_TORRE.delete;
			rcRecOfTab.DESC_TIPO_UNIDAD.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_TIPO_CONSTRUCCION  in out nocopy tytbLDC_TIPO_CONSTRUCCION,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_TIPO_CONSTRUCCION);

		for n in itbLDC_TIPO_CONSTRUCCION.first .. itbLDC_TIPO_CONSTRUCCION.last loop
			rcRecOfTab.ID_TIPO_CONSTRUCCION(n) := itbLDC_TIPO_CONSTRUCCION(n).ID_TIPO_CONSTRUCCION;
			rcRecOfTab.DESC_TIPO_CONSTRUCION(n) := itbLDC_TIPO_CONSTRUCCION(n).DESC_TIPO_CONSTRUCION;
			rcRecOfTab.DESC_PISOS(n) := itbLDC_TIPO_CONSTRUCCION(n).DESC_PISOS;
			rcRecOfTab.DESC_UNIDAD(n) := itbLDC_TIPO_CONSTRUCCION(n).DESC_UNIDAD;
			rcRecOfTab.DESC_TORRE(n) := itbLDC_TIPO_CONSTRUCCION(n).DESC_TORRE;
			rcRecOfTab.DESC_TIPO_UNIDAD(n) := itbLDC_TIPO_CONSTRUCCION(n).DESC_TIPO_UNIDAD;
			rcRecOfTab.row_id(n) := itbLDC_TIPO_CONSTRUCCION(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuID_TIPO_CONSTRUCCION in LDC_TIPO_CONSTRUCCION.ID_TIPO_CONSTRUCCION%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuID_TIPO_CONSTRUCCION
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
		inuID_TIPO_CONSTRUCCION in LDC_TIPO_CONSTRUCCION.ID_TIPO_CONSTRUCCION%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuID_TIPO_CONSTRUCCION = rcData.ID_TIPO_CONSTRUCCION
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
		inuID_TIPO_CONSTRUCCION in LDC_TIPO_CONSTRUCCION.ID_TIPO_CONSTRUCCION%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuID_TIPO_CONSTRUCCION
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuID_TIPO_CONSTRUCCION in LDC_TIPO_CONSTRUCCION.ID_TIPO_CONSTRUCCION%type
	)
	IS
		rcError styLDC_TIPO_CONSTRUCCION;
	BEGIN		rcError.ID_TIPO_CONSTRUCCION:=inuID_TIPO_CONSTRUCCION;

		Load
		(
			inuID_TIPO_CONSTRUCCION
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
		inuID_TIPO_CONSTRUCCION in LDC_TIPO_CONSTRUCCION.ID_TIPO_CONSTRUCCION%type
	)
	IS
	BEGIN
		Load
		(
			inuID_TIPO_CONSTRUCCION
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuID_TIPO_CONSTRUCCION in LDC_TIPO_CONSTRUCCION.ID_TIPO_CONSTRUCCION%type,
		orcRecord out nocopy styLDC_TIPO_CONSTRUCCION
	)
	IS
		rcError styLDC_TIPO_CONSTRUCCION;
	BEGIN		rcError.ID_TIPO_CONSTRUCCION:=inuID_TIPO_CONSTRUCCION;

		Load
		(
			inuID_TIPO_CONSTRUCCION
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuID_TIPO_CONSTRUCCION in LDC_TIPO_CONSTRUCCION.ID_TIPO_CONSTRUCCION%type
	)
	RETURN styLDC_TIPO_CONSTRUCCION
	IS
		rcError styLDC_TIPO_CONSTRUCCION;
	BEGIN
		rcError.ID_TIPO_CONSTRUCCION:=inuID_TIPO_CONSTRUCCION;

		Load
		(
			inuID_TIPO_CONSTRUCCION
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuID_TIPO_CONSTRUCCION in LDC_TIPO_CONSTRUCCION.ID_TIPO_CONSTRUCCION%type
	)
	RETURN styLDC_TIPO_CONSTRUCCION
	IS
		rcError styLDC_TIPO_CONSTRUCCION;
	BEGIN
		rcError.ID_TIPO_CONSTRUCCION:=inuID_TIPO_CONSTRUCCION;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuID_TIPO_CONSTRUCCION
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuID_TIPO_CONSTRUCCION
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_TIPO_CONSTRUCCION
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_TIPO_CONSTRUCCION
	)
	IS
		rfLDC_TIPO_CONSTRUCCION tyrfLDC_TIPO_CONSTRUCCION;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_TIPO_CONSTRUCCION.*, LDC_TIPO_CONSTRUCCION.rowid FROM LDC_TIPO_CONSTRUCCION';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_TIPO_CONSTRUCCION for sbFullQuery;

		fetch rfLDC_TIPO_CONSTRUCCION bulk collect INTO otbResult;

		close rfLDC_TIPO_CONSTRUCCION;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_TIPO_CONSTRUCCION.*, LDC_TIPO_CONSTRUCCION.rowid FROM LDC_TIPO_CONSTRUCCION';
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
		ircLDC_TIPO_CONSTRUCCION in styLDC_TIPO_CONSTRUCCION
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_TIPO_CONSTRUCCION,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_TIPO_CONSTRUCCION in styLDC_TIPO_CONSTRUCCION,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_TIPO_CONSTRUCCION.ID_TIPO_CONSTRUCCION is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ID_TIPO_CONSTRUCCION');
			raise ex.controlled_error;
		end if;

		insert into LDC_TIPO_CONSTRUCCION
		(
			ID_TIPO_CONSTRUCCION,
			DESC_TIPO_CONSTRUCION,
			DESC_PISOS,
			DESC_UNIDAD,
			DESC_TORRE,
			DESC_TIPO_UNIDAD
		)
		values
		(
			ircLDC_TIPO_CONSTRUCCION.ID_TIPO_CONSTRUCCION,
			ircLDC_TIPO_CONSTRUCCION.DESC_TIPO_CONSTRUCION,
			ircLDC_TIPO_CONSTRUCCION.DESC_PISOS,
			ircLDC_TIPO_CONSTRUCCION.DESC_UNIDAD,
			ircLDC_TIPO_CONSTRUCCION.DESC_TORRE,
			ircLDC_TIPO_CONSTRUCCION.DESC_TIPO_UNIDAD
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_TIPO_CONSTRUCCION));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_TIPO_CONSTRUCCION in out nocopy tytbLDC_TIPO_CONSTRUCCION
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_TIPO_CONSTRUCCION,blUseRowID);
		forall n in iotbLDC_TIPO_CONSTRUCCION.first..iotbLDC_TIPO_CONSTRUCCION.last
			insert into LDC_TIPO_CONSTRUCCION
			(
				ID_TIPO_CONSTRUCCION,
				DESC_TIPO_CONSTRUCION,
				DESC_PISOS,
				DESC_UNIDAD,
				DESC_TORRE,
				DESC_TIPO_UNIDAD
			)
			values
			(
				rcRecOfTab.ID_TIPO_CONSTRUCCION(n),
				rcRecOfTab.DESC_TIPO_CONSTRUCION(n),
				rcRecOfTab.DESC_PISOS(n),
				rcRecOfTab.DESC_UNIDAD(n),
				rcRecOfTab.DESC_TORRE(n),
				rcRecOfTab.DESC_TIPO_UNIDAD(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuID_TIPO_CONSTRUCCION in LDC_TIPO_CONSTRUCCION.ID_TIPO_CONSTRUCCION%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_TIPO_CONSTRUCCION;
	BEGIN
		rcError.ID_TIPO_CONSTRUCCION := inuID_TIPO_CONSTRUCCION;

		if inuLock=1 then
			LockByPk
			(
				inuID_TIPO_CONSTRUCCION,
				rcData
			);
		end if;


		delete
		from LDC_TIPO_CONSTRUCCION
		where
       		ID_TIPO_CONSTRUCCION=inuID_TIPO_CONSTRUCCION;
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
		rcError  styLDC_TIPO_CONSTRUCCION;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_TIPO_CONSTRUCCION
		where
			rowid = iriRowID
		returning
			ID_TIPO_CONSTRUCCION
		into
			rcError.ID_TIPO_CONSTRUCCION;
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
		iotbLDC_TIPO_CONSTRUCCION in out nocopy tytbLDC_TIPO_CONSTRUCCION,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_TIPO_CONSTRUCCION;
	BEGIN
		FillRecordOfTables(iotbLDC_TIPO_CONSTRUCCION, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_TIPO_CONSTRUCCION.first .. iotbLDC_TIPO_CONSTRUCCION.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_TIPO_CONSTRUCCION.first .. iotbLDC_TIPO_CONSTRUCCION.last
				delete
				from LDC_TIPO_CONSTRUCCION
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_TIPO_CONSTRUCCION.first .. iotbLDC_TIPO_CONSTRUCCION.last loop
					LockByPk
					(
						rcRecOfTab.ID_TIPO_CONSTRUCCION(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_TIPO_CONSTRUCCION.first .. iotbLDC_TIPO_CONSTRUCCION.last
				delete
				from LDC_TIPO_CONSTRUCCION
				where
		         	ID_TIPO_CONSTRUCCION = rcRecOfTab.ID_TIPO_CONSTRUCCION(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_TIPO_CONSTRUCCION in styLDC_TIPO_CONSTRUCCION,
		inuLock in number default 0
	)
	IS
		nuID_TIPO_CONSTRUCCION	LDC_TIPO_CONSTRUCCION.ID_TIPO_CONSTRUCCION%type;
	BEGIN
		if ircLDC_TIPO_CONSTRUCCION.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_TIPO_CONSTRUCCION.rowid,rcData);
			end if;
			update LDC_TIPO_CONSTRUCCION
			set
				DESC_TIPO_CONSTRUCION = ircLDC_TIPO_CONSTRUCCION.DESC_TIPO_CONSTRUCION,
				DESC_PISOS = ircLDC_TIPO_CONSTRUCCION.DESC_PISOS,
				DESC_UNIDAD = ircLDC_TIPO_CONSTRUCCION.DESC_UNIDAD,
				DESC_TORRE = ircLDC_TIPO_CONSTRUCCION.DESC_TORRE,
				DESC_TIPO_UNIDAD = ircLDC_TIPO_CONSTRUCCION.DESC_TIPO_UNIDAD
			where
				rowid = ircLDC_TIPO_CONSTRUCCION.rowid
			returning
				ID_TIPO_CONSTRUCCION
			into
				nuID_TIPO_CONSTRUCCION;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_TIPO_CONSTRUCCION.ID_TIPO_CONSTRUCCION,
					rcData
				);
			end if;

			update LDC_TIPO_CONSTRUCCION
			set
				DESC_TIPO_CONSTRUCION = ircLDC_TIPO_CONSTRUCCION.DESC_TIPO_CONSTRUCION,
				DESC_PISOS = ircLDC_TIPO_CONSTRUCCION.DESC_PISOS,
				DESC_UNIDAD = ircLDC_TIPO_CONSTRUCCION.DESC_UNIDAD,
				DESC_TORRE = ircLDC_TIPO_CONSTRUCCION.DESC_TORRE,
				DESC_TIPO_UNIDAD = ircLDC_TIPO_CONSTRUCCION.DESC_TIPO_UNIDAD
			where
				ID_TIPO_CONSTRUCCION = ircLDC_TIPO_CONSTRUCCION.ID_TIPO_CONSTRUCCION
			returning
				ID_TIPO_CONSTRUCCION
			into
				nuID_TIPO_CONSTRUCCION;
		end if;
		if
			nuID_TIPO_CONSTRUCCION is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_TIPO_CONSTRUCCION));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_TIPO_CONSTRUCCION in out nocopy tytbLDC_TIPO_CONSTRUCCION,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_TIPO_CONSTRUCCION;
	BEGIN
		FillRecordOfTables(iotbLDC_TIPO_CONSTRUCCION,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_TIPO_CONSTRUCCION.first .. iotbLDC_TIPO_CONSTRUCCION.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_TIPO_CONSTRUCCION.first .. iotbLDC_TIPO_CONSTRUCCION.last
				update LDC_TIPO_CONSTRUCCION
				set
					DESC_TIPO_CONSTRUCION = rcRecOfTab.DESC_TIPO_CONSTRUCION(n),
					DESC_PISOS = rcRecOfTab.DESC_PISOS(n),
					DESC_UNIDAD = rcRecOfTab.DESC_UNIDAD(n),
					DESC_TORRE = rcRecOfTab.DESC_TORRE(n),
					DESC_TIPO_UNIDAD = rcRecOfTab.DESC_TIPO_UNIDAD(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_TIPO_CONSTRUCCION.first .. iotbLDC_TIPO_CONSTRUCCION.last loop
					LockByPk
					(
						rcRecOfTab.ID_TIPO_CONSTRUCCION(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_TIPO_CONSTRUCCION.first .. iotbLDC_TIPO_CONSTRUCCION.last
				update LDC_TIPO_CONSTRUCCION
				SET
					DESC_TIPO_CONSTRUCION = rcRecOfTab.DESC_TIPO_CONSTRUCION(n),
					DESC_PISOS = rcRecOfTab.DESC_PISOS(n),
					DESC_UNIDAD = rcRecOfTab.DESC_UNIDAD(n),
					DESC_TORRE = rcRecOfTab.DESC_TORRE(n),
					DESC_TIPO_UNIDAD = rcRecOfTab.DESC_TIPO_UNIDAD(n)
				where
					ID_TIPO_CONSTRUCCION = rcRecOfTab.ID_TIPO_CONSTRUCCION(n)
;
		end if;
	END;
	PROCEDURE updDESC_TIPO_CONSTRUCION
	(
		inuID_TIPO_CONSTRUCCION in LDC_TIPO_CONSTRUCCION.ID_TIPO_CONSTRUCCION%type,
		isbDESC_TIPO_CONSTRUCION$ in LDC_TIPO_CONSTRUCCION.DESC_TIPO_CONSTRUCION%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_TIPO_CONSTRUCCION;
	BEGIN
		rcError.ID_TIPO_CONSTRUCCION := inuID_TIPO_CONSTRUCCION;
		if inuLock=1 then
			LockByPk
			(
				inuID_TIPO_CONSTRUCCION,
				rcData
			);
		end if;

		update LDC_TIPO_CONSTRUCCION
		set
			DESC_TIPO_CONSTRUCION = isbDESC_TIPO_CONSTRUCION$
		where
			ID_TIPO_CONSTRUCCION = inuID_TIPO_CONSTRUCCION;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DESC_TIPO_CONSTRUCION:= isbDESC_TIPO_CONSTRUCION$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updDESC_PISOS
	(
		inuID_TIPO_CONSTRUCCION in LDC_TIPO_CONSTRUCCION.ID_TIPO_CONSTRUCCION%type,
		isbDESC_PISOS$ in LDC_TIPO_CONSTRUCCION.DESC_PISOS%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_TIPO_CONSTRUCCION;
	BEGIN
		rcError.ID_TIPO_CONSTRUCCION := inuID_TIPO_CONSTRUCCION;
		if inuLock=1 then
			LockByPk
			(
				inuID_TIPO_CONSTRUCCION,
				rcData
			);
		end if;

		update LDC_TIPO_CONSTRUCCION
		set
			DESC_PISOS = isbDESC_PISOS$
		where
			ID_TIPO_CONSTRUCCION = inuID_TIPO_CONSTRUCCION;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DESC_PISOS:= isbDESC_PISOS$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updDESC_UNIDAD
	(
		inuID_TIPO_CONSTRUCCION in LDC_TIPO_CONSTRUCCION.ID_TIPO_CONSTRUCCION%type,
		isbDESC_UNIDAD$ in LDC_TIPO_CONSTRUCCION.DESC_UNIDAD%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_TIPO_CONSTRUCCION;
	BEGIN
		rcError.ID_TIPO_CONSTRUCCION := inuID_TIPO_CONSTRUCCION;
		if inuLock=1 then
			LockByPk
			(
				inuID_TIPO_CONSTRUCCION,
				rcData
			);
		end if;

		update LDC_TIPO_CONSTRUCCION
		set
			DESC_UNIDAD = isbDESC_UNIDAD$
		where
			ID_TIPO_CONSTRUCCION = inuID_TIPO_CONSTRUCCION;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DESC_UNIDAD:= isbDESC_UNIDAD$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updDESC_TORRE
	(
		inuID_TIPO_CONSTRUCCION in LDC_TIPO_CONSTRUCCION.ID_TIPO_CONSTRUCCION%type,
		isbDESC_TORRE$ in LDC_TIPO_CONSTRUCCION.DESC_TORRE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_TIPO_CONSTRUCCION;
	BEGIN
		rcError.ID_TIPO_CONSTRUCCION := inuID_TIPO_CONSTRUCCION;
		if inuLock=1 then
			LockByPk
			(
				inuID_TIPO_CONSTRUCCION,
				rcData
			);
		end if;

		update LDC_TIPO_CONSTRUCCION
		set
			DESC_TORRE = isbDESC_TORRE$
		where
			ID_TIPO_CONSTRUCCION = inuID_TIPO_CONSTRUCCION;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DESC_TORRE:= isbDESC_TORRE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updDESC_TIPO_UNIDAD
	(
		inuID_TIPO_CONSTRUCCION in LDC_TIPO_CONSTRUCCION.ID_TIPO_CONSTRUCCION%type,
		isbDESC_TIPO_UNIDAD$ in LDC_TIPO_CONSTRUCCION.DESC_TIPO_UNIDAD%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_TIPO_CONSTRUCCION;
	BEGIN
		rcError.ID_TIPO_CONSTRUCCION := inuID_TIPO_CONSTRUCCION;
		if inuLock=1 then
			LockByPk
			(
				inuID_TIPO_CONSTRUCCION,
				rcData
			);
		end if;

		update LDC_TIPO_CONSTRUCCION
		set
			DESC_TIPO_UNIDAD = isbDESC_TIPO_UNIDAD$
		where
			ID_TIPO_CONSTRUCCION = inuID_TIPO_CONSTRUCCION;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DESC_TIPO_UNIDAD:= isbDESC_TIPO_UNIDAD$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetID_TIPO_CONSTRUCCION
	(
		inuID_TIPO_CONSTRUCCION in LDC_TIPO_CONSTRUCCION.ID_TIPO_CONSTRUCCION%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPO_CONSTRUCCION.ID_TIPO_CONSTRUCCION%type
	IS
		rcError styLDC_TIPO_CONSTRUCCION;
	BEGIN

		rcError.ID_TIPO_CONSTRUCCION := inuID_TIPO_CONSTRUCCION;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_TIPO_CONSTRUCCION
			 )
		then
			 return(rcData.ID_TIPO_CONSTRUCCION);
		end if;
		Load
		(
		 		inuID_TIPO_CONSTRUCCION
		);
		return(rcData.ID_TIPO_CONSTRUCCION);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetDESC_TIPO_CONSTRUCION
	(
		inuID_TIPO_CONSTRUCCION in LDC_TIPO_CONSTRUCCION.ID_TIPO_CONSTRUCCION%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPO_CONSTRUCCION.DESC_TIPO_CONSTRUCION%type
	IS
		rcError styLDC_TIPO_CONSTRUCCION;
	BEGIN

		rcError.ID_TIPO_CONSTRUCCION := inuID_TIPO_CONSTRUCCION;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_TIPO_CONSTRUCCION
			 )
		then
			 return(rcData.DESC_TIPO_CONSTRUCION);
		end if;
		Load
		(
		 		inuID_TIPO_CONSTRUCCION
		);
		return(rcData.DESC_TIPO_CONSTRUCION);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetDESC_PISOS
	(
		inuID_TIPO_CONSTRUCCION in LDC_TIPO_CONSTRUCCION.ID_TIPO_CONSTRUCCION%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPO_CONSTRUCCION.DESC_PISOS%type
	IS
		rcError styLDC_TIPO_CONSTRUCCION;
	BEGIN

		rcError.ID_TIPO_CONSTRUCCION := inuID_TIPO_CONSTRUCCION;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_TIPO_CONSTRUCCION
			 )
		then
			 return(rcData.DESC_PISOS);
		end if;
		Load
		(
		 		inuID_TIPO_CONSTRUCCION
		);
		return(rcData.DESC_PISOS);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetDESC_UNIDAD
	(
		inuID_TIPO_CONSTRUCCION in LDC_TIPO_CONSTRUCCION.ID_TIPO_CONSTRUCCION%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPO_CONSTRUCCION.DESC_UNIDAD%type
	IS
		rcError styLDC_TIPO_CONSTRUCCION;
	BEGIN

		rcError.ID_TIPO_CONSTRUCCION := inuID_TIPO_CONSTRUCCION;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_TIPO_CONSTRUCCION
			 )
		then
			 return(rcData.DESC_UNIDAD);
		end if;
		Load
		(
		 		inuID_TIPO_CONSTRUCCION
		);
		return(rcData.DESC_UNIDAD);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetDESC_TORRE
	(
		inuID_TIPO_CONSTRUCCION in LDC_TIPO_CONSTRUCCION.ID_TIPO_CONSTRUCCION%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPO_CONSTRUCCION.DESC_TORRE%type
	IS
		rcError styLDC_TIPO_CONSTRUCCION;
	BEGIN

		rcError.ID_TIPO_CONSTRUCCION := inuID_TIPO_CONSTRUCCION;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_TIPO_CONSTRUCCION
			 )
		then
			 return(rcData.DESC_TORRE);
		end if;
		Load
		(
		 		inuID_TIPO_CONSTRUCCION
		);
		return(rcData.DESC_TORRE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetDESC_TIPO_UNIDAD
	(
		inuID_TIPO_CONSTRUCCION in LDC_TIPO_CONSTRUCCION.ID_TIPO_CONSTRUCCION%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPO_CONSTRUCCION.DESC_TIPO_UNIDAD%type
	IS
		rcError styLDC_TIPO_CONSTRUCCION;
	BEGIN

		rcError.ID_TIPO_CONSTRUCCION := inuID_TIPO_CONSTRUCCION;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_TIPO_CONSTRUCCION
			 )
		then
			 return(rcData.DESC_TIPO_UNIDAD);
		end if;
		Load
		(
		 		inuID_TIPO_CONSTRUCCION
		);
		return(rcData.DESC_TIPO_UNIDAD);
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
end DALDC_TIPO_CONSTRUCCION;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALDC_TIPO_CONSTRUCCION
BEGIN
    pkg_utilidades.prAplicarPermisos('DALDC_TIPO_CONSTRUCCION', 'ADM_PERSON'); 
END;
/  