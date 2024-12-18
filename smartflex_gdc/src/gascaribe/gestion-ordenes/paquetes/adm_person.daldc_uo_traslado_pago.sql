CREATE OR REPLACE PACKAGE ADM_PERSON.DALDC_UO_TRASLADO_PAGO
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
		inuPACKAGE_ID in LDC_UO_TRASLADO_PAGO.PACKAGE_ID%type
	)
	IS
		SELECT LDC_UO_TRASLADO_PAGO.*,LDC_UO_TRASLADO_PAGO.rowid
		FROM LDC_UO_TRASLADO_PAGO
		WHERE
		    PACKAGE_ID = inuPACKAGE_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_UO_TRASLADO_PAGO.*,LDC_UO_TRASLADO_PAGO.rowid
		FROM LDC_UO_TRASLADO_PAGO
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_UO_TRASLADO_PAGO  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_UO_TRASLADO_PAGO is table of styLDC_UO_TRASLADO_PAGO index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_UO_TRASLADO_PAGO;

	/* Tipos referenciando al registro */
	type tytbPACKAGE_ID is table of LDC_UO_TRASLADO_PAGO.PACKAGE_ID%type index by binary_integer;
	type tytbOPERATING_UNIT_ID is table of LDC_UO_TRASLADO_PAGO.OPERATING_UNIT_ID%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_UO_TRASLADO_PAGO is record
	(
		PACKAGE_ID   tytbPACKAGE_ID,
		OPERATING_UNIT_ID   tytbOPERATING_UNIT_ID,
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
		inuPACKAGE_ID in LDC_UO_TRASLADO_PAGO.PACKAGE_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuPACKAGE_ID in LDC_UO_TRASLADO_PAGO.PACKAGE_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuPACKAGE_ID in LDC_UO_TRASLADO_PAGO.PACKAGE_ID%type
	);

	PROCEDURE getRecord
	(
		inuPACKAGE_ID in LDC_UO_TRASLADO_PAGO.PACKAGE_ID%type,
		orcRecord out nocopy styLDC_UO_TRASLADO_PAGO
	);

	FUNCTION frcGetRcData
	(
		inuPACKAGE_ID in LDC_UO_TRASLADO_PAGO.PACKAGE_ID%type
	)
	RETURN styLDC_UO_TRASLADO_PAGO;

	FUNCTION frcGetRcData
	RETURN styLDC_UO_TRASLADO_PAGO;

	FUNCTION frcGetRecord
	(
		inuPACKAGE_ID in LDC_UO_TRASLADO_PAGO.PACKAGE_ID%type
	)
	RETURN styLDC_UO_TRASLADO_PAGO;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_UO_TRASLADO_PAGO
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_UO_TRASLADO_PAGO in styLDC_UO_TRASLADO_PAGO
	);

	PROCEDURE insRecord
	(
		ircLDC_UO_TRASLADO_PAGO in styLDC_UO_TRASLADO_PAGO,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_UO_TRASLADO_PAGO in out nocopy tytbLDC_UO_TRASLADO_PAGO
	);

	PROCEDURE delRecord
	(
		inuPACKAGE_ID in LDC_UO_TRASLADO_PAGO.PACKAGE_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_UO_TRASLADO_PAGO in out nocopy tytbLDC_UO_TRASLADO_PAGO,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_UO_TRASLADO_PAGO in styLDC_UO_TRASLADO_PAGO,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_UO_TRASLADO_PAGO in out nocopy tytbLDC_UO_TRASLADO_PAGO,
		inuLock in number default 1
	);

	PROCEDURE updOPERATING_UNIT_ID
	(
		inuPACKAGE_ID in LDC_UO_TRASLADO_PAGO.PACKAGE_ID%type,
		inuOPERATING_UNIT_ID$ in LDC_UO_TRASLADO_PAGO.OPERATING_UNIT_ID%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetPACKAGE_ID
	(
		inuPACKAGE_ID in LDC_UO_TRASLADO_PAGO.PACKAGE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_UO_TRASLADO_PAGO.PACKAGE_ID%type;

	FUNCTION fnuGetOPERATING_UNIT_ID
	(
		inuPACKAGE_ID in LDC_UO_TRASLADO_PAGO.PACKAGE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_UO_TRASLADO_PAGO.OPERATING_UNIT_ID%type;


	PROCEDURE LockByPk
	(
		inuPACKAGE_ID in LDC_UO_TRASLADO_PAGO.PACKAGE_ID%type,
		orcLDC_UO_TRASLADO_PAGO  out styLDC_UO_TRASLADO_PAGO
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_UO_TRASLADO_PAGO  out styLDC_UO_TRASLADO_PAGO
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_UO_TRASLADO_PAGO;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALDC_UO_TRASLADO_PAGO
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO1';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_UO_TRASLADO_PAGO';
	 cnuGeEntityId constant varchar2(30) := 5864; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuPACKAGE_ID in LDC_UO_TRASLADO_PAGO.PACKAGE_ID%type
	)
	IS
		SELECT LDC_UO_TRASLADO_PAGO.*,LDC_UO_TRASLADO_PAGO.rowid
		FROM LDC_UO_TRASLADO_PAGO
		WHERE  PACKAGE_ID = inuPACKAGE_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_UO_TRASLADO_PAGO.*,LDC_UO_TRASLADO_PAGO.rowid
		FROM LDC_UO_TRASLADO_PAGO
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_UO_TRASLADO_PAGO is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_UO_TRASLADO_PAGO;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_UO_TRASLADO_PAGO default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.PACKAGE_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuPACKAGE_ID in LDC_UO_TRASLADO_PAGO.PACKAGE_ID%type,
		orcLDC_UO_TRASLADO_PAGO  out styLDC_UO_TRASLADO_PAGO
	)
	IS
		rcError styLDC_UO_TRASLADO_PAGO;
	BEGIN
		rcError.PACKAGE_ID := inuPACKAGE_ID;

		Open cuLockRcByPk
		(
			inuPACKAGE_ID
		);

		fetch cuLockRcByPk into orcLDC_UO_TRASLADO_PAGO;
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
		orcLDC_UO_TRASLADO_PAGO  out styLDC_UO_TRASLADO_PAGO
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_UO_TRASLADO_PAGO;
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
		itbLDC_UO_TRASLADO_PAGO  in out nocopy tytbLDC_UO_TRASLADO_PAGO
	)
	IS
	BEGIN
			rcRecOfTab.PACKAGE_ID.delete;
			rcRecOfTab.OPERATING_UNIT_ID.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_UO_TRASLADO_PAGO  in out nocopy tytbLDC_UO_TRASLADO_PAGO,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_UO_TRASLADO_PAGO);

		for n in itbLDC_UO_TRASLADO_PAGO.first .. itbLDC_UO_TRASLADO_PAGO.last loop
			rcRecOfTab.PACKAGE_ID(n) := itbLDC_UO_TRASLADO_PAGO(n).PACKAGE_ID;
			rcRecOfTab.OPERATING_UNIT_ID(n) := itbLDC_UO_TRASLADO_PAGO(n).OPERATING_UNIT_ID;
			rcRecOfTab.row_id(n) := itbLDC_UO_TRASLADO_PAGO(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuPACKAGE_ID in LDC_UO_TRASLADO_PAGO.PACKAGE_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuPACKAGE_ID
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
		inuPACKAGE_ID in LDC_UO_TRASLADO_PAGO.PACKAGE_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuPACKAGE_ID = rcData.PACKAGE_ID
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
		inuPACKAGE_ID in LDC_UO_TRASLADO_PAGO.PACKAGE_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuPACKAGE_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuPACKAGE_ID in LDC_UO_TRASLADO_PAGO.PACKAGE_ID%type
	)
	IS
		rcError styLDC_UO_TRASLADO_PAGO;
	BEGIN		rcError.PACKAGE_ID:=inuPACKAGE_ID;

		Load
		(
			inuPACKAGE_ID
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
		inuPACKAGE_ID in LDC_UO_TRASLADO_PAGO.PACKAGE_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuPACKAGE_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuPACKAGE_ID in LDC_UO_TRASLADO_PAGO.PACKAGE_ID%type,
		orcRecord out nocopy styLDC_UO_TRASLADO_PAGO
	)
	IS
		rcError styLDC_UO_TRASLADO_PAGO;
	BEGIN		rcError.PACKAGE_ID:=inuPACKAGE_ID;

		Load
		(
			inuPACKAGE_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuPACKAGE_ID in LDC_UO_TRASLADO_PAGO.PACKAGE_ID%type
	)
	RETURN styLDC_UO_TRASLADO_PAGO
	IS
		rcError styLDC_UO_TRASLADO_PAGO;
	BEGIN
		rcError.PACKAGE_ID:=inuPACKAGE_ID;

		Load
		(
			inuPACKAGE_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuPACKAGE_ID in LDC_UO_TRASLADO_PAGO.PACKAGE_ID%type
	)
	RETURN styLDC_UO_TRASLADO_PAGO
	IS
		rcError styLDC_UO_TRASLADO_PAGO;
	BEGIN
		rcError.PACKAGE_ID:=inuPACKAGE_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuPACKAGE_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuPACKAGE_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_UO_TRASLADO_PAGO
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_UO_TRASLADO_PAGO
	)
	IS
		rfLDC_UO_TRASLADO_PAGO tyrfLDC_UO_TRASLADO_PAGO;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_UO_TRASLADO_PAGO.*, LDC_UO_TRASLADO_PAGO.rowid FROM LDC_UO_TRASLADO_PAGO';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_UO_TRASLADO_PAGO for sbFullQuery;

		fetch rfLDC_UO_TRASLADO_PAGO bulk collect INTO otbResult;

		close rfLDC_UO_TRASLADO_PAGO;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_UO_TRASLADO_PAGO.*, LDC_UO_TRASLADO_PAGO.rowid FROM LDC_UO_TRASLADO_PAGO';
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
		ircLDC_UO_TRASLADO_PAGO in styLDC_UO_TRASLADO_PAGO
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_UO_TRASLADO_PAGO,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_UO_TRASLADO_PAGO in styLDC_UO_TRASLADO_PAGO,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_UO_TRASLADO_PAGO.PACKAGE_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|PACKAGE_ID');
			raise ex.controlled_error;
		end if;

		insert into LDC_UO_TRASLADO_PAGO
		(
			PACKAGE_ID,
			OPERATING_UNIT_ID
		)
		values
		(
			ircLDC_UO_TRASLADO_PAGO.PACKAGE_ID,
			ircLDC_UO_TRASLADO_PAGO.OPERATING_UNIT_ID
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_UO_TRASLADO_PAGO));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_UO_TRASLADO_PAGO in out nocopy tytbLDC_UO_TRASLADO_PAGO
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_UO_TRASLADO_PAGO,blUseRowID);
		forall n in iotbLDC_UO_TRASLADO_PAGO.first..iotbLDC_UO_TRASLADO_PAGO.last
			insert into LDC_UO_TRASLADO_PAGO
			(
				PACKAGE_ID,
				OPERATING_UNIT_ID
			)
			values
			(
				rcRecOfTab.PACKAGE_ID(n),
				rcRecOfTab.OPERATING_UNIT_ID(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuPACKAGE_ID in LDC_UO_TRASLADO_PAGO.PACKAGE_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_UO_TRASLADO_PAGO;
	BEGIN
		rcError.PACKAGE_ID := inuPACKAGE_ID;

		if inuLock=1 then
			LockByPk
			(
				inuPACKAGE_ID,
				rcData
			);
		end if;


		delete
		from LDC_UO_TRASLADO_PAGO
		where
       		PACKAGE_ID=inuPACKAGE_ID;
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
		rcError  styLDC_UO_TRASLADO_PAGO;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_UO_TRASLADO_PAGO
		where
			rowid = iriRowID
		returning
			PACKAGE_ID
		into
			rcError.PACKAGE_ID;
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
		iotbLDC_UO_TRASLADO_PAGO in out nocopy tytbLDC_UO_TRASLADO_PAGO,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_UO_TRASLADO_PAGO;
	BEGIN
		FillRecordOfTables(iotbLDC_UO_TRASLADO_PAGO, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_UO_TRASLADO_PAGO.first .. iotbLDC_UO_TRASLADO_PAGO.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_UO_TRASLADO_PAGO.first .. iotbLDC_UO_TRASLADO_PAGO.last
				delete
				from LDC_UO_TRASLADO_PAGO
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_UO_TRASLADO_PAGO.first .. iotbLDC_UO_TRASLADO_PAGO.last loop
					LockByPk
					(
						rcRecOfTab.PACKAGE_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_UO_TRASLADO_PAGO.first .. iotbLDC_UO_TRASLADO_PAGO.last
				delete
				from LDC_UO_TRASLADO_PAGO
				where
		         	PACKAGE_ID = rcRecOfTab.PACKAGE_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_UO_TRASLADO_PAGO in styLDC_UO_TRASLADO_PAGO,
		inuLock in number default 0
	)
	IS
		nuPACKAGE_ID	LDC_UO_TRASLADO_PAGO.PACKAGE_ID%type;
	BEGIN
		if ircLDC_UO_TRASLADO_PAGO.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_UO_TRASLADO_PAGO.rowid,rcData);
			end if;
			update LDC_UO_TRASLADO_PAGO
			set
				OPERATING_UNIT_ID = ircLDC_UO_TRASLADO_PAGO.OPERATING_UNIT_ID
			where
				rowid = ircLDC_UO_TRASLADO_PAGO.rowid
			returning
				PACKAGE_ID
			into
				nuPACKAGE_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_UO_TRASLADO_PAGO.PACKAGE_ID,
					rcData
				);
			end if;

			update LDC_UO_TRASLADO_PAGO
			set
				OPERATING_UNIT_ID = ircLDC_UO_TRASLADO_PAGO.OPERATING_UNIT_ID
			where
				PACKAGE_ID = ircLDC_UO_TRASLADO_PAGO.PACKAGE_ID
			returning
				PACKAGE_ID
			into
				nuPACKAGE_ID;
		end if;
		if
			nuPACKAGE_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_UO_TRASLADO_PAGO));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_UO_TRASLADO_PAGO in out nocopy tytbLDC_UO_TRASLADO_PAGO,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_UO_TRASLADO_PAGO;
	BEGIN
		FillRecordOfTables(iotbLDC_UO_TRASLADO_PAGO,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_UO_TRASLADO_PAGO.first .. iotbLDC_UO_TRASLADO_PAGO.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_UO_TRASLADO_PAGO.first .. iotbLDC_UO_TRASLADO_PAGO.last
				update LDC_UO_TRASLADO_PAGO
				set
					OPERATING_UNIT_ID = rcRecOfTab.OPERATING_UNIT_ID(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_UO_TRASLADO_PAGO.first .. iotbLDC_UO_TRASLADO_PAGO.last loop
					LockByPk
					(
						rcRecOfTab.PACKAGE_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_UO_TRASLADO_PAGO.first .. iotbLDC_UO_TRASLADO_PAGO.last
				update LDC_UO_TRASLADO_PAGO
				SET
					OPERATING_UNIT_ID = rcRecOfTab.OPERATING_UNIT_ID(n)
				where
					PACKAGE_ID = rcRecOfTab.PACKAGE_ID(n)
;
		end if;
	END;
	PROCEDURE updOPERATING_UNIT_ID
	(
		inuPACKAGE_ID in LDC_UO_TRASLADO_PAGO.PACKAGE_ID%type,
		inuOPERATING_UNIT_ID$ in LDC_UO_TRASLADO_PAGO.OPERATING_UNIT_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_UO_TRASLADO_PAGO;
	BEGIN
		rcError.PACKAGE_ID := inuPACKAGE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPACKAGE_ID,
				rcData
			);
		end if;

		update LDC_UO_TRASLADO_PAGO
		set
			OPERATING_UNIT_ID = inuOPERATING_UNIT_ID$
		where
			PACKAGE_ID = inuPACKAGE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.OPERATING_UNIT_ID:= inuOPERATING_UNIT_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetPACKAGE_ID
	(
		inuPACKAGE_ID in LDC_UO_TRASLADO_PAGO.PACKAGE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_UO_TRASLADO_PAGO.PACKAGE_ID%type
	IS
		rcError styLDC_UO_TRASLADO_PAGO;
	BEGIN

		rcError.PACKAGE_ID := inuPACKAGE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPACKAGE_ID
			 )
		then
			 return(rcData.PACKAGE_ID);
		end if;
		Load
		(
		 		inuPACKAGE_ID
		);
		return(rcData.PACKAGE_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetOPERATING_UNIT_ID
	(
		inuPACKAGE_ID in LDC_UO_TRASLADO_PAGO.PACKAGE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_UO_TRASLADO_PAGO.OPERATING_UNIT_ID%type
	IS
		rcError styLDC_UO_TRASLADO_PAGO;
	BEGIN

		rcError.PACKAGE_ID := inuPACKAGE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPACKAGE_ID
			 )
		then
			 return(rcData.OPERATING_UNIT_ID);
		end if;
		Load
		(
		 		inuPACKAGE_ID
		);
		return(rcData.OPERATING_UNIT_ID);
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
end DALDC_UO_TRASLADO_PAGO;
/
PROMPT Otorgando permisos de ejecucion a DALDC_UO_TRASLADO_PAGO
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_UO_TRASLADO_PAGO', 'ADM_PERSON');
END;
/