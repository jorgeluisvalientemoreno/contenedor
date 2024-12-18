CREATE OR REPLACE PACKAGE adm_person.daldc_imcomael
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  11/06/2024   Adrianavg   OSF-2813: Migrar del esquema OPEN al esquema ADM_PERSON
  *************************************************************************
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuICMECODI in LDC_IMCOMAEL.ICMECODI%type
	)
	IS
		SELECT LDC_IMCOMAEL.*,LDC_IMCOMAEL.rowid
		FROM LDC_IMCOMAEL
		WHERE
		    ICMECODI = inuICMECODI;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_IMCOMAEL.*,LDC_IMCOMAEL.rowid
		FROM LDC_IMCOMAEL
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_IMCOMAEL  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_IMCOMAEL is table of styLDC_IMCOMAEL index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_IMCOMAEL;

	/* Tipos referenciando al registro */
	type tytbICMECODI is table of LDC_IMCOMAEL.ICMECODI%type index by binary_integer;
	type tytbICMEDESC is table of LDC_IMCOMAEL.ICMEDESC%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_IMCOMAEL is record
	(
		ICMECODI   tytbICMECODI,
		ICMEDESC   tytbICMEDESC,
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
		inuICMECODI in LDC_IMCOMAEL.ICMECODI%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuICMECODI in LDC_IMCOMAEL.ICMECODI%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuICMECODI in LDC_IMCOMAEL.ICMECODI%type
	);

	PROCEDURE getRecord
	(
		inuICMECODI in LDC_IMCOMAEL.ICMECODI%type,
		orcRecord out nocopy styLDC_IMCOMAEL
	);

	FUNCTION frcGetRcData
	(
		inuICMECODI in LDC_IMCOMAEL.ICMECODI%type
	)
	RETURN styLDC_IMCOMAEL;

	FUNCTION frcGetRcData
	RETURN styLDC_IMCOMAEL;

	FUNCTION frcGetRecord
	(
		inuICMECODI in LDC_IMCOMAEL.ICMECODI%type
	)
	RETURN styLDC_IMCOMAEL;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_IMCOMAEL
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_IMCOMAEL in styLDC_IMCOMAEL
	);

	PROCEDURE insRecord
	(
		ircLDC_IMCOMAEL in styLDC_IMCOMAEL,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_IMCOMAEL in out nocopy tytbLDC_IMCOMAEL
	);

	PROCEDURE delRecord
	(
		inuICMECODI in LDC_IMCOMAEL.ICMECODI%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_IMCOMAEL in out nocopy tytbLDC_IMCOMAEL,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_IMCOMAEL in styLDC_IMCOMAEL,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_IMCOMAEL in out nocopy tytbLDC_IMCOMAEL,
		inuLock in number default 1
	);

	PROCEDURE updICMEDESC
	(
		inuICMECODI in LDC_IMCOMAEL.ICMECODI%type,
		isbICMEDESC$ in LDC_IMCOMAEL.ICMEDESC%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetICMECODI
	(
		inuICMECODI in LDC_IMCOMAEL.ICMECODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_IMCOMAEL.ICMECODI%type;

	FUNCTION fsbGetICMEDESC
	(
		inuICMECODI in LDC_IMCOMAEL.ICMECODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_IMCOMAEL.ICMEDESC%type;


	PROCEDURE LockByPk
	(
		inuICMECODI in LDC_IMCOMAEL.ICMECODI%type,
		orcLDC_IMCOMAEL  out styLDC_IMCOMAEL
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_IMCOMAEL  out styLDC_IMCOMAEL
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_IMCOMAEL;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALDC_IMCOMAEL
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_IMCOMAEL';
	 cnuGeEntityId constant varchar2(30) := 4105; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuICMECODI in LDC_IMCOMAEL.ICMECODI%type
	)
	IS
		SELECT LDC_IMCOMAEL.*,LDC_IMCOMAEL.rowid
		FROM LDC_IMCOMAEL
		WHERE  ICMECODI = inuICMECODI
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_IMCOMAEL.*,LDC_IMCOMAEL.rowid
		FROM LDC_IMCOMAEL
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_IMCOMAEL is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_IMCOMAEL;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_IMCOMAEL default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.ICMECODI);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuICMECODI in LDC_IMCOMAEL.ICMECODI%type,
		orcLDC_IMCOMAEL  out styLDC_IMCOMAEL
	)
	IS
		rcError styLDC_IMCOMAEL;
	BEGIN
		rcError.ICMECODI := inuICMECODI;

		Open cuLockRcByPk
		(
			inuICMECODI
		);

		fetch cuLockRcByPk into orcLDC_IMCOMAEL;
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
		orcLDC_IMCOMAEL  out styLDC_IMCOMAEL
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_IMCOMAEL;
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
		itbLDC_IMCOMAEL  in out nocopy tytbLDC_IMCOMAEL
	)
	IS
	BEGIN
			rcRecOfTab.ICMECODI.delete;
			rcRecOfTab.ICMEDESC.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_IMCOMAEL  in out nocopy tytbLDC_IMCOMAEL,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_IMCOMAEL);

		for n in itbLDC_IMCOMAEL.first .. itbLDC_IMCOMAEL.last loop
			rcRecOfTab.ICMECODI(n) := itbLDC_IMCOMAEL(n).ICMECODI;
			rcRecOfTab.ICMEDESC(n) := itbLDC_IMCOMAEL(n).ICMEDESC;
			rcRecOfTab.row_id(n) := itbLDC_IMCOMAEL(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuICMECODI in LDC_IMCOMAEL.ICMECODI%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuICMECODI
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
		inuICMECODI in LDC_IMCOMAEL.ICMECODI%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuICMECODI = rcData.ICMECODI
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
		inuICMECODI in LDC_IMCOMAEL.ICMECODI%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuICMECODI
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuICMECODI in LDC_IMCOMAEL.ICMECODI%type
	)
	IS
		rcError styLDC_IMCOMAEL;
	BEGIN		rcError.ICMECODI:=inuICMECODI;

		Load
		(
			inuICMECODI
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
		inuICMECODI in LDC_IMCOMAEL.ICMECODI%type
	)
	IS
	BEGIN
		Load
		(
			inuICMECODI
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuICMECODI in LDC_IMCOMAEL.ICMECODI%type,
		orcRecord out nocopy styLDC_IMCOMAEL
	)
	IS
		rcError styLDC_IMCOMAEL;
	BEGIN		rcError.ICMECODI:=inuICMECODI;

		Load
		(
			inuICMECODI
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuICMECODI in LDC_IMCOMAEL.ICMECODI%type
	)
	RETURN styLDC_IMCOMAEL
	IS
		rcError styLDC_IMCOMAEL;
	BEGIN
		rcError.ICMECODI:=inuICMECODI;

		Load
		(
			inuICMECODI
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuICMECODI in LDC_IMCOMAEL.ICMECODI%type
	)
	RETURN styLDC_IMCOMAEL
	IS
		rcError styLDC_IMCOMAEL;
	BEGIN
		rcError.ICMECODI:=inuICMECODI;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuICMECODI
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuICMECODI
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_IMCOMAEL
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_IMCOMAEL
	)
	IS
		rfLDC_IMCOMAEL tyrfLDC_IMCOMAEL;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_IMCOMAEL.*, LDC_IMCOMAEL.rowid FROM LDC_IMCOMAEL';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_IMCOMAEL for sbFullQuery;

		fetch rfLDC_IMCOMAEL bulk collect INTO otbResult;

		close rfLDC_IMCOMAEL;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_IMCOMAEL.*, LDC_IMCOMAEL.rowid FROM LDC_IMCOMAEL';
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
		ircLDC_IMCOMAEL in styLDC_IMCOMAEL
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_IMCOMAEL,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_IMCOMAEL in styLDC_IMCOMAEL,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_IMCOMAEL.ICMECODI is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ICMECODI');
			raise ex.controlled_error;
		end if;

		insert into LDC_IMCOMAEL
		(
			ICMECODI,
			ICMEDESC
		)
		values
		(
			ircLDC_IMCOMAEL.ICMECODI,
			ircLDC_IMCOMAEL.ICMEDESC
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_IMCOMAEL));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_IMCOMAEL in out nocopy tytbLDC_IMCOMAEL
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_IMCOMAEL,blUseRowID);
		forall n in iotbLDC_IMCOMAEL.first..iotbLDC_IMCOMAEL.last
			insert into LDC_IMCOMAEL
			(
				ICMECODI,
				ICMEDESC
			)
			values
			(
				rcRecOfTab.ICMECODI(n),
				rcRecOfTab.ICMEDESC(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuICMECODI in LDC_IMCOMAEL.ICMECODI%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_IMCOMAEL;
	BEGIN
		rcError.ICMECODI := inuICMECODI;

		if inuLock=1 then
			LockByPk
			(
				inuICMECODI,
				rcData
			);
		end if;


		delete
		from LDC_IMCOMAEL
		where
       		ICMECODI=inuICMECODI;
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
		rcError  styLDC_IMCOMAEL;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_IMCOMAEL
		where
			rowid = iriRowID
		returning
			ICMECODI
		into
			rcError.ICMECODI;
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
		iotbLDC_IMCOMAEL in out nocopy tytbLDC_IMCOMAEL,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_IMCOMAEL;
	BEGIN
		FillRecordOfTables(iotbLDC_IMCOMAEL, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_IMCOMAEL.first .. iotbLDC_IMCOMAEL.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_IMCOMAEL.first .. iotbLDC_IMCOMAEL.last
				delete
				from LDC_IMCOMAEL
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_IMCOMAEL.first .. iotbLDC_IMCOMAEL.last loop
					LockByPk
					(
						rcRecOfTab.ICMECODI(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_IMCOMAEL.first .. iotbLDC_IMCOMAEL.last
				delete
				from LDC_IMCOMAEL
				where
		         	ICMECODI = rcRecOfTab.ICMECODI(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_IMCOMAEL in styLDC_IMCOMAEL,
		inuLock in number default 0
	)
	IS
		nuICMECODI	LDC_IMCOMAEL.ICMECODI%type;
	BEGIN
		if ircLDC_IMCOMAEL.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_IMCOMAEL.rowid,rcData);
			end if;
			update LDC_IMCOMAEL
			set
				ICMEDESC = ircLDC_IMCOMAEL.ICMEDESC
			where
				rowid = ircLDC_IMCOMAEL.rowid
			returning
				ICMECODI
			into
				nuICMECODI;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_IMCOMAEL.ICMECODI,
					rcData
				);
			end if;

			update LDC_IMCOMAEL
			set
				ICMEDESC = ircLDC_IMCOMAEL.ICMEDESC
			where
				ICMECODI = ircLDC_IMCOMAEL.ICMECODI
			returning
				ICMECODI
			into
				nuICMECODI;
		end if;
		if
			nuICMECODI is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_IMCOMAEL));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_IMCOMAEL in out nocopy tytbLDC_IMCOMAEL,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_IMCOMAEL;
	BEGIN
		FillRecordOfTables(iotbLDC_IMCOMAEL,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_IMCOMAEL.first .. iotbLDC_IMCOMAEL.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_IMCOMAEL.first .. iotbLDC_IMCOMAEL.last
				update LDC_IMCOMAEL
				set
					ICMEDESC = rcRecOfTab.ICMEDESC(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_IMCOMAEL.first .. iotbLDC_IMCOMAEL.last loop
					LockByPk
					(
						rcRecOfTab.ICMECODI(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_IMCOMAEL.first .. iotbLDC_IMCOMAEL.last
				update LDC_IMCOMAEL
				SET
					ICMEDESC = rcRecOfTab.ICMEDESC(n)
				where
					ICMECODI = rcRecOfTab.ICMECODI(n)
;
		end if;
	END;
	PROCEDURE updICMEDESC
	(
		inuICMECODI in LDC_IMCOMAEL.ICMECODI%type,
		isbICMEDESC$ in LDC_IMCOMAEL.ICMEDESC%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_IMCOMAEL;
	BEGIN
		rcError.ICMECODI := inuICMECODI;
		if inuLock=1 then
			LockByPk
			(
				inuICMECODI,
				rcData
			);
		end if;

		update LDC_IMCOMAEL
		set
			ICMEDESC = isbICMEDESC$
		where
			ICMECODI = inuICMECODI;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ICMEDESC:= isbICMEDESC$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetICMECODI
	(
		inuICMECODI in LDC_IMCOMAEL.ICMECODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_IMCOMAEL.ICMECODI%type
	IS
		rcError styLDC_IMCOMAEL;
	BEGIN

		rcError.ICMECODI := inuICMECODI;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuICMECODI
			 )
		then
			 return(rcData.ICMECODI);
		end if;
		Load
		(
		 		inuICMECODI
		);
		return(rcData.ICMECODI);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetICMEDESC
	(
		inuICMECODI in LDC_IMCOMAEL.ICMECODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_IMCOMAEL.ICMEDESC%type
	IS
		rcError styLDC_IMCOMAEL;
	BEGIN

		rcError.ICMECODI := inuICMECODI;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuICMECODI
			 )
		then
			 return(rcData.ICMEDESC);
		end if;
		Load
		(
		 		inuICMECODI
		);
		return(rcData.ICMEDESC);
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
end DALDC_IMCOMAEL;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALDC_IMCOMAEL
BEGIN
    pkg_utilidades.prAplicarPermisos('DALDC_IMCOMAEL', 'ADM_PERSON'); 
END;
/

