CREATE OR REPLACE PACKAGE ADM_PERSON.DALDC_CUOTAS_PROYECTO
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
		inuID_PROYECTO in LDC_CUOTAS_PROYECTO.ID_PROYECTO%type,
		inuCONSECUTIVO in LDC_CUOTAS_PROYECTO.CONSECUTIVO%type
	)
	IS
		SELECT LDC_CUOTAS_PROYECTO.*,LDC_CUOTAS_PROYECTO.rowid
		FROM LDC_CUOTAS_PROYECTO
		WHERE
		    ID_PROYECTO = inuID_PROYECTO
		    and CONSECUTIVO = inuCONSECUTIVO;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_CUOTAS_PROYECTO.*,LDC_CUOTAS_PROYECTO.rowid
		FROM LDC_CUOTAS_PROYECTO
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_CUOTAS_PROYECTO  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_CUOTAS_PROYECTO is table of styLDC_CUOTAS_PROYECTO index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_CUOTAS_PROYECTO;

	/* Tipos referenciando al registro */
	type tytbCONSECUTIVO is table of LDC_CUOTAS_PROYECTO.CONSECUTIVO%type index by binary_integer;
	type tytbID_PROYECTO is table of LDC_CUOTAS_PROYECTO.ID_PROYECTO%type index by binary_integer;
	type tytbFECHA_COBRO is table of LDC_CUOTAS_PROYECTO.FECHA_COBRO%type index by binary_integer;
	type tytbVALOR is table of LDC_CUOTAS_PROYECTO.VALOR%type index by binary_integer;
	type tytbFECHA_ALARMA is table of LDC_CUOTAS_PROYECTO.FECHA_ALARMA%type index by binary_integer;
	type tytbESTADO is table of LDC_CUOTAS_PROYECTO.ESTADO%type index by binary_integer;
	type tytbCUPON is table of LDC_CUOTAS_PROYECTO.CUPON%type index by binary_integer;
	type tytbFECHA_REGISTRO is table of LDC_CUOTAS_PROYECTO.FECHA_REGISTRO%type index by binary_integer;
	type tytbUSUA_REGISTRA is table of LDC_CUOTAS_PROYECTO.USUA_REGISTRA%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_CUOTAS_PROYECTO is record
	(
		CONSECUTIVO   tytbCONSECUTIVO,
		ID_PROYECTO   tytbID_PROYECTO,
		FECHA_COBRO   tytbFECHA_COBRO,
		VALOR   tytbVALOR,
		FECHA_ALARMA   tytbFECHA_ALARMA,
		ESTADO   tytbESTADO,
		CUPON   tytbCUPON,
		FECHA_REGISTRO   tytbFECHA_REGISTRO,
		USUA_REGISTRA   tytbUSUA_REGISTRA,
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
		inuID_PROYECTO in LDC_CUOTAS_PROYECTO.ID_PROYECTO%type,
		inuCONSECUTIVO in LDC_CUOTAS_PROYECTO.CONSECUTIVO%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuID_PROYECTO in LDC_CUOTAS_PROYECTO.ID_PROYECTO%type,
		inuCONSECUTIVO in LDC_CUOTAS_PROYECTO.CONSECUTIVO%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuID_PROYECTO in LDC_CUOTAS_PROYECTO.ID_PROYECTO%type,
		inuCONSECUTIVO in LDC_CUOTAS_PROYECTO.CONSECUTIVO%type
	);

	PROCEDURE getRecord
	(
		inuID_PROYECTO in LDC_CUOTAS_PROYECTO.ID_PROYECTO%type,
		inuCONSECUTIVO in LDC_CUOTAS_PROYECTO.CONSECUTIVO%type,
		orcRecord out nocopy styLDC_CUOTAS_PROYECTO
	);

	FUNCTION frcGetRcData
	(
		inuID_PROYECTO in LDC_CUOTAS_PROYECTO.ID_PROYECTO%type,
		inuCONSECUTIVO in LDC_CUOTAS_PROYECTO.CONSECUTIVO%type
	)
	RETURN styLDC_CUOTAS_PROYECTO;

	FUNCTION frcGetRcData
	RETURN styLDC_CUOTAS_PROYECTO;

	FUNCTION frcGetRecord
	(
		inuID_PROYECTO in LDC_CUOTAS_PROYECTO.ID_PROYECTO%type,
		inuCONSECUTIVO in LDC_CUOTAS_PROYECTO.CONSECUTIVO%type
	)
	RETURN styLDC_CUOTAS_PROYECTO;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_CUOTAS_PROYECTO
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_CUOTAS_PROYECTO in styLDC_CUOTAS_PROYECTO
	);

	PROCEDURE insRecord
	(
		ircLDC_CUOTAS_PROYECTO in styLDC_CUOTAS_PROYECTO,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_CUOTAS_PROYECTO in out nocopy tytbLDC_CUOTAS_PROYECTO
	);

	PROCEDURE delRecord
	(
		inuID_PROYECTO in LDC_CUOTAS_PROYECTO.ID_PROYECTO%type,
		inuCONSECUTIVO in LDC_CUOTAS_PROYECTO.CONSECUTIVO%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_CUOTAS_PROYECTO in out nocopy tytbLDC_CUOTAS_PROYECTO,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_CUOTAS_PROYECTO in styLDC_CUOTAS_PROYECTO,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_CUOTAS_PROYECTO in out nocopy tytbLDC_CUOTAS_PROYECTO,
		inuLock in number default 1
	);

	PROCEDURE updFECHA_COBRO
	(
		inuID_PROYECTO in LDC_CUOTAS_PROYECTO.ID_PROYECTO%type,
		inuCONSECUTIVO in LDC_CUOTAS_PROYECTO.CONSECUTIVO%type,
		idtFECHA_COBRO$ in LDC_CUOTAS_PROYECTO.FECHA_COBRO%type,
		inuLock in number default 0
	);

	PROCEDURE updVALOR
	(
		inuID_PROYECTO in LDC_CUOTAS_PROYECTO.ID_PROYECTO%type,
		inuCONSECUTIVO in LDC_CUOTAS_PROYECTO.CONSECUTIVO%type,
		inuVALOR$ in LDC_CUOTAS_PROYECTO.VALOR%type,
		inuLock in number default 0
	);

	PROCEDURE updFECHA_ALARMA
	(
		inuID_PROYECTO in LDC_CUOTAS_PROYECTO.ID_PROYECTO%type,
		inuCONSECUTIVO in LDC_CUOTAS_PROYECTO.CONSECUTIVO%type,
		idtFECHA_ALARMA$ in LDC_CUOTAS_PROYECTO.FECHA_ALARMA%type,
		inuLock in number default 0
	);

	PROCEDURE updESTADO
	(
		inuID_PROYECTO in LDC_CUOTAS_PROYECTO.ID_PROYECTO%type,
		inuCONSECUTIVO in LDC_CUOTAS_PROYECTO.CONSECUTIVO%type,
		isbESTADO$ in LDC_CUOTAS_PROYECTO.ESTADO%type,
		inuLock in number default 0
	);

	PROCEDURE updCUPON
	(
		inuID_PROYECTO in LDC_CUOTAS_PROYECTO.ID_PROYECTO%type,
		inuCONSECUTIVO in LDC_CUOTAS_PROYECTO.CONSECUTIVO%type,
		inuCUPON$ in LDC_CUOTAS_PROYECTO.CUPON%type,
		inuLock in number default 0
	);

	PROCEDURE updFECHA_REGISTRO
	(
		inuID_PROYECTO in LDC_CUOTAS_PROYECTO.ID_PROYECTO%type,
		inuCONSECUTIVO in LDC_CUOTAS_PROYECTO.CONSECUTIVO%type,
		idtFECHA_REGISTRO$ in LDC_CUOTAS_PROYECTO.FECHA_REGISTRO%type,
		inuLock in number default 0
	);

	PROCEDURE updUSUA_REGISTRA
	(
		inuID_PROYECTO in LDC_CUOTAS_PROYECTO.ID_PROYECTO%type,
		inuCONSECUTIVO in LDC_CUOTAS_PROYECTO.CONSECUTIVO%type,
		isbUSUA_REGISTRA$ in LDC_CUOTAS_PROYECTO.USUA_REGISTRA%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetCONSECUTIVO
	(
		inuID_PROYECTO in LDC_CUOTAS_PROYECTO.ID_PROYECTO%type,
		inuCONSECUTIVO in LDC_CUOTAS_PROYECTO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CUOTAS_PROYECTO.CONSECUTIVO%type;

	FUNCTION fnuGetID_PROYECTO
	(
		inuID_PROYECTO in LDC_CUOTAS_PROYECTO.ID_PROYECTO%type,
		inuCONSECUTIVO in LDC_CUOTAS_PROYECTO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CUOTAS_PROYECTO.ID_PROYECTO%type;

	FUNCTION fdtGetFECHA_COBRO
	(
		inuID_PROYECTO in LDC_CUOTAS_PROYECTO.ID_PROYECTO%type,
		inuCONSECUTIVO in LDC_CUOTAS_PROYECTO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CUOTAS_PROYECTO.FECHA_COBRO%type;

	FUNCTION fnuGetVALOR
	(
		inuID_PROYECTO in LDC_CUOTAS_PROYECTO.ID_PROYECTO%type,
		inuCONSECUTIVO in LDC_CUOTAS_PROYECTO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CUOTAS_PROYECTO.VALOR%type;

	FUNCTION fdtGetFECHA_ALARMA
	(
		inuID_PROYECTO in LDC_CUOTAS_PROYECTO.ID_PROYECTO%type,
		inuCONSECUTIVO in LDC_CUOTAS_PROYECTO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CUOTAS_PROYECTO.FECHA_ALARMA%type;

	FUNCTION fsbGetESTADO
	(
		inuID_PROYECTO in LDC_CUOTAS_PROYECTO.ID_PROYECTO%type,
		inuCONSECUTIVO in LDC_CUOTAS_PROYECTO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CUOTAS_PROYECTO.ESTADO%type;

	FUNCTION fnuGetCUPON
	(
		inuID_PROYECTO in LDC_CUOTAS_PROYECTO.ID_PROYECTO%type,
		inuCONSECUTIVO in LDC_CUOTAS_PROYECTO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CUOTAS_PROYECTO.CUPON%type;

	FUNCTION fdtGetFECHA_REGISTRO
	(
		inuID_PROYECTO in LDC_CUOTAS_PROYECTO.ID_PROYECTO%type,
		inuCONSECUTIVO in LDC_CUOTAS_PROYECTO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CUOTAS_PROYECTO.FECHA_REGISTRO%type;

	FUNCTION fsbGetUSUA_REGISTRA
	(
		inuID_PROYECTO in LDC_CUOTAS_PROYECTO.ID_PROYECTO%type,
		inuCONSECUTIVO in LDC_CUOTAS_PROYECTO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CUOTAS_PROYECTO.USUA_REGISTRA%type;


	PROCEDURE LockByPk
	(
		inuID_PROYECTO in LDC_CUOTAS_PROYECTO.ID_PROYECTO%type,
		inuCONSECUTIVO in LDC_CUOTAS_PROYECTO.CONSECUTIVO%type,
		orcLDC_CUOTAS_PROYECTO  out styLDC_CUOTAS_PROYECTO
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_CUOTAS_PROYECTO  out styLDC_CUOTAS_PROYECTO
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_CUOTAS_PROYECTO;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALDC_CUOTAS_PROYECTO
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_CUOTAS_PROYECTO';
	 cnuGeEntityId constant varchar2(30) := 2881; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuID_PROYECTO in LDC_CUOTAS_PROYECTO.ID_PROYECTO%type,
		inuCONSECUTIVO in LDC_CUOTAS_PROYECTO.CONSECUTIVO%type
	)
	IS
		SELECT LDC_CUOTAS_PROYECTO.*,LDC_CUOTAS_PROYECTO.rowid
		FROM LDC_CUOTAS_PROYECTO
		WHERE  ID_PROYECTO = inuID_PROYECTO
			and CONSECUTIVO = inuCONSECUTIVO
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_CUOTAS_PROYECTO.*,LDC_CUOTAS_PROYECTO.rowid
		FROM LDC_CUOTAS_PROYECTO
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_CUOTAS_PROYECTO is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_CUOTAS_PROYECTO;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_CUOTAS_PROYECTO default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.ID_PROYECTO);
		sbPk:=sbPk||','||ut_convert.fsbToChar(rcI.CONSECUTIVO);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuID_PROYECTO in LDC_CUOTAS_PROYECTO.ID_PROYECTO%type,
		inuCONSECUTIVO in LDC_CUOTAS_PROYECTO.CONSECUTIVO%type,
		orcLDC_CUOTAS_PROYECTO  out styLDC_CUOTAS_PROYECTO
	)
	IS
		rcError styLDC_CUOTAS_PROYECTO;
	BEGIN
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.CONSECUTIVO := inuCONSECUTIVO;

		Open cuLockRcByPk
		(
			inuID_PROYECTO,
			inuCONSECUTIVO
		);

		fetch cuLockRcByPk into orcLDC_CUOTAS_PROYECTO;
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
		orcLDC_CUOTAS_PROYECTO  out styLDC_CUOTAS_PROYECTO
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_CUOTAS_PROYECTO;
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
		itbLDC_CUOTAS_PROYECTO  in out nocopy tytbLDC_CUOTAS_PROYECTO
	)
	IS
	BEGIN
			rcRecOfTab.CONSECUTIVO.delete;
			rcRecOfTab.ID_PROYECTO.delete;
			rcRecOfTab.FECHA_COBRO.delete;
			rcRecOfTab.VALOR.delete;
			rcRecOfTab.FECHA_ALARMA.delete;
			rcRecOfTab.ESTADO.delete;
			rcRecOfTab.CUPON.delete;
			rcRecOfTab.FECHA_REGISTRO.delete;
			rcRecOfTab.USUA_REGISTRA.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_CUOTAS_PROYECTO  in out nocopy tytbLDC_CUOTAS_PROYECTO,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_CUOTAS_PROYECTO);

		for n in itbLDC_CUOTAS_PROYECTO.first .. itbLDC_CUOTAS_PROYECTO.last loop
			rcRecOfTab.CONSECUTIVO(n) := itbLDC_CUOTAS_PROYECTO(n).CONSECUTIVO;
			rcRecOfTab.ID_PROYECTO(n) := itbLDC_CUOTAS_PROYECTO(n).ID_PROYECTO;
			rcRecOfTab.FECHA_COBRO(n) := itbLDC_CUOTAS_PROYECTO(n).FECHA_COBRO;
			rcRecOfTab.VALOR(n) := itbLDC_CUOTAS_PROYECTO(n).VALOR;
			rcRecOfTab.FECHA_ALARMA(n) := itbLDC_CUOTAS_PROYECTO(n).FECHA_ALARMA;
			rcRecOfTab.ESTADO(n) := itbLDC_CUOTAS_PROYECTO(n).ESTADO;
			rcRecOfTab.CUPON(n) := itbLDC_CUOTAS_PROYECTO(n).CUPON;
			rcRecOfTab.FECHA_REGISTRO(n) := itbLDC_CUOTAS_PROYECTO(n).FECHA_REGISTRO;
			rcRecOfTab.USUA_REGISTRA(n) := itbLDC_CUOTAS_PROYECTO(n).USUA_REGISTRA;
			rcRecOfTab.row_id(n) := itbLDC_CUOTAS_PROYECTO(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuID_PROYECTO in LDC_CUOTAS_PROYECTO.ID_PROYECTO%type,
		inuCONSECUTIVO in LDC_CUOTAS_PROYECTO.CONSECUTIVO%type
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
		inuID_PROYECTO in LDC_CUOTAS_PROYECTO.ID_PROYECTO%type,
		inuCONSECUTIVO in LDC_CUOTAS_PROYECTO.CONSECUTIVO%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuID_PROYECTO = rcData.ID_PROYECTO AND
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
		inuID_PROYECTO in LDC_CUOTAS_PROYECTO.ID_PROYECTO%type,
		inuCONSECUTIVO in LDC_CUOTAS_PROYECTO.CONSECUTIVO%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuID_PROYECTO,
			inuCONSECUTIVO
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuID_PROYECTO in LDC_CUOTAS_PROYECTO.ID_PROYECTO%type,
		inuCONSECUTIVO in LDC_CUOTAS_PROYECTO.CONSECUTIVO%type
	)
	IS
		rcError styLDC_CUOTAS_PROYECTO;
	BEGIN		rcError.ID_PROYECTO:=inuID_PROYECTO;		rcError.CONSECUTIVO:=inuCONSECUTIVO;

		Load
		(
			inuID_PROYECTO,
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
		inuID_PROYECTO in LDC_CUOTAS_PROYECTO.ID_PROYECTO%type,
		inuCONSECUTIVO in LDC_CUOTAS_PROYECTO.CONSECUTIVO%type
	)
	IS
	BEGIN
		Load
		(
			inuID_PROYECTO,
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
		inuID_PROYECTO in LDC_CUOTAS_PROYECTO.ID_PROYECTO%type,
		inuCONSECUTIVO in LDC_CUOTAS_PROYECTO.CONSECUTIVO%type,
		orcRecord out nocopy styLDC_CUOTAS_PROYECTO
	)
	IS
		rcError styLDC_CUOTAS_PROYECTO;
	BEGIN		rcError.ID_PROYECTO:=inuID_PROYECTO;		rcError.CONSECUTIVO:=inuCONSECUTIVO;

		Load
		(
			inuID_PROYECTO,
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
		inuID_PROYECTO in LDC_CUOTAS_PROYECTO.ID_PROYECTO%type,
		inuCONSECUTIVO in LDC_CUOTAS_PROYECTO.CONSECUTIVO%type
	)
	RETURN styLDC_CUOTAS_PROYECTO
	IS
		rcError styLDC_CUOTAS_PROYECTO;
	BEGIN
		rcError.ID_PROYECTO:=inuID_PROYECTO;
		rcError.CONSECUTIVO:=inuCONSECUTIVO;

		Load
		(
			inuID_PROYECTO,
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
		inuID_PROYECTO in LDC_CUOTAS_PROYECTO.ID_PROYECTO%type,
		inuCONSECUTIVO in LDC_CUOTAS_PROYECTO.CONSECUTIVO%type
	)
	RETURN styLDC_CUOTAS_PROYECTO
	IS
		rcError styLDC_CUOTAS_PROYECTO;
	BEGIN
		rcError.ID_PROYECTO:=inuID_PROYECTO;
		rcError.CONSECUTIVO:=inuCONSECUTIVO;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuID_PROYECTO,
			inuCONSECUTIVO
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuID_PROYECTO,
			inuCONSECUTIVO
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_CUOTAS_PROYECTO
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_CUOTAS_PROYECTO
	)
	IS
		rfLDC_CUOTAS_PROYECTO tyrfLDC_CUOTAS_PROYECTO;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_CUOTAS_PROYECTO.*, LDC_CUOTAS_PROYECTO.rowid FROM LDC_CUOTAS_PROYECTO';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_CUOTAS_PROYECTO for sbFullQuery;

		fetch rfLDC_CUOTAS_PROYECTO bulk collect INTO otbResult;

		close rfLDC_CUOTAS_PROYECTO;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_CUOTAS_PROYECTO.*, LDC_CUOTAS_PROYECTO.rowid FROM LDC_CUOTAS_PROYECTO';
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
		ircLDC_CUOTAS_PROYECTO in styLDC_CUOTAS_PROYECTO
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_CUOTAS_PROYECTO,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_CUOTAS_PROYECTO in styLDC_CUOTAS_PROYECTO,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_CUOTAS_PROYECTO.ID_PROYECTO is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ID_PROYECTO');
			raise ex.controlled_error;
		end if;
		if ircLDC_CUOTAS_PROYECTO.CONSECUTIVO is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|CONSECUTIVO');
			raise ex.controlled_error;
		end if;

		insert into LDC_CUOTAS_PROYECTO
		(
			CONSECUTIVO,
			ID_PROYECTO,
			FECHA_COBRO,
			VALOR,
			FECHA_ALARMA,
			ESTADO,
			CUPON,
			FECHA_REGISTRO,
			USUA_REGISTRA
		)
		values
		(
			ircLDC_CUOTAS_PROYECTO.CONSECUTIVO,
			ircLDC_CUOTAS_PROYECTO.ID_PROYECTO,
			ircLDC_CUOTAS_PROYECTO.FECHA_COBRO,
			ircLDC_CUOTAS_PROYECTO.VALOR,
			ircLDC_CUOTAS_PROYECTO.FECHA_ALARMA,
			ircLDC_CUOTAS_PROYECTO.ESTADO,
			ircLDC_CUOTAS_PROYECTO.CUPON,
			ircLDC_CUOTAS_PROYECTO.FECHA_REGISTRO,
			ircLDC_CUOTAS_PROYECTO.USUA_REGISTRA
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_CUOTAS_PROYECTO));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_CUOTAS_PROYECTO in out nocopy tytbLDC_CUOTAS_PROYECTO
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_CUOTAS_PROYECTO,blUseRowID);
		forall n in iotbLDC_CUOTAS_PROYECTO.first..iotbLDC_CUOTAS_PROYECTO.last
			insert into LDC_CUOTAS_PROYECTO
			(
				CONSECUTIVO,
				ID_PROYECTO,
				FECHA_COBRO,
				VALOR,
				FECHA_ALARMA,
				ESTADO,
				CUPON,
				FECHA_REGISTRO,
				USUA_REGISTRA
			)
			values
			(
				rcRecOfTab.CONSECUTIVO(n),
				rcRecOfTab.ID_PROYECTO(n),
				rcRecOfTab.FECHA_COBRO(n),
				rcRecOfTab.VALOR(n),
				rcRecOfTab.FECHA_ALARMA(n),
				rcRecOfTab.ESTADO(n),
				rcRecOfTab.CUPON(n),
				rcRecOfTab.FECHA_REGISTRO(n),
				rcRecOfTab.USUA_REGISTRA(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuID_PROYECTO in LDC_CUOTAS_PROYECTO.ID_PROYECTO%type,
		inuCONSECUTIVO in LDC_CUOTAS_PROYECTO.CONSECUTIVO%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_CUOTAS_PROYECTO;
	BEGIN
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.CONSECUTIVO := inuCONSECUTIVO;

		if inuLock=1 then
			LockByPk
			(
				inuID_PROYECTO,
				inuCONSECUTIVO,
				rcData
			);
		end if;


		delete
		from LDC_CUOTAS_PROYECTO
		where
       		ID_PROYECTO=inuID_PROYECTO and
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
		rcError  styLDC_CUOTAS_PROYECTO;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_CUOTAS_PROYECTO
		where
			rowid = iriRowID
		returning
			CONSECUTIVO,
			ID_PROYECTO
		into
			rcError.CONSECUTIVO,
			rcError.ID_PROYECTO;
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
		iotbLDC_CUOTAS_PROYECTO in out nocopy tytbLDC_CUOTAS_PROYECTO,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_CUOTAS_PROYECTO;
	BEGIN
		FillRecordOfTables(iotbLDC_CUOTAS_PROYECTO, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_CUOTAS_PROYECTO.first .. iotbLDC_CUOTAS_PROYECTO.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CUOTAS_PROYECTO.first .. iotbLDC_CUOTAS_PROYECTO.last
				delete
				from LDC_CUOTAS_PROYECTO
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_CUOTAS_PROYECTO.first .. iotbLDC_CUOTAS_PROYECTO.last loop
					LockByPk
					(
						rcRecOfTab.ID_PROYECTO(n),
						rcRecOfTab.CONSECUTIVO(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CUOTAS_PROYECTO.first .. iotbLDC_CUOTAS_PROYECTO.last
				delete
				from LDC_CUOTAS_PROYECTO
				where
		         	ID_PROYECTO = rcRecOfTab.ID_PROYECTO(n) and
		         	CONSECUTIVO = rcRecOfTab.CONSECUTIVO(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_CUOTAS_PROYECTO in styLDC_CUOTAS_PROYECTO,
		inuLock in number default 0
	)
	IS
		nuID_PROYECTO	LDC_CUOTAS_PROYECTO.ID_PROYECTO%type;
		nuCONSECUTIVO	LDC_CUOTAS_PROYECTO.CONSECUTIVO%type;
	BEGIN
		if ircLDC_CUOTAS_PROYECTO.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_CUOTAS_PROYECTO.rowid,rcData);
			end if;
			update LDC_CUOTAS_PROYECTO
			set
				FECHA_COBRO = ircLDC_CUOTAS_PROYECTO.FECHA_COBRO,
				VALOR = ircLDC_CUOTAS_PROYECTO.VALOR,
				FECHA_ALARMA = ircLDC_CUOTAS_PROYECTO.FECHA_ALARMA,
				ESTADO = ircLDC_CUOTAS_PROYECTO.ESTADO,
				CUPON = ircLDC_CUOTAS_PROYECTO.CUPON,
				FECHA_REGISTRO = ircLDC_CUOTAS_PROYECTO.FECHA_REGISTRO,
				USUA_REGISTRA = ircLDC_CUOTAS_PROYECTO.USUA_REGISTRA
			where
				rowid = ircLDC_CUOTAS_PROYECTO.rowid
			returning
				ID_PROYECTO,
				CONSECUTIVO
			into
				nuID_PROYECTO,
				nuCONSECUTIVO;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_CUOTAS_PROYECTO.ID_PROYECTO,
					ircLDC_CUOTAS_PROYECTO.CONSECUTIVO,
					rcData
				);
			end if;

			update LDC_CUOTAS_PROYECTO
			set
				FECHA_COBRO = ircLDC_CUOTAS_PROYECTO.FECHA_COBRO,
				VALOR = ircLDC_CUOTAS_PROYECTO.VALOR,
				FECHA_ALARMA = ircLDC_CUOTAS_PROYECTO.FECHA_ALARMA,
				ESTADO = ircLDC_CUOTAS_PROYECTO.ESTADO,
				CUPON = ircLDC_CUOTAS_PROYECTO.CUPON,
				FECHA_REGISTRO = ircLDC_CUOTAS_PROYECTO.FECHA_REGISTRO,
				USUA_REGISTRA = ircLDC_CUOTAS_PROYECTO.USUA_REGISTRA
			where
				ID_PROYECTO = ircLDC_CUOTAS_PROYECTO.ID_PROYECTO and
				CONSECUTIVO = ircLDC_CUOTAS_PROYECTO.CONSECUTIVO
			returning
				ID_PROYECTO,
				CONSECUTIVO
			into
				nuID_PROYECTO,
				nuCONSECUTIVO;
		end if;
		if
			nuID_PROYECTO is NULL OR
			nuCONSECUTIVO is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_CUOTAS_PROYECTO));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_CUOTAS_PROYECTO in out nocopy tytbLDC_CUOTAS_PROYECTO,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_CUOTAS_PROYECTO;
	BEGIN
		FillRecordOfTables(iotbLDC_CUOTAS_PROYECTO,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_CUOTAS_PROYECTO.first .. iotbLDC_CUOTAS_PROYECTO.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CUOTAS_PROYECTO.first .. iotbLDC_CUOTAS_PROYECTO.last
				update LDC_CUOTAS_PROYECTO
				set
					FECHA_COBRO = rcRecOfTab.FECHA_COBRO(n),
					VALOR = rcRecOfTab.VALOR(n),
					FECHA_ALARMA = rcRecOfTab.FECHA_ALARMA(n),
					ESTADO = rcRecOfTab.ESTADO(n),
					CUPON = rcRecOfTab.CUPON(n),
					FECHA_REGISTRO = rcRecOfTab.FECHA_REGISTRO(n),
					USUA_REGISTRA = rcRecOfTab.USUA_REGISTRA(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_CUOTAS_PROYECTO.first .. iotbLDC_CUOTAS_PROYECTO.last loop
					LockByPk
					(
						rcRecOfTab.ID_PROYECTO(n),
						rcRecOfTab.CONSECUTIVO(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CUOTAS_PROYECTO.first .. iotbLDC_CUOTAS_PROYECTO.last
				update LDC_CUOTAS_PROYECTO
				SET
					FECHA_COBRO = rcRecOfTab.FECHA_COBRO(n),
					VALOR = rcRecOfTab.VALOR(n),
					FECHA_ALARMA = rcRecOfTab.FECHA_ALARMA(n),
					ESTADO = rcRecOfTab.ESTADO(n),
					CUPON = rcRecOfTab.CUPON(n),
					FECHA_REGISTRO = rcRecOfTab.FECHA_REGISTRO(n),
					USUA_REGISTRA = rcRecOfTab.USUA_REGISTRA(n)
				where
					ID_PROYECTO = rcRecOfTab.ID_PROYECTO(n) and
					CONSECUTIVO = rcRecOfTab.CONSECUTIVO(n)
;
		end if;
	END;
	PROCEDURE updFECHA_COBRO
	(
		inuID_PROYECTO in LDC_CUOTAS_PROYECTO.ID_PROYECTO%type,
		inuCONSECUTIVO in LDC_CUOTAS_PROYECTO.CONSECUTIVO%type,
		idtFECHA_COBRO$ in LDC_CUOTAS_PROYECTO.FECHA_COBRO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CUOTAS_PROYECTO;
	BEGIN
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuID_PROYECTO,
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_CUOTAS_PROYECTO
		set
			FECHA_COBRO = idtFECHA_COBRO$
		where
			ID_PROYECTO = inuID_PROYECTO and
			CONSECUTIVO = inuCONSECUTIVO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FECHA_COBRO:= idtFECHA_COBRO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updVALOR
	(
		inuID_PROYECTO in LDC_CUOTAS_PROYECTO.ID_PROYECTO%type,
		inuCONSECUTIVO in LDC_CUOTAS_PROYECTO.CONSECUTIVO%type,
		inuVALOR$ in LDC_CUOTAS_PROYECTO.VALOR%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CUOTAS_PROYECTO;
	BEGIN
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuID_PROYECTO,
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_CUOTAS_PROYECTO
		set
			VALOR = inuVALOR$
		where
			ID_PROYECTO = inuID_PROYECTO and
			CONSECUTIVO = inuCONSECUTIVO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.VALOR:= inuVALOR$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFECHA_ALARMA
	(
		inuID_PROYECTO in LDC_CUOTAS_PROYECTO.ID_PROYECTO%type,
		inuCONSECUTIVO in LDC_CUOTAS_PROYECTO.CONSECUTIVO%type,
		idtFECHA_ALARMA$ in LDC_CUOTAS_PROYECTO.FECHA_ALARMA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CUOTAS_PROYECTO;
	BEGIN
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuID_PROYECTO,
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_CUOTAS_PROYECTO
		set
			FECHA_ALARMA = idtFECHA_ALARMA$
		where
			ID_PROYECTO = inuID_PROYECTO and
			CONSECUTIVO = inuCONSECUTIVO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FECHA_ALARMA:= idtFECHA_ALARMA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updESTADO
	(
		inuID_PROYECTO in LDC_CUOTAS_PROYECTO.ID_PROYECTO%type,
		inuCONSECUTIVO in LDC_CUOTAS_PROYECTO.CONSECUTIVO%type,
		isbESTADO$ in LDC_CUOTAS_PROYECTO.ESTADO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CUOTAS_PROYECTO;
	BEGIN
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuID_PROYECTO,
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_CUOTAS_PROYECTO
		set
			ESTADO = isbESTADO$
		where
			ID_PROYECTO = inuID_PROYECTO and
			CONSECUTIVO = inuCONSECUTIVO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ESTADO:= isbESTADO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCUPON
	(
		inuID_PROYECTO in LDC_CUOTAS_PROYECTO.ID_PROYECTO%type,
		inuCONSECUTIVO in LDC_CUOTAS_PROYECTO.CONSECUTIVO%type,
		inuCUPON$ in LDC_CUOTAS_PROYECTO.CUPON%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CUOTAS_PROYECTO;
	BEGIN
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuID_PROYECTO,
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_CUOTAS_PROYECTO
		set
			CUPON = inuCUPON$
		where
			ID_PROYECTO = inuID_PROYECTO and
			CONSECUTIVO = inuCONSECUTIVO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CUPON:= inuCUPON$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFECHA_REGISTRO
	(
		inuID_PROYECTO in LDC_CUOTAS_PROYECTO.ID_PROYECTO%type,
		inuCONSECUTIVO in LDC_CUOTAS_PROYECTO.CONSECUTIVO%type,
		idtFECHA_REGISTRO$ in LDC_CUOTAS_PROYECTO.FECHA_REGISTRO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CUOTAS_PROYECTO;
	BEGIN
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuID_PROYECTO,
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_CUOTAS_PROYECTO
		set
			FECHA_REGISTRO = idtFECHA_REGISTRO$
		where
			ID_PROYECTO = inuID_PROYECTO and
			CONSECUTIVO = inuCONSECUTIVO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FECHA_REGISTRO:= idtFECHA_REGISTRO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updUSUA_REGISTRA
	(
		inuID_PROYECTO in LDC_CUOTAS_PROYECTO.ID_PROYECTO%type,
		inuCONSECUTIVO in LDC_CUOTAS_PROYECTO.CONSECUTIVO%type,
		isbUSUA_REGISTRA$ in LDC_CUOTAS_PROYECTO.USUA_REGISTRA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CUOTAS_PROYECTO;
	BEGIN
		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuID_PROYECTO,
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_CUOTAS_PROYECTO
		set
			USUA_REGISTRA = isbUSUA_REGISTRA$
		where
			ID_PROYECTO = inuID_PROYECTO and
			CONSECUTIVO = inuCONSECUTIVO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.USUA_REGISTRA:= isbUSUA_REGISTRA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetCONSECUTIVO
	(
		inuID_PROYECTO in LDC_CUOTAS_PROYECTO.ID_PROYECTO%type,
		inuCONSECUTIVO in LDC_CUOTAS_PROYECTO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CUOTAS_PROYECTO.CONSECUTIVO%type
	IS
		rcError styLDC_CUOTAS_PROYECTO;
	BEGIN

		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PROYECTO,
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.CONSECUTIVO);
		end if;
		Load
		(
		 		inuID_PROYECTO,
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
	FUNCTION fnuGetID_PROYECTO
	(
		inuID_PROYECTO in LDC_CUOTAS_PROYECTO.ID_PROYECTO%type,
		inuCONSECUTIVO in LDC_CUOTAS_PROYECTO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CUOTAS_PROYECTO.ID_PROYECTO%type
	IS
		rcError styLDC_CUOTAS_PROYECTO;
	BEGIN

		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PROYECTO,
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.ID_PROYECTO);
		end if;
		Load
		(
		 		inuID_PROYECTO,
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
	FUNCTION fdtGetFECHA_COBRO
	(
		inuID_PROYECTO in LDC_CUOTAS_PROYECTO.ID_PROYECTO%type,
		inuCONSECUTIVO in LDC_CUOTAS_PROYECTO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CUOTAS_PROYECTO.FECHA_COBRO%type
	IS
		rcError styLDC_CUOTAS_PROYECTO;
	BEGIN

		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PROYECTO,
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.FECHA_COBRO);
		end if;
		Load
		(
		 		inuID_PROYECTO,
		 		inuCONSECUTIVO
		);
		return(rcData.FECHA_COBRO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetVALOR
	(
		inuID_PROYECTO in LDC_CUOTAS_PROYECTO.ID_PROYECTO%type,
		inuCONSECUTIVO in LDC_CUOTAS_PROYECTO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CUOTAS_PROYECTO.VALOR%type
	IS
		rcError styLDC_CUOTAS_PROYECTO;
	BEGIN

		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PROYECTO,
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.VALOR);
		end if;
		Load
		(
		 		inuID_PROYECTO,
		 		inuCONSECUTIVO
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
	FUNCTION fdtGetFECHA_ALARMA
	(
		inuID_PROYECTO in LDC_CUOTAS_PROYECTO.ID_PROYECTO%type,
		inuCONSECUTIVO in LDC_CUOTAS_PROYECTO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CUOTAS_PROYECTO.FECHA_ALARMA%type
	IS
		rcError styLDC_CUOTAS_PROYECTO;
	BEGIN

		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PROYECTO,
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.FECHA_ALARMA);
		end if;
		Load
		(
		 		inuID_PROYECTO,
		 		inuCONSECUTIVO
		);
		return(rcData.FECHA_ALARMA);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetESTADO
	(
		inuID_PROYECTO in LDC_CUOTAS_PROYECTO.ID_PROYECTO%type,
		inuCONSECUTIVO in LDC_CUOTAS_PROYECTO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CUOTAS_PROYECTO.ESTADO%type
	IS
		rcError styLDC_CUOTAS_PROYECTO;
	BEGIN

		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PROYECTO,
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.ESTADO);
		end if;
		Load
		(
		 		inuID_PROYECTO,
		 		inuCONSECUTIVO
		);
		return(rcData.ESTADO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCUPON
	(
		inuID_PROYECTO in LDC_CUOTAS_PROYECTO.ID_PROYECTO%type,
		inuCONSECUTIVO in LDC_CUOTAS_PROYECTO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CUOTAS_PROYECTO.CUPON%type
	IS
		rcError styLDC_CUOTAS_PROYECTO;
	BEGIN

		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PROYECTO,
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.CUPON);
		end if;
		Load
		(
		 		inuID_PROYECTO,
		 		inuCONSECUTIVO
		);
		return(rcData.CUPON);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetFECHA_REGISTRO
	(
		inuID_PROYECTO in LDC_CUOTAS_PROYECTO.ID_PROYECTO%type,
		inuCONSECUTIVO in LDC_CUOTAS_PROYECTO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CUOTAS_PROYECTO.FECHA_REGISTRO%type
	IS
		rcError styLDC_CUOTAS_PROYECTO;
	BEGIN

		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PROYECTO,
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.FECHA_REGISTRO);
		end if;
		Load
		(
		 		inuID_PROYECTO,
		 		inuCONSECUTIVO
		);
		return(rcData.FECHA_REGISTRO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetUSUA_REGISTRA
	(
		inuID_PROYECTO in LDC_CUOTAS_PROYECTO.ID_PROYECTO%type,
		inuCONSECUTIVO in LDC_CUOTAS_PROYECTO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CUOTAS_PROYECTO.USUA_REGISTRA%type
	IS
		rcError styLDC_CUOTAS_PROYECTO;
	BEGIN

		rcError.ID_PROYECTO := inuID_PROYECTO;
		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_PROYECTO,
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.USUA_REGISTRA);
		end if;
		Load
		(
		 		inuID_PROYECTO,
		 		inuCONSECUTIVO
		);
		return(rcData.USUA_REGISTRA);
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
end DALDC_CUOTAS_PROYECTO;
/
PROMPT Otorgando permisos de ejecucion a DALDC_CUOTAS_PROYECTO
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_CUOTAS_PROYECTO', 'ADM_PERSON');
END;
/