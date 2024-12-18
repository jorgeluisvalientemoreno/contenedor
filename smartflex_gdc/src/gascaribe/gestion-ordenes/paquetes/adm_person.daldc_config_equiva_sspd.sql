CREATE OR REPLACE PACKAGE ADM_PERSON.DALDC_CONFIG_EQUIVA_SSPD
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
		inuCONF_EQUIV_SSPD_ID in LDC_CONFIG_EQUIVA_SSPD.CONF_EQUIV_SSPD_ID%type
	)
	IS
		SELECT LDC_CONFIG_EQUIVA_SSPD.*,LDC_CONFIG_EQUIVA_SSPD.rowid
		FROM LDC_CONFIG_EQUIVA_SSPD
		WHERE
		    CONF_EQUIV_SSPD_ID = inuCONF_EQUIV_SSPD_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_CONFIG_EQUIVA_SSPD.*,LDC_CONFIG_EQUIVA_SSPD.rowid
		FROM LDC_CONFIG_EQUIVA_SSPD
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_CONFIG_EQUIVA_SSPD  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_CONFIG_EQUIVA_SSPD is table of styLDC_CONFIG_EQUIVA_SSPD index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_CONFIG_EQUIVA_SSPD;

	/* Tipos referenciando al registro */
	type tytbCONF_EQUIV_SSPD_ID is table of LDC_CONFIG_EQUIVA_SSPD.CONF_EQUIV_SSPD_ID%type index by binary_integer;
	type tytbATECLIREPO_ID is table of LDC_CONFIG_EQUIVA_SSPD.ATECLIREPO_ID%type index by binary_integer;
	type tytbTIPO_SOLICITUD is table of LDC_CONFIG_EQUIVA_SSPD.TIPO_SOLICITUD%type index by binary_integer;
	type tytbRESP_SOL_OSF is table of LDC_CONFIG_EQUIVA_SSPD.RESP_SOL_OSF%type index by binary_integer;
	type tytbTIPO_RESPUESTA is table of LDC_CONFIG_EQUIVA_SSPD.TIPO_RESPUESTA%type index by binary_integer;
	type tytbCAUSAL_EQUIV_SSPD is table of LDC_CONFIG_EQUIVA_SSPD.CAUSAL_EQUIV_SSPD%type index by binary_integer;
	type tytbDESCRIPCION is table of LDC_CONFIG_EQUIVA_SSPD.DESCRIPCION%type index by binary_integer;
	type tytbAPLICA_ITANSUCA is table of LDC_CONFIG_EQUIVA_SSPD.APLICA_ITANSUCA%type index by binary_integer;
	type tytbFORMATO is table of LDC_CONFIG_EQUIVA_SSPD.FORMATO%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_CONFIG_EQUIVA_SSPD is record
	(
		CONF_EQUIV_SSPD_ID   tytbCONF_EQUIV_SSPD_ID,
		ATECLIREPO_ID   tytbATECLIREPO_ID,
		TIPO_SOLICITUD   tytbTIPO_SOLICITUD,
		RESP_SOL_OSF   tytbRESP_SOL_OSF,
		TIPO_RESPUESTA   tytbTIPO_RESPUESTA,
		CAUSAL_EQUIV_SSPD   tytbCAUSAL_EQUIV_SSPD,
		DESCRIPCION   tytbDESCRIPCION,
		APLICA_ITANSUCA   tytbAPLICA_ITANSUCA,
		FORMATO   tytbFORMATO,
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
		inuCONF_EQUIV_SSPD_ID in LDC_CONFIG_EQUIVA_SSPD.CONF_EQUIV_SSPD_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuCONF_EQUIV_SSPD_ID in LDC_CONFIG_EQUIVA_SSPD.CONF_EQUIV_SSPD_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuCONF_EQUIV_SSPD_ID in LDC_CONFIG_EQUIVA_SSPD.CONF_EQUIV_SSPD_ID%type
	);

	PROCEDURE getRecord
	(
		inuCONF_EQUIV_SSPD_ID in LDC_CONFIG_EQUIVA_SSPD.CONF_EQUIV_SSPD_ID%type,
		orcRecord out nocopy styLDC_CONFIG_EQUIVA_SSPD
	);

	FUNCTION frcGetRcData
	(
		inuCONF_EQUIV_SSPD_ID in LDC_CONFIG_EQUIVA_SSPD.CONF_EQUIV_SSPD_ID%type
	)
	RETURN styLDC_CONFIG_EQUIVA_SSPD;

	FUNCTION frcGetRcData
	RETURN styLDC_CONFIG_EQUIVA_SSPD;

	FUNCTION frcGetRecord
	(
		inuCONF_EQUIV_SSPD_ID in LDC_CONFIG_EQUIVA_SSPD.CONF_EQUIV_SSPD_ID%type
	)
	RETURN styLDC_CONFIG_EQUIVA_SSPD;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_CONFIG_EQUIVA_SSPD
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_CONFIG_EQUIVA_SSPD in styLDC_CONFIG_EQUIVA_SSPD
	);

	PROCEDURE insRecord
	(
		ircLDC_CONFIG_EQUIVA_SSPD in styLDC_CONFIG_EQUIVA_SSPD,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_CONFIG_EQUIVA_SSPD in out nocopy tytbLDC_CONFIG_EQUIVA_SSPD
	);

	PROCEDURE delRecord
	(
		inuCONF_EQUIV_SSPD_ID in LDC_CONFIG_EQUIVA_SSPD.CONF_EQUIV_SSPD_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_CONFIG_EQUIVA_SSPD in out nocopy tytbLDC_CONFIG_EQUIVA_SSPD,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_CONFIG_EQUIVA_SSPD in styLDC_CONFIG_EQUIVA_SSPD,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_CONFIG_EQUIVA_SSPD in out nocopy tytbLDC_CONFIG_EQUIVA_SSPD,
		inuLock in number default 1
	);

	PROCEDURE updATECLIREPO_ID
	(
		inuCONF_EQUIV_SSPD_ID in LDC_CONFIG_EQUIVA_SSPD.CONF_EQUIV_SSPD_ID%type,
		inuATECLIREPO_ID$ in LDC_CONFIG_EQUIVA_SSPD.ATECLIREPO_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updTIPO_SOLICITUD
	(
		inuCONF_EQUIV_SSPD_ID in LDC_CONFIG_EQUIVA_SSPD.CONF_EQUIV_SSPD_ID%type,
		inuTIPO_SOLICITUD$ in LDC_CONFIG_EQUIVA_SSPD.TIPO_SOLICITUD%type,
		inuLock in number default 0
	);

	PROCEDURE updRESP_SOL_OSF
	(
		inuCONF_EQUIV_SSPD_ID in LDC_CONFIG_EQUIVA_SSPD.CONF_EQUIV_SSPD_ID%type,
		inuRESP_SOL_OSF$ in LDC_CONFIG_EQUIVA_SSPD.RESP_SOL_OSF%type,
		inuLock in number default 0
	);

	PROCEDURE updTIPO_RESPUESTA
	(
		inuCONF_EQUIV_SSPD_ID in LDC_CONFIG_EQUIVA_SSPD.CONF_EQUIV_SSPD_ID%type,
		inuTIPO_RESPUESTA$ in LDC_CONFIG_EQUIVA_SSPD.TIPO_RESPUESTA%type,
		inuLock in number default 0
	);

	PROCEDURE updCAUSAL_EQUIV_SSPD
	(
		inuCONF_EQUIV_SSPD_ID in LDC_CONFIG_EQUIVA_SSPD.CONF_EQUIV_SSPD_ID%type,
		inuCAUSAL_EQUIV_SSPD$ in LDC_CONFIG_EQUIVA_SSPD.CAUSAL_EQUIV_SSPD%type,
		inuLock in number default 0
	);

	PROCEDURE updDESCRIPCION
	(
		inuCONF_EQUIV_SSPD_ID in LDC_CONFIG_EQUIVA_SSPD.CONF_EQUIV_SSPD_ID%type,
		isbDESCRIPCION$ in LDC_CONFIG_EQUIVA_SSPD.DESCRIPCION%type,
		inuLock in number default 0
	);

	PROCEDURE updAPLICA_ITANSUCA
	(
		inuCONF_EQUIV_SSPD_ID in LDC_CONFIG_EQUIVA_SSPD.CONF_EQUIV_SSPD_ID%type,
		isbAPLICA_ITANSUCA$ in LDC_CONFIG_EQUIVA_SSPD.APLICA_ITANSUCA%type,
		inuLock in number default 0
	);

	PROCEDURE updFORMATO
	(
		inuCONF_EQUIV_SSPD_ID in LDC_CONFIG_EQUIVA_SSPD.CONF_EQUIV_SSPD_ID%type,
		isbFORMATO$ in LDC_CONFIG_EQUIVA_SSPD.FORMATO%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetCONF_EQUIV_SSPD_ID
	(
		inuCONF_EQUIV_SSPD_ID in LDC_CONFIG_EQUIVA_SSPD.CONF_EQUIV_SSPD_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONFIG_EQUIVA_SSPD.CONF_EQUIV_SSPD_ID%type;

	FUNCTION fnuGetATECLIREPO_ID
	(
		inuCONF_EQUIV_SSPD_ID in LDC_CONFIG_EQUIVA_SSPD.CONF_EQUIV_SSPD_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONFIG_EQUIVA_SSPD.ATECLIREPO_ID%type;

	FUNCTION fnuGetTIPO_SOLICITUD
	(
		inuCONF_EQUIV_SSPD_ID in LDC_CONFIG_EQUIVA_SSPD.CONF_EQUIV_SSPD_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONFIG_EQUIVA_SSPD.TIPO_SOLICITUD%type;

	FUNCTION fnuGetRESP_SOL_OSF
	(
		inuCONF_EQUIV_SSPD_ID in LDC_CONFIG_EQUIVA_SSPD.CONF_EQUIV_SSPD_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONFIG_EQUIVA_SSPD.RESP_SOL_OSF%type;

	FUNCTION fnuGetTIPO_RESPUESTA
	(
		inuCONF_EQUIV_SSPD_ID in LDC_CONFIG_EQUIVA_SSPD.CONF_EQUIV_SSPD_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONFIG_EQUIVA_SSPD.TIPO_RESPUESTA%type;

	FUNCTION fnuGetCAUSAL_EQUIV_SSPD
	(
		inuCONF_EQUIV_SSPD_ID in LDC_CONFIG_EQUIVA_SSPD.CONF_EQUIV_SSPD_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONFIG_EQUIVA_SSPD.CAUSAL_EQUIV_SSPD%type;

	FUNCTION fsbGetDESCRIPCION
	(
		inuCONF_EQUIV_SSPD_ID in LDC_CONFIG_EQUIVA_SSPD.CONF_EQUIV_SSPD_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONFIG_EQUIVA_SSPD.DESCRIPCION%type;

	FUNCTION fsbGetAPLICA_ITANSUCA
	(
		inuCONF_EQUIV_SSPD_ID in LDC_CONFIG_EQUIVA_SSPD.CONF_EQUIV_SSPD_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONFIG_EQUIVA_SSPD.APLICA_ITANSUCA%type;

	FUNCTION fsbGetFORMATO
	(
		inuCONF_EQUIV_SSPD_ID in LDC_CONFIG_EQUIVA_SSPD.CONF_EQUIV_SSPD_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONFIG_EQUIVA_SSPD.FORMATO%type;


	PROCEDURE LockByPk
	(
		inuCONF_EQUIV_SSPD_ID in LDC_CONFIG_EQUIVA_SSPD.CONF_EQUIV_SSPD_ID%type,
		orcLDC_CONFIG_EQUIVA_SSPD  out styLDC_CONFIG_EQUIVA_SSPD
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_CONFIG_EQUIVA_SSPD  out styLDC_CONFIG_EQUIVA_SSPD
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_CONFIG_EQUIVA_SSPD;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALDC_CONFIG_EQUIVA_SSPD
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_CONFIG_EQUIVA_SSPD';
	 cnuGeEntityId constant varchar2(30) := 8779; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuCONF_EQUIV_SSPD_ID in LDC_CONFIG_EQUIVA_SSPD.CONF_EQUIV_SSPD_ID%type
	)
	IS
		SELECT LDC_CONFIG_EQUIVA_SSPD.*,LDC_CONFIG_EQUIVA_SSPD.rowid
		FROM LDC_CONFIG_EQUIVA_SSPD
		WHERE  CONF_EQUIV_SSPD_ID = inuCONF_EQUIV_SSPD_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_CONFIG_EQUIVA_SSPD.*,LDC_CONFIG_EQUIVA_SSPD.rowid
		FROM LDC_CONFIG_EQUIVA_SSPD
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_CONFIG_EQUIVA_SSPD is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_CONFIG_EQUIVA_SSPD;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_CONFIG_EQUIVA_SSPD default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.CONF_EQUIV_SSPD_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuCONF_EQUIV_SSPD_ID in LDC_CONFIG_EQUIVA_SSPD.CONF_EQUIV_SSPD_ID%type,
		orcLDC_CONFIG_EQUIVA_SSPD  out styLDC_CONFIG_EQUIVA_SSPD
	)
	IS
		rcError styLDC_CONFIG_EQUIVA_SSPD;
	BEGIN
		rcError.CONF_EQUIV_SSPD_ID := inuCONF_EQUIV_SSPD_ID;

		Open cuLockRcByPk
		(
			inuCONF_EQUIV_SSPD_ID
		);

		fetch cuLockRcByPk into orcLDC_CONFIG_EQUIVA_SSPD;
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
		orcLDC_CONFIG_EQUIVA_SSPD  out styLDC_CONFIG_EQUIVA_SSPD
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_CONFIG_EQUIVA_SSPD;
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
		itbLDC_CONFIG_EQUIVA_SSPD  in out nocopy tytbLDC_CONFIG_EQUIVA_SSPD
	)
	IS
	BEGIN
			rcRecOfTab.CONF_EQUIV_SSPD_ID.delete;
			rcRecOfTab.ATECLIREPO_ID.delete;
			rcRecOfTab.TIPO_SOLICITUD.delete;
			rcRecOfTab.RESP_SOL_OSF.delete;
			rcRecOfTab.TIPO_RESPUESTA.delete;
			rcRecOfTab.CAUSAL_EQUIV_SSPD.delete;
			rcRecOfTab.DESCRIPCION.delete;
			rcRecOfTab.APLICA_ITANSUCA.delete;
			rcRecOfTab.FORMATO.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_CONFIG_EQUIVA_SSPD  in out nocopy tytbLDC_CONFIG_EQUIVA_SSPD,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_CONFIG_EQUIVA_SSPD);

		for n in itbLDC_CONFIG_EQUIVA_SSPD.first .. itbLDC_CONFIG_EQUIVA_SSPD.last loop
			rcRecOfTab.CONF_EQUIV_SSPD_ID(n) := itbLDC_CONFIG_EQUIVA_SSPD(n).CONF_EQUIV_SSPD_ID;
			rcRecOfTab.ATECLIREPO_ID(n) := itbLDC_CONFIG_EQUIVA_SSPD(n).ATECLIREPO_ID;
			rcRecOfTab.TIPO_SOLICITUD(n) := itbLDC_CONFIG_EQUIVA_SSPD(n).TIPO_SOLICITUD;
			rcRecOfTab.RESP_SOL_OSF(n) := itbLDC_CONFIG_EQUIVA_SSPD(n).RESP_SOL_OSF;
			rcRecOfTab.TIPO_RESPUESTA(n) := itbLDC_CONFIG_EQUIVA_SSPD(n).TIPO_RESPUESTA;
			rcRecOfTab.CAUSAL_EQUIV_SSPD(n) := itbLDC_CONFIG_EQUIVA_SSPD(n).CAUSAL_EQUIV_SSPD;
			rcRecOfTab.DESCRIPCION(n) := itbLDC_CONFIG_EQUIVA_SSPD(n).DESCRIPCION;
			rcRecOfTab.APLICA_ITANSUCA(n) := itbLDC_CONFIG_EQUIVA_SSPD(n).APLICA_ITANSUCA;
			rcRecOfTab.FORMATO(n) := itbLDC_CONFIG_EQUIVA_SSPD(n).FORMATO;
			rcRecOfTab.row_id(n) := itbLDC_CONFIG_EQUIVA_SSPD(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuCONF_EQUIV_SSPD_ID in LDC_CONFIG_EQUIVA_SSPD.CONF_EQUIV_SSPD_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuCONF_EQUIV_SSPD_ID
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
		inuCONF_EQUIV_SSPD_ID in LDC_CONFIG_EQUIVA_SSPD.CONF_EQUIV_SSPD_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuCONF_EQUIV_SSPD_ID = rcData.CONF_EQUIV_SSPD_ID
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
		inuCONF_EQUIV_SSPD_ID in LDC_CONFIG_EQUIVA_SSPD.CONF_EQUIV_SSPD_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuCONF_EQUIV_SSPD_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuCONF_EQUIV_SSPD_ID in LDC_CONFIG_EQUIVA_SSPD.CONF_EQUIV_SSPD_ID%type
	)
	IS
		rcError styLDC_CONFIG_EQUIVA_SSPD;
	BEGIN		rcError.CONF_EQUIV_SSPD_ID:=inuCONF_EQUIV_SSPD_ID;

		Load
		(
			inuCONF_EQUIV_SSPD_ID
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
		inuCONF_EQUIV_SSPD_ID in LDC_CONFIG_EQUIVA_SSPD.CONF_EQUIV_SSPD_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuCONF_EQUIV_SSPD_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuCONF_EQUIV_SSPD_ID in LDC_CONFIG_EQUIVA_SSPD.CONF_EQUIV_SSPD_ID%type,
		orcRecord out nocopy styLDC_CONFIG_EQUIVA_SSPD
	)
	IS
		rcError styLDC_CONFIG_EQUIVA_SSPD;
	BEGIN		rcError.CONF_EQUIV_SSPD_ID:=inuCONF_EQUIV_SSPD_ID;

		Load
		(
			inuCONF_EQUIV_SSPD_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuCONF_EQUIV_SSPD_ID in LDC_CONFIG_EQUIVA_SSPD.CONF_EQUIV_SSPD_ID%type
	)
	RETURN styLDC_CONFIG_EQUIVA_SSPD
	IS
		rcError styLDC_CONFIG_EQUIVA_SSPD;
	BEGIN
		rcError.CONF_EQUIV_SSPD_ID:=inuCONF_EQUIV_SSPD_ID;

		Load
		(
			inuCONF_EQUIV_SSPD_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuCONF_EQUIV_SSPD_ID in LDC_CONFIG_EQUIVA_SSPD.CONF_EQUIV_SSPD_ID%type
	)
	RETURN styLDC_CONFIG_EQUIVA_SSPD
	IS
		rcError styLDC_CONFIG_EQUIVA_SSPD;
	BEGIN
		rcError.CONF_EQUIV_SSPD_ID:=inuCONF_EQUIV_SSPD_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuCONF_EQUIV_SSPD_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuCONF_EQUIV_SSPD_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_CONFIG_EQUIVA_SSPD
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_CONFIG_EQUIVA_SSPD
	)
	IS
		rfLDC_CONFIG_EQUIVA_SSPD tyrfLDC_CONFIG_EQUIVA_SSPD;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_CONFIG_EQUIVA_SSPD.*, LDC_CONFIG_EQUIVA_SSPD.rowid FROM LDC_CONFIG_EQUIVA_SSPD';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_CONFIG_EQUIVA_SSPD for sbFullQuery;

		fetch rfLDC_CONFIG_EQUIVA_SSPD bulk collect INTO otbResult;

		close rfLDC_CONFIG_EQUIVA_SSPD;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_CONFIG_EQUIVA_SSPD.*, LDC_CONFIG_EQUIVA_SSPD.rowid FROM LDC_CONFIG_EQUIVA_SSPD';
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
		ircLDC_CONFIG_EQUIVA_SSPD in styLDC_CONFIG_EQUIVA_SSPD
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_CONFIG_EQUIVA_SSPD,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_CONFIG_EQUIVA_SSPD in styLDC_CONFIG_EQUIVA_SSPD,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_CONFIG_EQUIVA_SSPD.CONF_EQUIV_SSPD_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|CONF_EQUIV_SSPD_ID');
			raise ex.controlled_error;
		end if;

		insert into LDC_CONFIG_EQUIVA_SSPD
		(
			CONF_EQUIV_SSPD_ID,
			ATECLIREPO_ID,
			TIPO_SOLICITUD,
			RESP_SOL_OSF,
			TIPO_RESPUESTA,
			CAUSAL_EQUIV_SSPD,
			DESCRIPCION,
			APLICA_ITANSUCA,
			FORMATO
		)
		values
		(
			ircLDC_CONFIG_EQUIVA_SSPD.CONF_EQUIV_SSPD_ID,
			ircLDC_CONFIG_EQUIVA_SSPD.ATECLIREPO_ID,
			ircLDC_CONFIG_EQUIVA_SSPD.TIPO_SOLICITUD,
			ircLDC_CONFIG_EQUIVA_SSPD.RESP_SOL_OSF,
			ircLDC_CONFIG_EQUIVA_SSPD.TIPO_RESPUESTA,
			ircLDC_CONFIG_EQUIVA_SSPD.CAUSAL_EQUIV_SSPD,
			ircLDC_CONFIG_EQUIVA_SSPD.DESCRIPCION,
			ircLDC_CONFIG_EQUIVA_SSPD.APLICA_ITANSUCA,
			ircLDC_CONFIG_EQUIVA_SSPD.FORMATO
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_CONFIG_EQUIVA_SSPD));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_CONFIG_EQUIVA_SSPD in out nocopy tytbLDC_CONFIG_EQUIVA_SSPD
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_CONFIG_EQUIVA_SSPD,blUseRowID);
		forall n in iotbLDC_CONFIG_EQUIVA_SSPD.first..iotbLDC_CONFIG_EQUIVA_SSPD.last
			insert into LDC_CONFIG_EQUIVA_SSPD
			(
				CONF_EQUIV_SSPD_ID,
				ATECLIREPO_ID,
				TIPO_SOLICITUD,
				RESP_SOL_OSF,
				TIPO_RESPUESTA,
				CAUSAL_EQUIV_SSPD,
				DESCRIPCION,
				APLICA_ITANSUCA,
				FORMATO
			)
			values
			(
				rcRecOfTab.CONF_EQUIV_SSPD_ID(n),
				rcRecOfTab.ATECLIREPO_ID(n),
				rcRecOfTab.TIPO_SOLICITUD(n),
				rcRecOfTab.RESP_SOL_OSF(n),
				rcRecOfTab.TIPO_RESPUESTA(n),
				rcRecOfTab.CAUSAL_EQUIV_SSPD(n),
				rcRecOfTab.DESCRIPCION(n),
				rcRecOfTab.APLICA_ITANSUCA(n),
				rcRecOfTab.FORMATO(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuCONF_EQUIV_SSPD_ID in LDC_CONFIG_EQUIVA_SSPD.CONF_EQUIV_SSPD_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_CONFIG_EQUIVA_SSPD;
	BEGIN
		rcError.CONF_EQUIV_SSPD_ID := inuCONF_EQUIV_SSPD_ID;

		if inuLock=1 then
			LockByPk
			(
				inuCONF_EQUIV_SSPD_ID,
				rcData
			);
		end if;


		delete
		from LDC_CONFIG_EQUIVA_SSPD
		where
       		CONF_EQUIV_SSPD_ID=inuCONF_EQUIV_SSPD_ID;
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
		rcError  styLDC_CONFIG_EQUIVA_SSPD;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_CONFIG_EQUIVA_SSPD
		where
			rowid = iriRowID
		returning
			CONF_EQUIV_SSPD_ID
		into
			rcError.CONF_EQUIV_SSPD_ID;
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
		iotbLDC_CONFIG_EQUIVA_SSPD in out nocopy tytbLDC_CONFIG_EQUIVA_SSPD,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_CONFIG_EQUIVA_SSPD;
	BEGIN
		FillRecordOfTables(iotbLDC_CONFIG_EQUIVA_SSPD, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_CONFIG_EQUIVA_SSPD.first .. iotbLDC_CONFIG_EQUIVA_SSPD.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CONFIG_EQUIVA_SSPD.first .. iotbLDC_CONFIG_EQUIVA_SSPD.last
				delete
				from LDC_CONFIG_EQUIVA_SSPD
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_CONFIG_EQUIVA_SSPD.first .. iotbLDC_CONFIG_EQUIVA_SSPD.last loop
					LockByPk
					(
						rcRecOfTab.CONF_EQUIV_SSPD_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CONFIG_EQUIVA_SSPD.first .. iotbLDC_CONFIG_EQUIVA_SSPD.last
				delete
				from LDC_CONFIG_EQUIVA_SSPD
				where
		         	CONF_EQUIV_SSPD_ID = rcRecOfTab.CONF_EQUIV_SSPD_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_CONFIG_EQUIVA_SSPD in styLDC_CONFIG_EQUIVA_SSPD,
		inuLock in number default 0
	)
	IS
		nuCONF_EQUIV_SSPD_ID	LDC_CONFIG_EQUIVA_SSPD.CONF_EQUIV_SSPD_ID%type;
	BEGIN
		if ircLDC_CONFIG_EQUIVA_SSPD.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_CONFIG_EQUIVA_SSPD.rowid,rcData);
			end if;
			update LDC_CONFIG_EQUIVA_SSPD
			set
				ATECLIREPO_ID = ircLDC_CONFIG_EQUIVA_SSPD.ATECLIREPO_ID,
				TIPO_SOLICITUD = ircLDC_CONFIG_EQUIVA_SSPD.TIPO_SOLICITUD,
				RESP_SOL_OSF = ircLDC_CONFIG_EQUIVA_SSPD.RESP_SOL_OSF,
				TIPO_RESPUESTA = ircLDC_CONFIG_EQUIVA_SSPD.TIPO_RESPUESTA,
				CAUSAL_EQUIV_SSPD = ircLDC_CONFIG_EQUIVA_SSPD.CAUSAL_EQUIV_SSPD,
				DESCRIPCION = ircLDC_CONFIG_EQUIVA_SSPD.DESCRIPCION,
				APLICA_ITANSUCA = ircLDC_CONFIG_EQUIVA_SSPD.APLICA_ITANSUCA,
				FORMATO = ircLDC_CONFIG_EQUIVA_SSPD.FORMATO
			where
				rowid = ircLDC_CONFIG_EQUIVA_SSPD.rowid
			returning
				CONF_EQUIV_SSPD_ID
			into
				nuCONF_EQUIV_SSPD_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_CONFIG_EQUIVA_SSPD.CONF_EQUIV_SSPD_ID,
					rcData
				);
			end if;

			update LDC_CONFIG_EQUIVA_SSPD
			set
				ATECLIREPO_ID = ircLDC_CONFIG_EQUIVA_SSPD.ATECLIREPO_ID,
				TIPO_SOLICITUD = ircLDC_CONFIG_EQUIVA_SSPD.TIPO_SOLICITUD,
				RESP_SOL_OSF = ircLDC_CONFIG_EQUIVA_SSPD.RESP_SOL_OSF,
				TIPO_RESPUESTA = ircLDC_CONFIG_EQUIVA_SSPD.TIPO_RESPUESTA,
				CAUSAL_EQUIV_SSPD = ircLDC_CONFIG_EQUIVA_SSPD.CAUSAL_EQUIV_SSPD,
				DESCRIPCION = ircLDC_CONFIG_EQUIVA_SSPD.DESCRIPCION,
				APLICA_ITANSUCA = ircLDC_CONFIG_EQUIVA_SSPD.APLICA_ITANSUCA,
				FORMATO = ircLDC_CONFIG_EQUIVA_SSPD.FORMATO
			where
				CONF_EQUIV_SSPD_ID = ircLDC_CONFIG_EQUIVA_SSPD.CONF_EQUIV_SSPD_ID
			returning
				CONF_EQUIV_SSPD_ID
			into
				nuCONF_EQUIV_SSPD_ID;
		end if;
		if
			nuCONF_EQUIV_SSPD_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_CONFIG_EQUIVA_SSPD));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_CONFIG_EQUIVA_SSPD in out nocopy tytbLDC_CONFIG_EQUIVA_SSPD,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_CONFIG_EQUIVA_SSPD;
	BEGIN
		FillRecordOfTables(iotbLDC_CONFIG_EQUIVA_SSPD,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_CONFIG_EQUIVA_SSPD.first .. iotbLDC_CONFIG_EQUIVA_SSPD.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CONFIG_EQUIVA_SSPD.first .. iotbLDC_CONFIG_EQUIVA_SSPD.last
				update LDC_CONFIG_EQUIVA_SSPD
				set
					ATECLIREPO_ID = rcRecOfTab.ATECLIREPO_ID(n),
					TIPO_SOLICITUD = rcRecOfTab.TIPO_SOLICITUD(n),
					RESP_SOL_OSF = rcRecOfTab.RESP_SOL_OSF(n),
					TIPO_RESPUESTA = rcRecOfTab.TIPO_RESPUESTA(n),
					CAUSAL_EQUIV_SSPD = rcRecOfTab.CAUSAL_EQUIV_SSPD(n),
					DESCRIPCION = rcRecOfTab.DESCRIPCION(n),
					APLICA_ITANSUCA = rcRecOfTab.APLICA_ITANSUCA(n),
					FORMATO = rcRecOfTab.FORMATO(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_CONFIG_EQUIVA_SSPD.first .. iotbLDC_CONFIG_EQUIVA_SSPD.last loop
					LockByPk
					(
						rcRecOfTab.CONF_EQUIV_SSPD_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CONFIG_EQUIVA_SSPD.first .. iotbLDC_CONFIG_EQUIVA_SSPD.last
				update LDC_CONFIG_EQUIVA_SSPD
				SET
					ATECLIREPO_ID = rcRecOfTab.ATECLIREPO_ID(n),
					TIPO_SOLICITUD = rcRecOfTab.TIPO_SOLICITUD(n),
					RESP_SOL_OSF = rcRecOfTab.RESP_SOL_OSF(n),
					TIPO_RESPUESTA = rcRecOfTab.TIPO_RESPUESTA(n),
					CAUSAL_EQUIV_SSPD = rcRecOfTab.CAUSAL_EQUIV_SSPD(n),
					DESCRIPCION = rcRecOfTab.DESCRIPCION(n),
					APLICA_ITANSUCA = rcRecOfTab.APLICA_ITANSUCA(n),
					FORMATO = rcRecOfTab.FORMATO(n)
				where
					CONF_EQUIV_SSPD_ID = rcRecOfTab.CONF_EQUIV_SSPD_ID(n)
;
		end if;
	END;
	PROCEDURE updATECLIREPO_ID
	(
		inuCONF_EQUIV_SSPD_ID in LDC_CONFIG_EQUIVA_SSPD.CONF_EQUIV_SSPD_ID%type,
		inuATECLIREPO_ID$ in LDC_CONFIG_EQUIVA_SSPD.ATECLIREPO_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CONFIG_EQUIVA_SSPD;
	BEGIN
		rcError.CONF_EQUIV_SSPD_ID := inuCONF_EQUIV_SSPD_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCONF_EQUIV_SSPD_ID,
				rcData
			);
		end if;

		update LDC_CONFIG_EQUIVA_SSPD
		set
			ATECLIREPO_ID = inuATECLIREPO_ID$
		where
			CONF_EQUIV_SSPD_ID = inuCONF_EQUIV_SSPD_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ATECLIREPO_ID:= inuATECLIREPO_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updTIPO_SOLICITUD
	(
		inuCONF_EQUIV_SSPD_ID in LDC_CONFIG_EQUIVA_SSPD.CONF_EQUIV_SSPD_ID%type,
		inuTIPO_SOLICITUD$ in LDC_CONFIG_EQUIVA_SSPD.TIPO_SOLICITUD%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CONFIG_EQUIVA_SSPD;
	BEGIN
		rcError.CONF_EQUIV_SSPD_ID := inuCONF_EQUIV_SSPD_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCONF_EQUIV_SSPD_ID,
				rcData
			);
		end if;

		update LDC_CONFIG_EQUIVA_SSPD
		set
			TIPO_SOLICITUD = inuTIPO_SOLICITUD$
		where
			CONF_EQUIV_SSPD_ID = inuCONF_EQUIV_SSPD_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TIPO_SOLICITUD:= inuTIPO_SOLICITUD$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRESP_SOL_OSF
	(
		inuCONF_EQUIV_SSPD_ID in LDC_CONFIG_EQUIVA_SSPD.CONF_EQUIV_SSPD_ID%type,
		inuRESP_SOL_OSF$ in LDC_CONFIG_EQUIVA_SSPD.RESP_SOL_OSF%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CONFIG_EQUIVA_SSPD;
	BEGIN
		rcError.CONF_EQUIV_SSPD_ID := inuCONF_EQUIV_SSPD_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCONF_EQUIV_SSPD_ID,
				rcData
			);
		end if;

		update LDC_CONFIG_EQUIVA_SSPD
		set
			RESP_SOL_OSF = inuRESP_SOL_OSF$
		where
			CONF_EQUIV_SSPD_ID = inuCONF_EQUIV_SSPD_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.RESP_SOL_OSF:= inuRESP_SOL_OSF$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updTIPO_RESPUESTA
	(
		inuCONF_EQUIV_SSPD_ID in LDC_CONFIG_EQUIVA_SSPD.CONF_EQUIV_SSPD_ID%type,
		inuTIPO_RESPUESTA$ in LDC_CONFIG_EQUIVA_SSPD.TIPO_RESPUESTA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CONFIG_EQUIVA_SSPD;
	BEGIN
		rcError.CONF_EQUIV_SSPD_ID := inuCONF_EQUIV_SSPD_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCONF_EQUIV_SSPD_ID,
				rcData
			);
		end if;

		update LDC_CONFIG_EQUIVA_SSPD
		set
			TIPO_RESPUESTA = inuTIPO_RESPUESTA$
		where
			CONF_EQUIV_SSPD_ID = inuCONF_EQUIV_SSPD_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TIPO_RESPUESTA:= inuTIPO_RESPUESTA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCAUSAL_EQUIV_SSPD
	(
		inuCONF_EQUIV_SSPD_ID in LDC_CONFIG_EQUIVA_SSPD.CONF_EQUIV_SSPD_ID%type,
		inuCAUSAL_EQUIV_SSPD$ in LDC_CONFIG_EQUIVA_SSPD.CAUSAL_EQUIV_SSPD%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CONFIG_EQUIVA_SSPD;
	BEGIN
		rcError.CONF_EQUIV_SSPD_ID := inuCONF_EQUIV_SSPD_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCONF_EQUIV_SSPD_ID,
				rcData
			);
		end if;

		update LDC_CONFIG_EQUIVA_SSPD
		set
			CAUSAL_EQUIV_SSPD = inuCAUSAL_EQUIV_SSPD$
		where
			CONF_EQUIV_SSPD_ID = inuCONF_EQUIV_SSPD_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CAUSAL_EQUIV_SSPD:= inuCAUSAL_EQUIV_SSPD$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updDESCRIPCION
	(
		inuCONF_EQUIV_SSPD_ID in LDC_CONFIG_EQUIVA_SSPD.CONF_EQUIV_SSPD_ID%type,
		isbDESCRIPCION$ in LDC_CONFIG_EQUIVA_SSPD.DESCRIPCION%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CONFIG_EQUIVA_SSPD;
	BEGIN
		rcError.CONF_EQUIV_SSPD_ID := inuCONF_EQUIV_SSPD_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCONF_EQUIV_SSPD_ID,
				rcData
			);
		end if;

		update LDC_CONFIG_EQUIVA_SSPD
		set
			DESCRIPCION = isbDESCRIPCION$
		where
			CONF_EQUIV_SSPD_ID = inuCONF_EQUIV_SSPD_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DESCRIPCION:= isbDESCRIPCION$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updAPLICA_ITANSUCA
	(
		inuCONF_EQUIV_SSPD_ID in LDC_CONFIG_EQUIVA_SSPD.CONF_EQUIV_SSPD_ID%type,
		isbAPLICA_ITANSUCA$ in LDC_CONFIG_EQUIVA_SSPD.APLICA_ITANSUCA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CONFIG_EQUIVA_SSPD;
	BEGIN
		rcError.CONF_EQUIV_SSPD_ID := inuCONF_EQUIV_SSPD_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCONF_EQUIV_SSPD_ID,
				rcData
			);
		end if;

		update LDC_CONFIG_EQUIVA_SSPD
		set
			APLICA_ITANSUCA = isbAPLICA_ITANSUCA$
		where
			CONF_EQUIV_SSPD_ID = inuCONF_EQUIV_SSPD_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.APLICA_ITANSUCA:= isbAPLICA_ITANSUCA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFORMATO
	(
		inuCONF_EQUIV_SSPD_ID in LDC_CONFIG_EQUIVA_SSPD.CONF_EQUIV_SSPD_ID%type,
		isbFORMATO$ in LDC_CONFIG_EQUIVA_SSPD.FORMATO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CONFIG_EQUIVA_SSPD;
	BEGIN
		rcError.CONF_EQUIV_SSPD_ID := inuCONF_EQUIV_SSPD_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCONF_EQUIV_SSPD_ID,
				rcData
			);
		end if;

		update LDC_CONFIG_EQUIVA_SSPD
		set
			FORMATO = isbFORMATO$
		where
			CONF_EQUIV_SSPD_ID = inuCONF_EQUIV_SSPD_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FORMATO:= isbFORMATO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetCONF_EQUIV_SSPD_ID
	(
		inuCONF_EQUIV_SSPD_ID in LDC_CONFIG_EQUIVA_SSPD.CONF_EQUIV_SSPD_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONFIG_EQUIVA_SSPD.CONF_EQUIV_SSPD_ID%type
	IS
		rcError styLDC_CONFIG_EQUIVA_SSPD;
	BEGIN

		rcError.CONF_EQUIV_SSPD_ID := inuCONF_EQUIV_SSPD_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONF_EQUIV_SSPD_ID
			 )
		then
			 return(rcData.CONF_EQUIV_SSPD_ID);
		end if;
		Load
		(
		 		inuCONF_EQUIV_SSPD_ID
		);
		return(rcData.CONF_EQUIV_SSPD_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetATECLIREPO_ID
	(
		inuCONF_EQUIV_SSPD_ID in LDC_CONFIG_EQUIVA_SSPD.CONF_EQUIV_SSPD_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONFIG_EQUIVA_SSPD.ATECLIREPO_ID%type
	IS
		rcError styLDC_CONFIG_EQUIVA_SSPD;
	BEGIN

		rcError.CONF_EQUIV_SSPD_ID := inuCONF_EQUIV_SSPD_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONF_EQUIV_SSPD_ID
			 )
		then
			 return(rcData.ATECLIREPO_ID);
		end if;
		Load
		(
		 		inuCONF_EQUIV_SSPD_ID
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
	FUNCTION fnuGetTIPO_SOLICITUD
	(
		inuCONF_EQUIV_SSPD_ID in LDC_CONFIG_EQUIVA_SSPD.CONF_EQUIV_SSPD_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONFIG_EQUIVA_SSPD.TIPO_SOLICITUD%type
	IS
		rcError styLDC_CONFIG_EQUIVA_SSPD;
	BEGIN

		rcError.CONF_EQUIV_SSPD_ID := inuCONF_EQUIV_SSPD_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONF_EQUIV_SSPD_ID
			 )
		then
			 return(rcData.TIPO_SOLICITUD);
		end if;
		Load
		(
		 		inuCONF_EQUIV_SSPD_ID
		);
		return(rcData.TIPO_SOLICITUD);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetRESP_SOL_OSF
	(
		inuCONF_EQUIV_SSPD_ID in LDC_CONFIG_EQUIVA_SSPD.CONF_EQUIV_SSPD_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONFIG_EQUIVA_SSPD.RESP_SOL_OSF%type
	IS
		rcError styLDC_CONFIG_EQUIVA_SSPD;
	BEGIN

		rcError.CONF_EQUIV_SSPD_ID := inuCONF_EQUIV_SSPD_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONF_EQUIV_SSPD_ID
			 )
		then
			 return(rcData.RESP_SOL_OSF);
		end if;
		Load
		(
		 		inuCONF_EQUIV_SSPD_ID
		);
		return(rcData.RESP_SOL_OSF);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetTIPO_RESPUESTA
	(
		inuCONF_EQUIV_SSPD_ID in LDC_CONFIG_EQUIVA_SSPD.CONF_EQUIV_SSPD_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONFIG_EQUIVA_SSPD.TIPO_RESPUESTA%type
	IS
		rcError styLDC_CONFIG_EQUIVA_SSPD;
	BEGIN

		rcError.CONF_EQUIV_SSPD_ID := inuCONF_EQUIV_SSPD_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONF_EQUIV_SSPD_ID
			 )
		then
			 return(rcData.TIPO_RESPUESTA);
		end if;
		Load
		(
		 		inuCONF_EQUIV_SSPD_ID
		);
		return(rcData.TIPO_RESPUESTA);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCAUSAL_EQUIV_SSPD
	(
		inuCONF_EQUIV_SSPD_ID in LDC_CONFIG_EQUIVA_SSPD.CONF_EQUIV_SSPD_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONFIG_EQUIVA_SSPD.CAUSAL_EQUIV_SSPD%type
	IS
		rcError styLDC_CONFIG_EQUIVA_SSPD;
	BEGIN

		rcError.CONF_EQUIV_SSPD_ID := inuCONF_EQUIV_SSPD_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONF_EQUIV_SSPD_ID
			 )
		then
			 return(rcData.CAUSAL_EQUIV_SSPD);
		end if;
		Load
		(
		 		inuCONF_EQUIV_SSPD_ID
		);
		return(rcData.CAUSAL_EQUIV_SSPD);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetDESCRIPCION
	(
		inuCONF_EQUIV_SSPD_ID in LDC_CONFIG_EQUIVA_SSPD.CONF_EQUIV_SSPD_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONFIG_EQUIVA_SSPD.DESCRIPCION%type
	IS
		rcError styLDC_CONFIG_EQUIVA_SSPD;
	BEGIN

		rcError.CONF_EQUIV_SSPD_ID := inuCONF_EQUIV_SSPD_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONF_EQUIV_SSPD_ID
			 )
		then
			 return(rcData.DESCRIPCION);
		end if;
		Load
		(
		 		inuCONF_EQUIV_SSPD_ID
		);
		return(rcData.DESCRIPCION);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetAPLICA_ITANSUCA
	(
		inuCONF_EQUIV_SSPD_ID in LDC_CONFIG_EQUIVA_SSPD.CONF_EQUIV_SSPD_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONFIG_EQUIVA_SSPD.APLICA_ITANSUCA%type
	IS
		rcError styLDC_CONFIG_EQUIVA_SSPD;
	BEGIN

		rcError.CONF_EQUIV_SSPD_ID := inuCONF_EQUIV_SSPD_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONF_EQUIV_SSPD_ID
			 )
		then
			 return(rcData.APLICA_ITANSUCA);
		end if;
		Load
		(
		 		inuCONF_EQUIV_SSPD_ID
		);
		return(rcData.APLICA_ITANSUCA);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetFORMATO
	(
		inuCONF_EQUIV_SSPD_ID in LDC_CONFIG_EQUIVA_SSPD.CONF_EQUIV_SSPD_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CONFIG_EQUIVA_SSPD.FORMATO%type
	IS
		rcError styLDC_CONFIG_EQUIVA_SSPD;
	BEGIN

		rcError.CONF_EQUIV_SSPD_ID := inuCONF_EQUIV_SSPD_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONF_EQUIV_SSPD_ID
			 )
		then
			 return(rcData.FORMATO);
		end if;
		Load
		(
		 		inuCONF_EQUIV_SSPD_ID
		);
		return(rcData.FORMATO);
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
end DALDC_CONFIG_EQUIVA_SSPD;
/
PROMPT Otorgando permisos de ejecucion a DALDC_CONFIG_EQUIVA_SSPD
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_CONFIG_EQUIVA_SSPD', 'ADM_PERSON');
END;
/