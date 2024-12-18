CREATE OR REPLACE PACKAGE ADM_PERSON.DALDC_FNB_VSI
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
		inuID_PKG_FNB in LDC_FNB_VSI.ID_PKG_FNB%type,
		inuID_OT_EA in LDC_FNB_VSI.ID_OT_EA%type,
		inuID_PKG_VSI in LDC_FNB_VSI.ID_PKG_VSI%type
	)
	IS
		SELECT LDC_FNB_VSI.*,LDC_FNB_VSI.rowid
		FROM LDC_FNB_VSI
		WHERE
		    ID_PKG_FNB = inuID_PKG_FNB
		    and ID_OT_EA = inuID_OT_EA
		    and ID_PKG_VSI = inuID_PKG_VSI;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_FNB_VSI.*,LDC_FNB_VSI.rowid
		FROM LDC_FNB_VSI
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_FNB_VSI  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_FNB_VSI is table of styLDC_FNB_VSI index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_FNB_VSI;

	/* Tipos referenciando al registro */
	type tytbID_PKG_FNB is table of LDC_FNB_VSI.ID_PKG_FNB%type index by binary_integer;
	type tytbID_OT_EA is table of LDC_FNB_VSI.ID_OT_EA%type index by binary_integer;
	type tytbID_PKG_VSI is table of LDC_FNB_VSI.ID_PKG_VSI%type index by binary_integer;
	type tytbPROCESADO is table of LDC_FNB_VSI.PROCESADO%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_FNB_VSI is record
	(
		ID_PKG_FNB   tytbID_PKG_FNB,
		ID_OT_EA   tytbID_OT_EA,
		ID_PKG_VSI   tytbID_PKG_VSI,
		PROCESADO   tytbPROCESADO,
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
		inuID_PKG_FNB in LDC_FNB_VSI.ID_PKG_FNB%type,
		inuID_OT_EA in LDC_FNB_VSI.ID_OT_EA%type,
		inuID_PKG_VSI in LDC_FNB_VSI.ID_PKG_VSI%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuID_PKG_FNB in LDC_FNB_VSI.ID_PKG_FNB%type,
		inuID_OT_EA in LDC_FNB_VSI.ID_OT_EA%type,
		inuID_PKG_VSI in LDC_FNB_VSI.ID_PKG_VSI%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuID_PKG_FNB in LDC_FNB_VSI.ID_PKG_FNB%type,
		inuID_OT_EA in LDC_FNB_VSI.ID_OT_EA%type,
		inuID_PKG_VSI in LDC_FNB_VSI.ID_PKG_VSI%type
	);

	PROCEDURE getRecord
	(
		inuID_PKG_FNB in LDC_FNB_VSI.ID_PKG_FNB%type,
		inuID_OT_EA in LDC_FNB_VSI.ID_OT_EA%type,
		inuID_PKG_VSI in LDC_FNB_VSI.ID_PKG_VSI%type,
		orcRecord out nocopy styLDC_FNB_VSI
	);

	FUNCTION frcGetRcData
	(
		inuID_PKG_FNB in LDC_FNB_VSI.ID_PKG_FNB%type,
		inuID_OT_EA in LDC_FNB_VSI.ID_OT_EA%type,
		inuID_PKG_VSI in LDC_FNB_VSI.ID_PKG_VSI%type
	)
	RETURN styLDC_FNB_VSI;

	FUNCTION frcGetRcData
	RETURN styLDC_FNB_VSI;

	FUNCTION frcGetRecord
	(
		inuID_PKG_FNB in LDC_FNB_VSI.ID_PKG_FNB%type,
		inuID_OT_EA in LDC_FNB_VSI.ID_OT_EA%type,
		inuID_PKG_VSI in LDC_FNB_VSI.ID_PKG_VSI%type
	)
	RETURN styLDC_FNB_VSI;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_FNB_VSI
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_FNB_VSI in styLDC_FNB_VSI
	);

	PROCEDURE insRecord
	(
		ircLDC_FNB_VSI in styLDC_FNB_VSI,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_FNB_VSI in out nocopy tytbLDC_FNB_VSI
	);

	PROCEDURE delRecord
	(
		inuID_PKG_FNB in LDC_FNB_VSI.ID_PKG_FNB%type,
		inuID_OT_EA in LDC_FNB_VSI.ID_OT_EA%type,
		inuID_PKG_VSI in LDC_FNB_VSI.ID_PKG_VSI%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_FNB_VSI in out nocopy tytbLDC_FNB_VSI,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_FNB_VSI in styLDC_FNB_VSI,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_FNB_VSI in out nocopy tytbLDC_FNB_VSI,
		inuLock in number default 1
	);

	PROCEDURE updPROCESADO
	(
		inuID_PKG_FNB in LDC_FNB_VSI.ID_PKG_FNB%type,
		inuID_OT_EA in LDC_FNB_VSI.ID_OT_EA%type,
		inuID_PKG_VSI in LDC_FNB_VSI.ID_PKG_VSI%type,
		isbPROCESADO$ in LDC_FNB_VSI.PROCESADO%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetID_PKG_FNB
	(
		inuID_PKG_FNB in LDC_FNB_VSI.ID_PKG_FNB%type,
		inuID_OT_EA in LDC_FNB_VSI.ID_OT_EA%type,
		inuID_PKG_VSI in LDC_FNB_VSI.ID_PKG_VSI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_FNB_VSI.ID_PKG_FNB%type;

	FUNCTION fnuGetID_OT_EA
	(
		inuID_PKG_FNB in LDC_FNB_VSI.ID_PKG_FNB%type,
		inuID_OT_EA in LDC_FNB_VSI.ID_OT_EA%type,
		inuID_PKG_VSI in LDC_FNB_VSI.ID_PKG_VSI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_FNB_VSI.ID_OT_EA%type;

	FUNCTION fnuGetID_PKG_VSI
	(
		inuID_PKG_FNB in LDC_FNB_VSI.ID_PKG_FNB%type,
		inuID_OT_EA in LDC_FNB_VSI.ID_OT_EA%type,
		inuID_PKG_VSI in LDC_FNB_VSI.ID_PKG_VSI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_FNB_VSI.ID_PKG_VSI%type;

	FUNCTION fsbGetPROCESADO
	(
		inuID_PKG_FNB in LDC_FNB_VSI.ID_PKG_FNB%type,
		inuID_OT_EA in LDC_FNB_VSI.ID_OT_EA%type,
		inuID_PKG_VSI in LDC_FNB_VSI.ID_PKG_VSI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_FNB_VSI.PROCESADO%type;


	PROCEDURE LockByPk
	(
		inuID_PKG_FNB in LDC_FNB_VSI.ID_PKG_FNB%type,
		inuID_OT_EA in LDC_FNB_VSI.ID_OT_EA%type,
		inuID_PKG_VSI in LDC_FNB_VSI.ID_PKG_VSI%type,
		orcLDC_FNB_VSI  out styLDC_FNB_VSI
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_FNB_VSI  out styLDC_FNB_VSI
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_FNB_VSI;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALDC_FNB_VSI
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_FNB_VSI';
	 cnuGeEntityId constant varchar2(30) := 8915; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuID_PKG_FNB in LDC_FNB_VSI.ID_PKG_FNB%type,
		inuID_OT_EA in LDC_FNB_VSI.ID_OT_EA%type,
		inuID_PKG_VSI in LDC_FNB_VSI.ID_PKG_VSI%type
	)
	IS
		SELECT LDC_FNB_VSI.*,LDC_FNB_VSI.rowid
		FROM LDC_FNB_VSI
		WHERE  ID_PKG_FNB = inuID_PKG_FNB
			and ID_OT_EA = inuID_OT_EA
			and ID_PKG_VSI = inuID_PKG_VSI
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_FNB_VSI.*,LDC_FNB_VSI.rowid
		FROM LDC_FNB_VSI
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_FNB_VSI is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_FNB_VSI;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_FNB_VSI default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.ID_PKG_FNB);
		sbPk:=sbPk||','||ut_convert.fsbToChar(rcI.ID_OT_EA);
		sbPk:=sbPk||','||ut_convert.fsbToChar(rcI.ID_PKG_VSI);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuID_PKG_FNB in LDC_FNB_VSI.ID_PKG_FNB%type,
		inuID_OT_EA in LDC_FNB_VSI.ID_OT_EA%type,
		inuID_PKG_VSI in LDC_FNB_VSI.ID_PKG_VSI%type,
		orcLDC_FNB_VSI  out styLDC_FNB_VSI
	)
	IS
		rcError styLDC_FNB_VSI;
	BEGIN
		rcError.ID_PKG_FNB := inuID_PKG_FNB;
		rcError.ID_OT_EA := inuID_OT_EA;
		rcError.ID_PKG_VSI := inuID_PKG_VSI;

		Open cuLockRcByPk
		(
			inuID_PKG_FNB,
			inuID_OT_EA,
			inuID_PKG_VSI
		);

		fetch cuLockRcByPk into orcLDC_FNB_VSI;
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
		orcLDC_FNB_VSI  out styLDC_FNB_VSI
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_FNB_VSI;
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
		itbLDC_FNB_VSI  in out nocopy tytbLDC_FNB_VSI
	)
	IS
	BEGIN
			rcRecOfTab.ID_PKG_FNB.delete;
			rcRecOfTab.ID_OT_EA.delete;
			rcRecOfTab.ID_PKG_VSI.delete;
			rcRecOfTab.PROCESADO.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_FNB_VSI  in out nocopy tytbLDC_FNB_VSI,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_FNB_VSI);

		for n in itbLDC_FNB_VSI.first .. itbLDC_FNB_VSI.last loop
			rcRecOfTab.ID_PKG_FNB(n) := itbLDC_FNB_VSI(n).ID_PKG_FNB;
			rcRecOfTab.ID_OT_EA(n) := itbLDC_FNB_VSI(n).ID_OT_EA;
			rcRecOfTab.ID_PKG_VSI(n) := itbLDC_FNB_VSI(n).ID_PKG_VSI;
			rcRecOfTab.PROCESADO(n) := itbLDC_FNB_VSI(n).PROCESADO;
			rcRecOfTab.row_id(n) := itbLDC_FNB_VSI(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuID_PKG_FNB in LDC_FNB_VSI.ID_PKG_FNB%type,
		inuID_OT_EA in LDC_FNB_VSI.ID_OT_EA%type,
		inuID_PKG_VSI in LDC_FNB_VSI.ID_PKG_VSI%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuID_PKG_FNB,
			inuID_OT_EA,
			inuID_PKG_VSI
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
		inuID_PKG_FNB in LDC_FNB_VSI.ID_PKG_FNB%type,
		inuID_OT_EA in LDC_FNB_VSI.ID_OT_EA%type,
		inuID_PKG_VSI in LDC_FNB_VSI.ID_PKG_VSI%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuID_PKG_FNB = rcData.ID_PKG_FNB AND
			inuID_OT_EA = rcData.ID_OT_EA AND
			inuID_PKG_VSI = rcData.ID_PKG_VSI
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
		inuID_PKG_FNB in LDC_FNB_VSI.ID_PKG_FNB%type,
		inuID_OT_EA in LDC_FNB_VSI.ID_OT_EA%type,
		inuID_PKG_VSI in LDC_FNB_VSI.ID_PKG_VSI%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuID_PKG_FNB,
			inuID_OT_EA,
			inuID_PKG_VSI
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuID_PKG_FNB in LDC_FNB_VSI.ID_PKG_FNB%type,
		inuID_OT_EA in LDC_FNB_VSI.ID_OT_EA%type,
		inuID_PKG_VSI in LDC_FNB_VSI.ID_PKG_VSI%type
	)
	IS
		rcError styLDC_FNB_VSI;
	BEGIN		rcError.ID_PKG_FNB:=inuID_PKG_FNB;		rcError.ID_OT_EA:=inuID_OT_EA;		rcError.ID_PKG_VSI:=inuID_PKG_VSI;

		Load
		(
			inuID_PKG_FNB,
			inuID_OT_EA,
			inuID_PKG_VSI
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
		inuID_PKG_FNB in LDC_FNB_VSI.ID_PKG_FNB%type,
		inuID_OT_EA in LDC_FNB_VSI.ID_OT_EA%type,
		inuID_PKG_VSI in LDC_FNB_VSI.ID_PKG_VSI%type
	)
	IS
	BEGIN
		Load
		(
			inuID_PKG_FNB,
			inuID_OT_EA,
			inuID_PKG_VSI
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuID_PKG_FNB in LDC_FNB_VSI.ID_PKG_FNB%type,
		inuID_OT_EA in LDC_FNB_VSI.ID_OT_EA%type,
		inuID_PKG_VSI in LDC_FNB_VSI.ID_PKG_VSI%type,
		orcRecord out nocopy styLDC_FNB_VSI
	)
	IS
		rcError styLDC_FNB_VSI;
	BEGIN		rcError.ID_PKG_FNB:=inuID_PKG_FNB;		rcError.ID_OT_EA:=inuID_OT_EA;		rcError.ID_PKG_VSI:=inuID_PKG_VSI;

		Load
		(
			inuID_PKG_FNB,
			inuID_OT_EA,
			inuID_PKG_VSI
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuID_PKG_FNB in LDC_FNB_VSI.ID_PKG_FNB%type,
		inuID_OT_EA in LDC_FNB_VSI.ID_OT_EA%type,
		inuID_PKG_VSI in LDC_FNB_VSI.ID_PKG_VSI%type
	)
	RETURN styLDC_FNB_VSI
	IS
		rcError styLDC_FNB_VSI;
	BEGIN
		rcError.ID_PKG_FNB:=inuID_PKG_FNB;
		rcError.ID_OT_EA:=inuID_OT_EA;
		rcError.ID_PKG_VSI:=inuID_PKG_VSI;

		Load
		(
			inuID_PKG_FNB,
			inuID_OT_EA,
			inuID_PKG_VSI
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuID_PKG_FNB in LDC_FNB_VSI.ID_PKG_FNB%type,
		inuID_OT_EA in LDC_FNB_VSI.ID_OT_EA%type,
		inuID_PKG_VSI in LDC_FNB_VSI.ID_PKG_VSI%type
	)
	RETURN styLDC_FNB_VSI
	IS
		rcError styLDC_FNB_VSI;
	BEGIN
		rcError.ID_PKG_FNB:=inuID_PKG_FNB;
		rcError.ID_OT_EA:=inuID_OT_EA;
		rcError.ID_PKG_VSI:=inuID_PKG_VSI;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuID_PKG_FNB,
			inuID_OT_EA,
			inuID_PKG_VSI
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuID_PKG_FNB,
			inuID_OT_EA,
			inuID_PKG_VSI
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_FNB_VSI
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_FNB_VSI
	)
	IS
		rfLDC_FNB_VSI tyrfLDC_FNB_VSI;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_FNB_VSI.*, LDC_FNB_VSI.rowid FROM LDC_FNB_VSI';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_FNB_VSI for sbFullQuery;

		fetch rfLDC_FNB_VSI bulk collect INTO otbResult;

		close rfLDC_FNB_VSI;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_FNB_VSI.*, LDC_FNB_VSI.rowid FROM LDC_FNB_VSI';
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
		ircLDC_FNB_VSI in styLDC_FNB_VSI
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_FNB_VSI,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_FNB_VSI in styLDC_FNB_VSI,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_FNB_VSI.ID_PKG_FNB is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ID_PKG_FNB');
			raise ex.controlled_error;
		end if;
		if ircLDC_FNB_VSI.ID_OT_EA is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ID_OT_EA');
			raise ex.controlled_error;
		end if;
		if ircLDC_FNB_VSI.ID_PKG_VSI is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ID_PKG_VSI');
			raise ex.controlled_error;
		end if;

		insert into LDC_FNB_VSI
		(
			ID_PKG_FNB,
			ID_OT_EA,
			ID_PKG_VSI,
			PROCESADO
		)
		values
		(
			ircLDC_FNB_VSI.ID_PKG_FNB,
			ircLDC_FNB_VSI.ID_OT_EA,
			ircLDC_FNB_VSI.ID_PKG_VSI,
			ircLDC_FNB_VSI.PROCESADO
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_FNB_VSI));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_FNB_VSI in out nocopy tytbLDC_FNB_VSI
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_FNB_VSI,blUseRowID);
		forall n in iotbLDC_FNB_VSI.first..iotbLDC_FNB_VSI.last
			insert into LDC_FNB_VSI
			(
				ID_PKG_FNB,
				ID_OT_EA,
				ID_PKG_VSI,
				PROCESADO
			)
			values
			(
				rcRecOfTab.ID_PKG_FNB(n),
				rcRecOfTab.ID_OT_EA(n),
				rcRecOfTab.ID_PKG_VSI(n),
				rcRecOfTab.PROCESADO(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuID_PKG_FNB in LDC_FNB_VSI.ID_PKG_FNB%type,
		inuID_OT_EA in LDC_FNB_VSI.ID_OT_EA%type,
		inuID_PKG_VSI in LDC_FNB_VSI.ID_PKG_VSI%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_FNB_VSI;
	BEGIN
		rcError.ID_PKG_FNB := inuID_PKG_FNB;
		rcError.ID_OT_EA := inuID_OT_EA;
		rcError.ID_PKG_VSI := inuID_PKG_VSI;

		if inuLock=1 then
			LockByPk
			(
				inuID_PKG_FNB,
				inuID_OT_EA,
				inuID_PKG_VSI,
				rcData
			);
		end if;


		delete
		from LDC_FNB_VSI
		where
       		ID_PKG_FNB=inuID_PKG_FNB and
       		ID_OT_EA=inuID_OT_EA and
       		ID_PKG_VSI=inuID_PKG_VSI;
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
		rcError  styLDC_FNB_VSI;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_FNB_VSI
		where
			rowid = iriRowID
		returning
			ID_PKG_FNB,
			ID_OT_EA,
			ID_PKG_VSI
		into
			rcError.ID_PKG_FNB,
			rcError.ID_OT_EA,
			rcError.ID_PKG_VSI;
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
		iotbLDC_FNB_VSI in out nocopy tytbLDC_FNB_VSI,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_FNB_VSI;
	BEGIN
		FillRecordOfTables(iotbLDC_FNB_VSI, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_FNB_VSI.first .. iotbLDC_FNB_VSI.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_FNB_VSI.first .. iotbLDC_FNB_VSI.last
				delete
				from LDC_FNB_VSI
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_FNB_VSI.first .. iotbLDC_FNB_VSI.last loop
					LockByPk
					(
						rcRecOfTab.ID_PKG_FNB(n),
						rcRecOfTab.ID_OT_EA(n),
						rcRecOfTab.ID_PKG_VSI(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_FNB_VSI.first .. iotbLDC_FNB_VSI.last
				delete
				from LDC_FNB_VSI
				where
		         	ID_PKG_FNB = rcRecOfTab.ID_PKG_FNB(n) and
		         	ID_OT_EA = rcRecOfTab.ID_OT_EA(n) and
		         	ID_PKG_VSI = rcRecOfTab.ID_PKG_VSI(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_FNB_VSI in styLDC_FNB_VSI,
		inuLock in number default 0
	)
	IS
		nuID_PKG_FNB	LDC_FNB_VSI.ID_PKG_FNB%type;
		nuID_OT_EA	LDC_FNB_VSI.ID_OT_EA%type;
		nuID_PKG_VSI	LDC_FNB_VSI.ID_PKG_VSI%type;
	BEGIN
		if ircLDC_FNB_VSI.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_FNB_VSI.rowid,rcData);
			end if;
			update LDC_FNB_VSI
			set
				PROCESADO = ircLDC_FNB_VSI.PROCESADO
			where
				rowid = ircLDC_FNB_VSI.rowid
			returning
				ID_PKG_FNB,
				ID_OT_EA,
				ID_PKG_VSI
			into
				nuID_PKG_FNB,
				nuID_OT_EA,
				nuID_PKG_VSI;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_FNB_VSI.ID_PKG_FNB,
					ircLDC_FNB_VSI.ID_OT_EA,
					ircLDC_FNB_VSI.ID_PKG_VSI,
					rcData
				);
			end if;

			update LDC_FNB_VSI
			set
				PROCESADO = ircLDC_FNB_VSI.PROCESADO
			where
				ID_PKG_FNB = ircLDC_FNB_VSI.ID_PKG_FNB and
				ID_OT_EA = ircLDC_FNB_VSI.ID_OT_EA and
				ID_PKG_VSI = ircLDC_FNB_VSI.ID_PKG_VSI
			returning
				ID_PKG_FNB,
				ID_OT_EA,
				ID_PKG_VSI
			into
				nuID_PKG_FNB,
				nuID_OT_EA,
				nuID_PKG_VSI;
		end if;
		if
			nuID_PKG_FNB is NULL OR
			nuID_OT_EA is NULL OR
			nuID_PKG_VSI is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_FNB_VSI));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_FNB_VSI in out nocopy tytbLDC_FNB_VSI,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_FNB_VSI;
	BEGIN
		FillRecordOfTables(iotbLDC_FNB_VSI,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_FNB_VSI.first .. iotbLDC_FNB_VSI.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_FNB_VSI.first .. iotbLDC_FNB_VSI.last
				update LDC_FNB_VSI
				set
					PROCESADO = rcRecOfTab.PROCESADO(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_FNB_VSI.first .. iotbLDC_FNB_VSI.last loop
					LockByPk
					(
						rcRecOfTab.ID_PKG_FNB(n),
						rcRecOfTab.ID_OT_EA(n),
						rcRecOfTab.ID_PKG_VSI(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_FNB_VSI.first .. iotbLDC_FNB_VSI.last
				update LDC_FNB_VSI
				SET
					PROCESADO = rcRecOfTab.PROCESADO(n)
				where
					ID_PKG_FNB = rcRecOfTab.ID_PKG_FNB(n) and
					ID_OT_EA = rcRecOfTab.ID_OT_EA(n) and
					ID_PKG_VSI = rcRecOfTab.ID_PKG_VSI(n)
;
		end if;
	END;
	PROCEDURE updPROCESADO
	(
		inuID_PKG_FNB in LDC_FNB_VSI.ID_PKG_FNB%type,
		inuID_OT_EA in LDC_FNB_VSI.ID_OT_EA%type,
		inuID_PKG_VSI in LDC_FNB_VSI.ID_PKG_VSI%type,
		isbPROCESADO$ in LDC_FNB_VSI.PROCESADO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_FNB_VSI;
	BEGIN
		rcError.ID_PKG_FNB := inuID_PKG_FNB;
		rcError.ID_OT_EA := inuID_OT_EA;
		rcError.ID_PKG_VSI := inuID_PKG_VSI;
		if inuLock=1 then
			LockByPk
			(
				inuID_PKG_FNB,
				inuID_OT_EA,
				inuID_PKG_VSI,
				rcData
			);
		end if;

		update LDC_FNB_VSI
		set
			PROCESADO = isbPROCESADO$
		where
			ID_PKG_FNB = inuID_PKG_FNB and
			ID_OT_EA = inuID_OT_EA and
			ID_PKG_VSI = inuID_PKG_VSI;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PROCESADO:= isbPROCESADO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetID_PKG_FNB
	(
		inuID_PKG_FNB in LDC_FNB_VSI.ID_PKG_FNB%type,
		inuID_OT_EA in LDC_FNB_VSI.ID_OT_EA%type,
		inuID_PKG_VSI in LDC_FNB_VSI.ID_PKG_VSI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_FNB_VSI.ID_PKG_FNB%type
	IS
		rcError styLDC_FNB_VSI;
	BEGIN

		rcError.ID_PKG_FNB := inuID_PKG_FNB;
		rcError.ID_OT_EA := inuID_OT_EA;
		rcError.ID_PKG_VSI := inuID_PKG_VSI;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PKG_FNB,
		 		inuID_OT_EA,
		 		inuID_PKG_VSI
			 )
		then
			 return(rcData.ID_PKG_FNB);
		end if;
		Load
		(
		 		inuID_PKG_FNB,
		 		inuID_OT_EA,
		 		inuID_PKG_VSI
		);
		return(rcData.ID_PKG_FNB);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetID_OT_EA
	(
		inuID_PKG_FNB in LDC_FNB_VSI.ID_PKG_FNB%type,
		inuID_OT_EA in LDC_FNB_VSI.ID_OT_EA%type,
		inuID_PKG_VSI in LDC_FNB_VSI.ID_PKG_VSI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_FNB_VSI.ID_OT_EA%type
	IS
		rcError styLDC_FNB_VSI;
	BEGIN

		rcError.ID_PKG_FNB := inuID_PKG_FNB;
		rcError.ID_OT_EA := inuID_OT_EA;
		rcError.ID_PKG_VSI := inuID_PKG_VSI;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PKG_FNB,
		 		inuID_OT_EA,
		 		inuID_PKG_VSI
			 )
		then
			 return(rcData.ID_OT_EA);
		end if;
		Load
		(
		 		inuID_PKG_FNB,
		 		inuID_OT_EA,
		 		inuID_PKG_VSI
		);
		return(rcData.ID_OT_EA);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetID_PKG_VSI
	(
		inuID_PKG_FNB in LDC_FNB_VSI.ID_PKG_FNB%type,
		inuID_OT_EA in LDC_FNB_VSI.ID_OT_EA%type,
		inuID_PKG_VSI in LDC_FNB_VSI.ID_PKG_VSI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_FNB_VSI.ID_PKG_VSI%type
	IS
		rcError styLDC_FNB_VSI;
	BEGIN

		rcError.ID_PKG_FNB := inuID_PKG_FNB;
		rcError.ID_OT_EA := inuID_OT_EA;
		rcError.ID_PKG_VSI := inuID_PKG_VSI;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PKG_FNB,
		 		inuID_OT_EA,
		 		inuID_PKG_VSI
			 )
		then
			 return(rcData.ID_PKG_VSI);
		end if;
		Load
		(
		 		inuID_PKG_FNB,
		 		inuID_OT_EA,
		 		inuID_PKG_VSI
		);
		return(rcData.ID_PKG_VSI);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetPROCESADO
	(
		inuID_PKG_FNB in LDC_FNB_VSI.ID_PKG_FNB%type,
		inuID_OT_EA in LDC_FNB_VSI.ID_OT_EA%type,
		inuID_PKG_VSI in LDC_FNB_VSI.ID_PKG_VSI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_FNB_VSI.PROCESADO%type
	IS
		rcError styLDC_FNB_VSI;
	BEGIN

		rcError.ID_PKG_FNB := inuID_PKG_FNB;
		rcError.ID_OT_EA := inuID_OT_EA;
		rcError.ID_PKG_VSI := inuID_PKG_VSI;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PKG_FNB,
		 		inuID_OT_EA,
		 		inuID_PKG_VSI
			 )
		then
			 return(rcData.PROCESADO);
		end if;
		Load
		(
		 		inuID_PKG_FNB,
		 		inuID_OT_EA,
		 		inuID_PKG_VSI
		);
		return(rcData.PROCESADO);
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
end DALDC_FNB_VSI;
/
PROMPT Otorgando permisos de ejecucion a DALDC_FNB_VSI
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_FNB_VSI', 'ADM_PERSON');
END;
/