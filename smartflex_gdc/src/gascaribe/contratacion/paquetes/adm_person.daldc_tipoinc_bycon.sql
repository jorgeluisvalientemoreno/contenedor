CREATE OR REPLACE PACKAGE adm_person.DALDC_TIPOINC_BYCON
is
    /******************************************************************************************
	Autor: Harrinson Henao Camelo / Horbath
	Fecha: 26-07-2021
	Ticket: CA709
	Descripcion: 	Paquete de primer nivel para la tabla LDC_TIPOINC_BYCON

	Historia de modificaciones
	Fecha		        Autor			Descripcion
	17/06/2024          PAcosta         OSF-2780: Cambio de esquema ADM_PERSON 
    27-07-2021	        horbath			Creacion de paquete

	******************************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuID_CONTRATO in LDC_TIPOINC_BYCON.ID_CONTRATO%type
	)
	IS
		SELECT LDC_TIPOINC_BYCON.*,LDC_TIPOINC_BYCON.rowid
		FROM LDC_TIPOINC_BYCON
		WHERE
		    ID_CONTRATO = inuID_CONTRATO;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_TIPOINC_BYCON.*,LDC_TIPOINC_BYCON.rowid
		FROM LDC_TIPOINC_BYCON
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_TIPOINC_BYCON  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_TIPOINC_BYCON is table of styLDC_TIPOINC_BYCON index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_TIPOINC_BYCON;

	/* Tipos referenciando al registro */
	type tytbID_CONTRATO is table of LDC_TIPOINC_BYCON.ID_CONTRATO%type index by binary_integer;
	type tytbINCREMENT_TYPE is table of LDC_TIPOINC_BYCON.INCREMENT_TYPE%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_TIPOINC_BYCON is record
	(
		ID_CONTRATO   tytbID_CONTRATO,
		INCREMENT_TYPE   tytbINCREMENT_TYPE,
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
		inuID_CONTRATO in LDC_TIPOINC_BYCON.ID_CONTRATO%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuID_CONTRATO in LDC_TIPOINC_BYCON.ID_CONTRATO%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuID_CONTRATO in LDC_TIPOINC_BYCON.ID_CONTRATO%type
	);

	PROCEDURE getRecord
	(
		inuID_CONTRATO in LDC_TIPOINC_BYCON.ID_CONTRATO%type,
		orcRecord out nocopy styLDC_TIPOINC_BYCON
	);

	FUNCTION frcGetRcData
	(
		inuID_CONTRATO in LDC_TIPOINC_BYCON.ID_CONTRATO%type
	)
	RETURN styLDC_TIPOINC_BYCON;

	FUNCTION frcGetRcData
	RETURN styLDC_TIPOINC_BYCON;

	FUNCTION frcGetRecord
	(
		inuID_CONTRATO in LDC_TIPOINC_BYCON.ID_CONTRATO%type
	)
	RETURN styLDC_TIPOINC_BYCON;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_TIPOINC_BYCON
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_TIPOINC_BYCON in styLDC_TIPOINC_BYCON
	);

	PROCEDURE insRecord
	(
		ircLDC_TIPOINC_BYCON in styLDC_TIPOINC_BYCON,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_TIPOINC_BYCON in out nocopy tytbLDC_TIPOINC_BYCON
	);

	PROCEDURE delRecord
	(
		inuID_CONTRATO in LDC_TIPOINC_BYCON.ID_CONTRATO%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_TIPOINC_BYCON in out nocopy tytbLDC_TIPOINC_BYCON,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_TIPOINC_BYCON in styLDC_TIPOINC_BYCON,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_TIPOINC_BYCON in out nocopy tytbLDC_TIPOINC_BYCON,
		inuLock in number default 1
	);

	PROCEDURE updINCREMENT_TYPE
	(
		inuID_CONTRATO in LDC_TIPOINC_BYCON.ID_CONTRATO%type,
		isbINCREMENT_TYPE$ in LDC_TIPOINC_BYCON.INCREMENT_TYPE%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetID_CONTRATO
	(
		inuID_CONTRATO in LDC_TIPOINC_BYCON.ID_CONTRATO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPOINC_BYCON.ID_CONTRATO%type;

	FUNCTION fsbGetINCREMENT_TYPE
	(
		inuID_CONTRATO in LDC_TIPOINC_BYCON.ID_CONTRATO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPOINC_BYCON.INCREMENT_TYPE%type;


	PROCEDURE LockByPk
	(
		inuID_CONTRATO in LDC_TIPOINC_BYCON.ID_CONTRATO%type,
		orcLDC_TIPOINC_BYCON  out styLDC_TIPOINC_BYCON
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_TIPOINC_BYCON  out styLDC_TIPOINC_BYCON
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_TIPOINC_BYCON;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALDC_TIPOINC_BYCON
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_TIPOINC_BYCON';
	 cnuGeEntityId constant varchar2(30) := 5789; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuID_CONTRATO in LDC_TIPOINC_BYCON.ID_CONTRATO%type
	)
	IS
		SELECT LDC_TIPOINC_BYCON.*,LDC_TIPOINC_BYCON.rowid
		FROM LDC_TIPOINC_BYCON
		WHERE  ID_CONTRATO = inuID_CONTRATO
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_TIPOINC_BYCON.*,LDC_TIPOINC_BYCON.rowid
		FROM LDC_TIPOINC_BYCON
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_TIPOINC_BYCON is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_TIPOINC_BYCON;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_TIPOINC_BYCON default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.ID_CONTRATO);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuID_CONTRATO in LDC_TIPOINC_BYCON.ID_CONTRATO%type,
		orcLDC_TIPOINC_BYCON  out styLDC_TIPOINC_BYCON
	)
	IS
		rcError styLDC_TIPOINC_BYCON;
	BEGIN
		rcError.ID_CONTRATO := inuID_CONTRATO;

		Open cuLockRcByPk
		(
			inuID_CONTRATO
		);

		fetch cuLockRcByPk into orcLDC_TIPOINC_BYCON;
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
		orcLDC_TIPOINC_BYCON  out styLDC_TIPOINC_BYCON
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_TIPOINC_BYCON;
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
		itbLDC_TIPOINC_BYCON  in out nocopy tytbLDC_TIPOINC_BYCON
	)
	IS
	BEGIN
			rcRecOfTab.ID_CONTRATO.delete;
			rcRecOfTab.INCREMENT_TYPE.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_TIPOINC_BYCON  in out nocopy tytbLDC_TIPOINC_BYCON,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_TIPOINC_BYCON);

		for n in itbLDC_TIPOINC_BYCON.first .. itbLDC_TIPOINC_BYCON.last loop
			rcRecOfTab.ID_CONTRATO(n) := itbLDC_TIPOINC_BYCON(n).ID_CONTRATO;
			rcRecOfTab.INCREMENT_TYPE(n) := itbLDC_TIPOINC_BYCON(n).INCREMENT_TYPE;
			rcRecOfTab.row_id(n) := itbLDC_TIPOINC_BYCON(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuID_CONTRATO in LDC_TIPOINC_BYCON.ID_CONTRATO%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuID_CONTRATO
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
		inuID_CONTRATO in LDC_TIPOINC_BYCON.ID_CONTRATO%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuID_CONTRATO = rcData.ID_CONTRATO
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
		inuID_CONTRATO in LDC_TIPOINC_BYCON.ID_CONTRATO%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuID_CONTRATO
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuID_CONTRATO in LDC_TIPOINC_BYCON.ID_CONTRATO%type
	)
	IS
		rcError styLDC_TIPOINC_BYCON;
	BEGIN		rcError.ID_CONTRATO:=inuID_CONTRATO;

		Load
		(
			inuID_CONTRATO
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
		inuID_CONTRATO in LDC_TIPOINC_BYCON.ID_CONTRATO%type
	)
	IS
	BEGIN
		Load
		(
			inuID_CONTRATO
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuID_CONTRATO in LDC_TIPOINC_BYCON.ID_CONTRATO%type,
		orcRecord out nocopy styLDC_TIPOINC_BYCON
	)
	IS
		rcError styLDC_TIPOINC_BYCON;
	BEGIN		rcError.ID_CONTRATO:=inuID_CONTRATO;

		Load
		(
			inuID_CONTRATO
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuID_CONTRATO in LDC_TIPOINC_BYCON.ID_CONTRATO%type
	)
	RETURN styLDC_TIPOINC_BYCON
	IS
		rcError styLDC_TIPOINC_BYCON;
	BEGIN
		rcError.ID_CONTRATO:=inuID_CONTRATO;

		Load
		(
			inuID_CONTRATO
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuID_CONTRATO in LDC_TIPOINC_BYCON.ID_CONTRATO%type
	)
	RETURN styLDC_TIPOINC_BYCON
	IS
		rcError styLDC_TIPOINC_BYCON;
	BEGIN
		rcError.ID_CONTRATO:=inuID_CONTRATO;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuID_CONTRATO
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuID_CONTRATO
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_TIPOINC_BYCON
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_TIPOINC_BYCON
	)
	IS
		rfLDC_TIPOINC_BYCON tyrfLDC_TIPOINC_BYCON;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_TIPOINC_BYCON.*, LDC_TIPOINC_BYCON.rowid FROM LDC_TIPOINC_BYCON';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_TIPOINC_BYCON for sbFullQuery;

		fetch rfLDC_TIPOINC_BYCON bulk collect INTO otbResult;

		close rfLDC_TIPOINC_BYCON;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_TIPOINC_BYCON.*, LDC_TIPOINC_BYCON.rowid FROM LDC_TIPOINC_BYCON';
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
		ircLDC_TIPOINC_BYCON in styLDC_TIPOINC_BYCON
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_TIPOINC_BYCON,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_TIPOINC_BYCON in styLDC_TIPOINC_BYCON,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_TIPOINC_BYCON.ID_CONTRATO is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ID_CONTRATO');
			raise ex.controlled_error;
		end if;

		insert into LDC_TIPOINC_BYCON
		(
			ID_CONTRATO,
			INCREMENT_TYPE
		)
		values
		(
			ircLDC_TIPOINC_BYCON.ID_CONTRATO,
			ircLDC_TIPOINC_BYCON.INCREMENT_TYPE
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_TIPOINC_BYCON));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_TIPOINC_BYCON in out nocopy tytbLDC_TIPOINC_BYCON
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_TIPOINC_BYCON,blUseRowID);
		forall n in iotbLDC_TIPOINC_BYCON.first..iotbLDC_TIPOINC_BYCON.last
			insert into LDC_TIPOINC_BYCON
			(
				ID_CONTRATO,
				INCREMENT_TYPE
			)
			values
			(
				rcRecOfTab.ID_CONTRATO(n),
				rcRecOfTab.INCREMENT_TYPE(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuID_CONTRATO in LDC_TIPOINC_BYCON.ID_CONTRATO%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_TIPOINC_BYCON;
	BEGIN
		rcError.ID_CONTRATO := inuID_CONTRATO;

		if inuLock=1 then
			LockByPk
			(
				inuID_CONTRATO,
				rcData
			);
		end if;


		delete
		from LDC_TIPOINC_BYCON
		where
       		ID_CONTRATO=inuID_CONTRATO;
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
		rcError  styLDC_TIPOINC_BYCON;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_TIPOINC_BYCON
		where
			rowid = iriRowID
		returning
			ID_CONTRATO
		into
			rcError.ID_CONTRATO;
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
		iotbLDC_TIPOINC_BYCON in out nocopy tytbLDC_TIPOINC_BYCON,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_TIPOINC_BYCON;
	BEGIN
		FillRecordOfTables(iotbLDC_TIPOINC_BYCON, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_TIPOINC_BYCON.first .. iotbLDC_TIPOINC_BYCON.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_TIPOINC_BYCON.first .. iotbLDC_TIPOINC_BYCON.last
				delete
				from LDC_TIPOINC_BYCON
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_TIPOINC_BYCON.first .. iotbLDC_TIPOINC_BYCON.last loop
					LockByPk
					(
						rcRecOfTab.ID_CONTRATO(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_TIPOINC_BYCON.first .. iotbLDC_TIPOINC_BYCON.last
				delete
				from LDC_TIPOINC_BYCON
				where
		         	ID_CONTRATO = rcRecOfTab.ID_CONTRATO(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_TIPOINC_BYCON in styLDC_TIPOINC_BYCON,
		inuLock in number default 0
	)
	IS
		nuID_CONTRATO	LDC_TIPOINC_BYCON.ID_CONTRATO%type;
	BEGIN
		if ircLDC_TIPOINC_BYCON.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_TIPOINC_BYCON.rowid,rcData);
			end if;
			update LDC_TIPOINC_BYCON
			set
				INCREMENT_TYPE = ircLDC_TIPOINC_BYCON.INCREMENT_TYPE
			where
				rowid = ircLDC_TIPOINC_BYCON.rowid
			returning
				ID_CONTRATO
			into
				nuID_CONTRATO;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_TIPOINC_BYCON.ID_CONTRATO,
					rcData
				);
			end if;

			update LDC_TIPOINC_BYCON
			set
				INCREMENT_TYPE = ircLDC_TIPOINC_BYCON.INCREMENT_TYPE
			where
				ID_CONTRATO = ircLDC_TIPOINC_BYCON.ID_CONTRATO
			returning
				ID_CONTRATO
			into
				nuID_CONTRATO;
		end if;
		if
			nuID_CONTRATO is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_TIPOINC_BYCON));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_TIPOINC_BYCON in out nocopy tytbLDC_TIPOINC_BYCON,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_TIPOINC_BYCON;
	BEGIN
		FillRecordOfTables(iotbLDC_TIPOINC_BYCON,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_TIPOINC_BYCON.first .. iotbLDC_TIPOINC_BYCON.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_TIPOINC_BYCON.first .. iotbLDC_TIPOINC_BYCON.last
				update LDC_TIPOINC_BYCON
				set
					INCREMENT_TYPE = rcRecOfTab.INCREMENT_TYPE(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_TIPOINC_BYCON.first .. iotbLDC_TIPOINC_BYCON.last loop
					LockByPk
					(
						rcRecOfTab.ID_CONTRATO(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_TIPOINC_BYCON.first .. iotbLDC_TIPOINC_BYCON.last
				update LDC_TIPOINC_BYCON
				SET
					INCREMENT_TYPE = rcRecOfTab.INCREMENT_TYPE(n)
				where
					ID_CONTRATO = rcRecOfTab.ID_CONTRATO(n)
;
		end if;
	END;
	PROCEDURE updINCREMENT_TYPE
	(
		inuID_CONTRATO in LDC_TIPOINC_BYCON.ID_CONTRATO%type,
		isbINCREMENT_TYPE$ in LDC_TIPOINC_BYCON.INCREMENT_TYPE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_TIPOINC_BYCON;
	BEGIN
		rcError.ID_CONTRATO := inuID_CONTRATO;
		if inuLock=1 then
			LockByPk
			(
				inuID_CONTRATO,
				rcData
			);
		end if;

		update LDC_TIPOINC_BYCON
		set
			INCREMENT_TYPE = isbINCREMENT_TYPE$
		where
			ID_CONTRATO = inuID_CONTRATO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.INCREMENT_TYPE:= isbINCREMENT_TYPE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetID_CONTRATO
	(
		inuID_CONTRATO in LDC_TIPOINC_BYCON.ID_CONTRATO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPOINC_BYCON.ID_CONTRATO%type
	IS
		rcError styLDC_TIPOINC_BYCON;
	BEGIN

		rcError.ID_CONTRATO := inuID_CONTRATO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_CONTRATO
			 )
		then
			 return(rcData.ID_CONTRATO);
		end if;
		Load
		(
		 		inuID_CONTRATO
		);
		return(rcData.ID_CONTRATO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetINCREMENT_TYPE
	(
		inuID_CONTRATO in LDC_TIPOINC_BYCON.ID_CONTRATO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPOINC_BYCON.INCREMENT_TYPE%type
	IS
		rcError styLDC_TIPOINC_BYCON;
	BEGIN

		rcError.ID_CONTRATO := inuID_CONTRATO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_CONTRATO
			 )
		then
			 return(rcData.INCREMENT_TYPE);
		end if;
		Load
		(
		 		inuID_CONTRATO
		);
		return(rcData.INCREMENT_TYPE);
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
end DALDC_TIPOINC_BYCON;
/
PROMPT Otorgando permisos de ejecucion a DALDC_TIPOINC_BYCON
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_TIPOINC_BYCON', 'ADM_PERSON');
END;
/