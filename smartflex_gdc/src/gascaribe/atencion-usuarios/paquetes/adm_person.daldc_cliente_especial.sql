CREATE OR REPLACE PACKAGE ADM_PERSON.DALDC_CLIENTE_ESPECIAL
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
		inuID_CLIENTE in LDC_CLIENTE_ESPECIAL.ID_CLIENTE%type
	)
	IS
		SELECT LDC_CLIENTE_ESPECIAL.*,LDC_CLIENTE_ESPECIAL.rowid
		FROM LDC_CLIENTE_ESPECIAL
		WHERE
		    ID_CLIENTE = inuID_CLIENTE;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_CLIENTE_ESPECIAL.*,LDC_CLIENTE_ESPECIAL.rowid
		FROM LDC_CLIENTE_ESPECIAL
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_CLIENTE_ESPECIAL  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_CLIENTE_ESPECIAL is table of styLDC_CLIENTE_ESPECIAL index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_CLIENTE_ESPECIAL;

	/* Tipos referenciando al registro */
	type tytbID_CLIENTE is table of LDC_CLIENTE_ESPECIAL.ID_CLIENTE%type index by binary_integer;
	type tytbCLIENTE_ESPECIAL is table of LDC_CLIENTE_ESPECIAL.CLIENTE_ESPECIAL%type index by binary_integer;
	type tytbFECHA_REGISTRO is table of LDC_CLIENTE_ESPECIAL.FECHA_REGISTRO%type index by binary_integer;
	type tytbFECHA_ULT_MODIF is table of LDC_CLIENTE_ESPECIAL.FECHA_ULT_MODIF%type index by binary_integer;
	type tytbUSUARIO_REGISTRO is table of LDC_CLIENTE_ESPECIAL.USUARIO_REGISTRO%type index by binary_integer;
	type tytbUSUARIO_ULT_MODIF is table of LDC_CLIENTE_ESPECIAL.USUARIO_ULT_MODIF%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_CLIENTE_ESPECIAL is record
	(
		ID_CLIENTE   tytbID_CLIENTE,
		CLIENTE_ESPECIAL   tytbCLIENTE_ESPECIAL,
		FECHA_REGISTRO   tytbFECHA_REGISTRO,
		FECHA_ULT_MODIF   tytbFECHA_ULT_MODIF,
		USUARIO_REGISTRO   tytbUSUARIO_REGISTRO,
		USUARIO_ULT_MODIF   tytbUSUARIO_ULT_MODIF,
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
		inuID_CLIENTE in LDC_CLIENTE_ESPECIAL.ID_CLIENTE%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuID_CLIENTE in LDC_CLIENTE_ESPECIAL.ID_CLIENTE%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuID_CLIENTE in LDC_CLIENTE_ESPECIAL.ID_CLIENTE%type
	);

	PROCEDURE getRecord
	(
		inuID_CLIENTE in LDC_CLIENTE_ESPECIAL.ID_CLIENTE%type,
		orcRecord out nocopy styLDC_CLIENTE_ESPECIAL
	);

	FUNCTION frcGetRcData
	(
		inuID_CLIENTE in LDC_CLIENTE_ESPECIAL.ID_CLIENTE%type
	)
	RETURN styLDC_CLIENTE_ESPECIAL;

	FUNCTION frcGetRcData
	RETURN styLDC_CLIENTE_ESPECIAL;

	FUNCTION frcGetRecord
	(
		inuID_CLIENTE in LDC_CLIENTE_ESPECIAL.ID_CLIENTE%type
	)
	RETURN styLDC_CLIENTE_ESPECIAL;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_CLIENTE_ESPECIAL
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_CLIENTE_ESPECIAL in styLDC_CLIENTE_ESPECIAL
	);

	PROCEDURE insRecord
	(
		ircLDC_CLIENTE_ESPECIAL in styLDC_CLIENTE_ESPECIAL,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_CLIENTE_ESPECIAL in out nocopy tytbLDC_CLIENTE_ESPECIAL
	);

	PROCEDURE delRecord
	(
		inuID_CLIENTE in LDC_CLIENTE_ESPECIAL.ID_CLIENTE%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_CLIENTE_ESPECIAL in out nocopy tytbLDC_CLIENTE_ESPECIAL,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_CLIENTE_ESPECIAL in styLDC_CLIENTE_ESPECIAL,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_CLIENTE_ESPECIAL in out nocopy tytbLDC_CLIENTE_ESPECIAL,
		inuLock in number default 1
	);

	PROCEDURE updCLIENTE_ESPECIAL
	(
		inuID_CLIENTE in LDC_CLIENTE_ESPECIAL.ID_CLIENTE%type,
		isbCLIENTE_ESPECIAL$ in LDC_CLIENTE_ESPECIAL.CLIENTE_ESPECIAL%type,
		inuLock in number default 0
	);

	PROCEDURE updFECHA_REGISTRO
	(
		inuID_CLIENTE in LDC_CLIENTE_ESPECIAL.ID_CLIENTE%type,
		idtFECHA_REGISTRO$ in LDC_CLIENTE_ESPECIAL.FECHA_REGISTRO%type,
		inuLock in number default 0
	);

	PROCEDURE updFECHA_ULT_MODIF
	(
		inuID_CLIENTE in LDC_CLIENTE_ESPECIAL.ID_CLIENTE%type,
		idtFECHA_ULT_MODIF$ in LDC_CLIENTE_ESPECIAL.FECHA_ULT_MODIF%type,
		inuLock in number default 0
	);

	PROCEDURE updUSUARIO_REGISTRO
	(
		inuID_CLIENTE in LDC_CLIENTE_ESPECIAL.ID_CLIENTE%type,
		isbUSUARIO_REGISTRO$ in LDC_CLIENTE_ESPECIAL.USUARIO_REGISTRO%type,
		inuLock in number default 0
	);

	PROCEDURE updUSUARIO_ULT_MODIF
	(
		inuID_CLIENTE in LDC_CLIENTE_ESPECIAL.ID_CLIENTE%type,
		isbUSUARIO_ULT_MODIF$ in LDC_CLIENTE_ESPECIAL.USUARIO_ULT_MODIF%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetID_CLIENTE
	(
		inuID_CLIENTE in LDC_CLIENTE_ESPECIAL.ID_CLIENTE%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CLIENTE_ESPECIAL.ID_CLIENTE%type;

	FUNCTION fsbGetCLIENTE_ESPECIAL
	(
		inuID_CLIENTE in LDC_CLIENTE_ESPECIAL.ID_CLIENTE%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CLIENTE_ESPECIAL.CLIENTE_ESPECIAL%type;

	FUNCTION fdtGetFECHA_REGISTRO
	(
		inuID_CLIENTE in LDC_CLIENTE_ESPECIAL.ID_CLIENTE%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CLIENTE_ESPECIAL.FECHA_REGISTRO%type;

	FUNCTION fdtGetFECHA_ULT_MODIF
	(
		inuID_CLIENTE in LDC_CLIENTE_ESPECIAL.ID_CLIENTE%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CLIENTE_ESPECIAL.FECHA_ULT_MODIF%type;

	FUNCTION fsbGetUSUARIO_REGISTRO
	(
		inuID_CLIENTE in LDC_CLIENTE_ESPECIAL.ID_CLIENTE%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CLIENTE_ESPECIAL.USUARIO_REGISTRO%type;

	FUNCTION fsbGetUSUARIO_ULT_MODIF
	(
		inuID_CLIENTE in LDC_CLIENTE_ESPECIAL.ID_CLIENTE%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CLIENTE_ESPECIAL.USUARIO_ULT_MODIF%type;


	PROCEDURE LockByPk
	(
		inuID_CLIENTE in LDC_CLIENTE_ESPECIAL.ID_CLIENTE%type,
		orcLDC_CLIENTE_ESPECIAL  out styLDC_CLIENTE_ESPECIAL
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_CLIENTE_ESPECIAL  out styLDC_CLIENTE_ESPECIAL
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_CLIENTE_ESPECIAL;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALDC_CLIENTE_ESPECIAL
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_CLIENTE_ESPECIAL';
	 cnuGeEntityId constant varchar2(30) := 3904; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuID_CLIENTE in LDC_CLIENTE_ESPECIAL.ID_CLIENTE%type
	)
	IS
		SELECT LDC_CLIENTE_ESPECIAL.*,LDC_CLIENTE_ESPECIAL.rowid
		FROM LDC_CLIENTE_ESPECIAL
		WHERE  ID_CLIENTE = inuID_CLIENTE
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_CLIENTE_ESPECIAL.*,LDC_CLIENTE_ESPECIAL.rowid
		FROM LDC_CLIENTE_ESPECIAL
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_CLIENTE_ESPECIAL is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_CLIENTE_ESPECIAL;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_CLIENTE_ESPECIAL default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.ID_CLIENTE);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuID_CLIENTE in LDC_CLIENTE_ESPECIAL.ID_CLIENTE%type,
		orcLDC_CLIENTE_ESPECIAL  out styLDC_CLIENTE_ESPECIAL
	)
	IS
		rcError styLDC_CLIENTE_ESPECIAL;
	BEGIN
		rcError.ID_CLIENTE := inuID_CLIENTE;

		Open cuLockRcByPk
		(
			inuID_CLIENTE
		);

		fetch cuLockRcByPk into orcLDC_CLIENTE_ESPECIAL;
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
		orcLDC_CLIENTE_ESPECIAL  out styLDC_CLIENTE_ESPECIAL
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_CLIENTE_ESPECIAL;
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
		itbLDC_CLIENTE_ESPECIAL  in out nocopy tytbLDC_CLIENTE_ESPECIAL
	)
	IS
	BEGIN
			rcRecOfTab.ID_CLIENTE.delete;
			rcRecOfTab.CLIENTE_ESPECIAL.delete;
			rcRecOfTab.FECHA_REGISTRO.delete;
			rcRecOfTab.FECHA_ULT_MODIF.delete;
			rcRecOfTab.USUARIO_REGISTRO.delete;
			rcRecOfTab.USUARIO_ULT_MODIF.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_CLIENTE_ESPECIAL  in out nocopy tytbLDC_CLIENTE_ESPECIAL,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_CLIENTE_ESPECIAL);

		for n in itbLDC_CLIENTE_ESPECIAL.first .. itbLDC_CLIENTE_ESPECIAL.last loop
			rcRecOfTab.ID_CLIENTE(n) := itbLDC_CLIENTE_ESPECIAL(n).ID_CLIENTE;
			rcRecOfTab.CLIENTE_ESPECIAL(n) := itbLDC_CLIENTE_ESPECIAL(n).CLIENTE_ESPECIAL;
			rcRecOfTab.FECHA_REGISTRO(n) := itbLDC_CLIENTE_ESPECIAL(n).FECHA_REGISTRO;
			rcRecOfTab.FECHA_ULT_MODIF(n) := itbLDC_CLIENTE_ESPECIAL(n).FECHA_ULT_MODIF;
			rcRecOfTab.USUARIO_REGISTRO(n) := itbLDC_CLIENTE_ESPECIAL(n).USUARIO_REGISTRO;
			rcRecOfTab.USUARIO_ULT_MODIF(n) := itbLDC_CLIENTE_ESPECIAL(n).USUARIO_ULT_MODIF;
			rcRecOfTab.row_id(n) := itbLDC_CLIENTE_ESPECIAL(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuID_CLIENTE in LDC_CLIENTE_ESPECIAL.ID_CLIENTE%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuID_CLIENTE
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
		inuID_CLIENTE in LDC_CLIENTE_ESPECIAL.ID_CLIENTE%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuID_CLIENTE = rcData.ID_CLIENTE
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
		inuID_CLIENTE in LDC_CLIENTE_ESPECIAL.ID_CLIENTE%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuID_CLIENTE
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuID_CLIENTE in LDC_CLIENTE_ESPECIAL.ID_CLIENTE%type
	)
	IS
		rcError styLDC_CLIENTE_ESPECIAL;
	BEGIN		rcError.ID_CLIENTE:=inuID_CLIENTE;

		Load
		(
			inuID_CLIENTE
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
		inuID_CLIENTE in LDC_CLIENTE_ESPECIAL.ID_CLIENTE%type
	)
	IS
	BEGIN
		Load
		(
			inuID_CLIENTE
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuID_CLIENTE in LDC_CLIENTE_ESPECIAL.ID_CLIENTE%type,
		orcRecord out nocopy styLDC_CLIENTE_ESPECIAL
	)
	IS
		rcError styLDC_CLIENTE_ESPECIAL;
	BEGIN		rcError.ID_CLIENTE:=inuID_CLIENTE;

		Load
		(
			inuID_CLIENTE
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuID_CLIENTE in LDC_CLIENTE_ESPECIAL.ID_CLIENTE%type
	)
	RETURN styLDC_CLIENTE_ESPECIAL
	IS
		rcError styLDC_CLIENTE_ESPECIAL;
	BEGIN
		rcError.ID_CLIENTE:=inuID_CLIENTE;

		Load
		(
			inuID_CLIENTE
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuID_CLIENTE in LDC_CLIENTE_ESPECIAL.ID_CLIENTE%type
	)
	RETURN styLDC_CLIENTE_ESPECIAL
	IS
		rcError styLDC_CLIENTE_ESPECIAL;
	BEGIN
		rcError.ID_CLIENTE:=inuID_CLIENTE;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuID_CLIENTE
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuID_CLIENTE
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_CLIENTE_ESPECIAL
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_CLIENTE_ESPECIAL
	)
	IS
		rfLDC_CLIENTE_ESPECIAL tyrfLDC_CLIENTE_ESPECIAL;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_CLIENTE_ESPECIAL.*, LDC_CLIENTE_ESPECIAL.rowid FROM LDC_CLIENTE_ESPECIAL';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_CLIENTE_ESPECIAL for sbFullQuery;

		fetch rfLDC_CLIENTE_ESPECIAL bulk collect INTO otbResult;

		close rfLDC_CLIENTE_ESPECIAL;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_CLIENTE_ESPECIAL.*, LDC_CLIENTE_ESPECIAL.rowid FROM LDC_CLIENTE_ESPECIAL';
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
		ircLDC_CLIENTE_ESPECIAL in styLDC_CLIENTE_ESPECIAL
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_CLIENTE_ESPECIAL,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_CLIENTE_ESPECIAL in styLDC_CLIENTE_ESPECIAL,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_CLIENTE_ESPECIAL.ID_CLIENTE is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ID_CLIENTE');
			raise ex.controlled_error;
		end if;

		insert into LDC_CLIENTE_ESPECIAL
		(
			ID_CLIENTE,
			CLIENTE_ESPECIAL,
			FECHA_REGISTRO,
			FECHA_ULT_MODIF,
			USUARIO_REGISTRO,
			USUARIO_ULT_MODIF
		)
		values
		(
			ircLDC_CLIENTE_ESPECIAL.ID_CLIENTE,
			ircLDC_CLIENTE_ESPECIAL.CLIENTE_ESPECIAL,
			ircLDC_CLIENTE_ESPECIAL.FECHA_REGISTRO,
			ircLDC_CLIENTE_ESPECIAL.FECHA_ULT_MODIF,
			ircLDC_CLIENTE_ESPECIAL.USUARIO_REGISTRO,
			ircLDC_CLIENTE_ESPECIAL.USUARIO_ULT_MODIF
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_CLIENTE_ESPECIAL));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_CLIENTE_ESPECIAL in out nocopy tytbLDC_CLIENTE_ESPECIAL
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_CLIENTE_ESPECIAL,blUseRowID);
		forall n in iotbLDC_CLIENTE_ESPECIAL.first..iotbLDC_CLIENTE_ESPECIAL.last
			insert into LDC_CLIENTE_ESPECIAL
			(
				ID_CLIENTE,
				CLIENTE_ESPECIAL,
				FECHA_REGISTRO,
				FECHA_ULT_MODIF,
				USUARIO_REGISTRO,
				USUARIO_ULT_MODIF
			)
			values
			(
				rcRecOfTab.ID_CLIENTE(n),
				rcRecOfTab.CLIENTE_ESPECIAL(n),
				rcRecOfTab.FECHA_REGISTRO(n),
				rcRecOfTab.FECHA_ULT_MODIF(n),
				rcRecOfTab.USUARIO_REGISTRO(n),
				rcRecOfTab.USUARIO_ULT_MODIF(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuID_CLIENTE in LDC_CLIENTE_ESPECIAL.ID_CLIENTE%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_CLIENTE_ESPECIAL;
	BEGIN
		rcError.ID_CLIENTE := inuID_CLIENTE;

		if inuLock=1 then
			LockByPk
			(
				inuID_CLIENTE,
				rcData
			);
		end if;


		delete
		from LDC_CLIENTE_ESPECIAL
		where
       		ID_CLIENTE=inuID_CLIENTE;
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
		rcError  styLDC_CLIENTE_ESPECIAL;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_CLIENTE_ESPECIAL
		where
			rowid = iriRowID
		returning
			ID_CLIENTE
		into
			rcError.ID_CLIENTE;
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
		iotbLDC_CLIENTE_ESPECIAL in out nocopy tytbLDC_CLIENTE_ESPECIAL,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_CLIENTE_ESPECIAL;
	BEGIN
		FillRecordOfTables(iotbLDC_CLIENTE_ESPECIAL, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_CLIENTE_ESPECIAL.first .. iotbLDC_CLIENTE_ESPECIAL.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CLIENTE_ESPECIAL.first .. iotbLDC_CLIENTE_ESPECIAL.last
				delete
				from LDC_CLIENTE_ESPECIAL
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_CLIENTE_ESPECIAL.first .. iotbLDC_CLIENTE_ESPECIAL.last loop
					LockByPk
					(
						rcRecOfTab.ID_CLIENTE(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CLIENTE_ESPECIAL.first .. iotbLDC_CLIENTE_ESPECIAL.last
				delete
				from LDC_CLIENTE_ESPECIAL
				where
		         	ID_CLIENTE = rcRecOfTab.ID_CLIENTE(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_CLIENTE_ESPECIAL in styLDC_CLIENTE_ESPECIAL,
		inuLock in number default 0
	)
	IS
		nuID_CLIENTE	LDC_CLIENTE_ESPECIAL.ID_CLIENTE%type;
	BEGIN
		if ircLDC_CLIENTE_ESPECIAL.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_CLIENTE_ESPECIAL.rowid,rcData);
			end if;
			update LDC_CLIENTE_ESPECIAL
			set
				CLIENTE_ESPECIAL = ircLDC_CLIENTE_ESPECIAL.CLIENTE_ESPECIAL,
				FECHA_REGISTRO = ircLDC_CLIENTE_ESPECIAL.FECHA_REGISTRO,
				FECHA_ULT_MODIF = ircLDC_CLIENTE_ESPECIAL.FECHA_ULT_MODIF,
				USUARIO_REGISTRO = ircLDC_CLIENTE_ESPECIAL.USUARIO_REGISTRO,
				USUARIO_ULT_MODIF = ircLDC_CLIENTE_ESPECIAL.USUARIO_ULT_MODIF
			where
				rowid = ircLDC_CLIENTE_ESPECIAL.rowid
			returning
				ID_CLIENTE
			into
				nuID_CLIENTE;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_CLIENTE_ESPECIAL.ID_CLIENTE,
					rcData
				);
			end if;

			update LDC_CLIENTE_ESPECIAL
			set
				CLIENTE_ESPECIAL = ircLDC_CLIENTE_ESPECIAL.CLIENTE_ESPECIAL,
				FECHA_REGISTRO = ircLDC_CLIENTE_ESPECIAL.FECHA_REGISTRO,
				FECHA_ULT_MODIF = ircLDC_CLIENTE_ESPECIAL.FECHA_ULT_MODIF,
				USUARIO_REGISTRO = ircLDC_CLIENTE_ESPECIAL.USUARIO_REGISTRO,
				USUARIO_ULT_MODIF = ircLDC_CLIENTE_ESPECIAL.USUARIO_ULT_MODIF
			where
				ID_CLIENTE = ircLDC_CLIENTE_ESPECIAL.ID_CLIENTE
			returning
				ID_CLIENTE
			into
				nuID_CLIENTE;
		end if;
		if
			nuID_CLIENTE is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_CLIENTE_ESPECIAL));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_CLIENTE_ESPECIAL in out nocopy tytbLDC_CLIENTE_ESPECIAL,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_CLIENTE_ESPECIAL;
	BEGIN
		FillRecordOfTables(iotbLDC_CLIENTE_ESPECIAL,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_CLIENTE_ESPECIAL.first .. iotbLDC_CLIENTE_ESPECIAL.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CLIENTE_ESPECIAL.first .. iotbLDC_CLIENTE_ESPECIAL.last
				update LDC_CLIENTE_ESPECIAL
				set
					CLIENTE_ESPECIAL = rcRecOfTab.CLIENTE_ESPECIAL(n),
					FECHA_REGISTRO = rcRecOfTab.FECHA_REGISTRO(n),
					FECHA_ULT_MODIF = rcRecOfTab.FECHA_ULT_MODIF(n),
					USUARIO_REGISTRO = rcRecOfTab.USUARIO_REGISTRO(n),
					USUARIO_ULT_MODIF = rcRecOfTab.USUARIO_ULT_MODIF(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_CLIENTE_ESPECIAL.first .. iotbLDC_CLIENTE_ESPECIAL.last loop
					LockByPk
					(
						rcRecOfTab.ID_CLIENTE(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CLIENTE_ESPECIAL.first .. iotbLDC_CLIENTE_ESPECIAL.last
				update LDC_CLIENTE_ESPECIAL
				SET
					CLIENTE_ESPECIAL = rcRecOfTab.CLIENTE_ESPECIAL(n),
					FECHA_REGISTRO = rcRecOfTab.FECHA_REGISTRO(n),
					FECHA_ULT_MODIF = rcRecOfTab.FECHA_ULT_MODIF(n),
					USUARIO_REGISTRO = rcRecOfTab.USUARIO_REGISTRO(n),
					USUARIO_ULT_MODIF = rcRecOfTab.USUARIO_ULT_MODIF(n)
				where
					ID_CLIENTE = rcRecOfTab.ID_CLIENTE(n)
;
		end if;
	END;
	PROCEDURE updCLIENTE_ESPECIAL
	(
		inuID_CLIENTE in LDC_CLIENTE_ESPECIAL.ID_CLIENTE%type,
		isbCLIENTE_ESPECIAL$ in LDC_CLIENTE_ESPECIAL.CLIENTE_ESPECIAL%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CLIENTE_ESPECIAL;
	BEGIN
		rcError.ID_CLIENTE := inuID_CLIENTE;
		if inuLock=1 then
			LockByPk
			(
				inuID_CLIENTE,
				rcData
			);
		end if;

		update LDC_CLIENTE_ESPECIAL
		set
			CLIENTE_ESPECIAL = isbCLIENTE_ESPECIAL$
		where
			ID_CLIENTE = inuID_CLIENTE;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CLIENTE_ESPECIAL:= isbCLIENTE_ESPECIAL$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFECHA_REGISTRO
	(
		inuID_CLIENTE in LDC_CLIENTE_ESPECIAL.ID_CLIENTE%type,
		idtFECHA_REGISTRO$ in LDC_CLIENTE_ESPECIAL.FECHA_REGISTRO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CLIENTE_ESPECIAL;
	BEGIN
		rcError.ID_CLIENTE := inuID_CLIENTE;
		if inuLock=1 then
			LockByPk
			(
				inuID_CLIENTE,
				rcData
			);
		end if;

		update LDC_CLIENTE_ESPECIAL
		set
			FECHA_REGISTRO = idtFECHA_REGISTRO$
		where
			ID_CLIENTE = inuID_CLIENTE;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FECHA_REGISTRO:= idtFECHA_REGISTRO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFECHA_ULT_MODIF
	(
		inuID_CLIENTE in LDC_CLIENTE_ESPECIAL.ID_CLIENTE%type,
		idtFECHA_ULT_MODIF$ in LDC_CLIENTE_ESPECIAL.FECHA_ULT_MODIF%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CLIENTE_ESPECIAL;
	BEGIN
		rcError.ID_CLIENTE := inuID_CLIENTE;
		if inuLock=1 then
			LockByPk
			(
				inuID_CLIENTE,
				rcData
			);
		end if;

		update LDC_CLIENTE_ESPECIAL
		set
			FECHA_ULT_MODIF = idtFECHA_ULT_MODIF$
		where
			ID_CLIENTE = inuID_CLIENTE;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FECHA_ULT_MODIF:= idtFECHA_ULT_MODIF$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updUSUARIO_REGISTRO
	(
		inuID_CLIENTE in LDC_CLIENTE_ESPECIAL.ID_CLIENTE%type,
		isbUSUARIO_REGISTRO$ in LDC_CLIENTE_ESPECIAL.USUARIO_REGISTRO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CLIENTE_ESPECIAL;
	BEGIN
		rcError.ID_CLIENTE := inuID_CLIENTE;
		if inuLock=1 then
			LockByPk
			(
				inuID_CLIENTE,
				rcData
			);
		end if;

		update LDC_CLIENTE_ESPECIAL
		set
			USUARIO_REGISTRO = isbUSUARIO_REGISTRO$
		where
			ID_CLIENTE = inuID_CLIENTE;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.USUARIO_REGISTRO:= isbUSUARIO_REGISTRO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updUSUARIO_ULT_MODIF
	(
		inuID_CLIENTE in LDC_CLIENTE_ESPECIAL.ID_CLIENTE%type,
		isbUSUARIO_ULT_MODIF$ in LDC_CLIENTE_ESPECIAL.USUARIO_ULT_MODIF%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CLIENTE_ESPECIAL;
	BEGIN
		rcError.ID_CLIENTE := inuID_CLIENTE;
		if inuLock=1 then
			LockByPk
			(
				inuID_CLIENTE,
				rcData
			);
		end if;

		update LDC_CLIENTE_ESPECIAL
		set
			USUARIO_ULT_MODIF = isbUSUARIO_ULT_MODIF$
		where
			ID_CLIENTE = inuID_CLIENTE;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.USUARIO_ULT_MODIF:= isbUSUARIO_ULT_MODIF$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetID_CLIENTE
	(
		inuID_CLIENTE in LDC_CLIENTE_ESPECIAL.ID_CLIENTE%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CLIENTE_ESPECIAL.ID_CLIENTE%type
	IS
		rcError styLDC_CLIENTE_ESPECIAL;
	BEGIN

		rcError.ID_CLIENTE := inuID_CLIENTE;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_CLIENTE
			 )
		then
			 return(rcData.ID_CLIENTE);
		end if;
		Load
		(
		 		inuID_CLIENTE
		);
		return(rcData.ID_CLIENTE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetCLIENTE_ESPECIAL
	(
		inuID_CLIENTE in LDC_CLIENTE_ESPECIAL.ID_CLIENTE%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CLIENTE_ESPECIAL.CLIENTE_ESPECIAL%type
	IS
		rcError styLDC_CLIENTE_ESPECIAL;
	BEGIN

		rcError.ID_CLIENTE := inuID_CLIENTE;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_CLIENTE
			 )
		then
			 return(rcData.CLIENTE_ESPECIAL);
		end if;
		Load
		(
		 		inuID_CLIENTE
		);
		return(rcData.CLIENTE_ESPECIAL);
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
		inuID_CLIENTE in LDC_CLIENTE_ESPECIAL.ID_CLIENTE%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CLIENTE_ESPECIAL.FECHA_REGISTRO%type
	IS
		rcError styLDC_CLIENTE_ESPECIAL;
	BEGIN

		rcError.ID_CLIENTE := inuID_CLIENTE;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_CLIENTE
			 )
		then
			 return(rcData.FECHA_REGISTRO);
		end if;
		Load
		(
		 		inuID_CLIENTE
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
	FUNCTION fdtGetFECHA_ULT_MODIF
	(
		inuID_CLIENTE in LDC_CLIENTE_ESPECIAL.ID_CLIENTE%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CLIENTE_ESPECIAL.FECHA_ULT_MODIF%type
	IS
		rcError styLDC_CLIENTE_ESPECIAL;
	BEGIN

		rcError.ID_CLIENTE := inuID_CLIENTE;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_CLIENTE
			 )
		then
			 return(rcData.FECHA_ULT_MODIF);
		end if;
		Load
		(
		 		inuID_CLIENTE
		);
		return(rcData.FECHA_ULT_MODIF);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetUSUARIO_REGISTRO
	(
		inuID_CLIENTE in LDC_CLIENTE_ESPECIAL.ID_CLIENTE%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CLIENTE_ESPECIAL.USUARIO_REGISTRO%type
	IS
		rcError styLDC_CLIENTE_ESPECIAL;
	BEGIN

		rcError.ID_CLIENTE := inuID_CLIENTE;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_CLIENTE
			 )
		then
			 return(rcData.USUARIO_REGISTRO);
		end if;
		Load
		(
		 		inuID_CLIENTE
		);
		return(rcData.USUARIO_REGISTRO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetUSUARIO_ULT_MODIF
	(
		inuID_CLIENTE in LDC_CLIENTE_ESPECIAL.ID_CLIENTE%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CLIENTE_ESPECIAL.USUARIO_ULT_MODIF%type
	IS
		rcError styLDC_CLIENTE_ESPECIAL;
	BEGIN

		rcError.ID_CLIENTE := inuID_CLIENTE;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_CLIENTE
			 )
		then
			 return(rcData.USUARIO_ULT_MODIF);
		end if;
		Load
		(
		 		inuID_CLIENTE
		);
		return(rcData.USUARIO_ULT_MODIF);
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
end DALDC_CLIENTE_ESPECIAL;
/
PROMPT Otorgando permisos de ejecucion a DALDC_CLIENTE_ESPECIAL
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_CLIENTE_ESPECIAL', 'ADM_PERSON');
END;
/