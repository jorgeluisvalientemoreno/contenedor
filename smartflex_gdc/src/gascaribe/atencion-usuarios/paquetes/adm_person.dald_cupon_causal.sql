CREATE OR REPLACE PACKAGE adm_person.DALD_CUPON_CAUSAL
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
    17/06/2024              PAcosta         OSF-2780: Cambio de esquema ADM_PERSON                              
    ****************************************************************/   
    
    /* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuCUPONUME in LD_CUPON_CAUSAL.CUPONUME%type
	)
	IS
		SELECT LD_CUPON_CAUSAL.*,LD_CUPON_CAUSAL.rowid
		FROM LD_CUPON_CAUSAL
		WHERE
		    CUPONUME = inuCUPONUME;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LD_CUPON_CAUSAL.*,LD_CUPON_CAUSAL.rowid
		FROM LD_CUPON_CAUSAL
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_CUPON_CAUSAL  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_CUPON_CAUSAL is table of styLD_CUPON_CAUSAL index by binary_integer;
	type tyrfRecords is ref cursor return styLD_CUPON_CAUSAL;

	/* Tipos referenciando al registro */
	type tytbCUPONUME is table of LD_CUPON_CAUSAL.CUPONUME%type index by binary_integer;
	type tytbCAUSAL_ID is table of LD_CUPON_CAUSAL.CAUSAL_ID%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_CUPON_CAUSAL is record
	(
		CUPONUME   tytbCUPONUME,
		CAUSAL_ID   tytbCAUSAL_ID,
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
		inuCUPONUME in LD_CUPON_CAUSAL.CUPONUME%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuCUPONUME in LD_CUPON_CAUSAL.CUPONUME%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuCUPONUME in LD_CUPON_CAUSAL.CUPONUME%type
	);

	PROCEDURE getRecord
	(
		inuCUPONUME in LD_CUPON_CAUSAL.CUPONUME%type,
		orcRecord out nocopy styLD_CUPON_CAUSAL
	);

	FUNCTION frcGetRcData
	(
		inuCUPONUME in LD_CUPON_CAUSAL.CUPONUME%type
	)
	RETURN styLD_CUPON_CAUSAL;

	FUNCTION frcGetRcData
	RETURN styLD_CUPON_CAUSAL;

	FUNCTION frcGetRecord
	(
		inuCUPONUME in LD_CUPON_CAUSAL.CUPONUME%type
	)
	RETURN styLD_CUPON_CAUSAL;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_CUPON_CAUSAL
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_CUPON_CAUSAL in styLD_CUPON_CAUSAL
	);

	PROCEDURE insRecord
	(
		ircLD_CUPON_CAUSAL in styLD_CUPON_CAUSAL,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_CUPON_CAUSAL in out nocopy tytbLD_CUPON_CAUSAL
	);

	PROCEDURE delRecord
	(
		inuCUPONUME in LD_CUPON_CAUSAL.CUPONUME%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_CUPON_CAUSAL in out nocopy tytbLD_CUPON_CAUSAL,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_CUPON_CAUSAL in styLD_CUPON_CAUSAL,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_CUPON_CAUSAL in out nocopy tytbLD_CUPON_CAUSAL,
		inuLock in number default 1
	);

	PROCEDURE updCAUSAL_ID
	(
		inuCUPONUME in LD_CUPON_CAUSAL.CUPONUME%type,
		inuCAUSAL_ID$ in LD_CUPON_CAUSAL.CAUSAL_ID%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetCUPONUME
	(
		inuCUPONUME in LD_CUPON_CAUSAL.CUPONUME%type,
		inuRaiseError in number default 1
	)
	RETURN LD_CUPON_CAUSAL.CUPONUME%type;

	FUNCTION fnuGetCAUSAL_ID
	(
		inuCUPONUME in LD_CUPON_CAUSAL.CUPONUME%type,
		inuRaiseError in number default 1
	)
	RETURN LD_CUPON_CAUSAL.CAUSAL_ID%type;


	PROCEDURE LockByPk
	(
		inuCUPONUME in LD_CUPON_CAUSAL.CUPONUME%type,
		orcLD_CUPON_CAUSAL  out styLD_CUPON_CAUSAL
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_CUPON_CAUSAL  out styLD_CUPON_CAUSAL
	);

    FUNCTION fblCuponCobro
	(
		inuCUPONUME in LD_CUPON_CAUSAL.CUPONUME%type default 1,
		inuRaiseError in number default 1
	)
    RETURN boolean;

    /*****************************************************************
      Propiedad intelectual de PETI (c).

      Unidad         : fblExisteCargo
      Descripcion    : Retorna true si existe un cargo para el duplicado.
                        Aplica según la validación definida por ZPrada:
                        - Realizar una validación para generar el cobro una sola vez
                        y no generarlo si se expiden varias Solicitudes de Estado de Cuenta
                        para el mismo caso en el mismo día.
      Autor          : Paula Andrea García Rendón
      Fecha          : 29/10/2014

      Parametros              Descripcion
      ============         ===================
      inuCUPONUME          Identificador del cupón.

      Fecha             Autor             Modificacion
      =========       =========           ====================

      ******************************************************************/
	FUNCTION fblExisteCargo(inuCupon number, nuProduct number)
    return boolean;

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_CUPON_CAUSAL;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_CUPON_CAUSAL
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_CUPON_CAUSAL';
	 cnuGeEntityId constant varchar2(30) := 1711; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuCUPONUME in LD_CUPON_CAUSAL.CUPONUME%type
	)
	IS
		SELECT LD_CUPON_CAUSAL.*,LD_CUPON_CAUSAL.rowid
		FROM LD_CUPON_CAUSAL
		WHERE  CUPONUME = inuCUPONUME
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_CUPON_CAUSAL.*,LD_CUPON_CAUSAL.rowid
		FROM LD_CUPON_CAUSAL
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLD_CUPON_CAUSAL is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_CUPON_CAUSAL;

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
	FUNCTION fsbPrimaryKey( rcI in styLD_CUPON_CAUSAL default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.CUPONUME);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuCUPONUME in LD_CUPON_CAUSAL.CUPONUME%type,
		orcLD_CUPON_CAUSAL  out styLD_CUPON_CAUSAL
	)
	IS
		rcError styLD_CUPON_CAUSAL;
	BEGIN
		rcError.CUPONUME := inuCUPONUME;

		Open cuLockRcByPk
		(
			inuCUPONUME
		);

		fetch cuLockRcByPk into orcLD_CUPON_CAUSAL;
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
		orcLD_CUPON_CAUSAL  out styLD_CUPON_CAUSAL
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_CUPON_CAUSAL;
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
		itbLD_CUPON_CAUSAL  in out nocopy tytbLD_CUPON_CAUSAL
	)
	IS
	BEGIN
			rcRecOfTab.CUPONUME.delete;
			rcRecOfTab.CAUSAL_ID.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_CUPON_CAUSAL  in out nocopy tytbLD_CUPON_CAUSAL,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_CUPON_CAUSAL);

		for n in itbLD_CUPON_CAUSAL.first .. itbLD_CUPON_CAUSAL.last loop
			rcRecOfTab.CUPONUME(n) := itbLD_CUPON_CAUSAL(n).CUPONUME;
			rcRecOfTab.CAUSAL_ID(n) := itbLD_CUPON_CAUSAL(n).CAUSAL_ID;
			rcRecOfTab.row_id(n) := itbLD_CUPON_CAUSAL(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuCUPONUME in LD_CUPON_CAUSAL.CUPONUME%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuCUPONUME
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
		inuCUPONUME in LD_CUPON_CAUSAL.CUPONUME%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuCUPONUME = rcData.CUPONUME
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
		inuCUPONUME in LD_CUPON_CAUSAL.CUPONUME%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuCUPONUME
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuCUPONUME in LD_CUPON_CAUSAL.CUPONUME%type
	)
	IS
		rcError styLD_CUPON_CAUSAL;
	BEGIN		rcError.CUPONUME:=inuCUPONUME;

		Load
		(
			inuCUPONUME
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
		inuCUPONUME in LD_CUPON_CAUSAL.CUPONUME%type
	)
	IS
	BEGIN
		Load
		(
			inuCUPONUME
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuCUPONUME in LD_CUPON_CAUSAL.CUPONUME%type,
		orcRecord out nocopy styLD_CUPON_CAUSAL
	)
	IS
		rcError styLD_CUPON_CAUSAL;
	BEGIN		rcError.CUPONUME:=inuCUPONUME;

		Load
		(
			inuCUPONUME
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuCUPONUME in LD_CUPON_CAUSAL.CUPONUME%type
	)
	RETURN styLD_CUPON_CAUSAL
	IS
		rcError styLD_CUPON_CAUSAL;
	BEGIN
		rcError.CUPONUME:=inuCUPONUME;

		Load
		(
			inuCUPONUME
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuCUPONUME in LD_CUPON_CAUSAL.CUPONUME%type
	)
	RETURN styLD_CUPON_CAUSAL
	IS
		rcError styLD_CUPON_CAUSAL;
	BEGIN
		rcError.CUPONUME:=inuCUPONUME;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuCUPONUME
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuCUPONUME
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_CUPON_CAUSAL
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_CUPON_CAUSAL
	)
	IS
		rfLD_CUPON_CAUSAL tyrfLD_CUPON_CAUSAL;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LD_CUPON_CAUSAL.*, LD_CUPON_CAUSAL.rowid FROM LD_CUPON_CAUSAL';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLD_CUPON_CAUSAL for sbFullQuery;

		fetch rfLD_CUPON_CAUSAL bulk collect INTO otbResult;

		close rfLD_CUPON_CAUSAL;
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
		sbSQL VARCHAR2 (32000) := 'select LD_CUPON_CAUSAL.*, LD_CUPON_CAUSAL.rowid FROM LD_CUPON_CAUSAL';
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
		ircLD_CUPON_CAUSAL in styLD_CUPON_CAUSAL
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_CUPON_CAUSAL,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLD_CUPON_CAUSAL in styLD_CUPON_CAUSAL,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_CUPON_CAUSAL.CUPONUME is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|CUPONUME');
			raise ex.controlled_error;
		end if;

		insert into LD_CUPON_CAUSAL
		(
			CUPONUME,
			CAUSAL_ID,
            PACKAGE_ID
		)
		values
		(
			ircLD_CUPON_CAUSAL.CUPONUME,
			ircLD_CUPON_CAUSAL.CAUSAL_ID,
			ircLD_CUPON_CAUSAL.PACKAGE_ID
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_CUPON_CAUSAL));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLD_CUPON_CAUSAL in out nocopy tytbLD_CUPON_CAUSAL
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_CUPON_CAUSAL,blUseRowID);
		forall n in iotbLD_CUPON_CAUSAL.first..iotbLD_CUPON_CAUSAL.last
			insert into LD_CUPON_CAUSAL
			(
				CUPONUME,
				CAUSAL_ID
			)
			values
			(
				rcRecOfTab.CUPONUME(n),
				rcRecOfTab.CAUSAL_ID(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuCUPONUME in LD_CUPON_CAUSAL.CUPONUME%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_CUPON_CAUSAL;
	BEGIN
		rcError.CUPONUME := inuCUPONUME;

		if inuLock=1 then
			LockByPk
			(
				inuCUPONUME,
				rcData
			);
		end if;


		delete
		from LD_CUPON_CAUSAL
		where
       		CUPONUME=inuCUPONUME;
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
		rcError  styLD_CUPON_CAUSAL;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LD_CUPON_CAUSAL
		where
			rowid = iriRowID
		returning
			CUPONUME
		into
			rcError.CUPONUME;
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
		iotbLD_CUPON_CAUSAL in out nocopy tytbLD_CUPON_CAUSAL,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_CUPON_CAUSAL;
	BEGIN
		FillRecordOfTables(iotbLD_CUPON_CAUSAL, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_CUPON_CAUSAL.first .. iotbLD_CUPON_CAUSAL.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_CUPON_CAUSAL.first .. iotbLD_CUPON_CAUSAL.last
				delete
				from LD_CUPON_CAUSAL
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_CUPON_CAUSAL.first .. iotbLD_CUPON_CAUSAL.last loop
					LockByPk
					(
						rcRecOfTab.CUPONUME(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_CUPON_CAUSAL.first .. iotbLD_CUPON_CAUSAL.last
				delete
				from LD_CUPON_CAUSAL
				where
		         	CUPONUME = rcRecOfTab.CUPONUME(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLD_CUPON_CAUSAL in styLD_CUPON_CAUSAL,
		inuLock in number default 0
	)
	IS
		nuCUPONUME	LD_CUPON_CAUSAL.CUPONUME%type;
	BEGIN
		if ircLD_CUPON_CAUSAL.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_CUPON_CAUSAL.rowid,rcData);
			end if;
			update LD_CUPON_CAUSAL
			set
				CAUSAL_ID = ircLD_CUPON_CAUSAL.CAUSAL_ID
			where
				rowid = ircLD_CUPON_CAUSAL.rowid
			returning
				CUPONUME
			into
				nuCUPONUME;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_CUPON_CAUSAL.CUPONUME,
					rcData
				);
			end if;

			update LD_CUPON_CAUSAL
			set
				CAUSAL_ID = ircLD_CUPON_CAUSAL.CAUSAL_ID
			where
				CUPONUME = ircLD_CUPON_CAUSAL.CUPONUME
			returning
				CUPONUME
			into
				nuCUPONUME;
		end if;
		if
			nuCUPONUME is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_CUPON_CAUSAL));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLD_CUPON_CAUSAL in out nocopy tytbLD_CUPON_CAUSAL,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_CUPON_CAUSAL;
	BEGIN
		FillRecordOfTables(iotbLD_CUPON_CAUSAL,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLD_CUPON_CAUSAL.first .. iotbLD_CUPON_CAUSAL.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_CUPON_CAUSAL.first .. iotbLD_CUPON_CAUSAL.last
				update LD_CUPON_CAUSAL
				set
					CAUSAL_ID = rcRecOfTab.CAUSAL_ID(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_CUPON_CAUSAL.first .. iotbLD_CUPON_CAUSAL.last loop
					LockByPk
					(
						rcRecOfTab.CUPONUME(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_CUPON_CAUSAL.first .. iotbLD_CUPON_CAUSAL.last
				update LD_CUPON_CAUSAL
				SET
					CAUSAL_ID = rcRecOfTab.CAUSAL_ID(n)
				where
					CUPONUME = rcRecOfTab.CUPONUME(n)
;
		end if;
	END;
	PROCEDURE updCAUSAL_ID
	(
		inuCUPONUME in LD_CUPON_CAUSAL.CUPONUME%type,
		inuCAUSAL_ID$ in LD_CUPON_CAUSAL.CAUSAL_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_CUPON_CAUSAL;
	BEGIN
		rcError.CUPONUME := inuCUPONUME;
		if inuLock=1 then
			LockByPk
			(
				inuCUPONUME,
				rcData
			);
		end if;

		update LD_CUPON_CAUSAL
		set
			CAUSAL_ID = inuCAUSAL_ID$
		where
			CUPONUME = inuCUPONUME;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CAUSAL_ID:= inuCAUSAL_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetCUPONUME
	(
		inuCUPONUME in LD_CUPON_CAUSAL.CUPONUME%type,
		inuRaiseError in number default 1
	)
	RETURN LD_CUPON_CAUSAL.CUPONUME%type
	IS
		rcError styLD_CUPON_CAUSAL;
	BEGIN

		rcError.CUPONUME := inuCUPONUME;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCUPONUME
			 )
		then
			 return(rcData.CUPONUME);
		end if;
		Load
		(
		 		inuCUPONUME
		);
		return(rcData.CUPONUME);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCAUSAL_ID
	(
		inuCUPONUME in LD_CUPON_CAUSAL.CUPONUME%type,
		inuRaiseError in number default 1
	)
	RETURN LD_CUPON_CAUSAL.CAUSAL_ID%type
	IS
		rcError styLD_CUPON_CAUSAL;
	BEGIN

		rcError.CUPONUME := inuCUPONUME;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCUPONUME
			 )
		then
			 return(rcData.CAUSAL_ID);
		end if;
		Load
		(
		 		inuCUPONUME
		);
		return(rcData.CAUSAL_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	/*****************************************************************
      Propiedad intelectual de PETI (c).

      Unidad         : fblCuponCobro
      Descripcion    : Retorna true si el cupón debe generar un cobro por
                        Solicitud de Estado de Cuenta.
      Autor          :
      Fecha          : 29/10/2014

      Parametros              Descripcion
      ============         ===================
      inuCUPONUME          Identificador del cupón.

      Fecha             Autor             Modificacion
      =========       =========           ====================

      ******************************************************************/
	FUNCTION fblCuponCobro
	(
		inuCUPONUME in LD_CUPON_CAUSAL.CUPONUME%type default 1,
		inuRaiseError in number default 1
	)
    RETURN boolean
	IS
		rcError           styLD_CUPON_CAUSAL;
		nuPackage_id      number:=0;
		nuCausal_id       number:=0;
		nuCausalCobro     number:=0;
		nuPackage_type_id number:=0;
		blGeneraCobro     boolean := FALSE;
		nucausaldecobro   number := 0;

		CURSOR cucausaldecobro(nucausal_id number)
        IS
          select count(1)
            from dual
           where nucausal_id in
                 ((select to_number(column_value)
                    from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('CAUSALES_COBRO_DUPLICADO',
                                                                                             null),
                                                            ','))));
	BEGIN
        /*ut_trace.init;
        ut_trace.setlevel(99);
        ut_trace.setoutput(ut_trace.fntrace_output_db);*/
        if ((inuCUPONUME = 1) or (inuCUPONUME is null)) then
            return false;
        end if;

        ut_trace.trace('cupon entro a validar si aplica cobro al cupon',2);
        --rcError.CUPONUME := inuCUPONUME;

        -- Selecciona el tipo de paquete, la causal de la solicitud y el paquete.
        begin
            select a.package_id,
                    b.causal_id,
                    a.package_type_id
            into    nuPackage_id,
                    nuCausal_id,
                    nuPackage_type_id
            from    mo_packages a, mo_motive b
            where   a.package_type_id = 100006
            and     a.document_key = inuCUPONUME
            and     a.package_id = b.package_id;
        exception
            when no_data_found then
                return false;
        end;

        ut_trace.trace('cupon entro a validar si aplica nuPackage_id:'||nuPackage_id,2);
        ut_trace.trace('cupon entro a validar si aplica nuCausal_id:'||nuCausal_id,2);
        ut_trace.trace('cupon entro a validar si aplica nuPackage_type_id:'||nuPackage_type_id,2);

        -- COn la causal identifica si debe generar un cobro.
        -- Para esto, valida con el parámetro configurado en LD_PARAMETER(CAUSALES_COBRO_DUPLICADO).
        OPEN cucausaldecobro(nuCausal_id);
        FETCH cucausaldecobro INTO nucausaldecobro;
        close  cucausaldecobro;

        ut_trace.trace('cupon entro a validar si aplica nucausaldecobro:'||nucausaldecobro,2);

        -- Si el tipo de paquete es 100006 - Solicitud de estado de cuenta
        -- y si la solicitud se cerró con una causal que genera cobro, entonces TRUE
        if (nucausaldecobro != 0) then
            blGeneraCobro := TRUE;
            return blGeneraCobro;
        end if;

        return blGeneraCobro;

	EXCEPTION
		when no_data_found then
            blGeneraCobro := false;
            return blGeneraCobro;
        when others then
            if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,'No existe en mo_packages el cupón '||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
                return null;
			end if;
	END fblCuponCobro;

	/*****************************************************************
      Propiedad intelectual de PETI (c).

      Unidad         : fblExisteCargo
      Descripcion    : Retorna true si existe un cargo para el duplicado.
                        Aplica según la validación definida por ZPrada:
                        - Realizar una validación para generar el cobro una sola vez
                        y no generarlo si se expiden varias Solicitudes de Estado de Cuenta
                        para el mismo caso en el mismo día.
      Autor          : Paula Andrea García Rendón
      Fecha          : 29/10/2014

      Parametros              Descripcion
      ============         ===================
      inuCUPONUME          Identificador del cupón.

      Fecha             Autor             Modificacion
      =========       =========           ====================

      ******************************************************************/
	FUNCTION fblExisteCargo(inuCupon number, nuProduct number)
    return boolean
    is
        cursor cuCargo
        is
            select count(1)
            from cargos
            where cargnuse = nuProduct
            and cargdoso like 'DP-%'
            and cargcuco = -1
            and trunc(sysdate) = trunc(cargfecr);

        nuExiste number :=0;
    begin
        ut_trace.trace('-- PASO 7.x[] inicio ValExisteCargo', 15);

        open  cuCargo;
        fetch cuCargo into nuExiste;
        close cuCargo;

        if nuExiste <> 0 then
            ut_trace.trace('-- PASO 7.x[] Exite ValExisteCargo', 15);
            return true;
        else
            ut_trace.trace('-- PASO 7.x[] No existe ValExisteCargo', 15);
            return false;
        end if;

    EXCEPTION
        when no_data_found then
            return false;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
	END fblExisteCargo;


	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	) IS
	Begin
	    blDAO_USE_CACHE := iblUseCache;
	END;

begin
    GetDAO_USE_CACHE;
end DALD_CUPON_CAUSAL;
/
PROMPT Otorgando permisos de ejecucion a DALD_CUPON_CAUSAL
BEGIN
    pkg_utilidades.praplicarpermisos('DALD_CUPON_CAUSAL', 'ADM_PERSON');
END;
/