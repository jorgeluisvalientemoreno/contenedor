CREATE OR REPLACE PACKAGE ADM_PERSON.DALDC_CAUSAL_SSPD
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
		inuCAUSAL_SSPD_ID in LDC_CAUSAL_SSPD.CAUSAL_SSPD_ID%type
	)
	IS
		SELECT LDC_CAUSAL_SSPD.*,LDC_CAUSAL_SSPD.rowid
		FROM LDC_CAUSAL_SSPD
		WHERE
		    CAUSAL_SSPD_ID = inuCAUSAL_SSPD_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_CAUSAL_SSPD.*,LDC_CAUSAL_SSPD.rowid
		FROM LDC_CAUSAL_SSPD
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_CAUSAL_SSPD  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_CAUSAL_SSPD is table of styLDC_CAUSAL_SSPD index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_CAUSAL_SSPD;

	/* Tipos referenciando al registro */
	type tytbCAUSAL_SSPD_ID is table of LDC_CAUSAL_SSPD.CAUSAL_SSPD_ID%type index by binary_integer;
	type tytbCAUSAL_ID is table of LDC_CAUSAL_SSPD.CAUSAL_ID%type index by binary_integer;
	type tytbDESCRIPTION is table of LDC_CAUSAL_SSPD.DESCRIPTION%type index by binary_integer;
	type tytbENTE_REGULA is table of LDC_CAUSAL_SSPD.ENTE_REGULA%type index by binary_integer;
	type tytbRESOLUCION is table of LDC_CAUSAL_SSPD.RESOLUCION%type index by binary_integer;
	type tytbFEC_VIGEN_RESOL is table of LDC_CAUSAL_SSPD.FEC_VIGEN_RESOL%type index by binary_integer;
	type tytbACTIVO is table of LDC_CAUSAL_SSPD.ACTIVO%type index by binary_integer;
	type tytbUSUARIO is table of LDC_CAUSAL_SSPD.USUARIO%type index by binary_integer;
	type tytbFECHA_REGISTRO is table of LDC_CAUSAL_SSPD.FECHA_REGISTRO%type index by binary_integer;
	type tytbTERMINAL is table of LDC_CAUSAL_SSPD.TERMINAL%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_CAUSAL_SSPD is record
	(
		CAUSAL_SSPD_ID   tytbCAUSAL_SSPD_ID,
		CAUSAL_ID   tytbCAUSAL_ID,
		DESCRIPTION   tytbDESCRIPTION,
		ENTE_REGULA   tytbENTE_REGULA,
		RESOLUCION   tytbRESOLUCION,
		FEC_VIGEN_RESOL   tytbFEC_VIGEN_RESOL,
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
		inuCAUSAL_SSPD_ID in LDC_CAUSAL_SSPD.CAUSAL_SSPD_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuCAUSAL_SSPD_ID in LDC_CAUSAL_SSPD.CAUSAL_SSPD_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuCAUSAL_SSPD_ID in LDC_CAUSAL_SSPD.CAUSAL_SSPD_ID%type
	);

	PROCEDURE getRecord
	(
		inuCAUSAL_SSPD_ID in LDC_CAUSAL_SSPD.CAUSAL_SSPD_ID%type,
		orcRecord out nocopy styLDC_CAUSAL_SSPD
	);

	FUNCTION frcGetRcData
	(
		inuCAUSAL_SSPD_ID in LDC_CAUSAL_SSPD.CAUSAL_SSPD_ID%type
	)
	RETURN styLDC_CAUSAL_SSPD;

	FUNCTION frcGetRcData
	RETURN styLDC_CAUSAL_SSPD;

	FUNCTION frcGetRecord
	(
		inuCAUSAL_SSPD_ID in LDC_CAUSAL_SSPD.CAUSAL_SSPD_ID%type
	)
	RETURN styLDC_CAUSAL_SSPD;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_CAUSAL_SSPD
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_CAUSAL_SSPD in styLDC_CAUSAL_SSPD
	);

	PROCEDURE insRecord
	(
		ircLDC_CAUSAL_SSPD in styLDC_CAUSAL_SSPD,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_CAUSAL_SSPD in out nocopy tytbLDC_CAUSAL_SSPD
	);

	PROCEDURE delRecord
	(
		inuCAUSAL_SSPD_ID in LDC_CAUSAL_SSPD.CAUSAL_SSPD_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_CAUSAL_SSPD in out nocopy tytbLDC_CAUSAL_SSPD,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_CAUSAL_SSPD in styLDC_CAUSAL_SSPD,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_CAUSAL_SSPD in out nocopy tytbLDC_CAUSAL_SSPD,
		inuLock in number default 1
	);

	PROCEDURE updCAUSAL_ID
	(
		inuCAUSAL_SSPD_ID in LDC_CAUSAL_SSPD.CAUSAL_SSPD_ID%type,
		inuCAUSAL_ID$ in LDC_CAUSAL_SSPD.CAUSAL_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updDESCRIPTION
	(
		inuCAUSAL_SSPD_ID in LDC_CAUSAL_SSPD.CAUSAL_SSPD_ID%type,
		isbDESCRIPTION$ in LDC_CAUSAL_SSPD.DESCRIPTION%type,
		inuLock in number default 0
	);

	PROCEDURE updENTE_REGULA
	(
		inuCAUSAL_SSPD_ID in LDC_CAUSAL_SSPD.CAUSAL_SSPD_ID%type,
		isbENTE_REGULA$ in LDC_CAUSAL_SSPD.ENTE_REGULA%type,
		inuLock in number default 0
	);

	PROCEDURE updRESOLUCION
	(
		inuCAUSAL_SSPD_ID in LDC_CAUSAL_SSPD.CAUSAL_SSPD_ID%type,
		isbRESOLUCION$ in LDC_CAUSAL_SSPD.RESOLUCION%type,
		inuLock in number default 0
	);

	PROCEDURE updFEC_VIGEN_RESOL
	(
		inuCAUSAL_SSPD_ID in LDC_CAUSAL_SSPD.CAUSAL_SSPD_ID%type,
		idtFEC_VIGEN_RESOL$ in LDC_CAUSAL_SSPD.FEC_VIGEN_RESOL%type,
		inuLock in number default 0
	);

	PROCEDURE updACTIVO
	(
		inuCAUSAL_SSPD_ID in LDC_CAUSAL_SSPD.CAUSAL_SSPD_ID%type,
		isbACTIVO$ in LDC_CAUSAL_SSPD.ACTIVO%type,
		inuLock in number default 0
	);

	PROCEDURE updUSUARIO
	(
		inuCAUSAL_SSPD_ID in LDC_CAUSAL_SSPD.CAUSAL_SSPD_ID%type,
		isbUSUARIO$ in LDC_CAUSAL_SSPD.USUARIO%type,
		inuLock in number default 0
	);

	PROCEDURE updFECHA_REGISTRO
	(
		inuCAUSAL_SSPD_ID in LDC_CAUSAL_SSPD.CAUSAL_SSPD_ID%type,
		idtFECHA_REGISTRO$ in LDC_CAUSAL_SSPD.FECHA_REGISTRO%type,
		inuLock in number default 0
	);

	PROCEDURE updTERMINAL
	(
		inuCAUSAL_SSPD_ID in LDC_CAUSAL_SSPD.CAUSAL_SSPD_ID%type,
		isbTERMINAL$ in LDC_CAUSAL_SSPD.TERMINAL%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetCAUSAL_SSPD_ID
	(
		inuCAUSAL_SSPD_ID in LDC_CAUSAL_SSPD.CAUSAL_SSPD_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CAUSAL_SSPD.CAUSAL_SSPD_ID%type;

	FUNCTION fnuGetCAUSAL_ID
	(
		inuCAUSAL_SSPD_ID in LDC_CAUSAL_SSPD.CAUSAL_SSPD_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CAUSAL_SSPD.CAUSAL_ID%type;

	FUNCTION fsbGetDESCRIPTION
	(
		inuCAUSAL_SSPD_ID in LDC_CAUSAL_SSPD.CAUSAL_SSPD_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CAUSAL_SSPD.DESCRIPTION%type;

	FUNCTION fsbGetENTE_REGULA
	(
		inuCAUSAL_SSPD_ID in LDC_CAUSAL_SSPD.CAUSAL_SSPD_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CAUSAL_SSPD.ENTE_REGULA%type;

	FUNCTION fsbGetRESOLUCION
	(
		inuCAUSAL_SSPD_ID in LDC_CAUSAL_SSPD.CAUSAL_SSPD_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CAUSAL_SSPD.RESOLUCION%type;

	FUNCTION fdtGetFEC_VIGEN_RESOL
	(
		inuCAUSAL_SSPD_ID in LDC_CAUSAL_SSPD.CAUSAL_SSPD_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CAUSAL_SSPD.FEC_VIGEN_RESOL%type;

	FUNCTION fsbGetACTIVO
	(
		inuCAUSAL_SSPD_ID in LDC_CAUSAL_SSPD.CAUSAL_SSPD_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CAUSAL_SSPD.ACTIVO%type;

	FUNCTION fsbGetUSUARIO
	(
		inuCAUSAL_SSPD_ID in LDC_CAUSAL_SSPD.CAUSAL_SSPD_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CAUSAL_SSPD.USUARIO%type;

	FUNCTION fdtGetFECHA_REGISTRO
	(
		inuCAUSAL_SSPD_ID in LDC_CAUSAL_SSPD.CAUSAL_SSPD_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CAUSAL_SSPD.FECHA_REGISTRO%type;

	FUNCTION fsbGetTERMINAL
	(
		inuCAUSAL_SSPD_ID in LDC_CAUSAL_SSPD.CAUSAL_SSPD_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CAUSAL_SSPD.TERMINAL%type;


	PROCEDURE LockByPk
	(
		inuCAUSAL_SSPD_ID in LDC_CAUSAL_SSPD.CAUSAL_SSPD_ID%type,
		orcLDC_CAUSAL_SSPD  out styLDC_CAUSAL_SSPD
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_CAUSAL_SSPD  out styLDC_CAUSAL_SSPD
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_CAUSAL_SSPD;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALDC_CAUSAL_SSPD
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_CAUSAL_SSPD';
	 cnuGeEntityId constant varchar2(30) := 8718; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuCAUSAL_SSPD_ID in LDC_CAUSAL_SSPD.CAUSAL_SSPD_ID%type
	)
	IS
		SELECT LDC_CAUSAL_SSPD.*,LDC_CAUSAL_SSPD.rowid
		FROM LDC_CAUSAL_SSPD
		WHERE  CAUSAL_SSPD_ID = inuCAUSAL_SSPD_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_CAUSAL_SSPD.*,LDC_CAUSAL_SSPD.rowid
		FROM LDC_CAUSAL_SSPD
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_CAUSAL_SSPD is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_CAUSAL_SSPD;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_CAUSAL_SSPD default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.CAUSAL_SSPD_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuCAUSAL_SSPD_ID in LDC_CAUSAL_SSPD.CAUSAL_SSPD_ID%type,
		orcLDC_CAUSAL_SSPD  out styLDC_CAUSAL_SSPD
	)
	IS
		rcError styLDC_CAUSAL_SSPD;
	BEGIN
		rcError.CAUSAL_SSPD_ID := inuCAUSAL_SSPD_ID;

		Open cuLockRcByPk
		(
			inuCAUSAL_SSPD_ID
		);

		fetch cuLockRcByPk into orcLDC_CAUSAL_SSPD;
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
		orcLDC_CAUSAL_SSPD  out styLDC_CAUSAL_SSPD
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_CAUSAL_SSPD;
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
		itbLDC_CAUSAL_SSPD  in out nocopy tytbLDC_CAUSAL_SSPD
	)
	IS
	BEGIN
			rcRecOfTab.CAUSAL_SSPD_ID.delete;
			rcRecOfTab.CAUSAL_ID.delete;
			rcRecOfTab.DESCRIPTION.delete;
			rcRecOfTab.ENTE_REGULA.delete;
			rcRecOfTab.RESOLUCION.delete;
			rcRecOfTab.FEC_VIGEN_RESOL.delete;
			rcRecOfTab.ACTIVO.delete;
			rcRecOfTab.USUARIO.delete;
			rcRecOfTab.FECHA_REGISTRO.delete;
			rcRecOfTab.TERMINAL.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_CAUSAL_SSPD  in out nocopy tytbLDC_CAUSAL_SSPD,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_CAUSAL_SSPD);

		for n in itbLDC_CAUSAL_SSPD.first .. itbLDC_CAUSAL_SSPD.last loop
			rcRecOfTab.CAUSAL_SSPD_ID(n) := itbLDC_CAUSAL_SSPD(n).CAUSAL_SSPD_ID;
			rcRecOfTab.CAUSAL_ID(n) := itbLDC_CAUSAL_SSPD(n).CAUSAL_ID;
			rcRecOfTab.DESCRIPTION(n) := itbLDC_CAUSAL_SSPD(n).DESCRIPTION;
			rcRecOfTab.ENTE_REGULA(n) := itbLDC_CAUSAL_SSPD(n).ENTE_REGULA;
			rcRecOfTab.RESOLUCION(n) := itbLDC_CAUSAL_SSPD(n).RESOLUCION;
			rcRecOfTab.FEC_VIGEN_RESOL(n) := itbLDC_CAUSAL_SSPD(n).FEC_VIGEN_RESOL;
			rcRecOfTab.ACTIVO(n) := itbLDC_CAUSAL_SSPD(n).ACTIVO;
			rcRecOfTab.USUARIO(n) := itbLDC_CAUSAL_SSPD(n).USUARIO;
			rcRecOfTab.FECHA_REGISTRO(n) := itbLDC_CAUSAL_SSPD(n).FECHA_REGISTRO;
			rcRecOfTab.TERMINAL(n) := itbLDC_CAUSAL_SSPD(n).TERMINAL;
			rcRecOfTab.row_id(n) := itbLDC_CAUSAL_SSPD(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuCAUSAL_SSPD_ID in LDC_CAUSAL_SSPD.CAUSAL_SSPD_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuCAUSAL_SSPD_ID
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
		inuCAUSAL_SSPD_ID in LDC_CAUSAL_SSPD.CAUSAL_SSPD_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuCAUSAL_SSPD_ID = rcData.CAUSAL_SSPD_ID
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
		inuCAUSAL_SSPD_ID in LDC_CAUSAL_SSPD.CAUSAL_SSPD_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuCAUSAL_SSPD_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuCAUSAL_SSPD_ID in LDC_CAUSAL_SSPD.CAUSAL_SSPD_ID%type
	)
	IS
		rcError styLDC_CAUSAL_SSPD;
	BEGIN		rcError.CAUSAL_SSPD_ID:=inuCAUSAL_SSPD_ID;

		Load
		(
			inuCAUSAL_SSPD_ID
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
		inuCAUSAL_SSPD_ID in LDC_CAUSAL_SSPD.CAUSAL_SSPD_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuCAUSAL_SSPD_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuCAUSAL_SSPD_ID in LDC_CAUSAL_SSPD.CAUSAL_SSPD_ID%type,
		orcRecord out nocopy styLDC_CAUSAL_SSPD
	)
	IS
		rcError styLDC_CAUSAL_SSPD;
	BEGIN		rcError.CAUSAL_SSPD_ID:=inuCAUSAL_SSPD_ID;

		Load
		(
			inuCAUSAL_SSPD_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuCAUSAL_SSPD_ID in LDC_CAUSAL_SSPD.CAUSAL_SSPD_ID%type
	)
	RETURN styLDC_CAUSAL_SSPD
	IS
		rcError styLDC_CAUSAL_SSPD;
	BEGIN
		rcError.CAUSAL_SSPD_ID:=inuCAUSAL_SSPD_ID;

		Load
		(
			inuCAUSAL_SSPD_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuCAUSAL_SSPD_ID in LDC_CAUSAL_SSPD.CAUSAL_SSPD_ID%type
	)
	RETURN styLDC_CAUSAL_SSPD
	IS
		rcError styLDC_CAUSAL_SSPD;
	BEGIN
		rcError.CAUSAL_SSPD_ID:=inuCAUSAL_SSPD_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuCAUSAL_SSPD_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuCAUSAL_SSPD_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_CAUSAL_SSPD
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_CAUSAL_SSPD
	)
	IS
		rfLDC_CAUSAL_SSPD tyrfLDC_CAUSAL_SSPD;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_CAUSAL_SSPD.*, LDC_CAUSAL_SSPD.rowid FROM LDC_CAUSAL_SSPD';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_CAUSAL_SSPD for sbFullQuery;

		fetch rfLDC_CAUSAL_SSPD bulk collect INTO otbResult;

		close rfLDC_CAUSAL_SSPD;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_CAUSAL_SSPD.*, LDC_CAUSAL_SSPD.rowid FROM LDC_CAUSAL_SSPD';
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
		ircLDC_CAUSAL_SSPD in styLDC_CAUSAL_SSPD
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_CAUSAL_SSPD,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_CAUSAL_SSPD in styLDC_CAUSAL_SSPD,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_CAUSAL_SSPD.CAUSAL_SSPD_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|CAUSAL_SSPD_ID');
			raise ex.controlled_error;
		end if;

		insert into LDC_CAUSAL_SSPD
		(
			CAUSAL_SSPD_ID,
			CAUSAL_ID,
			DESCRIPTION,
			ENTE_REGULA,
			RESOLUCION,
			FEC_VIGEN_RESOL,
			ACTIVO,
			USUARIO,
			FECHA_REGISTRO,
			TERMINAL
		)
		values
		(
			ircLDC_CAUSAL_SSPD.CAUSAL_SSPD_ID,
			ircLDC_CAUSAL_SSPD.CAUSAL_ID,
			ircLDC_CAUSAL_SSPD.DESCRIPTION,
			ircLDC_CAUSAL_SSPD.ENTE_REGULA,
			ircLDC_CAUSAL_SSPD.RESOLUCION,
			ircLDC_CAUSAL_SSPD.FEC_VIGEN_RESOL,
			ircLDC_CAUSAL_SSPD.ACTIVO,
			ircLDC_CAUSAL_SSPD.USUARIO,
			ircLDC_CAUSAL_SSPD.FECHA_REGISTRO,
			ircLDC_CAUSAL_SSPD.TERMINAL
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_CAUSAL_SSPD));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_CAUSAL_SSPD in out nocopy tytbLDC_CAUSAL_SSPD
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_CAUSAL_SSPD,blUseRowID);
		forall n in iotbLDC_CAUSAL_SSPD.first..iotbLDC_CAUSAL_SSPD.last
			insert into LDC_CAUSAL_SSPD
			(
				CAUSAL_SSPD_ID,
				CAUSAL_ID,
				DESCRIPTION,
				ENTE_REGULA,
				RESOLUCION,
				FEC_VIGEN_RESOL,
				ACTIVO,
				USUARIO,
				FECHA_REGISTRO,
				TERMINAL
			)
			values
			(
				rcRecOfTab.CAUSAL_SSPD_ID(n),
				rcRecOfTab.CAUSAL_ID(n),
				rcRecOfTab.DESCRIPTION(n),
				rcRecOfTab.ENTE_REGULA(n),
				rcRecOfTab.RESOLUCION(n),
				rcRecOfTab.FEC_VIGEN_RESOL(n),
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
		inuCAUSAL_SSPD_ID in LDC_CAUSAL_SSPD.CAUSAL_SSPD_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_CAUSAL_SSPD;
	BEGIN
		rcError.CAUSAL_SSPD_ID := inuCAUSAL_SSPD_ID;

		if inuLock=1 then
			LockByPk
			(
				inuCAUSAL_SSPD_ID,
				rcData
			);
		end if;


		delete
		from LDC_CAUSAL_SSPD
		where
       		CAUSAL_SSPD_ID=inuCAUSAL_SSPD_ID;
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
		rcError  styLDC_CAUSAL_SSPD;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_CAUSAL_SSPD
		where
			rowid = iriRowID
		returning
			CAUSAL_SSPD_ID
		into
			rcError.CAUSAL_SSPD_ID;
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
		iotbLDC_CAUSAL_SSPD in out nocopy tytbLDC_CAUSAL_SSPD,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_CAUSAL_SSPD;
	BEGIN
		FillRecordOfTables(iotbLDC_CAUSAL_SSPD, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_CAUSAL_SSPD.first .. iotbLDC_CAUSAL_SSPD.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CAUSAL_SSPD.first .. iotbLDC_CAUSAL_SSPD.last
				delete
				from LDC_CAUSAL_SSPD
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_CAUSAL_SSPD.first .. iotbLDC_CAUSAL_SSPD.last loop
					LockByPk
					(
						rcRecOfTab.CAUSAL_SSPD_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CAUSAL_SSPD.first .. iotbLDC_CAUSAL_SSPD.last
				delete
				from LDC_CAUSAL_SSPD
				where
		         	CAUSAL_SSPD_ID = rcRecOfTab.CAUSAL_SSPD_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_CAUSAL_SSPD in styLDC_CAUSAL_SSPD,
		inuLock in number default 0
	)
	IS
		nuCAUSAL_SSPD_ID	LDC_CAUSAL_SSPD.CAUSAL_SSPD_ID%type;
	BEGIN
		if ircLDC_CAUSAL_SSPD.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_CAUSAL_SSPD.rowid,rcData);
			end if;
			update LDC_CAUSAL_SSPD
			set
				CAUSAL_ID = ircLDC_CAUSAL_SSPD.CAUSAL_ID,
				DESCRIPTION = ircLDC_CAUSAL_SSPD.DESCRIPTION,
				ENTE_REGULA = ircLDC_CAUSAL_SSPD.ENTE_REGULA,
				RESOLUCION = ircLDC_CAUSAL_SSPD.RESOLUCION,
				FEC_VIGEN_RESOL = ircLDC_CAUSAL_SSPD.FEC_VIGEN_RESOL,
				ACTIVO = ircLDC_CAUSAL_SSPD.ACTIVO,
				USUARIO = ircLDC_CAUSAL_SSPD.USUARIO,
				FECHA_REGISTRO = ircLDC_CAUSAL_SSPD.FECHA_REGISTRO,
				TERMINAL = ircLDC_CAUSAL_SSPD.TERMINAL
			where
				rowid = ircLDC_CAUSAL_SSPD.rowid
			returning
				CAUSAL_SSPD_ID
			into
				nuCAUSAL_SSPD_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_CAUSAL_SSPD.CAUSAL_SSPD_ID,
					rcData
				);
			end if;

			update LDC_CAUSAL_SSPD
			set
				CAUSAL_ID = ircLDC_CAUSAL_SSPD.CAUSAL_ID,
				DESCRIPTION = ircLDC_CAUSAL_SSPD.DESCRIPTION,
				ENTE_REGULA = ircLDC_CAUSAL_SSPD.ENTE_REGULA,
				RESOLUCION = ircLDC_CAUSAL_SSPD.RESOLUCION,
				FEC_VIGEN_RESOL = ircLDC_CAUSAL_SSPD.FEC_VIGEN_RESOL,
				ACTIVO = ircLDC_CAUSAL_SSPD.ACTIVO,
				USUARIO = ircLDC_CAUSAL_SSPD.USUARIO,
				FECHA_REGISTRO = ircLDC_CAUSAL_SSPD.FECHA_REGISTRO,
				TERMINAL = ircLDC_CAUSAL_SSPD.TERMINAL
			where
				CAUSAL_SSPD_ID = ircLDC_CAUSAL_SSPD.CAUSAL_SSPD_ID
			returning
				CAUSAL_SSPD_ID
			into
				nuCAUSAL_SSPD_ID;
		end if;
		if
			nuCAUSAL_SSPD_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_CAUSAL_SSPD));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_CAUSAL_SSPD in out nocopy tytbLDC_CAUSAL_SSPD,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_CAUSAL_SSPD;
	BEGIN
		FillRecordOfTables(iotbLDC_CAUSAL_SSPD,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_CAUSAL_SSPD.first .. iotbLDC_CAUSAL_SSPD.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CAUSAL_SSPD.first .. iotbLDC_CAUSAL_SSPD.last
				update LDC_CAUSAL_SSPD
				set
					CAUSAL_ID = rcRecOfTab.CAUSAL_ID(n),
					DESCRIPTION = rcRecOfTab.DESCRIPTION(n),
					ENTE_REGULA = rcRecOfTab.ENTE_REGULA(n),
					RESOLUCION = rcRecOfTab.RESOLUCION(n),
					FEC_VIGEN_RESOL = rcRecOfTab.FEC_VIGEN_RESOL(n),
					ACTIVO = rcRecOfTab.ACTIVO(n),
					USUARIO = rcRecOfTab.USUARIO(n),
					FECHA_REGISTRO = rcRecOfTab.FECHA_REGISTRO(n),
					TERMINAL = rcRecOfTab.TERMINAL(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_CAUSAL_SSPD.first .. iotbLDC_CAUSAL_SSPD.last loop
					LockByPk
					(
						rcRecOfTab.CAUSAL_SSPD_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CAUSAL_SSPD.first .. iotbLDC_CAUSAL_SSPD.last
				update LDC_CAUSAL_SSPD
				SET
					CAUSAL_ID = rcRecOfTab.CAUSAL_ID(n),
					DESCRIPTION = rcRecOfTab.DESCRIPTION(n),
					ENTE_REGULA = rcRecOfTab.ENTE_REGULA(n),
					RESOLUCION = rcRecOfTab.RESOLUCION(n),
					FEC_VIGEN_RESOL = rcRecOfTab.FEC_VIGEN_RESOL(n),
					ACTIVO = rcRecOfTab.ACTIVO(n),
					USUARIO = rcRecOfTab.USUARIO(n),
					FECHA_REGISTRO = rcRecOfTab.FECHA_REGISTRO(n),
					TERMINAL = rcRecOfTab.TERMINAL(n)
				where
					CAUSAL_SSPD_ID = rcRecOfTab.CAUSAL_SSPD_ID(n)
;
		end if;
	END;
	PROCEDURE updCAUSAL_ID
	(
		inuCAUSAL_SSPD_ID in LDC_CAUSAL_SSPD.CAUSAL_SSPD_ID%type,
		inuCAUSAL_ID$ in LDC_CAUSAL_SSPD.CAUSAL_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CAUSAL_SSPD;
	BEGIN
		rcError.CAUSAL_SSPD_ID := inuCAUSAL_SSPD_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCAUSAL_SSPD_ID,
				rcData
			);
		end if;

		update LDC_CAUSAL_SSPD
		set
			CAUSAL_ID = inuCAUSAL_ID$
		where
			CAUSAL_SSPD_ID = inuCAUSAL_SSPD_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CAUSAL_ID:= inuCAUSAL_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updDESCRIPTION
	(
		inuCAUSAL_SSPD_ID in LDC_CAUSAL_SSPD.CAUSAL_SSPD_ID%type,
		isbDESCRIPTION$ in LDC_CAUSAL_SSPD.DESCRIPTION%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CAUSAL_SSPD;
	BEGIN
		rcError.CAUSAL_SSPD_ID := inuCAUSAL_SSPD_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCAUSAL_SSPD_ID,
				rcData
			);
		end if;

		update LDC_CAUSAL_SSPD
		set
			DESCRIPTION = isbDESCRIPTION$
		where
			CAUSAL_SSPD_ID = inuCAUSAL_SSPD_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DESCRIPTION:= isbDESCRIPTION$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updENTE_REGULA
	(
		inuCAUSAL_SSPD_ID in LDC_CAUSAL_SSPD.CAUSAL_SSPD_ID%type,
		isbENTE_REGULA$ in LDC_CAUSAL_SSPD.ENTE_REGULA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CAUSAL_SSPD;
	BEGIN
		rcError.CAUSAL_SSPD_ID := inuCAUSAL_SSPD_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCAUSAL_SSPD_ID,
				rcData
			);
		end if;

		update LDC_CAUSAL_SSPD
		set
			ENTE_REGULA = isbENTE_REGULA$
		where
			CAUSAL_SSPD_ID = inuCAUSAL_SSPD_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ENTE_REGULA:= isbENTE_REGULA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRESOLUCION
	(
		inuCAUSAL_SSPD_ID in LDC_CAUSAL_SSPD.CAUSAL_SSPD_ID%type,
		isbRESOLUCION$ in LDC_CAUSAL_SSPD.RESOLUCION%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CAUSAL_SSPD;
	BEGIN
		rcError.CAUSAL_SSPD_ID := inuCAUSAL_SSPD_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCAUSAL_SSPD_ID,
				rcData
			);
		end if;

		update LDC_CAUSAL_SSPD
		set
			RESOLUCION = isbRESOLUCION$
		where
			CAUSAL_SSPD_ID = inuCAUSAL_SSPD_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.RESOLUCION:= isbRESOLUCION$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFEC_VIGEN_RESOL
	(
		inuCAUSAL_SSPD_ID in LDC_CAUSAL_SSPD.CAUSAL_SSPD_ID%type,
		idtFEC_VIGEN_RESOL$ in LDC_CAUSAL_SSPD.FEC_VIGEN_RESOL%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CAUSAL_SSPD;
	BEGIN
		rcError.CAUSAL_SSPD_ID := inuCAUSAL_SSPD_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCAUSAL_SSPD_ID,
				rcData
			);
		end if;

		update LDC_CAUSAL_SSPD
		set
			FEC_VIGEN_RESOL = idtFEC_VIGEN_RESOL$
		where
			CAUSAL_SSPD_ID = inuCAUSAL_SSPD_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FEC_VIGEN_RESOL:= idtFEC_VIGEN_RESOL$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updACTIVO
	(
		inuCAUSAL_SSPD_ID in LDC_CAUSAL_SSPD.CAUSAL_SSPD_ID%type,
		isbACTIVO$ in LDC_CAUSAL_SSPD.ACTIVO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CAUSAL_SSPD;
	BEGIN
		rcError.CAUSAL_SSPD_ID := inuCAUSAL_SSPD_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCAUSAL_SSPD_ID,
				rcData
			);
		end if;

		update LDC_CAUSAL_SSPD
		set
			ACTIVO = isbACTIVO$
		where
			CAUSAL_SSPD_ID = inuCAUSAL_SSPD_ID;

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
		inuCAUSAL_SSPD_ID in LDC_CAUSAL_SSPD.CAUSAL_SSPD_ID%type,
		isbUSUARIO$ in LDC_CAUSAL_SSPD.USUARIO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CAUSAL_SSPD;
	BEGIN
		rcError.CAUSAL_SSPD_ID := inuCAUSAL_SSPD_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCAUSAL_SSPD_ID,
				rcData
			);
		end if;

		update LDC_CAUSAL_SSPD
		set
			USUARIO = isbUSUARIO$
		where
			CAUSAL_SSPD_ID = inuCAUSAL_SSPD_ID;

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
		inuCAUSAL_SSPD_ID in LDC_CAUSAL_SSPD.CAUSAL_SSPD_ID%type,
		idtFECHA_REGISTRO$ in LDC_CAUSAL_SSPD.FECHA_REGISTRO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CAUSAL_SSPD;
	BEGIN
		rcError.CAUSAL_SSPD_ID := inuCAUSAL_SSPD_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCAUSAL_SSPD_ID,
				rcData
			);
		end if;

		update LDC_CAUSAL_SSPD
		set
			FECHA_REGISTRO = idtFECHA_REGISTRO$
		where
			CAUSAL_SSPD_ID = inuCAUSAL_SSPD_ID;

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
		inuCAUSAL_SSPD_ID in LDC_CAUSAL_SSPD.CAUSAL_SSPD_ID%type,
		isbTERMINAL$ in LDC_CAUSAL_SSPD.TERMINAL%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CAUSAL_SSPD;
	BEGIN
		rcError.CAUSAL_SSPD_ID := inuCAUSAL_SSPD_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCAUSAL_SSPD_ID,
				rcData
			);
		end if;

		update LDC_CAUSAL_SSPD
		set
			TERMINAL = isbTERMINAL$
		where
			CAUSAL_SSPD_ID = inuCAUSAL_SSPD_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TERMINAL:= isbTERMINAL$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetCAUSAL_SSPD_ID
	(
		inuCAUSAL_SSPD_ID in LDC_CAUSAL_SSPD.CAUSAL_SSPD_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CAUSAL_SSPD.CAUSAL_SSPD_ID%type
	IS
		rcError styLDC_CAUSAL_SSPD;
	BEGIN

		rcError.CAUSAL_SSPD_ID := inuCAUSAL_SSPD_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCAUSAL_SSPD_ID
			 )
		then
			 return(rcData.CAUSAL_SSPD_ID);
		end if;
		Load
		(
		 		inuCAUSAL_SSPD_ID
		);
		return(rcData.CAUSAL_SSPD_ID);
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
		inuCAUSAL_SSPD_ID in LDC_CAUSAL_SSPD.CAUSAL_SSPD_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CAUSAL_SSPD.CAUSAL_ID%type
	IS
		rcError styLDC_CAUSAL_SSPD;
	BEGIN

		rcError.CAUSAL_SSPD_ID := inuCAUSAL_SSPD_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCAUSAL_SSPD_ID
			 )
		then
			 return(rcData.CAUSAL_ID);
		end if;
		Load
		(
		 		inuCAUSAL_SSPD_ID
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
	FUNCTION fsbGetDESCRIPTION
	(
		inuCAUSAL_SSPD_ID in LDC_CAUSAL_SSPD.CAUSAL_SSPD_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CAUSAL_SSPD.DESCRIPTION%type
	IS
		rcError styLDC_CAUSAL_SSPD;
	BEGIN

		rcError.CAUSAL_SSPD_ID := inuCAUSAL_SSPD_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCAUSAL_SSPD_ID
			 )
		then
			 return(rcData.DESCRIPTION);
		end if;
		Load
		(
		 		inuCAUSAL_SSPD_ID
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
	FUNCTION fsbGetENTE_REGULA
	(
		inuCAUSAL_SSPD_ID in LDC_CAUSAL_SSPD.CAUSAL_SSPD_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CAUSAL_SSPD.ENTE_REGULA%type
	IS
		rcError styLDC_CAUSAL_SSPD;
	BEGIN

		rcError.CAUSAL_SSPD_ID := inuCAUSAL_SSPD_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCAUSAL_SSPD_ID
			 )
		then
			 return(rcData.ENTE_REGULA);
		end if;
		Load
		(
		 		inuCAUSAL_SSPD_ID
		);
		return(rcData.ENTE_REGULA);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetRESOLUCION
	(
		inuCAUSAL_SSPD_ID in LDC_CAUSAL_SSPD.CAUSAL_SSPD_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CAUSAL_SSPD.RESOLUCION%type
	IS
		rcError styLDC_CAUSAL_SSPD;
	BEGIN

		rcError.CAUSAL_SSPD_ID := inuCAUSAL_SSPD_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCAUSAL_SSPD_ID
			 )
		then
			 return(rcData.RESOLUCION);
		end if;
		Load
		(
		 		inuCAUSAL_SSPD_ID
		);
		return(rcData.RESOLUCION);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetFEC_VIGEN_RESOL
	(
		inuCAUSAL_SSPD_ID in LDC_CAUSAL_SSPD.CAUSAL_SSPD_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CAUSAL_SSPD.FEC_VIGEN_RESOL%type
	IS
		rcError styLDC_CAUSAL_SSPD;
	BEGIN

		rcError.CAUSAL_SSPD_ID := inuCAUSAL_SSPD_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCAUSAL_SSPD_ID
			 )
		then
			 return(rcData.FEC_VIGEN_RESOL);
		end if;
		Load
		(
		 		inuCAUSAL_SSPD_ID
		);
		return(rcData.FEC_VIGEN_RESOL);
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
		inuCAUSAL_SSPD_ID in LDC_CAUSAL_SSPD.CAUSAL_SSPD_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CAUSAL_SSPD.ACTIVO%type
	IS
		rcError styLDC_CAUSAL_SSPD;
	BEGIN

		rcError.CAUSAL_SSPD_ID := inuCAUSAL_SSPD_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCAUSAL_SSPD_ID
			 )
		then
			 return(rcData.ACTIVO);
		end if;
		Load
		(
		 		inuCAUSAL_SSPD_ID
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
		inuCAUSAL_SSPD_ID in LDC_CAUSAL_SSPD.CAUSAL_SSPD_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CAUSAL_SSPD.USUARIO%type
	IS
		rcError styLDC_CAUSAL_SSPD;
	BEGIN

		rcError.CAUSAL_SSPD_ID := inuCAUSAL_SSPD_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCAUSAL_SSPD_ID
			 )
		then
			 return(rcData.USUARIO);
		end if;
		Load
		(
		 		inuCAUSAL_SSPD_ID
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
		inuCAUSAL_SSPD_ID in LDC_CAUSAL_SSPD.CAUSAL_SSPD_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CAUSAL_SSPD.FECHA_REGISTRO%type
	IS
		rcError styLDC_CAUSAL_SSPD;
	BEGIN

		rcError.CAUSAL_SSPD_ID := inuCAUSAL_SSPD_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCAUSAL_SSPD_ID
			 )
		then
			 return(rcData.FECHA_REGISTRO);
		end if;
		Load
		(
		 		inuCAUSAL_SSPD_ID
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
		inuCAUSAL_SSPD_ID in LDC_CAUSAL_SSPD.CAUSAL_SSPD_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CAUSAL_SSPD.TERMINAL%type
	IS
		rcError styLDC_CAUSAL_SSPD;
	BEGIN

		rcError.CAUSAL_SSPD_ID := inuCAUSAL_SSPD_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCAUSAL_SSPD_ID
			 )
		then
			 return(rcData.TERMINAL);
		end if;
		Load
		(
		 		inuCAUSAL_SSPD_ID
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
end DALDC_CAUSAL_SSPD;
/
PROMPT Otorgando permisos de ejecucion a DALDC_CAUSAL_SSPD
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_CAUSAL_SSPD', 'ADM_PERSON');
END;
/