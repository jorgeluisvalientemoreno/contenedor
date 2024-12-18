CREATE OR REPLACE PACKAGE adm_person.DALDC_CAPILOCAFACO
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  11/06/2024   Adrianavg   OSF-2813: Migrar del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuCONSECUTIVO in LDC_CAPILOCAFACO.CONSECUTIVO%type
	)
	IS
		SELECT LDC_CAPILOCAFACO.*,LDC_CAPILOCAFACO.rowid
		FROM LDC_CAPILOCAFACO
		WHERE
		    CONSECUTIVO = inuCONSECUTIVO;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_CAPILOCAFACO.*,LDC_CAPILOCAFACO.rowid
		FROM LDC_CAPILOCAFACO
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_CAPILOCAFACO  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_CAPILOCAFACO is table of styLDC_CAPILOCAFACO index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_CAPILOCAFACO;

	/* Tipos referenciando al registro */
	type tytbCONSECUTIVO is table of LDC_CAPILOCAFACO.CONSECUTIVO%type index by binary_integer;
	type tytbLOCALIDAD is table of LDC_CAPILOCAFACO.LOCALIDAD%type index by binary_integer;
	type tytbCAPITAL is table of LDC_CAPILOCAFACO.CAPITAL%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_CAPILOCAFACO is record
	(
		CONSECUTIVO   tytbCONSECUTIVO,
		LOCALIDAD   tytbLOCALIDAD,
		CAPITAL   tytbCAPITAL,
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
		inuCONSECUTIVO in LDC_CAPILOCAFACO.CONSECUTIVO%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuCONSECUTIVO in LDC_CAPILOCAFACO.CONSECUTIVO%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuCONSECUTIVO in LDC_CAPILOCAFACO.CONSECUTIVO%type
	);

	PROCEDURE getRecord
	(
		inuCONSECUTIVO in LDC_CAPILOCAFACO.CONSECUTIVO%type,
		orcRecord out nocopy styLDC_CAPILOCAFACO
	);

	FUNCTION frcGetRcData
	(
		inuCONSECUTIVO in LDC_CAPILOCAFACO.CONSECUTIVO%type
	)
	RETURN styLDC_CAPILOCAFACO;

	FUNCTION frcGetRcData
	RETURN styLDC_CAPILOCAFACO;

	FUNCTION frcGetRecord
	(
		inuCONSECUTIVO in LDC_CAPILOCAFACO.CONSECUTIVO%type
	)
	RETURN styLDC_CAPILOCAFACO;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_CAPILOCAFACO
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_CAPILOCAFACO in styLDC_CAPILOCAFACO
	);

	PROCEDURE insRecord
	(
		ircLDC_CAPILOCAFACO in styLDC_CAPILOCAFACO,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_CAPILOCAFACO in out nocopy tytbLDC_CAPILOCAFACO
	);

	PROCEDURE delRecord
	(
		inuCONSECUTIVO in LDC_CAPILOCAFACO.CONSECUTIVO%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_CAPILOCAFACO in out nocopy tytbLDC_CAPILOCAFACO,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_CAPILOCAFACO in styLDC_CAPILOCAFACO,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_CAPILOCAFACO in out nocopy tytbLDC_CAPILOCAFACO,
		inuLock in number default 1
	);

	PROCEDURE updLOCALIDAD
	(
		inuCONSECUTIVO in LDC_CAPILOCAFACO.CONSECUTIVO%type,
		inuLOCALIDAD$ in LDC_CAPILOCAFACO.LOCALIDAD%type,
		inuLock in number default 0
	);

	PROCEDURE updCAPITAL
	(
		inuCONSECUTIVO in LDC_CAPILOCAFACO.CONSECUTIVO%type,
		inuCAPITAL$ in LDC_CAPILOCAFACO.CAPITAL%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetCONSECUTIVO
	(
		inuCONSECUTIVO in LDC_CAPILOCAFACO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CAPILOCAFACO.CONSECUTIVO%type;

	FUNCTION fnuGetLOCALIDAD
	(
		inuCONSECUTIVO in LDC_CAPILOCAFACO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CAPILOCAFACO.LOCALIDAD%type;

	FUNCTION fnuGetCAPITAL
	(
		inuCONSECUTIVO in LDC_CAPILOCAFACO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CAPILOCAFACO.CAPITAL%type;


	PROCEDURE LockByPk
	(
		inuCONSECUTIVO in LDC_CAPILOCAFACO.CONSECUTIVO%type,
		orcLDC_CAPILOCAFACO  out styLDC_CAPILOCAFACO
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_CAPILOCAFACO  out styLDC_CAPILOCAFACO
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_CAPILOCAFACO;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALDC_CAPILOCAFACO
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_CAPILOCAFACO';
	 cnuGeEntityId constant varchar2(30) := 4720; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuCONSECUTIVO in LDC_CAPILOCAFACO.CONSECUTIVO%type
	)
	IS
		SELECT LDC_CAPILOCAFACO.*,LDC_CAPILOCAFACO.rowid
		FROM LDC_CAPILOCAFACO
		WHERE  CONSECUTIVO = inuCONSECUTIVO
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_CAPILOCAFACO.*,LDC_CAPILOCAFACO.rowid
		FROM LDC_CAPILOCAFACO
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_CAPILOCAFACO is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_CAPILOCAFACO;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_CAPILOCAFACO default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.CONSECUTIVO);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuCONSECUTIVO in LDC_CAPILOCAFACO.CONSECUTIVO%type,
		orcLDC_CAPILOCAFACO  out styLDC_CAPILOCAFACO
	)
	IS
		rcError styLDC_CAPILOCAFACO;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;

		Open cuLockRcByPk
		(
			inuCONSECUTIVO
		);

		fetch cuLockRcByPk into orcLDC_CAPILOCAFACO;
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
		orcLDC_CAPILOCAFACO  out styLDC_CAPILOCAFACO
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_CAPILOCAFACO;
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
		itbLDC_CAPILOCAFACO  in out nocopy tytbLDC_CAPILOCAFACO
	)
	IS
	BEGIN
			rcRecOfTab.CONSECUTIVO.delete;
			rcRecOfTab.LOCALIDAD.delete;
			rcRecOfTab.CAPITAL.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_CAPILOCAFACO  in out nocopy tytbLDC_CAPILOCAFACO,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_CAPILOCAFACO);

		for n in itbLDC_CAPILOCAFACO.first .. itbLDC_CAPILOCAFACO.last loop
			rcRecOfTab.CONSECUTIVO(n) := itbLDC_CAPILOCAFACO(n).CONSECUTIVO;
			rcRecOfTab.LOCALIDAD(n) := itbLDC_CAPILOCAFACO(n).LOCALIDAD;
			rcRecOfTab.CAPITAL(n) := itbLDC_CAPILOCAFACO(n).CAPITAL;
			rcRecOfTab.row_id(n) := itbLDC_CAPILOCAFACO(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuCONSECUTIVO in LDC_CAPILOCAFACO.CONSECUTIVO%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuCONSECUTIVO
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
		inuCONSECUTIVO in LDC_CAPILOCAFACO.CONSECUTIVO%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuCONSECUTIVO = rcData.CONSECUTIVO
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
		inuCONSECUTIVO in LDC_CAPILOCAFACO.CONSECUTIVO%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuCONSECUTIVO
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuCONSECUTIVO in LDC_CAPILOCAFACO.CONSECUTIVO%type
	)
	IS
		rcError styLDC_CAPILOCAFACO;
	BEGIN		rcError.CONSECUTIVO:=inuCONSECUTIVO;

		Load
		(
			inuCONSECUTIVO
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
		inuCONSECUTIVO in LDC_CAPILOCAFACO.CONSECUTIVO%type
	)
	IS
	BEGIN
		Load
		(
			inuCONSECUTIVO
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuCONSECUTIVO in LDC_CAPILOCAFACO.CONSECUTIVO%type,
		orcRecord out nocopy styLDC_CAPILOCAFACO
	)
	IS
		rcError styLDC_CAPILOCAFACO;
	BEGIN		rcError.CONSECUTIVO:=inuCONSECUTIVO;

		Load
		(
			inuCONSECUTIVO
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuCONSECUTIVO in LDC_CAPILOCAFACO.CONSECUTIVO%type
	)
	RETURN styLDC_CAPILOCAFACO
	IS
		rcError styLDC_CAPILOCAFACO;
	BEGIN
		rcError.CONSECUTIVO:=inuCONSECUTIVO;

		Load
		(
			inuCONSECUTIVO
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuCONSECUTIVO in LDC_CAPILOCAFACO.CONSECUTIVO%type
	)
	RETURN styLDC_CAPILOCAFACO
	IS
		rcError styLDC_CAPILOCAFACO;
	BEGIN
		rcError.CONSECUTIVO:=inuCONSECUTIVO;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuCONSECUTIVO
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuCONSECUTIVO
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_CAPILOCAFACO
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_CAPILOCAFACO
	)
	IS
		rfLDC_CAPILOCAFACO tyrfLDC_CAPILOCAFACO;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_CAPILOCAFACO.*, LDC_CAPILOCAFACO.rowid FROM LDC_CAPILOCAFACO';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_CAPILOCAFACO for sbFullQuery;

		fetch rfLDC_CAPILOCAFACO bulk collect INTO otbResult;

		close rfLDC_CAPILOCAFACO;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_CAPILOCAFACO.*, LDC_CAPILOCAFACO.rowid FROM LDC_CAPILOCAFACO';
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
		ircLDC_CAPILOCAFACO in styLDC_CAPILOCAFACO
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_CAPILOCAFACO,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_CAPILOCAFACO in styLDC_CAPILOCAFACO,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_CAPILOCAFACO.CONSECUTIVO is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|CONSECUTIVO');
			raise ex.controlled_error;
		end if;

		insert into LDC_CAPILOCAFACO
		(
			CONSECUTIVO,
			LOCALIDAD,
			CAPITAL
		)
		values
		(
			ircLDC_CAPILOCAFACO.CONSECUTIVO,
			ircLDC_CAPILOCAFACO.LOCALIDAD,
			ircLDC_CAPILOCAFACO.CAPITAL
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_CAPILOCAFACO));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_CAPILOCAFACO in out nocopy tytbLDC_CAPILOCAFACO
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_CAPILOCAFACO,blUseRowID);
		forall n in iotbLDC_CAPILOCAFACO.first..iotbLDC_CAPILOCAFACO.last
			insert into LDC_CAPILOCAFACO
			(
				CONSECUTIVO,
				LOCALIDAD,
				CAPITAL
			)
			values
			(
				rcRecOfTab.CONSECUTIVO(n),
				rcRecOfTab.LOCALIDAD(n),
				rcRecOfTab.CAPITAL(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuCONSECUTIVO in LDC_CAPILOCAFACO.CONSECUTIVO%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_CAPILOCAFACO;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;

		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;


		delete
		from LDC_CAPILOCAFACO
		where
       		CONSECUTIVO=inuCONSECUTIVO;
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
		rcError  styLDC_CAPILOCAFACO;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_CAPILOCAFACO
		where
			rowid = iriRowID
		returning
			CONSECUTIVO
		into
			rcError.CONSECUTIVO;
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
		iotbLDC_CAPILOCAFACO in out nocopy tytbLDC_CAPILOCAFACO,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_CAPILOCAFACO;
	BEGIN
		FillRecordOfTables(iotbLDC_CAPILOCAFACO, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_CAPILOCAFACO.first .. iotbLDC_CAPILOCAFACO.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CAPILOCAFACO.first .. iotbLDC_CAPILOCAFACO.last
				delete
				from LDC_CAPILOCAFACO
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_CAPILOCAFACO.first .. iotbLDC_CAPILOCAFACO.last loop
					LockByPk
					(
						rcRecOfTab.CONSECUTIVO(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CAPILOCAFACO.first .. iotbLDC_CAPILOCAFACO.last
				delete
				from LDC_CAPILOCAFACO
				where
		         	CONSECUTIVO = rcRecOfTab.CONSECUTIVO(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_CAPILOCAFACO in styLDC_CAPILOCAFACO,
		inuLock in number default 0
	)
	IS
		nuCONSECUTIVO	LDC_CAPILOCAFACO.CONSECUTIVO%type;
	BEGIN
		if ircLDC_CAPILOCAFACO.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_CAPILOCAFACO.rowid,rcData);
			end if;
			update LDC_CAPILOCAFACO
			set
				LOCALIDAD = ircLDC_CAPILOCAFACO.LOCALIDAD,
				CAPITAL = ircLDC_CAPILOCAFACO.CAPITAL
			where
				rowid = ircLDC_CAPILOCAFACO.rowid
			returning
				CONSECUTIVO
			into
				nuCONSECUTIVO;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_CAPILOCAFACO.CONSECUTIVO,
					rcData
				);
			end if;

			update LDC_CAPILOCAFACO
			set
				LOCALIDAD = ircLDC_CAPILOCAFACO.LOCALIDAD,
				CAPITAL = ircLDC_CAPILOCAFACO.CAPITAL
			where
				CONSECUTIVO = ircLDC_CAPILOCAFACO.CONSECUTIVO
			returning
				CONSECUTIVO
			into
				nuCONSECUTIVO;
		end if;
		if
			nuCONSECUTIVO is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_CAPILOCAFACO));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_CAPILOCAFACO in out nocopy tytbLDC_CAPILOCAFACO,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_CAPILOCAFACO;
	BEGIN
		FillRecordOfTables(iotbLDC_CAPILOCAFACO,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_CAPILOCAFACO.first .. iotbLDC_CAPILOCAFACO.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CAPILOCAFACO.first .. iotbLDC_CAPILOCAFACO.last
				update LDC_CAPILOCAFACO
				set
					LOCALIDAD = rcRecOfTab.LOCALIDAD(n),
					CAPITAL = rcRecOfTab.CAPITAL(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_CAPILOCAFACO.first .. iotbLDC_CAPILOCAFACO.last loop
					LockByPk
					(
						rcRecOfTab.CONSECUTIVO(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CAPILOCAFACO.first .. iotbLDC_CAPILOCAFACO.last
				update LDC_CAPILOCAFACO
				SET
					LOCALIDAD = rcRecOfTab.LOCALIDAD(n),
					CAPITAL = rcRecOfTab.CAPITAL(n)
				where
					CONSECUTIVO = rcRecOfTab.CONSECUTIVO(n)
;
		end if;
	END;
	PROCEDURE updLOCALIDAD
	(
		inuCONSECUTIVO in LDC_CAPILOCAFACO.CONSECUTIVO%type,
		inuLOCALIDAD$ in LDC_CAPILOCAFACO.LOCALIDAD%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CAPILOCAFACO;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_CAPILOCAFACO
		set
			LOCALIDAD = inuLOCALIDAD$
		where
			CONSECUTIVO = inuCONSECUTIVO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.LOCALIDAD:= inuLOCALIDAD$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCAPITAL
	(
		inuCONSECUTIVO in LDC_CAPILOCAFACO.CONSECUTIVO%type,
		inuCAPITAL$ in LDC_CAPILOCAFACO.CAPITAL%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CAPILOCAFACO;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_CAPILOCAFACO
		set
			CAPITAL = inuCAPITAL$
		where
			CONSECUTIVO = inuCONSECUTIVO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CAPITAL:= inuCAPITAL$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetCONSECUTIVO
	(
		inuCONSECUTIVO in LDC_CAPILOCAFACO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CAPILOCAFACO.CONSECUTIVO%type
	IS
		rcError styLDC_CAPILOCAFACO;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.CONSECUTIVO);
		end if;
		Load
		(
		 		inuCONSECUTIVO
		);
		return(rcData.CONSECUTIVO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetLOCALIDAD
	(
		inuCONSECUTIVO in LDC_CAPILOCAFACO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CAPILOCAFACO.LOCALIDAD%type
	IS
		rcError styLDC_CAPILOCAFACO;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.LOCALIDAD);
		end if;
		Load
		(
		 		inuCONSECUTIVO
		);
		return(rcData.LOCALIDAD);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCAPITAL
	(
		inuCONSECUTIVO in LDC_CAPILOCAFACO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CAPILOCAFACO.CAPITAL%type
	IS
		rcError styLDC_CAPILOCAFACO;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.CAPITAL);
		end if;
		Load
		(
		 		inuCONSECUTIVO
		);
		return(rcData.CAPITAL);
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
end DALDC_CAPILOCAFACO;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALDC_CAPILOCAFACO
BEGIN
    pkg_utilidades.prAplicarPermisos('DALDC_CAPILOCAFACO', 'ADM_PERSON'); 
END;
/
