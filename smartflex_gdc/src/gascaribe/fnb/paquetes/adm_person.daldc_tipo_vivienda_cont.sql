CREATE OR REPLACE PACKAGE ADM_PERSON.DALDC_TIPO_VIVIENDA_CONT
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
		inuCONTRATO in LDC_TIPO_VIVIENDA_CONT.CONTRATO%type
	)
	IS
		SELECT LDC_TIPO_VIVIENDA_CONT.*,LDC_TIPO_VIVIENDA_CONT.rowid
		FROM LDC_TIPO_VIVIENDA_CONT
		WHERE
		    CONTRATO = inuCONTRATO;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_TIPO_VIVIENDA_CONT.*,LDC_TIPO_VIVIENDA_CONT.rowid
		FROM LDC_TIPO_VIVIENDA_CONT
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_TIPO_VIVIENDA_CONT  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_TIPO_VIVIENDA_CONT is table of styLDC_TIPO_VIVIENDA_CONT index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_TIPO_VIVIENDA_CONT;

	/* Tipos referenciando al registro */
	type tytbCONTRATO is table of LDC_TIPO_VIVIENDA_CONT.CONTRATO%type index by binary_integer;
	type tytbTIPO_VIVIENDA is table of LDC_TIPO_VIVIENDA_CONT.TIPO_VIVIENDA%type index by binary_integer;
	type tytbFECHA_REGISTRO is table of LDC_TIPO_VIVIENDA_CONT.FECHA_REGISTRO%type index by binary_integer;
	type tytbSOLICITUD is table of LDC_TIPO_VIVIENDA_CONT.SOLICITUD%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_TIPO_VIVIENDA_CONT is record
	(
		CONTRATO   tytbCONTRATO,
		TIPO_VIVIENDA   tytbTIPO_VIVIENDA,
		FECHA_REGISTRO   tytbFECHA_REGISTRO,
		SOLICITUD   tytbSOLICITUD,
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
		inuCONTRATO in LDC_TIPO_VIVIENDA_CONT.CONTRATO%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuCONTRATO in LDC_TIPO_VIVIENDA_CONT.CONTRATO%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuCONTRATO in LDC_TIPO_VIVIENDA_CONT.CONTRATO%type
	);

	PROCEDURE getRecord
	(
		inuCONTRATO in LDC_TIPO_VIVIENDA_CONT.CONTRATO%type,
		orcRecord out nocopy styLDC_TIPO_VIVIENDA_CONT
	);

	FUNCTION frcGetRcData
	(
		inuCONTRATO in LDC_TIPO_VIVIENDA_CONT.CONTRATO%type
	)
	RETURN styLDC_TIPO_VIVIENDA_CONT;

	FUNCTION frcGetRcData
	RETURN styLDC_TIPO_VIVIENDA_CONT;

	FUNCTION frcGetRecord
	(
		inuCONTRATO in LDC_TIPO_VIVIENDA_CONT.CONTRATO%type
	)
	RETURN styLDC_TIPO_VIVIENDA_CONT;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_TIPO_VIVIENDA_CONT
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_TIPO_VIVIENDA_CONT in styLDC_TIPO_VIVIENDA_CONT
	);

	PROCEDURE insRecord
	(
		ircLDC_TIPO_VIVIENDA_CONT in styLDC_TIPO_VIVIENDA_CONT,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_TIPO_VIVIENDA_CONT in out nocopy tytbLDC_TIPO_VIVIENDA_CONT
	);

	PROCEDURE delRecord
	(
		inuCONTRATO in LDC_TIPO_VIVIENDA_CONT.CONTRATO%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_TIPO_VIVIENDA_CONT in out nocopy tytbLDC_TIPO_VIVIENDA_CONT,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_TIPO_VIVIENDA_CONT in styLDC_TIPO_VIVIENDA_CONT,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_TIPO_VIVIENDA_CONT in out nocopy tytbLDC_TIPO_VIVIENDA_CONT,
		inuLock in number default 1
	);

	PROCEDURE updTIPO_VIVIENDA
	(
		inuCONTRATO in LDC_TIPO_VIVIENDA_CONT.CONTRATO%type,
		inuTIPO_VIVIENDA$ in LDC_TIPO_VIVIENDA_CONT.TIPO_VIVIENDA%type,
		inuLock in number default 0
	);

	PROCEDURE updFECHA_REGISTRO
	(
		inuCONTRATO in LDC_TIPO_VIVIENDA_CONT.CONTRATO%type,
		idtFECHA_REGISTRO$ in LDC_TIPO_VIVIENDA_CONT.FECHA_REGISTRO%type,
		inuLock in number default 0
	);

	PROCEDURE updSOLICITUD
	(
		inuCONTRATO in LDC_TIPO_VIVIENDA_CONT.CONTRATO%type,
		inuSOLICITUD$ in LDC_TIPO_VIVIENDA_CONT.SOLICITUD%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetCONTRATO
	(
		inuCONTRATO in LDC_TIPO_VIVIENDA_CONT.CONTRATO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPO_VIVIENDA_CONT.CONTRATO%type;

	FUNCTION fnuGetTIPO_VIVIENDA
	(
		inuCONTRATO in LDC_TIPO_VIVIENDA_CONT.CONTRATO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPO_VIVIENDA_CONT.TIPO_VIVIENDA%type;

	FUNCTION fdtGetFECHA_REGISTRO
	(
		inuCONTRATO in LDC_TIPO_VIVIENDA_CONT.CONTRATO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPO_VIVIENDA_CONT.FECHA_REGISTRO%type;

	FUNCTION fnuGetSOLICITUD
	(
		inuCONTRATO in LDC_TIPO_VIVIENDA_CONT.CONTRATO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPO_VIVIENDA_CONT.SOLICITUD%type;


	PROCEDURE LockByPk
	(
		inuCONTRATO in LDC_TIPO_VIVIENDA_CONT.CONTRATO%type,
		orcLDC_TIPO_VIVIENDA_CONT  out styLDC_TIPO_VIVIENDA_CONT
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_TIPO_VIVIENDA_CONT  out styLDC_TIPO_VIVIENDA_CONT
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_TIPO_VIVIENDA_CONT;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALDC_TIPO_VIVIENDA_CONT
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_TIPO_VIVIENDA_CONT';
	 cnuGeEntityId constant varchar2(30) := 4227; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuCONTRATO in LDC_TIPO_VIVIENDA_CONT.CONTRATO%type
	)
	IS
		SELECT LDC_TIPO_VIVIENDA_CONT.*,LDC_TIPO_VIVIENDA_CONT.rowid
		FROM LDC_TIPO_VIVIENDA_CONT
		WHERE  CONTRATO = inuCONTRATO
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_TIPO_VIVIENDA_CONT.*,LDC_TIPO_VIVIENDA_CONT.rowid
		FROM LDC_TIPO_VIVIENDA_CONT
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_TIPO_VIVIENDA_CONT is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_TIPO_VIVIENDA_CONT;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_TIPO_VIVIENDA_CONT default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.CONTRATO);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuCONTRATO in LDC_TIPO_VIVIENDA_CONT.CONTRATO%type,
		orcLDC_TIPO_VIVIENDA_CONT  out styLDC_TIPO_VIVIENDA_CONT
	)
	IS
		rcError styLDC_TIPO_VIVIENDA_CONT;
	BEGIN
		rcError.CONTRATO := inuCONTRATO;

		Open cuLockRcByPk
		(
			inuCONTRATO
		);

		fetch cuLockRcByPk into orcLDC_TIPO_VIVIENDA_CONT;
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
		orcLDC_TIPO_VIVIENDA_CONT  out styLDC_TIPO_VIVIENDA_CONT
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_TIPO_VIVIENDA_CONT;
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
		itbLDC_TIPO_VIVIENDA_CONT  in out nocopy tytbLDC_TIPO_VIVIENDA_CONT
	)
	IS
	BEGIN
			rcRecOfTab.CONTRATO.delete;
			rcRecOfTab.TIPO_VIVIENDA.delete;
			rcRecOfTab.FECHA_REGISTRO.delete;
			rcRecOfTab.SOLICITUD.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_TIPO_VIVIENDA_CONT  in out nocopy tytbLDC_TIPO_VIVIENDA_CONT,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_TIPO_VIVIENDA_CONT);

		for n in itbLDC_TIPO_VIVIENDA_CONT.first .. itbLDC_TIPO_VIVIENDA_CONT.last loop
			rcRecOfTab.CONTRATO(n) := itbLDC_TIPO_VIVIENDA_CONT(n).CONTRATO;
			rcRecOfTab.TIPO_VIVIENDA(n) := itbLDC_TIPO_VIVIENDA_CONT(n).TIPO_VIVIENDA;
			rcRecOfTab.FECHA_REGISTRO(n) := itbLDC_TIPO_VIVIENDA_CONT(n).FECHA_REGISTRO;
			rcRecOfTab.SOLICITUD(n) := itbLDC_TIPO_VIVIENDA_CONT(n).SOLICITUD;
			rcRecOfTab.row_id(n) := itbLDC_TIPO_VIVIENDA_CONT(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuCONTRATO in LDC_TIPO_VIVIENDA_CONT.CONTRATO%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuCONTRATO
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
		inuCONTRATO in LDC_TIPO_VIVIENDA_CONT.CONTRATO%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuCONTRATO = rcData.CONTRATO
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
		inuCONTRATO in LDC_TIPO_VIVIENDA_CONT.CONTRATO%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuCONTRATO
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuCONTRATO in LDC_TIPO_VIVIENDA_CONT.CONTRATO%type
	)
	IS
		rcError styLDC_TIPO_VIVIENDA_CONT;
	BEGIN		rcError.CONTRATO:=inuCONTRATO;

		Load
		(
			inuCONTRATO
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
		inuCONTRATO in LDC_TIPO_VIVIENDA_CONT.CONTRATO%type
	)
	IS
	BEGIN
		Load
		(
			inuCONTRATO
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuCONTRATO in LDC_TIPO_VIVIENDA_CONT.CONTRATO%type,
		orcRecord out nocopy styLDC_TIPO_VIVIENDA_CONT
	)
	IS
		rcError styLDC_TIPO_VIVIENDA_CONT;
	BEGIN		rcError.CONTRATO:=inuCONTRATO;

		Load
		(
			inuCONTRATO
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuCONTRATO in LDC_TIPO_VIVIENDA_CONT.CONTRATO%type
	)
	RETURN styLDC_TIPO_VIVIENDA_CONT
	IS
		rcError styLDC_TIPO_VIVIENDA_CONT;
	BEGIN
		rcError.CONTRATO:=inuCONTRATO;

		Load
		(
			inuCONTRATO
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuCONTRATO in LDC_TIPO_VIVIENDA_CONT.CONTRATO%type
	)
	RETURN styLDC_TIPO_VIVIENDA_CONT
	IS
		rcError styLDC_TIPO_VIVIENDA_CONT;
	BEGIN
		rcError.CONTRATO:=inuCONTRATO;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuCONTRATO
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuCONTRATO
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_TIPO_VIVIENDA_CONT
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_TIPO_VIVIENDA_CONT
	)
	IS
		rfLDC_TIPO_VIVIENDA_CONT tyrfLDC_TIPO_VIVIENDA_CONT;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_TIPO_VIVIENDA_CONT.*, LDC_TIPO_VIVIENDA_CONT.rowid FROM LDC_TIPO_VIVIENDA_CONT';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_TIPO_VIVIENDA_CONT for sbFullQuery;

		fetch rfLDC_TIPO_VIVIENDA_CONT bulk collect INTO otbResult;

		close rfLDC_TIPO_VIVIENDA_CONT;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_TIPO_VIVIENDA_CONT.*, LDC_TIPO_VIVIENDA_CONT.rowid FROM LDC_TIPO_VIVIENDA_CONT';
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
		ircLDC_TIPO_VIVIENDA_CONT in styLDC_TIPO_VIVIENDA_CONT
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_TIPO_VIVIENDA_CONT,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_TIPO_VIVIENDA_CONT in styLDC_TIPO_VIVIENDA_CONT,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_TIPO_VIVIENDA_CONT.CONTRATO is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|CONTRATO');
			raise ex.controlled_error;
		end if;

		insert into LDC_TIPO_VIVIENDA_CONT
		(
			CONTRATO,
			TIPO_VIVIENDA,
			FECHA_REGISTRO,
			SOLICITUD
		)
		values
		(
			ircLDC_TIPO_VIVIENDA_CONT.CONTRATO,
			ircLDC_TIPO_VIVIENDA_CONT.TIPO_VIVIENDA,
			ircLDC_TIPO_VIVIENDA_CONT.FECHA_REGISTRO,
			ircLDC_TIPO_VIVIENDA_CONT.SOLICITUD
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_TIPO_VIVIENDA_CONT));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_TIPO_VIVIENDA_CONT in out nocopy tytbLDC_TIPO_VIVIENDA_CONT
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_TIPO_VIVIENDA_CONT,blUseRowID);
		forall n in iotbLDC_TIPO_VIVIENDA_CONT.first..iotbLDC_TIPO_VIVIENDA_CONT.last
			insert into LDC_TIPO_VIVIENDA_CONT
			(
				CONTRATO,
				TIPO_VIVIENDA,
				FECHA_REGISTRO,
				SOLICITUD
			)
			values
			(
				rcRecOfTab.CONTRATO(n),
				rcRecOfTab.TIPO_VIVIENDA(n),
				rcRecOfTab.FECHA_REGISTRO(n),
				rcRecOfTab.SOLICITUD(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuCONTRATO in LDC_TIPO_VIVIENDA_CONT.CONTRATO%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_TIPO_VIVIENDA_CONT;
	BEGIN
		rcError.CONTRATO := inuCONTRATO;

		if inuLock=1 then
			LockByPk
			(
				inuCONTRATO,
				rcData
			);
		end if;


		delete
		from LDC_TIPO_VIVIENDA_CONT
		where
       		CONTRATO=inuCONTRATO;
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
		rcError  styLDC_TIPO_VIVIENDA_CONT;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_TIPO_VIVIENDA_CONT
		where
			rowid = iriRowID
		returning
			CONTRATO
		into
			rcError.CONTRATO;
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
		iotbLDC_TIPO_VIVIENDA_CONT in out nocopy tytbLDC_TIPO_VIVIENDA_CONT,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_TIPO_VIVIENDA_CONT;
	BEGIN
		FillRecordOfTables(iotbLDC_TIPO_VIVIENDA_CONT, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_TIPO_VIVIENDA_CONT.first .. iotbLDC_TIPO_VIVIENDA_CONT.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_TIPO_VIVIENDA_CONT.first .. iotbLDC_TIPO_VIVIENDA_CONT.last
				delete
				from LDC_TIPO_VIVIENDA_CONT
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_TIPO_VIVIENDA_CONT.first .. iotbLDC_TIPO_VIVIENDA_CONT.last loop
					LockByPk
					(
						rcRecOfTab.CONTRATO(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_TIPO_VIVIENDA_CONT.first .. iotbLDC_TIPO_VIVIENDA_CONT.last
				delete
				from LDC_TIPO_VIVIENDA_CONT
				where
		         	CONTRATO = rcRecOfTab.CONTRATO(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_TIPO_VIVIENDA_CONT in styLDC_TIPO_VIVIENDA_CONT,
		inuLock in number default 0
	)
	IS
		nuCONTRATO	LDC_TIPO_VIVIENDA_CONT.CONTRATO%type;
	BEGIN
		if ircLDC_TIPO_VIVIENDA_CONT.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_TIPO_VIVIENDA_CONT.rowid,rcData);
			end if;
			update LDC_TIPO_VIVIENDA_CONT
			set
				TIPO_VIVIENDA = ircLDC_TIPO_VIVIENDA_CONT.TIPO_VIVIENDA,
				FECHA_REGISTRO = ircLDC_TIPO_VIVIENDA_CONT.FECHA_REGISTRO,
				SOLICITUD = ircLDC_TIPO_VIVIENDA_CONT.SOLICITUD
			where
				rowid = ircLDC_TIPO_VIVIENDA_CONT.rowid
			returning
				CONTRATO
			into
				nuCONTRATO;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_TIPO_VIVIENDA_CONT.CONTRATO,
					rcData
				);
			end if;

			update LDC_TIPO_VIVIENDA_CONT
			set
				TIPO_VIVIENDA = ircLDC_TIPO_VIVIENDA_CONT.TIPO_VIVIENDA,
				FECHA_REGISTRO = ircLDC_TIPO_VIVIENDA_CONT.FECHA_REGISTRO,
				SOLICITUD = ircLDC_TIPO_VIVIENDA_CONT.SOLICITUD
			where
				CONTRATO = ircLDC_TIPO_VIVIENDA_CONT.CONTRATO
			returning
				CONTRATO
			into
				nuCONTRATO;
		end if;
		if
			nuCONTRATO is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_TIPO_VIVIENDA_CONT));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_TIPO_VIVIENDA_CONT in out nocopy tytbLDC_TIPO_VIVIENDA_CONT,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_TIPO_VIVIENDA_CONT;
	BEGIN
		FillRecordOfTables(iotbLDC_TIPO_VIVIENDA_CONT,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_TIPO_VIVIENDA_CONT.first .. iotbLDC_TIPO_VIVIENDA_CONT.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_TIPO_VIVIENDA_CONT.first .. iotbLDC_TIPO_VIVIENDA_CONT.last
				update LDC_TIPO_VIVIENDA_CONT
				set
					TIPO_VIVIENDA = rcRecOfTab.TIPO_VIVIENDA(n),
					FECHA_REGISTRO = rcRecOfTab.FECHA_REGISTRO(n),
					SOLICITUD = rcRecOfTab.SOLICITUD(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_TIPO_VIVIENDA_CONT.first .. iotbLDC_TIPO_VIVIENDA_CONT.last loop
					LockByPk
					(
						rcRecOfTab.CONTRATO(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_TIPO_VIVIENDA_CONT.first .. iotbLDC_TIPO_VIVIENDA_CONT.last
				update LDC_TIPO_VIVIENDA_CONT
				SET
					TIPO_VIVIENDA = rcRecOfTab.TIPO_VIVIENDA(n),
					FECHA_REGISTRO = rcRecOfTab.FECHA_REGISTRO(n),
					SOLICITUD = rcRecOfTab.SOLICITUD(n)
				where
					CONTRATO = rcRecOfTab.CONTRATO(n)
;
		end if;
	END;
	PROCEDURE updTIPO_VIVIENDA
	(
		inuCONTRATO in LDC_TIPO_VIVIENDA_CONT.CONTRATO%type,
		inuTIPO_VIVIENDA$ in LDC_TIPO_VIVIENDA_CONT.TIPO_VIVIENDA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_TIPO_VIVIENDA_CONT;
	BEGIN
		rcError.CONTRATO := inuCONTRATO;
		if inuLock=1 then
			LockByPk
			(
				inuCONTRATO,
				rcData
			);
		end if;

		update LDC_TIPO_VIVIENDA_CONT
		set
			TIPO_VIVIENDA = inuTIPO_VIVIENDA$
		where
			CONTRATO = inuCONTRATO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TIPO_VIVIENDA:= inuTIPO_VIVIENDA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFECHA_REGISTRO
	(
		inuCONTRATO in LDC_TIPO_VIVIENDA_CONT.CONTRATO%type,
		idtFECHA_REGISTRO$ in LDC_TIPO_VIVIENDA_CONT.FECHA_REGISTRO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_TIPO_VIVIENDA_CONT;
	BEGIN
		rcError.CONTRATO := inuCONTRATO;
		if inuLock=1 then
			LockByPk
			(
				inuCONTRATO,
				rcData
			);
		end if;

		update LDC_TIPO_VIVIENDA_CONT
		set
			FECHA_REGISTRO = idtFECHA_REGISTRO$
		where
			CONTRATO = inuCONTRATO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FECHA_REGISTRO:= idtFECHA_REGISTRO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSOLICITUD
	(
		inuCONTRATO in LDC_TIPO_VIVIENDA_CONT.CONTRATO%type,
		inuSOLICITUD$ in LDC_TIPO_VIVIENDA_CONT.SOLICITUD%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_TIPO_VIVIENDA_CONT;
	BEGIN
		rcError.CONTRATO := inuCONTRATO;
		if inuLock=1 then
			LockByPk
			(
				inuCONTRATO,
				rcData
			);
		end if;

		update LDC_TIPO_VIVIENDA_CONT
		set
			SOLICITUD = inuSOLICITUD$
		where
			CONTRATO = inuCONTRATO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SOLICITUD:= inuSOLICITUD$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetCONTRATO
	(
		inuCONTRATO in LDC_TIPO_VIVIENDA_CONT.CONTRATO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPO_VIVIENDA_CONT.CONTRATO%type
	IS
		rcError styLDC_TIPO_VIVIENDA_CONT;
	BEGIN

		rcError.CONTRATO := inuCONTRATO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONTRATO
			 )
		then
			 return(rcData.CONTRATO);
		end if;
		Load
		(
		 		inuCONTRATO
		);
		return(rcData.CONTRATO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetTIPO_VIVIENDA
	(
		inuCONTRATO in LDC_TIPO_VIVIENDA_CONT.CONTRATO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPO_VIVIENDA_CONT.TIPO_VIVIENDA%type
	IS
		rcError styLDC_TIPO_VIVIENDA_CONT;
	BEGIN

		rcError.CONTRATO := inuCONTRATO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONTRATO
			 )
		then
			 return(rcData.TIPO_VIVIENDA);
		end if;
		Load
		(
		 		inuCONTRATO
		);
		return(rcData.TIPO_VIVIENDA);
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
		inuCONTRATO in LDC_TIPO_VIVIENDA_CONT.CONTRATO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPO_VIVIENDA_CONT.FECHA_REGISTRO%type
	IS
		rcError styLDC_TIPO_VIVIENDA_CONT;
	BEGIN

		rcError.CONTRATO := inuCONTRATO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONTRATO
			 )
		then
			 return(rcData.FECHA_REGISTRO);
		end if;
		Load
		(
		 		inuCONTRATO
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
	FUNCTION fnuGetSOLICITUD
	(
		inuCONTRATO in LDC_TIPO_VIVIENDA_CONT.CONTRATO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPO_VIVIENDA_CONT.SOLICITUD%type
	IS
		rcError styLDC_TIPO_VIVIENDA_CONT;
	BEGIN

		rcError.CONTRATO := inuCONTRATO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONTRATO
			 )
		then
			 return(rcData.SOLICITUD);
		end if;
		Load
		(
		 		inuCONTRATO
		);
		return(rcData.SOLICITUD);
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
end DALDC_TIPO_VIVIENDA_CONT;
/
PROMPT Otorgando permisos de ejecucion a DALDC_TIPO_VIVIENDA_CONT
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_TIPO_VIVIENDA_CONT', 'ADM_PERSON');
END;
/