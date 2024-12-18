CREATE OR REPLACE PACKAGE adm_person.daldc_imcoelma
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  11/06/2024   Adrianavg   OSF-2813: Migrar del esquema OPEN al esquema ADM_PERSON
  *************************************************************************
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuICEMCODI in LDC_IMCOELMA.ICEMCODI%type
	)
	IS
		SELECT LDC_IMCOELMA.*,LDC_IMCOELMA.rowid
		FROM LDC_IMCOELMA
		WHERE
		    ICEMCODI = inuICEMCODI;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_IMCOELMA.*,LDC_IMCOELMA.rowid
		FROM LDC_IMCOELMA
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_IMCOELMA  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_IMCOELMA is table of styLDC_IMCOELMA index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_IMCOELMA;

	/* Tipos referenciando al registro */
	type tytbICEMCODI is table of LDC_IMCOELMA.ICEMCODI%type index by binary_integer;
	type tytbICEMELEM is table of LDC_IMCOELMA.ICEMELEM%type index by binary_integer;
	type tytbICEMMAEL is table of LDC_IMCOELMA.ICEMMAEL%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_IMCOELMA is record
	(
		ICEMCODI   tytbICEMCODI,
		ICEMELEM   tytbICEMELEM,
		ICEMMAEL   tytbICEMMAEL,
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
		inuICEMCODI in LDC_IMCOELMA.ICEMCODI%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuICEMCODI in LDC_IMCOELMA.ICEMCODI%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuICEMCODI in LDC_IMCOELMA.ICEMCODI%type
	);

	PROCEDURE getRecord
	(
		inuICEMCODI in LDC_IMCOELMA.ICEMCODI%type,
		orcRecord out nocopy styLDC_IMCOELMA
	);

	FUNCTION frcGetRcData
	(
		inuICEMCODI in LDC_IMCOELMA.ICEMCODI%type
	)
	RETURN styLDC_IMCOELMA;

	FUNCTION frcGetRcData
	RETURN styLDC_IMCOELMA;

	FUNCTION frcGetRecord
	(
		inuICEMCODI in LDC_IMCOELMA.ICEMCODI%type
	)
	RETURN styLDC_IMCOELMA;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_IMCOELMA
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_IMCOELMA in styLDC_IMCOELMA
	);

	PROCEDURE insRecord
	(
		ircLDC_IMCOELMA in styLDC_IMCOELMA,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_IMCOELMA in out nocopy tytbLDC_IMCOELMA
	);

	PROCEDURE delRecord
	(
		inuICEMCODI in LDC_IMCOELMA.ICEMCODI%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_IMCOELMA in out nocopy tytbLDC_IMCOELMA,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_IMCOELMA in styLDC_IMCOELMA,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_IMCOELMA in out nocopy tytbLDC_IMCOELMA,
		inuLock in number default 1
	);

	PROCEDURE updICEMELEM
	(
		inuICEMCODI in LDC_IMCOELMA.ICEMCODI%type,
		isbICEMELEM$ in LDC_IMCOELMA.ICEMELEM%type,
		inuLock in number default 0
	);

	PROCEDURE updICEMMAEL
	(
		inuICEMCODI in LDC_IMCOELMA.ICEMCODI%type,
		inuICEMMAEL$ in LDC_IMCOELMA.ICEMMAEL%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetICEMCODI
	(
		inuICEMCODI in LDC_IMCOELMA.ICEMCODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_IMCOELMA.ICEMCODI%type;

	FUNCTION fsbGetICEMELEM
	(
		inuICEMCODI in LDC_IMCOELMA.ICEMCODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_IMCOELMA.ICEMELEM%type;

	FUNCTION fnuGetICEMMAEL
	(
		inuICEMCODI in LDC_IMCOELMA.ICEMCODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_IMCOELMA.ICEMMAEL%type;


	PROCEDURE LockByPk
	(
		inuICEMCODI in LDC_IMCOELMA.ICEMCODI%type,
		orcLDC_IMCOELMA  out styLDC_IMCOELMA
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_IMCOELMA  out styLDC_IMCOELMA
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_IMCOELMA;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALDC_IMCOELMA
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_IMCOELMA';
	 cnuGeEntityId constant varchar2(30) := 4104; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuICEMCODI in LDC_IMCOELMA.ICEMCODI%type
	)
	IS
		SELECT LDC_IMCOELMA.*,LDC_IMCOELMA.rowid
		FROM LDC_IMCOELMA
		WHERE  ICEMCODI = inuICEMCODI
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_IMCOELMA.*,LDC_IMCOELMA.rowid
		FROM LDC_IMCOELMA
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_IMCOELMA is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_IMCOELMA;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_IMCOELMA default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.ICEMCODI);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuICEMCODI in LDC_IMCOELMA.ICEMCODI%type,
		orcLDC_IMCOELMA  out styLDC_IMCOELMA
	)
	IS
		rcError styLDC_IMCOELMA;
	BEGIN
		rcError.ICEMCODI := inuICEMCODI;

		Open cuLockRcByPk
		(
			inuICEMCODI
		);

		fetch cuLockRcByPk into orcLDC_IMCOELMA;
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
		orcLDC_IMCOELMA  out styLDC_IMCOELMA
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_IMCOELMA;
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
		itbLDC_IMCOELMA  in out nocopy tytbLDC_IMCOELMA
	)
	IS
	BEGIN
			rcRecOfTab.ICEMCODI.delete;
			rcRecOfTab.ICEMELEM.delete;
			rcRecOfTab.ICEMMAEL.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_IMCOELMA  in out nocopy tytbLDC_IMCOELMA,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_IMCOELMA);

		for n in itbLDC_IMCOELMA.first .. itbLDC_IMCOELMA.last loop
			rcRecOfTab.ICEMCODI(n) := itbLDC_IMCOELMA(n).ICEMCODI;
			rcRecOfTab.ICEMELEM(n) := itbLDC_IMCOELMA(n).ICEMELEM;
			rcRecOfTab.ICEMMAEL(n) := itbLDC_IMCOELMA(n).ICEMMAEL;
			rcRecOfTab.row_id(n) := itbLDC_IMCOELMA(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuICEMCODI in LDC_IMCOELMA.ICEMCODI%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuICEMCODI
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
		inuICEMCODI in LDC_IMCOELMA.ICEMCODI%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuICEMCODI = rcData.ICEMCODI
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
		inuICEMCODI in LDC_IMCOELMA.ICEMCODI%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuICEMCODI
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuICEMCODI in LDC_IMCOELMA.ICEMCODI%type
	)
	IS
		rcError styLDC_IMCOELMA;
	BEGIN		rcError.ICEMCODI:=inuICEMCODI;

		Load
		(
			inuICEMCODI
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
		inuICEMCODI in LDC_IMCOELMA.ICEMCODI%type
	)
	IS
	BEGIN
		Load
		(
			inuICEMCODI
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuICEMCODI in LDC_IMCOELMA.ICEMCODI%type,
		orcRecord out nocopy styLDC_IMCOELMA
	)
	IS
		rcError styLDC_IMCOELMA;
	BEGIN		rcError.ICEMCODI:=inuICEMCODI;

		Load
		(
			inuICEMCODI
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuICEMCODI in LDC_IMCOELMA.ICEMCODI%type
	)
	RETURN styLDC_IMCOELMA
	IS
		rcError styLDC_IMCOELMA;
	BEGIN
		rcError.ICEMCODI:=inuICEMCODI;

		Load
		(
			inuICEMCODI
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuICEMCODI in LDC_IMCOELMA.ICEMCODI%type
	)
	RETURN styLDC_IMCOELMA
	IS
		rcError styLDC_IMCOELMA;
	BEGIN
		rcError.ICEMCODI:=inuICEMCODI;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuICEMCODI
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuICEMCODI
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_IMCOELMA
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_IMCOELMA
	)
	IS
		rfLDC_IMCOELMA tyrfLDC_IMCOELMA;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_IMCOELMA.*, LDC_IMCOELMA.rowid FROM LDC_IMCOELMA';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_IMCOELMA for sbFullQuery;

		fetch rfLDC_IMCOELMA bulk collect INTO otbResult;

		close rfLDC_IMCOELMA;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_IMCOELMA.*, LDC_IMCOELMA.rowid FROM LDC_IMCOELMA';
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
		ircLDC_IMCOELMA in styLDC_IMCOELMA
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_IMCOELMA,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_IMCOELMA in styLDC_IMCOELMA,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_IMCOELMA.ICEMCODI is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ICEMCODI');
			raise ex.controlled_error;
		end if;

		insert into LDC_IMCOELMA
		(
			ICEMCODI,
			ICEMELEM,
			ICEMMAEL
		)
		values
		(
			ircLDC_IMCOELMA.ICEMCODI,
			ircLDC_IMCOELMA.ICEMELEM,
			ircLDC_IMCOELMA.ICEMMAEL
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_IMCOELMA));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_IMCOELMA in out nocopy tytbLDC_IMCOELMA
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_IMCOELMA,blUseRowID);
		forall n in iotbLDC_IMCOELMA.first..iotbLDC_IMCOELMA.last
			insert into LDC_IMCOELMA
			(
				ICEMCODI,
				ICEMELEM,
				ICEMMAEL
			)
			values
			(
				rcRecOfTab.ICEMCODI(n),
				rcRecOfTab.ICEMELEM(n),
				rcRecOfTab.ICEMMAEL(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuICEMCODI in LDC_IMCOELMA.ICEMCODI%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_IMCOELMA;
	BEGIN
		rcError.ICEMCODI := inuICEMCODI;

		if inuLock=1 then
			LockByPk
			(
				inuICEMCODI,
				rcData
			);
		end if;


		delete
		from LDC_IMCOELMA
		where
       		ICEMCODI=inuICEMCODI;
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
		rcError  styLDC_IMCOELMA;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_IMCOELMA
		where
			rowid = iriRowID
		returning
			ICEMCODI
		into
			rcError.ICEMCODI;
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
		iotbLDC_IMCOELMA in out nocopy tytbLDC_IMCOELMA,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_IMCOELMA;
	BEGIN
		FillRecordOfTables(iotbLDC_IMCOELMA, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_IMCOELMA.first .. iotbLDC_IMCOELMA.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_IMCOELMA.first .. iotbLDC_IMCOELMA.last
				delete
				from LDC_IMCOELMA
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_IMCOELMA.first .. iotbLDC_IMCOELMA.last loop
					LockByPk
					(
						rcRecOfTab.ICEMCODI(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_IMCOELMA.first .. iotbLDC_IMCOELMA.last
				delete
				from LDC_IMCOELMA
				where
		         	ICEMCODI = rcRecOfTab.ICEMCODI(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_IMCOELMA in styLDC_IMCOELMA,
		inuLock in number default 0
	)
	IS
		nuICEMCODI	LDC_IMCOELMA.ICEMCODI%type;
	BEGIN
		if ircLDC_IMCOELMA.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_IMCOELMA.rowid,rcData);
			end if;
			update LDC_IMCOELMA
			set
				ICEMELEM = ircLDC_IMCOELMA.ICEMELEM,
				ICEMMAEL = ircLDC_IMCOELMA.ICEMMAEL
			where
				rowid = ircLDC_IMCOELMA.rowid
			returning
				ICEMCODI
			into
				nuICEMCODI;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_IMCOELMA.ICEMCODI,
					rcData
				);
			end if;

			update LDC_IMCOELMA
			set
				ICEMELEM = ircLDC_IMCOELMA.ICEMELEM,
				ICEMMAEL = ircLDC_IMCOELMA.ICEMMAEL
			where
				ICEMCODI = ircLDC_IMCOELMA.ICEMCODI
			returning
				ICEMCODI
			into
				nuICEMCODI;
		end if;
		if
			nuICEMCODI is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_IMCOELMA));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_IMCOELMA in out nocopy tytbLDC_IMCOELMA,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_IMCOELMA;
	BEGIN
		FillRecordOfTables(iotbLDC_IMCOELMA,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_IMCOELMA.first .. iotbLDC_IMCOELMA.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_IMCOELMA.first .. iotbLDC_IMCOELMA.last
				update LDC_IMCOELMA
				set
					ICEMELEM = rcRecOfTab.ICEMELEM(n),
					ICEMMAEL = rcRecOfTab.ICEMMAEL(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_IMCOELMA.first .. iotbLDC_IMCOELMA.last loop
					LockByPk
					(
						rcRecOfTab.ICEMCODI(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_IMCOELMA.first .. iotbLDC_IMCOELMA.last
				update LDC_IMCOELMA
				SET
					ICEMELEM = rcRecOfTab.ICEMELEM(n),
					ICEMMAEL = rcRecOfTab.ICEMMAEL(n)
				where
					ICEMCODI = rcRecOfTab.ICEMCODI(n)
;
		end if;
	END;
	PROCEDURE updICEMELEM
	(
		inuICEMCODI in LDC_IMCOELMA.ICEMCODI%type,
		isbICEMELEM$ in LDC_IMCOELMA.ICEMELEM%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_IMCOELMA;
	BEGIN
		rcError.ICEMCODI := inuICEMCODI;
		if inuLock=1 then
			LockByPk
			(
				inuICEMCODI,
				rcData
			);
		end if;

		update LDC_IMCOELMA
		set
			ICEMELEM = isbICEMELEM$
		where
			ICEMCODI = inuICEMCODI;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ICEMELEM:= isbICEMELEM$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updICEMMAEL
	(
		inuICEMCODI in LDC_IMCOELMA.ICEMCODI%type,
		inuICEMMAEL$ in LDC_IMCOELMA.ICEMMAEL%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_IMCOELMA;
	BEGIN
		rcError.ICEMCODI := inuICEMCODI;
		if inuLock=1 then
			LockByPk
			(
				inuICEMCODI,
				rcData
			);
		end if;

		update LDC_IMCOELMA
		set
			ICEMMAEL = inuICEMMAEL$
		where
			ICEMCODI = inuICEMCODI;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ICEMMAEL:= inuICEMMAEL$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetICEMCODI
	(
		inuICEMCODI in LDC_IMCOELMA.ICEMCODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_IMCOELMA.ICEMCODI%type
	IS
		rcError styLDC_IMCOELMA;
	BEGIN

		rcError.ICEMCODI := inuICEMCODI;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuICEMCODI
			 )
		then
			 return(rcData.ICEMCODI);
		end if;
		Load
		(
		 		inuICEMCODI
		);
		return(rcData.ICEMCODI);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetICEMELEM
	(
		inuICEMCODI in LDC_IMCOELMA.ICEMCODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_IMCOELMA.ICEMELEM%type
	IS
		rcError styLDC_IMCOELMA;
	BEGIN

		rcError.ICEMCODI := inuICEMCODI;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuICEMCODI
			 )
		then
			 return(rcData.ICEMELEM);
		end if;
		Load
		(
		 		inuICEMCODI
		);
		return(rcData.ICEMELEM);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetICEMMAEL
	(
		inuICEMCODI in LDC_IMCOELMA.ICEMCODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_IMCOELMA.ICEMMAEL%type
	IS
		rcError styLDC_IMCOELMA;
	BEGIN

		rcError.ICEMCODI := inuICEMCODI;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuICEMCODI
			 )
		then
			 return(rcData.ICEMMAEL);
		end if;
		Load
		(
		 		inuICEMCODI
		);
		return(rcData.ICEMMAEL);
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
end DALDC_IMCOELMA;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALDC_IMCOELMA
BEGIN
    pkg_utilidades.prAplicarPermisos('DALDC_IMCOELMA', 'ADM_PERSON'); 
END;
/
