CREATE OR REPLACE PACKAGE adm_person.daldci_tipointerfaz
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  11/06/2024   Adrianavg   OSF-2813: Migrar del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		isbTIPOINTERFAZ in LDCI_TIPOINTERFAZ.TIPOINTERFAZ%type,
		inuCOD_COMPROBANTE in LDCI_TIPOINTERFAZ.COD_COMPROBANTE%type
	)
	IS
		SELECT LDCI_TIPOINTERFAZ.*,LDCI_TIPOINTERFAZ.rowid
		FROM LDCI_TIPOINTERFAZ
		WHERE
		    TIPOINTERFAZ = isbTIPOINTERFAZ
		    and COD_COMPROBANTE = inuCOD_COMPROBANTE;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDCI_TIPOINTERFAZ.*,LDCI_TIPOINTERFAZ.rowid
		FROM LDCI_TIPOINTERFAZ
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDCI_TIPOINTERFAZ  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDCI_TIPOINTERFAZ is table of styLDCI_TIPOINTERFAZ index by binary_integer;
	type tyrfRecords is ref cursor return styLDCI_TIPOINTERFAZ;

	/* Tipos referenciando al registro */
	type tytbCONSECUTIVO is table of LDCI_TIPOINTERFAZ.CONSECUTIVO%type index by binary_integer;
	type tytbTIPOINTERFAZ is table of LDCI_TIPOINTERFAZ.TIPOINTERFAZ%type index by binary_integer;
	type tytbCOD_COMPROBANTE is table of LDCI_TIPOINTERFAZ.COD_COMPROBANTE%type index by binary_integer;
	type tytbCOD_TIPOCOMP is table of LDCI_TIPOINTERFAZ.COD_TIPOCOMP%type index by binary_integer;
	type tytbLEDGERS is table of LDCI_TIPOINTERFAZ.LEDGERS%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDCI_TIPOINTERFAZ is record
	(
		CONSECUTIVO   tytbCONSECUTIVO,
		TIPOINTERFAZ   tytbTIPOINTERFAZ,
		COD_COMPROBANTE   tytbCOD_COMPROBANTE,
		COD_TIPOCOMP   tytbCOD_TIPOCOMP,
		LEDGERS   tytbLEDGERS,
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
		isbTIPOINTERFAZ in LDCI_TIPOINTERFAZ.TIPOINTERFAZ%type,
		inuCOD_COMPROBANTE in LDCI_TIPOINTERFAZ.COD_COMPROBANTE%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		isbTIPOINTERFAZ in LDCI_TIPOINTERFAZ.TIPOINTERFAZ%type,
		inuCOD_COMPROBANTE in LDCI_TIPOINTERFAZ.COD_COMPROBANTE%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		isbTIPOINTERFAZ in LDCI_TIPOINTERFAZ.TIPOINTERFAZ%type,
		inuCOD_COMPROBANTE in LDCI_TIPOINTERFAZ.COD_COMPROBANTE%type
	);

	PROCEDURE getRecord
	(
		isbTIPOINTERFAZ in LDCI_TIPOINTERFAZ.TIPOINTERFAZ%type,
		inuCOD_COMPROBANTE in LDCI_TIPOINTERFAZ.COD_COMPROBANTE%type,
		orcRecord out nocopy styLDCI_TIPOINTERFAZ
	);

	FUNCTION frcGetRcData
	(
		isbTIPOINTERFAZ in LDCI_TIPOINTERFAZ.TIPOINTERFAZ%type,
		inuCOD_COMPROBANTE in LDCI_TIPOINTERFAZ.COD_COMPROBANTE%type
	)
	RETURN styLDCI_TIPOINTERFAZ;

	FUNCTION frcGetRcData
	RETURN styLDCI_TIPOINTERFAZ;

	FUNCTION frcGetRecord
	(
		isbTIPOINTERFAZ in LDCI_TIPOINTERFAZ.TIPOINTERFAZ%type,
		inuCOD_COMPROBANTE in LDCI_TIPOINTERFAZ.COD_COMPROBANTE%type
	)
	RETURN styLDCI_TIPOINTERFAZ;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDCI_TIPOINTERFAZ
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDCI_TIPOINTERFAZ in styLDCI_TIPOINTERFAZ
	);

	PROCEDURE insRecord
	(
		ircLDCI_TIPOINTERFAZ in styLDCI_TIPOINTERFAZ,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDCI_TIPOINTERFAZ in out nocopy tytbLDCI_TIPOINTERFAZ
	);

	PROCEDURE delRecord
	(
		isbTIPOINTERFAZ in LDCI_TIPOINTERFAZ.TIPOINTERFAZ%type,
		inuCOD_COMPROBANTE in LDCI_TIPOINTERFAZ.COD_COMPROBANTE%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDCI_TIPOINTERFAZ in out nocopy tytbLDCI_TIPOINTERFAZ,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDCI_TIPOINTERFAZ in styLDCI_TIPOINTERFAZ,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDCI_TIPOINTERFAZ in out nocopy tytbLDCI_TIPOINTERFAZ,
		inuLock in number default 1
	);

	PROCEDURE updCONSECUTIVO
	(
		isbTIPOINTERFAZ in LDCI_TIPOINTERFAZ.TIPOINTERFAZ%type,
		inuCOD_COMPROBANTE in LDCI_TIPOINTERFAZ.COD_COMPROBANTE%type,
		inuCONSECUTIVO$ in LDCI_TIPOINTERFAZ.CONSECUTIVO%type,
		inuLock in number default 0
	);

	PROCEDURE updCOD_TIPOCOMP
	(
		isbTIPOINTERFAZ in LDCI_TIPOINTERFAZ.TIPOINTERFAZ%type,
		inuCOD_COMPROBANTE in LDCI_TIPOINTERFAZ.COD_COMPROBANTE%type,
		inuCOD_TIPOCOMP$ in LDCI_TIPOINTERFAZ.COD_TIPOCOMP%type,
		inuLock in number default 0
	);

	PROCEDURE updLEDGERS
	(
		isbTIPOINTERFAZ in LDCI_TIPOINTERFAZ.TIPOINTERFAZ%type,
		inuCOD_COMPROBANTE in LDCI_TIPOINTERFAZ.COD_COMPROBANTE%type,
		isbLEDGERS$ in LDCI_TIPOINTERFAZ.LEDGERS%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetCONSECUTIVO
	(
		isbTIPOINTERFAZ in LDCI_TIPOINTERFAZ.TIPOINTERFAZ%type,
		inuCOD_COMPROBANTE in LDCI_TIPOINTERFAZ.COD_COMPROBANTE%type,
		inuRaiseError in number default 1
	)
	RETURN LDCI_TIPOINTERFAZ.CONSECUTIVO%type;

	FUNCTION fsbGetTIPOINTERFAZ
	(
		isbTIPOINTERFAZ in LDCI_TIPOINTERFAZ.TIPOINTERFAZ%type,
		inuCOD_COMPROBANTE in LDCI_TIPOINTERFAZ.COD_COMPROBANTE%type,
		inuRaiseError in number default 1
	)
	RETURN LDCI_TIPOINTERFAZ.TIPOINTERFAZ%type;

	FUNCTION fnuGetCOD_COMPROBANTE
	(
		isbTIPOINTERFAZ in LDCI_TIPOINTERFAZ.TIPOINTERFAZ%type,
		inuCOD_COMPROBANTE in LDCI_TIPOINTERFAZ.COD_COMPROBANTE%type,
		inuRaiseError in number default 1
	)
	RETURN LDCI_TIPOINTERFAZ.COD_COMPROBANTE%type;

	FUNCTION fnuGetCOD_TIPOCOMP
	(
		isbTIPOINTERFAZ in LDCI_TIPOINTERFAZ.TIPOINTERFAZ%type,
		inuCOD_COMPROBANTE in LDCI_TIPOINTERFAZ.COD_COMPROBANTE%type,
		inuRaiseError in number default 1
	)
	RETURN LDCI_TIPOINTERFAZ.COD_TIPOCOMP%type;

	FUNCTION fsbGetLEDGERS
	(
		isbTIPOINTERFAZ in LDCI_TIPOINTERFAZ.TIPOINTERFAZ%type,
		inuCOD_COMPROBANTE in LDCI_TIPOINTERFAZ.COD_COMPROBANTE%type,
		inuRaiseError in number default 1
	)
	RETURN LDCI_TIPOINTERFAZ.LEDGERS%type;


	PROCEDURE LockByPk
	(
		isbTIPOINTERFAZ in LDCI_TIPOINTERFAZ.TIPOINTERFAZ%type,
		inuCOD_COMPROBANTE in LDCI_TIPOINTERFAZ.COD_COMPROBANTE%type,
		orcLDCI_TIPOINTERFAZ  out styLDCI_TIPOINTERFAZ
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDCI_TIPOINTERFAZ  out styLDCI_TIPOINTERFAZ
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDCI_TIPOINTERFAZ;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALDCI_TIPOINTERFAZ
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDCI_TIPOINTERFAZ';
	 cnuGeEntityId constant varchar2(30) := 8909; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		isbTIPOINTERFAZ in LDCI_TIPOINTERFAZ.TIPOINTERFAZ%type,
		inuCOD_COMPROBANTE in LDCI_TIPOINTERFAZ.COD_COMPROBANTE%type
	)
	IS
		SELECT LDCI_TIPOINTERFAZ.*,LDCI_TIPOINTERFAZ.rowid
		FROM LDCI_TIPOINTERFAZ
		WHERE  TIPOINTERFAZ = isbTIPOINTERFAZ
			and COD_COMPROBANTE = inuCOD_COMPROBANTE
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDCI_TIPOINTERFAZ.*,LDCI_TIPOINTERFAZ.rowid
		FROM LDCI_TIPOINTERFAZ
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDCI_TIPOINTERFAZ is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDCI_TIPOINTERFAZ;

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
	FUNCTION fsbPrimaryKey( rcI in styLDCI_TIPOINTERFAZ default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.TIPOINTERFAZ);
		sbPk:=sbPk||','||ut_convert.fsbToChar(rcI.COD_COMPROBANTE);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		isbTIPOINTERFAZ in LDCI_TIPOINTERFAZ.TIPOINTERFAZ%type,
		inuCOD_COMPROBANTE in LDCI_TIPOINTERFAZ.COD_COMPROBANTE%type,
		orcLDCI_TIPOINTERFAZ  out styLDCI_TIPOINTERFAZ
	)
	IS
		rcError styLDCI_TIPOINTERFAZ;
	BEGIN
		rcError.TIPOINTERFAZ := isbTIPOINTERFAZ;
		rcError.COD_COMPROBANTE := inuCOD_COMPROBANTE;

		Open cuLockRcByPk
		(
			isbTIPOINTERFAZ,
			inuCOD_COMPROBANTE
		);

		fetch cuLockRcByPk into orcLDCI_TIPOINTERFAZ;
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
		orcLDCI_TIPOINTERFAZ  out styLDCI_TIPOINTERFAZ
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDCI_TIPOINTERFAZ;
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
		itbLDCI_TIPOINTERFAZ  in out nocopy tytbLDCI_TIPOINTERFAZ
	)
	IS
	BEGIN
			rcRecOfTab.CONSECUTIVO.delete;
			rcRecOfTab.TIPOINTERFAZ.delete;
			rcRecOfTab.COD_COMPROBANTE.delete;
			rcRecOfTab.COD_TIPOCOMP.delete;
			rcRecOfTab.LEDGERS.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDCI_TIPOINTERFAZ  in out nocopy tytbLDCI_TIPOINTERFAZ,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDCI_TIPOINTERFAZ);

		for n in itbLDCI_TIPOINTERFAZ.first .. itbLDCI_TIPOINTERFAZ.last loop
			rcRecOfTab.CONSECUTIVO(n) := itbLDCI_TIPOINTERFAZ(n).CONSECUTIVO;
			rcRecOfTab.TIPOINTERFAZ(n) := itbLDCI_TIPOINTERFAZ(n).TIPOINTERFAZ;
			rcRecOfTab.COD_COMPROBANTE(n) := itbLDCI_TIPOINTERFAZ(n).COD_COMPROBANTE;
			rcRecOfTab.COD_TIPOCOMP(n) := itbLDCI_TIPOINTERFAZ(n).COD_TIPOCOMP;
			rcRecOfTab.LEDGERS(n) := itbLDCI_TIPOINTERFAZ(n).LEDGERS;
			rcRecOfTab.row_id(n) := itbLDCI_TIPOINTERFAZ(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		isbTIPOINTERFAZ in LDCI_TIPOINTERFAZ.TIPOINTERFAZ%type,
		inuCOD_COMPROBANTE in LDCI_TIPOINTERFAZ.COD_COMPROBANTE%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			isbTIPOINTERFAZ,
			inuCOD_COMPROBANTE
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
		isbTIPOINTERFAZ in LDCI_TIPOINTERFAZ.TIPOINTERFAZ%type,
		inuCOD_COMPROBANTE in LDCI_TIPOINTERFAZ.COD_COMPROBANTE%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			isbTIPOINTERFAZ = rcData.TIPOINTERFAZ AND
			inuCOD_COMPROBANTE = rcData.COD_COMPROBANTE
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
		isbTIPOINTERFAZ in LDCI_TIPOINTERFAZ.TIPOINTERFAZ%type,
		inuCOD_COMPROBANTE in LDCI_TIPOINTERFAZ.COD_COMPROBANTE%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			isbTIPOINTERFAZ,
			inuCOD_COMPROBANTE
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		isbTIPOINTERFAZ in LDCI_TIPOINTERFAZ.TIPOINTERFAZ%type,
		inuCOD_COMPROBANTE in LDCI_TIPOINTERFAZ.COD_COMPROBANTE%type
	)
	IS
		rcError styLDCI_TIPOINTERFAZ;
	BEGIN		rcError.TIPOINTERFAZ:=isbTIPOINTERFAZ;		rcError.COD_COMPROBANTE:=inuCOD_COMPROBANTE;

		Load
		(
			isbTIPOINTERFAZ,
			inuCOD_COMPROBANTE
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
		isbTIPOINTERFAZ in LDCI_TIPOINTERFAZ.TIPOINTERFAZ%type,
		inuCOD_COMPROBANTE in LDCI_TIPOINTERFAZ.COD_COMPROBANTE%type
	)
	IS
	BEGIN
		Load
		(
			isbTIPOINTERFAZ,
			inuCOD_COMPROBANTE
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		isbTIPOINTERFAZ in LDCI_TIPOINTERFAZ.TIPOINTERFAZ%type,
		inuCOD_COMPROBANTE in LDCI_TIPOINTERFAZ.COD_COMPROBANTE%type,
		orcRecord out nocopy styLDCI_TIPOINTERFAZ
	)
	IS
		rcError styLDCI_TIPOINTERFAZ;
	BEGIN		rcError.TIPOINTERFAZ:=isbTIPOINTERFAZ;		rcError.COD_COMPROBANTE:=inuCOD_COMPROBANTE;

		Load
		(
			isbTIPOINTERFAZ,
			inuCOD_COMPROBANTE
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		isbTIPOINTERFAZ in LDCI_TIPOINTERFAZ.TIPOINTERFAZ%type,
		inuCOD_COMPROBANTE in LDCI_TIPOINTERFAZ.COD_COMPROBANTE%type
	)
	RETURN styLDCI_TIPOINTERFAZ
	IS
		rcError styLDCI_TIPOINTERFAZ;
	BEGIN
		rcError.TIPOINTERFAZ:=isbTIPOINTERFAZ;
		rcError.COD_COMPROBANTE:=inuCOD_COMPROBANTE;

		Load
		(
			isbTIPOINTERFAZ,
			inuCOD_COMPROBANTE
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		isbTIPOINTERFAZ in LDCI_TIPOINTERFAZ.TIPOINTERFAZ%type,
		inuCOD_COMPROBANTE in LDCI_TIPOINTERFAZ.COD_COMPROBANTE%type
	)
	RETURN styLDCI_TIPOINTERFAZ
	IS
		rcError styLDCI_TIPOINTERFAZ;
	BEGIN
		rcError.TIPOINTERFAZ:=isbTIPOINTERFAZ;
		rcError.COD_COMPROBANTE:=inuCOD_COMPROBANTE;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			isbTIPOINTERFAZ,
			inuCOD_COMPROBANTE
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			isbTIPOINTERFAZ,
			inuCOD_COMPROBANTE
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDCI_TIPOINTERFAZ
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDCI_TIPOINTERFAZ
	)
	IS
		rfLDCI_TIPOINTERFAZ tyrfLDCI_TIPOINTERFAZ;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDCI_TIPOINTERFAZ.*, LDCI_TIPOINTERFAZ.rowid FROM LDCI_TIPOINTERFAZ';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDCI_TIPOINTERFAZ for sbFullQuery;

		fetch rfLDCI_TIPOINTERFAZ bulk collect INTO otbResult;

		close rfLDCI_TIPOINTERFAZ;
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
		sbSQL VARCHAR2 (32000) := 'select LDCI_TIPOINTERFAZ.*, LDCI_TIPOINTERFAZ.rowid FROM LDCI_TIPOINTERFAZ';
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
		ircLDCI_TIPOINTERFAZ in styLDCI_TIPOINTERFAZ
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDCI_TIPOINTERFAZ,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDCI_TIPOINTERFAZ in styLDCI_TIPOINTERFAZ,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDCI_TIPOINTERFAZ.TIPOINTERFAZ is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|TIPOINTERFAZ');
			raise ex.controlled_error;
		end if;
		if ircLDCI_TIPOINTERFAZ.COD_COMPROBANTE is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|COD_COMPROBANTE');
			raise ex.controlled_error;
		end if;

		insert into LDCI_TIPOINTERFAZ
		(
			CONSECUTIVO,
			TIPOINTERFAZ,
			COD_COMPROBANTE,
			COD_TIPOCOMP,
			LEDGERS
		)
		values
		(
			ircLDCI_TIPOINTERFAZ.CONSECUTIVO,
			ircLDCI_TIPOINTERFAZ.TIPOINTERFAZ,
			ircLDCI_TIPOINTERFAZ.COD_COMPROBANTE,
			ircLDCI_TIPOINTERFAZ.COD_TIPOCOMP,
			ircLDCI_TIPOINTERFAZ.LEDGERS
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDCI_TIPOINTERFAZ));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDCI_TIPOINTERFAZ in out nocopy tytbLDCI_TIPOINTERFAZ
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDCI_TIPOINTERFAZ,blUseRowID);
		forall n in iotbLDCI_TIPOINTERFAZ.first..iotbLDCI_TIPOINTERFAZ.last
			insert into LDCI_TIPOINTERFAZ
			(
				CONSECUTIVO,
				TIPOINTERFAZ,
				COD_COMPROBANTE,
				COD_TIPOCOMP,
				LEDGERS
			)
			values
			(
				rcRecOfTab.CONSECUTIVO(n),
				rcRecOfTab.TIPOINTERFAZ(n),
				rcRecOfTab.COD_COMPROBANTE(n),
				rcRecOfTab.COD_TIPOCOMP(n),
				rcRecOfTab.LEDGERS(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		isbTIPOINTERFAZ in LDCI_TIPOINTERFAZ.TIPOINTERFAZ%type,
		inuCOD_COMPROBANTE in LDCI_TIPOINTERFAZ.COD_COMPROBANTE%type,
		inuLock in number default 1
	)
	IS
		rcError styLDCI_TIPOINTERFAZ;
	BEGIN
		rcError.TIPOINTERFAZ := isbTIPOINTERFAZ;
		rcError.COD_COMPROBANTE := inuCOD_COMPROBANTE;

		if inuLock=1 then
			LockByPk
			(
				isbTIPOINTERFAZ,
				inuCOD_COMPROBANTE,
				rcData
			);
		end if;


		delete
		from LDCI_TIPOINTERFAZ
		where
       		TIPOINTERFAZ=isbTIPOINTERFAZ and
       		COD_COMPROBANTE=inuCOD_COMPROBANTE;
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
		rcError  styLDCI_TIPOINTERFAZ;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDCI_TIPOINTERFAZ
		where
			rowid = iriRowID
		returning
			CONSECUTIVO,
			TIPOINTERFAZ
		into
			rcError.CONSECUTIVO,
			rcError.TIPOINTERFAZ;
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
		iotbLDCI_TIPOINTERFAZ in out nocopy tytbLDCI_TIPOINTERFAZ,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDCI_TIPOINTERFAZ;
	BEGIN
		FillRecordOfTables(iotbLDCI_TIPOINTERFAZ, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDCI_TIPOINTERFAZ.first .. iotbLDCI_TIPOINTERFAZ.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDCI_TIPOINTERFAZ.first .. iotbLDCI_TIPOINTERFAZ.last
				delete
				from LDCI_TIPOINTERFAZ
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDCI_TIPOINTERFAZ.first .. iotbLDCI_TIPOINTERFAZ.last loop
					LockByPk
					(
						rcRecOfTab.TIPOINTERFAZ(n),
						rcRecOfTab.COD_COMPROBANTE(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDCI_TIPOINTERFAZ.first .. iotbLDCI_TIPOINTERFAZ.last
				delete
				from LDCI_TIPOINTERFAZ
				where
		         	TIPOINTERFAZ = rcRecOfTab.TIPOINTERFAZ(n) and
		         	COD_COMPROBANTE = rcRecOfTab.COD_COMPROBANTE(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDCI_TIPOINTERFAZ in styLDCI_TIPOINTERFAZ,
		inuLock in number default 0
	)
	IS
		sbTIPOINTERFAZ	LDCI_TIPOINTERFAZ.TIPOINTERFAZ%type;
		nuCOD_COMPROBANTE	LDCI_TIPOINTERFAZ.COD_COMPROBANTE%type;
	BEGIN
		if ircLDCI_TIPOINTERFAZ.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDCI_TIPOINTERFAZ.rowid,rcData);
			end if;
			update LDCI_TIPOINTERFAZ
			set
				CONSECUTIVO = ircLDCI_TIPOINTERFAZ.CONSECUTIVO,
				COD_TIPOCOMP = ircLDCI_TIPOINTERFAZ.COD_TIPOCOMP,
				LEDGERS = ircLDCI_TIPOINTERFAZ.LEDGERS
			where
				rowid = ircLDCI_TIPOINTERFAZ.rowid
			returning
				TIPOINTERFAZ,
				COD_COMPROBANTE
			into
				sbTIPOINTERFAZ,
				nuCOD_COMPROBANTE;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDCI_TIPOINTERFAZ.TIPOINTERFAZ,
					ircLDCI_TIPOINTERFAZ.COD_COMPROBANTE,
					rcData
				);
			end if;

			update LDCI_TIPOINTERFAZ
			set
				CONSECUTIVO = ircLDCI_TIPOINTERFAZ.CONSECUTIVO,
				COD_TIPOCOMP = ircLDCI_TIPOINTERFAZ.COD_TIPOCOMP,
				LEDGERS = ircLDCI_TIPOINTERFAZ.LEDGERS
			where
				TIPOINTERFAZ = ircLDCI_TIPOINTERFAZ.TIPOINTERFAZ and
				COD_COMPROBANTE = ircLDCI_TIPOINTERFAZ.COD_COMPROBANTE
			returning
				TIPOINTERFAZ,
				COD_COMPROBANTE
			into
				sbTIPOINTERFAZ,
				nuCOD_COMPROBANTE;
		end if;
		if
			sbTIPOINTERFAZ is NULL OR
			nuCOD_COMPROBANTE is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDCI_TIPOINTERFAZ));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDCI_TIPOINTERFAZ in out nocopy tytbLDCI_TIPOINTERFAZ,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDCI_TIPOINTERFAZ;
	BEGIN
		FillRecordOfTables(iotbLDCI_TIPOINTERFAZ,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDCI_TIPOINTERFAZ.first .. iotbLDCI_TIPOINTERFAZ.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDCI_TIPOINTERFAZ.first .. iotbLDCI_TIPOINTERFAZ.last
				update LDCI_TIPOINTERFAZ
				set
					CONSECUTIVO = rcRecOfTab.CONSECUTIVO(n),
					COD_TIPOCOMP = rcRecOfTab.COD_TIPOCOMP(n),
					LEDGERS = rcRecOfTab.LEDGERS(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDCI_TIPOINTERFAZ.first .. iotbLDCI_TIPOINTERFAZ.last loop
					LockByPk
					(
						rcRecOfTab.TIPOINTERFAZ(n),
						rcRecOfTab.COD_COMPROBANTE(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDCI_TIPOINTERFAZ.first .. iotbLDCI_TIPOINTERFAZ.last
				update LDCI_TIPOINTERFAZ
				SET
					CONSECUTIVO = rcRecOfTab.CONSECUTIVO(n),
					COD_TIPOCOMP = rcRecOfTab.COD_TIPOCOMP(n),
					LEDGERS = rcRecOfTab.LEDGERS(n)
				where
					TIPOINTERFAZ = rcRecOfTab.TIPOINTERFAZ(n) and
					COD_COMPROBANTE = rcRecOfTab.COD_COMPROBANTE(n)
;
		end if;
	END;
	PROCEDURE updCONSECUTIVO
	(
		isbTIPOINTERFAZ in LDCI_TIPOINTERFAZ.TIPOINTERFAZ%type,
		inuCOD_COMPROBANTE in LDCI_TIPOINTERFAZ.COD_COMPROBANTE%type,
		inuCONSECUTIVO$ in LDCI_TIPOINTERFAZ.CONSECUTIVO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDCI_TIPOINTERFAZ;
	BEGIN
		rcError.TIPOINTERFAZ := isbTIPOINTERFAZ;
		rcError.COD_COMPROBANTE := inuCOD_COMPROBANTE;
		if inuLock=1 then
			LockByPk
			(
				isbTIPOINTERFAZ,
				inuCOD_COMPROBANTE,
				rcData
			);
		end if;

		update LDCI_TIPOINTERFAZ
		set
			CONSECUTIVO = inuCONSECUTIVO$
		where
			TIPOINTERFAZ = isbTIPOINTERFAZ and
			COD_COMPROBANTE = inuCOD_COMPROBANTE;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CONSECUTIVO:= inuCONSECUTIVO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCOD_TIPOCOMP
	(
		isbTIPOINTERFAZ in LDCI_TIPOINTERFAZ.TIPOINTERFAZ%type,
		inuCOD_COMPROBANTE in LDCI_TIPOINTERFAZ.COD_COMPROBANTE%type,
		inuCOD_TIPOCOMP$ in LDCI_TIPOINTERFAZ.COD_TIPOCOMP%type,
		inuLock in number default 0
	)
	IS
		rcError styLDCI_TIPOINTERFAZ;
	BEGIN
		rcError.TIPOINTERFAZ := isbTIPOINTERFAZ;
		rcError.COD_COMPROBANTE := inuCOD_COMPROBANTE;
		if inuLock=1 then
			LockByPk
			(
				isbTIPOINTERFAZ,
				inuCOD_COMPROBANTE,
				rcData
			);
		end if;

		update LDCI_TIPOINTERFAZ
		set
			COD_TIPOCOMP = inuCOD_TIPOCOMP$
		where
			TIPOINTERFAZ = isbTIPOINTERFAZ and
			COD_COMPROBANTE = inuCOD_COMPROBANTE;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.COD_TIPOCOMP:= inuCOD_TIPOCOMP$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updLEDGERS
	(
		isbTIPOINTERFAZ in LDCI_TIPOINTERFAZ.TIPOINTERFAZ%type,
		inuCOD_COMPROBANTE in LDCI_TIPOINTERFAZ.COD_COMPROBANTE%type,
		isbLEDGERS$ in LDCI_TIPOINTERFAZ.LEDGERS%type,
		inuLock in number default 0
	)
	IS
		rcError styLDCI_TIPOINTERFAZ;
	BEGIN
		rcError.TIPOINTERFAZ := isbTIPOINTERFAZ;
		rcError.COD_COMPROBANTE := inuCOD_COMPROBANTE;
		if inuLock=1 then
			LockByPk
			(
				isbTIPOINTERFAZ,
				inuCOD_COMPROBANTE,
				rcData
			);
		end if;

		update LDCI_TIPOINTERFAZ
		set
			LEDGERS = isbLEDGERS$
		where
			TIPOINTERFAZ = isbTIPOINTERFAZ and
			COD_COMPROBANTE = inuCOD_COMPROBANTE;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.LEDGERS:= isbLEDGERS$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetCONSECUTIVO
	(
		isbTIPOINTERFAZ in LDCI_TIPOINTERFAZ.TIPOINTERFAZ%type,
		inuCOD_COMPROBANTE in LDCI_TIPOINTERFAZ.COD_COMPROBANTE%type,
		inuRaiseError in number default 1
	)
	RETURN LDCI_TIPOINTERFAZ.CONSECUTIVO%type
	IS
		rcError styLDCI_TIPOINTERFAZ;
	BEGIN

		rcError.TIPOINTERFAZ := isbTIPOINTERFAZ;
		rcError.COD_COMPROBANTE := inuCOD_COMPROBANTE;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		isbTIPOINTERFAZ,
		 		inuCOD_COMPROBANTE
			 )
		then
			 return(rcData.CONSECUTIVO);
		end if;
		Load
		(
		 		isbTIPOINTERFAZ,
		 		inuCOD_COMPROBANTE
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
	FUNCTION fsbGetTIPOINTERFAZ
	(
		isbTIPOINTERFAZ in LDCI_TIPOINTERFAZ.TIPOINTERFAZ%type,
		inuCOD_COMPROBANTE in LDCI_TIPOINTERFAZ.COD_COMPROBANTE%type,
		inuRaiseError in number default 1
	)
	RETURN LDCI_TIPOINTERFAZ.TIPOINTERFAZ%type
	IS
		rcError styLDCI_TIPOINTERFAZ;
	BEGIN

		rcError.TIPOINTERFAZ := isbTIPOINTERFAZ;
		rcError.COD_COMPROBANTE := inuCOD_COMPROBANTE;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		isbTIPOINTERFAZ,
		 		inuCOD_COMPROBANTE
			 )
		then
			 return(rcData.TIPOINTERFAZ);
		end if;
		Load
		(
		 		isbTIPOINTERFAZ,
		 		inuCOD_COMPROBANTE
		);
		return(rcData.TIPOINTERFAZ);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCOD_COMPROBANTE
	(
		isbTIPOINTERFAZ in LDCI_TIPOINTERFAZ.TIPOINTERFAZ%type,
		inuCOD_COMPROBANTE in LDCI_TIPOINTERFAZ.COD_COMPROBANTE%type,
		inuRaiseError in number default 1
	)
	RETURN LDCI_TIPOINTERFAZ.COD_COMPROBANTE%type
	IS
		rcError styLDCI_TIPOINTERFAZ;
	BEGIN

		rcError.TIPOINTERFAZ := isbTIPOINTERFAZ;
		rcError.COD_COMPROBANTE := inuCOD_COMPROBANTE;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		isbTIPOINTERFAZ,
		 		inuCOD_COMPROBANTE
			 )
		then
			 return(rcData.COD_COMPROBANTE);
		end if;
		Load
		(
		 		isbTIPOINTERFAZ,
		 		inuCOD_COMPROBANTE
		);
		return(rcData.COD_COMPROBANTE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCOD_TIPOCOMP
	(
		isbTIPOINTERFAZ in LDCI_TIPOINTERFAZ.TIPOINTERFAZ%type,
		inuCOD_COMPROBANTE in LDCI_TIPOINTERFAZ.COD_COMPROBANTE%type,
		inuRaiseError in number default 1
	)
	RETURN LDCI_TIPOINTERFAZ.COD_TIPOCOMP%type
	IS
		rcError styLDCI_TIPOINTERFAZ;
	BEGIN

		rcError.TIPOINTERFAZ := isbTIPOINTERFAZ;
		rcError.COD_COMPROBANTE := inuCOD_COMPROBANTE;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		isbTIPOINTERFAZ,
		 		inuCOD_COMPROBANTE
			 )
		then
			 return(rcData.COD_TIPOCOMP);
		end if;
		Load
		(
		 		isbTIPOINTERFAZ,
		 		inuCOD_COMPROBANTE
		);
		return(rcData.COD_TIPOCOMP);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetLEDGERS
	(
		isbTIPOINTERFAZ in LDCI_TIPOINTERFAZ.TIPOINTERFAZ%type,
		inuCOD_COMPROBANTE in LDCI_TIPOINTERFAZ.COD_COMPROBANTE%type,
		inuRaiseError in number default 1
	)
	RETURN LDCI_TIPOINTERFAZ.LEDGERS%type
	IS
		rcError styLDCI_TIPOINTERFAZ;
	BEGIN

		rcError.TIPOINTERFAZ := isbTIPOINTERFAZ;
		rcError.COD_COMPROBANTE := inuCOD_COMPROBANTE;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		isbTIPOINTERFAZ,
		 		inuCOD_COMPROBANTE
			 )
		then
			 return(rcData.LEDGERS);
		end if;
		Load
		(
		 		isbTIPOINTERFAZ,
		 		inuCOD_COMPROBANTE
		);
		return(rcData.LEDGERS);
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
end DALDCI_TIPOINTERFAZ;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALDCI_TIPOINTERFAZ
BEGIN
    pkg_utilidades.prAplicarPermisos('DALDCI_TIPOINTERFAZ', 'ADM_PERSON'); 
END;
/  