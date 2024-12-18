CREATE OR REPLACE PACKAGE ADM_PERSON.DALDC_EQUIVALENCIA_SSPD
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
		inuTIPO_SOLICITUD in LDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD%type,
		inuRESP_SOL_OSF in LDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF%type
	)
	IS
		SELECT LDC_EQUIVALENCIA_SSPD.*,LDC_EQUIVALENCIA_SSPD.rowid
		FROM LDC_EQUIVALENCIA_SSPD
		WHERE
		    TIPO_SOLICITUD = inuTIPO_SOLICITUD
		    and RESP_SOL_OSF = inuRESP_SOL_OSF;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_EQUIVALENCIA_SSPD.*,LDC_EQUIVALENCIA_SSPD.rowid
		FROM LDC_EQUIVALENCIA_SSPD
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_EQUIVALENCIA_SSPD  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_EQUIVALENCIA_SSPD is table of styLDC_EQUIVALENCIA_SSPD index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_EQUIVALENCIA_SSPD;

	/* Tipos referenciando al registro */
	type tytbTIPO_SOLICITUD is table of LDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD%type index by binary_integer;
	type tytbRESP_SOL_OSF is table of LDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF%type index by binary_integer;
	type tytbTIPO_RESPUESTA is table of LDC_EQUIVALENCIA_SSPD.TIPO_RESPUESTA%type index by binary_integer;
	type tytbCAUSAL_EQUIV_SSPD is table of LDC_EQUIVALENCIA_SSPD.CAUSAL_EQUIV_SSPD%type index by binary_integer;
	type tytbAPLICA_ITANSUCA is table of LDC_EQUIVALENCIA_SSPD.APLICA_ITANSUCA%type index by binary_integer;
	type tytbFORMATO is table of LDC_EQUIVALENCIA_SSPD.FORMATO%type index by binary_integer;
	type tytbACTIVO is table of LDC_EQUIVALENCIA_SSPD.ACTIVO%type index by binary_integer;
	type tytbFECHA_INICIAL is table of LDC_EQUIVALENCIA_SSPD.FECHA_INICIAL%type index by binary_integer;
	type tytbUSUARIO is table of LDC_EQUIVALENCIA_SSPD.USUARIO%type index by binary_integer;
	type tytbFECHA_REGISTRO is table of LDC_EQUIVALENCIA_SSPD.FECHA_REGISTRO%type index by binary_integer;
	type tytbTERMINAL is table of LDC_EQUIVALENCIA_SSPD.TERMINAL%type index by binary_integer;
	type tytbCLASIFICACION is table of LDC_EQUIVALENCIA_SSPD.CLASIFICACION%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_EQUIVALENCIA_SSPD is record
	(
		TIPO_SOLICITUD   tytbTIPO_SOLICITUD,
		RESP_SOL_OSF   tytbRESP_SOL_OSF,
		TIPO_RESPUESTA   tytbTIPO_RESPUESTA,
		CAUSAL_EQUIV_SSPD   tytbCAUSAL_EQUIV_SSPD,
		APLICA_ITANSUCA   tytbAPLICA_ITANSUCA,
		FORMATO   tytbFORMATO,
		ACTIVO   tytbACTIVO,
		FECHA_INICIAL   tytbFECHA_INICIAL,
		USUARIO   tytbUSUARIO,
		FECHA_REGISTRO   tytbFECHA_REGISTRO,
		TERMINAL   tytbTERMINAL,
		CLASIFICACION   tytbCLASIFICACION,
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
		inuTIPO_SOLICITUD in LDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD%type,
		inuRESP_SOL_OSF in LDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuTIPO_SOLICITUD in LDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD%type,
		inuRESP_SOL_OSF in LDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuTIPO_SOLICITUD in LDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD%type,
		inuRESP_SOL_OSF in LDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF%type
	);

	PROCEDURE getRecord
	(
		inuTIPO_SOLICITUD in LDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD%type,
		inuRESP_SOL_OSF in LDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF%type,
		orcRecord out nocopy styLDC_EQUIVALENCIA_SSPD
	);

	FUNCTION frcGetRcData
	(
		inuTIPO_SOLICITUD in LDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD%type,
		inuRESP_SOL_OSF in LDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF%type
	)
	RETURN styLDC_EQUIVALENCIA_SSPD;

	FUNCTION frcGetRcData
	RETURN styLDC_EQUIVALENCIA_SSPD;

	FUNCTION frcGetRecord
	(
		inuTIPO_SOLICITUD in LDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD%type,
		inuRESP_SOL_OSF in LDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF%type
	)
	RETURN styLDC_EQUIVALENCIA_SSPD;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_EQUIVALENCIA_SSPD
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_EQUIVALENCIA_SSPD in styLDC_EQUIVALENCIA_SSPD
	);

	PROCEDURE insRecord
	(
		ircLDC_EQUIVALENCIA_SSPD in styLDC_EQUIVALENCIA_SSPD,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_EQUIVALENCIA_SSPD in out nocopy tytbLDC_EQUIVALENCIA_SSPD
	);

	PROCEDURE delRecord
	(
		inuTIPO_SOLICITUD in LDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD%type,
		inuRESP_SOL_OSF in LDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_EQUIVALENCIA_SSPD in out nocopy tytbLDC_EQUIVALENCIA_SSPD,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_EQUIVALENCIA_SSPD in styLDC_EQUIVALENCIA_SSPD,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_EQUIVALENCIA_SSPD in out nocopy tytbLDC_EQUIVALENCIA_SSPD,
		inuLock in number default 1
	);

	PROCEDURE updTIPO_RESPUESTA
	(
		inuTIPO_SOLICITUD in LDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD%type,
		inuRESP_SOL_OSF in LDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF%type,
		inuTIPO_RESPUESTA$ in LDC_EQUIVALENCIA_SSPD.TIPO_RESPUESTA%type,
		inuLock in number default 0
	);

	PROCEDURE updCAUSAL_EQUIV_SSPD
	(
		inuTIPO_SOLICITUD in LDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD%type,
		inuRESP_SOL_OSF in LDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF%type,
		inuCAUSAL_EQUIV_SSPD$ in LDC_EQUIVALENCIA_SSPD.CAUSAL_EQUIV_SSPD%type,
		inuLock in number default 0
	);

	PROCEDURE updAPLICA_ITANSUCA
	(
		inuTIPO_SOLICITUD in LDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD%type,
		inuRESP_SOL_OSF in LDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF%type,
		isbAPLICA_ITANSUCA$ in LDC_EQUIVALENCIA_SSPD.APLICA_ITANSUCA%type,
		inuLock in number default 0
	);

	PROCEDURE updFORMATO
	(
		inuTIPO_SOLICITUD in LDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD%type,
		inuRESP_SOL_OSF in LDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF%type,
		isbFORMATO$ in LDC_EQUIVALENCIA_SSPD.FORMATO%type,
		inuLock in number default 0
	);

	PROCEDURE updACTIVO
	(
		inuTIPO_SOLICITUD in LDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD%type,
		inuRESP_SOL_OSF in LDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF%type,
		isbACTIVO$ in LDC_EQUIVALENCIA_SSPD.ACTIVO%type,
		inuLock in number default 0
	);

	PROCEDURE updFECHA_INICIAL
	(
		inuTIPO_SOLICITUD in LDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD%type,
		inuRESP_SOL_OSF in LDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF%type,
		idtFECHA_INICIAL$ in LDC_EQUIVALENCIA_SSPD.FECHA_INICIAL%type,
		inuLock in number default 0
	);

	PROCEDURE updUSUARIO
	(
		inuTIPO_SOLICITUD in LDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD%type,
		inuRESP_SOL_OSF in LDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF%type,
		inuUSUARIO$ in LDC_EQUIVALENCIA_SSPD.USUARIO%type,
		inuLock in number default 0
	);

	PROCEDURE updFECHA_REGISTRO
	(
		inuTIPO_SOLICITUD in LDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD%type,
		inuRESP_SOL_OSF in LDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF%type,
		idtFECHA_REGISTRO$ in LDC_EQUIVALENCIA_SSPD.FECHA_REGISTRO%type,
		inuLock in number default 0
	);

	PROCEDURE updTERMINAL
	(
		inuTIPO_SOLICITUD in LDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD%type,
		inuRESP_SOL_OSF in LDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF%type,
		isbTERMINAL$ in LDC_EQUIVALENCIA_SSPD.TERMINAL%type,
		inuLock in number default 0
	);

	PROCEDURE updCLASIFICACION
	(
		inuTIPO_SOLICITUD in LDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD%type,
		inuRESP_SOL_OSF in LDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF%type,
		inuCLASIFICACION$ in LDC_EQUIVALENCIA_SSPD.CLASIFICACION%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetTIPO_SOLICITUD
	(
		inuTIPO_SOLICITUD in LDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD%type,
		inuRESP_SOL_OSF in LDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD%type;

	FUNCTION fnuGetRESP_SOL_OSF
	(
		inuTIPO_SOLICITUD in LDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD%type,
		inuRESP_SOL_OSF in LDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF%type;

	FUNCTION fnuGetTIPO_RESPUESTA
	(
		inuTIPO_SOLICITUD in LDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD%type,
		inuRESP_SOL_OSF in LDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_EQUIVALENCIA_SSPD.TIPO_RESPUESTA%type;

	FUNCTION fnuGetCAUSAL_EQUIV_SSPD
	(
		inuTIPO_SOLICITUD in LDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD%type,
		inuRESP_SOL_OSF in LDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_EQUIVALENCIA_SSPD.CAUSAL_EQUIV_SSPD%type;

	FUNCTION fsbGetAPLICA_ITANSUCA
	(
		inuTIPO_SOLICITUD in LDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD%type,
		inuRESP_SOL_OSF in LDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_EQUIVALENCIA_SSPD.APLICA_ITANSUCA%type;

	FUNCTION fsbGetFORMATO
	(
		inuTIPO_SOLICITUD in LDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD%type,
		inuRESP_SOL_OSF in LDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_EQUIVALENCIA_SSPD.FORMATO%type;

	FUNCTION fsbGetACTIVO
	(
		inuTIPO_SOLICITUD in LDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD%type,
		inuRESP_SOL_OSF in LDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_EQUIVALENCIA_SSPD.ACTIVO%type;

	FUNCTION fdtGetFECHA_INICIAL
	(
		inuTIPO_SOLICITUD in LDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD%type,
		inuRESP_SOL_OSF in LDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_EQUIVALENCIA_SSPD.FECHA_INICIAL%type;

	FUNCTION fnuGetUSUARIO
	(
		inuTIPO_SOLICITUD in LDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD%type,
		inuRESP_SOL_OSF in LDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_EQUIVALENCIA_SSPD.USUARIO%type;

	FUNCTION fdtGetFECHA_REGISTRO
	(
		inuTIPO_SOLICITUD in LDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD%type,
		inuRESP_SOL_OSF in LDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_EQUIVALENCIA_SSPD.FECHA_REGISTRO%type;

	FUNCTION fsbGetTERMINAL
	(
		inuTIPO_SOLICITUD in LDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD%type,
		inuRESP_SOL_OSF in LDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_EQUIVALENCIA_SSPD.TERMINAL%type;

	FUNCTION fnuGetCLASIFICACION
	(
		inuTIPO_SOLICITUD in LDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD%type,
		inuRESP_SOL_OSF in LDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_EQUIVALENCIA_SSPD.CLASIFICACION%type;


	PROCEDURE LockByPk
	(
		inuTIPO_SOLICITUD in LDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD%type,
		inuRESP_SOL_OSF in LDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF%type,
		orcLDC_EQUIVALENCIA_SSPD  out styLDC_EQUIVALENCIA_SSPD
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_EQUIVALENCIA_SSPD  out styLDC_EQUIVALENCIA_SSPD
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_EQUIVALENCIA_SSPD;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALDC_EQUIVALENCIA_SSPD
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_EQUIVALENCIA_SSPD';
	 cnuGeEntityId constant varchar2(30) := 8716; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuTIPO_SOLICITUD in LDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD%type,
		inuRESP_SOL_OSF in LDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF%type
	)
	IS
		SELECT LDC_EQUIVALENCIA_SSPD.*,LDC_EQUIVALENCIA_SSPD.rowid
		FROM LDC_EQUIVALENCIA_SSPD
		WHERE  TIPO_SOLICITUD = inuTIPO_SOLICITUD
			and RESP_SOL_OSF = inuRESP_SOL_OSF
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_EQUIVALENCIA_SSPD.*,LDC_EQUIVALENCIA_SSPD.rowid
		FROM LDC_EQUIVALENCIA_SSPD
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_EQUIVALENCIA_SSPD is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_EQUIVALENCIA_SSPD;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_EQUIVALENCIA_SSPD default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.TIPO_SOLICITUD);
		sbPk:=sbPk||','||ut_convert.fsbToChar(rcI.RESP_SOL_OSF);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuTIPO_SOLICITUD in LDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD%type,
		inuRESP_SOL_OSF in LDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF%type,
		orcLDC_EQUIVALENCIA_SSPD  out styLDC_EQUIVALENCIA_SSPD
	)
	IS
		rcError styLDC_EQUIVALENCIA_SSPD;
	BEGIN
		rcError.TIPO_SOLICITUD := inuTIPO_SOLICITUD;
		rcError.RESP_SOL_OSF := inuRESP_SOL_OSF;

		Open cuLockRcByPk
		(
			inuTIPO_SOLICITUD,
			inuRESP_SOL_OSF
		);

		fetch cuLockRcByPk into orcLDC_EQUIVALENCIA_SSPD;
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
		orcLDC_EQUIVALENCIA_SSPD  out styLDC_EQUIVALENCIA_SSPD
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_EQUIVALENCIA_SSPD;
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
		itbLDC_EQUIVALENCIA_SSPD  in out nocopy tytbLDC_EQUIVALENCIA_SSPD
	)
	IS
	BEGIN
			rcRecOfTab.TIPO_SOLICITUD.delete;
			rcRecOfTab.RESP_SOL_OSF.delete;
			rcRecOfTab.TIPO_RESPUESTA.delete;
			rcRecOfTab.CAUSAL_EQUIV_SSPD.delete;
			rcRecOfTab.APLICA_ITANSUCA.delete;
			rcRecOfTab.FORMATO.delete;
			rcRecOfTab.ACTIVO.delete;
			rcRecOfTab.FECHA_INICIAL.delete;
			rcRecOfTab.USUARIO.delete;
			rcRecOfTab.FECHA_REGISTRO.delete;
			rcRecOfTab.TERMINAL.delete;
			rcRecOfTab.CLASIFICACION.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_EQUIVALENCIA_SSPD  in out nocopy tytbLDC_EQUIVALENCIA_SSPD,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_EQUIVALENCIA_SSPD);

		for n in itbLDC_EQUIVALENCIA_SSPD.first .. itbLDC_EQUIVALENCIA_SSPD.last loop
			rcRecOfTab.TIPO_SOLICITUD(n) := itbLDC_EQUIVALENCIA_SSPD(n).TIPO_SOLICITUD;
			rcRecOfTab.RESP_SOL_OSF(n) := itbLDC_EQUIVALENCIA_SSPD(n).RESP_SOL_OSF;
			rcRecOfTab.TIPO_RESPUESTA(n) := itbLDC_EQUIVALENCIA_SSPD(n).TIPO_RESPUESTA;
			rcRecOfTab.CAUSAL_EQUIV_SSPD(n) := itbLDC_EQUIVALENCIA_SSPD(n).CAUSAL_EQUIV_SSPD;
			rcRecOfTab.APLICA_ITANSUCA(n) := itbLDC_EQUIVALENCIA_SSPD(n).APLICA_ITANSUCA;
			rcRecOfTab.FORMATO(n) := itbLDC_EQUIVALENCIA_SSPD(n).FORMATO;
			rcRecOfTab.ACTIVO(n) := itbLDC_EQUIVALENCIA_SSPD(n).ACTIVO;
			rcRecOfTab.FECHA_INICIAL(n) := itbLDC_EQUIVALENCIA_SSPD(n).FECHA_INICIAL;
			rcRecOfTab.USUARIO(n) := itbLDC_EQUIVALENCIA_SSPD(n).USUARIO;
			rcRecOfTab.FECHA_REGISTRO(n) := itbLDC_EQUIVALENCIA_SSPD(n).FECHA_REGISTRO;
			rcRecOfTab.TERMINAL(n) := itbLDC_EQUIVALENCIA_SSPD(n).TERMINAL;
			rcRecOfTab.CLASIFICACION(n) := itbLDC_EQUIVALENCIA_SSPD(n).CLASIFICACION;
			rcRecOfTab.row_id(n) := itbLDC_EQUIVALENCIA_SSPD(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuTIPO_SOLICITUD in LDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD%type,
		inuRESP_SOL_OSF in LDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuTIPO_SOLICITUD,
			inuRESP_SOL_OSF
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
		inuTIPO_SOLICITUD in LDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD%type,
		inuRESP_SOL_OSF in LDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuTIPO_SOLICITUD = rcData.TIPO_SOLICITUD AND
			inuRESP_SOL_OSF = rcData.RESP_SOL_OSF
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
		inuTIPO_SOLICITUD in LDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD%type,
		inuRESP_SOL_OSF in LDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuTIPO_SOLICITUD,
			inuRESP_SOL_OSF
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuTIPO_SOLICITUD in LDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD%type,
		inuRESP_SOL_OSF in LDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF%type
	)
	IS
		rcError styLDC_EQUIVALENCIA_SSPD;
	BEGIN		rcError.TIPO_SOLICITUD:=inuTIPO_SOLICITUD;		rcError.RESP_SOL_OSF:=inuRESP_SOL_OSF;

		Load
		(
			inuTIPO_SOLICITUD,
			inuRESP_SOL_OSF
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
		inuTIPO_SOLICITUD in LDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD%type,
		inuRESP_SOL_OSF in LDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF%type
	)
	IS
	BEGIN
		Load
		(
			inuTIPO_SOLICITUD,
			inuRESP_SOL_OSF
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuTIPO_SOLICITUD in LDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD%type,
		inuRESP_SOL_OSF in LDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF%type,
		orcRecord out nocopy styLDC_EQUIVALENCIA_SSPD
	)
	IS
		rcError styLDC_EQUIVALENCIA_SSPD;
	BEGIN		rcError.TIPO_SOLICITUD:=inuTIPO_SOLICITUD;		rcError.RESP_SOL_OSF:=inuRESP_SOL_OSF;

		Load
		(
			inuTIPO_SOLICITUD,
			inuRESP_SOL_OSF
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuTIPO_SOLICITUD in LDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD%type,
		inuRESP_SOL_OSF in LDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF%type
	)
	RETURN styLDC_EQUIVALENCIA_SSPD
	IS
		rcError styLDC_EQUIVALENCIA_SSPD;
	BEGIN
		rcError.TIPO_SOLICITUD:=inuTIPO_SOLICITUD;
		rcError.RESP_SOL_OSF:=inuRESP_SOL_OSF;

		Load
		(
			inuTIPO_SOLICITUD,
			inuRESP_SOL_OSF
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuTIPO_SOLICITUD in LDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD%type,
		inuRESP_SOL_OSF in LDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF%type
	)
	RETURN styLDC_EQUIVALENCIA_SSPD
	IS
		rcError styLDC_EQUIVALENCIA_SSPD;
	BEGIN
		rcError.TIPO_SOLICITUD:=inuTIPO_SOLICITUD;
		rcError.RESP_SOL_OSF:=inuRESP_SOL_OSF;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuTIPO_SOLICITUD,
			inuRESP_SOL_OSF
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuTIPO_SOLICITUD,
			inuRESP_SOL_OSF
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_EQUIVALENCIA_SSPD
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_EQUIVALENCIA_SSPD
	)
	IS
		rfLDC_EQUIVALENCIA_SSPD tyrfLDC_EQUIVALENCIA_SSPD;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_EQUIVALENCIA_SSPD.*, LDC_EQUIVALENCIA_SSPD.rowid FROM LDC_EQUIVALENCIA_SSPD';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_EQUIVALENCIA_SSPD for sbFullQuery;

		fetch rfLDC_EQUIVALENCIA_SSPD bulk collect INTO otbResult;

		close rfLDC_EQUIVALENCIA_SSPD;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_EQUIVALENCIA_SSPD.*, LDC_EQUIVALENCIA_SSPD.rowid FROM LDC_EQUIVALENCIA_SSPD';
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
		ircLDC_EQUIVALENCIA_SSPD in styLDC_EQUIVALENCIA_SSPD
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_EQUIVALENCIA_SSPD,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_EQUIVALENCIA_SSPD in styLDC_EQUIVALENCIA_SSPD,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|TIPO_SOLICITUD');
			raise ex.controlled_error;
		end if;
		if ircLDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|RESP_SOL_OSF');
			raise ex.controlled_error;
		end if;

		insert into LDC_EQUIVALENCIA_SSPD
		(
			TIPO_SOLICITUD,
			RESP_SOL_OSF,
			TIPO_RESPUESTA,
			CAUSAL_EQUIV_SSPD,
			APLICA_ITANSUCA,
			FORMATO,
			ACTIVO,
			FECHA_INICIAL,
			USUARIO,
			FECHA_REGISTRO,
			TERMINAL,
			CLASIFICACION
		)
		values
		(
			ircLDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD,
			ircLDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF,
			ircLDC_EQUIVALENCIA_SSPD.TIPO_RESPUESTA,
			ircLDC_EQUIVALENCIA_SSPD.CAUSAL_EQUIV_SSPD,
			ircLDC_EQUIVALENCIA_SSPD.APLICA_ITANSUCA,
			ircLDC_EQUIVALENCIA_SSPD.FORMATO,
			ircLDC_EQUIVALENCIA_SSPD.ACTIVO,
			ircLDC_EQUIVALENCIA_SSPD.FECHA_INICIAL,
			ircLDC_EQUIVALENCIA_SSPD.USUARIO,
			ircLDC_EQUIVALENCIA_SSPD.FECHA_REGISTRO,
			ircLDC_EQUIVALENCIA_SSPD.TERMINAL,
			ircLDC_EQUIVALENCIA_SSPD.CLASIFICACION
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_EQUIVALENCIA_SSPD));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_EQUIVALENCIA_SSPD in out nocopy tytbLDC_EQUIVALENCIA_SSPD
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_EQUIVALENCIA_SSPD,blUseRowID);
		forall n in iotbLDC_EQUIVALENCIA_SSPD.first..iotbLDC_EQUIVALENCIA_SSPD.last
			insert into LDC_EQUIVALENCIA_SSPD
			(
				TIPO_SOLICITUD,
				RESP_SOL_OSF,
				TIPO_RESPUESTA,
				CAUSAL_EQUIV_SSPD,
				APLICA_ITANSUCA,
				FORMATO,
				ACTIVO,
				FECHA_INICIAL,
				USUARIO,
				FECHA_REGISTRO,
				TERMINAL,
				CLASIFICACION
			)
			values
			(
				rcRecOfTab.TIPO_SOLICITUD(n),
				rcRecOfTab.RESP_SOL_OSF(n),
				rcRecOfTab.TIPO_RESPUESTA(n),
				rcRecOfTab.CAUSAL_EQUIV_SSPD(n),
				rcRecOfTab.APLICA_ITANSUCA(n),
				rcRecOfTab.FORMATO(n),
				rcRecOfTab.ACTIVO(n),
				rcRecOfTab.FECHA_INICIAL(n),
				rcRecOfTab.USUARIO(n),
				rcRecOfTab.FECHA_REGISTRO(n),
				rcRecOfTab.TERMINAL(n),
				rcRecOfTab.CLASIFICACION(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuTIPO_SOLICITUD in LDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD%type,
		inuRESP_SOL_OSF in LDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_EQUIVALENCIA_SSPD;
	BEGIN
		rcError.TIPO_SOLICITUD := inuTIPO_SOLICITUD;
		rcError.RESP_SOL_OSF := inuRESP_SOL_OSF;

		if inuLock=1 then
			LockByPk
			(
				inuTIPO_SOLICITUD,
				inuRESP_SOL_OSF,
				rcData
			);
		end if;


		delete
		from LDC_EQUIVALENCIA_SSPD
		where
       		TIPO_SOLICITUD=inuTIPO_SOLICITUD and
       		RESP_SOL_OSF=inuRESP_SOL_OSF;
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
		rcError  styLDC_EQUIVALENCIA_SSPD;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_EQUIVALENCIA_SSPD
		where
			rowid = iriRowID
		returning
			TIPO_SOLICITUD,
			RESP_SOL_OSF
		into
			rcError.TIPO_SOLICITUD,
			rcError.RESP_SOL_OSF;
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
		iotbLDC_EQUIVALENCIA_SSPD in out nocopy tytbLDC_EQUIVALENCIA_SSPD,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_EQUIVALENCIA_SSPD;
	BEGIN
		FillRecordOfTables(iotbLDC_EQUIVALENCIA_SSPD, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_EQUIVALENCIA_SSPD.first .. iotbLDC_EQUIVALENCIA_SSPD.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_EQUIVALENCIA_SSPD.first .. iotbLDC_EQUIVALENCIA_SSPD.last
				delete
				from LDC_EQUIVALENCIA_SSPD
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_EQUIVALENCIA_SSPD.first .. iotbLDC_EQUIVALENCIA_SSPD.last loop
					LockByPk
					(
						rcRecOfTab.TIPO_SOLICITUD(n),
						rcRecOfTab.RESP_SOL_OSF(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_EQUIVALENCIA_SSPD.first .. iotbLDC_EQUIVALENCIA_SSPD.last
				delete
				from LDC_EQUIVALENCIA_SSPD
				where
		         	TIPO_SOLICITUD = rcRecOfTab.TIPO_SOLICITUD(n) and
		         	RESP_SOL_OSF = rcRecOfTab.RESP_SOL_OSF(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_EQUIVALENCIA_SSPD in styLDC_EQUIVALENCIA_SSPD,
		inuLock in number default 0
	)
	IS
		nuTIPO_SOLICITUD	LDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD%type;
		nuRESP_SOL_OSF	LDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF%type;
	BEGIN
		if ircLDC_EQUIVALENCIA_SSPD.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_EQUIVALENCIA_SSPD.rowid,rcData);
			end if;
			update LDC_EQUIVALENCIA_SSPD
			set
				TIPO_RESPUESTA = ircLDC_EQUIVALENCIA_SSPD.TIPO_RESPUESTA,
				CAUSAL_EQUIV_SSPD = ircLDC_EQUIVALENCIA_SSPD.CAUSAL_EQUIV_SSPD,
				APLICA_ITANSUCA = ircLDC_EQUIVALENCIA_SSPD.APLICA_ITANSUCA,
				FORMATO = ircLDC_EQUIVALENCIA_SSPD.FORMATO,
				ACTIVO = ircLDC_EQUIVALENCIA_SSPD.ACTIVO,
				FECHA_INICIAL = ircLDC_EQUIVALENCIA_SSPD.FECHA_INICIAL,
				USUARIO = ircLDC_EQUIVALENCIA_SSPD.USUARIO,
				FECHA_REGISTRO = ircLDC_EQUIVALENCIA_SSPD.FECHA_REGISTRO,
				TERMINAL = ircLDC_EQUIVALENCIA_SSPD.TERMINAL,
				CLASIFICACION = ircLDC_EQUIVALENCIA_SSPD.CLASIFICACION
			where
				rowid = ircLDC_EQUIVALENCIA_SSPD.rowid
			returning
				TIPO_SOLICITUD,
				RESP_SOL_OSF
			into
				nuTIPO_SOLICITUD,
				nuRESP_SOL_OSF;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD,
					ircLDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF,
					rcData
				);
			end if;

			update LDC_EQUIVALENCIA_SSPD
			set
				TIPO_RESPUESTA = ircLDC_EQUIVALENCIA_SSPD.TIPO_RESPUESTA,
				CAUSAL_EQUIV_SSPD = ircLDC_EQUIVALENCIA_SSPD.CAUSAL_EQUIV_SSPD,
				APLICA_ITANSUCA = ircLDC_EQUIVALENCIA_SSPD.APLICA_ITANSUCA,
				FORMATO = ircLDC_EQUIVALENCIA_SSPD.FORMATO,
				ACTIVO = ircLDC_EQUIVALENCIA_SSPD.ACTIVO,
				FECHA_INICIAL = ircLDC_EQUIVALENCIA_SSPD.FECHA_INICIAL,
				USUARIO = ircLDC_EQUIVALENCIA_SSPD.USUARIO,
				FECHA_REGISTRO = ircLDC_EQUIVALENCIA_SSPD.FECHA_REGISTRO,
				TERMINAL = ircLDC_EQUIVALENCIA_SSPD.TERMINAL,
				CLASIFICACION = ircLDC_EQUIVALENCIA_SSPD.CLASIFICACION
			where
				TIPO_SOLICITUD = ircLDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD and
				RESP_SOL_OSF = ircLDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF
			returning
				TIPO_SOLICITUD,
				RESP_SOL_OSF
			into
				nuTIPO_SOLICITUD,
				nuRESP_SOL_OSF;
		end if;
		if
			nuTIPO_SOLICITUD is NULL OR
			nuRESP_SOL_OSF is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_EQUIVALENCIA_SSPD));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_EQUIVALENCIA_SSPD in out nocopy tytbLDC_EQUIVALENCIA_SSPD,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_EQUIVALENCIA_SSPD;
	BEGIN
		FillRecordOfTables(iotbLDC_EQUIVALENCIA_SSPD,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_EQUIVALENCIA_SSPD.first .. iotbLDC_EQUIVALENCIA_SSPD.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_EQUIVALENCIA_SSPD.first .. iotbLDC_EQUIVALENCIA_SSPD.last
				update LDC_EQUIVALENCIA_SSPD
				set
					TIPO_RESPUESTA = rcRecOfTab.TIPO_RESPUESTA(n),
					CAUSAL_EQUIV_SSPD = rcRecOfTab.CAUSAL_EQUIV_SSPD(n),
					APLICA_ITANSUCA = rcRecOfTab.APLICA_ITANSUCA(n),
					FORMATO = rcRecOfTab.FORMATO(n),
					ACTIVO = rcRecOfTab.ACTIVO(n),
					FECHA_INICIAL = rcRecOfTab.FECHA_INICIAL(n),
					USUARIO = rcRecOfTab.USUARIO(n),
					FECHA_REGISTRO = rcRecOfTab.FECHA_REGISTRO(n),
					TERMINAL = rcRecOfTab.TERMINAL(n),
					CLASIFICACION = rcRecOfTab.CLASIFICACION(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_EQUIVALENCIA_SSPD.first .. iotbLDC_EQUIVALENCIA_SSPD.last loop
					LockByPk
					(
						rcRecOfTab.TIPO_SOLICITUD(n),
						rcRecOfTab.RESP_SOL_OSF(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_EQUIVALENCIA_SSPD.first .. iotbLDC_EQUIVALENCIA_SSPD.last
				update LDC_EQUIVALENCIA_SSPD
				SET
					TIPO_RESPUESTA = rcRecOfTab.TIPO_RESPUESTA(n),
					CAUSAL_EQUIV_SSPD = rcRecOfTab.CAUSAL_EQUIV_SSPD(n),
					APLICA_ITANSUCA = rcRecOfTab.APLICA_ITANSUCA(n),
					FORMATO = rcRecOfTab.FORMATO(n),
					ACTIVO = rcRecOfTab.ACTIVO(n),
					FECHA_INICIAL = rcRecOfTab.FECHA_INICIAL(n),
					USUARIO = rcRecOfTab.USUARIO(n),
					FECHA_REGISTRO = rcRecOfTab.FECHA_REGISTRO(n),
					TERMINAL = rcRecOfTab.TERMINAL(n),
					CLASIFICACION = rcRecOfTab.CLASIFICACION(n)
				where
					TIPO_SOLICITUD = rcRecOfTab.TIPO_SOLICITUD(n) and
					RESP_SOL_OSF = rcRecOfTab.RESP_SOL_OSF(n)
;
		end if;
	END;
	PROCEDURE updTIPO_RESPUESTA
	(
		inuTIPO_SOLICITUD in LDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD%type,
		inuRESP_SOL_OSF in LDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF%type,
		inuTIPO_RESPUESTA$ in LDC_EQUIVALENCIA_SSPD.TIPO_RESPUESTA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_EQUIVALENCIA_SSPD;
	BEGIN
		rcError.TIPO_SOLICITUD := inuTIPO_SOLICITUD;
		rcError.RESP_SOL_OSF := inuRESP_SOL_OSF;
		if inuLock=1 then
			LockByPk
			(
				inuTIPO_SOLICITUD,
				inuRESP_SOL_OSF,
				rcData
			);
		end if;

		update LDC_EQUIVALENCIA_SSPD
		set
			TIPO_RESPUESTA = inuTIPO_RESPUESTA$
		where
			TIPO_SOLICITUD = inuTIPO_SOLICITUD and
			RESP_SOL_OSF = inuRESP_SOL_OSF;

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
		inuTIPO_SOLICITUD in LDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD%type,
		inuRESP_SOL_OSF in LDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF%type,
		inuCAUSAL_EQUIV_SSPD$ in LDC_EQUIVALENCIA_SSPD.CAUSAL_EQUIV_SSPD%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_EQUIVALENCIA_SSPD;
	BEGIN
		rcError.TIPO_SOLICITUD := inuTIPO_SOLICITUD;
		rcError.RESP_SOL_OSF := inuRESP_SOL_OSF;
		if inuLock=1 then
			LockByPk
			(
				inuTIPO_SOLICITUD,
				inuRESP_SOL_OSF,
				rcData
			);
		end if;

		update LDC_EQUIVALENCIA_SSPD
		set
			CAUSAL_EQUIV_SSPD = inuCAUSAL_EQUIV_SSPD$
		where
			TIPO_SOLICITUD = inuTIPO_SOLICITUD and
			RESP_SOL_OSF = inuRESP_SOL_OSF;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CAUSAL_EQUIV_SSPD:= inuCAUSAL_EQUIV_SSPD$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updAPLICA_ITANSUCA
	(
		inuTIPO_SOLICITUD in LDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD%type,
		inuRESP_SOL_OSF in LDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF%type,
		isbAPLICA_ITANSUCA$ in LDC_EQUIVALENCIA_SSPD.APLICA_ITANSUCA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_EQUIVALENCIA_SSPD;
	BEGIN
		rcError.TIPO_SOLICITUD := inuTIPO_SOLICITUD;
		rcError.RESP_SOL_OSF := inuRESP_SOL_OSF;
		if inuLock=1 then
			LockByPk
			(
				inuTIPO_SOLICITUD,
				inuRESP_SOL_OSF,
				rcData
			);
		end if;

		update LDC_EQUIVALENCIA_SSPD
		set
			APLICA_ITANSUCA = isbAPLICA_ITANSUCA$
		where
			TIPO_SOLICITUD = inuTIPO_SOLICITUD and
			RESP_SOL_OSF = inuRESP_SOL_OSF;

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
		inuTIPO_SOLICITUD in LDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD%type,
		inuRESP_SOL_OSF in LDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF%type,
		isbFORMATO$ in LDC_EQUIVALENCIA_SSPD.FORMATO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_EQUIVALENCIA_SSPD;
	BEGIN
		rcError.TIPO_SOLICITUD := inuTIPO_SOLICITUD;
		rcError.RESP_SOL_OSF := inuRESP_SOL_OSF;
		if inuLock=1 then
			LockByPk
			(
				inuTIPO_SOLICITUD,
				inuRESP_SOL_OSF,
				rcData
			);
		end if;

		update LDC_EQUIVALENCIA_SSPD
		set
			FORMATO = isbFORMATO$
		where
			TIPO_SOLICITUD = inuTIPO_SOLICITUD and
			RESP_SOL_OSF = inuRESP_SOL_OSF;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FORMATO:= isbFORMATO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updACTIVO
	(
		inuTIPO_SOLICITUD in LDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD%type,
		inuRESP_SOL_OSF in LDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF%type,
		isbACTIVO$ in LDC_EQUIVALENCIA_SSPD.ACTIVO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_EQUIVALENCIA_SSPD;
	BEGIN
		rcError.TIPO_SOLICITUD := inuTIPO_SOLICITUD;
		rcError.RESP_SOL_OSF := inuRESP_SOL_OSF;
		if inuLock=1 then
			LockByPk
			(
				inuTIPO_SOLICITUD,
				inuRESP_SOL_OSF,
				rcData
			);
		end if;

		update LDC_EQUIVALENCIA_SSPD
		set
			ACTIVO = isbACTIVO$
		where
			TIPO_SOLICITUD = inuTIPO_SOLICITUD and
			RESP_SOL_OSF = inuRESP_SOL_OSF;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ACTIVO:= isbACTIVO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFECHA_INICIAL
	(
		inuTIPO_SOLICITUD in LDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD%type,
		inuRESP_SOL_OSF in LDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF%type,
		idtFECHA_INICIAL$ in LDC_EQUIVALENCIA_SSPD.FECHA_INICIAL%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_EQUIVALENCIA_SSPD;
	BEGIN
		rcError.TIPO_SOLICITUD := inuTIPO_SOLICITUD;
		rcError.RESP_SOL_OSF := inuRESP_SOL_OSF;
		if inuLock=1 then
			LockByPk
			(
				inuTIPO_SOLICITUD,
				inuRESP_SOL_OSF,
				rcData
			);
		end if;

		update LDC_EQUIVALENCIA_SSPD
		set
			FECHA_INICIAL = idtFECHA_INICIAL$
		where
			TIPO_SOLICITUD = inuTIPO_SOLICITUD and
			RESP_SOL_OSF = inuRESP_SOL_OSF;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FECHA_INICIAL:= idtFECHA_INICIAL$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updUSUARIO
	(
		inuTIPO_SOLICITUD in LDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD%type,
		inuRESP_SOL_OSF in LDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF%type,
		inuUSUARIO$ in LDC_EQUIVALENCIA_SSPD.USUARIO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_EQUIVALENCIA_SSPD;
	BEGIN
		rcError.TIPO_SOLICITUD := inuTIPO_SOLICITUD;
		rcError.RESP_SOL_OSF := inuRESP_SOL_OSF;
		if inuLock=1 then
			LockByPk
			(
				inuTIPO_SOLICITUD,
				inuRESP_SOL_OSF,
				rcData
			);
		end if;

		update LDC_EQUIVALENCIA_SSPD
		set
			USUARIO = inuUSUARIO$
		where
			TIPO_SOLICITUD = inuTIPO_SOLICITUD and
			RESP_SOL_OSF = inuRESP_SOL_OSF;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.USUARIO:= inuUSUARIO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFECHA_REGISTRO
	(
		inuTIPO_SOLICITUD in LDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD%type,
		inuRESP_SOL_OSF in LDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF%type,
		idtFECHA_REGISTRO$ in LDC_EQUIVALENCIA_SSPD.FECHA_REGISTRO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_EQUIVALENCIA_SSPD;
	BEGIN
		rcError.TIPO_SOLICITUD := inuTIPO_SOLICITUD;
		rcError.RESP_SOL_OSF := inuRESP_SOL_OSF;
		if inuLock=1 then
			LockByPk
			(
				inuTIPO_SOLICITUD,
				inuRESP_SOL_OSF,
				rcData
			);
		end if;

		update LDC_EQUIVALENCIA_SSPD
		set
			FECHA_REGISTRO = idtFECHA_REGISTRO$
		where
			TIPO_SOLICITUD = inuTIPO_SOLICITUD and
			RESP_SOL_OSF = inuRESP_SOL_OSF;

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
		inuTIPO_SOLICITUD in LDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD%type,
		inuRESP_SOL_OSF in LDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF%type,
		isbTERMINAL$ in LDC_EQUIVALENCIA_SSPD.TERMINAL%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_EQUIVALENCIA_SSPD;
	BEGIN
		rcError.TIPO_SOLICITUD := inuTIPO_SOLICITUD;
		rcError.RESP_SOL_OSF := inuRESP_SOL_OSF;
		if inuLock=1 then
			LockByPk
			(
				inuTIPO_SOLICITUD,
				inuRESP_SOL_OSF,
				rcData
			);
		end if;

		update LDC_EQUIVALENCIA_SSPD
		set
			TERMINAL = isbTERMINAL$
		where
			TIPO_SOLICITUD = inuTIPO_SOLICITUD and
			RESP_SOL_OSF = inuRESP_SOL_OSF;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TERMINAL:= isbTERMINAL$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCLASIFICACION
	(
		inuTIPO_SOLICITUD in LDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD%type,
		inuRESP_SOL_OSF in LDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF%type,
		inuCLASIFICACION$ in LDC_EQUIVALENCIA_SSPD.CLASIFICACION%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_EQUIVALENCIA_SSPD;
	BEGIN
		rcError.TIPO_SOLICITUD := inuTIPO_SOLICITUD;
		rcError.RESP_SOL_OSF := inuRESP_SOL_OSF;
		if inuLock=1 then
			LockByPk
			(
				inuTIPO_SOLICITUD,
				inuRESP_SOL_OSF,
				rcData
			);
		end if;

		update LDC_EQUIVALENCIA_SSPD
		set
			CLASIFICACION = inuCLASIFICACION$
		where
			TIPO_SOLICITUD = inuTIPO_SOLICITUD and
			RESP_SOL_OSF = inuRESP_SOL_OSF;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CLASIFICACION:= inuCLASIFICACION$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetTIPO_SOLICITUD
	(
		inuTIPO_SOLICITUD in LDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD%type,
		inuRESP_SOL_OSF in LDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD%type
	IS
		rcError styLDC_EQUIVALENCIA_SSPD;
	BEGIN

		rcError.TIPO_SOLICITUD := inuTIPO_SOLICITUD;
		rcError.RESP_SOL_OSF := inuRESP_SOL_OSF;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuTIPO_SOLICITUD,
		 		inuRESP_SOL_OSF
			 )
		then
			 return(rcData.TIPO_SOLICITUD);
		end if;
		Load
		(
		 		inuTIPO_SOLICITUD,
		 		inuRESP_SOL_OSF
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
		inuTIPO_SOLICITUD in LDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD%type,
		inuRESP_SOL_OSF in LDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF%type
	IS
		rcError styLDC_EQUIVALENCIA_SSPD;
	BEGIN

		rcError.TIPO_SOLICITUD := inuTIPO_SOLICITUD;
		rcError.RESP_SOL_OSF := inuRESP_SOL_OSF;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuTIPO_SOLICITUD,
		 		inuRESP_SOL_OSF
			 )
		then
			 return(rcData.RESP_SOL_OSF);
		end if;
		Load
		(
		 		inuTIPO_SOLICITUD,
		 		inuRESP_SOL_OSF
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
		inuTIPO_SOLICITUD in LDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD%type,
		inuRESP_SOL_OSF in LDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_EQUIVALENCIA_SSPD.TIPO_RESPUESTA%type
	IS
		rcError styLDC_EQUIVALENCIA_SSPD;
	BEGIN

		rcError.TIPO_SOLICITUD := inuTIPO_SOLICITUD;
		rcError.RESP_SOL_OSF := inuRESP_SOL_OSF;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuTIPO_SOLICITUD,
		 		inuRESP_SOL_OSF
			 )
		then
			 return(rcData.TIPO_RESPUESTA);
		end if;
		Load
		(
		 		inuTIPO_SOLICITUD,
		 		inuRESP_SOL_OSF
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
		inuTIPO_SOLICITUD in LDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD%type,
		inuRESP_SOL_OSF in LDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_EQUIVALENCIA_SSPD.CAUSAL_EQUIV_SSPD%type
	IS
		rcError styLDC_EQUIVALENCIA_SSPD;
	BEGIN

		rcError.TIPO_SOLICITUD := inuTIPO_SOLICITUD;
		rcError.RESP_SOL_OSF := inuRESP_SOL_OSF;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuTIPO_SOLICITUD,
		 		inuRESP_SOL_OSF
			 )
		then
			 return(rcData.CAUSAL_EQUIV_SSPD);
		end if;
		Load
		(
		 		inuTIPO_SOLICITUD,
		 		inuRESP_SOL_OSF
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
	FUNCTION fsbGetAPLICA_ITANSUCA
	(
		inuTIPO_SOLICITUD in LDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD%type,
		inuRESP_SOL_OSF in LDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_EQUIVALENCIA_SSPD.APLICA_ITANSUCA%type
	IS
		rcError styLDC_EQUIVALENCIA_SSPD;
	BEGIN

		rcError.TIPO_SOLICITUD := inuTIPO_SOLICITUD;
		rcError.RESP_SOL_OSF := inuRESP_SOL_OSF;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuTIPO_SOLICITUD,
		 		inuRESP_SOL_OSF
			 )
		then
			 return(rcData.APLICA_ITANSUCA);
		end if;
		Load
		(
		 		inuTIPO_SOLICITUD,
		 		inuRESP_SOL_OSF
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
		inuTIPO_SOLICITUD in LDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD%type,
		inuRESP_SOL_OSF in LDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_EQUIVALENCIA_SSPD.FORMATO%type
	IS
		rcError styLDC_EQUIVALENCIA_SSPD;
	BEGIN

		rcError.TIPO_SOLICITUD := inuTIPO_SOLICITUD;
		rcError.RESP_SOL_OSF := inuRESP_SOL_OSF;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuTIPO_SOLICITUD,
		 		inuRESP_SOL_OSF
			 )
		then
			 return(rcData.FORMATO);
		end if;
		Load
		(
		 		inuTIPO_SOLICITUD,
		 		inuRESP_SOL_OSF
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
	FUNCTION fsbGetACTIVO
	(
		inuTIPO_SOLICITUD in LDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD%type,
		inuRESP_SOL_OSF in LDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_EQUIVALENCIA_SSPD.ACTIVO%type
	IS
		rcError styLDC_EQUIVALENCIA_SSPD;
	BEGIN

		rcError.TIPO_SOLICITUD := inuTIPO_SOLICITUD;
		rcError.RESP_SOL_OSF := inuRESP_SOL_OSF;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuTIPO_SOLICITUD,
		 		inuRESP_SOL_OSF
			 )
		then
			 return(rcData.ACTIVO);
		end if;
		Load
		(
		 		inuTIPO_SOLICITUD,
		 		inuRESP_SOL_OSF
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
	FUNCTION fdtGetFECHA_INICIAL
	(
		inuTIPO_SOLICITUD in LDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD%type,
		inuRESP_SOL_OSF in LDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_EQUIVALENCIA_SSPD.FECHA_INICIAL%type
	IS
		rcError styLDC_EQUIVALENCIA_SSPD;
	BEGIN

		rcError.TIPO_SOLICITUD := inuTIPO_SOLICITUD;
		rcError.RESP_SOL_OSF := inuRESP_SOL_OSF;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuTIPO_SOLICITUD,
		 		inuRESP_SOL_OSF
			 )
		then
			 return(rcData.FECHA_INICIAL);
		end if;
		Load
		(
		 		inuTIPO_SOLICITUD,
		 		inuRESP_SOL_OSF
		);
		return(rcData.FECHA_INICIAL);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetUSUARIO
	(
		inuTIPO_SOLICITUD in LDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD%type,
		inuRESP_SOL_OSF in LDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_EQUIVALENCIA_SSPD.USUARIO%type
	IS
		rcError styLDC_EQUIVALENCIA_SSPD;
	BEGIN

		rcError.TIPO_SOLICITUD := inuTIPO_SOLICITUD;
		rcError.RESP_SOL_OSF := inuRESP_SOL_OSF;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuTIPO_SOLICITUD,
		 		inuRESP_SOL_OSF
			 )
		then
			 return(rcData.USUARIO);
		end if;
		Load
		(
		 		inuTIPO_SOLICITUD,
		 		inuRESP_SOL_OSF
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
		inuTIPO_SOLICITUD in LDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD%type,
		inuRESP_SOL_OSF in LDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_EQUIVALENCIA_SSPD.FECHA_REGISTRO%type
	IS
		rcError styLDC_EQUIVALENCIA_SSPD;
	BEGIN

		rcError.TIPO_SOLICITUD := inuTIPO_SOLICITUD;
		rcError.RESP_SOL_OSF := inuRESP_SOL_OSF;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuTIPO_SOLICITUD,
		 		inuRESP_SOL_OSF
			 )
		then
			 return(rcData.FECHA_REGISTRO);
		end if;
		Load
		(
		 		inuTIPO_SOLICITUD,
		 		inuRESP_SOL_OSF
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
		inuTIPO_SOLICITUD in LDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD%type,
		inuRESP_SOL_OSF in LDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_EQUIVALENCIA_SSPD.TERMINAL%type
	IS
		rcError styLDC_EQUIVALENCIA_SSPD;
	BEGIN

		rcError.TIPO_SOLICITUD := inuTIPO_SOLICITUD;
		rcError.RESP_SOL_OSF := inuRESP_SOL_OSF;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuTIPO_SOLICITUD,
		 		inuRESP_SOL_OSF
			 )
		then
			 return(rcData.TERMINAL);
		end if;
		Load
		(
		 		inuTIPO_SOLICITUD,
		 		inuRESP_SOL_OSF
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
	FUNCTION fnuGetCLASIFICACION
	(
		inuTIPO_SOLICITUD in LDC_EQUIVALENCIA_SSPD.TIPO_SOLICITUD%type,
		inuRESP_SOL_OSF in LDC_EQUIVALENCIA_SSPD.RESP_SOL_OSF%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_EQUIVALENCIA_SSPD.CLASIFICACION%type
	IS
		rcError styLDC_EQUIVALENCIA_SSPD;
	BEGIN

		rcError.TIPO_SOLICITUD := inuTIPO_SOLICITUD;
		rcError.RESP_SOL_OSF := inuRESP_SOL_OSF;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuTIPO_SOLICITUD,
		 		inuRESP_SOL_OSF
			 )
		then
			 return(rcData.CLASIFICACION);
		end if;
		Load
		(
		 		inuTIPO_SOLICITUD,
		 		inuRESP_SOL_OSF
		);
		return(rcData.CLASIFICACION);
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
end DALDC_EQUIVALENCIA_SSPD;
/
PROMPT Otorgando permisos de ejecucion a DALDC_EQUIVALENCIA_SSPD
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_EQUIVALENCIA_SSPD', 'ADM_PERSON');
END;
/