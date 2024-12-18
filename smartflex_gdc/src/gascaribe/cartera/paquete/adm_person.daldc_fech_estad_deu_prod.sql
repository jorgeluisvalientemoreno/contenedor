CREATE OR REPLACE PACKAGE adm_person.daldc_fech_estad_deu_prod
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  27/05/2024   Adrianavg   OSF-2744: Se migra del esquema OPEN al esquema ADM_PERSON
  *************************************************************************
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuID_SOLICITUD in LDC_FECH_ESTAD_DEU_PROD.ID_SOLICITUD%type
	)
	IS
		SELECT LDC_FECH_ESTAD_DEU_PROD.*,LDC_FECH_ESTAD_DEU_PROD.rowid
		FROM LDC_FECH_ESTAD_DEU_PROD
		WHERE
		    ID_SOLICITUD = inuID_SOLICITUD;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_FECH_ESTAD_DEU_PROD.*,LDC_FECH_ESTAD_DEU_PROD.rowid
		FROM LDC_FECH_ESTAD_DEU_PROD
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_FECH_ESTAD_DEU_PROD  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_FECH_ESTAD_DEU_PROD is table of styLDC_FECH_ESTAD_DEU_PROD index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_FECH_ESTAD_DEU_PROD;

	/* Tipos referenciando al registro */
	type tytbID_SOLICITUD is table of LDC_FECH_ESTAD_DEU_PROD.ID_SOLICITUD%type index by binary_integer;
	type tytbTIPO_SOLICITUD is table of LDC_FECH_ESTAD_DEU_PROD.TIPO_SOLICITUD%type index by binary_integer;
	type tytbFECHA_DEUDA is table of LDC_FECH_ESTAD_DEU_PROD.FECHA_DEUDA%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_FECH_ESTAD_DEU_PROD is record
	(
		ID_SOLICITUD   tytbID_SOLICITUD,
		TIPO_SOLICITUD   tytbTIPO_SOLICITUD,
		FECHA_DEUDA   tytbFECHA_DEUDA,
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
		inuID_SOLICITUD in LDC_FECH_ESTAD_DEU_PROD.ID_SOLICITUD%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuID_SOLICITUD in LDC_FECH_ESTAD_DEU_PROD.ID_SOLICITUD%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuID_SOLICITUD in LDC_FECH_ESTAD_DEU_PROD.ID_SOLICITUD%type
	);

	PROCEDURE getRecord
	(
		inuID_SOLICITUD in LDC_FECH_ESTAD_DEU_PROD.ID_SOLICITUD%type,
		orcRecord out nocopy styLDC_FECH_ESTAD_DEU_PROD
	);

	FUNCTION frcGetRcData
	(
		inuID_SOLICITUD in LDC_FECH_ESTAD_DEU_PROD.ID_SOLICITUD%type
	)
	RETURN styLDC_FECH_ESTAD_DEU_PROD;

	FUNCTION frcGetRcData
	RETURN styLDC_FECH_ESTAD_DEU_PROD;

	FUNCTION frcGetRecord
	(
		inuID_SOLICITUD in LDC_FECH_ESTAD_DEU_PROD.ID_SOLICITUD%type
	)
	RETURN styLDC_FECH_ESTAD_DEU_PROD;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_FECH_ESTAD_DEU_PROD
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_FECH_ESTAD_DEU_PROD in styLDC_FECH_ESTAD_DEU_PROD
	);

	PROCEDURE insRecord
	(
		ircLDC_FECH_ESTAD_DEU_PROD in styLDC_FECH_ESTAD_DEU_PROD,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_FECH_ESTAD_DEU_PROD in out nocopy tytbLDC_FECH_ESTAD_DEU_PROD
	);

	PROCEDURE delRecord
	(
		inuID_SOLICITUD in LDC_FECH_ESTAD_DEU_PROD.ID_SOLICITUD%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_FECH_ESTAD_DEU_PROD in out nocopy tytbLDC_FECH_ESTAD_DEU_PROD,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_FECH_ESTAD_DEU_PROD in styLDC_FECH_ESTAD_DEU_PROD,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_FECH_ESTAD_DEU_PROD in out nocopy tytbLDC_FECH_ESTAD_DEU_PROD,
		inuLock in number default 1
	);

	PROCEDURE updTIPO_SOLICITUD
	(
		inuID_SOLICITUD in LDC_FECH_ESTAD_DEU_PROD.ID_SOLICITUD%type,
		inuTIPO_SOLICITUD$ in LDC_FECH_ESTAD_DEU_PROD.TIPO_SOLICITUD%type,
		inuLock in number default 0
	);

	PROCEDURE updFECHA_DEUDA
	(
		inuID_SOLICITUD in LDC_FECH_ESTAD_DEU_PROD.ID_SOLICITUD%type,
		idtFECHA_DEUDA$ in LDC_FECH_ESTAD_DEU_PROD.FECHA_DEUDA%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetID_SOLICITUD
	(
		inuID_SOLICITUD in LDC_FECH_ESTAD_DEU_PROD.ID_SOLICITUD%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_FECH_ESTAD_DEU_PROD.ID_SOLICITUD%type;

	FUNCTION fnuGetTIPO_SOLICITUD
	(
		inuID_SOLICITUD in LDC_FECH_ESTAD_DEU_PROD.ID_SOLICITUD%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_FECH_ESTAD_DEU_PROD.TIPO_SOLICITUD%type;

	FUNCTION fdtGetFECHA_DEUDA
	(
		inuID_SOLICITUD in LDC_FECH_ESTAD_DEU_PROD.ID_SOLICITUD%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_FECH_ESTAD_DEU_PROD.FECHA_DEUDA%type;


	PROCEDURE LockByPk
	(
		inuID_SOLICITUD in LDC_FECH_ESTAD_DEU_PROD.ID_SOLICITUD%type,
		orcLDC_FECH_ESTAD_DEU_PROD  out styLDC_FECH_ESTAD_DEU_PROD
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_FECH_ESTAD_DEU_PROD  out styLDC_FECH_ESTAD_DEU_PROD
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_FECH_ESTAD_DEU_PROD;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALDC_FECH_ESTAD_DEU_PROD
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_FECH_ESTAD_DEU_PROD';
	 cnuGeEntityId constant varchar2(30) := 4056; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuID_SOLICITUD in LDC_FECH_ESTAD_DEU_PROD.ID_SOLICITUD%type
	)
	IS
		SELECT LDC_FECH_ESTAD_DEU_PROD.*,LDC_FECH_ESTAD_DEU_PROD.rowid
		FROM LDC_FECH_ESTAD_DEU_PROD
		WHERE  ID_SOLICITUD = inuID_SOLICITUD
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_FECH_ESTAD_DEU_PROD.*,LDC_FECH_ESTAD_DEU_PROD.rowid
		FROM LDC_FECH_ESTAD_DEU_PROD
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_FECH_ESTAD_DEU_PROD is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_FECH_ESTAD_DEU_PROD;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_FECH_ESTAD_DEU_PROD default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.ID_SOLICITUD);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuID_SOLICITUD in LDC_FECH_ESTAD_DEU_PROD.ID_SOLICITUD%type,
		orcLDC_FECH_ESTAD_DEU_PROD  out styLDC_FECH_ESTAD_DEU_PROD
	)
	IS
		rcError styLDC_FECH_ESTAD_DEU_PROD;
	BEGIN
		rcError.ID_SOLICITUD := inuID_SOLICITUD;

		Open cuLockRcByPk
		(
			inuID_SOLICITUD
		);

		fetch cuLockRcByPk into orcLDC_FECH_ESTAD_DEU_PROD;
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
		orcLDC_FECH_ESTAD_DEU_PROD  out styLDC_FECH_ESTAD_DEU_PROD
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_FECH_ESTAD_DEU_PROD;
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
		itbLDC_FECH_ESTAD_DEU_PROD  in out nocopy tytbLDC_FECH_ESTAD_DEU_PROD
	)
	IS
	BEGIN
			rcRecOfTab.ID_SOLICITUD.delete;
			rcRecOfTab.TIPO_SOLICITUD.delete;
			rcRecOfTab.FECHA_DEUDA.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_FECH_ESTAD_DEU_PROD  in out nocopy tytbLDC_FECH_ESTAD_DEU_PROD,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_FECH_ESTAD_DEU_PROD);

		for n in itbLDC_FECH_ESTAD_DEU_PROD.first .. itbLDC_FECH_ESTAD_DEU_PROD.last loop
			rcRecOfTab.ID_SOLICITUD(n) := itbLDC_FECH_ESTAD_DEU_PROD(n).ID_SOLICITUD;
			rcRecOfTab.TIPO_SOLICITUD(n) := itbLDC_FECH_ESTAD_DEU_PROD(n).TIPO_SOLICITUD;
			rcRecOfTab.FECHA_DEUDA(n) := itbLDC_FECH_ESTAD_DEU_PROD(n).FECHA_DEUDA;
			rcRecOfTab.row_id(n) := itbLDC_FECH_ESTAD_DEU_PROD(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuID_SOLICITUD in LDC_FECH_ESTAD_DEU_PROD.ID_SOLICITUD%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuID_SOLICITUD
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
		inuID_SOLICITUD in LDC_FECH_ESTAD_DEU_PROD.ID_SOLICITUD%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuID_SOLICITUD = rcData.ID_SOLICITUD
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
		inuID_SOLICITUD in LDC_FECH_ESTAD_DEU_PROD.ID_SOLICITUD%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuID_SOLICITUD
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuID_SOLICITUD in LDC_FECH_ESTAD_DEU_PROD.ID_SOLICITUD%type
	)
	IS
		rcError styLDC_FECH_ESTAD_DEU_PROD;
	BEGIN		rcError.ID_SOLICITUD:=inuID_SOLICITUD;

		Load
		(
			inuID_SOLICITUD
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
		inuID_SOLICITUD in LDC_FECH_ESTAD_DEU_PROD.ID_SOLICITUD%type
	)
	IS
	BEGIN
		Load
		(
			inuID_SOLICITUD
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuID_SOLICITUD in LDC_FECH_ESTAD_DEU_PROD.ID_SOLICITUD%type,
		orcRecord out nocopy styLDC_FECH_ESTAD_DEU_PROD
	)
	IS
		rcError styLDC_FECH_ESTAD_DEU_PROD;
	BEGIN		rcError.ID_SOLICITUD:=inuID_SOLICITUD;

		Load
		(
			inuID_SOLICITUD
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuID_SOLICITUD in LDC_FECH_ESTAD_DEU_PROD.ID_SOLICITUD%type
	)
	RETURN styLDC_FECH_ESTAD_DEU_PROD
	IS
		rcError styLDC_FECH_ESTAD_DEU_PROD;
	BEGIN
		rcError.ID_SOLICITUD:=inuID_SOLICITUD;

		Load
		(
			inuID_SOLICITUD
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuID_SOLICITUD in LDC_FECH_ESTAD_DEU_PROD.ID_SOLICITUD%type
	)
	RETURN styLDC_FECH_ESTAD_DEU_PROD
	IS
		rcError styLDC_FECH_ESTAD_DEU_PROD;
	BEGIN
		rcError.ID_SOLICITUD:=inuID_SOLICITUD;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuID_SOLICITUD
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuID_SOLICITUD
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_FECH_ESTAD_DEU_PROD
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_FECH_ESTAD_DEU_PROD
	)
	IS
		rfLDC_FECH_ESTAD_DEU_PROD tyrfLDC_FECH_ESTAD_DEU_PROD;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_FECH_ESTAD_DEU_PROD.*, LDC_FECH_ESTAD_DEU_PROD.rowid FROM LDC_FECH_ESTAD_DEU_PROD';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_FECH_ESTAD_DEU_PROD for sbFullQuery;

		fetch rfLDC_FECH_ESTAD_DEU_PROD bulk collect INTO otbResult;

		close rfLDC_FECH_ESTAD_DEU_PROD;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_FECH_ESTAD_DEU_PROD.*, LDC_FECH_ESTAD_DEU_PROD.rowid FROM LDC_FECH_ESTAD_DEU_PROD';
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
		ircLDC_FECH_ESTAD_DEU_PROD in styLDC_FECH_ESTAD_DEU_PROD
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_FECH_ESTAD_DEU_PROD,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_FECH_ESTAD_DEU_PROD in styLDC_FECH_ESTAD_DEU_PROD,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_FECH_ESTAD_DEU_PROD.ID_SOLICITUD is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ID_SOLICITUD');
			raise ex.controlled_error;
		end if;

		insert into LDC_FECH_ESTAD_DEU_PROD
		(
			ID_SOLICITUD,
			TIPO_SOLICITUD,
			FECHA_DEUDA
		)
		values
		(
			ircLDC_FECH_ESTAD_DEU_PROD.ID_SOLICITUD,
			ircLDC_FECH_ESTAD_DEU_PROD.TIPO_SOLICITUD,
			ircLDC_FECH_ESTAD_DEU_PROD.FECHA_DEUDA
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_FECH_ESTAD_DEU_PROD));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_FECH_ESTAD_DEU_PROD in out nocopy tytbLDC_FECH_ESTAD_DEU_PROD
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_FECH_ESTAD_DEU_PROD,blUseRowID);
		forall n in iotbLDC_FECH_ESTAD_DEU_PROD.first..iotbLDC_FECH_ESTAD_DEU_PROD.last
			insert into LDC_FECH_ESTAD_DEU_PROD
			(
				ID_SOLICITUD,
				TIPO_SOLICITUD,
				FECHA_DEUDA
			)
			values
			(
				rcRecOfTab.ID_SOLICITUD(n),
				rcRecOfTab.TIPO_SOLICITUD(n),
				rcRecOfTab.FECHA_DEUDA(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuID_SOLICITUD in LDC_FECH_ESTAD_DEU_PROD.ID_SOLICITUD%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_FECH_ESTAD_DEU_PROD;
	BEGIN
		rcError.ID_SOLICITUD := inuID_SOLICITUD;

		if inuLock=1 then
			LockByPk
			(
				inuID_SOLICITUD,
				rcData
			);
		end if;


		delete
		from LDC_FECH_ESTAD_DEU_PROD
		where
       		ID_SOLICITUD=inuID_SOLICITUD;
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
		rcError  styLDC_FECH_ESTAD_DEU_PROD;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_FECH_ESTAD_DEU_PROD
		where
			rowid = iriRowID
		returning
			ID_SOLICITUD
		into
			rcError.ID_SOLICITUD;
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
		iotbLDC_FECH_ESTAD_DEU_PROD in out nocopy tytbLDC_FECH_ESTAD_DEU_PROD,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_FECH_ESTAD_DEU_PROD;
	BEGIN
		FillRecordOfTables(iotbLDC_FECH_ESTAD_DEU_PROD, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_FECH_ESTAD_DEU_PROD.first .. iotbLDC_FECH_ESTAD_DEU_PROD.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_FECH_ESTAD_DEU_PROD.first .. iotbLDC_FECH_ESTAD_DEU_PROD.last
				delete
				from LDC_FECH_ESTAD_DEU_PROD
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_FECH_ESTAD_DEU_PROD.first .. iotbLDC_FECH_ESTAD_DEU_PROD.last loop
					LockByPk
					(
						rcRecOfTab.ID_SOLICITUD(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_FECH_ESTAD_DEU_PROD.first .. iotbLDC_FECH_ESTAD_DEU_PROD.last
				delete
				from LDC_FECH_ESTAD_DEU_PROD
				where
		         	ID_SOLICITUD = rcRecOfTab.ID_SOLICITUD(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_FECH_ESTAD_DEU_PROD in styLDC_FECH_ESTAD_DEU_PROD,
		inuLock in number default 0
	)
	IS
		nuID_SOLICITUD	LDC_FECH_ESTAD_DEU_PROD.ID_SOLICITUD%type;
	BEGIN
		if ircLDC_FECH_ESTAD_DEU_PROD.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_FECH_ESTAD_DEU_PROD.rowid,rcData);
			end if;
			update LDC_FECH_ESTAD_DEU_PROD
			set
				TIPO_SOLICITUD = ircLDC_FECH_ESTAD_DEU_PROD.TIPO_SOLICITUD,
				FECHA_DEUDA = ircLDC_FECH_ESTAD_DEU_PROD.FECHA_DEUDA
			where
				rowid = ircLDC_FECH_ESTAD_DEU_PROD.rowid
			returning
				ID_SOLICITUD
			into
				nuID_SOLICITUD;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_FECH_ESTAD_DEU_PROD.ID_SOLICITUD,
					rcData
				);
			end if;

			update LDC_FECH_ESTAD_DEU_PROD
			set
				TIPO_SOLICITUD = ircLDC_FECH_ESTAD_DEU_PROD.TIPO_SOLICITUD,
				FECHA_DEUDA = ircLDC_FECH_ESTAD_DEU_PROD.FECHA_DEUDA
			where
				ID_SOLICITUD = ircLDC_FECH_ESTAD_DEU_PROD.ID_SOLICITUD
			returning
				ID_SOLICITUD
			into
				nuID_SOLICITUD;
		end if;
		if
			nuID_SOLICITUD is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_FECH_ESTAD_DEU_PROD));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_FECH_ESTAD_DEU_PROD in out nocopy tytbLDC_FECH_ESTAD_DEU_PROD,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_FECH_ESTAD_DEU_PROD;
	BEGIN
		FillRecordOfTables(iotbLDC_FECH_ESTAD_DEU_PROD,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_FECH_ESTAD_DEU_PROD.first .. iotbLDC_FECH_ESTAD_DEU_PROD.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_FECH_ESTAD_DEU_PROD.first .. iotbLDC_FECH_ESTAD_DEU_PROD.last
				update LDC_FECH_ESTAD_DEU_PROD
				set
					TIPO_SOLICITUD = rcRecOfTab.TIPO_SOLICITUD(n),
					FECHA_DEUDA = rcRecOfTab.FECHA_DEUDA(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_FECH_ESTAD_DEU_PROD.first .. iotbLDC_FECH_ESTAD_DEU_PROD.last loop
					LockByPk
					(
						rcRecOfTab.ID_SOLICITUD(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_FECH_ESTAD_DEU_PROD.first .. iotbLDC_FECH_ESTAD_DEU_PROD.last
				update LDC_FECH_ESTAD_DEU_PROD
				SET
					TIPO_SOLICITUD = rcRecOfTab.TIPO_SOLICITUD(n),
					FECHA_DEUDA = rcRecOfTab.FECHA_DEUDA(n)
				where
					ID_SOLICITUD = rcRecOfTab.ID_SOLICITUD(n)
;
		end if;
	END;
	PROCEDURE updTIPO_SOLICITUD
	(
		inuID_SOLICITUD in LDC_FECH_ESTAD_DEU_PROD.ID_SOLICITUD%type,
		inuTIPO_SOLICITUD$ in LDC_FECH_ESTAD_DEU_PROD.TIPO_SOLICITUD%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_FECH_ESTAD_DEU_PROD;
	BEGIN
		rcError.ID_SOLICITUD := inuID_SOLICITUD;
		if inuLock=1 then
			LockByPk
			(
				inuID_SOLICITUD,
				rcData
			);
		end if;

		update LDC_FECH_ESTAD_DEU_PROD
		set
			TIPO_SOLICITUD = inuTIPO_SOLICITUD$
		where
			ID_SOLICITUD = inuID_SOLICITUD;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TIPO_SOLICITUD:= inuTIPO_SOLICITUD$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFECHA_DEUDA
	(
		inuID_SOLICITUD in LDC_FECH_ESTAD_DEU_PROD.ID_SOLICITUD%type,
		idtFECHA_DEUDA$ in LDC_FECH_ESTAD_DEU_PROD.FECHA_DEUDA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_FECH_ESTAD_DEU_PROD;
	BEGIN
		rcError.ID_SOLICITUD := inuID_SOLICITUD;
		if inuLock=1 then
			LockByPk
			(
				inuID_SOLICITUD,
				rcData
			);
		end if;

		update LDC_FECH_ESTAD_DEU_PROD
		set
			FECHA_DEUDA = idtFECHA_DEUDA$
		where
			ID_SOLICITUD = inuID_SOLICITUD;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FECHA_DEUDA:= idtFECHA_DEUDA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetID_SOLICITUD
	(
		inuID_SOLICITUD in LDC_FECH_ESTAD_DEU_PROD.ID_SOLICITUD%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_FECH_ESTAD_DEU_PROD.ID_SOLICITUD%type
	IS
		rcError styLDC_FECH_ESTAD_DEU_PROD;
	BEGIN

		rcError.ID_SOLICITUD := inuID_SOLICITUD;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_SOLICITUD
			 )
		then
			 return(rcData.ID_SOLICITUD);
		end if;
		Load
		(
		 		inuID_SOLICITUD
		);
		return(rcData.ID_SOLICITUD);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetTIPO_SOLICITUD
	(
		inuID_SOLICITUD in LDC_FECH_ESTAD_DEU_PROD.ID_SOLICITUD%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_FECH_ESTAD_DEU_PROD.TIPO_SOLICITUD%type
	IS
		rcError styLDC_FECH_ESTAD_DEU_PROD;
	BEGIN

		rcError.ID_SOLICITUD := inuID_SOLICITUD;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_SOLICITUD
			 )
		then
			 return(rcData.TIPO_SOLICITUD);
		end if;
		Load
		(
		 		inuID_SOLICITUD
		);
		return(rcData.TIPO_SOLICITUD);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetFECHA_DEUDA
	(
		inuID_SOLICITUD in LDC_FECH_ESTAD_DEU_PROD.ID_SOLICITUD%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_FECH_ESTAD_DEU_PROD.FECHA_DEUDA%type
	IS
		rcError styLDC_FECH_ESTAD_DEU_PROD;
	BEGIN

		rcError.ID_SOLICITUD := inuID_SOLICITUD;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_SOLICITUD
			 )
		then
			 return(rcData.FECHA_DEUDA);
		end if;
		Load
		(
		 		inuID_SOLICITUD
		);
		return(rcData.FECHA_DEUDA);
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
end DALDC_FECH_ESTAD_DEU_PROD;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALDC_FECH_ESTAD_DEU_PROD
BEGIN
    pkg_utilidades.prAplicarPermisos('DALDC_FECH_ESTAD_DEU_PROD', 'ADM_PERSON'); 
END;
/
