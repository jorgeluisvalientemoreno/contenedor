CREATE OR REPLACE PACKAGE adm_person.daldc_validacion_actividades
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  11/06/2024   Adrianavg   OSF-2813: Migrar del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuID in LDC_VALIDACION_ACTIVIDADES.ID%type
	)
	IS
		SELECT LDC_VALIDACION_ACTIVIDADES.*,LDC_VALIDACION_ACTIVIDADES.rowid
		FROM LDC_VALIDACION_ACTIVIDADES
		WHERE
		    ID = inuID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_VALIDACION_ACTIVIDADES.*,LDC_VALIDACION_ACTIVIDADES.rowid
		FROM LDC_VALIDACION_ACTIVIDADES
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_VALIDACION_ACTIVIDADES  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_VALIDACION_ACTIVIDADES is table of styLDC_VALIDACION_ACTIVIDADES index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_VALIDACION_ACTIVIDADES;

	/* Tipos referenciando al registro */
	type tytbTIPO_PRODUCTO is table of LDC_VALIDACION_ACTIVIDADES.TIPO_PRODUCTO%type index by binary_integer;
	type tytbACTIVIDAD is table of LDC_VALIDACION_ACTIVIDADES.ACTIVIDAD%type index by binary_integer;
	type tytbVALIDACION is table of LDC_VALIDACION_ACTIVIDADES.VALIDACION%type index by binary_integer;
	type tytbID is table of LDC_VALIDACION_ACTIVIDADES.ID%type index by binary_integer;
	type tytbNIVEL_REGISTRO is table of LDC_VALIDACION_ACTIVIDADES.NIVEL_REGISTRO%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_VALIDACION_ACTIVIDADES is record
	(
		TIPO_PRODUCTO   tytbTIPO_PRODUCTO,
		ACTIVIDAD   tytbACTIVIDAD,
		VALIDACION   tytbVALIDACION,
		ID   tytbID,
		NIVEL_REGISTRO   tytbNIVEL_REGISTRO,
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
		inuID in LDC_VALIDACION_ACTIVIDADES.ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuID in LDC_VALIDACION_ACTIVIDADES.ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuID in LDC_VALIDACION_ACTIVIDADES.ID%type
	);

	PROCEDURE getRecord
	(
		inuID in LDC_VALIDACION_ACTIVIDADES.ID%type,
		orcRecord out nocopy styLDC_VALIDACION_ACTIVIDADES
	);

	FUNCTION frcGetRcData
	(
		inuID in LDC_VALIDACION_ACTIVIDADES.ID%type
	)
	RETURN styLDC_VALIDACION_ACTIVIDADES;

	FUNCTION frcGetRcData
	RETURN styLDC_VALIDACION_ACTIVIDADES;

	FUNCTION frcGetRecord
	(
		inuID in LDC_VALIDACION_ACTIVIDADES.ID%type
	)
	RETURN styLDC_VALIDACION_ACTIVIDADES;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_VALIDACION_ACTIVIDADES
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_VALIDACION_ACTIVIDADES in styLDC_VALIDACION_ACTIVIDADES
	);

	PROCEDURE insRecord
	(
		ircLDC_VALIDACION_ACTIVIDADES in styLDC_VALIDACION_ACTIVIDADES,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_VALIDACION_ACTIVIDADES in out nocopy tytbLDC_VALIDACION_ACTIVIDADES
	);

	PROCEDURE delRecord
	(
		inuID in LDC_VALIDACION_ACTIVIDADES.ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_VALIDACION_ACTIVIDADES in out nocopy tytbLDC_VALIDACION_ACTIVIDADES,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_VALIDACION_ACTIVIDADES in styLDC_VALIDACION_ACTIVIDADES,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_VALIDACION_ACTIVIDADES in out nocopy tytbLDC_VALIDACION_ACTIVIDADES,
		inuLock in number default 1
	);

	PROCEDURE updTIPO_PRODUCTO
	(
		inuID in LDC_VALIDACION_ACTIVIDADES.ID%type,
		inuTIPO_PRODUCTO$ in LDC_VALIDACION_ACTIVIDADES.TIPO_PRODUCTO%type,
		inuLock in number default 0
	);

	PROCEDURE updACTIVIDAD
	(
		inuID in LDC_VALIDACION_ACTIVIDADES.ID%type,
		inuACTIVIDAD$ in LDC_VALIDACION_ACTIVIDADES.ACTIVIDAD%type,
		inuLock in number default 0
	);

	PROCEDURE updVALIDACION
	(
		inuID in LDC_VALIDACION_ACTIVIDADES.ID%type,
		inuVALIDACION$ in LDC_VALIDACION_ACTIVIDADES.VALIDACION%type,
		inuLock in number default 0
	);

	PROCEDURE updNIVEL_REGISTRO
	(
		inuID in LDC_VALIDACION_ACTIVIDADES.ID%type,
		isbNIVEL_REGISTRO$ in LDC_VALIDACION_ACTIVIDADES.NIVEL_REGISTRO%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetTIPO_PRODUCTO
	(
		inuID in LDC_VALIDACION_ACTIVIDADES.ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VALIDACION_ACTIVIDADES.TIPO_PRODUCTO%type;

	FUNCTION fnuGetACTIVIDAD
	(
		inuID in LDC_VALIDACION_ACTIVIDADES.ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VALIDACION_ACTIVIDADES.ACTIVIDAD%type;

	FUNCTION fnuGetVALIDACION
	(
		inuID in LDC_VALIDACION_ACTIVIDADES.ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VALIDACION_ACTIVIDADES.VALIDACION%type;

	FUNCTION fnuGetID
	(
		inuID in LDC_VALIDACION_ACTIVIDADES.ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VALIDACION_ACTIVIDADES.ID%type;

	FUNCTION fsbGetNIVEL_REGISTRO
	(
		inuID in LDC_VALIDACION_ACTIVIDADES.ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VALIDACION_ACTIVIDADES.NIVEL_REGISTRO%type;


	PROCEDURE LockByPk
	(
		inuID in LDC_VALIDACION_ACTIVIDADES.ID%type,
		orcLDC_VALIDACION_ACTIVIDADES  out styLDC_VALIDACION_ACTIVIDADES
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_VALIDACION_ACTIVIDADES  out styLDC_VALIDACION_ACTIVIDADES
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_VALIDACION_ACTIVIDADES;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALDC_VALIDACION_ACTIVIDADES
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_VALIDACION_ACTIVIDADES';
	 cnuGeEntityId constant varchar2(30) := 2388; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuID in LDC_VALIDACION_ACTIVIDADES.ID%type
	)
	IS
		SELECT LDC_VALIDACION_ACTIVIDADES.*,LDC_VALIDACION_ACTIVIDADES.rowid
		FROM LDC_VALIDACION_ACTIVIDADES
		WHERE  ID = inuID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_VALIDACION_ACTIVIDADES.*,LDC_VALIDACION_ACTIVIDADES.rowid
		FROM LDC_VALIDACION_ACTIVIDADES
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_VALIDACION_ACTIVIDADES is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_VALIDACION_ACTIVIDADES;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_VALIDACION_ACTIVIDADES default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuID in LDC_VALIDACION_ACTIVIDADES.ID%type,
		orcLDC_VALIDACION_ACTIVIDADES  out styLDC_VALIDACION_ACTIVIDADES
	)
	IS
		rcError styLDC_VALIDACION_ACTIVIDADES;
	BEGIN
		rcError.ID := inuID;

		Open cuLockRcByPk
		(
			inuID
		);

		fetch cuLockRcByPk into orcLDC_VALIDACION_ACTIVIDADES;
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
		orcLDC_VALIDACION_ACTIVIDADES  out styLDC_VALIDACION_ACTIVIDADES
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_VALIDACION_ACTIVIDADES;
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
		itbLDC_VALIDACION_ACTIVIDADES  in out nocopy tytbLDC_VALIDACION_ACTIVIDADES
	)
	IS
	BEGIN
			rcRecOfTab.TIPO_PRODUCTO.delete;
			rcRecOfTab.ACTIVIDAD.delete;
			rcRecOfTab.VALIDACION.delete;
			rcRecOfTab.ID.delete;
			rcRecOfTab.NIVEL_REGISTRO.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_VALIDACION_ACTIVIDADES  in out nocopy tytbLDC_VALIDACION_ACTIVIDADES,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_VALIDACION_ACTIVIDADES);

		for n in itbLDC_VALIDACION_ACTIVIDADES.first .. itbLDC_VALIDACION_ACTIVIDADES.last loop
			rcRecOfTab.TIPO_PRODUCTO(n) := itbLDC_VALIDACION_ACTIVIDADES(n).TIPO_PRODUCTO;
			rcRecOfTab.ACTIVIDAD(n) := itbLDC_VALIDACION_ACTIVIDADES(n).ACTIVIDAD;
			rcRecOfTab.VALIDACION(n) := itbLDC_VALIDACION_ACTIVIDADES(n).VALIDACION;
			rcRecOfTab.ID(n) := itbLDC_VALIDACION_ACTIVIDADES(n).ID;
			rcRecOfTab.NIVEL_REGISTRO(n) := itbLDC_VALIDACION_ACTIVIDADES(n).NIVEL_REGISTRO;
			rcRecOfTab.row_id(n) := itbLDC_VALIDACION_ACTIVIDADES(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuID in LDC_VALIDACION_ACTIVIDADES.ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuID
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
		inuID in LDC_VALIDACION_ACTIVIDADES.ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuID = rcData.ID
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
		inuID in LDC_VALIDACION_ACTIVIDADES.ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuID in LDC_VALIDACION_ACTIVIDADES.ID%type
	)
	IS
		rcError styLDC_VALIDACION_ACTIVIDADES;
	BEGIN		rcError.ID:=inuID;

		Load
		(
			inuID
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
		inuID in LDC_VALIDACION_ACTIVIDADES.ID%type
	)
	IS
	BEGIN
		Load
		(
			inuID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuID in LDC_VALIDACION_ACTIVIDADES.ID%type,
		orcRecord out nocopy styLDC_VALIDACION_ACTIVIDADES
	)
	IS
		rcError styLDC_VALIDACION_ACTIVIDADES;
	BEGIN		rcError.ID:=inuID;

		Load
		(
			inuID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuID in LDC_VALIDACION_ACTIVIDADES.ID%type
	)
	RETURN styLDC_VALIDACION_ACTIVIDADES
	IS
		rcError styLDC_VALIDACION_ACTIVIDADES;
	BEGIN
		rcError.ID:=inuID;

		Load
		(
			inuID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuID in LDC_VALIDACION_ACTIVIDADES.ID%type
	)
	RETURN styLDC_VALIDACION_ACTIVIDADES
	IS
		rcError styLDC_VALIDACION_ACTIVIDADES;
	BEGIN
		rcError.ID:=inuID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_VALIDACION_ACTIVIDADES
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_VALIDACION_ACTIVIDADES
	)
	IS
		rfLDC_VALIDACION_ACTIVIDADES tyrfLDC_VALIDACION_ACTIVIDADES;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_VALIDACION_ACTIVIDADES.*, LDC_VALIDACION_ACTIVIDADES.rowid FROM LDC_VALIDACION_ACTIVIDADES';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_VALIDACION_ACTIVIDADES for sbFullQuery;

		fetch rfLDC_VALIDACION_ACTIVIDADES bulk collect INTO otbResult;

		close rfLDC_VALIDACION_ACTIVIDADES;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_VALIDACION_ACTIVIDADES.*, LDC_VALIDACION_ACTIVIDADES.rowid FROM LDC_VALIDACION_ACTIVIDADES';
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
		ircLDC_VALIDACION_ACTIVIDADES in styLDC_VALIDACION_ACTIVIDADES
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_VALIDACION_ACTIVIDADES,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_VALIDACION_ACTIVIDADES in styLDC_VALIDACION_ACTIVIDADES,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_VALIDACION_ACTIVIDADES.ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ID');
			raise ex.controlled_error;
		end if;

		insert into LDC_VALIDACION_ACTIVIDADES
		(
			TIPO_PRODUCTO,
			ACTIVIDAD,
			VALIDACION,
			ID,
			NIVEL_REGISTRO
		)
		values
		(
			ircLDC_VALIDACION_ACTIVIDADES.TIPO_PRODUCTO,
			ircLDC_VALIDACION_ACTIVIDADES.ACTIVIDAD,
			ircLDC_VALIDACION_ACTIVIDADES.VALIDACION,
			ircLDC_VALIDACION_ACTIVIDADES.ID,
			ircLDC_VALIDACION_ACTIVIDADES.NIVEL_REGISTRO
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_VALIDACION_ACTIVIDADES));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_VALIDACION_ACTIVIDADES in out nocopy tytbLDC_VALIDACION_ACTIVIDADES
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_VALIDACION_ACTIVIDADES,blUseRowID);
		forall n in iotbLDC_VALIDACION_ACTIVIDADES.first..iotbLDC_VALIDACION_ACTIVIDADES.last
			insert into LDC_VALIDACION_ACTIVIDADES
			(
				TIPO_PRODUCTO,
				ACTIVIDAD,
				VALIDACION,
				ID,
				NIVEL_REGISTRO
			)
			values
			(
				rcRecOfTab.TIPO_PRODUCTO(n),
				rcRecOfTab.ACTIVIDAD(n),
				rcRecOfTab.VALIDACION(n),
				rcRecOfTab.ID(n),
				rcRecOfTab.NIVEL_REGISTRO(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuID in LDC_VALIDACION_ACTIVIDADES.ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_VALIDACION_ACTIVIDADES;
	BEGIN
		rcError.ID := inuID;

		if inuLock=1 then
			LockByPk
			(
				inuID,
				rcData
			);
		end if;


		delete
		from LDC_VALIDACION_ACTIVIDADES
		where
       		ID=inuID;
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
		rcError  styLDC_VALIDACION_ACTIVIDADES;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_VALIDACION_ACTIVIDADES
		where
			rowid = iriRowID
		returning
			TIPO_PRODUCTO
		into
			rcError.TIPO_PRODUCTO;
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
		iotbLDC_VALIDACION_ACTIVIDADES in out nocopy tytbLDC_VALIDACION_ACTIVIDADES,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_VALIDACION_ACTIVIDADES;
	BEGIN
		FillRecordOfTables(iotbLDC_VALIDACION_ACTIVIDADES, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_VALIDACION_ACTIVIDADES.first .. iotbLDC_VALIDACION_ACTIVIDADES.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_VALIDACION_ACTIVIDADES.first .. iotbLDC_VALIDACION_ACTIVIDADES.last
				delete
				from LDC_VALIDACION_ACTIVIDADES
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_VALIDACION_ACTIVIDADES.first .. iotbLDC_VALIDACION_ACTIVIDADES.last loop
					LockByPk
					(
						rcRecOfTab.ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_VALIDACION_ACTIVIDADES.first .. iotbLDC_VALIDACION_ACTIVIDADES.last
				delete
				from LDC_VALIDACION_ACTIVIDADES
				where
		         	ID = rcRecOfTab.ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_VALIDACION_ACTIVIDADES in styLDC_VALIDACION_ACTIVIDADES,
		inuLock in number default 0
	)
	IS
		nuID	LDC_VALIDACION_ACTIVIDADES.ID%type;
	BEGIN
		if ircLDC_VALIDACION_ACTIVIDADES.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_VALIDACION_ACTIVIDADES.rowid,rcData);
			end if;
			update LDC_VALIDACION_ACTIVIDADES
			set
				TIPO_PRODUCTO = ircLDC_VALIDACION_ACTIVIDADES.TIPO_PRODUCTO,
				ACTIVIDAD = ircLDC_VALIDACION_ACTIVIDADES.ACTIVIDAD,
				VALIDACION = ircLDC_VALIDACION_ACTIVIDADES.VALIDACION,
				NIVEL_REGISTRO = ircLDC_VALIDACION_ACTIVIDADES.NIVEL_REGISTRO
			where
				rowid = ircLDC_VALIDACION_ACTIVIDADES.rowid
			returning
				ID
			into
				nuID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_VALIDACION_ACTIVIDADES.ID,
					rcData
				);
			end if;

			update LDC_VALIDACION_ACTIVIDADES
			set
				TIPO_PRODUCTO = ircLDC_VALIDACION_ACTIVIDADES.TIPO_PRODUCTO,
				ACTIVIDAD = ircLDC_VALIDACION_ACTIVIDADES.ACTIVIDAD,
				VALIDACION = ircLDC_VALIDACION_ACTIVIDADES.VALIDACION,
				NIVEL_REGISTRO = ircLDC_VALIDACION_ACTIVIDADES.NIVEL_REGISTRO
			where
				ID = ircLDC_VALIDACION_ACTIVIDADES.ID
			returning
				ID
			into
				nuID;
		end if;
		if
			nuID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_VALIDACION_ACTIVIDADES));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_VALIDACION_ACTIVIDADES in out nocopy tytbLDC_VALIDACION_ACTIVIDADES,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_VALIDACION_ACTIVIDADES;
	BEGIN
		FillRecordOfTables(iotbLDC_VALIDACION_ACTIVIDADES,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_VALIDACION_ACTIVIDADES.first .. iotbLDC_VALIDACION_ACTIVIDADES.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_VALIDACION_ACTIVIDADES.first .. iotbLDC_VALIDACION_ACTIVIDADES.last
				update LDC_VALIDACION_ACTIVIDADES
				set
					TIPO_PRODUCTO = rcRecOfTab.TIPO_PRODUCTO(n),
					ACTIVIDAD = rcRecOfTab.ACTIVIDAD(n),
					VALIDACION = rcRecOfTab.VALIDACION(n),
					NIVEL_REGISTRO = rcRecOfTab.NIVEL_REGISTRO(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_VALIDACION_ACTIVIDADES.first .. iotbLDC_VALIDACION_ACTIVIDADES.last loop
					LockByPk
					(
						rcRecOfTab.ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_VALIDACION_ACTIVIDADES.first .. iotbLDC_VALIDACION_ACTIVIDADES.last
				update LDC_VALIDACION_ACTIVIDADES
				SET
					TIPO_PRODUCTO = rcRecOfTab.TIPO_PRODUCTO(n),
					ACTIVIDAD = rcRecOfTab.ACTIVIDAD(n),
					VALIDACION = rcRecOfTab.VALIDACION(n),
					NIVEL_REGISTRO = rcRecOfTab.NIVEL_REGISTRO(n)
				where
					ID = rcRecOfTab.ID(n)
;
		end if;
	END;
	PROCEDURE updTIPO_PRODUCTO
	(
		inuID in LDC_VALIDACION_ACTIVIDADES.ID%type,
		inuTIPO_PRODUCTO$ in LDC_VALIDACION_ACTIVIDADES.TIPO_PRODUCTO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_VALIDACION_ACTIVIDADES;
	BEGIN
		rcError.ID := inuID;
		if inuLock=1 then
			LockByPk
			(
				inuID,
				rcData
			);
		end if;

		update LDC_VALIDACION_ACTIVIDADES
		set
			TIPO_PRODUCTO = inuTIPO_PRODUCTO$
		where
			ID = inuID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TIPO_PRODUCTO:= inuTIPO_PRODUCTO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updACTIVIDAD
	(
		inuID in LDC_VALIDACION_ACTIVIDADES.ID%type,
		inuACTIVIDAD$ in LDC_VALIDACION_ACTIVIDADES.ACTIVIDAD%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_VALIDACION_ACTIVIDADES;
	BEGIN
		rcError.ID := inuID;
		if inuLock=1 then
			LockByPk
			(
				inuID,
				rcData
			);
		end if;

		update LDC_VALIDACION_ACTIVIDADES
		set
			ACTIVIDAD = inuACTIVIDAD$
		where
			ID = inuID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ACTIVIDAD:= inuACTIVIDAD$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updVALIDACION
	(
		inuID in LDC_VALIDACION_ACTIVIDADES.ID%type,
		inuVALIDACION$ in LDC_VALIDACION_ACTIVIDADES.VALIDACION%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_VALIDACION_ACTIVIDADES;
	BEGIN
		rcError.ID := inuID;
		if inuLock=1 then
			LockByPk
			(
				inuID,
				rcData
			);
		end if;

		update LDC_VALIDACION_ACTIVIDADES
		set
			VALIDACION = inuVALIDACION$
		where
			ID = inuID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.VALIDACION:= inuVALIDACION$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updNIVEL_REGISTRO
	(
		inuID in LDC_VALIDACION_ACTIVIDADES.ID%type,
		isbNIVEL_REGISTRO$ in LDC_VALIDACION_ACTIVIDADES.NIVEL_REGISTRO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_VALIDACION_ACTIVIDADES;
	BEGIN
		rcError.ID := inuID;
		if inuLock=1 then
			LockByPk
			(
				inuID,
				rcData
			);
		end if;

		update LDC_VALIDACION_ACTIVIDADES
		set
			NIVEL_REGISTRO = isbNIVEL_REGISTRO$
		where
			ID = inuID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.NIVEL_REGISTRO:= isbNIVEL_REGISTRO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetTIPO_PRODUCTO
	(
		inuID in LDC_VALIDACION_ACTIVIDADES.ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VALIDACION_ACTIVIDADES.TIPO_PRODUCTO%type
	IS
		rcError styLDC_VALIDACION_ACTIVIDADES;
	BEGIN

		rcError.ID := inuID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID
			 )
		then
			 return(rcData.TIPO_PRODUCTO);
		end if;
		Load
		(
		 		inuID
		);
		return(rcData.TIPO_PRODUCTO);
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
		inuID in LDC_VALIDACION_ACTIVIDADES.ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VALIDACION_ACTIVIDADES.ACTIVIDAD%type
	IS
		rcError styLDC_VALIDACION_ACTIVIDADES;
	BEGIN

		rcError.ID := inuID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID
			 )
		then
			 return(rcData.ACTIVIDAD);
		end if;
		Load
		(
		 		inuID
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
	FUNCTION fnuGetVALIDACION
	(
		inuID in LDC_VALIDACION_ACTIVIDADES.ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VALIDACION_ACTIVIDADES.VALIDACION%type
	IS
		rcError styLDC_VALIDACION_ACTIVIDADES;
	BEGIN

		rcError.ID := inuID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID
			 )
		then
			 return(rcData.VALIDACION);
		end if;
		Load
		(
		 		inuID
		);
		return(rcData.VALIDACION);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetID
	(
		inuID in LDC_VALIDACION_ACTIVIDADES.ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VALIDACION_ACTIVIDADES.ID%type
	IS
		rcError styLDC_VALIDACION_ACTIVIDADES;
	BEGIN

		rcError.ID := inuID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID
			 )
		then
			 return(rcData.ID);
		end if;
		Load
		(
		 		inuID
		);
		return(rcData.ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetNIVEL_REGISTRO
	(
		inuID in LDC_VALIDACION_ACTIVIDADES.ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_VALIDACION_ACTIVIDADES.NIVEL_REGISTRO%type
	IS
		rcError styLDC_VALIDACION_ACTIVIDADES;
	BEGIN

		rcError.ID := inuID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID
			 )
		then
			 return(rcData.NIVEL_REGISTRO);
		end if;
		Load
		(
		 		inuID
		);
		return(rcData.NIVEL_REGISTRO);
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
end DALDC_VALIDACION_ACTIVIDADES;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALDC_VALIDACION_ACTIVIDADES
BEGIN
    pkg_utilidades.prAplicarPermisos('DALDC_VALIDACION_ACTIVIDADES', 'ADM_PERSON'); 
END;
/