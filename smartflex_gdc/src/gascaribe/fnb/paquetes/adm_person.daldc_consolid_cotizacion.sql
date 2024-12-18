CREATE OR REPLACE PACKAGE ADM_PERSON.DALDC_CONSOLID_COTIZACION
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
		inuID_TIPO_TRABAJO in LDC_CONSOLID_COTIZACION.ID_TIPO_TRABAJO%type,
		inuID_COTIZACION_DETALLADA in LDC_CONSOLID_COTIZACION.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_CONSOLID_COTIZACION.ID_PROYECTO%type
	)
	IS
		SELECT LDC_CONSOLID_COTIZACION.*,LDC_CONSOLID_COTIZACION.rowid
		FROM LDC_CONSOLID_COTIZACION
		WHERE
		    ID_TIPO_TRABAJO = inuID_TIPO_TRABAJO
		    and ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA
		    and ID_PROYECTO = inuID_PROYECTO;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_CONSOLID_COTIZACION.*,LDC_CONSOLID_COTIZACION.rowid
		FROM LDC_CONSOLID_COTIZACION
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_CONSOLID_COTIZACION  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_CONSOLID_COTIZACION is table of styLDC_CONSOLID_COTIZACION index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_CONSOLID_COTIZACION;

	/* Tipos referenciando al registro */
	type tytbID_PROYECTO is table of LDC_CONSOLID_COTIZACION.ID_PROYECTO%type index by binary_integer;
	type tytbID_COTIZACION_DETALLADA is table of LDC_CONSOLID_COTIZACION.ID_COTIZACION_DETALLADA%type index by binary_integer;
	type tytbID_TIPO_TRABAJO is table of LDC_CONSOLID_COTIZACION.ID_TIPO_TRABAJO%type index by binary_integer;
	type tytbCOSTO is table of LDC_CONSOLID_COTIZACION.COSTO%type index by binary_integer;
	type tytbPRECIO is table of LDC_CONSOLID_COTIZACION.PRECIO%type index by binary_integer;
	type tytbMARGEN is table of LDC_CONSOLID_COTIZACION.MARGEN%type index by binary_integer;
	type tytbIVA is table of LDC_CONSOLID_COTIZACION.IVA%type index by binary_integer;
	type tytbPRECIO_TOTAL is table of LDC_CONSOLID_COTIZACION.PRECIO_TOTAL%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_CONSOLID_COTIZACION is record
	(
		ID_PROYECTO   tytbID_PROYECTO,
		ID_COTIZACION_DETALLADA   tytbID_COTIZACION_DETALLADA,
		ID_TIPO_TRABAJO   tytbID_TIPO_TRABAJO,
		COSTO   tytbCOSTO,
		PRECIO   tytbPRECIO,
		MARGEN   tytbMARGEN,
		IVA   tytbIVA,
		PRECIO_TOTAL   tytbPRECIO_TOTAL,
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
		inuID_TIPO_TRABAJO in LDC_CONSOLID_COTIZACION.ID_TIPO_TRABAJO%type,
		inuID_COTIZACION_DETALLADA in LDC_CONSOLID_COTIZACION.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_CONSOLID_COTIZACION.ID_PROYECTO%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuID_TIPO_TRABAJO in LDC_CONSOLID_COTIZACION.ID_TIPO_TRABAJO%type,
		inuID_COTIZACION_DETALLADA in LDC_CONSOLID_COTIZACION.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_CONSOLID_COTIZACION.ID_PROYECTO%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuID_TIPO_TRABAJO in LDC_CONSOLID_COTIZACION.ID_TIPO_TRABAJO%type,
		inuID_COTIZACION_DETALLADA in LDC_CONSOLID_COTIZACION.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_CONSOLID_COTIZACION.ID_PROYECTO%type
	);

	PROCEDURE getRecord
	(
		inuID_TIPO_TRABAJO in LDC_CONSOLID_COTIZACION.ID_TIPO_TRABAJO%type,
		inuID_COTIZACION_DETALLADA in LDC_CONSOLID_COTIZACION.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_CONSOLID_COTIZACION.ID_PROYECTO%type,
		orcRecord out nocopy styLDC_CONSOLID_COTIZACION
	);

	FUNCTION frcGetRcData
	(
		inuID_TIPO_TRABAJO in LDC_CONSOLID_COTIZACION.ID_TIPO_TRABAJO%type,
		inuID_COTIZACION_DETALLADA in LDC_CONSOLID_COTIZACION.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_CONSOLID_COTIZACION.ID_PROYECTO%type
	)
	RETURN styLDC_CONSOLID_COTIZACION;

	FUNCTION frcGetRcData
	RETURN styLDC_CONSOLID_COTIZACION;

	FUNCTION frcGetRecord
	(
		inuID_TIPO_TRABAJO in LDC_CONSOLID_COTIZACION.ID_TIPO_TRABAJO%type,
		inuID_COTIZACION_DETALLADA in LDC_CONSOLID_COTIZACION.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_CONSOLID_COTIZACION.ID_PROYECTO%type
	)
	RETURN styLDC_CONSOLID_COTIZACION;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_CONSOLID_COTIZACION
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_CONSOLID_COTIZACION in styLDC_CONSOLID_COTIZACION
	);

	PROCEDURE insRecord
	(
		ircLDC_CONSOLID_COTIZACION in styLDC_CONSOLID_COTIZACION,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_CONSOLID_COTIZACION in out nocopy tytbLDC_CONSOLID_COTIZACION
	);

	PROCEDURE delRecord
	(
		inuID_TIPO_TRABAJO in LDC_CONSOLID_COTIZACION.ID_TIPO_TRABAJO%type,
		inuID_COTIZACION_DETALLADA in LDC_CONSOLID_COTIZACION.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_CONSOLID_COTIZACION.ID_PROYECTO%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_CONSOLID_COTIZACION in out nocopy tytbLDC_CONSOLID_COTIZACION,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_CONSOLID_COTIZACION in styLDC_CONSOLID_COTIZACION,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_CONSOLID_COTIZACION in out nocopy tytbLDC_CONSOLID_COTIZACION,
		inuLock in number default 1
	);

	PROCEDURE updCOSTO
	(
		inuID_TIPO_TRABAJO in LDC_CONSOLID_COTIZACION.ID_TIPO_TRABAJO%type,
		inuID_COTIZACION_DETALLADA in LDC_CONSOLID_COTIZACION.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_CONSOLID_COTIZACION.ID_PROYECTO%type,
		inuCOSTO$ in LDC_CONSOLID_COTIZACION.COSTO%type,
		inuLock in number default 0
	);

	PROCEDURE updPRECIO
	(
		inuID_TIPO_TRABAJO in LDC_CONSOLID_COTIZACION.ID_TIPO_TRABAJO%type,
		inuID_COTIZACION_DETALLADA in LDC_CONSOLID_COTIZACION.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_CONSOLID_COTIZACION.ID_PROYECTO%type,
		inuPRECIO$ in LDC_CONSOLID_COTIZACION.PRECIO%type,
		inuLock in number default 0
	);

	PROCEDURE updMARGEN
	(
		inuID_TIPO_TRABAJO in LDC_CONSOLID_COTIZACION.ID_TIPO_TRABAJO%type,
		inuID_COTIZACION_DETALLADA in LDC_CONSOLID_COTIZACION.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_CONSOLID_COTIZACION.ID_PROYECTO%type,
		inuMARGEN$ in LDC_CONSOLID_COTIZACION.MARGEN%type,
		inuLock in number default 0
	);

	PROCEDURE updIVA
	(
		inuID_TIPO_TRABAJO in LDC_CONSOLID_COTIZACION.ID_TIPO_TRABAJO%type,
		inuID_COTIZACION_DETALLADA in LDC_CONSOLID_COTIZACION.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_CONSOLID_COTIZACION.ID_PROYECTO%type,
		inuIVA$ in LDC_CONSOLID_COTIZACION.IVA%type,
		inuLock in number default 0
	);

	PROCEDURE updPRECIO_TOTAL
	(
		inuID_TIPO_TRABAJO in LDC_CONSOLID_COTIZACION.ID_TIPO_TRABAJO%type,
		inuID_COTIZACION_DETALLADA in LDC_CONSOLID_COTIZACION.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_CONSOLID_COTIZACION.ID_PROYECTO%type,
		inuPRECIO_TOTAL$ in LDC_CONSOLID_COTIZACION.PRECIO_TOTAL%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetID_PROYECTO
	(
		inuID_TIPO_TRABAJO in LDC_CONSOLID_COTIZACION.ID_TIPO_TRABAJO%type,
		inuID_COTIZACION_DETALLADA in LDC_CONSOLID_COTIZACION.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_CONSOLID_COTIZACION.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONSOLID_COTIZACION.ID_PROYECTO%type;

	FUNCTION fnuGetID_COTIZACION_DETALLADA
	(
		inuID_TIPO_TRABAJO in LDC_CONSOLID_COTIZACION.ID_TIPO_TRABAJO%type,
		inuID_COTIZACION_DETALLADA in LDC_CONSOLID_COTIZACION.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_CONSOLID_COTIZACION.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONSOLID_COTIZACION.ID_COTIZACION_DETALLADA%type;

	FUNCTION fnuGetID_TIPO_TRABAJO
	(
		inuID_TIPO_TRABAJO in LDC_CONSOLID_COTIZACION.ID_TIPO_TRABAJO%type,
		inuID_COTIZACION_DETALLADA in LDC_CONSOLID_COTIZACION.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_CONSOLID_COTIZACION.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONSOLID_COTIZACION.ID_TIPO_TRABAJO%type;

	FUNCTION fnuGetCOSTO
	(
		inuID_TIPO_TRABAJO in LDC_CONSOLID_COTIZACION.ID_TIPO_TRABAJO%type,
		inuID_COTIZACION_DETALLADA in LDC_CONSOLID_COTIZACION.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_CONSOLID_COTIZACION.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONSOLID_COTIZACION.COSTO%type;

	FUNCTION fnuGetPRECIO
	(
		inuID_TIPO_TRABAJO in LDC_CONSOLID_COTIZACION.ID_TIPO_TRABAJO%type,
		inuID_COTIZACION_DETALLADA in LDC_CONSOLID_COTIZACION.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_CONSOLID_COTIZACION.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONSOLID_COTIZACION.PRECIO%type;

	FUNCTION fnuGetMARGEN
	(
		inuID_TIPO_TRABAJO in LDC_CONSOLID_COTIZACION.ID_TIPO_TRABAJO%type,
		inuID_COTIZACION_DETALLADA in LDC_CONSOLID_COTIZACION.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_CONSOLID_COTIZACION.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONSOLID_COTIZACION.MARGEN%type;

	FUNCTION fnuGetIVA
	(
		inuID_TIPO_TRABAJO in LDC_CONSOLID_COTIZACION.ID_TIPO_TRABAJO%type,
		inuID_COTIZACION_DETALLADA in LDC_CONSOLID_COTIZACION.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_CONSOLID_COTIZACION.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONSOLID_COTIZACION.IVA%type;

	FUNCTION fnuGetPRECIO_TOTAL
	(
		inuID_TIPO_TRABAJO in LDC_CONSOLID_COTIZACION.ID_TIPO_TRABAJO%type,
		inuID_COTIZACION_DETALLADA in LDC_CONSOLID_COTIZACION.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_CONSOLID_COTIZACION.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONSOLID_COTIZACION.PRECIO_TOTAL%type;


	PROCEDURE LockByPk
	(
		inuID_TIPO_TRABAJO in LDC_CONSOLID_COTIZACION.ID_TIPO_TRABAJO%type,
		inuID_COTIZACION_DETALLADA in LDC_CONSOLID_COTIZACION.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_CONSOLID_COTIZACION.ID_PROYECTO%type,
		orcLDC_CONSOLID_COTIZACION  out styLDC_CONSOLID_COTIZACION
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_CONSOLID_COTIZACION  out styLDC_CONSOLID_COTIZACION
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_CONSOLID_COTIZACION;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALDC_CONSOLID_COTIZACION
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_CONSOLID_COTIZACION';
	 cnuGeEntityId constant varchar2(30) := 2873; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuID_TIPO_TRABAJO in LDC_CONSOLID_COTIZACION.ID_TIPO_TRABAJO%type,
		inuID_COTIZACION_DETALLADA in LDC_CONSOLID_COTIZACION.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_CONSOLID_COTIZACION.ID_PROYECTO%type
	)
	IS
		SELECT LDC_CONSOLID_COTIZACION.*,LDC_CONSOLID_COTIZACION.rowid
		FROM LDC_CONSOLID_COTIZACION
		WHERE  ID_TIPO_TRABAJO = inuID_TIPO_TRABAJO
			and ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA
			and ID_PROYECTO = inuID_PROYECTO
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_CONSOLID_COTIZACION.*,LDC_CONSOLID_COTIZACION.rowid
		FROM LDC_CONSOLID_COTIZACION
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_CONSOLID_COTIZACION is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_CONSOLID_COTIZACION;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_CONSOLID_COTIZACION default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.ID_TIPO_TRABAJO);
		sbPk:=sbPk||','||ut_convert.fsbToChar(rcI.ID_COTIZACION_DETALLADA);
		sbPk:=sbPk||','||ut_convert.fsbToChar(rcI.ID_PROYECTO);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuID_TIPO_TRABAJO in LDC_CONSOLID_COTIZACION.ID_TIPO_TRABAJO%type,
		inuID_COTIZACION_DETALLADA in LDC_CONSOLID_COTIZACION.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_CONSOLID_COTIZACION.ID_PROYECTO%type,
		orcLDC_CONSOLID_COTIZACION  out styLDC_CONSOLID_COTIZACION
	)
	IS
		rcError styLDC_CONSOLID_COTIZACION;
	BEGIN
		rcError.ID_TIPO_TRABAJO := inuID_TIPO_TRABAJO;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;

		Open cuLockRcByPk
		(
			inuID_TIPO_TRABAJO,
			inuID_COTIZACION_DETALLADA,
			inuID_PROYECTO
		);

		fetch cuLockRcByPk into orcLDC_CONSOLID_COTIZACION;
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
		orcLDC_CONSOLID_COTIZACION  out styLDC_CONSOLID_COTIZACION
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_CONSOLID_COTIZACION;
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
		itbLDC_CONSOLID_COTIZACION  in out nocopy tytbLDC_CONSOLID_COTIZACION
	)
	IS
	BEGIN
			rcRecOfTab.ID_PROYECTO.delete;
			rcRecOfTab.ID_COTIZACION_DETALLADA.delete;
			rcRecOfTab.ID_TIPO_TRABAJO.delete;
			rcRecOfTab.COSTO.delete;
			rcRecOfTab.PRECIO.delete;
			rcRecOfTab.MARGEN.delete;
			rcRecOfTab.IVA.delete;
			rcRecOfTab.PRECIO_TOTAL.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_CONSOLID_COTIZACION  in out nocopy tytbLDC_CONSOLID_COTIZACION,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_CONSOLID_COTIZACION);

		for n in itbLDC_CONSOLID_COTIZACION.first .. itbLDC_CONSOLID_COTIZACION.last loop
			rcRecOfTab.ID_PROYECTO(n) := itbLDC_CONSOLID_COTIZACION(n).ID_PROYECTO;
			rcRecOfTab.ID_COTIZACION_DETALLADA(n) := itbLDC_CONSOLID_COTIZACION(n).ID_COTIZACION_DETALLADA;
			rcRecOfTab.ID_TIPO_TRABAJO(n) := itbLDC_CONSOLID_COTIZACION(n).ID_TIPO_TRABAJO;
			rcRecOfTab.COSTO(n) := itbLDC_CONSOLID_COTIZACION(n).COSTO;
			rcRecOfTab.PRECIO(n) := itbLDC_CONSOLID_COTIZACION(n).PRECIO;
			rcRecOfTab.MARGEN(n) := itbLDC_CONSOLID_COTIZACION(n).MARGEN;
			rcRecOfTab.IVA(n) := itbLDC_CONSOLID_COTIZACION(n).IVA;
			rcRecOfTab.PRECIO_TOTAL(n) := itbLDC_CONSOLID_COTIZACION(n).PRECIO_TOTAL;
			rcRecOfTab.row_id(n) := itbLDC_CONSOLID_COTIZACION(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuID_TIPO_TRABAJO in LDC_CONSOLID_COTIZACION.ID_TIPO_TRABAJO%type,
		inuID_COTIZACION_DETALLADA in LDC_CONSOLID_COTIZACION.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_CONSOLID_COTIZACION.ID_PROYECTO%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuID_TIPO_TRABAJO,
			inuID_COTIZACION_DETALLADA,
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
		inuID_TIPO_TRABAJO in LDC_CONSOLID_COTIZACION.ID_TIPO_TRABAJO%type,
		inuID_COTIZACION_DETALLADA in LDC_CONSOLID_COTIZACION.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_CONSOLID_COTIZACION.ID_PROYECTO%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuID_TIPO_TRABAJO = rcData.ID_TIPO_TRABAJO AND
			inuID_COTIZACION_DETALLADA = rcData.ID_COTIZACION_DETALLADA AND
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
		inuID_TIPO_TRABAJO in LDC_CONSOLID_COTIZACION.ID_TIPO_TRABAJO%type,
		inuID_COTIZACION_DETALLADA in LDC_CONSOLID_COTIZACION.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_CONSOLID_COTIZACION.ID_PROYECTO%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuID_TIPO_TRABAJO,
			inuID_COTIZACION_DETALLADA,
			inuID_PROYECTO
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuID_TIPO_TRABAJO in LDC_CONSOLID_COTIZACION.ID_TIPO_TRABAJO%type,
		inuID_COTIZACION_DETALLADA in LDC_CONSOLID_COTIZACION.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_CONSOLID_COTIZACION.ID_PROYECTO%type
	)
	IS
		rcError styLDC_CONSOLID_COTIZACION;
	BEGIN		rcError.ID_TIPO_TRABAJO:=inuID_TIPO_TRABAJO;		rcError.ID_COTIZACION_DETALLADA:=inuID_COTIZACION_DETALLADA;		rcError.ID_PROYECTO:=inuID_PROYECTO;

		Load
		(
			inuID_TIPO_TRABAJO,
			inuID_COTIZACION_DETALLADA,
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
		inuID_TIPO_TRABAJO in LDC_CONSOLID_COTIZACION.ID_TIPO_TRABAJO%type,
		inuID_COTIZACION_DETALLADA in LDC_CONSOLID_COTIZACION.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_CONSOLID_COTIZACION.ID_PROYECTO%type
	)
	IS
	BEGIN
		Load
		(
			inuID_TIPO_TRABAJO,
			inuID_COTIZACION_DETALLADA,
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
		inuID_TIPO_TRABAJO in LDC_CONSOLID_COTIZACION.ID_TIPO_TRABAJO%type,
		inuID_COTIZACION_DETALLADA in LDC_CONSOLID_COTIZACION.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_CONSOLID_COTIZACION.ID_PROYECTO%type,
		orcRecord out nocopy styLDC_CONSOLID_COTIZACION
	)
	IS
		rcError styLDC_CONSOLID_COTIZACION;
	BEGIN		rcError.ID_TIPO_TRABAJO:=inuID_TIPO_TRABAJO;		rcError.ID_COTIZACION_DETALLADA:=inuID_COTIZACION_DETALLADA;		rcError.ID_PROYECTO:=inuID_PROYECTO;

		Load
		(
			inuID_TIPO_TRABAJO,
			inuID_COTIZACION_DETALLADA,
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
		inuID_TIPO_TRABAJO in LDC_CONSOLID_COTIZACION.ID_TIPO_TRABAJO%type,
		inuID_COTIZACION_DETALLADA in LDC_CONSOLID_COTIZACION.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_CONSOLID_COTIZACION.ID_PROYECTO%type
	)
	RETURN styLDC_CONSOLID_COTIZACION
	IS
		rcError styLDC_CONSOLID_COTIZACION;
	BEGIN
		rcError.ID_TIPO_TRABAJO:=inuID_TIPO_TRABAJO;
		rcError.ID_COTIZACION_DETALLADA:=inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO:=inuID_PROYECTO;

		Load
		(
			inuID_TIPO_TRABAJO,
			inuID_COTIZACION_DETALLADA,
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
		inuID_TIPO_TRABAJO in LDC_CONSOLID_COTIZACION.ID_TIPO_TRABAJO%type,
		inuID_COTIZACION_DETALLADA in LDC_CONSOLID_COTIZACION.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_CONSOLID_COTIZACION.ID_PROYECTO%type
	)
	RETURN styLDC_CONSOLID_COTIZACION
	IS
		rcError styLDC_CONSOLID_COTIZACION;
	BEGIN
		rcError.ID_TIPO_TRABAJO:=inuID_TIPO_TRABAJO;
		rcError.ID_COTIZACION_DETALLADA:=inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO:=inuID_PROYECTO;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuID_TIPO_TRABAJO,
			inuID_COTIZACION_DETALLADA,
			inuID_PROYECTO
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuID_TIPO_TRABAJO,
			inuID_COTIZACION_DETALLADA,
			inuID_PROYECTO
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_CONSOLID_COTIZACION
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_CONSOLID_COTIZACION
	)
	IS
		rfLDC_CONSOLID_COTIZACION tyrfLDC_CONSOLID_COTIZACION;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_CONSOLID_COTIZACION.*, LDC_CONSOLID_COTIZACION.rowid FROM LDC_CONSOLID_COTIZACION';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_CONSOLID_COTIZACION for sbFullQuery;

		fetch rfLDC_CONSOLID_COTIZACION bulk collect INTO otbResult;

		close rfLDC_CONSOLID_COTIZACION;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_CONSOLID_COTIZACION.*, LDC_CONSOLID_COTIZACION.rowid FROM LDC_CONSOLID_COTIZACION';
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
		ircLDC_CONSOLID_COTIZACION in styLDC_CONSOLID_COTIZACION
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_CONSOLID_COTIZACION,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_CONSOLID_COTIZACION in styLDC_CONSOLID_COTIZACION,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_CONSOLID_COTIZACION.ID_TIPO_TRABAJO is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ID_TIPO_TRABAJO');
			raise ex.controlled_error;
		end if;
		if ircLDC_CONSOLID_COTIZACION.ID_COTIZACION_DETALLADA is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ID_COTIZACION_DETALLADA');
			raise ex.controlled_error;
		end if;
		if ircLDC_CONSOLID_COTIZACION.ID_PROYECTO is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ID_PROYECTO');
			raise ex.controlled_error;
		end if;

		insert into LDC_CONSOLID_COTIZACION
		(
			ID_PROYECTO,
			ID_COTIZACION_DETALLADA,
			ID_TIPO_TRABAJO,
			COSTO,
			PRECIO,
			MARGEN,
			IVA,
			PRECIO_TOTAL
		)
		values
		(
			ircLDC_CONSOLID_COTIZACION.ID_PROYECTO,
			ircLDC_CONSOLID_COTIZACION.ID_COTIZACION_DETALLADA,
			ircLDC_CONSOLID_COTIZACION.ID_TIPO_TRABAJO,
			ircLDC_CONSOLID_COTIZACION.COSTO,
			ircLDC_CONSOLID_COTIZACION.PRECIO,
			ircLDC_CONSOLID_COTIZACION.MARGEN,
			ircLDC_CONSOLID_COTIZACION.IVA,
			ircLDC_CONSOLID_COTIZACION.PRECIO_TOTAL
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_CONSOLID_COTIZACION));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_CONSOLID_COTIZACION in out nocopy tytbLDC_CONSOLID_COTIZACION
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_CONSOLID_COTIZACION,blUseRowID);
		forall n in iotbLDC_CONSOLID_COTIZACION.first..iotbLDC_CONSOLID_COTIZACION.last
			insert into LDC_CONSOLID_COTIZACION
			(
				ID_PROYECTO,
				ID_COTIZACION_DETALLADA,
				ID_TIPO_TRABAJO,
				COSTO,
				PRECIO,
				MARGEN,
				IVA,
				PRECIO_TOTAL
			)
			values
			(
				rcRecOfTab.ID_PROYECTO(n),
				rcRecOfTab.ID_COTIZACION_DETALLADA(n),
				rcRecOfTab.ID_TIPO_TRABAJO(n),
				rcRecOfTab.COSTO(n),
				rcRecOfTab.PRECIO(n),
				rcRecOfTab.MARGEN(n),
				rcRecOfTab.IVA(n),
				rcRecOfTab.PRECIO_TOTAL(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuID_TIPO_TRABAJO in LDC_CONSOLID_COTIZACION.ID_TIPO_TRABAJO%type,
		inuID_COTIZACION_DETALLADA in LDC_CONSOLID_COTIZACION.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_CONSOLID_COTIZACION.ID_PROYECTO%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_CONSOLID_COTIZACION;
	BEGIN
		rcError.ID_TIPO_TRABAJO := inuID_TIPO_TRABAJO;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;

		if inuLock=1 then
			LockByPk
			(
				inuID_TIPO_TRABAJO,
				inuID_COTIZACION_DETALLADA,
				inuID_PROYECTO,
				rcData
			);
		end if;


		delete
		from LDC_CONSOLID_COTIZACION
		where
       		ID_TIPO_TRABAJO=inuID_TIPO_TRABAJO and
       		ID_COTIZACION_DETALLADA=inuID_COTIZACION_DETALLADA and
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
		rcError  styLDC_CONSOLID_COTIZACION;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_CONSOLID_COTIZACION
		where
			rowid = iriRowID
		returning
			ID_PROYECTO,
			ID_COTIZACION_DETALLADA,
			ID_TIPO_TRABAJO
		into
			rcError.ID_PROYECTO,
			rcError.ID_COTIZACION_DETALLADA,
			rcError.ID_TIPO_TRABAJO;
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
		iotbLDC_CONSOLID_COTIZACION in out nocopy tytbLDC_CONSOLID_COTIZACION,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_CONSOLID_COTIZACION;
	BEGIN
		FillRecordOfTables(iotbLDC_CONSOLID_COTIZACION, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_CONSOLID_COTIZACION.first .. iotbLDC_CONSOLID_COTIZACION.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CONSOLID_COTIZACION.first .. iotbLDC_CONSOLID_COTIZACION.last
				delete
				from LDC_CONSOLID_COTIZACION
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_CONSOLID_COTIZACION.first .. iotbLDC_CONSOLID_COTIZACION.last loop
					LockByPk
					(
						rcRecOfTab.ID_TIPO_TRABAJO(n),
						rcRecOfTab.ID_COTIZACION_DETALLADA(n),
						rcRecOfTab.ID_PROYECTO(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CONSOLID_COTIZACION.first .. iotbLDC_CONSOLID_COTIZACION.last
				delete
				from LDC_CONSOLID_COTIZACION
				where
		         	ID_TIPO_TRABAJO = rcRecOfTab.ID_TIPO_TRABAJO(n) and
		         	ID_COTIZACION_DETALLADA = rcRecOfTab.ID_COTIZACION_DETALLADA(n) and
		         	ID_PROYECTO = rcRecOfTab.ID_PROYECTO(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_CONSOLID_COTIZACION in styLDC_CONSOLID_COTIZACION,
		inuLock in number default 0
	)
	IS
		nuID_TIPO_TRABAJO	LDC_CONSOLID_COTIZACION.ID_TIPO_TRABAJO%type;
		nuID_COTIZACION_DETALLADA	LDC_CONSOLID_COTIZACION.ID_COTIZACION_DETALLADA%type;
		nuID_PROYECTO	LDC_CONSOLID_COTIZACION.ID_PROYECTO%type;
	BEGIN
		if ircLDC_CONSOLID_COTIZACION.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_CONSOLID_COTIZACION.rowid,rcData);
			end if;
			update LDC_CONSOLID_COTIZACION
			set
				COSTO = ircLDC_CONSOLID_COTIZACION.COSTO,
				PRECIO = ircLDC_CONSOLID_COTIZACION.PRECIO,
				MARGEN = ircLDC_CONSOLID_COTIZACION.MARGEN,
				IVA = ircLDC_CONSOLID_COTIZACION.IVA,
				PRECIO_TOTAL = ircLDC_CONSOLID_COTIZACION.PRECIO_TOTAL
			where
				rowid = ircLDC_CONSOLID_COTIZACION.rowid
			returning
				ID_TIPO_TRABAJO,
				ID_COTIZACION_DETALLADA,
				ID_PROYECTO
			into
				nuID_TIPO_TRABAJO,
				nuID_COTIZACION_DETALLADA,
				nuID_PROYECTO;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_CONSOLID_COTIZACION.ID_TIPO_TRABAJO,
					ircLDC_CONSOLID_COTIZACION.ID_COTIZACION_DETALLADA,
					ircLDC_CONSOLID_COTIZACION.ID_PROYECTO,
					rcData
				);
			end if;

			update LDC_CONSOLID_COTIZACION
			set
				COSTO = ircLDC_CONSOLID_COTIZACION.COSTO,
				PRECIO = ircLDC_CONSOLID_COTIZACION.PRECIO,
				MARGEN = ircLDC_CONSOLID_COTIZACION.MARGEN,
				IVA = ircLDC_CONSOLID_COTIZACION.IVA,
				PRECIO_TOTAL = ircLDC_CONSOLID_COTIZACION.PRECIO_TOTAL
			where
				ID_TIPO_TRABAJO = ircLDC_CONSOLID_COTIZACION.ID_TIPO_TRABAJO and
				ID_COTIZACION_DETALLADA = ircLDC_CONSOLID_COTIZACION.ID_COTIZACION_DETALLADA and
				ID_PROYECTO = ircLDC_CONSOLID_COTIZACION.ID_PROYECTO
			returning
				ID_TIPO_TRABAJO,
				ID_COTIZACION_DETALLADA,
				ID_PROYECTO
			into
				nuID_TIPO_TRABAJO,
				nuID_COTIZACION_DETALLADA,
				nuID_PROYECTO;
		end if;
		if
			nuID_TIPO_TRABAJO is NULL OR
			nuID_COTIZACION_DETALLADA is NULL OR
			nuID_PROYECTO is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_CONSOLID_COTIZACION));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_CONSOLID_COTIZACION in out nocopy tytbLDC_CONSOLID_COTIZACION,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_CONSOLID_COTIZACION;
	BEGIN
		FillRecordOfTables(iotbLDC_CONSOLID_COTIZACION,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_CONSOLID_COTIZACION.first .. iotbLDC_CONSOLID_COTIZACION.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CONSOLID_COTIZACION.first .. iotbLDC_CONSOLID_COTIZACION.last
				update LDC_CONSOLID_COTIZACION
				set
					COSTO = rcRecOfTab.COSTO(n),
					PRECIO = rcRecOfTab.PRECIO(n),
					MARGEN = rcRecOfTab.MARGEN(n),
					IVA = rcRecOfTab.IVA(n),
					PRECIO_TOTAL = rcRecOfTab.PRECIO_TOTAL(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_CONSOLID_COTIZACION.first .. iotbLDC_CONSOLID_COTIZACION.last loop
					LockByPk
					(
						rcRecOfTab.ID_TIPO_TRABAJO(n),
						rcRecOfTab.ID_COTIZACION_DETALLADA(n),
						rcRecOfTab.ID_PROYECTO(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CONSOLID_COTIZACION.first .. iotbLDC_CONSOLID_COTIZACION.last
				update LDC_CONSOLID_COTIZACION
				SET
					COSTO = rcRecOfTab.COSTO(n),
					PRECIO = rcRecOfTab.PRECIO(n),
					MARGEN = rcRecOfTab.MARGEN(n),
					IVA = rcRecOfTab.IVA(n),
					PRECIO_TOTAL = rcRecOfTab.PRECIO_TOTAL(n)
				where
					ID_TIPO_TRABAJO = rcRecOfTab.ID_TIPO_TRABAJO(n) and
					ID_COTIZACION_DETALLADA = rcRecOfTab.ID_COTIZACION_DETALLADA(n) and
					ID_PROYECTO = rcRecOfTab.ID_PROYECTO(n)
;
		end if;
	END;
	PROCEDURE updCOSTO
	(
		inuID_TIPO_TRABAJO in LDC_CONSOLID_COTIZACION.ID_TIPO_TRABAJO%type,
		inuID_COTIZACION_DETALLADA in LDC_CONSOLID_COTIZACION.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_CONSOLID_COTIZACION.ID_PROYECTO%type,
		inuCOSTO$ in LDC_CONSOLID_COTIZACION.COSTO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CONSOLID_COTIZACION;
	BEGIN
		rcError.ID_TIPO_TRABAJO := inuID_TIPO_TRABAJO;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		if inuLock=1 then
			LockByPk
			(
				inuID_TIPO_TRABAJO,
				inuID_COTIZACION_DETALLADA,
				inuID_PROYECTO,
				rcData
			);
		end if;

		update LDC_CONSOLID_COTIZACION
		set
			COSTO = inuCOSTO$
		where
			ID_TIPO_TRABAJO = inuID_TIPO_TRABAJO and
			ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA and
			ID_PROYECTO = inuID_PROYECTO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.COSTO:= inuCOSTO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPRECIO
	(
		inuID_TIPO_TRABAJO in LDC_CONSOLID_COTIZACION.ID_TIPO_TRABAJO%type,
		inuID_COTIZACION_DETALLADA in LDC_CONSOLID_COTIZACION.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_CONSOLID_COTIZACION.ID_PROYECTO%type,
		inuPRECIO$ in LDC_CONSOLID_COTIZACION.PRECIO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CONSOLID_COTIZACION;
	BEGIN
		rcError.ID_TIPO_TRABAJO := inuID_TIPO_TRABAJO;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		if inuLock=1 then
			LockByPk
			(
				inuID_TIPO_TRABAJO,
				inuID_COTIZACION_DETALLADA,
				inuID_PROYECTO,
				rcData
			);
		end if;

		update LDC_CONSOLID_COTIZACION
		set
			PRECIO = inuPRECIO$
		where
			ID_TIPO_TRABAJO = inuID_TIPO_TRABAJO and
			ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA and
			ID_PROYECTO = inuID_PROYECTO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PRECIO:= inuPRECIO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updMARGEN
	(
		inuID_TIPO_TRABAJO in LDC_CONSOLID_COTIZACION.ID_TIPO_TRABAJO%type,
		inuID_COTIZACION_DETALLADA in LDC_CONSOLID_COTIZACION.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_CONSOLID_COTIZACION.ID_PROYECTO%type,
		inuMARGEN$ in LDC_CONSOLID_COTIZACION.MARGEN%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CONSOLID_COTIZACION;
	BEGIN
		rcError.ID_TIPO_TRABAJO := inuID_TIPO_TRABAJO;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		if inuLock=1 then
			LockByPk
			(
				inuID_TIPO_TRABAJO,
				inuID_COTIZACION_DETALLADA,
				inuID_PROYECTO,
				rcData
			);
		end if;

		update LDC_CONSOLID_COTIZACION
		set
			MARGEN = inuMARGEN$
		where
			ID_TIPO_TRABAJO = inuID_TIPO_TRABAJO and
			ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA and
			ID_PROYECTO = inuID_PROYECTO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.MARGEN:= inuMARGEN$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updIVA
	(
		inuID_TIPO_TRABAJO in LDC_CONSOLID_COTIZACION.ID_TIPO_TRABAJO%type,
		inuID_COTIZACION_DETALLADA in LDC_CONSOLID_COTIZACION.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_CONSOLID_COTIZACION.ID_PROYECTO%type,
		inuIVA$ in LDC_CONSOLID_COTIZACION.IVA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CONSOLID_COTIZACION;
	BEGIN
		rcError.ID_TIPO_TRABAJO := inuID_TIPO_TRABAJO;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		if inuLock=1 then
			LockByPk
			(
				inuID_TIPO_TRABAJO,
				inuID_COTIZACION_DETALLADA,
				inuID_PROYECTO,
				rcData
			);
		end if;

		update LDC_CONSOLID_COTIZACION
		set
			IVA = inuIVA$
		where
			ID_TIPO_TRABAJO = inuID_TIPO_TRABAJO and
			ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA and
			ID_PROYECTO = inuID_PROYECTO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.IVA:= inuIVA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPRECIO_TOTAL
	(
		inuID_TIPO_TRABAJO in LDC_CONSOLID_COTIZACION.ID_TIPO_TRABAJO%type,
		inuID_COTIZACION_DETALLADA in LDC_CONSOLID_COTIZACION.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_CONSOLID_COTIZACION.ID_PROYECTO%type,
		inuPRECIO_TOTAL$ in LDC_CONSOLID_COTIZACION.PRECIO_TOTAL%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CONSOLID_COTIZACION;
	BEGIN
		rcError.ID_TIPO_TRABAJO := inuID_TIPO_TRABAJO;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;
		if inuLock=1 then
			LockByPk
			(
				inuID_TIPO_TRABAJO,
				inuID_COTIZACION_DETALLADA,
				inuID_PROYECTO,
				rcData
			);
		end if;

		update LDC_CONSOLID_COTIZACION
		set
			PRECIO_TOTAL = inuPRECIO_TOTAL$
		where
			ID_TIPO_TRABAJO = inuID_TIPO_TRABAJO and
			ID_COTIZACION_DETALLADA = inuID_COTIZACION_DETALLADA and
			ID_PROYECTO = inuID_PROYECTO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PRECIO_TOTAL:= inuPRECIO_TOTAL$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetID_PROYECTO
	(
		inuID_TIPO_TRABAJO in LDC_CONSOLID_COTIZACION.ID_TIPO_TRABAJO%type,
		inuID_COTIZACION_DETALLADA in LDC_CONSOLID_COTIZACION.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_CONSOLID_COTIZACION.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONSOLID_COTIZACION.ID_PROYECTO%type
	IS
		rcError styLDC_CONSOLID_COTIZACION;
	BEGIN

		rcError.ID_TIPO_TRABAJO := inuID_TIPO_TRABAJO;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_TIPO_TRABAJO,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.ID_PROYECTO);
		end if;
		Load
		(
		 		inuID_TIPO_TRABAJO,
		 		inuID_COTIZACION_DETALLADA,
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
	FUNCTION fnuGetID_COTIZACION_DETALLADA
	(
		inuID_TIPO_TRABAJO in LDC_CONSOLID_COTIZACION.ID_TIPO_TRABAJO%type,
		inuID_COTIZACION_DETALLADA in LDC_CONSOLID_COTIZACION.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_CONSOLID_COTIZACION.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONSOLID_COTIZACION.ID_COTIZACION_DETALLADA%type
	IS
		rcError styLDC_CONSOLID_COTIZACION;
	BEGIN

		rcError.ID_TIPO_TRABAJO := inuID_TIPO_TRABAJO;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_TIPO_TRABAJO,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.ID_COTIZACION_DETALLADA);
		end if;
		Load
		(
		 		inuID_TIPO_TRABAJO,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
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
		inuID_TIPO_TRABAJO in LDC_CONSOLID_COTIZACION.ID_TIPO_TRABAJO%type,
		inuID_COTIZACION_DETALLADA in LDC_CONSOLID_COTIZACION.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_CONSOLID_COTIZACION.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONSOLID_COTIZACION.ID_TIPO_TRABAJO%type
	IS
		rcError styLDC_CONSOLID_COTIZACION;
	BEGIN

		rcError.ID_TIPO_TRABAJO := inuID_TIPO_TRABAJO;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_TIPO_TRABAJO,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.ID_TIPO_TRABAJO);
		end if;
		Load
		(
		 		inuID_TIPO_TRABAJO,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
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
	FUNCTION fnuGetCOSTO
	(
		inuID_TIPO_TRABAJO in LDC_CONSOLID_COTIZACION.ID_TIPO_TRABAJO%type,
		inuID_COTIZACION_DETALLADA in LDC_CONSOLID_COTIZACION.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_CONSOLID_COTIZACION.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONSOLID_COTIZACION.COSTO%type
	IS
		rcError styLDC_CONSOLID_COTIZACION;
	BEGIN

		rcError.ID_TIPO_TRABAJO := inuID_TIPO_TRABAJO;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_TIPO_TRABAJO,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.COSTO);
		end if;
		Load
		(
		 		inuID_TIPO_TRABAJO,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
		);
		return(rcData.COSTO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetPRECIO
	(
		inuID_TIPO_TRABAJO in LDC_CONSOLID_COTIZACION.ID_TIPO_TRABAJO%type,
		inuID_COTIZACION_DETALLADA in LDC_CONSOLID_COTIZACION.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_CONSOLID_COTIZACION.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONSOLID_COTIZACION.PRECIO%type
	IS
		rcError styLDC_CONSOLID_COTIZACION;
	BEGIN

		rcError.ID_TIPO_TRABAJO := inuID_TIPO_TRABAJO;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_TIPO_TRABAJO,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.PRECIO);
		end if;
		Load
		(
		 		inuID_TIPO_TRABAJO,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
		);
		return(rcData.PRECIO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetMARGEN
	(
		inuID_TIPO_TRABAJO in LDC_CONSOLID_COTIZACION.ID_TIPO_TRABAJO%type,
		inuID_COTIZACION_DETALLADA in LDC_CONSOLID_COTIZACION.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_CONSOLID_COTIZACION.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONSOLID_COTIZACION.MARGEN%type
	IS
		rcError styLDC_CONSOLID_COTIZACION;
	BEGIN

		rcError.ID_TIPO_TRABAJO := inuID_TIPO_TRABAJO;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_TIPO_TRABAJO,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.MARGEN);
		end if;
		Load
		(
		 		inuID_TIPO_TRABAJO,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
		);
		return(rcData.MARGEN);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetIVA
	(
		inuID_TIPO_TRABAJO in LDC_CONSOLID_COTIZACION.ID_TIPO_TRABAJO%type,
		inuID_COTIZACION_DETALLADA in LDC_CONSOLID_COTIZACION.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_CONSOLID_COTIZACION.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONSOLID_COTIZACION.IVA%type
	IS
		rcError styLDC_CONSOLID_COTIZACION;
	BEGIN

		rcError.ID_TIPO_TRABAJO := inuID_TIPO_TRABAJO;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_TIPO_TRABAJO,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.IVA);
		end if;
		Load
		(
		 		inuID_TIPO_TRABAJO,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
		);
		return(rcData.IVA);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetPRECIO_TOTAL
	(
		inuID_TIPO_TRABAJO in LDC_CONSOLID_COTIZACION.ID_TIPO_TRABAJO%type,
		inuID_COTIZACION_DETALLADA in LDC_CONSOLID_COTIZACION.ID_COTIZACION_DETALLADA%type,
		inuID_PROYECTO in LDC_CONSOLID_COTIZACION.ID_PROYECTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONSOLID_COTIZACION.PRECIO_TOTAL%type
	IS
		rcError styLDC_CONSOLID_COTIZACION;
	BEGIN

		rcError.ID_TIPO_TRABAJO := inuID_TIPO_TRABAJO;
		rcError.ID_COTIZACION_DETALLADA := inuID_COTIZACION_DETALLADA;
		rcError.ID_PROYECTO := inuID_PROYECTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_TIPO_TRABAJO,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
			 )
		then
			 return(rcData.PRECIO_TOTAL);
		end if;
		Load
		(
		 		inuID_TIPO_TRABAJO,
		 		inuID_COTIZACION_DETALLADA,
		 		inuID_PROYECTO
		);
		return(rcData.PRECIO_TOTAL);
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
end DALDC_CONSOLID_COTIZACION;
/
PROMPT Otorgando permisos de ejecucion a DALDC_CONSOLID_COTIZACION
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_CONSOLID_COTIZACION', 'ADM_PERSON');
END;
/