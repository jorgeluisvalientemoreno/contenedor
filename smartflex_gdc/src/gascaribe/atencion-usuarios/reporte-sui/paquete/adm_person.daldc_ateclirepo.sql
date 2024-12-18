CREATE OR REPLACE PACKAGE adm_person.daldc_ateclirepo
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  12/06/2024   Adrianavg   OSF-2779: Se migra del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuATECLIREPO_ID in LDC_ATECLIREPO.ATECLIREPO_ID%type
	)
	IS
		SELECT LDC_ATECLIREPO.*,LDC_ATECLIREPO.rowid
		FROM LDC_ATECLIREPO
		WHERE
		    ATECLIREPO_ID = inuATECLIREPO_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_ATECLIREPO.*,LDC_ATECLIREPO.rowid
		FROM LDC_ATECLIREPO
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_ATECLIREPO  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_ATECLIREPO is table of styLDC_ATECLIREPO index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_ATECLIREPO;

	/* Tipos referenciando al registro */
	type tytbATECLIREPO_ID is table of LDC_ATECLIREPO.ATECLIREPO_ID%type index by binary_integer;
	type tytbTIPO_REPORTE is table of LDC_ATECLIREPO.TIPO_REPORTE%type index by binary_integer;
	type tytbANO_REPORTE is table of LDC_ATECLIREPO.ANO_REPORTE%type index by binary_integer;
	type tytbMES_REPORTE is table of LDC_ATECLIREPO.MES_REPORTE%type index by binary_integer;
	type tytbFECHA_APROBACION is table of LDC_ATECLIREPO.FECHA_APROBACION%type index by binary_integer;
	type tytbAPROBADO is table of LDC_ATECLIREPO.APROBADO%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_ATECLIREPO is record
	(
		ATECLIREPO_ID   tytbATECLIREPO_ID,
		TIPO_REPORTE   tytbTIPO_REPORTE,
		ANO_REPORTE   tytbANO_REPORTE,
		MES_REPORTE   tytbMES_REPORTE,
		FECHA_APROBACION   tytbFECHA_APROBACION,
		APROBADO   tytbAPROBADO,
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
		inuATECLIREPO_ID in LDC_ATECLIREPO.ATECLIREPO_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuATECLIREPO_ID in LDC_ATECLIREPO.ATECLIREPO_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuATECLIREPO_ID in LDC_ATECLIREPO.ATECLIREPO_ID%type
	);

	PROCEDURE getRecord
	(
		inuATECLIREPO_ID in LDC_ATECLIREPO.ATECLIREPO_ID%type,
		orcRecord out nocopy styLDC_ATECLIREPO
	);

	FUNCTION frcGetRcData
	(
		inuATECLIREPO_ID in LDC_ATECLIREPO.ATECLIREPO_ID%type
	)
	RETURN styLDC_ATECLIREPO;

	FUNCTION frcGetRcData
	RETURN styLDC_ATECLIREPO;

	FUNCTION frcGetRecord
	(
		inuATECLIREPO_ID in LDC_ATECLIREPO.ATECLIREPO_ID%type
	)
	RETURN styLDC_ATECLIREPO;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_ATECLIREPO
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_ATECLIREPO in styLDC_ATECLIREPO
	);

	PROCEDURE insRecord
	(
		ircLDC_ATECLIREPO in styLDC_ATECLIREPO,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_ATECLIREPO in out nocopy tytbLDC_ATECLIREPO
	);

	PROCEDURE delRecord
	(
		inuATECLIREPO_ID in LDC_ATECLIREPO.ATECLIREPO_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_ATECLIREPO in out nocopy tytbLDC_ATECLIREPO,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_ATECLIREPO in styLDC_ATECLIREPO,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_ATECLIREPO in out nocopy tytbLDC_ATECLIREPO,
		inuLock in number default 1
	);

	PROCEDURE updTIPO_REPORTE
	(
		inuATECLIREPO_ID in LDC_ATECLIREPO.ATECLIREPO_ID%type,
		isbTIPO_REPORTE$ in LDC_ATECLIREPO.TIPO_REPORTE%type,
		inuLock in number default 0
	);

	PROCEDURE updANO_REPORTE
	(
		inuATECLIREPO_ID in LDC_ATECLIREPO.ATECLIREPO_ID%type,
		inuANO_REPORTE$ in LDC_ATECLIREPO.ANO_REPORTE%type,
		inuLock in number default 0
	);

	PROCEDURE updMES_REPORTE
	(
		inuATECLIREPO_ID in LDC_ATECLIREPO.ATECLIREPO_ID%type,
		inuMES_REPORTE$ in LDC_ATECLIREPO.MES_REPORTE%type,
		inuLock in number default 0
	);

	PROCEDURE updFECHA_APROBACION
	(
		inuATECLIREPO_ID in LDC_ATECLIREPO.ATECLIREPO_ID%type,
		idtFECHA_APROBACION$ in LDC_ATECLIREPO.FECHA_APROBACION%type,
		inuLock in number default 0
	);

	PROCEDURE updAPROBADO
	(
		inuATECLIREPO_ID in LDC_ATECLIREPO.ATECLIREPO_ID%type,
		isbAPROBADO$ in LDC_ATECLIREPO.APROBADO%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetATECLIREPO_ID
	(
		inuATECLIREPO_ID in LDC_ATECLIREPO.ATECLIREPO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ATECLIREPO.ATECLIREPO_ID%type;

	FUNCTION fsbGetTIPO_REPORTE
	(
		inuATECLIREPO_ID in LDC_ATECLIREPO.ATECLIREPO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ATECLIREPO.TIPO_REPORTE%type;

	FUNCTION fnuGetANO_REPORTE
	(
		inuATECLIREPO_ID in LDC_ATECLIREPO.ATECLIREPO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ATECLIREPO.ANO_REPORTE%type;

	FUNCTION fnuGetMES_REPORTE
	(
		inuATECLIREPO_ID in LDC_ATECLIREPO.ATECLIREPO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ATECLIREPO.MES_REPORTE%type;

	FUNCTION fdtGetFECHA_APROBACION
	(
		inuATECLIREPO_ID in LDC_ATECLIREPO.ATECLIREPO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ATECLIREPO.FECHA_APROBACION%type;

	FUNCTION fsbGetAPROBADO
	(
		inuATECLIREPO_ID in LDC_ATECLIREPO.ATECLIREPO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ATECLIREPO.APROBADO%type;


	PROCEDURE LockByPk
	(
		inuATECLIREPO_ID in LDC_ATECLIREPO.ATECLIREPO_ID%type,
		orcLDC_ATECLIREPO  out styLDC_ATECLIREPO
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_ATECLIREPO  out styLDC_ATECLIREPO
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_ATECLIREPO;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALDC_ATECLIREPO
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_ATECLIREPO';
	 cnuGeEntityId constant varchar2(30) := 8750; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuATECLIREPO_ID in LDC_ATECLIREPO.ATECLIREPO_ID%type
	)
	IS
		SELECT LDC_ATECLIREPO.*,LDC_ATECLIREPO.rowid
		FROM LDC_ATECLIREPO
		WHERE  ATECLIREPO_ID = inuATECLIREPO_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_ATECLIREPO.*,LDC_ATECLIREPO.rowid
		FROM LDC_ATECLIREPO
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_ATECLIREPO is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_ATECLIREPO;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_ATECLIREPO default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.ATECLIREPO_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuATECLIREPO_ID in LDC_ATECLIREPO.ATECLIREPO_ID%type,
		orcLDC_ATECLIREPO  out styLDC_ATECLIREPO
	)
	IS
		rcError styLDC_ATECLIREPO;
	BEGIN
		rcError.ATECLIREPO_ID := inuATECLIREPO_ID;

		Open cuLockRcByPk
		(
			inuATECLIREPO_ID
		);

		fetch cuLockRcByPk into orcLDC_ATECLIREPO;
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
		orcLDC_ATECLIREPO  out styLDC_ATECLIREPO
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_ATECLIREPO;
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
		itbLDC_ATECLIREPO  in out nocopy tytbLDC_ATECLIREPO
	)
	IS
	BEGIN
			rcRecOfTab.ATECLIREPO_ID.delete;
			rcRecOfTab.TIPO_REPORTE.delete;
			rcRecOfTab.ANO_REPORTE.delete;
			rcRecOfTab.MES_REPORTE.delete;
			rcRecOfTab.FECHA_APROBACION.delete;
			rcRecOfTab.APROBADO.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_ATECLIREPO  in out nocopy tytbLDC_ATECLIREPO,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_ATECLIREPO);

		for n in itbLDC_ATECLIREPO.first .. itbLDC_ATECLIREPO.last loop
			rcRecOfTab.ATECLIREPO_ID(n) := itbLDC_ATECLIREPO(n).ATECLIREPO_ID;
			rcRecOfTab.TIPO_REPORTE(n) := itbLDC_ATECLIREPO(n).TIPO_REPORTE;
			rcRecOfTab.ANO_REPORTE(n) := itbLDC_ATECLIREPO(n).ANO_REPORTE;
			rcRecOfTab.MES_REPORTE(n) := itbLDC_ATECLIREPO(n).MES_REPORTE;
			rcRecOfTab.FECHA_APROBACION(n) := itbLDC_ATECLIREPO(n).FECHA_APROBACION;
			rcRecOfTab.APROBADO(n) := itbLDC_ATECLIREPO(n).APROBADO;
			rcRecOfTab.row_id(n) := itbLDC_ATECLIREPO(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuATECLIREPO_ID in LDC_ATECLIREPO.ATECLIREPO_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuATECLIREPO_ID
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
		inuATECLIREPO_ID in LDC_ATECLIREPO.ATECLIREPO_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuATECLIREPO_ID = rcData.ATECLIREPO_ID
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
		inuATECLIREPO_ID in LDC_ATECLIREPO.ATECLIREPO_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuATECLIREPO_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuATECLIREPO_ID in LDC_ATECLIREPO.ATECLIREPO_ID%type
	)
	IS
		rcError styLDC_ATECLIREPO;
	BEGIN		rcError.ATECLIREPO_ID:=inuATECLIREPO_ID;

		Load
		(
			inuATECLIREPO_ID
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
		inuATECLIREPO_ID in LDC_ATECLIREPO.ATECLIREPO_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuATECLIREPO_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuATECLIREPO_ID in LDC_ATECLIREPO.ATECLIREPO_ID%type,
		orcRecord out nocopy styLDC_ATECLIREPO
	)
	IS
		rcError styLDC_ATECLIREPO;
	BEGIN		rcError.ATECLIREPO_ID:=inuATECLIREPO_ID;

		Load
		(
			inuATECLIREPO_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuATECLIREPO_ID in LDC_ATECLIREPO.ATECLIREPO_ID%type
	)
	RETURN styLDC_ATECLIREPO
	IS
		rcError styLDC_ATECLIREPO;
	BEGIN
		rcError.ATECLIREPO_ID:=inuATECLIREPO_ID;

		Load
		(
			inuATECLIREPO_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuATECLIREPO_ID in LDC_ATECLIREPO.ATECLIREPO_ID%type
	)
	RETURN styLDC_ATECLIREPO
	IS
		rcError styLDC_ATECLIREPO;
	BEGIN
		rcError.ATECLIREPO_ID:=inuATECLIREPO_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuATECLIREPO_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuATECLIREPO_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_ATECLIREPO
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_ATECLIREPO
	)
	IS
		rfLDC_ATECLIREPO tyrfLDC_ATECLIREPO;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_ATECLIREPO.*, LDC_ATECLIREPO.rowid FROM LDC_ATECLIREPO';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_ATECLIREPO for sbFullQuery;

		fetch rfLDC_ATECLIREPO bulk collect INTO otbResult;

		close rfLDC_ATECLIREPO;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_ATECLIREPO.*, LDC_ATECLIREPO.rowid FROM LDC_ATECLIREPO';
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
		ircLDC_ATECLIREPO in styLDC_ATECLIREPO
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_ATECLIREPO,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_ATECLIREPO in styLDC_ATECLIREPO,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_ATECLIREPO.ATECLIREPO_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ATECLIREPO_ID');
			raise ex.controlled_error;
		end if;

		insert into LDC_ATECLIREPO
		(
			ATECLIREPO_ID,
			TIPO_REPORTE,
			ANO_REPORTE,
			MES_REPORTE,
			FECHA_APROBACION,
			APROBADO
		)
		values
		(
			ircLDC_ATECLIREPO.ATECLIREPO_ID,
			ircLDC_ATECLIREPO.TIPO_REPORTE,
			ircLDC_ATECLIREPO.ANO_REPORTE,
			ircLDC_ATECLIREPO.MES_REPORTE,
			ircLDC_ATECLIREPO.FECHA_APROBACION,
			ircLDC_ATECLIREPO.APROBADO
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_ATECLIREPO));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_ATECLIREPO in out nocopy tytbLDC_ATECLIREPO
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_ATECLIREPO,blUseRowID);
		forall n in iotbLDC_ATECLIREPO.first..iotbLDC_ATECLIREPO.last
			insert into LDC_ATECLIREPO
			(
				ATECLIREPO_ID,
				TIPO_REPORTE,
				ANO_REPORTE,
				MES_REPORTE,
				FECHA_APROBACION,
				APROBADO
			)
			values
			(
				rcRecOfTab.ATECLIREPO_ID(n),
				rcRecOfTab.TIPO_REPORTE(n),
				rcRecOfTab.ANO_REPORTE(n),
				rcRecOfTab.MES_REPORTE(n),
				rcRecOfTab.FECHA_APROBACION(n),
				rcRecOfTab.APROBADO(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuATECLIREPO_ID in LDC_ATECLIREPO.ATECLIREPO_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_ATECLIREPO;
	BEGIN
		rcError.ATECLIREPO_ID := inuATECLIREPO_ID;

		if inuLock=1 then
			LockByPk
			(
				inuATECLIREPO_ID,
				rcData
			);
		end if;


		delete
		from LDC_ATECLIREPO
		where
       		ATECLIREPO_ID=inuATECLIREPO_ID;
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
		rcError  styLDC_ATECLIREPO;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_ATECLIREPO
		where
			rowid = iriRowID
		returning
			ATECLIREPO_ID
		into
			rcError.ATECLIREPO_ID;
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
		iotbLDC_ATECLIREPO in out nocopy tytbLDC_ATECLIREPO,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_ATECLIREPO;
	BEGIN
		FillRecordOfTables(iotbLDC_ATECLIREPO, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_ATECLIREPO.first .. iotbLDC_ATECLIREPO.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ATECLIREPO.first .. iotbLDC_ATECLIREPO.last
				delete
				from LDC_ATECLIREPO
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_ATECLIREPO.first .. iotbLDC_ATECLIREPO.last loop
					LockByPk
					(
						rcRecOfTab.ATECLIREPO_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ATECLIREPO.first .. iotbLDC_ATECLIREPO.last
				delete
				from LDC_ATECLIREPO
				where
		         	ATECLIREPO_ID = rcRecOfTab.ATECLIREPO_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_ATECLIREPO in styLDC_ATECLIREPO,
		inuLock in number default 0
	)
	IS
		nuATECLIREPO_ID	LDC_ATECLIREPO.ATECLIREPO_ID%type;
	BEGIN
		if ircLDC_ATECLIREPO.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_ATECLIREPO.rowid,rcData);
			end if;
			update LDC_ATECLIREPO
			set
				TIPO_REPORTE = ircLDC_ATECLIREPO.TIPO_REPORTE,
				ANO_REPORTE = ircLDC_ATECLIREPO.ANO_REPORTE,
				MES_REPORTE = ircLDC_ATECLIREPO.MES_REPORTE,
				FECHA_APROBACION = ircLDC_ATECLIREPO.FECHA_APROBACION,
				APROBADO = ircLDC_ATECLIREPO.APROBADO
			where
				rowid = ircLDC_ATECLIREPO.rowid
			returning
				ATECLIREPO_ID
			into
				nuATECLIREPO_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_ATECLIREPO.ATECLIREPO_ID,
					rcData
				);
			end if;

			update LDC_ATECLIREPO
			set
				TIPO_REPORTE = ircLDC_ATECLIREPO.TIPO_REPORTE,
				ANO_REPORTE = ircLDC_ATECLIREPO.ANO_REPORTE,
				MES_REPORTE = ircLDC_ATECLIREPO.MES_REPORTE,
				FECHA_APROBACION = ircLDC_ATECLIREPO.FECHA_APROBACION,
				APROBADO = ircLDC_ATECLIREPO.APROBADO
			where
				ATECLIREPO_ID = ircLDC_ATECLIREPO.ATECLIREPO_ID
			returning
				ATECLIREPO_ID
			into
				nuATECLIREPO_ID;
		end if;
		if
			nuATECLIREPO_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_ATECLIREPO));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_ATECLIREPO in out nocopy tytbLDC_ATECLIREPO,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_ATECLIREPO;
	BEGIN
		FillRecordOfTables(iotbLDC_ATECLIREPO,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_ATECLIREPO.first .. iotbLDC_ATECLIREPO.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ATECLIREPO.first .. iotbLDC_ATECLIREPO.last
				update LDC_ATECLIREPO
				set
					TIPO_REPORTE = rcRecOfTab.TIPO_REPORTE(n),
					ANO_REPORTE = rcRecOfTab.ANO_REPORTE(n),
					MES_REPORTE = rcRecOfTab.MES_REPORTE(n),
					FECHA_APROBACION = rcRecOfTab.FECHA_APROBACION(n),
					APROBADO = rcRecOfTab.APROBADO(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_ATECLIREPO.first .. iotbLDC_ATECLIREPO.last loop
					LockByPk
					(
						rcRecOfTab.ATECLIREPO_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_ATECLIREPO.first .. iotbLDC_ATECLIREPO.last
				update LDC_ATECLIREPO
				SET
					TIPO_REPORTE = rcRecOfTab.TIPO_REPORTE(n),
					ANO_REPORTE = rcRecOfTab.ANO_REPORTE(n),
					MES_REPORTE = rcRecOfTab.MES_REPORTE(n),
					FECHA_APROBACION = rcRecOfTab.FECHA_APROBACION(n),
					APROBADO = rcRecOfTab.APROBADO(n)
				where
					ATECLIREPO_ID = rcRecOfTab.ATECLIREPO_ID(n)
;
		end if;
	END;
	PROCEDURE updTIPO_REPORTE
	(
		inuATECLIREPO_ID in LDC_ATECLIREPO.ATECLIREPO_ID%type,
		isbTIPO_REPORTE$ in LDC_ATECLIREPO.TIPO_REPORTE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ATECLIREPO;
	BEGIN
		rcError.ATECLIREPO_ID := inuATECLIREPO_ID;
		if inuLock=1 then
			LockByPk
			(
				inuATECLIREPO_ID,
				rcData
			);
		end if;

		update LDC_ATECLIREPO
		set
			TIPO_REPORTE = isbTIPO_REPORTE$
		where
			ATECLIREPO_ID = inuATECLIREPO_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TIPO_REPORTE:= isbTIPO_REPORTE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updANO_REPORTE
	(
		inuATECLIREPO_ID in LDC_ATECLIREPO.ATECLIREPO_ID%type,
		inuANO_REPORTE$ in LDC_ATECLIREPO.ANO_REPORTE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ATECLIREPO;
	BEGIN
		rcError.ATECLIREPO_ID := inuATECLIREPO_ID;
		if inuLock=1 then
			LockByPk
			(
				inuATECLIREPO_ID,
				rcData
			);
		end if;

		update LDC_ATECLIREPO
		set
			ANO_REPORTE = inuANO_REPORTE$
		where
			ATECLIREPO_ID = inuATECLIREPO_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ANO_REPORTE:= inuANO_REPORTE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updMES_REPORTE
	(
		inuATECLIREPO_ID in LDC_ATECLIREPO.ATECLIREPO_ID%type,
		inuMES_REPORTE$ in LDC_ATECLIREPO.MES_REPORTE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ATECLIREPO;
	BEGIN
		rcError.ATECLIREPO_ID := inuATECLIREPO_ID;
		if inuLock=1 then
			LockByPk
			(
				inuATECLIREPO_ID,
				rcData
			);
		end if;

		update LDC_ATECLIREPO
		set
			MES_REPORTE = inuMES_REPORTE$
		where
			ATECLIREPO_ID = inuATECLIREPO_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.MES_REPORTE:= inuMES_REPORTE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFECHA_APROBACION
	(
		inuATECLIREPO_ID in LDC_ATECLIREPO.ATECLIREPO_ID%type,
		idtFECHA_APROBACION$ in LDC_ATECLIREPO.FECHA_APROBACION%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ATECLIREPO;
	BEGIN
		rcError.ATECLIREPO_ID := inuATECLIREPO_ID;
		if inuLock=1 then
			LockByPk
			(
				inuATECLIREPO_ID,
				rcData
			);
		end if;

		update LDC_ATECLIREPO
		set
			FECHA_APROBACION = idtFECHA_APROBACION$
		where
			ATECLIREPO_ID = inuATECLIREPO_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FECHA_APROBACION:= idtFECHA_APROBACION$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updAPROBADO
	(
		inuATECLIREPO_ID in LDC_ATECLIREPO.ATECLIREPO_ID%type,
		isbAPROBADO$ in LDC_ATECLIREPO.APROBADO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_ATECLIREPO;
	BEGIN
		rcError.ATECLIREPO_ID := inuATECLIREPO_ID;
		if inuLock=1 then
			LockByPk
			(
				inuATECLIREPO_ID,
				rcData
			);
		end if;

		update LDC_ATECLIREPO
		set
			APROBADO = isbAPROBADO$
		where
			ATECLIREPO_ID = inuATECLIREPO_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.APROBADO:= isbAPROBADO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetATECLIREPO_ID
	(
		inuATECLIREPO_ID in LDC_ATECLIREPO.ATECLIREPO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ATECLIREPO.ATECLIREPO_ID%type
	IS
		rcError styLDC_ATECLIREPO;
	BEGIN

		rcError.ATECLIREPO_ID := inuATECLIREPO_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuATECLIREPO_ID
			 )
		then
			 return(rcData.ATECLIREPO_ID);
		end if;
		Load
		(
		 		inuATECLIREPO_ID
		);
		return(rcData.ATECLIREPO_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetTIPO_REPORTE
	(
		inuATECLIREPO_ID in LDC_ATECLIREPO.ATECLIREPO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ATECLIREPO.TIPO_REPORTE%type
	IS
		rcError styLDC_ATECLIREPO;
	BEGIN

		rcError.ATECLIREPO_ID := inuATECLIREPO_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuATECLIREPO_ID
			 )
		then
			 return(rcData.TIPO_REPORTE);
		end if;
		Load
		(
		 		inuATECLIREPO_ID
		);
		return(rcData.TIPO_REPORTE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetANO_REPORTE
	(
		inuATECLIREPO_ID in LDC_ATECLIREPO.ATECLIREPO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ATECLIREPO.ANO_REPORTE%type
	IS
		rcError styLDC_ATECLIREPO;
	BEGIN

		rcError.ATECLIREPO_ID := inuATECLIREPO_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuATECLIREPO_ID
			 )
		then
			 return(rcData.ANO_REPORTE);
		end if;
		Load
		(
		 		inuATECLIREPO_ID
		);
		return(rcData.ANO_REPORTE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetMES_REPORTE
	(
		inuATECLIREPO_ID in LDC_ATECLIREPO.ATECLIREPO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ATECLIREPO.MES_REPORTE%type
	IS
		rcError styLDC_ATECLIREPO;
	BEGIN

		rcError.ATECLIREPO_ID := inuATECLIREPO_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuATECLIREPO_ID
			 )
		then
			 return(rcData.MES_REPORTE);
		end if;
		Load
		(
		 		inuATECLIREPO_ID
		);
		return(rcData.MES_REPORTE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetFECHA_APROBACION
	(
		inuATECLIREPO_ID in LDC_ATECLIREPO.ATECLIREPO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ATECLIREPO.FECHA_APROBACION%type
	IS
		rcError styLDC_ATECLIREPO;
	BEGIN

		rcError.ATECLIREPO_ID := inuATECLIREPO_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuATECLIREPO_ID
			 )
		then
			 return(rcData.FECHA_APROBACION);
		end if;
		Load
		(
		 		inuATECLIREPO_ID
		);
		return(rcData.FECHA_APROBACION);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetAPROBADO
	(
		inuATECLIREPO_ID in LDC_ATECLIREPO.ATECLIREPO_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_ATECLIREPO.APROBADO%type
	IS
		rcError styLDC_ATECLIREPO;
	BEGIN

		rcError.ATECLIREPO_ID := inuATECLIREPO_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuATECLIREPO_ID
			 )
		then
			 return(rcData.APROBADO);
		end if;
		Load
		(
		 		inuATECLIREPO_ID
		);
		return(rcData.APROBADO);
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
end DALDC_ATECLIREPO;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALDC_ATECLIREPO
BEGIN
    pkg_utilidades.prAplicarPermisos('DALDC_ATECLIREPO', 'ADM_PERSON'); 
END;
/ 
