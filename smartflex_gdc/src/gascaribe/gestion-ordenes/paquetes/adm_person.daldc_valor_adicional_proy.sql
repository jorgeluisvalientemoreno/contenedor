CREATE OR REPLACE PACKAGE ADM_PERSON.DALDC_VALOR_ADICIONAL_PROY
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
		inuCONSECUTIVO in LDC_VALOR_ADICIONAL_PROY.CONSECUTIVO%type
	)
	IS
		SELECT LDC_VALOR_ADICIONAL_PROY.*,LDC_VALOR_ADICIONAL_PROY.rowid
		FROM LDC_VALOR_ADICIONAL_PROY
		WHERE
		    CONSECUTIVO = inuCONSECUTIVO;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_VALOR_ADICIONAL_PROY.*,LDC_VALOR_ADICIONAL_PROY.rowid
		FROM LDC_VALOR_ADICIONAL_PROY
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_VALOR_ADICIONAL_PROY  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_VALOR_ADICIONAL_PROY is table of styLDC_VALOR_ADICIONAL_PROY index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_VALOR_ADICIONAL_PROY;

	/* Tipos referenciando al registro */
	type tytbCONSECUTIVO is table of LDC_VALOR_ADICIONAL_PROY.CONSECUTIVO%type index by binary_integer;
	type tytbID_PROYECTO is table of LDC_VALOR_ADICIONAL_PROY.ID_PROYECTO%type index by binary_integer;
	type tytbVALOR is table of LDC_VALOR_ADICIONAL_PROY.VALOR%type index by binary_integer;
	type tytbCUPON is table of LDC_VALOR_ADICIONAL_PROY.CUPON%type index by binary_integer;
	type tytbFECHA_REGISTRO is table of LDC_VALOR_ADICIONAL_PROY.FECHA_REGISTRO%type index by binary_integer;
	type tytbUSUARIO is table of LDC_VALOR_ADICIONAL_PROY.USUARIO%type index by binary_integer;
	type tytbVALOR_COSTO is table of LDC_VALOR_ADICIONAL_PROY.VALOR_COSTO%type index by binary_integer;
	type tytbOBSERVACION is table of LDC_VALOR_ADICIONAL_PROY.OBSERVACION%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_VALOR_ADICIONAL_PROY is record
	(
		CONSECUTIVO   tytbCONSECUTIVO,
		ID_PROYECTO   tytbID_PROYECTO,
		VALOR   tytbVALOR,
		CUPON   tytbCUPON,
		FECHA_REGISTRO   tytbFECHA_REGISTRO,
		USUARIO   tytbUSUARIO,
		VALOR_COSTO   tytbVALOR_COSTO,
		OBSERVACION   tytbOBSERVACION,
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
		inuCONSECUTIVO in LDC_VALOR_ADICIONAL_PROY.CONSECUTIVO%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuCONSECUTIVO in LDC_VALOR_ADICIONAL_PROY.CONSECUTIVO%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuCONSECUTIVO in LDC_VALOR_ADICIONAL_PROY.CONSECUTIVO%type
	);

	PROCEDURE getRecord
	(
		inuCONSECUTIVO in LDC_VALOR_ADICIONAL_PROY.CONSECUTIVO%type,
		orcRecord out nocopy styLDC_VALOR_ADICIONAL_PROY
	);

	FUNCTION frcGetRcData
	(
		inuCONSECUTIVO in LDC_VALOR_ADICIONAL_PROY.CONSECUTIVO%type
	)
	RETURN styLDC_VALOR_ADICIONAL_PROY;

	FUNCTION frcGetRcData
	RETURN styLDC_VALOR_ADICIONAL_PROY;

	FUNCTION frcGetRecord
	(
		inuCONSECUTIVO in LDC_VALOR_ADICIONAL_PROY.CONSECUTIVO%type
	)
	RETURN styLDC_VALOR_ADICIONAL_PROY;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_VALOR_ADICIONAL_PROY
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_VALOR_ADICIONAL_PROY in styLDC_VALOR_ADICIONAL_PROY
	);

	PROCEDURE insRecord
	(
		ircLDC_VALOR_ADICIONAL_PROY in styLDC_VALOR_ADICIONAL_PROY,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_VALOR_ADICIONAL_PROY in out nocopy tytbLDC_VALOR_ADICIONAL_PROY
	);

	PROCEDURE delRecord
	(
		inuCONSECUTIVO in LDC_VALOR_ADICIONAL_PROY.CONSECUTIVO%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_VALOR_ADICIONAL_PROY in out nocopy tytbLDC_VALOR_ADICIONAL_PROY,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_VALOR_ADICIONAL_PROY in styLDC_VALOR_ADICIONAL_PROY,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_VALOR_ADICIONAL_PROY in out nocopy tytbLDC_VALOR_ADICIONAL_PROY,
		inuLock in number default 1
	);

	PROCEDURE updID_PROYECTO
	(
		inuCONSECUTIVO in LDC_VALOR_ADICIONAL_PROY.CONSECUTIVO%type,
		inuID_PROYECTO$ in LDC_VALOR_ADICIONAL_PROY.ID_PROYECTO%type,
		inuLock in number default 0
	);

	PROCEDURE updVALOR
	(
		inuCONSECUTIVO in LDC_VALOR_ADICIONAL_PROY.CONSECUTIVO%type,
		inuVALOR$ in LDC_VALOR_ADICIONAL_PROY.VALOR%type,
		inuLock in number default 0
	);

	PROCEDURE updCUPON
	(
		inuCONSECUTIVO in LDC_VALOR_ADICIONAL_PROY.CONSECUTIVO%type,
		inuCUPON$ in LDC_VALOR_ADICIONAL_PROY.CUPON%type,
		inuLock in number default 0
	);

	PROCEDURE updFECHA_REGISTRO
	(
		inuCONSECUTIVO in LDC_VALOR_ADICIONAL_PROY.CONSECUTIVO%type,
		idtFECHA_REGISTRO$ in LDC_VALOR_ADICIONAL_PROY.FECHA_REGISTRO%type,
		inuLock in number default 0
	);

	PROCEDURE updUSUARIO
	(
		inuCONSECUTIVO in LDC_VALOR_ADICIONAL_PROY.CONSECUTIVO%type,
		isbUSUARIO$ in LDC_VALOR_ADICIONAL_PROY.USUARIO%type,
		inuLock in number default 0
	);

	PROCEDURE updVALOR_COSTO
	(
		inuCONSECUTIVO in LDC_VALOR_ADICIONAL_PROY.CONSECUTIVO%type,
		inuVALOR_COSTO$ in LDC_VALOR_ADICIONAL_PROY.VALOR_COSTO%type,
		inuLock in number default 0
	);

	PROCEDURE updOBSERVACION
	(
		inuCONSECUTIVO in LDC_VALOR_ADICIONAL_PROY.CONSECUTIVO%type,
		isbOBSERVACION$ in LDC_VALOR_ADICIONAL_PROY.OBSERVACION%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetCONSECUTIVO
	(
		inuCONSECUTIVO in LDC_VALOR_ADICIONAL_PROY.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VALOR_ADICIONAL_PROY.CONSECUTIVO%type;

	FUNCTION fnuGetID_PROYECTO
	(
		inuCONSECUTIVO in LDC_VALOR_ADICIONAL_PROY.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VALOR_ADICIONAL_PROY.ID_PROYECTO%type;

	FUNCTION fnuGetVALOR
	(
		inuCONSECUTIVO in LDC_VALOR_ADICIONAL_PROY.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VALOR_ADICIONAL_PROY.VALOR%type;

	FUNCTION fnuGetCUPON
	(
		inuCONSECUTIVO in LDC_VALOR_ADICIONAL_PROY.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VALOR_ADICIONAL_PROY.CUPON%type;

	FUNCTION fdtGetFECHA_REGISTRO
	(
		inuCONSECUTIVO in LDC_VALOR_ADICIONAL_PROY.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VALOR_ADICIONAL_PROY.FECHA_REGISTRO%type;

	FUNCTION fsbGetUSUARIO
	(
		inuCONSECUTIVO in LDC_VALOR_ADICIONAL_PROY.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VALOR_ADICIONAL_PROY.USUARIO%type;

	FUNCTION fnuGetVALOR_COSTO
	(
		inuCONSECUTIVO in LDC_VALOR_ADICIONAL_PROY.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VALOR_ADICIONAL_PROY.VALOR_COSTO%type;

	FUNCTION fsbGetOBSERVACION
	(
		inuCONSECUTIVO in LDC_VALOR_ADICIONAL_PROY.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VALOR_ADICIONAL_PROY.OBSERVACION%type;


	PROCEDURE LockByPk
	(
		inuCONSECUTIVO in LDC_VALOR_ADICIONAL_PROY.CONSECUTIVO%type,
		orcLDC_VALOR_ADICIONAL_PROY  out styLDC_VALOR_ADICIONAL_PROY
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_VALOR_ADICIONAL_PROY  out styLDC_VALOR_ADICIONAL_PROY
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_VALOR_ADICIONAL_PROY;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALDC_VALOR_ADICIONAL_PROY
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_VALOR_ADICIONAL_PROY';
	 cnuGeEntityId constant varchar2(30) := 3413; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuCONSECUTIVO in LDC_VALOR_ADICIONAL_PROY.CONSECUTIVO%type
	)
	IS
		SELECT LDC_VALOR_ADICIONAL_PROY.*,LDC_VALOR_ADICIONAL_PROY.rowid
		FROM LDC_VALOR_ADICIONAL_PROY
		WHERE  CONSECUTIVO = inuCONSECUTIVO
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_VALOR_ADICIONAL_PROY.*,LDC_VALOR_ADICIONAL_PROY.rowid
		FROM LDC_VALOR_ADICIONAL_PROY
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_VALOR_ADICIONAL_PROY is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_VALOR_ADICIONAL_PROY;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_VALOR_ADICIONAL_PROY default rcData )
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
		inuCONSECUTIVO in LDC_VALOR_ADICIONAL_PROY.CONSECUTIVO%type,
		orcLDC_VALOR_ADICIONAL_PROY  out styLDC_VALOR_ADICIONAL_PROY
	)
	IS
		rcError styLDC_VALOR_ADICIONAL_PROY;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;

		Open cuLockRcByPk
		(
			inuCONSECUTIVO
		);

		fetch cuLockRcByPk into orcLDC_VALOR_ADICIONAL_PROY;
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
		orcLDC_VALOR_ADICIONAL_PROY  out styLDC_VALOR_ADICIONAL_PROY
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_VALOR_ADICIONAL_PROY;
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
		itbLDC_VALOR_ADICIONAL_PROY  in out nocopy tytbLDC_VALOR_ADICIONAL_PROY
	)
	IS
	BEGIN
			rcRecOfTab.CONSECUTIVO.delete;
			rcRecOfTab.ID_PROYECTO.delete;
			rcRecOfTab.VALOR.delete;
			rcRecOfTab.CUPON.delete;
			rcRecOfTab.FECHA_REGISTRO.delete;
			rcRecOfTab.USUARIO.delete;
			rcRecOfTab.VALOR_COSTO.delete;
			rcRecOfTab.OBSERVACION.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_VALOR_ADICIONAL_PROY  in out nocopy tytbLDC_VALOR_ADICIONAL_PROY,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_VALOR_ADICIONAL_PROY);

		for n in itbLDC_VALOR_ADICIONAL_PROY.first .. itbLDC_VALOR_ADICIONAL_PROY.last loop
			rcRecOfTab.CONSECUTIVO(n) := itbLDC_VALOR_ADICIONAL_PROY(n).CONSECUTIVO;
			rcRecOfTab.ID_PROYECTO(n) := itbLDC_VALOR_ADICIONAL_PROY(n).ID_PROYECTO;
			rcRecOfTab.VALOR(n) := itbLDC_VALOR_ADICIONAL_PROY(n).VALOR;
			rcRecOfTab.CUPON(n) := itbLDC_VALOR_ADICIONAL_PROY(n).CUPON;
			rcRecOfTab.FECHA_REGISTRO(n) := itbLDC_VALOR_ADICIONAL_PROY(n).FECHA_REGISTRO;
			rcRecOfTab.USUARIO(n) := itbLDC_VALOR_ADICIONAL_PROY(n).USUARIO;
			rcRecOfTab.VALOR_COSTO(n) := itbLDC_VALOR_ADICIONAL_PROY(n).VALOR_COSTO;
			rcRecOfTab.OBSERVACION(n) := itbLDC_VALOR_ADICIONAL_PROY(n).OBSERVACION;
			rcRecOfTab.row_id(n) := itbLDC_VALOR_ADICIONAL_PROY(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuCONSECUTIVO in LDC_VALOR_ADICIONAL_PROY.CONSECUTIVO%type
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
		inuCONSECUTIVO in LDC_VALOR_ADICIONAL_PROY.CONSECUTIVO%type
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
		inuCONSECUTIVO in LDC_VALOR_ADICIONAL_PROY.CONSECUTIVO%type
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
		inuCONSECUTIVO in LDC_VALOR_ADICIONAL_PROY.CONSECUTIVO%type
	)
	IS
		rcError styLDC_VALOR_ADICIONAL_PROY;
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
		inuCONSECUTIVO in LDC_VALOR_ADICIONAL_PROY.CONSECUTIVO%type
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
		inuCONSECUTIVO in LDC_VALOR_ADICIONAL_PROY.CONSECUTIVO%type,
		orcRecord out nocopy styLDC_VALOR_ADICIONAL_PROY
	)
	IS
		rcError styLDC_VALOR_ADICIONAL_PROY;
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
		inuCONSECUTIVO in LDC_VALOR_ADICIONAL_PROY.CONSECUTIVO%type
	)
	RETURN styLDC_VALOR_ADICIONAL_PROY
	IS
		rcError styLDC_VALOR_ADICIONAL_PROY;
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
		inuCONSECUTIVO in LDC_VALOR_ADICIONAL_PROY.CONSECUTIVO%type
	)
	RETURN styLDC_VALOR_ADICIONAL_PROY
	IS
		rcError styLDC_VALOR_ADICIONAL_PROY;
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
	RETURN styLDC_VALOR_ADICIONAL_PROY
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_VALOR_ADICIONAL_PROY
	)
	IS
		rfLDC_VALOR_ADICIONAL_PROY tyrfLDC_VALOR_ADICIONAL_PROY;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_VALOR_ADICIONAL_PROY.*, LDC_VALOR_ADICIONAL_PROY.rowid FROM LDC_VALOR_ADICIONAL_PROY';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_VALOR_ADICIONAL_PROY for sbFullQuery;

		fetch rfLDC_VALOR_ADICIONAL_PROY bulk collect INTO otbResult;

		close rfLDC_VALOR_ADICIONAL_PROY;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_VALOR_ADICIONAL_PROY.*, LDC_VALOR_ADICIONAL_PROY.rowid FROM LDC_VALOR_ADICIONAL_PROY';
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
		ircLDC_VALOR_ADICIONAL_PROY in styLDC_VALOR_ADICIONAL_PROY
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_VALOR_ADICIONAL_PROY,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_VALOR_ADICIONAL_PROY in styLDC_VALOR_ADICIONAL_PROY,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_VALOR_ADICIONAL_PROY.CONSECUTIVO is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|CONSECUTIVO');
			raise ex.controlled_error;
		end if;

		insert into LDC_VALOR_ADICIONAL_PROY
		(
			CONSECUTIVO,
			ID_PROYECTO,
			VALOR,
			CUPON,
			FECHA_REGISTRO,
			USUARIO,
			VALOR_COSTO,
			OBSERVACION
		)
		values
		(
			ircLDC_VALOR_ADICIONAL_PROY.CONSECUTIVO,
			ircLDC_VALOR_ADICIONAL_PROY.ID_PROYECTO,
			ircLDC_VALOR_ADICIONAL_PROY.VALOR,
			ircLDC_VALOR_ADICIONAL_PROY.CUPON,
			ircLDC_VALOR_ADICIONAL_PROY.FECHA_REGISTRO,
			ircLDC_VALOR_ADICIONAL_PROY.USUARIO,
			ircLDC_VALOR_ADICIONAL_PROY.VALOR_COSTO,
			ircLDC_VALOR_ADICIONAL_PROY.OBSERVACION
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_VALOR_ADICIONAL_PROY));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_VALOR_ADICIONAL_PROY in out nocopy tytbLDC_VALOR_ADICIONAL_PROY
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_VALOR_ADICIONAL_PROY,blUseRowID);
		forall n in iotbLDC_VALOR_ADICIONAL_PROY.first..iotbLDC_VALOR_ADICIONAL_PROY.last
			insert into LDC_VALOR_ADICIONAL_PROY
			(
				CONSECUTIVO,
				ID_PROYECTO,
				VALOR,
				CUPON,
				FECHA_REGISTRO,
				USUARIO,
				VALOR_COSTO,
				OBSERVACION
			)
			values
			(
				rcRecOfTab.CONSECUTIVO(n),
				rcRecOfTab.ID_PROYECTO(n),
				rcRecOfTab.VALOR(n),
				rcRecOfTab.CUPON(n),
				rcRecOfTab.FECHA_REGISTRO(n),
				rcRecOfTab.USUARIO(n),
				rcRecOfTab.VALOR_COSTO(n),
				rcRecOfTab.OBSERVACION(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuCONSECUTIVO in LDC_VALOR_ADICIONAL_PROY.CONSECUTIVO%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_VALOR_ADICIONAL_PROY;
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
		from LDC_VALOR_ADICIONAL_PROY
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
		rcError  styLDC_VALOR_ADICIONAL_PROY;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_VALOR_ADICIONAL_PROY
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
		iotbLDC_VALOR_ADICIONAL_PROY in out nocopy tytbLDC_VALOR_ADICIONAL_PROY,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_VALOR_ADICIONAL_PROY;
	BEGIN
		FillRecordOfTables(iotbLDC_VALOR_ADICIONAL_PROY, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_VALOR_ADICIONAL_PROY.first .. iotbLDC_VALOR_ADICIONAL_PROY.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_VALOR_ADICIONAL_PROY.first .. iotbLDC_VALOR_ADICIONAL_PROY.last
				delete
				from LDC_VALOR_ADICIONAL_PROY
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_VALOR_ADICIONAL_PROY.first .. iotbLDC_VALOR_ADICIONAL_PROY.last loop
					LockByPk
					(
						rcRecOfTab.CONSECUTIVO(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_VALOR_ADICIONAL_PROY.first .. iotbLDC_VALOR_ADICIONAL_PROY.last
				delete
				from LDC_VALOR_ADICIONAL_PROY
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
		ircLDC_VALOR_ADICIONAL_PROY in styLDC_VALOR_ADICIONAL_PROY,
		inuLock in number default 0
	)
	IS
		nuCONSECUTIVO	LDC_VALOR_ADICIONAL_PROY.CONSECUTIVO%type;
	BEGIN
		if ircLDC_VALOR_ADICIONAL_PROY.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_VALOR_ADICIONAL_PROY.rowid,rcData);
			end if;
			update LDC_VALOR_ADICIONAL_PROY
			set
				ID_PROYECTO = ircLDC_VALOR_ADICIONAL_PROY.ID_PROYECTO,
				VALOR = ircLDC_VALOR_ADICIONAL_PROY.VALOR,
				CUPON = ircLDC_VALOR_ADICIONAL_PROY.CUPON,
				FECHA_REGISTRO = ircLDC_VALOR_ADICIONAL_PROY.FECHA_REGISTRO,
				USUARIO = ircLDC_VALOR_ADICIONAL_PROY.USUARIO,
				VALOR_COSTO = ircLDC_VALOR_ADICIONAL_PROY.VALOR_COSTO,
				OBSERVACION = ircLDC_VALOR_ADICIONAL_PROY.OBSERVACION
			where
				rowid = ircLDC_VALOR_ADICIONAL_PROY.rowid
			returning
				CONSECUTIVO
			into
				nuCONSECUTIVO;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_VALOR_ADICIONAL_PROY.CONSECUTIVO,
					rcData
				);
			end if;

			update LDC_VALOR_ADICIONAL_PROY
			set
				ID_PROYECTO = ircLDC_VALOR_ADICIONAL_PROY.ID_PROYECTO,
				VALOR = ircLDC_VALOR_ADICIONAL_PROY.VALOR,
				CUPON = ircLDC_VALOR_ADICIONAL_PROY.CUPON,
				FECHA_REGISTRO = ircLDC_VALOR_ADICIONAL_PROY.FECHA_REGISTRO,
				USUARIO = ircLDC_VALOR_ADICIONAL_PROY.USUARIO,
				VALOR_COSTO = ircLDC_VALOR_ADICIONAL_PROY.VALOR_COSTO,
				OBSERVACION = ircLDC_VALOR_ADICIONAL_PROY.OBSERVACION
			where
				CONSECUTIVO = ircLDC_VALOR_ADICIONAL_PROY.CONSECUTIVO
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
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_VALOR_ADICIONAL_PROY));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_VALOR_ADICIONAL_PROY in out nocopy tytbLDC_VALOR_ADICIONAL_PROY,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_VALOR_ADICIONAL_PROY;
	BEGIN
		FillRecordOfTables(iotbLDC_VALOR_ADICIONAL_PROY,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_VALOR_ADICIONAL_PROY.first .. iotbLDC_VALOR_ADICIONAL_PROY.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_VALOR_ADICIONAL_PROY.first .. iotbLDC_VALOR_ADICIONAL_PROY.last
				update LDC_VALOR_ADICIONAL_PROY
				set
					ID_PROYECTO = rcRecOfTab.ID_PROYECTO(n),
					VALOR = rcRecOfTab.VALOR(n),
					CUPON = rcRecOfTab.CUPON(n),
					FECHA_REGISTRO = rcRecOfTab.FECHA_REGISTRO(n),
					USUARIO = rcRecOfTab.USUARIO(n),
					VALOR_COSTO = rcRecOfTab.VALOR_COSTO(n),
					OBSERVACION = rcRecOfTab.OBSERVACION(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_VALOR_ADICIONAL_PROY.first .. iotbLDC_VALOR_ADICIONAL_PROY.last loop
					LockByPk
					(
						rcRecOfTab.CONSECUTIVO(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_VALOR_ADICIONAL_PROY.first .. iotbLDC_VALOR_ADICIONAL_PROY.last
				update LDC_VALOR_ADICIONAL_PROY
				SET
					ID_PROYECTO = rcRecOfTab.ID_PROYECTO(n),
					VALOR = rcRecOfTab.VALOR(n),
					CUPON = rcRecOfTab.CUPON(n),
					FECHA_REGISTRO = rcRecOfTab.FECHA_REGISTRO(n),
					USUARIO = rcRecOfTab.USUARIO(n),
					VALOR_COSTO = rcRecOfTab.VALOR_COSTO(n),
					OBSERVACION = rcRecOfTab.OBSERVACION(n)
				where
					CONSECUTIVO = rcRecOfTab.CONSECUTIVO(n)
;
		end if;
	END;
	PROCEDURE updID_PROYECTO
	(
		inuCONSECUTIVO in LDC_VALOR_ADICIONAL_PROY.CONSECUTIVO%type,
		inuID_PROYECTO$ in LDC_VALOR_ADICIONAL_PROY.ID_PROYECTO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_VALOR_ADICIONAL_PROY;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_VALOR_ADICIONAL_PROY
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
	PROCEDURE updVALOR
	(
		inuCONSECUTIVO in LDC_VALOR_ADICIONAL_PROY.CONSECUTIVO%type,
		inuVALOR$ in LDC_VALOR_ADICIONAL_PROY.VALOR%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_VALOR_ADICIONAL_PROY;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_VALOR_ADICIONAL_PROY
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
	PROCEDURE updCUPON
	(
		inuCONSECUTIVO in LDC_VALOR_ADICIONAL_PROY.CONSECUTIVO%type,
		inuCUPON$ in LDC_VALOR_ADICIONAL_PROY.CUPON%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_VALOR_ADICIONAL_PROY;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_VALOR_ADICIONAL_PROY
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
	PROCEDURE updFECHA_REGISTRO
	(
		inuCONSECUTIVO in LDC_VALOR_ADICIONAL_PROY.CONSECUTIVO%type,
		idtFECHA_REGISTRO$ in LDC_VALOR_ADICIONAL_PROY.FECHA_REGISTRO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_VALOR_ADICIONAL_PROY;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_VALOR_ADICIONAL_PROY
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
	PROCEDURE updUSUARIO
	(
		inuCONSECUTIVO in LDC_VALOR_ADICIONAL_PROY.CONSECUTIVO%type,
		isbUSUARIO$ in LDC_VALOR_ADICIONAL_PROY.USUARIO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_VALOR_ADICIONAL_PROY;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_VALOR_ADICIONAL_PROY
		set
			USUARIO = isbUSUARIO$
		where
			CONSECUTIVO = inuCONSECUTIVO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.USUARIO:= isbUSUARIO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updVALOR_COSTO
	(
		inuCONSECUTIVO in LDC_VALOR_ADICIONAL_PROY.CONSECUTIVO%type,
		inuVALOR_COSTO$ in LDC_VALOR_ADICIONAL_PROY.VALOR_COSTO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_VALOR_ADICIONAL_PROY;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_VALOR_ADICIONAL_PROY
		set
			VALOR_COSTO = inuVALOR_COSTO$
		where
			CONSECUTIVO = inuCONSECUTIVO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.VALOR_COSTO:= inuVALOR_COSTO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updOBSERVACION
	(
		inuCONSECUTIVO in LDC_VALOR_ADICIONAL_PROY.CONSECUTIVO%type,
		isbOBSERVACION$ in LDC_VALOR_ADICIONAL_PROY.OBSERVACION%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_VALOR_ADICIONAL_PROY;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_VALOR_ADICIONAL_PROY
		set
			OBSERVACION = isbOBSERVACION$
		where
			CONSECUTIVO = inuCONSECUTIVO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.OBSERVACION:= isbOBSERVACION$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetCONSECUTIVO
	(
		inuCONSECUTIVO in LDC_VALOR_ADICIONAL_PROY.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VALOR_ADICIONAL_PROY.CONSECUTIVO%type
	IS
		rcError styLDC_VALOR_ADICIONAL_PROY;
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
		inuCONSECUTIVO in LDC_VALOR_ADICIONAL_PROY.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VALOR_ADICIONAL_PROY.ID_PROYECTO%type
	IS
		rcError styLDC_VALOR_ADICIONAL_PROY;
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
	FUNCTION fnuGetVALOR
	(
		inuCONSECUTIVO in LDC_VALOR_ADICIONAL_PROY.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VALOR_ADICIONAL_PROY.VALOR%type
	IS
		rcError styLDC_VALOR_ADICIONAL_PROY;
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
	FUNCTION fnuGetCUPON
	(
		inuCONSECUTIVO in LDC_VALOR_ADICIONAL_PROY.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VALOR_ADICIONAL_PROY.CUPON%type
	IS
		rcError styLDC_VALOR_ADICIONAL_PROY;
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
	FUNCTION fdtGetFECHA_REGISTRO
	(
		inuCONSECUTIVO in LDC_VALOR_ADICIONAL_PROY.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VALOR_ADICIONAL_PROY.FECHA_REGISTRO%type
	IS
		rcError styLDC_VALOR_ADICIONAL_PROY;
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
	FUNCTION fsbGetUSUARIO
	(
		inuCONSECUTIVO in LDC_VALOR_ADICIONAL_PROY.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VALOR_ADICIONAL_PROY.USUARIO%type
	IS
		rcError styLDC_VALOR_ADICIONAL_PROY;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.USUARIO);
		end if;
		Load
		(
		 		inuCONSECUTIVO
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
	FUNCTION fnuGetVALOR_COSTO
	(
		inuCONSECUTIVO in LDC_VALOR_ADICIONAL_PROY.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VALOR_ADICIONAL_PROY.VALOR_COSTO%type
	IS
		rcError styLDC_VALOR_ADICIONAL_PROY;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.VALOR_COSTO);
		end if;
		Load
		(
		 		inuCONSECUTIVO
		);
		return(rcData.VALOR_COSTO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetOBSERVACION
	(
		inuCONSECUTIVO in LDC_VALOR_ADICIONAL_PROY.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VALOR_ADICIONAL_PROY.OBSERVACION%type
	IS
		rcError styLDC_VALOR_ADICIONAL_PROY;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.OBSERVACION);
		end if;
		Load
		(
		 		inuCONSECUTIVO
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
	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	) IS
	Begin
	    blDAO_USE_CACHE := iblUseCache;
	END;

begin
    GetDAO_USE_CACHE;
end DALDC_VALOR_ADICIONAL_PROY;
/
PROMPT Otorgando permisos de ejecucion a DALDC_VALOR_ADICIONAL_PROY
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_VALOR_ADICIONAL_PROY', 'ADM_PERSON');
END;
/