CREATE OR REPLACE PACKAGE ADM_PERSON.DALDC_ITEMS_COTIZACION_COM
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
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type
	)
	IS
		SELECT LDC_ITEMS_COTIZACION_COM.*,LDC_ITEMS_COTIZACION_COM.rowid
		FROM LDC_ITEMS_COTIZACION_COM
		WHERE
		    CONSECUTIVO = inuCONSECUTIVO;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_ITEMS_COTIZACION_COM.*,LDC_ITEMS_COTIZACION_COM.rowid
		FROM LDC_ITEMS_COTIZACION_COM
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_ITEMS_COTIZACION_COM  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_ITEMS_COTIZACION_COM is table of styLDC_ITEMS_COTIZACION_COM index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_ITEMS_COTIZACION_COM;

	/* Tipos referenciando al registro */
	type tytbCONSECUTIVO is table of LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type index by binary_integer;
	type tytbID_COT_COMERCIAL is table of LDC_ITEMS_COTIZACION_COM.ID_COT_COMERCIAL%type index by binary_integer;
	type tytbTIPO_TRABAJO is table of LDC_ITEMS_COTIZACION_COM.TIPO_TRABAJO%type index by binary_integer;
	type tytbACTIVIDAD is table of LDC_ITEMS_COTIZACION_COM.ACTIVIDAD%type index by binary_integer;
	type tytbID_LISTA is table of LDC_ITEMS_COTIZACION_COM.ID_LISTA%type index by binary_integer;
	type tytbID_ITEM is table of LDC_ITEMS_COTIZACION_COM.ID_ITEM%type index by binary_integer;
	type tytbCOSTO_VENTA is table of LDC_ITEMS_COTIZACION_COM.COSTO_VENTA%type index by binary_integer;
	type tytbAIU is table of LDC_ITEMS_COTIZACION_COM.AIU%type index by binary_integer;
	type tytbCANTIDAD is table of LDC_ITEMS_COTIZACION_COM.CANTIDAD%type index by binary_integer;
	type tytbDESCUENTO is table of LDC_ITEMS_COTIZACION_COM.DESCUENTO%type index by binary_integer;
	type tytbPRECIO_TOTAL is table of LDC_ITEMS_COTIZACION_COM.PRECIO_TOTAL%type index by binary_integer;
	type tytbIVA is table of LDC_ITEMS_COTIZACION_COM.IVA%type index by binary_integer;
	type tytbFECHA_REGISTRO is table of LDC_ITEMS_COTIZACION_COM.FECHA_REGISTRO%type index by binary_integer;
	type tytbUSUARIO_REGISTRA is table of LDC_ITEMS_COTIZACION_COM.USUARIO_REGISTRA%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_ITEMS_COTIZACION_COM is record
	(
		CONSECUTIVO   tytbCONSECUTIVO,
		ID_COT_COMERCIAL   tytbID_COT_COMERCIAL,
		TIPO_TRABAJO   tytbTIPO_TRABAJO,
		ACTIVIDAD   tytbACTIVIDAD,
		ID_LISTA   tytbID_LISTA,
		ID_ITEM   tytbID_ITEM,
		COSTO_VENTA   tytbCOSTO_VENTA,
		AIU   tytbAIU,
		CANTIDAD   tytbCANTIDAD,
		DESCUENTO   tytbDESCUENTO,
		PRECIO_TOTAL   tytbPRECIO_TOTAL,
		IVA   tytbIVA,
		FECHA_REGISTRO   tytbFECHA_REGISTRO,
		USUARIO_REGISTRA   tytbUSUARIO_REGISTRA,
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
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type
	);

	PROCEDURE getRecord
	(
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type,
		orcRecord out nocopy styLDC_ITEMS_COTIZACION_COM
	);

	FUNCTION frcGetRcData
	(
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type
	)
	RETURN styLDC_ITEMS_COTIZACION_COM;

	FUNCTION frcGetRcData
	RETURN styLDC_ITEMS_COTIZACION_COM;

	FUNCTION frcGetRecord
	(
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type
	)
	RETURN styLDC_ITEMS_COTIZACION_COM;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_ITEMS_COTIZACION_COM
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_ITEMS_COTIZACION_COM in styLDC_ITEMS_COTIZACION_COM
	);

	PROCEDURE insRecord
	(
		ircLDC_ITEMS_COTIZACION_COM in styLDC_ITEMS_COTIZACION_COM,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_ITEMS_COTIZACION_COM in out nocopy tytbLDC_ITEMS_COTIZACION_COM
	);

	PROCEDURE delRecord
	(
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_ITEMS_COTIZACION_COM in out nocopy tytbLDC_ITEMS_COTIZACION_COM,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_ITEMS_COTIZACION_COM in styLDC_ITEMS_COTIZACION_COM,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_ITEMS_COTIZACION_COM in out nocopy tytbLDC_ITEMS_COTIZACION_COM,
		inuLock in number default 1
	);

	PROCEDURE updID_COT_COMERCIAL
	(
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type,
		inuID_COT_COMERCIAL$ in LDC_ITEMS_COTIZACION_COM.ID_COT_COMERCIAL%type,
		inuLock in number default 0
	);

	PROCEDURE updTIPO_TRABAJO
	(
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type,
		inuTIPO_TRABAJO$ in LDC_ITEMS_COTIZACION_COM.TIPO_TRABAJO%type,
		inuLock in number default 0
	);

	PROCEDURE updACTIVIDAD
	(
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type,
		inuACTIVIDAD$ in LDC_ITEMS_COTIZACION_COM.ACTIVIDAD%type,
		inuLock in number default 0
	);

	PROCEDURE updID_LISTA
	(
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type,
		inuID_LISTA$ in LDC_ITEMS_COTIZACION_COM.ID_LISTA%type,
		inuLock in number default 0
	);

	PROCEDURE updID_ITEM
	(
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type,
		inuID_ITEM$ in LDC_ITEMS_COTIZACION_COM.ID_ITEM%type,
		inuLock in number default 0
	);

	PROCEDURE updCOSTO_VENTA
	(
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type,
		inuCOSTO_VENTA$ in LDC_ITEMS_COTIZACION_COM.COSTO_VENTA%type,
		inuLock in number default 0
	);

	PROCEDURE updAIU
	(
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type,
		inuAIU$ in LDC_ITEMS_COTIZACION_COM.AIU%type,
		inuLock in number default 0
	);

	PROCEDURE updCANTIDAD
	(
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type,
		inuCANTIDAD$ in LDC_ITEMS_COTIZACION_COM.CANTIDAD%type,
		inuLock in number default 0
	);

	PROCEDURE updDESCUENTO
	(
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type,
		inuDESCUENTO$ in LDC_ITEMS_COTIZACION_COM.DESCUENTO%type,
		inuLock in number default 0
	);

	PROCEDURE updPRECIO_TOTAL
	(
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type,
		inuPRECIO_TOTAL$ in LDC_ITEMS_COTIZACION_COM.PRECIO_TOTAL%type,
		inuLock in number default 0
	);

	PROCEDURE updIVA
	(
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type,
		inuIVA$ in LDC_ITEMS_COTIZACION_COM.IVA%type,
		inuLock in number default 0
	);

	PROCEDURE updFECHA_REGISTRO
	(
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type,
		idtFECHA_REGISTRO$ in LDC_ITEMS_COTIZACION_COM.FECHA_REGISTRO%type,
		inuLock in number default 0
	);

	PROCEDURE updUSUARIO_REGISTRA
	(
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type,
		isbUSUARIO_REGISTRA$ in LDC_ITEMS_COTIZACION_COM.USUARIO_REGISTRA%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetCONSECUTIVO
	(
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type;

	FUNCTION fnuGetID_COT_COMERCIAL
	(
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_COTIZACION_COM.ID_COT_COMERCIAL%type;

	FUNCTION fnuGetTIPO_TRABAJO
	(
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_COTIZACION_COM.TIPO_TRABAJO%type;

	FUNCTION fnuGetACTIVIDAD
	(
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_COTIZACION_COM.ACTIVIDAD%type;

	FUNCTION fnuGetID_LISTA
	(
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_COTIZACION_COM.ID_LISTA%type;

	FUNCTION fnuGetID_ITEM
	(
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_COTIZACION_COM.ID_ITEM%type;

	FUNCTION fnuGetCOSTO_VENTA
	(
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_COTIZACION_COM.COSTO_VENTA%type;

	FUNCTION fnuGetAIU
	(
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_COTIZACION_COM.AIU%type;

	FUNCTION fnuGetCANTIDAD
	(
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_COTIZACION_COM.CANTIDAD%type;

	FUNCTION fnuGetDESCUENTO
	(
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_COTIZACION_COM.DESCUENTO%type;

	FUNCTION fnuGetPRECIO_TOTAL
	(
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_COTIZACION_COM.PRECIO_TOTAL%type;

	FUNCTION fnuGetIVA
	(
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_COTIZACION_COM.IVA%type;

	FUNCTION fdtGetFECHA_REGISTRO
	(
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_COTIZACION_COM.FECHA_REGISTRO%type;

	FUNCTION fsbGetUSUARIO_REGISTRA
	(
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_COTIZACION_COM.USUARIO_REGISTRA%type;


	PROCEDURE LockByPk
	(
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type,
		orcLDC_ITEMS_COTIZACION_COM  out styLDC_ITEMS_COTIZACION_COM
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_ITEMS_COTIZACION_COM  out styLDC_ITEMS_COTIZACION_COM
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_ITEMS_COTIZACION_COM;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALDC_ITEMS_COTIZACION_COM
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_ITEMS_COTIZACION_COM';
	 cnuGeEntityId constant varchar2(30) := 3856; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type
	)
	IS
		SELECT LDC_ITEMS_COTIZACION_COM.*,LDC_ITEMS_COTIZACION_COM.rowid
		FROM LDC_ITEMS_COTIZACION_COM
		WHERE  CONSECUTIVO = inuCONSECUTIVO
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_ITEMS_COTIZACION_COM.*,LDC_ITEMS_COTIZACION_COM.rowid
		FROM LDC_ITEMS_COTIZACION_COM
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_ITEMS_COTIZACION_COM is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_ITEMS_COTIZACION_COM;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_ITEMS_COTIZACION_COM default rcData )
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
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type,
		orcLDC_ITEMS_COTIZACION_COM  out styLDC_ITEMS_COTIZACION_COM
	)
	IS
		rcError styLDC_ITEMS_COTIZACION_COM;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;

		Open cuLockRcByPk
		(
			inuCONSECUTIVO
		);

		fetch cuLockRcByPk into orcLDC_ITEMS_COTIZACION_COM;
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
		orcLDC_ITEMS_COTIZACION_COM  out styLDC_ITEMS_COTIZACION_COM
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_ITEMS_COTIZACION_COM;
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
		itbLDC_ITEMS_COTIZACION_COM  in out nocopy tytbLDC_ITEMS_COTIZACION_COM
	)
	IS
	BEGIN
			rcRecOfTab.CONSECUTIVO.delete;
			rcRecOfTab.ID_COT_COMERCIAL.delete;
			rcRecOfTab.TIPO_TRABAJO.delete;
			rcRecOfTab.ACTIVIDAD.delete;
			rcRecOfTab.ID_LISTA.delete;
			rcRecOfTab.ID_ITEM.delete;
			rcRecOfTab.COSTO_VENTA.delete;
			rcRecOfTab.AIU.delete;
			rcRecOfTab.CANTIDAD.delete;
			rcRecOfTab.DESCUENTO.delete;
			rcRecOfTab.PRECIO_TOTAL.delete;
			rcRecOfTab.IVA.delete;
			rcRecOfTab.FECHA_REGISTRO.delete;
			rcRecOfTab.USUARIO_REGISTRA.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_ITEMS_COTIZACION_COM  in out nocopy tytbLDC_ITEMS_COTIZACION_COM,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_ITEMS_COTIZACION_COM);

		for n in itbLDC_ITEMS_COTIZACION_COM.first .. itbLDC_ITEMS_COTIZACION_COM.last loop
			rcRecOfTab.CONSECUTIVO(n) := itbLDC_ITEMS_COTIZACION_COM(n).CONSECUTIVO;
			rcRecOfTab.ID_COT_COMERCIAL(n) := itbLDC_ITEMS_COTIZACION_COM(n).ID_COT_COMERCIAL;
			rcRecOfTab.TIPO_TRABAJO(n) := itbLDC_ITEMS_COTIZACION_COM(n).TIPO_TRABAJO;
			rcRecOfTab.ACTIVIDAD(n) := itbLDC_ITEMS_COTIZACION_COM(n).ACTIVIDAD;
			rcRecOfTab.ID_LISTA(n) := itbLDC_ITEMS_COTIZACION_COM(n).ID_LISTA;
			rcRecOfTab.ID_ITEM(n) := itbLDC_ITEMS_COTIZACION_COM(n).ID_ITEM;
			rcRecOfTab.COSTO_VENTA(n) := itbLDC_ITEMS_COTIZACION_COM(n).COSTO_VENTA;
			rcRecOfTab.AIU(n) := itbLDC_ITEMS_COTIZACION_COM(n).AIU;
			rcRecOfTab.CANTIDAD(n) := itbLDC_ITEMS_COTIZACION_COM(n).CANTIDAD;
			rcRecOfTab.DESCUENTO(n) := itbLDC_ITEMS_COTIZACION_COM(n).DESCUENTO;
			rcRecOfTab.PRECIO_TOTAL(n) := itbLDC_ITEMS_COTIZACION_COM(n).PRECIO_TOTAL;
			rcRecOfTab.IVA(n) := itbLDC_ITEMS_COTIZACION_COM(n).IVA;
			rcRecOfTab.FECHA_REGISTRO(n) := itbLDC_ITEMS_COTIZACION_COM(n).FECHA_REGISTRO;
			rcRecOfTab.USUARIO_REGISTRA(n) := itbLDC_ITEMS_COTIZACION_COM(n).USUARIO_REGISTRA;
			rcRecOfTab.row_id(n) := itbLDC_ITEMS_COTIZACION_COM(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type
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
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type
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
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type
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
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type
	)
	IS
		rcError styLDC_ITEMS_COTIZACION_COM;
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
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type
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
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type,
		orcRecord out nocopy styLDC_ITEMS_COTIZACION_COM
	)
	IS
		rcError styLDC_ITEMS_COTIZACION_COM;
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
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type
	)
	RETURN styLDC_ITEMS_COTIZACION_COM
	IS
		rcError styLDC_ITEMS_COTIZACION_COM;
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
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type
	)
	RETURN styLDC_ITEMS_COTIZACION_COM
	IS
		rcError styLDC_ITEMS_COTIZACION_COM;
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
	RETURN styLDC_ITEMS_COTIZACION_COM
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_ITEMS_COTIZACION_COM
	)
	IS
		rfLDC_ITEMS_COTIZACION_COM tyrfLDC_ITEMS_COTIZACION_COM;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_ITEMS_COTIZACION_COM.*, LDC_ITEMS_COTIZACION_COM.rowid FROM LDC_ITEMS_COTIZACION_COM';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_ITEMS_COTIZACION_COM for sbFullQuery;

		fetch rfLDC_ITEMS_COTIZACION_COM bulk collect INTO otbResult;

		close rfLDC_ITEMS_COTIZACION_COM;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_ITEMS_COTIZACION_COM.*, LDC_ITEMS_COTIZACION_COM.rowid FROM LDC_ITEMS_COTIZACION_COM';
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
		ircLDC_ITEMS_COTIZACION_COM in styLDC_ITEMS_COTIZACION_COM
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_ITEMS_COTIZACION_COM,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_ITEMS_COTIZACION_COM in styLDC_ITEMS_COTIZACION_COM,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_ITEMS_COTIZACION_COM.CONSECUTIVO is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|CONSECUTIVO');
			raise ex.controlled_error;
		end if;

		insert into LDC_ITEMS_COTIZACION_COM
		(
			CONSECUTIVO,
			ID_COT_COMERCIAL,
			TIPO_TRABAJO,
			ACTIVIDAD,
			ID_LISTA,
			ID_ITEM,
			COSTO_VENTA,
			AIU,
			CANTIDAD,
			DESCUENTO,
			PRECIO_TOTAL,
			IVA,
			FECHA_REGISTRO,
			USUARIO_REGISTRA
		)
		values
		(
			ircLDC_ITEMS_COTIZACION_COM.CONSECUTIVO,
			ircLDC_ITEMS_COTIZACION_COM.ID_COT_COMERCIAL,
			ircLDC_ITEMS_COTIZACION_COM.TIPO_TRABAJO,
			ircLDC_ITEMS_COTIZACION_COM.ACTIVIDAD,
			ircLDC_ITEMS_COTIZACION_COM.ID_LISTA,
			ircLDC_ITEMS_COTIZACION_COM.ID_ITEM,
			ircLDC_ITEMS_COTIZACION_COM.COSTO_VENTA,
			ircLDC_ITEMS_COTIZACION_COM.AIU,
			ircLDC_ITEMS_COTIZACION_COM.CANTIDAD,
			ircLDC_ITEMS_COTIZACION_COM.DESCUENTO,
			ircLDC_ITEMS_COTIZACION_COM.PRECIO_TOTAL,
			ircLDC_ITEMS_COTIZACION_COM.IVA,
			ircLDC_ITEMS_COTIZACION_COM.FECHA_REGISTRO,
			ircLDC_ITEMS_COTIZACION_COM.USUARIO_REGISTRA
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_ITEMS_COTIZACION_COM));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_ITEMS_COTIZACION_COM in out nocopy tytbLDC_ITEMS_COTIZACION_COM
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_ITEMS_COTIZACION_COM,blUseRowID);
		forall n in iotbLDC_ITEMS_COTIZACION_COM.first..iotbLDC_ITEMS_COTIZACION_COM.last
			insert into LDC_ITEMS_COTIZACION_COM
			(
				CONSECUTIVO,
				ID_COT_COMERCIAL,
				TIPO_TRABAJO,
				ACTIVIDAD,
				ID_LISTA,
				ID_ITEM,
				COSTO_VENTA,
				AIU,
				CANTIDAD,
				DESCUENTO,
				PRECIO_TOTAL,
				IVA,
				FECHA_REGISTRO,
				USUARIO_REGISTRA
			)
			values
			(
				rcRecOfTab.CONSECUTIVO(n),
				rcRecOfTab.ID_COT_COMERCIAL(n),
				rcRecOfTab.TIPO_TRABAJO(n),
				rcRecOfTab.ACTIVIDAD(n),
				rcRecOfTab.ID_LISTA(n),
				rcRecOfTab.ID_ITEM(n),
				rcRecOfTab.COSTO_VENTA(n),
				rcRecOfTab.AIU(n),
				rcRecOfTab.CANTIDAD(n),
				rcRecOfTab.DESCUENTO(n),
				rcRecOfTab.PRECIO_TOTAL(n),
				rcRecOfTab.IVA(n),
				rcRecOfTab.FECHA_REGISTRO(n),
				rcRecOfTab.USUARIO_REGISTRA(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_ITEMS_COTIZACION_COM;
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
		from LDC_ITEMS_COTIZACION_COM
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
		rcError  styLDC_ITEMS_COTIZACION_COM;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_ITEMS_COTIZACION_COM
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
		iotbLDC_ITEMS_COTIZACION_COM in out nocopy tytbLDC_ITEMS_COTIZACION_COM,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_ITEMS_COTIZACION_COM;
	BEGIN
		FillRecordOfTables(iotbLDC_ITEMS_COTIZACION_COM, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_ITEMS_COTIZACION_COM.first .. iotbLDC_ITEMS_COTIZACION_COM.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ITEMS_COTIZACION_COM.first .. iotbLDC_ITEMS_COTIZACION_COM.last
				delete
				from LDC_ITEMS_COTIZACION_COM
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_ITEMS_COTIZACION_COM.first .. iotbLDC_ITEMS_COTIZACION_COM.last loop
					LockByPk
					(
						rcRecOfTab.CONSECUTIVO(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ITEMS_COTIZACION_COM.first .. iotbLDC_ITEMS_COTIZACION_COM.last
				delete
				from LDC_ITEMS_COTIZACION_COM
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
		ircLDC_ITEMS_COTIZACION_COM in styLDC_ITEMS_COTIZACION_COM,
		inuLock in number default 0
	)
	IS
		nuCONSECUTIVO	LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type;
	BEGIN
		if ircLDC_ITEMS_COTIZACION_COM.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_ITEMS_COTIZACION_COM.rowid,rcData);
			end if;
			update LDC_ITEMS_COTIZACION_COM
			set
				ID_COT_COMERCIAL = ircLDC_ITEMS_COTIZACION_COM.ID_COT_COMERCIAL,
				TIPO_TRABAJO = ircLDC_ITEMS_COTIZACION_COM.TIPO_TRABAJO,
				ACTIVIDAD = ircLDC_ITEMS_COTIZACION_COM.ACTIVIDAD,
				ID_LISTA = ircLDC_ITEMS_COTIZACION_COM.ID_LISTA,
				ID_ITEM = ircLDC_ITEMS_COTIZACION_COM.ID_ITEM,
				COSTO_VENTA = ircLDC_ITEMS_COTIZACION_COM.COSTO_VENTA,
				AIU = ircLDC_ITEMS_COTIZACION_COM.AIU,
				CANTIDAD = ircLDC_ITEMS_COTIZACION_COM.CANTIDAD,
				DESCUENTO = ircLDC_ITEMS_COTIZACION_COM.DESCUENTO,
				PRECIO_TOTAL = ircLDC_ITEMS_COTIZACION_COM.PRECIO_TOTAL,
				IVA = ircLDC_ITEMS_COTIZACION_COM.IVA,
				FECHA_REGISTRO = ircLDC_ITEMS_COTIZACION_COM.FECHA_REGISTRO,
				USUARIO_REGISTRA = ircLDC_ITEMS_COTIZACION_COM.USUARIO_REGISTRA
			where
				rowid = ircLDC_ITEMS_COTIZACION_COM.rowid
			returning
				CONSECUTIVO
			into
				nuCONSECUTIVO;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_ITEMS_COTIZACION_COM.CONSECUTIVO,
					rcData
				);
			end if;

			update LDC_ITEMS_COTIZACION_COM
			set
				ID_COT_COMERCIAL = ircLDC_ITEMS_COTIZACION_COM.ID_COT_COMERCIAL,
				TIPO_TRABAJO = ircLDC_ITEMS_COTIZACION_COM.TIPO_TRABAJO,
				ACTIVIDAD = ircLDC_ITEMS_COTIZACION_COM.ACTIVIDAD,
				ID_LISTA = ircLDC_ITEMS_COTIZACION_COM.ID_LISTA,
				ID_ITEM = ircLDC_ITEMS_COTIZACION_COM.ID_ITEM,
				COSTO_VENTA = ircLDC_ITEMS_COTIZACION_COM.COSTO_VENTA,
				AIU = ircLDC_ITEMS_COTIZACION_COM.AIU,
				CANTIDAD = ircLDC_ITEMS_COTIZACION_COM.CANTIDAD,
				DESCUENTO = ircLDC_ITEMS_COTIZACION_COM.DESCUENTO,
				PRECIO_TOTAL = ircLDC_ITEMS_COTIZACION_COM.PRECIO_TOTAL,
				IVA = ircLDC_ITEMS_COTIZACION_COM.IVA,
				FECHA_REGISTRO = ircLDC_ITEMS_COTIZACION_COM.FECHA_REGISTRO,
				USUARIO_REGISTRA = ircLDC_ITEMS_COTIZACION_COM.USUARIO_REGISTRA
			where
				CONSECUTIVO = ircLDC_ITEMS_COTIZACION_COM.CONSECUTIVO
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
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_ITEMS_COTIZACION_COM));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_ITEMS_COTIZACION_COM in out nocopy tytbLDC_ITEMS_COTIZACION_COM,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_ITEMS_COTIZACION_COM;
	BEGIN
		FillRecordOfTables(iotbLDC_ITEMS_COTIZACION_COM,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_ITEMS_COTIZACION_COM.first .. iotbLDC_ITEMS_COTIZACION_COM.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ITEMS_COTIZACION_COM.first .. iotbLDC_ITEMS_COTIZACION_COM.last
				update LDC_ITEMS_COTIZACION_COM
				set
					ID_COT_COMERCIAL = rcRecOfTab.ID_COT_COMERCIAL(n),
					TIPO_TRABAJO = rcRecOfTab.TIPO_TRABAJO(n),
					ACTIVIDAD = rcRecOfTab.ACTIVIDAD(n),
					ID_LISTA = rcRecOfTab.ID_LISTA(n),
					ID_ITEM = rcRecOfTab.ID_ITEM(n),
					COSTO_VENTA = rcRecOfTab.COSTO_VENTA(n),
					AIU = rcRecOfTab.AIU(n),
					CANTIDAD = rcRecOfTab.CANTIDAD(n),
					DESCUENTO = rcRecOfTab.DESCUENTO(n),
					PRECIO_TOTAL = rcRecOfTab.PRECIO_TOTAL(n),
					IVA = rcRecOfTab.IVA(n),
					FECHA_REGISTRO = rcRecOfTab.FECHA_REGISTRO(n),
					USUARIO_REGISTRA = rcRecOfTab.USUARIO_REGISTRA(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_ITEMS_COTIZACION_COM.first .. iotbLDC_ITEMS_COTIZACION_COM.last loop
					LockByPk
					(
						rcRecOfTab.CONSECUTIVO(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ITEMS_COTIZACION_COM.first .. iotbLDC_ITEMS_COTIZACION_COM.last
				update LDC_ITEMS_COTIZACION_COM
				SET
					ID_COT_COMERCIAL = rcRecOfTab.ID_COT_COMERCIAL(n),
					TIPO_TRABAJO = rcRecOfTab.TIPO_TRABAJO(n),
					ACTIVIDAD = rcRecOfTab.ACTIVIDAD(n),
					ID_LISTA = rcRecOfTab.ID_LISTA(n),
					ID_ITEM = rcRecOfTab.ID_ITEM(n),
					COSTO_VENTA = rcRecOfTab.COSTO_VENTA(n),
					AIU = rcRecOfTab.AIU(n),
					CANTIDAD = rcRecOfTab.CANTIDAD(n),
					DESCUENTO = rcRecOfTab.DESCUENTO(n),
					PRECIO_TOTAL = rcRecOfTab.PRECIO_TOTAL(n),
					IVA = rcRecOfTab.IVA(n),
					FECHA_REGISTRO = rcRecOfTab.FECHA_REGISTRO(n),
					USUARIO_REGISTRA = rcRecOfTab.USUARIO_REGISTRA(n)
				where
					CONSECUTIVO = rcRecOfTab.CONSECUTIVO(n)
;
		end if;
	END;
	PROCEDURE updID_COT_COMERCIAL
	(
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type,
		inuID_COT_COMERCIAL$ in LDC_ITEMS_COTIZACION_COM.ID_COT_COMERCIAL%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ITEMS_COTIZACION_COM;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_ITEMS_COTIZACION_COM
		set
			ID_COT_COMERCIAL = inuID_COT_COMERCIAL$
		where
			CONSECUTIVO = inuCONSECUTIVO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ID_COT_COMERCIAL:= inuID_COT_COMERCIAL$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updTIPO_TRABAJO
	(
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type,
		inuTIPO_TRABAJO$ in LDC_ITEMS_COTIZACION_COM.TIPO_TRABAJO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ITEMS_COTIZACION_COM;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_ITEMS_COTIZACION_COM
		set
			TIPO_TRABAJO = inuTIPO_TRABAJO$
		where
			CONSECUTIVO = inuCONSECUTIVO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TIPO_TRABAJO:= inuTIPO_TRABAJO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updACTIVIDAD
	(
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type,
		inuACTIVIDAD$ in LDC_ITEMS_COTIZACION_COM.ACTIVIDAD%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ITEMS_COTIZACION_COM;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_ITEMS_COTIZACION_COM
		set
			ACTIVIDAD = inuACTIVIDAD$
		where
			CONSECUTIVO = inuCONSECUTIVO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ACTIVIDAD:= inuACTIVIDAD$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updID_LISTA
	(
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type,
		inuID_LISTA$ in LDC_ITEMS_COTIZACION_COM.ID_LISTA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ITEMS_COTIZACION_COM;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_ITEMS_COTIZACION_COM
		set
			ID_LISTA = inuID_LISTA$
		where
			CONSECUTIVO = inuCONSECUTIVO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ID_LISTA:= inuID_LISTA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updID_ITEM
	(
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type,
		inuID_ITEM$ in LDC_ITEMS_COTIZACION_COM.ID_ITEM%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ITEMS_COTIZACION_COM;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_ITEMS_COTIZACION_COM
		set
			ID_ITEM = inuID_ITEM$
		where
			CONSECUTIVO = inuCONSECUTIVO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ID_ITEM:= inuID_ITEM$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCOSTO_VENTA
	(
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type,
		inuCOSTO_VENTA$ in LDC_ITEMS_COTIZACION_COM.COSTO_VENTA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ITEMS_COTIZACION_COM;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_ITEMS_COTIZACION_COM
		set
			COSTO_VENTA = inuCOSTO_VENTA$
		where
			CONSECUTIVO = inuCONSECUTIVO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.COSTO_VENTA:= inuCOSTO_VENTA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updAIU
	(
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type,
		inuAIU$ in LDC_ITEMS_COTIZACION_COM.AIU%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ITEMS_COTIZACION_COM;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_ITEMS_COTIZACION_COM
		set
			AIU = inuAIU$
		where
			CONSECUTIVO = inuCONSECUTIVO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.AIU:= inuAIU$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCANTIDAD
	(
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type,
		inuCANTIDAD$ in LDC_ITEMS_COTIZACION_COM.CANTIDAD%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ITEMS_COTIZACION_COM;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_ITEMS_COTIZACION_COM
		set
			CANTIDAD = inuCANTIDAD$
		where
			CONSECUTIVO = inuCONSECUTIVO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CANTIDAD:= inuCANTIDAD$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updDESCUENTO
	(
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type,
		inuDESCUENTO$ in LDC_ITEMS_COTIZACION_COM.DESCUENTO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ITEMS_COTIZACION_COM;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_ITEMS_COTIZACION_COM
		set
			DESCUENTO = inuDESCUENTO$
		where
			CONSECUTIVO = inuCONSECUTIVO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DESCUENTO:= inuDESCUENTO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPRECIO_TOTAL
	(
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type,
		inuPRECIO_TOTAL$ in LDC_ITEMS_COTIZACION_COM.PRECIO_TOTAL%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ITEMS_COTIZACION_COM;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_ITEMS_COTIZACION_COM
		set
			PRECIO_TOTAL = inuPRECIO_TOTAL$
		where
			CONSECUTIVO = inuCONSECUTIVO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PRECIO_TOTAL:= inuPRECIO_TOTAL$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updIVA
	(
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type,
		inuIVA$ in LDC_ITEMS_COTIZACION_COM.IVA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ITEMS_COTIZACION_COM;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_ITEMS_COTIZACION_COM
		set
			IVA = inuIVA$
		where
			CONSECUTIVO = inuCONSECUTIVO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.IVA:= inuIVA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFECHA_REGISTRO
	(
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type,
		idtFECHA_REGISTRO$ in LDC_ITEMS_COTIZACION_COM.FECHA_REGISTRO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ITEMS_COTIZACION_COM;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_ITEMS_COTIZACION_COM
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
	PROCEDURE updUSUARIO_REGISTRA
	(
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type,
		isbUSUARIO_REGISTRA$ in LDC_ITEMS_COTIZACION_COM.USUARIO_REGISTRA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ITEMS_COTIZACION_COM;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_ITEMS_COTIZACION_COM
		set
			USUARIO_REGISTRA = isbUSUARIO_REGISTRA$
		where
			CONSECUTIVO = inuCONSECUTIVO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.USUARIO_REGISTRA:= isbUSUARIO_REGISTRA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetCONSECUTIVO
	(
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type
	IS
		rcError styLDC_ITEMS_COTIZACION_COM;
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
	FUNCTION fnuGetID_COT_COMERCIAL
	(
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_COTIZACION_COM.ID_COT_COMERCIAL%type
	IS
		rcError styLDC_ITEMS_COTIZACION_COM;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.ID_COT_COMERCIAL);
		end if;
		Load
		(
		 		inuCONSECUTIVO
		);
		return(rcData.ID_COT_COMERCIAL);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetTIPO_TRABAJO
	(
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_COTIZACION_COM.TIPO_TRABAJO%type
	IS
		rcError styLDC_ITEMS_COTIZACION_COM;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.TIPO_TRABAJO);
		end if;
		Load
		(
		 		inuCONSECUTIVO
		);
		return(rcData.TIPO_TRABAJO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetACTIVIDAD
	(
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_COTIZACION_COM.ACTIVIDAD%type
	IS
		rcError styLDC_ITEMS_COTIZACION_COM;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.ACTIVIDAD);
		end if;
		Load
		(
		 		inuCONSECUTIVO
		);
		return(rcData.ACTIVIDAD);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetID_LISTA
	(
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_COTIZACION_COM.ID_LISTA%type
	IS
		rcError styLDC_ITEMS_COTIZACION_COM;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.ID_LISTA);
		end if;
		Load
		(
		 		inuCONSECUTIVO
		);
		return(rcData.ID_LISTA);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetID_ITEM
	(
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_COTIZACION_COM.ID_ITEM%type
	IS
		rcError styLDC_ITEMS_COTIZACION_COM;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.ID_ITEM);
		end if;
		Load
		(
		 		inuCONSECUTIVO
		);
		return(rcData.ID_ITEM);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCOSTO_VENTA
	(
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_COTIZACION_COM.COSTO_VENTA%type
	IS
		rcError styLDC_ITEMS_COTIZACION_COM;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.COSTO_VENTA);
		end if;
		Load
		(
		 		inuCONSECUTIVO
		);
		return(rcData.COSTO_VENTA);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetAIU
	(
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_COTIZACION_COM.AIU%type
	IS
		rcError styLDC_ITEMS_COTIZACION_COM;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.AIU);
		end if;
		Load
		(
		 		inuCONSECUTIVO
		);
		return(rcData.AIU);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCANTIDAD
	(
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_COTIZACION_COM.CANTIDAD%type
	IS
		rcError styLDC_ITEMS_COTIZACION_COM;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.CANTIDAD);
		end if;
		Load
		(
		 		inuCONSECUTIVO
		);
		return(rcData.CANTIDAD);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetDESCUENTO
	(
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_COTIZACION_COM.DESCUENTO%type
	IS
		rcError styLDC_ITEMS_COTIZACION_COM;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.DESCUENTO);
		end if;
		Load
		(
		 		inuCONSECUTIVO
		);
		return(rcData.DESCUENTO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetPRECIO_TOTAL
	(
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_COTIZACION_COM.PRECIO_TOTAL%type
	IS
		rcError styLDC_ITEMS_COTIZACION_COM;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.PRECIO_TOTAL);
		end if;
		Load
		(
		 		inuCONSECUTIVO
		);
		return(rcData.PRECIO_TOTAL);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetIVA
	(
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_COTIZACION_COM.IVA%type
	IS
		rcError styLDC_ITEMS_COTIZACION_COM;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.IVA);
		end if;
		Load
		(
		 		inuCONSECUTIVO
		);
		return(rcData.IVA);
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
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_COTIZACION_COM.FECHA_REGISTRO%type
	IS
		rcError styLDC_ITEMS_COTIZACION_COM;
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
	FUNCTION fsbGetUSUARIO_REGISTRA
	(
		inuCONSECUTIVO in LDC_ITEMS_COTIZACION_COM.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ITEMS_COTIZACION_COM.USUARIO_REGISTRA%type
	IS
		rcError styLDC_ITEMS_COTIZACION_COM;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.USUARIO_REGISTRA);
		end if;
		Load
		(
		 		inuCONSECUTIVO
		);
		return(rcData.USUARIO_REGISTRA);
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
end DALDC_ITEMS_COTIZACION_COM;
/
PROMPT Otorgando permisos de ejecucion a DALDC_ITEMS_COTIZACION_COM
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_ITEMS_COTIZACION_COM', 'ADM_PERSON');
END;
/