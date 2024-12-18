CREATE OR REPLACE PACKAGE ADM_PERSON.DALDC_PISO_PROYECTO
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
		inuID_PISO in LDC_PISO_PROYECTO.ID_PISO%type,
		inuID_PROYECTO in LDC_PISO_PROYECTO.ID_PROYECTO%type
	)
	IS
		SELECT LDC_PISO_PROYECTO.*,LDC_PISO_PROYECTO.rowid
		FROM LDC_PISO_PROYECTO
		WHERE
		    ID_PISO = inuID_PISO
		    and ID_PROYECTO = inuID_PROYECTO;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_PISO_PROYECTO.*,LDC_PISO_PROYECTO.rowid
		FROM LDC_PISO_PROYECTO
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_PISO_PROYECTO  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_PISO_PROYECTO is table of styLDC_PISO_PROYECTO index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_PISO_PROYECTO;

	/* Tipos referenciando al registro */
	type tytbID_PISO is table of LDC_PISO_PROYECTO.ID_PISO%type index by binary_integer;
	type tytbDESCRIPCION is table of LDC_PISO_PROYECTO.DESCRIPCION%type index by binary_integer;
	type tytbID_PROYECTO is table of LDC_PISO_PROYECTO.ID_PROYECTO%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_PISO_PROYECTO is record
	(
		ID_PISO   tytbID_PISO,
		DESCRIPCION   tytbDESCRIPCION,
		ID_PROYECTO   tytbID_PROYECTO,
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
		inuID_PISO in LDC_PISO_PROYECTO.ID_PISO%type,
		inuID_PROYECTO in LDC_PISO_PROYECTO.ID_PROYECTO%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuID_PISO in LDC_PISO_PROYECTO.ID_PISO%type,
		inuID_PROYECTO in LDC_PISO_PROYECTO.ID_PROYECTO%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuID_PISO in LDC_PISO_PROYECTO.ID_PISO%type,
		inuID_PROYECTO in LDC_PISO_PROYECTO.ID_PROYECTO%type
	);

	PROCEDURE getRecord
	(
		inuID_PISO in LDC_PISO_PROYECTO.ID_PISO%type,
		inuID_PROYECTO in LDC_PISO_PROYECTO.ID_PROYECTO%type,
		orcRecord out nocopy styLDC_PISO_PROYECTO
	);

	FUNCTION frcGetRcData
	(
		inuID_PISO in LDC_PISO_PROYECTO.ID_PISO%type,
		inuID_PROYECTO in LDC_PISO_PROYECTO.ID_PROYECTO%type
	)
	RETURN styLDC_PISO_PROYECTO;

	FUNCTION frcGetRcData
	RETURN styLDC_PISO_PROYECTO;

	FUNCTION frcGetRecord
	(
		inuID_PISO in LDC_PISO_PROYECTO.ID_PISO%type,
		inuID_PROYECTO in LDC_PISO_PROYECTO.ID_PROYECTO%type
	)
	RETURN styLDC_PISO_PROYECTO;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_PISO_PROYECTO
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_PISO_PROYECTO in styLDC_PISO_PROYECTO
	);

	PROCEDURE insRecord
	(
		ircLDC_PISO_PROYECTO in styLDC_PISO_PROYECTO,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_PISO_PROYECTO in out nocopy tytbLDC_PISO_PROYECTO
	);

	PROCEDURE delRecord
	(
		inuID_PISO in LDC_PISO_PROYECTO.ID_PISO%type,
		inuID_PROYECTO in LDC_PISO_PROYECTO.ID_PROYECTO%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_PISO_PROYECTO in out nocopy tytbLDC_PISO_PROYECTO,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_PISO_PROYECTO in styLDC_PISO_PROYECTO,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_PISO_PROYECTO in out nocopy tytbLDC_PISO_PROYECTO,
		inuLock in number default 1
	);

	PROCEDURE updDESCRIPCION
	(
		inuID_PISO in LDC_PISO_PROYECTO.ID_PISO%type,
		inuID_PROYECTO in LDC_PISO_PROYECTO.ID_PROYECTO%type,
		isbDESCRIPCION$ in LDC_PISO_PROYECTO.DESCRIPCION%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetID_PISO
	(
		inuID_PISO in LDC_PISO_PROYECTO.ID_PISO%type,
		inuID_PROYECTO in LDC_PISO_PROYECTO.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PISO_PROYECTO.ID_PISO%type;

	FUNCTION fsbGetDESCRIPCION
	(
		inuID_PISO in LDC_PISO_PROYECTO.ID_PISO%type,
		inuID_PROYECTO in LDC_PISO_PROYECTO.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PISO_PROYECTO.DESCRIPCION%type;

	FUNCTION fnuGetID_PROYECTO
	(
		inuID_PISO in LDC_PISO_PROYECTO.ID_PISO%type,
		inuID_PROYECTO in LDC_PISO_PROYECTO.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PISO_PROYECTO.ID_PROYECTO%type;


	PROCEDURE LockByPk
	(
		inuID_PISO in LDC_PISO_PROYECTO.ID_PISO%type,
		inuID_PROYECTO in LDC_PISO_PROYECTO.ID_PROYECTO%type,
		orcLDC_PISO_PROYECTO  out styLDC_PISO_PROYECTO
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_PISO_PROYECTO  out styLDC_PISO_PROYECTO
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_PISO_PROYECTO;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALDC_PISO_PROYECTO
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_PISO_PROYECTO';
	 cnuGeEntityId constant varchar2(30) := 2858; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuID_PISO in LDC_PISO_PROYECTO.ID_PISO%type,
		inuID_PROYECTO in LDC_PISO_PROYECTO.ID_PROYECTO%type
	)
	IS
		SELECT LDC_PISO_PROYECTO.*,LDC_PISO_PROYECTO.rowid
		FROM LDC_PISO_PROYECTO
		WHERE  ID_PISO = inuID_PISO
			and ID_PROYECTO = inuID_PROYECTO
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_PISO_PROYECTO.*,LDC_PISO_PROYECTO.rowid
		FROM LDC_PISO_PROYECTO
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_PISO_PROYECTO is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_PISO_PROYECTO;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_PISO_PROYECTO default rcData )
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
		inuID_PISO in LDC_PISO_PROYECTO.ID_PISO%type,
		inuID_PROYECTO in LDC_PISO_PROYECTO.ID_PROYECTO%type,
		orcLDC_PISO_PROYECTO  out styLDC_PISO_PROYECTO
	)
	IS
		rcError styLDC_PISO_PROYECTO;
	BEGIN
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_PROYECTO := inuID_PROYECTO;

		Open cuLockRcByPk
		(
			inuID_PISO,
			inuID_PROYECTO
		);

		fetch cuLockRcByPk into orcLDC_PISO_PROYECTO;
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
		orcLDC_PISO_PROYECTO  out styLDC_PISO_PROYECTO
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_PISO_PROYECTO;
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
		itbLDC_PISO_PROYECTO  in out nocopy tytbLDC_PISO_PROYECTO
	)
	IS
	BEGIN
			rcRecOfTab.ID_PISO.delete;
			rcRecOfTab.DESCRIPCION.delete;
			rcRecOfTab.ID_PROYECTO.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_PISO_PROYECTO  in out nocopy tytbLDC_PISO_PROYECTO,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_PISO_PROYECTO);

		for n in itbLDC_PISO_PROYECTO.first .. itbLDC_PISO_PROYECTO.last loop
			rcRecOfTab.ID_PISO(n) := itbLDC_PISO_PROYECTO(n).ID_PISO;
			rcRecOfTab.DESCRIPCION(n) := itbLDC_PISO_PROYECTO(n).DESCRIPCION;
			rcRecOfTab.ID_PROYECTO(n) := itbLDC_PISO_PROYECTO(n).ID_PROYECTO;
			rcRecOfTab.row_id(n) := itbLDC_PISO_PROYECTO(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuID_PISO in LDC_PISO_PROYECTO.ID_PISO%type,
		inuID_PROYECTO in LDC_PISO_PROYECTO.ID_PROYECTO%type
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
		inuID_PISO in LDC_PISO_PROYECTO.ID_PISO%type,
		inuID_PROYECTO in LDC_PISO_PROYECTO.ID_PROYECTO%type
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
		inuID_PISO in LDC_PISO_PROYECTO.ID_PISO%type,
		inuID_PROYECTO in LDC_PISO_PROYECTO.ID_PROYECTO%type
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
		inuID_PISO in LDC_PISO_PROYECTO.ID_PISO%type,
		inuID_PROYECTO in LDC_PISO_PROYECTO.ID_PROYECTO%type
	)
	IS
		rcError styLDC_PISO_PROYECTO;
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
		inuID_PISO in LDC_PISO_PROYECTO.ID_PISO%type,
		inuID_PROYECTO in LDC_PISO_PROYECTO.ID_PROYECTO%type
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
		inuID_PISO in LDC_PISO_PROYECTO.ID_PISO%type,
		inuID_PROYECTO in LDC_PISO_PROYECTO.ID_PROYECTO%type,
		orcRecord out nocopy styLDC_PISO_PROYECTO
	)
	IS
		rcError styLDC_PISO_PROYECTO;
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
		inuID_PISO in LDC_PISO_PROYECTO.ID_PISO%type,
		inuID_PROYECTO in LDC_PISO_PROYECTO.ID_PROYECTO%type
	)
	RETURN styLDC_PISO_PROYECTO
	IS
		rcError styLDC_PISO_PROYECTO;
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
		inuID_PISO in LDC_PISO_PROYECTO.ID_PISO%type,
		inuID_PROYECTO in LDC_PISO_PROYECTO.ID_PROYECTO%type
	)
	RETURN styLDC_PISO_PROYECTO
	IS
		rcError styLDC_PISO_PROYECTO;
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
	RETURN styLDC_PISO_PROYECTO
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_PISO_PROYECTO
	)
	IS
		rfLDC_PISO_PROYECTO tyrfLDC_PISO_PROYECTO;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_PISO_PROYECTO.*, LDC_PISO_PROYECTO.rowid FROM LDC_PISO_PROYECTO';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_PISO_PROYECTO for sbFullQuery;

		fetch rfLDC_PISO_PROYECTO bulk collect INTO otbResult;

		close rfLDC_PISO_PROYECTO;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_PISO_PROYECTO.*, LDC_PISO_PROYECTO.rowid FROM LDC_PISO_PROYECTO';
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
		ircLDC_PISO_PROYECTO in styLDC_PISO_PROYECTO
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_PISO_PROYECTO,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_PISO_PROYECTO in styLDC_PISO_PROYECTO,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_PISO_PROYECTO.ID_PISO is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ID_PISO');
			raise ex.controlled_error;
		end if;
		if ircLDC_PISO_PROYECTO.ID_PROYECTO is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ID_PROYECTO');
			raise ex.controlled_error;
		end if;

		insert into LDC_PISO_PROYECTO
		(
			ID_PISO,
			DESCRIPCION,
			ID_PROYECTO
		)
		values
		(
			ircLDC_PISO_PROYECTO.ID_PISO,
			ircLDC_PISO_PROYECTO.DESCRIPCION,
			ircLDC_PISO_PROYECTO.ID_PROYECTO
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_PISO_PROYECTO));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_PISO_PROYECTO in out nocopy tytbLDC_PISO_PROYECTO
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_PISO_PROYECTO,blUseRowID);
		forall n in iotbLDC_PISO_PROYECTO.first..iotbLDC_PISO_PROYECTO.last
			insert into LDC_PISO_PROYECTO
			(
				ID_PISO,
				DESCRIPCION,
				ID_PROYECTO
			)
			values
			(
				rcRecOfTab.ID_PISO(n),
				rcRecOfTab.DESCRIPCION(n),
				rcRecOfTab.ID_PROYECTO(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuID_PISO in LDC_PISO_PROYECTO.ID_PISO%type,
		inuID_PROYECTO in LDC_PISO_PROYECTO.ID_PROYECTO%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_PISO_PROYECTO;
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
		from LDC_PISO_PROYECTO
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
		rcError  styLDC_PISO_PROYECTO;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_PISO_PROYECTO
		where
			rowid = iriRowID
		returning
			ID_PISO,
			DESCRIPCION
		into
			rcError.ID_PISO,
			rcError.DESCRIPCION;
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
		iotbLDC_PISO_PROYECTO in out nocopy tytbLDC_PISO_PROYECTO,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_PISO_PROYECTO;
	BEGIN
		FillRecordOfTables(iotbLDC_PISO_PROYECTO, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_PISO_PROYECTO.first .. iotbLDC_PISO_PROYECTO.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_PISO_PROYECTO.first .. iotbLDC_PISO_PROYECTO.last
				delete
				from LDC_PISO_PROYECTO
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_PISO_PROYECTO.first .. iotbLDC_PISO_PROYECTO.last loop
					LockByPk
					(
						rcRecOfTab.ID_PISO(n),
						rcRecOfTab.ID_PROYECTO(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_PISO_PROYECTO.first .. iotbLDC_PISO_PROYECTO.last
				delete
				from LDC_PISO_PROYECTO
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
		ircLDC_PISO_PROYECTO in styLDC_PISO_PROYECTO,
		inuLock in number default 0
	)
	IS
		nuID_PISO	LDC_PISO_PROYECTO.ID_PISO%type;
		nuID_PROYECTO	LDC_PISO_PROYECTO.ID_PROYECTO%type;
	BEGIN
		if ircLDC_PISO_PROYECTO.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_PISO_PROYECTO.rowid,rcData);
			end if;
			update LDC_PISO_PROYECTO
			set
				DESCRIPCION = ircLDC_PISO_PROYECTO.DESCRIPCION
			where
				rowid = ircLDC_PISO_PROYECTO.rowid
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
					ircLDC_PISO_PROYECTO.ID_PISO,
					ircLDC_PISO_PROYECTO.ID_PROYECTO,
					rcData
				);
			end if;

			update LDC_PISO_PROYECTO
			set
				DESCRIPCION = ircLDC_PISO_PROYECTO.DESCRIPCION
			where
				ID_PISO = ircLDC_PISO_PROYECTO.ID_PISO and
				ID_PROYECTO = ircLDC_PISO_PROYECTO.ID_PROYECTO
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
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_PISO_PROYECTO));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_PISO_PROYECTO in out nocopy tytbLDC_PISO_PROYECTO,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_PISO_PROYECTO;
	BEGIN
		FillRecordOfTables(iotbLDC_PISO_PROYECTO,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_PISO_PROYECTO.first .. iotbLDC_PISO_PROYECTO.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_PISO_PROYECTO.first .. iotbLDC_PISO_PROYECTO.last
				update LDC_PISO_PROYECTO
				set
					DESCRIPCION = rcRecOfTab.DESCRIPCION(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_PISO_PROYECTO.first .. iotbLDC_PISO_PROYECTO.last loop
					LockByPk
					(
						rcRecOfTab.ID_PISO(n),
						rcRecOfTab.ID_PROYECTO(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_PISO_PROYECTO.first .. iotbLDC_PISO_PROYECTO.last
				update LDC_PISO_PROYECTO
				SET
					DESCRIPCION = rcRecOfTab.DESCRIPCION(n)
				where
					ID_PISO = rcRecOfTab.ID_PISO(n) and
					ID_PROYECTO = rcRecOfTab.ID_PROYECTO(n)
;
		end if;
	END;
	PROCEDURE updDESCRIPCION
	(
		inuID_PISO in LDC_PISO_PROYECTO.ID_PISO%type,
		inuID_PROYECTO in LDC_PISO_PROYECTO.ID_PROYECTO%type,
		isbDESCRIPCION$ in LDC_PISO_PROYECTO.DESCRIPCION%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_PISO_PROYECTO;
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

		update LDC_PISO_PROYECTO
		set
			DESCRIPCION = isbDESCRIPCION$
		where
			ID_PISO = inuID_PISO and
			ID_PROYECTO = inuID_PROYECTO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DESCRIPCION:= isbDESCRIPCION$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetID_PISO
	(
		inuID_PISO in LDC_PISO_PROYECTO.ID_PISO%type,
		inuID_PROYECTO in LDC_PISO_PROYECTO.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PISO_PROYECTO.ID_PISO%type
	IS
		rcError styLDC_PISO_PROYECTO;
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
	FUNCTION fsbGetDESCRIPCION
	(
		inuID_PISO in LDC_PISO_PROYECTO.ID_PISO%type,
		inuID_PROYECTO in LDC_PISO_PROYECTO.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PISO_PROYECTO.DESCRIPCION%type
	IS
		rcError styLDC_PISO_PROYECTO;
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
			 return(rcData.DESCRIPCION);
		end if;
		Load
		(
		 		inuID_PISO,
		 		inuID_PROYECTO
		);
		return(rcData.DESCRIPCION);
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
		inuID_PISO in LDC_PISO_PROYECTO.ID_PISO%type,
		inuID_PROYECTO in LDC_PISO_PROYECTO.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PISO_PROYECTO.ID_PROYECTO%type
	IS
		rcError styLDC_PISO_PROYECTO;
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
	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	) IS
	Begin
	    blDAO_USE_CACHE := iblUseCache;
	END;

begin
    GetDAO_USE_CACHE;
end DALDC_PISO_PROYECTO;
/
PROMPT Otorgando permisos de ejecucion a DALDC_PISO_PROYECTO
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_PISO_PROYECTO', 'ADM_PERSON');
END;
/