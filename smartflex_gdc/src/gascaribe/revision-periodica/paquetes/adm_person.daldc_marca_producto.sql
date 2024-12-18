CREATE OR REPLACE PACKAGE adm_person.DALDC_MARCA_PRODUCTO
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
    17/06/2024              PAcosta         OSF-2780: Cambio de esquema ADM_PERSON                              
    ****************************************************************/   
    
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuID_PRODUCTO in LDC_MARCA_PRODUCTO.ID_PRODUCTO%type
	)
	IS
		SELECT LDC_MARCA_PRODUCTO.*,LDC_MARCA_PRODUCTO.rowid
		FROM LDC_MARCA_PRODUCTO
		WHERE
		    ID_PRODUCTO = inuID_PRODUCTO;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_MARCA_PRODUCTO.*,LDC_MARCA_PRODUCTO.rowid
		FROM LDC_MARCA_PRODUCTO
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_MARCA_PRODUCTO  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_MARCA_PRODUCTO is table of styLDC_MARCA_PRODUCTO index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_MARCA_PRODUCTO;

	/* Tipos referenciando al registro */
	type tytbID_PRODUCTO is table of LDC_MARCA_PRODUCTO.ID_PRODUCTO%type index by binary_integer;
	type tytbORDER_ID is table of LDC_MARCA_PRODUCTO.ORDER_ID%type index by binary_integer;
	type tytbCERTIFICADO is table of LDC_MARCA_PRODUCTO.CERTIFICADO%type index by binary_integer;
	type tytbFECHA_ULTIMA_ACTU is table of LDC_MARCA_PRODUCTO.FECHA_ULTIMA_ACTU%type index by binary_integer;
	type tytbINTENTOS is table of LDC_MARCA_PRODUCTO.INTENTOS%type index by binary_integer;
	type tytbMEDIO_RECEPCION is table of LDC_MARCA_PRODUCTO.MEDIO_RECEPCION%type index by binary_integer;
	type tytbREGISTER_POR_DEFECTO is table of LDC_MARCA_PRODUCTO.REGISTER_POR_DEFECTO%type index by binary_integer;
	type tytbSUSPENSION_TYPE_ID is table of LDC_MARCA_PRODUCTO.SUSPENSION_TYPE_ID%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_MARCA_PRODUCTO is record
	(
		ID_PRODUCTO   tytbID_PRODUCTO,
		ORDER_ID   tytbORDER_ID,
		CERTIFICADO   tytbCERTIFICADO,
		FECHA_ULTIMA_ACTU   tytbFECHA_ULTIMA_ACTU,
		INTENTOS   tytbINTENTOS,
		MEDIO_RECEPCION   tytbMEDIO_RECEPCION,
		REGISTER_POR_DEFECTO   tytbREGISTER_POR_DEFECTO,
		SUSPENSION_TYPE_ID   tytbSUSPENSION_TYPE_ID,
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
		inuID_PRODUCTO in LDC_MARCA_PRODUCTO.ID_PRODUCTO%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuID_PRODUCTO in LDC_MARCA_PRODUCTO.ID_PRODUCTO%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuID_PRODUCTO in LDC_MARCA_PRODUCTO.ID_PRODUCTO%type
	);

	PROCEDURE getRecord
	(
		inuID_PRODUCTO in LDC_MARCA_PRODUCTO.ID_PRODUCTO%type,
		orcRecord out nocopy styLDC_MARCA_PRODUCTO
	);

	FUNCTION frcGetRcData
	(
		inuID_PRODUCTO in LDC_MARCA_PRODUCTO.ID_PRODUCTO%type
	)
	RETURN styLDC_MARCA_PRODUCTO;

	FUNCTION frcGetRcData
	RETURN styLDC_MARCA_PRODUCTO;

	FUNCTION frcGetRecord
	(
		inuID_PRODUCTO in LDC_MARCA_PRODUCTO.ID_PRODUCTO%type
	)
	RETURN styLDC_MARCA_PRODUCTO;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_MARCA_PRODUCTO
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_MARCA_PRODUCTO in styLDC_MARCA_PRODUCTO
	);

	PROCEDURE insRecord
	(
		ircLDC_MARCA_PRODUCTO in styLDC_MARCA_PRODUCTO,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_MARCA_PRODUCTO in out nocopy tytbLDC_MARCA_PRODUCTO
	);

	PROCEDURE delRecord
	(
		inuID_PRODUCTO in LDC_MARCA_PRODUCTO.ID_PRODUCTO%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_MARCA_PRODUCTO in out nocopy tytbLDC_MARCA_PRODUCTO,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_MARCA_PRODUCTO in styLDC_MARCA_PRODUCTO,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_MARCA_PRODUCTO in out nocopy tytbLDC_MARCA_PRODUCTO,
		inuLock in number default 1
	);

	PROCEDURE updORDER_ID
	(
		inuID_PRODUCTO in LDC_MARCA_PRODUCTO.ID_PRODUCTO%type,
		inuORDER_ID$ in LDC_MARCA_PRODUCTO.ORDER_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updCERTIFICADO
	(
		inuID_PRODUCTO in LDC_MARCA_PRODUCTO.ID_PRODUCTO%type,
		isbCERTIFICADO$ in LDC_MARCA_PRODUCTO.CERTIFICADO%type,
		inuLock in number default 0
	);

	PROCEDURE updFECHA_ULTIMA_ACTU
	(
		inuID_PRODUCTO in LDC_MARCA_PRODUCTO.ID_PRODUCTO%type,
		idtFECHA_ULTIMA_ACTU$ in LDC_MARCA_PRODUCTO.FECHA_ULTIMA_ACTU%type,
		inuLock in number default 0
	);

	PROCEDURE updINTENTOS
	(
		inuID_PRODUCTO in LDC_MARCA_PRODUCTO.ID_PRODUCTO%type,
		inuINTENTOS$ in LDC_MARCA_PRODUCTO.INTENTOS%type,
		inuLock in number default 0
	);

	PROCEDURE updMEDIO_RECEPCION
	(
		inuID_PRODUCTO in LDC_MARCA_PRODUCTO.ID_PRODUCTO%type,
		isbMEDIO_RECEPCION$ in LDC_MARCA_PRODUCTO.MEDIO_RECEPCION%type,
		inuLock in number default 0
	);

	PROCEDURE updREGISTER_POR_DEFECTO
	(
		inuID_PRODUCTO in LDC_MARCA_PRODUCTO.ID_PRODUCTO%type,
		isbREGISTER_POR_DEFECTO$ in LDC_MARCA_PRODUCTO.REGISTER_POR_DEFECTO%type,
		inuLock in number default 0
	);

	PROCEDURE updSUSPENSION_TYPE_ID
	(
		inuID_PRODUCTO in LDC_MARCA_PRODUCTO.ID_PRODUCTO%type,
		inuSUSPENSION_TYPE_ID$ in LDC_MARCA_PRODUCTO.SUSPENSION_TYPE_ID%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetID_PRODUCTO
	(
		inuID_PRODUCTO in LDC_MARCA_PRODUCTO.ID_PRODUCTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_MARCA_PRODUCTO.ID_PRODUCTO%type;

	FUNCTION fnuGetORDER_ID
	(
		inuID_PRODUCTO in LDC_MARCA_PRODUCTO.ID_PRODUCTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_MARCA_PRODUCTO.ORDER_ID%type;

	FUNCTION fsbGetCERTIFICADO
	(
		inuID_PRODUCTO in LDC_MARCA_PRODUCTO.ID_PRODUCTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_MARCA_PRODUCTO.CERTIFICADO%type;

	FUNCTION fdtGetFECHA_ULTIMA_ACTU
	(
		inuID_PRODUCTO in LDC_MARCA_PRODUCTO.ID_PRODUCTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_MARCA_PRODUCTO.FECHA_ULTIMA_ACTU%type;

	FUNCTION fnuGetINTENTOS
	(
		inuID_PRODUCTO in LDC_MARCA_PRODUCTO.ID_PRODUCTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_MARCA_PRODUCTO.INTENTOS%type;

	FUNCTION fsbGetMEDIO_RECEPCION
	(
		inuID_PRODUCTO in LDC_MARCA_PRODUCTO.ID_PRODUCTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_MARCA_PRODUCTO.MEDIO_RECEPCION%type;

	FUNCTION fsbGetREGISTER_POR_DEFECTO
	(
		inuID_PRODUCTO in LDC_MARCA_PRODUCTO.ID_PRODUCTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_MARCA_PRODUCTO.REGISTER_POR_DEFECTO%type;

	FUNCTION fnuGetSUSPENSION_TYPE_ID
	(
		inuID_PRODUCTO in LDC_MARCA_PRODUCTO.ID_PRODUCTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_MARCA_PRODUCTO.SUSPENSION_TYPE_ID%type;


	PROCEDURE LockByPk
	(
		inuID_PRODUCTO in LDC_MARCA_PRODUCTO.ID_PRODUCTO%type,
		orcLDC_MARCA_PRODUCTO  out styLDC_MARCA_PRODUCTO
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_MARCA_PRODUCTO  out styLDC_MARCA_PRODUCTO
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_MARCA_PRODUCTO;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALDC_MARCA_PRODUCTO
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_MARCA_PRODUCTO';
	 cnuGeEntityId constant varchar2(30) := 18; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuID_PRODUCTO in LDC_MARCA_PRODUCTO.ID_PRODUCTO%type
	)
	IS
		SELECT LDC_MARCA_PRODUCTO.*,LDC_MARCA_PRODUCTO.rowid
		FROM LDC_MARCA_PRODUCTO
		WHERE  ID_PRODUCTO = inuID_PRODUCTO
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_MARCA_PRODUCTO.*,LDC_MARCA_PRODUCTO.rowid
		FROM LDC_MARCA_PRODUCTO
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_MARCA_PRODUCTO is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_MARCA_PRODUCTO;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_MARCA_PRODUCTO default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.ID_PRODUCTO);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuID_PRODUCTO in LDC_MARCA_PRODUCTO.ID_PRODUCTO%type,
		orcLDC_MARCA_PRODUCTO  out styLDC_MARCA_PRODUCTO
	)
	IS
		rcError styLDC_MARCA_PRODUCTO;
	BEGIN
		rcError.ID_PRODUCTO := inuID_PRODUCTO;

		Open cuLockRcByPk
		(
			inuID_PRODUCTO
		);

		fetch cuLockRcByPk into orcLDC_MARCA_PRODUCTO;
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
		orcLDC_MARCA_PRODUCTO  out styLDC_MARCA_PRODUCTO
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_MARCA_PRODUCTO;
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
		itbLDC_MARCA_PRODUCTO  in out nocopy tytbLDC_MARCA_PRODUCTO
	)
	IS
	BEGIN
			rcRecOfTab.ID_PRODUCTO.delete;
			rcRecOfTab.ORDER_ID.delete;
			rcRecOfTab.CERTIFICADO.delete;
			rcRecOfTab.FECHA_ULTIMA_ACTU.delete;
			rcRecOfTab.INTENTOS.delete;
			rcRecOfTab.MEDIO_RECEPCION.delete;
			rcRecOfTab.REGISTER_POR_DEFECTO.delete;
			rcRecOfTab.SUSPENSION_TYPE_ID.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_MARCA_PRODUCTO  in out nocopy tytbLDC_MARCA_PRODUCTO,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_MARCA_PRODUCTO);

		for n in itbLDC_MARCA_PRODUCTO.first .. itbLDC_MARCA_PRODUCTO.last loop
			rcRecOfTab.ID_PRODUCTO(n) := itbLDC_MARCA_PRODUCTO(n).ID_PRODUCTO;
			rcRecOfTab.ORDER_ID(n) := itbLDC_MARCA_PRODUCTO(n).ORDER_ID;
			rcRecOfTab.CERTIFICADO(n) := itbLDC_MARCA_PRODUCTO(n).CERTIFICADO;
			rcRecOfTab.FECHA_ULTIMA_ACTU(n) := itbLDC_MARCA_PRODUCTO(n).FECHA_ULTIMA_ACTU;
			rcRecOfTab.INTENTOS(n) := itbLDC_MARCA_PRODUCTO(n).INTENTOS;
			rcRecOfTab.MEDIO_RECEPCION(n) := itbLDC_MARCA_PRODUCTO(n).MEDIO_RECEPCION;
			rcRecOfTab.REGISTER_POR_DEFECTO(n) := itbLDC_MARCA_PRODUCTO(n).REGISTER_POR_DEFECTO;
			rcRecOfTab.SUSPENSION_TYPE_ID(n) := itbLDC_MARCA_PRODUCTO(n).SUSPENSION_TYPE_ID;
			rcRecOfTab.row_id(n) := itbLDC_MARCA_PRODUCTO(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuID_PRODUCTO in LDC_MARCA_PRODUCTO.ID_PRODUCTO%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuID_PRODUCTO
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
		inuID_PRODUCTO in LDC_MARCA_PRODUCTO.ID_PRODUCTO%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuID_PRODUCTO = rcData.ID_PRODUCTO
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
		inuID_PRODUCTO in LDC_MARCA_PRODUCTO.ID_PRODUCTO%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuID_PRODUCTO
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuID_PRODUCTO in LDC_MARCA_PRODUCTO.ID_PRODUCTO%type
	)
	IS
		rcError styLDC_MARCA_PRODUCTO;
	BEGIN		rcError.ID_PRODUCTO:=inuID_PRODUCTO;

		Load
		(
			inuID_PRODUCTO
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
		inuID_PRODUCTO in LDC_MARCA_PRODUCTO.ID_PRODUCTO%type
	)
	IS
	BEGIN
		Load
		(
			inuID_PRODUCTO
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuID_PRODUCTO in LDC_MARCA_PRODUCTO.ID_PRODUCTO%type,
		orcRecord out nocopy styLDC_MARCA_PRODUCTO
	)
	IS
		rcError styLDC_MARCA_PRODUCTO;
	BEGIN		rcError.ID_PRODUCTO:=inuID_PRODUCTO;

		Load
		(
			inuID_PRODUCTO
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuID_PRODUCTO in LDC_MARCA_PRODUCTO.ID_PRODUCTO%type
	)
	RETURN styLDC_MARCA_PRODUCTO
	IS
		rcError styLDC_MARCA_PRODUCTO;
	BEGIN
		rcError.ID_PRODUCTO:=inuID_PRODUCTO;

		Load
		(
			inuID_PRODUCTO
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuID_PRODUCTO in LDC_MARCA_PRODUCTO.ID_PRODUCTO%type
	)
	RETURN styLDC_MARCA_PRODUCTO
	IS
		rcError styLDC_MARCA_PRODUCTO;
	BEGIN
		rcError.ID_PRODUCTO:=inuID_PRODUCTO;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuID_PRODUCTO
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuID_PRODUCTO
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_MARCA_PRODUCTO
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_MARCA_PRODUCTO
	)
	IS
		rfLDC_MARCA_PRODUCTO tyrfLDC_MARCA_PRODUCTO;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_MARCA_PRODUCTO.*, LDC_MARCA_PRODUCTO.rowid FROM LDC_MARCA_PRODUCTO';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_MARCA_PRODUCTO for sbFullQuery;

		fetch rfLDC_MARCA_PRODUCTO bulk collect INTO otbResult;

		close rfLDC_MARCA_PRODUCTO;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_MARCA_PRODUCTO.*, LDC_MARCA_PRODUCTO.rowid FROM LDC_MARCA_PRODUCTO';
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
		ircLDC_MARCA_PRODUCTO in styLDC_MARCA_PRODUCTO
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_MARCA_PRODUCTO,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_MARCA_PRODUCTO in styLDC_MARCA_PRODUCTO,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_MARCA_PRODUCTO.ID_PRODUCTO is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ID_PRODUCTO');
			raise ex.controlled_error;
		end if;

		insert into LDC_MARCA_PRODUCTO
		(
			ID_PRODUCTO,
			ORDER_ID,
			CERTIFICADO,
			FECHA_ULTIMA_ACTU,
			INTENTOS,
			MEDIO_RECEPCION,
			REGISTER_POR_DEFECTO,
			SUSPENSION_TYPE_ID
		)
		values
		(
			ircLDC_MARCA_PRODUCTO.ID_PRODUCTO,
			ircLDC_MARCA_PRODUCTO.ORDER_ID,
			ircLDC_MARCA_PRODUCTO.CERTIFICADO,
			ircLDC_MARCA_PRODUCTO.FECHA_ULTIMA_ACTU,
			ircLDC_MARCA_PRODUCTO.INTENTOS,
			ircLDC_MARCA_PRODUCTO.MEDIO_RECEPCION,
			ircLDC_MARCA_PRODUCTO.REGISTER_POR_DEFECTO,
			ircLDC_MARCA_PRODUCTO.SUSPENSION_TYPE_ID
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_MARCA_PRODUCTO));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_MARCA_PRODUCTO in out nocopy tytbLDC_MARCA_PRODUCTO
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_MARCA_PRODUCTO,blUseRowID);
		forall n in iotbLDC_MARCA_PRODUCTO.first..iotbLDC_MARCA_PRODUCTO.last
			insert into LDC_MARCA_PRODUCTO
			(
				ID_PRODUCTO,
				ORDER_ID,
				CERTIFICADO,
				FECHA_ULTIMA_ACTU,
				INTENTOS,
				MEDIO_RECEPCION,
				REGISTER_POR_DEFECTO,
				SUSPENSION_TYPE_ID
			)
			values
			(
				rcRecOfTab.ID_PRODUCTO(n),
				rcRecOfTab.ORDER_ID(n),
				rcRecOfTab.CERTIFICADO(n),
				rcRecOfTab.FECHA_ULTIMA_ACTU(n),
				rcRecOfTab.INTENTOS(n),
				rcRecOfTab.MEDIO_RECEPCION(n),
				rcRecOfTab.REGISTER_POR_DEFECTO(n),
				rcRecOfTab.SUSPENSION_TYPE_ID(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuID_PRODUCTO in LDC_MARCA_PRODUCTO.ID_PRODUCTO%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_MARCA_PRODUCTO;
	BEGIN
		rcError.ID_PRODUCTO := inuID_PRODUCTO;

		if inuLock=1 then
			LockByPk
			(
				inuID_PRODUCTO,
				rcData
			);
		end if;


		delete
		from LDC_MARCA_PRODUCTO
		where
       		ID_PRODUCTO=inuID_PRODUCTO;
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
		rcError  styLDC_MARCA_PRODUCTO;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_MARCA_PRODUCTO
		where
			rowid = iriRowID
		returning
			ID_PRODUCTO
		into
			rcError.ID_PRODUCTO;
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
		iotbLDC_MARCA_PRODUCTO in out nocopy tytbLDC_MARCA_PRODUCTO,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_MARCA_PRODUCTO;
	BEGIN
		FillRecordOfTables(iotbLDC_MARCA_PRODUCTO, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_MARCA_PRODUCTO.first .. iotbLDC_MARCA_PRODUCTO.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_MARCA_PRODUCTO.first .. iotbLDC_MARCA_PRODUCTO.last
				delete
				from LDC_MARCA_PRODUCTO
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_MARCA_PRODUCTO.first .. iotbLDC_MARCA_PRODUCTO.last loop
					LockByPk
					(
						rcRecOfTab.ID_PRODUCTO(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_MARCA_PRODUCTO.first .. iotbLDC_MARCA_PRODUCTO.last
				delete
				from LDC_MARCA_PRODUCTO
				where
		         	ID_PRODUCTO = rcRecOfTab.ID_PRODUCTO(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_MARCA_PRODUCTO in styLDC_MARCA_PRODUCTO,
		inuLock in number default 0
	)
	IS
		nuID_PRODUCTO	LDC_MARCA_PRODUCTO.ID_PRODUCTO%type;
	BEGIN
		if ircLDC_MARCA_PRODUCTO.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_MARCA_PRODUCTO.rowid,rcData);
			end if;
			update LDC_MARCA_PRODUCTO
			set
				ORDER_ID = ircLDC_MARCA_PRODUCTO.ORDER_ID,
				CERTIFICADO = ircLDC_MARCA_PRODUCTO.CERTIFICADO,
				FECHA_ULTIMA_ACTU = ircLDC_MARCA_PRODUCTO.FECHA_ULTIMA_ACTU,
				INTENTOS = ircLDC_MARCA_PRODUCTO.INTENTOS,
				MEDIO_RECEPCION = ircLDC_MARCA_PRODUCTO.MEDIO_RECEPCION,
				REGISTER_POR_DEFECTO = ircLDC_MARCA_PRODUCTO.REGISTER_POR_DEFECTO,
				SUSPENSION_TYPE_ID = ircLDC_MARCA_PRODUCTO.SUSPENSION_TYPE_ID
			where
				rowid = ircLDC_MARCA_PRODUCTO.rowid
			returning
				ID_PRODUCTO
			into
				nuID_PRODUCTO;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_MARCA_PRODUCTO.ID_PRODUCTO,
					rcData
				);
			end if;

			update LDC_MARCA_PRODUCTO
			set
				ORDER_ID = ircLDC_MARCA_PRODUCTO.ORDER_ID,
				CERTIFICADO = ircLDC_MARCA_PRODUCTO.CERTIFICADO,
				FECHA_ULTIMA_ACTU = ircLDC_MARCA_PRODUCTO.FECHA_ULTIMA_ACTU,
				INTENTOS = ircLDC_MARCA_PRODUCTO.INTENTOS,
				MEDIO_RECEPCION = ircLDC_MARCA_PRODUCTO.MEDIO_RECEPCION,
				REGISTER_POR_DEFECTO = ircLDC_MARCA_PRODUCTO.REGISTER_POR_DEFECTO,
				SUSPENSION_TYPE_ID = ircLDC_MARCA_PRODUCTO.SUSPENSION_TYPE_ID
			where
				ID_PRODUCTO = ircLDC_MARCA_PRODUCTO.ID_PRODUCTO
			returning
				ID_PRODUCTO
			into
				nuID_PRODUCTO;
		end if;
		if
			nuID_PRODUCTO is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_MARCA_PRODUCTO));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_MARCA_PRODUCTO in out nocopy tytbLDC_MARCA_PRODUCTO,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_MARCA_PRODUCTO;
	BEGIN
		FillRecordOfTables(iotbLDC_MARCA_PRODUCTO,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_MARCA_PRODUCTO.first .. iotbLDC_MARCA_PRODUCTO.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_MARCA_PRODUCTO.first .. iotbLDC_MARCA_PRODUCTO.last
				update LDC_MARCA_PRODUCTO
				set
					ORDER_ID = rcRecOfTab.ORDER_ID(n),
					CERTIFICADO = rcRecOfTab.CERTIFICADO(n),
					FECHA_ULTIMA_ACTU = rcRecOfTab.FECHA_ULTIMA_ACTU(n),
					INTENTOS = rcRecOfTab.INTENTOS(n),
					MEDIO_RECEPCION = rcRecOfTab.MEDIO_RECEPCION(n),
					REGISTER_POR_DEFECTO = rcRecOfTab.REGISTER_POR_DEFECTO(n),
					SUSPENSION_TYPE_ID = rcRecOfTab.SUSPENSION_TYPE_ID(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_MARCA_PRODUCTO.first .. iotbLDC_MARCA_PRODUCTO.last loop
					LockByPk
					(
						rcRecOfTab.ID_PRODUCTO(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_MARCA_PRODUCTO.first .. iotbLDC_MARCA_PRODUCTO.last
				update LDC_MARCA_PRODUCTO
				SET
					ORDER_ID = rcRecOfTab.ORDER_ID(n),
					CERTIFICADO = rcRecOfTab.CERTIFICADO(n),
					FECHA_ULTIMA_ACTU = rcRecOfTab.FECHA_ULTIMA_ACTU(n),
					INTENTOS = rcRecOfTab.INTENTOS(n),
					MEDIO_RECEPCION = rcRecOfTab.MEDIO_RECEPCION(n),
					REGISTER_POR_DEFECTO = rcRecOfTab.REGISTER_POR_DEFECTO(n),
					SUSPENSION_TYPE_ID = rcRecOfTab.SUSPENSION_TYPE_ID(n)
				where
					ID_PRODUCTO = rcRecOfTab.ID_PRODUCTO(n)
;
		end if;
	END;
	PROCEDURE updORDER_ID
	(
		inuID_PRODUCTO in LDC_MARCA_PRODUCTO.ID_PRODUCTO%type,
		inuORDER_ID$ in LDC_MARCA_PRODUCTO.ORDER_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_MARCA_PRODUCTO;
	BEGIN
		rcError.ID_PRODUCTO := inuID_PRODUCTO;
		if inuLock=1 then
			LockByPk
			(
				inuID_PRODUCTO,
				rcData
			);
		end if;

		update LDC_MARCA_PRODUCTO
		set
			ORDER_ID = inuORDER_ID$
		where
			ID_PRODUCTO = inuID_PRODUCTO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ORDER_ID:= inuORDER_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCERTIFICADO
	(
		inuID_PRODUCTO in LDC_MARCA_PRODUCTO.ID_PRODUCTO%type,
		isbCERTIFICADO$ in LDC_MARCA_PRODUCTO.CERTIFICADO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_MARCA_PRODUCTO;
	BEGIN
		rcError.ID_PRODUCTO := inuID_PRODUCTO;
		if inuLock=1 then
			LockByPk
			(
				inuID_PRODUCTO,
				rcData
			);
		end if;

		update LDC_MARCA_PRODUCTO
		set
			CERTIFICADO = isbCERTIFICADO$
		where
			ID_PRODUCTO = inuID_PRODUCTO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CERTIFICADO:= isbCERTIFICADO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFECHA_ULTIMA_ACTU
	(
		inuID_PRODUCTO in LDC_MARCA_PRODUCTO.ID_PRODUCTO%type,
		idtFECHA_ULTIMA_ACTU$ in LDC_MARCA_PRODUCTO.FECHA_ULTIMA_ACTU%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_MARCA_PRODUCTO;
	BEGIN
		rcError.ID_PRODUCTO := inuID_PRODUCTO;
		if inuLock=1 then
			LockByPk
			(
				inuID_PRODUCTO,
				rcData
			);
		end if;

		update LDC_MARCA_PRODUCTO
		set
			FECHA_ULTIMA_ACTU = idtFECHA_ULTIMA_ACTU$
		where
			ID_PRODUCTO = inuID_PRODUCTO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FECHA_ULTIMA_ACTU:= idtFECHA_ULTIMA_ACTU$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updINTENTOS
	(
		inuID_PRODUCTO in LDC_MARCA_PRODUCTO.ID_PRODUCTO%type,
		inuINTENTOS$ in LDC_MARCA_PRODUCTO.INTENTOS%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_MARCA_PRODUCTO;
	BEGIN
		rcError.ID_PRODUCTO := inuID_PRODUCTO;
		if inuLock=1 then
			LockByPk
			(
				inuID_PRODUCTO,
				rcData
			);
		end if;

		update LDC_MARCA_PRODUCTO
		set
			INTENTOS = inuINTENTOS$
		where
			ID_PRODUCTO = inuID_PRODUCTO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.INTENTOS:= inuINTENTOS$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updMEDIO_RECEPCION
	(
		inuID_PRODUCTO in LDC_MARCA_PRODUCTO.ID_PRODUCTO%type,
		isbMEDIO_RECEPCION$ in LDC_MARCA_PRODUCTO.MEDIO_RECEPCION%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_MARCA_PRODUCTO;
	BEGIN
		rcError.ID_PRODUCTO := inuID_PRODUCTO;
		if inuLock=1 then
			LockByPk
			(
				inuID_PRODUCTO,
				rcData
			);
		end if;

		update LDC_MARCA_PRODUCTO
		set
			MEDIO_RECEPCION = isbMEDIO_RECEPCION$
		where
			ID_PRODUCTO = inuID_PRODUCTO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.MEDIO_RECEPCION:= isbMEDIO_RECEPCION$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updREGISTER_POR_DEFECTO
	(
		inuID_PRODUCTO in LDC_MARCA_PRODUCTO.ID_PRODUCTO%type,
		isbREGISTER_POR_DEFECTO$ in LDC_MARCA_PRODUCTO.REGISTER_POR_DEFECTO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_MARCA_PRODUCTO;
	BEGIN
		rcError.ID_PRODUCTO := inuID_PRODUCTO;
		if inuLock=1 then
			LockByPk
			(
				inuID_PRODUCTO,
				rcData
			);
		end if;

		update LDC_MARCA_PRODUCTO
		set
			REGISTER_POR_DEFECTO = isbREGISTER_POR_DEFECTO$
		where
			ID_PRODUCTO = inuID_PRODUCTO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.REGISTER_POR_DEFECTO:= isbREGISTER_POR_DEFECTO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSUSPENSION_TYPE_ID
	(
		inuID_PRODUCTO in LDC_MARCA_PRODUCTO.ID_PRODUCTO%type,
		inuSUSPENSION_TYPE_ID$ in LDC_MARCA_PRODUCTO.SUSPENSION_TYPE_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_MARCA_PRODUCTO;
	BEGIN
		rcError.ID_PRODUCTO := inuID_PRODUCTO;
		if inuLock=1 then
			LockByPk
			(
				inuID_PRODUCTO,
				rcData
			);
		end if;

		update LDC_MARCA_PRODUCTO
		set
			SUSPENSION_TYPE_ID = inuSUSPENSION_TYPE_ID$
		where
			ID_PRODUCTO = inuID_PRODUCTO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SUSPENSION_TYPE_ID:= inuSUSPENSION_TYPE_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetID_PRODUCTO
	(
		inuID_PRODUCTO in LDC_MARCA_PRODUCTO.ID_PRODUCTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_MARCA_PRODUCTO.ID_PRODUCTO%type
	IS
		rcError styLDC_MARCA_PRODUCTO;
	BEGIN

		rcError.ID_PRODUCTO := inuID_PRODUCTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PRODUCTO
			 )
		then
			 return(rcData.ID_PRODUCTO);
		end if;
		Load
		(
		 		inuID_PRODUCTO
		);
		return(rcData.ID_PRODUCTO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetORDER_ID
	(
		inuID_PRODUCTO in LDC_MARCA_PRODUCTO.ID_PRODUCTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_MARCA_PRODUCTO.ORDER_ID%type
	IS
		rcError styLDC_MARCA_PRODUCTO;
	BEGIN

		rcError.ID_PRODUCTO := inuID_PRODUCTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PRODUCTO
			 )
		then
			 return(rcData.ORDER_ID);
		end if;
		Load
		(
		 		inuID_PRODUCTO
		);
		return(rcData.ORDER_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetCERTIFICADO
	(
		inuID_PRODUCTO in LDC_MARCA_PRODUCTO.ID_PRODUCTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_MARCA_PRODUCTO.CERTIFICADO%type
	IS
		rcError styLDC_MARCA_PRODUCTO;
	BEGIN

		rcError.ID_PRODUCTO := inuID_PRODUCTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PRODUCTO
			 )
		then
			 return(rcData.CERTIFICADO);
		end if;
		Load
		(
		 		inuID_PRODUCTO
		);
		return(rcData.CERTIFICADO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetFECHA_ULTIMA_ACTU
	(
		inuID_PRODUCTO in LDC_MARCA_PRODUCTO.ID_PRODUCTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_MARCA_PRODUCTO.FECHA_ULTIMA_ACTU%type
	IS
		rcError styLDC_MARCA_PRODUCTO;
	BEGIN

		rcError.ID_PRODUCTO := inuID_PRODUCTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PRODUCTO
			 )
		then
			 return(rcData.FECHA_ULTIMA_ACTU);
		end if;
		Load
		(
		 		inuID_PRODUCTO
		);
		return(rcData.FECHA_ULTIMA_ACTU);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetINTENTOS
	(
		inuID_PRODUCTO in LDC_MARCA_PRODUCTO.ID_PRODUCTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_MARCA_PRODUCTO.INTENTOS%type
	IS
		rcError styLDC_MARCA_PRODUCTO;
	BEGIN

		rcError.ID_PRODUCTO := inuID_PRODUCTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PRODUCTO
			 )
		then
			 return(rcData.INTENTOS);
		end if;
		Load
		(
		 		inuID_PRODUCTO
		);
		return(rcData.INTENTOS);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetMEDIO_RECEPCION
	(
		inuID_PRODUCTO in LDC_MARCA_PRODUCTO.ID_PRODUCTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_MARCA_PRODUCTO.MEDIO_RECEPCION%type
	IS
		rcError styLDC_MARCA_PRODUCTO;
	BEGIN

		rcError.ID_PRODUCTO := inuID_PRODUCTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PRODUCTO
			 )
		then
			 return(rcData.MEDIO_RECEPCION);
		end if;
		Load
		(
		 		inuID_PRODUCTO
		);
		return(rcData.MEDIO_RECEPCION);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetREGISTER_POR_DEFECTO
	(
		inuID_PRODUCTO in LDC_MARCA_PRODUCTO.ID_PRODUCTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_MARCA_PRODUCTO.REGISTER_POR_DEFECTO%type
	IS
		rcError styLDC_MARCA_PRODUCTO;
	BEGIN

		rcError.ID_PRODUCTO := inuID_PRODUCTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PRODUCTO
			 )
		then
			 return(rcData.REGISTER_POR_DEFECTO);
		end if;
		Load
		(
		 		inuID_PRODUCTO
		);
		return(rcData.REGISTER_POR_DEFECTO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetSUSPENSION_TYPE_ID
	(
		inuID_PRODUCTO in LDC_MARCA_PRODUCTO.ID_PRODUCTO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_MARCA_PRODUCTO.SUSPENSION_TYPE_ID%type
	IS
		rcError styLDC_MARCA_PRODUCTO;
	BEGIN

		rcError.ID_PRODUCTO := inuID_PRODUCTO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PRODUCTO
			 )
		then
			 return(rcData.SUSPENSION_TYPE_ID);
		end if;
		Load
		(
		 		inuID_PRODUCTO
		);
		return(rcData.SUSPENSION_TYPE_ID);
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
end DALDC_MARCA_PRODUCTO;
/
PROMPT Otorgando permisos de ejecucion a DALDC_MARCA_PRODUCTO
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_MARCA_PRODUCTO', 'ADM_PERSON');
END;
/