CREATE OR REPLACE PACKAGE ADM_PERSON.DALDC_METRAJE_PISO
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
    05/06/2024              PAcosta         OSF-2777: Cambio de esquema ADM_PERSON                              
    ****************************************************************/  
    
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuID_PISO in LDC_METRAJE_PISO.ID_PISO%type,
		inuID_PROYECTO in LDC_METRAJE_PISO.ID_PROYECTO%type
	)
	IS
		SELECT LDC_METRAJE_PISO.*,LDC_METRAJE_PISO.rowid
		FROM LDC_METRAJE_PISO
		WHERE
		    ID_PISO = inuID_PISO
		    and ID_PROYECTO = inuID_PROYECTO;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_METRAJE_PISO.*,LDC_METRAJE_PISO.rowid
		FROM LDC_METRAJE_PISO
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_METRAJE_PISO  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_METRAJE_PISO is table of styLDC_METRAJE_PISO index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_METRAJE_PISO;

	/* Tipos referenciando al registro */
	type tytbID_PISO is table of LDC_METRAJE_PISO.ID_PISO%type index by binary_integer;
	type tytbID_PROYECTO is table of LDC_METRAJE_PISO.ID_PROYECTO%type index by binary_integer;
	type tytbLONG_BAJANTE is table of LDC_METRAJE_PISO.LONG_BAJANTE%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_METRAJE_PISO is record
	(
		ID_PISO   tytbID_PISO,
		ID_PROYECTO   tytbID_PROYECTO,
		LONG_BAJANTE   tytbLONG_BAJANTE,
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
		inuID_PISO in LDC_METRAJE_PISO.ID_PISO%type,
		inuID_PROYECTO in LDC_METRAJE_PISO.ID_PROYECTO%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuID_PISO in LDC_METRAJE_PISO.ID_PISO%type,
		inuID_PROYECTO in LDC_METRAJE_PISO.ID_PROYECTO%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuID_PISO in LDC_METRAJE_PISO.ID_PISO%type,
		inuID_PROYECTO in LDC_METRAJE_PISO.ID_PROYECTO%type
	);

	PROCEDURE getRecord
	(
		inuID_PISO in LDC_METRAJE_PISO.ID_PISO%type,
		inuID_PROYECTO in LDC_METRAJE_PISO.ID_PROYECTO%type,
		orcRecord out nocopy styLDC_METRAJE_PISO
	);

	FUNCTION frcGetRcData
	(
		inuID_PISO in LDC_METRAJE_PISO.ID_PISO%type,
		inuID_PROYECTO in LDC_METRAJE_PISO.ID_PROYECTO%type
	)
	RETURN styLDC_METRAJE_PISO;

	FUNCTION frcGetRcData
	RETURN styLDC_METRAJE_PISO;

	FUNCTION frcGetRecord
	(
		inuID_PISO in LDC_METRAJE_PISO.ID_PISO%type,
		inuID_PROYECTO in LDC_METRAJE_PISO.ID_PROYECTO%type
	)
	RETURN styLDC_METRAJE_PISO;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_METRAJE_PISO
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_METRAJE_PISO in styLDC_METRAJE_PISO
	);

	PROCEDURE insRecord
	(
		ircLDC_METRAJE_PISO in styLDC_METRAJE_PISO,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_METRAJE_PISO in out nocopy tytbLDC_METRAJE_PISO
	);

	PROCEDURE delRecord
	(
		inuID_PISO in LDC_METRAJE_PISO.ID_PISO%type,
		inuID_PROYECTO in LDC_METRAJE_PISO.ID_PROYECTO%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_METRAJE_PISO in out nocopy tytbLDC_METRAJE_PISO,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_METRAJE_PISO in styLDC_METRAJE_PISO,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_METRAJE_PISO in out nocopy tytbLDC_METRAJE_PISO,
		inuLock in number default 1
	);

	PROCEDURE updLONG_BAJANTE
	(
		inuID_PISO in LDC_METRAJE_PISO.ID_PISO%type,
		inuID_PROYECTO in LDC_METRAJE_PISO.ID_PROYECTO%type,
		inuLONG_BAJANTE$ in LDC_METRAJE_PISO.LONG_BAJANTE%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetID_PISO
	(
		inuID_PISO in LDC_METRAJE_PISO.ID_PISO%type,
		inuID_PROYECTO in LDC_METRAJE_PISO.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_METRAJE_PISO.ID_PISO%type;

	FUNCTION fnuGetID_PROYECTO
	(
		inuID_PISO in LDC_METRAJE_PISO.ID_PISO%type,
		inuID_PROYECTO in LDC_METRAJE_PISO.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_METRAJE_PISO.ID_PROYECTO%type;

	FUNCTION fnuGetLONG_BAJANTE
	(
		inuID_PISO in LDC_METRAJE_PISO.ID_PISO%type,
		inuID_PROYECTO in LDC_METRAJE_PISO.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_METRAJE_PISO.LONG_BAJANTE%type;


	PROCEDURE LockByPk
	(
		inuID_PISO in LDC_METRAJE_PISO.ID_PISO%type,
		inuID_PROYECTO in LDC_METRAJE_PISO.ID_PROYECTO%type,
		orcLDC_METRAJE_PISO  out styLDC_METRAJE_PISO
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_METRAJE_PISO  out styLDC_METRAJE_PISO
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_METRAJE_PISO;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALDC_METRAJE_PISO
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_METRAJE_PISO';
	 cnuGeEntityId constant varchar2(30) := 2861; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuID_PISO in LDC_METRAJE_PISO.ID_PISO%type,
		inuID_PROYECTO in LDC_METRAJE_PISO.ID_PROYECTO%type
	)
	IS
		SELECT LDC_METRAJE_PISO.*,LDC_METRAJE_PISO.rowid
		FROM LDC_METRAJE_PISO
		WHERE  ID_PISO = inuID_PISO
			and ID_PROYECTO = inuID_PROYECTO
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_METRAJE_PISO.*,LDC_METRAJE_PISO.rowid
		FROM LDC_METRAJE_PISO
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_METRAJE_PISO is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_METRAJE_PISO;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_METRAJE_PISO default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.ID_PISO);
		sbPk:=sbPk||','||ut_convert.fsbToChar(rcI.ID_PROYECTO);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuID_PISO in LDC_METRAJE_PISO.ID_PISO%type,
		inuID_PROYECTO in LDC_METRAJE_PISO.ID_PROYECTO%type,
		orcLDC_METRAJE_PISO  out styLDC_METRAJE_PISO
	)
	IS
		rcError styLDC_METRAJE_PISO;
	BEGIN
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_PROYECTO := inuID_PROYECTO;

		Open cuLockRcByPk
		(
			inuID_PISO,
			inuID_PROYECTO
		);

		fetch cuLockRcByPk into orcLDC_METRAJE_PISO;
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
		orcLDC_METRAJE_PISO  out styLDC_METRAJE_PISO
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_METRAJE_PISO;
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
		itbLDC_METRAJE_PISO  in out nocopy tytbLDC_METRAJE_PISO
	)
	IS
	BEGIN
			rcRecOfTab.ID_PISO.delete;
			rcRecOfTab.ID_PROYECTO.delete;
			rcRecOfTab.LONG_BAJANTE.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_METRAJE_PISO  in out nocopy tytbLDC_METRAJE_PISO,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_METRAJE_PISO);

		for n in itbLDC_METRAJE_PISO.first .. itbLDC_METRAJE_PISO.last loop
			rcRecOfTab.ID_PISO(n) := itbLDC_METRAJE_PISO(n).ID_PISO;
			rcRecOfTab.ID_PROYECTO(n) := itbLDC_METRAJE_PISO(n).ID_PROYECTO;
			rcRecOfTab.LONG_BAJANTE(n) := itbLDC_METRAJE_PISO(n).LONG_BAJANTE;
			rcRecOfTab.row_id(n) := itbLDC_METRAJE_PISO(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuID_PISO in LDC_METRAJE_PISO.ID_PISO%type,
		inuID_PROYECTO in LDC_METRAJE_PISO.ID_PROYECTO%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuID_PISO,
			inuID_PROYECTO
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
		inuID_PISO in LDC_METRAJE_PISO.ID_PISO%type,
		inuID_PROYECTO in LDC_METRAJE_PISO.ID_PROYECTO%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuID_PISO = rcData.ID_PISO AND
			inuID_PROYECTO = rcData.ID_PROYECTO
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
		inuID_PISO in LDC_METRAJE_PISO.ID_PISO%type,
		inuID_PROYECTO in LDC_METRAJE_PISO.ID_PROYECTO%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuID_PISO,
			inuID_PROYECTO
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuID_PISO in LDC_METRAJE_PISO.ID_PISO%type,
		inuID_PROYECTO in LDC_METRAJE_PISO.ID_PROYECTO%type
	)
	IS
		rcError styLDC_METRAJE_PISO;
	BEGIN		rcError.ID_PISO:=inuID_PISO;		rcError.ID_PROYECTO:=inuID_PROYECTO;

		Load
		(
			inuID_PISO,
			inuID_PROYECTO
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
		inuID_PISO in LDC_METRAJE_PISO.ID_PISO%type,
		inuID_PROYECTO in LDC_METRAJE_PISO.ID_PROYECTO%type
	)
	IS
	BEGIN
		Load
		(
			inuID_PISO,
			inuID_PROYECTO
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuID_PISO in LDC_METRAJE_PISO.ID_PISO%type,
		inuID_PROYECTO in LDC_METRAJE_PISO.ID_PROYECTO%type,
		orcRecord out nocopy styLDC_METRAJE_PISO
	)
	IS
		rcError styLDC_METRAJE_PISO;
	BEGIN		rcError.ID_PISO:=inuID_PISO;		rcError.ID_PROYECTO:=inuID_PROYECTO;

		Load
		(
			inuID_PISO,
			inuID_PROYECTO
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuID_PISO in LDC_METRAJE_PISO.ID_PISO%type,
		inuID_PROYECTO in LDC_METRAJE_PISO.ID_PROYECTO%type
	)
	RETURN styLDC_METRAJE_PISO
	IS
		rcError styLDC_METRAJE_PISO;
	BEGIN
		rcError.ID_PISO:=inuID_PISO;
		rcError.ID_PROYECTO:=inuID_PROYECTO;

		Load
		(
			inuID_PISO,
			inuID_PROYECTO
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuID_PISO in LDC_METRAJE_PISO.ID_PISO%type,
		inuID_PROYECTO in LDC_METRAJE_PISO.ID_PROYECTO%type
	)
	RETURN styLDC_METRAJE_PISO
	IS
		rcError styLDC_METRAJE_PISO;
	BEGIN
		rcError.ID_PISO:=inuID_PISO;
		rcError.ID_PROYECTO:=inuID_PROYECTO;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuID_PISO,
			inuID_PROYECTO
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuID_PISO,
			inuID_PROYECTO
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_METRAJE_PISO
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_METRAJE_PISO
	)
	IS
		rfLDC_METRAJE_PISO tyrfLDC_METRAJE_PISO;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_METRAJE_PISO.*, LDC_METRAJE_PISO.rowid FROM LDC_METRAJE_PISO';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_METRAJE_PISO for sbFullQuery;

		fetch rfLDC_METRAJE_PISO bulk collect INTO otbResult;

		close rfLDC_METRAJE_PISO;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_METRAJE_PISO.*, LDC_METRAJE_PISO.rowid FROM LDC_METRAJE_PISO';
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
		ircLDC_METRAJE_PISO in styLDC_METRAJE_PISO
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_METRAJE_PISO,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_METRAJE_PISO in styLDC_METRAJE_PISO,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_METRAJE_PISO.ID_PISO is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ID_PISO');
			raise ex.controlled_error;
		end if;
		if ircLDC_METRAJE_PISO.ID_PROYECTO is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ID_PROYECTO');
			raise ex.controlled_error;
		end if;

		insert into LDC_METRAJE_PISO
		(
			ID_PISO,
			ID_PROYECTO,
			LONG_BAJANTE
		)
		values
		(
			ircLDC_METRAJE_PISO.ID_PISO,
			ircLDC_METRAJE_PISO.ID_PROYECTO,
			ircLDC_METRAJE_PISO.LONG_BAJANTE
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_METRAJE_PISO));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_METRAJE_PISO in out nocopy tytbLDC_METRAJE_PISO
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_METRAJE_PISO,blUseRowID);
		forall n in iotbLDC_METRAJE_PISO.first..iotbLDC_METRAJE_PISO.last
			insert into LDC_METRAJE_PISO
			(
				ID_PISO,
				ID_PROYECTO,
				LONG_BAJANTE
			)
			values
			(
				rcRecOfTab.ID_PISO(n),
				rcRecOfTab.ID_PROYECTO(n),
				rcRecOfTab.LONG_BAJANTE(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuID_PISO in LDC_METRAJE_PISO.ID_PISO%type,
		inuID_PROYECTO in LDC_METRAJE_PISO.ID_PROYECTO%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_METRAJE_PISO;
	BEGIN
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_PROYECTO := inuID_PROYECTO;

		if inuLock=1 then
			LockByPk
			(
				inuID_PISO,
				inuID_PROYECTO,
				rcData
			);
		end if;


		delete
		from LDC_METRAJE_PISO
		where
       		ID_PISO=inuID_PISO and
       		ID_PROYECTO=inuID_PROYECTO;
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
		rcError  styLDC_METRAJE_PISO;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_METRAJE_PISO
		where
			rowid = iriRowID
		returning
			ID_PISO,
			ID_PROYECTO
		into
			rcError.ID_PISO,
			rcError.ID_PROYECTO;
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
		iotbLDC_METRAJE_PISO in out nocopy tytbLDC_METRAJE_PISO,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_METRAJE_PISO;
	BEGIN
		FillRecordOfTables(iotbLDC_METRAJE_PISO, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_METRAJE_PISO.first .. iotbLDC_METRAJE_PISO.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_METRAJE_PISO.first .. iotbLDC_METRAJE_PISO.last
				delete
				from LDC_METRAJE_PISO
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_METRAJE_PISO.first .. iotbLDC_METRAJE_PISO.last loop
					LockByPk
					(
						rcRecOfTab.ID_PISO(n),
						rcRecOfTab.ID_PROYECTO(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_METRAJE_PISO.first .. iotbLDC_METRAJE_PISO.last
				delete
				from LDC_METRAJE_PISO
				where
		         	ID_PISO = rcRecOfTab.ID_PISO(n) and
		         	ID_PROYECTO = rcRecOfTab.ID_PROYECTO(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_METRAJE_PISO in styLDC_METRAJE_PISO,
		inuLock in number default 0
	)
	IS
		nuID_PISO	LDC_METRAJE_PISO.ID_PISO%type;
		nuID_PROYECTO	LDC_METRAJE_PISO.ID_PROYECTO%type;
	BEGIN
		if ircLDC_METRAJE_PISO.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_METRAJE_PISO.rowid,rcData);
			end if;
			update LDC_METRAJE_PISO
			set
				LONG_BAJANTE = ircLDC_METRAJE_PISO.LONG_BAJANTE
			where
				rowid = ircLDC_METRAJE_PISO.rowid
			returning
				ID_PISO,
				ID_PROYECTO
			into
				nuID_PISO,
				nuID_PROYECTO;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_METRAJE_PISO.ID_PISO,
					ircLDC_METRAJE_PISO.ID_PROYECTO,
					rcData
				);
			end if;

			update LDC_METRAJE_PISO
			set
				LONG_BAJANTE = ircLDC_METRAJE_PISO.LONG_BAJANTE
			where
				ID_PISO = ircLDC_METRAJE_PISO.ID_PISO and
				ID_PROYECTO = ircLDC_METRAJE_PISO.ID_PROYECTO
			returning
				ID_PISO,
				ID_PROYECTO
			into
				nuID_PISO,
				nuID_PROYECTO;
		end if;
		if
			nuID_PISO is NULL OR
			nuID_PROYECTO is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_METRAJE_PISO));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_METRAJE_PISO in out nocopy tytbLDC_METRAJE_PISO,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_METRAJE_PISO;
	BEGIN
		FillRecordOfTables(iotbLDC_METRAJE_PISO,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_METRAJE_PISO.first .. iotbLDC_METRAJE_PISO.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_METRAJE_PISO.first .. iotbLDC_METRAJE_PISO.last
				update LDC_METRAJE_PISO
				set
					LONG_BAJANTE = rcRecOfTab.LONG_BAJANTE(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_METRAJE_PISO.first .. iotbLDC_METRAJE_PISO.last loop
					LockByPk
					(
						rcRecOfTab.ID_PISO(n),
						rcRecOfTab.ID_PROYECTO(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_METRAJE_PISO.first .. iotbLDC_METRAJE_PISO.last
				update LDC_METRAJE_PISO
				SET
					LONG_BAJANTE = rcRecOfTab.LONG_BAJANTE(n)
				where
					ID_PISO = rcRecOfTab.ID_PISO(n) and
					ID_PROYECTO = rcRecOfTab.ID_PROYECTO(n)
;
		end if;
	END;
	PROCEDURE updLONG_BAJANTE
	(
		inuID_PISO in LDC_METRAJE_PISO.ID_PISO%type,
		inuID_PROYECTO in LDC_METRAJE_PISO.ID_PROYECTO%type,
		inuLONG_BAJANTE$ in LDC_METRAJE_PISO.LONG_BAJANTE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_METRAJE_PISO;
	BEGIN
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		if inuLock=1 then
			LockByPk
			(
				inuID_PISO,
				inuID_PROYECTO,
				rcData
			);
		end if;

		update LDC_METRAJE_PISO
		set
			LONG_BAJANTE = inuLONG_BAJANTE$
		where
			ID_PISO = inuID_PISO and
			ID_PROYECTO = inuID_PROYECTO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.LONG_BAJANTE:= inuLONG_BAJANTE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetID_PISO
	(
		inuID_PISO in LDC_METRAJE_PISO.ID_PISO%type,
		inuID_PROYECTO in LDC_METRAJE_PISO.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_METRAJE_PISO.ID_PISO%type
	IS
		rcError styLDC_METRAJE_PISO;
	BEGIN

		rcError.ID_PISO := inuID_PISO;
		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PISO,
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.ID_PISO);
		end if;
		Load
		(
		 		inuID_PISO,
		 		inuID_PROYECTO
		);
		return(rcData.ID_PISO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetID_PROYECTO
	(
		inuID_PISO in LDC_METRAJE_PISO.ID_PISO%type,
		inuID_PROYECTO in LDC_METRAJE_PISO.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_METRAJE_PISO.ID_PROYECTO%type
	IS
		rcError styLDC_METRAJE_PISO;
	BEGIN

		rcError.ID_PISO := inuID_PISO;
		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PISO,
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.ID_PROYECTO);
		end if;
		Load
		(
		 		inuID_PISO,
		 		inuID_PROYECTO
		);
		return(rcData.ID_PROYECTO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetLONG_BAJANTE
	(
		inuID_PISO in LDC_METRAJE_PISO.ID_PISO%type,
		inuID_PROYECTO in LDC_METRAJE_PISO.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_METRAJE_PISO.LONG_BAJANTE%type
	IS
		rcError styLDC_METRAJE_PISO;
	BEGIN

		rcError.ID_PISO := inuID_PISO;
		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PISO,
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.LONG_BAJANTE);
		end if;
		Load
		(
		 		inuID_PISO,
		 		inuID_PROYECTO
		);
		return(rcData.LONG_BAJANTE);
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
end DALDC_METRAJE_PISO;
/
PROMPT Otorgando permisos de ejecucion a DALDC_METRAJE_PISO
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_METRAJE_PISO', 'ADM_PERSON');
END;
/