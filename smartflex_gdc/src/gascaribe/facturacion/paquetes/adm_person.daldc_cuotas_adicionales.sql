CREATE OR REPLACE PACKAGE ADM_PERSON.DALDC_CUOTAS_ADICIONALES
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
		inuCONSECUTIVO in LDC_CUOTAS_ADICIONALES.CONSECUTIVO%type
	)
	IS
		SELECT LDC_CUOTAS_ADICIONALES.*,LDC_CUOTAS_ADICIONALES.rowid
		FROM LDC_CUOTAS_ADICIONALES
		WHERE
		    CONSECUTIVO = inuCONSECUTIVO;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_CUOTAS_ADICIONALES.*,LDC_CUOTAS_ADICIONALES.rowid
		FROM LDC_CUOTAS_ADICIONALES
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_CUOTAS_ADICIONALES  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_CUOTAS_ADICIONALES is table of styLDC_CUOTAS_ADICIONALES index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_CUOTAS_ADICIONALES;

	/* Tipos referenciando al registro */
	type tytbCONSECUTIVO is table of LDC_CUOTAS_ADICIONALES.CONSECUTIVO%type index by binary_integer;
	type tytbID_PROYECTO is table of LDC_CUOTAS_ADICIONALES.ID_PROYECTO%type index by binary_integer;
	type tytbVALOR is table of LDC_CUOTAS_ADICIONALES.VALOR%type index by binary_integer;
	type tytbCUPON is table of LDC_CUOTAS_ADICIONALES.CUPON%type index by binary_integer;
	type tytbTIPO_CUOTA is table of LDC_CUOTAS_ADICIONALES.TIPO_CUOTA%type index by binary_integer;
	type tytbFECHA_REGISTRO is table of LDC_CUOTAS_ADICIONALES.FECHA_REGISTRO%type index by binary_integer;
	type tytbUSUA_REGISTRA is table of LDC_CUOTAS_ADICIONALES.USUA_REGISTRA%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_CUOTAS_ADICIONALES is record
	(
		CONSECUTIVO   tytbCONSECUTIVO,
		ID_PROYECTO   tytbID_PROYECTO,
		VALOR   tytbVALOR,
		CUPON   tytbCUPON,
		TIPO_CUOTA   tytbTIPO_CUOTA,
		FECHA_REGISTRO   tytbFECHA_REGISTRO,
		USUA_REGISTRA   tytbUSUA_REGISTRA,
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
		inuCONSECUTIVO in LDC_CUOTAS_ADICIONALES.CONSECUTIVO%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuCONSECUTIVO in LDC_CUOTAS_ADICIONALES.CONSECUTIVO%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuCONSECUTIVO in LDC_CUOTAS_ADICIONALES.CONSECUTIVO%type
	);

	PROCEDURE getRecord
	(
		inuCONSECUTIVO in LDC_CUOTAS_ADICIONALES.CONSECUTIVO%type,
		orcRecord out nocopy styLDC_CUOTAS_ADICIONALES
	);

	FUNCTION frcGetRcData
	(
		inuCONSECUTIVO in LDC_CUOTAS_ADICIONALES.CONSECUTIVO%type
	)
	RETURN styLDC_CUOTAS_ADICIONALES;

	FUNCTION frcGetRcData
	RETURN styLDC_CUOTAS_ADICIONALES;

	FUNCTION frcGetRecord
	(
		inuCONSECUTIVO in LDC_CUOTAS_ADICIONALES.CONSECUTIVO%type
	)
	RETURN styLDC_CUOTAS_ADICIONALES;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_CUOTAS_ADICIONALES
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_CUOTAS_ADICIONALES in styLDC_CUOTAS_ADICIONALES
	);

	PROCEDURE insRecord
	(
		ircLDC_CUOTAS_ADICIONALES in styLDC_CUOTAS_ADICIONALES,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_CUOTAS_ADICIONALES in out nocopy tytbLDC_CUOTAS_ADICIONALES
	);

	PROCEDURE delRecord
	(
		inuCONSECUTIVO in LDC_CUOTAS_ADICIONALES.CONSECUTIVO%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_CUOTAS_ADICIONALES in out nocopy tytbLDC_CUOTAS_ADICIONALES,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_CUOTAS_ADICIONALES in styLDC_CUOTAS_ADICIONALES,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_CUOTAS_ADICIONALES in out nocopy tytbLDC_CUOTAS_ADICIONALES,
		inuLock in number default 1
	);

	PROCEDURE updID_PROYECTO
	(
		inuCONSECUTIVO in LDC_CUOTAS_ADICIONALES.CONSECUTIVO%type,
		inuID_PROYECTO$ in LDC_CUOTAS_ADICIONALES.ID_PROYECTO%type,
		inuLock in number default 0
	);

	PROCEDURE updVALOR
	(
		inuCONSECUTIVO in LDC_CUOTAS_ADICIONALES.CONSECUTIVO%type,
		inuVALOR$ in LDC_CUOTAS_ADICIONALES.VALOR%type,
		inuLock in number default 0
	);

	PROCEDURE updCUPON
	(
		inuCONSECUTIVO in LDC_CUOTAS_ADICIONALES.CONSECUTIVO%type,
		inuCUPON$ in LDC_CUOTAS_ADICIONALES.CUPON%type,
		inuLock in number default 0
	);

	PROCEDURE updTIPO_CUOTA
	(
		inuCONSECUTIVO in LDC_CUOTAS_ADICIONALES.CONSECUTIVO%type,
		isbTIPO_CUOTA$ in LDC_CUOTAS_ADICIONALES.TIPO_CUOTA%type,
		inuLock in number default 0
	);

	PROCEDURE updFECHA_REGISTRO
	(
		inuCONSECUTIVO in LDC_CUOTAS_ADICIONALES.CONSECUTIVO%type,
		idtFECHA_REGISTRO$ in LDC_CUOTAS_ADICIONALES.FECHA_REGISTRO%type,
		inuLock in number default 0
	);

	PROCEDURE updUSUA_REGISTRA
	(
		inuCONSECUTIVO in LDC_CUOTAS_ADICIONALES.CONSECUTIVO%type,
		isbUSUA_REGISTRA$ in LDC_CUOTAS_ADICIONALES.USUA_REGISTRA%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetCONSECUTIVO
	(
		inuCONSECUTIVO in LDC_CUOTAS_ADICIONALES.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CUOTAS_ADICIONALES.CONSECUTIVO%type;

	FUNCTION fnuGetID_PROYECTO
	(
		inuCONSECUTIVO in LDC_CUOTAS_ADICIONALES.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CUOTAS_ADICIONALES.ID_PROYECTO%type;

	FUNCTION fnuGetVALOR
	(
		inuCONSECUTIVO in LDC_CUOTAS_ADICIONALES.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CUOTAS_ADICIONALES.VALOR%type;

	FUNCTION fnuGetCUPON
	(
		inuCONSECUTIVO in LDC_CUOTAS_ADICIONALES.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CUOTAS_ADICIONALES.CUPON%type;

	FUNCTION fsbGetTIPO_CUOTA
	(
		inuCONSECUTIVO in LDC_CUOTAS_ADICIONALES.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CUOTAS_ADICIONALES.TIPO_CUOTA%type;

	FUNCTION fdtGetFECHA_REGISTRO
	(
		inuCONSECUTIVO in LDC_CUOTAS_ADICIONALES.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CUOTAS_ADICIONALES.FECHA_REGISTRO%type;

	FUNCTION fsbGetUSUA_REGISTRA
	(
		inuCONSECUTIVO in LDC_CUOTAS_ADICIONALES.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CUOTAS_ADICIONALES.USUA_REGISTRA%type;


	PROCEDURE LockByPk
	(
		inuCONSECUTIVO in LDC_CUOTAS_ADICIONALES.CONSECUTIVO%type,
		orcLDC_CUOTAS_ADICIONALES  out styLDC_CUOTAS_ADICIONALES
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_CUOTAS_ADICIONALES  out styLDC_CUOTAS_ADICIONALES
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_CUOTAS_ADICIONALES;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALDC_CUOTAS_ADICIONALES
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_CUOTAS_ADICIONALES';
	 cnuGeEntityId constant varchar2(30) := 2882; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuCONSECUTIVO in LDC_CUOTAS_ADICIONALES.CONSECUTIVO%type
	)
	IS
		SELECT LDC_CUOTAS_ADICIONALES.*,LDC_CUOTAS_ADICIONALES.rowid
		FROM LDC_CUOTAS_ADICIONALES
		WHERE  CONSECUTIVO = inuCONSECUTIVO
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_CUOTAS_ADICIONALES.*,LDC_CUOTAS_ADICIONALES.rowid
		FROM LDC_CUOTAS_ADICIONALES
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_CUOTAS_ADICIONALES is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_CUOTAS_ADICIONALES;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_CUOTAS_ADICIONALES default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.CONSECUTIVO);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuCONSECUTIVO in LDC_CUOTAS_ADICIONALES.CONSECUTIVO%type,
		orcLDC_CUOTAS_ADICIONALES  out styLDC_CUOTAS_ADICIONALES
	)
	IS
		rcError styLDC_CUOTAS_ADICIONALES;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;

		Open cuLockRcByPk
		(
			inuCONSECUTIVO
		);

		fetch cuLockRcByPk into orcLDC_CUOTAS_ADICIONALES;
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
		orcLDC_CUOTAS_ADICIONALES  out styLDC_CUOTAS_ADICIONALES
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_CUOTAS_ADICIONALES;
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
		itbLDC_CUOTAS_ADICIONALES  in out nocopy tytbLDC_CUOTAS_ADICIONALES
	)
	IS
	BEGIN
			rcRecOfTab.CONSECUTIVO.delete;
			rcRecOfTab.ID_PROYECTO.delete;
			rcRecOfTab.VALOR.delete;
			rcRecOfTab.CUPON.delete;
			rcRecOfTab.TIPO_CUOTA.delete;
			rcRecOfTab.FECHA_REGISTRO.delete;
			rcRecOfTab.USUA_REGISTRA.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_CUOTAS_ADICIONALES  in out nocopy tytbLDC_CUOTAS_ADICIONALES,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_CUOTAS_ADICIONALES);

		for n in itbLDC_CUOTAS_ADICIONALES.first .. itbLDC_CUOTAS_ADICIONALES.last loop
			rcRecOfTab.CONSECUTIVO(n) := itbLDC_CUOTAS_ADICIONALES(n).CONSECUTIVO;
			rcRecOfTab.ID_PROYECTO(n) := itbLDC_CUOTAS_ADICIONALES(n).ID_PROYECTO;
			rcRecOfTab.VALOR(n) := itbLDC_CUOTAS_ADICIONALES(n).VALOR;
			rcRecOfTab.CUPON(n) := itbLDC_CUOTAS_ADICIONALES(n).CUPON;
			rcRecOfTab.TIPO_CUOTA(n) := itbLDC_CUOTAS_ADICIONALES(n).TIPO_CUOTA;
			rcRecOfTab.FECHA_REGISTRO(n) := itbLDC_CUOTAS_ADICIONALES(n).FECHA_REGISTRO;
			rcRecOfTab.USUA_REGISTRA(n) := itbLDC_CUOTAS_ADICIONALES(n).USUA_REGISTRA;
			rcRecOfTab.row_id(n) := itbLDC_CUOTAS_ADICIONALES(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuCONSECUTIVO in LDC_CUOTAS_ADICIONALES.CONSECUTIVO%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuCONSECUTIVO
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
		inuCONSECUTIVO in LDC_CUOTAS_ADICIONALES.CONSECUTIVO%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuCONSECUTIVO = rcData.CONSECUTIVO
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
		inuCONSECUTIVO in LDC_CUOTAS_ADICIONALES.CONSECUTIVO%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuCONSECUTIVO
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuCONSECUTIVO in LDC_CUOTAS_ADICIONALES.CONSECUTIVO%type
	)
	IS
		rcError styLDC_CUOTAS_ADICIONALES;
	BEGIN		rcError.CONSECUTIVO:=inuCONSECUTIVO;

		Load
		(
			inuCONSECUTIVO
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
		inuCONSECUTIVO in LDC_CUOTAS_ADICIONALES.CONSECUTIVO%type
	)
	IS
	BEGIN
		Load
		(
			inuCONSECUTIVO
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuCONSECUTIVO in LDC_CUOTAS_ADICIONALES.CONSECUTIVO%type,
		orcRecord out nocopy styLDC_CUOTAS_ADICIONALES
	)
	IS
		rcError styLDC_CUOTAS_ADICIONALES;
	BEGIN		rcError.CONSECUTIVO:=inuCONSECUTIVO;

		Load
		(
			inuCONSECUTIVO
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuCONSECUTIVO in LDC_CUOTAS_ADICIONALES.CONSECUTIVO%type
	)
	RETURN styLDC_CUOTAS_ADICIONALES
	IS
		rcError styLDC_CUOTAS_ADICIONALES;
	BEGIN
		rcError.CONSECUTIVO:=inuCONSECUTIVO;

		Load
		(
			inuCONSECUTIVO
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuCONSECUTIVO in LDC_CUOTAS_ADICIONALES.CONSECUTIVO%type
	)
	RETURN styLDC_CUOTAS_ADICIONALES
	IS
		rcError styLDC_CUOTAS_ADICIONALES;
	BEGIN
		rcError.CONSECUTIVO:=inuCONSECUTIVO;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuCONSECUTIVO
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuCONSECUTIVO
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_CUOTAS_ADICIONALES
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_CUOTAS_ADICIONALES
	)
	IS
		rfLDC_CUOTAS_ADICIONALES tyrfLDC_CUOTAS_ADICIONALES;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_CUOTAS_ADICIONALES.*, LDC_CUOTAS_ADICIONALES.rowid FROM LDC_CUOTAS_ADICIONALES';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_CUOTAS_ADICIONALES for sbFullQuery;

		fetch rfLDC_CUOTAS_ADICIONALES bulk collect INTO otbResult;

		close rfLDC_CUOTAS_ADICIONALES;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_CUOTAS_ADICIONALES.*, LDC_CUOTAS_ADICIONALES.rowid FROM LDC_CUOTAS_ADICIONALES';
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
		ircLDC_CUOTAS_ADICIONALES in styLDC_CUOTAS_ADICIONALES
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_CUOTAS_ADICIONALES,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_CUOTAS_ADICIONALES in styLDC_CUOTAS_ADICIONALES,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_CUOTAS_ADICIONALES.CONSECUTIVO is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|CONSECUTIVO');
			raise ex.controlled_error;
		end if;

		insert into LDC_CUOTAS_ADICIONALES
		(
			CONSECUTIVO,
			ID_PROYECTO,
			VALOR,
			CUPON,
			TIPO_CUOTA,
			FECHA_REGISTRO,
			USUA_REGISTRA
		)
		values
		(
			ircLDC_CUOTAS_ADICIONALES.CONSECUTIVO,
			ircLDC_CUOTAS_ADICIONALES.ID_PROYECTO,
			ircLDC_CUOTAS_ADICIONALES.VALOR,
			ircLDC_CUOTAS_ADICIONALES.CUPON,
			ircLDC_CUOTAS_ADICIONALES.TIPO_CUOTA,
			ircLDC_CUOTAS_ADICIONALES.FECHA_REGISTRO,
			ircLDC_CUOTAS_ADICIONALES.USUA_REGISTRA
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_CUOTAS_ADICIONALES));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_CUOTAS_ADICIONALES in out nocopy tytbLDC_CUOTAS_ADICIONALES
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_CUOTAS_ADICIONALES,blUseRowID);
		forall n in iotbLDC_CUOTAS_ADICIONALES.first..iotbLDC_CUOTAS_ADICIONALES.last
			insert into LDC_CUOTAS_ADICIONALES
			(
				CONSECUTIVO,
				ID_PROYECTO,
				VALOR,
				CUPON,
				TIPO_CUOTA,
				FECHA_REGISTRO,
				USUA_REGISTRA
			)
			values
			(
				rcRecOfTab.CONSECUTIVO(n),
				rcRecOfTab.ID_PROYECTO(n),
				rcRecOfTab.VALOR(n),
				rcRecOfTab.CUPON(n),
				rcRecOfTab.TIPO_CUOTA(n),
				rcRecOfTab.FECHA_REGISTRO(n),
				rcRecOfTab.USUA_REGISTRA(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuCONSECUTIVO in LDC_CUOTAS_ADICIONALES.CONSECUTIVO%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_CUOTAS_ADICIONALES;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;

		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;


		delete
		from LDC_CUOTAS_ADICIONALES
		where
       		CONSECUTIVO=inuCONSECUTIVO;
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
		rcError  styLDC_CUOTAS_ADICIONALES;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_CUOTAS_ADICIONALES
		where
			rowid = iriRowID
		returning
			CONSECUTIVO
		into
			rcError.CONSECUTIVO;
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
		iotbLDC_CUOTAS_ADICIONALES in out nocopy tytbLDC_CUOTAS_ADICIONALES,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_CUOTAS_ADICIONALES;
	BEGIN
		FillRecordOfTables(iotbLDC_CUOTAS_ADICIONALES, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_CUOTAS_ADICIONALES.first .. iotbLDC_CUOTAS_ADICIONALES.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CUOTAS_ADICIONALES.first .. iotbLDC_CUOTAS_ADICIONALES.last
				delete
				from LDC_CUOTAS_ADICIONALES
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_CUOTAS_ADICIONALES.first .. iotbLDC_CUOTAS_ADICIONALES.last loop
					LockByPk
					(
						rcRecOfTab.CONSECUTIVO(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CUOTAS_ADICIONALES.first .. iotbLDC_CUOTAS_ADICIONALES.last
				delete
				from LDC_CUOTAS_ADICIONALES
				where
		         	CONSECUTIVO = rcRecOfTab.CONSECUTIVO(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_CUOTAS_ADICIONALES in styLDC_CUOTAS_ADICIONALES,
		inuLock in number default 0
	)
	IS
		nuCONSECUTIVO	LDC_CUOTAS_ADICIONALES.CONSECUTIVO%type;
	BEGIN
		if ircLDC_CUOTAS_ADICIONALES.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_CUOTAS_ADICIONALES.rowid,rcData);
			end if;
			update LDC_CUOTAS_ADICIONALES
			set
				ID_PROYECTO = ircLDC_CUOTAS_ADICIONALES.ID_PROYECTO,
				VALOR = ircLDC_CUOTAS_ADICIONALES.VALOR,
				CUPON = ircLDC_CUOTAS_ADICIONALES.CUPON,
				TIPO_CUOTA = ircLDC_CUOTAS_ADICIONALES.TIPO_CUOTA,
				FECHA_REGISTRO = ircLDC_CUOTAS_ADICIONALES.FECHA_REGISTRO,
				USUA_REGISTRA = ircLDC_CUOTAS_ADICIONALES.USUA_REGISTRA
			where
				rowid = ircLDC_CUOTAS_ADICIONALES.rowid
			returning
				CONSECUTIVO
			into
				nuCONSECUTIVO;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_CUOTAS_ADICIONALES.CONSECUTIVO,
					rcData
				);
			end if;

			update LDC_CUOTAS_ADICIONALES
			set
				ID_PROYECTO = ircLDC_CUOTAS_ADICIONALES.ID_PROYECTO,
				VALOR = ircLDC_CUOTAS_ADICIONALES.VALOR,
				CUPON = ircLDC_CUOTAS_ADICIONALES.CUPON,
				TIPO_CUOTA = ircLDC_CUOTAS_ADICIONALES.TIPO_CUOTA,
				FECHA_REGISTRO = ircLDC_CUOTAS_ADICIONALES.FECHA_REGISTRO,
				USUA_REGISTRA = ircLDC_CUOTAS_ADICIONALES.USUA_REGISTRA
			where
				CONSECUTIVO = ircLDC_CUOTAS_ADICIONALES.CONSECUTIVO
			returning
				CONSECUTIVO
			into
				nuCONSECUTIVO;
		end if;
		if
			nuCONSECUTIVO is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_CUOTAS_ADICIONALES));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_CUOTAS_ADICIONALES in out nocopy tytbLDC_CUOTAS_ADICIONALES,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_CUOTAS_ADICIONALES;
	BEGIN
		FillRecordOfTables(iotbLDC_CUOTAS_ADICIONALES,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_CUOTAS_ADICIONALES.first .. iotbLDC_CUOTAS_ADICIONALES.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CUOTAS_ADICIONALES.first .. iotbLDC_CUOTAS_ADICIONALES.last
				update LDC_CUOTAS_ADICIONALES
				set
					ID_PROYECTO = rcRecOfTab.ID_PROYECTO(n),
					VALOR = rcRecOfTab.VALOR(n),
					CUPON = rcRecOfTab.CUPON(n),
					TIPO_CUOTA = rcRecOfTab.TIPO_CUOTA(n),
					FECHA_REGISTRO = rcRecOfTab.FECHA_REGISTRO(n),
					USUA_REGISTRA = rcRecOfTab.USUA_REGISTRA(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_CUOTAS_ADICIONALES.first .. iotbLDC_CUOTAS_ADICIONALES.last loop
					LockByPk
					(
						rcRecOfTab.CONSECUTIVO(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CUOTAS_ADICIONALES.first .. iotbLDC_CUOTAS_ADICIONALES.last
				update LDC_CUOTAS_ADICIONALES
				SET
					ID_PROYECTO = rcRecOfTab.ID_PROYECTO(n),
					VALOR = rcRecOfTab.VALOR(n),
					CUPON = rcRecOfTab.CUPON(n),
					TIPO_CUOTA = rcRecOfTab.TIPO_CUOTA(n),
					FECHA_REGISTRO = rcRecOfTab.FECHA_REGISTRO(n),
					USUA_REGISTRA = rcRecOfTab.USUA_REGISTRA(n)
				where
					CONSECUTIVO = rcRecOfTab.CONSECUTIVO(n)
;
		end if;
	END;
	PROCEDURE updID_PROYECTO
	(
		inuCONSECUTIVO in LDC_CUOTAS_ADICIONALES.CONSECUTIVO%type,
		inuID_PROYECTO$ in LDC_CUOTAS_ADICIONALES.ID_PROYECTO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CUOTAS_ADICIONALES;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_CUOTAS_ADICIONALES
		set
			ID_PROYECTO = inuID_PROYECTO$
		where
			CONSECUTIVO = inuCONSECUTIVO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ID_PROYECTO:= inuID_PROYECTO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updVALOR
	(
		inuCONSECUTIVO in LDC_CUOTAS_ADICIONALES.CONSECUTIVO%type,
		inuVALOR$ in LDC_CUOTAS_ADICIONALES.VALOR%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CUOTAS_ADICIONALES;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_CUOTAS_ADICIONALES
		set
			VALOR = inuVALOR$
		where
			CONSECUTIVO = inuCONSECUTIVO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.VALOR:= inuVALOR$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCUPON
	(
		inuCONSECUTIVO in LDC_CUOTAS_ADICIONALES.CONSECUTIVO%type,
		inuCUPON$ in LDC_CUOTAS_ADICIONALES.CUPON%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CUOTAS_ADICIONALES;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_CUOTAS_ADICIONALES
		set
			CUPON = inuCUPON$
		where
			CONSECUTIVO = inuCONSECUTIVO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CUPON:= inuCUPON$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updTIPO_CUOTA
	(
		inuCONSECUTIVO in LDC_CUOTAS_ADICIONALES.CONSECUTIVO%type,
		isbTIPO_CUOTA$ in LDC_CUOTAS_ADICIONALES.TIPO_CUOTA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CUOTAS_ADICIONALES;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_CUOTAS_ADICIONALES
		set
			TIPO_CUOTA = isbTIPO_CUOTA$
		where
			CONSECUTIVO = inuCONSECUTIVO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TIPO_CUOTA:= isbTIPO_CUOTA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFECHA_REGISTRO
	(
		inuCONSECUTIVO in LDC_CUOTAS_ADICIONALES.CONSECUTIVO%type,
		idtFECHA_REGISTRO$ in LDC_CUOTAS_ADICIONALES.FECHA_REGISTRO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CUOTAS_ADICIONALES;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_CUOTAS_ADICIONALES
		set
			FECHA_REGISTRO = idtFECHA_REGISTRO$
		where
			CONSECUTIVO = inuCONSECUTIVO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FECHA_REGISTRO:= idtFECHA_REGISTRO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updUSUA_REGISTRA
	(
		inuCONSECUTIVO in LDC_CUOTAS_ADICIONALES.CONSECUTIVO%type,
		isbUSUA_REGISTRA$ in LDC_CUOTAS_ADICIONALES.USUA_REGISTRA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CUOTAS_ADICIONALES;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_CUOTAS_ADICIONALES
		set
			USUA_REGISTRA = isbUSUA_REGISTRA$
		where
			CONSECUTIVO = inuCONSECUTIVO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.USUA_REGISTRA:= isbUSUA_REGISTRA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetCONSECUTIVO
	(
		inuCONSECUTIVO in LDC_CUOTAS_ADICIONALES.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CUOTAS_ADICIONALES.CONSECUTIVO%type
	IS
		rcError styLDC_CUOTAS_ADICIONALES;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.CONSECUTIVO);
		end if;
		Load
		(
		 		inuCONSECUTIVO
		);
		return(rcData.CONSECUTIVO);
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
		inuCONSECUTIVO in LDC_CUOTAS_ADICIONALES.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CUOTAS_ADICIONALES.ID_PROYECTO%type
	IS
		rcError styLDC_CUOTAS_ADICIONALES;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.ID_PROYECTO);
		end if;
		Load
		(
		 		inuCONSECUTIVO
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
	FUNCTION fnuGetVALOR
	(
		inuCONSECUTIVO in LDC_CUOTAS_ADICIONALES.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CUOTAS_ADICIONALES.VALOR%type
	IS
		rcError styLDC_CUOTAS_ADICIONALES;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.VALOR);
		end if;
		Load
		(
		 		inuCONSECUTIVO
		);
		return(rcData.VALOR);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCUPON
	(
		inuCONSECUTIVO in LDC_CUOTAS_ADICIONALES.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CUOTAS_ADICIONALES.CUPON%type
	IS
		rcError styLDC_CUOTAS_ADICIONALES;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.CUPON);
		end if;
		Load
		(
		 		inuCONSECUTIVO
		);
		return(rcData.CUPON);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetTIPO_CUOTA
	(
		inuCONSECUTIVO in LDC_CUOTAS_ADICIONALES.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CUOTAS_ADICIONALES.TIPO_CUOTA%type
	IS
		rcError styLDC_CUOTAS_ADICIONALES;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.TIPO_CUOTA);
		end if;
		Load
		(
		 		inuCONSECUTIVO
		);
		return(rcData.TIPO_CUOTA);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetFECHA_REGISTRO
	(
		inuCONSECUTIVO in LDC_CUOTAS_ADICIONALES.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CUOTAS_ADICIONALES.FECHA_REGISTRO%type
	IS
		rcError styLDC_CUOTAS_ADICIONALES;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.FECHA_REGISTRO);
		end if;
		Load
		(
		 		inuCONSECUTIVO
		);
		return(rcData.FECHA_REGISTRO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetUSUA_REGISTRA
	(
		inuCONSECUTIVO in LDC_CUOTAS_ADICIONALES.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CUOTAS_ADICIONALES.USUA_REGISTRA%type
	IS
		rcError styLDC_CUOTAS_ADICIONALES;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.USUA_REGISTRA);
		end if;
		Load
		(
		 		inuCONSECUTIVO
		);
		return(rcData.USUA_REGISTRA);
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
end DALDC_CUOTAS_ADICIONALES;
/
PROMPT Otorgando permisos de ejecucion a DALDC_CUOTAS_ADICIONALES
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_CUOTAS_ADICIONALES', 'ADM_PERSON');
END;
/