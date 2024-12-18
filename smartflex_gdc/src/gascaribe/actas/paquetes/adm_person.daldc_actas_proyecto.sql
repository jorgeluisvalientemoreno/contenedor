CREATE OR REPLACE PACKAGE ADM_PERSON.DALDC_ACTAS_PROYECTO
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
    06/06/2024              PAcosta         OSF-2778: Cambio de esquema ADM_PERSON                              
    ****************************************************************/    
    
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuCONSECUTIVO in LDC_ACTAS_PROYECTO.CONSECUTIVO%type
	)
	IS
		SELECT LDC_ACTAS_PROYECTO.*,LDC_ACTAS_PROYECTO.rowid
		FROM LDC_ACTAS_PROYECTO
		WHERE
		    CONSECUTIVO = inuCONSECUTIVO;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_ACTAS_PROYECTO.*,LDC_ACTAS_PROYECTO.rowid
		FROM LDC_ACTAS_PROYECTO
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_ACTAS_PROYECTO  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_ACTAS_PROYECTO is table of styLDC_ACTAS_PROYECTO index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_ACTAS_PROYECTO;

	/* Tipos referenciando al registro */
	type tytbCONSECUTIVO is table of LDC_ACTAS_PROYECTO.CONSECUTIVO%type index by binary_integer;
	type tytbID_ACTA is table of LDC_ACTAS_PROYECTO.ID_ACTA%type index by binary_integer;
	type tytbID_PROYECTO is table of LDC_ACTAS_PROYECTO.ID_PROYECTO%type index by binary_integer;
	type tytbID_CUOTA is table of LDC_ACTAS_PROYECTO.ID_CUOTA%type index by binary_integer;
	type tytbFECHA_REGISTRO is table of LDC_ACTAS_PROYECTO.FECHA_REGISTRO%type index by binary_integer;
	type tytbTIPO_TRABAJO is table of LDC_ACTAS_PROYECTO.TIPO_TRABAJO%type index by binary_integer;
	type tytbVALOR_UNIT is table of LDC_ACTAS_PROYECTO.VALOR_UNIT%type index by binary_integer;
	type tytbCANT_TRABAJO is table of LDC_ACTAS_PROYECTO.CANT_TRABAJO%type index by binary_integer;
	type tytbVALOR_TOTAL is table of LDC_ACTAS_PROYECTO.VALOR_TOTAL%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_ACTAS_PROYECTO is record
	(
		CONSECUTIVO   tytbCONSECUTIVO,
		ID_ACTA   tytbID_ACTA,
		ID_PROYECTO   tytbID_PROYECTO,
		ID_CUOTA   tytbID_CUOTA,
		FECHA_REGISTRO   tytbFECHA_REGISTRO,
		TIPO_TRABAJO   tytbTIPO_TRABAJO,
		VALOR_UNIT   tytbVALOR_UNIT,
		CANT_TRABAJO   tytbCANT_TRABAJO,
		VALOR_TOTAL   tytbVALOR_TOTAL,
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
		inuCONSECUTIVO in LDC_ACTAS_PROYECTO.CONSECUTIVO%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuCONSECUTIVO in LDC_ACTAS_PROYECTO.CONSECUTIVO%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuCONSECUTIVO in LDC_ACTAS_PROYECTO.CONSECUTIVO%type
	);

	PROCEDURE getRecord
	(
		inuCONSECUTIVO in LDC_ACTAS_PROYECTO.CONSECUTIVO%type,
		orcRecord out nocopy styLDC_ACTAS_PROYECTO
	);

	FUNCTION frcGetRcData
	(
		inuCONSECUTIVO in LDC_ACTAS_PROYECTO.CONSECUTIVO%type
	)
	RETURN styLDC_ACTAS_PROYECTO;

	FUNCTION frcGetRcData
	RETURN styLDC_ACTAS_PROYECTO;

	FUNCTION frcGetRecord
	(
		inuCONSECUTIVO in LDC_ACTAS_PROYECTO.CONSECUTIVO%type
	)
	RETURN styLDC_ACTAS_PROYECTO;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_ACTAS_PROYECTO
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_ACTAS_PROYECTO in styLDC_ACTAS_PROYECTO
	);

	PROCEDURE insRecord
	(
		ircLDC_ACTAS_PROYECTO in styLDC_ACTAS_PROYECTO,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_ACTAS_PROYECTO in out nocopy tytbLDC_ACTAS_PROYECTO
	);

	PROCEDURE delRecord
	(
		inuCONSECUTIVO in LDC_ACTAS_PROYECTO.CONSECUTIVO%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_ACTAS_PROYECTO in out nocopy tytbLDC_ACTAS_PROYECTO,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_ACTAS_PROYECTO in styLDC_ACTAS_PROYECTO,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_ACTAS_PROYECTO in out nocopy tytbLDC_ACTAS_PROYECTO,
		inuLock in number default 1
	);

	PROCEDURE updID_ACTA
	(
		inuCONSECUTIVO in LDC_ACTAS_PROYECTO.CONSECUTIVO%type,
		inuID_ACTA$ in LDC_ACTAS_PROYECTO.ID_ACTA%type,
		inuLock in number default 0
	);

	PROCEDURE updID_PROYECTO
	(
		inuCONSECUTIVO in LDC_ACTAS_PROYECTO.CONSECUTIVO%type,
		inuID_PROYECTO$ in LDC_ACTAS_PROYECTO.ID_PROYECTO%type,
		inuLock in number default 0
	);

	PROCEDURE updID_CUOTA
	(
		inuCONSECUTIVO in LDC_ACTAS_PROYECTO.CONSECUTIVO%type,
		inuID_CUOTA$ in LDC_ACTAS_PROYECTO.ID_CUOTA%type,
		inuLock in number default 0
	);

	PROCEDURE updFECHA_REGISTRO
	(
		inuCONSECUTIVO in LDC_ACTAS_PROYECTO.CONSECUTIVO%type,
		idtFECHA_REGISTRO$ in LDC_ACTAS_PROYECTO.FECHA_REGISTRO%type,
		inuLock in number default 0
	);

	PROCEDURE updTIPO_TRABAJO
	(
		inuCONSECUTIVO in LDC_ACTAS_PROYECTO.CONSECUTIVO%type,
		inuTIPO_TRABAJO$ in LDC_ACTAS_PROYECTO.TIPO_TRABAJO%type,
		inuLock in number default 0
	);

	PROCEDURE updVALOR_UNIT
	(
		inuCONSECUTIVO in LDC_ACTAS_PROYECTO.CONSECUTIVO%type,
		inuVALOR_UNIT$ in LDC_ACTAS_PROYECTO.VALOR_UNIT%type,
		inuLock in number default 0
	);

	PROCEDURE updCANT_TRABAJO
	(
		inuCONSECUTIVO in LDC_ACTAS_PROYECTO.CONSECUTIVO%type,
		inuCANT_TRABAJO$ in LDC_ACTAS_PROYECTO.CANT_TRABAJO%type,
		inuLock in number default 0
	);

	PROCEDURE updVALOR_TOTAL
	(
		inuCONSECUTIVO in LDC_ACTAS_PROYECTO.CONSECUTIVO%type,
		inuVALOR_TOTAL$ in LDC_ACTAS_PROYECTO.VALOR_TOTAL%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetCONSECUTIVO
	(
		inuCONSECUTIVO in LDC_ACTAS_PROYECTO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ACTAS_PROYECTO.CONSECUTIVO%type;

	FUNCTION fnuGetID_ACTA
	(
		inuCONSECUTIVO in LDC_ACTAS_PROYECTO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ACTAS_PROYECTO.ID_ACTA%type;

	FUNCTION fnuGetID_PROYECTO
	(
		inuCONSECUTIVO in LDC_ACTAS_PROYECTO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ACTAS_PROYECTO.ID_PROYECTO%type;

	FUNCTION fnuGetID_CUOTA
	(
		inuCONSECUTIVO in LDC_ACTAS_PROYECTO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ACTAS_PROYECTO.ID_CUOTA%type;

	FUNCTION fdtGetFECHA_REGISTRO
	(
		inuCONSECUTIVO in LDC_ACTAS_PROYECTO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ACTAS_PROYECTO.FECHA_REGISTRO%type;

	FUNCTION fnuGetTIPO_TRABAJO
	(
		inuCONSECUTIVO in LDC_ACTAS_PROYECTO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ACTAS_PROYECTO.TIPO_TRABAJO%type;

	FUNCTION fnuGetVALOR_UNIT
	(
		inuCONSECUTIVO in LDC_ACTAS_PROYECTO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ACTAS_PROYECTO.VALOR_UNIT%type;

	FUNCTION fnuGetCANT_TRABAJO
	(
		inuCONSECUTIVO in LDC_ACTAS_PROYECTO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ACTAS_PROYECTO.CANT_TRABAJO%type;

	FUNCTION fnuGetVALOR_TOTAL
	(
		inuCONSECUTIVO in LDC_ACTAS_PROYECTO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ACTAS_PROYECTO.VALOR_TOTAL%type;


	PROCEDURE LockByPk
	(
		inuCONSECUTIVO in LDC_ACTAS_PROYECTO.CONSECUTIVO%type,
		orcLDC_ACTAS_PROYECTO  out styLDC_ACTAS_PROYECTO
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_ACTAS_PROYECTO  out styLDC_ACTAS_PROYECTO
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_ACTAS_PROYECTO;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALDC_ACTAS_PROYECTO
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_ACTAS_PROYECTO';
	 cnuGeEntityId constant varchar2(30) := 2898; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuCONSECUTIVO in LDC_ACTAS_PROYECTO.CONSECUTIVO%type
	)
	IS
		SELECT LDC_ACTAS_PROYECTO.*,LDC_ACTAS_PROYECTO.rowid
		FROM LDC_ACTAS_PROYECTO
		WHERE  CONSECUTIVO = inuCONSECUTIVO
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_ACTAS_PROYECTO.*,LDC_ACTAS_PROYECTO.rowid
		FROM LDC_ACTAS_PROYECTO
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_ACTAS_PROYECTO is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_ACTAS_PROYECTO;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_ACTAS_PROYECTO default rcData )
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
		inuCONSECUTIVO in LDC_ACTAS_PROYECTO.CONSECUTIVO%type,
		orcLDC_ACTAS_PROYECTO  out styLDC_ACTAS_PROYECTO
	)
	IS
		rcError styLDC_ACTAS_PROYECTO;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;

		Open cuLockRcByPk
		(
			inuCONSECUTIVO
		);

		fetch cuLockRcByPk into orcLDC_ACTAS_PROYECTO;
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
		orcLDC_ACTAS_PROYECTO  out styLDC_ACTAS_PROYECTO
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_ACTAS_PROYECTO;
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
		itbLDC_ACTAS_PROYECTO  in out nocopy tytbLDC_ACTAS_PROYECTO
	)
	IS
	BEGIN
			rcRecOfTab.CONSECUTIVO.delete;
			rcRecOfTab.ID_ACTA.delete;
			rcRecOfTab.ID_PROYECTO.delete;
			rcRecOfTab.ID_CUOTA.delete;
			rcRecOfTab.FECHA_REGISTRO.delete;
			rcRecOfTab.TIPO_TRABAJO.delete;
			rcRecOfTab.VALOR_UNIT.delete;
			rcRecOfTab.CANT_TRABAJO.delete;
			rcRecOfTab.VALOR_TOTAL.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_ACTAS_PROYECTO  in out nocopy tytbLDC_ACTAS_PROYECTO,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_ACTAS_PROYECTO);

		for n in itbLDC_ACTAS_PROYECTO.first .. itbLDC_ACTAS_PROYECTO.last loop
			rcRecOfTab.CONSECUTIVO(n) := itbLDC_ACTAS_PROYECTO(n).CONSECUTIVO;
			rcRecOfTab.ID_ACTA(n) := itbLDC_ACTAS_PROYECTO(n).ID_ACTA;
			rcRecOfTab.ID_PROYECTO(n) := itbLDC_ACTAS_PROYECTO(n).ID_PROYECTO;
			rcRecOfTab.ID_CUOTA(n) := itbLDC_ACTAS_PROYECTO(n).ID_CUOTA;
			rcRecOfTab.FECHA_REGISTRO(n) := itbLDC_ACTAS_PROYECTO(n).FECHA_REGISTRO;
			rcRecOfTab.TIPO_TRABAJO(n) := itbLDC_ACTAS_PROYECTO(n).TIPO_TRABAJO;
			rcRecOfTab.VALOR_UNIT(n) := itbLDC_ACTAS_PROYECTO(n).VALOR_UNIT;
			rcRecOfTab.CANT_TRABAJO(n) := itbLDC_ACTAS_PROYECTO(n).CANT_TRABAJO;
			rcRecOfTab.VALOR_TOTAL(n) := itbLDC_ACTAS_PROYECTO(n).VALOR_TOTAL;
			rcRecOfTab.row_id(n) := itbLDC_ACTAS_PROYECTO(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuCONSECUTIVO in LDC_ACTAS_PROYECTO.CONSECUTIVO%type
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
		inuCONSECUTIVO in LDC_ACTAS_PROYECTO.CONSECUTIVO%type
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
		inuCONSECUTIVO in LDC_ACTAS_PROYECTO.CONSECUTIVO%type
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
		inuCONSECUTIVO in LDC_ACTAS_PROYECTO.CONSECUTIVO%type
	)
	IS
		rcError styLDC_ACTAS_PROYECTO;
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
		inuCONSECUTIVO in LDC_ACTAS_PROYECTO.CONSECUTIVO%type
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
		inuCONSECUTIVO in LDC_ACTAS_PROYECTO.CONSECUTIVO%type,
		orcRecord out nocopy styLDC_ACTAS_PROYECTO
	)
	IS
		rcError styLDC_ACTAS_PROYECTO;
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
		inuCONSECUTIVO in LDC_ACTAS_PROYECTO.CONSECUTIVO%type
	)
	RETURN styLDC_ACTAS_PROYECTO
	IS
		rcError styLDC_ACTAS_PROYECTO;
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
		inuCONSECUTIVO in LDC_ACTAS_PROYECTO.CONSECUTIVO%type
	)
	RETURN styLDC_ACTAS_PROYECTO
	IS
		rcError styLDC_ACTAS_PROYECTO;
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
	RETURN styLDC_ACTAS_PROYECTO
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_ACTAS_PROYECTO
	)
	IS
		rfLDC_ACTAS_PROYECTO tyrfLDC_ACTAS_PROYECTO;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_ACTAS_PROYECTO.*, LDC_ACTAS_PROYECTO.rowid FROM LDC_ACTAS_PROYECTO';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_ACTAS_PROYECTO for sbFullQuery;

		fetch rfLDC_ACTAS_PROYECTO bulk collect INTO otbResult;

		close rfLDC_ACTAS_PROYECTO;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_ACTAS_PROYECTO.*, LDC_ACTAS_PROYECTO.rowid FROM LDC_ACTAS_PROYECTO';
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
		ircLDC_ACTAS_PROYECTO in styLDC_ACTAS_PROYECTO
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_ACTAS_PROYECTO,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_ACTAS_PROYECTO in styLDC_ACTAS_PROYECTO,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_ACTAS_PROYECTO.CONSECUTIVO is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|CONSECUTIVO');
			raise ex.controlled_error;
		end if;

		insert into LDC_ACTAS_PROYECTO
		(
			CONSECUTIVO,
			ID_ACTA,
			ID_PROYECTO,
			ID_CUOTA,
			FECHA_REGISTRO,
			TIPO_TRABAJO,
			VALOR_UNIT,
			CANT_TRABAJO,
			VALOR_TOTAL
		)
		values
		(
			ircLDC_ACTAS_PROYECTO.CONSECUTIVO,
			ircLDC_ACTAS_PROYECTO.ID_ACTA,
			ircLDC_ACTAS_PROYECTO.ID_PROYECTO,
			ircLDC_ACTAS_PROYECTO.ID_CUOTA,
			ircLDC_ACTAS_PROYECTO.FECHA_REGISTRO,
			ircLDC_ACTAS_PROYECTO.TIPO_TRABAJO,
			ircLDC_ACTAS_PROYECTO.VALOR_UNIT,
			ircLDC_ACTAS_PROYECTO.CANT_TRABAJO,
			ircLDC_ACTAS_PROYECTO.VALOR_TOTAL
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_ACTAS_PROYECTO));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_ACTAS_PROYECTO in out nocopy tytbLDC_ACTAS_PROYECTO
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_ACTAS_PROYECTO,blUseRowID);
		forall n in iotbLDC_ACTAS_PROYECTO.first..iotbLDC_ACTAS_PROYECTO.last
			insert into LDC_ACTAS_PROYECTO
			(
				CONSECUTIVO,
				ID_ACTA,
				ID_PROYECTO,
				ID_CUOTA,
				FECHA_REGISTRO,
				TIPO_TRABAJO,
				VALOR_UNIT,
				CANT_TRABAJO,
				VALOR_TOTAL
			)
			values
			(
				rcRecOfTab.CONSECUTIVO(n),
				rcRecOfTab.ID_ACTA(n),
				rcRecOfTab.ID_PROYECTO(n),
				rcRecOfTab.ID_CUOTA(n),
				rcRecOfTab.FECHA_REGISTRO(n),
				rcRecOfTab.TIPO_TRABAJO(n),
				rcRecOfTab.VALOR_UNIT(n),
				rcRecOfTab.CANT_TRABAJO(n),
				rcRecOfTab.VALOR_TOTAL(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuCONSECUTIVO in LDC_ACTAS_PROYECTO.CONSECUTIVO%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_ACTAS_PROYECTO;
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
		from LDC_ACTAS_PROYECTO
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
		rcError  styLDC_ACTAS_PROYECTO;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_ACTAS_PROYECTO
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
		iotbLDC_ACTAS_PROYECTO in out nocopy tytbLDC_ACTAS_PROYECTO,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_ACTAS_PROYECTO;
	BEGIN
		FillRecordOfTables(iotbLDC_ACTAS_PROYECTO, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_ACTAS_PROYECTO.first .. iotbLDC_ACTAS_PROYECTO.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ACTAS_PROYECTO.first .. iotbLDC_ACTAS_PROYECTO.last
				delete
				from LDC_ACTAS_PROYECTO
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_ACTAS_PROYECTO.first .. iotbLDC_ACTAS_PROYECTO.last loop
					LockByPk
					(
						rcRecOfTab.CONSECUTIVO(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ACTAS_PROYECTO.first .. iotbLDC_ACTAS_PROYECTO.last
				delete
				from LDC_ACTAS_PROYECTO
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
		ircLDC_ACTAS_PROYECTO in styLDC_ACTAS_PROYECTO,
		inuLock in number default 0
	)
	IS
		nuCONSECUTIVO	LDC_ACTAS_PROYECTO.CONSECUTIVO%type;
	BEGIN
		if ircLDC_ACTAS_PROYECTO.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_ACTAS_PROYECTO.rowid,rcData);
			end if;
			update LDC_ACTAS_PROYECTO
			set
				ID_ACTA = ircLDC_ACTAS_PROYECTO.ID_ACTA,
				ID_PROYECTO = ircLDC_ACTAS_PROYECTO.ID_PROYECTO,
				ID_CUOTA = ircLDC_ACTAS_PROYECTO.ID_CUOTA,
				FECHA_REGISTRO = ircLDC_ACTAS_PROYECTO.FECHA_REGISTRO,
				TIPO_TRABAJO = ircLDC_ACTAS_PROYECTO.TIPO_TRABAJO,
				VALOR_UNIT = ircLDC_ACTAS_PROYECTO.VALOR_UNIT,
				CANT_TRABAJO = ircLDC_ACTAS_PROYECTO.CANT_TRABAJO,
				VALOR_TOTAL = ircLDC_ACTAS_PROYECTO.VALOR_TOTAL
			where
				rowid = ircLDC_ACTAS_PROYECTO.rowid
			returning
				CONSECUTIVO
			into
				nuCONSECUTIVO;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_ACTAS_PROYECTO.CONSECUTIVO,
					rcData
				);
			end if;

			update LDC_ACTAS_PROYECTO
			set
				ID_ACTA = ircLDC_ACTAS_PROYECTO.ID_ACTA,
				ID_PROYECTO = ircLDC_ACTAS_PROYECTO.ID_PROYECTO,
				ID_CUOTA = ircLDC_ACTAS_PROYECTO.ID_CUOTA,
				FECHA_REGISTRO = ircLDC_ACTAS_PROYECTO.FECHA_REGISTRO,
				TIPO_TRABAJO = ircLDC_ACTAS_PROYECTO.TIPO_TRABAJO,
				VALOR_UNIT = ircLDC_ACTAS_PROYECTO.VALOR_UNIT,
				CANT_TRABAJO = ircLDC_ACTAS_PROYECTO.CANT_TRABAJO,
				VALOR_TOTAL = ircLDC_ACTAS_PROYECTO.VALOR_TOTAL
			where
				CONSECUTIVO = ircLDC_ACTAS_PROYECTO.CONSECUTIVO
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
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_ACTAS_PROYECTO));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_ACTAS_PROYECTO in out nocopy tytbLDC_ACTAS_PROYECTO,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_ACTAS_PROYECTO;
	BEGIN
		FillRecordOfTables(iotbLDC_ACTAS_PROYECTO,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_ACTAS_PROYECTO.first .. iotbLDC_ACTAS_PROYECTO.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ACTAS_PROYECTO.first .. iotbLDC_ACTAS_PROYECTO.last
				update LDC_ACTAS_PROYECTO
				set
					ID_ACTA = rcRecOfTab.ID_ACTA(n),
					ID_PROYECTO = rcRecOfTab.ID_PROYECTO(n),
					ID_CUOTA = rcRecOfTab.ID_CUOTA(n),
					FECHA_REGISTRO = rcRecOfTab.FECHA_REGISTRO(n),
					TIPO_TRABAJO = rcRecOfTab.TIPO_TRABAJO(n),
					VALOR_UNIT = rcRecOfTab.VALOR_UNIT(n),
					CANT_TRABAJO = rcRecOfTab.CANT_TRABAJO(n),
					VALOR_TOTAL = rcRecOfTab.VALOR_TOTAL(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_ACTAS_PROYECTO.first .. iotbLDC_ACTAS_PROYECTO.last loop
					LockByPk
					(
						rcRecOfTab.CONSECUTIVO(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ACTAS_PROYECTO.first .. iotbLDC_ACTAS_PROYECTO.last
				update LDC_ACTAS_PROYECTO
				SET
					ID_ACTA = rcRecOfTab.ID_ACTA(n),
					ID_PROYECTO = rcRecOfTab.ID_PROYECTO(n),
					ID_CUOTA = rcRecOfTab.ID_CUOTA(n),
					FECHA_REGISTRO = rcRecOfTab.FECHA_REGISTRO(n),
					TIPO_TRABAJO = rcRecOfTab.TIPO_TRABAJO(n),
					VALOR_UNIT = rcRecOfTab.VALOR_UNIT(n),
					CANT_TRABAJO = rcRecOfTab.CANT_TRABAJO(n),
					VALOR_TOTAL = rcRecOfTab.VALOR_TOTAL(n)
				where
					CONSECUTIVO = rcRecOfTab.CONSECUTIVO(n)
;
		end if;
	END;
	PROCEDURE updID_ACTA
	(
		inuCONSECUTIVO in LDC_ACTAS_PROYECTO.CONSECUTIVO%type,
		inuID_ACTA$ in LDC_ACTAS_PROYECTO.ID_ACTA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ACTAS_PROYECTO;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_ACTAS_PROYECTO
		set
			ID_ACTA = inuID_ACTA$
		where
			CONSECUTIVO = inuCONSECUTIVO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ID_ACTA:= inuID_ACTA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updID_PROYECTO
	(
		inuCONSECUTIVO in LDC_ACTAS_PROYECTO.CONSECUTIVO%type,
		inuID_PROYECTO$ in LDC_ACTAS_PROYECTO.ID_PROYECTO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ACTAS_PROYECTO;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_ACTAS_PROYECTO
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
	PROCEDURE updID_CUOTA
	(
		inuCONSECUTIVO in LDC_ACTAS_PROYECTO.CONSECUTIVO%type,
		inuID_CUOTA$ in LDC_ACTAS_PROYECTO.ID_CUOTA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ACTAS_PROYECTO;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_ACTAS_PROYECTO
		set
			ID_CUOTA = inuID_CUOTA$
		where
			CONSECUTIVO = inuCONSECUTIVO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ID_CUOTA:= inuID_CUOTA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFECHA_REGISTRO
	(
		inuCONSECUTIVO in LDC_ACTAS_PROYECTO.CONSECUTIVO%type,
		idtFECHA_REGISTRO$ in LDC_ACTAS_PROYECTO.FECHA_REGISTRO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ACTAS_PROYECTO;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_ACTAS_PROYECTO
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
	PROCEDURE updTIPO_TRABAJO
	(
		inuCONSECUTIVO in LDC_ACTAS_PROYECTO.CONSECUTIVO%type,
		inuTIPO_TRABAJO$ in LDC_ACTAS_PROYECTO.TIPO_TRABAJO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ACTAS_PROYECTO;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_ACTAS_PROYECTO
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
	PROCEDURE updVALOR_UNIT
	(
		inuCONSECUTIVO in LDC_ACTAS_PROYECTO.CONSECUTIVO%type,
		inuVALOR_UNIT$ in LDC_ACTAS_PROYECTO.VALOR_UNIT%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ACTAS_PROYECTO;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_ACTAS_PROYECTO
		set
			VALOR_UNIT = inuVALOR_UNIT$
		where
			CONSECUTIVO = inuCONSECUTIVO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.VALOR_UNIT:= inuVALOR_UNIT$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCANT_TRABAJO
	(
		inuCONSECUTIVO in LDC_ACTAS_PROYECTO.CONSECUTIVO%type,
		inuCANT_TRABAJO$ in LDC_ACTAS_PROYECTO.CANT_TRABAJO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ACTAS_PROYECTO;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_ACTAS_PROYECTO
		set
			CANT_TRABAJO = inuCANT_TRABAJO$
		where
			CONSECUTIVO = inuCONSECUTIVO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CANT_TRABAJO:= inuCANT_TRABAJO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updVALOR_TOTAL
	(
		inuCONSECUTIVO in LDC_ACTAS_PROYECTO.CONSECUTIVO%type,
		inuVALOR_TOTAL$ in LDC_ACTAS_PROYECTO.VALOR_TOTAL%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ACTAS_PROYECTO;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_ACTAS_PROYECTO
		set
			VALOR_TOTAL = inuVALOR_TOTAL$
		where
			CONSECUTIVO = inuCONSECUTIVO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.VALOR_TOTAL:= inuVALOR_TOTAL$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetCONSECUTIVO
	(
		inuCONSECUTIVO in LDC_ACTAS_PROYECTO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ACTAS_PROYECTO.CONSECUTIVO%type
	IS
		rcError styLDC_ACTAS_PROYECTO;
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
	FUNCTION fnuGetID_ACTA
	(
		inuCONSECUTIVO in LDC_ACTAS_PROYECTO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ACTAS_PROYECTO.ID_ACTA%type
	IS
		rcError styLDC_ACTAS_PROYECTO;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.ID_ACTA);
		end if;
		Load
		(
		 		inuCONSECUTIVO
		);
		return(rcData.ID_ACTA);
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
		inuCONSECUTIVO in LDC_ACTAS_PROYECTO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ACTAS_PROYECTO.ID_PROYECTO%type
	IS
		rcError styLDC_ACTAS_PROYECTO;
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
	FUNCTION fnuGetID_CUOTA
	(
		inuCONSECUTIVO in LDC_ACTAS_PROYECTO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ACTAS_PROYECTO.ID_CUOTA%type
	IS
		rcError styLDC_ACTAS_PROYECTO;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.ID_CUOTA);
		end if;
		Load
		(
		 		inuCONSECUTIVO
		);
		return(rcData.ID_CUOTA);
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
		inuCONSECUTIVO in LDC_ACTAS_PROYECTO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ACTAS_PROYECTO.FECHA_REGISTRO%type
	IS
		rcError styLDC_ACTAS_PROYECTO;
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
	FUNCTION fnuGetTIPO_TRABAJO
	(
		inuCONSECUTIVO in LDC_ACTAS_PROYECTO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ACTAS_PROYECTO.TIPO_TRABAJO%type
	IS
		rcError styLDC_ACTAS_PROYECTO;
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
	FUNCTION fnuGetVALOR_UNIT
	(
		inuCONSECUTIVO in LDC_ACTAS_PROYECTO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ACTAS_PROYECTO.VALOR_UNIT%type
	IS
		rcError styLDC_ACTAS_PROYECTO;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.VALOR_UNIT);
		end if;
		Load
		(
		 		inuCONSECUTIVO
		);
		return(rcData.VALOR_UNIT);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCANT_TRABAJO
	(
		inuCONSECUTIVO in LDC_ACTAS_PROYECTO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ACTAS_PROYECTO.CANT_TRABAJO%type
	IS
		rcError styLDC_ACTAS_PROYECTO;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.CANT_TRABAJO);
		end if;
		Load
		(
		 		inuCONSECUTIVO
		);
		return(rcData.CANT_TRABAJO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetVALOR_TOTAL
	(
		inuCONSECUTIVO in LDC_ACTAS_PROYECTO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ACTAS_PROYECTO.VALOR_TOTAL%type
	IS
		rcError styLDC_ACTAS_PROYECTO;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.VALOR_TOTAL);
		end if;
		Load
		(
		 		inuCONSECUTIVO
		);
		return(rcData.VALOR_TOTAL);
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
end DALDC_ACTAS_PROYECTO;
/
PROMPT Otorgando permisos de ejecucion a DALDC_ACTAS_PROYECTO
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_ACTAS_PROYECTO', 'ADM_PERSON');
END;
/