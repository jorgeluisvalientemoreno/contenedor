CREATE OR REPLACE PACKAGE ADM_PERSON.DALDC_AUDIT_CHEQ_PROY
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
		inuCONSECUTIVO in LDC_AUDIT_CHEQ_PROY.CONSECUTIVO%type
	)
	IS
		SELECT LDC_AUDIT_CHEQ_PROY.*,LDC_AUDIT_CHEQ_PROY.rowid
		FROM LDC_AUDIT_CHEQ_PROY
		WHERE
		    CONSECUTIVO = inuCONSECUTIVO;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_AUDIT_CHEQ_PROY.*,LDC_AUDIT_CHEQ_PROY.rowid
		FROM LDC_AUDIT_CHEQ_PROY
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_AUDIT_CHEQ_PROY  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_AUDIT_CHEQ_PROY is table of styLDC_AUDIT_CHEQ_PROY index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_AUDIT_CHEQ_PROY;

	/* Tipos referenciando al registro */
	type tytbCONSECUTIVO is table of LDC_AUDIT_CHEQ_PROY.CONSECUTIVO%type index by binary_integer;
	type tytbNUMERO_CHEQUE is table of LDC_AUDIT_CHEQ_PROY.NUMERO_CHEQUE%type index by binary_integer;
	type tytbESTADO_ANTERIOR is table of LDC_AUDIT_CHEQ_PROY.ESTADO_ANTERIOR%type index by binary_integer;
	type tytbESTADO_NUEVO is table of LDC_AUDIT_CHEQ_PROY.ESTADO_NUEVO%type index by binary_integer;
	type tytbFECHA_MODIF is table of LDC_AUDIT_CHEQ_PROY.FECHA_MODIF%type index by binary_integer;
	type tytbUSUA_MODIF is table of LDC_AUDIT_CHEQ_PROY.USUA_MODIF%type index by binary_integer;
	type tytbID_PROYECTO is table of LDC_AUDIT_CHEQ_PROY.ID_PROYECTO%type index by binary_integer;
	type tytbCONS_CHEQUE is table of LDC_AUDIT_CHEQ_PROY.CONS_CHEQUE%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_AUDIT_CHEQ_PROY is record
	(
		CONSECUTIVO   tytbCONSECUTIVO,
		NUMERO_CHEQUE   tytbNUMERO_CHEQUE,
		ESTADO_ANTERIOR   tytbESTADO_ANTERIOR,
		ESTADO_NUEVO   tytbESTADO_NUEVO,
		FECHA_MODIF   tytbFECHA_MODIF,
		USUA_MODIF   tytbUSUA_MODIF,
		ID_PROYECTO   tytbID_PROYECTO,
		CONS_CHEQUE   tytbCONS_CHEQUE,
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
		inuCONSECUTIVO in LDC_AUDIT_CHEQ_PROY.CONSECUTIVO%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuCONSECUTIVO in LDC_AUDIT_CHEQ_PROY.CONSECUTIVO%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuCONSECUTIVO in LDC_AUDIT_CHEQ_PROY.CONSECUTIVO%type
	);

	PROCEDURE getRecord
	(
		inuCONSECUTIVO in LDC_AUDIT_CHEQ_PROY.CONSECUTIVO%type,
		orcRecord out nocopy styLDC_AUDIT_CHEQ_PROY
	);

	FUNCTION frcGetRcData
	(
		inuCONSECUTIVO in LDC_AUDIT_CHEQ_PROY.CONSECUTIVO%type
	)
	RETURN styLDC_AUDIT_CHEQ_PROY;

	FUNCTION frcGetRcData
	RETURN styLDC_AUDIT_CHEQ_PROY;

	FUNCTION frcGetRecord
	(
		inuCONSECUTIVO in LDC_AUDIT_CHEQ_PROY.CONSECUTIVO%type
	)
	RETURN styLDC_AUDIT_CHEQ_PROY;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_AUDIT_CHEQ_PROY
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_AUDIT_CHEQ_PROY in styLDC_AUDIT_CHEQ_PROY
	);

	PROCEDURE insRecord
	(
		ircLDC_AUDIT_CHEQ_PROY in styLDC_AUDIT_CHEQ_PROY,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_AUDIT_CHEQ_PROY in out nocopy tytbLDC_AUDIT_CHEQ_PROY
	);

	PROCEDURE delRecord
	(
		inuCONSECUTIVO in LDC_AUDIT_CHEQ_PROY.CONSECUTIVO%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_AUDIT_CHEQ_PROY in out nocopy tytbLDC_AUDIT_CHEQ_PROY,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_AUDIT_CHEQ_PROY in styLDC_AUDIT_CHEQ_PROY,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_AUDIT_CHEQ_PROY in out nocopy tytbLDC_AUDIT_CHEQ_PROY,
		inuLock in number default 1
	);

	PROCEDURE updNUMERO_CHEQUE
	(
		inuCONSECUTIVO in LDC_AUDIT_CHEQ_PROY.CONSECUTIVO%type,
		isbNUMERO_CHEQUE$ in LDC_AUDIT_CHEQ_PROY.NUMERO_CHEQUE%type,
		inuLock in number default 0
	);

	PROCEDURE updESTADO_ANTERIOR
	(
		inuCONSECUTIVO in LDC_AUDIT_CHEQ_PROY.CONSECUTIVO%type,
		isbESTADO_ANTERIOR$ in LDC_AUDIT_CHEQ_PROY.ESTADO_ANTERIOR%type,
		inuLock in number default 0
	);

	PROCEDURE updESTADO_NUEVO
	(
		inuCONSECUTIVO in LDC_AUDIT_CHEQ_PROY.CONSECUTIVO%type,
		isbESTADO_NUEVO$ in LDC_AUDIT_CHEQ_PROY.ESTADO_NUEVO%type,
		inuLock in number default 0
	);

	PROCEDURE updFECHA_MODIF
	(
		inuCONSECUTIVO in LDC_AUDIT_CHEQ_PROY.CONSECUTIVO%type,
		idtFECHA_MODIF$ in LDC_AUDIT_CHEQ_PROY.FECHA_MODIF%type,
		inuLock in number default 0
	);

	PROCEDURE updUSUA_MODIF
	(
		inuCONSECUTIVO in LDC_AUDIT_CHEQ_PROY.CONSECUTIVO%type,
		isbUSUA_MODIF$ in LDC_AUDIT_CHEQ_PROY.USUA_MODIF%type,
		inuLock in number default 0
	);

	PROCEDURE updID_PROYECTO
	(
		inuCONSECUTIVO in LDC_AUDIT_CHEQ_PROY.CONSECUTIVO%type,
		inuID_PROYECTO$ in LDC_AUDIT_CHEQ_PROY.ID_PROYECTO%type,
		inuLock in number default 0
	);

	PROCEDURE updCONS_CHEQUE
	(
		inuCONSECUTIVO in LDC_AUDIT_CHEQ_PROY.CONSECUTIVO%type,
		inuCONS_CHEQUE$ in LDC_AUDIT_CHEQ_PROY.CONS_CHEQUE%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetCONSECUTIVO
	(
		inuCONSECUTIVO in LDC_AUDIT_CHEQ_PROY.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_AUDIT_CHEQ_PROY.CONSECUTIVO%type;

	FUNCTION fsbGetNUMERO_CHEQUE
	(
		inuCONSECUTIVO in LDC_AUDIT_CHEQ_PROY.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_AUDIT_CHEQ_PROY.NUMERO_CHEQUE%type;

	FUNCTION fsbGetESTADO_ANTERIOR
	(
		inuCONSECUTIVO in LDC_AUDIT_CHEQ_PROY.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_AUDIT_CHEQ_PROY.ESTADO_ANTERIOR%type;

	FUNCTION fsbGetESTADO_NUEVO
	(
		inuCONSECUTIVO in LDC_AUDIT_CHEQ_PROY.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_AUDIT_CHEQ_PROY.ESTADO_NUEVO%type;

	FUNCTION fdtGetFECHA_MODIF
	(
		inuCONSECUTIVO in LDC_AUDIT_CHEQ_PROY.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_AUDIT_CHEQ_PROY.FECHA_MODIF%type;

	FUNCTION fsbGetUSUA_MODIF
	(
		inuCONSECUTIVO in LDC_AUDIT_CHEQ_PROY.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_AUDIT_CHEQ_PROY.USUA_MODIF%type;

	FUNCTION fnuGetID_PROYECTO
	(
		inuCONSECUTIVO in LDC_AUDIT_CHEQ_PROY.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_AUDIT_CHEQ_PROY.ID_PROYECTO%type;

	FUNCTION fnuGetCONS_CHEQUE
	(
		inuCONSECUTIVO in LDC_AUDIT_CHEQ_PROY.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_AUDIT_CHEQ_PROY.CONS_CHEQUE%type;


	PROCEDURE LockByPk
	(
		inuCONSECUTIVO in LDC_AUDIT_CHEQ_PROY.CONSECUTIVO%type,
		orcLDC_AUDIT_CHEQ_PROY  out styLDC_AUDIT_CHEQ_PROY
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_AUDIT_CHEQ_PROY  out styLDC_AUDIT_CHEQ_PROY
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_AUDIT_CHEQ_PROY;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALDC_AUDIT_CHEQ_PROY
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_AUDIT_CHEQ_PROY';
	 cnuGeEntityId constant varchar2(30) := 2899; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuCONSECUTIVO in LDC_AUDIT_CHEQ_PROY.CONSECUTIVO%type
	)
	IS
		SELECT LDC_AUDIT_CHEQ_PROY.*,LDC_AUDIT_CHEQ_PROY.rowid
		FROM LDC_AUDIT_CHEQ_PROY
		WHERE  CONSECUTIVO = inuCONSECUTIVO
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_AUDIT_CHEQ_PROY.*,LDC_AUDIT_CHEQ_PROY.rowid
		FROM LDC_AUDIT_CHEQ_PROY
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_AUDIT_CHEQ_PROY is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_AUDIT_CHEQ_PROY;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_AUDIT_CHEQ_PROY default rcData )
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
		inuCONSECUTIVO in LDC_AUDIT_CHEQ_PROY.CONSECUTIVO%type,
		orcLDC_AUDIT_CHEQ_PROY  out styLDC_AUDIT_CHEQ_PROY
	)
	IS
		rcError styLDC_AUDIT_CHEQ_PROY;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;

		Open cuLockRcByPk
		(
			inuCONSECUTIVO
		);

		fetch cuLockRcByPk into orcLDC_AUDIT_CHEQ_PROY;
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
		orcLDC_AUDIT_CHEQ_PROY  out styLDC_AUDIT_CHEQ_PROY
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_AUDIT_CHEQ_PROY;
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
		itbLDC_AUDIT_CHEQ_PROY  in out nocopy tytbLDC_AUDIT_CHEQ_PROY
	)
	IS
	BEGIN
			rcRecOfTab.CONSECUTIVO.delete;
			rcRecOfTab.NUMERO_CHEQUE.delete;
			rcRecOfTab.ESTADO_ANTERIOR.delete;
			rcRecOfTab.ESTADO_NUEVO.delete;
			rcRecOfTab.FECHA_MODIF.delete;
			rcRecOfTab.USUA_MODIF.delete;
			rcRecOfTab.ID_PROYECTO.delete;
			rcRecOfTab.CONS_CHEQUE.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_AUDIT_CHEQ_PROY  in out nocopy tytbLDC_AUDIT_CHEQ_PROY,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_AUDIT_CHEQ_PROY);

		for n in itbLDC_AUDIT_CHEQ_PROY.first .. itbLDC_AUDIT_CHEQ_PROY.last loop
			rcRecOfTab.CONSECUTIVO(n) := itbLDC_AUDIT_CHEQ_PROY(n).CONSECUTIVO;
			rcRecOfTab.NUMERO_CHEQUE(n) := itbLDC_AUDIT_CHEQ_PROY(n).NUMERO_CHEQUE;
			rcRecOfTab.ESTADO_ANTERIOR(n) := itbLDC_AUDIT_CHEQ_PROY(n).ESTADO_ANTERIOR;
			rcRecOfTab.ESTADO_NUEVO(n) := itbLDC_AUDIT_CHEQ_PROY(n).ESTADO_NUEVO;
			rcRecOfTab.FECHA_MODIF(n) := itbLDC_AUDIT_CHEQ_PROY(n).FECHA_MODIF;
			rcRecOfTab.USUA_MODIF(n) := itbLDC_AUDIT_CHEQ_PROY(n).USUA_MODIF;
			rcRecOfTab.ID_PROYECTO(n) := itbLDC_AUDIT_CHEQ_PROY(n).ID_PROYECTO;
			rcRecOfTab.CONS_CHEQUE(n) := itbLDC_AUDIT_CHEQ_PROY(n).CONS_CHEQUE;
			rcRecOfTab.row_id(n) := itbLDC_AUDIT_CHEQ_PROY(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuCONSECUTIVO in LDC_AUDIT_CHEQ_PROY.CONSECUTIVO%type
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
		inuCONSECUTIVO in LDC_AUDIT_CHEQ_PROY.CONSECUTIVO%type
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
		inuCONSECUTIVO in LDC_AUDIT_CHEQ_PROY.CONSECUTIVO%type
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
		inuCONSECUTIVO in LDC_AUDIT_CHEQ_PROY.CONSECUTIVO%type
	)
	IS
		rcError styLDC_AUDIT_CHEQ_PROY;
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
		inuCONSECUTIVO in LDC_AUDIT_CHEQ_PROY.CONSECUTIVO%type
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
		inuCONSECUTIVO in LDC_AUDIT_CHEQ_PROY.CONSECUTIVO%type,
		orcRecord out nocopy styLDC_AUDIT_CHEQ_PROY
	)
	IS
		rcError styLDC_AUDIT_CHEQ_PROY;
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
		inuCONSECUTIVO in LDC_AUDIT_CHEQ_PROY.CONSECUTIVO%type
	)
	RETURN styLDC_AUDIT_CHEQ_PROY
	IS
		rcError styLDC_AUDIT_CHEQ_PROY;
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
		inuCONSECUTIVO in LDC_AUDIT_CHEQ_PROY.CONSECUTIVO%type
	)
	RETURN styLDC_AUDIT_CHEQ_PROY
	IS
		rcError styLDC_AUDIT_CHEQ_PROY;
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
	RETURN styLDC_AUDIT_CHEQ_PROY
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_AUDIT_CHEQ_PROY
	)
	IS
		rfLDC_AUDIT_CHEQ_PROY tyrfLDC_AUDIT_CHEQ_PROY;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_AUDIT_CHEQ_PROY.*, LDC_AUDIT_CHEQ_PROY.rowid FROM LDC_AUDIT_CHEQ_PROY';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_AUDIT_CHEQ_PROY for sbFullQuery;

		fetch rfLDC_AUDIT_CHEQ_PROY bulk collect INTO otbResult;

		close rfLDC_AUDIT_CHEQ_PROY;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_AUDIT_CHEQ_PROY.*, LDC_AUDIT_CHEQ_PROY.rowid FROM LDC_AUDIT_CHEQ_PROY';
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
		ircLDC_AUDIT_CHEQ_PROY in styLDC_AUDIT_CHEQ_PROY
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_AUDIT_CHEQ_PROY,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_AUDIT_CHEQ_PROY in styLDC_AUDIT_CHEQ_PROY,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_AUDIT_CHEQ_PROY.CONSECUTIVO is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|CONSECUTIVO');
			raise ex.controlled_error;
		end if;

		insert into LDC_AUDIT_CHEQ_PROY
		(
			CONSECUTIVO,
			NUMERO_CHEQUE,
			ESTADO_ANTERIOR,
			ESTADO_NUEVO,
			FECHA_MODIF,
			USUA_MODIF,
			ID_PROYECTO,
			CONS_CHEQUE
		)
		values
		(
			ircLDC_AUDIT_CHEQ_PROY.CONSECUTIVO,
			ircLDC_AUDIT_CHEQ_PROY.NUMERO_CHEQUE,
			ircLDC_AUDIT_CHEQ_PROY.ESTADO_ANTERIOR,
			ircLDC_AUDIT_CHEQ_PROY.ESTADO_NUEVO,
			ircLDC_AUDIT_CHEQ_PROY.FECHA_MODIF,
			ircLDC_AUDIT_CHEQ_PROY.USUA_MODIF,
			ircLDC_AUDIT_CHEQ_PROY.ID_PROYECTO,
			ircLDC_AUDIT_CHEQ_PROY.CONS_CHEQUE
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_AUDIT_CHEQ_PROY));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_AUDIT_CHEQ_PROY in out nocopy tytbLDC_AUDIT_CHEQ_PROY
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_AUDIT_CHEQ_PROY,blUseRowID);
		forall n in iotbLDC_AUDIT_CHEQ_PROY.first..iotbLDC_AUDIT_CHEQ_PROY.last
			insert into LDC_AUDIT_CHEQ_PROY
			(
				CONSECUTIVO,
				NUMERO_CHEQUE,
				ESTADO_ANTERIOR,
				ESTADO_NUEVO,
				FECHA_MODIF,
				USUA_MODIF,
				ID_PROYECTO,
				CONS_CHEQUE
			)
			values
			(
				rcRecOfTab.CONSECUTIVO(n),
				rcRecOfTab.NUMERO_CHEQUE(n),
				rcRecOfTab.ESTADO_ANTERIOR(n),
				rcRecOfTab.ESTADO_NUEVO(n),
				rcRecOfTab.FECHA_MODIF(n),
				rcRecOfTab.USUA_MODIF(n),
				rcRecOfTab.ID_PROYECTO(n),
				rcRecOfTab.CONS_CHEQUE(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuCONSECUTIVO in LDC_AUDIT_CHEQ_PROY.CONSECUTIVO%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_AUDIT_CHEQ_PROY;
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
		from LDC_AUDIT_CHEQ_PROY
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
		rcError  styLDC_AUDIT_CHEQ_PROY;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_AUDIT_CHEQ_PROY
		where
			rowid = iriRowID
		returning
			CONSECUTIVO
		into
			rcError.CONSECUTIVO;
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
		iotbLDC_AUDIT_CHEQ_PROY in out nocopy tytbLDC_AUDIT_CHEQ_PROY,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_AUDIT_CHEQ_PROY;
	BEGIN
		FillRecordOfTables(iotbLDC_AUDIT_CHEQ_PROY, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_AUDIT_CHEQ_PROY.first .. iotbLDC_AUDIT_CHEQ_PROY.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_AUDIT_CHEQ_PROY.first .. iotbLDC_AUDIT_CHEQ_PROY.last
				delete
				from LDC_AUDIT_CHEQ_PROY
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_AUDIT_CHEQ_PROY.first .. iotbLDC_AUDIT_CHEQ_PROY.last loop
					LockByPk
					(
						rcRecOfTab.CONSECUTIVO(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_AUDIT_CHEQ_PROY.first .. iotbLDC_AUDIT_CHEQ_PROY.last
				delete
				from LDC_AUDIT_CHEQ_PROY
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
		ircLDC_AUDIT_CHEQ_PROY in styLDC_AUDIT_CHEQ_PROY,
		inuLock in number default 0
	)
	IS
		nuCONSECUTIVO	LDC_AUDIT_CHEQ_PROY.CONSECUTIVO%type;
	BEGIN
		if ircLDC_AUDIT_CHEQ_PROY.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_AUDIT_CHEQ_PROY.rowid,rcData);
			end if;
			update LDC_AUDIT_CHEQ_PROY
			set
				NUMERO_CHEQUE = ircLDC_AUDIT_CHEQ_PROY.NUMERO_CHEQUE,
				ESTADO_ANTERIOR = ircLDC_AUDIT_CHEQ_PROY.ESTADO_ANTERIOR,
				ESTADO_NUEVO = ircLDC_AUDIT_CHEQ_PROY.ESTADO_NUEVO,
				FECHA_MODIF = ircLDC_AUDIT_CHEQ_PROY.FECHA_MODIF,
				USUA_MODIF = ircLDC_AUDIT_CHEQ_PROY.USUA_MODIF,
				ID_PROYECTO = ircLDC_AUDIT_CHEQ_PROY.ID_PROYECTO,
				CONS_CHEQUE = ircLDC_AUDIT_CHEQ_PROY.CONS_CHEQUE
			where
				rowid = ircLDC_AUDIT_CHEQ_PROY.rowid
			returning
				CONSECUTIVO
			into
				nuCONSECUTIVO;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_AUDIT_CHEQ_PROY.CONSECUTIVO,
					rcData
				);
			end if;

			update LDC_AUDIT_CHEQ_PROY
			set
				NUMERO_CHEQUE = ircLDC_AUDIT_CHEQ_PROY.NUMERO_CHEQUE,
				ESTADO_ANTERIOR = ircLDC_AUDIT_CHEQ_PROY.ESTADO_ANTERIOR,
				ESTADO_NUEVO = ircLDC_AUDIT_CHEQ_PROY.ESTADO_NUEVO,
				FECHA_MODIF = ircLDC_AUDIT_CHEQ_PROY.FECHA_MODIF,
				USUA_MODIF = ircLDC_AUDIT_CHEQ_PROY.USUA_MODIF,
				ID_PROYECTO = ircLDC_AUDIT_CHEQ_PROY.ID_PROYECTO,
				CONS_CHEQUE = ircLDC_AUDIT_CHEQ_PROY.CONS_CHEQUE
			where
				CONSECUTIVO = ircLDC_AUDIT_CHEQ_PROY.CONSECUTIVO
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
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_AUDIT_CHEQ_PROY));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_AUDIT_CHEQ_PROY in out nocopy tytbLDC_AUDIT_CHEQ_PROY,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_AUDIT_CHEQ_PROY;
	BEGIN
		FillRecordOfTables(iotbLDC_AUDIT_CHEQ_PROY,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_AUDIT_CHEQ_PROY.first .. iotbLDC_AUDIT_CHEQ_PROY.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_AUDIT_CHEQ_PROY.first .. iotbLDC_AUDIT_CHEQ_PROY.last
				update LDC_AUDIT_CHEQ_PROY
				set
					NUMERO_CHEQUE = rcRecOfTab.NUMERO_CHEQUE(n),
					ESTADO_ANTERIOR = rcRecOfTab.ESTADO_ANTERIOR(n),
					ESTADO_NUEVO = rcRecOfTab.ESTADO_NUEVO(n),
					FECHA_MODIF = rcRecOfTab.FECHA_MODIF(n),
					USUA_MODIF = rcRecOfTab.USUA_MODIF(n),
					ID_PROYECTO = rcRecOfTab.ID_PROYECTO(n),
					CONS_CHEQUE = rcRecOfTab.CONS_CHEQUE(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_AUDIT_CHEQ_PROY.first .. iotbLDC_AUDIT_CHEQ_PROY.last loop
					LockByPk
					(
						rcRecOfTab.CONSECUTIVO(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_AUDIT_CHEQ_PROY.first .. iotbLDC_AUDIT_CHEQ_PROY.last
				update LDC_AUDIT_CHEQ_PROY
				SET
					NUMERO_CHEQUE = rcRecOfTab.NUMERO_CHEQUE(n),
					ESTADO_ANTERIOR = rcRecOfTab.ESTADO_ANTERIOR(n),
					ESTADO_NUEVO = rcRecOfTab.ESTADO_NUEVO(n),
					FECHA_MODIF = rcRecOfTab.FECHA_MODIF(n),
					USUA_MODIF = rcRecOfTab.USUA_MODIF(n),
					ID_PROYECTO = rcRecOfTab.ID_PROYECTO(n),
					CONS_CHEQUE = rcRecOfTab.CONS_CHEQUE(n)
				where
					CONSECUTIVO = rcRecOfTab.CONSECUTIVO(n)
;
		end if;
	END;
	PROCEDURE updNUMERO_CHEQUE
	(
		inuCONSECUTIVO in LDC_AUDIT_CHEQ_PROY.CONSECUTIVO%type,
		isbNUMERO_CHEQUE$ in LDC_AUDIT_CHEQ_PROY.NUMERO_CHEQUE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_AUDIT_CHEQ_PROY;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_AUDIT_CHEQ_PROY
		set
			NUMERO_CHEQUE = isbNUMERO_CHEQUE$
		where
			CONSECUTIVO = inuCONSECUTIVO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.NUMERO_CHEQUE:= isbNUMERO_CHEQUE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updESTADO_ANTERIOR
	(
		inuCONSECUTIVO in LDC_AUDIT_CHEQ_PROY.CONSECUTIVO%type,
		isbESTADO_ANTERIOR$ in LDC_AUDIT_CHEQ_PROY.ESTADO_ANTERIOR%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_AUDIT_CHEQ_PROY;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_AUDIT_CHEQ_PROY
		set
			ESTADO_ANTERIOR = isbESTADO_ANTERIOR$
		where
			CONSECUTIVO = inuCONSECUTIVO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ESTADO_ANTERIOR:= isbESTADO_ANTERIOR$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updESTADO_NUEVO
	(
		inuCONSECUTIVO in LDC_AUDIT_CHEQ_PROY.CONSECUTIVO%type,
		isbESTADO_NUEVO$ in LDC_AUDIT_CHEQ_PROY.ESTADO_NUEVO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_AUDIT_CHEQ_PROY;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_AUDIT_CHEQ_PROY
		set
			ESTADO_NUEVO = isbESTADO_NUEVO$
		where
			CONSECUTIVO = inuCONSECUTIVO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ESTADO_NUEVO:= isbESTADO_NUEVO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFECHA_MODIF
	(
		inuCONSECUTIVO in LDC_AUDIT_CHEQ_PROY.CONSECUTIVO%type,
		idtFECHA_MODIF$ in LDC_AUDIT_CHEQ_PROY.FECHA_MODIF%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_AUDIT_CHEQ_PROY;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_AUDIT_CHEQ_PROY
		set
			FECHA_MODIF = idtFECHA_MODIF$
		where
			CONSECUTIVO = inuCONSECUTIVO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FECHA_MODIF:= idtFECHA_MODIF$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updUSUA_MODIF
	(
		inuCONSECUTIVO in LDC_AUDIT_CHEQ_PROY.CONSECUTIVO%type,
		isbUSUA_MODIF$ in LDC_AUDIT_CHEQ_PROY.USUA_MODIF%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_AUDIT_CHEQ_PROY;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_AUDIT_CHEQ_PROY
		set
			USUA_MODIF = isbUSUA_MODIF$
		where
			CONSECUTIVO = inuCONSECUTIVO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.USUA_MODIF:= isbUSUA_MODIF$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updID_PROYECTO
	(
		inuCONSECUTIVO in LDC_AUDIT_CHEQ_PROY.CONSECUTIVO%type,
		inuID_PROYECTO$ in LDC_AUDIT_CHEQ_PROY.ID_PROYECTO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_AUDIT_CHEQ_PROY;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_AUDIT_CHEQ_PROY
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
	PROCEDURE updCONS_CHEQUE
	(
		inuCONSECUTIVO in LDC_AUDIT_CHEQ_PROY.CONSECUTIVO%type,
		inuCONS_CHEQUE$ in LDC_AUDIT_CHEQ_PROY.CONS_CHEQUE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_AUDIT_CHEQ_PROY;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_AUDIT_CHEQ_PROY
		set
			CONS_CHEQUE = inuCONS_CHEQUE$
		where
			CONSECUTIVO = inuCONSECUTIVO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CONS_CHEQUE:= inuCONS_CHEQUE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetCONSECUTIVO
	(
		inuCONSECUTIVO in LDC_AUDIT_CHEQ_PROY.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_AUDIT_CHEQ_PROY.CONSECUTIVO%type
	IS
		rcError styLDC_AUDIT_CHEQ_PROY;
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
	FUNCTION fsbGetNUMERO_CHEQUE
	(
		inuCONSECUTIVO in LDC_AUDIT_CHEQ_PROY.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_AUDIT_CHEQ_PROY.NUMERO_CHEQUE%type
	IS
		rcError styLDC_AUDIT_CHEQ_PROY;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.NUMERO_CHEQUE);
		end if;
		Load
		(
		 		inuCONSECUTIVO
		);
		return(rcData.NUMERO_CHEQUE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetESTADO_ANTERIOR
	(
		inuCONSECUTIVO in LDC_AUDIT_CHEQ_PROY.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_AUDIT_CHEQ_PROY.ESTADO_ANTERIOR%type
	IS
		rcError styLDC_AUDIT_CHEQ_PROY;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.ESTADO_ANTERIOR);
		end if;
		Load
		(
		 		inuCONSECUTIVO
		);
		return(rcData.ESTADO_ANTERIOR);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetESTADO_NUEVO
	(
		inuCONSECUTIVO in LDC_AUDIT_CHEQ_PROY.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_AUDIT_CHEQ_PROY.ESTADO_NUEVO%type
	IS
		rcError styLDC_AUDIT_CHEQ_PROY;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.ESTADO_NUEVO);
		end if;
		Load
		(
		 		inuCONSECUTIVO
		);
		return(rcData.ESTADO_NUEVO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetFECHA_MODIF
	(
		inuCONSECUTIVO in LDC_AUDIT_CHEQ_PROY.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_AUDIT_CHEQ_PROY.FECHA_MODIF%type
	IS
		rcError styLDC_AUDIT_CHEQ_PROY;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.FECHA_MODIF);
		end if;
		Load
		(
		 		inuCONSECUTIVO
		);
		return(rcData.FECHA_MODIF);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetUSUA_MODIF
	(
		inuCONSECUTIVO in LDC_AUDIT_CHEQ_PROY.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_AUDIT_CHEQ_PROY.USUA_MODIF%type
	IS
		rcError styLDC_AUDIT_CHEQ_PROY;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.USUA_MODIF);
		end if;
		Load
		(
		 		inuCONSECUTIVO
		);
		return(rcData.USUA_MODIF);
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
		inuCONSECUTIVO in LDC_AUDIT_CHEQ_PROY.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_AUDIT_CHEQ_PROY.ID_PROYECTO%type
	IS
		rcError styLDC_AUDIT_CHEQ_PROY;
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
	FUNCTION fnuGetCONS_CHEQUE
	(
		inuCONSECUTIVO in LDC_AUDIT_CHEQ_PROY.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_AUDIT_CHEQ_PROY.CONS_CHEQUE%type
	IS
		rcError styLDC_AUDIT_CHEQ_PROY;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.CONS_CHEQUE);
		end if;
		Load
		(
		 		inuCONSECUTIVO
		);
		return(rcData.CONS_CHEQUE);
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
end DALDC_AUDIT_CHEQ_PROY;
/
PROMPT Otorgando permisos de ejecucion a DALDC_AUDIT_CHEQ_PROY
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_AUDIT_CHEQ_PROY', 'ADM_PERSON');
END;
/