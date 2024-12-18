CREATE OR REPLACE PACKAGE ADM_PERSON.DALDC_VENTA_ESTUFA
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
		inuID_SOLICITUD in LDC_VENTA_ESTUFA.ID_SOLICITUD%type
	)
	IS
		SELECT LDC_VENTA_ESTUFA.*,LDC_VENTA_ESTUFA.rowid
		FROM LDC_VENTA_ESTUFA
		WHERE
		    ID_SOLICITUD = inuID_SOLICITUD;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_VENTA_ESTUFA.*,LDC_VENTA_ESTUFA.rowid
		FROM LDC_VENTA_ESTUFA
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_VENTA_ESTUFA  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_VENTA_ESTUFA is table of styLDC_VENTA_ESTUFA index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_VENTA_ESTUFA;

	/* Tipos referenciando al registro */
	type tytbID_SOLICITUD is table of LDC_VENTA_ESTUFA.ID_SOLICITUD%type index by binary_integer;
	type tytbFECHA is table of LDC_VENTA_ESTUFA.FECHA%type index by binary_integer;
	type tytbPRODUCTO is table of LDC_VENTA_ESTUFA.PRODUCTO%type index by binary_integer;
	type tytbNUM_CUOTAS is table of LDC_VENTA_ESTUFA.NUM_CUOTAS%type index by binary_integer;
	type tytbID_PLAN_FINAN is table of LDC_VENTA_ESTUFA.ID_PLAN_FINAN%type index by binary_integer;
	type tytbID_DIFERIDO is table of LDC_VENTA_ESTUFA.ID_DIFERIDO%type index by binary_integer;
	type tytbID_ORDEN is table of LDC_VENTA_ESTUFA.ID_ORDEN%type index by binary_integer;
	type tytbID_LISTA is table of LDC_VENTA_ESTUFA.ID_LISTA%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_VENTA_ESTUFA is record
	(
		ID_SOLICITUD   tytbID_SOLICITUD,
		FECHA   tytbFECHA,
		PRODUCTO   tytbPRODUCTO,
		NUM_CUOTAS   tytbNUM_CUOTAS,
		ID_PLAN_FINAN   tytbID_PLAN_FINAN,
		ID_DIFERIDO   tytbID_DIFERIDO,
		ID_ORDEN   tytbID_ORDEN,
		ID_LISTA   tytbID_LISTA,
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
		inuID_SOLICITUD in LDC_VENTA_ESTUFA.ID_SOLICITUD%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuID_SOLICITUD in LDC_VENTA_ESTUFA.ID_SOLICITUD%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuID_SOLICITUD in LDC_VENTA_ESTUFA.ID_SOLICITUD%type
	);

	PROCEDURE getRecord
	(
		inuID_SOLICITUD in LDC_VENTA_ESTUFA.ID_SOLICITUD%type,
		orcRecord out nocopy styLDC_VENTA_ESTUFA
	);

	FUNCTION frcGetRcData
	(
		inuID_SOLICITUD in LDC_VENTA_ESTUFA.ID_SOLICITUD%type
	)
	RETURN styLDC_VENTA_ESTUFA;

	FUNCTION frcGetRcData
	RETURN styLDC_VENTA_ESTUFA;

	FUNCTION frcGetRecord
	(
		inuID_SOLICITUD in LDC_VENTA_ESTUFA.ID_SOLICITUD%type
	)
	RETURN styLDC_VENTA_ESTUFA;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_VENTA_ESTUFA
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_VENTA_ESTUFA in styLDC_VENTA_ESTUFA
	);

	PROCEDURE insRecord
	(
		ircLDC_VENTA_ESTUFA in styLDC_VENTA_ESTUFA,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_VENTA_ESTUFA in out nocopy tytbLDC_VENTA_ESTUFA
	);

	PROCEDURE delRecord
	(
		inuID_SOLICITUD in LDC_VENTA_ESTUFA.ID_SOLICITUD%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_VENTA_ESTUFA in out nocopy tytbLDC_VENTA_ESTUFA,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_VENTA_ESTUFA in styLDC_VENTA_ESTUFA,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_VENTA_ESTUFA in out nocopy tytbLDC_VENTA_ESTUFA,
		inuLock in number default 1
	);

	PROCEDURE updFECHA
	(
		inuID_SOLICITUD in LDC_VENTA_ESTUFA.ID_SOLICITUD%type,
		idtFECHA$ in LDC_VENTA_ESTUFA.FECHA%type,
		inuLock in number default 0
	);

	PROCEDURE updPRODUCTO
	(
		inuID_SOLICITUD in LDC_VENTA_ESTUFA.ID_SOLICITUD%type,
		inuPRODUCTO$ in LDC_VENTA_ESTUFA.PRODUCTO%type,
		inuLock in number default 0
	);

	PROCEDURE updNUM_CUOTAS
	(
		inuID_SOLICITUD in LDC_VENTA_ESTUFA.ID_SOLICITUD%type,
		inuNUM_CUOTAS$ in LDC_VENTA_ESTUFA.NUM_CUOTAS%type,
		inuLock in number default 0
	);

	PROCEDURE updID_PLAN_FINAN
	(
		inuID_SOLICITUD in LDC_VENTA_ESTUFA.ID_SOLICITUD%type,
		inuID_PLAN_FINAN$ in LDC_VENTA_ESTUFA.ID_PLAN_FINAN%type,
		inuLock in number default 0
	);

	PROCEDURE updID_DIFERIDO
	(
		inuID_SOLICITUD in LDC_VENTA_ESTUFA.ID_SOLICITUD%type,
		inuID_DIFERIDO$ in LDC_VENTA_ESTUFA.ID_DIFERIDO%type,
		inuLock in number default 0
	);

	PROCEDURE updID_ORDEN
	(
		inuID_SOLICITUD in LDC_VENTA_ESTUFA.ID_SOLICITUD%type,
		inuID_ORDEN$ in LDC_VENTA_ESTUFA.ID_ORDEN%type,
		inuLock in number default 0
	);

	PROCEDURE updID_LISTA
	(
		inuID_SOLICITUD in LDC_VENTA_ESTUFA.ID_SOLICITUD%type,
		inuID_LISTA$ in LDC_VENTA_ESTUFA.ID_LISTA%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetID_SOLICITUD
	(
		inuID_SOLICITUD in LDC_VENTA_ESTUFA.ID_SOLICITUD%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VENTA_ESTUFA.ID_SOLICITUD%type;

	FUNCTION fdtGetFECHA
	(
		inuID_SOLICITUD in LDC_VENTA_ESTUFA.ID_SOLICITUD%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VENTA_ESTUFA.FECHA%type;

	FUNCTION fnuGetPRODUCTO
	(
		inuID_SOLICITUD in LDC_VENTA_ESTUFA.ID_SOLICITUD%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VENTA_ESTUFA.PRODUCTO%type;

	FUNCTION fnuGetNUM_CUOTAS
	(
		inuID_SOLICITUD in LDC_VENTA_ESTUFA.ID_SOLICITUD%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VENTA_ESTUFA.NUM_CUOTAS%type;

	FUNCTION fnuGetID_PLAN_FINAN
	(
		inuID_SOLICITUD in LDC_VENTA_ESTUFA.ID_SOLICITUD%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VENTA_ESTUFA.ID_PLAN_FINAN%type;

	FUNCTION fnuGetID_DIFERIDO
	(
		inuID_SOLICITUD in LDC_VENTA_ESTUFA.ID_SOLICITUD%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VENTA_ESTUFA.ID_DIFERIDO%type;

	FUNCTION fnuGetID_ORDEN
	(
		inuID_SOLICITUD in LDC_VENTA_ESTUFA.ID_SOLICITUD%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VENTA_ESTUFA.ID_ORDEN%type;

	FUNCTION fnuGetID_LISTA
	(
		inuID_SOLICITUD in LDC_VENTA_ESTUFA.ID_SOLICITUD%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VENTA_ESTUFA.ID_LISTA%type;


	PROCEDURE LockByPk
	(
		inuID_SOLICITUD in LDC_VENTA_ESTUFA.ID_SOLICITUD%type,
		orcLDC_VENTA_ESTUFA  out styLDC_VENTA_ESTUFA
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_VENTA_ESTUFA  out styLDC_VENTA_ESTUFA
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_VENTA_ESTUFA;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALDC_VENTA_ESTUFA
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_VENTA_ESTUFA';
	 cnuGeEntityId constant varchar2(30) := 4122; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuID_SOLICITUD in LDC_VENTA_ESTUFA.ID_SOLICITUD%type
	)
	IS
		SELECT LDC_VENTA_ESTUFA.*,LDC_VENTA_ESTUFA.rowid
		FROM LDC_VENTA_ESTUFA
		WHERE  ID_SOLICITUD = inuID_SOLICITUD
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_VENTA_ESTUFA.*,LDC_VENTA_ESTUFA.rowid
		FROM LDC_VENTA_ESTUFA
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_VENTA_ESTUFA is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_VENTA_ESTUFA;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_VENTA_ESTUFA default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.ID_SOLICITUD);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuID_SOLICITUD in LDC_VENTA_ESTUFA.ID_SOLICITUD%type,
		orcLDC_VENTA_ESTUFA  out styLDC_VENTA_ESTUFA
	)
	IS
		rcError styLDC_VENTA_ESTUFA;
	BEGIN
		rcError.ID_SOLICITUD := inuID_SOLICITUD;

		Open cuLockRcByPk
		(
			inuID_SOLICITUD
		);

		fetch cuLockRcByPk into orcLDC_VENTA_ESTUFA;
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
		orcLDC_VENTA_ESTUFA  out styLDC_VENTA_ESTUFA
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_VENTA_ESTUFA;
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
		itbLDC_VENTA_ESTUFA  in out nocopy tytbLDC_VENTA_ESTUFA
	)
	IS
	BEGIN
			rcRecOfTab.ID_SOLICITUD.delete;
			rcRecOfTab.FECHA.delete;
			rcRecOfTab.PRODUCTO.delete;
			rcRecOfTab.NUM_CUOTAS.delete;
			rcRecOfTab.ID_PLAN_FINAN.delete;
			rcRecOfTab.ID_DIFERIDO.delete;
			rcRecOfTab.ID_ORDEN.delete;
			rcRecOfTab.ID_LISTA.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_VENTA_ESTUFA  in out nocopy tytbLDC_VENTA_ESTUFA,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_VENTA_ESTUFA);

		for n in itbLDC_VENTA_ESTUFA.first .. itbLDC_VENTA_ESTUFA.last loop
			rcRecOfTab.ID_SOLICITUD(n) := itbLDC_VENTA_ESTUFA(n).ID_SOLICITUD;
			rcRecOfTab.FECHA(n) := itbLDC_VENTA_ESTUFA(n).FECHA;
			rcRecOfTab.PRODUCTO(n) := itbLDC_VENTA_ESTUFA(n).PRODUCTO;
			rcRecOfTab.NUM_CUOTAS(n) := itbLDC_VENTA_ESTUFA(n).NUM_CUOTAS;
			rcRecOfTab.ID_PLAN_FINAN(n) := itbLDC_VENTA_ESTUFA(n).ID_PLAN_FINAN;
			rcRecOfTab.ID_DIFERIDO(n) := itbLDC_VENTA_ESTUFA(n).ID_DIFERIDO;
			rcRecOfTab.ID_ORDEN(n) := itbLDC_VENTA_ESTUFA(n).ID_ORDEN;
			rcRecOfTab.ID_LISTA(n) := itbLDC_VENTA_ESTUFA(n).ID_LISTA;
			rcRecOfTab.row_id(n) := itbLDC_VENTA_ESTUFA(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuID_SOLICITUD in LDC_VENTA_ESTUFA.ID_SOLICITUD%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuID_SOLICITUD
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
		inuID_SOLICITUD in LDC_VENTA_ESTUFA.ID_SOLICITUD%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuID_SOLICITUD = rcData.ID_SOLICITUD
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
		inuID_SOLICITUD in LDC_VENTA_ESTUFA.ID_SOLICITUD%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuID_SOLICITUD
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuID_SOLICITUD in LDC_VENTA_ESTUFA.ID_SOLICITUD%type
	)
	IS
		rcError styLDC_VENTA_ESTUFA;
	BEGIN		rcError.ID_SOLICITUD:=inuID_SOLICITUD;

		Load
		(
			inuID_SOLICITUD
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
		inuID_SOLICITUD in LDC_VENTA_ESTUFA.ID_SOLICITUD%type
	)
	IS
	BEGIN
		Load
		(
			inuID_SOLICITUD
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuID_SOLICITUD in LDC_VENTA_ESTUFA.ID_SOLICITUD%type,
		orcRecord out nocopy styLDC_VENTA_ESTUFA
	)
	IS
		rcError styLDC_VENTA_ESTUFA;
	BEGIN		rcError.ID_SOLICITUD:=inuID_SOLICITUD;

		Load
		(
			inuID_SOLICITUD
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuID_SOLICITUD in LDC_VENTA_ESTUFA.ID_SOLICITUD%type
	)
	RETURN styLDC_VENTA_ESTUFA
	IS
		rcError styLDC_VENTA_ESTUFA;
	BEGIN
		rcError.ID_SOLICITUD:=inuID_SOLICITUD;

		Load
		(
			inuID_SOLICITUD
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuID_SOLICITUD in LDC_VENTA_ESTUFA.ID_SOLICITUD%type
	)
	RETURN styLDC_VENTA_ESTUFA
	IS
		rcError styLDC_VENTA_ESTUFA;
	BEGIN
		rcError.ID_SOLICITUD:=inuID_SOLICITUD;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuID_SOLICITUD
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuID_SOLICITUD
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_VENTA_ESTUFA
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_VENTA_ESTUFA
	)
	IS
		rfLDC_VENTA_ESTUFA tyrfLDC_VENTA_ESTUFA;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_VENTA_ESTUFA.*, LDC_VENTA_ESTUFA.rowid FROM LDC_VENTA_ESTUFA';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_VENTA_ESTUFA for sbFullQuery;

		fetch rfLDC_VENTA_ESTUFA bulk collect INTO otbResult;

		close rfLDC_VENTA_ESTUFA;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_VENTA_ESTUFA.*, LDC_VENTA_ESTUFA.rowid FROM LDC_VENTA_ESTUFA';
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
		ircLDC_VENTA_ESTUFA in styLDC_VENTA_ESTUFA
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_VENTA_ESTUFA,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_VENTA_ESTUFA in styLDC_VENTA_ESTUFA,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_VENTA_ESTUFA.ID_SOLICITUD is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ID_SOLICITUD');
			raise ex.controlled_error;
		end if;

		insert into LDC_VENTA_ESTUFA
		(
			ID_SOLICITUD,
			FECHA,
			PRODUCTO,
			NUM_CUOTAS,
			ID_PLAN_FINAN,
			ID_DIFERIDO,
			ID_ORDEN,
			ID_LISTA
		)
		values
		(
			ircLDC_VENTA_ESTUFA.ID_SOLICITUD,
			ircLDC_VENTA_ESTUFA.FECHA,
			ircLDC_VENTA_ESTUFA.PRODUCTO,
			ircLDC_VENTA_ESTUFA.NUM_CUOTAS,
			ircLDC_VENTA_ESTUFA.ID_PLAN_FINAN,
			ircLDC_VENTA_ESTUFA.ID_DIFERIDO,
			ircLDC_VENTA_ESTUFA.ID_ORDEN,
			ircLDC_VENTA_ESTUFA.ID_LISTA
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_VENTA_ESTUFA));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_VENTA_ESTUFA in out nocopy tytbLDC_VENTA_ESTUFA
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_VENTA_ESTUFA,blUseRowID);
		forall n in iotbLDC_VENTA_ESTUFA.first..iotbLDC_VENTA_ESTUFA.last
			insert into LDC_VENTA_ESTUFA
			(
				ID_SOLICITUD,
				FECHA,
				PRODUCTO,
				NUM_CUOTAS,
				ID_PLAN_FINAN,
				ID_DIFERIDO,
				ID_ORDEN,
				ID_LISTA
			)
			values
			(
				rcRecOfTab.ID_SOLICITUD(n),
				rcRecOfTab.FECHA(n),
				rcRecOfTab.PRODUCTO(n),
				rcRecOfTab.NUM_CUOTAS(n),
				rcRecOfTab.ID_PLAN_FINAN(n),
				rcRecOfTab.ID_DIFERIDO(n),
				rcRecOfTab.ID_ORDEN(n),
				rcRecOfTab.ID_LISTA(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuID_SOLICITUD in LDC_VENTA_ESTUFA.ID_SOLICITUD%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_VENTA_ESTUFA;
	BEGIN
		rcError.ID_SOLICITUD := inuID_SOLICITUD;

		if inuLock=1 then
			LockByPk
			(
				inuID_SOLICITUD,
				rcData
			);
		end if;


		delete
		from LDC_VENTA_ESTUFA
		where
       		ID_SOLICITUD=inuID_SOLICITUD;
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
		rcError  styLDC_VENTA_ESTUFA;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_VENTA_ESTUFA
		where
			rowid = iriRowID
		returning
			ID_SOLICITUD
		into
			rcError.ID_SOLICITUD;
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
		iotbLDC_VENTA_ESTUFA in out nocopy tytbLDC_VENTA_ESTUFA,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_VENTA_ESTUFA;
	BEGIN
		FillRecordOfTables(iotbLDC_VENTA_ESTUFA, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_VENTA_ESTUFA.first .. iotbLDC_VENTA_ESTUFA.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_VENTA_ESTUFA.first .. iotbLDC_VENTA_ESTUFA.last
				delete
				from LDC_VENTA_ESTUFA
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_VENTA_ESTUFA.first .. iotbLDC_VENTA_ESTUFA.last loop
					LockByPk
					(
						rcRecOfTab.ID_SOLICITUD(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_VENTA_ESTUFA.first .. iotbLDC_VENTA_ESTUFA.last
				delete
				from LDC_VENTA_ESTUFA
				where
		         	ID_SOLICITUD = rcRecOfTab.ID_SOLICITUD(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_VENTA_ESTUFA in styLDC_VENTA_ESTUFA,
		inuLock in number default 0
	)
	IS
		nuID_SOLICITUD	LDC_VENTA_ESTUFA.ID_SOLICITUD%type;
	BEGIN
		if ircLDC_VENTA_ESTUFA.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_VENTA_ESTUFA.rowid,rcData);
			end if;
			update LDC_VENTA_ESTUFA
			set
				FECHA = ircLDC_VENTA_ESTUFA.FECHA,
				PRODUCTO = ircLDC_VENTA_ESTUFA.PRODUCTO,
				NUM_CUOTAS = ircLDC_VENTA_ESTUFA.NUM_CUOTAS,
				ID_PLAN_FINAN = ircLDC_VENTA_ESTUFA.ID_PLAN_FINAN,
				ID_DIFERIDO = ircLDC_VENTA_ESTUFA.ID_DIFERIDO,
				ID_ORDEN = ircLDC_VENTA_ESTUFA.ID_ORDEN,
				ID_LISTA = ircLDC_VENTA_ESTUFA.ID_LISTA
			where
				rowid = ircLDC_VENTA_ESTUFA.rowid
			returning
				ID_SOLICITUD
			into
				nuID_SOLICITUD;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_VENTA_ESTUFA.ID_SOLICITUD,
					rcData
				);
			end if;

			update LDC_VENTA_ESTUFA
			set
				FECHA = ircLDC_VENTA_ESTUFA.FECHA,
				PRODUCTO = ircLDC_VENTA_ESTUFA.PRODUCTO,
				NUM_CUOTAS = ircLDC_VENTA_ESTUFA.NUM_CUOTAS,
				ID_PLAN_FINAN = ircLDC_VENTA_ESTUFA.ID_PLAN_FINAN,
				ID_DIFERIDO = ircLDC_VENTA_ESTUFA.ID_DIFERIDO,
				ID_ORDEN = ircLDC_VENTA_ESTUFA.ID_ORDEN,
				ID_LISTA = ircLDC_VENTA_ESTUFA.ID_LISTA
			where
				ID_SOLICITUD = ircLDC_VENTA_ESTUFA.ID_SOLICITUD
			returning
				ID_SOLICITUD
			into
				nuID_SOLICITUD;
		end if;
		if
			nuID_SOLICITUD is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_VENTA_ESTUFA));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_VENTA_ESTUFA in out nocopy tytbLDC_VENTA_ESTUFA,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_VENTA_ESTUFA;
	BEGIN
		FillRecordOfTables(iotbLDC_VENTA_ESTUFA,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_VENTA_ESTUFA.first .. iotbLDC_VENTA_ESTUFA.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_VENTA_ESTUFA.first .. iotbLDC_VENTA_ESTUFA.last
				update LDC_VENTA_ESTUFA
				set
					FECHA = rcRecOfTab.FECHA(n),
					PRODUCTO = rcRecOfTab.PRODUCTO(n),
					NUM_CUOTAS = rcRecOfTab.NUM_CUOTAS(n),
					ID_PLAN_FINAN = rcRecOfTab.ID_PLAN_FINAN(n),
					ID_DIFERIDO = rcRecOfTab.ID_DIFERIDO(n),
					ID_ORDEN = rcRecOfTab.ID_ORDEN(n),
					ID_LISTA = rcRecOfTab.ID_LISTA(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_VENTA_ESTUFA.first .. iotbLDC_VENTA_ESTUFA.last loop
					LockByPk
					(
						rcRecOfTab.ID_SOLICITUD(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_VENTA_ESTUFA.first .. iotbLDC_VENTA_ESTUFA.last
				update LDC_VENTA_ESTUFA
				SET
					FECHA = rcRecOfTab.FECHA(n),
					PRODUCTO = rcRecOfTab.PRODUCTO(n),
					NUM_CUOTAS = rcRecOfTab.NUM_CUOTAS(n),
					ID_PLAN_FINAN = rcRecOfTab.ID_PLAN_FINAN(n),
					ID_DIFERIDO = rcRecOfTab.ID_DIFERIDO(n),
					ID_ORDEN = rcRecOfTab.ID_ORDEN(n),
					ID_LISTA = rcRecOfTab.ID_LISTA(n)
				where
					ID_SOLICITUD = rcRecOfTab.ID_SOLICITUD(n)
;
		end if;
	END;
	PROCEDURE updFECHA
	(
		inuID_SOLICITUD in LDC_VENTA_ESTUFA.ID_SOLICITUD%type,
		idtFECHA$ in LDC_VENTA_ESTUFA.FECHA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_VENTA_ESTUFA;
	BEGIN
		rcError.ID_SOLICITUD := inuID_SOLICITUD;
		if inuLock=1 then
			LockByPk
			(
				inuID_SOLICITUD,
				rcData
			);
		end if;

		update LDC_VENTA_ESTUFA
		set
			FECHA = idtFECHA$
		where
			ID_SOLICITUD = inuID_SOLICITUD;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FECHA:= idtFECHA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPRODUCTO
	(
		inuID_SOLICITUD in LDC_VENTA_ESTUFA.ID_SOLICITUD%type,
		inuPRODUCTO$ in LDC_VENTA_ESTUFA.PRODUCTO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_VENTA_ESTUFA;
	BEGIN
		rcError.ID_SOLICITUD := inuID_SOLICITUD;
		if inuLock=1 then
			LockByPk
			(
				inuID_SOLICITUD,
				rcData
			);
		end if;

		update LDC_VENTA_ESTUFA
		set
			PRODUCTO = inuPRODUCTO$
		where
			ID_SOLICITUD = inuID_SOLICITUD;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PRODUCTO:= inuPRODUCTO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updNUM_CUOTAS
	(
		inuID_SOLICITUD in LDC_VENTA_ESTUFA.ID_SOLICITUD%type,
		inuNUM_CUOTAS$ in LDC_VENTA_ESTUFA.NUM_CUOTAS%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_VENTA_ESTUFA;
	BEGIN
		rcError.ID_SOLICITUD := inuID_SOLICITUD;
		if inuLock=1 then
			LockByPk
			(
				inuID_SOLICITUD,
				rcData
			);
		end if;

		update LDC_VENTA_ESTUFA
		set
			NUM_CUOTAS = inuNUM_CUOTAS$
		where
			ID_SOLICITUD = inuID_SOLICITUD;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.NUM_CUOTAS:= inuNUM_CUOTAS$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updID_PLAN_FINAN
	(
		inuID_SOLICITUD in LDC_VENTA_ESTUFA.ID_SOLICITUD%type,
		inuID_PLAN_FINAN$ in LDC_VENTA_ESTUFA.ID_PLAN_FINAN%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_VENTA_ESTUFA;
	BEGIN
		rcError.ID_SOLICITUD := inuID_SOLICITUD;
		if inuLock=1 then
			LockByPk
			(
				inuID_SOLICITUD,
				rcData
			);
		end if;

		update LDC_VENTA_ESTUFA
		set
			ID_PLAN_FINAN = inuID_PLAN_FINAN$
		where
			ID_SOLICITUD = inuID_SOLICITUD;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ID_PLAN_FINAN:= inuID_PLAN_FINAN$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updID_DIFERIDO
	(
		inuID_SOLICITUD in LDC_VENTA_ESTUFA.ID_SOLICITUD%type,
		inuID_DIFERIDO$ in LDC_VENTA_ESTUFA.ID_DIFERIDO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_VENTA_ESTUFA;
	BEGIN
		rcError.ID_SOLICITUD := inuID_SOLICITUD;
		if inuLock=1 then
			LockByPk
			(
				inuID_SOLICITUD,
				rcData
			);
		end if;

		update LDC_VENTA_ESTUFA
		set
			ID_DIFERIDO = inuID_DIFERIDO$
		where
			ID_SOLICITUD = inuID_SOLICITUD;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ID_DIFERIDO:= inuID_DIFERIDO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updID_ORDEN
	(
		inuID_SOLICITUD in LDC_VENTA_ESTUFA.ID_SOLICITUD%type,
		inuID_ORDEN$ in LDC_VENTA_ESTUFA.ID_ORDEN%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_VENTA_ESTUFA;
	BEGIN
		rcError.ID_SOLICITUD := inuID_SOLICITUD;
		if inuLock=1 then
			LockByPk
			(
				inuID_SOLICITUD,
				rcData
			);
		end if;

		update LDC_VENTA_ESTUFA
		set
			ID_ORDEN = inuID_ORDEN$
		where
			ID_SOLICITUD = inuID_SOLICITUD;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ID_ORDEN:= inuID_ORDEN$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updID_LISTA
	(
		inuID_SOLICITUD in LDC_VENTA_ESTUFA.ID_SOLICITUD%type,
		inuID_LISTA$ in LDC_VENTA_ESTUFA.ID_LISTA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_VENTA_ESTUFA;
	BEGIN
		rcError.ID_SOLICITUD := inuID_SOLICITUD;
		if inuLock=1 then
			LockByPk
			(
				inuID_SOLICITUD,
				rcData
			);
		end if;

		update LDC_VENTA_ESTUFA
		set
			ID_LISTA = inuID_LISTA$
		where
			ID_SOLICITUD = inuID_SOLICITUD;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ID_LISTA:= inuID_LISTA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetID_SOLICITUD
	(
		inuID_SOLICITUD in LDC_VENTA_ESTUFA.ID_SOLICITUD%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VENTA_ESTUFA.ID_SOLICITUD%type
	IS
		rcError styLDC_VENTA_ESTUFA;
	BEGIN

		rcError.ID_SOLICITUD := inuID_SOLICITUD;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_SOLICITUD
			 )
		then
			 return(rcData.ID_SOLICITUD);
		end if;
		Load
		(
		 		inuID_SOLICITUD
		);
		return(rcData.ID_SOLICITUD);
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
		inuID_SOLICITUD in LDC_VENTA_ESTUFA.ID_SOLICITUD%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VENTA_ESTUFA.FECHA%type
	IS
		rcError styLDC_VENTA_ESTUFA;
	BEGIN

		rcError.ID_SOLICITUD := inuID_SOLICITUD;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_SOLICITUD
			 )
		then
			 return(rcData.FECHA);
		end if;
		Load
		(
		 		inuID_SOLICITUD
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
	FUNCTION fnuGetPRODUCTO
	(
		inuID_SOLICITUD in LDC_VENTA_ESTUFA.ID_SOLICITUD%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VENTA_ESTUFA.PRODUCTO%type
	IS
		rcError styLDC_VENTA_ESTUFA;
	BEGIN

		rcError.ID_SOLICITUD := inuID_SOLICITUD;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_SOLICITUD
			 )
		then
			 return(rcData.PRODUCTO);
		end if;
		Load
		(
		 		inuID_SOLICITUD
		);
		return(rcData.PRODUCTO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetNUM_CUOTAS
	(
		inuID_SOLICITUD in LDC_VENTA_ESTUFA.ID_SOLICITUD%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VENTA_ESTUFA.NUM_CUOTAS%type
	IS
		rcError styLDC_VENTA_ESTUFA;
	BEGIN

		rcError.ID_SOLICITUD := inuID_SOLICITUD;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_SOLICITUD
			 )
		then
			 return(rcData.NUM_CUOTAS);
		end if;
		Load
		(
		 		inuID_SOLICITUD
		);
		return(rcData.NUM_CUOTAS);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetID_PLAN_FINAN
	(
		inuID_SOLICITUD in LDC_VENTA_ESTUFA.ID_SOLICITUD%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VENTA_ESTUFA.ID_PLAN_FINAN%type
	IS
		rcError styLDC_VENTA_ESTUFA;
	BEGIN

		rcError.ID_SOLICITUD := inuID_SOLICITUD;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_SOLICITUD
			 )
		then
			 return(rcData.ID_PLAN_FINAN);
		end if;
		Load
		(
		 		inuID_SOLICITUD
		);
		return(rcData.ID_PLAN_FINAN);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetID_DIFERIDO
	(
		inuID_SOLICITUD in LDC_VENTA_ESTUFA.ID_SOLICITUD%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VENTA_ESTUFA.ID_DIFERIDO%type
	IS
		rcError styLDC_VENTA_ESTUFA;
	BEGIN

		rcError.ID_SOLICITUD := inuID_SOLICITUD;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_SOLICITUD
			 )
		then
			 return(rcData.ID_DIFERIDO);
		end if;
		Load
		(
		 		inuID_SOLICITUD
		);
		return(rcData.ID_DIFERIDO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetID_ORDEN
	(
		inuID_SOLICITUD in LDC_VENTA_ESTUFA.ID_SOLICITUD%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VENTA_ESTUFA.ID_ORDEN%type
	IS
		rcError styLDC_VENTA_ESTUFA;
	BEGIN

		rcError.ID_SOLICITUD := inuID_SOLICITUD;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_SOLICITUD
			 )
		then
			 return(rcData.ID_ORDEN);
		end if;
		Load
		(
		 		inuID_SOLICITUD
		);
		return(rcData.ID_ORDEN);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetID_LISTA
	(
		inuID_SOLICITUD in LDC_VENTA_ESTUFA.ID_SOLICITUD%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VENTA_ESTUFA.ID_LISTA%type
	IS
		rcError styLDC_VENTA_ESTUFA;
	BEGIN

		rcError.ID_SOLICITUD := inuID_SOLICITUD;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_SOLICITUD
			 )
		then
			 return(rcData.ID_LISTA);
		end if;
		Load
		(
		 		inuID_SOLICITUD
		);
		return(rcData.ID_LISTA);
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
end DALDC_VENTA_ESTUFA;
/
PROMPT Otorgando permisos de ejecucion a DALDC_VENTA_ESTUFA
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_VENTA_ESTUFA', 'ADM_PERSON');
END;
/