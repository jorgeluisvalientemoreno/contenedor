CREATE OR REPLACE PACKAGE adm_person.DALDC_LV_LEY_1581
is
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     : DALDC_LV_LEY_1581
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
		inuID_TABLA in LDC_LV_LEY_1581.ID_TABLA%type
	)
	IS
		SELECT LDC_LV_LEY_1581.*,LDC_LV_LEY_1581.rowid
		FROM LDC_LV_LEY_1581
		WHERE
		    ID_TABLA = inuID_TABLA;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_LV_LEY_1581.*,LDC_LV_LEY_1581.rowid
		FROM LDC_LV_LEY_1581
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_LV_LEY_1581  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_LV_LEY_1581 is table of styLDC_LV_LEY_1581 index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_LV_LEY_1581;

	/* Tipos referenciando al registro */
	type tytbID_TABLA is table of LDC_LV_LEY_1581.ID_TABLA%type index by binary_integer;
	type tytbDESCRIPCION is table of LDC_LV_LEY_1581.DESCRIPCION%type index by binary_integer;
	type tytbACTIVO is table of LDC_LV_LEY_1581.ACTIVO%type index by binary_integer;
	type tytbUSUARIO is table of LDC_LV_LEY_1581.USUARIO%type index by binary_integer;
	type tytbFECHA is table of LDC_LV_LEY_1581.FECHA%type index by binary_integer;
	type tytbTERMINAL is table of LDC_LV_LEY_1581.TERMINAL%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_LV_LEY_1581 is record
	(
		ID_TABLA   tytbID_TABLA,
		DESCRIPCION   tytbDESCRIPCION,
		ACTIVO   tytbACTIVO,
		USUARIO   tytbUSUARIO,
		FECHA   tytbFECHA,
		TERMINAL   tytbTERMINAL,
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
		inuID_TABLA in LDC_LV_LEY_1581.ID_TABLA%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuID_TABLA in LDC_LV_LEY_1581.ID_TABLA%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuID_TABLA in LDC_LV_LEY_1581.ID_TABLA%type
	);

	PROCEDURE getRecord
	(
		inuID_TABLA in LDC_LV_LEY_1581.ID_TABLA%type,
		orcRecord out nocopy styLDC_LV_LEY_1581
	);

	FUNCTION frcGetRcData
	(
		inuID_TABLA in LDC_LV_LEY_1581.ID_TABLA%type
	)
	RETURN styLDC_LV_LEY_1581;

	FUNCTION frcGetRcData
	RETURN styLDC_LV_LEY_1581;

	FUNCTION frcGetRecord
	(
		inuID_TABLA in LDC_LV_LEY_1581.ID_TABLA%type
	)
	RETURN styLDC_LV_LEY_1581;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_LV_LEY_1581
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_LV_LEY_1581 in styLDC_LV_LEY_1581
	);

	PROCEDURE insRecord
	(
		ircLDC_LV_LEY_1581 in styLDC_LV_LEY_1581,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_LV_LEY_1581 in out nocopy tytbLDC_LV_LEY_1581
	);

	PROCEDURE delRecord
	(
		inuID_TABLA in LDC_LV_LEY_1581.ID_TABLA%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_LV_LEY_1581 in out nocopy tytbLDC_LV_LEY_1581,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_LV_LEY_1581 in styLDC_LV_LEY_1581,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_LV_LEY_1581 in out nocopy tytbLDC_LV_LEY_1581,
		inuLock in number default 1
	);

	PROCEDURE updDESCRIPCION
	(
		inuID_TABLA in LDC_LV_LEY_1581.ID_TABLA%type,
		isbDESCRIPCION$ in LDC_LV_LEY_1581.DESCRIPCION%type,
		inuLock in number default 0
	);

	PROCEDURE updACTIVO
	(
		inuID_TABLA in LDC_LV_LEY_1581.ID_TABLA%type,
		isbACTIVO$ in LDC_LV_LEY_1581.ACTIVO%type,
		inuLock in number default 0
	);

	PROCEDURE updUSUARIO
	(
		inuID_TABLA in LDC_LV_LEY_1581.ID_TABLA%type,
		isbUSUARIO$ in LDC_LV_LEY_1581.USUARIO%type,
		inuLock in number default 0
	);

	PROCEDURE updFECHA
	(
		inuID_TABLA in LDC_LV_LEY_1581.ID_TABLA%type,
		idtFECHA$ in LDC_LV_LEY_1581.FECHA%type,
		inuLock in number default 0
	);

	PROCEDURE updTERMINAL
	(
		inuID_TABLA in LDC_LV_LEY_1581.ID_TABLA%type,
		isbTERMINAL$ in LDC_LV_LEY_1581.TERMINAL%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetID_TABLA
	(
		inuID_TABLA in LDC_LV_LEY_1581.ID_TABLA%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_LV_LEY_1581.ID_TABLA%type;

	FUNCTION fsbGetDESCRIPCION
	(
		inuID_TABLA in LDC_LV_LEY_1581.ID_TABLA%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_LV_LEY_1581.DESCRIPCION%type;

	FUNCTION fsbGetACTIVO
	(
		inuID_TABLA in LDC_LV_LEY_1581.ID_TABLA%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_LV_LEY_1581.ACTIVO%type;

	FUNCTION fsbGetUSUARIO
	(
		inuID_TABLA in LDC_LV_LEY_1581.ID_TABLA%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_LV_LEY_1581.USUARIO%type;

	FUNCTION fdtGetFECHA
	(
		inuID_TABLA in LDC_LV_LEY_1581.ID_TABLA%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_LV_LEY_1581.FECHA%type;

	FUNCTION fsbGetTERMINAL
	(
		inuID_TABLA in LDC_LV_LEY_1581.ID_TABLA%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_LV_LEY_1581.TERMINAL%type;


	PROCEDURE LockByPk
	(
		inuID_TABLA in LDC_LV_LEY_1581.ID_TABLA%type,
		orcLDC_LV_LEY_1581  out styLDC_LV_LEY_1581
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_LV_LEY_1581  out styLDC_LV_LEY_1581
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_LV_LEY_1581;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALDC_LV_LEY_1581
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_LV_LEY_1581';
	 cnuGeEntityId constant varchar2(30) := 8807; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuID_TABLA in LDC_LV_LEY_1581.ID_TABLA%type
	)
	IS
		SELECT LDC_LV_LEY_1581.*,LDC_LV_LEY_1581.rowid
		FROM LDC_LV_LEY_1581
		WHERE  ID_TABLA = inuID_TABLA
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_LV_LEY_1581.*,LDC_LV_LEY_1581.rowid
		FROM LDC_LV_LEY_1581
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_LV_LEY_1581 is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_LV_LEY_1581;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_LV_LEY_1581 default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.ID_TABLA);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuID_TABLA in LDC_LV_LEY_1581.ID_TABLA%type,
		orcLDC_LV_LEY_1581  out styLDC_LV_LEY_1581
	)
	IS
		rcError styLDC_LV_LEY_1581;
	BEGIN
		rcError.ID_TABLA := inuID_TABLA;

		Open cuLockRcByPk
		(
			inuID_TABLA
		);

		fetch cuLockRcByPk into orcLDC_LV_LEY_1581;
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
		orcLDC_LV_LEY_1581  out styLDC_LV_LEY_1581
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_LV_LEY_1581;
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
		itbLDC_LV_LEY_1581  in out nocopy tytbLDC_LV_LEY_1581
	)
	IS
	BEGIN
			rcRecOfTab.ID_TABLA.delete;
			rcRecOfTab.DESCRIPCION.delete;
			rcRecOfTab.ACTIVO.delete;
			rcRecOfTab.USUARIO.delete;
			rcRecOfTab.FECHA.delete;
			rcRecOfTab.TERMINAL.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_LV_LEY_1581  in out nocopy tytbLDC_LV_LEY_1581,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_LV_LEY_1581);

		for n in itbLDC_LV_LEY_1581.first .. itbLDC_LV_LEY_1581.last loop
			rcRecOfTab.ID_TABLA(n) := itbLDC_LV_LEY_1581(n).ID_TABLA;
			rcRecOfTab.DESCRIPCION(n) := itbLDC_LV_LEY_1581(n).DESCRIPCION;
			rcRecOfTab.ACTIVO(n) := itbLDC_LV_LEY_1581(n).ACTIVO;
			rcRecOfTab.USUARIO(n) := itbLDC_LV_LEY_1581(n).USUARIO;
			rcRecOfTab.FECHA(n) := itbLDC_LV_LEY_1581(n).FECHA;
			rcRecOfTab.TERMINAL(n) := itbLDC_LV_LEY_1581(n).TERMINAL;
			rcRecOfTab.row_id(n) := itbLDC_LV_LEY_1581(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuID_TABLA in LDC_LV_LEY_1581.ID_TABLA%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuID_TABLA
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
		inuID_TABLA in LDC_LV_LEY_1581.ID_TABLA%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuID_TABLA = rcData.ID_TABLA
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
		inuID_TABLA in LDC_LV_LEY_1581.ID_TABLA%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuID_TABLA
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuID_TABLA in LDC_LV_LEY_1581.ID_TABLA%type
	)
	IS
		rcError styLDC_LV_LEY_1581;
	BEGIN		rcError.ID_TABLA:=inuID_TABLA;

		Load
		(
			inuID_TABLA
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
		inuID_TABLA in LDC_LV_LEY_1581.ID_TABLA%type
	)
	IS
	BEGIN
		Load
		(
			inuID_TABLA
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuID_TABLA in LDC_LV_LEY_1581.ID_TABLA%type,
		orcRecord out nocopy styLDC_LV_LEY_1581
	)
	IS
		rcError styLDC_LV_LEY_1581;
	BEGIN		rcError.ID_TABLA:=inuID_TABLA;

		Load
		(
			inuID_TABLA
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuID_TABLA in LDC_LV_LEY_1581.ID_TABLA%type
	)
	RETURN styLDC_LV_LEY_1581
	IS
		rcError styLDC_LV_LEY_1581;
	BEGIN
		rcError.ID_TABLA:=inuID_TABLA;

		Load
		(
			inuID_TABLA
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuID_TABLA in LDC_LV_LEY_1581.ID_TABLA%type
	)
	RETURN styLDC_LV_LEY_1581
	IS
		rcError styLDC_LV_LEY_1581;
	BEGIN
		rcError.ID_TABLA:=inuID_TABLA;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuID_TABLA
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuID_TABLA
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_LV_LEY_1581
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_LV_LEY_1581
	)
	IS
		rfLDC_LV_LEY_1581 tyrfLDC_LV_LEY_1581;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_LV_LEY_1581.*, LDC_LV_LEY_1581.rowid FROM LDC_LV_LEY_1581';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_LV_LEY_1581 for sbFullQuery;

		fetch rfLDC_LV_LEY_1581 bulk collect INTO otbResult;

		close rfLDC_LV_LEY_1581;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_LV_LEY_1581.*, LDC_LV_LEY_1581.rowid FROM LDC_LV_LEY_1581';
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
		ircLDC_LV_LEY_1581 in styLDC_LV_LEY_1581
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_LV_LEY_1581,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_LV_LEY_1581 in styLDC_LV_LEY_1581,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_LV_LEY_1581.ID_TABLA is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ID_TABLA');
			raise ex.controlled_error;
		end if;

		insert into LDC_LV_LEY_1581
		(
			ID_TABLA,
			DESCRIPCION,
			ACTIVO,
			USUARIO,
			FECHA,
			TERMINAL
		)
		values
		(
			ircLDC_LV_LEY_1581.ID_TABLA,
			ircLDC_LV_LEY_1581.DESCRIPCION,
			ircLDC_LV_LEY_1581.ACTIVO,
			ircLDC_LV_LEY_1581.USUARIO,
			ircLDC_LV_LEY_1581.FECHA,
			ircLDC_LV_LEY_1581.TERMINAL
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_LV_LEY_1581));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_LV_LEY_1581 in out nocopy tytbLDC_LV_LEY_1581
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_LV_LEY_1581,blUseRowID);
		forall n in iotbLDC_LV_LEY_1581.first..iotbLDC_LV_LEY_1581.last
			insert into LDC_LV_LEY_1581
			(
				ID_TABLA,
				DESCRIPCION,
				ACTIVO,
				USUARIO,
				FECHA,
				TERMINAL
			)
			values
			(
				rcRecOfTab.ID_TABLA(n),
				rcRecOfTab.DESCRIPCION(n),
				rcRecOfTab.ACTIVO(n),
				rcRecOfTab.USUARIO(n),
				rcRecOfTab.FECHA(n),
				rcRecOfTab.TERMINAL(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuID_TABLA in LDC_LV_LEY_1581.ID_TABLA%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_LV_LEY_1581;
	BEGIN
		rcError.ID_TABLA := inuID_TABLA;

		if inuLock=1 then
			LockByPk
			(
				inuID_TABLA,
				rcData
			);
		end if;


		delete
		from LDC_LV_LEY_1581
		where
       		ID_TABLA=inuID_TABLA;
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
		rcError  styLDC_LV_LEY_1581;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_LV_LEY_1581
		where
			rowid = iriRowID
		returning
			ID_TABLA
		into
			rcError.ID_TABLA;
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
		iotbLDC_LV_LEY_1581 in out nocopy tytbLDC_LV_LEY_1581,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_LV_LEY_1581;
	BEGIN
		FillRecordOfTables(iotbLDC_LV_LEY_1581, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_LV_LEY_1581.first .. iotbLDC_LV_LEY_1581.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_LV_LEY_1581.first .. iotbLDC_LV_LEY_1581.last
				delete
				from LDC_LV_LEY_1581
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_LV_LEY_1581.first .. iotbLDC_LV_LEY_1581.last loop
					LockByPk
					(
						rcRecOfTab.ID_TABLA(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_LV_LEY_1581.first .. iotbLDC_LV_LEY_1581.last
				delete
				from LDC_LV_LEY_1581
				where
		         	ID_TABLA = rcRecOfTab.ID_TABLA(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_LV_LEY_1581 in styLDC_LV_LEY_1581,
		inuLock in number default 0
	)
	IS
		nuID_TABLA	LDC_LV_LEY_1581.ID_TABLA%type;
	BEGIN
		if ircLDC_LV_LEY_1581.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_LV_LEY_1581.rowid,rcData);
			end if;
			update LDC_LV_LEY_1581
			set
				DESCRIPCION = ircLDC_LV_LEY_1581.DESCRIPCION,
				ACTIVO = ircLDC_LV_LEY_1581.ACTIVO,
				USUARIO = ircLDC_LV_LEY_1581.USUARIO,
				FECHA = ircLDC_LV_LEY_1581.FECHA,
				TERMINAL = ircLDC_LV_LEY_1581.TERMINAL
			where
				rowid = ircLDC_LV_LEY_1581.rowid
			returning
				ID_TABLA
			into
				nuID_TABLA;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_LV_LEY_1581.ID_TABLA,
					rcData
				);
			end if;

			update LDC_LV_LEY_1581
			set
				DESCRIPCION = ircLDC_LV_LEY_1581.DESCRIPCION,
				ACTIVO = ircLDC_LV_LEY_1581.ACTIVO,
				USUARIO = ircLDC_LV_LEY_1581.USUARIO,
				FECHA = ircLDC_LV_LEY_1581.FECHA,
				TERMINAL = ircLDC_LV_LEY_1581.TERMINAL
			where
				ID_TABLA = ircLDC_LV_LEY_1581.ID_TABLA
			returning
				ID_TABLA
			into
				nuID_TABLA;
		end if;
		if
			nuID_TABLA is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_LV_LEY_1581));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_LV_LEY_1581 in out nocopy tytbLDC_LV_LEY_1581,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_LV_LEY_1581;
	BEGIN
		FillRecordOfTables(iotbLDC_LV_LEY_1581,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_LV_LEY_1581.first .. iotbLDC_LV_LEY_1581.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_LV_LEY_1581.first .. iotbLDC_LV_LEY_1581.last
				update LDC_LV_LEY_1581
				set
					DESCRIPCION = rcRecOfTab.DESCRIPCION(n),
					ACTIVO = rcRecOfTab.ACTIVO(n),
					USUARIO = rcRecOfTab.USUARIO(n),
					FECHA = rcRecOfTab.FECHA(n),
					TERMINAL = rcRecOfTab.TERMINAL(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_LV_LEY_1581.first .. iotbLDC_LV_LEY_1581.last loop
					LockByPk
					(
						rcRecOfTab.ID_TABLA(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_LV_LEY_1581.first .. iotbLDC_LV_LEY_1581.last
				update LDC_LV_LEY_1581
				SET
					DESCRIPCION = rcRecOfTab.DESCRIPCION(n),
					ACTIVO = rcRecOfTab.ACTIVO(n),
					USUARIO = rcRecOfTab.USUARIO(n),
					FECHA = rcRecOfTab.FECHA(n),
					TERMINAL = rcRecOfTab.TERMINAL(n)
				where
					ID_TABLA = rcRecOfTab.ID_TABLA(n)
;
		end if;
	END;
	PROCEDURE updDESCRIPCION
	(
		inuID_TABLA in LDC_LV_LEY_1581.ID_TABLA%type,
		isbDESCRIPCION$ in LDC_LV_LEY_1581.DESCRIPCION%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_LV_LEY_1581;
	BEGIN
		rcError.ID_TABLA := inuID_TABLA;
		if inuLock=1 then
			LockByPk
			(
				inuID_TABLA,
				rcData
			);
		end if;

		update LDC_LV_LEY_1581
		set
			DESCRIPCION = isbDESCRIPCION$
		where
			ID_TABLA = inuID_TABLA;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DESCRIPCION:= isbDESCRIPCION$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updACTIVO
	(
		inuID_TABLA in LDC_LV_LEY_1581.ID_TABLA%type,
		isbACTIVO$ in LDC_LV_LEY_1581.ACTIVO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_LV_LEY_1581;
	BEGIN
		rcError.ID_TABLA := inuID_TABLA;
		if inuLock=1 then
			LockByPk
			(
				inuID_TABLA,
				rcData
			);
		end if;

		update LDC_LV_LEY_1581
		set
			ACTIVO = isbACTIVO$
		where
			ID_TABLA = inuID_TABLA;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ACTIVO:= isbACTIVO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updUSUARIO
	(
		inuID_TABLA in LDC_LV_LEY_1581.ID_TABLA%type,
		isbUSUARIO$ in LDC_LV_LEY_1581.USUARIO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_LV_LEY_1581;
	BEGIN
		rcError.ID_TABLA := inuID_TABLA;
		if inuLock=1 then
			LockByPk
			(
				inuID_TABLA,
				rcData
			);
		end if;

		update LDC_LV_LEY_1581
		set
			USUARIO = isbUSUARIO$
		where
			ID_TABLA = inuID_TABLA;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.USUARIO:= isbUSUARIO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFECHA
	(
		inuID_TABLA in LDC_LV_LEY_1581.ID_TABLA%type,
		idtFECHA$ in LDC_LV_LEY_1581.FECHA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_LV_LEY_1581;
	BEGIN
		rcError.ID_TABLA := inuID_TABLA;
		if inuLock=1 then
			LockByPk
			(
				inuID_TABLA,
				rcData
			);
		end if;

		update LDC_LV_LEY_1581
		set
			FECHA = idtFECHA$
		where
			ID_TABLA = inuID_TABLA;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FECHA:= idtFECHA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updTERMINAL
	(
		inuID_TABLA in LDC_LV_LEY_1581.ID_TABLA%type,
		isbTERMINAL$ in LDC_LV_LEY_1581.TERMINAL%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_LV_LEY_1581;
	BEGIN
		rcError.ID_TABLA := inuID_TABLA;
		if inuLock=1 then
			LockByPk
			(
				inuID_TABLA,
				rcData
			);
		end if;

		update LDC_LV_LEY_1581
		set
			TERMINAL = isbTERMINAL$
		where
			ID_TABLA = inuID_TABLA;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TERMINAL:= isbTERMINAL$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetID_TABLA
	(
		inuID_TABLA in LDC_LV_LEY_1581.ID_TABLA%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_LV_LEY_1581.ID_TABLA%type
	IS
		rcError styLDC_LV_LEY_1581;
	BEGIN

		rcError.ID_TABLA := inuID_TABLA;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_TABLA
			 )
		then
			 return(rcData.ID_TABLA);
		end if;
		Load
		(
		 		inuID_TABLA
		);
		return(rcData.ID_TABLA);
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
		inuID_TABLA in LDC_LV_LEY_1581.ID_TABLA%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_LV_LEY_1581.DESCRIPCION%type
	IS
		rcError styLDC_LV_LEY_1581;
	BEGIN

		rcError.ID_TABLA := inuID_TABLA;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_TABLA
			 )
		then
			 return(rcData.DESCRIPCION);
		end if;
		Load
		(
		 		inuID_TABLA
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
	FUNCTION fsbGetACTIVO
	(
		inuID_TABLA in LDC_LV_LEY_1581.ID_TABLA%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_LV_LEY_1581.ACTIVO%type
	IS
		rcError styLDC_LV_LEY_1581;
	BEGIN

		rcError.ID_TABLA := inuID_TABLA;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_TABLA
			 )
		then
			 return(rcData.ACTIVO);
		end if;
		Load
		(
		 		inuID_TABLA
		);
		return(rcData.ACTIVO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetUSUARIO
	(
		inuID_TABLA in LDC_LV_LEY_1581.ID_TABLA%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_LV_LEY_1581.USUARIO%type
	IS
		rcError styLDC_LV_LEY_1581;
	BEGIN

		rcError.ID_TABLA := inuID_TABLA;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_TABLA
			 )
		then
			 return(rcData.USUARIO);
		end if;
		Load
		(
		 		inuID_TABLA
		);
		return(rcData.USUARIO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetFECHA
	(
		inuID_TABLA in LDC_LV_LEY_1581.ID_TABLA%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_LV_LEY_1581.FECHA%type
	IS
		rcError styLDC_LV_LEY_1581;
	BEGIN

		rcError.ID_TABLA := inuID_TABLA;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_TABLA
			 )
		then
			 return(rcData.FECHA);
		end if;
		Load
		(
		 		inuID_TABLA
		);
		return(rcData.FECHA);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetTERMINAL
	(
		inuID_TABLA in LDC_LV_LEY_1581.ID_TABLA%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_LV_LEY_1581.TERMINAL%type
	IS
		rcError styLDC_LV_LEY_1581;
	BEGIN

		rcError.ID_TABLA := inuID_TABLA;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_TABLA
			 )
		then
			 return(rcData.TERMINAL);
		end if;
		Load
		(
		 		inuID_TABLA
		);
		return(rcData.TERMINAL);
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
end DALDC_LV_LEY_1581;
/
PROMPT Otorgando permisos de ejecucion a DALDC_LV_LEY_1581
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_LV_LEY_1581', 'ADM_PERSON');
END;
/