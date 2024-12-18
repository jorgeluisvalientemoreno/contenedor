CREATE OR REPLACE PACKAGE ADM_PERSON.DALDC_TIPOS_TRABAJO_COT
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
		inuID_PROYECTO in LDC_TIPOS_TRABAJO_COT.ID_PROYECTO%type,
		inuID_COTIZACION_DETALLADA in LDC_TIPOS_TRABAJO_COT.ID_COTIZACION_DETALLADA%type,
		isbTIPO_TRABAJO_DESC in LDC_TIPOS_TRABAJO_COT.TIPO_TRABAJO_DESC%type
	)
	IS
		SELECT LDC_TIPOS_TRABAJO_COT.*,LDC_TIPOS_TRABAJO_COT.rowid
		FROM LDC_TIPOS_TRABAJO_COT
		WHERE
		    ID_PROYECTO = inuID_PROYECTO
		    and ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA
		    and TIPO_TRABAJO_DESC = isbTIPO_TRABAJO_DESC;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_TIPOS_TRABAJO_COT.*,LDC_TIPOS_TRABAJO_COT.rowid
		FROM LDC_TIPOS_TRABAJO_COT
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_TIPOS_TRABAJO_COT  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_TIPOS_TRABAJO_COT is table of styLDC_TIPOS_TRABAJO_COT index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_TIPOS_TRABAJO_COT;

	/* Tipos referenciando al registro */
	type tytbID_PROYECTO is table of LDC_TIPOS_TRABAJO_COT.ID_PROYECTO%type index by binary_integer;
	type tytbID_ACTIVIDAD_PRINCIPAL is table of LDC_TIPOS_TRABAJO_COT.ID_ACTIVIDAD_PRINCIPAL%type index by binary_integer;
	type tytbTIPO_TRABAJO_DESC is table of LDC_TIPOS_TRABAJO_COT.TIPO_TRABAJO_DESC%type index by binary_integer;
	type tytbID_COTIZACION_DETALLADA is table of LDC_TIPOS_TRABAJO_COT.ID_COTIZACION_DETALLADA%type index by binary_integer;
	type tytbID_TIPO_TRABAJO is table of LDC_TIPOS_TRABAJO_COT.ID_TIPO_TRABAJO%type index by binary_integer;
	type tytbESTA_INI_ORDEN is table of LDC_TIPOS_TRABAJO_COT.ESTA_INI_ORDEN%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_TIPOS_TRABAJO_COT is record
	(
		ID_PROYECTO   tytbID_PROYECTO,
		ID_ACTIVIDAD_PRINCIPAL   tytbID_ACTIVIDAD_PRINCIPAL,
		TIPO_TRABAJO_DESC   tytbTIPO_TRABAJO_DESC,
		ID_COTIZACION_DETALLADA   tytbID_COTIZACION_DETALLADA,
		ID_TIPO_TRABAJO   tytbID_TIPO_TRABAJO,
		ESTA_INI_ORDEN   tytbESTA_INI_ORDEN,
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
		inuID_PROYECTO in LDC_TIPOS_TRABAJO_COT.ID_PROYECTO%type,
		inuID_COTIZACION_DETALLADA in LDC_TIPOS_TRABAJO_COT.ID_COTIZACION_DETALLADA%type,
		isbTIPO_TRABAJO_DESC in LDC_TIPOS_TRABAJO_COT.TIPO_TRABAJO_DESC%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuID_PROYECTO in LDC_TIPOS_TRABAJO_COT.ID_PROYECTO%type,
		inuID_COTIZACION_DETALLADA in LDC_TIPOS_TRABAJO_COT.ID_COTIZACION_DETALLADA%type,
		isbTIPO_TRABAJO_DESC in LDC_TIPOS_TRABAJO_COT.TIPO_TRABAJO_DESC%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuID_PROYECTO in LDC_TIPOS_TRABAJO_COT.ID_PROYECTO%type,
		inuID_COTIZACION_DETALLADA in LDC_TIPOS_TRABAJO_COT.ID_COTIZACION_DETALLADA%type,
		isbTIPO_TRABAJO_DESC in LDC_TIPOS_TRABAJO_COT.TIPO_TRABAJO_DESC%type
	);

	PROCEDURE getRecord
	(
		inuID_PROYECTO in LDC_TIPOS_TRABAJO_COT.ID_PROYECTO%type,
		inuID_COTIZACION_DETALLADA in LDC_TIPOS_TRABAJO_COT.ID_COTIZACION_DETALLADA%type,
		isbTIPO_TRABAJO_DESC in LDC_TIPOS_TRABAJO_COT.TIPO_TRABAJO_DESC%type,
		orcRecord out nocopy styLDC_TIPOS_TRABAJO_COT
	);

	FUNCTION frcGetRcData
	(
		inuID_PROYECTO in LDC_TIPOS_TRABAJO_COT.ID_PROYECTO%type,
		inuID_COTIZACION_DETALLADA in LDC_TIPOS_TRABAJO_COT.ID_COTIZACION_DETALLADA%type,
		isbTIPO_TRABAJO_DESC in LDC_TIPOS_TRABAJO_COT.TIPO_TRABAJO_DESC%type
	)
	RETURN styLDC_TIPOS_TRABAJO_COT;

	FUNCTION frcGetRcData
	RETURN styLDC_TIPOS_TRABAJO_COT;

	FUNCTION frcGetRecord
	(
		inuID_PROYECTO in LDC_TIPOS_TRABAJO_COT.ID_PROYECTO%type,
		inuID_COTIZACION_DETALLADA in LDC_TIPOS_TRABAJO_COT.ID_COTIZACION_DETALLADA%type,
		isbTIPO_TRABAJO_DESC in LDC_TIPOS_TRABAJO_COT.TIPO_TRABAJO_DESC%type
	)
	RETURN styLDC_TIPOS_TRABAJO_COT;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_TIPOS_TRABAJO_COT
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_TIPOS_TRABAJO_COT in styLDC_TIPOS_TRABAJO_COT
	);

	PROCEDURE insRecord
	(
		ircLDC_TIPOS_TRABAJO_COT in styLDC_TIPOS_TRABAJO_COT,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_TIPOS_TRABAJO_COT in out nocopy tytbLDC_TIPOS_TRABAJO_COT
	);

	PROCEDURE delRecord
	(
		inuID_PROYECTO in LDC_TIPOS_TRABAJO_COT.ID_PROYECTO%type,
		inuID_COTIZACION_DETALLADA in LDC_TIPOS_TRABAJO_COT.ID_COTIZACION_DETALLADA%type,
		isbTIPO_TRABAJO_DESC in LDC_TIPOS_TRABAJO_COT.TIPO_TRABAJO_DESC%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_TIPOS_TRABAJO_COT in out nocopy tytbLDC_TIPOS_TRABAJO_COT,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_TIPOS_TRABAJO_COT in styLDC_TIPOS_TRABAJO_COT,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_TIPOS_TRABAJO_COT in out nocopy tytbLDC_TIPOS_TRABAJO_COT,
		inuLock in number default 1
	);

	PROCEDURE updID_ACTIVIDAD_PRINCIPAL
	(
		inuID_PROYECTO in LDC_TIPOS_TRABAJO_COT.ID_PROYECTO%type,
		inuID_COTIZACION_DETALLADA in LDC_TIPOS_TRABAJO_COT.ID_COTIZACION_DETALLADA%type,
		isbTIPO_TRABAJO_DESC in LDC_TIPOS_TRABAJO_COT.TIPO_TRABAJO_DESC%type,
		inuID_ACTIVIDAD_PRINCIPAL$ in LDC_TIPOS_TRABAJO_COT.ID_ACTIVIDAD_PRINCIPAL%type,
		inuLock in number default 0
	);

	PROCEDURE updID_TIPO_TRABAJO
	(
		inuID_PROYECTO in LDC_TIPOS_TRABAJO_COT.ID_PROYECTO%type,
		inuID_COTIZACION_DETALLADA in LDC_TIPOS_TRABAJO_COT.ID_COTIZACION_DETALLADA%type,
		isbTIPO_TRABAJO_DESC in LDC_TIPOS_TRABAJO_COT.TIPO_TRABAJO_DESC%type,
		inuID_TIPO_TRABAJO$ in LDC_TIPOS_TRABAJO_COT.ID_TIPO_TRABAJO%type,
		inuLock in number default 0
	);

	PROCEDURE updESTA_INI_ORDEN
	(
		inuID_PROYECTO in LDC_TIPOS_TRABAJO_COT.ID_PROYECTO%type,
		inuID_COTIZACION_DETALLADA in LDC_TIPOS_TRABAJO_COT.ID_COTIZACION_DETALLADA%type,
		isbTIPO_TRABAJO_DESC in LDC_TIPOS_TRABAJO_COT.TIPO_TRABAJO_DESC%type,
		inuESTA_INI_ORDEN$ in LDC_TIPOS_TRABAJO_COT.ESTA_INI_ORDEN%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetID_PROYECTO
	(
		inuID_PROYECTO in LDC_TIPOS_TRABAJO_COT.ID_PROYECTO%type,
		inuID_COTIZACION_DETALLADA in LDC_TIPOS_TRABAJO_COT.ID_COTIZACION_DETALLADA%type,
		isbTIPO_TRABAJO_DESC in LDC_TIPOS_TRABAJO_COT.TIPO_TRABAJO_DESC%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPOS_TRABAJO_COT.ID_PROYECTO%type;

	FUNCTION fnuGetID_ACTIVIDAD_PRINCIPAL
	(
		inuID_PROYECTO in LDC_TIPOS_TRABAJO_COT.ID_PROYECTO%type,
		inuID_COTIZACION_DETALLADA in LDC_TIPOS_TRABAJO_COT.ID_COTIZACION_DETALLADA%type,
		isbTIPO_TRABAJO_DESC in LDC_TIPOS_TRABAJO_COT.TIPO_TRABAJO_DESC%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPOS_TRABAJO_COT.ID_ACTIVIDAD_PRINCIPAL%type;

	FUNCTION fsbGetTIPO_TRABAJO_DESC
	(
		inuID_PROYECTO in LDC_TIPOS_TRABAJO_COT.ID_PROYECTO%type,
		inuID_COTIZACION_DETALLADA in LDC_TIPOS_TRABAJO_COT.ID_COTIZACION_DETALLADA%type,
		isbTIPO_TRABAJO_DESC in LDC_TIPOS_TRABAJO_COT.TIPO_TRABAJO_DESC%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPOS_TRABAJO_COT.TIPO_TRABAJO_DESC%type;

	FUNCTION fnuGetID_COTIZACION_DETALLADA
	(
		inuID_PROYECTO in LDC_TIPOS_TRABAJO_COT.ID_PROYECTO%type,
		inuID_COTIZACION_DETALLADA in LDC_TIPOS_TRABAJO_COT.ID_COTIZACION_DETALLADA%type,
		isbTIPO_TRABAJO_DESC in LDC_TIPOS_TRABAJO_COT.TIPO_TRABAJO_DESC%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPOS_TRABAJO_COT.ID_COTIZACION_DETALLADA%type;

	FUNCTION fnuGetID_TIPO_TRABAJO
	(
		inuID_PROYECTO in LDC_TIPOS_TRABAJO_COT.ID_PROYECTO%type,
		inuID_COTIZACION_DETALLADA in LDC_TIPOS_TRABAJO_COT.ID_COTIZACION_DETALLADA%type,
		isbTIPO_TRABAJO_DESC in LDC_TIPOS_TRABAJO_COT.TIPO_TRABAJO_DESC%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPOS_TRABAJO_COT.ID_TIPO_TRABAJO%type;

	FUNCTION fnuGetESTA_INI_ORDEN
	(
		inuID_PROYECTO in LDC_TIPOS_TRABAJO_COT.ID_PROYECTO%type,
		inuID_COTIZACION_DETALLADA in LDC_TIPOS_TRABAJO_COT.ID_COTIZACION_DETALLADA%type,
		isbTIPO_TRABAJO_DESC in LDC_TIPOS_TRABAJO_COT.TIPO_TRABAJO_DESC%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPOS_TRABAJO_COT.ESTA_INI_ORDEN%type;


	PROCEDURE LockByPk
	(
		inuID_PROYECTO in LDC_TIPOS_TRABAJO_COT.ID_PROYECTO%type,
		inuID_COTIZACION_DETALLADA in LDC_TIPOS_TRABAJO_COT.ID_COTIZACION_DETALLADA%type,
		isbTIPO_TRABAJO_DESC in LDC_TIPOS_TRABAJO_COT.TIPO_TRABAJO_DESC%type,
		orcLDC_TIPOS_TRABAJO_COT  out styLDC_TIPOS_TRABAJO_COT
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_TIPOS_TRABAJO_COT  out styLDC_TIPOS_TRABAJO_COT
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_TIPOS_TRABAJO_COT;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALDC_TIPOS_TRABAJO_COT
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_TIPOS_TRABAJO_COT';
	 cnuGeEntityId constant varchar2(30) := 2865; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuID_PROYECTO in LDC_TIPOS_TRABAJO_COT.ID_PROYECTO%type,
		inuID_COTIZACION_DETALLADA in LDC_TIPOS_TRABAJO_COT.ID_COTIZACION_DETALLADA%type,
		isbTIPO_TRABAJO_DESC in LDC_TIPOS_TRABAJO_COT.TIPO_TRABAJO_DESC%type
	)
	IS
		SELECT LDC_TIPOS_TRABAJO_COT.*,LDC_TIPOS_TRABAJO_COT.rowid
		FROM LDC_TIPOS_TRABAJO_COT
		WHERE  ID_PROYECTO = inuID_PROYECTO
			and ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA
			and TIPO_TRABAJO_DESC = isbTIPO_TRABAJO_DESC
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_TIPOS_TRABAJO_COT.*,LDC_TIPOS_TRABAJO_COT.rowid
		FROM LDC_TIPOS_TRABAJO_COT
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_TIPOS_TRABAJO_COT is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_TIPOS_TRABAJO_COT;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_TIPOS_TRABAJO_COT default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.ID_PROYECTO);
		sbPk:=sbPk||','||ut_convert.fsbToChar(rcI.ID_COTIZACION_DETALLADA);
		sbPk:=sbPk||','||ut_convert.fsbToChar(rcI.TIPO_TRABAJO_DESC);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuID_PROYECTO in LDC_TIPOS_TRABAJO_COT.ID_PROYECTO%type,
		inuID_COTIZACION_DETALLADA in LDC_TIPOS_TRABAJO_COT.ID_COTIZACION_DETALLADA%type,
		isbTIPO_TRABAJO_DESC in LDC_TIPOS_TRABAJO_COT.TIPO_TRABAJO_DESC%type,
		orcLDC_TIPOS_TRABAJO_COT  out styLDC_TIPOS_TRABAJO_COT
	)
	IS
		rcError styLDC_TIPOS_TRABAJO_COT;
	BEGIN
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.TIPO_TRABAJO_DESC := isbTIPO_TRABAJO_DESC;

		Open cuLockRcByPk
		(
			inuID_PROYECTO,
			inuID_COTIZACION_DETALLADA,
			isbTIPO_TRABAJO_DESC
		);

		fetch cuLockRcByPk into orcLDC_TIPOS_TRABAJO_COT;
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
		orcLDC_TIPOS_TRABAJO_COT  out styLDC_TIPOS_TRABAJO_COT
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_TIPOS_TRABAJO_COT;
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
		itbLDC_TIPOS_TRABAJO_COT  in out nocopy tytbLDC_TIPOS_TRABAJO_COT
	)
	IS
	BEGIN
			rcRecOfTab.ID_PROYECTO.delete;
			rcRecOfTab.ID_ACTIVIDAD_PRINCIPAL.delete;
			rcRecOfTab.TIPO_TRABAJO_DESC.delete;
			rcRecOfTab.ID_COTIZACION_DETALLADA.delete;
			rcRecOfTab.ID_TIPO_TRABAJO.delete;
			rcRecOfTab.ESTA_INI_ORDEN.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_TIPOS_TRABAJO_COT  in out nocopy tytbLDC_TIPOS_TRABAJO_COT,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_TIPOS_TRABAJO_COT);

		for n in itbLDC_TIPOS_TRABAJO_COT.first .. itbLDC_TIPOS_TRABAJO_COT.last loop
			rcRecOfTab.ID_PROYECTO(n) := itbLDC_TIPOS_TRABAJO_COT(n).ID_PROYECTO;
			rcRecOfTab.ID_ACTIVIDAD_PRINCIPAL(n) := itbLDC_TIPOS_TRABAJO_COT(n).ID_ACTIVIDAD_PRINCIPAL;
			rcRecOfTab.TIPO_TRABAJO_DESC(n) := itbLDC_TIPOS_TRABAJO_COT(n).TIPO_TRABAJO_DESC;
			rcRecOfTab.ID_COTIZACION_DETALLADA(n) := itbLDC_TIPOS_TRABAJO_COT(n).ID_COTIZACION_DETALLADA;
			rcRecOfTab.ID_TIPO_TRABAJO(n) := itbLDC_TIPOS_TRABAJO_COT(n).ID_TIPO_TRABAJO;
			rcRecOfTab.ESTA_INI_ORDEN(n) := itbLDC_TIPOS_TRABAJO_COT(n).ESTA_INI_ORDEN;
			rcRecOfTab.row_id(n) := itbLDC_TIPOS_TRABAJO_COT(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuID_PROYECTO in LDC_TIPOS_TRABAJO_COT.ID_PROYECTO%type,
		inuID_COTIZACION_DETALLADA in LDC_TIPOS_TRABAJO_COT.ID_COTIZACION_DETALLADA%type,
		isbTIPO_TRABAJO_DESC in LDC_TIPOS_TRABAJO_COT.TIPO_TRABAJO_DESC%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuID_PROYECTO,
			inuID_COTIZACION_DETALLADA,
			isbTIPO_TRABAJO_DESC
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
		inuID_PROYECTO in LDC_TIPOS_TRABAJO_COT.ID_PROYECTO%type,
		inuID_COTIZACION_DETALLADA in LDC_TIPOS_TRABAJO_COT.ID_COTIZACION_DETALLADA%type,
		isbTIPO_TRABAJO_DESC in LDC_TIPOS_TRABAJO_COT.TIPO_TRABAJO_DESC%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuID_PROYECTO = rcData.ID_PROYECTO AND
			inuID_COTIZACION_DETALLADA = rcData.ID_COTIZACION_DETALLADA AND
			isbTIPO_TRABAJO_DESC = rcData.TIPO_TRABAJO_DESC
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
		inuID_PROYECTO in LDC_TIPOS_TRABAJO_COT.ID_PROYECTO%type,
		inuID_COTIZACION_DETALLADA in LDC_TIPOS_TRABAJO_COT.ID_COTIZACION_DETALLADA%type,
		isbTIPO_TRABAJO_DESC in LDC_TIPOS_TRABAJO_COT.TIPO_TRABAJO_DESC%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuID_PROYECTO,
			inuID_COTIZACION_DETALLADA,
			isbTIPO_TRABAJO_DESC
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuID_PROYECTO in LDC_TIPOS_TRABAJO_COT.ID_PROYECTO%type,
		inuID_COTIZACION_DETALLADA in LDC_TIPOS_TRABAJO_COT.ID_COTIZACION_DETALLADA%type,
		isbTIPO_TRABAJO_DESC in LDC_TIPOS_TRABAJO_COT.TIPO_TRABAJO_DESC%type
	)
	IS
		rcError styLDC_TIPOS_TRABAJO_COT;
	BEGIN		rcError.ID_PROYECTO:=inuID_PROYECTO;		rcError.ID_COTIZACION_DETALLADA:=inuID_COTIZACION_DETALLADA;		rcError.TIPO_TRABAJO_DESC:=isbTIPO_TRABAJO_DESC;

		Load
		(
			inuID_PROYECTO,
			inuID_COTIZACION_DETALLADA,
			isbTIPO_TRABAJO_DESC
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
		inuID_PROYECTO in LDC_TIPOS_TRABAJO_COT.ID_PROYECTO%type,
		inuID_COTIZACION_DETALLADA in LDC_TIPOS_TRABAJO_COT.ID_COTIZACION_DETALLADA%type,
		isbTIPO_TRABAJO_DESC in LDC_TIPOS_TRABAJO_COT.TIPO_TRABAJO_DESC%type
	)
	IS
	BEGIN
		Load
		(
			inuID_PROYECTO,
			inuID_COTIZACION_DETALLADA,
			isbTIPO_TRABAJO_DESC
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuID_PROYECTO in LDC_TIPOS_TRABAJO_COT.ID_PROYECTO%type,
		inuID_COTIZACION_DETALLADA in LDC_TIPOS_TRABAJO_COT.ID_COTIZACION_DETALLADA%type,
		isbTIPO_TRABAJO_DESC in LDC_TIPOS_TRABAJO_COT.TIPO_TRABAJO_DESC%type,
		orcRecord out nocopy styLDC_TIPOS_TRABAJO_COT
	)
	IS
		rcError styLDC_TIPOS_TRABAJO_COT;
	BEGIN		rcError.ID_PROYECTO:=inuID_PROYECTO;		rcError.ID_COTIZACION_DETALLADA:=inuID_COTIZACION_DETALLADA;		rcError.TIPO_TRABAJO_DESC:=isbTIPO_TRABAJO_DESC;

		Load
		(
			inuID_PROYECTO,
			inuID_COTIZACION_DETALLADA,
			isbTIPO_TRABAJO_DESC
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuID_PROYECTO in LDC_TIPOS_TRABAJO_COT.ID_PROYECTO%type,
		inuID_COTIZACION_DETALLADA in LDC_TIPOS_TRABAJO_COT.ID_COTIZACION_DETALLADA%type,
		isbTIPO_TRABAJO_DESC in LDC_TIPOS_TRABAJO_COT.TIPO_TRABAJO_DESC%type
	)
	RETURN styLDC_TIPOS_TRABAJO_COT
	IS
		rcError styLDC_TIPOS_TRABAJO_COT;
	BEGIN
		rcError.ID_PROYECTO:=inuID_PROYECTO;
		rcError.ID_COTIZACION_DETALLADA:=inuID_COTIZACION_DETALLADA;
		rcError.TIPO_TRABAJO_DESC:=isbTIPO_TRABAJO_DESC;

		Load
		(
			inuID_PROYECTO,
			inuID_COTIZACION_DETALLADA,
			isbTIPO_TRABAJO_DESC
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuID_PROYECTO in LDC_TIPOS_TRABAJO_COT.ID_PROYECTO%type,
		inuID_COTIZACION_DETALLADA in LDC_TIPOS_TRABAJO_COT.ID_COTIZACION_DETALLADA%type,
		isbTIPO_TRABAJO_DESC in LDC_TIPOS_TRABAJO_COT.TIPO_TRABAJO_DESC%type
	)
	RETURN styLDC_TIPOS_TRABAJO_COT
	IS
		rcError styLDC_TIPOS_TRABAJO_COT;
	BEGIN
		rcError.ID_PROYECTO:=inuID_PROYECTO;
		rcError.ID_COTIZACION_DETALLADA:=inuID_COTIZACION_DETALLADA;
		rcError.TIPO_TRABAJO_DESC:=isbTIPO_TRABAJO_DESC;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuID_PROYECTO,
			inuID_COTIZACION_DETALLADA,
			isbTIPO_TRABAJO_DESC
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuID_PROYECTO,
			inuID_COTIZACION_DETALLADA,
			isbTIPO_TRABAJO_DESC
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_TIPOS_TRABAJO_COT
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_TIPOS_TRABAJO_COT
	)
	IS
		rfLDC_TIPOS_TRABAJO_COT tyrfLDC_TIPOS_TRABAJO_COT;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_TIPOS_TRABAJO_COT.*, LDC_TIPOS_TRABAJO_COT.rowid FROM LDC_TIPOS_TRABAJO_COT';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_TIPOS_TRABAJO_COT for sbFullQuery;

		fetch rfLDC_TIPOS_TRABAJO_COT bulk collect INTO otbResult;

		close rfLDC_TIPOS_TRABAJO_COT;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_TIPOS_TRABAJO_COT.*, LDC_TIPOS_TRABAJO_COT.rowid FROM LDC_TIPOS_TRABAJO_COT';
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
		ircLDC_TIPOS_TRABAJO_COT in styLDC_TIPOS_TRABAJO_COT
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_TIPOS_TRABAJO_COT,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_TIPOS_TRABAJO_COT in styLDC_TIPOS_TRABAJO_COT,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_TIPOS_TRABAJO_COT.ID_PROYECTO is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ID_PROYECTO');
			raise ex.controlled_error;
		end if;
		if ircLDC_TIPOS_TRABAJO_COT.ID_COTIZACION_DETALLADA is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ID_COTIZACION_DETALLADA');
			raise ex.controlled_error;
		end if;
		if ircLDC_TIPOS_TRABAJO_COT.TIPO_TRABAJO_DESC is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|TIPO_TRABAJO_DESC');
			raise ex.controlled_error;
		end if;

		insert into LDC_TIPOS_TRABAJO_COT
		(
			ID_PROYECTO,
			ID_ACTIVIDAD_PRINCIPAL,
			TIPO_TRABAJO_DESC,
			ID_COTIZACION_DETALLADA,
			ID_TIPO_TRABAJO,
			ESTA_INI_ORDEN
		)
		values
		(
			ircLDC_TIPOS_TRABAJO_COT.ID_PROYECTO,
			ircLDC_TIPOS_TRABAJO_COT.ID_ACTIVIDAD_PRINCIPAL,
			ircLDC_TIPOS_TRABAJO_COT.TIPO_TRABAJO_DESC,
			ircLDC_TIPOS_TRABAJO_COT.ID_COTIZACION_DETALLADA,
			ircLDC_TIPOS_TRABAJO_COT.ID_TIPO_TRABAJO,
			ircLDC_TIPOS_TRABAJO_COT.ESTA_INI_ORDEN
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_TIPOS_TRABAJO_COT));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_TIPOS_TRABAJO_COT in out nocopy tytbLDC_TIPOS_TRABAJO_COT
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_TIPOS_TRABAJO_COT,blUseRowID);
		forall n in iotbLDC_TIPOS_TRABAJO_COT.first..iotbLDC_TIPOS_TRABAJO_COT.last
			insert into LDC_TIPOS_TRABAJO_COT
			(
				ID_PROYECTO,
				ID_ACTIVIDAD_PRINCIPAL,
				TIPO_TRABAJO_DESC,
				ID_COTIZACION_DETALLADA,
				ID_TIPO_TRABAJO,
				ESTA_INI_ORDEN
			)
			values
			(
				rcRecOfTab.ID_PROYECTO(n),
				rcRecOfTab.ID_ACTIVIDAD_PRINCIPAL(n),
				rcRecOfTab.TIPO_TRABAJO_DESC(n),
				rcRecOfTab.ID_COTIZACION_DETALLADA(n),
				rcRecOfTab.ID_TIPO_TRABAJO(n),
				rcRecOfTab.ESTA_INI_ORDEN(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuID_PROYECTO in LDC_TIPOS_TRABAJO_COT.ID_PROYECTO%type,
		inuID_COTIZACION_DETALLADA in LDC_TIPOS_TRABAJO_COT.ID_COTIZACION_DETALLADA%type,
		isbTIPO_TRABAJO_DESC in LDC_TIPOS_TRABAJO_COT.TIPO_TRABAJO_DESC%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_TIPOS_TRABAJO_COT;
	BEGIN
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.TIPO_TRABAJO_DESC := isbTIPO_TRABAJO_DESC;

		if inuLock=1 then
			LockByPk
			(
				inuID_PROYECTO,
				inuID_COTIZACION_DETALLADA,
				isbTIPO_TRABAJO_DESC,
				rcData
			);
		end if;


		delete
		from LDC_TIPOS_TRABAJO_COT
		where
       		ID_PROYECTO=inuID_PROYECTO and
       		ID_COTIZACION_DETALLADA=inuID_COTIZACION_DETALLADA and
       		TIPO_TRABAJO_DESC=isbTIPO_TRABAJO_DESC;
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
		rcError  styLDC_TIPOS_TRABAJO_COT;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_TIPOS_TRABAJO_COT
		where
			rowid = iriRowID
		returning
			ID_PROYECTO,
			ID_ACTIVIDAD_PRINCIPAL,
			TIPO_TRABAJO_DESC
		into
			rcError.ID_PROYECTO,
			rcError.ID_ACTIVIDAD_PRINCIPAL,
			rcError.TIPO_TRABAJO_DESC;
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
		iotbLDC_TIPOS_TRABAJO_COT in out nocopy tytbLDC_TIPOS_TRABAJO_COT,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_TIPOS_TRABAJO_COT;
	BEGIN
		FillRecordOfTables(iotbLDC_TIPOS_TRABAJO_COT, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_TIPOS_TRABAJO_COT.first .. iotbLDC_TIPOS_TRABAJO_COT.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_TIPOS_TRABAJO_COT.first .. iotbLDC_TIPOS_TRABAJO_COT.last
				delete
				from LDC_TIPOS_TRABAJO_COT
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_TIPOS_TRABAJO_COT.first .. iotbLDC_TIPOS_TRABAJO_COT.last loop
					LockByPk
					(
						rcRecOfTab.ID_PROYECTO(n),
						rcRecOfTab.ID_COTIZACION_DETALLADA(n),
						rcRecOfTab.TIPO_TRABAJO_DESC(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_TIPOS_TRABAJO_COT.first .. iotbLDC_TIPOS_TRABAJO_COT.last
				delete
				from LDC_TIPOS_TRABAJO_COT
				where
		         	ID_PROYECTO = rcRecOfTab.ID_PROYECTO(n) and
		         	ID_COTIZACION_DETALLADA = rcRecOfTab.ID_COTIZACION_DETALLADA(n) and
		         	TIPO_TRABAJO_DESC = rcRecOfTab.TIPO_TRABAJO_DESC(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_TIPOS_TRABAJO_COT in styLDC_TIPOS_TRABAJO_COT,
		inuLock in number default 0
	)
	IS
		nuID_PROYECTO	LDC_TIPOS_TRABAJO_COT.ID_PROYECTO%type;
		nuID_COTIZACION_DETALLADA	LDC_TIPOS_TRABAJO_COT.ID_COTIZACION_DETALLADA%type;
		sbTIPO_TRABAJO_DESC	LDC_TIPOS_TRABAJO_COT.TIPO_TRABAJO_DESC%type;
	BEGIN
		if ircLDC_TIPOS_TRABAJO_COT.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_TIPOS_TRABAJO_COT.rowid,rcData);
			end if;
			update LDC_TIPOS_TRABAJO_COT
			set
				ID_ACTIVIDAD_PRINCIPAL = ircLDC_TIPOS_TRABAJO_COT.ID_ACTIVIDAD_PRINCIPAL,
				ID_TIPO_TRABAJO = ircLDC_TIPOS_TRABAJO_COT.ID_TIPO_TRABAJO,
				ESTA_INI_ORDEN = ircLDC_TIPOS_TRABAJO_COT.ESTA_INI_ORDEN
			where
				rowid = ircLDC_TIPOS_TRABAJO_COT.rowid
			returning
				ID_PROYECTO,
				ID_COTIZACION_DETALLADA,
				TIPO_TRABAJO_DESC
			into
				nuID_PROYECTO,
				nuID_COTIZACION_DETALLADA,
				sbTIPO_TRABAJO_DESC;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_TIPOS_TRABAJO_COT.ID_PROYECTO,
					ircLDC_TIPOS_TRABAJO_COT.ID_COTIZACION_DETALLADA,
					ircLDC_TIPOS_TRABAJO_COT.TIPO_TRABAJO_DESC,
					rcData
				);
			end if;

			update LDC_TIPOS_TRABAJO_COT
			set
				ID_ACTIVIDAD_PRINCIPAL = ircLDC_TIPOS_TRABAJO_COT.ID_ACTIVIDAD_PRINCIPAL,
				ID_TIPO_TRABAJO = ircLDC_TIPOS_TRABAJO_COT.ID_TIPO_TRABAJO,
				ESTA_INI_ORDEN = ircLDC_TIPOS_TRABAJO_COT.ESTA_INI_ORDEN
			where
				ID_PROYECTO = ircLDC_TIPOS_TRABAJO_COT.ID_PROYECTO and
				ID_COTIZACION_DETALLADA = ircLDC_TIPOS_TRABAJO_COT.ID_COTIZACION_DETALLADA and
				TIPO_TRABAJO_DESC = ircLDC_TIPOS_TRABAJO_COT.TIPO_TRABAJO_DESC
			returning
				ID_PROYECTO,
				ID_COTIZACION_DETALLADA,
				TIPO_TRABAJO_DESC
			into
				nuID_PROYECTO,
				nuID_COTIZACION_DETALLADA,
				sbTIPO_TRABAJO_DESC;
		end if;
		if
			nuID_PROYECTO is NULL OR
			nuID_COTIZACION_DETALLADA is NULL OR
			sbTIPO_TRABAJO_DESC is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_TIPOS_TRABAJO_COT));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_TIPOS_TRABAJO_COT in out nocopy tytbLDC_TIPOS_TRABAJO_COT,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_TIPOS_TRABAJO_COT;
	BEGIN
		FillRecordOfTables(iotbLDC_TIPOS_TRABAJO_COT,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_TIPOS_TRABAJO_COT.first .. iotbLDC_TIPOS_TRABAJO_COT.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_TIPOS_TRABAJO_COT.first .. iotbLDC_TIPOS_TRABAJO_COT.last
				update LDC_TIPOS_TRABAJO_COT
				set
					ID_ACTIVIDAD_PRINCIPAL = rcRecOfTab.ID_ACTIVIDAD_PRINCIPAL(n),
					ID_TIPO_TRABAJO = rcRecOfTab.ID_TIPO_TRABAJO(n),
					ESTA_INI_ORDEN = rcRecOfTab.ESTA_INI_ORDEN(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_TIPOS_TRABAJO_COT.first .. iotbLDC_TIPOS_TRABAJO_COT.last loop
					LockByPk
					(
						rcRecOfTab.ID_PROYECTO(n),
						rcRecOfTab.ID_COTIZACION_DETALLADA(n),
						rcRecOfTab.TIPO_TRABAJO_DESC(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_TIPOS_TRABAJO_COT.first .. iotbLDC_TIPOS_TRABAJO_COT.last
				update LDC_TIPOS_TRABAJO_COT
				SET
					ID_ACTIVIDAD_PRINCIPAL = rcRecOfTab.ID_ACTIVIDAD_PRINCIPAL(n),
					ID_TIPO_TRABAJO = rcRecOfTab.ID_TIPO_TRABAJO(n),
					ESTA_INI_ORDEN = rcRecOfTab.ESTA_INI_ORDEN(n)
				where
					ID_PROYECTO = rcRecOfTab.ID_PROYECTO(n) and
					ID_COTIZACION_DETALLADA = rcRecOfTab.ID_COTIZACION_DETALLADA(n) and
					TIPO_TRABAJO_DESC = rcRecOfTab.TIPO_TRABAJO_DESC(n)
;
		end if;
	END;
	PROCEDURE updID_ACTIVIDAD_PRINCIPAL
	(
		inuID_PROYECTO in LDC_TIPOS_TRABAJO_COT.ID_PROYECTO%type,
		inuID_COTIZACION_DETALLADA in LDC_TIPOS_TRABAJO_COT.ID_COTIZACION_DETALLADA%type,
		isbTIPO_TRABAJO_DESC in LDC_TIPOS_TRABAJO_COT.TIPO_TRABAJO_DESC%type,
		inuID_ACTIVIDAD_PRINCIPAL$ in LDC_TIPOS_TRABAJO_COT.ID_ACTIVIDAD_PRINCIPAL%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_TIPOS_TRABAJO_COT;
	BEGIN
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.TIPO_TRABAJO_DESC := isbTIPO_TRABAJO_DESC;
		if inuLock=1 then
			LockByPk
			(
				inuID_PROYECTO,
				inuID_COTIZACION_DETALLADA,
				isbTIPO_TRABAJO_DESC,
				rcData
			);
		end if;

		update LDC_TIPOS_TRABAJO_COT
		set
			ID_ACTIVIDAD_PRINCIPAL = inuID_ACTIVIDAD_PRINCIPAL$
		where
			ID_PROYECTO = inuID_PROYECTO and
			ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA and
			TIPO_TRABAJO_DESC = isbTIPO_TRABAJO_DESC;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ID_ACTIVIDAD_PRINCIPAL:= inuID_ACTIVIDAD_PRINCIPAL$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updID_TIPO_TRABAJO
	(
		inuID_PROYECTO in LDC_TIPOS_TRABAJO_COT.ID_PROYECTO%type,
		inuID_COTIZACION_DETALLADA in LDC_TIPOS_TRABAJO_COT.ID_COTIZACION_DETALLADA%type,
		isbTIPO_TRABAJO_DESC in LDC_TIPOS_TRABAJO_COT.TIPO_TRABAJO_DESC%type,
		inuID_TIPO_TRABAJO$ in LDC_TIPOS_TRABAJO_COT.ID_TIPO_TRABAJO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_TIPOS_TRABAJO_COT;
	BEGIN
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.TIPO_TRABAJO_DESC := isbTIPO_TRABAJO_DESC;
		if inuLock=1 then
			LockByPk
			(
				inuID_PROYECTO,
				inuID_COTIZACION_DETALLADA,
				isbTIPO_TRABAJO_DESC,
				rcData
			);
		end if;

		update LDC_TIPOS_TRABAJO_COT
		set
			ID_TIPO_TRABAJO = inuID_TIPO_TRABAJO$
		where
			ID_PROYECTO = inuID_PROYECTO and
			ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA and
			TIPO_TRABAJO_DESC = isbTIPO_TRABAJO_DESC;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ID_TIPO_TRABAJO:= inuID_TIPO_TRABAJO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updESTA_INI_ORDEN
	(
		inuID_PROYECTO in LDC_TIPOS_TRABAJO_COT.ID_PROYECTO%type,
		inuID_COTIZACION_DETALLADA in LDC_TIPOS_TRABAJO_COT.ID_COTIZACION_DETALLADA%type,
		isbTIPO_TRABAJO_DESC in LDC_TIPOS_TRABAJO_COT.TIPO_TRABAJO_DESC%type,
		inuESTA_INI_ORDEN$ in LDC_TIPOS_TRABAJO_COT.ESTA_INI_ORDEN%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_TIPOS_TRABAJO_COT;
	BEGIN
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.TIPO_TRABAJO_DESC := isbTIPO_TRABAJO_DESC;
		if inuLock=1 then
			LockByPk
			(
				inuID_PROYECTO,
				inuID_COTIZACION_DETALLADA,
				isbTIPO_TRABAJO_DESC,
				rcData
			);
		end if;

		update LDC_TIPOS_TRABAJO_COT
		set
			ESTA_INI_ORDEN = inuESTA_INI_ORDEN$
		where
			ID_PROYECTO = inuID_PROYECTO and
			ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA and
			TIPO_TRABAJO_DESC = isbTIPO_TRABAJO_DESC;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ESTA_INI_ORDEN:= inuESTA_INI_ORDEN$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetID_PROYECTO
	(
		inuID_PROYECTO in LDC_TIPOS_TRABAJO_COT.ID_PROYECTO%type,
		inuID_COTIZACION_DETALLADA in LDC_TIPOS_TRABAJO_COT.ID_COTIZACION_DETALLADA%type,
		isbTIPO_TRABAJO_DESC in LDC_TIPOS_TRABAJO_COT.TIPO_TRABAJO_DESC%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPOS_TRABAJO_COT.ID_PROYECTO%type
	IS
		rcError styLDC_TIPOS_TRABAJO_COT;
	BEGIN

		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.TIPO_TRABAJO_DESC := isbTIPO_TRABAJO_DESC;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PROYECTO,
		 		inuID_COTIZACION_DETALLADA,
		 		isbTIPO_TRABAJO_DESC
			 )
		then
			 return(rcData.ID_PROYECTO);
		end if;
		Load
		(
		 		inuID_PROYECTO,
		 		inuID_COTIZACION_DETALLADA,
		 		isbTIPO_TRABAJO_DESC
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
	FUNCTION fnuGetID_ACTIVIDAD_PRINCIPAL
	(
		inuID_PROYECTO in LDC_TIPOS_TRABAJO_COT.ID_PROYECTO%type,
		inuID_COTIZACION_DETALLADA in LDC_TIPOS_TRABAJO_COT.ID_COTIZACION_DETALLADA%type,
		isbTIPO_TRABAJO_DESC in LDC_TIPOS_TRABAJO_COT.TIPO_TRABAJO_DESC%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPOS_TRABAJO_COT.ID_ACTIVIDAD_PRINCIPAL%type
	IS
		rcError styLDC_TIPOS_TRABAJO_COT;
	BEGIN

		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.TIPO_TRABAJO_DESC := isbTIPO_TRABAJO_DESC;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PROYECTO,
		 		inuID_COTIZACION_DETALLADA,
		 		isbTIPO_TRABAJO_DESC
			 )
		then
			 return(rcData.ID_ACTIVIDAD_PRINCIPAL);
		end if;
		Load
		(
		 		inuID_PROYECTO,
		 		inuID_COTIZACION_DETALLADA,
		 		isbTIPO_TRABAJO_DESC
		);
		return(rcData.ID_ACTIVIDAD_PRINCIPAL);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetTIPO_TRABAJO_DESC
	(
		inuID_PROYECTO in LDC_TIPOS_TRABAJO_COT.ID_PROYECTO%type,
		inuID_COTIZACION_DETALLADA in LDC_TIPOS_TRABAJO_COT.ID_COTIZACION_DETALLADA%type,
		isbTIPO_TRABAJO_DESC in LDC_TIPOS_TRABAJO_COT.TIPO_TRABAJO_DESC%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPOS_TRABAJO_COT.TIPO_TRABAJO_DESC%type
	IS
		rcError styLDC_TIPOS_TRABAJO_COT;
	BEGIN

		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.TIPO_TRABAJO_DESC := isbTIPO_TRABAJO_DESC;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PROYECTO,
		 		inuID_COTIZACION_DETALLADA,
		 		isbTIPO_TRABAJO_DESC
			 )
		then
			 return(rcData.TIPO_TRABAJO_DESC);
		end if;
		Load
		(
		 		inuID_PROYECTO,
		 		inuID_COTIZACION_DETALLADA,
		 		isbTIPO_TRABAJO_DESC
		);
		return(rcData.TIPO_TRABAJO_DESC);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetID_COTIZACION_DETALLADA
	(
		inuID_PROYECTO in LDC_TIPOS_TRABAJO_COT.ID_PROYECTO%type,
		inuID_COTIZACION_DETALLADA in LDC_TIPOS_TRABAJO_COT.ID_COTIZACION_DETALLADA%type,
		isbTIPO_TRABAJO_DESC in LDC_TIPOS_TRABAJO_COT.TIPO_TRABAJO_DESC%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPOS_TRABAJO_COT.ID_COTIZACION_DETALLADA%type
	IS
		rcError styLDC_TIPOS_TRABAJO_COT;
	BEGIN

		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.TIPO_TRABAJO_DESC := isbTIPO_TRABAJO_DESC;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PROYECTO,
		 		inuID_COTIZACION_DETALLADA,
		 		isbTIPO_TRABAJO_DESC
			 )
		then
			 return(rcData.ID_COTIZACION_DETALLADA);
		end if;
		Load
		(
		 		inuID_PROYECTO,
		 		inuID_COTIZACION_DETALLADA,
		 		isbTIPO_TRABAJO_DESC
		);
		return(rcData.ID_COTIZACION_DETALLADA);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetID_TIPO_TRABAJO
	(
		inuID_PROYECTO in LDC_TIPOS_TRABAJO_COT.ID_PROYECTO%type,
		inuID_COTIZACION_DETALLADA in LDC_TIPOS_TRABAJO_COT.ID_COTIZACION_DETALLADA%type,
		isbTIPO_TRABAJO_DESC in LDC_TIPOS_TRABAJO_COT.TIPO_TRABAJO_DESC%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPOS_TRABAJO_COT.ID_TIPO_TRABAJO%type
	IS
		rcError styLDC_TIPOS_TRABAJO_COT;
	BEGIN

		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.TIPO_TRABAJO_DESC := isbTIPO_TRABAJO_DESC;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PROYECTO,
		 		inuID_COTIZACION_DETALLADA,
		 		isbTIPO_TRABAJO_DESC
			 )
		then
			 return(rcData.ID_TIPO_TRABAJO);
		end if;
		Load
		(
		 		inuID_PROYECTO,
		 		inuID_COTIZACION_DETALLADA,
		 		isbTIPO_TRABAJO_DESC
		);
		return(rcData.ID_TIPO_TRABAJO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetESTA_INI_ORDEN
	(
		inuID_PROYECTO in LDC_TIPOS_TRABAJO_COT.ID_PROYECTO%type,
		inuID_COTIZACION_DETALLADA in LDC_TIPOS_TRABAJO_COT.ID_COTIZACION_DETALLADA%type,
		isbTIPO_TRABAJO_DESC in LDC_TIPOS_TRABAJO_COT.TIPO_TRABAJO_DESC%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPOS_TRABAJO_COT.ESTA_INI_ORDEN%type
	IS
		rcError styLDC_TIPOS_TRABAJO_COT;
	BEGIN

		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.TIPO_TRABAJO_DESC := isbTIPO_TRABAJO_DESC;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PROYECTO,
		 		inuID_COTIZACION_DETALLADA,
		 		isbTIPO_TRABAJO_DESC
			 )
		then
			 return(rcData.ESTA_INI_ORDEN);
		end if;
		Load
		(
		 		inuID_PROYECTO,
		 		inuID_COTIZACION_DETALLADA,
		 		isbTIPO_TRABAJO_DESC
		);
		return(rcData.ESTA_INI_ORDEN);
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
end DALDC_TIPOS_TRABAJO_COT;
/
PROMPT Otorgando permisos de ejecucion a DALDC_TIPOS_TRABAJO_COT
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_TIPOS_TRABAJO_COT', 'ADM_PERSON');
END;
/