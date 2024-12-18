CREATE OR REPLACE PACKAGE adm_person.daldc_ca_liquidareca
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  11/06/2024   Adrianavg   OSF-2813: Migrar del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuIDLIQUIDARECA in LDC_CA_LIQUIDARECA.IDLIQUIDARECA%type
	)
	IS
		SELECT LDC_CA_LIQUIDARECA.*,LDC_CA_LIQUIDARECA.rowid
		FROM LDC_CA_LIQUIDARECA
		WHERE
		    IDLIQUIDARECA = inuIDLIQUIDARECA;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_CA_LIQUIDARECA.*,LDC_CA_LIQUIDARECA.rowid
		FROM LDC_CA_LIQUIDARECA
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_CA_LIQUIDARECA  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_CA_LIQUIDARECA is table of styLDC_CA_LIQUIDARECA index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_CA_LIQUIDARECA;

	/* Tipos referenciando al registro */
	type tytbIDLIQUIDARECA is table of LDC_CA_LIQUIDARECA.IDLIQUIDARECA%type index by binary_integer;
	type tytbIDOPERUNITXRANGOREC is table of LDC_CA_LIQUIDARECA.IDOPERUNITXRANGOREC%type index by binary_integer;
	type tytbPORCINICIAL is table of LDC_CA_LIQUIDARECA.PORCINICIAL%type index by binary_integer;
	type tytbPORCFINAL is table of LDC_CA_LIQUIDARECA.PORCFINAL%type index by binary_integer;
	type tytbVALORPORC is table of LDC_CA_LIQUIDARECA.VALORPORC%type index by binary_integer;
	type tytbDEPARTAMENTO is table of LDC_CA_LIQUIDARECA.DEPARTAMENTO%type index by binary_integer;
	type tytbLOCALIDA is table of LDC_CA_LIQUIDARECA.LOCALIDA%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_CA_LIQUIDARECA is record
	(
		IDLIQUIDARECA   tytbIDLIQUIDARECA,
		IDOPERUNITXRANGOREC   tytbIDOPERUNITXRANGOREC,
		PORCINICIAL   tytbPORCINICIAL,
		PORCFINAL   tytbPORCFINAL,
		VALORPORC   tytbVALORPORC,
		DEPARTAMENTO   tytbDEPARTAMENTO,
		LOCALIDA   tytbLOCALIDA,
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
		inuIDLIQUIDARECA in LDC_CA_LIQUIDARECA.IDLIQUIDARECA%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuIDLIQUIDARECA in LDC_CA_LIQUIDARECA.IDLIQUIDARECA%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuIDLIQUIDARECA in LDC_CA_LIQUIDARECA.IDLIQUIDARECA%type
	);

	PROCEDURE getRecord
	(
		inuIDLIQUIDARECA in LDC_CA_LIQUIDARECA.IDLIQUIDARECA%type,
		orcRecord out nocopy styLDC_CA_LIQUIDARECA
	);

	FUNCTION frcGetRcData
	(
		inuIDLIQUIDARECA in LDC_CA_LIQUIDARECA.IDLIQUIDARECA%type
	)
	RETURN styLDC_CA_LIQUIDARECA;

	FUNCTION frcGetRcData
	RETURN styLDC_CA_LIQUIDARECA;

	FUNCTION frcGetRecord
	(
		inuIDLIQUIDARECA in LDC_CA_LIQUIDARECA.IDLIQUIDARECA%type
	)
	RETURN styLDC_CA_LIQUIDARECA;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_CA_LIQUIDARECA
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_CA_LIQUIDARECA in styLDC_CA_LIQUIDARECA
	);

	PROCEDURE insRecord
	(
		ircLDC_CA_LIQUIDARECA in styLDC_CA_LIQUIDARECA,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_CA_LIQUIDARECA in out nocopy tytbLDC_CA_LIQUIDARECA
	);

	PROCEDURE delRecord
	(
		inuIDLIQUIDARECA in LDC_CA_LIQUIDARECA.IDLIQUIDARECA%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_CA_LIQUIDARECA in out nocopy tytbLDC_CA_LIQUIDARECA,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_CA_LIQUIDARECA in styLDC_CA_LIQUIDARECA,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_CA_LIQUIDARECA in out nocopy tytbLDC_CA_LIQUIDARECA,
		inuLock in number default 1
	);

	PROCEDURE updIDOPERUNITXRANGOREC
	(
		inuIDLIQUIDARECA in LDC_CA_LIQUIDARECA.IDLIQUIDARECA%type,
		inuIDOPERUNITXRANGOREC$ in LDC_CA_LIQUIDARECA.IDOPERUNITXRANGOREC%type,
		inuLock in number default 0
	);

	PROCEDURE updPORCINICIAL
	(
		inuIDLIQUIDARECA in LDC_CA_LIQUIDARECA.IDLIQUIDARECA%type,
		inuPORCINICIAL$ in LDC_CA_LIQUIDARECA.PORCINICIAL%type,
		inuLock in number default 0
	);

	PROCEDURE updPORCFINAL
	(
		inuIDLIQUIDARECA in LDC_CA_LIQUIDARECA.IDLIQUIDARECA%type,
		inuPORCFINAL$ in LDC_CA_LIQUIDARECA.PORCFINAL%type,
		inuLock in number default 0
	);

	PROCEDURE updVALORPORC
	(
		inuIDLIQUIDARECA in LDC_CA_LIQUIDARECA.IDLIQUIDARECA%type,
		inuVALORPORC$ in LDC_CA_LIQUIDARECA.VALORPORC%type,
		inuLock in number default 0
	);

	PROCEDURE updDEPARTAMENTO
	(
		inuIDLIQUIDARECA in LDC_CA_LIQUIDARECA.IDLIQUIDARECA%type,
		inuDEPARTAMENTO$ in LDC_CA_LIQUIDARECA.DEPARTAMENTO%type,
		inuLock in number default 0
	);

	PROCEDURE updLOCALIDA
	(
		inuIDLIQUIDARECA in LDC_CA_LIQUIDARECA.IDLIQUIDARECA%type,
		inuLOCALIDA$ in LDC_CA_LIQUIDARECA.LOCALIDA%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetIDLIQUIDARECA
	(
		inuIDLIQUIDARECA in LDC_CA_LIQUIDARECA.IDLIQUIDARECA%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CA_LIQUIDARECA.IDLIQUIDARECA%type;

	FUNCTION fnuGetIDOPERUNITXRANGOREC
	(
		inuIDLIQUIDARECA in LDC_CA_LIQUIDARECA.IDLIQUIDARECA%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CA_LIQUIDARECA.IDOPERUNITXRANGOREC%type;

	FUNCTION fnuGetPORCINICIAL
	(
		inuIDLIQUIDARECA in LDC_CA_LIQUIDARECA.IDLIQUIDARECA%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CA_LIQUIDARECA.PORCINICIAL%type;

	FUNCTION fnuGetPORCFINAL
	(
		inuIDLIQUIDARECA in LDC_CA_LIQUIDARECA.IDLIQUIDARECA%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CA_LIQUIDARECA.PORCFINAL%type;

	FUNCTION fnuGetVALORPORC
	(
		inuIDLIQUIDARECA in LDC_CA_LIQUIDARECA.IDLIQUIDARECA%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CA_LIQUIDARECA.VALORPORC%type;

	FUNCTION fnuGetDEPARTAMENTO
	(
		inuIDLIQUIDARECA in LDC_CA_LIQUIDARECA.IDLIQUIDARECA%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CA_LIQUIDARECA.DEPARTAMENTO%type;

	FUNCTION fnuGetLOCALIDA
	(
		inuIDLIQUIDARECA in LDC_CA_LIQUIDARECA.IDLIQUIDARECA%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CA_LIQUIDARECA.LOCALIDA%type;


	PROCEDURE LockByPk
	(
		inuIDLIQUIDARECA in LDC_CA_LIQUIDARECA.IDLIQUIDARECA%type,
		orcLDC_CA_LIQUIDARECA  out styLDC_CA_LIQUIDARECA
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_CA_LIQUIDARECA  out styLDC_CA_LIQUIDARECA
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_CA_LIQUIDARECA;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALDC_CA_LIQUIDARECA
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_CA_LIQUIDARECA';
	 cnuGeEntityId constant varchar2(30) := 8274; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuIDLIQUIDARECA in LDC_CA_LIQUIDARECA.IDLIQUIDARECA%type
	)
	IS
		SELECT LDC_CA_LIQUIDARECA.*,LDC_CA_LIQUIDARECA.rowid
		FROM LDC_CA_LIQUIDARECA
		WHERE  IDLIQUIDARECA = inuIDLIQUIDARECA
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_CA_LIQUIDARECA.*,LDC_CA_LIQUIDARECA.rowid
		FROM LDC_CA_LIQUIDARECA
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_CA_LIQUIDARECA is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_CA_LIQUIDARECA;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_CA_LIQUIDARECA default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.IDLIQUIDARECA);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuIDLIQUIDARECA in LDC_CA_LIQUIDARECA.IDLIQUIDARECA%type,
		orcLDC_CA_LIQUIDARECA  out styLDC_CA_LIQUIDARECA
	)
	IS
		rcError styLDC_CA_LIQUIDARECA;
	BEGIN
		rcError.IDLIQUIDARECA := inuIDLIQUIDARECA;

		Open cuLockRcByPk
		(
			inuIDLIQUIDARECA
		);

		fetch cuLockRcByPk into orcLDC_CA_LIQUIDARECA;
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
		orcLDC_CA_LIQUIDARECA  out styLDC_CA_LIQUIDARECA
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_CA_LIQUIDARECA;
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
		itbLDC_CA_LIQUIDARECA  in out nocopy tytbLDC_CA_LIQUIDARECA
	)
	IS
	BEGIN
			rcRecOfTab.IDLIQUIDARECA.delete;
			rcRecOfTab.IDOPERUNITXRANGOREC.delete;
			rcRecOfTab.PORCINICIAL.delete;
			rcRecOfTab.PORCFINAL.delete;
			rcRecOfTab.VALORPORC.delete;
			rcRecOfTab.DEPARTAMENTO.delete;
			rcRecOfTab.LOCALIDA.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_CA_LIQUIDARECA  in out nocopy tytbLDC_CA_LIQUIDARECA,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_CA_LIQUIDARECA);

		for n in itbLDC_CA_LIQUIDARECA.first .. itbLDC_CA_LIQUIDARECA.last loop
			rcRecOfTab.IDLIQUIDARECA(n) := itbLDC_CA_LIQUIDARECA(n).IDLIQUIDARECA;
			rcRecOfTab.IDOPERUNITXRANGOREC(n) := itbLDC_CA_LIQUIDARECA(n).IDOPERUNITXRANGOREC;
			rcRecOfTab.PORCINICIAL(n) := itbLDC_CA_LIQUIDARECA(n).PORCINICIAL;
			rcRecOfTab.PORCFINAL(n) := itbLDC_CA_LIQUIDARECA(n).PORCFINAL;
			rcRecOfTab.VALORPORC(n) := itbLDC_CA_LIQUIDARECA(n).VALORPORC;
			rcRecOfTab.DEPARTAMENTO(n) := itbLDC_CA_LIQUIDARECA(n).DEPARTAMENTO;
			rcRecOfTab.LOCALIDA(n) := itbLDC_CA_LIQUIDARECA(n).LOCALIDA;
			rcRecOfTab.row_id(n) := itbLDC_CA_LIQUIDARECA(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuIDLIQUIDARECA in LDC_CA_LIQUIDARECA.IDLIQUIDARECA%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuIDLIQUIDARECA
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
		inuIDLIQUIDARECA in LDC_CA_LIQUIDARECA.IDLIQUIDARECA%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuIDLIQUIDARECA = rcData.IDLIQUIDARECA
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
		inuIDLIQUIDARECA in LDC_CA_LIQUIDARECA.IDLIQUIDARECA%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuIDLIQUIDARECA
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuIDLIQUIDARECA in LDC_CA_LIQUIDARECA.IDLIQUIDARECA%type
	)
	IS
		rcError styLDC_CA_LIQUIDARECA;
	BEGIN		rcError.IDLIQUIDARECA:=inuIDLIQUIDARECA;

		Load
		(
			inuIDLIQUIDARECA
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
		inuIDLIQUIDARECA in LDC_CA_LIQUIDARECA.IDLIQUIDARECA%type
	)
	IS
	BEGIN
		Load
		(
			inuIDLIQUIDARECA
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuIDLIQUIDARECA in LDC_CA_LIQUIDARECA.IDLIQUIDARECA%type,
		orcRecord out nocopy styLDC_CA_LIQUIDARECA
	)
	IS
		rcError styLDC_CA_LIQUIDARECA;
	BEGIN		rcError.IDLIQUIDARECA:=inuIDLIQUIDARECA;

		Load
		(
			inuIDLIQUIDARECA
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuIDLIQUIDARECA in LDC_CA_LIQUIDARECA.IDLIQUIDARECA%type
	)
	RETURN styLDC_CA_LIQUIDARECA
	IS
		rcError styLDC_CA_LIQUIDARECA;
	BEGIN
		rcError.IDLIQUIDARECA:=inuIDLIQUIDARECA;

		Load
		(
			inuIDLIQUIDARECA
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuIDLIQUIDARECA in LDC_CA_LIQUIDARECA.IDLIQUIDARECA%type
	)
	RETURN styLDC_CA_LIQUIDARECA
	IS
		rcError styLDC_CA_LIQUIDARECA;
	BEGIN
		rcError.IDLIQUIDARECA:=inuIDLIQUIDARECA;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuIDLIQUIDARECA
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuIDLIQUIDARECA
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_CA_LIQUIDARECA
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_CA_LIQUIDARECA
	)
	IS
		rfLDC_CA_LIQUIDARECA tyrfLDC_CA_LIQUIDARECA;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_CA_LIQUIDARECA.*, LDC_CA_LIQUIDARECA.rowid FROM LDC_CA_LIQUIDARECA';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_CA_LIQUIDARECA for sbFullQuery;

		fetch rfLDC_CA_LIQUIDARECA bulk collect INTO otbResult;

		close rfLDC_CA_LIQUIDARECA;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_CA_LIQUIDARECA.*, LDC_CA_LIQUIDARECA.rowid FROM LDC_CA_LIQUIDARECA';
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
		ircLDC_CA_LIQUIDARECA in styLDC_CA_LIQUIDARECA
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_CA_LIQUIDARECA,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_CA_LIQUIDARECA in styLDC_CA_LIQUIDARECA,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_CA_LIQUIDARECA.IDLIQUIDARECA is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|IDLIQUIDARECA');
			raise ex.controlled_error;
		end if;

		insert into LDC_CA_LIQUIDARECA
		(
			IDLIQUIDARECA,
			IDOPERUNITXRANGOREC,
			PORCINICIAL,
			PORCFINAL,
			VALORPORC,
			DEPARTAMENTO,
			LOCALIDA
		)
		values
		(
			ircLDC_CA_LIQUIDARECA.IDLIQUIDARECA,
			ircLDC_CA_LIQUIDARECA.IDOPERUNITXRANGOREC,
			ircLDC_CA_LIQUIDARECA.PORCINICIAL,
			ircLDC_CA_LIQUIDARECA.PORCFINAL,
			ircLDC_CA_LIQUIDARECA.VALORPORC,
			ircLDC_CA_LIQUIDARECA.DEPARTAMENTO,
			ircLDC_CA_LIQUIDARECA.LOCALIDA
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_CA_LIQUIDARECA));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_CA_LIQUIDARECA in out nocopy tytbLDC_CA_LIQUIDARECA
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_CA_LIQUIDARECA,blUseRowID);
		forall n in iotbLDC_CA_LIQUIDARECA.first..iotbLDC_CA_LIQUIDARECA.last
			insert into LDC_CA_LIQUIDARECA
			(
				IDLIQUIDARECA,
				IDOPERUNITXRANGOREC,
				PORCINICIAL,
				PORCFINAL,
				VALORPORC,
				DEPARTAMENTO,
				LOCALIDA
			)
			values
			(
				rcRecOfTab.IDLIQUIDARECA(n),
				rcRecOfTab.IDOPERUNITXRANGOREC(n),
				rcRecOfTab.PORCINICIAL(n),
				rcRecOfTab.PORCFINAL(n),
				rcRecOfTab.VALORPORC(n),
				rcRecOfTab.DEPARTAMENTO(n),
				rcRecOfTab.LOCALIDA(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuIDLIQUIDARECA in LDC_CA_LIQUIDARECA.IDLIQUIDARECA%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_CA_LIQUIDARECA;
	BEGIN
		rcError.IDLIQUIDARECA := inuIDLIQUIDARECA;

		if inuLock=1 then
			LockByPk
			(
				inuIDLIQUIDARECA,
				rcData
			);
		end if;


		delete
		from LDC_CA_LIQUIDARECA
		where
       		IDLIQUIDARECA=inuIDLIQUIDARECA;
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
		rcError  styLDC_CA_LIQUIDARECA;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_CA_LIQUIDARECA
		where
			rowid = iriRowID
		returning
			IDLIQUIDARECA
		into
			rcError.IDLIQUIDARECA;
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
		iotbLDC_CA_LIQUIDARECA in out nocopy tytbLDC_CA_LIQUIDARECA,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_CA_LIQUIDARECA;
	BEGIN
		FillRecordOfTables(iotbLDC_CA_LIQUIDARECA, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_CA_LIQUIDARECA.first .. iotbLDC_CA_LIQUIDARECA.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CA_LIQUIDARECA.first .. iotbLDC_CA_LIQUIDARECA.last
				delete
				from LDC_CA_LIQUIDARECA
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_CA_LIQUIDARECA.first .. iotbLDC_CA_LIQUIDARECA.last loop
					LockByPk
					(
						rcRecOfTab.IDLIQUIDARECA(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CA_LIQUIDARECA.first .. iotbLDC_CA_LIQUIDARECA.last
				delete
				from LDC_CA_LIQUIDARECA
				where
		         	IDLIQUIDARECA = rcRecOfTab.IDLIQUIDARECA(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_CA_LIQUIDARECA in styLDC_CA_LIQUIDARECA,
		inuLock in number default 0
	)
	IS
		nuIDLIQUIDARECA	LDC_CA_LIQUIDARECA.IDLIQUIDARECA%type;
	BEGIN
		if ircLDC_CA_LIQUIDARECA.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_CA_LIQUIDARECA.rowid,rcData);
			end if;
			update LDC_CA_LIQUIDARECA
			set
				IDOPERUNITXRANGOREC = ircLDC_CA_LIQUIDARECA.IDOPERUNITXRANGOREC,
				PORCINICIAL = ircLDC_CA_LIQUIDARECA.PORCINICIAL,
				PORCFINAL = ircLDC_CA_LIQUIDARECA.PORCFINAL,
				VALORPORC = ircLDC_CA_LIQUIDARECA.VALORPORC,
				DEPARTAMENTO = ircLDC_CA_LIQUIDARECA.DEPARTAMENTO,
				LOCALIDA = ircLDC_CA_LIQUIDARECA.LOCALIDA
			where
				rowid = ircLDC_CA_LIQUIDARECA.rowid
			returning
				IDLIQUIDARECA
			into
				nuIDLIQUIDARECA;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_CA_LIQUIDARECA.IDLIQUIDARECA,
					rcData
				);
			end if;

			update LDC_CA_LIQUIDARECA
			set
				IDOPERUNITXRANGOREC = ircLDC_CA_LIQUIDARECA.IDOPERUNITXRANGOREC,
				PORCINICIAL = ircLDC_CA_LIQUIDARECA.PORCINICIAL,
				PORCFINAL = ircLDC_CA_LIQUIDARECA.PORCFINAL,
				VALORPORC = ircLDC_CA_LIQUIDARECA.VALORPORC,
				DEPARTAMENTO = ircLDC_CA_LIQUIDARECA.DEPARTAMENTO,
				LOCALIDA = ircLDC_CA_LIQUIDARECA.LOCALIDA
			where
				IDLIQUIDARECA = ircLDC_CA_LIQUIDARECA.IDLIQUIDARECA
			returning
				IDLIQUIDARECA
			into
				nuIDLIQUIDARECA;
		end if;
		if
			nuIDLIQUIDARECA is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_CA_LIQUIDARECA));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_CA_LIQUIDARECA in out nocopy tytbLDC_CA_LIQUIDARECA,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_CA_LIQUIDARECA;
	BEGIN
		FillRecordOfTables(iotbLDC_CA_LIQUIDARECA,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_CA_LIQUIDARECA.first .. iotbLDC_CA_LIQUIDARECA.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CA_LIQUIDARECA.first .. iotbLDC_CA_LIQUIDARECA.last
				update LDC_CA_LIQUIDARECA
				set
					IDOPERUNITXRANGOREC = rcRecOfTab.IDOPERUNITXRANGOREC(n),
					PORCINICIAL = rcRecOfTab.PORCINICIAL(n),
					PORCFINAL = rcRecOfTab.PORCFINAL(n),
					VALORPORC = rcRecOfTab.VALORPORC(n),
					DEPARTAMENTO = rcRecOfTab.DEPARTAMENTO(n),
					LOCALIDA = rcRecOfTab.LOCALIDA(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_CA_LIQUIDARECA.first .. iotbLDC_CA_LIQUIDARECA.last loop
					LockByPk
					(
						rcRecOfTab.IDLIQUIDARECA(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CA_LIQUIDARECA.first .. iotbLDC_CA_LIQUIDARECA.last
				update LDC_CA_LIQUIDARECA
				SET
					IDOPERUNITXRANGOREC = rcRecOfTab.IDOPERUNITXRANGOREC(n),
					PORCINICIAL = rcRecOfTab.PORCINICIAL(n),
					PORCFINAL = rcRecOfTab.PORCFINAL(n),
					VALORPORC = rcRecOfTab.VALORPORC(n),
					DEPARTAMENTO = rcRecOfTab.DEPARTAMENTO(n),
					LOCALIDA = rcRecOfTab.LOCALIDA(n)
				where
					IDLIQUIDARECA = rcRecOfTab.IDLIQUIDARECA(n)
;
		end if;
	END;
	PROCEDURE updIDOPERUNITXRANGOREC
	(
		inuIDLIQUIDARECA in LDC_CA_LIQUIDARECA.IDLIQUIDARECA%type,
		inuIDOPERUNITXRANGOREC$ in LDC_CA_LIQUIDARECA.IDOPERUNITXRANGOREC%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CA_LIQUIDARECA;
	BEGIN
		rcError.IDLIQUIDARECA := inuIDLIQUIDARECA;
		if inuLock=1 then
			LockByPk
			(
				inuIDLIQUIDARECA,
				rcData
			);
		end if;

		update LDC_CA_LIQUIDARECA
		set
			IDOPERUNITXRANGOREC = inuIDOPERUNITXRANGOREC$
		where
			IDLIQUIDARECA = inuIDLIQUIDARECA;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.IDOPERUNITXRANGOREC:= inuIDOPERUNITXRANGOREC$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPORCINICIAL
	(
		inuIDLIQUIDARECA in LDC_CA_LIQUIDARECA.IDLIQUIDARECA%type,
		inuPORCINICIAL$ in LDC_CA_LIQUIDARECA.PORCINICIAL%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CA_LIQUIDARECA;
	BEGIN
		rcError.IDLIQUIDARECA := inuIDLIQUIDARECA;
		if inuLock=1 then
			LockByPk
			(
				inuIDLIQUIDARECA,
				rcData
			);
		end if;

		update LDC_CA_LIQUIDARECA
		set
			PORCINICIAL = inuPORCINICIAL$
		where
			IDLIQUIDARECA = inuIDLIQUIDARECA;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PORCINICIAL:= inuPORCINICIAL$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPORCFINAL
	(
		inuIDLIQUIDARECA in LDC_CA_LIQUIDARECA.IDLIQUIDARECA%type,
		inuPORCFINAL$ in LDC_CA_LIQUIDARECA.PORCFINAL%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CA_LIQUIDARECA;
	BEGIN
		rcError.IDLIQUIDARECA := inuIDLIQUIDARECA;
		if inuLock=1 then
			LockByPk
			(
				inuIDLIQUIDARECA,
				rcData
			);
		end if;

		update LDC_CA_LIQUIDARECA
		set
			PORCFINAL = inuPORCFINAL$
		where
			IDLIQUIDARECA = inuIDLIQUIDARECA;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PORCFINAL:= inuPORCFINAL$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updVALORPORC
	(
		inuIDLIQUIDARECA in LDC_CA_LIQUIDARECA.IDLIQUIDARECA%type,
		inuVALORPORC$ in LDC_CA_LIQUIDARECA.VALORPORC%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CA_LIQUIDARECA;
	BEGIN
		rcError.IDLIQUIDARECA := inuIDLIQUIDARECA;
		if inuLock=1 then
			LockByPk
			(
				inuIDLIQUIDARECA,
				rcData
			);
		end if;

		update LDC_CA_LIQUIDARECA
		set
			VALORPORC = inuVALORPORC$
		where
			IDLIQUIDARECA = inuIDLIQUIDARECA;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.VALORPORC:= inuVALORPORC$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updDEPARTAMENTO
	(
		inuIDLIQUIDARECA in LDC_CA_LIQUIDARECA.IDLIQUIDARECA%type,
		inuDEPARTAMENTO$ in LDC_CA_LIQUIDARECA.DEPARTAMENTO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CA_LIQUIDARECA;
	BEGIN
		rcError.IDLIQUIDARECA := inuIDLIQUIDARECA;
		if inuLock=1 then
			LockByPk
			(
				inuIDLIQUIDARECA,
				rcData
			);
		end if;

		update LDC_CA_LIQUIDARECA
		set
			DEPARTAMENTO = inuDEPARTAMENTO$
		where
			IDLIQUIDARECA = inuIDLIQUIDARECA;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DEPARTAMENTO:= inuDEPARTAMENTO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updLOCALIDA
	(
		inuIDLIQUIDARECA in LDC_CA_LIQUIDARECA.IDLIQUIDARECA%type,
		inuLOCALIDA$ in LDC_CA_LIQUIDARECA.LOCALIDA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CA_LIQUIDARECA;
	BEGIN
		rcError.IDLIQUIDARECA := inuIDLIQUIDARECA;
		if inuLock=1 then
			LockByPk
			(
				inuIDLIQUIDARECA,
				rcData
			);
		end if;

		update LDC_CA_LIQUIDARECA
		set
			LOCALIDA = inuLOCALIDA$
		where
			IDLIQUIDARECA = inuIDLIQUIDARECA;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.LOCALIDA:= inuLOCALIDA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetIDLIQUIDARECA
	(
		inuIDLIQUIDARECA in LDC_CA_LIQUIDARECA.IDLIQUIDARECA%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CA_LIQUIDARECA.IDLIQUIDARECA%type
	IS
		rcError styLDC_CA_LIQUIDARECA;
	BEGIN

		rcError.IDLIQUIDARECA := inuIDLIQUIDARECA;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuIDLIQUIDARECA
			 )
		then
			 return(rcData.IDLIQUIDARECA);
		end if;
		Load
		(
		 		inuIDLIQUIDARECA
		);
		return(rcData.IDLIQUIDARECA);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetIDOPERUNITXRANGOREC
	(
		inuIDLIQUIDARECA in LDC_CA_LIQUIDARECA.IDLIQUIDARECA%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CA_LIQUIDARECA.IDOPERUNITXRANGOREC%type
	IS
		rcError styLDC_CA_LIQUIDARECA;
	BEGIN

		rcError.IDLIQUIDARECA := inuIDLIQUIDARECA;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuIDLIQUIDARECA
			 )
		then
			 return(rcData.IDOPERUNITXRANGOREC);
		end if;
		Load
		(
		 		inuIDLIQUIDARECA
		);
		return(rcData.IDOPERUNITXRANGOREC);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetPORCINICIAL
	(
		inuIDLIQUIDARECA in LDC_CA_LIQUIDARECA.IDLIQUIDARECA%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CA_LIQUIDARECA.PORCINICIAL%type
	IS
		rcError styLDC_CA_LIQUIDARECA;
	BEGIN

		rcError.IDLIQUIDARECA := inuIDLIQUIDARECA;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuIDLIQUIDARECA
			 )
		then
			 return(rcData.PORCINICIAL);
		end if;
		Load
		(
		 		inuIDLIQUIDARECA
		);
		return(rcData.PORCINICIAL);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetPORCFINAL
	(
		inuIDLIQUIDARECA in LDC_CA_LIQUIDARECA.IDLIQUIDARECA%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CA_LIQUIDARECA.PORCFINAL%type
	IS
		rcError styLDC_CA_LIQUIDARECA;
	BEGIN

		rcError.IDLIQUIDARECA := inuIDLIQUIDARECA;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuIDLIQUIDARECA
			 )
		then
			 return(rcData.PORCFINAL);
		end if;
		Load
		(
		 		inuIDLIQUIDARECA
		);
		return(rcData.PORCFINAL);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetVALORPORC
	(
		inuIDLIQUIDARECA in LDC_CA_LIQUIDARECA.IDLIQUIDARECA%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CA_LIQUIDARECA.VALORPORC%type
	IS
		rcError styLDC_CA_LIQUIDARECA;
	BEGIN

		rcError.IDLIQUIDARECA := inuIDLIQUIDARECA;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuIDLIQUIDARECA
			 )
		then
			 return(rcData.VALORPORC);
		end if;
		Load
		(
		 		inuIDLIQUIDARECA
		);
		return(rcData.VALORPORC);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetDEPARTAMENTO
	(
		inuIDLIQUIDARECA in LDC_CA_LIQUIDARECA.IDLIQUIDARECA%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CA_LIQUIDARECA.DEPARTAMENTO%type
	IS
		rcError styLDC_CA_LIQUIDARECA;
	BEGIN

		rcError.IDLIQUIDARECA := inuIDLIQUIDARECA;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuIDLIQUIDARECA
			 )
		then
			 return(rcData.DEPARTAMENTO);
		end if;
		Load
		(
		 		inuIDLIQUIDARECA
		);
		return(rcData.DEPARTAMENTO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetLOCALIDA
	(
		inuIDLIQUIDARECA in LDC_CA_LIQUIDARECA.IDLIQUIDARECA%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CA_LIQUIDARECA.LOCALIDA%type
	IS
		rcError styLDC_CA_LIQUIDARECA;
	BEGIN

		rcError.IDLIQUIDARECA := inuIDLIQUIDARECA;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuIDLIQUIDARECA
			 )
		then
			 return(rcData.LOCALIDA);
		end if;
		Load
		(
		 		inuIDLIQUIDARECA
		);
		return(rcData.LOCALIDA);
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
end DALDC_CA_LIQUIDARECA;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALDC_CA_LIQUIDARECA
BEGIN
    pkg_utilidades.prAplicarPermisos('DALDC_CA_LIQUIDARECA', 'ADM_PERSON'); 
END;
/