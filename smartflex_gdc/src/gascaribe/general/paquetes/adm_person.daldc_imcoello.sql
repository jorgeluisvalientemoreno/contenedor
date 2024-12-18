CREATE OR REPLACE PACKAGE adm_person.daldc_imcoello
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  11/06/2024   Adrianavg   OSF-2813: Migrar del esquema OPEN al esquema ADM_PERSON
  *************************************************************************
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuICELCODI in LDC_IMCOELLO.ICELCODI%type
	)
	IS
		SELECT LDC_IMCOELLO.*,LDC_IMCOELLO.rowid
		FROM LDC_IMCOELLO
		WHERE
		    ICELCODI = inuICELCODI;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_IMCOELLO.*,LDC_IMCOELLO.rowid
		FROM LDC_IMCOELLO
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_IMCOELLO  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_IMCOELLO is table of styLDC_IMCOELLO index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_IMCOELLO;

	/* Tipos referenciando al registro */
	type tytbICELCODI is table of LDC_IMCOELLO.ICELCODI%type index by binary_integer;
	type tytbICELELEM is table of LDC_IMCOELLO.ICELELEM%type index by binary_integer;
	type tytbICELLOCA is table of LDC_IMCOELLO.ICELLOCA%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_IMCOELLO is record
	(
		ICELCODI   tytbICELCODI,
		ICELELEM   tytbICELELEM,
		ICELLOCA   tytbICELLOCA,
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
		inuICELCODI in LDC_IMCOELLO.ICELCODI%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuICELCODI in LDC_IMCOELLO.ICELCODI%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuICELCODI in LDC_IMCOELLO.ICELCODI%type
	);

	PROCEDURE getRecord
	(
		inuICELCODI in LDC_IMCOELLO.ICELCODI%type,
		orcRecord out nocopy styLDC_IMCOELLO
	);

	FUNCTION frcGetRcData
	(
		inuICELCODI in LDC_IMCOELLO.ICELCODI%type
	)
	RETURN styLDC_IMCOELLO;

	FUNCTION frcGetRcData
	RETURN styLDC_IMCOELLO;

	FUNCTION frcGetRecord
	(
		inuICELCODI in LDC_IMCOELLO.ICELCODI%type
	)
	RETURN styLDC_IMCOELLO;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_IMCOELLO
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_IMCOELLO in styLDC_IMCOELLO
	);

	PROCEDURE insRecord
	(
		ircLDC_IMCOELLO in styLDC_IMCOELLO,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_IMCOELLO in out nocopy tytbLDC_IMCOELLO
	);

	PROCEDURE delRecord
	(
		inuICELCODI in LDC_IMCOELLO.ICELCODI%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_IMCOELLO in out nocopy tytbLDC_IMCOELLO,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_IMCOELLO in styLDC_IMCOELLO,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_IMCOELLO in out nocopy tytbLDC_IMCOELLO,
		inuLock in number default 1
	);

	PROCEDURE updICELELEM
	(
		inuICELCODI in LDC_IMCOELLO.ICELCODI%type,
		isbICELELEM$ in LDC_IMCOELLO.ICELELEM%type,
		inuLock in number default 0
	);

	PROCEDURE updICELLOCA
	(
		inuICELCODI in LDC_IMCOELLO.ICELCODI%type,
		inuICELLOCA$ in LDC_IMCOELLO.ICELLOCA%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetICELCODI
	(
		inuICELCODI in LDC_IMCOELLO.ICELCODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_IMCOELLO.ICELCODI%type;

	FUNCTION fsbGetICELELEM
	(
		inuICELCODI in LDC_IMCOELLO.ICELCODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_IMCOELLO.ICELELEM%type;

	FUNCTION fnuGetICELLOCA
	(
		inuICELCODI in LDC_IMCOELLO.ICELCODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_IMCOELLO.ICELLOCA%type;


	PROCEDURE LockByPk
	(
		inuICELCODI in LDC_IMCOELLO.ICELCODI%type,
		orcLDC_IMCOELLO  out styLDC_IMCOELLO
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_IMCOELLO  out styLDC_IMCOELLO
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_IMCOELLO;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALDC_IMCOELLO
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_IMCOELLO';
	 cnuGeEntityId constant varchar2(30) := 4103; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuICELCODI in LDC_IMCOELLO.ICELCODI%type
	)
	IS
		SELECT LDC_IMCOELLO.*,LDC_IMCOELLO.rowid
		FROM LDC_IMCOELLO
		WHERE  ICELCODI = inuICELCODI
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_IMCOELLO.*,LDC_IMCOELLO.rowid
		FROM LDC_IMCOELLO
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_IMCOELLO is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_IMCOELLO;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_IMCOELLO default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.ICELCODI);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuICELCODI in LDC_IMCOELLO.ICELCODI%type,
		orcLDC_IMCOELLO  out styLDC_IMCOELLO
	)
	IS
		rcError styLDC_IMCOELLO;
	BEGIN
		rcError.ICELCODI := inuICELCODI;

		Open cuLockRcByPk
		(
			inuICELCODI
		);

		fetch cuLockRcByPk into orcLDC_IMCOELLO;
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
		orcLDC_IMCOELLO  out styLDC_IMCOELLO
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_IMCOELLO;
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
		itbLDC_IMCOELLO  in out nocopy tytbLDC_IMCOELLO
	)
	IS
	BEGIN
			rcRecOfTab.ICELCODI.delete;
			rcRecOfTab.ICELELEM.delete;
			rcRecOfTab.ICELLOCA.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_IMCOELLO  in out nocopy tytbLDC_IMCOELLO,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_IMCOELLO);

		for n in itbLDC_IMCOELLO.first .. itbLDC_IMCOELLO.last loop
			rcRecOfTab.ICELCODI(n) := itbLDC_IMCOELLO(n).ICELCODI;
			rcRecOfTab.ICELELEM(n) := itbLDC_IMCOELLO(n).ICELELEM;
			rcRecOfTab.ICELLOCA(n) := itbLDC_IMCOELLO(n).ICELLOCA;
			rcRecOfTab.row_id(n) := itbLDC_IMCOELLO(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuICELCODI in LDC_IMCOELLO.ICELCODI%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuICELCODI
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
		inuICELCODI in LDC_IMCOELLO.ICELCODI%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuICELCODI = rcData.ICELCODI
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
		inuICELCODI in LDC_IMCOELLO.ICELCODI%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuICELCODI
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuICELCODI in LDC_IMCOELLO.ICELCODI%type
	)
	IS
		rcError styLDC_IMCOELLO;
	BEGIN		rcError.ICELCODI:=inuICELCODI;

		Load
		(
			inuICELCODI
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
		inuICELCODI in LDC_IMCOELLO.ICELCODI%type
	)
	IS
	BEGIN
		Load
		(
			inuICELCODI
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuICELCODI in LDC_IMCOELLO.ICELCODI%type,
		orcRecord out nocopy styLDC_IMCOELLO
	)
	IS
		rcError styLDC_IMCOELLO;
	BEGIN		rcError.ICELCODI:=inuICELCODI;

		Load
		(
			inuICELCODI
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuICELCODI in LDC_IMCOELLO.ICELCODI%type
	)
	RETURN styLDC_IMCOELLO
	IS
		rcError styLDC_IMCOELLO;
	BEGIN
		rcError.ICELCODI:=inuICELCODI;

		Load
		(
			inuICELCODI
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuICELCODI in LDC_IMCOELLO.ICELCODI%type
	)
	RETURN styLDC_IMCOELLO
	IS
		rcError styLDC_IMCOELLO;
	BEGIN
		rcError.ICELCODI:=inuICELCODI;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuICELCODI
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuICELCODI
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_IMCOELLO
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_IMCOELLO
	)
	IS
		rfLDC_IMCOELLO tyrfLDC_IMCOELLO;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_IMCOELLO.*, LDC_IMCOELLO.rowid FROM LDC_IMCOELLO';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_IMCOELLO for sbFullQuery;

		fetch rfLDC_IMCOELLO bulk collect INTO otbResult;

		close rfLDC_IMCOELLO;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_IMCOELLO.*, LDC_IMCOELLO.rowid FROM LDC_IMCOELLO';
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
		ircLDC_IMCOELLO in styLDC_IMCOELLO
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_IMCOELLO,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_IMCOELLO in styLDC_IMCOELLO,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_IMCOELLO.ICELCODI is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ICELCODI');
			raise ex.controlled_error;
		end if;

		insert into LDC_IMCOELLO
		(
			ICELCODI,
			ICELELEM,
			ICELLOCA
		)
		values
		(
			ircLDC_IMCOELLO.ICELCODI,
			ircLDC_IMCOELLO.ICELELEM,
			ircLDC_IMCOELLO.ICELLOCA
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_IMCOELLO));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_IMCOELLO in out nocopy tytbLDC_IMCOELLO
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_IMCOELLO,blUseRowID);
		forall n in iotbLDC_IMCOELLO.first..iotbLDC_IMCOELLO.last
			insert into LDC_IMCOELLO
			(
				ICELCODI,
				ICELELEM,
				ICELLOCA
			)
			values
			(
				rcRecOfTab.ICELCODI(n),
				rcRecOfTab.ICELELEM(n),
				rcRecOfTab.ICELLOCA(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuICELCODI in LDC_IMCOELLO.ICELCODI%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_IMCOELLO;
	BEGIN
		rcError.ICELCODI := inuICELCODI;

		if inuLock=1 then
			LockByPk
			(
				inuICELCODI,
				rcData
			);
		end if;


		delete
		from LDC_IMCOELLO
		where
       		ICELCODI=inuICELCODI;
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
		rcError  styLDC_IMCOELLO;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_IMCOELLO
		where
			rowid = iriRowID
		returning
			ICELCODI
		into
			rcError.ICELCODI;
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
		iotbLDC_IMCOELLO in out nocopy tytbLDC_IMCOELLO,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_IMCOELLO;
	BEGIN
		FillRecordOfTables(iotbLDC_IMCOELLO, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_IMCOELLO.first .. iotbLDC_IMCOELLO.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_IMCOELLO.first .. iotbLDC_IMCOELLO.last
				delete
				from LDC_IMCOELLO
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_IMCOELLO.first .. iotbLDC_IMCOELLO.last loop
					LockByPk
					(
						rcRecOfTab.ICELCODI(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_IMCOELLO.first .. iotbLDC_IMCOELLO.last
				delete
				from LDC_IMCOELLO
				where
		         	ICELCODI = rcRecOfTab.ICELCODI(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_IMCOELLO in styLDC_IMCOELLO,
		inuLock in number default 0
	)
	IS
		nuICELCODI	LDC_IMCOELLO.ICELCODI%type;
	BEGIN
		if ircLDC_IMCOELLO.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_IMCOELLO.rowid,rcData);
			end if;
			update LDC_IMCOELLO
			set
				ICELELEM = ircLDC_IMCOELLO.ICELELEM,
				ICELLOCA = ircLDC_IMCOELLO.ICELLOCA
			where
				rowid = ircLDC_IMCOELLO.rowid
			returning
				ICELCODI
			into
				nuICELCODI;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_IMCOELLO.ICELCODI,
					rcData
				);
			end if;

			update LDC_IMCOELLO
			set
				ICELELEM = ircLDC_IMCOELLO.ICELELEM,
				ICELLOCA = ircLDC_IMCOELLO.ICELLOCA
			where
				ICELCODI = ircLDC_IMCOELLO.ICELCODI
			returning
				ICELCODI
			into
				nuICELCODI;
		end if;
		if
			nuICELCODI is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_IMCOELLO));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_IMCOELLO in out nocopy tytbLDC_IMCOELLO,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_IMCOELLO;
	BEGIN
		FillRecordOfTables(iotbLDC_IMCOELLO,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_IMCOELLO.first .. iotbLDC_IMCOELLO.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_IMCOELLO.first .. iotbLDC_IMCOELLO.last
				update LDC_IMCOELLO
				set
					ICELELEM = rcRecOfTab.ICELELEM(n),
					ICELLOCA = rcRecOfTab.ICELLOCA(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_IMCOELLO.first .. iotbLDC_IMCOELLO.last loop
					LockByPk
					(
						rcRecOfTab.ICELCODI(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_IMCOELLO.first .. iotbLDC_IMCOELLO.last
				update LDC_IMCOELLO
				SET
					ICELELEM = rcRecOfTab.ICELELEM(n),
					ICELLOCA = rcRecOfTab.ICELLOCA(n)
				where
					ICELCODI = rcRecOfTab.ICELCODI(n)
;
		end if;
	END;
	PROCEDURE updICELELEM
	(
		inuICELCODI in LDC_IMCOELLO.ICELCODI%type,
		isbICELELEM$ in LDC_IMCOELLO.ICELELEM%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_IMCOELLO;
	BEGIN
		rcError.ICELCODI := inuICELCODI;
		if inuLock=1 then
			LockByPk
			(
				inuICELCODI,
				rcData
			);
		end if;

		update LDC_IMCOELLO
		set
			ICELELEM = isbICELELEM$
		where
			ICELCODI = inuICELCODI;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ICELELEM:= isbICELELEM$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updICELLOCA
	(
		inuICELCODI in LDC_IMCOELLO.ICELCODI%type,
		inuICELLOCA$ in LDC_IMCOELLO.ICELLOCA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_IMCOELLO;
	BEGIN
		rcError.ICELCODI := inuICELCODI;
		if inuLock=1 then
			LockByPk
			(
				inuICELCODI,
				rcData
			);
		end if;

		update LDC_IMCOELLO
		set
			ICELLOCA = inuICELLOCA$
		where
			ICELCODI = inuICELCODI;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ICELLOCA:= inuICELLOCA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetICELCODI
	(
		inuICELCODI in LDC_IMCOELLO.ICELCODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_IMCOELLO.ICELCODI%type
	IS
		rcError styLDC_IMCOELLO;
	BEGIN

		rcError.ICELCODI := inuICELCODI;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuICELCODI
			 )
		then
			 return(rcData.ICELCODI);
		end if;
		Load
		(
		 		inuICELCODI
		);
		return(rcData.ICELCODI);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetICELELEM
	(
		inuICELCODI in LDC_IMCOELLO.ICELCODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_IMCOELLO.ICELELEM%type
	IS
		rcError styLDC_IMCOELLO;
	BEGIN

		rcError.ICELCODI := inuICELCODI;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuICELCODI
			 )
		then
			 return(rcData.ICELELEM);
		end if;
		Load
		(
		 		inuICELCODI
		);
		return(rcData.ICELELEM);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetICELLOCA
	(
		inuICELCODI in LDC_IMCOELLO.ICELCODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_IMCOELLO.ICELLOCA%type
	IS
		rcError styLDC_IMCOELLO;
	BEGIN

		rcError.ICELCODI := inuICELCODI;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuICELCODI
			 )
		then
			 return(rcData.ICELLOCA);
		end if;
		Load
		(
		 		inuICELCODI
		);
		return(rcData.ICELLOCA);
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
end DALDC_IMCOELLO;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALDC_IMCOELLO
BEGIN
    pkg_utilidades.prAplicarPermisos('DALDC_IMCOELLO', 'ADM_PERSON'); 
END;
/
