CREATE OR REPLACE PACKAGE adm_person.daldc_varifacolo
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  11/06/2024   Adrianavg   OSF-2813: Migrar del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuFACTOR_ID in LDC_VARIFACOLO.FACTOR_ID%type
	)
	IS
		SELECT LDC_VARIFACOLO.*,LDC_VARIFACOLO.rowid
		FROM LDC_VARIFACOLO
		WHERE
		    FACTOR_ID = inuFACTOR_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_VARIFACOLO.*,LDC_VARIFACOLO.rowid
		FROM LDC_VARIFACOLO
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_VARIFACOLO  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_VARIFACOLO is table of styLDC_VARIFACOLO index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_VARIFACOLO;

	/* Tipos referenciando al registro */
	type tytbFACTOR_ID is table of LDC_VARIFACOLO.FACTOR_ID%type index by binary_integer;
	type tytbVARIABLE is table of LDC_VARIFACOLO.VARIABLE%type index by binary_integer;
	type tytbVALOR_VARIABLE is table of LDC_VARIFACOLO.VALOR_VARIABLE%type index by binary_integer;
	type tytbPROMEDIO_VARIABLE is table of LDC_VARIFACOLO.PROMEDIO_VARIABLE%type index by binary_integer;
	type tytbUBICACION_LOCALIDAD is table of LDC_VARIFACOLO.UBICACION_LOCALIDAD%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_VARIFACOLO is record
	(
		FACTOR_ID   tytbFACTOR_ID,
		VARIABLE   tytbVARIABLE,
		VALOR_VARIABLE   tytbVALOR_VARIABLE,
		PROMEDIO_VARIABLE   tytbPROMEDIO_VARIABLE,
		UBICACION_LOCALIDAD   tytbUBICACION_LOCALIDAD,
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
		inuFACTOR_ID in LDC_VARIFACOLO.FACTOR_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuFACTOR_ID in LDC_VARIFACOLO.FACTOR_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuFACTOR_ID in LDC_VARIFACOLO.FACTOR_ID%type
	);

	PROCEDURE getRecord
	(
		inuFACTOR_ID in LDC_VARIFACOLO.FACTOR_ID%type,
		orcRecord out nocopy styLDC_VARIFACOLO
	);

	FUNCTION frcGetRcData
	(
		inuFACTOR_ID in LDC_VARIFACOLO.FACTOR_ID%type
	)
	RETURN styLDC_VARIFACOLO;

	FUNCTION frcGetRcData
	RETURN styLDC_VARIFACOLO;

	FUNCTION frcGetRecord
	(
		inuFACTOR_ID in LDC_VARIFACOLO.FACTOR_ID%type
	)
	RETURN styLDC_VARIFACOLO;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_VARIFACOLO
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_VARIFACOLO in styLDC_VARIFACOLO
	);

	PROCEDURE insRecord
	(
		ircLDC_VARIFACOLO in styLDC_VARIFACOLO,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_VARIFACOLO in out nocopy tytbLDC_VARIFACOLO
	);

	PROCEDURE delRecord
	(
		inuFACTOR_ID in LDC_VARIFACOLO.FACTOR_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_VARIFACOLO in out nocopy tytbLDC_VARIFACOLO,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_VARIFACOLO in styLDC_VARIFACOLO,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_VARIFACOLO in out nocopy tytbLDC_VARIFACOLO,
		inuLock in number default 1
	);

	PROCEDURE updVARIABLE
	(
		inuFACTOR_ID in LDC_VARIFACOLO.FACTOR_ID%type,
		isbVARIABLE$ in LDC_VARIFACOLO.VARIABLE%type,
		inuLock in number default 0
	);

	PROCEDURE updVALOR_VARIABLE
	(
		inuFACTOR_ID in LDC_VARIFACOLO.FACTOR_ID%type,
		inuVALOR_VARIABLE$ in LDC_VARIFACOLO.VALOR_VARIABLE%type,
		inuLock in number default 0
	);

	PROCEDURE updPROMEDIO_VARIABLE
	(
		inuFACTOR_ID in LDC_VARIFACOLO.FACTOR_ID%type,
		inuPROMEDIO_VARIABLE$ in LDC_VARIFACOLO.PROMEDIO_VARIABLE%type,
		inuLock in number default 0
	);

	PROCEDURE updUBICACION_LOCALIDAD
	(
		inuFACTOR_ID in LDC_VARIFACOLO.FACTOR_ID%type,
		inuUBICACION_LOCALIDAD$ in LDC_VARIFACOLO.UBICACION_LOCALIDAD%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetFACTOR_ID
	(
		inuFACTOR_ID in LDC_VARIFACOLO.FACTOR_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VARIFACOLO.FACTOR_ID%type;

	FUNCTION fsbGetVARIABLE
	(
		inuFACTOR_ID in LDC_VARIFACOLO.FACTOR_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VARIFACOLO.VARIABLE%type;

	FUNCTION fnuGetVALOR_VARIABLE
	(
		inuFACTOR_ID in LDC_VARIFACOLO.FACTOR_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VARIFACOLO.VALOR_VARIABLE%type;

	FUNCTION fnuGetPROMEDIO_VARIABLE
	(
		inuFACTOR_ID in LDC_VARIFACOLO.FACTOR_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VARIFACOLO.PROMEDIO_VARIABLE%type;

	FUNCTION fnuGetUBICACION_LOCALIDAD
	(
		inuFACTOR_ID in LDC_VARIFACOLO.FACTOR_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VARIFACOLO.UBICACION_LOCALIDAD%type;


	PROCEDURE LockByPk
	(
		inuFACTOR_ID in LDC_VARIFACOLO.FACTOR_ID%type,
		orcLDC_VARIFACOLO  out styLDC_VARIFACOLO
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_VARIFACOLO  out styLDC_VARIFACOLO
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_VARIFACOLO;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALDC_VARIFACOLO
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_VARIFACOLO';
	 cnuGeEntityId constant varchar2(30) := 4719; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuFACTOR_ID in LDC_VARIFACOLO.FACTOR_ID%type
	)
	IS
		SELECT LDC_VARIFACOLO.*,LDC_VARIFACOLO.rowid
		FROM LDC_VARIFACOLO
		WHERE  FACTOR_ID = inuFACTOR_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_VARIFACOLO.*,LDC_VARIFACOLO.rowid
		FROM LDC_VARIFACOLO
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_VARIFACOLO is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_VARIFACOLO;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_VARIFACOLO default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.FACTOR_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuFACTOR_ID in LDC_VARIFACOLO.FACTOR_ID%type,
		orcLDC_VARIFACOLO  out styLDC_VARIFACOLO
	)
	IS
		rcError styLDC_VARIFACOLO;
	BEGIN
		rcError.FACTOR_ID := inuFACTOR_ID;

		Open cuLockRcByPk
		(
			inuFACTOR_ID
		);

		fetch cuLockRcByPk into orcLDC_VARIFACOLO;
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
		orcLDC_VARIFACOLO  out styLDC_VARIFACOLO
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_VARIFACOLO;
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
		itbLDC_VARIFACOLO  in out nocopy tytbLDC_VARIFACOLO
	)
	IS
	BEGIN
			rcRecOfTab.FACTOR_ID.delete;
			rcRecOfTab.VARIABLE.delete;
			rcRecOfTab.VALOR_VARIABLE.delete;
			rcRecOfTab.PROMEDIO_VARIABLE.delete;
			rcRecOfTab.UBICACION_LOCALIDAD.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_VARIFACOLO  in out nocopy tytbLDC_VARIFACOLO,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_VARIFACOLO);

		for n in itbLDC_VARIFACOLO.first .. itbLDC_VARIFACOLO.last loop
			rcRecOfTab.FACTOR_ID(n) := itbLDC_VARIFACOLO(n).FACTOR_ID;
			rcRecOfTab.VARIABLE(n) := itbLDC_VARIFACOLO(n).VARIABLE;
			rcRecOfTab.VALOR_VARIABLE(n) := itbLDC_VARIFACOLO(n).VALOR_VARIABLE;
			rcRecOfTab.PROMEDIO_VARIABLE(n) := itbLDC_VARIFACOLO(n).PROMEDIO_VARIABLE;
			rcRecOfTab.UBICACION_LOCALIDAD(n) := itbLDC_VARIFACOLO(n).UBICACION_LOCALIDAD;
			rcRecOfTab.row_id(n) := itbLDC_VARIFACOLO(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuFACTOR_ID in LDC_VARIFACOLO.FACTOR_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuFACTOR_ID
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
		inuFACTOR_ID in LDC_VARIFACOLO.FACTOR_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuFACTOR_ID = rcData.FACTOR_ID
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
		inuFACTOR_ID in LDC_VARIFACOLO.FACTOR_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuFACTOR_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuFACTOR_ID in LDC_VARIFACOLO.FACTOR_ID%type
	)
	IS
		rcError styLDC_VARIFACOLO;
	BEGIN		rcError.FACTOR_ID:=inuFACTOR_ID;

		Load
		(
			inuFACTOR_ID
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
		inuFACTOR_ID in LDC_VARIFACOLO.FACTOR_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuFACTOR_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuFACTOR_ID in LDC_VARIFACOLO.FACTOR_ID%type,
		orcRecord out nocopy styLDC_VARIFACOLO
	)
	IS
		rcError styLDC_VARIFACOLO;
	BEGIN		rcError.FACTOR_ID:=inuFACTOR_ID;

		Load
		(
			inuFACTOR_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuFACTOR_ID in LDC_VARIFACOLO.FACTOR_ID%type
	)
	RETURN styLDC_VARIFACOLO
	IS
		rcError styLDC_VARIFACOLO;
	BEGIN
		rcError.FACTOR_ID:=inuFACTOR_ID;

		Load
		(
			inuFACTOR_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuFACTOR_ID in LDC_VARIFACOLO.FACTOR_ID%type
	)
	RETURN styLDC_VARIFACOLO
	IS
		rcError styLDC_VARIFACOLO;
	BEGIN
		rcError.FACTOR_ID:=inuFACTOR_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuFACTOR_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuFACTOR_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_VARIFACOLO
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_VARIFACOLO
	)
	IS
		rfLDC_VARIFACOLO tyrfLDC_VARIFACOLO;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_VARIFACOLO.*, LDC_VARIFACOLO.rowid FROM LDC_VARIFACOLO';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_VARIFACOLO for sbFullQuery;

		fetch rfLDC_VARIFACOLO bulk collect INTO otbResult;

		close rfLDC_VARIFACOLO;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_VARIFACOLO.*, LDC_VARIFACOLO.rowid FROM LDC_VARIFACOLO';
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
		ircLDC_VARIFACOLO in styLDC_VARIFACOLO
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_VARIFACOLO,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_VARIFACOLO in styLDC_VARIFACOLO,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_VARIFACOLO.FACTOR_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|FACTOR_ID');
			raise ex.controlled_error;
		end if;

		insert into LDC_VARIFACOLO
		(
			FACTOR_ID,
			VARIABLE,
			VALOR_VARIABLE,
			PROMEDIO_VARIABLE,
			UBICACION_LOCALIDAD
		)
		values
		(
			ircLDC_VARIFACOLO.FACTOR_ID,
			ircLDC_VARIFACOLO.VARIABLE,
			ircLDC_VARIFACOLO.VALOR_VARIABLE,
			ircLDC_VARIFACOLO.PROMEDIO_VARIABLE,
			ircLDC_VARIFACOLO.UBICACION_LOCALIDAD
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_VARIFACOLO));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_VARIFACOLO in out nocopy tytbLDC_VARIFACOLO
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_VARIFACOLO,blUseRowID);
		forall n in iotbLDC_VARIFACOLO.first..iotbLDC_VARIFACOLO.last
			insert into LDC_VARIFACOLO
			(
				FACTOR_ID,
				VARIABLE,
				VALOR_VARIABLE,
				PROMEDIO_VARIABLE,
				UBICACION_LOCALIDAD
			)
			values
			(
				rcRecOfTab.FACTOR_ID(n),
				rcRecOfTab.VARIABLE(n),
				rcRecOfTab.VALOR_VARIABLE(n),
				rcRecOfTab.PROMEDIO_VARIABLE(n),
				rcRecOfTab.UBICACION_LOCALIDAD(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuFACTOR_ID in LDC_VARIFACOLO.FACTOR_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_VARIFACOLO;
	BEGIN
		rcError.FACTOR_ID := inuFACTOR_ID;

		if inuLock=1 then
			LockByPk
			(
				inuFACTOR_ID,
				rcData
			);
		end if;


		delete
		from LDC_VARIFACOLO
		where
       		FACTOR_ID=inuFACTOR_ID;
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
		rcError  styLDC_VARIFACOLO;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_VARIFACOLO
		where
			rowid = iriRowID
		returning
			FACTOR_ID
		into
			rcError.FACTOR_ID;
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
		iotbLDC_VARIFACOLO in out nocopy tytbLDC_VARIFACOLO,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_VARIFACOLO;
	BEGIN
		FillRecordOfTables(iotbLDC_VARIFACOLO, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_VARIFACOLO.first .. iotbLDC_VARIFACOLO.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_VARIFACOLO.first .. iotbLDC_VARIFACOLO.last
				delete
				from LDC_VARIFACOLO
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_VARIFACOLO.first .. iotbLDC_VARIFACOLO.last loop
					LockByPk
					(
						rcRecOfTab.FACTOR_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_VARIFACOLO.first .. iotbLDC_VARIFACOLO.last
				delete
				from LDC_VARIFACOLO
				where
		         	FACTOR_ID = rcRecOfTab.FACTOR_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_VARIFACOLO in styLDC_VARIFACOLO,
		inuLock in number default 0
	)
	IS
		nuFACTOR_ID	LDC_VARIFACOLO.FACTOR_ID%type;
	BEGIN
		if ircLDC_VARIFACOLO.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_VARIFACOLO.rowid,rcData);
			end if;
			update LDC_VARIFACOLO
			set
				VARIABLE = ircLDC_VARIFACOLO.VARIABLE,
				VALOR_VARIABLE = ircLDC_VARIFACOLO.VALOR_VARIABLE,
				PROMEDIO_VARIABLE = ircLDC_VARIFACOLO.PROMEDIO_VARIABLE,
				UBICACION_LOCALIDAD = ircLDC_VARIFACOLO.UBICACION_LOCALIDAD
			where
				rowid = ircLDC_VARIFACOLO.rowid
			returning
				FACTOR_ID
			into
				nuFACTOR_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_VARIFACOLO.FACTOR_ID,
					rcData
				);
			end if;

			update LDC_VARIFACOLO
			set
				VARIABLE = ircLDC_VARIFACOLO.VARIABLE,
				VALOR_VARIABLE = ircLDC_VARIFACOLO.VALOR_VARIABLE,
				PROMEDIO_VARIABLE = ircLDC_VARIFACOLO.PROMEDIO_VARIABLE,
				UBICACION_LOCALIDAD = ircLDC_VARIFACOLO.UBICACION_LOCALIDAD
			where
				FACTOR_ID = ircLDC_VARIFACOLO.FACTOR_ID
			returning
				FACTOR_ID
			into
				nuFACTOR_ID;
		end if;
		if
			nuFACTOR_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_VARIFACOLO));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_VARIFACOLO in out nocopy tytbLDC_VARIFACOLO,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_VARIFACOLO;
	BEGIN
		FillRecordOfTables(iotbLDC_VARIFACOLO,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_VARIFACOLO.first .. iotbLDC_VARIFACOLO.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_VARIFACOLO.first .. iotbLDC_VARIFACOLO.last
				update LDC_VARIFACOLO
				set
					VARIABLE = rcRecOfTab.VARIABLE(n),
					VALOR_VARIABLE = rcRecOfTab.VALOR_VARIABLE(n),
					PROMEDIO_VARIABLE = rcRecOfTab.PROMEDIO_VARIABLE(n),
					UBICACION_LOCALIDAD = rcRecOfTab.UBICACION_LOCALIDAD(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_VARIFACOLO.first .. iotbLDC_VARIFACOLO.last loop
					LockByPk
					(
						rcRecOfTab.FACTOR_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_VARIFACOLO.first .. iotbLDC_VARIFACOLO.last
				update LDC_VARIFACOLO
				SET
					VARIABLE = rcRecOfTab.VARIABLE(n),
					VALOR_VARIABLE = rcRecOfTab.VALOR_VARIABLE(n),
					PROMEDIO_VARIABLE = rcRecOfTab.PROMEDIO_VARIABLE(n),
					UBICACION_LOCALIDAD = rcRecOfTab.UBICACION_LOCALIDAD(n)
				where
					FACTOR_ID = rcRecOfTab.FACTOR_ID(n)
;
		end if;
	END;
	PROCEDURE updVARIABLE
	(
		inuFACTOR_ID in LDC_VARIFACOLO.FACTOR_ID%type,
		isbVARIABLE$ in LDC_VARIFACOLO.VARIABLE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_VARIFACOLO;
	BEGIN
		rcError.FACTOR_ID := inuFACTOR_ID;
		if inuLock=1 then
			LockByPk
			(
				inuFACTOR_ID,
				rcData
			);
		end if;

		update LDC_VARIFACOLO
		set
			VARIABLE = isbVARIABLE$
		where
			FACTOR_ID = inuFACTOR_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.VARIABLE:= isbVARIABLE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updVALOR_VARIABLE
	(
		inuFACTOR_ID in LDC_VARIFACOLO.FACTOR_ID%type,
		inuVALOR_VARIABLE$ in LDC_VARIFACOLO.VALOR_VARIABLE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_VARIFACOLO;
	BEGIN
		rcError.FACTOR_ID := inuFACTOR_ID;
		if inuLock=1 then
			LockByPk
			(
				inuFACTOR_ID,
				rcData
			);
		end if;

		update LDC_VARIFACOLO
		set
			VALOR_VARIABLE = inuVALOR_VARIABLE$
		where
			FACTOR_ID = inuFACTOR_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.VALOR_VARIABLE:= inuVALOR_VARIABLE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPROMEDIO_VARIABLE
	(
		inuFACTOR_ID in LDC_VARIFACOLO.FACTOR_ID%type,
		inuPROMEDIO_VARIABLE$ in LDC_VARIFACOLO.PROMEDIO_VARIABLE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_VARIFACOLO;
	BEGIN
		rcError.FACTOR_ID := inuFACTOR_ID;
		if inuLock=1 then
			LockByPk
			(
				inuFACTOR_ID,
				rcData
			);
		end if;

		update LDC_VARIFACOLO
		set
			PROMEDIO_VARIABLE = inuPROMEDIO_VARIABLE$
		where
			FACTOR_ID = inuFACTOR_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PROMEDIO_VARIABLE:= inuPROMEDIO_VARIABLE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updUBICACION_LOCALIDAD
	(
		inuFACTOR_ID in LDC_VARIFACOLO.FACTOR_ID%type,
		inuUBICACION_LOCALIDAD$ in LDC_VARIFACOLO.UBICACION_LOCALIDAD%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_VARIFACOLO;
	BEGIN
		rcError.FACTOR_ID := inuFACTOR_ID;
		if inuLock=1 then
			LockByPk
			(
				inuFACTOR_ID,
				rcData
			);
		end if;

		update LDC_VARIFACOLO
		set
			UBICACION_LOCALIDAD = inuUBICACION_LOCALIDAD$
		where
			FACTOR_ID = inuFACTOR_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.UBICACION_LOCALIDAD:= inuUBICACION_LOCALIDAD$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetFACTOR_ID
	(
		inuFACTOR_ID in LDC_VARIFACOLO.FACTOR_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VARIFACOLO.FACTOR_ID%type
	IS
		rcError styLDC_VARIFACOLO;
	BEGIN

		rcError.FACTOR_ID := inuFACTOR_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuFACTOR_ID
			 )
		then
			 return(rcData.FACTOR_ID);
		end if;
		Load
		(
		 		inuFACTOR_ID
		);
		return(rcData.FACTOR_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetVARIABLE
	(
		inuFACTOR_ID in LDC_VARIFACOLO.FACTOR_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VARIFACOLO.VARIABLE%type
	IS
		rcError styLDC_VARIFACOLO;
	BEGIN

		rcError.FACTOR_ID := inuFACTOR_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuFACTOR_ID
			 )
		then
			 return(rcData.VARIABLE);
		end if;
		Load
		(
		 		inuFACTOR_ID
		);
		return(rcData.VARIABLE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetVALOR_VARIABLE
	(
		inuFACTOR_ID in LDC_VARIFACOLO.FACTOR_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VARIFACOLO.VALOR_VARIABLE%type
	IS
		rcError styLDC_VARIFACOLO;
	BEGIN

		rcError.FACTOR_ID := inuFACTOR_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuFACTOR_ID
			 )
		then
			 return(rcData.VALOR_VARIABLE);
		end if;
		Load
		(
		 		inuFACTOR_ID
		);
		return(rcData.VALOR_VARIABLE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetPROMEDIO_VARIABLE
	(
		inuFACTOR_ID in LDC_VARIFACOLO.FACTOR_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VARIFACOLO.PROMEDIO_VARIABLE%type
	IS
		rcError styLDC_VARIFACOLO;
	BEGIN

		rcError.FACTOR_ID := inuFACTOR_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuFACTOR_ID
			 )
		then
			 return(rcData.PROMEDIO_VARIABLE);
		end if;
		Load
		(
		 		inuFACTOR_ID
		);
		return(rcData.PROMEDIO_VARIABLE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetUBICACION_LOCALIDAD
	(
		inuFACTOR_ID in LDC_VARIFACOLO.FACTOR_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VARIFACOLO.UBICACION_LOCALIDAD%type
	IS
		rcError styLDC_VARIFACOLO;
	BEGIN

		rcError.FACTOR_ID := inuFACTOR_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuFACTOR_ID
			 )
		then
			 return(rcData.UBICACION_LOCALIDAD);
		end if;
		Load
		(
		 		inuFACTOR_ID
		);
		return(rcData.UBICACION_LOCALIDAD);
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
end DALDC_VARIFACOLO;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALDC_VARIFACOLO
BEGIN
    pkg_utilidades.prAplicarPermisos('DALDC_VARIFACOLO', 'ADM_PERSON'); 
END;
/

