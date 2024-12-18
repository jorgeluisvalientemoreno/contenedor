CREATE OR REPLACE PACKAGE ADM_PERSON.DALDC_ATTRADDACCOUNTSENTITY
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
		inuATTRADDACCOUNTSENTITY_ID in LDC_ATTRADDACCOUNTSENTITY.ATTRADDACCOUNTSENTITY_ID%type
	)
	IS
		SELECT LDC_ATTRADDACCOUNTSENTITY.*,LDC_ATTRADDACCOUNTSENTITY.rowid
		FROM LDC_ATTRADDACCOUNTSENTITY
		WHERE
		    ATTRADDACCOUNTSENTITY_ID = inuATTRADDACCOUNTSENTITY_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_ATTRADDACCOUNTSENTITY.*,LDC_ATTRADDACCOUNTSENTITY.rowid
		FROM LDC_ATTRADDACCOUNTSENTITY
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_ATTRADDACCOUNTSENTITY  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_ATTRADDACCOUNTSENTITY is table of styLDC_ATTRADDACCOUNTSENTITY index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_ATTRADDACCOUNTSENTITY;

	/* Tipos referenciando al registro */
	type tytbATTRADDACCOUNTSENTITY_ID is table of LDC_ATTRADDACCOUNTSENTITY.ATTRADDACCOUNTSENTITY_ID%type index by binary_integer;
	type tytbID_ENTIDAD_RECAUDO is table of LDC_ATTRADDACCOUNTSENTITY.ID_ENTIDAD_RECAUDO%type index by binary_integer;
	type tytbDIACONSIGNACION is table of LDC_ATTRADDACCOUNTSENTITY.DIACONSIGNACION%type index by binary_integer;
	type tytbDIAINICIAL is table of LDC_ATTRADDACCOUNTSENTITY.DIAINICIAL%type index by binary_integer;
	type tytbDIAFINAL is table of LDC_ATTRADDACCOUNTSENTITY.DIAFINAL%type index by binary_integer;
	type tytbVIGENCIA is table of LDC_ATTRADDACCOUNTSENTITY.VIGENCIA%type index by binary_integer;
	type tytbCOMISION_ADELANTADA is table of LDC_ATTRADDACCOUNTSENTITY.COMISION_ADELANTADA%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_ATTRADDACCOUNTSENTITY is record
	(
		ATTRADDACCOUNTSENTITY_ID   tytbATTRADDACCOUNTSENTITY_ID,
		ID_ENTIDAD_RECAUDO   tytbID_ENTIDAD_RECAUDO,
		DIACONSIGNACION   tytbDIACONSIGNACION,
		DIAINICIAL   tytbDIAINICIAL,
		DIAFINAL   tytbDIAFINAL,
		VIGENCIA   tytbVIGENCIA,
		COMISION_ADELANTADA   tytbCOMISION_ADELANTADA,
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
		inuATTRADDACCOUNTSENTITY_ID in LDC_ATTRADDACCOUNTSENTITY.ATTRADDACCOUNTSENTITY_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuATTRADDACCOUNTSENTITY_ID in LDC_ATTRADDACCOUNTSENTITY.ATTRADDACCOUNTSENTITY_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuATTRADDACCOUNTSENTITY_ID in LDC_ATTRADDACCOUNTSENTITY.ATTRADDACCOUNTSENTITY_ID%type
	);

	PROCEDURE getRecord
	(
		inuATTRADDACCOUNTSENTITY_ID in LDC_ATTRADDACCOUNTSENTITY.ATTRADDACCOUNTSENTITY_ID%type,
		orcRecord out nocopy styLDC_ATTRADDACCOUNTSENTITY
	);

	FUNCTION frcGetRcData
	(
		inuATTRADDACCOUNTSENTITY_ID in LDC_ATTRADDACCOUNTSENTITY.ATTRADDACCOUNTSENTITY_ID%type
	)
	RETURN styLDC_ATTRADDACCOUNTSENTITY;

	FUNCTION frcGetRcData
	RETURN styLDC_ATTRADDACCOUNTSENTITY;

	FUNCTION frcGetRecord
	(
		inuATTRADDACCOUNTSENTITY_ID in LDC_ATTRADDACCOUNTSENTITY.ATTRADDACCOUNTSENTITY_ID%type
	)
	RETURN styLDC_ATTRADDACCOUNTSENTITY;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_ATTRADDACCOUNTSENTITY
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_ATTRADDACCOUNTSENTITY in styLDC_ATTRADDACCOUNTSENTITY
	);

	PROCEDURE insRecord
	(
		ircLDC_ATTRADDACCOUNTSENTITY in styLDC_ATTRADDACCOUNTSENTITY,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_ATTRADDACCOUNTSENTITY in out nocopy tytbLDC_ATTRADDACCOUNTSENTITY
	);

	PROCEDURE delRecord
	(
		inuATTRADDACCOUNTSENTITY_ID in LDC_ATTRADDACCOUNTSENTITY.ATTRADDACCOUNTSENTITY_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_ATTRADDACCOUNTSENTITY in out nocopy tytbLDC_ATTRADDACCOUNTSENTITY,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_ATTRADDACCOUNTSENTITY in styLDC_ATTRADDACCOUNTSENTITY,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_ATTRADDACCOUNTSENTITY in out nocopy tytbLDC_ATTRADDACCOUNTSENTITY,
		inuLock in number default 1
	);

	PROCEDURE updID_ENTIDAD_RECAUDO
	(
		inuATTRADDACCOUNTSENTITY_ID in LDC_ATTRADDACCOUNTSENTITY.ATTRADDACCOUNTSENTITY_ID%type,
		inuID_ENTIDAD_RECAUDO$ in LDC_ATTRADDACCOUNTSENTITY.ID_ENTIDAD_RECAUDO%type,
		inuLock in number default 0
	);

	PROCEDURE updDIACONSIGNACION
	(
		inuATTRADDACCOUNTSENTITY_ID in LDC_ATTRADDACCOUNTSENTITY.ATTRADDACCOUNTSENTITY_ID%type,
		isbDIACONSIGNACION$ in LDC_ATTRADDACCOUNTSENTITY.DIACONSIGNACION%type,
		inuLock in number default 0
	);

	PROCEDURE updDIAINICIAL
	(
		inuATTRADDACCOUNTSENTITY_ID in LDC_ATTRADDACCOUNTSENTITY.ATTRADDACCOUNTSENTITY_ID%type,
		isbDIAINICIAL$ in LDC_ATTRADDACCOUNTSENTITY.DIAINICIAL%type,
		inuLock in number default 0
	);

	PROCEDURE updDIAFINAL
	(
		inuATTRADDACCOUNTSENTITY_ID in LDC_ATTRADDACCOUNTSENTITY.ATTRADDACCOUNTSENTITY_ID%type,
		isbDIAFINAL$ in LDC_ATTRADDACCOUNTSENTITY.DIAFINAL%type,
		inuLock in number default 0
	);

	PROCEDURE updVIGENCIA
	(
		inuATTRADDACCOUNTSENTITY_ID in LDC_ATTRADDACCOUNTSENTITY.ATTRADDACCOUNTSENTITY_ID%type,
		idtVIGENCIA$ in LDC_ATTRADDACCOUNTSENTITY.VIGENCIA%type,
		inuLock in number default 0
	);

	PROCEDURE updCOMISION_ADELANTADA
	(
		inuATTRADDACCOUNTSENTITY_ID in LDC_ATTRADDACCOUNTSENTITY.ATTRADDACCOUNTSENTITY_ID%type,
		isbCOMISION_ADELANTADA$ in LDC_ATTRADDACCOUNTSENTITY.COMISION_ADELANTADA%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetATTRADDACCOUNTSENTITY_ID
	(
		inuATTRADDACCOUNTSENTITY_ID in LDC_ATTRADDACCOUNTSENTITY.ATTRADDACCOUNTSENTITY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ATTRADDACCOUNTSENTITY.ATTRADDACCOUNTSENTITY_ID%type;

	FUNCTION fnuGetID_ENTIDAD_RECAUDO
	(
		inuATTRADDACCOUNTSENTITY_ID in LDC_ATTRADDACCOUNTSENTITY.ATTRADDACCOUNTSENTITY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ATTRADDACCOUNTSENTITY.ID_ENTIDAD_RECAUDO%type;

	FUNCTION fsbGetDIACONSIGNACION
	(
		inuATTRADDACCOUNTSENTITY_ID in LDC_ATTRADDACCOUNTSENTITY.ATTRADDACCOUNTSENTITY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ATTRADDACCOUNTSENTITY.DIACONSIGNACION%type;

	FUNCTION fsbGetDIAINICIAL
	(
		inuATTRADDACCOUNTSENTITY_ID in LDC_ATTRADDACCOUNTSENTITY.ATTRADDACCOUNTSENTITY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ATTRADDACCOUNTSENTITY.DIAINICIAL%type;

	FUNCTION fsbGetDIAFINAL
	(
		inuATTRADDACCOUNTSENTITY_ID in LDC_ATTRADDACCOUNTSENTITY.ATTRADDACCOUNTSENTITY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ATTRADDACCOUNTSENTITY.DIAFINAL%type;

	FUNCTION fdtGetVIGENCIA
	(
		inuATTRADDACCOUNTSENTITY_ID in LDC_ATTRADDACCOUNTSENTITY.ATTRADDACCOUNTSENTITY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ATTRADDACCOUNTSENTITY.VIGENCIA%type;

	FUNCTION fsbGetCOMISION_ADELANTADA
	(
		inuATTRADDACCOUNTSENTITY_ID in LDC_ATTRADDACCOUNTSENTITY.ATTRADDACCOUNTSENTITY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ATTRADDACCOUNTSENTITY.COMISION_ADELANTADA%type;


	PROCEDURE LockByPk
	(
		inuATTRADDACCOUNTSENTITY_ID in LDC_ATTRADDACCOUNTSENTITY.ATTRADDACCOUNTSENTITY_ID%type,
		orcLDC_ATTRADDACCOUNTSENTITY  out styLDC_ATTRADDACCOUNTSENTITY
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_ATTRADDACCOUNTSENTITY  out styLDC_ATTRADDACCOUNTSENTITY
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_ATTRADDACCOUNTSENTITY;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALDC_ATTRADDACCOUNTSENTITY
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO8239';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_ATTRADDACCOUNTSENTITY';
	 cnuGeEntityId constant varchar2(30) := 8239; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuATTRADDACCOUNTSENTITY_ID in LDC_ATTRADDACCOUNTSENTITY.ATTRADDACCOUNTSENTITY_ID%type
	)
	IS
		SELECT LDC_ATTRADDACCOUNTSENTITY.*,LDC_ATTRADDACCOUNTSENTITY.rowid
		FROM LDC_ATTRADDACCOUNTSENTITY
		WHERE  ATTRADDACCOUNTSENTITY_ID = inuATTRADDACCOUNTSENTITY_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_ATTRADDACCOUNTSENTITY.*,LDC_ATTRADDACCOUNTSENTITY.rowid
		FROM LDC_ATTRADDACCOUNTSENTITY
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_ATTRADDACCOUNTSENTITY is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_ATTRADDACCOUNTSENTITY;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_ATTRADDACCOUNTSENTITY default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.ATTRADDACCOUNTSENTITY_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuATTRADDACCOUNTSENTITY_ID in LDC_ATTRADDACCOUNTSENTITY.ATTRADDACCOUNTSENTITY_ID%type,
		orcLDC_ATTRADDACCOUNTSENTITY  out styLDC_ATTRADDACCOUNTSENTITY
	)
	IS
		rcError styLDC_ATTRADDACCOUNTSENTITY;
	BEGIN
		rcError.ATTRADDACCOUNTSENTITY_ID := inuATTRADDACCOUNTSENTITY_ID;

		Open cuLockRcByPk
		(
			inuATTRADDACCOUNTSENTITY_ID
		);

		fetch cuLockRcByPk into orcLDC_ATTRADDACCOUNTSENTITY;
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
		orcLDC_ATTRADDACCOUNTSENTITY  out styLDC_ATTRADDACCOUNTSENTITY
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_ATTRADDACCOUNTSENTITY;
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
		itbLDC_ATTRADDACCOUNTSENTITY  in out nocopy tytbLDC_ATTRADDACCOUNTSENTITY
	)
	IS
	BEGIN
			rcRecOfTab.ATTRADDACCOUNTSENTITY_ID.delete;
			rcRecOfTab.ID_ENTIDAD_RECAUDO.delete;
			rcRecOfTab.DIACONSIGNACION.delete;
			rcRecOfTab.DIAINICIAL.delete;
			rcRecOfTab.DIAFINAL.delete;
			rcRecOfTab.VIGENCIA.delete;
			rcRecOfTab.COMISION_ADELANTADA.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_ATTRADDACCOUNTSENTITY  in out nocopy tytbLDC_ATTRADDACCOUNTSENTITY,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_ATTRADDACCOUNTSENTITY);

		for n in itbLDC_ATTRADDACCOUNTSENTITY.first .. itbLDC_ATTRADDACCOUNTSENTITY.last loop
			rcRecOfTab.ATTRADDACCOUNTSENTITY_ID(n) := itbLDC_ATTRADDACCOUNTSENTITY(n).ATTRADDACCOUNTSENTITY_ID;
			rcRecOfTab.ID_ENTIDAD_RECAUDO(n) := itbLDC_ATTRADDACCOUNTSENTITY(n).ID_ENTIDAD_RECAUDO;
			rcRecOfTab.DIACONSIGNACION(n) := itbLDC_ATTRADDACCOUNTSENTITY(n).DIACONSIGNACION;
			rcRecOfTab.DIAINICIAL(n) := itbLDC_ATTRADDACCOUNTSENTITY(n).DIAINICIAL;
			rcRecOfTab.DIAFINAL(n) := itbLDC_ATTRADDACCOUNTSENTITY(n).DIAFINAL;
			rcRecOfTab.VIGENCIA(n) := itbLDC_ATTRADDACCOUNTSENTITY(n).VIGENCIA;
			rcRecOfTab.COMISION_ADELANTADA(n) := itbLDC_ATTRADDACCOUNTSENTITY(n).COMISION_ADELANTADA;
			rcRecOfTab.row_id(n) := itbLDC_ATTRADDACCOUNTSENTITY(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuATTRADDACCOUNTSENTITY_ID in LDC_ATTRADDACCOUNTSENTITY.ATTRADDACCOUNTSENTITY_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuATTRADDACCOUNTSENTITY_ID
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
		inuATTRADDACCOUNTSENTITY_ID in LDC_ATTRADDACCOUNTSENTITY.ATTRADDACCOUNTSENTITY_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuATTRADDACCOUNTSENTITY_ID = rcData.ATTRADDACCOUNTSENTITY_ID
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
		inuATTRADDACCOUNTSENTITY_ID in LDC_ATTRADDACCOUNTSENTITY.ATTRADDACCOUNTSENTITY_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuATTRADDACCOUNTSENTITY_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuATTRADDACCOUNTSENTITY_ID in LDC_ATTRADDACCOUNTSENTITY.ATTRADDACCOUNTSENTITY_ID%type
	)
	IS
		rcError styLDC_ATTRADDACCOUNTSENTITY;
	BEGIN		rcError.ATTRADDACCOUNTSENTITY_ID:=inuATTRADDACCOUNTSENTITY_ID;

		Load
		(
			inuATTRADDACCOUNTSENTITY_ID
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
		inuATTRADDACCOUNTSENTITY_ID in LDC_ATTRADDACCOUNTSENTITY.ATTRADDACCOUNTSENTITY_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuATTRADDACCOUNTSENTITY_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuATTRADDACCOUNTSENTITY_ID in LDC_ATTRADDACCOUNTSENTITY.ATTRADDACCOUNTSENTITY_ID%type,
		orcRecord out nocopy styLDC_ATTRADDACCOUNTSENTITY
	)
	IS
		rcError styLDC_ATTRADDACCOUNTSENTITY;
	BEGIN		rcError.ATTRADDACCOUNTSENTITY_ID:=inuATTRADDACCOUNTSENTITY_ID;

		Load
		(
			inuATTRADDACCOUNTSENTITY_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuATTRADDACCOUNTSENTITY_ID in LDC_ATTRADDACCOUNTSENTITY.ATTRADDACCOUNTSENTITY_ID%type
	)
	RETURN styLDC_ATTRADDACCOUNTSENTITY
	IS
		rcError styLDC_ATTRADDACCOUNTSENTITY;
	BEGIN
		rcError.ATTRADDACCOUNTSENTITY_ID:=inuATTRADDACCOUNTSENTITY_ID;

		Load
		(
			inuATTRADDACCOUNTSENTITY_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuATTRADDACCOUNTSENTITY_ID in LDC_ATTRADDACCOUNTSENTITY.ATTRADDACCOUNTSENTITY_ID%type
	)
	RETURN styLDC_ATTRADDACCOUNTSENTITY
	IS
		rcError styLDC_ATTRADDACCOUNTSENTITY;
	BEGIN
		rcError.ATTRADDACCOUNTSENTITY_ID:=inuATTRADDACCOUNTSENTITY_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuATTRADDACCOUNTSENTITY_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuATTRADDACCOUNTSENTITY_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_ATTRADDACCOUNTSENTITY
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_ATTRADDACCOUNTSENTITY
	)
	IS
		rfLDC_ATTRADDACCOUNTSENTITY tyrfLDC_ATTRADDACCOUNTSENTITY;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_ATTRADDACCOUNTSENTITY.*, LDC_ATTRADDACCOUNTSENTITY.rowid FROM LDC_ATTRADDACCOUNTSENTITY';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_ATTRADDACCOUNTSENTITY for sbFullQuery;

		fetch rfLDC_ATTRADDACCOUNTSENTITY bulk collect INTO otbResult;

		close rfLDC_ATTRADDACCOUNTSENTITY;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_ATTRADDACCOUNTSENTITY.*, LDC_ATTRADDACCOUNTSENTITY.rowid FROM LDC_ATTRADDACCOUNTSENTITY';
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
		ircLDC_ATTRADDACCOUNTSENTITY in styLDC_ATTRADDACCOUNTSENTITY
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_ATTRADDACCOUNTSENTITY,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_ATTRADDACCOUNTSENTITY in styLDC_ATTRADDACCOUNTSENTITY,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_ATTRADDACCOUNTSENTITY.ATTRADDACCOUNTSENTITY_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ATTRADDACCOUNTSENTITY_ID');
			raise ex.controlled_error;
		end if;

		insert into LDC_ATTRADDACCOUNTSENTITY
		(
			ATTRADDACCOUNTSENTITY_ID,
			ID_ENTIDAD_RECAUDO,
			DIACONSIGNACION,
			DIAINICIAL,
			DIAFINAL,
			VIGENCIA,
			COMISION_ADELANTADA
		)
		values
		(
			ircLDC_ATTRADDACCOUNTSENTITY.ATTRADDACCOUNTSENTITY_ID,
			ircLDC_ATTRADDACCOUNTSENTITY.ID_ENTIDAD_RECAUDO,
			ircLDC_ATTRADDACCOUNTSENTITY.DIACONSIGNACION,
			ircLDC_ATTRADDACCOUNTSENTITY.DIAINICIAL,
			ircLDC_ATTRADDACCOUNTSENTITY.DIAFINAL,
			ircLDC_ATTRADDACCOUNTSENTITY.VIGENCIA,
			ircLDC_ATTRADDACCOUNTSENTITY.COMISION_ADELANTADA
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_ATTRADDACCOUNTSENTITY));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_ATTRADDACCOUNTSENTITY in out nocopy tytbLDC_ATTRADDACCOUNTSENTITY
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_ATTRADDACCOUNTSENTITY,blUseRowID);
		forall n in iotbLDC_ATTRADDACCOUNTSENTITY.first..iotbLDC_ATTRADDACCOUNTSENTITY.last
			insert into LDC_ATTRADDACCOUNTSENTITY
			(
				ATTRADDACCOUNTSENTITY_ID,
				ID_ENTIDAD_RECAUDO,
				DIACONSIGNACION,
				DIAINICIAL,
				DIAFINAL,
				VIGENCIA,
				COMISION_ADELANTADA
			)
			values
			(
				rcRecOfTab.ATTRADDACCOUNTSENTITY_ID(n),
				rcRecOfTab.ID_ENTIDAD_RECAUDO(n),
				rcRecOfTab.DIACONSIGNACION(n),
				rcRecOfTab.DIAINICIAL(n),
				rcRecOfTab.DIAFINAL(n),
				rcRecOfTab.VIGENCIA(n),
				rcRecOfTab.COMISION_ADELANTADA(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuATTRADDACCOUNTSENTITY_ID in LDC_ATTRADDACCOUNTSENTITY.ATTRADDACCOUNTSENTITY_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_ATTRADDACCOUNTSENTITY;
	BEGIN
		rcError.ATTRADDACCOUNTSENTITY_ID := inuATTRADDACCOUNTSENTITY_ID;

		if inuLock=1 then
			LockByPk
			(
				inuATTRADDACCOUNTSENTITY_ID,
				rcData
			);
		end if;


		delete
		from LDC_ATTRADDACCOUNTSENTITY
		where
       		ATTRADDACCOUNTSENTITY_ID=inuATTRADDACCOUNTSENTITY_ID;
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
		rcError  styLDC_ATTRADDACCOUNTSENTITY;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_ATTRADDACCOUNTSENTITY
		where
			rowid = iriRowID
		returning
			ATTRADDACCOUNTSENTITY_ID
		into
			rcError.ATTRADDACCOUNTSENTITY_ID;
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
		iotbLDC_ATTRADDACCOUNTSENTITY in out nocopy tytbLDC_ATTRADDACCOUNTSENTITY,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_ATTRADDACCOUNTSENTITY;
	BEGIN
		FillRecordOfTables(iotbLDC_ATTRADDACCOUNTSENTITY, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_ATTRADDACCOUNTSENTITY.first .. iotbLDC_ATTRADDACCOUNTSENTITY.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ATTRADDACCOUNTSENTITY.first .. iotbLDC_ATTRADDACCOUNTSENTITY.last
				delete
				from LDC_ATTRADDACCOUNTSENTITY
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_ATTRADDACCOUNTSENTITY.first .. iotbLDC_ATTRADDACCOUNTSENTITY.last loop
					LockByPk
					(
						rcRecOfTab.ATTRADDACCOUNTSENTITY_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ATTRADDACCOUNTSENTITY.first .. iotbLDC_ATTRADDACCOUNTSENTITY.last
				delete
				from LDC_ATTRADDACCOUNTSENTITY
				where
		         	ATTRADDACCOUNTSENTITY_ID = rcRecOfTab.ATTRADDACCOUNTSENTITY_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_ATTRADDACCOUNTSENTITY in styLDC_ATTRADDACCOUNTSENTITY,
		inuLock in number default 0
	)
	IS
		nuATTRADDACCOUNTSENTITY_ID	LDC_ATTRADDACCOUNTSENTITY.ATTRADDACCOUNTSENTITY_ID%type;
	BEGIN
		if ircLDC_ATTRADDACCOUNTSENTITY.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_ATTRADDACCOUNTSENTITY.rowid,rcData);
			end if;
			update LDC_ATTRADDACCOUNTSENTITY
			set
				ID_ENTIDAD_RECAUDO = ircLDC_ATTRADDACCOUNTSENTITY.ID_ENTIDAD_RECAUDO,
				DIACONSIGNACION = ircLDC_ATTRADDACCOUNTSENTITY.DIACONSIGNACION,
				DIAINICIAL = ircLDC_ATTRADDACCOUNTSENTITY.DIAINICIAL,
				DIAFINAL = ircLDC_ATTRADDACCOUNTSENTITY.DIAFINAL,
				VIGENCIA = ircLDC_ATTRADDACCOUNTSENTITY.VIGENCIA,
				COMISION_ADELANTADA = ircLDC_ATTRADDACCOUNTSENTITY.COMISION_ADELANTADA
			where
				rowid = ircLDC_ATTRADDACCOUNTSENTITY.rowid
			returning
				ATTRADDACCOUNTSENTITY_ID
			into
				nuATTRADDACCOUNTSENTITY_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_ATTRADDACCOUNTSENTITY.ATTRADDACCOUNTSENTITY_ID,
					rcData
				);
			end if;

			update LDC_ATTRADDACCOUNTSENTITY
			set
				ID_ENTIDAD_RECAUDO = ircLDC_ATTRADDACCOUNTSENTITY.ID_ENTIDAD_RECAUDO,
				DIACONSIGNACION = ircLDC_ATTRADDACCOUNTSENTITY.DIACONSIGNACION,
				DIAINICIAL = ircLDC_ATTRADDACCOUNTSENTITY.DIAINICIAL,
				DIAFINAL = ircLDC_ATTRADDACCOUNTSENTITY.DIAFINAL,
				VIGENCIA = ircLDC_ATTRADDACCOUNTSENTITY.VIGENCIA,
				COMISION_ADELANTADA = ircLDC_ATTRADDACCOUNTSENTITY.COMISION_ADELANTADA
			where
				ATTRADDACCOUNTSENTITY_ID = ircLDC_ATTRADDACCOUNTSENTITY.ATTRADDACCOUNTSENTITY_ID
			returning
				ATTRADDACCOUNTSENTITY_ID
			into
				nuATTRADDACCOUNTSENTITY_ID;
		end if;
		if
			nuATTRADDACCOUNTSENTITY_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_ATTRADDACCOUNTSENTITY));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_ATTRADDACCOUNTSENTITY in out nocopy tytbLDC_ATTRADDACCOUNTSENTITY,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_ATTRADDACCOUNTSENTITY;
	BEGIN
		FillRecordOfTables(iotbLDC_ATTRADDACCOUNTSENTITY,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_ATTRADDACCOUNTSENTITY.first .. iotbLDC_ATTRADDACCOUNTSENTITY.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ATTRADDACCOUNTSENTITY.first .. iotbLDC_ATTRADDACCOUNTSENTITY.last
				update LDC_ATTRADDACCOUNTSENTITY
				set
					ID_ENTIDAD_RECAUDO = rcRecOfTab.ID_ENTIDAD_RECAUDO(n),
					DIACONSIGNACION = rcRecOfTab.DIACONSIGNACION(n),
					DIAINICIAL = rcRecOfTab.DIAINICIAL(n),
					DIAFINAL = rcRecOfTab.DIAFINAL(n),
					VIGENCIA = rcRecOfTab.VIGENCIA(n),
					COMISION_ADELANTADA = rcRecOfTab.COMISION_ADELANTADA(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_ATTRADDACCOUNTSENTITY.first .. iotbLDC_ATTRADDACCOUNTSENTITY.last loop
					LockByPk
					(
						rcRecOfTab.ATTRADDACCOUNTSENTITY_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ATTRADDACCOUNTSENTITY.first .. iotbLDC_ATTRADDACCOUNTSENTITY.last
				update LDC_ATTRADDACCOUNTSENTITY
				SET
					ID_ENTIDAD_RECAUDO = rcRecOfTab.ID_ENTIDAD_RECAUDO(n),
					DIACONSIGNACION = rcRecOfTab.DIACONSIGNACION(n),
					DIAINICIAL = rcRecOfTab.DIAINICIAL(n),
					DIAFINAL = rcRecOfTab.DIAFINAL(n),
					VIGENCIA = rcRecOfTab.VIGENCIA(n),
					COMISION_ADELANTADA = rcRecOfTab.COMISION_ADELANTADA(n)
				where
					ATTRADDACCOUNTSENTITY_ID = rcRecOfTab.ATTRADDACCOUNTSENTITY_ID(n)
;
		end if;
	END;
	PROCEDURE updID_ENTIDAD_RECAUDO
	(
		inuATTRADDACCOUNTSENTITY_ID in LDC_ATTRADDACCOUNTSENTITY.ATTRADDACCOUNTSENTITY_ID%type,
		inuID_ENTIDAD_RECAUDO$ in LDC_ATTRADDACCOUNTSENTITY.ID_ENTIDAD_RECAUDO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ATTRADDACCOUNTSENTITY;
	BEGIN
		rcError.ATTRADDACCOUNTSENTITY_ID := inuATTRADDACCOUNTSENTITY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuATTRADDACCOUNTSENTITY_ID,
				rcData
			);
		end if;

		update LDC_ATTRADDACCOUNTSENTITY
		set
			ID_ENTIDAD_RECAUDO = inuID_ENTIDAD_RECAUDO$
		where
			ATTRADDACCOUNTSENTITY_ID = inuATTRADDACCOUNTSENTITY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ID_ENTIDAD_RECAUDO:= inuID_ENTIDAD_RECAUDO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updDIACONSIGNACION
	(
		inuATTRADDACCOUNTSENTITY_ID in LDC_ATTRADDACCOUNTSENTITY.ATTRADDACCOUNTSENTITY_ID%type,
		isbDIACONSIGNACION$ in LDC_ATTRADDACCOUNTSENTITY.DIACONSIGNACION%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ATTRADDACCOUNTSENTITY;
	BEGIN
		rcError.ATTRADDACCOUNTSENTITY_ID := inuATTRADDACCOUNTSENTITY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuATTRADDACCOUNTSENTITY_ID,
				rcData
			);
		end if;

		update LDC_ATTRADDACCOUNTSENTITY
		set
			DIACONSIGNACION = isbDIACONSIGNACION$
		where
			ATTRADDACCOUNTSENTITY_ID = inuATTRADDACCOUNTSENTITY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DIACONSIGNACION:= isbDIACONSIGNACION$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updDIAINICIAL
	(
		inuATTRADDACCOUNTSENTITY_ID in LDC_ATTRADDACCOUNTSENTITY.ATTRADDACCOUNTSENTITY_ID%type,
		isbDIAINICIAL$ in LDC_ATTRADDACCOUNTSENTITY.DIAINICIAL%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ATTRADDACCOUNTSENTITY;
	BEGIN
		rcError.ATTRADDACCOUNTSENTITY_ID := inuATTRADDACCOUNTSENTITY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuATTRADDACCOUNTSENTITY_ID,
				rcData
			);
		end if;

		update LDC_ATTRADDACCOUNTSENTITY
		set
			DIAINICIAL = isbDIAINICIAL$
		where
			ATTRADDACCOUNTSENTITY_ID = inuATTRADDACCOUNTSENTITY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DIAINICIAL:= isbDIAINICIAL$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updDIAFINAL
	(
		inuATTRADDACCOUNTSENTITY_ID in LDC_ATTRADDACCOUNTSENTITY.ATTRADDACCOUNTSENTITY_ID%type,
		isbDIAFINAL$ in LDC_ATTRADDACCOUNTSENTITY.DIAFINAL%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ATTRADDACCOUNTSENTITY;
	BEGIN
		rcError.ATTRADDACCOUNTSENTITY_ID := inuATTRADDACCOUNTSENTITY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuATTRADDACCOUNTSENTITY_ID,
				rcData
			);
		end if;

		update LDC_ATTRADDACCOUNTSENTITY
		set
			DIAFINAL = isbDIAFINAL$
		where
			ATTRADDACCOUNTSENTITY_ID = inuATTRADDACCOUNTSENTITY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DIAFINAL:= isbDIAFINAL$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updVIGENCIA
	(
		inuATTRADDACCOUNTSENTITY_ID in LDC_ATTRADDACCOUNTSENTITY.ATTRADDACCOUNTSENTITY_ID%type,
		idtVIGENCIA$ in LDC_ATTRADDACCOUNTSENTITY.VIGENCIA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ATTRADDACCOUNTSENTITY;
	BEGIN
		rcError.ATTRADDACCOUNTSENTITY_ID := inuATTRADDACCOUNTSENTITY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuATTRADDACCOUNTSENTITY_ID,
				rcData
			);
		end if;

		update LDC_ATTRADDACCOUNTSENTITY
		set
			VIGENCIA = idtVIGENCIA$
		where
			ATTRADDACCOUNTSENTITY_ID = inuATTRADDACCOUNTSENTITY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.VIGENCIA:= idtVIGENCIA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCOMISION_ADELANTADA
	(
		inuATTRADDACCOUNTSENTITY_ID in LDC_ATTRADDACCOUNTSENTITY.ATTRADDACCOUNTSENTITY_ID%type,
		isbCOMISION_ADELANTADA$ in LDC_ATTRADDACCOUNTSENTITY.COMISION_ADELANTADA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ATTRADDACCOUNTSENTITY;
	BEGIN
		rcError.ATTRADDACCOUNTSENTITY_ID := inuATTRADDACCOUNTSENTITY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuATTRADDACCOUNTSENTITY_ID,
				rcData
			);
		end if;

		update LDC_ATTRADDACCOUNTSENTITY
		set
			COMISION_ADELANTADA = isbCOMISION_ADELANTADA$
		where
			ATTRADDACCOUNTSENTITY_ID = inuATTRADDACCOUNTSENTITY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.COMISION_ADELANTADA:= isbCOMISION_ADELANTADA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetATTRADDACCOUNTSENTITY_ID
	(
		inuATTRADDACCOUNTSENTITY_ID in LDC_ATTRADDACCOUNTSENTITY.ATTRADDACCOUNTSENTITY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ATTRADDACCOUNTSENTITY.ATTRADDACCOUNTSENTITY_ID%type
	IS
		rcError styLDC_ATTRADDACCOUNTSENTITY;
	BEGIN

		rcError.ATTRADDACCOUNTSENTITY_ID := inuATTRADDACCOUNTSENTITY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuATTRADDACCOUNTSENTITY_ID
			 )
		then
			 return(rcData.ATTRADDACCOUNTSENTITY_ID);
		end if;
		Load
		(
		 		inuATTRADDACCOUNTSENTITY_ID
		);
		return(rcData.ATTRADDACCOUNTSENTITY_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetID_ENTIDAD_RECAUDO
	(
		inuATTRADDACCOUNTSENTITY_ID in LDC_ATTRADDACCOUNTSENTITY.ATTRADDACCOUNTSENTITY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ATTRADDACCOUNTSENTITY.ID_ENTIDAD_RECAUDO%type
	IS
		rcError styLDC_ATTRADDACCOUNTSENTITY;
	BEGIN

		rcError.ATTRADDACCOUNTSENTITY_ID := inuATTRADDACCOUNTSENTITY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuATTRADDACCOUNTSENTITY_ID
			 )
		then
			 return(rcData.ID_ENTIDAD_RECAUDO);
		end if;
		Load
		(
		 		inuATTRADDACCOUNTSENTITY_ID
		);
		return(rcData.ID_ENTIDAD_RECAUDO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetDIACONSIGNACION
	(
		inuATTRADDACCOUNTSENTITY_ID in LDC_ATTRADDACCOUNTSENTITY.ATTRADDACCOUNTSENTITY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ATTRADDACCOUNTSENTITY.DIACONSIGNACION%type
	IS
		rcError styLDC_ATTRADDACCOUNTSENTITY;
	BEGIN

		rcError.ATTRADDACCOUNTSENTITY_ID := inuATTRADDACCOUNTSENTITY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuATTRADDACCOUNTSENTITY_ID
			 )
		then
			 return(rcData.DIACONSIGNACION);
		end if;
		Load
		(
		 		inuATTRADDACCOUNTSENTITY_ID
		);
		return(rcData.DIACONSIGNACION);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetDIAINICIAL
	(
		inuATTRADDACCOUNTSENTITY_ID in LDC_ATTRADDACCOUNTSENTITY.ATTRADDACCOUNTSENTITY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ATTRADDACCOUNTSENTITY.DIAINICIAL%type
	IS
		rcError styLDC_ATTRADDACCOUNTSENTITY;
	BEGIN

		rcError.ATTRADDACCOUNTSENTITY_ID := inuATTRADDACCOUNTSENTITY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuATTRADDACCOUNTSENTITY_ID
			 )
		then
			 return(rcData.DIAINICIAL);
		end if;
		Load
		(
		 		inuATTRADDACCOUNTSENTITY_ID
		);
		return(rcData.DIAINICIAL);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetDIAFINAL
	(
		inuATTRADDACCOUNTSENTITY_ID in LDC_ATTRADDACCOUNTSENTITY.ATTRADDACCOUNTSENTITY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ATTRADDACCOUNTSENTITY.DIAFINAL%type
	IS
		rcError styLDC_ATTRADDACCOUNTSENTITY;
	BEGIN

		rcError.ATTRADDACCOUNTSENTITY_ID := inuATTRADDACCOUNTSENTITY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuATTRADDACCOUNTSENTITY_ID
			 )
		then
			 return(rcData.DIAFINAL);
		end if;
		Load
		(
		 		inuATTRADDACCOUNTSENTITY_ID
		);
		return(rcData.DIAFINAL);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetVIGENCIA
	(
		inuATTRADDACCOUNTSENTITY_ID in LDC_ATTRADDACCOUNTSENTITY.ATTRADDACCOUNTSENTITY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ATTRADDACCOUNTSENTITY.VIGENCIA%type
	IS
		rcError styLDC_ATTRADDACCOUNTSENTITY;
	BEGIN

		rcError.ATTRADDACCOUNTSENTITY_ID := inuATTRADDACCOUNTSENTITY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuATTRADDACCOUNTSENTITY_ID
			 )
		then
			 return(rcData.VIGENCIA);
		end if;
		Load
		(
		 		inuATTRADDACCOUNTSENTITY_ID
		);
		return(rcData.VIGENCIA);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetCOMISION_ADELANTADA
	(
		inuATTRADDACCOUNTSENTITY_ID in LDC_ATTRADDACCOUNTSENTITY.ATTRADDACCOUNTSENTITY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ATTRADDACCOUNTSENTITY.COMISION_ADELANTADA%type
	IS
		rcError styLDC_ATTRADDACCOUNTSENTITY;
	BEGIN

		rcError.ATTRADDACCOUNTSENTITY_ID := inuATTRADDACCOUNTSENTITY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuATTRADDACCOUNTSENTITY_ID
			 )
		then
			 return(rcData.COMISION_ADELANTADA);
		end if;
		Load
		(
		 		inuATTRADDACCOUNTSENTITY_ID
		);
		return(rcData.COMISION_ADELANTADA);
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
end DALDC_ATTRADDACCOUNTSENTITY;
/
PROMPT Otorgando permisos de ejecucion a DALDC_ATTRADDACCOUNTSENTITY
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_ATTRADDACCOUNTSENTITY', 'ADM_PERSON');
END;
/