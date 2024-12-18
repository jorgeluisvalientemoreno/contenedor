CREATE OR REPLACE PACKAGE ADM_PERSON.DALDC_TASKACTCOSTPROM
is
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     : DALDC_TASKACTCOSTPROM
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
		inuID_REGISTRO in LDC_TASKACTCOSTPROM.ID_REGISTRO%type
	)
	IS
		SELECT LDC_TASKACTCOSTPROM.*,LDC_TASKACTCOSTPROM.rowid
		FROM LDC_TASKACTCOSTPROM
		WHERE
		    ID_REGISTRO = inuID_REGISTRO;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_TASKACTCOSTPROM.*,LDC_TASKACTCOSTPROM.rowid
		FROM LDC_TASKACTCOSTPROM
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_TASKACTCOSTPROM  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_TASKACTCOSTPROM is table of styLDC_TASKACTCOSTPROM index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_TASKACTCOSTPROM;

	/* Tipos referenciando al registro */
	type tytbID_REGISTRO is table of LDC_TASKACTCOSTPROM.ID_REGISTRO%type index by binary_integer;
	type tytbTIPO_TRAB is table of LDC_TASKACTCOSTPROM.TIPO_TRAB%type index by binary_integer;
	type tytbACTIVIDAD is table of LDC_TASKACTCOSTPROM.ACTIVIDAD%type index by binary_integer;
	type tytbCOSTO_PROM is table of LDC_TASKACTCOSTPROM.COSTO_PROM%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_TASKACTCOSTPROM is record
	(
		ID_REGISTRO   tytbID_REGISTRO,
		TIPO_TRAB   tytbTIPO_TRAB,
		ACTIVIDAD   tytbACTIVIDAD,
		COSTO_PROM   tytbCOSTO_PROM,
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
		inuID_REGISTRO in LDC_TASKACTCOSTPROM.ID_REGISTRO%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuID_REGISTRO in LDC_TASKACTCOSTPROM.ID_REGISTRO%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuID_REGISTRO in LDC_TASKACTCOSTPROM.ID_REGISTRO%type
	);

	PROCEDURE getRecord
	(
		inuID_REGISTRO in LDC_TASKACTCOSTPROM.ID_REGISTRO%type,
		orcRecord out nocopy styLDC_TASKACTCOSTPROM
	);

	FUNCTION frcGetRcData
	(
		inuID_REGISTRO in LDC_TASKACTCOSTPROM.ID_REGISTRO%type
	)
	RETURN styLDC_TASKACTCOSTPROM;

	FUNCTION frcGetRcData
	RETURN styLDC_TASKACTCOSTPROM;

	FUNCTION frcGetRecord
	(
		inuID_REGISTRO in LDC_TASKACTCOSTPROM.ID_REGISTRO%type
	)
	RETURN styLDC_TASKACTCOSTPROM;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_TASKACTCOSTPROM
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_TASKACTCOSTPROM in styLDC_TASKACTCOSTPROM
	);

	PROCEDURE insRecord
	(
		ircLDC_TASKACTCOSTPROM in styLDC_TASKACTCOSTPROM,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_TASKACTCOSTPROM in out nocopy tytbLDC_TASKACTCOSTPROM
	);

	PROCEDURE delRecord
	(
		inuID_REGISTRO in LDC_TASKACTCOSTPROM.ID_REGISTRO%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_TASKACTCOSTPROM in out nocopy tytbLDC_TASKACTCOSTPROM,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_TASKACTCOSTPROM in styLDC_TASKACTCOSTPROM,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_TASKACTCOSTPROM in out nocopy tytbLDC_TASKACTCOSTPROM,
		inuLock in number default 1
	);

	PROCEDURE updTIPO_TRAB
	(
		inuID_REGISTRO in LDC_TASKACTCOSTPROM.ID_REGISTRO%type,
		inuTIPO_TRAB$ in LDC_TASKACTCOSTPROM.TIPO_TRAB%type,
		inuLock in number default 0
	);

	PROCEDURE updACTIVIDAD
	(
		inuID_REGISTRO in LDC_TASKACTCOSTPROM.ID_REGISTRO%type,
		inuACTIVIDAD$ in LDC_TASKACTCOSTPROM.ACTIVIDAD%type,
		inuLock in number default 0
	);

	PROCEDURE updCOSTO_PROM
	(
		inuID_REGISTRO in LDC_TASKACTCOSTPROM.ID_REGISTRO%type,
		inuCOSTO_PROM$ in LDC_TASKACTCOSTPROM.COSTO_PROM%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetID_REGISTRO
	(
		inuID_REGISTRO in LDC_TASKACTCOSTPROM.ID_REGISTRO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TASKACTCOSTPROM.ID_REGISTRO%type;

	FUNCTION fnuGetTIPO_TRAB
	(
		inuID_REGISTRO in LDC_TASKACTCOSTPROM.ID_REGISTRO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TASKACTCOSTPROM.TIPO_TRAB%type;

	FUNCTION fnuGetACTIVIDAD
	(
		inuID_REGISTRO in LDC_TASKACTCOSTPROM.ID_REGISTRO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TASKACTCOSTPROM.ACTIVIDAD%type;

	FUNCTION fnuGetCOSTO_PROM
	(
		inuID_REGISTRO in LDC_TASKACTCOSTPROM.ID_REGISTRO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TASKACTCOSTPROM.COSTO_PROM%type;


	PROCEDURE LockByPk
	(
		inuID_REGISTRO in LDC_TASKACTCOSTPROM.ID_REGISTRO%type,
		orcLDC_TASKACTCOSTPROM  out styLDC_TASKACTCOSTPROM
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_TASKACTCOSTPROM  out styLDC_TASKACTCOSTPROM
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_TASKACTCOSTPROM;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALDC_TASKACTCOSTPROM
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO1';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_TASKACTCOSTPROM';
	 cnuGeEntityId constant varchar2(30) := 4862; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuID_REGISTRO in LDC_TASKACTCOSTPROM.ID_REGISTRO%type
	)
	IS
		SELECT LDC_TASKACTCOSTPROM.*,LDC_TASKACTCOSTPROM.rowid
		FROM LDC_TASKACTCOSTPROM
		WHERE  ID_REGISTRO = inuID_REGISTRO
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_TASKACTCOSTPROM.*,LDC_TASKACTCOSTPROM.rowid
		FROM LDC_TASKACTCOSTPROM
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_TASKACTCOSTPROM is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_TASKACTCOSTPROM;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_TASKACTCOSTPROM default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.ID_REGISTRO);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuID_REGISTRO in LDC_TASKACTCOSTPROM.ID_REGISTRO%type,
		orcLDC_TASKACTCOSTPROM  out styLDC_TASKACTCOSTPROM
	)
	IS
		rcError styLDC_TASKACTCOSTPROM;
	BEGIN
		rcError.ID_REGISTRO := inuID_REGISTRO;

		Open cuLockRcByPk
		(
			inuID_REGISTRO
		);

		fetch cuLockRcByPk into orcLDC_TASKACTCOSTPROM;
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
		orcLDC_TASKACTCOSTPROM  out styLDC_TASKACTCOSTPROM
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_TASKACTCOSTPROM;
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
		itbLDC_TASKACTCOSTPROM  in out nocopy tytbLDC_TASKACTCOSTPROM
	)
	IS
	BEGIN
			rcRecOfTab.ID_REGISTRO.delete;
			rcRecOfTab.TIPO_TRAB.delete;
			rcRecOfTab.ACTIVIDAD.delete;
			rcRecOfTab.COSTO_PROM.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_TASKACTCOSTPROM  in out nocopy tytbLDC_TASKACTCOSTPROM,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_TASKACTCOSTPROM);

		for n in itbLDC_TASKACTCOSTPROM.first .. itbLDC_TASKACTCOSTPROM.last loop
			rcRecOfTab.ID_REGISTRO(n) := itbLDC_TASKACTCOSTPROM(n).ID_REGISTRO;
			rcRecOfTab.TIPO_TRAB(n) := itbLDC_TASKACTCOSTPROM(n).TIPO_TRAB;
			rcRecOfTab.ACTIVIDAD(n) := itbLDC_TASKACTCOSTPROM(n).ACTIVIDAD;
			rcRecOfTab.COSTO_PROM(n) := itbLDC_TASKACTCOSTPROM(n).COSTO_PROM;
			rcRecOfTab.row_id(n) := itbLDC_TASKACTCOSTPROM(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuID_REGISTRO in LDC_TASKACTCOSTPROM.ID_REGISTRO%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuID_REGISTRO
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
		inuID_REGISTRO in LDC_TASKACTCOSTPROM.ID_REGISTRO%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuID_REGISTRO = rcData.ID_REGISTRO
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
		inuID_REGISTRO in LDC_TASKACTCOSTPROM.ID_REGISTRO%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuID_REGISTRO
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuID_REGISTRO in LDC_TASKACTCOSTPROM.ID_REGISTRO%type
	)
	IS
		rcError styLDC_TASKACTCOSTPROM;
	BEGIN		rcError.ID_REGISTRO:=inuID_REGISTRO;

		Load
		(
			inuID_REGISTRO
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
		inuID_REGISTRO in LDC_TASKACTCOSTPROM.ID_REGISTRO%type
	)
	IS
	BEGIN
		Load
		(
			inuID_REGISTRO
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuID_REGISTRO in LDC_TASKACTCOSTPROM.ID_REGISTRO%type,
		orcRecord out nocopy styLDC_TASKACTCOSTPROM
	)
	IS
		rcError styLDC_TASKACTCOSTPROM;
	BEGIN		rcError.ID_REGISTRO:=inuID_REGISTRO;

		Load
		(
			inuID_REGISTRO
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuID_REGISTRO in LDC_TASKACTCOSTPROM.ID_REGISTRO%type
	)
	RETURN styLDC_TASKACTCOSTPROM
	IS
		rcError styLDC_TASKACTCOSTPROM;
	BEGIN
		rcError.ID_REGISTRO:=inuID_REGISTRO;

		Load
		(
			inuID_REGISTRO
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuID_REGISTRO in LDC_TASKACTCOSTPROM.ID_REGISTRO%type
	)
	RETURN styLDC_TASKACTCOSTPROM
	IS
		rcError styLDC_TASKACTCOSTPROM;
	BEGIN
		rcError.ID_REGISTRO:=inuID_REGISTRO;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuID_REGISTRO
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuID_REGISTRO
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_TASKACTCOSTPROM
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_TASKACTCOSTPROM
	)
	IS
		rfLDC_TASKACTCOSTPROM tyrfLDC_TASKACTCOSTPROM;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_TASKACTCOSTPROM.*, LDC_TASKACTCOSTPROM.rowid FROM LDC_TASKACTCOSTPROM';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_TASKACTCOSTPROM for sbFullQuery;

		fetch rfLDC_TASKACTCOSTPROM bulk collect INTO otbResult;

		close rfLDC_TASKACTCOSTPROM;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_TASKACTCOSTPROM.*, LDC_TASKACTCOSTPROM.rowid FROM LDC_TASKACTCOSTPROM';
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
		ircLDC_TASKACTCOSTPROM in styLDC_TASKACTCOSTPROM
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_TASKACTCOSTPROM,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_TASKACTCOSTPROM in styLDC_TASKACTCOSTPROM,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_TASKACTCOSTPROM.ID_REGISTRO is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ID_REGISTRO');
			raise ex.controlled_error;
		end if;

		insert into LDC_TASKACTCOSTPROM
		(
			ID_REGISTRO,
			TIPO_TRAB,
			ACTIVIDAD,
			COSTO_PROM
		)
		values
		(
			ircLDC_TASKACTCOSTPROM.ID_REGISTRO,
			ircLDC_TASKACTCOSTPROM.TIPO_TRAB,
			ircLDC_TASKACTCOSTPROM.ACTIVIDAD,
			ircLDC_TASKACTCOSTPROM.COSTO_PROM
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_TASKACTCOSTPROM));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_TASKACTCOSTPROM in out nocopy tytbLDC_TASKACTCOSTPROM
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_TASKACTCOSTPROM,blUseRowID);
		forall n in iotbLDC_TASKACTCOSTPROM.first..iotbLDC_TASKACTCOSTPROM.last
			insert into LDC_TASKACTCOSTPROM
			(
				ID_REGISTRO,
				TIPO_TRAB,
				ACTIVIDAD,
				COSTO_PROM
			)
			values
			(
				rcRecOfTab.ID_REGISTRO(n),
				rcRecOfTab.TIPO_TRAB(n),
				rcRecOfTab.ACTIVIDAD(n),
				rcRecOfTab.COSTO_PROM(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuID_REGISTRO in LDC_TASKACTCOSTPROM.ID_REGISTRO%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_TASKACTCOSTPROM;
	BEGIN
		rcError.ID_REGISTRO := inuID_REGISTRO;

		if inuLock=1 then
			LockByPk
			(
				inuID_REGISTRO,
				rcData
			);
		end if;


		delete
		from LDC_TASKACTCOSTPROM
		where
       		ID_REGISTRO=inuID_REGISTRO;
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
		rcError  styLDC_TASKACTCOSTPROM;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_TASKACTCOSTPROM
		where
			rowid = iriRowID
		returning
			ID_REGISTRO
		into
			rcError.ID_REGISTRO;
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
		iotbLDC_TASKACTCOSTPROM in out nocopy tytbLDC_TASKACTCOSTPROM,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_TASKACTCOSTPROM;
	BEGIN
		FillRecordOfTables(iotbLDC_TASKACTCOSTPROM, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_TASKACTCOSTPROM.first .. iotbLDC_TASKACTCOSTPROM.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_TASKACTCOSTPROM.first .. iotbLDC_TASKACTCOSTPROM.last
				delete
				from LDC_TASKACTCOSTPROM
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_TASKACTCOSTPROM.first .. iotbLDC_TASKACTCOSTPROM.last loop
					LockByPk
					(
						rcRecOfTab.ID_REGISTRO(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_TASKACTCOSTPROM.first .. iotbLDC_TASKACTCOSTPROM.last
				delete
				from LDC_TASKACTCOSTPROM
				where
		         	ID_REGISTRO = rcRecOfTab.ID_REGISTRO(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_TASKACTCOSTPROM in styLDC_TASKACTCOSTPROM,
		inuLock in number default 0
	)
	IS
		nuID_REGISTRO	LDC_TASKACTCOSTPROM.ID_REGISTRO%type;
	BEGIN
		if ircLDC_TASKACTCOSTPROM.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_TASKACTCOSTPROM.rowid,rcData);
			end if;
			update LDC_TASKACTCOSTPROM
			set
				TIPO_TRAB = ircLDC_TASKACTCOSTPROM.TIPO_TRAB,
				ACTIVIDAD = ircLDC_TASKACTCOSTPROM.ACTIVIDAD,
				COSTO_PROM = ircLDC_TASKACTCOSTPROM.COSTO_PROM
			where
				rowid = ircLDC_TASKACTCOSTPROM.rowid
			returning
				ID_REGISTRO
			into
				nuID_REGISTRO;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_TASKACTCOSTPROM.ID_REGISTRO,
					rcData
				);
			end if;

			update LDC_TASKACTCOSTPROM
			set
				TIPO_TRAB = ircLDC_TASKACTCOSTPROM.TIPO_TRAB,
				ACTIVIDAD = ircLDC_TASKACTCOSTPROM.ACTIVIDAD,
				COSTO_PROM = ircLDC_TASKACTCOSTPROM.COSTO_PROM
			where
				ID_REGISTRO = ircLDC_TASKACTCOSTPROM.ID_REGISTRO
			returning
				ID_REGISTRO
			into
				nuID_REGISTRO;
		end if;
		if
			nuID_REGISTRO is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_TASKACTCOSTPROM));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_TASKACTCOSTPROM in out nocopy tytbLDC_TASKACTCOSTPROM,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_TASKACTCOSTPROM;
	BEGIN
		FillRecordOfTables(iotbLDC_TASKACTCOSTPROM,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_TASKACTCOSTPROM.first .. iotbLDC_TASKACTCOSTPROM.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_TASKACTCOSTPROM.first .. iotbLDC_TASKACTCOSTPROM.last
				update LDC_TASKACTCOSTPROM
				set
					TIPO_TRAB = rcRecOfTab.TIPO_TRAB(n),
					ACTIVIDAD = rcRecOfTab.ACTIVIDAD(n),
					COSTO_PROM = rcRecOfTab.COSTO_PROM(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_TASKACTCOSTPROM.first .. iotbLDC_TASKACTCOSTPROM.last loop
					LockByPk
					(
						rcRecOfTab.ID_REGISTRO(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_TASKACTCOSTPROM.first .. iotbLDC_TASKACTCOSTPROM.last
				update LDC_TASKACTCOSTPROM
				SET
					TIPO_TRAB = rcRecOfTab.TIPO_TRAB(n),
					ACTIVIDAD = rcRecOfTab.ACTIVIDAD(n),
					COSTO_PROM = rcRecOfTab.COSTO_PROM(n)
				where
					ID_REGISTRO = rcRecOfTab.ID_REGISTRO(n)
;
		end if;
	END;
	PROCEDURE updTIPO_TRAB
	(
		inuID_REGISTRO in LDC_TASKACTCOSTPROM.ID_REGISTRO%type,
		inuTIPO_TRAB$ in LDC_TASKACTCOSTPROM.TIPO_TRAB%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_TASKACTCOSTPROM;
	BEGIN
		rcError.ID_REGISTRO := inuID_REGISTRO;
		if inuLock=1 then
			LockByPk
			(
				inuID_REGISTRO,
				rcData
			);
		end if;

		update LDC_TASKACTCOSTPROM
		set
			TIPO_TRAB = inuTIPO_TRAB$
		where
			ID_REGISTRO = inuID_REGISTRO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TIPO_TRAB:= inuTIPO_TRAB$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updACTIVIDAD
	(
		inuID_REGISTRO in LDC_TASKACTCOSTPROM.ID_REGISTRO%type,
		inuACTIVIDAD$ in LDC_TASKACTCOSTPROM.ACTIVIDAD%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_TASKACTCOSTPROM;
	BEGIN
		rcError.ID_REGISTRO := inuID_REGISTRO;
		if inuLock=1 then
			LockByPk
			(
				inuID_REGISTRO,
				rcData
			);
		end if;

		update LDC_TASKACTCOSTPROM
		set
			ACTIVIDAD = inuACTIVIDAD$
		where
			ID_REGISTRO = inuID_REGISTRO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ACTIVIDAD:= inuACTIVIDAD$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCOSTO_PROM
	(
		inuID_REGISTRO in LDC_TASKACTCOSTPROM.ID_REGISTRO%type,
		inuCOSTO_PROM$ in LDC_TASKACTCOSTPROM.COSTO_PROM%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_TASKACTCOSTPROM;
	BEGIN
		rcError.ID_REGISTRO := inuID_REGISTRO;
		if inuLock=1 then
			LockByPk
			(
				inuID_REGISTRO,
				rcData
			);
		end if;

		update LDC_TASKACTCOSTPROM
		set
			COSTO_PROM = inuCOSTO_PROM$
		where
			ID_REGISTRO = inuID_REGISTRO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.COSTO_PROM:= inuCOSTO_PROM$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetID_REGISTRO
	(
		inuID_REGISTRO in LDC_TASKACTCOSTPROM.ID_REGISTRO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TASKACTCOSTPROM.ID_REGISTRO%type
	IS
		rcError styLDC_TASKACTCOSTPROM;
	BEGIN

		rcError.ID_REGISTRO := inuID_REGISTRO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_REGISTRO
			 )
		then
			 return(rcData.ID_REGISTRO);
		end if;
		Load
		(
		 		inuID_REGISTRO
		);
		return(rcData.ID_REGISTRO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetTIPO_TRAB
	(
		inuID_REGISTRO in LDC_TASKACTCOSTPROM.ID_REGISTRO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TASKACTCOSTPROM.TIPO_TRAB%type
	IS
		rcError styLDC_TASKACTCOSTPROM;
	BEGIN

		rcError.ID_REGISTRO := inuID_REGISTRO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_REGISTRO
			 )
		then
			 return(rcData.TIPO_TRAB);
		end if;
		Load
		(
		 		inuID_REGISTRO
		);
		return(rcData.TIPO_TRAB);
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
		inuID_REGISTRO in LDC_TASKACTCOSTPROM.ID_REGISTRO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TASKACTCOSTPROM.ACTIVIDAD%type
	IS
		rcError styLDC_TASKACTCOSTPROM;
	BEGIN

		rcError.ID_REGISTRO := inuID_REGISTRO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_REGISTRO
			 )
		then
			 return(rcData.ACTIVIDAD);
		end if;
		Load
		(
		 		inuID_REGISTRO
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
	FUNCTION fnuGetCOSTO_PROM
	(
		inuID_REGISTRO in LDC_TASKACTCOSTPROM.ID_REGISTRO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TASKACTCOSTPROM.COSTO_PROM%type
	IS
		rcError styLDC_TASKACTCOSTPROM;
	BEGIN

		rcError.ID_REGISTRO := inuID_REGISTRO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_REGISTRO
			 )
		then
			 return(rcData.COSTO_PROM);
		end if;
		Load
		(
		 		inuID_REGISTRO
		);
		return(rcData.COSTO_PROM);
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
end DALDC_TASKACTCOSTPROM;
/
PROMPT Otorgando permisos de ejecucion a DALDC_TASKACTCOSTPROM
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_TASKACTCOSTPROM', 'ADM_PERSON');
END;
/