CREATE OR REPLACE PACKAGE adm_person.daldc_varicert
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  11/06/2024   Adrianavg   OSF-2813: Migrar del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuVACECODI in LDC_VARICERT.VACECODI%type
	)
	IS
		SELECT LDC_VARICERT.*,LDC_VARICERT.rowid
		FROM LDC_VARICERT
		WHERE
		    VACECODI = inuVACECODI;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_VARICERT.*,LDC_VARICERT.rowid
		FROM LDC_VARICERT
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_VARICERT  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_VARICERT is table of styLDC_VARICERT index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_VARICERT;

	/* Tipos referenciando al registro */
	type tytbVACECODI is table of LDC_VARICERT.VACECODI%type index by binary_integer;
	type tytbVACEDESC is table of LDC_VARICERT.VACEDESC%type index by binary_integer;
	type tytbVACEVAAT is table of LDC_VARICERT.VACEVAAT%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_VARICERT is record
	(
		VACECODI   tytbVACECODI,
		VACEDESC   tytbVACEDESC,
		VACEVAAT   tytbVACEVAAT,
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
		inuVACECODI in LDC_VARICERT.VACECODI%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuVACECODI in LDC_VARICERT.VACECODI%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuVACECODI in LDC_VARICERT.VACECODI%type
	);

	PROCEDURE getRecord
	(
		inuVACECODI in LDC_VARICERT.VACECODI%type,
		orcRecord out nocopy styLDC_VARICERT
	);

	FUNCTION frcGetRcData
	(
		inuVACECODI in LDC_VARICERT.VACECODI%type
	)
	RETURN styLDC_VARICERT;

	FUNCTION frcGetRcData
	RETURN styLDC_VARICERT;

	FUNCTION frcGetRecord
	(
		inuVACECODI in LDC_VARICERT.VACECODI%type
	)
	RETURN styLDC_VARICERT;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_VARICERT
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_VARICERT in styLDC_VARICERT
	);

	PROCEDURE insRecord
	(
		ircLDC_VARICERT in styLDC_VARICERT,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_VARICERT in out nocopy tytbLDC_VARICERT
	);

	PROCEDURE delRecord
	(
		inuVACECODI in LDC_VARICERT.VACECODI%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_VARICERT in out nocopy tytbLDC_VARICERT,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_VARICERT in styLDC_VARICERT,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_VARICERT in out nocopy tytbLDC_VARICERT,
		inuLock in number default 1
	);

	PROCEDURE updVACEDESC
	(
		inuVACECODI in LDC_VARICERT.VACECODI%type,
		isbVACEDESC$ in LDC_VARICERT.VACEDESC%type,
		inuLock in number default 0
	);

	PROCEDURE updVACEVAAT
	(
		inuVACECODI in LDC_VARICERT.VACECODI%type,
		isbVACEVAAT$ in LDC_VARICERT.VACEVAAT%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetVACECODI
	(
		inuVACECODI in LDC_VARICERT.VACECODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VARICERT.VACECODI%type;

	FUNCTION fsbGetVACEDESC
	(
		inuVACECODI in LDC_VARICERT.VACECODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VARICERT.VACEDESC%type;

	FUNCTION fsbGetVACEVAAT
	(
		inuVACECODI in LDC_VARICERT.VACECODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VARICERT.VACEVAAT%type;


	PROCEDURE LockByPk
	(
		inuVACECODI in LDC_VARICERT.VACECODI%type,
		orcLDC_VARICERT  out styLDC_VARICERT
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_VARICERT  out styLDC_VARICERT
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_VARICERT;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALDC_VARICERT
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_VARICERT';
	 cnuGeEntityId constant varchar2(30) := 8433; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuVACECODI in LDC_VARICERT.VACECODI%type
	)
	IS
		SELECT LDC_VARICERT.*,LDC_VARICERT.rowid
		FROM LDC_VARICERT
		WHERE  VACECODI = inuVACECODI
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_VARICERT.*,LDC_VARICERT.rowid
		FROM LDC_VARICERT
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_VARICERT is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_VARICERT;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_VARICERT default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.VACECODI);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuVACECODI in LDC_VARICERT.VACECODI%type,
		orcLDC_VARICERT  out styLDC_VARICERT
	)
	IS
		rcError styLDC_VARICERT;
	BEGIN
		rcError.VACECODI := inuVACECODI;

		Open cuLockRcByPk
		(
			inuVACECODI
		);

		fetch cuLockRcByPk into orcLDC_VARICERT;
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
		orcLDC_VARICERT  out styLDC_VARICERT
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_VARICERT;
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
		itbLDC_VARICERT  in out nocopy tytbLDC_VARICERT
	)
	IS
	BEGIN
			rcRecOfTab.VACECODI.delete;
			rcRecOfTab.VACEDESC.delete;
			rcRecOfTab.VACEVAAT.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_VARICERT  in out nocopy tytbLDC_VARICERT,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_VARICERT);

		for n in itbLDC_VARICERT.first .. itbLDC_VARICERT.last loop
			rcRecOfTab.VACECODI(n) := itbLDC_VARICERT(n).VACECODI;
			rcRecOfTab.VACEDESC(n) := itbLDC_VARICERT(n).VACEDESC;
			rcRecOfTab.VACEVAAT(n) := itbLDC_VARICERT(n).VACEVAAT;
			rcRecOfTab.row_id(n) := itbLDC_VARICERT(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuVACECODI in LDC_VARICERT.VACECODI%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuVACECODI
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
		inuVACECODI in LDC_VARICERT.VACECODI%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuVACECODI = rcData.VACECODI
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
		inuVACECODI in LDC_VARICERT.VACECODI%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuVACECODI
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuVACECODI in LDC_VARICERT.VACECODI%type
	)
	IS
		rcError styLDC_VARICERT;
	BEGIN		rcError.VACECODI:=inuVACECODI;

		Load
		(
			inuVACECODI
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
		inuVACECODI in LDC_VARICERT.VACECODI%type
	)
	IS
	BEGIN
		Load
		(
			inuVACECODI
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuVACECODI in LDC_VARICERT.VACECODI%type,
		orcRecord out nocopy styLDC_VARICERT
	)
	IS
		rcError styLDC_VARICERT;
	BEGIN		rcError.VACECODI:=inuVACECODI;

		Load
		(
			inuVACECODI
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuVACECODI in LDC_VARICERT.VACECODI%type
	)
	RETURN styLDC_VARICERT
	IS
		rcError styLDC_VARICERT;
	BEGIN
		rcError.VACECODI:=inuVACECODI;

		Load
		(
			inuVACECODI
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuVACECODI in LDC_VARICERT.VACECODI%type
	)
	RETURN styLDC_VARICERT
	IS
		rcError styLDC_VARICERT;
	BEGIN
		rcError.VACECODI:=inuVACECODI;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuVACECODI
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuVACECODI
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_VARICERT
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_VARICERT
	)
	IS
		rfLDC_VARICERT tyrfLDC_VARICERT;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_VARICERT.*, LDC_VARICERT.rowid FROM LDC_VARICERT';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_VARICERT for sbFullQuery;

		fetch rfLDC_VARICERT bulk collect INTO otbResult;

		close rfLDC_VARICERT;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_VARICERT.*, LDC_VARICERT.rowid FROM LDC_VARICERT';
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
		ircLDC_VARICERT in styLDC_VARICERT
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_VARICERT,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_VARICERT in styLDC_VARICERT,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_VARICERT.VACECODI is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|VACECODI');
			raise ex.controlled_error;
		end if;

		insert into LDC_VARICERT
		(
			VACECODI,
			VACEDESC,
			VACEVAAT
		)
		values
		(
			ircLDC_VARICERT.VACECODI,
			ircLDC_VARICERT.VACEDESC,
			ircLDC_VARICERT.VACEVAAT
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_VARICERT));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_VARICERT in out nocopy tytbLDC_VARICERT
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_VARICERT,blUseRowID);
		forall n in iotbLDC_VARICERT.first..iotbLDC_VARICERT.last
			insert into LDC_VARICERT
			(
				VACECODI,
				VACEDESC,
				VACEVAAT
			)
			values
			(
				rcRecOfTab.VACECODI(n),
				rcRecOfTab.VACEDESC(n),
				rcRecOfTab.VACEVAAT(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuVACECODI in LDC_VARICERT.VACECODI%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_VARICERT;
	BEGIN
		rcError.VACECODI := inuVACECODI;

		if inuLock=1 then
			LockByPk
			(
				inuVACECODI,
				rcData
			);
		end if;


		delete
		from LDC_VARICERT
		where
       		VACECODI=inuVACECODI;
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
		rcError  styLDC_VARICERT;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_VARICERT
		where
			rowid = iriRowID
		returning
			VACECODI
		into
			rcError.VACECODI;
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
		iotbLDC_VARICERT in out nocopy tytbLDC_VARICERT,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_VARICERT;
	BEGIN
		FillRecordOfTables(iotbLDC_VARICERT, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_VARICERT.first .. iotbLDC_VARICERT.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_VARICERT.first .. iotbLDC_VARICERT.last
				delete
				from LDC_VARICERT
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_VARICERT.first .. iotbLDC_VARICERT.last loop
					LockByPk
					(
						rcRecOfTab.VACECODI(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_VARICERT.first .. iotbLDC_VARICERT.last
				delete
				from LDC_VARICERT
				where
		         	VACECODI = rcRecOfTab.VACECODI(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_VARICERT in styLDC_VARICERT,
		inuLock in number default 0
	)
	IS
		nuVACECODI	LDC_VARICERT.VACECODI%type;
	BEGIN
		if ircLDC_VARICERT.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_VARICERT.rowid,rcData);
			end if;
			update LDC_VARICERT
			set
				VACEDESC = ircLDC_VARICERT.VACEDESC,
				VACEVAAT = ircLDC_VARICERT.VACEVAAT
			where
				rowid = ircLDC_VARICERT.rowid
			returning
				VACECODI
			into
				nuVACECODI;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_VARICERT.VACECODI,
					rcData
				);
			end if;

			update LDC_VARICERT
			set
				VACEDESC = ircLDC_VARICERT.VACEDESC,
				VACEVAAT = ircLDC_VARICERT.VACEVAAT
			where
				VACECODI = ircLDC_VARICERT.VACECODI
			returning
				VACECODI
			into
				nuVACECODI;
		end if;
		if
			nuVACECODI is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_VARICERT));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_VARICERT in out nocopy tytbLDC_VARICERT,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_VARICERT;
	BEGIN
		FillRecordOfTables(iotbLDC_VARICERT,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_VARICERT.first .. iotbLDC_VARICERT.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_VARICERT.first .. iotbLDC_VARICERT.last
				update LDC_VARICERT
				set
					VACEDESC = rcRecOfTab.VACEDESC(n),
					VACEVAAT = rcRecOfTab.VACEVAAT(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_VARICERT.first .. iotbLDC_VARICERT.last loop
					LockByPk
					(
						rcRecOfTab.VACECODI(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_VARICERT.first .. iotbLDC_VARICERT.last
				update LDC_VARICERT
				SET
					VACEDESC = rcRecOfTab.VACEDESC(n),
					VACEVAAT = rcRecOfTab.VACEVAAT(n)
				where
					VACECODI = rcRecOfTab.VACECODI(n)
;
		end if;
	END;
	PROCEDURE updVACEDESC
	(
		inuVACECODI in LDC_VARICERT.VACECODI%type,
		isbVACEDESC$ in LDC_VARICERT.VACEDESC%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_VARICERT;
	BEGIN
		rcError.VACECODI := inuVACECODI;
		if inuLock=1 then
			LockByPk
			(
				inuVACECODI,
				rcData
			);
		end if;

		update LDC_VARICERT
		set
			VACEDESC = isbVACEDESC$
		where
			VACECODI = inuVACECODI;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.VACEDESC:= isbVACEDESC$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updVACEVAAT
	(
		inuVACECODI in LDC_VARICERT.VACECODI%type,
		isbVACEVAAT$ in LDC_VARICERT.VACEVAAT%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_VARICERT;
	BEGIN
		rcError.VACECODI := inuVACECODI;
		if inuLock=1 then
			LockByPk
			(
				inuVACECODI,
				rcData
			);
		end if;

		update LDC_VARICERT
		set
			VACEVAAT = isbVACEVAAT$
		where
			VACECODI = inuVACECODI;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.VACEVAAT:= isbVACEVAAT$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetVACECODI
	(
		inuVACECODI in LDC_VARICERT.VACECODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VARICERT.VACECODI%type
	IS
		rcError styLDC_VARICERT;
	BEGIN

		rcError.VACECODI := inuVACECODI;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuVACECODI
			 )
		then
			 return(rcData.VACECODI);
		end if;
		Load
		(
		 		inuVACECODI
		);
		return(rcData.VACECODI);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetVACEDESC
	(
		inuVACECODI in LDC_VARICERT.VACECODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VARICERT.VACEDESC%type
	IS
		rcError styLDC_VARICERT;
	BEGIN

		rcError.VACECODI := inuVACECODI;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuVACECODI
			 )
		then
			 return(rcData.VACEDESC);
		end if;
		Load
		(
		 		inuVACECODI
		);
		return(rcData.VACEDESC);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetVACEVAAT
	(
		inuVACECODI in LDC_VARICERT.VACECODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VARICERT.VACEVAAT%type
	IS
		rcError styLDC_VARICERT;
	BEGIN

		rcError.VACECODI := inuVACECODI;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuVACECODI
			 )
		then
			 return(rcData.VACEVAAT);
		end if;
		Load
		(
		 		inuVACECODI
		);
		return(rcData.VACEVAAT);
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
end DALDC_VARICERT;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALDC_VARICERT
BEGIN
    pkg_utilidades.prAplicarPermisos('DALDC_VARICERT', 'ADM_PERSON'); 
END;
/
