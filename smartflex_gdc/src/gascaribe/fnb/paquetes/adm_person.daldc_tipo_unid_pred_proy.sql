CREATE OR REPLACE PACKAGE ADM_PERSON.DALDC_TIPO_UNID_PRED_PROY
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
		inuID_TIPO_UNID_PRED in LDC_TIPO_UNID_PRED_PROY.ID_TIPO_UNID_PRED%type,
		inuID_PROYECTO in LDC_TIPO_UNID_PRED_PROY.ID_PROYECTO%type
	)
	IS
		SELECT LDC_TIPO_UNID_PRED_PROY.*,LDC_TIPO_UNID_PRED_PROY.rowid
		FROM LDC_TIPO_UNID_PRED_PROY
		WHERE
		    ID_TIPO_UNID_PRED = inuID_TIPO_UNID_PRED
		    and ID_PROYECTO = inuID_PROYECTO;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_TIPO_UNID_PRED_PROY.*,LDC_TIPO_UNID_PRED_PROY.rowid
		FROM LDC_TIPO_UNID_PRED_PROY
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_TIPO_UNID_PRED_PROY  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_TIPO_UNID_PRED_PROY is table of styLDC_TIPO_UNID_PRED_PROY index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_TIPO_UNID_PRED_PROY;

	/* Tipos referenciando al registro */
	type tytbID_TIPO_UNID_PRED is table of LDC_TIPO_UNID_PRED_PROY.ID_TIPO_UNID_PRED%type index by binary_integer;
	type tytbDESCRIPCION is table of LDC_TIPO_UNID_PRED_PROY.DESCRIPCION%type index by binary_integer;
	type tytbID_PROYECTO is table of LDC_TIPO_UNID_PRED_PROY.ID_PROYECTO%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_TIPO_UNID_PRED_PROY is record
	(
		ID_TIPO_UNID_PRED   tytbID_TIPO_UNID_PRED,
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
		inuID_TIPO_UNID_PRED in LDC_TIPO_UNID_PRED_PROY.ID_TIPO_UNID_PRED%type,
		inuID_PROYECTO in LDC_TIPO_UNID_PRED_PROY.ID_PROYECTO%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuID_TIPO_UNID_PRED in LDC_TIPO_UNID_PRED_PROY.ID_TIPO_UNID_PRED%type,
		inuID_PROYECTO in LDC_TIPO_UNID_PRED_PROY.ID_PROYECTO%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuID_TIPO_UNID_PRED in LDC_TIPO_UNID_PRED_PROY.ID_TIPO_UNID_PRED%type,
		inuID_PROYECTO in LDC_TIPO_UNID_PRED_PROY.ID_PROYECTO%type
	);

	PROCEDURE getRecord
	(
		inuID_TIPO_UNID_PRED in LDC_TIPO_UNID_PRED_PROY.ID_TIPO_UNID_PRED%type,
		inuID_PROYECTO in LDC_TIPO_UNID_PRED_PROY.ID_PROYECTO%type,
		orcRecord out nocopy styLDC_TIPO_UNID_PRED_PROY
	);

	FUNCTION frcGetRcData
	(
		inuID_TIPO_UNID_PRED in LDC_TIPO_UNID_PRED_PROY.ID_TIPO_UNID_PRED%type,
		inuID_PROYECTO in LDC_TIPO_UNID_PRED_PROY.ID_PROYECTO%type
	)
	RETURN styLDC_TIPO_UNID_PRED_PROY;

	FUNCTION frcGetRcData
	RETURN styLDC_TIPO_UNID_PRED_PROY;

	FUNCTION frcGetRecord
	(
		inuID_TIPO_UNID_PRED in LDC_TIPO_UNID_PRED_PROY.ID_TIPO_UNID_PRED%type,
		inuID_PROYECTO in LDC_TIPO_UNID_PRED_PROY.ID_PROYECTO%type
	)
	RETURN styLDC_TIPO_UNID_PRED_PROY;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_TIPO_UNID_PRED_PROY
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_TIPO_UNID_PRED_PROY in styLDC_TIPO_UNID_PRED_PROY
	);

	PROCEDURE insRecord
	(
		ircLDC_TIPO_UNID_PRED_PROY in styLDC_TIPO_UNID_PRED_PROY,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_TIPO_UNID_PRED_PROY in out nocopy tytbLDC_TIPO_UNID_PRED_PROY
	);

	PROCEDURE delRecord
	(
		inuID_TIPO_UNID_PRED in LDC_TIPO_UNID_PRED_PROY.ID_TIPO_UNID_PRED%type,
		inuID_PROYECTO in LDC_TIPO_UNID_PRED_PROY.ID_PROYECTO%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_TIPO_UNID_PRED_PROY in out nocopy tytbLDC_TIPO_UNID_PRED_PROY,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_TIPO_UNID_PRED_PROY in styLDC_TIPO_UNID_PRED_PROY,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_TIPO_UNID_PRED_PROY in out nocopy tytbLDC_TIPO_UNID_PRED_PROY,
		inuLock in number default 1
	);

	PROCEDURE updDESCRIPCION
	(
		inuID_TIPO_UNID_PRED in LDC_TIPO_UNID_PRED_PROY.ID_TIPO_UNID_PRED%type,
		inuID_PROYECTO in LDC_TIPO_UNID_PRED_PROY.ID_PROYECTO%type,
		isbDESCRIPCION$ in LDC_TIPO_UNID_PRED_PROY.DESCRIPCION%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetID_TIPO_UNID_PRED
	(
		inuID_TIPO_UNID_PRED in LDC_TIPO_UNID_PRED_PROY.ID_TIPO_UNID_PRED%type,
		inuID_PROYECTO in LDC_TIPO_UNID_PRED_PROY.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPO_UNID_PRED_PROY.ID_TIPO_UNID_PRED%type;

	FUNCTION fsbGetDESCRIPCION
	(
		inuID_TIPO_UNID_PRED in LDC_TIPO_UNID_PRED_PROY.ID_TIPO_UNID_PRED%type,
		inuID_PROYECTO in LDC_TIPO_UNID_PRED_PROY.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPO_UNID_PRED_PROY.DESCRIPCION%type;

	FUNCTION fnuGetID_PROYECTO
	(
		inuID_TIPO_UNID_PRED in LDC_TIPO_UNID_PRED_PROY.ID_TIPO_UNID_PRED%type,
		inuID_PROYECTO in LDC_TIPO_UNID_PRED_PROY.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPO_UNID_PRED_PROY.ID_PROYECTO%type;


	PROCEDURE LockByPk
	(
		inuID_TIPO_UNID_PRED in LDC_TIPO_UNID_PRED_PROY.ID_TIPO_UNID_PRED%type,
		inuID_PROYECTO in LDC_TIPO_UNID_PRED_PROY.ID_PROYECTO%type,
		orcLDC_TIPO_UNID_PRED_PROY  out styLDC_TIPO_UNID_PRED_PROY
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_TIPO_UNID_PRED_PROY  out styLDC_TIPO_UNID_PRED_PROY
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_TIPO_UNID_PRED_PROY;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALDC_TIPO_UNID_PRED_PROY
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_TIPO_UNID_PRED_PROY';
	 cnuGeEntityId constant varchar2(30) := 2859; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuID_TIPO_UNID_PRED in LDC_TIPO_UNID_PRED_PROY.ID_TIPO_UNID_PRED%type,
		inuID_PROYECTO in LDC_TIPO_UNID_PRED_PROY.ID_PROYECTO%type
	)
	IS
		SELECT LDC_TIPO_UNID_PRED_PROY.*,LDC_TIPO_UNID_PRED_PROY.rowid
		FROM LDC_TIPO_UNID_PRED_PROY
		WHERE  ID_TIPO_UNID_PRED = inuID_TIPO_UNID_PRED
			and ID_PROYECTO = inuID_PROYECTO
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_TIPO_UNID_PRED_PROY.*,LDC_TIPO_UNID_PRED_PROY.rowid
		FROM LDC_TIPO_UNID_PRED_PROY
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_TIPO_UNID_PRED_PROY is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_TIPO_UNID_PRED_PROY;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_TIPO_UNID_PRED_PROY default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.ID_TIPO_UNID_PRED);
		sbPk:=sbPk||','||ut_convert.fsbToChar(rcI.ID_PROYECTO);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuID_TIPO_UNID_PRED in LDC_TIPO_UNID_PRED_PROY.ID_TIPO_UNID_PRED%type,
		inuID_PROYECTO in LDC_TIPO_UNID_PRED_PROY.ID_PROYECTO%type,
		orcLDC_TIPO_UNID_PRED_PROY  out styLDC_TIPO_UNID_PRED_PROY
	)
	IS
		rcError styLDC_TIPO_UNID_PRED_PROY;
	BEGIN
		rcError.ID_TIPO_UNID_PRED := inuID_TIPO_UNID_PRED;
		rcError.ID_PROYECTO := inuID_PROYECTO;

		Open cuLockRcByPk
		(
			inuID_TIPO_UNID_PRED,
			inuID_PROYECTO
		);

		fetch cuLockRcByPk into orcLDC_TIPO_UNID_PRED_PROY;
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
		orcLDC_TIPO_UNID_PRED_PROY  out styLDC_TIPO_UNID_PRED_PROY
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_TIPO_UNID_PRED_PROY;
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
		itbLDC_TIPO_UNID_PRED_PROY  in out nocopy tytbLDC_TIPO_UNID_PRED_PROY
	)
	IS
	BEGIN
			rcRecOfTab.ID_TIPO_UNID_PRED.delete;
			rcRecOfTab.DESCRIPCION.delete;
			rcRecOfTab.ID_PROYECTO.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_TIPO_UNID_PRED_PROY  in out nocopy tytbLDC_TIPO_UNID_PRED_PROY,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_TIPO_UNID_PRED_PROY);

		for n in itbLDC_TIPO_UNID_PRED_PROY.first .. itbLDC_TIPO_UNID_PRED_PROY.last loop
			rcRecOfTab.ID_TIPO_UNID_PRED(n) := itbLDC_TIPO_UNID_PRED_PROY(n).ID_TIPO_UNID_PRED;
			rcRecOfTab.DESCRIPCION(n) := itbLDC_TIPO_UNID_PRED_PROY(n).DESCRIPCION;
			rcRecOfTab.ID_PROYECTO(n) := itbLDC_TIPO_UNID_PRED_PROY(n).ID_PROYECTO;
			rcRecOfTab.row_id(n) := itbLDC_TIPO_UNID_PRED_PROY(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuID_TIPO_UNID_PRED in LDC_TIPO_UNID_PRED_PROY.ID_TIPO_UNID_PRED%type,
		inuID_PROYECTO in LDC_TIPO_UNID_PRED_PROY.ID_PROYECTO%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuID_TIPO_UNID_PRED,
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
		inuID_TIPO_UNID_PRED in LDC_TIPO_UNID_PRED_PROY.ID_TIPO_UNID_PRED%type,
		inuID_PROYECTO in LDC_TIPO_UNID_PRED_PROY.ID_PROYECTO%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuID_TIPO_UNID_PRED = rcData.ID_TIPO_UNID_PRED AND
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
		inuID_TIPO_UNID_PRED in LDC_TIPO_UNID_PRED_PROY.ID_TIPO_UNID_PRED%type,
		inuID_PROYECTO in LDC_TIPO_UNID_PRED_PROY.ID_PROYECTO%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuID_TIPO_UNID_PRED,
			inuID_PROYECTO
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuID_TIPO_UNID_PRED in LDC_TIPO_UNID_PRED_PROY.ID_TIPO_UNID_PRED%type,
		inuID_PROYECTO in LDC_TIPO_UNID_PRED_PROY.ID_PROYECTO%type
	)
	IS
		rcError styLDC_TIPO_UNID_PRED_PROY;
	BEGIN		rcError.ID_TIPO_UNID_PRED:=inuID_TIPO_UNID_PRED;		rcError.ID_PROYECTO:=inuID_PROYECTO;

		Load
		(
			inuID_TIPO_UNID_PRED,
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
		inuID_TIPO_UNID_PRED in LDC_TIPO_UNID_PRED_PROY.ID_TIPO_UNID_PRED%type,
		inuID_PROYECTO in LDC_TIPO_UNID_PRED_PROY.ID_PROYECTO%type
	)
	IS
	BEGIN
		Load
		(
			inuID_TIPO_UNID_PRED,
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
		inuID_TIPO_UNID_PRED in LDC_TIPO_UNID_PRED_PROY.ID_TIPO_UNID_PRED%type,
		inuID_PROYECTO in LDC_TIPO_UNID_PRED_PROY.ID_PROYECTO%type,
		orcRecord out nocopy styLDC_TIPO_UNID_PRED_PROY
	)
	IS
		rcError styLDC_TIPO_UNID_PRED_PROY;
	BEGIN		rcError.ID_TIPO_UNID_PRED:=inuID_TIPO_UNID_PRED;		rcError.ID_PROYECTO:=inuID_PROYECTO;

		Load
		(
			inuID_TIPO_UNID_PRED,
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
		inuID_TIPO_UNID_PRED in LDC_TIPO_UNID_PRED_PROY.ID_TIPO_UNID_PRED%type,
		inuID_PROYECTO in LDC_TIPO_UNID_PRED_PROY.ID_PROYECTO%type
	)
	RETURN styLDC_TIPO_UNID_PRED_PROY
	IS
		rcError styLDC_TIPO_UNID_PRED_PROY;
	BEGIN
		rcError.ID_TIPO_UNID_PRED:=inuID_TIPO_UNID_PRED;
		rcError.ID_PROYECTO:=inuID_PROYECTO;

		Load
		(
			inuID_TIPO_UNID_PRED,
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
		inuID_TIPO_UNID_PRED in LDC_TIPO_UNID_PRED_PROY.ID_TIPO_UNID_PRED%type,
		inuID_PROYECTO in LDC_TIPO_UNID_PRED_PROY.ID_PROYECTO%type
	)
	RETURN styLDC_TIPO_UNID_PRED_PROY
	IS
		rcError styLDC_TIPO_UNID_PRED_PROY;
	BEGIN
		rcError.ID_TIPO_UNID_PRED:=inuID_TIPO_UNID_PRED;
		rcError.ID_PROYECTO:=inuID_PROYECTO;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuID_TIPO_UNID_PRED,
			inuID_PROYECTO
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuID_TIPO_UNID_PRED,
			inuID_PROYECTO
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_TIPO_UNID_PRED_PROY
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_TIPO_UNID_PRED_PROY
	)
	IS
		rfLDC_TIPO_UNID_PRED_PROY tyrfLDC_TIPO_UNID_PRED_PROY;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_TIPO_UNID_PRED_PROY.*, LDC_TIPO_UNID_PRED_PROY.rowid FROM LDC_TIPO_UNID_PRED_PROY';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_TIPO_UNID_PRED_PROY for sbFullQuery;

		fetch rfLDC_TIPO_UNID_PRED_PROY bulk collect INTO otbResult;

		close rfLDC_TIPO_UNID_PRED_PROY;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_TIPO_UNID_PRED_PROY.*, LDC_TIPO_UNID_PRED_PROY.rowid FROM LDC_TIPO_UNID_PRED_PROY';
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
		ircLDC_TIPO_UNID_PRED_PROY in styLDC_TIPO_UNID_PRED_PROY
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_TIPO_UNID_PRED_PROY,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_TIPO_UNID_PRED_PROY in styLDC_TIPO_UNID_PRED_PROY,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_TIPO_UNID_PRED_PROY.ID_TIPO_UNID_PRED is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ID_TIPO_UNID_PRED');
			raise ex.controlled_error;
		end if;
		if ircLDC_TIPO_UNID_PRED_PROY.ID_PROYECTO is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ID_PROYECTO');
			raise ex.controlled_error;
		end if;

		insert into LDC_TIPO_UNID_PRED_PROY
		(
			ID_TIPO_UNID_PRED,
			DESCRIPCION,
			ID_PROYECTO
		)
		values
		(
			ircLDC_TIPO_UNID_PRED_PROY.ID_TIPO_UNID_PRED,
			ircLDC_TIPO_UNID_PRED_PROY.DESCRIPCION,
			ircLDC_TIPO_UNID_PRED_PROY.ID_PROYECTO
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_TIPO_UNID_PRED_PROY));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_TIPO_UNID_PRED_PROY in out nocopy tytbLDC_TIPO_UNID_PRED_PROY
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_TIPO_UNID_PRED_PROY,blUseRowID);
		forall n in iotbLDC_TIPO_UNID_PRED_PROY.first..iotbLDC_TIPO_UNID_PRED_PROY.last
			insert into LDC_TIPO_UNID_PRED_PROY
			(
				ID_TIPO_UNID_PRED,
				DESCRIPCION,
				ID_PROYECTO
			)
			values
			(
				rcRecOfTab.ID_TIPO_UNID_PRED(n),
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
		inuID_TIPO_UNID_PRED in LDC_TIPO_UNID_PRED_PROY.ID_TIPO_UNID_PRED%type,
		inuID_PROYECTO in LDC_TIPO_UNID_PRED_PROY.ID_PROYECTO%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_TIPO_UNID_PRED_PROY;
	BEGIN
		rcError.ID_TIPO_UNID_PRED := inuID_TIPO_UNID_PRED;
		rcError.ID_PROYECTO := inuID_PROYECTO;

		if inuLock=1 then
			LockByPk
			(
				inuID_TIPO_UNID_PRED,
				inuID_PROYECTO,
				rcData
			);
		end if;


		delete
		from LDC_TIPO_UNID_PRED_PROY
		where
       		ID_TIPO_UNID_PRED=inuID_TIPO_UNID_PRED and
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
		rcError  styLDC_TIPO_UNID_PRED_PROY;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_TIPO_UNID_PRED_PROY
		where
			rowid = iriRowID
		returning
			ID_TIPO_UNID_PRED,
			DESCRIPCION
		into
			rcError.ID_TIPO_UNID_PRED,
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
		iotbLDC_TIPO_UNID_PRED_PROY in out nocopy tytbLDC_TIPO_UNID_PRED_PROY,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_TIPO_UNID_PRED_PROY;
	BEGIN
		FillRecordOfTables(iotbLDC_TIPO_UNID_PRED_PROY, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_TIPO_UNID_PRED_PROY.first .. iotbLDC_TIPO_UNID_PRED_PROY.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_TIPO_UNID_PRED_PROY.first .. iotbLDC_TIPO_UNID_PRED_PROY.last
				delete
				from LDC_TIPO_UNID_PRED_PROY
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_TIPO_UNID_PRED_PROY.first .. iotbLDC_TIPO_UNID_PRED_PROY.last loop
					LockByPk
					(
						rcRecOfTab.ID_TIPO_UNID_PRED(n),
						rcRecOfTab.ID_PROYECTO(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_TIPO_UNID_PRED_PROY.first .. iotbLDC_TIPO_UNID_PRED_PROY.last
				delete
				from LDC_TIPO_UNID_PRED_PROY
				where
		         	ID_TIPO_UNID_PRED = rcRecOfTab.ID_TIPO_UNID_PRED(n) and
		         	ID_PROYECTO = rcRecOfTab.ID_PROYECTO(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_TIPO_UNID_PRED_PROY in styLDC_TIPO_UNID_PRED_PROY,
		inuLock in number default 0
	)
	IS
		nuID_TIPO_UNID_PRED	LDC_TIPO_UNID_PRED_PROY.ID_TIPO_UNID_PRED%type;
		nuID_PROYECTO	LDC_TIPO_UNID_PRED_PROY.ID_PROYECTO%type;
	BEGIN
		if ircLDC_TIPO_UNID_PRED_PROY.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_TIPO_UNID_PRED_PROY.rowid,rcData);
			end if;
			update LDC_TIPO_UNID_PRED_PROY
			set
				DESCRIPCION = ircLDC_TIPO_UNID_PRED_PROY.DESCRIPCION
			where
				rowid = ircLDC_TIPO_UNID_PRED_PROY.rowid
			returning
				ID_TIPO_UNID_PRED,
				ID_PROYECTO
			into
				nuID_TIPO_UNID_PRED,
				nuID_PROYECTO;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_TIPO_UNID_PRED_PROY.ID_TIPO_UNID_PRED,
					ircLDC_TIPO_UNID_PRED_PROY.ID_PROYECTO,
					rcData
				);
			end if;

			update LDC_TIPO_UNID_PRED_PROY
			set
				DESCRIPCION = ircLDC_TIPO_UNID_PRED_PROY.DESCRIPCION
			where
				ID_TIPO_UNID_PRED = ircLDC_TIPO_UNID_PRED_PROY.ID_TIPO_UNID_PRED and
				ID_PROYECTO = ircLDC_TIPO_UNID_PRED_PROY.ID_PROYECTO
			returning
				ID_TIPO_UNID_PRED,
				ID_PROYECTO
			into
				nuID_TIPO_UNID_PRED,
				nuID_PROYECTO;
		end if;
		if
			nuID_TIPO_UNID_PRED is NULL OR
			nuID_PROYECTO is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_TIPO_UNID_PRED_PROY));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_TIPO_UNID_PRED_PROY in out nocopy tytbLDC_TIPO_UNID_PRED_PROY,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_TIPO_UNID_PRED_PROY;
	BEGIN
		FillRecordOfTables(iotbLDC_TIPO_UNID_PRED_PROY,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_TIPO_UNID_PRED_PROY.first .. iotbLDC_TIPO_UNID_PRED_PROY.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_TIPO_UNID_PRED_PROY.first .. iotbLDC_TIPO_UNID_PRED_PROY.last
				update LDC_TIPO_UNID_PRED_PROY
				set
					DESCRIPCION = rcRecOfTab.DESCRIPCION(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_TIPO_UNID_PRED_PROY.first .. iotbLDC_TIPO_UNID_PRED_PROY.last loop
					LockByPk
					(
						rcRecOfTab.ID_TIPO_UNID_PRED(n),
						rcRecOfTab.ID_PROYECTO(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_TIPO_UNID_PRED_PROY.first .. iotbLDC_TIPO_UNID_PRED_PROY.last
				update LDC_TIPO_UNID_PRED_PROY
				SET
					DESCRIPCION = rcRecOfTab.DESCRIPCION(n)
				where
					ID_TIPO_UNID_PRED = rcRecOfTab.ID_TIPO_UNID_PRED(n) and
					ID_PROYECTO = rcRecOfTab.ID_PROYECTO(n)
;
		end if;
	END;
	PROCEDURE updDESCRIPCION
	(
		inuID_TIPO_UNID_PRED in LDC_TIPO_UNID_PRED_PROY.ID_TIPO_UNID_PRED%type,
		inuID_PROYECTO in LDC_TIPO_UNID_PRED_PROY.ID_PROYECTO%type,
		isbDESCRIPCION$ in LDC_TIPO_UNID_PRED_PROY.DESCRIPCION%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_TIPO_UNID_PRED_PROY;
	BEGIN
		rcError.ID_TIPO_UNID_PRED := inuID_TIPO_UNID_PRED;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		if inuLock=1 then
			LockByPk
			(
				inuID_TIPO_UNID_PRED,
				inuID_PROYECTO,
				rcData
			);
		end if;

		update LDC_TIPO_UNID_PRED_PROY
		set
			DESCRIPCION = isbDESCRIPCION$
		where
			ID_TIPO_UNID_PRED = inuID_TIPO_UNID_PRED and
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
	FUNCTION fnuGetID_TIPO_UNID_PRED
	(
		inuID_TIPO_UNID_PRED in LDC_TIPO_UNID_PRED_PROY.ID_TIPO_UNID_PRED%type,
		inuID_PROYECTO in LDC_TIPO_UNID_PRED_PROY.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPO_UNID_PRED_PROY.ID_TIPO_UNID_PRED%type
	IS
		rcError styLDC_TIPO_UNID_PRED_PROY;
	BEGIN

		rcError.ID_TIPO_UNID_PRED := inuID_TIPO_UNID_PRED;
		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_TIPO_UNID_PRED,
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.ID_TIPO_UNID_PRED);
		end if;
		Load
		(
		 		inuID_TIPO_UNID_PRED,
		 		inuID_PROYECTO
		);
		return(rcData.ID_TIPO_UNID_PRED);
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
		inuID_TIPO_UNID_PRED in LDC_TIPO_UNID_PRED_PROY.ID_TIPO_UNID_PRED%type,
		inuID_PROYECTO in LDC_TIPO_UNID_PRED_PROY.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPO_UNID_PRED_PROY.DESCRIPCION%type
	IS
		rcError styLDC_TIPO_UNID_PRED_PROY;
	BEGIN

		rcError.ID_TIPO_UNID_PRED := inuID_TIPO_UNID_PRED;
		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_TIPO_UNID_PRED,
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.DESCRIPCION);
		end if;
		Load
		(
		 		inuID_TIPO_UNID_PRED,
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
		inuID_TIPO_UNID_PRED in LDC_TIPO_UNID_PRED_PROY.ID_TIPO_UNID_PRED%type,
		inuID_PROYECTO in LDC_TIPO_UNID_PRED_PROY.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPO_UNID_PRED_PROY.ID_PROYECTO%type
	IS
		rcError styLDC_TIPO_UNID_PRED_PROY;
	BEGIN

		rcError.ID_TIPO_UNID_PRED := inuID_TIPO_UNID_PRED;
		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_TIPO_UNID_PRED,
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.ID_PROYECTO);
		end if;
		Load
		(
		 		inuID_TIPO_UNID_PRED,
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
end DALDC_TIPO_UNID_PRED_PROY;
/
PROMPT Otorgando permisos de ejecucion a DALDC_TIPO_UNID_PRED_PROY
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_TIPO_UNID_PRED_PROY', 'ADM_PERSON');
END;
/