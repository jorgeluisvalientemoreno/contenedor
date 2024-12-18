CREATE OR REPLACE PACKAGE ADM_PERSON.DALDC_IMPRDOCU
is
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     : 
    Descripcion	 : 
    
    Parametro	    Descripcion
    ============	==============================
    
    Historia de Modificaciones
    Fecha   	           Autor            Modificacion
    ====================   =========        ====================
    04/05/2024              PAcosta         OSF-2776: Cambio de esquema ADM_PERSON                              
    ****************************************************************/
    
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuIMDOPART in LDC_IMPRDOCU.IMDOPART%type,
		inuIMDOFILA in LDC_IMPRDOCU.IMDOFILA%type,
		isbIMDOPROG in LDC_IMPRDOCU.IMDOPROG%type
	)
	IS
		SELECT LDC_IMPRDOCU.*,LDC_IMPRDOCU.rowid
		FROM LDC_IMPRDOCU
		WHERE
		    IMDOPART = inuIMDOPART
		    and IMDOFILA = inuIMDOFILA
		    and IMDOPROG = isbIMDOPROG;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_IMPRDOCU.*,LDC_IMPRDOCU.rowid
		FROM LDC_IMPRDOCU
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_IMPRDOCU  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_IMPRDOCU is table of styLDC_IMPRDOCU index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_IMPRDOCU;

	/* Tipos referenciando al registro */
	type tytbIMDOPART is table of LDC_IMPRDOCU.IMDOPART%type index by binary_integer;
	type tytbIMDOFILA is table of LDC_IMPRDOCU.IMDOFILA%type index by binary_integer;
	type tytbIMDOPROG is table of LDC_IMPRDOCU.IMDOPROG%type index by binary_integer;
	type tytbIMDOSUSC is table of LDC_IMPRDOCU.IMDOSUSC%type index by binary_integer;
	type tytbIMDOPROD is table of LDC_IMPRDOCU.IMDOPROD%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_IMPRDOCU is record
	(
		IMDOPART   tytbIMDOPART,
		IMDOFILA   tytbIMDOFILA,
		IMDOPROG   tytbIMDOPROG,
		IMDOSUSC   tytbIMDOSUSC,
		IMDOPROD   tytbIMDOPROD,
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
		inuIMDOPART in LDC_IMPRDOCU.IMDOPART%type,
		inuIMDOFILA in LDC_IMPRDOCU.IMDOFILA%type,
		isbIMDOPROG in LDC_IMPRDOCU.IMDOPROG%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuIMDOPART in LDC_IMPRDOCU.IMDOPART%type,
		inuIMDOFILA in LDC_IMPRDOCU.IMDOFILA%type,
		isbIMDOPROG in LDC_IMPRDOCU.IMDOPROG%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuIMDOPART in LDC_IMPRDOCU.IMDOPART%type,
		inuIMDOFILA in LDC_IMPRDOCU.IMDOFILA%type,
		isbIMDOPROG in LDC_IMPRDOCU.IMDOPROG%type
	);

	PROCEDURE getRecord
	(
		inuIMDOPART in LDC_IMPRDOCU.IMDOPART%type,
		inuIMDOFILA in LDC_IMPRDOCU.IMDOFILA%type,
		isbIMDOPROG in LDC_IMPRDOCU.IMDOPROG%type,
		orcRecord out nocopy styLDC_IMPRDOCU
	);

	FUNCTION frcGetRcData
	(
		inuIMDOPART in LDC_IMPRDOCU.IMDOPART%type,
		inuIMDOFILA in LDC_IMPRDOCU.IMDOFILA%type,
		isbIMDOPROG in LDC_IMPRDOCU.IMDOPROG%type
	)
	RETURN styLDC_IMPRDOCU;

	FUNCTION frcGetRcData
	RETURN styLDC_IMPRDOCU;

	FUNCTION frcGetRecord
	(
		inuIMDOPART in LDC_IMPRDOCU.IMDOPART%type,
		inuIMDOFILA in LDC_IMPRDOCU.IMDOFILA%type,
		isbIMDOPROG in LDC_IMPRDOCU.IMDOPROG%type
	)
	RETURN styLDC_IMPRDOCU;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_IMPRDOCU
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_IMPRDOCU in styLDC_IMPRDOCU
	);

	PROCEDURE insRecord
	(
		ircLDC_IMPRDOCU in styLDC_IMPRDOCU,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_IMPRDOCU in out nocopy tytbLDC_IMPRDOCU
	);

	PROCEDURE delRecord
	(
		inuIMDOPART in LDC_IMPRDOCU.IMDOPART%type,
		inuIMDOFILA in LDC_IMPRDOCU.IMDOFILA%type,
		isbIMDOPROG in LDC_IMPRDOCU.IMDOPROG%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_IMPRDOCU in out nocopy tytbLDC_IMPRDOCU,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_IMPRDOCU in styLDC_IMPRDOCU,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_IMPRDOCU in out nocopy tytbLDC_IMPRDOCU,
		inuLock in number default 1
	);

	PROCEDURE updIMDOSUSC
	(
		inuIMDOPART in LDC_IMPRDOCU.IMDOPART%type,
		inuIMDOFILA in LDC_IMPRDOCU.IMDOFILA%type,
		isbIMDOPROG in LDC_IMPRDOCU.IMDOPROG%type,
		inuIMDOSUSC$ in LDC_IMPRDOCU.IMDOSUSC%type,
		inuLock in number default 0
	);

	PROCEDURE updIMDOPROD
	(
		inuIMDOPART in LDC_IMPRDOCU.IMDOPART%type,
		inuIMDOFILA in LDC_IMPRDOCU.IMDOFILA%type,
		isbIMDOPROG in LDC_IMPRDOCU.IMDOPROG%type,
		inuIMDOPROD$ in LDC_IMPRDOCU.IMDOPROD%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetIMDOPART
	(
		inuIMDOPART in LDC_IMPRDOCU.IMDOPART%type,
		inuIMDOFILA in LDC_IMPRDOCU.IMDOFILA%type,
		isbIMDOPROG in LDC_IMPRDOCU.IMDOPROG%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_IMPRDOCU.IMDOPART%type;

	FUNCTION fnuGetIMDOFILA
	(
		inuIMDOPART in LDC_IMPRDOCU.IMDOPART%type,
		inuIMDOFILA in LDC_IMPRDOCU.IMDOFILA%type,
		isbIMDOPROG in LDC_IMPRDOCU.IMDOPROG%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_IMPRDOCU.IMDOFILA%type;

	FUNCTION fsbGetIMDOPROG
	(
		inuIMDOPART in LDC_IMPRDOCU.IMDOPART%type,
		inuIMDOFILA in LDC_IMPRDOCU.IMDOFILA%type,
		isbIMDOPROG in LDC_IMPRDOCU.IMDOPROG%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_IMPRDOCU.IMDOPROG%type;

	FUNCTION fnuGetIMDOSUSC
	(
		inuIMDOPART in LDC_IMPRDOCU.IMDOPART%type,
		inuIMDOFILA in LDC_IMPRDOCU.IMDOFILA%type,
		isbIMDOPROG in LDC_IMPRDOCU.IMDOPROG%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_IMPRDOCU.IMDOSUSC%type;

	FUNCTION fnuGetIMDOPROD
	(
		inuIMDOPART in LDC_IMPRDOCU.IMDOPART%type,
		inuIMDOFILA in LDC_IMPRDOCU.IMDOFILA%type,
		isbIMDOPROG in LDC_IMPRDOCU.IMDOPROG%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_IMPRDOCU.IMDOPROD%type;


	PROCEDURE LockByPk
	(
		inuIMDOPART in LDC_IMPRDOCU.IMDOPART%type,
		inuIMDOFILA in LDC_IMPRDOCU.IMDOFILA%type,
		isbIMDOPROG in LDC_IMPRDOCU.IMDOPROG%type,
		orcLDC_IMPRDOCU  out styLDC_IMPRDOCU
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_IMPRDOCU  out styLDC_IMPRDOCU
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_IMPRDOCU;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALDC_IMPRDOCU
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_IMPRDOCU';
	 cnuGeEntityId constant varchar2(30) := 4156; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuIMDOPART in LDC_IMPRDOCU.IMDOPART%type,
		inuIMDOFILA in LDC_IMPRDOCU.IMDOFILA%type,
		isbIMDOPROG in LDC_IMPRDOCU.IMDOPROG%type
	)
	IS
		SELECT LDC_IMPRDOCU.*,LDC_IMPRDOCU.rowid
		FROM LDC_IMPRDOCU
		WHERE  IMDOPART = inuIMDOPART
			and IMDOFILA = inuIMDOFILA
			and IMDOPROG = isbIMDOPROG
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_IMPRDOCU.*,LDC_IMPRDOCU.rowid
		FROM LDC_IMPRDOCU
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_IMPRDOCU is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_IMPRDOCU;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_IMPRDOCU default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.IMDOPART);
		sbPk:=sbPk||','||ut_convert.fsbToChar(rcI.IMDOFILA);
		sbPk:=sbPk||','||ut_convert.fsbToChar(rcI.IMDOPROG);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuIMDOPART in LDC_IMPRDOCU.IMDOPART%type,
		inuIMDOFILA in LDC_IMPRDOCU.IMDOFILA%type,
		isbIMDOPROG in LDC_IMPRDOCU.IMDOPROG%type,
		orcLDC_IMPRDOCU  out styLDC_IMPRDOCU
	)
	IS
		rcError styLDC_IMPRDOCU;
	BEGIN
		rcError.IMDOPART := inuIMDOPART;
		rcError.IMDOFILA := inuIMDOFILA;
		rcError.IMDOPROG := isbIMDOPROG;

		Open cuLockRcByPk
		(
			inuIMDOPART,
			inuIMDOFILA,
			isbIMDOPROG
		);

		fetch cuLockRcByPk into orcLDC_IMPRDOCU;
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
		orcLDC_IMPRDOCU  out styLDC_IMPRDOCU
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_IMPRDOCU;
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
		itbLDC_IMPRDOCU  in out nocopy tytbLDC_IMPRDOCU
	)
	IS
	BEGIN
			rcRecOfTab.IMDOPART.delete;
			rcRecOfTab.IMDOFILA.delete;
			rcRecOfTab.IMDOPROG.delete;
			rcRecOfTab.IMDOSUSC.delete;
			rcRecOfTab.IMDOPROD.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_IMPRDOCU  in out nocopy tytbLDC_IMPRDOCU,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_IMPRDOCU);

		for n in itbLDC_IMPRDOCU.first .. itbLDC_IMPRDOCU.last loop
			rcRecOfTab.IMDOPART(n) := itbLDC_IMPRDOCU(n).IMDOPART;
			rcRecOfTab.IMDOFILA(n) := itbLDC_IMPRDOCU(n).IMDOFILA;
			rcRecOfTab.IMDOPROG(n) := itbLDC_IMPRDOCU(n).IMDOPROG;
			rcRecOfTab.IMDOSUSC(n) := itbLDC_IMPRDOCU(n).IMDOSUSC;
			rcRecOfTab.IMDOPROD(n) := itbLDC_IMPRDOCU(n).IMDOPROD;
			rcRecOfTab.row_id(n) := itbLDC_IMPRDOCU(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuIMDOPART in LDC_IMPRDOCU.IMDOPART%type,
		inuIMDOFILA in LDC_IMPRDOCU.IMDOFILA%type,
		isbIMDOPROG in LDC_IMPRDOCU.IMDOPROG%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuIMDOPART,
			inuIMDOFILA,
			isbIMDOPROG
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
		inuIMDOPART in LDC_IMPRDOCU.IMDOPART%type,
		inuIMDOFILA in LDC_IMPRDOCU.IMDOFILA%type,
		isbIMDOPROG in LDC_IMPRDOCU.IMDOPROG%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuIMDOPART = rcData.IMDOPART AND
			inuIMDOFILA = rcData.IMDOFILA AND
			isbIMDOPROG = rcData.IMDOPROG
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
		inuIMDOPART in LDC_IMPRDOCU.IMDOPART%type,
		inuIMDOFILA in LDC_IMPRDOCU.IMDOFILA%type,
		isbIMDOPROG in LDC_IMPRDOCU.IMDOPROG%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuIMDOPART,
			inuIMDOFILA,
			isbIMDOPROG
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuIMDOPART in LDC_IMPRDOCU.IMDOPART%type,
		inuIMDOFILA in LDC_IMPRDOCU.IMDOFILA%type,
		isbIMDOPROG in LDC_IMPRDOCU.IMDOPROG%type
	)
	IS
		rcError styLDC_IMPRDOCU;
	BEGIN		rcError.IMDOPART:=inuIMDOPART;		rcError.IMDOFILA:=inuIMDOFILA;		rcError.IMDOPROG:=isbIMDOPROG;

		Load
		(
			inuIMDOPART,
			inuIMDOFILA,
			isbIMDOPROG
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
		inuIMDOPART in LDC_IMPRDOCU.IMDOPART%type,
		inuIMDOFILA in LDC_IMPRDOCU.IMDOFILA%type,
		isbIMDOPROG in LDC_IMPRDOCU.IMDOPROG%type
	)
	IS
	BEGIN
		Load
		(
			inuIMDOPART,
			inuIMDOFILA,
			isbIMDOPROG
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuIMDOPART in LDC_IMPRDOCU.IMDOPART%type,
		inuIMDOFILA in LDC_IMPRDOCU.IMDOFILA%type,
		isbIMDOPROG in LDC_IMPRDOCU.IMDOPROG%type,
		orcRecord out nocopy styLDC_IMPRDOCU
	)
	IS
		rcError styLDC_IMPRDOCU;
	BEGIN		rcError.IMDOPART:=inuIMDOPART;		rcError.IMDOFILA:=inuIMDOFILA;		rcError.IMDOPROG:=isbIMDOPROG;

		Load
		(
			inuIMDOPART,
			inuIMDOFILA,
			isbIMDOPROG
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuIMDOPART in LDC_IMPRDOCU.IMDOPART%type,
		inuIMDOFILA in LDC_IMPRDOCU.IMDOFILA%type,
		isbIMDOPROG in LDC_IMPRDOCU.IMDOPROG%type
	)
	RETURN styLDC_IMPRDOCU
	IS
		rcError styLDC_IMPRDOCU;
	BEGIN
		rcError.IMDOPART:=inuIMDOPART;
		rcError.IMDOFILA:=inuIMDOFILA;
		rcError.IMDOPROG:=isbIMDOPROG;

		Load
		(
			inuIMDOPART,
			inuIMDOFILA,
			isbIMDOPROG
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuIMDOPART in LDC_IMPRDOCU.IMDOPART%type,
		inuIMDOFILA in LDC_IMPRDOCU.IMDOFILA%type,
		isbIMDOPROG in LDC_IMPRDOCU.IMDOPROG%type
	)
	RETURN styLDC_IMPRDOCU
	IS
		rcError styLDC_IMPRDOCU;
	BEGIN
		rcError.IMDOPART:=inuIMDOPART;
		rcError.IMDOFILA:=inuIMDOFILA;
		rcError.IMDOPROG:=isbIMDOPROG;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuIMDOPART,
			inuIMDOFILA,
			isbIMDOPROG
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuIMDOPART,
			inuIMDOFILA,
			isbIMDOPROG
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_IMPRDOCU
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_IMPRDOCU
	)
	IS
		rfLDC_IMPRDOCU tyrfLDC_IMPRDOCU;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_IMPRDOCU.*, LDC_IMPRDOCU.rowid FROM LDC_IMPRDOCU';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_IMPRDOCU for sbFullQuery;

		fetch rfLDC_IMPRDOCU bulk collect INTO otbResult;

		close rfLDC_IMPRDOCU;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_IMPRDOCU.*, LDC_IMPRDOCU.rowid FROM LDC_IMPRDOCU';
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
		ircLDC_IMPRDOCU in styLDC_IMPRDOCU
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_IMPRDOCU,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_IMPRDOCU in styLDC_IMPRDOCU,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_IMPRDOCU.IMDOPART is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|IMDOPART');
			raise ex.controlled_error;
		end if;
		if ircLDC_IMPRDOCU.IMDOFILA is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|IMDOFILA');
			raise ex.controlled_error;
		end if;
		if ircLDC_IMPRDOCU.IMDOPROG is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|IMDOPROG');
			raise ex.controlled_error;
		end if;

		insert into LDC_IMPRDOCU
		(
			IMDOPART,
			IMDOFILA,
			IMDOPROG,
			IMDOSUSC,
			IMDOPROD
		)
		values
		(
			ircLDC_IMPRDOCU.IMDOPART,
			ircLDC_IMPRDOCU.IMDOFILA,
			ircLDC_IMPRDOCU.IMDOPROG,
			ircLDC_IMPRDOCU.IMDOSUSC,
			ircLDC_IMPRDOCU.IMDOPROD
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_IMPRDOCU));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_IMPRDOCU in out nocopy tytbLDC_IMPRDOCU
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_IMPRDOCU,blUseRowID);
		forall n in iotbLDC_IMPRDOCU.first..iotbLDC_IMPRDOCU.last
			insert into LDC_IMPRDOCU
			(
				IMDOPART,
				IMDOFILA,
				IMDOPROG,
				IMDOSUSC,
				IMDOPROD
			)
			values
			(
				rcRecOfTab.IMDOPART(n),
				rcRecOfTab.IMDOFILA(n),
				rcRecOfTab.IMDOPROG(n),
				rcRecOfTab.IMDOSUSC(n),
				rcRecOfTab.IMDOPROD(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuIMDOPART in LDC_IMPRDOCU.IMDOPART%type,
		inuIMDOFILA in LDC_IMPRDOCU.IMDOFILA%type,
		isbIMDOPROG in LDC_IMPRDOCU.IMDOPROG%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_IMPRDOCU;
	BEGIN
		rcError.IMDOPART := inuIMDOPART;
		rcError.IMDOFILA := inuIMDOFILA;
		rcError.IMDOPROG := isbIMDOPROG;

		if inuLock=1 then
			LockByPk
			(
				inuIMDOPART,
				inuIMDOFILA,
				isbIMDOPROG,
				rcData
			);
		end if;


		delete
		from LDC_IMPRDOCU
		where
       		IMDOPART=inuIMDOPART and
       		IMDOFILA=inuIMDOFILA and
       		IMDOPROG=isbIMDOPROG;
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
		rcError  styLDC_IMPRDOCU;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_IMPRDOCU
		where
			rowid = iriRowID
		returning
			IMDOPART,
			IMDOFILA,
			IMDOPROG
		into
			rcError.IMDOPART,
			rcError.IMDOFILA,
			rcError.IMDOPROG;
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
		iotbLDC_IMPRDOCU in out nocopy tytbLDC_IMPRDOCU,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_IMPRDOCU;
	BEGIN
		FillRecordOfTables(iotbLDC_IMPRDOCU, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_IMPRDOCU.first .. iotbLDC_IMPRDOCU.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_IMPRDOCU.first .. iotbLDC_IMPRDOCU.last
				delete
				from LDC_IMPRDOCU
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_IMPRDOCU.first .. iotbLDC_IMPRDOCU.last loop
					LockByPk
					(
						rcRecOfTab.IMDOPART(n),
						rcRecOfTab.IMDOFILA(n),
						rcRecOfTab.IMDOPROG(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_IMPRDOCU.first .. iotbLDC_IMPRDOCU.last
				delete
				from LDC_IMPRDOCU
				where
		         	IMDOPART = rcRecOfTab.IMDOPART(n) and
		         	IMDOFILA = rcRecOfTab.IMDOFILA(n) and
		         	IMDOPROG = rcRecOfTab.IMDOPROG(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_IMPRDOCU in styLDC_IMPRDOCU,
		inuLock in number default 0
	)
	IS
		nuIMDOPART	LDC_IMPRDOCU.IMDOPART%type;
		nuIMDOFILA	LDC_IMPRDOCU.IMDOFILA%type;
		sbIMDOPROG	LDC_IMPRDOCU.IMDOPROG%type;
	BEGIN
		if ircLDC_IMPRDOCU.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_IMPRDOCU.rowid,rcData);
			end if;
			update LDC_IMPRDOCU
			set
				IMDOSUSC = ircLDC_IMPRDOCU.IMDOSUSC,
				IMDOPROD = ircLDC_IMPRDOCU.IMDOPROD
			where
				rowid = ircLDC_IMPRDOCU.rowid
			returning
				IMDOPART,
				IMDOFILA,
				IMDOPROG
			into
				nuIMDOPART,
				nuIMDOFILA,
				sbIMDOPROG;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_IMPRDOCU.IMDOPART,
					ircLDC_IMPRDOCU.IMDOFILA,
					ircLDC_IMPRDOCU.IMDOPROG,
					rcData
				);
			end if;

			update LDC_IMPRDOCU
			set
				IMDOSUSC = ircLDC_IMPRDOCU.IMDOSUSC,
				IMDOPROD = ircLDC_IMPRDOCU.IMDOPROD
			where
				IMDOPART = ircLDC_IMPRDOCU.IMDOPART and
				IMDOFILA = ircLDC_IMPRDOCU.IMDOFILA and
				IMDOPROG = ircLDC_IMPRDOCU.IMDOPROG
			returning
				IMDOPART,
				IMDOFILA,
				IMDOPROG
			into
				nuIMDOPART,
				nuIMDOFILA,
				sbIMDOPROG;
		end if;
		if
			nuIMDOPART is NULL OR
			nuIMDOFILA is NULL OR
			sbIMDOPROG is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_IMPRDOCU));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_IMPRDOCU in out nocopy tytbLDC_IMPRDOCU,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_IMPRDOCU;
	BEGIN
		FillRecordOfTables(iotbLDC_IMPRDOCU,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_IMPRDOCU.first .. iotbLDC_IMPRDOCU.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_IMPRDOCU.first .. iotbLDC_IMPRDOCU.last
				update LDC_IMPRDOCU
				set
					IMDOSUSC = rcRecOfTab.IMDOSUSC(n),
					IMDOPROD = rcRecOfTab.IMDOPROD(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_IMPRDOCU.first .. iotbLDC_IMPRDOCU.last loop
					LockByPk
					(
						rcRecOfTab.IMDOPART(n),
						rcRecOfTab.IMDOFILA(n),
						rcRecOfTab.IMDOPROG(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_IMPRDOCU.first .. iotbLDC_IMPRDOCU.last
				update LDC_IMPRDOCU
				SET
					IMDOSUSC = rcRecOfTab.IMDOSUSC(n),
					IMDOPROD = rcRecOfTab.IMDOPROD(n)
				where
					IMDOPART = rcRecOfTab.IMDOPART(n) and
					IMDOFILA = rcRecOfTab.IMDOFILA(n) and
					IMDOPROG = rcRecOfTab.IMDOPROG(n)
;
		end if;
	END;
	PROCEDURE updIMDOSUSC
	(
		inuIMDOPART in LDC_IMPRDOCU.IMDOPART%type,
		inuIMDOFILA in LDC_IMPRDOCU.IMDOFILA%type,
		isbIMDOPROG in LDC_IMPRDOCU.IMDOPROG%type,
		inuIMDOSUSC$ in LDC_IMPRDOCU.IMDOSUSC%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_IMPRDOCU;
	BEGIN
		rcError.IMDOPART := inuIMDOPART;
		rcError.IMDOFILA := inuIMDOFILA;
		rcError.IMDOPROG := isbIMDOPROG;
		if inuLock=1 then
			LockByPk
			(
				inuIMDOPART,
				inuIMDOFILA,
				isbIMDOPROG,
				rcData
			);
		end if;

		update LDC_IMPRDOCU
		set
			IMDOSUSC = inuIMDOSUSC$
		where
			IMDOPART = inuIMDOPART and
			IMDOFILA = inuIMDOFILA and
			IMDOPROG = isbIMDOPROG;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.IMDOSUSC:= inuIMDOSUSC$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updIMDOPROD
	(
		inuIMDOPART in LDC_IMPRDOCU.IMDOPART%type,
		inuIMDOFILA in LDC_IMPRDOCU.IMDOFILA%type,
		isbIMDOPROG in LDC_IMPRDOCU.IMDOPROG%type,
		inuIMDOPROD$ in LDC_IMPRDOCU.IMDOPROD%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_IMPRDOCU;
	BEGIN
		rcError.IMDOPART := inuIMDOPART;
		rcError.IMDOFILA := inuIMDOFILA;
		rcError.IMDOPROG := isbIMDOPROG;
		if inuLock=1 then
			LockByPk
			(
				inuIMDOPART,
				inuIMDOFILA,
				isbIMDOPROG,
				rcData
			);
		end if;

		update LDC_IMPRDOCU
		set
			IMDOPROD = inuIMDOPROD$
		where
			IMDOPART = inuIMDOPART and
			IMDOFILA = inuIMDOFILA and
			IMDOPROG = isbIMDOPROG;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.IMDOPROD:= inuIMDOPROD$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetIMDOPART
	(
		inuIMDOPART in LDC_IMPRDOCU.IMDOPART%type,
		inuIMDOFILA in LDC_IMPRDOCU.IMDOFILA%type,
		isbIMDOPROG in LDC_IMPRDOCU.IMDOPROG%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_IMPRDOCU.IMDOPART%type
	IS
		rcError styLDC_IMPRDOCU;
	BEGIN

		rcError.IMDOPART := inuIMDOPART;
		rcError.IMDOFILA := inuIMDOFILA;
		rcError.IMDOPROG := isbIMDOPROG;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuIMDOPART,
		 		inuIMDOFILA,
		 		isbIMDOPROG
			 )
		then
			 return(rcData.IMDOPART);
		end if;
		Load
		(
		 		inuIMDOPART,
		 		inuIMDOFILA,
		 		isbIMDOPROG
		);
		return(rcData.IMDOPART);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetIMDOFILA
	(
		inuIMDOPART in LDC_IMPRDOCU.IMDOPART%type,
		inuIMDOFILA in LDC_IMPRDOCU.IMDOFILA%type,
		isbIMDOPROG in LDC_IMPRDOCU.IMDOPROG%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_IMPRDOCU.IMDOFILA%type
	IS
		rcError styLDC_IMPRDOCU;
	BEGIN

		rcError.IMDOPART := inuIMDOPART;
		rcError.IMDOFILA := inuIMDOFILA;
		rcError.IMDOPROG := isbIMDOPROG;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuIMDOPART,
		 		inuIMDOFILA,
		 		isbIMDOPROG
			 )
		then
			 return(rcData.IMDOFILA);
		end if;
		Load
		(
		 		inuIMDOPART,
		 		inuIMDOFILA,
		 		isbIMDOPROG
		);
		return(rcData.IMDOFILA);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetIMDOPROG
	(
		inuIMDOPART in LDC_IMPRDOCU.IMDOPART%type,
		inuIMDOFILA in LDC_IMPRDOCU.IMDOFILA%type,
		isbIMDOPROG in LDC_IMPRDOCU.IMDOPROG%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_IMPRDOCU.IMDOPROG%type
	IS
		rcError styLDC_IMPRDOCU;
	BEGIN

		rcError.IMDOPART := inuIMDOPART;
		rcError.IMDOFILA := inuIMDOFILA;
		rcError.IMDOPROG := isbIMDOPROG;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuIMDOPART,
		 		inuIMDOFILA,
		 		isbIMDOPROG
			 )
		then
			 return(rcData.IMDOPROG);
		end if;
		Load
		(
		 		inuIMDOPART,
		 		inuIMDOFILA,
		 		isbIMDOPROG
		);
		return(rcData.IMDOPROG);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetIMDOSUSC
	(
		inuIMDOPART in LDC_IMPRDOCU.IMDOPART%type,
		inuIMDOFILA in LDC_IMPRDOCU.IMDOFILA%type,
		isbIMDOPROG in LDC_IMPRDOCU.IMDOPROG%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_IMPRDOCU.IMDOSUSC%type
	IS
		rcError styLDC_IMPRDOCU;
	BEGIN

		rcError.IMDOPART := inuIMDOPART;
		rcError.IMDOFILA := inuIMDOFILA;
		rcError.IMDOPROG := isbIMDOPROG;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuIMDOPART,
		 		inuIMDOFILA,
		 		isbIMDOPROG
			 )
		then
			 return(rcData.IMDOSUSC);
		end if;
		Load
		(
		 		inuIMDOPART,
		 		inuIMDOFILA,
		 		isbIMDOPROG
		);
		return(rcData.IMDOSUSC);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetIMDOPROD
	(
		inuIMDOPART in LDC_IMPRDOCU.IMDOPART%type,
		inuIMDOFILA in LDC_IMPRDOCU.IMDOFILA%type,
		isbIMDOPROG in LDC_IMPRDOCU.IMDOPROG%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_IMPRDOCU.IMDOPROD%type
	IS
		rcError styLDC_IMPRDOCU;
	BEGIN

		rcError.IMDOPART := inuIMDOPART;
		rcError.IMDOFILA := inuIMDOFILA;
		rcError.IMDOPROG := isbIMDOPROG;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuIMDOPART,
		 		inuIMDOFILA,
		 		isbIMDOPROG
			 )
		then
			 return(rcData.IMDOPROD);
		end if;
		Load
		(
		 		inuIMDOPART,
		 		inuIMDOFILA,
		 		isbIMDOPROG
		);
		return(rcData.IMDOPROD);
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
end DALDC_IMPRDOCU;
/
PROMPT Otorgando permisos de ejecucion a DALDC_IMPRDOCU
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_IMPRDOCU', 'ADM_PERSON');
END;
/