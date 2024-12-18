CREATE OR REPLACE PACKAGE ADM_PERSON.DALDC_CONDBLOQASIG
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
		inuBLOQUEOM_ID in LDC_CONDBLOQASIG.BLOQUEOM_ID%type
	)
	IS
		SELECT LDC_CONDBLOQASIG.*,LDC_CONDBLOQASIG.rowid
		FROM LDC_CONDBLOQASIG
		WHERE
		    BLOQUEOM_ID = inuBLOQUEOM_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_CONDBLOQASIG.*,LDC_CONDBLOQASIG.rowid
		FROM LDC_CONDBLOQASIG
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_CONDBLOQASIG  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_CONDBLOQASIG is table of styLDC_CONDBLOQASIG index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_CONDBLOQASIG;

	/* Tipos referenciando al registro */
	type tytbBLOQUEOM_ID is table of LDC_CONDBLOQASIG.BLOQUEOM_ID%type index by binary_integer;
	type tytbOPERATING_UNIT_ID is table of LDC_CONDBLOQASIG.OPERATING_UNIT_ID%type index by binary_integer;
	type tytbTASK_TYPE_ID is table of LDC_CONDBLOQASIG.TASK_TYPE_ID%type index by binary_integer;
	type tytbACTIVITY_ID is table of LDC_CONDBLOQASIG.ACTIVITY_ID%type index by binary_integer;
	type tytbNUMDIAS is table of LDC_CONDBLOQASIG.NUMDIAS%type index by binary_integer;
	type tytbCANT_OT is table of LDC_CONDBLOQASIG.CANT_OT%type index by binary_integer;
	type tytbFECHAREG is table of LDC_CONDBLOQASIG.FECHAREG%type index by binary_integer;
	type tytbESACTIVA is table of LDC_CONDBLOQASIG.ESACTIVA%type index by binary_integer;
	type tytbUSUARIO is table of LDC_CONDBLOQASIG.USUARIO%type index by binary_integer;
	type tytbTERMINAL is table of LDC_CONDBLOQASIG.TERMINAL%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_CONDBLOQASIG is record
	(
		BLOQUEOM_ID   tytbBLOQUEOM_ID,
		OPERATING_UNIT_ID   tytbOPERATING_UNIT_ID,
		TASK_TYPE_ID   tytbTASK_TYPE_ID,
		ACTIVITY_ID   tytbACTIVITY_ID,
		NUMDIAS   tytbNUMDIAS,
		CANT_OT   tytbCANT_OT,
		FECHAREG   tytbFECHAREG,
		ESACTIVA   tytbESACTIVA,
		USUARIO   tytbUSUARIO,
		TERMINAL   tytbTERMINAL,
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
		inuBLOQUEOM_ID in LDC_CONDBLOQASIG.BLOQUEOM_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuBLOQUEOM_ID in LDC_CONDBLOQASIG.BLOQUEOM_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuBLOQUEOM_ID in LDC_CONDBLOQASIG.BLOQUEOM_ID%type
	);

	PROCEDURE getRecord
	(
		inuBLOQUEOM_ID in LDC_CONDBLOQASIG.BLOQUEOM_ID%type,
		orcRecord out nocopy styLDC_CONDBLOQASIG
	);

	FUNCTION frcGetRcData
	(
		inuBLOQUEOM_ID in LDC_CONDBLOQASIG.BLOQUEOM_ID%type
	)
	RETURN styLDC_CONDBLOQASIG;

	FUNCTION frcGetRcData
	RETURN styLDC_CONDBLOQASIG;

	FUNCTION frcGetRecord
	(
		inuBLOQUEOM_ID in LDC_CONDBLOQASIG.BLOQUEOM_ID%type
	)
	RETURN styLDC_CONDBLOQASIG;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_CONDBLOQASIG
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_CONDBLOQASIG in styLDC_CONDBLOQASIG
	);

	PROCEDURE insRecord
	(
		ircLDC_CONDBLOQASIG in styLDC_CONDBLOQASIG,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_CONDBLOQASIG in out nocopy tytbLDC_CONDBLOQASIG
	);

	PROCEDURE delRecord
	(
		inuBLOQUEOM_ID in LDC_CONDBLOQASIG.BLOQUEOM_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_CONDBLOQASIG in out nocopy tytbLDC_CONDBLOQASIG,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_CONDBLOQASIG in styLDC_CONDBLOQASIG,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_CONDBLOQASIG in out nocopy tytbLDC_CONDBLOQASIG,
		inuLock in number default 1
	);

	PROCEDURE updOPERATING_UNIT_ID
	(
		inuBLOQUEOM_ID in LDC_CONDBLOQASIG.BLOQUEOM_ID%type,
		inuOPERATING_UNIT_ID$ in LDC_CONDBLOQASIG.OPERATING_UNIT_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updTASK_TYPE_ID
	(
		inuBLOQUEOM_ID in LDC_CONDBLOQASIG.BLOQUEOM_ID%type,
		inuTASK_TYPE_ID$ in LDC_CONDBLOQASIG.TASK_TYPE_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updACTIVITY_ID
	(
		inuBLOQUEOM_ID in LDC_CONDBLOQASIG.BLOQUEOM_ID%type,
		inuACTIVITY_ID$ in LDC_CONDBLOQASIG.ACTIVITY_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updNUMDIAS
	(
		inuBLOQUEOM_ID in LDC_CONDBLOQASIG.BLOQUEOM_ID%type,
		inuNUMDIAS$ in LDC_CONDBLOQASIG.NUMDIAS%type,
		inuLock in number default 0
	);

	PROCEDURE updCANT_OT
	(
		inuBLOQUEOM_ID in LDC_CONDBLOQASIG.BLOQUEOM_ID%type,
		inuCANT_OT$ in LDC_CONDBLOQASIG.CANT_OT%type,
		inuLock in number default 0
	);

	PROCEDURE updFECHAREG
	(
		inuBLOQUEOM_ID in LDC_CONDBLOQASIG.BLOQUEOM_ID%type,
		idtFECHAREG$ in LDC_CONDBLOQASIG.FECHAREG%type,
		inuLock in number default 0
	);

	PROCEDURE updESACTIVA
	(
		inuBLOQUEOM_ID in LDC_CONDBLOQASIG.BLOQUEOM_ID%type,
		isbESACTIVA$ in LDC_CONDBLOQASIG.ESACTIVA%type,
		inuLock in number default 0
	);

	PROCEDURE updUSUARIO
	(
		inuBLOQUEOM_ID in LDC_CONDBLOQASIG.BLOQUEOM_ID%type,
		isbUSUARIO$ in LDC_CONDBLOQASIG.USUARIO%type,
		inuLock in number default 0
	);

	PROCEDURE updTERMINAL
	(
		inuBLOQUEOM_ID in LDC_CONDBLOQASIG.BLOQUEOM_ID%type,
		isbTERMINAL$ in LDC_CONDBLOQASIG.TERMINAL%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetBLOQUEOM_ID
	(
		inuBLOQUEOM_ID in LDC_CONDBLOQASIG.BLOQUEOM_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONDBLOQASIG.BLOQUEOM_ID%type;

	FUNCTION fnuGetOPERATING_UNIT_ID
	(
		inuBLOQUEOM_ID in LDC_CONDBLOQASIG.BLOQUEOM_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONDBLOQASIG.OPERATING_UNIT_ID%type;

	FUNCTION fnuGetTASK_TYPE_ID
	(
		inuBLOQUEOM_ID in LDC_CONDBLOQASIG.BLOQUEOM_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONDBLOQASIG.TASK_TYPE_ID%type;

	FUNCTION fnuGetACTIVITY_ID
	(
		inuBLOQUEOM_ID in LDC_CONDBLOQASIG.BLOQUEOM_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONDBLOQASIG.ACTIVITY_ID%type;

	FUNCTION fnuGetNUMDIAS
	(
		inuBLOQUEOM_ID in LDC_CONDBLOQASIG.BLOQUEOM_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONDBLOQASIG.NUMDIAS%type;

	FUNCTION fnuGetCANT_OT
	(
		inuBLOQUEOM_ID in LDC_CONDBLOQASIG.BLOQUEOM_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONDBLOQASIG.CANT_OT%type;

	FUNCTION fdtGetFECHAREG
	(
		inuBLOQUEOM_ID in LDC_CONDBLOQASIG.BLOQUEOM_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONDBLOQASIG.FECHAREG%type;

	FUNCTION fsbGetESACTIVA
	(
		inuBLOQUEOM_ID in LDC_CONDBLOQASIG.BLOQUEOM_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONDBLOQASIG.ESACTIVA%type;

	FUNCTION fsbGetUSUARIO
	(
		inuBLOQUEOM_ID in LDC_CONDBLOQASIG.BLOQUEOM_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONDBLOQASIG.USUARIO%type;

	FUNCTION fsbGetTERMINAL
	(
		inuBLOQUEOM_ID in LDC_CONDBLOQASIG.BLOQUEOM_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONDBLOQASIG.TERMINAL%type;


	PROCEDURE LockByPk
	(
		inuBLOQUEOM_ID in LDC_CONDBLOQASIG.BLOQUEOM_ID%type,
		orcLDC_CONDBLOQASIG  out styLDC_CONDBLOQASIG
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_CONDBLOQASIG  out styLDC_CONDBLOQASIG
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_CONDBLOQASIG;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALDC_CONDBLOQASIG
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_CONDBLOQASIG';
	 cnuGeEntityId constant varchar2(30) := 2849; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuBLOQUEOM_ID in LDC_CONDBLOQASIG.BLOQUEOM_ID%type
	)
	IS
		SELECT LDC_CONDBLOQASIG.*,LDC_CONDBLOQASIG.rowid
		FROM LDC_CONDBLOQASIG
		WHERE  BLOQUEOM_ID = inuBLOQUEOM_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_CONDBLOQASIG.*,LDC_CONDBLOQASIG.rowid
		FROM LDC_CONDBLOQASIG
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_CONDBLOQASIG is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_CONDBLOQASIG;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_CONDBLOQASIG default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.BLOQUEOM_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuBLOQUEOM_ID in LDC_CONDBLOQASIG.BLOQUEOM_ID%type,
		orcLDC_CONDBLOQASIG  out styLDC_CONDBLOQASIG
	)
	IS
		rcError styLDC_CONDBLOQASIG;
	BEGIN
		rcError.BLOQUEOM_ID := inuBLOQUEOM_ID;

		Open cuLockRcByPk
		(
			inuBLOQUEOM_ID
		);

		fetch cuLockRcByPk into orcLDC_CONDBLOQASIG;
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
		orcLDC_CONDBLOQASIG  out styLDC_CONDBLOQASIG
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_CONDBLOQASIG;
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
		itbLDC_CONDBLOQASIG  in out nocopy tytbLDC_CONDBLOQASIG
	)
	IS
	BEGIN
			rcRecOfTab.BLOQUEOM_ID.delete;
			rcRecOfTab.OPERATING_UNIT_ID.delete;
			rcRecOfTab.TASK_TYPE_ID.delete;
			rcRecOfTab.ACTIVITY_ID.delete;
			rcRecOfTab.NUMDIAS.delete;
			rcRecOfTab.CANT_OT.delete;
			rcRecOfTab.FECHAREG.delete;
			rcRecOfTab.ESACTIVA.delete;
			rcRecOfTab.USUARIO.delete;
			rcRecOfTab.TERMINAL.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_CONDBLOQASIG  in out nocopy tytbLDC_CONDBLOQASIG,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_CONDBLOQASIG);

		for n in itbLDC_CONDBLOQASIG.first .. itbLDC_CONDBLOQASIG.last loop
			rcRecOfTab.BLOQUEOM_ID(n) := itbLDC_CONDBLOQASIG(n).BLOQUEOM_ID;
			rcRecOfTab.OPERATING_UNIT_ID(n) := itbLDC_CONDBLOQASIG(n).OPERATING_UNIT_ID;
			rcRecOfTab.TASK_TYPE_ID(n) := itbLDC_CONDBLOQASIG(n).TASK_TYPE_ID;
			rcRecOfTab.ACTIVITY_ID(n) := itbLDC_CONDBLOQASIG(n).ACTIVITY_ID;
			rcRecOfTab.NUMDIAS(n) := itbLDC_CONDBLOQASIG(n).NUMDIAS;
			rcRecOfTab.CANT_OT(n) := itbLDC_CONDBLOQASIG(n).CANT_OT;
			rcRecOfTab.FECHAREG(n) := itbLDC_CONDBLOQASIG(n).FECHAREG;
			rcRecOfTab.ESACTIVA(n) := itbLDC_CONDBLOQASIG(n).ESACTIVA;
			rcRecOfTab.USUARIO(n) := itbLDC_CONDBLOQASIG(n).USUARIO;
			rcRecOfTab.TERMINAL(n) := itbLDC_CONDBLOQASIG(n).TERMINAL;
			rcRecOfTab.row_id(n) := itbLDC_CONDBLOQASIG(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuBLOQUEOM_ID in LDC_CONDBLOQASIG.BLOQUEOM_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuBLOQUEOM_ID
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
		inuBLOQUEOM_ID in LDC_CONDBLOQASIG.BLOQUEOM_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuBLOQUEOM_ID = rcData.BLOQUEOM_ID
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
		inuBLOQUEOM_ID in LDC_CONDBLOQASIG.BLOQUEOM_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuBLOQUEOM_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuBLOQUEOM_ID in LDC_CONDBLOQASIG.BLOQUEOM_ID%type
	)
	IS
		rcError styLDC_CONDBLOQASIG;
	BEGIN		rcError.BLOQUEOM_ID:=inuBLOQUEOM_ID;

		Load
		(
			inuBLOQUEOM_ID
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
		inuBLOQUEOM_ID in LDC_CONDBLOQASIG.BLOQUEOM_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuBLOQUEOM_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuBLOQUEOM_ID in LDC_CONDBLOQASIG.BLOQUEOM_ID%type,
		orcRecord out nocopy styLDC_CONDBLOQASIG
	)
	IS
		rcError styLDC_CONDBLOQASIG;
	BEGIN		rcError.BLOQUEOM_ID:=inuBLOQUEOM_ID;

		Load
		(
			inuBLOQUEOM_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuBLOQUEOM_ID in LDC_CONDBLOQASIG.BLOQUEOM_ID%type
	)
	RETURN styLDC_CONDBLOQASIG
	IS
		rcError styLDC_CONDBLOQASIG;
	BEGIN
		rcError.BLOQUEOM_ID:=inuBLOQUEOM_ID;

		Load
		(
			inuBLOQUEOM_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuBLOQUEOM_ID in LDC_CONDBLOQASIG.BLOQUEOM_ID%type
	)
	RETURN styLDC_CONDBLOQASIG
	IS
		rcError styLDC_CONDBLOQASIG;
	BEGIN
		rcError.BLOQUEOM_ID:=inuBLOQUEOM_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuBLOQUEOM_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuBLOQUEOM_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_CONDBLOQASIG
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_CONDBLOQASIG
	)
	IS
		rfLDC_CONDBLOQASIG tyrfLDC_CONDBLOQASIG;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_CONDBLOQASIG.*, LDC_CONDBLOQASIG.rowid FROM LDC_CONDBLOQASIG';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_CONDBLOQASIG for sbFullQuery;

		fetch rfLDC_CONDBLOQASIG bulk collect INTO otbResult;

		close rfLDC_CONDBLOQASIG;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_CONDBLOQASIG.*, LDC_CONDBLOQASIG.rowid FROM LDC_CONDBLOQASIG';
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
		ircLDC_CONDBLOQASIG in styLDC_CONDBLOQASIG
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_CONDBLOQASIG,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_CONDBLOQASIG in styLDC_CONDBLOQASIG,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_CONDBLOQASIG.BLOQUEOM_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|BLOQUEOM_ID');
			raise ex.controlled_error;
		end if;

		insert into LDC_CONDBLOQASIG
		(
			BLOQUEOM_ID,
			OPERATING_UNIT_ID,
			TASK_TYPE_ID,
			ACTIVITY_ID,
			NUMDIAS,
			CANT_OT,
			FECHAREG,
			ESACTIVA,
			USUARIO,
			TERMINAL
		)
		values
		(
			ircLDC_CONDBLOQASIG.BLOQUEOM_ID,
			ircLDC_CONDBLOQASIG.OPERATING_UNIT_ID,
			ircLDC_CONDBLOQASIG.TASK_TYPE_ID,
			ircLDC_CONDBLOQASIG.ACTIVITY_ID,
			ircLDC_CONDBLOQASIG.NUMDIAS,
			ircLDC_CONDBLOQASIG.CANT_OT,
			ircLDC_CONDBLOQASIG.FECHAREG,
			ircLDC_CONDBLOQASIG.ESACTIVA,
			ircLDC_CONDBLOQASIG.USUARIO,
			ircLDC_CONDBLOQASIG.TERMINAL
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_CONDBLOQASIG));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_CONDBLOQASIG in out nocopy tytbLDC_CONDBLOQASIG
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_CONDBLOQASIG,blUseRowID);
		forall n in iotbLDC_CONDBLOQASIG.first..iotbLDC_CONDBLOQASIG.last
			insert into LDC_CONDBLOQASIG
			(
				BLOQUEOM_ID,
				OPERATING_UNIT_ID,
				TASK_TYPE_ID,
				ACTIVITY_ID,
				NUMDIAS,
				CANT_OT,
				FECHAREG,
				ESACTIVA,
				USUARIO,
				TERMINAL
			)
			values
			(
				rcRecOfTab.BLOQUEOM_ID(n),
				rcRecOfTab.OPERATING_UNIT_ID(n),
				rcRecOfTab.TASK_TYPE_ID(n),
				rcRecOfTab.ACTIVITY_ID(n),
				rcRecOfTab.NUMDIAS(n),
				rcRecOfTab.CANT_OT(n),
				rcRecOfTab.FECHAREG(n),
				rcRecOfTab.ESACTIVA(n),
				rcRecOfTab.USUARIO(n),
				rcRecOfTab.TERMINAL(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuBLOQUEOM_ID in LDC_CONDBLOQASIG.BLOQUEOM_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_CONDBLOQASIG;
	BEGIN
		rcError.BLOQUEOM_ID := inuBLOQUEOM_ID;

		if inuLock=1 then
			LockByPk
			(
				inuBLOQUEOM_ID,
				rcData
			);
		end if;


		delete
		from LDC_CONDBLOQASIG
		where
       		BLOQUEOM_ID=inuBLOQUEOM_ID;
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
		rcError  styLDC_CONDBLOQASIG;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_CONDBLOQASIG
		where
			rowid = iriRowID
		returning
			BLOQUEOM_ID
		into
			rcError.BLOQUEOM_ID;
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
		iotbLDC_CONDBLOQASIG in out nocopy tytbLDC_CONDBLOQASIG,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_CONDBLOQASIG;
	BEGIN
		FillRecordOfTables(iotbLDC_CONDBLOQASIG, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_CONDBLOQASIG.first .. iotbLDC_CONDBLOQASIG.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CONDBLOQASIG.first .. iotbLDC_CONDBLOQASIG.last
				delete
				from LDC_CONDBLOQASIG
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_CONDBLOQASIG.first .. iotbLDC_CONDBLOQASIG.last loop
					LockByPk
					(
						rcRecOfTab.BLOQUEOM_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CONDBLOQASIG.first .. iotbLDC_CONDBLOQASIG.last
				delete
				from LDC_CONDBLOQASIG
				where
		         	BLOQUEOM_ID = rcRecOfTab.BLOQUEOM_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_CONDBLOQASIG in styLDC_CONDBLOQASIG,
		inuLock in number default 0
	)
	IS
		nuBLOQUEOM_ID	LDC_CONDBLOQASIG.BLOQUEOM_ID%type;
	BEGIN
		if ircLDC_CONDBLOQASIG.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_CONDBLOQASIG.rowid,rcData);
			end if;
			update LDC_CONDBLOQASIG
			set
				OPERATING_UNIT_ID = ircLDC_CONDBLOQASIG.OPERATING_UNIT_ID,
				TASK_TYPE_ID = ircLDC_CONDBLOQASIG.TASK_TYPE_ID,
				ACTIVITY_ID = ircLDC_CONDBLOQASIG.ACTIVITY_ID,
				NUMDIAS = ircLDC_CONDBLOQASIG.NUMDIAS,
				CANT_OT = ircLDC_CONDBLOQASIG.CANT_OT,
				FECHAREG = ircLDC_CONDBLOQASIG.FECHAREG,
				ESACTIVA = ircLDC_CONDBLOQASIG.ESACTIVA,
				USUARIO = ircLDC_CONDBLOQASIG.USUARIO,
				TERMINAL = ircLDC_CONDBLOQASIG.TERMINAL
			where
				rowid = ircLDC_CONDBLOQASIG.rowid
			returning
				BLOQUEOM_ID
			into
				nuBLOQUEOM_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_CONDBLOQASIG.BLOQUEOM_ID,
					rcData
				);
			end if;

			update LDC_CONDBLOQASIG
			set
				OPERATING_UNIT_ID = ircLDC_CONDBLOQASIG.OPERATING_UNIT_ID,
				TASK_TYPE_ID = ircLDC_CONDBLOQASIG.TASK_TYPE_ID,
				ACTIVITY_ID = ircLDC_CONDBLOQASIG.ACTIVITY_ID,
				NUMDIAS = ircLDC_CONDBLOQASIG.NUMDIAS,
				CANT_OT = ircLDC_CONDBLOQASIG.CANT_OT,
				FECHAREG = ircLDC_CONDBLOQASIG.FECHAREG,
				ESACTIVA = ircLDC_CONDBLOQASIG.ESACTIVA,
				USUARIO = ircLDC_CONDBLOQASIG.USUARIO,
				TERMINAL = ircLDC_CONDBLOQASIG.TERMINAL
			where
				BLOQUEOM_ID = ircLDC_CONDBLOQASIG.BLOQUEOM_ID
			returning
				BLOQUEOM_ID
			into
				nuBLOQUEOM_ID;
		end if;
		if
			nuBLOQUEOM_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_CONDBLOQASIG));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_CONDBLOQASIG in out nocopy tytbLDC_CONDBLOQASIG,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_CONDBLOQASIG;
	BEGIN
		FillRecordOfTables(iotbLDC_CONDBLOQASIG,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_CONDBLOQASIG.first .. iotbLDC_CONDBLOQASIG.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CONDBLOQASIG.first .. iotbLDC_CONDBLOQASIG.last
				update LDC_CONDBLOQASIG
				set
					OPERATING_UNIT_ID = rcRecOfTab.OPERATING_UNIT_ID(n),
					TASK_TYPE_ID = rcRecOfTab.TASK_TYPE_ID(n),
					ACTIVITY_ID = rcRecOfTab.ACTIVITY_ID(n),
					NUMDIAS = rcRecOfTab.NUMDIAS(n),
					CANT_OT = rcRecOfTab.CANT_OT(n),
					FECHAREG = rcRecOfTab.FECHAREG(n),
					ESACTIVA = rcRecOfTab.ESACTIVA(n),
					USUARIO = rcRecOfTab.USUARIO(n),
					TERMINAL = rcRecOfTab.TERMINAL(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_CONDBLOQASIG.first .. iotbLDC_CONDBLOQASIG.last loop
					LockByPk
					(
						rcRecOfTab.BLOQUEOM_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CONDBLOQASIG.first .. iotbLDC_CONDBLOQASIG.last
				update LDC_CONDBLOQASIG
				SET
					OPERATING_UNIT_ID = rcRecOfTab.OPERATING_UNIT_ID(n),
					TASK_TYPE_ID = rcRecOfTab.TASK_TYPE_ID(n),
					ACTIVITY_ID = rcRecOfTab.ACTIVITY_ID(n),
					NUMDIAS = rcRecOfTab.NUMDIAS(n),
					CANT_OT = rcRecOfTab.CANT_OT(n),
					FECHAREG = rcRecOfTab.FECHAREG(n),
					ESACTIVA = rcRecOfTab.ESACTIVA(n),
					USUARIO = rcRecOfTab.USUARIO(n),
					TERMINAL = rcRecOfTab.TERMINAL(n)
				where
					BLOQUEOM_ID = rcRecOfTab.BLOQUEOM_ID(n)
;
		end if;
	END;
	PROCEDURE updOPERATING_UNIT_ID
	(
		inuBLOQUEOM_ID in LDC_CONDBLOQASIG.BLOQUEOM_ID%type,
		inuOPERATING_UNIT_ID$ in LDC_CONDBLOQASIG.OPERATING_UNIT_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CONDBLOQASIG;
	BEGIN
		rcError.BLOQUEOM_ID := inuBLOQUEOM_ID;
		if inuLock=1 then
			LockByPk
			(
				inuBLOQUEOM_ID,
				rcData
			);
		end if;

		update LDC_CONDBLOQASIG
		set
			OPERATING_UNIT_ID = inuOPERATING_UNIT_ID$
		where
			BLOQUEOM_ID = inuBLOQUEOM_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.OPERATING_UNIT_ID:= inuOPERATING_UNIT_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updTASK_TYPE_ID
	(
		inuBLOQUEOM_ID in LDC_CONDBLOQASIG.BLOQUEOM_ID%type,
		inuTASK_TYPE_ID$ in LDC_CONDBLOQASIG.TASK_TYPE_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CONDBLOQASIG;
	BEGIN
		rcError.BLOQUEOM_ID := inuBLOQUEOM_ID;
		if inuLock=1 then
			LockByPk
			(
				inuBLOQUEOM_ID,
				rcData
			);
		end if;

		update LDC_CONDBLOQASIG
		set
			TASK_TYPE_ID = inuTASK_TYPE_ID$
		where
			BLOQUEOM_ID = inuBLOQUEOM_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TASK_TYPE_ID:= inuTASK_TYPE_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updACTIVITY_ID
	(
		inuBLOQUEOM_ID in LDC_CONDBLOQASIG.BLOQUEOM_ID%type,
		inuACTIVITY_ID$ in LDC_CONDBLOQASIG.ACTIVITY_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CONDBLOQASIG;
	BEGIN
		rcError.BLOQUEOM_ID := inuBLOQUEOM_ID;
		if inuLock=1 then
			LockByPk
			(
				inuBLOQUEOM_ID,
				rcData
			);
		end if;

		update LDC_CONDBLOQASIG
		set
			ACTIVITY_ID = inuACTIVITY_ID$
		where
			BLOQUEOM_ID = inuBLOQUEOM_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ACTIVITY_ID:= inuACTIVITY_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updNUMDIAS
	(
		inuBLOQUEOM_ID in LDC_CONDBLOQASIG.BLOQUEOM_ID%type,
		inuNUMDIAS$ in LDC_CONDBLOQASIG.NUMDIAS%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CONDBLOQASIG;
	BEGIN
		rcError.BLOQUEOM_ID := inuBLOQUEOM_ID;
		if inuLock=1 then
			LockByPk
			(
				inuBLOQUEOM_ID,
				rcData
			);
		end if;

		update LDC_CONDBLOQASIG
		set
			NUMDIAS = inuNUMDIAS$
		where
			BLOQUEOM_ID = inuBLOQUEOM_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.NUMDIAS:= inuNUMDIAS$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCANT_OT
	(
		inuBLOQUEOM_ID in LDC_CONDBLOQASIG.BLOQUEOM_ID%type,
		inuCANT_OT$ in LDC_CONDBLOQASIG.CANT_OT%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CONDBLOQASIG;
	BEGIN
		rcError.BLOQUEOM_ID := inuBLOQUEOM_ID;
		if inuLock=1 then
			LockByPk
			(
				inuBLOQUEOM_ID,
				rcData
			);
		end if;

		update LDC_CONDBLOQASIG
		set
			CANT_OT = inuCANT_OT$
		where
			BLOQUEOM_ID = inuBLOQUEOM_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CANT_OT:= inuCANT_OT$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFECHAREG
	(
		inuBLOQUEOM_ID in LDC_CONDBLOQASIG.BLOQUEOM_ID%type,
		idtFECHAREG$ in LDC_CONDBLOQASIG.FECHAREG%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CONDBLOQASIG;
	BEGIN
		rcError.BLOQUEOM_ID := inuBLOQUEOM_ID;
		if inuLock=1 then
			LockByPk
			(
				inuBLOQUEOM_ID,
				rcData
			);
		end if;

		update LDC_CONDBLOQASIG
		set
			FECHAREG = idtFECHAREG$
		where
			BLOQUEOM_ID = inuBLOQUEOM_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FECHAREG:= idtFECHAREG$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updESACTIVA
	(
		inuBLOQUEOM_ID in LDC_CONDBLOQASIG.BLOQUEOM_ID%type,
		isbESACTIVA$ in LDC_CONDBLOQASIG.ESACTIVA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CONDBLOQASIG;
	BEGIN
		rcError.BLOQUEOM_ID := inuBLOQUEOM_ID;
		if inuLock=1 then
			LockByPk
			(
				inuBLOQUEOM_ID,
				rcData
			);
		end if;

		update LDC_CONDBLOQASIG
		set
			ESACTIVA = isbESACTIVA$
		where
			BLOQUEOM_ID = inuBLOQUEOM_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ESACTIVA:= isbESACTIVA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updUSUARIO
	(
		inuBLOQUEOM_ID in LDC_CONDBLOQASIG.BLOQUEOM_ID%type,
		isbUSUARIO$ in LDC_CONDBLOQASIG.USUARIO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CONDBLOQASIG;
	BEGIN
		rcError.BLOQUEOM_ID := inuBLOQUEOM_ID;
		if inuLock=1 then
			LockByPk
			(
				inuBLOQUEOM_ID,
				rcData
			);
		end if;

		update LDC_CONDBLOQASIG
		set
			USUARIO = isbUSUARIO$
		where
			BLOQUEOM_ID = inuBLOQUEOM_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.USUARIO:= isbUSUARIO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updTERMINAL
	(
		inuBLOQUEOM_ID in LDC_CONDBLOQASIG.BLOQUEOM_ID%type,
		isbTERMINAL$ in LDC_CONDBLOQASIG.TERMINAL%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CONDBLOQASIG;
	BEGIN
		rcError.BLOQUEOM_ID := inuBLOQUEOM_ID;
		if inuLock=1 then
			LockByPk
			(
				inuBLOQUEOM_ID,
				rcData
			);
		end if;

		update LDC_CONDBLOQASIG
		set
			TERMINAL = isbTERMINAL$
		where
			BLOQUEOM_ID = inuBLOQUEOM_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TERMINAL:= isbTERMINAL$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetBLOQUEOM_ID
	(
		inuBLOQUEOM_ID in LDC_CONDBLOQASIG.BLOQUEOM_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONDBLOQASIG.BLOQUEOM_ID%type
	IS
		rcError styLDC_CONDBLOQASIG;
	BEGIN

		rcError.BLOQUEOM_ID := inuBLOQUEOM_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuBLOQUEOM_ID
			 )
		then
			 return(rcData.BLOQUEOM_ID);
		end if;
		Load
		(
		 		inuBLOQUEOM_ID
		);
		return(rcData.BLOQUEOM_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetOPERATING_UNIT_ID
	(
		inuBLOQUEOM_ID in LDC_CONDBLOQASIG.BLOQUEOM_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONDBLOQASIG.OPERATING_UNIT_ID%type
	IS
		rcError styLDC_CONDBLOQASIG;
	BEGIN

		rcError.BLOQUEOM_ID := inuBLOQUEOM_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuBLOQUEOM_ID
			 )
		then
			 return(rcData.OPERATING_UNIT_ID);
		end if;
		Load
		(
		 		inuBLOQUEOM_ID
		);
		return(rcData.OPERATING_UNIT_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetTASK_TYPE_ID
	(
		inuBLOQUEOM_ID in LDC_CONDBLOQASIG.BLOQUEOM_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONDBLOQASIG.TASK_TYPE_ID%type
	IS
		rcError styLDC_CONDBLOQASIG;
	BEGIN

		rcError.BLOQUEOM_ID := inuBLOQUEOM_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuBLOQUEOM_ID
			 )
		then
			 return(rcData.TASK_TYPE_ID);
		end if;
		Load
		(
		 		inuBLOQUEOM_ID
		);
		return(rcData.TASK_TYPE_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetACTIVITY_ID
	(
		inuBLOQUEOM_ID in LDC_CONDBLOQASIG.BLOQUEOM_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONDBLOQASIG.ACTIVITY_ID%type
	IS
		rcError styLDC_CONDBLOQASIG;
	BEGIN

		rcError.BLOQUEOM_ID := inuBLOQUEOM_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuBLOQUEOM_ID
			 )
		then
			 return(rcData.ACTIVITY_ID);
		end if;
		Load
		(
		 		inuBLOQUEOM_ID
		);
		return(rcData.ACTIVITY_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetNUMDIAS
	(
		inuBLOQUEOM_ID in LDC_CONDBLOQASIG.BLOQUEOM_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONDBLOQASIG.NUMDIAS%type
	IS
		rcError styLDC_CONDBLOQASIG;
	BEGIN

		rcError.BLOQUEOM_ID := inuBLOQUEOM_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuBLOQUEOM_ID
			 )
		then
			 return(rcData.NUMDIAS);
		end if;
		Load
		(
		 		inuBLOQUEOM_ID
		);
		return(rcData.NUMDIAS);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCANT_OT
	(
		inuBLOQUEOM_ID in LDC_CONDBLOQASIG.BLOQUEOM_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONDBLOQASIG.CANT_OT%type
	IS
		rcError styLDC_CONDBLOQASIG;
	BEGIN

		rcError.BLOQUEOM_ID := inuBLOQUEOM_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuBLOQUEOM_ID
			 )
		then
			 return(rcData.CANT_OT);
		end if;
		Load
		(
		 		inuBLOQUEOM_ID
		);
		return(rcData.CANT_OT);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetFECHAREG
	(
		inuBLOQUEOM_ID in LDC_CONDBLOQASIG.BLOQUEOM_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONDBLOQASIG.FECHAREG%type
	IS
		rcError styLDC_CONDBLOQASIG;
	BEGIN

		rcError.BLOQUEOM_ID := inuBLOQUEOM_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuBLOQUEOM_ID
			 )
		then
			 return(rcData.FECHAREG);
		end if;
		Load
		(
		 		inuBLOQUEOM_ID
		);
		return(rcData.FECHAREG);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetESACTIVA
	(
		inuBLOQUEOM_ID in LDC_CONDBLOQASIG.BLOQUEOM_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONDBLOQASIG.ESACTIVA%type
	IS
		rcError styLDC_CONDBLOQASIG;
	BEGIN

		rcError.BLOQUEOM_ID := inuBLOQUEOM_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuBLOQUEOM_ID
			 )
		then
			 return(rcData.ESACTIVA);
		end if;
		Load
		(
		 		inuBLOQUEOM_ID
		);
		return(rcData.ESACTIVA);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetUSUARIO
	(
		inuBLOQUEOM_ID in LDC_CONDBLOQASIG.BLOQUEOM_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONDBLOQASIG.USUARIO%type
	IS
		rcError styLDC_CONDBLOQASIG;
	BEGIN

		rcError.BLOQUEOM_ID := inuBLOQUEOM_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuBLOQUEOM_ID
			 )
		then
			 return(rcData.USUARIO);
		end if;
		Load
		(
		 		inuBLOQUEOM_ID
		);
		return(rcData.USUARIO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetTERMINAL
	(
		inuBLOQUEOM_ID in LDC_CONDBLOQASIG.BLOQUEOM_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONDBLOQASIG.TERMINAL%type
	IS
		rcError styLDC_CONDBLOQASIG;
	BEGIN

		rcError.BLOQUEOM_ID := inuBLOQUEOM_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuBLOQUEOM_ID
			 )
		then
			 return(rcData.TERMINAL);
		end if;
		Load
		(
		 		inuBLOQUEOM_ID
		);
		return(rcData.TERMINAL);
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
end DALDC_CONDBLOQASIG;
/
PROMPT Otorgando permisos de ejecucion a DALDC_CONDBLOQASIG
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_CONDBLOQASIG', 'ADM_PERSON');
END;
/