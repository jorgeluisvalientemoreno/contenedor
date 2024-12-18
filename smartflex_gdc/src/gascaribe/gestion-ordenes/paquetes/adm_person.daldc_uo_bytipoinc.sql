CREATE OR REPLACE PACKAGE ADM_PERSON.DALDC_UO_BYTIPOINC
is
    /******************************************************************************************
	Autor: horbath / Horbath
	Fecha: 26-07-2021
	Ticket: CA709
	Descripcion: 	Paquete de primer nivel para la tabla LDC_UO_BYTIPOINC

	Historia de modificaciones
	Fecha		Autor			Descripcion
	27-07-2021	horbath			Creacion de paquete
    05/06/2024  PAcosta         OSF-2777: Cambio de esquema ADM_PERSON  
	******************************************************************************************/
	
    /* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuID_CONTRATO in LDC_UO_BYTIPOINC.ID_CONTRATO%type,
		inuOPERATING_UNIT_ID in LDC_UO_BYTIPOINC.OPERATING_UNIT_ID%type
	)
	IS
		SELECT LDC_UO_BYTIPOINC.*,LDC_UO_BYTIPOINC.rowid
		FROM LDC_UO_BYTIPOINC
		WHERE
		    ID_CONTRATO = inuID_CONTRATO
		AND	OPERATING_UNIT_ID = inuOPERATING_UNIT_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_UO_BYTIPOINC.*,LDC_UO_BYTIPOINC.rowid
		FROM LDC_UO_BYTIPOINC
		WHERE
			rowId = irirowid;

	/* Subtipos */
	subtype styLDC_UO_BYTIPOINC  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_UO_BYTIPOINC is table of styLDC_UO_BYTIPOINC index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_UO_BYTIPOINC;

	/* Tipos referenciando al registro */
	type tytbID_CONTRATO is table of LDC_UO_BYTIPOINC.ID_CONTRATO%type index by binary_integer;
	type tytbOPERATING_UNIT_ID is table of LDC_UO_BYTIPOINC.OPERATING_UNIT_ID%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_UO_BYTIPOINC is record
	(
		ID_CONTRATO   tytbID_CONTRATO,
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
		inuID_CONTRATO in LDC_UO_BYTIPOINC.ID_CONTRATO%type,
        inuOPERATING_UNIT_ID in LDC_UO_BYTIPOINC.OPERATING_UNIT_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuID_CONTRATO in LDC_UO_BYTIPOINC.ID_CONTRATO%type,
		inuOPERATING_UNIT_ID in LDC_UO_BYTIPOINC.OPERATING_UNIT_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuID_CONTRATO in LDC_UO_BYTIPOINC.ID_CONTRATO%type,
		inuOPERATING_UNIT_ID in LDC_UO_BYTIPOINC.OPERATING_UNIT_ID%type
	);

	PROCEDURE getRecord
	(
		inuID_CONTRATO in LDC_UO_BYTIPOINC.ID_CONTRATO%type,
        inuOPERATING_UNIT_ID in LDC_UO_BYTIPOINC.OPERATING_UNIT_ID%type,
		orcRecord out nocopy styLDC_UO_BYTIPOINC
	);

	FUNCTION frcGetRcData
	(
		inuID_CONTRATO in LDC_UO_BYTIPOINC.ID_CONTRATO%type,
		inuOPERATING_UNIT_ID in LDC_UO_BYTIPOINC.OPERATING_UNIT_ID%type
	)
	RETURN styLDC_UO_BYTIPOINC;

	FUNCTION frcGetRcData
	RETURN styLDC_UO_BYTIPOINC;

	FUNCTION frcGetRecord
	(
		inuID_CONTRATO in LDC_UO_BYTIPOINC.ID_CONTRATO%type,
		inuOPERATING_UNIT_ID in LDC_UO_BYTIPOINC.OPERATING_UNIT_ID%type
	)
	RETURN styLDC_UO_BYTIPOINC;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_UO_BYTIPOINC
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_UO_BYTIPOINC in styLDC_UO_BYTIPOINC
	);

	PROCEDURE insRecord
	(
		ircLDC_UO_BYTIPOINC in styLDC_UO_BYTIPOINC,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_UO_BYTIPOINC in out nocopy tytbLDC_UO_BYTIPOINC
	);

	PROCEDURE delRecord
	(
		inuID_CONTRATO in LDC_UO_BYTIPOINC.ID_CONTRATO%type,
		inuOPERATING_UNIT_ID in LDC_UO_BYTIPOINC.OPERATING_UNIT_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_UO_BYTIPOINC in out nocopy tytbLDC_UO_BYTIPOINC,
		inuLock in number default 1
	);

	PROCEDURE LockByPk
	(
		inuID_CONTRATO in LDC_UO_BYTIPOINC.ID_CONTRATO%type,
		inuOPERATING_UNIT_ID in LDC_UO_BYTIPOINC.OPERATING_UNIT_ID%type,
		orcLDC_UO_BYTIPOINC  out styLDC_UO_BYTIPOINC
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_UO_BYTIPOINC  out styLDC_UO_BYTIPOINC
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_UO_BYTIPOINC;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALDC_UO_BYTIPOINC
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'CA709';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_UO_BYTIPOINC';
	 cnuGeEntityId constant varchar2(30) := 5790; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuID_CONTRATO in LDC_UO_BYTIPOINC.ID_CONTRATO%type,
		inuOPERATING_UNIT_ID in LDC_UO_BYTIPOINC.OPERATING_UNIT_ID%type
	)
	IS
		SELECT LDC_UO_BYTIPOINC.*,LDC_UO_BYTIPOINC.rowid
		FROM LDC_UO_BYTIPOINC
		WHERE  ID_CONTRATO = inuID_CONTRATO
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_UO_BYTIPOINC.*,LDC_UO_BYTIPOINC.rowid
		FROM LDC_UO_BYTIPOINC
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_UO_BYTIPOINC is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_UO_BYTIPOINC;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_UO_BYTIPOINC default rcData )
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
		inuID_CONTRATO in LDC_UO_BYTIPOINC.ID_CONTRATO%type,
		inuOPERATING_UNIT_ID in LDC_UO_BYTIPOINC.OPERATING_UNIT_ID%type,
		orcLDC_UO_BYTIPOINC  out styLDC_UO_BYTIPOINC
	)
	IS
		rcError styLDC_UO_BYTIPOINC;
	BEGIN
		rcError.ID_CONTRATO := inuID_CONTRATO;

		Open cuLockRcByPk
		(
			inuID_CONTRATO,
			inuOPERATING_UNIT_ID
		);

		fetch cuLockRcByPk into orcLDC_UO_BYTIPOINC;
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
		orcLDC_UO_BYTIPOINC  out styLDC_UO_BYTIPOINC
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_UO_BYTIPOINC;
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
		itbLDC_UO_BYTIPOINC  in out nocopy tytbLDC_UO_BYTIPOINC
	)
	IS
	BEGIN
			rcRecOfTab.ID_CONTRATO.delete;
			rcRecOfTab.OPERATING_UNIT_ID.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_UO_BYTIPOINC  in out nocopy tytbLDC_UO_BYTIPOINC,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_UO_BYTIPOINC);

		for n in itbLDC_UO_BYTIPOINC.first .. itbLDC_UO_BYTIPOINC.last loop
			rcRecOfTab.ID_CONTRATO(n) := itbLDC_UO_BYTIPOINC(n).ID_CONTRATO;
			rcRecOfTab.OPERATING_UNIT_ID(n) := itbLDC_UO_BYTIPOINC(n).OPERATING_UNIT_ID;
			rcRecOfTab.row_id(n) := itbLDC_UO_BYTIPOINC(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuID_CONTRATO in LDC_UO_BYTIPOINC.ID_CONTRATO%type,
		inuOPERATING_UNIT_ID in LDC_UO_BYTIPOINC.OPERATING_UNIT_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuID_CONTRATO,
			inuOPERATING_UNIT_ID
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
		inuID_CONTRATO in LDC_UO_BYTIPOINC.ID_CONTRATO%type,
		inuOPERATING_UNIT_ID in LDC_UO_BYTIPOINC.OPERATING_UNIT_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuID_CONTRATO = rcData.ID_CONTRATO AND inuOPERATING_UNIT_ID = rcData.OPERATING_UNIT_ID
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
		inuID_CONTRATO in LDC_UO_BYTIPOINC.ID_CONTRATO%type,
		inuOPERATING_UNIT_ID in LDC_UO_BYTIPOINC.OPERATING_UNIT_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuID_CONTRATO,
			inuOPERATING_UNIT_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;

	PROCEDURE AccKey
	(
		inuID_CONTRATO in LDC_UO_BYTIPOINC.ID_CONTRATO%type,
		inuOPERATING_UNIT_ID in LDC_UO_BYTIPOINC.OPERATING_UNIT_ID%type
	)
	IS
		rcError styLDC_UO_BYTIPOINC;
	BEGIN		rcError.ID_CONTRATO:=inuID_CONTRATO;

		Load
		(
			inuID_CONTRATO,
			inuOPERATING_UNIT_ID
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
		inuID_CONTRATO in LDC_UO_BYTIPOINC.ID_CONTRATO%type,
		inuOPERATING_UNIT_ID in LDC_UO_BYTIPOINC.OPERATING_UNIT_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuID_CONTRATO,
			inuOPERATING_UNIT_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuID_CONTRATO in LDC_UO_BYTIPOINC.ID_CONTRATO%type,
		inuOPERATING_UNIT_ID in LDC_UO_BYTIPOINC.OPERATING_UNIT_ID%type,
		orcRecord out nocopy styLDC_UO_BYTIPOINC
	)
	IS
		rcError styLDC_UO_BYTIPOINC;
	BEGIN

		rcError.ID_CONTRATO:=inuID_CONTRATO;
		rcError.OPERATING_UNIT_ID := inuOPERATING_UNIT_ID;
		Load
		(
			inuID_CONTRATO,
			inuOPERATING_UNIT_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuID_CONTRATO in LDC_UO_BYTIPOINC.ID_CONTRATO%type,
		inuOPERATING_UNIT_ID in LDC_UO_BYTIPOINC.OPERATING_UNIT_ID%type
	)
	RETURN styLDC_UO_BYTIPOINC
	IS
		rcError styLDC_UO_BYTIPOINC;
	BEGIN
		rcError.ID_CONTRATO:=inuID_CONTRATO;
		rcError.OPERATING_UNIT_ID := inuOPERATING_UNIT_ID;
		Load
		(
			inuID_CONTRATO,
			inuOPERATING_UNIT_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuID_CONTRATO in LDC_UO_BYTIPOINC.ID_CONTRATO%type,
		inuOPERATING_UNIT_ID in LDC_UO_BYTIPOINC.OPERATING_UNIT_ID%type
	)
	RETURN styLDC_UO_BYTIPOINC
	IS
		rcError styLDC_UO_BYTIPOINC;
	BEGIN
		rcError.ID_CONTRATO:=inuID_CONTRATO;
		rcError.OPERATING_UNIT_ID := inuOPERATING_UNIT_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuID_CONTRATO,
				inuOPERATING_UNIT_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuID_CONTRATO,
			inuOPERATING_UNIT_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_UO_BYTIPOINC
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_UO_BYTIPOINC
	)
	IS
		rfLDC_UO_BYTIPOINC tyrfLDC_UO_BYTIPOINC;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_UO_BYTIPOINC.*, LDC_UO_BYTIPOINC.rowid FROM LDC_UO_BYTIPOINC';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_UO_BYTIPOINC for sbFullQuery;

		fetch rfLDC_UO_BYTIPOINC bulk collect INTO otbResult;

		close rfLDC_UO_BYTIPOINC;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_UO_BYTIPOINC.*, LDC_UO_BYTIPOINC.rowid FROM LDC_UO_BYTIPOINC';
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
		ircLDC_UO_BYTIPOINC in styLDC_UO_BYTIPOINC
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_UO_BYTIPOINC,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_UO_BYTIPOINC in styLDC_UO_BYTIPOINC,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_UO_BYTIPOINC.ID_CONTRATO is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ID_CONTRATO');
			raise ex.controlled_error;
		end if;

		if ircLDC_UO_BYTIPOINC.OPERATING_UNIT_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|OPERATING_UNIT_ID');
			raise ex.controlled_error;
		end if;

		insert into LDC_UO_BYTIPOINC
		(
			ID_CONTRATO,
			OPERATING_UNIT_ID
		)
		values
		(
			ircLDC_UO_BYTIPOINC.ID_CONTRATO,
			ircLDC_UO_BYTIPOINC.OPERATING_UNIT_ID
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_UO_BYTIPOINC));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_UO_BYTIPOINC in out nocopy tytbLDC_UO_BYTIPOINC
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_UO_BYTIPOINC,blUseRowID);
		forall n in iotbLDC_UO_BYTIPOINC.first..iotbLDC_UO_BYTIPOINC.last
			insert into LDC_UO_BYTIPOINC
			(
				ID_CONTRATO,
				OPERATING_UNIT_ID
			)
			values
			(
				rcRecOfTab.ID_CONTRATO(n),
				rcRecOfTab.OPERATING_UNIT_ID(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuID_CONTRATO in LDC_UO_BYTIPOINC.ID_CONTRATO%type,
		inuOPERATING_UNIT_ID in LDC_UO_BYTIPOINC.OPERATING_UNIT_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_UO_BYTIPOINC;
	BEGIN
		rcError.ID_CONTRATO := inuID_CONTRATO;
		rcError.OPERATING_UNIT_ID := inuOPERATING_UNIT_ID;
		if inuLock=1 then
			LockByPk
			(
				inuID_CONTRATO,
				inuOPERATING_UNIT_ID,
				rcData
			);
		end if;


		delete
		from LDC_UO_BYTIPOINC
		where
       		ID_CONTRATO=inuID_CONTRATO
		and OPERATING_UNIT_ID = inuOPERATING_UNIT_ID;
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
		rcError  styLDC_UO_BYTIPOINC;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_UO_BYTIPOINC
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
		iotbLDC_UO_BYTIPOINC in out nocopy tytbLDC_UO_BYTIPOINC,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_UO_BYTIPOINC;
	BEGIN
		FillRecordOfTables(iotbLDC_UO_BYTIPOINC, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_UO_BYTIPOINC.first .. iotbLDC_UO_BYTIPOINC.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_UO_BYTIPOINC.first .. iotbLDC_UO_BYTIPOINC.last
				delete
				from LDC_UO_BYTIPOINC
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_UO_BYTIPOINC.first .. iotbLDC_UO_BYTIPOINC.last loop
					LockByPk
					(
						rcRecOfTab.ID_CONTRATO(n),
						rcRecOfTab.OPERATING_UNIT_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_UO_BYTIPOINC.first .. iotbLDC_UO_BYTIPOINC.last
				delete
				from LDC_UO_BYTIPOINC
				where
		         	ID_CONTRATO = rcRecOfTab.ID_CONTRATO(n)
				and OPERATING_UNIT_ID = rcRecOfTab.OPERATING_UNIT_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
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
end DALDC_UO_BYTIPOINC;
/
PROMPT Otorgando permisos de ejecucion a DALDC_UO_BYTIPOINC
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_UO_BYTIPOINC', 'ADM_PERSON');
END;
/