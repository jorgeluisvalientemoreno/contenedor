CREATE OR REPLACE PACKAGE adm_person.daldci_novxtitrab
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  11/06/2024   Adrianavg   OSF-2813: Migrar del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuNOVETITRAB_ID in LDCI_NOVXTITRAB.NOVETITRAB_ID%type
	)
	IS
		SELECT LDCI_NOVXTITRAB.*,LDCI_NOVXTITRAB.rowid
		FROM LDCI_NOVXTITRAB
		WHERE
		    NOVETITRAB_ID = inuNOVETITRAB_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDCI_NOVXTITRAB.*,LDCI_NOVXTITRAB.rowid
		FROM LDCI_NOVXTITRAB
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDCI_NOVXTITRAB  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDCI_NOVXTITRAB is table of styLDCI_NOVXTITRAB index by binary_integer;
	type tyrfRecords is ref cursor return styLDCI_NOVXTITRAB;

	/* Tipos referenciando al registro */
	type tytbNOVETITRAB_ID is table of LDCI_NOVXTITRAB.NOVETITRAB_ID%type index by binary_integer;
	type tytbNOVETYPE_ID is table of LDCI_NOVXTITRAB.NOVETYPE_ID%type index by binary_integer;
	type tytbTASK_TYPE_ID is table of LDCI_NOVXTITRAB.TASK_TYPE_ID%type index by binary_integer;
	type tytbPRIORIDAD is table of LDCI_NOVXTITRAB.PRIORIDAD%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDCI_NOVXTITRAB is record
	(
		NOVETITRAB_ID   tytbNOVETITRAB_ID,
		NOVETYPE_ID   tytbNOVETYPE_ID,
		TASK_TYPE_ID   tytbTASK_TYPE_ID,
		PRIORIDAD   tytbPRIORIDAD,
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
		inuNOVETITRAB_ID in LDCI_NOVXTITRAB.NOVETITRAB_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuNOVETITRAB_ID in LDCI_NOVXTITRAB.NOVETITRAB_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuNOVETITRAB_ID in LDCI_NOVXTITRAB.NOVETITRAB_ID%type
	);

	PROCEDURE getRecord
	(
		inuNOVETITRAB_ID in LDCI_NOVXTITRAB.NOVETITRAB_ID%type,
		orcRecord out nocopy styLDCI_NOVXTITRAB
	);

	FUNCTION frcGetRcData
	(
		inuNOVETITRAB_ID in LDCI_NOVXTITRAB.NOVETITRAB_ID%type
	)
	RETURN styLDCI_NOVXTITRAB;

	FUNCTION frcGetRcData
	RETURN styLDCI_NOVXTITRAB;

	FUNCTION frcGetRecord
	(
		inuNOVETITRAB_ID in LDCI_NOVXTITRAB.NOVETITRAB_ID%type
	)
	RETURN styLDCI_NOVXTITRAB;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDCI_NOVXTITRAB
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDCI_NOVXTITRAB in styLDCI_NOVXTITRAB
	);

	PROCEDURE insRecord
	(
		ircLDCI_NOVXTITRAB in styLDCI_NOVXTITRAB,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDCI_NOVXTITRAB in out nocopy tytbLDCI_NOVXTITRAB
	);

	PROCEDURE delRecord
	(
		inuNOVETITRAB_ID in LDCI_NOVXTITRAB.NOVETITRAB_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDCI_NOVXTITRAB in out nocopy tytbLDCI_NOVXTITRAB,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDCI_NOVXTITRAB in styLDCI_NOVXTITRAB,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDCI_NOVXTITRAB in out nocopy tytbLDCI_NOVXTITRAB,
		inuLock in number default 1
	);

	PROCEDURE updNOVETYPE_ID
	(
		inuNOVETITRAB_ID in LDCI_NOVXTITRAB.NOVETITRAB_ID%type,
		inuNOVETYPE_ID$ in LDCI_NOVXTITRAB.NOVETYPE_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updTASK_TYPE_ID
	(
		inuNOVETITRAB_ID in LDCI_NOVXTITRAB.NOVETITRAB_ID%type,
		inuTASK_TYPE_ID$ in LDCI_NOVXTITRAB.TASK_TYPE_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updPRIORIDAD
	(
		inuNOVETITRAB_ID in LDCI_NOVXTITRAB.NOVETITRAB_ID%type,
		inuPRIORIDAD$ in LDCI_NOVXTITRAB.PRIORIDAD%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetNOVETITRAB_ID
	(
		inuNOVETITRAB_ID in LDCI_NOVXTITRAB.NOVETITRAB_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDCI_NOVXTITRAB.NOVETITRAB_ID%type;

	FUNCTION fnuGetNOVETYPE_ID
	(
		inuNOVETITRAB_ID in LDCI_NOVXTITRAB.NOVETITRAB_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDCI_NOVXTITRAB.NOVETYPE_ID%type;

	FUNCTION fnuGetTASK_TYPE_ID
	(
		inuNOVETITRAB_ID in LDCI_NOVXTITRAB.NOVETITRAB_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDCI_NOVXTITRAB.TASK_TYPE_ID%type;

	FUNCTION fnuGetPRIORIDAD
	(
		inuNOVETITRAB_ID in LDCI_NOVXTITRAB.NOVETITRAB_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDCI_NOVXTITRAB.PRIORIDAD%type;


	PROCEDURE LockByPk
	(
		inuNOVETITRAB_ID in LDCI_NOVXTITRAB.NOVETITRAB_ID%type,
		orcLDCI_NOVXTITRAB  out styLDCI_NOVXTITRAB
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDCI_NOVXTITRAB  out styLDCI_NOVXTITRAB
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDCI_NOVXTITRAB;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALDCI_NOVXTITRAB
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDCI_NOVXTITRAB';
	 cnuGeEntityId constant varchar2(30) := 4212; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuNOVETITRAB_ID in LDCI_NOVXTITRAB.NOVETITRAB_ID%type
	)
	IS
		SELECT LDCI_NOVXTITRAB.*,LDCI_NOVXTITRAB.rowid
		FROM LDCI_NOVXTITRAB
		WHERE  NOVETITRAB_ID = inuNOVETITRAB_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDCI_NOVXTITRAB.*,LDCI_NOVXTITRAB.rowid
		FROM LDCI_NOVXTITRAB
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDCI_NOVXTITRAB is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDCI_NOVXTITRAB;

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
	FUNCTION fsbPrimaryKey( rcI in styLDCI_NOVXTITRAB default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.NOVETITRAB_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuNOVETITRAB_ID in LDCI_NOVXTITRAB.NOVETITRAB_ID%type,
		orcLDCI_NOVXTITRAB  out styLDCI_NOVXTITRAB
	)
	IS
		rcError styLDCI_NOVXTITRAB;
	BEGIN
		rcError.NOVETITRAB_ID := inuNOVETITRAB_ID;

		Open cuLockRcByPk
		(
			inuNOVETITRAB_ID
		);

		fetch cuLockRcByPk into orcLDCI_NOVXTITRAB;
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
		orcLDCI_NOVXTITRAB  out styLDCI_NOVXTITRAB
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDCI_NOVXTITRAB;
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
		itbLDCI_NOVXTITRAB  in out nocopy tytbLDCI_NOVXTITRAB
	)
	IS
	BEGIN
			rcRecOfTab.NOVETITRAB_ID.delete;
			rcRecOfTab.NOVETYPE_ID.delete;
			rcRecOfTab.TASK_TYPE_ID.delete;
			rcRecOfTab.PRIORIDAD.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDCI_NOVXTITRAB  in out nocopy tytbLDCI_NOVXTITRAB,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDCI_NOVXTITRAB);

		for n in itbLDCI_NOVXTITRAB.first .. itbLDCI_NOVXTITRAB.last loop
			rcRecOfTab.NOVETITRAB_ID(n) := itbLDCI_NOVXTITRAB(n).NOVETITRAB_ID;
			rcRecOfTab.NOVETYPE_ID(n) := itbLDCI_NOVXTITRAB(n).NOVETYPE_ID;
			rcRecOfTab.TASK_TYPE_ID(n) := itbLDCI_NOVXTITRAB(n).TASK_TYPE_ID;
			rcRecOfTab.PRIORIDAD(n) := itbLDCI_NOVXTITRAB(n).PRIORIDAD;
			rcRecOfTab.row_id(n) := itbLDCI_NOVXTITRAB(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuNOVETITRAB_ID in LDCI_NOVXTITRAB.NOVETITRAB_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuNOVETITRAB_ID
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
		inuNOVETITRAB_ID in LDCI_NOVXTITRAB.NOVETITRAB_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuNOVETITRAB_ID = rcData.NOVETITRAB_ID
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
		inuNOVETITRAB_ID in LDCI_NOVXTITRAB.NOVETITRAB_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuNOVETITRAB_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuNOVETITRAB_ID in LDCI_NOVXTITRAB.NOVETITRAB_ID%type
	)
	IS
		rcError styLDCI_NOVXTITRAB;
	BEGIN		rcError.NOVETITRAB_ID:=inuNOVETITRAB_ID;

		Load
		(
			inuNOVETITRAB_ID
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
		inuNOVETITRAB_ID in LDCI_NOVXTITRAB.NOVETITRAB_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuNOVETITRAB_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuNOVETITRAB_ID in LDCI_NOVXTITRAB.NOVETITRAB_ID%type,
		orcRecord out nocopy styLDCI_NOVXTITRAB
	)
	IS
		rcError styLDCI_NOVXTITRAB;
	BEGIN		rcError.NOVETITRAB_ID:=inuNOVETITRAB_ID;

		Load
		(
			inuNOVETITRAB_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuNOVETITRAB_ID in LDCI_NOVXTITRAB.NOVETITRAB_ID%type
	)
	RETURN styLDCI_NOVXTITRAB
	IS
		rcError styLDCI_NOVXTITRAB;
	BEGIN
		rcError.NOVETITRAB_ID:=inuNOVETITRAB_ID;

		Load
		(
			inuNOVETITRAB_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuNOVETITRAB_ID in LDCI_NOVXTITRAB.NOVETITRAB_ID%type
	)
	RETURN styLDCI_NOVXTITRAB
	IS
		rcError styLDCI_NOVXTITRAB;
	BEGIN
		rcError.NOVETITRAB_ID:=inuNOVETITRAB_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuNOVETITRAB_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuNOVETITRAB_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDCI_NOVXTITRAB
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDCI_NOVXTITRAB
	)
	IS
		rfLDCI_NOVXTITRAB tyrfLDCI_NOVXTITRAB;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDCI_NOVXTITRAB.*, LDCI_NOVXTITRAB.rowid FROM LDCI_NOVXTITRAB';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDCI_NOVXTITRAB for sbFullQuery;

		fetch rfLDCI_NOVXTITRAB bulk collect INTO otbResult;

		close rfLDCI_NOVXTITRAB;
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
		sbSQL VARCHAR2 (32000) := 'select LDCI_NOVXTITRAB.*, LDCI_NOVXTITRAB.rowid FROM LDCI_NOVXTITRAB';
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
		ircLDCI_NOVXTITRAB in styLDCI_NOVXTITRAB
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDCI_NOVXTITRAB,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDCI_NOVXTITRAB in styLDCI_NOVXTITRAB,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDCI_NOVXTITRAB.NOVETITRAB_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|NOVETITRAB_ID');
			raise ex.controlled_error;
		end if;

		insert into LDCI_NOVXTITRAB
		(
			NOVETITRAB_ID,
			NOVETYPE_ID,
			TASK_TYPE_ID,
			PRIORIDAD
		)
		values
		(
			ircLDCI_NOVXTITRAB.NOVETITRAB_ID,
			ircLDCI_NOVXTITRAB.NOVETYPE_ID,
			ircLDCI_NOVXTITRAB.TASK_TYPE_ID,
			ircLDCI_NOVXTITRAB.PRIORIDAD
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDCI_NOVXTITRAB));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDCI_NOVXTITRAB in out nocopy tytbLDCI_NOVXTITRAB
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDCI_NOVXTITRAB,blUseRowID);
		forall n in iotbLDCI_NOVXTITRAB.first..iotbLDCI_NOVXTITRAB.last
			insert into LDCI_NOVXTITRAB
			(
				NOVETITRAB_ID,
				NOVETYPE_ID,
				TASK_TYPE_ID,
				PRIORIDAD
			)
			values
			(
				rcRecOfTab.NOVETITRAB_ID(n),
				rcRecOfTab.NOVETYPE_ID(n),
				rcRecOfTab.TASK_TYPE_ID(n),
				rcRecOfTab.PRIORIDAD(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuNOVETITRAB_ID in LDCI_NOVXTITRAB.NOVETITRAB_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLDCI_NOVXTITRAB;
	BEGIN
		rcError.NOVETITRAB_ID := inuNOVETITRAB_ID;

		if inuLock=1 then
			LockByPk
			(
				inuNOVETITRAB_ID,
				rcData
			);
		end if;


		delete
		from LDCI_NOVXTITRAB
		where
       		NOVETITRAB_ID=inuNOVETITRAB_ID;
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
		rcError  styLDCI_NOVXTITRAB;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDCI_NOVXTITRAB
		where
			rowid = iriRowID
		returning
			NOVETITRAB_ID
		into
			rcError.NOVETITRAB_ID;
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
		iotbLDCI_NOVXTITRAB in out nocopy tytbLDCI_NOVXTITRAB,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDCI_NOVXTITRAB;
	BEGIN
		FillRecordOfTables(iotbLDCI_NOVXTITRAB, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDCI_NOVXTITRAB.first .. iotbLDCI_NOVXTITRAB.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDCI_NOVXTITRAB.first .. iotbLDCI_NOVXTITRAB.last
				delete
				from LDCI_NOVXTITRAB
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDCI_NOVXTITRAB.first .. iotbLDCI_NOVXTITRAB.last loop
					LockByPk
					(
						rcRecOfTab.NOVETITRAB_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDCI_NOVXTITRAB.first .. iotbLDCI_NOVXTITRAB.last
				delete
				from LDCI_NOVXTITRAB
				where
		         	NOVETITRAB_ID = rcRecOfTab.NOVETITRAB_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDCI_NOVXTITRAB in styLDCI_NOVXTITRAB,
		inuLock in number default 0
	)
	IS
		nuNOVETITRAB_ID	LDCI_NOVXTITRAB.NOVETITRAB_ID%type;
	BEGIN
		if ircLDCI_NOVXTITRAB.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDCI_NOVXTITRAB.rowid,rcData);
			end if;
			update LDCI_NOVXTITRAB
			set
				NOVETYPE_ID = ircLDCI_NOVXTITRAB.NOVETYPE_ID,
				TASK_TYPE_ID = ircLDCI_NOVXTITRAB.TASK_TYPE_ID,
				PRIORIDAD = ircLDCI_NOVXTITRAB.PRIORIDAD
			where
				rowid = ircLDCI_NOVXTITRAB.rowid
			returning
				NOVETITRAB_ID
			into
				nuNOVETITRAB_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDCI_NOVXTITRAB.NOVETITRAB_ID,
					rcData
				);
			end if;

			update LDCI_NOVXTITRAB
			set
				NOVETYPE_ID = ircLDCI_NOVXTITRAB.NOVETYPE_ID,
				TASK_TYPE_ID = ircLDCI_NOVXTITRAB.TASK_TYPE_ID,
				PRIORIDAD = ircLDCI_NOVXTITRAB.PRIORIDAD
			where
				NOVETITRAB_ID = ircLDCI_NOVXTITRAB.NOVETITRAB_ID
			returning
				NOVETITRAB_ID
			into
				nuNOVETITRAB_ID;
		end if;
		if
			nuNOVETITRAB_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDCI_NOVXTITRAB));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDCI_NOVXTITRAB in out nocopy tytbLDCI_NOVXTITRAB,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDCI_NOVXTITRAB;
	BEGIN
		FillRecordOfTables(iotbLDCI_NOVXTITRAB,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDCI_NOVXTITRAB.first .. iotbLDCI_NOVXTITRAB.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDCI_NOVXTITRAB.first .. iotbLDCI_NOVXTITRAB.last
				update LDCI_NOVXTITRAB
				set
					NOVETYPE_ID = rcRecOfTab.NOVETYPE_ID(n),
					TASK_TYPE_ID = rcRecOfTab.TASK_TYPE_ID(n),
					PRIORIDAD = rcRecOfTab.PRIORIDAD(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDCI_NOVXTITRAB.first .. iotbLDCI_NOVXTITRAB.last loop
					LockByPk
					(
						rcRecOfTab.NOVETITRAB_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDCI_NOVXTITRAB.first .. iotbLDCI_NOVXTITRAB.last
				update LDCI_NOVXTITRAB
				SET
					NOVETYPE_ID = rcRecOfTab.NOVETYPE_ID(n),
					TASK_TYPE_ID = rcRecOfTab.TASK_TYPE_ID(n),
					PRIORIDAD = rcRecOfTab.PRIORIDAD(n)
				where
					NOVETITRAB_ID = rcRecOfTab.NOVETITRAB_ID(n)
;
		end if;
	END;
	PROCEDURE updNOVETYPE_ID
	(
		inuNOVETITRAB_ID in LDCI_NOVXTITRAB.NOVETITRAB_ID%type,
		inuNOVETYPE_ID$ in LDCI_NOVXTITRAB.NOVETYPE_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDCI_NOVXTITRAB;
	BEGIN
		rcError.NOVETITRAB_ID := inuNOVETITRAB_ID;
		if inuLock=1 then
			LockByPk
			(
				inuNOVETITRAB_ID,
				rcData
			);
		end if;

		update LDCI_NOVXTITRAB
		set
			NOVETYPE_ID = inuNOVETYPE_ID$
		where
			NOVETITRAB_ID = inuNOVETITRAB_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.NOVETYPE_ID:= inuNOVETYPE_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updTASK_TYPE_ID
	(
		inuNOVETITRAB_ID in LDCI_NOVXTITRAB.NOVETITRAB_ID%type,
		inuTASK_TYPE_ID$ in LDCI_NOVXTITRAB.TASK_TYPE_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDCI_NOVXTITRAB;
	BEGIN
		rcError.NOVETITRAB_ID := inuNOVETITRAB_ID;
		if inuLock=1 then
			LockByPk
			(
				inuNOVETITRAB_ID,
				rcData
			);
		end if;

		update LDCI_NOVXTITRAB
		set
			TASK_TYPE_ID = inuTASK_TYPE_ID$
		where
			NOVETITRAB_ID = inuNOVETITRAB_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TASK_TYPE_ID:= inuTASK_TYPE_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPRIORIDAD
	(
		inuNOVETITRAB_ID in LDCI_NOVXTITRAB.NOVETITRAB_ID%type,
		inuPRIORIDAD$ in LDCI_NOVXTITRAB.PRIORIDAD%type,
		inuLock in number default 0
	)
	IS
		rcError styLDCI_NOVXTITRAB;
	BEGIN
		rcError.NOVETITRAB_ID := inuNOVETITRAB_ID;
		if inuLock=1 then
			LockByPk
			(
				inuNOVETITRAB_ID,
				rcData
			);
		end if;

		update LDCI_NOVXTITRAB
		set
			PRIORIDAD = inuPRIORIDAD$
		where
			NOVETITRAB_ID = inuNOVETITRAB_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PRIORIDAD:= inuPRIORIDAD$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetNOVETITRAB_ID
	(
		inuNOVETITRAB_ID in LDCI_NOVXTITRAB.NOVETITRAB_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDCI_NOVXTITRAB.NOVETITRAB_ID%type
	IS
		rcError styLDCI_NOVXTITRAB;
	BEGIN

		rcError.NOVETITRAB_ID := inuNOVETITRAB_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuNOVETITRAB_ID
			 )
		then
			 return(rcData.NOVETITRAB_ID);
		end if;
		Load
		(
		 		inuNOVETITRAB_ID
		);
		return(rcData.NOVETITRAB_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetNOVETYPE_ID
	(
		inuNOVETITRAB_ID in LDCI_NOVXTITRAB.NOVETITRAB_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDCI_NOVXTITRAB.NOVETYPE_ID%type
	IS
		rcError styLDCI_NOVXTITRAB;
	BEGIN

		rcError.NOVETITRAB_ID := inuNOVETITRAB_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuNOVETITRAB_ID
			 )
		then
			 return(rcData.NOVETYPE_ID);
		end if;
		Load
		(
		 		inuNOVETITRAB_ID
		);
		return(rcData.NOVETYPE_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetTASK_TYPE_ID
	(
		inuNOVETITRAB_ID in LDCI_NOVXTITRAB.NOVETITRAB_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDCI_NOVXTITRAB.TASK_TYPE_ID%type
	IS
		rcError styLDCI_NOVXTITRAB;
	BEGIN

		rcError.NOVETITRAB_ID := inuNOVETITRAB_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuNOVETITRAB_ID
			 )
		then
			 return(rcData.TASK_TYPE_ID);
		end if;
		Load
		(
		 		inuNOVETITRAB_ID
		);
		return(rcData.TASK_TYPE_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetPRIORIDAD
	(
		inuNOVETITRAB_ID in LDCI_NOVXTITRAB.NOVETITRAB_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDCI_NOVXTITRAB.PRIORIDAD%type
	IS
		rcError styLDCI_NOVXTITRAB;
	BEGIN

		rcError.NOVETITRAB_ID := inuNOVETITRAB_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuNOVETITRAB_ID
			 )
		then
			 return(rcData.PRIORIDAD);
		end if;
		Load
		(
		 		inuNOVETITRAB_ID
		);
		return(rcData.PRIORIDAD);
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
end DALDCI_NOVXTITRAB;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALDCI_NOVXTITRAB
BEGIN
    pkg_utilidades.prAplicarPermisos('DALDCI_NOVXTITRAB', 'ADM_PERSON'); 
END;
/
