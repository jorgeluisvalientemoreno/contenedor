CREATE OR REPLACE PACKAGE ADM_PERSON.DALDC_CHEQUES_PROYECTO
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
		inuCONSECUTIVO in LDC_CHEQUES_PROYECTO.CONSECUTIVO%type
	)
	IS
		SELECT LDC_CHEQUES_PROYECTO.*,LDC_CHEQUES_PROYECTO.rowid
		FROM LDC_CHEQUES_PROYECTO
		WHERE
		    CONSECUTIVO = inuCONSECUTIVO;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_CHEQUES_PROYECTO.*,LDC_CHEQUES_PROYECTO.rowid
		FROM LDC_CHEQUES_PROYECTO
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_CHEQUES_PROYECTO  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_CHEQUES_PROYECTO is table of styLDC_CHEQUES_PROYECTO index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_CHEQUES_PROYECTO;

	/* Tipos referenciando al registro */
	type tytbCONSECUTIVO is table of LDC_CHEQUES_PROYECTO.CONSECUTIVO%type index by binary_integer;
	type tytbID_PROYECTO is table of LDC_CHEQUES_PROYECTO.ID_PROYECTO%type index by binary_integer;
	type tytbNUMERO_CHEQUE is table of LDC_CHEQUES_PROYECTO.NUMERO_CHEQUE%type index by binary_integer;
	type tytbENTIDAD is table of LDC_CHEQUES_PROYECTO.ENTIDAD%type index by binary_integer;
	type tytbESTADO is table of LDC_CHEQUES_PROYECTO.ESTADO%type index by binary_integer;
	type tytbFECHA_CHEQUE is table of LDC_CHEQUES_PROYECTO.FECHA_CHEQUE%type index by binary_integer;
	type tytbFECHA_ALARMA is table of LDC_CHEQUES_PROYECTO.FECHA_ALARMA%type index by binary_integer;
	type tytbVALOR is table of LDC_CHEQUES_PROYECTO.VALOR%type index by binary_integer;
	type tytbNUEVO_CHEQUE is table of LDC_CHEQUES_PROYECTO.NUEVO_CHEQUE%type index by binary_integer;
	type tytbCUPON is table of LDC_CHEQUES_PROYECTO.CUPON%type index by binary_integer;
	type tytbUSUA_REGISTRA is table of LDC_CHEQUES_PROYECTO.USUA_REGISTRA%type index by binary_integer;
	type tytbFECHA_REGISTRO is table of LDC_CHEQUES_PROYECTO.FECHA_REGISTRO%type index by binary_integer;
	type tytbCUENTA is table of LDC_CHEQUES_PROYECTO.CUENTA%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_CHEQUES_PROYECTO is record
	(
		CONSECUTIVO   tytbCONSECUTIVO,
		ID_PROYECTO   tytbID_PROYECTO,
		NUMERO_CHEQUE   tytbNUMERO_CHEQUE,
		ENTIDAD   tytbENTIDAD,
		ESTADO   tytbESTADO,
		FECHA_CHEQUE   tytbFECHA_CHEQUE,
		FECHA_ALARMA   tytbFECHA_ALARMA,
		VALOR   tytbVALOR,
		NUEVO_CHEQUE   tytbNUEVO_CHEQUE,
		CUPON   tytbCUPON,
		USUA_REGISTRA   tytbUSUA_REGISTRA,
		FECHA_REGISTRO   tytbFECHA_REGISTRO,
		CUENTA   tytbCUENTA,
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
		inuCONSECUTIVO in LDC_CHEQUES_PROYECTO.CONSECUTIVO%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuCONSECUTIVO in LDC_CHEQUES_PROYECTO.CONSECUTIVO%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuCONSECUTIVO in LDC_CHEQUES_PROYECTO.CONSECUTIVO%type
	);

	PROCEDURE getRecord
	(
		inuCONSECUTIVO in LDC_CHEQUES_PROYECTO.CONSECUTIVO%type,
		orcRecord out nocopy styLDC_CHEQUES_PROYECTO
	);

	FUNCTION frcGetRcData
	(
		inuCONSECUTIVO in LDC_CHEQUES_PROYECTO.CONSECUTIVO%type
	)
	RETURN styLDC_CHEQUES_PROYECTO;

	FUNCTION frcGetRcData
	RETURN styLDC_CHEQUES_PROYECTO;

	FUNCTION frcGetRecord
	(
		inuCONSECUTIVO in LDC_CHEQUES_PROYECTO.CONSECUTIVO%type
	)
	RETURN styLDC_CHEQUES_PROYECTO;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_CHEQUES_PROYECTO
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_CHEQUES_PROYECTO in styLDC_CHEQUES_PROYECTO
	);

	PROCEDURE insRecord
	(
		ircLDC_CHEQUES_PROYECTO in styLDC_CHEQUES_PROYECTO,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_CHEQUES_PROYECTO in out nocopy tytbLDC_CHEQUES_PROYECTO
	);

	PROCEDURE delRecord
	(
		inuCONSECUTIVO in LDC_CHEQUES_PROYECTO.CONSECUTIVO%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_CHEQUES_PROYECTO in out nocopy tytbLDC_CHEQUES_PROYECTO,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_CHEQUES_PROYECTO in styLDC_CHEQUES_PROYECTO,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_CHEQUES_PROYECTO in out nocopy tytbLDC_CHEQUES_PROYECTO,
		inuLock in number default 1
	);

	PROCEDURE updID_PROYECTO
	(
		inuCONSECUTIVO in LDC_CHEQUES_PROYECTO.CONSECUTIVO%type,
		inuID_PROYECTO$ in LDC_CHEQUES_PROYECTO.ID_PROYECTO%type,
		inuLock in number default 0
	);

	PROCEDURE updNUMERO_CHEQUE
	(
		inuCONSECUTIVO in LDC_CHEQUES_PROYECTO.CONSECUTIVO%type,
		isbNUMERO_CHEQUE$ in LDC_CHEQUES_PROYECTO.NUMERO_CHEQUE%type,
		inuLock in number default 0
	);

	PROCEDURE updENTIDAD
	(
		inuCONSECUTIVO in LDC_CHEQUES_PROYECTO.CONSECUTIVO%type,
		inuENTIDAD$ in LDC_CHEQUES_PROYECTO.ENTIDAD%type,
		inuLock in number default 0
	);

	PROCEDURE updESTADO
	(
		inuCONSECUTIVO in LDC_CHEQUES_PROYECTO.CONSECUTIVO%type,
		isbESTADO$ in LDC_CHEQUES_PROYECTO.ESTADO%type,
		inuLock in number default 0
	);

	PROCEDURE updFECHA_CHEQUE
	(
		inuCONSECUTIVO in LDC_CHEQUES_PROYECTO.CONSECUTIVO%type,
		idtFECHA_CHEQUE$ in LDC_CHEQUES_PROYECTO.FECHA_CHEQUE%type,
		inuLock in number default 0
	);

	PROCEDURE updFECHA_ALARMA
	(
		inuCONSECUTIVO in LDC_CHEQUES_PROYECTO.CONSECUTIVO%type,
		idtFECHA_ALARMA$ in LDC_CHEQUES_PROYECTO.FECHA_ALARMA%type,
		inuLock in number default 0
	);

	PROCEDURE updVALOR
	(
		inuCONSECUTIVO in LDC_CHEQUES_PROYECTO.CONSECUTIVO%type,
		inuVALOR$ in LDC_CHEQUES_PROYECTO.VALOR%type,
		inuLock in number default 0
	);

	PROCEDURE updNUEVO_CHEQUE
	(
		inuCONSECUTIVO in LDC_CHEQUES_PROYECTO.CONSECUTIVO%type,
		isbNUEVO_CHEQUE$ in LDC_CHEQUES_PROYECTO.NUEVO_CHEQUE%type,
		inuLock in number default 0
	);

	PROCEDURE updCUPON
	(
		inuCONSECUTIVO in LDC_CHEQUES_PROYECTO.CONSECUTIVO%type,
		inuCUPON$ in LDC_CHEQUES_PROYECTO.CUPON%type,
		inuLock in number default 0
	);

	PROCEDURE updUSUA_REGISTRA
	(
		inuCONSECUTIVO in LDC_CHEQUES_PROYECTO.CONSECUTIVO%type,
		isbUSUA_REGISTRA$ in LDC_CHEQUES_PROYECTO.USUA_REGISTRA%type,
		inuLock in number default 0
	);

	PROCEDURE updFECHA_REGISTRO
	(
		inuCONSECUTIVO in LDC_CHEQUES_PROYECTO.CONSECUTIVO%type,
		idtFECHA_REGISTRO$ in LDC_CHEQUES_PROYECTO.FECHA_REGISTRO%type,
		inuLock in number default 0
	);

	PROCEDURE updCUENTA
	(
		inuCONSECUTIVO in LDC_CHEQUES_PROYECTO.CONSECUTIVO%type,
		isbCUENTA$ in LDC_CHEQUES_PROYECTO.CUENTA%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetCONSECUTIVO
	(
		inuCONSECUTIVO in LDC_CHEQUES_PROYECTO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CHEQUES_PROYECTO.CONSECUTIVO%type;

	FUNCTION fnuGetID_PROYECTO
	(
		inuCONSECUTIVO in LDC_CHEQUES_PROYECTO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CHEQUES_PROYECTO.ID_PROYECTO%type;

	FUNCTION fsbGetNUMERO_CHEQUE
	(
		inuCONSECUTIVO in LDC_CHEQUES_PROYECTO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CHEQUES_PROYECTO.NUMERO_CHEQUE%type;

	FUNCTION fnuGetENTIDAD
	(
		inuCONSECUTIVO in LDC_CHEQUES_PROYECTO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CHEQUES_PROYECTO.ENTIDAD%type;

	FUNCTION fsbGetESTADO
	(
		inuCONSECUTIVO in LDC_CHEQUES_PROYECTO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CHEQUES_PROYECTO.ESTADO%type;

	FUNCTION fdtGetFECHA_CHEQUE
	(
		inuCONSECUTIVO in LDC_CHEQUES_PROYECTO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CHEQUES_PROYECTO.FECHA_CHEQUE%type;

	FUNCTION fdtGetFECHA_ALARMA
	(
		inuCONSECUTIVO in LDC_CHEQUES_PROYECTO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CHEQUES_PROYECTO.FECHA_ALARMA%type;

	FUNCTION fnuGetVALOR
	(
		inuCONSECUTIVO in LDC_CHEQUES_PROYECTO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CHEQUES_PROYECTO.VALOR%type;

	FUNCTION fsbGetNUEVO_CHEQUE
	(
		inuCONSECUTIVO in LDC_CHEQUES_PROYECTO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CHEQUES_PROYECTO.NUEVO_CHEQUE%type;

	FUNCTION fnuGetCUPON
	(
		inuCONSECUTIVO in LDC_CHEQUES_PROYECTO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CHEQUES_PROYECTO.CUPON%type;

	FUNCTION fsbGetUSUA_REGISTRA
	(
		inuCONSECUTIVO in LDC_CHEQUES_PROYECTO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CHEQUES_PROYECTO.USUA_REGISTRA%type;

	FUNCTION fdtGetFECHA_REGISTRO
	(
		inuCONSECUTIVO in LDC_CHEQUES_PROYECTO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CHEQUES_PROYECTO.FECHA_REGISTRO%type;

	FUNCTION fsbGetCUENTA
	(
		inuCONSECUTIVO in LDC_CHEQUES_PROYECTO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CHEQUES_PROYECTO.CUENTA%type;


	PROCEDURE LockByPk
	(
		inuCONSECUTIVO in LDC_CHEQUES_PROYECTO.CONSECUTIVO%type,
		orcLDC_CHEQUES_PROYECTO  out styLDC_CHEQUES_PROYECTO
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_CHEQUES_PROYECTO  out styLDC_CHEQUES_PROYECTO
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_CHEQUES_PROYECTO;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALDC_CHEQUES_PROYECTO
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_CHEQUES_PROYECTO';
	 cnuGeEntityId constant varchar2(30) := 2879; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuCONSECUTIVO in LDC_CHEQUES_PROYECTO.CONSECUTIVO%type
	)
	IS
		SELECT LDC_CHEQUES_PROYECTO.*,LDC_CHEQUES_PROYECTO.rowid
		FROM LDC_CHEQUES_PROYECTO
		WHERE  CONSECUTIVO = inuCONSECUTIVO
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_CHEQUES_PROYECTO.*,LDC_CHEQUES_PROYECTO.rowid
		FROM LDC_CHEQUES_PROYECTO
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_CHEQUES_PROYECTO is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_CHEQUES_PROYECTO;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_CHEQUES_PROYECTO default rcData )
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
		inuCONSECUTIVO in LDC_CHEQUES_PROYECTO.CONSECUTIVO%type,
		orcLDC_CHEQUES_PROYECTO  out styLDC_CHEQUES_PROYECTO
	)
	IS
		rcError styLDC_CHEQUES_PROYECTO;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;

		Open cuLockRcByPk
		(
			inuCONSECUTIVO
		);

		fetch cuLockRcByPk into orcLDC_CHEQUES_PROYECTO;
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
		orcLDC_CHEQUES_PROYECTO  out styLDC_CHEQUES_PROYECTO
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_CHEQUES_PROYECTO;
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
		itbLDC_CHEQUES_PROYECTO  in out nocopy tytbLDC_CHEQUES_PROYECTO
	)
	IS
	BEGIN
			rcRecOfTab.CONSECUTIVO.delete;
			rcRecOfTab.ID_PROYECTO.delete;
			rcRecOfTab.NUMERO_CHEQUE.delete;
			rcRecOfTab.ENTIDAD.delete;
			rcRecOfTab.ESTADO.delete;
			rcRecOfTab.FECHA_CHEQUE.delete;
			rcRecOfTab.FECHA_ALARMA.delete;
			rcRecOfTab.VALOR.delete;
			rcRecOfTab.NUEVO_CHEQUE.delete;
			rcRecOfTab.CUPON.delete;
			rcRecOfTab.USUA_REGISTRA.delete;
			rcRecOfTab.FECHA_REGISTRO.delete;
			rcRecOfTab.CUENTA.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_CHEQUES_PROYECTO  in out nocopy tytbLDC_CHEQUES_PROYECTO,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_CHEQUES_PROYECTO);

		for n in itbLDC_CHEQUES_PROYECTO.first .. itbLDC_CHEQUES_PROYECTO.last loop
			rcRecOfTab.CONSECUTIVO(n) := itbLDC_CHEQUES_PROYECTO(n).CONSECUTIVO;
			rcRecOfTab.ID_PROYECTO(n) := itbLDC_CHEQUES_PROYECTO(n).ID_PROYECTO;
			rcRecOfTab.NUMERO_CHEQUE(n) := itbLDC_CHEQUES_PROYECTO(n).NUMERO_CHEQUE;
			rcRecOfTab.ENTIDAD(n) := itbLDC_CHEQUES_PROYECTO(n).ENTIDAD;
			rcRecOfTab.ESTADO(n) := itbLDC_CHEQUES_PROYECTO(n).ESTADO;
			rcRecOfTab.FECHA_CHEQUE(n) := itbLDC_CHEQUES_PROYECTO(n).FECHA_CHEQUE;
			rcRecOfTab.FECHA_ALARMA(n) := itbLDC_CHEQUES_PROYECTO(n).FECHA_ALARMA;
			rcRecOfTab.VALOR(n) := itbLDC_CHEQUES_PROYECTO(n).VALOR;
			rcRecOfTab.NUEVO_CHEQUE(n) := itbLDC_CHEQUES_PROYECTO(n).NUEVO_CHEQUE;
			rcRecOfTab.CUPON(n) := itbLDC_CHEQUES_PROYECTO(n).CUPON;
			rcRecOfTab.USUA_REGISTRA(n) := itbLDC_CHEQUES_PROYECTO(n).USUA_REGISTRA;
			rcRecOfTab.FECHA_REGISTRO(n) := itbLDC_CHEQUES_PROYECTO(n).FECHA_REGISTRO;
			rcRecOfTab.CUENTA(n) := itbLDC_CHEQUES_PROYECTO(n).CUENTA;
			rcRecOfTab.row_id(n) := itbLDC_CHEQUES_PROYECTO(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuCONSECUTIVO in LDC_CHEQUES_PROYECTO.CONSECUTIVO%type
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
		inuCONSECUTIVO in LDC_CHEQUES_PROYECTO.CONSECUTIVO%type
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
		inuCONSECUTIVO in LDC_CHEQUES_PROYECTO.CONSECUTIVO%type
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
		inuCONSECUTIVO in LDC_CHEQUES_PROYECTO.CONSECUTIVO%type
	)
	IS
		rcError styLDC_CHEQUES_PROYECTO;
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
		inuCONSECUTIVO in LDC_CHEQUES_PROYECTO.CONSECUTIVO%type
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
		inuCONSECUTIVO in LDC_CHEQUES_PROYECTO.CONSECUTIVO%type,
		orcRecord out nocopy styLDC_CHEQUES_PROYECTO
	)
	IS
		rcError styLDC_CHEQUES_PROYECTO;
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
		inuCONSECUTIVO in LDC_CHEQUES_PROYECTO.CONSECUTIVO%type
	)
	RETURN styLDC_CHEQUES_PROYECTO
	IS
		rcError styLDC_CHEQUES_PROYECTO;
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
		inuCONSECUTIVO in LDC_CHEQUES_PROYECTO.CONSECUTIVO%type
	)
	RETURN styLDC_CHEQUES_PROYECTO
	IS
		rcError styLDC_CHEQUES_PROYECTO;
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
	RETURN styLDC_CHEQUES_PROYECTO
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_CHEQUES_PROYECTO
	)
	IS
		rfLDC_CHEQUES_PROYECTO tyrfLDC_CHEQUES_PROYECTO;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_CHEQUES_PROYECTO.*, LDC_CHEQUES_PROYECTO.rowid FROM LDC_CHEQUES_PROYECTO';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_CHEQUES_PROYECTO for sbFullQuery;

		fetch rfLDC_CHEQUES_PROYECTO bulk collect INTO otbResult;

		close rfLDC_CHEQUES_PROYECTO;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_CHEQUES_PROYECTO.*, LDC_CHEQUES_PROYECTO.rowid FROM LDC_CHEQUES_PROYECTO';
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
		ircLDC_CHEQUES_PROYECTO in styLDC_CHEQUES_PROYECTO
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_CHEQUES_PROYECTO,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_CHEQUES_PROYECTO in styLDC_CHEQUES_PROYECTO,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_CHEQUES_PROYECTO.CONSECUTIVO is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|CONSECUTIVO');
			raise ex.controlled_error;
		end if;

		insert into LDC_CHEQUES_PROYECTO
		(
			CONSECUTIVO,
			ID_PROYECTO,
			NUMERO_CHEQUE,
			ENTIDAD,
			ESTADO,
			FECHA_CHEQUE,
			FECHA_ALARMA,
			VALOR,
			NUEVO_CHEQUE,
			CUPON,
			USUA_REGISTRA,
			FECHA_REGISTRO,
			CUENTA
		)
		values
		(
			ircLDC_CHEQUES_PROYECTO.CONSECUTIVO,
			ircLDC_CHEQUES_PROYECTO.ID_PROYECTO,
			ircLDC_CHEQUES_PROYECTO.NUMERO_CHEQUE,
			ircLDC_CHEQUES_PROYECTO.ENTIDAD,
			ircLDC_CHEQUES_PROYECTO.ESTADO,
			ircLDC_CHEQUES_PROYECTO.FECHA_CHEQUE,
			ircLDC_CHEQUES_PROYECTO.FECHA_ALARMA,
			ircLDC_CHEQUES_PROYECTO.VALOR,
			ircLDC_CHEQUES_PROYECTO.NUEVO_CHEQUE,
			ircLDC_CHEQUES_PROYECTO.CUPON,
			ircLDC_CHEQUES_PROYECTO.USUA_REGISTRA,
			ircLDC_CHEQUES_PROYECTO.FECHA_REGISTRO,
			ircLDC_CHEQUES_PROYECTO.CUENTA
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_CHEQUES_PROYECTO));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_CHEQUES_PROYECTO in out nocopy tytbLDC_CHEQUES_PROYECTO
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_CHEQUES_PROYECTO,blUseRowID);
		forall n in iotbLDC_CHEQUES_PROYECTO.first..iotbLDC_CHEQUES_PROYECTO.last
			insert into LDC_CHEQUES_PROYECTO
			(
				CONSECUTIVO,
				ID_PROYECTO,
				NUMERO_CHEQUE,
				ENTIDAD,
				ESTADO,
				FECHA_CHEQUE,
				FECHA_ALARMA,
				VALOR,
				NUEVO_CHEQUE,
				CUPON,
				USUA_REGISTRA,
				FECHA_REGISTRO,
				CUENTA
			)
			values
			(
				rcRecOfTab.CONSECUTIVO(n),
				rcRecOfTab.ID_PROYECTO(n),
				rcRecOfTab.NUMERO_CHEQUE(n),
				rcRecOfTab.ENTIDAD(n),
				rcRecOfTab.ESTADO(n),
				rcRecOfTab.FECHA_CHEQUE(n),
				rcRecOfTab.FECHA_ALARMA(n),
				rcRecOfTab.VALOR(n),
				rcRecOfTab.NUEVO_CHEQUE(n),
				rcRecOfTab.CUPON(n),
				rcRecOfTab.USUA_REGISTRA(n),
				rcRecOfTab.FECHA_REGISTRO(n),
				rcRecOfTab.CUENTA(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuCONSECUTIVO in LDC_CHEQUES_PROYECTO.CONSECUTIVO%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_CHEQUES_PROYECTO;
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
		from LDC_CHEQUES_PROYECTO
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
		rcError  styLDC_CHEQUES_PROYECTO;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_CHEQUES_PROYECTO
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
		iotbLDC_CHEQUES_PROYECTO in out nocopy tytbLDC_CHEQUES_PROYECTO,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_CHEQUES_PROYECTO;
	BEGIN
		FillRecordOfTables(iotbLDC_CHEQUES_PROYECTO, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_CHEQUES_PROYECTO.first .. iotbLDC_CHEQUES_PROYECTO.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CHEQUES_PROYECTO.first .. iotbLDC_CHEQUES_PROYECTO.last
				delete
				from LDC_CHEQUES_PROYECTO
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_CHEQUES_PROYECTO.first .. iotbLDC_CHEQUES_PROYECTO.last loop
					LockByPk
					(
						rcRecOfTab.CONSECUTIVO(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CHEQUES_PROYECTO.first .. iotbLDC_CHEQUES_PROYECTO.last
				delete
				from LDC_CHEQUES_PROYECTO
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
		ircLDC_CHEQUES_PROYECTO in styLDC_CHEQUES_PROYECTO,
		inuLock in number default 0
	)
	IS
		nuCONSECUTIVO	LDC_CHEQUES_PROYECTO.CONSECUTIVO%type;
	BEGIN
		if ircLDC_CHEQUES_PROYECTO.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_CHEQUES_PROYECTO.rowid,rcData);
			end if;
			update LDC_CHEQUES_PROYECTO
			set
				ID_PROYECTO = ircLDC_CHEQUES_PROYECTO.ID_PROYECTO,
				NUMERO_CHEQUE = ircLDC_CHEQUES_PROYECTO.NUMERO_CHEQUE,
				ENTIDAD = ircLDC_CHEQUES_PROYECTO.ENTIDAD,
				ESTADO = ircLDC_CHEQUES_PROYECTO.ESTADO,
				FECHA_CHEQUE = ircLDC_CHEQUES_PROYECTO.FECHA_CHEQUE,
				FECHA_ALARMA = ircLDC_CHEQUES_PROYECTO.FECHA_ALARMA,
				VALOR = ircLDC_CHEQUES_PROYECTO.VALOR,
				NUEVO_CHEQUE = ircLDC_CHEQUES_PROYECTO.NUEVO_CHEQUE,
				CUPON = ircLDC_CHEQUES_PROYECTO.CUPON,
				USUA_REGISTRA = ircLDC_CHEQUES_PROYECTO.USUA_REGISTRA,
				FECHA_REGISTRO = ircLDC_CHEQUES_PROYECTO.FECHA_REGISTRO,
				CUENTA = ircLDC_CHEQUES_PROYECTO.CUENTA
			where
				rowid = ircLDC_CHEQUES_PROYECTO.rowid
			returning
				CONSECUTIVO
			into
				nuCONSECUTIVO;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_CHEQUES_PROYECTO.CONSECUTIVO,
					rcData
				);
			end if;

			update LDC_CHEQUES_PROYECTO
			set
				ID_PROYECTO = ircLDC_CHEQUES_PROYECTO.ID_PROYECTO,
				NUMERO_CHEQUE = ircLDC_CHEQUES_PROYECTO.NUMERO_CHEQUE,
				ENTIDAD = ircLDC_CHEQUES_PROYECTO.ENTIDAD,
				ESTADO = ircLDC_CHEQUES_PROYECTO.ESTADO,
				FECHA_CHEQUE = ircLDC_CHEQUES_PROYECTO.FECHA_CHEQUE,
				FECHA_ALARMA = ircLDC_CHEQUES_PROYECTO.FECHA_ALARMA,
				VALOR = ircLDC_CHEQUES_PROYECTO.VALOR,
				NUEVO_CHEQUE = ircLDC_CHEQUES_PROYECTO.NUEVO_CHEQUE,
				CUPON = ircLDC_CHEQUES_PROYECTO.CUPON,
				USUA_REGISTRA = ircLDC_CHEQUES_PROYECTO.USUA_REGISTRA,
				FECHA_REGISTRO = ircLDC_CHEQUES_PROYECTO.FECHA_REGISTRO,
				CUENTA = ircLDC_CHEQUES_PROYECTO.CUENTA
			where
				CONSECUTIVO = ircLDC_CHEQUES_PROYECTO.CONSECUTIVO
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
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_CHEQUES_PROYECTO));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_CHEQUES_PROYECTO in out nocopy tytbLDC_CHEQUES_PROYECTO,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_CHEQUES_PROYECTO;
	BEGIN
		FillRecordOfTables(iotbLDC_CHEQUES_PROYECTO,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_CHEQUES_PROYECTO.first .. iotbLDC_CHEQUES_PROYECTO.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CHEQUES_PROYECTO.first .. iotbLDC_CHEQUES_PROYECTO.last
				update LDC_CHEQUES_PROYECTO
				set
					ID_PROYECTO = rcRecOfTab.ID_PROYECTO(n),
					NUMERO_CHEQUE = rcRecOfTab.NUMERO_CHEQUE(n),
					ENTIDAD = rcRecOfTab.ENTIDAD(n),
					ESTADO = rcRecOfTab.ESTADO(n),
					FECHA_CHEQUE = rcRecOfTab.FECHA_CHEQUE(n),
					FECHA_ALARMA = rcRecOfTab.FECHA_ALARMA(n),
					VALOR = rcRecOfTab.VALOR(n),
					NUEVO_CHEQUE = rcRecOfTab.NUEVO_CHEQUE(n),
					CUPON = rcRecOfTab.CUPON(n),
					USUA_REGISTRA = rcRecOfTab.USUA_REGISTRA(n),
					FECHA_REGISTRO = rcRecOfTab.FECHA_REGISTRO(n),
					CUENTA = rcRecOfTab.CUENTA(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_CHEQUES_PROYECTO.first .. iotbLDC_CHEQUES_PROYECTO.last loop
					LockByPk
					(
						rcRecOfTab.CONSECUTIVO(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CHEQUES_PROYECTO.first .. iotbLDC_CHEQUES_PROYECTO.last
				update LDC_CHEQUES_PROYECTO
				SET
					ID_PROYECTO = rcRecOfTab.ID_PROYECTO(n),
					NUMERO_CHEQUE = rcRecOfTab.NUMERO_CHEQUE(n),
					ENTIDAD = rcRecOfTab.ENTIDAD(n),
					ESTADO = rcRecOfTab.ESTADO(n),
					FECHA_CHEQUE = rcRecOfTab.FECHA_CHEQUE(n),
					FECHA_ALARMA = rcRecOfTab.FECHA_ALARMA(n),
					VALOR = rcRecOfTab.VALOR(n),
					NUEVO_CHEQUE = rcRecOfTab.NUEVO_CHEQUE(n),
					CUPON = rcRecOfTab.CUPON(n),
					USUA_REGISTRA = rcRecOfTab.USUA_REGISTRA(n),
					FECHA_REGISTRO = rcRecOfTab.FECHA_REGISTRO(n),
					CUENTA = rcRecOfTab.CUENTA(n)
				where
					CONSECUTIVO = rcRecOfTab.CONSECUTIVO(n)
;
		end if;
	END;
	PROCEDURE updID_PROYECTO
	(
		inuCONSECUTIVO in LDC_CHEQUES_PROYECTO.CONSECUTIVO%type,
		inuID_PROYECTO$ in LDC_CHEQUES_PROYECTO.ID_PROYECTO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CHEQUES_PROYECTO;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_CHEQUES_PROYECTO
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
	PROCEDURE updNUMERO_CHEQUE
	(
		inuCONSECUTIVO in LDC_CHEQUES_PROYECTO.CONSECUTIVO%type,
		isbNUMERO_CHEQUE$ in LDC_CHEQUES_PROYECTO.NUMERO_CHEQUE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CHEQUES_PROYECTO;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_CHEQUES_PROYECTO
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
	PROCEDURE updENTIDAD
	(
		inuCONSECUTIVO in LDC_CHEQUES_PROYECTO.CONSECUTIVO%type,
		inuENTIDAD$ in LDC_CHEQUES_PROYECTO.ENTIDAD%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CHEQUES_PROYECTO;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_CHEQUES_PROYECTO
		set
			ENTIDAD = inuENTIDAD$
		where
			CONSECUTIVO = inuCONSECUTIVO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ENTIDAD:= inuENTIDAD$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updESTADO
	(
		inuCONSECUTIVO in LDC_CHEQUES_PROYECTO.CONSECUTIVO%type,
		isbESTADO$ in LDC_CHEQUES_PROYECTO.ESTADO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CHEQUES_PROYECTO;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_CHEQUES_PROYECTO
		set
			ESTADO = isbESTADO$
		where
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
	PROCEDURE updFECHA_CHEQUE
	(
		inuCONSECUTIVO in LDC_CHEQUES_PROYECTO.CONSECUTIVO%type,
		idtFECHA_CHEQUE$ in LDC_CHEQUES_PROYECTO.FECHA_CHEQUE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CHEQUES_PROYECTO;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_CHEQUES_PROYECTO
		set
			FECHA_CHEQUE = idtFECHA_CHEQUE$
		where
			CONSECUTIVO = inuCONSECUTIVO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FECHA_CHEQUE:= idtFECHA_CHEQUE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFECHA_ALARMA
	(
		inuCONSECUTIVO in LDC_CHEQUES_PROYECTO.CONSECUTIVO%type,
		idtFECHA_ALARMA$ in LDC_CHEQUES_PROYECTO.FECHA_ALARMA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CHEQUES_PROYECTO;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_CHEQUES_PROYECTO
		set
			FECHA_ALARMA = idtFECHA_ALARMA$
		where
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
	PROCEDURE updVALOR
	(
		inuCONSECUTIVO in LDC_CHEQUES_PROYECTO.CONSECUTIVO%type,
		inuVALOR$ in LDC_CHEQUES_PROYECTO.VALOR%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CHEQUES_PROYECTO;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_CHEQUES_PROYECTO
		set
			VALOR = inuVALOR$
		where
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
	PROCEDURE updNUEVO_CHEQUE
	(
		inuCONSECUTIVO in LDC_CHEQUES_PROYECTO.CONSECUTIVO%type,
		isbNUEVO_CHEQUE$ in LDC_CHEQUES_PROYECTO.NUEVO_CHEQUE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CHEQUES_PROYECTO;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_CHEQUES_PROYECTO
		set
			NUEVO_CHEQUE = isbNUEVO_CHEQUE$
		where
			CONSECUTIVO = inuCONSECUTIVO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.NUEVO_CHEQUE:= isbNUEVO_CHEQUE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCUPON
	(
		inuCONSECUTIVO in LDC_CHEQUES_PROYECTO.CONSECUTIVO%type,
		inuCUPON$ in LDC_CHEQUES_PROYECTO.CUPON%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CHEQUES_PROYECTO;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_CHEQUES_PROYECTO
		set
			CUPON = inuCUPON$
		where
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
	PROCEDURE updUSUA_REGISTRA
	(
		inuCONSECUTIVO in LDC_CHEQUES_PROYECTO.CONSECUTIVO%type,
		isbUSUA_REGISTRA$ in LDC_CHEQUES_PROYECTO.USUA_REGISTRA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CHEQUES_PROYECTO;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_CHEQUES_PROYECTO
		set
			USUA_REGISTRA = isbUSUA_REGISTRA$
		where
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
	PROCEDURE updFECHA_REGISTRO
	(
		inuCONSECUTIVO in LDC_CHEQUES_PROYECTO.CONSECUTIVO%type,
		idtFECHA_REGISTRO$ in LDC_CHEQUES_PROYECTO.FECHA_REGISTRO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CHEQUES_PROYECTO;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_CHEQUES_PROYECTO
		set
			FECHA_REGISTRO = idtFECHA_REGISTRO$
		where
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
	PROCEDURE updCUENTA
	(
		inuCONSECUTIVO in LDC_CHEQUES_PROYECTO.CONSECUTIVO%type,
		isbCUENTA$ in LDC_CHEQUES_PROYECTO.CUENTA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CHEQUES_PROYECTO;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_CHEQUES_PROYECTO
		set
			CUENTA = isbCUENTA$
		where
			CONSECUTIVO = inuCONSECUTIVO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CUENTA:= isbCUENTA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetCONSECUTIVO
	(
		inuCONSECUTIVO in LDC_CHEQUES_PROYECTO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CHEQUES_PROYECTO.CONSECUTIVO%type
	IS
		rcError styLDC_CHEQUES_PROYECTO;
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
	FUNCTION fnuGetID_PROYECTO
	(
		inuCONSECUTIVO in LDC_CHEQUES_PROYECTO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CHEQUES_PROYECTO.ID_PROYECTO%type
	IS
		rcError styLDC_CHEQUES_PROYECTO;
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
	FUNCTION fsbGetNUMERO_CHEQUE
	(
		inuCONSECUTIVO in LDC_CHEQUES_PROYECTO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CHEQUES_PROYECTO.NUMERO_CHEQUE%type
	IS
		rcError styLDC_CHEQUES_PROYECTO;
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
	FUNCTION fnuGetENTIDAD
	(
		inuCONSECUTIVO in LDC_CHEQUES_PROYECTO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CHEQUES_PROYECTO.ENTIDAD%type
	IS
		rcError styLDC_CHEQUES_PROYECTO;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.ENTIDAD);
		end if;
		Load
		(
		 		inuCONSECUTIVO
		);
		return(rcData.ENTIDAD);
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
		inuCONSECUTIVO in LDC_CHEQUES_PROYECTO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CHEQUES_PROYECTO.ESTADO%type
	IS
		rcError styLDC_CHEQUES_PROYECTO;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.ESTADO);
		end if;
		Load
		(
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
	FUNCTION fdtGetFECHA_CHEQUE
	(
		inuCONSECUTIVO in LDC_CHEQUES_PROYECTO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CHEQUES_PROYECTO.FECHA_CHEQUE%type
	IS
		rcError styLDC_CHEQUES_PROYECTO;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.FECHA_CHEQUE);
		end if;
		Load
		(
		 		inuCONSECUTIVO
		);
		return(rcData.FECHA_CHEQUE);
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
		inuCONSECUTIVO in LDC_CHEQUES_PROYECTO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CHEQUES_PROYECTO.FECHA_ALARMA%type
	IS
		rcError styLDC_CHEQUES_PROYECTO;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.FECHA_ALARMA);
		end if;
		Load
		(
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
	FUNCTION fnuGetVALOR
	(
		inuCONSECUTIVO in LDC_CHEQUES_PROYECTO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CHEQUES_PROYECTO.VALOR%type
	IS
		rcError styLDC_CHEQUES_PROYECTO;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.VALOR);
		end if;
		Load
		(
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
	FUNCTION fsbGetNUEVO_CHEQUE
	(
		inuCONSECUTIVO in LDC_CHEQUES_PROYECTO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CHEQUES_PROYECTO.NUEVO_CHEQUE%type
	IS
		rcError styLDC_CHEQUES_PROYECTO;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.NUEVO_CHEQUE);
		end if;
		Load
		(
		 		inuCONSECUTIVO
		);
		return(rcData.NUEVO_CHEQUE);
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
		inuCONSECUTIVO in LDC_CHEQUES_PROYECTO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CHEQUES_PROYECTO.CUPON%type
	IS
		rcError styLDC_CHEQUES_PROYECTO;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.CUPON);
		end if;
		Load
		(
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
	FUNCTION fsbGetUSUA_REGISTRA
	(
		inuCONSECUTIVO in LDC_CHEQUES_PROYECTO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CHEQUES_PROYECTO.USUA_REGISTRA%type
	IS
		rcError styLDC_CHEQUES_PROYECTO;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.USUA_REGISTRA);
		end if;
		Load
		(
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
	FUNCTION fdtGetFECHA_REGISTRO
	(
		inuCONSECUTIVO in LDC_CHEQUES_PROYECTO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CHEQUES_PROYECTO.FECHA_REGISTRO%type
	IS
		rcError styLDC_CHEQUES_PROYECTO;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.FECHA_REGISTRO);
		end if;
		Load
		(
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
	FUNCTION fsbGetCUENTA
	(
		inuCONSECUTIVO in LDC_CHEQUES_PROYECTO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CHEQUES_PROYECTO.CUENTA%type
	IS
		rcError styLDC_CHEQUES_PROYECTO;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.CUENTA);
		end if;
		Load
		(
		 		inuCONSECUTIVO
		);
		return(rcData.CUENTA);
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
end DALDC_CHEQUES_PROYECTO;
/
PROMPT Otorgando permisos de ejecucion a DALDC_CHEQUES_PROYECTO
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_CHEQUES_PROYECTO', 'ADM_PERSON');
END;
/