CREATE OR REPLACE PACKAGE adm_person.daldci_ctaifrs
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  11/06/2024   Adrianavg   OSF-2813: Migrar del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		isbCTAORIGEN in LDCI_CTAIFRS.CTAORIGEN%type
	)
	IS
		SELECT LDCI_CTAIFRS.*,LDCI_CTAIFRS.rowid
		FROM LDCI_CTAIFRS
		WHERE
		    CTAORIGEN = isbCTAORIGEN;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDCI_CTAIFRS.*,LDCI_CTAIFRS.rowid
		FROM LDCI_CTAIFRS
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDCI_CTAIFRS  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDCI_CTAIFRS is table of styLDCI_CTAIFRS index by binary_integer;
	type tyrfRecords is ref cursor return styLDCI_CTAIFRS;

	/* Tipos referenciando al registro */
	type tytbCTAORIGEN is table of LDCI_CTAIFRS.CTAORIGEN%type index by binary_integer;
	type tytbCTADESTINO is table of LDCI_CTAIFRS.CTADESTINO%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDCI_CTAIFRS is record
	(
		CTAORIGEN   tytbCTAORIGEN,
		CTADESTINO   tytbCTADESTINO,
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
		isbCTAORIGEN in LDCI_CTAIFRS.CTAORIGEN%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		isbCTAORIGEN in LDCI_CTAIFRS.CTAORIGEN%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		isbCTAORIGEN in LDCI_CTAIFRS.CTAORIGEN%type
	);

	PROCEDURE getRecord
	(
		isbCTAORIGEN in LDCI_CTAIFRS.CTAORIGEN%type,
		orcRecord out nocopy styLDCI_CTAIFRS
	);

	FUNCTION frcGetRcData
	(
		isbCTAORIGEN in LDCI_CTAIFRS.CTAORIGEN%type
	)
	RETURN styLDCI_CTAIFRS;

	FUNCTION frcGetRcData
	RETURN styLDCI_CTAIFRS;

	FUNCTION frcGetRecord
	(
		isbCTAORIGEN in LDCI_CTAIFRS.CTAORIGEN%type
	)
	RETURN styLDCI_CTAIFRS;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDCI_CTAIFRS
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDCI_CTAIFRS in styLDCI_CTAIFRS
	);

	PROCEDURE insRecord
	(
		ircLDCI_CTAIFRS in styLDCI_CTAIFRS,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDCI_CTAIFRS in out nocopy tytbLDCI_CTAIFRS
	);

	PROCEDURE delRecord
	(
		isbCTAORIGEN in LDCI_CTAIFRS.CTAORIGEN%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDCI_CTAIFRS in out nocopy tytbLDCI_CTAIFRS,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDCI_CTAIFRS in styLDCI_CTAIFRS,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDCI_CTAIFRS in out nocopy tytbLDCI_CTAIFRS,
		inuLock in number default 1
	);

	PROCEDURE updCTADESTINO
	(
		isbCTAORIGEN in LDCI_CTAIFRS.CTAORIGEN%type,
		isbCTADESTINO$ in LDCI_CTAIFRS.CTADESTINO%type,
		inuLock in number default 0
	);

	FUNCTION fsbGetCTAORIGEN
	(
		isbCTAORIGEN in LDCI_CTAIFRS.CTAORIGEN%type,
		inuRaiseError in number default 1
	)
	RETURN LDCI_CTAIFRS.CTAORIGEN%type;

	FUNCTION fsbGetCTADESTINO
	(
		isbCTAORIGEN in LDCI_CTAIFRS.CTAORIGEN%type,
		inuRaiseError in number default 1
	)
	RETURN LDCI_CTAIFRS.CTADESTINO%type;


	PROCEDURE LockByPk
	(
		isbCTAORIGEN in LDCI_CTAIFRS.CTAORIGEN%type,
		orcLDCI_CTAIFRS  out styLDCI_CTAIFRS
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDCI_CTAIFRS  out styLDCI_CTAIFRS
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDCI_CTAIFRS;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALDCI_CTAIFRS
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDCI_CTAIFRS';
	 cnuGeEntityId constant varchar2(30) := 8947; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		isbCTAORIGEN in LDCI_CTAIFRS.CTAORIGEN%type
	)
	IS
		SELECT LDCI_CTAIFRS.*,LDCI_CTAIFRS.rowid
		FROM LDCI_CTAIFRS
		WHERE  CTAORIGEN = isbCTAORIGEN
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDCI_CTAIFRS.*,LDCI_CTAIFRS.rowid
		FROM LDCI_CTAIFRS
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDCI_CTAIFRS is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDCI_CTAIFRS;

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
	FUNCTION fsbPrimaryKey( rcI in styLDCI_CTAIFRS default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.CTAORIGEN);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		isbCTAORIGEN in LDCI_CTAIFRS.CTAORIGEN%type,
		orcLDCI_CTAIFRS  out styLDCI_CTAIFRS
	)
	IS
		rcError styLDCI_CTAIFRS;
	BEGIN
		rcError.CTAORIGEN := isbCTAORIGEN;

		Open cuLockRcByPk
		(
			isbCTAORIGEN
		);

		fetch cuLockRcByPk into orcLDCI_CTAIFRS;
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
		orcLDCI_CTAIFRS  out styLDCI_CTAIFRS
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDCI_CTAIFRS;
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
		itbLDCI_CTAIFRS  in out nocopy tytbLDCI_CTAIFRS
	)
	IS
	BEGIN
			rcRecOfTab.CTAORIGEN.delete;
			rcRecOfTab.CTADESTINO.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDCI_CTAIFRS  in out nocopy tytbLDCI_CTAIFRS,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDCI_CTAIFRS);

		for n in itbLDCI_CTAIFRS.first .. itbLDCI_CTAIFRS.last loop
			rcRecOfTab.CTAORIGEN(n) := itbLDCI_CTAIFRS(n).CTAORIGEN;
			rcRecOfTab.CTADESTINO(n) := itbLDCI_CTAIFRS(n).CTADESTINO;
			rcRecOfTab.row_id(n) := itbLDCI_CTAIFRS(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		isbCTAORIGEN in LDCI_CTAIFRS.CTAORIGEN%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			isbCTAORIGEN
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
		isbCTAORIGEN in LDCI_CTAIFRS.CTAORIGEN%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			isbCTAORIGEN = rcData.CTAORIGEN
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
		isbCTAORIGEN in LDCI_CTAIFRS.CTAORIGEN%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			isbCTAORIGEN
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		isbCTAORIGEN in LDCI_CTAIFRS.CTAORIGEN%type
	)
	IS
		rcError styLDCI_CTAIFRS;
	BEGIN		rcError.CTAORIGEN:=isbCTAORIGEN;

		Load
		(
			isbCTAORIGEN
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
		isbCTAORIGEN in LDCI_CTAIFRS.CTAORIGEN%type
	)
	IS
	BEGIN
		Load
		(
			isbCTAORIGEN
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		isbCTAORIGEN in LDCI_CTAIFRS.CTAORIGEN%type,
		orcRecord out nocopy styLDCI_CTAIFRS
	)
	IS
		rcError styLDCI_CTAIFRS;
	BEGIN		rcError.CTAORIGEN:=isbCTAORIGEN;

		Load
		(
			isbCTAORIGEN
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		isbCTAORIGEN in LDCI_CTAIFRS.CTAORIGEN%type
	)
	RETURN styLDCI_CTAIFRS
	IS
		rcError styLDCI_CTAIFRS;
	BEGIN
		rcError.CTAORIGEN:=isbCTAORIGEN;

		Load
		(
			isbCTAORIGEN
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		isbCTAORIGEN in LDCI_CTAIFRS.CTAORIGEN%type
	)
	RETURN styLDCI_CTAIFRS
	IS
		rcError styLDCI_CTAIFRS;
	BEGIN
		rcError.CTAORIGEN:=isbCTAORIGEN;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			isbCTAORIGEN
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			isbCTAORIGEN
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDCI_CTAIFRS
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDCI_CTAIFRS
	)
	IS
		rfLDCI_CTAIFRS tyrfLDCI_CTAIFRS;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDCI_CTAIFRS.*, LDCI_CTAIFRS.rowid FROM LDCI_CTAIFRS';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDCI_CTAIFRS for sbFullQuery;

		fetch rfLDCI_CTAIFRS bulk collect INTO otbResult;

		close rfLDCI_CTAIFRS;
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
		sbSQL VARCHAR2 (32000) := 'select LDCI_CTAIFRS.*, LDCI_CTAIFRS.rowid FROM LDCI_CTAIFRS';
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
		ircLDCI_CTAIFRS in styLDCI_CTAIFRS
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDCI_CTAIFRS,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDCI_CTAIFRS in styLDCI_CTAIFRS,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDCI_CTAIFRS.CTAORIGEN is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|CTAORIGEN');
			raise ex.controlled_error;
		end if;

		insert into LDCI_CTAIFRS
		(
			CTAORIGEN,
			CTADESTINO
		)
		values
		(
			ircLDCI_CTAIFRS.CTAORIGEN,
			ircLDCI_CTAIFRS.CTADESTINO
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDCI_CTAIFRS));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDCI_CTAIFRS in out nocopy tytbLDCI_CTAIFRS
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDCI_CTAIFRS,blUseRowID);
		forall n in iotbLDCI_CTAIFRS.first..iotbLDCI_CTAIFRS.last
			insert into LDCI_CTAIFRS
			(
				CTAORIGEN,
				CTADESTINO
			)
			values
			(
				rcRecOfTab.CTAORIGEN(n),
				rcRecOfTab.CTADESTINO(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		isbCTAORIGEN in LDCI_CTAIFRS.CTAORIGEN%type,
		inuLock in number default 1
	)
	IS
		rcError styLDCI_CTAIFRS;
	BEGIN
		rcError.CTAORIGEN := isbCTAORIGEN;

		if inuLock=1 then
			LockByPk
			(
				isbCTAORIGEN,
				rcData
			);
		end if;


		delete
		from LDCI_CTAIFRS
		where
       		CTAORIGEN=isbCTAORIGEN;
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
		rcError  styLDCI_CTAIFRS;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDCI_CTAIFRS
		where
			rowid = iriRowID
		returning
			CTAORIGEN
		into
			rcError.CTAORIGEN;
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
		iotbLDCI_CTAIFRS in out nocopy tytbLDCI_CTAIFRS,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDCI_CTAIFRS;
	BEGIN
		FillRecordOfTables(iotbLDCI_CTAIFRS, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDCI_CTAIFRS.first .. iotbLDCI_CTAIFRS.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDCI_CTAIFRS.first .. iotbLDCI_CTAIFRS.last
				delete
				from LDCI_CTAIFRS
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDCI_CTAIFRS.first .. iotbLDCI_CTAIFRS.last loop
					LockByPk
					(
						rcRecOfTab.CTAORIGEN(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDCI_CTAIFRS.first .. iotbLDCI_CTAIFRS.last
				delete
				from LDCI_CTAIFRS
				where
		         	CTAORIGEN = rcRecOfTab.CTAORIGEN(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDCI_CTAIFRS in styLDCI_CTAIFRS,
		inuLock in number default 0
	)
	IS
		sbCTAORIGEN	LDCI_CTAIFRS.CTAORIGEN%type;
	BEGIN
		if ircLDCI_CTAIFRS.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDCI_CTAIFRS.rowid,rcData);
			end if;
			update LDCI_CTAIFRS
			set
				CTADESTINO = ircLDCI_CTAIFRS.CTADESTINO
			where
				rowid = ircLDCI_CTAIFRS.rowid
			returning
				CTAORIGEN
			into
				sbCTAORIGEN;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDCI_CTAIFRS.CTAORIGEN,
					rcData
				);
			end if;

			update LDCI_CTAIFRS
			set
				CTADESTINO = ircLDCI_CTAIFRS.CTADESTINO
			where
				CTAORIGEN = ircLDCI_CTAIFRS.CTAORIGEN
			returning
				CTAORIGEN
			into
				sbCTAORIGEN;
		end if;
		if
			sbCTAORIGEN is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDCI_CTAIFRS));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDCI_CTAIFRS in out nocopy tytbLDCI_CTAIFRS,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDCI_CTAIFRS;
	BEGIN
		FillRecordOfTables(iotbLDCI_CTAIFRS,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDCI_CTAIFRS.first .. iotbLDCI_CTAIFRS.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDCI_CTAIFRS.first .. iotbLDCI_CTAIFRS.last
				update LDCI_CTAIFRS
				set
					CTADESTINO = rcRecOfTab.CTADESTINO(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDCI_CTAIFRS.first .. iotbLDCI_CTAIFRS.last loop
					LockByPk
					(
						rcRecOfTab.CTAORIGEN(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDCI_CTAIFRS.first .. iotbLDCI_CTAIFRS.last
				update LDCI_CTAIFRS
				SET
					CTADESTINO = rcRecOfTab.CTADESTINO(n)
				where
					CTAORIGEN = rcRecOfTab.CTAORIGEN(n)
;
		end if;
	END;
	PROCEDURE updCTADESTINO
	(
		isbCTAORIGEN in LDCI_CTAIFRS.CTAORIGEN%type,
		isbCTADESTINO$ in LDCI_CTAIFRS.CTADESTINO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDCI_CTAIFRS;
	BEGIN
		rcError.CTAORIGEN := isbCTAORIGEN;
		if inuLock=1 then
			LockByPk
			(
				isbCTAORIGEN,
				rcData
			);
		end if;

		update LDCI_CTAIFRS
		set
			CTADESTINO = isbCTADESTINO$
		where
			CTAORIGEN = isbCTAORIGEN;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CTADESTINO:= isbCTADESTINO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fsbGetCTAORIGEN
	(
		isbCTAORIGEN in LDCI_CTAIFRS.CTAORIGEN%type,
		inuRaiseError in number default 1
	)
	RETURN LDCI_CTAIFRS.CTAORIGEN%type
	IS
		rcError styLDCI_CTAIFRS;
	BEGIN

		rcError.CTAORIGEN := isbCTAORIGEN;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		isbCTAORIGEN
			 )
		then
			 return(rcData.CTAORIGEN);
		end if;
		Load
		(
		 		isbCTAORIGEN
		);
		return(rcData.CTAORIGEN);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetCTADESTINO
	(
		isbCTAORIGEN in LDCI_CTAIFRS.CTAORIGEN%type,
		inuRaiseError in number default 1
	)
	RETURN LDCI_CTAIFRS.CTADESTINO%type
	IS
		rcError styLDCI_CTAIFRS;
	BEGIN

		rcError.CTAORIGEN := isbCTAORIGEN;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		isbCTAORIGEN
			 )
		then
			 return(rcData.CTADESTINO);
		end if;
		Load
		(
		 		isbCTAORIGEN
		);
		return(rcData.CTADESTINO);
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
end DALDCI_CTAIFRS;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALDCI_CTAIFRS
BEGIN
    pkg_utilidades.prAplicarPermisos('DALDCI_CTAIFRS', 'ADM_PERSON'); 
END;
/
