CREATE OR REPLACE PACKAGE ADM_PERSON.DALDC_EQUIVAL_UNID_PRED
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
		inuCONSECUTIVO in LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type
	)
	IS
		SELECT LDC_EQUIVAL_UNID_PRED.*,LDC_EQUIVAL_UNID_PRED.rowid
		FROM LDC_EQUIVAL_UNID_PRED
		WHERE
		    CONSECUTIVO = inuCONSECUTIVO;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_EQUIVAL_UNID_PRED.*,LDC_EQUIVAL_UNID_PRED.rowid
		FROM LDC_EQUIVAL_UNID_PRED
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_EQUIVAL_UNID_PRED  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_EQUIVAL_UNID_PRED is table of styLDC_EQUIVAL_UNID_PRED index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_EQUIVAL_UNID_PRED;

	/* Tipos referenciando al registro */
	type tytbACTIVA is table of LDC_EQUIVAL_UNID_PRED.ACTIVA%type index by binary_integer;
	type tytbCONSECUTIVO is table of LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type index by binary_integer;
	type tytbID_DIRECCION is table of LDC_EQUIVAL_UNID_PRED.ID_DIRECCION%type index by binary_integer;
	type tytbID_UNIDAD_PREDIAL is table of LDC_EQUIVAL_UNID_PRED.ID_UNIDAD_PREDIAL%type index by binary_integer;
	type tytbID_SOLICITUD is table of LDC_EQUIVAL_UNID_PRED.ID_SOLICITUD%type index by binary_integer;
	type tytbFECHA_EQUIV is table of LDC_EQUIVAL_UNID_PRED.FECHA_EQUIV%type index by binary_integer;
	type tytbSUBROG_APROB is table of LDC_EQUIVAL_UNID_PRED.SUBROG_APROB%type index by binary_integer;
	type tytbUSUA_APRUEBA is table of LDC_EQUIVAL_UNID_PRED.USUA_APRUEBA%type index by binary_integer;
	type tytbFECHA_APROB is table of LDC_EQUIVAL_UNID_PRED.FECHA_APROB%type index by binary_integer;
	type tytbID_PROYECTO is table of LDC_EQUIVAL_UNID_PRED.ID_PROYECTO%type index by binary_integer;
	type tytbID_TORRE is table of LDC_EQUIVAL_UNID_PRED.ID_TORRE%type index by binary_integer;
	type tytbID_PISO is table of LDC_EQUIVAL_UNID_PRED.ID_PISO%type index by binary_integer;
	type tytbID_UNIDAD_PREDIAL_UNICO is table of LDC_EQUIVAL_UNID_PRED.ID_UNIDAD_PREDIAL_UNICO%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_EQUIVAL_UNID_PRED is record
	(
		ACTIVA   tytbACTIVA,
		CONSECUTIVO   tytbCONSECUTIVO,
		ID_DIRECCION   tytbID_DIRECCION,
		ID_UNIDAD_PREDIAL   tytbID_UNIDAD_PREDIAL,
		ID_SOLICITUD   tytbID_SOLICITUD,
		FECHA_EQUIV   tytbFECHA_EQUIV,
		SUBROG_APROB   tytbSUBROG_APROB,
		USUA_APRUEBA   tytbUSUA_APRUEBA,
		FECHA_APROB   tytbFECHA_APROB,
		ID_PROYECTO   tytbID_PROYECTO,
		ID_TORRE   tytbID_TORRE,
		ID_PISO   tytbID_PISO,
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
		inuCONSECUTIVO in LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuCONSECUTIVO in LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuCONSECUTIVO in LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type
	);

	PROCEDURE getRecord
	(
		inuCONSECUTIVO in LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type,
		orcRecord out nocopy styLDC_EQUIVAL_UNID_PRED
	);

	FUNCTION frcGetRcData
	(
		inuCONSECUTIVO in LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type
	)
	RETURN styLDC_EQUIVAL_UNID_PRED;

	FUNCTION frcGetRcData
	RETURN styLDC_EQUIVAL_UNID_PRED;

	FUNCTION frcGetRecord
	(
		inuCONSECUTIVO in LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type
	)
	RETURN styLDC_EQUIVAL_UNID_PRED;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_EQUIVAL_UNID_PRED
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_EQUIVAL_UNID_PRED in styLDC_EQUIVAL_UNID_PRED
	);

	PROCEDURE insRecord
	(
		ircLDC_EQUIVAL_UNID_PRED in styLDC_EQUIVAL_UNID_PRED,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_EQUIVAL_UNID_PRED in out nocopy tytbLDC_EQUIVAL_UNID_PRED
	);

	PROCEDURE delRecord
	(
		inuCONSECUTIVO in LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_EQUIVAL_UNID_PRED in out nocopy tytbLDC_EQUIVAL_UNID_PRED,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_EQUIVAL_UNID_PRED in styLDC_EQUIVAL_UNID_PRED,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_EQUIVAL_UNID_PRED in out nocopy tytbLDC_EQUIVAL_UNID_PRED,
		inuLock in number default 1
	);

	PROCEDURE updACTIVA
	(
		inuCONSECUTIVO in LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type,
		isbACTIVA$ in LDC_EQUIVAL_UNID_PRED.ACTIVA%type,
		inuLock in number default 0
	);

	PROCEDURE updID_DIRECCION
	(
		inuCONSECUTIVO in LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type,
		inuID_DIRECCION$ in LDC_EQUIVAL_UNID_PRED.ID_DIRECCION%type,
		inuLock in number default 0
	);

	PROCEDURE updID_UNIDAD_PREDIAL
	(
		inuCONSECUTIVO in LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type,
		inuID_UNIDAD_PREDIAL$ in LDC_EQUIVAL_UNID_PRED.ID_UNIDAD_PREDIAL%type,
		inuLock in number default 0
	);

	PROCEDURE updID_SOLICITUD
	(
		inuCONSECUTIVO in LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type,
		inuID_SOLICITUD$ in LDC_EQUIVAL_UNID_PRED.ID_SOLICITUD%type,
		inuLock in number default 0
	);

	PROCEDURE updFECHA_EQUIV
	(
		inuCONSECUTIVO in LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type,
		idtFECHA_EQUIV$ in LDC_EQUIVAL_UNID_PRED.FECHA_EQUIV%type,
		inuLock in number default 0
	);

	PROCEDURE updSUBROG_APROB
	(
		inuCONSECUTIVO in LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type,
		isbSUBROG_APROB$ in LDC_EQUIVAL_UNID_PRED.SUBROG_APROB%type,
		inuLock in number default 0
	);

	PROCEDURE updUSUA_APRUEBA
	(
		inuCONSECUTIVO in LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type,
		isbUSUA_APRUEBA$ in LDC_EQUIVAL_UNID_PRED.USUA_APRUEBA%type,
		inuLock in number default 0
	);

	PROCEDURE updFECHA_APROB
	(
		inuCONSECUTIVO in LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type,
		idtFECHA_APROB$ in LDC_EQUIVAL_UNID_PRED.FECHA_APROB%type,
		inuLock in number default 0
	);

	PROCEDURE updID_PROYECTO
	(
		inuCONSECUTIVO in LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type,
		inuID_PROYECTO$ in LDC_EQUIVAL_UNID_PRED.ID_PROYECTO%type,
		inuLock in number default 0
	);

	PROCEDURE updID_TORRE
	(
		inuCONSECUTIVO in LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type,
		inuID_TORRE$ in LDC_EQUIVAL_UNID_PRED.ID_TORRE%type,
		inuLock in number default 0
	);

	PROCEDURE updID_PISO
	(
		inuCONSECUTIVO in LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type,
		inuID_PISO$ in LDC_EQUIVAL_UNID_PRED.ID_PISO%type,
		inuLock in number default 0
	);

	PROCEDURE updID_UNIDAD_PREDIAL_UNICO
	(
		inuCONSECUTIVO in LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type,
		inuID_UNIDAD_PREDIAL_UNICO$ in LDC_EQUIVAL_UNID_PRED.ID_UNIDAD_PREDIAL_UNICO%type,
		inuLock in number default 0
	);

	FUNCTION fsbGetACTIVA
	(
		inuCONSECUTIVO in LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_EQUIVAL_UNID_PRED.ACTIVA%type;

	FUNCTION fnuGetCONSECUTIVO
	(
		inuCONSECUTIVO in LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type;

	FUNCTION fnuGetID_DIRECCION
	(
		inuCONSECUTIVO in LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_EQUIVAL_UNID_PRED.ID_DIRECCION%type;

	FUNCTION fnuGetID_UNIDAD_PREDIAL
	(
		inuCONSECUTIVO in LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_EQUIVAL_UNID_PRED.ID_UNIDAD_PREDIAL%type;

	FUNCTION fnuGetID_SOLICITUD
	(
		inuCONSECUTIVO in LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_EQUIVAL_UNID_PRED.ID_SOLICITUD%type;

	FUNCTION fdtGetFECHA_EQUIV
	(
		inuCONSECUTIVO in LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_EQUIVAL_UNID_PRED.FECHA_EQUIV%type;

	FUNCTION fsbGetSUBROG_APROB
	(
		inuCONSECUTIVO in LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_EQUIVAL_UNID_PRED.SUBROG_APROB%type;

	FUNCTION fsbGetUSUA_APRUEBA
	(
		inuCONSECUTIVO in LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_EQUIVAL_UNID_PRED.USUA_APRUEBA%type;

	FUNCTION fdtGetFECHA_APROB
	(
		inuCONSECUTIVO in LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_EQUIVAL_UNID_PRED.FECHA_APROB%type;

	FUNCTION fnuGetID_PROYECTO
	(
		inuCONSECUTIVO in LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_EQUIVAL_UNID_PRED.ID_PROYECTO%type;

	FUNCTION fnuGetID_TORRE
	(
		inuCONSECUTIVO in LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_EQUIVAL_UNID_PRED.ID_TORRE%type;

	FUNCTION fnuGetID_PISO
	(
		inuCONSECUTIVO in LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_EQUIVAL_UNID_PRED.ID_PISO%type;

	FUNCTION fnuGetID_UNIDAD_PREDIAL_UNICO
	(
		inuCONSECUTIVO in LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_EQUIVAL_UNID_PRED.ID_UNIDAD_PREDIAL_UNICO%type;


	PROCEDURE LockByPk
	(
		inuCONSECUTIVO in LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type,
		orcLDC_EQUIVAL_UNID_PRED  out styLDC_EQUIVAL_UNID_PRED
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_EQUIVAL_UNID_PRED  out styLDC_EQUIVAL_UNID_PRED
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_EQUIVAL_UNID_PRED;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALDC_EQUIVAL_UNID_PRED
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_EQUIVAL_UNID_PRED';
	 cnuGeEntityId constant varchar2(30) := 2874; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuCONSECUTIVO in LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type
	)
	IS
		SELECT LDC_EQUIVAL_UNID_PRED.*,LDC_EQUIVAL_UNID_PRED.rowid
		FROM LDC_EQUIVAL_UNID_PRED
		WHERE  CONSECUTIVO = inuCONSECUTIVO
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_EQUIVAL_UNID_PRED.*,LDC_EQUIVAL_UNID_PRED.rowid
		FROM LDC_EQUIVAL_UNID_PRED
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_EQUIVAL_UNID_PRED is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_EQUIVAL_UNID_PRED;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_EQUIVAL_UNID_PRED default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.CONSECUTIVO);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuCONSECUTIVO in LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type,
		orcLDC_EQUIVAL_UNID_PRED  out styLDC_EQUIVAL_UNID_PRED
	)
	IS
		rcError styLDC_EQUIVAL_UNID_PRED;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;

		Open cuLockRcByPk
		(
			inuCONSECUTIVO
		);

		fetch cuLockRcByPk into orcLDC_EQUIVAL_UNID_PRED;
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
		orcLDC_EQUIVAL_UNID_PRED  out styLDC_EQUIVAL_UNID_PRED
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_EQUIVAL_UNID_PRED;
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
		itbLDC_EQUIVAL_UNID_PRED  in out nocopy tytbLDC_EQUIVAL_UNID_PRED
	)
	IS
	BEGIN
			rcRecOfTab.ACTIVA.delete;
			rcRecOfTab.CONSECUTIVO.delete;
			rcRecOfTab.ID_DIRECCION.delete;
			rcRecOfTab.ID_UNIDAD_PREDIAL.delete;
			rcRecOfTab.ID_SOLICITUD.delete;
			rcRecOfTab.FECHA_EQUIV.delete;
			rcRecOfTab.SUBROG_APROB.delete;
			rcRecOfTab.USUA_APRUEBA.delete;
			rcRecOfTab.FECHA_APROB.delete;
			rcRecOfTab.ID_PROYECTO.delete;
			rcRecOfTab.ID_TORRE.delete;
			rcRecOfTab.ID_PISO.delete;
			rcRecOfTab.ID_UNIDAD_PREDIAL_UNICO.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_EQUIVAL_UNID_PRED  in out nocopy tytbLDC_EQUIVAL_UNID_PRED,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_EQUIVAL_UNID_PRED);

		for n in itbLDC_EQUIVAL_UNID_PRED.first .. itbLDC_EQUIVAL_UNID_PRED.last loop
			rcRecOfTab.ACTIVA(n) := itbLDC_EQUIVAL_UNID_PRED(n).ACTIVA;
			rcRecOfTab.CONSECUTIVO(n) := itbLDC_EQUIVAL_UNID_PRED(n).CONSECUTIVO;
			rcRecOfTab.ID_DIRECCION(n) := itbLDC_EQUIVAL_UNID_PRED(n).ID_DIRECCION;
			rcRecOfTab.ID_UNIDAD_PREDIAL(n) := itbLDC_EQUIVAL_UNID_PRED(n).ID_UNIDAD_PREDIAL;
			rcRecOfTab.ID_SOLICITUD(n) := itbLDC_EQUIVAL_UNID_PRED(n).ID_SOLICITUD;
			rcRecOfTab.FECHA_EQUIV(n) := itbLDC_EQUIVAL_UNID_PRED(n).FECHA_EQUIV;
			rcRecOfTab.SUBROG_APROB(n) := itbLDC_EQUIVAL_UNID_PRED(n).SUBROG_APROB;
			rcRecOfTab.USUA_APRUEBA(n) := itbLDC_EQUIVAL_UNID_PRED(n).USUA_APRUEBA;
			rcRecOfTab.FECHA_APROB(n) := itbLDC_EQUIVAL_UNID_PRED(n).FECHA_APROB;
			rcRecOfTab.ID_PROYECTO(n) := itbLDC_EQUIVAL_UNID_PRED(n).ID_PROYECTO;
			rcRecOfTab.ID_TORRE(n) := itbLDC_EQUIVAL_UNID_PRED(n).ID_TORRE;
			rcRecOfTab.ID_PISO(n) := itbLDC_EQUIVAL_UNID_PRED(n).ID_PISO;
			rcRecOfTab.ID_UNIDAD_PREDIAL_UNICO(n) := itbLDC_EQUIVAL_UNID_PRED(n).ID_UNIDAD_PREDIAL_UNICO;
			rcRecOfTab.row_id(n) := itbLDC_EQUIVAL_UNID_PRED(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuCONSECUTIVO in LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuCONSECUTIVO
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
		inuCONSECUTIVO in LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuCONSECUTIVO = rcData.CONSECUTIVO
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
		inuCONSECUTIVO in LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuCONSECUTIVO
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuCONSECUTIVO in LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type
	)
	IS
		rcError styLDC_EQUIVAL_UNID_PRED;
	BEGIN		rcError.CONSECUTIVO:=inuCONSECUTIVO;

		Load
		(
			inuCONSECUTIVO
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
		inuCONSECUTIVO in LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type
	)
	IS
	BEGIN
		Load
		(
			inuCONSECUTIVO
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuCONSECUTIVO in LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type,
		orcRecord out nocopy styLDC_EQUIVAL_UNID_PRED
	)
	IS
		rcError styLDC_EQUIVAL_UNID_PRED;
	BEGIN		rcError.CONSECUTIVO:=inuCONSECUTIVO;

		Load
		(
			inuCONSECUTIVO
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuCONSECUTIVO in LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type
	)
	RETURN styLDC_EQUIVAL_UNID_PRED
	IS
		rcError styLDC_EQUIVAL_UNID_PRED;
	BEGIN
		rcError.CONSECUTIVO:=inuCONSECUTIVO;

		Load
		(
			inuCONSECUTIVO
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuCONSECUTIVO in LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type
	)
	RETURN styLDC_EQUIVAL_UNID_PRED
	IS
		rcError styLDC_EQUIVAL_UNID_PRED;
	BEGIN
		rcError.CONSECUTIVO:=inuCONSECUTIVO;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuCONSECUTIVO
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuCONSECUTIVO
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_EQUIVAL_UNID_PRED
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_EQUIVAL_UNID_PRED
	)
	IS
		rfLDC_EQUIVAL_UNID_PRED tyrfLDC_EQUIVAL_UNID_PRED;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_EQUIVAL_UNID_PRED.*, LDC_EQUIVAL_UNID_PRED.rowid FROM LDC_EQUIVAL_UNID_PRED';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_EQUIVAL_UNID_PRED for sbFullQuery;

		fetch rfLDC_EQUIVAL_UNID_PRED bulk collect INTO otbResult;

		close rfLDC_EQUIVAL_UNID_PRED;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_EQUIVAL_UNID_PRED.*, LDC_EQUIVAL_UNID_PRED.rowid FROM LDC_EQUIVAL_UNID_PRED';
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
		ircLDC_EQUIVAL_UNID_PRED in styLDC_EQUIVAL_UNID_PRED
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_EQUIVAL_UNID_PRED,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_EQUIVAL_UNID_PRED in styLDC_EQUIVAL_UNID_PRED,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_EQUIVAL_UNID_PRED.CONSECUTIVO is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|CONSECUTIVO');
			raise ex.controlled_error;
		end if;

		insert into LDC_EQUIVAL_UNID_PRED
		(
			ACTIVA,
			CONSECUTIVO,
			ID_DIRECCION,
			ID_UNIDAD_PREDIAL,
			ID_SOLICITUD,
			FECHA_EQUIV,
			SUBROG_APROB,
			USUA_APRUEBA,
			FECHA_APROB,
			ID_PROYECTO,
			ID_TORRE,
			ID_PISO,
			ID_UNIDAD_PREDIAL_UNICO
		)
		values
		(
			ircLDC_EQUIVAL_UNID_PRED.ACTIVA,
			ircLDC_EQUIVAL_UNID_PRED.CONSECUTIVO,
			ircLDC_EQUIVAL_UNID_PRED.ID_DIRECCION,
			ircLDC_EQUIVAL_UNID_PRED.ID_UNIDAD_PREDIAL,
			ircLDC_EQUIVAL_UNID_PRED.ID_SOLICITUD,
			ircLDC_EQUIVAL_UNID_PRED.FECHA_EQUIV,
			ircLDC_EQUIVAL_UNID_PRED.SUBROG_APROB,
			ircLDC_EQUIVAL_UNID_PRED.USUA_APRUEBA,
			ircLDC_EQUIVAL_UNID_PRED.FECHA_APROB,
			ircLDC_EQUIVAL_UNID_PRED.ID_PROYECTO,
			ircLDC_EQUIVAL_UNID_PRED.ID_TORRE,
			ircLDC_EQUIVAL_UNID_PRED.ID_PISO,
			ircLDC_EQUIVAL_UNID_PRED.ID_UNIDAD_PREDIAL_UNICO
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_EQUIVAL_UNID_PRED));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_EQUIVAL_UNID_PRED in out nocopy tytbLDC_EQUIVAL_UNID_PRED
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_EQUIVAL_UNID_PRED,blUseRowID);
		forall n in iotbLDC_EQUIVAL_UNID_PRED.first..iotbLDC_EQUIVAL_UNID_PRED.last
			insert into LDC_EQUIVAL_UNID_PRED
			(
				ACTIVA,
				CONSECUTIVO,
				ID_DIRECCION,
				ID_UNIDAD_PREDIAL,
				ID_SOLICITUD,
				FECHA_EQUIV,
				SUBROG_APROB,
				USUA_APRUEBA,
				FECHA_APROB,
				ID_PROYECTO,
				ID_TORRE,
				ID_PISO,
				ID_UNIDAD_PREDIAL_UNICO
			)
			values
			(
				rcRecOfTab.ACTIVA(n),
				rcRecOfTab.CONSECUTIVO(n),
				rcRecOfTab.ID_DIRECCION(n),
				rcRecOfTab.ID_UNIDAD_PREDIAL(n),
				rcRecOfTab.ID_SOLICITUD(n),
				rcRecOfTab.FECHA_EQUIV(n),
				rcRecOfTab.SUBROG_APROB(n),
				rcRecOfTab.USUA_APRUEBA(n),
				rcRecOfTab.FECHA_APROB(n),
				rcRecOfTab.ID_PROYECTO(n),
				rcRecOfTab.ID_TORRE(n),
				rcRecOfTab.ID_PISO(n),
				rcRecOfTab.ID_UNIDAD_PREDIAL_UNICO(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuCONSECUTIVO in LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_EQUIVAL_UNID_PRED;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;

		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;


		delete
		from LDC_EQUIVAL_UNID_PRED
		where
       		CONSECUTIVO=inuCONSECUTIVO;
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
		rcError  styLDC_EQUIVAL_UNID_PRED;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_EQUIVAL_UNID_PRED
		where
			rowid = iriRowID
		returning
			ACTIVA
		into
			rcError.ACTIVA;
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
		iotbLDC_EQUIVAL_UNID_PRED in out nocopy tytbLDC_EQUIVAL_UNID_PRED,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_EQUIVAL_UNID_PRED;
	BEGIN
		FillRecordOfTables(iotbLDC_EQUIVAL_UNID_PRED, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_EQUIVAL_UNID_PRED.first .. iotbLDC_EQUIVAL_UNID_PRED.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_EQUIVAL_UNID_PRED.first .. iotbLDC_EQUIVAL_UNID_PRED.last
				delete
				from LDC_EQUIVAL_UNID_PRED
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_EQUIVAL_UNID_PRED.first .. iotbLDC_EQUIVAL_UNID_PRED.last loop
					LockByPk
					(
						rcRecOfTab.CONSECUTIVO(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_EQUIVAL_UNID_PRED.first .. iotbLDC_EQUIVAL_UNID_PRED.last
				delete
				from LDC_EQUIVAL_UNID_PRED
				where
		         	CONSECUTIVO = rcRecOfTab.CONSECUTIVO(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_EQUIVAL_UNID_PRED in styLDC_EQUIVAL_UNID_PRED,
		inuLock in number default 0
	)
	IS
		nuCONSECUTIVO	LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type;
	BEGIN
		if ircLDC_EQUIVAL_UNID_PRED.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_EQUIVAL_UNID_PRED.rowid,rcData);
			end if;
			update LDC_EQUIVAL_UNID_PRED
			set
				ACTIVA = ircLDC_EQUIVAL_UNID_PRED.ACTIVA,
				ID_DIRECCION = ircLDC_EQUIVAL_UNID_PRED.ID_DIRECCION,
				ID_UNIDAD_PREDIAL = ircLDC_EQUIVAL_UNID_PRED.ID_UNIDAD_PREDIAL,
				ID_SOLICITUD = ircLDC_EQUIVAL_UNID_PRED.ID_SOLICITUD,
				FECHA_EQUIV = ircLDC_EQUIVAL_UNID_PRED.FECHA_EQUIV,
				SUBROG_APROB = ircLDC_EQUIVAL_UNID_PRED.SUBROG_APROB,
				USUA_APRUEBA = ircLDC_EQUIVAL_UNID_PRED.USUA_APRUEBA,
				FECHA_APROB = ircLDC_EQUIVAL_UNID_PRED.FECHA_APROB,
				ID_PROYECTO = ircLDC_EQUIVAL_UNID_PRED.ID_PROYECTO,
				ID_TORRE = ircLDC_EQUIVAL_UNID_PRED.ID_TORRE,
				ID_PISO = ircLDC_EQUIVAL_UNID_PRED.ID_PISO,
				ID_UNIDAD_PREDIAL_UNICO = ircLDC_EQUIVAL_UNID_PRED.ID_UNIDAD_PREDIAL_UNICO
			where
				rowid = ircLDC_EQUIVAL_UNID_PRED.rowid
			returning
				CONSECUTIVO
			into
				nuCONSECUTIVO;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_EQUIVAL_UNID_PRED.CONSECUTIVO,
					rcData
				);
			end if;

			update LDC_EQUIVAL_UNID_PRED
			set
				ACTIVA = ircLDC_EQUIVAL_UNID_PRED.ACTIVA,
				ID_DIRECCION = ircLDC_EQUIVAL_UNID_PRED.ID_DIRECCION,
				ID_UNIDAD_PREDIAL = ircLDC_EQUIVAL_UNID_PRED.ID_UNIDAD_PREDIAL,
				ID_SOLICITUD = ircLDC_EQUIVAL_UNID_PRED.ID_SOLICITUD,
				FECHA_EQUIV = ircLDC_EQUIVAL_UNID_PRED.FECHA_EQUIV,
				SUBROG_APROB = ircLDC_EQUIVAL_UNID_PRED.SUBROG_APROB,
				USUA_APRUEBA = ircLDC_EQUIVAL_UNID_PRED.USUA_APRUEBA,
				FECHA_APROB = ircLDC_EQUIVAL_UNID_PRED.FECHA_APROB,
				ID_PROYECTO = ircLDC_EQUIVAL_UNID_PRED.ID_PROYECTO,
				ID_TORRE = ircLDC_EQUIVAL_UNID_PRED.ID_TORRE,
				ID_PISO = ircLDC_EQUIVAL_UNID_PRED.ID_PISO,
				ID_UNIDAD_PREDIAL_UNICO = ircLDC_EQUIVAL_UNID_PRED.ID_UNIDAD_PREDIAL_UNICO
			where
				CONSECUTIVO = ircLDC_EQUIVAL_UNID_PRED.CONSECUTIVO
			returning
				CONSECUTIVO
			into
				nuCONSECUTIVO;
		end if;
		if
			nuCONSECUTIVO is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_EQUIVAL_UNID_PRED));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_EQUIVAL_UNID_PRED in out nocopy tytbLDC_EQUIVAL_UNID_PRED,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_EQUIVAL_UNID_PRED;
	BEGIN
		FillRecordOfTables(iotbLDC_EQUIVAL_UNID_PRED,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_EQUIVAL_UNID_PRED.first .. iotbLDC_EQUIVAL_UNID_PRED.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_EQUIVAL_UNID_PRED.first .. iotbLDC_EQUIVAL_UNID_PRED.last
				update LDC_EQUIVAL_UNID_PRED
				set
					ACTIVA = rcRecOfTab.ACTIVA(n),
					ID_DIRECCION = rcRecOfTab.ID_DIRECCION(n),
					ID_UNIDAD_PREDIAL = rcRecOfTab.ID_UNIDAD_PREDIAL(n),
					ID_SOLICITUD = rcRecOfTab.ID_SOLICITUD(n),
					FECHA_EQUIV = rcRecOfTab.FECHA_EQUIV(n),
					SUBROG_APROB = rcRecOfTab.SUBROG_APROB(n),
					USUA_APRUEBA = rcRecOfTab.USUA_APRUEBA(n),
					FECHA_APROB = rcRecOfTab.FECHA_APROB(n),
					ID_PROYECTO = rcRecOfTab.ID_PROYECTO(n),
					ID_TORRE = rcRecOfTab.ID_TORRE(n),
					ID_PISO = rcRecOfTab.ID_PISO(n),
					ID_UNIDAD_PREDIAL_UNICO = rcRecOfTab.ID_UNIDAD_PREDIAL_UNICO(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_EQUIVAL_UNID_PRED.first .. iotbLDC_EQUIVAL_UNID_PRED.last loop
					LockByPk
					(
						rcRecOfTab.CONSECUTIVO(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_EQUIVAL_UNID_PRED.first .. iotbLDC_EQUIVAL_UNID_PRED.last
				update LDC_EQUIVAL_UNID_PRED
				SET
					ACTIVA = rcRecOfTab.ACTIVA(n),
					ID_DIRECCION = rcRecOfTab.ID_DIRECCION(n),
					ID_UNIDAD_PREDIAL = rcRecOfTab.ID_UNIDAD_PREDIAL(n),
					ID_SOLICITUD = rcRecOfTab.ID_SOLICITUD(n),
					FECHA_EQUIV = rcRecOfTab.FECHA_EQUIV(n),
					SUBROG_APROB = rcRecOfTab.SUBROG_APROB(n),
					USUA_APRUEBA = rcRecOfTab.USUA_APRUEBA(n),
					FECHA_APROB = rcRecOfTab.FECHA_APROB(n),
					ID_PROYECTO = rcRecOfTab.ID_PROYECTO(n),
					ID_TORRE = rcRecOfTab.ID_TORRE(n),
					ID_PISO = rcRecOfTab.ID_PISO(n),
					ID_UNIDAD_PREDIAL_UNICO = rcRecOfTab.ID_UNIDAD_PREDIAL_UNICO(n)
				where
					CONSECUTIVO = rcRecOfTab.CONSECUTIVO(n)
;
		end if;
	END;
	PROCEDURE updACTIVA
	(
		inuCONSECUTIVO in LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type,
		isbACTIVA$ in LDC_EQUIVAL_UNID_PRED.ACTIVA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_EQUIVAL_UNID_PRED;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_EQUIVAL_UNID_PRED
		set
			ACTIVA = isbACTIVA$
		where
			CONSECUTIVO = inuCONSECUTIVO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ACTIVA:= isbACTIVA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updID_DIRECCION
	(
		inuCONSECUTIVO in LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type,
		inuID_DIRECCION$ in LDC_EQUIVAL_UNID_PRED.ID_DIRECCION%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_EQUIVAL_UNID_PRED;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_EQUIVAL_UNID_PRED
		set
			ID_DIRECCION = inuID_DIRECCION$
		where
			CONSECUTIVO = inuCONSECUTIVO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ID_DIRECCION:= inuID_DIRECCION$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updID_UNIDAD_PREDIAL
	(
		inuCONSECUTIVO in LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type,
		inuID_UNIDAD_PREDIAL$ in LDC_EQUIVAL_UNID_PRED.ID_UNIDAD_PREDIAL%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_EQUIVAL_UNID_PRED;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_EQUIVAL_UNID_PRED
		set
			ID_UNIDAD_PREDIAL = inuID_UNIDAD_PREDIAL$
		where
			CONSECUTIVO = inuCONSECUTIVO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ID_UNIDAD_PREDIAL:= inuID_UNIDAD_PREDIAL$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updID_SOLICITUD
	(
		inuCONSECUTIVO in LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type,
		inuID_SOLICITUD$ in LDC_EQUIVAL_UNID_PRED.ID_SOLICITUD%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_EQUIVAL_UNID_PRED;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_EQUIVAL_UNID_PRED
		set
			ID_SOLICITUD = inuID_SOLICITUD$
		where
			CONSECUTIVO = inuCONSECUTIVO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ID_SOLICITUD:= inuID_SOLICITUD$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFECHA_EQUIV
	(
		inuCONSECUTIVO in LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type,
		idtFECHA_EQUIV$ in LDC_EQUIVAL_UNID_PRED.FECHA_EQUIV%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_EQUIVAL_UNID_PRED;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_EQUIVAL_UNID_PRED
		set
			FECHA_EQUIV = idtFECHA_EQUIV$
		where
			CONSECUTIVO = inuCONSECUTIVO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FECHA_EQUIV:= idtFECHA_EQUIV$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSUBROG_APROB
	(
		inuCONSECUTIVO in LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type,
		isbSUBROG_APROB$ in LDC_EQUIVAL_UNID_PRED.SUBROG_APROB%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_EQUIVAL_UNID_PRED;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_EQUIVAL_UNID_PRED
		set
			SUBROG_APROB = isbSUBROG_APROB$
		where
			CONSECUTIVO = inuCONSECUTIVO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SUBROG_APROB:= isbSUBROG_APROB$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updUSUA_APRUEBA
	(
		inuCONSECUTIVO in LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type,
		isbUSUA_APRUEBA$ in LDC_EQUIVAL_UNID_PRED.USUA_APRUEBA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_EQUIVAL_UNID_PRED;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_EQUIVAL_UNID_PRED
		set
			USUA_APRUEBA = isbUSUA_APRUEBA$
		where
			CONSECUTIVO = inuCONSECUTIVO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.USUA_APRUEBA:= isbUSUA_APRUEBA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFECHA_APROB
	(
		inuCONSECUTIVO in LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type,
		idtFECHA_APROB$ in LDC_EQUIVAL_UNID_PRED.FECHA_APROB%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_EQUIVAL_UNID_PRED;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_EQUIVAL_UNID_PRED
		set
			FECHA_APROB = idtFECHA_APROB$
		where
			CONSECUTIVO = inuCONSECUTIVO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FECHA_APROB:= idtFECHA_APROB$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updID_PROYECTO
	(
		inuCONSECUTIVO in LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type,
		inuID_PROYECTO$ in LDC_EQUIVAL_UNID_PRED.ID_PROYECTO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_EQUIVAL_UNID_PRED;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_EQUIVAL_UNID_PRED
		set
			ID_PROYECTO = inuID_PROYECTO$
		where
			CONSECUTIVO = inuCONSECUTIVO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ID_PROYECTO:= inuID_PROYECTO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updID_TORRE
	(
		inuCONSECUTIVO in LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type,
		inuID_TORRE$ in LDC_EQUIVAL_UNID_PRED.ID_TORRE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_EQUIVAL_UNID_PRED;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_EQUIVAL_UNID_PRED
		set
			ID_TORRE = inuID_TORRE$
		where
			CONSECUTIVO = inuCONSECUTIVO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ID_TORRE:= inuID_TORRE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updID_PISO
	(
		inuCONSECUTIVO in LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type,
		inuID_PISO$ in LDC_EQUIVAL_UNID_PRED.ID_PISO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_EQUIVAL_UNID_PRED;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_EQUIVAL_UNID_PRED
		set
			ID_PISO = inuID_PISO$
		where
			CONSECUTIVO = inuCONSECUTIVO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ID_PISO:= inuID_PISO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updID_UNIDAD_PREDIAL_UNICO
	(
		inuCONSECUTIVO in LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type,
		inuID_UNIDAD_PREDIAL_UNICO$ in LDC_EQUIVAL_UNID_PRED.ID_UNIDAD_PREDIAL_UNICO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_EQUIVAL_UNID_PRED;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_EQUIVAL_UNID_PRED
		set
			ID_UNIDAD_PREDIAL_UNICO = inuID_UNIDAD_PREDIAL_UNICO$
		where
			CONSECUTIVO = inuCONSECUTIVO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ID_UNIDAD_PREDIAL_UNICO:= inuID_UNIDAD_PREDIAL_UNICO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fsbGetACTIVA
	(
		inuCONSECUTIVO in LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_EQUIVAL_UNID_PRED.ACTIVA%type
	IS
		rcError styLDC_EQUIVAL_UNID_PRED;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.ACTIVA);
		end if;
		Load
		(
		 		inuCONSECUTIVO
		);
		return(rcData.ACTIVA);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCONSECUTIVO
	(
		inuCONSECUTIVO in LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type
	IS
		rcError styLDC_EQUIVAL_UNID_PRED;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.CONSECUTIVO);
		end if;
		Load
		(
		 		inuCONSECUTIVO
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
	FUNCTION fnuGetID_DIRECCION
	(
		inuCONSECUTIVO in LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_EQUIVAL_UNID_PRED.ID_DIRECCION%type
	IS
		rcError styLDC_EQUIVAL_UNID_PRED;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.ID_DIRECCION);
		end if;
		Load
		(
		 		inuCONSECUTIVO
		);
		return(rcData.ID_DIRECCION);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetID_UNIDAD_PREDIAL
	(
		inuCONSECUTIVO in LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_EQUIVAL_UNID_PRED.ID_UNIDAD_PREDIAL%type
	IS
		rcError styLDC_EQUIVAL_UNID_PRED;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.ID_UNIDAD_PREDIAL);
		end if;
		Load
		(
		 		inuCONSECUTIVO
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
	FUNCTION fnuGetID_SOLICITUD
	(
		inuCONSECUTIVO in LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_EQUIVAL_UNID_PRED.ID_SOLICITUD%type
	IS
		rcError styLDC_EQUIVAL_UNID_PRED;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.ID_SOLICITUD);
		end if;
		Load
		(
		 		inuCONSECUTIVO
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
	FUNCTION fdtGetFECHA_EQUIV
	(
		inuCONSECUTIVO in LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_EQUIVAL_UNID_PRED.FECHA_EQUIV%type
	IS
		rcError styLDC_EQUIVAL_UNID_PRED;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.FECHA_EQUIV);
		end if;
		Load
		(
		 		inuCONSECUTIVO
		);
		return(rcData.FECHA_EQUIV);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetSUBROG_APROB
	(
		inuCONSECUTIVO in LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_EQUIVAL_UNID_PRED.SUBROG_APROB%type
	IS
		rcError styLDC_EQUIVAL_UNID_PRED;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.SUBROG_APROB);
		end if;
		Load
		(
		 		inuCONSECUTIVO
		);
		return(rcData.SUBROG_APROB);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetUSUA_APRUEBA
	(
		inuCONSECUTIVO in LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_EQUIVAL_UNID_PRED.USUA_APRUEBA%type
	IS
		rcError styLDC_EQUIVAL_UNID_PRED;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.USUA_APRUEBA);
		end if;
		Load
		(
		 		inuCONSECUTIVO
		);
		return(rcData.USUA_APRUEBA);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetFECHA_APROB
	(
		inuCONSECUTIVO in LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_EQUIVAL_UNID_PRED.FECHA_APROB%type
	IS
		rcError styLDC_EQUIVAL_UNID_PRED;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.FECHA_APROB);
		end if;
		Load
		(
		 		inuCONSECUTIVO
		);
		return(rcData.FECHA_APROB);
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
		inuCONSECUTIVO in LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_EQUIVAL_UNID_PRED.ID_PROYECTO%type
	IS
		rcError styLDC_EQUIVAL_UNID_PRED;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.ID_PROYECTO);
		end if;
		Load
		(
		 		inuCONSECUTIVO
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
	FUNCTION fnuGetID_TORRE
	(
		inuCONSECUTIVO in LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_EQUIVAL_UNID_PRED.ID_TORRE%type
	IS
		rcError styLDC_EQUIVAL_UNID_PRED;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.ID_TORRE);
		end if;
		Load
		(
		 		inuCONSECUTIVO
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
	FUNCTION fnuGetID_PISO
	(
		inuCONSECUTIVO in LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_EQUIVAL_UNID_PRED.ID_PISO%type
	IS
		rcError styLDC_EQUIVAL_UNID_PRED;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.ID_PISO);
		end if;
		Load
		(
		 		inuCONSECUTIVO
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
	FUNCTION fnuGetID_UNIDAD_PREDIAL_UNICO
	(
		inuCONSECUTIVO in LDC_EQUIVAL_UNID_PRED.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_EQUIVAL_UNID_PRED.ID_UNIDAD_PREDIAL_UNICO%type
	IS
		rcError styLDC_EQUIVAL_UNID_PRED;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.ID_UNIDAD_PREDIAL_UNICO);
		end if;
		Load
		(
		 		inuCONSECUTIVO
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
end DALDC_EQUIVAL_UNID_PRED;
/
PROMPT Otorgando permisos de ejecucion a DALDC_EQUIVAL_UNID_PRED
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_EQUIVAL_UNID_PRED', 'ADM_PERSON');
END;
/