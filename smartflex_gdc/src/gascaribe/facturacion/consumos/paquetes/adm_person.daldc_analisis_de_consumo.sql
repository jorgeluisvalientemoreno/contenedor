CREATE OR REPLACE PACKAGE ADM_PERSON.DALDC_ANALISIS_DE_CONSUMO
is
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     : DALDC_ANALISIS_DE_CONSUMO
    Descripcion	 : 
    
    Parametro	    Descripcion
    ============	==============================
    
    Historia de Modificaciones
    Fecha   	           Autor            Modificacion
    ====================   =========        ====================
    07/06/2024              PAcosta         OSF-2812: Cambio de esquema ADM_PERSON                                               
    ****************************************************************/
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuADC_ID in LDC_ANALISIS_DE_CONSUMO.ADC_ID%type
	)
	IS
		SELECT LDC_ANALISIS_DE_CONSUMO.*,LDC_ANALISIS_DE_CONSUMO.rowid
		FROM LDC_ANALISIS_DE_CONSUMO
		WHERE
		    ADC_ID = inuADC_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_ANALISIS_DE_CONSUMO.*,LDC_ANALISIS_DE_CONSUMO.rowid
		FROM LDC_ANALISIS_DE_CONSUMO
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_ANALISIS_DE_CONSUMO  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_ANALISIS_DE_CONSUMO is table of styLDC_ANALISIS_DE_CONSUMO index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_ANALISIS_DE_CONSUMO;

	/* Tipos referenciando al registro */
	type tytbADC_ID is table of LDC_ANALISIS_DE_CONSUMO.ADC_ID%type index by binary_integer;
	type tytbDESCRIPTION is table of LDC_ANALISIS_DE_CONSUMO.DESCRIPTION%type index by binary_integer;
	type tytbACTIVO is table of LDC_ANALISIS_DE_CONSUMO.ACTIVO%type index by binary_integer;
	type tytbUSUARIO is table of LDC_ANALISIS_DE_CONSUMO.USUARIO%type index by binary_integer;
	type tytbFECHA_REGISTRO is table of LDC_ANALISIS_DE_CONSUMO.FECHA_REGISTRO%type index by binary_integer;
	type tytbTERMINAL is table of LDC_ANALISIS_DE_CONSUMO.TERMINAL%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_ANALISIS_DE_CONSUMO is record
	(
		ADC_ID   tytbADC_ID,
		DESCRIPTION   tytbDESCRIPTION,
		ACTIVO   tytbACTIVO,
		USUARIO   tytbUSUARIO,
		FECHA_REGISTRO   tytbFECHA_REGISTRO,
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
		inuADC_ID in LDC_ANALISIS_DE_CONSUMO.ADC_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuADC_ID in LDC_ANALISIS_DE_CONSUMO.ADC_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuADC_ID in LDC_ANALISIS_DE_CONSUMO.ADC_ID%type
	);

	PROCEDURE getRecord
	(
		inuADC_ID in LDC_ANALISIS_DE_CONSUMO.ADC_ID%type,
		orcRecord out nocopy styLDC_ANALISIS_DE_CONSUMO
	);

	FUNCTION frcGetRcData
	(
		inuADC_ID in LDC_ANALISIS_DE_CONSUMO.ADC_ID%type
	)
	RETURN styLDC_ANALISIS_DE_CONSUMO;

	FUNCTION frcGetRcData
	RETURN styLDC_ANALISIS_DE_CONSUMO;

	FUNCTION frcGetRecord
	(
		inuADC_ID in LDC_ANALISIS_DE_CONSUMO.ADC_ID%type
	)
	RETURN styLDC_ANALISIS_DE_CONSUMO;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_ANALISIS_DE_CONSUMO
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_ANALISIS_DE_CONSUMO in styLDC_ANALISIS_DE_CONSUMO
	);

	PROCEDURE insRecord
	(
		ircLDC_ANALISIS_DE_CONSUMO in styLDC_ANALISIS_DE_CONSUMO,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_ANALISIS_DE_CONSUMO in out nocopy tytbLDC_ANALISIS_DE_CONSUMO
	);

	PROCEDURE delRecord
	(
		inuADC_ID in LDC_ANALISIS_DE_CONSUMO.ADC_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_ANALISIS_DE_CONSUMO in out nocopy tytbLDC_ANALISIS_DE_CONSUMO,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_ANALISIS_DE_CONSUMO in styLDC_ANALISIS_DE_CONSUMO,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_ANALISIS_DE_CONSUMO in out nocopy tytbLDC_ANALISIS_DE_CONSUMO,
		inuLock in number default 1
	);

	PROCEDURE updDESCRIPTION
	(
		inuADC_ID in LDC_ANALISIS_DE_CONSUMO.ADC_ID%type,
		isbDESCRIPTION$ in LDC_ANALISIS_DE_CONSUMO.DESCRIPTION%type,
		inuLock in number default 0
	);

	PROCEDURE updACTIVO
	(
		inuADC_ID in LDC_ANALISIS_DE_CONSUMO.ADC_ID%type,
		isbACTIVO$ in LDC_ANALISIS_DE_CONSUMO.ACTIVO%type,
		inuLock in number default 0
	);

	PROCEDURE updUSUARIO
	(
		inuADC_ID in LDC_ANALISIS_DE_CONSUMO.ADC_ID%type,
		isbUSUARIO$ in LDC_ANALISIS_DE_CONSUMO.USUARIO%type,
		inuLock in number default 0
	);

	PROCEDURE updFECHA_REGISTRO
	(
		inuADC_ID in LDC_ANALISIS_DE_CONSUMO.ADC_ID%type,
		idtFECHA_REGISTRO$ in LDC_ANALISIS_DE_CONSUMO.FECHA_REGISTRO%type,
		inuLock in number default 0
	);

	PROCEDURE updTERMINAL
	(
		inuADC_ID in LDC_ANALISIS_DE_CONSUMO.ADC_ID%type,
		isbTERMINAL$ in LDC_ANALISIS_DE_CONSUMO.TERMINAL%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetADC_ID
	(
		inuADC_ID in LDC_ANALISIS_DE_CONSUMO.ADC_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ANALISIS_DE_CONSUMO.ADC_ID%type;

	FUNCTION fsbGetDESCRIPTION
	(
		inuADC_ID in LDC_ANALISIS_DE_CONSUMO.ADC_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ANALISIS_DE_CONSUMO.DESCRIPTION%type;

	FUNCTION fsbGetACTIVO
	(
		inuADC_ID in LDC_ANALISIS_DE_CONSUMO.ADC_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ANALISIS_DE_CONSUMO.ACTIVO%type;

	FUNCTION fsbGetUSUARIO
	(
		inuADC_ID in LDC_ANALISIS_DE_CONSUMO.ADC_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ANALISIS_DE_CONSUMO.USUARIO%type;

	FUNCTION fdtGetFECHA_REGISTRO
	(
		inuADC_ID in LDC_ANALISIS_DE_CONSUMO.ADC_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ANALISIS_DE_CONSUMO.FECHA_REGISTRO%type;

	FUNCTION fsbGetTERMINAL
	(
		inuADC_ID in LDC_ANALISIS_DE_CONSUMO.ADC_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ANALISIS_DE_CONSUMO.TERMINAL%type;


	PROCEDURE LockByPk
	(
		inuADC_ID in LDC_ANALISIS_DE_CONSUMO.ADC_ID%type,
		orcLDC_ANALISIS_DE_CONSUMO  out styLDC_ANALISIS_DE_CONSUMO
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_ANALISIS_DE_CONSUMO  out styLDC_ANALISIS_DE_CONSUMO
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_ANALISIS_DE_CONSUMO;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALDC_ANALISIS_DE_CONSUMO
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_ANALISIS_DE_CONSUMO';
	 cnuGeEntityId constant varchar2(30) := 8795; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuADC_ID in LDC_ANALISIS_DE_CONSUMO.ADC_ID%type
	)
	IS
		SELECT LDC_ANALISIS_DE_CONSUMO.*,LDC_ANALISIS_DE_CONSUMO.rowid
		FROM LDC_ANALISIS_DE_CONSUMO
		WHERE  ADC_ID = inuADC_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_ANALISIS_DE_CONSUMO.*,LDC_ANALISIS_DE_CONSUMO.rowid
		FROM LDC_ANALISIS_DE_CONSUMO
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_ANALISIS_DE_CONSUMO is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_ANALISIS_DE_CONSUMO;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_ANALISIS_DE_CONSUMO default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.ADC_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuADC_ID in LDC_ANALISIS_DE_CONSUMO.ADC_ID%type,
		orcLDC_ANALISIS_DE_CONSUMO  out styLDC_ANALISIS_DE_CONSUMO
	)
	IS
		rcError styLDC_ANALISIS_DE_CONSUMO;
	BEGIN
		rcError.ADC_ID := inuADC_ID;

		Open cuLockRcByPk
		(
			inuADC_ID
		);

		fetch cuLockRcByPk into orcLDC_ANALISIS_DE_CONSUMO;
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
		orcLDC_ANALISIS_DE_CONSUMO  out styLDC_ANALISIS_DE_CONSUMO
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_ANALISIS_DE_CONSUMO;
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
		itbLDC_ANALISIS_DE_CONSUMO  in out nocopy tytbLDC_ANALISIS_DE_CONSUMO
	)
	IS
	BEGIN
			rcRecOfTab.ADC_ID.delete;
			rcRecOfTab.DESCRIPTION.delete;
			rcRecOfTab.ACTIVO.delete;
			rcRecOfTab.USUARIO.delete;
			rcRecOfTab.FECHA_REGISTRO.delete;
			rcRecOfTab.TERMINAL.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_ANALISIS_DE_CONSUMO  in out nocopy tytbLDC_ANALISIS_DE_CONSUMO,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_ANALISIS_DE_CONSUMO);

		for n in itbLDC_ANALISIS_DE_CONSUMO.first .. itbLDC_ANALISIS_DE_CONSUMO.last loop
			rcRecOfTab.ADC_ID(n) := itbLDC_ANALISIS_DE_CONSUMO(n).ADC_ID;
			rcRecOfTab.DESCRIPTION(n) := itbLDC_ANALISIS_DE_CONSUMO(n).DESCRIPTION;
			rcRecOfTab.ACTIVO(n) := itbLDC_ANALISIS_DE_CONSUMO(n).ACTIVO;
			rcRecOfTab.USUARIO(n) := itbLDC_ANALISIS_DE_CONSUMO(n).USUARIO;
			rcRecOfTab.FECHA_REGISTRO(n) := itbLDC_ANALISIS_DE_CONSUMO(n).FECHA_REGISTRO;
			rcRecOfTab.TERMINAL(n) := itbLDC_ANALISIS_DE_CONSUMO(n).TERMINAL;
			rcRecOfTab.row_id(n) := itbLDC_ANALISIS_DE_CONSUMO(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuADC_ID in LDC_ANALISIS_DE_CONSUMO.ADC_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuADC_ID
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
		inuADC_ID in LDC_ANALISIS_DE_CONSUMO.ADC_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuADC_ID = rcData.ADC_ID
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
		inuADC_ID in LDC_ANALISIS_DE_CONSUMO.ADC_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuADC_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuADC_ID in LDC_ANALISIS_DE_CONSUMO.ADC_ID%type
	)
	IS
		rcError styLDC_ANALISIS_DE_CONSUMO;
	BEGIN		rcError.ADC_ID:=inuADC_ID;

		Load
		(
			inuADC_ID
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
		inuADC_ID in LDC_ANALISIS_DE_CONSUMO.ADC_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuADC_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuADC_ID in LDC_ANALISIS_DE_CONSUMO.ADC_ID%type,
		orcRecord out nocopy styLDC_ANALISIS_DE_CONSUMO
	)
	IS
		rcError styLDC_ANALISIS_DE_CONSUMO;
	BEGIN		rcError.ADC_ID:=inuADC_ID;

		Load
		(
			inuADC_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuADC_ID in LDC_ANALISIS_DE_CONSUMO.ADC_ID%type
	)
	RETURN styLDC_ANALISIS_DE_CONSUMO
	IS
		rcError styLDC_ANALISIS_DE_CONSUMO;
	BEGIN
		rcError.ADC_ID:=inuADC_ID;

		Load
		(
			inuADC_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuADC_ID in LDC_ANALISIS_DE_CONSUMO.ADC_ID%type
	)
	RETURN styLDC_ANALISIS_DE_CONSUMO
	IS
		rcError styLDC_ANALISIS_DE_CONSUMO;
	BEGIN
		rcError.ADC_ID:=inuADC_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuADC_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuADC_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_ANALISIS_DE_CONSUMO
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_ANALISIS_DE_CONSUMO
	)
	IS
		rfLDC_ANALISIS_DE_CONSUMO tyrfLDC_ANALISIS_DE_CONSUMO;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_ANALISIS_DE_CONSUMO.*, LDC_ANALISIS_DE_CONSUMO.rowid FROM LDC_ANALISIS_DE_CONSUMO';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_ANALISIS_DE_CONSUMO for sbFullQuery;

		fetch rfLDC_ANALISIS_DE_CONSUMO bulk collect INTO otbResult;

		close rfLDC_ANALISIS_DE_CONSUMO;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_ANALISIS_DE_CONSUMO.*, LDC_ANALISIS_DE_CONSUMO.rowid FROM LDC_ANALISIS_DE_CONSUMO';
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
		ircLDC_ANALISIS_DE_CONSUMO in styLDC_ANALISIS_DE_CONSUMO
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_ANALISIS_DE_CONSUMO,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_ANALISIS_DE_CONSUMO in styLDC_ANALISIS_DE_CONSUMO,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_ANALISIS_DE_CONSUMO.ADC_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ADC_ID');
			raise ex.controlled_error;
		end if;

		insert into LDC_ANALISIS_DE_CONSUMO
		(
			ADC_ID,
			DESCRIPTION,
			ACTIVO,
			USUARIO,
			FECHA_REGISTRO,
			TERMINAL
		)
		values
		(
			ircLDC_ANALISIS_DE_CONSUMO.ADC_ID,
			ircLDC_ANALISIS_DE_CONSUMO.DESCRIPTION,
			ircLDC_ANALISIS_DE_CONSUMO.ACTIVO,
			ircLDC_ANALISIS_DE_CONSUMO.USUARIO,
			ircLDC_ANALISIS_DE_CONSUMO.FECHA_REGISTRO,
			ircLDC_ANALISIS_DE_CONSUMO.TERMINAL
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_ANALISIS_DE_CONSUMO));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_ANALISIS_DE_CONSUMO in out nocopy tytbLDC_ANALISIS_DE_CONSUMO
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_ANALISIS_DE_CONSUMO,blUseRowID);
		forall n in iotbLDC_ANALISIS_DE_CONSUMO.first..iotbLDC_ANALISIS_DE_CONSUMO.last
			insert into LDC_ANALISIS_DE_CONSUMO
			(
				ADC_ID,
				DESCRIPTION,
				ACTIVO,
				USUARIO,
				FECHA_REGISTRO,
				TERMINAL
			)
			values
			(
				rcRecOfTab.ADC_ID(n),
				rcRecOfTab.DESCRIPTION(n),
				rcRecOfTab.ACTIVO(n),
				rcRecOfTab.USUARIO(n),
				rcRecOfTab.FECHA_REGISTRO(n),
				rcRecOfTab.TERMINAL(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuADC_ID in LDC_ANALISIS_DE_CONSUMO.ADC_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_ANALISIS_DE_CONSUMO;
	BEGIN
		rcError.ADC_ID := inuADC_ID;

		if inuLock=1 then
			LockByPk
			(
				inuADC_ID,
				rcData
			);
		end if;


		delete
		from LDC_ANALISIS_DE_CONSUMO
		where
       		ADC_ID=inuADC_ID;
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
		rcError  styLDC_ANALISIS_DE_CONSUMO;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_ANALISIS_DE_CONSUMO
		where
			rowid = iriRowID
		returning
			ADC_ID
		into
			rcError.ADC_ID;
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
		iotbLDC_ANALISIS_DE_CONSUMO in out nocopy tytbLDC_ANALISIS_DE_CONSUMO,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_ANALISIS_DE_CONSUMO;
	BEGIN
		FillRecordOfTables(iotbLDC_ANALISIS_DE_CONSUMO, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_ANALISIS_DE_CONSUMO.first .. iotbLDC_ANALISIS_DE_CONSUMO.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ANALISIS_DE_CONSUMO.first .. iotbLDC_ANALISIS_DE_CONSUMO.last
				delete
				from LDC_ANALISIS_DE_CONSUMO
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_ANALISIS_DE_CONSUMO.first .. iotbLDC_ANALISIS_DE_CONSUMO.last loop
					LockByPk
					(
						rcRecOfTab.ADC_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ANALISIS_DE_CONSUMO.first .. iotbLDC_ANALISIS_DE_CONSUMO.last
				delete
				from LDC_ANALISIS_DE_CONSUMO
				where
		         	ADC_ID = rcRecOfTab.ADC_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_ANALISIS_DE_CONSUMO in styLDC_ANALISIS_DE_CONSUMO,
		inuLock in number default 0
	)
	IS
		nuADC_ID	LDC_ANALISIS_DE_CONSUMO.ADC_ID%type;
	BEGIN
		if ircLDC_ANALISIS_DE_CONSUMO.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_ANALISIS_DE_CONSUMO.rowid,rcData);
			end if;
			update LDC_ANALISIS_DE_CONSUMO
			set
				DESCRIPTION = ircLDC_ANALISIS_DE_CONSUMO.DESCRIPTION,
				ACTIVO = ircLDC_ANALISIS_DE_CONSUMO.ACTIVO,
				USUARIO = ircLDC_ANALISIS_DE_CONSUMO.USUARIO,
				FECHA_REGISTRO = ircLDC_ANALISIS_DE_CONSUMO.FECHA_REGISTRO,
				TERMINAL = ircLDC_ANALISIS_DE_CONSUMO.TERMINAL
			where
				rowid = ircLDC_ANALISIS_DE_CONSUMO.rowid
			returning
				ADC_ID
			into
				nuADC_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_ANALISIS_DE_CONSUMO.ADC_ID,
					rcData
				);
			end if;

			update LDC_ANALISIS_DE_CONSUMO
			set
				DESCRIPTION = ircLDC_ANALISIS_DE_CONSUMO.DESCRIPTION,
				ACTIVO = ircLDC_ANALISIS_DE_CONSUMO.ACTIVO,
				USUARIO = ircLDC_ANALISIS_DE_CONSUMO.USUARIO,
				FECHA_REGISTRO = ircLDC_ANALISIS_DE_CONSUMO.FECHA_REGISTRO,
				TERMINAL = ircLDC_ANALISIS_DE_CONSUMO.TERMINAL
			where
				ADC_ID = ircLDC_ANALISIS_DE_CONSUMO.ADC_ID
			returning
				ADC_ID
			into
				nuADC_ID;
		end if;
		if
			nuADC_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_ANALISIS_DE_CONSUMO));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_ANALISIS_DE_CONSUMO in out nocopy tytbLDC_ANALISIS_DE_CONSUMO,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_ANALISIS_DE_CONSUMO;
	BEGIN
		FillRecordOfTables(iotbLDC_ANALISIS_DE_CONSUMO,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_ANALISIS_DE_CONSUMO.first .. iotbLDC_ANALISIS_DE_CONSUMO.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ANALISIS_DE_CONSUMO.first .. iotbLDC_ANALISIS_DE_CONSUMO.last
				update LDC_ANALISIS_DE_CONSUMO
				set
					DESCRIPTION = rcRecOfTab.DESCRIPTION(n),
					ACTIVO = rcRecOfTab.ACTIVO(n),
					USUARIO = rcRecOfTab.USUARIO(n),
					FECHA_REGISTRO = rcRecOfTab.FECHA_REGISTRO(n),
					TERMINAL = rcRecOfTab.TERMINAL(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_ANALISIS_DE_CONSUMO.first .. iotbLDC_ANALISIS_DE_CONSUMO.last loop
					LockByPk
					(
						rcRecOfTab.ADC_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ANALISIS_DE_CONSUMO.first .. iotbLDC_ANALISIS_DE_CONSUMO.last
				update LDC_ANALISIS_DE_CONSUMO
				SET
					DESCRIPTION = rcRecOfTab.DESCRIPTION(n),
					ACTIVO = rcRecOfTab.ACTIVO(n),
					USUARIO = rcRecOfTab.USUARIO(n),
					FECHA_REGISTRO = rcRecOfTab.FECHA_REGISTRO(n),
					TERMINAL = rcRecOfTab.TERMINAL(n)
				where
					ADC_ID = rcRecOfTab.ADC_ID(n)
;
		end if;
	END;
	PROCEDURE updDESCRIPTION
	(
		inuADC_ID in LDC_ANALISIS_DE_CONSUMO.ADC_ID%type,
		isbDESCRIPTION$ in LDC_ANALISIS_DE_CONSUMO.DESCRIPTION%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ANALISIS_DE_CONSUMO;
	BEGIN
		rcError.ADC_ID := inuADC_ID;
		if inuLock=1 then
			LockByPk
			(
				inuADC_ID,
				rcData
			);
		end if;

		update LDC_ANALISIS_DE_CONSUMO
		set
			DESCRIPTION = isbDESCRIPTION$
		where
			ADC_ID = inuADC_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DESCRIPTION:= isbDESCRIPTION$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updACTIVO
	(
		inuADC_ID in LDC_ANALISIS_DE_CONSUMO.ADC_ID%type,
		isbACTIVO$ in LDC_ANALISIS_DE_CONSUMO.ACTIVO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ANALISIS_DE_CONSUMO;
	BEGIN
		rcError.ADC_ID := inuADC_ID;
		if inuLock=1 then
			LockByPk
			(
				inuADC_ID,
				rcData
			);
		end if;

		update LDC_ANALISIS_DE_CONSUMO
		set
			ACTIVO = isbACTIVO$
		where
			ADC_ID = inuADC_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ACTIVO:= isbACTIVO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updUSUARIO
	(
		inuADC_ID in LDC_ANALISIS_DE_CONSUMO.ADC_ID%type,
		isbUSUARIO$ in LDC_ANALISIS_DE_CONSUMO.USUARIO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ANALISIS_DE_CONSUMO;
	BEGIN
		rcError.ADC_ID := inuADC_ID;
		if inuLock=1 then
			LockByPk
			(
				inuADC_ID,
				rcData
			);
		end if;

		update LDC_ANALISIS_DE_CONSUMO
		set
			USUARIO = isbUSUARIO$
		where
			ADC_ID = inuADC_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.USUARIO:= isbUSUARIO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFECHA_REGISTRO
	(
		inuADC_ID in LDC_ANALISIS_DE_CONSUMO.ADC_ID%type,
		idtFECHA_REGISTRO$ in LDC_ANALISIS_DE_CONSUMO.FECHA_REGISTRO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ANALISIS_DE_CONSUMO;
	BEGIN
		rcError.ADC_ID := inuADC_ID;
		if inuLock=1 then
			LockByPk
			(
				inuADC_ID,
				rcData
			);
		end if;

		update LDC_ANALISIS_DE_CONSUMO
		set
			FECHA_REGISTRO = idtFECHA_REGISTRO$
		where
			ADC_ID = inuADC_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FECHA_REGISTRO:= idtFECHA_REGISTRO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updTERMINAL
	(
		inuADC_ID in LDC_ANALISIS_DE_CONSUMO.ADC_ID%type,
		isbTERMINAL$ in LDC_ANALISIS_DE_CONSUMO.TERMINAL%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ANALISIS_DE_CONSUMO;
	BEGIN
		rcError.ADC_ID := inuADC_ID;
		if inuLock=1 then
			LockByPk
			(
				inuADC_ID,
				rcData
			);
		end if;

		update LDC_ANALISIS_DE_CONSUMO
		set
			TERMINAL = isbTERMINAL$
		where
			ADC_ID = inuADC_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TERMINAL:= isbTERMINAL$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetADC_ID
	(
		inuADC_ID in LDC_ANALISIS_DE_CONSUMO.ADC_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ANALISIS_DE_CONSUMO.ADC_ID%type
	IS
		rcError styLDC_ANALISIS_DE_CONSUMO;
	BEGIN

		rcError.ADC_ID := inuADC_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuADC_ID
			 )
		then
			 return(rcData.ADC_ID);
		end if;
		Load
		(
		 		inuADC_ID
		);
		return(rcData.ADC_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetDESCRIPTION
	(
		inuADC_ID in LDC_ANALISIS_DE_CONSUMO.ADC_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ANALISIS_DE_CONSUMO.DESCRIPTION%type
	IS
		rcError styLDC_ANALISIS_DE_CONSUMO;
	BEGIN

		rcError.ADC_ID := inuADC_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuADC_ID
			 )
		then
			 return(rcData.DESCRIPTION);
		end if;
		Load
		(
		 		inuADC_ID
		);
		return(rcData.DESCRIPTION);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetACTIVO
	(
		inuADC_ID in LDC_ANALISIS_DE_CONSUMO.ADC_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ANALISIS_DE_CONSUMO.ACTIVO%type
	IS
		rcError styLDC_ANALISIS_DE_CONSUMO;
	BEGIN

		rcError.ADC_ID := inuADC_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuADC_ID
			 )
		then
			 return(rcData.ACTIVO);
		end if;
		Load
		(
		 		inuADC_ID
		);
		return(rcData.ACTIVO);
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
		inuADC_ID in LDC_ANALISIS_DE_CONSUMO.ADC_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ANALISIS_DE_CONSUMO.USUARIO%type
	IS
		rcError styLDC_ANALISIS_DE_CONSUMO;
	BEGIN

		rcError.ADC_ID := inuADC_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuADC_ID
			 )
		then
			 return(rcData.USUARIO);
		end if;
		Load
		(
		 		inuADC_ID
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
	FUNCTION fdtGetFECHA_REGISTRO
	(
		inuADC_ID in LDC_ANALISIS_DE_CONSUMO.ADC_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ANALISIS_DE_CONSUMO.FECHA_REGISTRO%type
	IS
		rcError styLDC_ANALISIS_DE_CONSUMO;
	BEGIN

		rcError.ADC_ID := inuADC_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuADC_ID
			 )
		then
			 return(rcData.FECHA_REGISTRO);
		end if;
		Load
		(
		 		inuADC_ID
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
	FUNCTION fsbGetTERMINAL
	(
		inuADC_ID in LDC_ANALISIS_DE_CONSUMO.ADC_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ANALISIS_DE_CONSUMO.TERMINAL%type
	IS
		rcError styLDC_ANALISIS_DE_CONSUMO;
	BEGIN

		rcError.ADC_ID := inuADC_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuADC_ID
			 )
		then
			 return(rcData.TERMINAL);
		end if;
		Load
		(
		 		inuADC_ID
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
end DALDC_ANALISIS_DE_CONSUMO;
/
PROMPT Otorgando permisos de ejecucion a DALDC_ANALISIS_DE_CONSUMO
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_ANALISIS_DE_CONSUMO', 'ADM_PERSON');
END;
/