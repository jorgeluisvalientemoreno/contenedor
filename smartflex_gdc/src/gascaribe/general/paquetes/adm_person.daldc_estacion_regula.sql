CREATE OR REPLACE PACKAGE adm_person.daldc_estacion_regula
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  11/06/2024   Adrianavg   OSF-2813: Migrar del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuESTACION_REGULA_ID in LDC_ESTACION_REGULA.ESTACION_REGULA_ID%type
	)
	IS
		SELECT LDC_ESTACION_REGULA.*,LDC_ESTACION_REGULA.rowid
		FROM LDC_ESTACION_REGULA
		WHERE
		    ESTACION_REGULA_ID = inuESTACION_REGULA_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_ESTACION_REGULA.*,LDC_ESTACION_REGULA.rowid
		FROM LDC_ESTACION_REGULA
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_ESTACION_REGULA  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_ESTACION_REGULA is table of styLDC_ESTACION_REGULA index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_ESTACION_REGULA;

	/* Tipos referenciando al registro */
	type tytbESTACION_REGULA_ID is table of LDC_ESTACION_REGULA.ESTACION_REGULA_ID%type index by binary_integer;
	type tytbDESCRPTION is table of LDC_ESTACION_REGULA.DESCRPTION%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_ESTACION_REGULA is record
	(
		ESTACION_REGULA_ID   tytbESTACION_REGULA_ID,
		DESCRPTION   tytbDESCRPTION,
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
		inuESTACION_REGULA_ID in LDC_ESTACION_REGULA.ESTACION_REGULA_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuESTACION_REGULA_ID in LDC_ESTACION_REGULA.ESTACION_REGULA_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuESTACION_REGULA_ID in LDC_ESTACION_REGULA.ESTACION_REGULA_ID%type
	);

	PROCEDURE getRecord
	(
		inuESTACION_REGULA_ID in LDC_ESTACION_REGULA.ESTACION_REGULA_ID%type,
		orcRecord out nocopy styLDC_ESTACION_REGULA
	);

	FUNCTION frcGetRcData
	(
		inuESTACION_REGULA_ID in LDC_ESTACION_REGULA.ESTACION_REGULA_ID%type
	)
	RETURN styLDC_ESTACION_REGULA;

	FUNCTION frcGetRcData
	RETURN styLDC_ESTACION_REGULA;

	FUNCTION frcGetRecord
	(
		inuESTACION_REGULA_ID in LDC_ESTACION_REGULA.ESTACION_REGULA_ID%type
	)
	RETURN styLDC_ESTACION_REGULA;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_ESTACION_REGULA
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_ESTACION_REGULA in styLDC_ESTACION_REGULA
	);

	PROCEDURE insRecord
	(
		ircLDC_ESTACION_REGULA in styLDC_ESTACION_REGULA,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_ESTACION_REGULA in out nocopy tytbLDC_ESTACION_REGULA
	);

	PROCEDURE delRecord
	(
		inuESTACION_REGULA_ID in LDC_ESTACION_REGULA.ESTACION_REGULA_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_ESTACION_REGULA in out nocopy tytbLDC_ESTACION_REGULA,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_ESTACION_REGULA in styLDC_ESTACION_REGULA,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_ESTACION_REGULA in out nocopy tytbLDC_ESTACION_REGULA,
		inuLock in number default 1
	);

	PROCEDURE updDESCRPTION
	(
		inuESTACION_REGULA_ID in LDC_ESTACION_REGULA.ESTACION_REGULA_ID%type,
		isbDESCRPTION$ in LDC_ESTACION_REGULA.DESCRPTION%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetESTACION_REGULA_ID
	(
		inuESTACION_REGULA_ID in LDC_ESTACION_REGULA.ESTACION_REGULA_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ESTACION_REGULA.ESTACION_REGULA_ID%type;

	FUNCTION fsbGetDESCRPTION
	(
		inuESTACION_REGULA_ID in LDC_ESTACION_REGULA.ESTACION_REGULA_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ESTACION_REGULA.DESCRPTION%type;


	PROCEDURE LockByPk
	(
		inuESTACION_REGULA_ID in LDC_ESTACION_REGULA.ESTACION_REGULA_ID%type,
		orcLDC_ESTACION_REGULA  out styLDC_ESTACION_REGULA
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_ESTACION_REGULA  out styLDC_ESTACION_REGULA
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_ESTACION_REGULA;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALDC_ESTACION_REGULA
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_ESTACION_REGULA';
	 cnuGeEntityId constant varchar2(30) := 8809; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuESTACION_REGULA_ID in LDC_ESTACION_REGULA.ESTACION_REGULA_ID%type
	)
	IS
		SELECT LDC_ESTACION_REGULA.*,LDC_ESTACION_REGULA.rowid
		FROM LDC_ESTACION_REGULA
		WHERE  ESTACION_REGULA_ID = inuESTACION_REGULA_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_ESTACION_REGULA.*,LDC_ESTACION_REGULA.rowid
		FROM LDC_ESTACION_REGULA
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_ESTACION_REGULA is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_ESTACION_REGULA;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_ESTACION_REGULA default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.ESTACION_REGULA_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuESTACION_REGULA_ID in LDC_ESTACION_REGULA.ESTACION_REGULA_ID%type,
		orcLDC_ESTACION_REGULA  out styLDC_ESTACION_REGULA
	)
	IS
		rcError styLDC_ESTACION_REGULA;
	BEGIN
		rcError.ESTACION_REGULA_ID := inuESTACION_REGULA_ID;

		Open cuLockRcByPk
		(
			inuESTACION_REGULA_ID
		);

		fetch cuLockRcByPk into orcLDC_ESTACION_REGULA;
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
		orcLDC_ESTACION_REGULA  out styLDC_ESTACION_REGULA
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_ESTACION_REGULA;
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
		itbLDC_ESTACION_REGULA  in out nocopy tytbLDC_ESTACION_REGULA
	)
	IS
	BEGIN
			rcRecOfTab.ESTACION_REGULA_ID.delete;
			rcRecOfTab.DESCRPTION.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_ESTACION_REGULA  in out nocopy tytbLDC_ESTACION_REGULA,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_ESTACION_REGULA);

		for n in itbLDC_ESTACION_REGULA.first .. itbLDC_ESTACION_REGULA.last loop
			rcRecOfTab.ESTACION_REGULA_ID(n) := itbLDC_ESTACION_REGULA(n).ESTACION_REGULA_ID;
			rcRecOfTab.DESCRPTION(n) := itbLDC_ESTACION_REGULA(n).DESCRPTION;
			rcRecOfTab.row_id(n) := itbLDC_ESTACION_REGULA(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuESTACION_REGULA_ID in LDC_ESTACION_REGULA.ESTACION_REGULA_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuESTACION_REGULA_ID
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
		inuESTACION_REGULA_ID in LDC_ESTACION_REGULA.ESTACION_REGULA_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuESTACION_REGULA_ID = rcData.ESTACION_REGULA_ID
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
		inuESTACION_REGULA_ID in LDC_ESTACION_REGULA.ESTACION_REGULA_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuESTACION_REGULA_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuESTACION_REGULA_ID in LDC_ESTACION_REGULA.ESTACION_REGULA_ID%type
	)
	IS
		rcError styLDC_ESTACION_REGULA;
	BEGIN		rcError.ESTACION_REGULA_ID:=inuESTACION_REGULA_ID;

		Load
		(
			inuESTACION_REGULA_ID
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
		inuESTACION_REGULA_ID in LDC_ESTACION_REGULA.ESTACION_REGULA_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuESTACION_REGULA_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuESTACION_REGULA_ID in LDC_ESTACION_REGULA.ESTACION_REGULA_ID%type,
		orcRecord out nocopy styLDC_ESTACION_REGULA
	)
	IS
		rcError styLDC_ESTACION_REGULA;
	BEGIN		rcError.ESTACION_REGULA_ID:=inuESTACION_REGULA_ID;

		Load
		(
			inuESTACION_REGULA_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuESTACION_REGULA_ID in LDC_ESTACION_REGULA.ESTACION_REGULA_ID%type
	)
	RETURN styLDC_ESTACION_REGULA
	IS
		rcError styLDC_ESTACION_REGULA;
	BEGIN
		rcError.ESTACION_REGULA_ID:=inuESTACION_REGULA_ID;

		Load
		(
			inuESTACION_REGULA_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuESTACION_REGULA_ID in LDC_ESTACION_REGULA.ESTACION_REGULA_ID%type
	)
	RETURN styLDC_ESTACION_REGULA
	IS
		rcError styLDC_ESTACION_REGULA;
	BEGIN
		rcError.ESTACION_REGULA_ID:=inuESTACION_REGULA_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuESTACION_REGULA_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuESTACION_REGULA_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_ESTACION_REGULA
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_ESTACION_REGULA
	)
	IS
		rfLDC_ESTACION_REGULA tyrfLDC_ESTACION_REGULA;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_ESTACION_REGULA.*, LDC_ESTACION_REGULA.rowid FROM LDC_ESTACION_REGULA';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_ESTACION_REGULA for sbFullQuery;

		fetch rfLDC_ESTACION_REGULA bulk collect INTO otbResult;

		close rfLDC_ESTACION_REGULA;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_ESTACION_REGULA.*, LDC_ESTACION_REGULA.rowid FROM LDC_ESTACION_REGULA';
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
		ircLDC_ESTACION_REGULA in styLDC_ESTACION_REGULA
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_ESTACION_REGULA,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_ESTACION_REGULA in styLDC_ESTACION_REGULA,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_ESTACION_REGULA.ESTACION_REGULA_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ESTACION_REGULA_ID');
			raise ex.controlled_error;
		end if;

		insert into LDC_ESTACION_REGULA
		(
			ESTACION_REGULA_ID,
			DESCRPTION
		)
		values
		(
			ircLDC_ESTACION_REGULA.ESTACION_REGULA_ID,
			ircLDC_ESTACION_REGULA.DESCRPTION
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_ESTACION_REGULA));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_ESTACION_REGULA in out nocopy tytbLDC_ESTACION_REGULA
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_ESTACION_REGULA,blUseRowID);
		forall n in iotbLDC_ESTACION_REGULA.first..iotbLDC_ESTACION_REGULA.last
			insert into LDC_ESTACION_REGULA
			(
				ESTACION_REGULA_ID,
				DESCRPTION
			)
			values
			(
				rcRecOfTab.ESTACION_REGULA_ID(n),
				rcRecOfTab.DESCRPTION(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuESTACION_REGULA_ID in LDC_ESTACION_REGULA.ESTACION_REGULA_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_ESTACION_REGULA;
	BEGIN
		rcError.ESTACION_REGULA_ID := inuESTACION_REGULA_ID;

		if inuLock=1 then
			LockByPk
			(
				inuESTACION_REGULA_ID,
				rcData
			);
		end if;


		delete
		from LDC_ESTACION_REGULA
		where
       		ESTACION_REGULA_ID=inuESTACION_REGULA_ID;
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
		rcError  styLDC_ESTACION_REGULA;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_ESTACION_REGULA
		where
			rowid = iriRowID
		returning
			ESTACION_REGULA_ID
		into
			rcError.ESTACION_REGULA_ID;
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
		iotbLDC_ESTACION_REGULA in out nocopy tytbLDC_ESTACION_REGULA,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_ESTACION_REGULA;
	BEGIN
		FillRecordOfTables(iotbLDC_ESTACION_REGULA, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_ESTACION_REGULA.first .. iotbLDC_ESTACION_REGULA.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ESTACION_REGULA.first .. iotbLDC_ESTACION_REGULA.last
				delete
				from LDC_ESTACION_REGULA
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_ESTACION_REGULA.first .. iotbLDC_ESTACION_REGULA.last loop
					LockByPk
					(
						rcRecOfTab.ESTACION_REGULA_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ESTACION_REGULA.first .. iotbLDC_ESTACION_REGULA.last
				delete
				from LDC_ESTACION_REGULA
				where
		         	ESTACION_REGULA_ID = rcRecOfTab.ESTACION_REGULA_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_ESTACION_REGULA in styLDC_ESTACION_REGULA,
		inuLock in number default 0
	)
	IS
		nuESTACION_REGULA_ID	LDC_ESTACION_REGULA.ESTACION_REGULA_ID%type;
	BEGIN
		if ircLDC_ESTACION_REGULA.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_ESTACION_REGULA.rowid,rcData);
			end if;
			update LDC_ESTACION_REGULA
			set
				DESCRPTION = ircLDC_ESTACION_REGULA.DESCRPTION
			where
				rowid = ircLDC_ESTACION_REGULA.rowid
			returning
				ESTACION_REGULA_ID
			into
				nuESTACION_REGULA_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_ESTACION_REGULA.ESTACION_REGULA_ID,
					rcData
				);
			end if;

			update LDC_ESTACION_REGULA
			set
				DESCRPTION = ircLDC_ESTACION_REGULA.DESCRPTION
			where
				ESTACION_REGULA_ID = ircLDC_ESTACION_REGULA.ESTACION_REGULA_ID
			returning
				ESTACION_REGULA_ID
			into
				nuESTACION_REGULA_ID;
		end if;
		if
			nuESTACION_REGULA_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_ESTACION_REGULA));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_ESTACION_REGULA in out nocopy tytbLDC_ESTACION_REGULA,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_ESTACION_REGULA;
	BEGIN
		FillRecordOfTables(iotbLDC_ESTACION_REGULA,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_ESTACION_REGULA.first .. iotbLDC_ESTACION_REGULA.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ESTACION_REGULA.first .. iotbLDC_ESTACION_REGULA.last
				update LDC_ESTACION_REGULA
				set
					DESCRPTION = rcRecOfTab.DESCRPTION(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_ESTACION_REGULA.first .. iotbLDC_ESTACION_REGULA.last loop
					LockByPk
					(
						rcRecOfTab.ESTACION_REGULA_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ESTACION_REGULA.first .. iotbLDC_ESTACION_REGULA.last
				update LDC_ESTACION_REGULA
				SET
					DESCRPTION = rcRecOfTab.DESCRPTION(n)
				where
					ESTACION_REGULA_ID = rcRecOfTab.ESTACION_REGULA_ID(n)
;
		end if;
	END;
	PROCEDURE updDESCRPTION
	(
		inuESTACION_REGULA_ID in LDC_ESTACION_REGULA.ESTACION_REGULA_ID%type,
		isbDESCRPTION$ in LDC_ESTACION_REGULA.DESCRPTION%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ESTACION_REGULA;
	BEGIN
		rcError.ESTACION_REGULA_ID := inuESTACION_REGULA_ID;
		if inuLock=1 then
			LockByPk
			(
				inuESTACION_REGULA_ID,
				rcData
			);
		end if;

		update LDC_ESTACION_REGULA
		set
			DESCRPTION = isbDESCRPTION$
		where
			ESTACION_REGULA_ID = inuESTACION_REGULA_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DESCRPTION:= isbDESCRPTION$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetESTACION_REGULA_ID
	(
		inuESTACION_REGULA_ID in LDC_ESTACION_REGULA.ESTACION_REGULA_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ESTACION_REGULA.ESTACION_REGULA_ID%type
	IS
		rcError styLDC_ESTACION_REGULA;
	BEGIN

		rcError.ESTACION_REGULA_ID := inuESTACION_REGULA_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuESTACION_REGULA_ID
			 )
		then
			 return(rcData.ESTACION_REGULA_ID);
		end if;
		Load
		(
		 		inuESTACION_REGULA_ID
		);
		return(rcData.ESTACION_REGULA_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetDESCRPTION
	(
		inuESTACION_REGULA_ID in LDC_ESTACION_REGULA.ESTACION_REGULA_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ESTACION_REGULA.DESCRPTION%type
	IS
		rcError styLDC_ESTACION_REGULA;
	BEGIN

		rcError.ESTACION_REGULA_ID := inuESTACION_REGULA_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuESTACION_REGULA_ID
			 )
		then
			 return(rcData.DESCRPTION);
		end if;
		Load
		(
		 		inuESTACION_REGULA_ID
		);
		return(rcData.DESCRPTION);
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
end DALDC_ESTACION_REGULA;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALDC_ESTACION_REGULA
BEGIN
    pkg_utilidades.prAplicarPermisos('DALDC_ESTACION_REGULA', 'ADM_PERSON'); 
END;
/
