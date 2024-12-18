CREATE OR REPLACE PACKAGE adm_person.daldc_ca_rangperscast
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  11/06/2024   Adrianavg   OSF-2813: Migrar del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuRANGINICANTPER in LDC_CA_RANGPERSCAST.RANGINICANTPER%type,
		inuRANGFINCANTPER in LDC_CA_RANGPERSCAST.RANGFINCANTPER%type
	)
	IS
		SELECT LDC_CA_RANGPERSCAST.*,LDC_CA_RANGPERSCAST.rowid
		FROM LDC_CA_RANGPERSCAST
		WHERE
		    RANGINICANTPER = inuRANGINICANTPER
		    and RANGFINCANTPER = inuRANGFINCANTPER;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_CA_RANGPERSCAST.*,LDC_CA_RANGPERSCAST.rowid
		FROM LDC_CA_RANGPERSCAST
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_CA_RANGPERSCAST  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_CA_RANGPERSCAST is table of styLDC_CA_RANGPERSCAST index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_CA_RANGPERSCAST;

	/* Tipos referenciando al registro */
	type tytbRANGINICANTPER is table of LDC_CA_RANGPERSCAST.RANGINICANTPER%type index by binary_integer;
	type tytbRANGFINCANTPER is table of LDC_CA_RANGPERSCAST.RANGFINCANTPER%type index by binary_integer;
	type tytbVALOR is table of LDC_CA_RANGPERSCAST.VALOR%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_CA_RANGPERSCAST is record
	(
		RANGINICANTPER   tytbRANGINICANTPER,
		RANGFINCANTPER   tytbRANGFINCANTPER,
		VALOR   tytbVALOR,
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
		inuRANGINICANTPER in LDC_CA_RANGPERSCAST.RANGINICANTPER%type,
		inuRANGFINCANTPER in LDC_CA_RANGPERSCAST.RANGFINCANTPER%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuRANGINICANTPER in LDC_CA_RANGPERSCAST.RANGINICANTPER%type,
		inuRANGFINCANTPER in LDC_CA_RANGPERSCAST.RANGFINCANTPER%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuRANGINICANTPER in LDC_CA_RANGPERSCAST.RANGINICANTPER%type,
		inuRANGFINCANTPER in LDC_CA_RANGPERSCAST.RANGFINCANTPER%type
	);

	PROCEDURE getRecord
	(
		inuRANGINICANTPER in LDC_CA_RANGPERSCAST.RANGINICANTPER%type,
		inuRANGFINCANTPER in LDC_CA_RANGPERSCAST.RANGFINCANTPER%type,
		orcRecord out nocopy styLDC_CA_RANGPERSCAST
	);

	FUNCTION frcGetRcData
	(
		inuRANGINICANTPER in LDC_CA_RANGPERSCAST.RANGINICANTPER%type,
		inuRANGFINCANTPER in LDC_CA_RANGPERSCAST.RANGFINCANTPER%type
	)
	RETURN styLDC_CA_RANGPERSCAST;

	FUNCTION frcGetRcData
	RETURN styLDC_CA_RANGPERSCAST;

	FUNCTION frcGetRecord
	(
		inuRANGINICANTPER in LDC_CA_RANGPERSCAST.RANGINICANTPER%type,
		inuRANGFINCANTPER in LDC_CA_RANGPERSCAST.RANGFINCANTPER%type
	)
	RETURN styLDC_CA_RANGPERSCAST;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_CA_RANGPERSCAST
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_CA_RANGPERSCAST in styLDC_CA_RANGPERSCAST
	);

	PROCEDURE insRecord
	(
		ircLDC_CA_RANGPERSCAST in styLDC_CA_RANGPERSCAST,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_CA_RANGPERSCAST in out nocopy tytbLDC_CA_RANGPERSCAST
	);

	PROCEDURE delRecord
	(
		inuRANGINICANTPER in LDC_CA_RANGPERSCAST.RANGINICANTPER%type,
		inuRANGFINCANTPER in LDC_CA_RANGPERSCAST.RANGFINCANTPER%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_CA_RANGPERSCAST in out nocopy tytbLDC_CA_RANGPERSCAST,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_CA_RANGPERSCAST in styLDC_CA_RANGPERSCAST,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_CA_RANGPERSCAST in out nocopy tytbLDC_CA_RANGPERSCAST,
		inuLock in number default 1
	);

	PROCEDURE updVALOR
	(
		inuRANGINICANTPER in LDC_CA_RANGPERSCAST.RANGINICANTPER%type,
		inuRANGFINCANTPER in LDC_CA_RANGPERSCAST.RANGFINCANTPER%type,
		inuVALOR$ in LDC_CA_RANGPERSCAST.VALOR%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetRANGINICANTPER
	(
		inuRANGINICANTPER in LDC_CA_RANGPERSCAST.RANGINICANTPER%type,
		inuRANGFINCANTPER in LDC_CA_RANGPERSCAST.RANGFINCANTPER%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CA_RANGPERSCAST.RANGINICANTPER%type;

	FUNCTION fnuGetRANGFINCANTPER
	(
		inuRANGINICANTPER in LDC_CA_RANGPERSCAST.RANGINICANTPER%type,
		inuRANGFINCANTPER in LDC_CA_RANGPERSCAST.RANGFINCANTPER%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CA_RANGPERSCAST.RANGFINCANTPER%type;

	FUNCTION fnuGetVALOR
	(
		inuRANGINICANTPER in LDC_CA_RANGPERSCAST.RANGINICANTPER%type,
		inuRANGFINCANTPER in LDC_CA_RANGPERSCAST.RANGFINCANTPER%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CA_RANGPERSCAST.VALOR%type;


	PROCEDURE LockByPk
	(
		inuRANGINICANTPER in LDC_CA_RANGPERSCAST.RANGINICANTPER%type,
		inuRANGFINCANTPER in LDC_CA_RANGPERSCAST.RANGFINCANTPER%type,
		orcLDC_CA_RANGPERSCAST  out styLDC_CA_RANGPERSCAST
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_CA_RANGPERSCAST  out styLDC_CA_RANGPERSCAST
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_CA_RANGPERSCAST;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALDC_CA_RANGPERSCAST
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_CA_RANGPERSCAST';
	 cnuGeEntityId constant varchar2(30) := 8325; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuRANGINICANTPER in LDC_CA_RANGPERSCAST.RANGINICANTPER%type,
		inuRANGFINCANTPER in LDC_CA_RANGPERSCAST.RANGFINCANTPER%type
	)
	IS
		SELECT LDC_CA_RANGPERSCAST.*,LDC_CA_RANGPERSCAST.rowid
		FROM LDC_CA_RANGPERSCAST
		WHERE  RANGINICANTPER = inuRANGINICANTPER
			and RANGFINCANTPER = inuRANGFINCANTPER
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_CA_RANGPERSCAST.*,LDC_CA_RANGPERSCAST.rowid
		FROM LDC_CA_RANGPERSCAST
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_CA_RANGPERSCAST is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_CA_RANGPERSCAST;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_CA_RANGPERSCAST default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.RANGINICANTPER);
		sbPk:=sbPk||','||ut_convert.fsbToChar(rcI.RANGFINCANTPER);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuRANGINICANTPER in LDC_CA_RANGPERSCAST.RANGINICANTPER%type,
		inuRANGFINCANTPER in LDC_CA_RANGPERSCAST.RANGFINCANTPER%type,
		orcLDC_CA_RANGPERSCAST  out styLDC_CA_RANGPERSCAST
	)
	IS
		rcError styLDC_CA_RANGPERSCAST;
	BEGIN
		rcError.RANGINICANTPER := inuRANGINICANTPER;
		rcError.RANGFINCANTPER := inuRANGFINCANTPER;

		Open cuLockRcByPk
		(
			inuRANGINICANTPER,
			inuRANGFINCANTPER
		);

		fetch cuLockRcByPk into orcLDC_CA_RANGPERSCAST;
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
		orcLDC_CA_RANGPERSCAST  out styLDC_CA_RANGPERSCAST
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_CA_RANGPERSCAST;
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
		itbLDC_CA_RANGPERSCAST  in out nocopy tytbLDC_CA_RANGPERSCAST
	)
	IS
	BEGIN
			rcRecOfTab.RANGINICANTPER.delete;
			rcRecOfTab.RANGFINCANTPER.delete;
			rcRecOfTab.VALOR.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_CA_RANGPERSCAST  in out nocopy tytbLDC_CA_RANGPERSCAST,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_CA_RANGPERSCAST);

		for n in itbLDC_CA_RANGPERSCAST.first .. itbLDC_CA_RANGPERSCAST.last loop
			rcRecOfTab.RANGINICANTPER(n) := itbLDC_CA_RANGPERSCAST(n).RANGINICANTPER;
			rcRecOfTab.RANGFINCANTPER(n) := itbLDC_CA_RANGPERSCAST(n).RANGFINCANTPER;
			rcRecOfTab.VALOR(n) := itbLDC_CA_RANGPERSCAST(n).VALOR;
			rcRecOfTab.row_id(n) := itbLDC_CA_RANGPERSCAST(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuRANGINICANTPER in LDC_CA_RANGPERSCAST.RANGINICANTPER%type,
		inuRANGFINCANTPER in LDC_CA_RANGPERSCAST.RANGFINCANTPER%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuRANGINICANTPER,
			inuRANGFINCANTPER
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
		inuRANGINICANTPER in LDC_CA_RANGPERSCAST.RANGINICANTPER%type,
		inuRANGFINCANTPER in LDC_CA_RANGPERSCAST.RANGFINCANTPER%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuRANGINICANTPER = rcData.RANGINICANTPER AND
			inuRANGFINCANTPER = rcData.RANGFINCANTPER
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
		inuRANGINICANTPER in LDC_CA_RANGPERSCAST.RANGINICANTPER%type,
		inuRANGFINCANTPER in LDC_CA_RANGPERSCAST.RANGFINCANTPER%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuRANGINICANTPER,
			inuRANGFINCANTPER
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuRANGINICANTPER in LDC_CA_RANGPERSCAST.RANGINICANTPER%type,
		inuRANGFINCANTPER in LDC_CA_RANGPERSCAST.RANGFINCANTPER%type
	)
	IS
		rcError styLDC_CA_RANGPERSCAST;
	BEGIN		rcError.RANGINICANTPER:=inuRANGINICANTPER;		rcError.RANGFINCANTPER:=inuRANGFINCANTPER;

		Load
		(
			inuRANGINICANTPER,
			inuRANGFINCANTPER
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
		inuRANGINICANTPER in LDC_CA_RANGPERSCAST.RANGINICANTPER%type,
		inuRANGFINCANTPER in LDC_CA_RANGPERSCAST.RANGFINCANTPER%type
	)
	IS
	BEGIN
		Load
		(
			inuRANGINICANTPER,
			inuRANGFINCANTPER
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuRANGINICANTPER in LDC_CA_RANGPERSCAST.RANGINICANTPER%type,
		inuRANGFINCANTPER in LDC_CA_RANGPERSCAST.RANGFINCANTPER%type,
		orcRecord out nocopy styLDC_CA_RANGPERSCAST
	)
	IS
		rcError styLDC_CA_RANGPERSCAST;
	BEGIN		rcError.RANGINICANTPER:=inuRANGINICANTPER;		rcError.RANGFINCANTPER:=inuRANGFINCANTPER;

		Load
		(
			inuRANGINICANTPER,
			inuRANGFINCANTPER
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuRANGINICANTPER in LDC_CA_RANGPERSCAST.RANGINICANTPER%type,
		inuRANGFINCANTPER in LDC_CA_RANGPERSCAST.RANGFINCANTPER%type
	)
	RETURN styLDC_CA_RANGPERSCAST
	IS
		rcError styLDC_CA_RANGPERSCAST;
	BEGIN
		rcError.RANGINICANTPER:=inuRANGINICANTPER;
		rcError.RANGFINCANTPER:=inuRANGFINCANTPER;

		Load
		(
			inuRANGINICANTPER,
			inuRANGFINCANTPER
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuRANGINICANTPER in LDC_CA_RANGPERSCAST.RANGINICANTPER%type,
		inuRANGFINCANTPER in LDC_CA_RANGPERSCAST.RANGFINCANTPER%type
	)
	RETURN styLDC_CA_RANGPERSCAST
	IS
		rcError styLDC_CA_RANGPERSCAST;
	BEGIN
		rcError.RANGINICANTPER:=inuRANGINICANTPER;
		rcError.RANGFINCANTPER:=inuRANGFINCANTPER;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuRANGINICANTPER,
			inuRANGFINCANTPER
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuRANGINICANTPER,
			inuRANGFINCANTPER
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_CA_RANGPERSCAST
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_CA_RANGPERSCAST
	)
	IS
		rfLDC_CA_RANGPERSCAST tyrfLDC_CA_RANGPERSCAST;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_CA_RANGPERSCAST.*, LDC_CA_RANGPERSCAST.rowid FROM LDC_CA_RANGPERSCAST';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_CA_RANGPERSCAST for sbFullQuery;

		fetch rfLDC_CA_RANGPERSCAST bulk collect INTO otbResult;

		close rfLDC_CA_RANGPERSCAST;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_CA_RANGPERSCAST.*, LDC_CA_RANGPERSCAST.rowid FROM LDC_CA_RANGPERSCAST';
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
		ircLDC_CA_RANGPERSCAST in styLDC_CA_RANGPERSCAST
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_CA_RANGPERSCAST,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_CA_RANGPERSCAST in styLDC_CA_RANGPERSCAST,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_CA_RANGPERSCAST.RANGINICANTPER is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|RANGINICANTPER');
			raise ex.controlled_error;
		end if;
		if ircLDC_CA_RANGPERSCAST.RANGFINCANTPER is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|RANGFINCANTPER');
			raise ex.controlled_error;
		end if;

		insert into LDC_CA_RANGPERSCAST
		(
			RANGINICANTPER,
			RANGFINCANTPER,
			VALOR
		)
		values
		(
			ircLDC_CA_RANGPERSCAST.RANGINICANTPER,
			ircLDC_CA_RANGPERSCAST.RANGFINCANTPER,
			ircLDC_CA_RANGPERSCAST.VALOR
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_CA_RANGPERSCAST));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_CA_RANGPERSCAST in out nocopy tytbLDC_CA_RANGPERSCAST
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_CA_RANGPERSCAST,blUseRowID);
		forall n in iotbLDC_CA_RANGPERSCAST.first..iotbLDC_CA_RANGPERSCAST.last
			insert into LDC_CA_RANGPERSCAST
			(
				RANGINICANTPER,
				RANGFINCANTPER,
				VALOR
			)
			values
			(
				rcRecOfTab.RANGINICANTPER(n),
				rcRecOfTab.RANGFINCANTPER(n),
				rcRecOfTab.VALOR(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuRANGINICANTPER in LDC_CA_RANGPERSCAST.RANGINICANTPER%type,
		inuRANGFINCANTPER in LDC_CA_RANGPERSCAST.RANGFINCANTPER%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_CA_RANGPERSCAST;
	BEGIN
		rcError.RANGINICANTPER := inuRANGINICANTPER;
		rcError.RANGFINCANTPER := inuRANGFINCANTPER;

		if inuLock=1 then
			LockByPk
			(
				inuRANGINICANTPER,
				inuRANGFINCANTPER,
				rcData
			);
		end if;


		delete
		from LDC_CA_RANGPERSCAST
		where
       		RANGINICANTPER=inuRANGINICANTPER and
       		RANGFINCANTPER=inuRANGFINCANTPER;
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
		rcError  styLDC_CA_RANGPERSCAST;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_CA_RANGPERSCAST
		where
			rowid = iriRowID
		returning
			RANGINICANTPER,
			RANGFINCANTPER
		into
			rcError.RANGINICANTPER,
			rcError.RANGFINCANTPER;
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
		iotbLDC_CA_RANGPERSCAST in out nocopy tytbLDC_CA_RANGPERSCAST,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_CA_RANGPERSCAST;
	BEGIN
		FillRecordOfTables(iotbLDC_CA_RANGPERSCAST, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_CA_RANGPERSCAST.first .. iotbLDC_CA_RANGPERSCAST.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CA_RANGPERSCAST.first .. iotbLDC_CA_RANGPERSCAST.last
				delete
				from LDC_CA_RANGPERSCAST
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_CA_RANGPERSCAST.first .. iotbLDC_CA_RANGPERSCAST.last loop
					LockByPk
					(
						rcRecOfTab.RANGINICANTPER(n),
						rcRecOfTab.RANGFINCANTPER(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CA_RANGPERSCAST.first .. iotbLDC_CA_RANGPERSCAST.last
				delete
				from LDC_CA_RANGPERSCAST
				where
		         	RANGINICANTPER = rcRecOfTab.RANGINICANTPER(n) and
		         	RANGFINCANTPER = rcRecOfTab.RANGFINCANTPER(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_CA_RANGPERSCAST in styLDC_CA_RANGPERSCAST,
		inuLock in number default 0
	)
	IS
		nuRANGINICANTPER	LDC_CA_RANGPERSCAST.RANGINICANTPER%type;
		nuRANGFINCANTPER	LDC_CA_RANGPERSCAST.RANGFINCANTPER%type;
	BEGIN
		if ircLDC_CA_RANGPERSCAST.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_CA_RANGPERSCAST.rowid,rcData);
			end if;
			update LDC_CA_RANGPERSCAST
			set
				VALOR = ircLDC_CA_RANGPERSCAST.VALOR
			where
				rowid = ircLDC_CA_RANGPERSCAST.rowid
			returning
				RANGINICANTPER,
				RANGFINCANTPER
			into
				nuRANGINICANTPER,
				nuRANGFINCANTPER;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_CA_RANGPERSCAST.RANGINICANTPER,
					ircLDC_CA_RANGPERSCAST.RANGFINCANTPER,
					rcData
				);
			end if;

			update LDC_CA_RANGPERSCAST
			set
				VALOR = ircLDC_CA_RANGPERSCAST.VALOR
			where
				RANGINICANTPER = ircLDC_CA_RANGPERSCAST.RANGINICANTPER and
				RANGFINCANTPER = ircLDC_CA_RANGPERSCAST.RANGFINCANTPER
			returning
				RANGINICANTPER,
				RANGFINCANTPER
			into
				nuRANGINICANTPER,
				nuRANGFINCANTPER;
		end if;
		if
			nuRANGINICANTPER is NULL OR
			nuRANGFINCANTPER is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_CA_RANGPERSCAST));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_CA_RANGPERSCAST in out nocopy tytbLDC_CA_RANGPERSCAST,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_CA_RANGPERSCAST;
	BEGIN
		FillRecordOfTables(iotbLDC_CA_RANGPERSCAST,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_CA_RANGPERSCAST.first .. iotbLDC_CA_RANGPERSCAST.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CA_RANGPERSCAST.first .. iotbLDC_CA_RANGPERSCAST.last
				update LDC_CA_RANGPERSCAST
				set
					VALOR = rcRecOfTab.VALOR(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_CA_RANGPERSCAST.first .. iotbLDC_CA_RANGPERSCAST.last loop
					LockByPk
					(
						rcRecOfTab.RANGINICANTPER(n),
						rcRecOfTab.RANGFINCANTPER(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CA_RANGPERSCAST.first .. iotbLDC_CA_RANGPERSCAST.last
				update LDC_CA_RANGPERSCAST
				SET
					VALOR = rcRecOfTab.VALOR(n)
				where
					RANGINICANTPER = rcRecOfTab.RANGINICANTPER(n) and
					RANGFINCANTPER = rcRecOfTab.RANGFINCANTPER(n)
;
		end if;
	END;
	PROCEDURE updVALOR
	(
		inuRANGINICANTPER in LDC_CA_RANGPERSCAST.RANGINICANTPER%type,
		inuRANGFINCANTPER in LDC_CA_RANGPERSCAST.RANGFINCANTPER%type,
		inuVALOR$ in LDC_CA_RANGPERSCAST.VALOR%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CA_RANGPERSCAST;
	BEGIN
		rcError.RANGINICANTPER := inuRANGINICANTPER;
		rcError.RANGFINCANTPER := inuRANGFINCANTPER;
		if inuLock=1 then
			LockByPk
			(
				inuRANGINICANTPER,
				inuRANGFINCANTPER,
				rcData
			);
		end if;

		update LDC_CA_RANGPERSCAST
		set
			VALOR = inuVALOR$
		where
			RANGINICANTPER = inuRANGINICANTPER and
			RANGFINCANTPER = inuRANGFINCANTPER;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.VALOR:= inuVALOR$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetRANGINICANTPER
	(
		inuRANGINICANTPER in LDC_CA_RANGPERSCAST.RANGINICANTPER%type,
		inuRANGFINCANTPER in LDC_CA_RANGPERSCAST.RANGFINCANTPER%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CA_RANGPERSCAST.RANGINICANTPER%type
	IS
		rcError styLDC_CA_RANGPERSCAST;
	BEGIN

		rcError.RANGINICANTPER := inuRANGINICANTPER;
		rcError.RANGFINCANTPER := inuRANGFINCANTPER;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRANGINICANTPER,
		 		inuRANGFINCANTPER
			 )
		then
			 return(rcData.RANGINICANTPER);
		end if;
		Load
		(
		 		inuRANGINICANTPER,
		 		inuRANGFINCANTPER
		);
		return(rcData.RANGINICANTPER);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetRANGFINCANTPER
	(
		inuRANGINICANTPER in LDC_CA_RANGPERSCAST.RANGINICANTPER%type,
		inuRANGFINCANTPER in LDC_CA_RANGPERSCAST.RANGFINCANTPER%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CA_RANGPERSCAST.RANGFINCANTPER%type
	IS
		rcError styLDC_CA_RANGPERSCAST;
	BEGIN

		rcError.RANGINICANTPER := inuRANGINICANTPER;
		rcError.RANGFINCANTPER := inuRANGFINCANTPER;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRANGINICANTPER,
		 		inuRANGFINCANTPER
			 )
		then
			 return(rcData.RANGFINCANTPER);
		end if;
		Load
		(
		 		inuRANGINICANTPER,
		 		inuRANGFINCANTPER
		);
		return(rcData.RANGFINCANTPER);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetVALOR
	(
		inuRANGINICANTPER in LDC_CA_RANGPERSCAST.RANGINICANTPER%type,
		inuRANGFINCANTPER in LDC_CA_RANGPERSCAST.RANGFINCANTPER%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CA_RANGPERSCAST.VALOR%type
	IS
		rcError styLDC_CA_RANGPERSCAST;
	BEGIN

		rcError.RANGINICANTPER := inuRANGINICANTPER;
		rcError.RANGFINCANTPER := inuRANGFINCANTPER;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRANGINICANTPER,
		 		inuRANGFINCANTPER
			 )
		then
			 return(rcData.VALOR);
		end if;
		Load
		(
		 		inuRANGINICANTPER,
		 		inuRANGFINCANTPER
		);
		return(rcData.VALOR);
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
end DALDC_CA_RANGPERSCAST;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALDC_CA_RANGPERSCAST
BEGIN
    pkg_utilidades.prAplicarPermisos('DALDC_CA_RANGPERSCAST', 'ADM_PERSON'); 
END;
/