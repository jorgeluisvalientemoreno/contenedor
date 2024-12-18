CREATE OR REPLACE PACKAGE ADM_PERSON.DALDC_ORDENES_DOCU
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
		inuID_ORDEN in LDC_ORDENES_DOCU.ID_ORDEN%type
	)
	IS
		SELECT LDC_ORDENES_DOCU.*,LDC_ORDENES_DOCU.rowid
		FROM LDC_ORDENES_DOCU
		WHERE
		    ID_ORDEN = inuID_ORDEN;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_ORDENES_DOCU.*,LDC_ORDENES_DOCU.rowid
		FROM LDC_ORDENES_DOCU
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_ORDENES_DOCU  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_ORDENES_DOCU is table of styLDC_ORDENES_DOCU index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_ORDENES_DOCU;

	/* Tipos referenciando al registro */
	type tytbID_ORDEN is table of LDC_ORDENES_DOCU.ID_ORDEN%type index by binary_integer;
	type tytbID_PROCESO is table of LDC_ORDENES_DOCU.ID_PROCESO%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_ORDENES_DOCU is record
	(
		ID_ORDEN   tytbID_ORDEN,
		ID_PROCESO   tytbID_PROCESO,
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
		inuID_ORDEN in LDC_ORDENES_DOCU.ID_ORDEN%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuID_ORDEN in LDC_ORDENES_DOCU.ID_ORDEN%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuID_ORDEN in LDC_ORDENES_DOCU.ID_ORDEN%type
	);

	PROCEDURE getRecord
	(
		inuID_ORDEN in LDC_ORDENES_DOCU.ID_ORDEN%type,
		orcRecord out nocopy styLDC_ORDENES_DOCU
	);

	FUNCTION frcGetRcData
	(
		inuID_ORDEN in LDC_ORDENES_DOCU.ID_ORDEN%type
	)
	RETURN styLDC_ORDENES_DOCU;

	FUNCTION frcGetRcData
	RETURN styLDC_ORDENES_DOCU;

	FUNCTION frcGetRecord
	(
		inuID_ORDEN in LDC_ORDENES_DOCU.ID_ORDEN%type
	)
	RETURN styLDC_ORDENES_DOCU;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_ORDENES_DOCU
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_ORDENES_DOCU in styLDC_ORDENES_DOCU
	);

	PROCEDURE insRecord
	(
		ircLDC_ORDENES_DOCU in styLDC_ORDENES_DOCU,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_ORDENES_DOCU in out nocopy tytbLDC_ORDENES_DOCU
	);

	PROCEDURE delRecord
	(
		inuID_ORDEN in LDC_ORDENES_DOCU.ID_ORDEN%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_ORDENES_DOCU in out nocopy tytbLDC_ORDENES_DOCU,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_ORDENES_DOCU in styLDC_ORDENES_DOCU,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_ORDENES_DOCU in out nocopy tytbLDC_ORDENES_DOCU,
		inuLock in number default 1
	);

	PROCEDURE updID_PROCESO
	(
		inuID_ORDEN in LDC_ORDENES_DOCU.ID_ORDEN%type,
		inuID_PROCESO$ in LDC_ORDENES_DOCU.ID_PROCESO%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetID_ORDEN
	(
		inuID_ORDEN in LDC_ORDENES_DOCU.ID_ORDEN%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ORDENES_DOCU.ID_ORDEN%type;

	FUNCTION fnuGetID_PROCESO
	(
		inuID_ORDEN in LDC_ORDENES_DOCU.ID_ORDEN%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ORDENES_DOCU.ID_PROCESO%type;


	PROCEDURE LockByPk
	(
		inuID_ORDEN in LDC_ORDENES_DOCU.ID_ORDEN%type,
		orcLDC_ORDENES_DOCU  out styLDC_ORDENES_DOCU
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_ORDENES_DOCU  out styLDC_ORDENES_DOCU
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_ORDENES_DOCU;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALDC_ORDENES_DOCU
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO6013';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_ORDENES_DOCU';
	 cnuGeEntityId constant varchar2(30) := 2164; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuID_ORDEN in LDC_ORDENES_DOCU.ID_ORDEN%type
	)
	IS
		SELECT LDC_ORDENES_DOCU.*,LDC_ORDENES_DOCU.rowid
		FROM LDC_ORDENES_DOCU
		WHERE  ID_ORDEN = inuID_ORDEN
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_ORDENES_DOCU.*,LDC_ORDENES_DOCU.rowid
		FROM LDC_ORDENES_DOCU
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_ORDENES_DOCU is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_ORDENES_DOCU;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_ORDENES_DOCU default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.ID_ORDEN);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuID_ORDEN in LDC_ORDENES_DOCU.ID_ORDEN%type,
		orcLDC_ORDENES_DOCU  out styLDC_ORDENES_DOCU
	)
	IS
		rcError styLDC_ORDENES_DOCU;
	BEGIN
		rcError.ID_ORDEN := inuID_ORDEN;

		Open cuLockRcByPk
		(
			inuID_ORDEN
		);

		fetch cuLockRcByPk into orcLDC_ORDENES_DOCU;
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
		orcLDC_ORDENES_DOCU  out styLDC_ORDENES_DOCU
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_ORDENES_DOCU;
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
		itbLDC_ORDENES_DOCU  in out nocopy tytbLDC_ORDENES_DOCU
	)
	IS
	BEGIN
			rcRecOfTab.ID_ORDEN.delete;
			rcRecOfTab.ID_PROCESO.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_ORDENES_DOCU  in out nocopy tytbLDC_ORDENES_DOCU,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_ORDENES_DOCU);

		for n in itbLDC_ORDENES_DOCU.first .. itbLDC_ORDENES_DOCU.last loop
			rcRecOfTab.ID_ORDEN(n) := itbLDC_ORDENES_DOCU(n).ID_ORDEN;
			rcRecOfTab.ID_PROCESO(n) := itbLDC_ORDENES_DOCU(n).ID_PROCESO;
			rcRecOfTab.row_id(n) := itbLDC_ORDENES_DOCU(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuID_ORDEN in LDC_ORDENES_DOCU.ID_ORDEN%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuID_ORDEN
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
		inuID_ORDEN in LDC_ORDENES_DOCU.ID_ORDEN%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuID_ORDEN = rcData.ID_ORDEN
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
		inuID_ORDEN in LDC_ORDENES_DOCU.ID_ORDEN%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuID_ORDEN
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuID_ORDEN in LDC_ORDENES_DOCU.ID_ORDEN%type
	)
	IS
		rcError styLDC_ORDENES_DOCU;
	BEGIN		rcError.ID_ORDEN:=inuID_ORDEN;

		Load
		(
			inuID_ORDEN
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
		inuID_ORDEN in LDC_ORDENES_DOCU.ID_ORDEN%type
	)
	IS
	BEGIN
		Load
		(
			inuID_ORDEN
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuID_ORDEN in LDC_ORDENES_DOCU.ID_ORDEN%type,
		orcRecord out nocopy styLDC_ORDENES_DOCU
	)
	IS
		rcError styLDC_ORDENES_DOCU;
	BEGIN		rcError.ID_ORDEN:=inuID_ORDEN;

		Load
		(
			inuID_ORDEN
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuID_ORDEN in LDC_ORDENES_DOCU.ID_ORDEN%type
	)
	RETURN styLDC_ORDENES_DOCU
	IS
		rcError styLDC_ORDENES_DOCU;
	BEGIN
		rcError.ID_ORDEN:=inuID_ORDEN;

		Load
		(
			inuID_ORDEN
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuID_ORDEN in LDC_ORDENES_DOCU.ID_ORDEN%type
	)
	RETURN styLDC_ORDENES_DOCU
	IS
		rcError styLDC_ORDENES_DOCU;
	BEGIN
		rcError.ID_ORDEN:=inuID_ORDEN;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuID_ORDEN
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuID_ORDEN
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_ORDENES_DOCU
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_ORDENES_DOCU
	)
	IS
		rfLDC_ORDENES_DOCU tyrfLDC_ORDENES_DOCU;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_ORDENES_DOCU.*, LDC_ORDENES_DOCU.rowid FROM LDC_ORDENES_DOCU';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_ORDENES_DOCU for sbFullQuery;

		fetch rfLDC_ORDENES_DOCU bulk collect INTO otbResult;

		close rfLDC_ORDENES_DOCU;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_ORDENES_DOCU.*, LDC_ORDENES_DOCU.rowid FROM LDC_ORDENES_DOCU';
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
		ircLDC_ORDENES_DOCU in styLDC_ORDENES_DOCU
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_ORDENES_DOCU,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_ORDENES_DOCU in styLDC_ORDENES_DOCU,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_ORDENES_DOCU.ID_ORDEN is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ID_ORDEN');
			raise ex.controlled_error;
		end if;

		insert into LDC_ORDENES_DOCU
		(
			ID_ORDEN,
			ID_PROCESO
		)
		values
		(
			ircLDC_ORDENES_DOCU.ID_ORDEN,
			ircLDC_ORDENES_DOCU.ID_PROCESO
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_ORDENES_DOCU));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_ORDENES_DOCU in out nocopy tytbLDC_ORDENES_DOCU
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_ORDENES_DOCU,blUseRowID);
		forall n in iotbLDC_ORDENES_DOCU.first..iotbLDC_ORDENES_DOCU.last
			insert into LDC_ORDENES_DOCU
			(
				ID_ORDEN,
				ID_PROCESO
			)
			values
			(
				rcRecOfTab.ID_ORDEN(n),
				rcRecOfTab.ID_PROCESO(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuID_ORDEN in LDC_ORDENES_DOCU.ID_ORDEN%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_ORDENES_DOCU;
	BEGIN
		rcError.ID_ORDEN := inuID_ORDEN;

		if inuLock=1 then
			LockByPk
			(
				inuID_ORDEN,
				rcData
			);
		end if;


		delete
		from LDC_ORDENES_DOCU
		where
       		ID_ORDEN=inuID_ORDEN;
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
		rcError  styLDC_ORDENES_DOCU;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_ORDENES_DOCU
		where
			rowid = iriRowID
		returning
			ID_ORDEN
		into
			rcError.ID_ORDEN;
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
		iotbLDC_ORDENES_DOCU in out nocopy tytbLDC_ORDENES_DOCU,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_ORDENES_DOCU;
	BEGIN
		FillRecordOfTables(iotbLDC_ORDENES_DOCU, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_ORDENES_DOCU.first .. iotbLDC_ORDENES_DOCU.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ORDENES_DOCU.first .. iotbLDC_ORDENES_DOCU.last
				delete
				from LDC_ORDENES_DOCU
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_ORDENES_DOCU.first .. iotbLDC_ORDENES_DOCU.last loop
					LockByPk
					(
						rcRecOfTab.ID_ORDEN(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ORDENES_DOCU.first .. iotbLDC_ORDENES_DOCU.last
				delete
				from LDC_ORDENES_DOCU
				where
		         	ID_ORDEN = rcRecOfTab.ID_ORDEN(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_ORDENES_DOCU in styLDC_ORDENES_DOCU,
		inuLock in number default 0
	)
	IS
		nuID_ORDEN	LDC_ORDENES_DOCU.ID_ORDEN%type;
	BEGIN
		if ircLDC_ORDENES_DOCU.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_ORDENES_DOCU.rowid,rcData);
			end if;
			update LDC_ORDENES_DOCU
			set
				ID_PROCESO = ircLDC_ORDENES_DOCU.ID_PROCESO
			where
				rowid = ircLDC_ORDENES_DOCU.rowid
			returning
				ID_ORDEN
			into
				nuID_ORDEN;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_ORDENES_DOCU.ID_ORDEN,
					rcData
				);
			end if;

			update LDC_ORDENES_DOCU
			set
				ID_PROCESO = ircLDC_ORDENES_DOCU.ID_PROCESO
			where
				ID_ORDEN = ircLDC_ORDENES_DOCU.ID_ORDEN
			returning
				ID_ORDEN
			into
				nuID_ORDEN;
		end if;
		if
			nuID_ORDEN is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_ORDENES_DOCU));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_ORDENES_DOCU in out nocopy tytbLDC_ORDENES_DOCU,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_ORDENES_DOCU;
	BEGIN
		FillRecordOfTables(iotbLDC_ORDENES_DOCU,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_ORDENES_DOCU.first .. iotbLDC_ORDENES_DOCU.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ORDENES_DOCU.first .. iotbLDC_ORDENES_DOCU.last
				update LDC_ORDENES_DOCU
				set
					ID_PROCESO = rcRecOfTab.ID_PROCESO(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_ORDENES_DOCU.first .. iotbLDC_ORDENES_DOCU.last loop
					LockByPk
					(
						rcRecOfTab.ID_ORDEN(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ORDENES_DOCU.first .. iotbLDC_ORDENES_DOCU.last
				update LDC_ORDENES_DOCU
				SET
					ID_PROCESO = rcRecOfTab.ID_PROCESO(n)
				where
					ID_ORDEN = rcRecOfTab.ID_ORDEN(n)
;
		end if;
	END;
	PROCEDURE updID_PROCESO
	(
		inuID_ORDEN in LDC_ORDENES_DOCU.ID_ORDEN%type,
		inuID_PROCESO$ in LDC_ORDENES_DOCU.ID_PROCESO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ORDENES_DOCU;
	BEGIN
		rcError.ID_ORDEN := inuID_ORDEN;
		if inuLock=1 then
			LockByPk
			(
				inuID_ORDEN,
				rcData
			);
		end if;

		update LDC_ORDENES_DOCU
		set
			ID_PROCESO = inuID_PROCESO$
		where
			ID_ORDEN = inuID_ORDEN;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ID_PROCESO:= inuID_PROCESO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetID_ORDEN
	(
		inuID_ORDEN in LDC_ORDENES_DOCU.ID_ORDEN%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ORDENES_DOCU.ID_ORDEN%type
	IS
		rcError styLDC_ORDENES_DOCU;
	BEGIN

		rcError.ID_ORDEN := inuID_ORDEN;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_ORDEN
			 )
		then
			 return(rcData.ID_ORDEN);
		end if;
		Load
		(
		 		inuID_ORDEN
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
	FUNCTION fnuGetID_PROCESO
	(
		inuID_ORDEN in LDC_ORDENES_DOCU.ID_ORDEN%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ORDENES_DOCU.ID_PROCESO%type
	IS
		rcError styLDC_ORDENES_DOCU;
	BEGIN

		rcError.ID_ORDEN := inuID_ORDEN;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_ORDEN
			 )
		then
			 return(rcData.ID_PROCESO);
		end if;
		Load
		(
		 		inuID_ORDEN
		);
		return(rcData.ID_PROCESO);
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
end DALDC_ORDENES_DOCU;
/
PROMPT Otorgando permisos de ejecucion a DALDC_ORDENES_DOCU
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_ORDENES_DOCU', 'ADM_PERSON');
END;
/