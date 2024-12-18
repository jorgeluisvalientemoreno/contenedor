CREATE OR REPLACE PACKAGE ADM_PERSON.DALDC_UNIDAD_PREDIAL
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
    05/06/2024              PAcosta         OSF-2777: Cambio de esquema ADM_PERSON                              
    ****************************************************************/    
    
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuID_PROYECTO in LDC_UNIDAD_PREDIAL.ID_PROYECTO%type,
		inuID_TORRE in LDC_UNIDAD_PREDIAL.ID_TORRE%type,
		inuID_PISO in LDC_UNIDAD_PREDIAL.ID_PISO%type,
		inuID_UNIDAD_PREDIAL in LDC_UNIDAD_PREDIAL.ID_UNIDAD_PREDIAL%type
	)
	IS
		SELECT LDC_UNIDAD_PREDIAL.*,LDC_UNIDAD_PREDIAL.rowid
		FROM LDC_UNIDAD_PREDIAL
		WHERE
		    ID_PROYECTO = inuID_PROYECTO
		    and ID_TORRE = inuID_TORRE
		    and ID_PISO = inuID_PISO
		    and ID_UNIDAD_PREDIAL = inuID_UNIDAD_PREDIAL;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_UNIDAD_PREDIAL.*,LDC_UNIDAD_PREDIAL.rowid
		FROM LDC_UNIDAD_PREDIAL
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_UNIDAD_PREDIAL  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_UNIDAD_PREDIAL is table of styLDC_UNIDAD_PREDIAL index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_UNIDAD_PREDIAL;

	/* Tipos referenciando al registro */
	type tytbID_UNIDAD_PREDIAL is table of LDC_UNIDAD_PREDIAL.ID_UNIDAD_PREDIAL%type index by binary_integer;
	type tytbDESCRIPCION is table of LDC_UNIDAD_PREDIAL.DESCRIPCION%type index by binary_integer;
	type tytbID_PROYECTO is table of LDC_UNIDAD_PREDIAL.ID_PROYECTO%type index by binary_integer;
	type tytbID_TIPO_UNID_PRED is table of LDC_UNIDAD_PREDIAL.ID_TIPO_UNID_PRED%type index by binary_integer;
	type tytbID_PISO is table of LDC_UNIDAD_PREDIAL.ID_PISO%type index by binary_integer;
	type tytbFECH_CREACION is table of LDC_UNIDAD_PREDIAL.FECH_CREACION%type index by binary_integer;
	type tytbID_TORRE is table of LDC_UNIDAD_PREDIAL.ID_TORRE%type index by binary_integer;
	type tytbID_UNIDAD_PREDIAL_UNICO is table of LDC_UNIDAD_PREDIAL.ID_UNIDAD_PREDIAL_UNICO%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_UNIDAD_PREDIAL is record
	(
		ID_UNIDAD_PREDIAL   tytbID_UNIDAD_PREDIAL,
		DESCRIPCION   tytbDESCRIPCION,
		ID_PROYECTO   tytbID_PROYECTO,
		ID_TIPO_UNID_PRED   tytbID_TIPO_UNID_PRED,
		ID_PISO   tytbID_PISO,
		FECH_CREACION   tytbFECH_CREACION,
		ID_TORRE   tytbID_TORRE,
		ID_UNIDAD_PREDIAL_UNICO   tytbID_UNIDAD_PREDIAL_UNICO,
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
		inuID_PROYECTO in LDC_UNIDAD_PREDIAL.ID_PROYECTO%type,
		inuID_TORRE in LDC_UNIDAD_PREDIAL.ID_TORRE%type,
		inuID_PISO in LDC_UNIDAD_PREDIAL.ID_PISO%type,
		inuID_UNIDAD_PREDIAL in LDC_UNIDAD_PREDIAL.ID_UNIDAD_PREDIAL%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuID_PROYECTO in LDC_UNIDAD_PREDIAL.ID_PROYECTO%type,
		inuID_TORRE in LDC_UNIDAD_PREDIAL.ID_TORRE%type,
		inuID_PISO in LDC_UNIDAD_PREDIAL.ID_PISO%type,
		inuID_UNIDAD_PREDIAL in LDC_UNIDAD_PREDIAL.ID_UNIDAD_PREDIAL%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuID_PROYECTO in LDC_UNIDAD_PREDIAL.ID_PROYECTO%type,
		inuID_TORRE in LDC_UNIDAD_PREDIAL.ID_TORRE%type,
		inuID_PISO in LDC_UNIDAD_PREDIAL.ID_PISO%type,
		inuID_UNIDAD_PREDIAL in LDC_UNIDAD_PREDIAL.ID_UNIDAD_PREDIAL%type
	);

	PROCEDURE getRecord
	(
		inuID_PROYECTO in LDC_UNIDAD_PREDIAL.ID_PROYECTO%type,
		inuID_TORRE in LDC_UNIDAD_PREDIAL.ID_TORRE%type,
		inuID_PISO in LDC_UNIDAD_PREDIAL.ID_PISO%type,
		inuID_UNIDAD_PREDIAL in LDC_UNIDAD_PREDIAL.ID_UNIDAD_PREDIAL%type,
		orcRecord out nocopy styLDC_UNIDAD_PREDIAL
	);

	FUNCTION frcGetRcData
	(
		inuID_PROYECTO in LDC_UNIDAD_PREDIAL.ID_PROYECTO%type,
		inuID_TORRE in LDC_UNIDAD_PREDIAL.ID_TORRE%type,
		inuID_PISO in LDC_UNIDAD_PREDIAL.ID_PISO%type,
		inuID_UNIDAD_PREDIAL in LDC_UNIDAD_PREDIAL.ID_UNIDAD_PREDIAL%type
	)
	RETURN styLDC_UNIDAD_PREDIAL;

	FUNCTION frcGetRcData
	RETURN styLDC_UNIDAD_PREDIAL;

	FUNCTION frcGetRecord
	(
		inuID_PROYECTO in LDC_UNIDAD_PREDIAL.ID_PROYECTO%type,
		inuID_TORRE in LDC_UNIDAD_PREDIAL.ID_TORRE%type,
		inuID_PISO in LDC_UNIDAD_PREDIAL.ID_PISO%type,
		inuID_UNIDAD_PREDIAL in LDC_UNIDAD_PREDIAL.ID_UNIDAD_PREDIAL%type
	)
	RETURN styLDC_UNIDAD_PREDIAL;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_UNIDAD_PREDIAL
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_UNIDAD_PREDIAL in styLDC_UNIDAD_PREDIAL
	);

	PROCEDURE insRecord
	(
		ircLDC_UNIDAD_PREDIAL in styLDC_UNIDAD_PREDIAL,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_UNIDAD_PREDIAL in out nocopy tytbLDC_UNIDAD_PREDIAL
	);

	PROCEDURE delRecord
	(
		inuID_PROYECTO in LDC_UNIDAD_PREDIAL.ID_PROYECTO%type,
		inuID_TORRE in LDC_UNIDAD_PREDIAL.ID_TORRE%type,
		inuID_PISO in LDC_UNIDAD_PREDIAL.ID_PISO%type,
		inuID_UNIDAD_PREDIAL in LDC_UNIDAD_PREDIAL.ID_UNIDAD_PREDIAL%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_UNIDAD_PREDIAL in out nocopy tytbLDC_UNIDAD_PREDIAL,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_UNIDAD_PREDIAL in styLDC_UNIDAD_PREDIAL,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_UNIDAD_PREDIAL in out nocopy tytbLDC_UNIDAD_PREDIAL,
		inuLock in number default 1
	);

	PROCEDURE updDESCRIPCION
	(
		inuID_PROYECTO in LDC_UNIDAD_PREDIAL.ID_PROYECTO%type,
		inuID_TORRE in LDC_UNIDAD_PREDIAL.ID_TORRE%type,
		inuID_PISO in LDC_UNIDAD_PREDIAL.ID_PISO%type,
		inuID_UNIDAD_PREDIAL in LDC_UNIDAD_PREDIAL.ID_UNIDAD_PREDIAL%type,
		isbDESCRIPCION$ in LDC_UNIDAD_PREDIAL.DESCRIPCION%type,
		inuLock in number default 0
	);

	PROCEDURE updID_TIPO_UNID_PRED
	(
		inuID_PROYECTO in LDC_UNIDAD_PREDIAL.ID_PROYECTO%type,
		inuID_TORRE in LDC_UNIDAD_PREDIAL.ID_TORRE%type,
		inuID_PISO in LDC_UNIDAD_PREDIAL.ID_PISO%type,
		inuID_UNIDAD_PREDIAL in LDC_UNIDAD_PREDIAL.ID_UNIDAD_PREDIAL%type,
		inuID_TIPO_UNID_PRED$ in LDC_UNIDAD_PREDIAL.ID_TIPO_UNID_PRED%type,
		inuLock in number default 0
	);

	PROCEDURE updFECH_CREACION
	(
		inuID_PROYECTO in LDC_UNIDAD_PREDIAL.ID_PROYECTO%type,
		inuID_TORRE in LDC_UNIDAD_PREDIAL.ID_TORRE%type,
		inuID_PISO in LDC_UNIDAD_PREDIAL.ID_PISO%type,
		inuID_UNIDAD_PREDIAL in LDC_UNIDAD_PREDIAL.ID_UNIDAD_PREDIAL%type,
		idtFECH_CREACION$ in LDC_UNIDAD_PREDIAL.FECH_CREACION%type,
		inuLock in number default 0
	);

	PROCEDURE updID_UNIDAD_PREDIAL_UNICO
	(
		inuID_PROYECTO in LDC_UNIDAD_PREDIAL.ID_PROYECTO%type,
		inuID_TORRE in LDC_UNIDAD_PREDIAL.ID_TORRE%type,
		inuID_PISO in LDC_UNIDAD_PREDIAL.ID_PISO%type,
		inuID_UNIDAD_PREDIAL in LDC_UNIDAD_PREDIAL.ID_UNIDAD_PREDIAL%type,
		inuID_UNIDAD_PREDIAL_UNICO$ in LDC_UNIDAD_PREDIAL.ID_UNIDAD_PREDIAL_UNICO%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetID_UNIDAD_PREDIAL
	(
		inuID_PROYECTO in LDC_UNIDAD_PREDIAL.ID_PROYECTO%type,
		inuID_TORRE in LDC_UNIDAD_PREDIAL.ID_TORRE%type,
		inuID_PISO in LDC_UNIDAD_PREDIAL.ID_PISO%type,
		inuID_UNIDAD_PREDIAL in LDC_UNIDAD_PREDIAL.ID_UNIDAD_PREDIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_UNIDAD_PREDIAL.ID_UNIDAD_PREDIAL%type;

	FUNCTION fsbGetDESCRIPCION
	(
		inuID_PROYECTO in LDC_UNIDAD_PREDIAL.ID_PROYECTO%type,
		inuID_TORRE in LDC_UNIDAD_PREDIAL.ID_TORRE%type,
		inuID_PISO in LDC_UNIDAD_PREDIAL.ID_PISO%type,
		inuID_UNIDAD_PREDIAL in LDC_UNIDAD_PREDIAL.ID_UNIDAD_PREDIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_UNIDAD_PREDIAL.DESCRIPCION%type;

	FUNCTION fnuGetID_PROYECTO
	(
		inuID_PROYECTO in LDC_UNIDAD_PREDIAL.ID_PROYECTO%type,
		inuID_TORRE in LDC_UNIDAD_PREDIAL.ID_TORRE%type,
		inuID_PISO in LDC_UNIDAD_PREDIAL.ID_PISO%type,
		inuID_UNIDAD_PREDIAL in LDC_UNIDAD_PREDIAL.ID_UNIDAD_PREDIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_UNIDAD_PREDIAL.ID_PROYECTO%type;

	FUNCTION fnuGetID_TIPO_UNID_PRED
	(
		inuID_PROYECTO in LDC_UNIDAD_PREDIAL.ID_PROYECTO%type,
		inuID_TORRE in LDC_UNIDAD_PREDIAL.ID_TORRE%type,
		inuID_PISO in LDC_UNIDAD_PREDIAL.ID_PISO%type,
		inuID_UNIDAD_PREDIAL in LDC_UNIDAD_PREDIAL.ID_UNIDAD_PREDIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_UNIDAD_PREDIAL.ID_TIPO_UNID_PRED%type;

	FUNCTION fnuGetID_PISO
	(
		inuID_PROYECTO in LDC_UNIDAD_PREDIAL.ID_PROYECTO%type,
		inuID_TORRE in LDC_UNIDAD_PREDIAL.ID_TORRE%type,
		inuID_PISO in LDC_UNIDAD_PREDIAL.ID_PISO%type,
		inuID_UNIDAD_PREDIAL in LDC_UNIDAD_PREDIAL.ID_UNIDAD_PREDIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_UNIDAD_PREDIAL.ID_PISO%type;

	FUNCTION fdtGetFECH_CREACION
	(
		inuID_PROYECTO in LDC_UNIDAD_PREDIAL.ID_PROYECTO%type,
		inuID_TORRE in LDC_UNIDAD_PREDIAL.ID_TORRE%type,
		inuID_PISO in LDC_UNIDAD_PREDIAL.ID_PISO%type,
		inuID_UNIDAD_PREDIAL in LDC_UNIDAD_PREDIAL.ID_UNIDAD_PREDIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_UNIDAD_PREDIAL.FECH_CREACION%type;

	FUNCTION fnuGetID_TORRE
	(
		inuID_PROYECTO in LDC_UNIDAD_PREDIAL.ID_PROYECTO%type,
		inuID_TORRE in LDC_UNIDAD_PREDIAL.ID_TORRE%type,
		inuID_PISO in LDC_UNIDAD_PREDIAL.ID_PISO%type,
		inuID_UNIDAD_PREDIAL in LDC_UNIDAD_PREDIAL.ID_UNIDAD_PREDIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_UNIDAD_PREDIAL.ID_TORRE%type;

	FUNCTION fnuGetID_UNIDAD_PREDIAL_UNICO
	(
		inuID_PROYECTO in LDC_UNIDAD_PREDIAL.ID_PROYECTO%type,
		inuID_TORRE in LDC_UNIDAD_PREDIAL.ID_TORRE%type,
		inuID_PISO in LDC_UNIDAD_PREDIAL.ID_PISO%type,
		inuID_UNIDAD_PREDIAL in LDC_UNIDAD_PREDIAL.ID_UNIDAD_PREDIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_UNIDAD_PREDIAL.ID_UNIDAD_PREDIAL_UNICO%type;


	PROCEDURE LockByPk
	(
		inuID_PROYECTO in LDC_UNIDAD_PREDIAL.ID_PROYECTO%type,
		inuID_TORRE in LDC_UNIDAD_PREDIAL.ID_TORRE%type,
		inuID_PISO in LDC_UNIDAD_PREDIAL.ID_PISO%type,
		inuID_UNIDAD_PREDIAL in LDC_UNIDAD_PREDIAL.ID_UNIDAD_PREDIAL%type,
		orcLDC_UNIDAD_PREDIAL  out styLDC_UNIDAD_PREDIAL
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_UNIDAD_PREDIAL  out styLDC_UNIDAD_PREDIAL
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_UNIDAD_PREDIAL;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALDC_UNIDAD_PREDIAL
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_UNIDAD_PREDIAL';
	 cnuGeEntityId constant varchar2(30) := 2863; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuID_PROYECTO in LDC_UNIDAD_PREDIAL.ID_PROYECTO%type,
		inuID_TORRE in LDC_UNIDAD_PREDIAL.ID_TORRE%type,
		inuID_PISO in LDC_UNIDAD_PREDIAL.ID_PISO%type,
		inuID_UNIDAD_PREDIAL in LDC_UNIDAD_PREDIAL.ID_UNIDAD_PREDIAL%type
	)
	IS
		SELECT LDC_UNIDAD_PREDIAL.*,LDC_UNIDAD_PREDIAL.rowid
		FROM LDC_UNIDAD_PREDIAL
		WHERE  ID_PROYECTO = inuID_PROYECTO
			and ID_TORRE = inuID_TORRE
			and ID_PISO = inuID_PISO
			and ID_UNIDAD_PREDIAL = inuID_UNIDAD_PREDIAL
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_UNIDAD_PREDIAL.*,LDC_UNIDAD_PREDIAL.rowid
		FROM LDC_UNIDAD_PREDIAL
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_UNIDAD_PREDIAL is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_UNIDAD_PREDIAL;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_UNIDAD_PREDIAL default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.ID_PROYECTO);
		sbPk:=sbPk||','||ut_convert.fsbToChar(rcI.ID_TORRE);
		sbPk:=sbPk||','||ut_convert.fsbToChar(rcI.ID_PISO);
		sbPk:=sbPk||','||ut_convert.fsbToChar(rcI.ID_UNIDAD_PREDIAL);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuID_PROYECTO in LDC_UNIDAD_PREDIAL.ID_PROYECTO%type,
		inuID_TORRE in LDC_UNIDAD_PREDIAL.ID_TORRE%type,
		inuID_PISO in LDC_UNIDAD_PREDIAL.ID_PISO%type,
		inuID_UNIDAD_PREDIAL in LDC_UNIDAD_PREDIAL.ID_UNIDAD_PREDIAL%type,
		orcLDC_UNIDAD_PREDIAL  out styLDC_UNIDAD_PREDIAL
	)
	IS
		rcError styLDC_UNIDAD_PREDIAL;
	BEGIN
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_TORRE := inuID_TORRE;
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_UNIDAD_PREDIAL := inuID_UNIDAD_PREDIAL;

		Open cuLockRcByPk
		(
			inuID_PROYECTO,
			inuID_TORRE,
			inuID_PISO,
			inuID_UNIDAD_PREDIAL
		);

		fetch cuLockRcByPk into orcLDC_UNIDAD_PREDIAL;
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
		orcLDC_UNIDAD_PREDIAL  out styLDC_UNIDAD_PREDIAL
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_UNIDAD_PREDIAL;
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
		itbLDC_UNIDAD_PREDIAL  in out nocopy tytbLDC_UNIDAD_PREDIAL
	)
	IS
	BEGIN
			rcRecOfTab.ID_UNIDAD_PREDIAL.delete;
			rcRecOfTab.DESCRIPCION.delete;
			rcRecOfTab.ID_PROYECTO.delete;
			rcRecOfTab.ID_TIPO_UNID_PRED.delete;
			rcRecOfTab.ID_PISO.delete;
			rcRecOfTab.FECH_CREACION.delete;
			rcRecOfTab.ID_TORRE.delete;
			rcRecOfTab.ID_UNIDAD_PREDIAL_UNICO.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_UNIDAD_PREDIAL  in out nocopy tytbLDC_UNIDAD_PREDIAL,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_UNIDAD_PREDIAL);

		for n in itbLDC_UNIDAD_PREDIAL.first .. itbLDC_UNIDAD_PREDIAL.last loop
			rcRecOfTab.ID_UNIDAD_PREDIAL(n) := itbLDC_UNIDAD_PREDIAL(n).ID_UNIDAD_PREDIAL;
			rcRecOfTab.DESCRIPCION(n) := itbLDC_UNIDAD_PREDIAL(n).DESCRIPCION;
			rcRecOfTab.ID_PROYECTO(n) := itbLDC_UNIDAD_PREDIAL(n).ID_PROYECTO;
			rcRecOfTab.ID_TIPO_UNID_PRED(n) := itbLDC_UNIDAD_PREDIAL(n).ID_TIPO_UNID_PRED;
			rcRecOfTab.ID_PISO(n) := itbLDC_UNIDAD_PREDIAL(n).ID_PISO;
			rcRecOfTab.FECH_CREACION(n) := itbLDC_UNIDAD_PREDIAL(n).FECH_CREACION;
			rcRecOfTab.ID_TORRE(n) := itbLDC_UNIDAD_PREDIAL(n).ID_TORRE;
			rcRecOfTab.ID_UNIDAD_PREDIAL_UNICO(n) := itbLDC_UNIDAD_PREDIAL(n).ID_UNIDAD_PREDIAL_UNICO;
			rcRecOfTab.row_id(n) := itbLDC_UNIDAD_PREDIAL(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuID_PROYECTO in LDC_UNIDAD_PREDIAL.ID_PROYECTO%type,
		inuID_TORRE in LDC_UNIDAD_PREDIAL.ID_TORRE%type,
		inuID_PISO in LDC_UNIDAD_PREDIAL.ID_PISO%type,
		inuID_UNIDAD_PREDIAL in LDC_UNIDAD_PREDIAL.ID_UNIDAD_PREDIAL%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuID_PROYECTO,
			inuID_TORRE,
			inuID_PISO,
			inuID_UNIDAD_PREDIAL
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
		inuID_PROYECTO in LDC_UNIDAD_PREDIAL.ID_PROYECTO%type,
		inuID_TORRE in LDC_UNIDAD_PREDIAL.ID_TORRE%type,
		inuID_PISO in LDC_UNIDAD_PREDIAL.ID_PISO%type,
		inuID_UNIDAD_PREDIAL in LDC_UNIDAD_PREDIAL.ID_UNIDAD_PREDIAL%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuID_PROYECTO = rcData.ID_PROYECTO AND
			inuID_TORRE = rcData.ID_TORRE AND
			inuID_PISO = rcData.ID_PISO AND
			inuID_UNIDAD_PREDIAL = rcData.ID_UNIDAD_PREDIAL
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
		inuID_PROYECTO in LDC_UNIDAD_PREDIAL.ID_PROYECTO%type,
		inuID_TORRE in LDC_UNIDAD_PREDIAL.ID_TORRE%type,
		inuID_PISO in LDC_UNIDAD_PREDIAL.ID_PISO%type,
		inuID_UNIDAD_PREDIAL in LDC_UNIDAD_PREDIAL.ID_UNIDAD_PREDIAL%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuID_PROYECTO,
			inuID_TORRE,
			inuID_PISO,
			inuID_UNIDAD_PREDIAL
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuID_PROYECTO in LDC_UNIDAD_PREDIAL.ID_PROYECTO%type,
		inuID_TORRE in LDC_UNIDAD_PREDIAL.ID_TORRE%type,
		inuID_PISO in LDC_UNIDAD_PREDIAL.ID_PISO%type,
		inuID_UNIDAD_PREDIAL in LDC_UNIDAD_PREDIAL.ID_UNIDAD_PREDIAL%type
	)
	IS
		rcError styLDC_UNIDAD_PREDIAL;
	BEGIN		rcError.ID_PROYECTO:=inuID_PROYECTO;		rcError.ID_TORRE:=inuID_TORRE;		rcError.ID_PISO:=inuID_PISO;		rcError.ID_UNIDAD_PREDIAL:=inuID_UNIDAD_PREDIAL;

		Load
		(
			inuID_PROYECTO,
			inuID_TORRE,
			inuID_PISO,
			inuID_UNIDAD_PREDIAL
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
		inuID_PROYECTO in LDC_UNIDAD_PREDIAL.ID_PROYECTO%type,
		inuID_TORRE in LDC_UNIDAD_PREDIAL.ID_TORRE%type,
		inuID_PISO in LDC_UNIDAD_PREDIAL.ID_PISO%type,
		inuID_UNIDAD_PREDIAL in LDC_UNIDAD_PREDIAL.ID_UNIDAD_PREDIAL%type
	)
	IS
	BEGIN
		Load
		(
			inuID_PROYECTO,
			inuID_TORRE,
			inuID_PISO,
			inuID_UNIDAD_PREDIAL
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuID_PROYECTO in LDC_UNIDAD_PREDIAL.ID_PROYECTO%type,
		inuID_TORRE in LDC_UNIDAD_PREDIAL.ID_TORRE%type,
		inuID_PISO in LDC_UNIDAD_PREDIAL.ID_PISO%type,
		inuID_UNIDAD_PREDIAL in LDC_UNIDAD_PREDIAL.ID_UNIDAD_PREDIAL%type,
		orcRecord out nocopy styLDC_UNIDAD_PREDIAL
	)
	IS
		rcError styLDC_UNIDAD_PREDIAL;
	BEGIN		rcError.ID_PROYECTO:=inuID_PROYECTO;		rcError.ID_TORRE:=inuID_TORRE;		rcError.ID_PISO:=inuID_PISO;		rcError.ID_UNIDAD_PREDIAL:=inuID_UNIDAD_PREDIAL;

		Load
		(
			inuID_PROYECTO,
			inuID_TORRE,
			inuID_PISO,
			inuID_UNIDAD_PREDIAL
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuID_PROYECTO in LDC_UNIDAD_PREDIAL.ID_PROYECTO%type,
		inuID_TORRE in LDC_UNIDAD_PREDIAL.ID_TORRE%type,
		inuID_PISO in LDC_UNIDAD_PREDIAL.ID_PISO%type,
		inuID_UNIDAD_PREDIAL in LDC_UNIDAD_PREDIAL.ID_UNIDAD_PREDIAL%type
	)
	RETURN styLDC_UNIDAD_PREDIAL
	IS
		rcError styLDC_UNIDAD_PREDIAL;
	BEGIN
		rcError.ID_PROYECTO:=inuID_PROYECTO;
		rcError.ID_TORRE:=inuID_TORRE;
		rcError.ID_PISO:=inuID_PISO;
		rcError.ID_UNIDAD_PREDIAL:=inuID_UNIDAD_PREDIAL;

		Load
		(
			inuID_PROYECTO,
			inuID_TORRE,
			inuID_PISO,
			inuID_UNIDAD_PREDIAL
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuID_PROYECTO in LDC_UNIDAD_PREDIAL.ID_PROYECTO%type,
		inuID_TORRE in LDC_UNIDAD_PREDIAL.ID_TORRE%type,
		inuID_PISO in LDC_UNIDAD_PREDIAL.ID_PISO%type,
		inuID_UNIDAD_PREDIAL in LDC_UNIDAD_PREDIAL.ID_UNIDAD_PREDIAL%type
	)
	RETURN styLDC_UNIDAD_PREDIAL
	IS
		rcError styLDC_UNIDAD_PREDIAL;
	BEGIN
		rcError.ID_PROYECTO:=inuID_PROYECTO;
		rcError.ID_TORRE:=inuID_TORRE;
		rcError.ID_PISO:=inuID_PISO;
		rcError.ID_UNIDAD_PREDIAL:=inuID_UNIDAD_PREDIAL;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuID_PROYECTO,
			inuID_TORRE,
			inuID_PISO,
			inuID_UNIDAD_PREDIAL
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuID_PROYECTO,
			inuID_TORRE,
			inuID_PISO,
			inuID_UNIDAD_PREDIAL
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_UNIDAD_PREDIAL
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_UNIDAD_PREDIAL
	)
	IS
		rfLDC_UNIDAD_PREDIAL tyrfLDC_UNIDAD_PREDIAL;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_UNIDAD_PREDIAL.*, LDC_UNIDAD_PREDIAL.rowid FROM LDC_UNIDAD_PREDIAL';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_UNIDAD_PREDIAL for sbFullQuery;

		fetch rfLDC_UNIDAD_PREDIAL bulk collect INTO otbResult;

		close rfLDC_UNIDAD_PREDIAL;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_UNIDAD_PREDIAL.*, LDC_UNIDAD_PREDIAL.rowid FROM LDC_UNIDAD_PREDIAL';
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
		ircLDC_UNIDAD_PREDIAL in styLDC_UNIDAD_PREDIAL
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_UNIDAD_PREDIAL,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_UNIDAD_PREDIAL in styLDC_UNIDAD_PREDIAL,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_UNIDAD_PREDIAL.ID_PROYECTO is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ID_PROYECTO');
			raise ex.controlled_error;
		end if;
		if ircLDC_UNIDAD_PREDIAL.ID_TORRE is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ID_TORRE');
			raise ex.controlled_error;
		end if;
		if ircLDC_UNIDAD_PREDIAL.ID_PISO is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ID_PISO');
			raise ex.controlled_error;
		end if;
		if ircLDC_UNIDAD_PREDIAL.ID_UNIDAD_PREDIAL is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ID_UNIDAD_PREDIAL');
			raise ex.controlled_error;
		end if;

		insert into LDC_UNIDAD_PREDIAL
		(
			ID_UNIDAD_PREDIAL,
			DESCRIPCION,
			ID_PROYECTO,
			ID_TIPO_UNID_PRED,
			ID_PISO,
			FECH_CREACION,
			ID_TORRE,
			ID_UNIDAD_PREDIAL_UNICO
		)
		values
		(
			ircLDC_UNIDAD_PREDIAL.ID_UNIDAD_PREDIAL,
			ircLDC_UNIDAD_PREDIAL.DESCRIPCION,
			ircLDC_UNIDAD_PREDIAL.ID_PROYECTO,
			ircLDC_UNIDAD_PREDIAL.ID_TIPO_UNID_PRED,
			ircLDC_UNIDAD_PREDIAL.ID_PISO,
			ircLDC_UNIDAD_PREDIAL.FECH_CREACION,
			ircLDC_UNIDAD_PREDIAL.ID_TORRE,
			ircLDC_UNIDAD_PREDIAL.ID_UNIDAD_PREDIAL_UNICO
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_UNIDAD_PREDIAL));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_UNIDAD_PREDIAL in out nocopy tytbLDC_UNIDAD_PREDIAL
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_UNIDAD_PREDIAL,blUseRowID);
		forall n in iotbLDC_UNIDAD_PREDIAL.first..iotbLDC_UNIDAD_PREDIAL.last
			insert into LDC_UNIDAD_PREDIAL
			(
				ID_UNIDAD_PREDIAL,
				DESCRIPCION,
				ID_PROYECTO,
				ID_TIPO_UNID_PRED,
				ID_PISO,
				FECH_CREACION,
				ID_TORRE,
				ID_UNIDAD_PREDIAL_UNICO
			)
			values
			(
				rcRecOfTab.ID_UNIDAD_PREDIAL(n),
				rcRecOfTab.DESCRIPCION(n),
				rcRecOfTab.ID_PROYECTO(n),
				rcRecOfTab.ID_TIPO_UNID_PRED(n),
				rcRecOfTab.ID_PISO(n),
				rcRecOfTab.FECH_CREACION(n),
				rcRecOfTab.ID_TORRE(n),
				rcRecOfTab.ID_UNIDAD_PREDIAL_UNICO(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuID_PROYECTO in LDC_UNIDAD_PREDIAL.ID_PROYECTO%type,
		inuID_TORRE in LDC_UNIDAD_PREDIAL.ID_TORRE%type,
		inuID_PISO in LDC_UNIDAD_PREDIAL.ID_PISO%type,
		inuID_UNIDAD_PREDIAL in LDC_UNIDAD_PREDIAL.ID_UNIDAD_PREDIAL%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_UNIDAD_PREDIAL;
	BEGIN
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_TORRE := inuID_TORRE;
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_UNIDAD_PREDIAL := inuID_UNIDAD_PREDIAL;

		if inuLock=1 then
			LockByPk
			(
				inuID_PROYECTO,
				inuID_TORRE,
				inuID_PISO,
				inuID_UNIDAD_PREDIAL,
				rcData
			);
		end if;


		delete
		from LDC_UNIDAD_PREDIAL
		where
       		ID_PROYECTO=inuID_PROYECTO and
       		ID_TORRE=inuID_TORRE and
       		ID_PISO=inuID_PISO and
       		ID_UNIDAD_PREDIAL=inuID_UNIDAD_PREDIAL;
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
		rcError  styLDC_UNIDAD_PREDIAL;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_UNIDAD_PREDIAL
		where
			rowid = iriRowID
		returning
			ID_UNIDAD_PREDIAL,
			DESCRIPCION,
			ID_PROYECTO,
			ID_TIPO_UNID_PRED
		into
			rcError.ID_UNIDAD_PREDIAL,
			rcError.DESCRIPCION,
			rcError.ID_PROYECTO,
			rcError.ID_TIPO_UNID_PRED;
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
		iotbLDC_UNIDAD_PREDIAL in out nocopy tytbLDC_UNIDAD_PREDIAL,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_UNIDAD_PREDIAL;
	BEGIN
		FillRecordOfTables(iotbLDC_UNIDAD_PREDIAL, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_UNIDAD_PREDIAL.first .. iotbLDC_UNIDAD_PREDIAL.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_UNIDAD_PREDIAL.first .. iotbLDC_UNIDAD_PREDIAL.last
				delete
				from LDC_UNIDAD_PREDIAL
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_UNIDAD_PREDIAL.first .. iotbLDC_UNIDAD_PREDIAL.last loop
					LockByPk
					(
						rcRecOfTab.ID_PROYECTO(n),
						rcRecOfTab.ID_TORRE(n),
						rcRecOfTab.ID_PISO(n),
						rcRecOfTab.ID_UNIDAD_PREDIAL(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_UNIDAD_PREDIAL.first .. iotbLDC_UNIDAD_PREDIAL.last
				delete
				from LDC_UNIDAD_PREDIAL
				where
		         	ID_PROYECTO = rcRecOfTab.ID_PROYECTO(n) and
		         	ID_TORRE = rcRecOfTab.ID_TORRE(n) and
		         	ID_PISO = rcRecOfTab.ID_PISO(n) and
		         	ID_UNIDAD_PREDIAL = rcRecOfTab.ID_UNIDAD_PREDIAL(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_UNIDAD_PREDIAL in styLDC_UNIDAD_PREDIAL,
		inuLock in number default 0
	)
	IS
		nuID_PROYECTO	LDC_UNIDAD_PREDIAL.ID_PROYECTO%type;
		nuID_TORRE	LDC_UNIDAD_PREDIAL.ID_TORRE%type;
		nuID_PISO	LDC_UNIDAD_PREDIAL.ID_PISO%type;
		nuID_UNIDAD_PREDIAL	LDC_UNIDAD_PREDIAL.ID_UNIDAD_PREDIAL%type;
	BEGIN
		if ircLDC_UNIDAD_PREDIAL.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_UNIDAD_PREDIAL.rowid,rcData);
			end if;
			update LDC_UNIDAD_PREDIAL
			set
				DESCRIPCION = ircLDC_UNIDAD_PREDIAL.DESCRIPCION,
				ID_TIPO_UNID_PRED = ircLDC_UNIDAD_PREDIAL.ID_TIPO_UNID_PRED,
				FECH_CREACION = ircLDC_UNIDAD_PREDIAL.FECH_CREACION,
				ID_UNIDAD_PREDIAL_UNICO = ircLDC_UNIDAD_PREDIAL.ID_UNIDAD_PREDIAL_UNICO
			where
				rowid = ircLDC_UNIDAD_PREDIAL.rowid
			returning
				ID_PROYECTO,
				ID_TORRE,
				ID_PISO,
				ID_UNIDAD_PREDIAL
			into
				nuID_PROYECTO,
				nuID_TORRE,
				nuID_PISO,
				nuID_UNIDAD_PREDIAL;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_UNIDAD_PREDIAL.ID_PROYECTO,
					ircLDC_UNIDAD_PREDIAL.ID_TORRE,
					ircLDC_UNIDAD_PREDIAL.ID_PISO,
					ircLDC_UNIDAD_PREDIAL.ID_UNIDAD_PREDIAL,
					rcData
				);
			end if;

			update LDC_UNIDAD_PREDIAL
			set
				DESCRIPCION = ircLDC_UNIDAD_PREDIAL.DESCRIPCION,
				ID_TIPO_UNID_PRED = ircLDC_UNIDAD_PREDIAL.ID_TIPO_UNID_PRED,
				FECH_CREACION = ircLDC_UNIDAD_PREDIAL.FECH_CREACION,
				ID_UNIDAD_PREDIAL_UNICO = ircLDC_UNIDAD_PREDIAL.ID_UNIDAD_PREDIAL_UNICO
			where
				ID_PROYECTO = ircLDC_UNIDAD_PREDIAL.ID_PROYECTO and
				ID_TORRE = ircLDC_UNIDAD_PREDIAL.ID_TORRE and
				ID_PISO = ircLDC_UNIDAD_PREDIAL.ID_PISO and
				ID_UNIDAD_PREDIAL = ircLDC_UNIDAD_PREDIAL.ID_UNIDAD_PREDIAL
			returning
				ID_PROYECTO,
				ID_TORRE,
				ID_PISO,
				ID_UNIDAD_PREDIAL
			into
				nuID_PROYECTO,
				nuID_TORRE,
				nuID_PISO,
				nuID_UNIDAD_PREDIAL;
		end if;
		if
			nuID_PROYECTO is NULL OR
			nuID_TORRE is NULL OR
			nuID_PISO is NULL OR
			nuID_UNIDAD_PREDIAL is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_UNIDAD_PREDIAL));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_UNIDAD_PREDIAL in out nocopy tytbLDC_UNIDAD_PREDIAL,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_UNIDAD_PREDIAL;
	BEGIN
		FillRecordOfTables(iotbLDC_UNIDAD_PREDIAL,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_UNIDAD_PREDIAL.first .. iotbLDC_UNIDAD_PREDIAL.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_UNIDAD_PREDIAL.first .. iotbLDC_UNIDAD_PREDIAL.last
				update LDC_UNIDAD_PREDIAL
				set
					DESCRIPCION = rcRecOfTab.DESCRIPCION(n),
					ID_TIPO_UNID_PRED = rcRecOfTab.ID_TIPO_UNID_PRED(n),
					FECH_CREACION = rcRecOfTab.FECH_CREACION(n),
					ID_UNIDAD_PREDIAL_UNICO = rcRecOfTab.ID_UNIDAD_PREDIAL_UNICO(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_UNIDAD_PREDIAL.first .. iotbLDC_UNIDAD_PREDIAL.last loop
					LockByPk
					(
						rcRecOfTab.ID_PROYECTO(n),
						rcRecOfTab.ID_TORRE(n),
						rcRecOfTab.ID_PISO(n),
						rcRecOfTab.ID_UNIDAD_PREDIAL(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_UNIDAD_PREDIAL.first .. iotbLDC_UNIDAD_PREDIAL.last
				update LDC_UNIDAD_PREDIAL
				SET
					DESCRIPCION = rcRecOfTab.DESCRIPCION(n),
					ID_TIPO_UNID_PRED = rcRecOfTab.ID_TIPO_UNID_PRED(n),
					FECH_CREACION = rcRecOfTab.FECH_CREACION(n),
					ID_UNIDAD_PREDIAL_UNICO = rcRecOfTab.ID_UNIDAD_PREDIAL_UNICO(n)
				where
					ID_PROYECTO = rcRecOfTab.ID_PROYECTO(n) and
					ID_TORRE = rcRecOfTab.ID_TORRE(n) and
					ID_PISO = rcRecOfTab.ID_PISO(n) and
					ID_UNIDAD_PREDIAL = rcRecOfTab.ID_UNIDAD_PREDIAL(n)
;
		end if;
	END;
	PROCEDURE updDESCRIPCION
	(
		inuID_PROYECTO in LDC_UNIDAD_PREDIAL.ID_PROYECTO%type,
		inuID_TORRE in LDC_UNIDAD_PREDIAL.ID_TORRE%type,
		inuID_PISO in LDC_UNIDAD_PREDIAL.ID_PISO%type,
		inuID_UNIDAD_PREDIAL in LDC_UNIDAD_PREDIAL.ID_UNIDAD_PREDIAL%type,
		isbDESCRIPCION$ in LDC_UNIDAD_PREDIAL.DESCRIPCION%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_UNIDAD_PREDIAL;
	BEGIN
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_TORRE := inuID_TORRE;
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_UNIDAD_PREDIAL := inuID_UNIDAD_PREDIAL;
		if inuLock=1 then
			LockByPk
			(
				inuID_PROYECTO,
				inuID_TORRE,
				inuID_PISO,
				inuID_UNIDAD_PREDIAL,
				rcData
			);
		end if;

		update LDC_UNIDAD_PREDIAL
		set
			DESCRIPCION = isbDESCRIPCION$
		where
			ID_PROYECTO = inuID_PROYECTO and
			ID_TORRE = inuID_TORRE and
			ID_PISO = inuID_PISO and
			ID_UNIDAD_PREDIAL = inuID_UNIDAD_PREDIAL;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DESCRIPCION:= isbDESCRIPCION$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updID_TIPO_UNID_PRED
	(
		inuID_PROYECTO in LDC_UNIDAD_PREDIAL.ID_PROYECTO%type,
		inuID_TORRE in LDC_UNIDAD_PREDIAL.ID_TORRE%type,
		inuID_PISO in LDC_UNIDAD_PREDIAL.ID_PISO%type,
		inuID_UNIDAD_PREDIAL in LDC_UNIDAD_PREDIAL.ID_UNIDAD_PREDIAL%type,
		inuID_TIPO_UNID_PRED$ in LDC_UNIDAD_PREDIAL.ID_TIPO_UNID_PRED%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_UNIDAD_PREDIAL;
	BEGIN
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_TORRE := inuID_TORRE;
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_UNIDAD_PREDIAL := inuID_UNIDAD_PREDIAL;
		if inuLock=1 then
			LockByPk
			(
				inuID_PROYECTO,
				inuID_TORRE,
				inuID_PISO,
				inuID_UNIDAD_PREDIAL,
				rcData
			);
		end if;

		update LDC_UNIDAD_PREDIAL
		set
			ID_TIPO_UNID_PRED = inuID_TIPO_UNID_PRED$
		where
			ID_PROYECTO = inuID_PROYECTO and
			ID_TORRE = inuID_TORRE and
			ID_PISO = inuID_PISO and
			ID_UNIDAD_PREDIAL = inuID_UNIDAD_PREDIAL;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ID_TIPO_UNID_PRED:= inuID_TIPO_UNID_PRED$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFECH_CREACION
	(
		inuID_PROYECTO in LDC_UNIDAD_PREDIAL.ID_PROYECTO%type,
		inuID_TORRE in LDC_UNIDAD_PREDIAL.ID_TORRE%type,
		inuID_PISO in LDC_UNIDAD_PREDIAL.ID_PISO%type,
		inuID_UNIDAD_PREDIAL in LDC_UNIDAD_PREDIAL.ID_UNIDAD_PREDIAL%type,
		idtFECH_CREACION$ in LDC_UNIDAD_PREDIAL.FECH_CREACION%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_UNIDAD_PREDIAL;
	BEGIN
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_TORRE := inuID_TORRE;
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_UNIDAD_PREDIAL := inuID_UNIDAD_PREDIAL;
		if inuLock=1 then
			LockByPk
			(
				inuID_PROYECTO,
				inuID_TORRE,
				inuID_PISO,
				inuID_UNIDAD_PREDIAL,
				rcData
			);
		end if;

		update LDC_UNIDAD_PREDIAL
		set
			FECH_CREACION = idtFECH_CREACION$
		where
			ID_PROYECTO = inuID_PROYECTO and
			ID_TORRE = inuID_TORRE and
			ID_PISO = inuID_PISO and
			ID_UNIDAD_PREDIAL = inuID_UNIDAD_PREDIAL;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FECH_CREACION:= idtFECH_CREACION$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updID_UNIDAD_PREDIAL_UNICO
	(
		inuID_PROYECTO in LDC_UNIDAD_PREDIAL.ID_PROYECTO%type,
		inuID_TORRE in LDC_UNIDAD_PREDIAL.ID_TORRE%type,
		inuID_PISO in LDC_UNIDAD_PREDIAL.ID_PISO%type,
		inuID_UNIDAD_PREDIAL in LDC_UNIDAD_PREDIAL.ID_UNIDAD_PREDIAL%type,
		inuID_UNIDAD_PREDIAL_UNICO$ in LDC_UNIDAD_PREDIAL.ID_UNIDAD_PREDIAL_UNICO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_UNIDAD_PREDIAL;
	BEGIN
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_TORRE := inuID_TORRE;
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_UNIDAD_PREDIAL := inuID_UNIDAD_PREDIAL;
		if inuLock=1 then
			LockByPk
			(
				inuID_PROYECTO,
				inuID_TORRE,
				inuID_PISO,
				inuID_UNIDAD_PREDIAL,
				rcData
			);
		end if;

		update LDC_UNIDAD_PREDIAL
		set
			ID_UNIDAD_PREDIAL_UNICO = inuID_UNIDAD_PREDIAL_UNICO$
		where
			ID_PROYECTO = inuID_PROYECTO and
			ID_TORRE = inuID_TORRE and
			ID_PISO = inuID_PISO and
			ID_UNIDAD_PREDIAL = inuID_UNIDAD_PREDIAL;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ID_UNIDAD_PREDIAL_UNICO:= inuID_UNIDAD_PREDIAL_UNICO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetID_UNIDAD_PREDIAL
	(
		inuID_PROYECTO in LDC_UNIDAD_PREDIAL.ID_PROYECTO%type,
		inuID_TORRE in LDC_UNIDAD_PREDIAL.ID_TORRE%type,
		inuID_PISO in LDC_UNIDAD_PREDIAL.ID_PISO%type,
		inuID_UNIDAD_PREDIAL in LDC_UNIDAD_PREDIAL.ID_UNIDAD_PREDIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_UNIDAD_PREDIAL.ID_UNIDAD_PREDIAL%type
	IS
		rcError styLDC_UNIDAD_PREDIAL;
	BEGIN

		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_TORRE := inuID_TORRE;
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_UNIDAD_PREDIAL := inuID_UNIDAD_PREDIAL;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PROYECTO,
		 		inuID_TORRE,
		 		inuID_PISO,
		 		inuID_UNIDAD_PREDIAL
			 )
		then
			 return(rcData.ID_UNIDAD_PREDIAL);
		end if;
		Load
		(
		 		inuID_PROYECTO,
		 		inuID_TORRE,
		 		inuID_PISO,
		 		inuID_UNIDAD_PREDIAL
		);
		return(rcData.ID_UNIDAD_PREDIAL);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetDESCRIPCION
	(
		inuID_PROYECTO in LDC_UNIDAD_PREDIAL.ID_PROYECTO%type,
		inuID_TORRE in LDC_UNIDAD_PREDIAL.ID_TORRE%type,
		inuID_PISO in LDC_UNIDAD_PREDIAL.ID_PISO%type,
		inuID_UNIDAD_PREDIAL in LDC_UNIDAD_PREDIAL.ID_UNIDAD_PREDIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_UNIDAD_PREDIAL.DESCRIPCION%type
	IS
		rcError styLDC_UNIDAD_PREDIAL;
	BEGIN

		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_TORRE := inuID_TORRE;
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_UNIDAD_PREDIAL := inuID_UNIDAD_PREDIAL;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PROYECTO,
		 		inuID_TORRE,
		 		inuID_PISO,
		 		inuID_UNIDAD_PREDIAL
			 )
		then
			 return(rcData.DESCRIPCION);
		end if;
		Load
		(
		 		inuID_PROYECTO,
		 		inuID_TORRE,
		 		inuID_PISO,
		 		inuID_UNIDAD_PREDIAL
		);
		return(rcData.DESCRIPCION);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetID_PROYECTO
	(
		inuID_PROYECTO in LDC_UNIDAD_PREDIAL.ID_PROYECTO%type,
		inuID_TORRE in LDC_UNIDAD_PREDIAL.ID_TORRE%type,
		inuID_PISO in LDC_UNIDAD_PREDIAL.ID_PISO%type,
		inuID_UNIDAD_PREDIAL in LDC_UNIDAD_PREDIAL.ID_UNIDAD_PREDIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_UNIDAD_PREDIAL.ID_PROYECTO%type
	IS
		rcError styLDC_UNIDAD_PREDIAL;
	BEGIN

		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_TORRE := inuID_TORRE;
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_UNIDAD_PREDIAL := inuID_UNIDAD_PREDIAL;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PROYECTO,
		 		inuID_TORRE,
		 		inuID_PISO,
		 		inuID_UNIDAD_PREDIAL
			 )
		then
			 return(rcData.ID_PROYECTO);
		end if;
		Load
		(
		 		inuID_PROYECTO,
		 		inuID_TORRE,
		 		inuID_PISO,
		 		inuID_UNIDAD_PREDIAL
		);
		return(rcData.ID_PROYECTO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetID_TIPO_UNID_PRED
	(
		inuID_PROYECTO in LDC_UNIDAD_PREDIAL.ID_PROYECTO%type,
		inuID_TORRE in LDC_UNIDAD_PREDIAL.ID_TORRE%type,
		inuID_PISO in LDC_UNIDAD_PREDIAL.ID_PISO%type,
		inuID_UNIDAD_PREDIAL in LDC_UNIDAD_PREDIAL.ID_UNIDAD_PREDIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_UNIDAD_PREDIAL.ID_TIPO_UNID_PRED%type
	IS
		rcError styLDC_UNIDAD_PREDIAL;
	BEGIN

		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_TORRE := inuID_TORRE;
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_UNIDAD_PREDIAL := inuID_UNIDAD_PREDIAL;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PROYECTO,
		 		inuID_TORRE,
		 		inuID_PISO,
		 		inuID_UNIDAD_PREDIAL
			 )
		then
			 return(rcData.ID_TIPO_UNID_PRED);
		end if;
		Load
		(
		 		inuID_PROYECTO,
		 		inuID_TORRE,
		 		inuID_PISO,
		 		inuID_UNIDAD_PREDIAL
		);
		return(rcData.ID_TIPO_UNID_PRED);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetID_PISO
	(
		inuID_PROYECTO in LDC_UNIDAD_PREDIAL.ID_PROYECTO%type,
		inuID_TORRE in LDC_UNIDAD_PREDIAL.ID_TORRE%type,
		inuID_PISO in LDC_UNIDAD_PREDIAL.ID_PISO%type,
		inuID_UNIDAD_PREDIAL in LDC_UNIDAD_PREDIAL.ID_UNIDAD_PREDIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_UNIDAD_PREDIAL.ID_PISO%type
	IS
		rcError styLDC_UNIDAD_PREDIAL;
	BEGIN

		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_TORRE := inuID_TORRE;
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_UNIDAD_PREDIAL := inuID_UNIDAD_PREDIAL;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PROYECTO,
		 		inuID_TORRE,
		 		inuID_PISO,
		 		inuID_UNIDAD_PREDIAL
			 )
		then
			 return(rcData.ID_PISO);
		end if;
		Load
		(
		 		inuID_PROYECTO,
		 		inuID_TORRE,
		 		inuID_PISO,
		 		inuID_UNIDAD_PREDIAL
		);
		return(rcData.ID_PISO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetFECH_CREACION
	(
		inuID_PROYECTO in LDC_UNIDAD_PREDIAL.ID_PROYECTO%type,
		inuID_TORRE in LDC_UNIDAD_PREDIAL.ID_TORRE%type,
		inuID_PISO in LDC_UNIDAD_PREDIAL.ID_PISO%type,
		inuID_UNIDAD_PREDIAL in LDC_UNIDAD_PREDIAL.ID_UNIDAD_PREDIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_UNIDAD_PREDIAL.FECH_CREACION%type
	IS
		rcError styLDC_UNIDAD_PREDIAL;
	BEGIN

		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_TORRE := inuID_TORRE;
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_UNIDAD_PREDIAL := inuID_UNIDAD_PREDIAL;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PROYECTO,
		 		inuID_TORRE,
		 		inuID_PISO,
		 		inuID_UNIDAD_PREDIAL
			 )
		then
			 return(rcData.FECH_CREACION);
		end if;
		Load
		(
		 		inuID_PROYECTO,
		 		inuID_TORRE,
		 		inuID_PISO,
		 		inuID_UNIDAD_PREDIAL
		);
		return(rcData.FECH_CREACION);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetID_TORRE
	(
		inuID_PROYECTO in LDC_UNIDAD_PREDIAL.ID_PROYECTO%type,
		inuID_TORRE in LDC_UNIDAD_PREDIAL.ID_TORRE%type,
		inuID_PISO in LDC_UNIDAD_PREDIAL.ID_PISO%type,
		inuID_UNIDAD_PREDIAL in LDC_UNIDAD_PREDIAL.ID_UNIDAD_PREDIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_UNIDAD_PREDIAL.ID_TORRE%type
	IS
		rcError styLDC_UNIDAD_PREDIAL;
	BEGIN

		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_TORRE := inuID_TORRE;
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_UNIDAD_PREDIAL := inuID_UNIDAD_PREDIAL;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PROYECTO,
		 		inuID_TORRE,
		 		inuID_PISO,
		 		inuID_UNIDAD_PREDIAL
			 )
		then
			 return(rcData.ID_TORRE);
		end if;
		Load
		(
		 		inuID_PROYECTO,
		 		inuID_TORRE,
		 		inuID_PISO,
		 		inuID_UNIDAD_PREDIAL
		);
		return(rcData.ID_TORRE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetID_UNIDAD_PREDIAL_UNICO
	(
		inuID_PROYECTO in LDC_UNIDAD_PREDIAL.ID_PROYECTO%type,
		inuID_TORRE in LDC_UNIDAD_PREDIAL.ID_TORRE%type,
		inuID_PISO in LDC_UNIDAD_PREDIAL.ID_PISO%type,
		inuID_UNIDAD_PREDIAL in LDC_UNIDAD_PREDIAL.ID_UNIDAD_PREDIAL%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_UNIDAD_PREDIAL.ID_UNIDAD_PREDIAL_UNICO%type
	IS
		rcError styLDC_UNIDAD_PREDIAL;
	BEGIN

		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.ID_TORRE := inuID_TORRE;
		rcError.ID_PISO := inuID_PISO;
		rcError.ID_UNIDAD_PREDIAL := inuID_UNIDAD_PREDIAL;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PROYECTO,
		 		inuID_TORRE,
		 		inuID_PISO,
		 		inuID_UNIDAD_PREDIAL
			 )
		then
			 return(rcData.ID_UNIDAD_PREDIAL_UNICO);
		end if;
		Load
		(
		 		inuID_PROYECTO,
		 		inuID_TORRE,
		 		inuID_PISO,
		 		inuID_UNIDAD_PREDIAL
		);
		return(rcData.ID_UNIDAD_PREDIAL_UNICO);
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
end DALDC_UNIDAD_PREDIAL;
/
PROMPT Otorgando permisos de ejecucion a DALDC_UNIDAD_PREDIAL
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_UNIDAD_PREDIAL', 'ADM_PERSON');
END;
/