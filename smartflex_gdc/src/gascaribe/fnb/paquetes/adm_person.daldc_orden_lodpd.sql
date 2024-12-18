CREATE OR REPLACE PACKAGE adm_person.daldc_orden_lodpd
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  12/06/2024   Adrianavg   OSF-2779: Se migra del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuCONSECUTIVE in LDC_ORDEN_LODPD.CONSECUTIVE%type
	)
	IS
		SELECT LDC_ORDEN_LODPD.*,LDC_ORDEN_LODPD.rowid
		FROM LDC_ORDEN_LODPD
		WHERE
		    CONSECUTIVE = inuCONSECUTIVE;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_ORDEN_LODPD.*,LDC_ORDEN_LODPD.rowid
		FROM LDC_ORDEN_LODPD
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_ORDEN_LODPD  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_ORDEN_LODPD is table of styLDC_ORDEN_LODPD index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_ORDEN_LODPD;

	/* Tipos referenciando al registro */
	type tytbCONSECUTIVE is table of LDC_ORDEN_LODPD.CONSECUTIVE%type index by binary_integer;
	type tytbORDER_ID is table of LDC_ORDEN_LODPD.ORDER_ID%type index by binary_integer;
	type tytbREGISTER_DATE is table of LDC_ORDEN_LODPD.REGISTER_DATE%type index by binary_integer;
	type tytbGROUPER_ID is table of LDC_ORDEN_LODPD.GROUPER_ID%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_ORDEN_LODPD is record
	(
		CONSECUTIVE   tytbCONSECUTIVE,
		ORDER_ID   tytbORDER_ID,
		REGISTER_DATE   tytbREGISTER_DATE,
		GROUPER_ID   tytbGROUPER_ID,
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
		inuCONSECUTIVE in LDC_ORDEN_LODPD.CONSECUTIVE%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuCONSECUTIVE in LDC_ORDEN_LODPD.CONSECUTIVE%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuCONSECUTIVE in LDC_ORDEN_LODPD.CONSECUTIVE%type
	);

	PROCEDURE getRecord
	(
		inuCONSECUTIVE in LDC_ORDEN_LODPD.CONSECUTIVE%type,
		orcRecord out nocopy styLDC_ORDEN_LODPD
	);

	FUNCTION frcGetRcData
	(
		inuCONSECUTIVE in LDC_ORDEN_LODPD.CONSECUTIVE%type
	)
	RETURN styLDC_ORDEN_LODPD;

	FUNCTION frcGetRcData
	RETURN styLDC_ORDEN_LODPD;

	FUNCTION frcGetRecord
	(
		inuCONSECUTIVE in LDC_ORDEN_LODPD.CONSECUTIVE%type
	)
	RETURN styLDC_ORDEN_LODPD;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_ORDEN_LODPD
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_ORDEN_LODPD in styLDC_ORDEN_LODPD
	);

	PROCEDURE insRecord
	(
		ircLDC_ORDEN_LODPD in styLDC_ORDEN_LODPD,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_ORDEN_LODPD in out nocopy tytbLDC_ORDEN_LODPD
	);

	PROCEDURE delRecord
	(
		inuCONSECUTIVE in LDC_ORDEN_LODPD.CONSECUTIVE%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_ORDEN_LODPD in out nocopy tytbLDC_ORDEN_LODPD,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_ORDEN_LODPD in styLDC_ORDEN_LODPD,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_ORDEN_LODPD in out nocopy tytbLDC_ORDEN_LODPD,
		inuLock in number default 1
	);

	PROCEDURE updORDER_ID
	(
		inuCONSECUTIVE in LDC_ORDEN_LODPD.CONSECUTIVE%type,
		inuORDER_ID$ in LDC_ORDEN_LODPD.ORDER_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updREGISTER_DATE
	(
		inuCONSECUTIVE in LDC_ORDEN_LODPD.CONSECUTIVE%type,
		idtREGISTER_DATE$ in LDC_ORDEN_LODPD.REGISTER_DATE%type,
		inuLock in number default 0
	);

	PROCEDURE updGROUPER_ID
	(
		inuCONSECUTIVE in LDC_ORDEN_LODPD.CONSECUTIVE%type,
		inuGROUPER_ID$ in LDC_ORDEN_LODPD.GROUPER_ID%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetCONSECUTIVE
	(
		inuCONSECUTIVE in LDC_ORDEN_LODPD.CONSECUTIVE%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ORDEN_LODPD.CONSECUTIVE%type;

	FUNCTION fnuGetORDER_ID
	(
		inuCONSECUTIVE in LDC_ORDEN_LODPD.CONSECUTIVE%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ORDEN_LODPD.ORDER_ID%type;

	FUNCTION fdtGetREGISTER_DATE
	(
		inuCONSECUTIVE in LDC_ORDEN_LODPD.CONSECUTIVE%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ORDEN_LODPD.REGISTER_DATE%type;

	FUNCTION fnuGetGROUPER_ID
	(
		inuCONSECUTIVE in LDC_ORDEN_LODPD.CONSECUTIVE%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ORDEN_LODPD.GROUPER_ID%type;


	PROCEDURE LockByPk
	(
		inuCONSECUTIVE in LDC_ORDEN_LODPD.CONSECUTIVE%type,
		orcLDC_ORDEN_LODPD  out styLDC_ORDEN_LODPD
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_ORDEN_LODPD  out styLDC_ORDEN_LODPD
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_ORDEN_LODPD;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALDC_ORDEN_LODPD
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_ORDEN_LODPD';
	 cnuGeEntityId constant varchar2(30) := 1878; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuCONSECUTIVE in LDC_ORDEN_LODPD.CONSECUTIVE%type
	)
	IS
		SELECT LDC_ORDEN_LODPD.*,LDC_ORDEN_LODPD.rowid
		FROM LDC_ORDEN_LODPD
		WHERE  CONSECUTIVE = inuCONSECUTIVE
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_ORDEN_LODPD.*,LDC_ORDEN_LODPD.rowid
		FROM LDC_ORDEN_LODPD
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_ORDEN_LODPD is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_ORDEN_LODPD;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_ORDEN_LODPD default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.CONSECUTIVE);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuCONSECUTIVE in LDC_ORDEN_LODPD.CONSECUTIVE%type,
		orcLDC_ORDEN_LODPD  out styLDC_ORDEN_LODPD
	)
	IS
		rcError styLDC_ORDEN_LODPD;
	BEGIN
		rcError.CONSECUTIVE := inuCONSECUTIVE;

		Open cuLockRcByPk
		(
			inuCONSECUTIVE
		);

		fetch cuLockRcByPk into orcLDC_ORDEN_LODPD;
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
		orcLDC_ORDEN_LODPD  out styLDC_ORDEN_LODPD
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_ORDEN_LODPD;
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
		itbLDC_ORDEN_LODPD  in out nocopy tytbLDC_ORDEN_LODPD
	)
	IS
	BEGIN
			rcRecOfTab.CONSECUTIVE.delete;
			rcRecOfTab.ORDER_ID.delete;
			rcRecOfTab.REGISTER_DATE.delete;
			rcRecOfTab.GROUPER_ID.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_ORDEN_LODPD  in out nocopy tytbLDC_ORDEN_LODPD,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_ORDEN_LODPD);

		for n in itbLDC_ORDEN_LODPD.first .. itbLDC_ORDEN_LODPD.last loop
			rcRecOfTab.CONSECUTIVE(n) := itbLDC_ORDEN_LODPD(n).CONSECUTIVE;
			rcRecOfTab.ORDER_ID(n) := itbLDC_ORDEN_LODPD(n).ORDER_ID;
			rcRecOfTab.REGISTER_DATE(n) := itbLDC_ORDEN_LODPD(n).REGISTER_DATE;
			rcRecOfTab.GROUPER_ID(n) := itbLDC_ORDEN_LODPD(n).GROUPER_ID;
			rcRecOfTab.row_id(n) := itbLDC_ORDEN_LODPD(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuCONSECUTIVE in LDC_ORDEN_LODPD.CONSECUTIVE%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuCONSECUTIVE
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
		inuCONSECUTIVE in LDC_ORDEN_LODPD.CONSECUTIVE%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuCONSECUTIVE = rcData.CONSECUTIVE
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
		inuCONSECUTIVE in LDC_ORDEN_LODPD.CONSECUTIVE%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuCONSECUTIVE
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuCONSECUTIVE in LDC_ORDEN_LODPD.CONSECUTIVE%type
	)
	IS
		rcError styLDC_ORDEN_LODPD;
	BEGIN		rcError.CONSECUTIVE:=inuCONSECUTIVE;

		Load
		(
			inuCONSECUTIVE
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
		inuCONSECUTIVE in LDC_ORDEN_LODPD.CONSECUTIVE%type
	)
	IS
	BEGIN
		Load
		(
			inuCONSECUTIVE
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuCONSECUTIVE in LDC_ORDEN_LODPD.CONSECUTIVE%type,
		orcRecord out nocopy styLDC_ORDEN_LODPD
	)
	IS
		rcError styLDC_ORDEN_LODPD;
	BEGIN		rcError.CONSECUTIVE:=inuCONSECUTIVE;

		Load
		(
			inuCONSECUTIVE
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuCONSECUTIVE in LDC_ORDEN_LODPD.CONSECUTIVE%type
	)
	RETURN styLDC_ORDEN_LODPD
	IS
		rcError styLDC_ORDEN_LODPD;
	BEGIN
		rcError.CONSECUTIVE:=inuCONSECUTIVE;

		Load
		(
			inuCONSECUTIVE
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuCONSECUTIVE in LDC_ORDEN_LODPD.CONSECUTIVE%type
	)
	RETURN styLDC_ORDEN_LODPD
	IS
		rcError styLDC_ORDEN_LODPD;
	BEGIN
		rcError.CONSECUTIVE:=inuCONSECUTIVE;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuCONSECUTIVE
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuCONSECUTIVE
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_ORDEN_LODPD
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_ORDEN_LODPD
	)
	IS
		rfLDC_ORDEN_LODPD tyrfLDC_ORDEN_LODPD;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_ORDEN_LODPD.*, LDC_ORDEN_LODPD.rowid FROM LDC_ORDEN_LODPD';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_ORDEN_LODPD for sbFullQuery;

		fetch rfLDC_ORDEN_LODPD bulk collect INTO otbResult;

		close rfLDC_ORDEN_LODPD;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_ORDEN_LODPD.*, LDC_ORDEN_LODPD.rowid FROM LDC_ORDEN_LODPD';
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
		ircLDC_ORDEN_LODPD in styLDC_ORDEN_LODPD
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_ORDEN_LODPD,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_ORDEN_LODPD in styLDC_ORDEN_LODPD,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_ORDEN_LODPD.CONSECUTIVE is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|CONSECUTIVE');
			raise ex.controlled_error;
		end if;

		insert into LDC_ORDEN_LODPD
		(
			CONSECUTIVE,
			ORDER_ID,
			REGISTER_DATE,
			GROUPER_ID
		)
		values
		(
			ircLDC_ORDEN_LODPD.CONSECUTIVE,
			ircLDC_ORDEN_LODPD.ORDER_ID,
			ircLDC_ORDEN_LODPD.REGISTER_DATE,
			ircLDC_ORDEN_LODPD.GROUPER_ID
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_ORDEN_LODPD));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_ORDEN_LODPD in out nocopy tytbLDC_ORDEN_LODPD
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_ORDEN_LODPD,blUseRowID);
		forall n in iotbLDC_ORDEN_LODPD.first..iotbLDC_ORDEN_LODPD.last
			insert into LDC_ORDEN_LODPD
			(
				CONSECUTIVE,
				ORDER_ID,
				REGISTER_DATE,
				GROUPER_ID
			)
			values
			(
				rcRecOfTab.CONSECUTIVE(n),
				rcRecOfTab.ORDER_ID(n),
				rcRecOfTab.REGISTER_DATE(n),
				rcRecOfTab.GROUPER_ID(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuCONSECUTIVE in LDC_ORDEN_LODPD.CONSECUTIVE%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_ORDEN_LODPD;
	BEGIN
		rcError.CONSECUTIVE := inuCONSECUTIVE;

		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVE,
				rcData
			);
		end if;


		delete
		from LDC_ORDEN_LODPD
		where
       		CONSECUTIVE=inuCONSECUTIVE;
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
		rcError  styLDC_ORDEN_LODPD;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_ORDEN_LODPD
		where
			rowid = iriRowID
		returning
			CONSECUTIVE
		into
			rcError.CONSECUTIVE;
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
		iotbLDC_ORDEN_LODPD in out nocopy tytbLDC_ORDEN_LODPD,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_ORDEN_LODPD;
	BEGIN
		FillRecordOfTables(iotbLDC_ORDEN_LODPD, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_ORDEN_LODPD.first .. iotbLDC_ORDEN_LODPD.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ORDEN_LODPD.first .. iotbLDC_ORDEN_LODPD.last
				delete
				from LDC_ORDEN_LODPD
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_ORDEN_LODPD.first .. iotbLDC_ORDEN_LODPD.last loop
					LockByPk
					(
						rcRecOfTab.CONSECUTIVE(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ORDEN_LODPD.first .. iotbLDC_ORDEN_LODPD.last
				delete
				from LDC_ORDEN_LODPD
				where
		         	CONSECUTIVE = rcRecOfTab.CONSECUTIVE(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_ORDEN_LODPD in styLDC_ORDEN_LODPD,
		inuLock in number default 0
	)
	IS
		nuCONSECUTIVE	LDC_ORDEN_LODPD.CONSECUTIVE%type;
	BEGIN
		if ircLDC_ORDEN_LODPD.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_ORDEN_LODPD.rowid,rcData);
			end if;
			update LDC_ORDEN_LODPD
			set
				ORDER_ID = ircLDC_ORDEN_LODPD.ORDER_ID,
				REGISTER_DATE = ircLDC_ORDEN_LODPD.REGISTER_DATE,
				GROUPER_ID = ircLDC_ORDEN_LODPD.GROUPER_ID
			where
				rowid = ircLDC_ORDEN_LODPD.rowid
			returning
				CONSECUTIVE
			into
				nuCONSECUTIVE;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_ORDEN_LODPD.CONSECUTIVE,
					rcData
				);
			end if;

			update LDC_ORDEN_LODPD
			set
				ORDER_ID = ircLDC_ORDEN_LODPD.ORDER_ID,
				REGISTER_DATE = ircLDC_ORDEN_LODPD.REGISTER_DATE,
				GROUPER_ID = ircLDC_ORDEN_LODPD.GROUPER_ID
			where
				CONSECUTIVE = ircLDC_ORDEN_LODPD.CONSECUTIVE
			returning
				CONSECUTIVE
			into
				nuCONSECUTIVE;
		end if;
		if
			nuCONSECUTIVE is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_ORDEN_LODPD));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_ORDEN_LODPD in out nocopy tytbLDC_ORDEN_LODPD,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_ORDEN_LODPD;
	BEGIN
		FillRecordOfTables(iotbLDC_ORDEN_LODPD,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_ORDEN_LODPD.first .. iotbLDC_ORDEN_LODPD.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ORDEN_LODPD.first .. iotbLDC_ORDEN_LODPD.last
				update LDC_ORDEN_LODPD
				set
					ORDER_ID = rcRecOfTab.ORDER_ID(n),
					REGISTER_DATE = rcRecOfTab.REGISTER_DATE(n),
					GROUPER_ID = rcRecOfTab.GROUPER_ID(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_ORDEN_LODPD.first .. iotbLDC_ORDEN_LODPD.last loop
					LockByPk
					(
						rcRecOfTab.CONSECUTIVE(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ORDEN_LODPD.first .. iotbLDC_ORDEN_LODPD.last
				update LDC_ORDEN_LODPD
				SET
					ORDER_ID = rcRecOfTab.ORDER_ID(n),
					REGISTER_DATE = rcRecOfTab.REGISTER_DATE(n),
					GROUPER_ID = rcRecOfTab.GROUPER_ID(n)
				where
					CONSECUTIVE = rcRecOfTab.CONSECUTIVE(n)
;
		end if;
	END;
	PROCEDURE updORDER_ID
	(
		inuCONSECUTIVE in LDC_ORDEN_LODPD.CONSECUTIVE%type,
		inuORDER_ID$ in LDC_ORDEN_LODPD.ORDER_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ORDEN_LODPD;
	BEGIN
		rcError.CONSECUTIVE := inuCONSECUTIVE;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVE,
				rcData
			);
		end if;

		update LDC_ORDEN_LODPD
		set
			ORDER_ID = inuORDER_ID$
		where
			CONSECUTIVE = inuCONSECUTIVE;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ORDER_ID:= inuORDER_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updREGISTER_DATE
	(
		inuCONSECUTIVE in LDC_ORDEN_LODPD.CONSECUTIVE%type,
		idtREGISTER_DATE$ in LDC_ORDEN_LODPD.REGISTER_DATE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ORDEN_LODPD;
	BEGIN
		rcError.CONSECUTIVE := inuCONSECUTIVE;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVE,
				rcData
			);
		end if;

		update LDC_ORDEN_LODPD
		set
			REGISTER_DATE = idtREGISTER_DATE$
		where
			CONSECUTIVE = inuCONSECUTIVE;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.REGISTER_DATE:= idtREGISTER_DATE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updGROUPER_ID
	(
		inuCONSECUTIVE in LDC_ORDEN_LODPD.CONSECUTIVE%type,
		inuGROUPER_ID$ in LDC_ORDEN_LODPD.GROUPER_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ORDEN_LODPD;
	BEGIN
		rcError.CONSECUTIVE := inuCONSECUTIVE;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVE,
				rcData
			);
		end if;

		update LDC_ORDEN_LODPD
		set
			GROUPER_ID = inuGROUPER_ID$
		where
			CONSECUTIVE = inuCONSECUTIVE;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.GROUPER_ID:= inuGROUPER_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetCONSECUTIVE
	(
		inuCONSECUTIVE in LDC_ORDEN_LODPD.CONSECUTIVE%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ORDEN_LODPD.CONSECUTIVE%type
	IS
		rcError styLDC_ORDEN_LODPD;
	BEGIN

		rcError.CONSECUTIVE := inuCONSECUTIVE;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVE
			 )
		then
			 return(rcData.CONSECUTIVE);
		end if;
		Load
		(
		 		inuCONSECUTIVE
		);
		return(rcData.CONSECUTIVE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetORDER_ID
	(
		inuCONSECUTIVE in LDC_ORDEN_LODPD.CONSECUTIVE%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ORDEN_LODPD.ORDER_ID%type
	IS
		rcError styLDC_ORDEN_LODPD;
	BEGIN

		rcError.CONSECUTIVE := inuCONSECUTIVE;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVE
			 )
		then
			 return(rcData.ORDER_ID);
		end if;
		Load
		(
		 		inuCONSECUTIVE
		);
		return(rcData.ORDER_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetREGISTER_DATE
	(
		inuCONSECUTIVE in LDC_ORDEN_LODPD.CONSECUTIVE%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ORDEN_LODPD.REGISTER_DATE%type
	IS
		rcError styLDC_ORDEN_LODPD;
	BEGIN

		rcError.CONSECUTIVE := inuCONSECUTIVE;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVE
			 )
		then
			 return(rcData.REGISTER_DATE);
		end if;
		Load
		(
		 		inuCONSECUTIVE
		);
		return(rcData.REGISTER_DATE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetGROUPER_ID
	(
		inuCONSECUTIVE in LDC_ORDEN_LODPD.CONSECUTIVE%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ORDEN_LODPD.GROUPER_ID%type
	IS
		rcError styLDC_ORDEN_LODPD;
	BEGIN

		rcError.CONSECUTIVE := inuCONSECUTIVE;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVE
			 )
		then
			 return(rcData.GROUPER_ID);
		end if;
		Load
		(
		 		inuCONSECUTIVE
		);
		return(rcData.GROUPER_ID);
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
end DALDC_ORDEN_LODPD;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALDC_ORDEN_LODPD
BEGIN
    pkg_utilidades.prAplicarPermisos('DALDC_ORDEN_LODPD', 'ADM_PERSON'); 
END;
/ 
