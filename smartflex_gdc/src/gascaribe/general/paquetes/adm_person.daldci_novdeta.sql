CREATE OR REPLACE PACKAGE adm_person.daldci_novdeta
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  11/06/2024   Adrianavg   OSF-2813: Migrar del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuNOVETYPE_ID in LDCI_NOVDETA.NOVETYPE_ID%type
	)
	IS
		SELECT LDCI_NOVDETA.*,LDCI_NOVDETA.rowid
		FROM LDCI_NOVDETA
		WHERE
		    NOVETYPE_ID = inuNOVETYPE_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDCI_NOVDETA.*,LDCI_NOVDETA.rowid
		FROM LDCI_NOVDETA
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDCI_NOVDETA  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDCI_NOVDETA is table of styLDCI_NOVDETA index by binary_integer;
	type tyrfRecords is ref cursor return styLDCI_NOVDETA;

	/* Tipos referenciando al registro */
	type tytbNOVETYPE_ID is table of LDCI_NOVDETA.NOVETYPE_ID%type index by binary_integer;
	type tytbDESCRIPCION is table of LDCI_NOVDETA.DESCRIPCION%type index by binary_integer;
	type tytbPROCESO is table of LDCI_NOVDETA.PROCESO%type index by binary_integer;
	type tytbESTADO is table of LDCI_NOVDETA.ESTADO%type index by binary_integer;
	type tytbOBSERVACION is table of LDCI_NOVDETA.OBSERVACION%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDCI_NOVDETA is record
	(
		NOVETYPE_ID   tytbNOVETYPE_ID,
		DESCRIPCION   tytbDESCRIPCION,
		PROCESO   tytbPROCESO,
		ESTADO   tytbESTADO,
		OBSERVACION   tytbOBSERVACION,
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
		inuNOVETYPE_ID in LDCI_NOVDETA.NOVETYPE_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuNOVETYPE_ID in LDCI_NOVDETA.NOVETYPE_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuNOVETYPE_ID in LDCI_NOVDETA.NOVETYPE_ID%type
	);

	PROCEDURE getRecord
	(
		inuNOVETYPE_ID in LDCI_NOVDETA.NOVETYPE_ID%type,
		orcRecord out nocopy styLDCI_NOVDETA
	);

	FUNCTION frcGetRcData
	(
		inuNOVETYPE_ID in LDCI_NOVDETA.NOVETYPE_ID%type
	)
	RETURN styLDCI_NOVDETA;

	FUNCTION frcGetRcData
	RETURN styLDCI_NOVDETA;

	FUNCTION frcGetRecord
	(
		inuNOVETYPE_ID in LDCI_NOVDETA.NOVETYPE_ID%type
	)
	RETURN styLDCI_NOVDETA;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDCI_NOVDETA
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDCI_NOVDETA in styLDCI_NOVDETA
	);

	PROCEDURE insRecord
	(
		ircLDCI_NOVDETA in styLDCI_NOVDETA,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDCI_NOVDETA in out nocopy tytbLDCI_NOVDETA
	);

	PROCEDURE delRecord
	(
		inuNOVETYPE_ID in LDCI_NOVDETA.NOVETYPE_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDCI_NOVDETA in out nocopy tytbLDCI_NOVDETA,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDCI_NOVDETA in styLDCI_NOVDETA,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDCI_NOVDETA in out nocopy tytbLDCI_NOVDETA,
		inuLock in number default 1
	);

	PROCEDURE updDESCRIPCION
	(
		inuNOVETYPE_ID in LDCI_NOVDETA.NOVETYPE_ID%type,
		isbDESCRIPCION$ in LDCI_NOVDETA.DESCRIPCION%type,
		inuLock in number default 0
	);

	PROCEDURE updPROCESO
	(
		inuNOVETYPE_ID in LDCI_NOVDETA.NOVETYPE_ID%type,
		isbPROCESO$ in LDCI_NOVDETA.PROCESO%type,
		inuLock in number default 0
	);

	PROCEDURE updESTADO
	(
		inuNOVETYPE_ID in LDCI_NOVDETA.NOVETYPE_ID%type,
		isbESTADO$ in LDCI_NOVDETA.ESTADO%type,
		inuLock in number default 0
	);

	PROCEDURE updOBSERVACION
	(
		inuNOVETYPE_ID in LDCI_NOVDETA.NOVETYPE_ID%type,
		isbOBSERVACION$ in LDCI_NOVDETA.OBSERVACION%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetNOVETYPE_ID
	(
		inuNOVETYPE_ID in LDCI_NOVDETA.NOVETYPE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDCI_NOVDETA.NOVETYPE_ID%type;

	FUNCTION fsbGetDESCRIPCION
	(
		inuNOVETYPE_ID in LDCI_NOVDETA.NOVETYPE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDCI_NOVDETA.DESCRIPCION%type;

	FUNCTION fsbGetPROCESO
	(
		inuNOVETYPE_ID in LDCI_NOVDETA.NOVETYPE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDCI_NOVDETA.PROCESO%type;

	FUNCTION fsbGetESTADO
	(
		inuNOVETYPE_ID in LDCI_NOVDETA.NOVETYPE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDCI_NOVDETA.ESTADO%type;

	FUNCTION fsbGetOBSERVACION
	(
		inuNOVETYPE_ID in LDCI_NOVDETA.NOVETYPE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDCI_NOVDETA.OBSERVACION%type;


	PROCEDURE LockByPk
	(
		inuNOVETYPE_ID in LDCI_NOVDETA.NOVETYPE_ID%type,
		orcLDCI_NOVDETA  out styLDCI_NOVDETA
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDCI_NOVDETA  out styLDCI_NOVDETA
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDCI_NOVDETA;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALDCI_NOVDETA
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDCI_NOVDETA';
	 cnuGeEntityId constant varchar2(30) := 4197; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuNOVETYPE_ID in LDCI_NOVDETA.NOVETYPE_ID%type
	)
	IS
		SELECT LDCI_NOVDETA.*,LDCI_NOVDETA.rowid
		FROM LDCI_NOVDETA
		WHERE  NOVETYPE_ID = inuNOVETYPE_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDCI_NOVDETA.*,LDCI_NOVDETA.rowid
		FROM LDCI_NOVDETA
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDCI_NOVDETA is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDCI_NOVDETA;

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
	FUNCTION fsbPrimaryKey( rcI in styLDCI_NOVDETA default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.NOVETYPE_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuNOVETYPE_ID in LDCI_NOVDETA.NOVETYPE_ID%type,
		orcLDCI_NOVDETA  out styLDCI_NOVDETA
	)
	IS
		rcError styLDCI_NOVDETA;
	BEGIN
		rcError.NOVETYPE_ID := inuNOVETYPE_ID;

		Open cuLockRcByPk
		(
			inuNOVETYPE_ID
		);

		fetch cuLockRcByPk into orcLDCI_NOVDETA;
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
		orcLDCI_NOVDETA  out styLDCI_NOVDETA
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDCI_NOVDETA;
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
		itbLDCI_NOVDETA  in out nocopy tytbLDCI_NOVDETA
	)
	IS
	BEGIN
			rcRecOfTab.NOVETYPE_ID.delete;
			rcRecOfTab.DESCRIPCION.delete;
			rcRecOfTab.PROCESO.delete;
			rcRecOfTab.ESTADO.delete;
			rcRecOfTab.OBSERVACION.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDCI_NOVDETA  in out nocopy tytbLDCI_NOVDETA,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDCI_NOVDETA);

		for n in itbLDCI_NOVDETA.first .. itbLDCI_NOVDETA.last loop
			rcRecOfTab.NOVETYPE_ID(n) := itbLDCI_NOVDETA(n).NOVETYPE_ID;
			rcRecOfTab.DESCRIPCION(n) := itbLDCI_NOVDETA(n).DESCRIPCION;
			rcRecOfTab.PROCESO(n) := itbLDCI_NOVDETA(n).PROCESO;
			rcRecOfTab.ESTADO(n) := itbLDCI_NOVDETA(n).ESTADO;
			rcRecOfTab.OBSERVACION(n) := itbLDCI_NOVDETA(n).OBSERVACION;
			rcRecOfTab.row_id(n) := itbLDCI_NOVDETA(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuNOVETYPE_ID in LDCI_NOVDETA.NOVETYPE_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuNOVETYPE_ID
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
		inuNOVETYPE_ID in LDCI_NOVDETA.NOVETYPE_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuNOVETYPE_ID = rcData.NOVETYPE_ID
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
		inuNOVETYPE_ID in LDCI_NOVDETA.NOVETYPE_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuNOVETYPE_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuNOVETYPE_ID in LDCI_NOVDETA.NOVETYPE_ID%type
	)
	IS
		rcError styLDCI_NOVDETA;
	BEGIN		rcError.NOVETYPE_ID:=inuNOVETYPE_ID;

		Load
		(
			inuNOVETYPE_ID
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
		inuNOVETYPE_ID in LDCI_NOVDETA.NOVETYPE_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuNOVETYPE_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuNOVETYPE_ID in LDCI_NOVDETA.NOVETYPE_ID%type,
		orcRecord out nocopy styLDCI_NOVDETA
	)
	IS
		rcError styLDCI_NOVDETA;
	BEGIN		rcError.NOVETYPE_ID:=inuNOVETYPE_ID;

		Load
		(
			inuNOVETYPE_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuNOVETYPE_ID in LDCI_NOVDETA.NOVETYPE_ID%type
	)
	RETURN styLDCI_NOVDETA
	IS
		rcError styLDCI_NOVDETA;
	BEGIN
		rcError.NOVETYPE_ID:=inuNOVETYPE_ID;

		Load
		(
			inuNOVETYPE_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuNOVETYPE_ID in LDCI_NOVDETA.NOVETYPE_ID%type
	)
	RETURN styLDCI_NOVDETA
	IS
		rcError styLDCI_NOVDETA;
	BEGIN
		rcError.NOVETYPE_ID:=inuNOVETYPE_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuNOVETYPE_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuNOVETYPE_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDCI_NOVDETA
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDCI_NOVDETA
	)
	IS
		rfLDCI_NOVDETA tyrfLDCI_NOVDETA;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDCI_NOVDETA.*, LDCI_NOVDETA.rowid FROM LDCI_NOVDETA';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDCI_NOVDETA for sbFullQuery;

		fetch rfLDCI_NOVDETA bulk collect INTO otbResult;

		close rfLDCI_NOVDETA;
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
		sbSQL VARCHAR2 (32000) := 'select LDCI_NOVDETA.*, LDCI_NOVDETA.rowid FROM LDCI_NOVDETA';
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
		ircLDCI_NOVDETA in styLDCI_NOVDETA
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDCI_NOVDETA,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDCI_NOVDETA in styLDCI_NOVDETA,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDCI_NOVDETA.NOVETYPE_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|NOVETYPE_ID');
			raise ex.controlled_error;
		end if;

		insert into LDCI_NOVDETA
		(
			NOVETYPE_ID,
			DESCRIPCION,
			PROCESO,
			ESTADO,
			OBSERVACION
		)
		values
		(
			ircLDCI_NOVDETA.NOVETYPE_ID,
			ircLDCI_NOVDETA.DESCRIPCION,
			ircLDCI_NOVDETA.PROCESO,
			ircLDCI_NOVDETA.ESTADO,
			ircLDCI_NOVDETA.OBSERVACION
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDCI_NOVDETA));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDCI_NOVDETA in out nocopy tytbLDCI_NOVDETA
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDCI_NOVDETA,blUseRowID);
		forall n in iotbLDCI_NOVDETA.first..iotbLDCI_NOVDETA.last
			insert into LDCI_NOVDETA
			(
				NOVETYPE_ID,
				DESCRIPCION,
				PROCESO,
				ESTADO,
				OBSERVACION
			)
			values
			(
				rcRecOfTab.NOVETYPE_ID(n),
				rcRecOfTab.DESCRIPCION(n),
				rcRecOfTab.PROCESO(n),
				rcRecOfTab.ESTADO(n),
				rcRecOfTab.OBSERVACION(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuNOVETYPE_ID in LDCI_NOVDETA.NOVETYPE_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLDCI_NOVDETA;
	BEGIN
		rcError.NOVETYPE_ID := inuNOVETYPE_ID;

		if inuLock=1 then
			LockByPk
			(
				inuNOVETYPE_ID,
				rcData
			);
		end if;


		delete
		from LDCI_NOVDETA
		where
       		NOVETYPE_ID=inuNOVETYPE_ID;
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
		rcError  styLDCI_NOVDETA;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDCI_NOVDETA
		where
			rowid = iriRowID
		returning
			NOVETYPE_ID
		into
			rcError.NOVETYPE_ID;
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
		iotbLDCI_NOVDETA in out nocopy tytbLDCI_NOVDETA,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDCI_NOVDETA;
	BEGIN
		FillRecordOfTables(iotbLDCI_NOVDETA, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDCI_NOVDETA.first .. iotbLDCI_NOVDETA.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDCI_NOVDETA.first .. iotbLDCI_NOVDETA.last
				delete
				from LDCI_NOVDETA
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDCI_NOVDETA.first .. iotbLDCI_NOVDETA.last loop
					LockByPk
					(
						rcRecOfTab.NOVETYPE_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDCI_NOVDETA.first .. iotbLDCI_NOVDETA.last
				delete
				from LDCI_NOVDETA
				where
		         	NOVETYPE_ID = rcRecOfTab.NOVETYPE_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDCI_NOVDETA in styLDCI_NOVDETA,
		inuLock in number default 0
	)
	IS
		nuNOVETYPE_ID	LDCI_NOVDETA.NOVETYPE_ID%type;
	BEGIN
		if ircLDCI_NOVDETA.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDCI_NOVDETA.rowid,rcData);
			end if;
			update LDCI_NOVDETA
			set
				DESCRIPCION = ircLDCI_NOVDETA.DESCRIPCION,
				PROCESO = ircLDCI_NOVDETA.PROCESO,
				ESTADO = ircLDCI_NOVDETA.ESTADO,
				OBSERVACION = ircLDCI_NOVDETA.OBSERVACION
			where
				rowid = ircLDCI_NOVDETA.rowid
			returning
				NOVETYPE_ID
			into
				nuNOVETYPE_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDCI_NOVDETA.NOVETYPE_ID,
					rcData
				);
			end if;

			update LDCI_NOVDETA
			set
				DESCRIPCION = ircLDCI_NOVDETA.DESCRIPCION,
				PROCESO = ircLDCI_NOVDETA.PROCESO,
				ESTADO = ircLDCI_NOVDETA.ESTADO,
				OBSERVACION = ircLDCI_NOVDETA.OBSERVACION
			where
				NOVETYPE_ID = ircLDCI_NOVDETA.NOVETYPE_ID
			returning
				NOVETYPE_ID
			into
				nuNOVETYPE_ID;
		end if;
		if
			nuNOVETYPE_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDCI_NOVDETA));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDCI_NOVDETA in out nocopy tytbLDCI_NOVDETA,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDCI_NOVDETA;
	BEGIN
		FillRecordOfTables(iotbLDCI_NOVDETA,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDCI_NOVDETA.first .. iotbLDCI_NOVDETA.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDCI_NOVDETA.first .. iotbLDCI_NOVDETA.last
				update LDCI_NOVDETA
				set
					DESCRIPCION = rcRecOfTab.DESCRIPCION(n),
					PROCESO = rcRecOfTab.PROCESO(n),
					ESTADO = rcRecOfTab.ESTADO(n),
					OBSERVACION = rcRecOfTab.OBSERVACION(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDCI_NOVDETA.first .. iotbLDCI_NOVDETA.last loop
					LockByPk
					(
						rcRecOfTab.NOVETYPE_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDCI_NOVDETA.first .. iotbLDCI_NOVDETA.last
				update LDCI_NOVDETA
				SET
					DESCRIPCION = rcRecOfTab.DESCRIPCION(n),
					PROCESO = rcRecOfTab.PROCESO(n),
					ESTADO = rcRecOfTab.ESTADO(n),
					OBSERVACION = rcRecOfTab.OBSERVACION(n)
				where
					NOVETYPE_ID = rcRecOfTab.NOVETYPE_ID(n)
;
		end if;
	END;
	PROCEDURE updDESCRIPCION
	(
		inuNOVETYPE_ID in LDCI_NOVDETA.NOVETYPE_ID%type,
		isbDESCRIPCION$ in LDCI_NOVDETA.DESCRIPCION%type,
		inuLock in number default 0
	)
	IS
		rcError styLDCI_NOVDETA;
	BEGIN
		rcError.NOVETYPE_ID := inuNOVETYPE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuNOVETYPE_ID,
				rcData
			);
		end if;

		update LDCI_NOVDETA
		set
			DESCRIPCION = isbDESCRIPCION$
		where
			NOVETYPE_ID = inuNOVETYPE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DESCRIPCION:= isbDESCRIPCION$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPROCESO
	(
		inuNOVETYPE_ID in LDCI_NOVDETA.NOVETYPE_ID%type,
		isbPROCESO$ in LDCI_NOVDETA.PROCESO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDCI_NOVDETA;
	BEGIN
		rcError.NOVETYPE_ID := inuNOVETYPE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuNOVETYPE_ID,
				rcData
			);
		end if;

		update LDCI_NOVDETA
		set
			PROCESO = isbPROCESO$
		where
			NOVETYPE_ID = inuNOVETYPE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PROCESO:= isbPROCESO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updESTADO
	(
		inuNOVETYPE_ID in LDCI_NOVDETA.NOVETYPE_ID%type,
		isbESTADO$ in LDCI_NOVDETA.ESTADO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDCI_NOVDETA;
	BEGIN
		rcError.NOVETYPE_ID := inuNOVETYPE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuNOVETYPE_ID,
				rcData
			);
		end if;

		update LDCI_NOVDETA
		set
			ESTADO = isbESTADO$
		where
			NOVETYPE_ID = inuNOVETYPE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ESTADO:= isbESTADO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updOBSERVACION
	(
		inuNOVETYPE_ID in LDCI_NOVDETA.NOVETYPE_ID%type,
		isbOBSERVACION$ in LDCI_NOVDETA.OBSERVACION%type,
		inuLock in number default 0
	)
	IS
		rcError styLDCI_NOVDETA;
	BEGIN
		rcError.NOVETYPE_ID := inuNOVETYPE_ID;
		if inuLock=1 then
			LockByPk
			(
				inuNOVETYPE_ID,
				rcData
			);
		end if;

		update LDCI_NOVDETA
		set
			OBSERVACION = isbOBSERVACION$
		where
			NOVETYPE_ID = inuNOVETYPE_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.OBSERVACION:= isbOBSERVACION$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetNOVETYPE_ID
	(
		inuNOVETYPE_ID in LDCI_NOVDETA.NOVETYPE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDCI_NOVDETA.NOVETYPE_ID%type
	IS
		rcError styLDCI_NOVDETA;
	BEGIN

		rcError.NOVETYPE_ID := inuNOVETYPE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuNOVETYPE_ID
			 )
		then
			 return(rcData.NOVETYPE_ID);
		end if;
		Load
		(
		 		inuNOVETYPE_ID
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
	FUNCTION fsbGetDESCRIPCION
	(
		inuNOVETYPE_ID in LDCI_NOVDETA.NOVETYPE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDCI_NOVDETA.DESCRIPCION%type
	IS
		rcError styLDCI_NOVDETA;
	BEGIN

		rcError.NOVETYPE_ID := inuNOVETYPE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuNOVETYPE_ID
			 )
		then
			 return(rcData.DESCRIPCION);
		end if;
		Load
		(
		 		inuNOVETYPE_ID
		);
		return(rcData.DESCRIPCION);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetPROCESO
	(
		inuNOVETYPE_ID in LDCI_NOVDETA.NOVETYPE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDCI_NOVDETA.PROCESO%type
	IS
		rcError styLDCI_NOVDETA;
	BEGIN

		rcError.NOVETYPE_ID := inuNOVETYPE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuNOVETYPE_ID
			 )
		then
			 return(rcData.PROCESO);
		end if;
		Load
		(
		 		inuNOVETYPE_ID
		);
		return(rcData.PROCESO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetESTADO
	(
		inuNOVETYPE_ID in LDCI_NOVDETA.NOVETYPE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDCI_NOVDETA.ESTADO%type
	IS
		rcError styLDCI_NOVDETA;
	BEGIN

		rcError.NOVETYPE_ID := inuNOVETYPE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuNOVETYPE_ID
			 )
		then
			 return(rcData.ESTADO);
		end if;
		Load
		(
		 		inuNOVETYPE_ID
		);
		return(rcData.ESTADO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetOBSERVACION
	(
		inuNOVETYPE_ID in LDCI_NOVDETA.NOVETYPE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDCI_NOVDETA.OBSERVACION%type
	IS
		rcError styLDCI_NOVDETA;
	BEGIN

		rcError.NOVETYPE_ID := inuNOVETYPE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuNOVETYPE_ID
			 )
		then
			 return(rcData.OBSERVACION);
		end if;
		Load
		(
		 		inuNOVETYPE_ID
		);
		return(rcData.OBSERVACION);
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
end DALDCI_NOVDETA;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALDCI_NOVDETA
BEGIN
    pkg_utilidades.prAplicarPermisos('DALDCI_NOVDETA', 'ADM_PERSON'); 
END;
/

