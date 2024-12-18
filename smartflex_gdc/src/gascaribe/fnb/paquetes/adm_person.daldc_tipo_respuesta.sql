CREATE OR REPLACE PACKAGE ADM_PERSON.DALDC_TIPO_RESPUESTA
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
    06/06/2024              PAcosta         OSF-2778: Cambio de esquema ADM_PERSON                              
    ****************************************************************/    
    
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuLDC_TIPO_RESPUESTA_ID in LDC_TIPO_RESPUESTA.LDC_TIPO_RESPUESTA_ID%type
	)
	IS
		SELECT LDC_TIPO_RESPUESTA.*,LDC_TIPO_RESPUESTA.rowid
		FROM LDC_TIPO_RESPUESTA
		WHERE
		    LDC_TIPO_RESPUESTA_ID = inuLDC_TIPO_RESPUESTA_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_TIPO_RESPUESTA.*,LDC_TIPO_RESPUESTA.rowid
		FROM LDC_TIPO_RESPUESTA
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_TIPO_RESPUESTA  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_TIPO_RESPUESTA is table of styLDC_TIPO_RESPUESTA index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_TIPO_RESPUESTA;

	/* Tipos referenciando al registro */
	type tytbLDC_TIPO_RESPUESTA_ID is table of LDC_TIPO_RESPUESTA.LDC_TIPO_RESPUESTA_ID%type index by binary_integer;
	type tytbSSPD_RESPUESTA is table of LDC_TIPO_RESPUESTA.SSPD_RESPUESTA%type index by binary_integer;
	type tytbDESCRIPTION is table of LDC_TIPO_RESPUESTA.DESCRIPTION%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_TIPO_RESPUESTA is record
	(
		LDC_TIPO_RESPUESTA_ID   tytbLDC_TIPO_RESPUESTA_ID,
		SSPD_RESPUESTA   tytbSSPD_RESPUESTA,
		DESCRIPTION   tytbDESCRIPTION,
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
		inuLDC_TIPO_RESPUESTA_ID in LDC_TIPO_RESPUESTA.LDC_TIPO_RESPUESTA_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuLDC_TIPO_RESPUESTA_ID in LDC_TIPO_RESPUESTA.LDC_TIPO_RESPUESTA_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuLDC_TIPO_RESPUESTA_ID in LDC_TIPO_RESPUESTA.LDC_TIPO_RESPUESTA_ID%type
	);

	PROCEDURE getRecord
	(
		inuLDC_TIPO_RESPUESTA_ID in LDC_TIPO_RESPUESTA.LDC_TIPO_RESPUESTA_ID%type,
		orcRecord out nocopy styLDC_TIPO_RESPUESTA
	);

	FUNCTION frcGetRcData
	(
		inuLDC_TIPO_RESPUESTA_ID in LDC_TIPO_RESPUESTA.LDC_TIPO_RESPUESTA_ID%type
	)
	RETURN styLDC_TIPO_RESPUESTA;

	FUNCTION frcGetRcData
	RETURN styLDC_TIPO_RESPUESTA;

	FUNCTION frcGetRecord
	(
		inuLDC_TIPO_RESPUESTA_ID in LDC_TIPO_RESPUESTA.LDC_TIPO_RESPUESTA_ID%type
	)
	RETURN styLDC_TIPO_RESPUESTA;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_TIPO_RESPUESTA
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_TIPO_RESPUESTA in styLDC_TIPO_RESPUESTA
	);

	PROCEDURE insRecord
	(
		ircLDC_TIPO_RESPUESTA in styLDC_TIPO_RESPUESTA,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_TIPO_RESPUESTA in out nocopy tytbLDC_TIPO_RESPUESTA
	);

	PROCEDURE delRecord
	(
		inuLDC_TIPO_RESPUESTA_ID in LDC_TIPO_RESPUESTA.LDC_TIPO_RESPUESTA_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_TIPO_RESPUESTA in out nocopy tytbLDC_TIPO_RESPUESTA,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_TIPO_RESPUESTA in styLDC_TIPO_RESPUESTA,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_TIPO_RESPUESTA in out nocopy tytbLDC_TIPO_RESPUESTA,
		inuLock in number default 1
	);

	PROCEDURE updSSPD_RESPUESTA
	(
		inuLDC_TIPO_RESPUESTA_ID in LDC_TIPO_RESPUESTA.LDC_TIPO_RESPUESTA_ID%type,
		inuSSPD_RESPUESTA$ in LDC_TIPO_RESPUESTA.SSPD_RESPUESTA%type,
		inuLock in number default 0
	);

	PROCEDURE updDESCRIPTION
	(
		inuLDC_TIPO_RESPUESTA_ID in LDC_TIPO_RESPUESTA.LDC_TIPO_RESPUESTA_ID%type,
		isbDESCRIPTION$ in LDC_TIPO_RESPUESTA.DESCRIPTION%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetLDC_TIPO_RESPUESTA_ID
	(
		inuLDC_TIPO_RESPUESTA_ID in LDC_TIPO_RESPUESTA.LDC_TIPO_RESPUESTA_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPO_RESPUESTA.LDC_TIPO_RESPUESTA_ID%type;

	FUNCTION fnuGetSSPD_RESPUESTA
	(
		inuLDC_TIPO_RESPUESTA_ID in LDC_TIPO_RESPUESTA.LDC_TIPO_RESPUESTA_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPO_RESPUESTA.SSPD_RESPUESTA%type;

	FUNCTION fsbGetDESCRIPTION
	(
		inuLDC_TIPO_RESPUESTA_ID in LDC_TIPO_RESPUESTA.LDC_TIPO_RESPUESTA_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPO_RESPUESTA.DESCRIPTION%type;


	PROCEDURE LockByPk
	(
		inuLDC_TIPO_RESPUESTA_ID in LDC_TIPO_RESPUESTA.LDC_TIPO_RESPUESTA_ID%type,
		orcLDC_TIPO_RESPUESTA  out styLDC_TIPO_RESPUESTA
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_TIPO_RESPUESTA  out styLDC_TIPO_RESPUESTA
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_TIPO_RESPUESTA;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALDC_TIPO_RESPUESTA
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_TIPO_RESPUESTA';
	 cnuGeEntityId constant varchar2(30) := 8853; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuLDC_TIPO_RESPUESTA_ID in LDC_TIPO_RESPUESTA.LDC_TIPO_RESPUESTA_ID%type
	)
	IS
		SELECT LDC_TIPO_RESPUESTA.*,LDC_TIPO_RESPUESTA.rowid
		FROM LDC_TIPO_RESPUESTA
		WHERE  LDC_TIPO_RESPUESTA_ID = inuLDC_TIPO_RESPUESTA_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_TIPO_RESPUESTA.*,LDC_TIPO_RESPUESTA.rowid
		FROM LDC_TIPO_RESPUESTA
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_TIPO_RESPUESTA is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_TIPO_RESPUESTA;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_TIPO_RESPUESTA default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.LDC_TIPO_RESPUESTA_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuLDC_TIPO_RESPUESTA_ID in LDC_TIPO_RESPUESTA.LDC_TIPO_RESPUESTA_ID%type,
		orcLDC_TIPO_RESPUESTA  out styLDC_TIPO_RESPUESTA
	)
	IS
		rcError styLDC_TIPO_RESPUESTA;
	BEGIN
		rcError.LDC_TIPO_RESPUESTA_ID := inuLDC_TIPO_RESPUESTA_ID;

		Open cuLockRcByPk
		(
			inuLDC_TIPO_RESPUESTA_ID
		);

		fetch cuLockRcByPk into orcLDC_TIPO_RESPUESTA;
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
		orcLDC_TIPO_RESPUESTA  out styLDC_TIPO_RESPUESTA
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_TIPO_RESPUESTA;
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
		itbLDC_TIPO_RESPUESTA  in out nocopy tytbLDC_TIPO_RESPUESTA
	)
	IS
	BEGIN
			rcRecOfTab.LDC_TIPO_RESPUESTA_ID.delete;
			rcRecOfTab.SSPD_RESPUESTA.delete;
			rcRecOfTab.DESCRIPTION.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_TIPO_RESPUESTA  in out nocopy tytbLDC_TIPO_RESPUESTA,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_TIPO_RESPUESTA);

		for n in itbLDC_TIPO_RESPUESTA.first .. itbLDC_TIPO_RESPUESTA.last loop
			rcRecOfTab.LDC_TIPO_RESPUESTA_ID(n) := itbLDC_TIPO_RESPUESTA(n).LDC_TIPO_RESPUESTA_ID;
			rcRecOfTab.SSPD_RESPUESTA(n) := itbLDC_TIPO_RESPUESTA(n).SSPD_RESPUESTA;
			rcRecOfTab.DESCRIPTION(n) := itbLDC_TIPO_RESPUESTA(n).DESCRIPTION;
			rcRecOfTab.row_id(n) := itbLDC_TIPO_RESPUESTA(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuLDC_TIPO_RESPUESTA_ID in LDC_TIPO_RESPUESTA.LDC_TIPO_RESPUESTA_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuLDC_TIPO_RESPUESTA_ID
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
		inuLDC_TIPO_RESPUESTA_ID in LDC_TIPO_RESPUESTA.LDC_TIPO_RESPUESTA_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuLDC_TIPO_RESPUESTA_ID = rcData.LDC_TIPO_RESPUESTA_ID
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
		inuLDC_TIPO_RESPUESTA_ID in LDC_TIPO_RESPUESTA.LDC_TIPO_RESPUESTA_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuLDC_TIPO_RESPUESTA_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuLDC_TIPO_RESPUESTA_ID in LDC_TIPO_RESPUESTA.LDC_TIPO_RESPUESTA_ID%type
	)
	IS
		rcError styLDC_TIPO_RESPUESTA;
	BEGIN		rcError.LDC_TIPO_RESPUESTA_ID:=inuLDC_TIPO_RESPUESTA_ID;

		Load
		(
			inuLDC_TIPO_RESPUESTA_ID
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
		inuLDC_TIPO_RESPUESTA_ID in LDC_TIPO_RESPUESTA.LDC_TIPO_RESPUESTA_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuLDC_TIPO_RESPUESTA_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuLDC_TIPO_RESPUESTA_ID in LDC_TIPO_RESPUESTA.LDC_TIPO_RESPUESTA_ID%type,
		orcRecord out nocopy styLDC_TIPO_RESPUESTA
	)
	IS
		rcError styLDC_TIPO_RESPUESTA;
	BEGIN		rcError.LDC_TIPO_RESPUESTA_ID:=inuLDC_TIPO_RESPUESTA_ID;

		Load
		(
			inuLDC_TIPO_RESPUESTA_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuLDC_TIPO_RESPUESTA_ID in LDC_TIPO_RESPUESTA.LDC_TIPO_RESPUESTA_ID%type
	)
	RETURN styLDC_TIPO_RESPUESTA
	IS
		rcError styLDC_TIPO_RESPUESTA;
	BEGIN
		rcError.LDC_TIPO_RESPUESTA_ID:=inuLDC_TIPO_RESPUESTA_ID;

		Load
		(
			inuLDC_TIPO_RESPUESTA_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuLDC_TIPO_RESPUESTA_ID in LDC_TIPO_RESPUESTA.LDC_TIPO_RESPUESTA_ID%type
	)
	RETURN styLDC_TIPO_RESPUESTA
	IS
		rcError styLDC_TIPO_RESPUESTA;
	BEGIN
		rcError.LDC_TIPO_RESPUESTA_ID:=inuLDC_TIPO_RESPUESTA_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuLDC_TIPO_RESPUESTA_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuLDC_TIPO_RESPUESTA_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_TIPO_RESPUESTA
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_TIPO_RESPUESTA
	)
	IS
		rfLDC_TIPO_RESPUESTA tyrfLDC_TIPO_RESPUESTA;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_TIPO_RESPUESTA.*, LDC_TIPO_RESPUESTA.rowid FROM LDC_TIPO_RESPUESTA';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_TIPO_RESPUESTA for sbFullQuery;

		fetch rfLDC_TIPO_RESPUESTA bulk collect INTO otbResult;

		close rfLDC_TIPO_RESPUESTA;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_TIPO_RESPUESTA.*, LDC_TIPO_RESPUESTA.rowid FROM LDC_TIPO_RESPUESTA';
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
		ircLDC_TIPO_RESPUESTA in styLDC_TIPO_RESPUESTA
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_TIPO_RESPUESTA,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_TIPO_RESPUESTA in styLDC_TIPO_RESPUESTA,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_TIPO_RESPUESTA.LDC_TIPO_RESPUESTA_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|LDC_TIPO_RESPUESTA_ID');
			raise ex.controlled_error;
		end if;

		insert into LDC_TIPO_RESPUESTA
		(
			LDC_TIPO_RESPUESTA_ID,
			SSPD_RESPUESTA,
			DESCRIPTION
		)
		values
		(
			ircLDC_TIPO_RESPUESTA.LDC_TIPO_RESPUESTA_ID,
			ircLDC_TIPO_RESPUESTA.SSPD_RESPUESTA,
			ircLDC_TIPO_RESPUESTA.DESCRIPTION
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_TIPO_RESPUESTA));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_TIPO_RESPUESTA in out nocopy tytbLDC_TIPO_RESPUESTA
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_TIPO_RESPUESTA,blUseRowID);
		forall n in iotbLDC_TIPO_RESPUESTA.first..iotbLDC_TIPO_RESPUESTA.last
			insert into LDC_TIPO_RESPUESTA
			(
				LDC_TIPO_RESPUESTA_ID,
				SSPD_RESPUESTA,
				DESCRIPTION
			)
			values
			(
				rcRecOfTab.LDC_TIPO_RESPUESTA_ID(n),
				rcRecOfTab.SSPD_RESPUESTA(n),
				rcRecOfTab.DESCRIPTION(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuLDC_TIPO_RESPUESTA_ID in LDC_TIPO_RESPUESTA.LDC_TIPO_RESPUESTA_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_TIPO_RESPUESTA;
	BEGIN
		rcError.LDC_TIPO_RESPUESTA_ID := inuLDC_TIPO_RESPUESTA_ID;

		if inuLock=1 then
			LockByPk
			(
				inuLDC_TIPO_RESPUESTA_ID,
				rcData
			);
		end if;


		delete
		from LDC_TIPO_RESPUESTA
		where
       		LDC_TIPO_RESPUESTA_ID=inuLDC_TIPO_RESPUESTA_ID;
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
		rcError  styLDC_TIPO_RESPUESTA;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_TIPO_RESPUESTA
		where
			rowid = iriRowID
		returning
			LDC_TIPO_RESPUESTA_ID
		into
			rcError.LDC_TIPO_RESPUESTA_ID;
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
		iotbLDC_TIPO_RESPUESTA in out nocopy tytbLDC_TIPO_RESPUESTA,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_TIPO_RESPUESTA;
	BEGIN
		FillRecordOfTables(iotbLDC_TIPO_RESPUESTA, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_TIPO_RESPUESTA.first .. iotbLDC_TIPO_RESPUESTA.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_TIPO_RESPUESTA.first .. iotbLDC_TIPO_RESPUESTA.last
				delete
				from LDC_TIPO_RESPUESTA
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_TIPO_RESPUESTA.first .. iotbLDC_TIPO_RESPUESTA.last loop
					LockByPk
					(
						rcRecOfTab.LDC_TIPO_RESPUESTA_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_TIPO_RESPUESTA.first .. iotbLDC_TIPO_RESPUESTA.last
				delete
				from LDC_TIPO_RESPUESTA
				where
		         	LDC_TIPO_RESPUESTA_ID = rcRecOfTab.LDC_TIPO_RESPUESTA_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_TIPO_RESPUESTA in styLDC_TIPO_RESPUESTA,
		inuLock in number default 0
	)
	IS
		nuLDC_TIPO_RESPUESTA_ID	LDC_TIPO_RESPUESTA.LDC_TIPO_RESPUESTA_ID%type;
	BEGIN
		if ircLDC_TIPO_RESPUESTA.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_TIPO_RESPUESTA.rowid,rcData);
			end if;
			update LDC_TIPO_RESPUESTA
			set
				SSPD_RESPUESTA = ircLDC_TIPO_RESPUESTA.SSPD_RESPUESTA,
				DESCRIPTION = ircLDC_TIPO_RESPUESTA.DESCRIPTION
			where
				rowid = ircLDC_TIPO_RESPUESTA.rowid
			returning
				LDC_TIPO_RESPUESTA_ID
			into
				nuLDC_TIPO_RESPUESTA_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_TIPO_RESPUESTA.LDC_TIPO_RESPUESTA_ID,
					rcData
				);
			end if;

			update LDC_TIPO_RESPUESTA
			set
				SSPD_RESPUESTA = ircLDC_TIPO_RESPUESTA.SSPD_RESPUESTA,
				DESCRIPTION = ircLDC_TIPO_RESPUESTA.DESCRIPTION
			where
				LDC_TIPO_RESPUESTA_ID = ircLDC_TIPO_RESPUESTA.LDC_TIPO_RESPUESTA_ID
			returning
				LDC_TIPO_RESPUESTA_ID
			into
				nuLDC_TIPO_RESPUESTA_ID;
		end if;
		if
			nuLDC_TIPO_RESPUESTA_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_TIPO_RESPUESTA));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_TIPO_RESPUESTA in out nocopy tytbLDC_TIPO_RESPUESTA,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_TIPO_RESPUESTA;
	BEGIN
		FillRecordOfTables(iotbLDC_TIPO_RESPUESTA,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_TIPO_RESPUESTA.first .. iotbLDC_TIPO_RESPUESTA.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_TIPO_RESPUESTA.first .. iotbLDC_TIPO_RESPUESTA.last
				update LDC_TIPO_RESPUESTA
				set
					SSPD_RESPUESTA = rcRecOfTab.SSPD_RESPUESTA(n),
					DESCRIPTION = rcRecOfTab.DESCRIPTION(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_TIPO_RESPUESTA.first .. iotbLDC_TIPO_RESPUESTA.last loop
					LockByPk
					(
						rcRecOfTab.LDC_TIPO_RESPUESTA_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_TIPO_RESPUESTA.first .. iotbLDC_TIPO_RESPUESTA.last
				update LDC_TIPO_RESPUESTA
				SET
					SSPD_RESPUESTA = rcRecOfTab.SSPD_RESPUESTA(n),
					DESCRIPTION = rcRecOfTab.DESCRIPTION(n)
				where
					LDC_TIPO_RESPUESTA_ID = rcRecOfTab.LDC_TIPO_RESPUESTA_ID(n)
;
		end if;
	END;
	PROCEDURE updSSPD_RESPUESTA
	(
		inuLDC_TIPO_RESPUESTA_ID in LDC_TIPO_RESPUESTA.LDC_TIPO_RESPUESTA_ID%type,
		inuSSPD_RESPUESTA$ in LDC_TIPO_RESPUESTA.SSPD_RESPUESTA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_TIPO_RESPUESTA;
	BEGIN
		rcError.LDC_TIPO_RESPUESTA_ID := inuLDC_TIPO_RESPUESTA_ID;
		if inuLock=1 then
			LockByPk
			(
				inuLDC_TIPO_RESPUESTA_ID,
				rcData
			);
		end if;

		update LDC_TIPO_RESPUESTA
		set
			SSPD_RESPUESTA = inuSSPD_RESPUESTA$
		where
			LDC_TIPO_RESPUESTA_ID = inuLDC_TIPO_RESPUESTA_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SSPD_RESPUESTA:= inuSSPD_RESPUESTA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updDESCRIPTION
	(
		inuLDC_TIPO_RESPUESTA_ID in LDC_TIPO_RESPUESTA.LDC_TIPO_RESPUESTA_ID%type,
		isbDESCRIPTION$ in LDC_TIPO_RESPUESTA.DESCRIPTION%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_TIPO_RESPUESTA;
	BEGIN
		rcError.LDC_TIPO_RESPUESTA_ID := inuLDC_TIPO_RESPUESTA_ID;
		if inuLock=1 then
			LockByPk
			(
				inuLDC_TIPO_RESPUESTA_ID,
				rcData
			);
		end if;

		update LDC_TIPO_RESPUESTA
		set
			DESCRIPTION = isbDESCRIPTION$
		where
			LDC_TIPO_RESPUESTA_ID = inuLDC_TIPO_RESPUESTA_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DESCRIPTION:= isbDESCRIPTION$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetLDC_TIPO_RESPUESTA_ID
	(
		inuLDC_TIPO_RESPUESTA_ID in LDC_TIPO_RESPUESTA.LDC_TIPO_RESPUESTA_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPO_RESPUESTA.LDC_TIPO_RESPUESTA_ID%type
	IS
		rcError styLDC_TIPO_RESPUESTA;
	BEGIN

		rcError.LDC_TIPO_RESPUESTA_ID := inuLDC_TIPO_RESPUESTA_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuLDC_TIPO_RESPUESTA_ID
			 )
		then
			 return(rcData.LDC_TIPO_RESPUESTA_ID);
		end if;
		Load
		(
		 		inuLDC_TIPO_RESPUESTA_ID
		);
		return(rcData.LDC_TIPO_RESPUESTA_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetSSPD_RESPUESTA
	(
		inuLDC_TIPO_RESPUESTA_ID in LDC_TIPO_RESPUESTA.LDC_TIPO_RESPUESTA_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPO_RESPUESTA.SSPD_RESPUESTA%type
	IS
		rcError styLDC_TIPO_RESPUESTA;
	BEGIN

		rcError.LDC_TIPO_RESPUESTA_ID := inuLDC_TIPO_RESPUESTA_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuLDC_TIPO_RESPUESTA_ID
			 )
		then
			 return(rcData.SSPD_RESPUESTA);
		end if;
		Load
		(
		 		inuLDC_TIPO_RESPUESTA_ID
		);
		return(rcData.SSPD_RESPUESTA);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetDESCRIPTION
	(
		inuLDC_TIPO_RESPUESTA_ID in LDC_TIPO_RESPUESTA.LDC_TIPO_RESPUESTA_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPO_RESPUESTA.DESCRIPTION%type
	IS
		rcError styLDC_TIPO_RESPUESTA;
	BEGIN

		rcError.LDC_TIPO_RESPUESTA_ID := inuLDC_TIPO_RESPUESTA_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuLDC_TIPO_RESPUESTA_ID
			 )
		then
			 return(rcData.DESCRIPTION);
		end if;
		Load
		(
		 		inuLDC_TIPO_RESPUESTA_ID
		);
		return(rcData.DESCRIPTION);
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
end DALDC_TIPO_RESPUESTA;
/
PROMPT Otorgando permisos de ejecucion a DALDC_TIPO_RESPUESTA
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_TIPO_RESPUESTA', 'ADM_PERSON');
END;
/