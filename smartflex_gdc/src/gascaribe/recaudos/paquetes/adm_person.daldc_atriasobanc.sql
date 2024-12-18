CREATE OR REPLACE PACKAGE adm_person.DALDC_ATRIASOBANC
is
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     : DALDC_ATRIASOBANC
    Descripcion	 : 
    
    Parametro	    Descripcion
    ============	==============================
    
    Historia de Modificaciones
    Fecha   	           Autor            Modificacion
    ====================   =========        ====================
    07/06/2024              PAcosta         OSF-2812: Cambio de esquema ADM_PERSON                                                
    ****************************************************************/   
    
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuATRIASOBANC_ID in LDC_ATRIASOBANC.ATRIASOBANC_ID%type
	)
	IS
		SELECT LDC_ATRIASOBANC.*,LDC_ATRIASOBANC.rowid
		FROM LDC_ATRIASOBANC
		WHERE
		    ATRIASOBANC_ID = inuATRIASOBANC_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_ATRIASOBANC.*,LDC_ATRIASOBANC.rowid
		FROM LDC_ATRIASOBANC
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_ATRIASOBANC  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_ATRIASOBANC is table of styLDC_ATRIASOBANC index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_ATRIASOBANC;

	/* Tipos referenciando al registro */
	type tytbOBSERVACION is table of LDC_ATRIASOBANC.OBSERVACION%type index by binary_integer;
	type tytbVALOR is table of LDC_ATRIASOBANC.VALOR%type index by binary_integer;
	type tytbFORMATO is table of LDC_ATRIASOBANC.FORMATO%type index by binary_integer;
	type tytbLONGITUD is table of LDC_ATRIASOBANC.LONGITUD%type index by binary_integer;
	type tytbDESCRIPTION is table of LDC_ATRIASOBANC.DESCRIPTION%type index by binary_integer;
	type tytbPOSICION is table of LDC_ATRIASOBANC.POSICION%type index by binary_integer;
	type tytbREGIASOBANC_ID is table of LDC_ATRIASOBANC.REGIASOBANC_ID%type index by binary_integer;
	type tytbATRIASOBANC_ID is table of LDC_ATRIASOBANC.ATRIASOBANC_ID%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_ATRIASOBANC is record
	(
		OBSERVACION   tytbOBSERVACION,
		VALOR   tytbVALOR,
		FORMATO   tytbFORMATO,
		LONGITUD   tytbLONGITUD,
		DESCRIPTION   tytbDESCRIPTION,
		POSICION   tytbPOSICION,
		REGIASOBANC_ID   tytbREGIASOBANC_ID,
		ATRIASOBANC_ID   tytbATRIASOBANC_ID,
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
		inuATRIASOBANC_ID in LDC_ATRIASOBANC.ATRIASOBANC_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuATRIASOBANC_ID in LDC_ATRIASOBANC.ATRIASOBANC_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuATRIASOBANC_ID in LDC_ATRIASOBANC.ATRIASOBANC_ID%type
	);

	PROCEDURE getRecord
	(
		inuATRIASOBANC_ID in LDC_ATRIASOBANC.ATRIASOBANC_ID%type,
		orcRecord out nocopy styLDC_ATRIASOBANC
	);

	FUNCTION frcGetRcData
	(
		inuATRIASOBANC_ID in LDC_ATRIASOBANC.ATRIASOBANC_ID%type
	)
	RETURN styLDC_ATRIASOBANC;

	FUNCTION frcGetRcData
	RETURN styLDC_ATRIASOBANC;

	FUNCTION frcGetRecord
	(
		inuATRIASOBANC_ID in LDC_ATRIASOBANC.ATRIASOBANC_ID%type
	)
	RETURN styLDC_ATRIASOBANC;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_ATRIASOBANC
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_ATRIASOBANC in styLDC_ATRIASOBANC
	);

	PROCEDURE insRecord
	(
		ircLDC_ATRIASOBANC in styLDC_ATRIASOBANC,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_ATRIASOBANC in out nocopy tytbLDC_ATRIASOBANC
	);

	PROCEDURE delRecord
	(
		inuATRIASOBANC_ID in LDC_ATRIASOBANC.ATRIASOBANC_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_ATRIASOBANC in out nocopy tytbLDC_ATRIASOBANC,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_ATRIASOBANC in styLDC_ATRIASOBANC,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_ATRIASOBANC in out nocopy tytbLDC_ATRIASOBANC,
		inuLock in number default 1
	);

	PROCEDURE updOBSERVACION
	(
		inuATRIASOBANC_ID in LDC_ATRIASOBANC.ATRIASOBANC_ID%type,
		isbOBSERVACION$ in LDC_ATRIASOBANC.OBSERVACION%type,
		inuLock in number default 0
	);

	PROCEDURE updVALOR
	(
		inuATRIASOBANC_ID in LDC_ATRIASOBANC.ATRIASOBANC_ID%type,
		isbVALOR$ in LDC_ATRIASOBANC.VALOR%type,
		inuLock in number default 0
	);

	PROCEDURE updFORMATO
	(
		inuATRIASOBANC_ID in LDC_ATRIASOBANC.ATRIASOBANC_ID%type,
		isbFORMATO$ in LDC_ATRIASOBANC.FORMATO%type,
		inuLock in number default 0
	);

	PROCEDURE updLONGITUD
	(
		inuATRIASOBANC_ID in LDC_ATRIASOBANC.ATRIASOBANC_ID%type,
		inuLONGITUD$ in LDC_ATRIASOBANC.LONGITUD%type,
		inuLock in number default 0
	);

	PROCEDURE updDESCRIPTION
	(
		inuATRIASOBANC_ID in LDC_ATRIASOBANC.ATRIASOBANC_ID%type,
		isbDESCRIPTION$ in LDC_ATRIASOBANC.DESCRIPTION%type,
		inuLock in number default 0
	);

	PROCEDURE updPOSICION
	(
		inuATRIASOBANC_ID in LDC_ATRIASOBANC.ATRIASOBANC_ID%type,
		inuPOSICION$ in LDC_ATRIASOBANC.POSICION%type,
		inuLock in number default 0
	);

	PROCEDURE updREGIASOBANC_ID
	(
		inuATRIASOBANC_ID in LDC_ATRIASOBANC.ATRIASOBANC_ID%type,
		inuREGIASOBANC_ID$ in LDC_ATRIASOBANC.REGIASOBANC_ID%type,
		inuLock in number default 0
	);

	FUNCTION fsbGetOBSERVACION
	(
		inuATRIASOBANC_ID in LDC_ATRIASOBANC.ATRIASOBANC_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ATRIASOBANC.OBSERVACION%type;

	FUNCTION fsbGetVALOR
	(
		inuATRIASOBANC_ID in LDC_ATRIASOBANC.ATRIASOBANC_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ATRIASOBANC.VALOR%type;

	FUNCTION fsbGetFORMATO
	(
		inuATRIASOBANC_ID in LDC_ATRIASOBANC.ATRIASOBANC_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ATRIASOBANC.FORMATO%type;

	FUNCTION fnuGetLONGITUD
	(
		inuATRIASOBANC_ID in LDC_ATRIASOBANC.ATRIASOBANC_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ATRIASOBANC.LONGITUD%type;

	FUNCTION fsbGetDESCRIPTION
	(
		inuATRIASOBANC_ID in LDC_ATRIASOBANC.ATRIASOBANC_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ATRIASOBANC.DESCRIPTION%type;

	FUNCTION fnuGetPOSICION
	(
		inuATRIASOBANC_ID in LDC_ATRIASOBANC.ATRIASOBANC_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ATRIASOBANC.POSICION%type;

	FUNCTION fnuGetREGIASOBANC_ID
	(
		inuATRIASOBANC_ID in LDC_ATRIASOBANC.ATRIASOBANC_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ATRIASOBANC.REGIASOBANC_ID%type;

	FUNCTION fnuGetATRIASOBANC_ID
	(
		inuATRIASOBANC_ID in LDC_ATRIASOBANC.ATRIASOBANC_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ATRIASOBANC.ATRIASOBANC_ID%type;


	PROCEDURE LockByPk
	(
		inuATRIASOBANC_ID in LDC_ATRIASOBANC.ATRIASOBANC_ID%type,
		orcLDC_ATRIASOBANC  out styLDC_ATRIASOBANC
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_ATRIASOBANC  out styLDC_ATRIASOBANC
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_ATRIASOBANC;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALDC_ATRIASOBANC
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_ATRIASOBANC';
	 cnuGeEntityId constant varchar2(30) := 57; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuATRIASOBANC_ID in LDC_ATRIASOBANC.ATRIASOBANC_ID%type
	)
	IS
		SELECT LDC_ATRIASOBANC.*,LDC_ATRIASOBANC.rowid
		FROM LDC_ATRIASOBANC
		WHERE  ATRIASOBANC_ID = inuATRIASOBANC_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_ATRIASOBANC.*,LDC_ATRIASOBANC.rowid
		FROM LDC_ATRIASOBANC
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_ATRIASOBANC is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_ATRIASOBANC;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_ATRIASOBANC default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.ATRIASOBANC_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuATRIASOBANC_ID in LDC_ATRIASOBANC.ATRIASOBANC_ID%type,
		orcLDC_ATRIASOBANC  out styLDC_ATRIASOBANC
	)
	IS
		rcError styLDC_ATRIASOBANC;
	BEGIN
		rcError.ATRIASOBANC_ID := inuATRIASOBANC_ID;

		Open cuLockRcByPk
		(
			inuATRIASOBANC_ID
		);

		fetch cuLockRcByPk into orcLDC_ATRIASOBANC;
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
		orcLDC_ATRIASOBANC  out styLDC_ATRIASOBANC
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_ATRIASOBANC;
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
		itbLDC_ATRIASOBANC  in out nocopy tytbLDC_ATRIASOBANC
	)
	IS
	BEGIN
			rcRecOfTab.OBSERVACION.delete;
			rcRecOfTab.VALOR.delete;
			rcRecOfTab.FORMATO.delete;
			rcRecOfTab.LONGITUD.delete;
			rcRecOfTab.DESCRIPTION.delete;
			rcRecOfTab.POSICION.delete;
			rcRecOfTab.REGIASOBANC_ID.delete;
			rcRecOfTab.ATRIASOBANC_ID.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_ATRIASOBANC  in out nocopy tytbLDC_ATRIASOBANC,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_ATRIASOBANC);

		for n in itbLDC_ATRIASOBANC.first .. itbLDC_ATRIASOBANC.last loop
			rcRecOfTab.OBSERVACION(n) := itbLDC_ATRIASOBANC(n).OBSERVACION;
			rcRecOfTab.VALOR(n) := itbLDC_ATRIASOBANC(n).VALOR;
			rcRecOfTab.FORMATO(n) := itbLDC_ATRIASOBANC(n).FORMATO;
			rcRecOfTab.LONGITUD(n) := itbLDC_ATRIASOBANC(n).LONGITUD;
			rcRecOfTab.DESCRIPTION(n) := itbLDC_ATRIASOBANC(n).DESCRIPTION;
			rcRecOfTab.POSICION(n) := itbLDC_ATRIASOBANC(n).POSICION;
			rcRecOfTab.REGIASOBANC_ID(n) := itbLDC_ATRIASOBANC(n).REGIASOBANC_ID;
			rcRecOfTab.ATRIASOBANC_ID(n) := itbLDC_ATRIASOBANC(n).ATRIASOBANC_ID;
			rcRecOfTab.row_id(n) := itbLDC_ATRIASOBANC(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuATRIASOBANC_ID in LDC_ATRIASOBANC.ATRIASOBANC_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuATRIASOBANC_ID
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
		inuATRIASOBANC_ID in LDC_ATRIASOBANC.ATRIASOBANC_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuATRIASOBANC_ID = rcData.ATRIASOBANC_ID
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
		inuATRIASOBANC_ID in LDC_ATRIASOBANC.ATRIASOBANC_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuATRIASOBANC_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuATRIASOBANC_ID in LDC_ATRIASOBANC.ATRIASOBANC_ID%type
	)
	IS
		rcError styLDC_ATRIASOBANC;
	BEGIN		rcError.ATRIASOBANC_ID:=inuATRIASOBANC_ID;

		Load
		(
			inuATRIASOBANC_ID
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
		inuATRIASOBANC_ID in LDC_ATRIASOBANC.ATRIASOBANC_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuATRIASOBANC_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuATRIASOBANC_ID in LDC_ATRIASOBANC.ATRIASOBANC_ID%type,
		orcRecord out nocopy styLDC_ATRIASOBANC
	)
	IS
		rcError styLDC_ATRIASOBANC;
	BEGIN		rcError.ATRIASOBANC_ID:=inuATRIASOBANC_ID;

		Load
		(
			inuATRIASOBANC_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuATRIASOBANC_ID in LDC_ATRIASOBANC.ATRIASOBANC_ID%type
	)
	RETURN styLDC_ATRIASOBANC
	IS
		rcError styLDC_ATRIASOBANC;
	BEGIN
		rcError.ATRIASOBANC_ID:=inuATRIASOBANC_ID;

		Load
		(
			inuATRIASOBANC_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuATRIASOBANC_ID in LDC_ATRIASOBANC.ATRIASOBANC_ID%type
	)
	RETURN styLDC_ATRIASOBANC
	IS
		rcError styLDC_ATRIASOBANC;
	BEGIN
		rcError.ATRIASOBANC_ID:=inuATRIASOBANC_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuATRIASOBANC_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuATRIASOBANC_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_ATRIASOBANC
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_ATRIASOBANC
	)
	IS
		rfLDC_ATRIASOBANC tyrfLDC_ATRIASOBANC;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_ATRIASOBANC.*, LDC_ATRIASOBANC.rowid FROM LDC_ATRIASOBANC';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_ATRIASOBANC for sbFullQuery;

		fetch rfLDC_ATRIASOBANC bulk collect INTO otbResult;

		close rfLDC_ATRIASOBANC;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_ATRIASOBANC.*, LDC_ATRIASOBANC.rowid FROM LDC_ATRIASOBANC';
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
		ircLDC_ATRIASOBANC in styLDC_ATRIASOBANC
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_ATRIASOBANC,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_ATRIASOBANC in styLDC_ATRIASOBANC,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_ATRIASOBANC.ATRIASOBANC_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ATRIASOBANC_ID');
			raise ex.controlled_error;
		end if;

		insert into LDC_ATRIASOBANC
		(
			OBSERVACION,
			VALOR,
			FORMATO,
			LONGITUD,
			DESCRIPTION,
			POSICION,
			REGIASOBANC_ID,
			ATRIASOBANC_ID
		)
		values
		(
			ircLDC_ATRIASOBANC.OBSERVACION,
			ircLDC_ATRIASOBANC.VALOR,
			ircLDC_ATRIASOBANC.FORMATO,
			ircLDC_ATRIASOBANC.LONGITUD,
			ircLDC_ATRIASOBANC.DESCRIPTION,
			ircLDC_ATRIASOBANC.POSICION,
			ircLDC_ATRIASOBANC.REGIASOBANC_ID,
			ircLDC_ATRIASOBANC.ATRIASOBANC_ID
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_ATRIASOBANC));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_ATRIASOBANC in out nocopy tytbLDC_ATRIASOBANC
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_ATRIASOBANC,blUseRowID);
		forall n in iotbLDC_ATRIASOBANC.first..iotbLDC_ATRIASOBANC.last
			insert into LDC_ATRIASOBANC
			(
				OBSERVACION,
				VALOR,
				FORMATO,
				LONGITUD,
				DESCRIPTION,
				POSICION,
				REGIASOBANC_ID,
				ATRIASOBANC_ID
			)
			values
			(
				rcRecOfTab.OBSERVACION(n),
				rcRecOfTab.VALOR(n),
				rcRecOfTab.FORMATO(n),
				rcRecOfTab.LONGITUD(n),
				rcRecOfTab.DESCRIPTION(n),
				rcRecOfTab.POSICION(n),
				rcRecOfTab.REGIASOBANC_ID(n),
				rcRecOfTab.ATRIASOBANC_ID(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuATRIASOBANC_ID in LDC_ATRIASOBANC.ATRIASOBANC_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_ATRIASOBANC;
	BEGIN
		rcError.ATRIASOBANC_ID := inuATRIASOBANC_ID;

		if inuLock=1 then
			LockByPk
			(
				inuATRIASOBANC_ID,
				rcData
			);
		end if;


		delete
		from LDC_ATRIASOBANC
		where
       		ATRIASOBANC_ID=inuATRIASOBANC_ID;
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
		rcError  styLDC_ATRIASOBANC;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_ATRIASOBANC
		where
			rowid = iriRowID
		returning
			OBSERVACION
		into
			rcError.OBSERVACION;
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
		iotbLDC_ATRIASOBANC in out nocopy tytbLDC_ATRIASOBANC,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_ATRIASOBANC;
	BEGIN
		FillRecordOfTables(iotbLDC_ATRIASOBANC, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_ATRIASOBANC.first .. iotbLDC_ATRIASOBANC.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ATRIASOBANC.first .. iotbLDC_ATRIASOBANC.last
				delete
				from LDC_ATRIASOBANC
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_ATRIASOBANC.first .. iotbLDC_ATRIASOBANC.last loop
					LockByPk
					(
						rcRecOfTab.ATRIASOBANC_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ATRIASOBANC.first .. iotbLDC_ATRIASOBANC.last
				delete
				from LDC_ATRIASOBANC
				where
		         	ATRIASOBANC_ID = rcRecOfTab.ATRIASOBANC_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_ATRIASOBANC in styLDC_ATRIASOBANC,
		inuLock in number default 0
	)
	IS
		nuATRIASOBANC_ID	LDC_ATRIASOBANC.ATRIASOBANC_ID%type;
	BEGIN
		if ircLDC_ATRIASOBANC.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_ATRIASOBANC.rowid,rcData);
			end if;
			update LDC_ATRIASOBANC
			set
				OBSERVACION = ircLDC_ATRIASOBANC.OBSERVACION,
				VALOR = ircLDC_ATRIASOBANC.VALOR,
				FORMATO = ircLDC_ATRIASOBANC.FORMATO,
				LONGITUD = ircLDC_ATRIASOBANC.LONGITUD,
				DESCRIPTION = ircLDC_ATRIASOBANC.DESCRIPTION,
				POSICION = ircLDC_ATRIASOBANC.POSICION,
				REGIASOBANC_ID = ircLDC_ATRIASOBANC.REGIASOBANC_ID
			where
				rowid = ircLDC_ATRIASOBANC.rowid
			returning
				ATRIASOBANC_ID
			into
				nuATRIASOBANC_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_ATRIASOBANC.ATRIASOBANC_ID,
					rcData
				);
			end if;

			update LDC_ATRIASOBANC
			set
				OBSERVACION = ircLDC_ATRIASOBANC.OBSERVACION,
				VALOR = ircLDC_ATRIASOBANC.VALOR,
				FORMATO = ircLDC_ATRIASOBANC.FORMATO,
				LONGITUD = ircLDC_ATRIASOBANC.LONGITUD,
				DESCRIPTION = ircLDC_ATRIASOBANC.DESCRIPTION,
				POSICION = ircLDC_ATRIASOBANC.POSICION,
				REGIASOBANC_ID = ircLDC_ATRIASOBANC.REGIASOBANC_ID
			where
				ATRIASOBANC_ID = ircLDC_ATRIASOBANC.ATRIASOBANC_ID
			returning
				ATRIASOBANC_ID
			into
				nuATRIASOBANC_ID;
		end if;
		if
			nuATRIASOBANC_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_ATRIASOBANC));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_ATRIASOBANC in out nocopy tytbLDC_ATRIASOBANC,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_ATRIASOBANC;
	BEGIN
		FillRecordOfTables(iotbLDC_ATRIASOBANC,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_ATRIASOBANC.first .. iotbLDC_ATRIASOBANC.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ATRIASOBANC.first .. iotbLDC_ATRIASOBANC.last
				update LDC_ATRIASOBANC
				set
					OBSERVACION = rcRecOfTab.OBSERVACION(n),
					VALOR = rcRecOfTab.VALOR(n),
					FORMATO = rcRecOfTab.FORMATO(n),
					LONGITUD = rcRecOfTab.LONGITUD(n),
					DESCRIPTION = rcRecOfTab.DESCRIPTION(n),
					POSICION = rcRecOfTab.POSICION(n),
					REGIASOBANC_ID = rcRecOfTab.REGIASOBANC_ID(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_ATRIASOBANC.first .. iotbLDC_ATRIASOBANC.last loop
					LockByPk
					(
						rcRecOfTab.ATRIASOBANC_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ATRIASOBANC.first .. iotbLDC_ATRIASOBANC.last
				update LDC_ATRIASOBANC
				SET
					OBSERVACION = rcRecOfTab.OBSERVACION(n),
					VALOR = rcRecOfTab.VALOR(n),
					FORMATO = rcRecOfTab.FORMATO(n),
					LONGITUD = rcRecOfTab.LONGITUD(n),
					DESCRIPTION = rcRecOfTab.DESCRIPTION(n),
					POSICION = rcRecOfTab.POSICION(n),
					REGIASOBANC_ID = rcRecOfTab.REGIASOBANC_ID(n)
				where
					ATRIASOBANC_ID = rcRecOfTab.ATRIASOBANC_ID(n)
;
		end if;
	END;
	PROCEDURE updOBSERVACION
	(
		inuATRIASOBANC_ID in LDC_ATRIASOBANC.ATRIASOBANC_ID%type,
		isbOBSERVACION$ in LDC_ATRIASOBANC.OBSERVACION%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ATRIASOBANC;
	BEGIN
		rcError.ATRIASOBANC_ID := inuATRIASOBANC_ID;
		if inuLock=1 then
			LockByPk
			(
				inuATRIASOBANC_ID,
				rcData
			);
		end if;

		update LDC_ATRIASOBANC
		set
			OBSERVACION = isbOBSERVACION$
		where
			ATRIASOBANC_ID = inuATRIASOBANC_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.OBSERVACION:= isbOBSERVACION$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updVALOR
	(
		inuATRIASOBANC_ID in LDC_ATRIASOBANC.ATRIASOBANC_ID%type,
		isbVALOR$ in LDC_ATRIASOBANC.VALOR%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ATRIASOBANC;
	BEGIN
		rcError.ATRIASOBANC_ID := inuATRIASOBANC_ID;
		if inuLock=1 then
			LockByPk
			(
				inuATRIASOBANC_ID,
				rcData
			);
		end if;

		update LDC_ATRIASOBANC
		set
			VALOR = isbVALOR$
		where
			ATRIASOBANC_ID = inuATRIASOBANC_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.VALOR:= isbVALOR$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFORMATO
	(
		inuATRIASOBANC_ID in LDC_ATRIASOBANC.ATRIASOBANC_ID%type,
		isbFORMATO$ in LDC_ATRIASOBANC.FORMATO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ATRIASOBANC;
	BEGIN
		rcError.ATRIASOBANC_ID := inuATRIASOBANC_ID;
		if inuLock=1 then
			LockByPk
			(
				inuATRIASOBANC_ID,
				rcData
			);
		end if;

		update LDC_ATRIASOBANC
		set
			FORMATO = isbFORMATO$
		where
			ATRIASOBANC_ID = inuATRIASOBANC_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FORMATO:= isbFORMATO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updLONGITUD
	(
		inuATRIASOBANC_ID in LDC_ATRIASOBANC.ATRIASOBANC_ID%type,
		inuLONGITUD$ in LDC_ATRIASOBANC.LONGITUD%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ATRIASOBANC;
	BEGIN
		rcError.ATRIASOBANC_ID := inuATRIASOBANC_ID;
		if inuLock=1 then
			LockByPk
			(
				inuATRIASOBANC_ID,
				rcData
			);
		end if;

		update LDC_ATRIASOBANC
		set
			LONGITUD = inuLONGITUD$
		where
			ATRIASOBANC_ID = inuATRIASOBANC_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.LONGITUD:= inuLONGITUD$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updDESCRIPTION
	(
		inuATRIASOBANC_ID in LDC_ATRIASOBANC.ATRIASOBANC_ID%type,
		isbDESCRIPTION$ in LDC_ATRIASOBANC.DESCRIPTION%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ATRIASOBANC;
	BEGIN
		rcError.ATRIASOBANC_ID := inuATRIASOBANC_ID;
		if inuLock=1 then
			LockByPk
			(
				inuATRIASOBANC_ID,
				rcData
			);
		end if;

		update LDC_ATRIASOBANC
		set
			DESCRIPTION = isbDESCRIPTION$
		where
			ATRIASOBANC_ID = inuATRIASOBANC_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DESCRIPTION:= isbDESCRIPTION$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPOSICION
	(
		inuATRIASOBANC_ID in LDC_ATRIASOBANC.ATRIASOBANC_ID%type,
		inuPOSICION$ in LDC_ATRIASOBANC.POSICION%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ATRIASOBANC;
	BEGIN
		rcError.ATRIASOBANC_ID := inuATRIASOBANC_ID;
		if inuLock=1 then
			LockByPk
			(
				inuATRIASOBANC_ID,
				rcData
			);
		end if;

		update LDC_ATRIASOBANC
		set
			POSICION = inuPOSICION$
		where
			ATRIASOBANC_ID = inuATRIASOBANC_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.POSICION:= inuPOSICION$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updREGIASOBANC_ID
	(
		inuATRIASOBANC_ID in LDC_ATRIASOBANC.ATRIASOBANC_ID%type,
		inuREGIASOBANC_ID$ in LDC_ATRIASOBANC.REGIASOBANC_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ATRIASOBANC;
	BEGIN
		rcError.ATRIASOBANC_ID := inuATRIASOBANC_ID;
		if inuLock=1 then
			LockByPk
			(
				inuATRIASOBANC_ID,
				rcData
			);
		end if;

		update LDC_ATRIASOBANC
		set
			REGIASOBANC_ID = inuREGIASOBANC_ID$
		where
			ATRIASOBANC_ID = inuATRIASOBANC_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.REGIASOBANC_ID:= inuREGIASOBANC_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fsbGetOBSERVACION
	(
		inuATRIASOBANC_ID in LDC_ATRIASOBANC.ATRIASOBANC_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ATRIASOBANC.OBSERVACION%type
	IS
		rcError styLDC_ATRIASOBANC;
	BEGIN

		rcError.ATRIASOBANC_ID := inuATRIASOBANC_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuATRIASOBANC_ID
			 )
		then
			 return(rcData.OBSERVACION);
		end if;
		Load
		(
		 		inuATRIASOBANC_ID
		);
		return(rcData.OBSERVACION);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetVALOR
	(
		inuATRIASOBANC_ID in LDC_ATRIASOBANC.ATRIASOBANC_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ATRIASOBANC.VALOR%type
	IS
		rcError styLDC_ATRIASOBANC;
	BEGIN

		rcError.ATRIASOBANC_ID := inuATRIASOBANC_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuATRIASOBANC_ID
			 )
		then
			 return(rcData.VALOR);
		end if;
		Load
		(
		 		inuATRIASOBANC_ID
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
	FUNCTION fsbGetFORMATO
	(
		inuATRIASOBANC_ID in LDC_ATRIASOBANC.ATRIASOBANC_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ATRIASOBANC.FORMATO%type
	IS
		rcError styLDC_ATRIASOBANC;
	BEGIN

		rcError.ATRIASOBANC_ID := inuATRIASOBANC_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuATRIASOBANC_ID
			 )
		then
			 return(rcData.FORMATO);
		end if;
		Load
		(
		 		inuATRIASOBANC_ID
		);
		return(rcData.FORMATO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetLONGITUD
	(
		inuATRIASOBANC_ID in LDC_ATRIASOBANC.ATRIASOBANC_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ATRIASOBANC.LONGITUD%type
	IS
		rcError styLDC_ATRIASOBANC;
	BEGIN

		rcError.ATRIASOBANC_ID := inuATRIASOBANC_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuATRIASOBANC_ID
			 )
		then
			 return(rcData.LONGITUD);
		end if;
		Load
		(
		 		inuATRIASOBANC_ID
		);
		return(rcData.LONGITUD);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetDESCRIPTION
	(
		inuATRIASOBANC_ID in LDC_ATRIASOBANC.ATRIASOBANC_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ATRIASOBANC.DESCRIPTION%type
	IS
		rcError styLDC_ATRIASOBANC;
	BEGIN

		rcError.ATRIASOBANC_ID := inuATRIASOBANC_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuATRIASOBANC_ID
			 )
		then
			 return(rcData.DESCRIPTION);
		end if;
		Load
		(
		 		inuATRIASOBANC_ID
		);
		return(rcData.DESCRIPTION);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetPOSICION
	(
		inuATRIASOBANC_ID in LDC_ATRIASOBANC.ATRIASOBANC_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ATRIASOBANC.POSICION%type
	IS
		rcError styLDC_ATRIASOBANC;
	BEGIN

		rcError.ATRIASOBANC_ID := inuATRIASOBANC_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuATRIASOBANC_ID
			 )
		then
			 return(rcData.POSICION);
		end if;
		Load
		(
		 		inuATRIASOBANC_ID
		);
		return(rcData.POSICION);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetREGIASOBANC_ID
	(
		inuATRIASOBANC_ID in LDC_ATRIASOBANC.ATRIASOBANC_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ATRIASOBANC.REGIASOBANC_ID%type
	IS
		rcError styLDC_ATRIASOBANC;
	BEGIN

		rcError.ATRIASOBANC_ID := inuATRIASOBANC_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuATRIASOBANC_ID
			 )
		then
			 return(rcData.REGIASOBANC_ID);
		end if;
		Load
		(
		 		inuATRIASOBANC_ID
		);
		return(rcData.REGIASOBANC_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetATRIASOBANC_ID
	(
		inuATRIASOBANC_ID in LDC_ATRIASOBANC.ATRIASOBANC_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ATRIASOBANC.ATRIASOBANC_ID%type
	IS
		rcError styLDC_ATRIASOBANC;
	BEGIN

		rcError.ATRIASOBANC_ID := inuATRIASOBANC_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuATRIASOBANC_ID
			 )
		then
			 return(rcData.ATRIASOBANC_ID);
		end if;
		Load
		(
		 		inuATRIASOBANC_ID
		);
		return(rcData.ATRIASOBANC_ID);
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
end DALDC_ATRIASOBANC;
/
PROMPT Otorgando permisos de ejecucion a DALDC_ATRIASOBANC
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_ATRIASOBANC', 'ADM_PERSON');
END;
/