CREATE OR REPLACE PACKAGE ADM_PERSON.DALDC_RESPUESTA_CAUSAL
is
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     : DALDC_RESPUESTA_CAUSAL
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
		inuRESPCAUS_OSF in LDC_RESPUESTA_CAUSAL.RESPCAUS_OSF%type,
		inuTIPOSOLICITUD in LDC_RESPUESTA_CAUSAL.TIPOSOLICITUD%type
	)
	IS
		SELECT LDC_RESPUESTA_CAUSAL.*,LDC_RESPUESTA_CAUSAL.rowid
		FROM LDC_RESPUESTA_CAUSAL
		WHERE
		    RESPCAUS_OSF = inuRESPCAUS_OSF
		    and TIPOSOLICITUD = inuTIPOSOLICITUD;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_RESPUESTA_CAUSAL.*,LDC_RESPUESTA_CAUSAL.rowid
		FROM LDC_RESPUESTA_CAUSAL
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_RESPUESTA_CAUSAL  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_RESPUESTA_CAUSAL is table of styLDC_RESPUESTA_CAUSAL index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_RESPUESTA_CAUSAL;

	/* Tipos referenciando al registro */
	type tytbRESPCAUS_OSF is table of LDC_RESPUESTA_CAUSAL.RESPCAUS_OSF%type index by binary_integer;
	type tytbTIPOSOLICITUD is table of LDC_RESPUESTA_CAUSAL.TIPOSOLICITUD%type index by binary_integer;
	type tytbEQUIVALENCIA_SSPD is table of LDC_RESPUESTA_CAUSAL.EQUIVALENCIA_SSPD%type index by binary_integer;
	type tytbTIPORESPUESTA is table of LDC_RESPUESTA_CAUSAL.TIPORESPUESTA%type index by binary_integer;
	type tytbFECHA_INICIAL is table of LDC_RESPUESTA_CAUSAL.FECHA_INICIAL%type index by binary_integer;
	type tytbFECHA_FINAL is table of LDC_RESPUESTA_CAUSAL.FECHA_FINAL%type index by binary_integer;
	type tytbRESOLUCION is table of LDC_RESPUESTA_CAUSAL.RESOLUCION%type index by binary_integer;
	type tytbUSUARIO is table of LDC_RESPUESTA_CAUSAL.USUARIO%type index by binary_integer;
	type tytbFECHA_REGISTRO is table of LDC_RESPUESTA_CAUSAL.FECHA_REGISTRO%type index by binary_integer;
	type tytbCLASIFICACION is table of LDC_RESPUESTA_CAUSAL.CLASIFICACION%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_RESPUESTA_CAUSAL is record
	(
		RESPCAUS_OSF   tytbRESPCAUS_OSF,
		TIPOSOLICITUD   tytbTIPOSOLICITUD,
		EQUIVALENCIA_SSPD   tytbEQUIVALENCIA_SSPD,
		TIPORESPUESTA   tytbTIPORESPUESTA,
		FECHA_INICIAL   tytbFECHA_INICIAL,
		FECHA_FINAL   tytbFECHA_FINAL,
		RESOLUCION   tytbRESOLUCION,
		USUARIO   tytbUSUARIO,
		FECHA_REGISTRO   tytbFECHA_REGISTRO,
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
		inuRESPCAUS_OSF in LDC_RESPUESTA_CAUSAL.RESPCAUS_OSF%type,
		inuTIPOSOLICITUD in LDC_RESPUESTA_CAUSAL.TIPOSOLICITUD%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuRESPCAUS_OSF in LDC_RESPUESTA_CAUSAL.RESPCAUS_OSF%type,
		inuTIPOSOLICITUD in LDC_RESPUESTA_CAUSAL.TIPOSOLICITUD%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuRESPCAUS_OSF in LDC_RESPUESTA_CAUSAL.RESPCAUS_OSF%type,
		inuTIPOSOLICITUD in LDC_RESPUESTA_CAUSAL.TIPOSOLICITUD%type
	);

	PROCEDURE getRecord
	(
		inuRESPCAUS_OSF in LDC_RESPUESTA_CAUSAL.RESPCAUS_OSF%type,
		inuTIPOSOLICITUD in LDC_RESPUESTA_CAUSAL.TIPOSOLICITUD%type,
		orcRecord out nocopy styLDC_RESPUESTA_CAUSAL
	);

	FUNCTION frcGetRcData
	(
		inuRESPCAUS_OSF in LDC_RESPUESTA_CAUSAL.RESPCAUS_OSF%type,
		inuTIPOSOLICITUD in LDC_RESPUESTA_CAUSAL.TIPOSOLICITUD%type
	)
	RETURN styLDC_RESPUESTA_CAUSAL;

	FUNCTION frcGetRcData
	RETURN styLDC_RESPUESTA_CAUSAL;

	FUNCTION frcGetRecord
	(
		inuRESPCAUS_OSF in LDC_RESPUESTA_CAUSAL.RESPCAUS_OSF%type,
		inuTIPOSOLICITUD in LDC_RESPUESTA_CAUSAL.TIPOSOLICITUD%type
	)
	RETURN styLDC_RESPUESTA_CAUSAL;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_RESPUESTA_CAUSAL
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_RESPUESTA_CAUSAL in styLDC_RESPUESTA_CAUSAL
	);

	PROCEDURE insRecord
	(
		ircLDC_RESPUESTA_CAUSAL in styLDC_RESPUESTA_CAUSAL,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_RESPUESTA_CAUSAL in out nocopy tytbLDC_RESPUESTA_CAUSAL
	);

	PROCEDURE delRecord
	(
		inuRESPCAUS_OSF in LDC_RESPUESTA_CAUSAL.RESPCAUS_OSF%type,
		inuTIPOSOLICITUD in LDC_RESPUESTA_CAUSAL.TIPOSOLICITUD%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_RESPUESTA_CAUSAL in out nocopy tytbLDC_RESPUESTA_CAUSAL,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_RESPUESTA_CAUSAL in styLDC_RESPUESTA_CAUSAL,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_RESPUESTA_CAUSAL in out nocopy tytbLDC_RESPUESTA_CAUSAL,
		inuLock in number default 1
	);

	PROCEDURE updEQUIVALENCIA_SSPD
	(
		inuRESPCAUS_OSF in LDC_RESPUESTA_CAUSAL.RESPCAUS_OSF%type,
		inuTIPOSOLICITUD in LDC_RESPUESTA_CAUSAL.TIPOSOLICITUD%type,
		inuEQUIVALENCIA_SSPD$ in LDC_RESPUESTA_CAUSAL.EQUIVALENCIA_SSPD%type,
		inuLock in number default 0
	);

	PROCEDURE updTIPORESPUESTA
	(
		inuRESPCAUS_OSF in LDC_RESPUESTA_CAUSAL.RESPCAUS_OSF%type,
		inuTIPOSOLICITUD in LDC_RESPUESTA_CAUSAL.TIPOSOLICITUD%type,
		inuTIPORESPUESTA$ in LDC_RESPUESTA_CAUSAL.TIPORESPUESTA%type,
		inuLock in number default 0
	);

	PROCEDURE updFECHA_INICIAL
	(
		inuRESPCAUS_OSF in LDC_RESPUESTA_CAUSAL.RESPCAUS_OSF%type,
		inuTIPOSOLICITUD in LDC_RESPUESTA_CAUSAL.TIPOSOLICITUD%type,
		idtFECHA_INICIAL$ in LDC_RESPUESTA_CAUSAL.FECHA_INICIAL%type,
		inuLock in number default 0
	);

	PROCEDURE updFECHA_FINAL
	(
		inuRESPCAUS_OSF in LDC_RESPUESTA_CAUSAL.RESPCAUS_OSF%type,
		inuTIPOSOLICITUD in LDC_RESPUESTA_CAUSAL.TIPOSOLICITUD%type,
		idtFECHA_FINAL$ in LDC_RESPUESTA_CAUSAL.FECHA_FINAL%type,
		inuLock in number default 0
	);

	PROCEDURE updRESOLUCION
	(
		inuRESPCAUS_OSF in LDC_RESPUESTA_CAUSAL.RESPCAUS_OSF%type,
		inuTIPOSOLICITUD in LDC_RESPUESTA_CAUSAL.TIPOSOLICITUD%type,
		isbRESOLUCION$ in LDC_RESPUESTA_CAUSAL.RESOLUCION%type,
		inuLock in number default 0
	);

	PROCEDURE updUSUARIO
	(
		inuRESPCAUS_OSF in LDC_RESPUESTA_CAUSAL.RESPCAUS_OSF%type,
		inuTIPOSOLICITUD in LDC_RESPUESTA_CAUSAL.TIPOSOLICITUD%type,
		inuUSUARIO$ in LDC_RESPUESTA_CAUSAL.USUARIO%type,
		inuLock in number default 0
	);

	PROCEDURE updFECHA_REGISTRO
	(
		inuRESPCAUS_OSF in LDC_RESPUESTA_CAUSAL.RESPCAUS_OSF%type,
		inuTIPOSOLICITUD in LDC_RESPUESTA_CAUSAL.TIPOSOLICITUD%type,
		idtFECHA_REGISTRO$ in LDC_RESPUESTA_CAUSAL.FECHA_REGISTRO%type,
		inuLock in number default 0
	);

	PROCEDURE updCLASIFICACION
	(
		inuRESPCAUS_OSF in LDC_RESPUESTA_CAUSAL.RESPCAUS_OSF%type,
		inuTIPOSOLICITUD in LDC_RESPUESTA_CAUSAL.TIPOSOLICITUD%type,
		inuCLASIFICACION$ in LDC_RESPUESTA_CAUSAL.CLASIFICACION%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetRESPCAUS_OSF
	(
		inuRESPCAUS_OSF in LDC_RESPUESTA_CAUSAL.RESPCAUS_OSF%type,
		inuTIPOSOLICITUD in LDC_RESPUESTA_CAUSAL.TIPOSOLICITUD%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RESPUESTA_CAUSAL.RESPCAUS_OSF%type;

	FUNCTION fnuGetTIPOSOLICITUD
	(
		inuRESPCAUS_OSF in LDC_RESPUESTA_CAUSAL.RESPCAUS_OSF%type,
		inuTIPOSOLICITUD in LDC_RESPUESTA_CAUSAL.TIPOSOLICITUD%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RESPUESTA_CAUSAL.TIPOSOLICITUD%type;

	FUNCTION fnuGetEQUIVALENCIA_SSPD
	(
		inuRESPCAUS_OSF in LDC_RESPUESTA_CAUSAL.RESPCAUS_OSF%type,
		inuTIPOSOLICITUD in LDC_RESPUESTA_CAUSAL.TIPOSOLICITUD%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RESPUESTA_CAUSAL.EQUIVALENCIA_SSPD%type;

	FUNCTION fnuGetTIPORESPUESTA
	(
		inuRESPCAUS_OSF in LDC_RESPUESTA_CAUSAL.RESPCAUS_OSF%type,
		inuTIPOSOLICITUD in LDC_RESPUESTA_CAUSAL.TIPOSOLICITUD%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RESPUESTA_CAUSAL.TIPORESPUESTA%type;

	FUNCTION fdtGetFECHA_INICIAL
	(
		inuRESPCAUS_OSF in LDC_RESPUESTA_CAUSAL.RESPCAUS_OSF%type,
		inuTIPOSOLICITUD in LDC_RESPUESTA_CAUSAL.TIPOSOLICITUD%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RESPUESTA_CAUSAL.FECHA_INICIAL%type;

	FUNCTION fdtGetFECHA_FINAL
	(
		inuRESPCAUS_OSF in LDC_RESPUESTA_CAUSAL.RESPCAUS_OSF%type,
		inuTIPOSOLICITUD in LDC_RESPUESTA_CAUSAL.TIPOSOLICITUD%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RESPUESTA_CAUSAL.FECHA_FINAL%type;

	FUNCTION fsbGetRESOLUCION
	(
		inuRESPCAUS_OSF in LDC_RESPUESTA_CAUSAL.RESPCAUS_OSF%type,
		inuTIPOSOLICITUD in LDC_RESPUESTA_CAUSAL.TIPOSOLICITUD%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RESPUESTA_CAUSAL.RESOLUCION%type;

	FUNCTION fnuGetUSUARIO
	(
		inuRESPCAUS_OSF in LDC_RESPUESTA_CAUSAL.RESPCAUS_OSF%type,
		inuTIPOSOLICITUD in LDC_RESPUESTA_CAUSAL.TIPOSOLICITUD%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RESPUESTA_CAUSAL.USUARIO%type;

	FUNCTION fdtGetFECHA_REGISTRO
	(
		inuRESPCAUS_OSF in LDC_RESPUESTA_CAUSAL.RESPCAUS_OSF%type,
		inuTIPOSOLICITUD in LDC_RESPUESTA_CAUSAL.TIPOSOLICITUD%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RESPUESTA_CAUSAL.FECHA_REGISTRO%type;

	FUNCTION fnuGetCLASIFICACION
	(
		inuRESPCAUS_OSF in LDC_RESPUESTA_CAUSAL.RESPCAUS_OSF%type,
		inuTIPOSOLICITUD in LDC_RESPUESTA_CAUSAL.TIPOSOLICITUD%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RESPUESTA_CAUSAL.CLASIFICACION%type;


	PROCEDURE LockByPk
	(
		inuRESPCAUS_OSF in LDC_RESPUESTA_CAUSAL.RESPCAUS_OSF%type,
		inuTIPOSOLICITUD in LDC_RESPUESTA_CAUSAL.TIPOSOLICITUD%type,
		orcLDC_RESPUESTA_CAUSAL  out styLDC_RESPUESTA_CAUSAL
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_RESPUESTA_CAUSAL  out styLDC_RESPUESTA_CAUSAL
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_RESPUESTA_CAUSAL;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALDC_RESPUESTA_CAUSAL
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_RESPUESTA_CAUSAL';
	 cnuGeEntityId constant varchar2(30) := 8705; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuRESPCAUS_OSF in LDC_RESPUESTA_CAUSAL.RESPCAUS_OSF%type,
		inuTIPOSOLICITUD in LDC_RESPUESTA_CAUSAL.TIPOSOLICITUD%type
	)
	IS
		SELECT LDC_RESPUESTA_CAUSAL.*,LDC_RESPUESTA_CAUSAL.rowid
		FROM LDC_RESPUESTA_CAUSAL
		WHERE  RESPCAUS_OSF = inuRESPCAUS_OSF
			and TIPOSOLICITUD = inuTIPOSOLICITUD
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_RESPUESTA_CAUSAL.*,LDC_RESPUESTA_CAUSAL.rowid
		FROM LDC_RESPUESTA_CAUSAL
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_RESPUESTA_CAUSAL is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_RESPUESTA_CAUSAL;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_RESPUESTA_CAUSAL default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.RESPCAUS_OSF);
		sbPk:=sbPk||','||ut_convert.fsbToChar(rcI.TIPOSOLICITUD);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuRESPCAUS_OSF in LDC_RESPUESTA_CAUSAL.RESPCAUS_OSF%type,
		inuTIPOSOLICITUD in LDC_RESPUESTA_CAUSAL.TIPOSOLICITUD%type,
		orcLDC_RESPUESTA_CAUSAL  out styLDC_RESPUESTA_CAUSAL
	)
	IS
		rcError styLDC_RESPUESTA_CAUSAL;
	BEGIN
		rcError.RESPCAUS_OSF := inuRESPCAUS_OSF;
		rcError.TIPOSOLICITUD := inuTIPOSOLICITUD;

		Open cuLockRcByPk
		(
			inuRESPCAUS_OSF,
			inuTIPOSOLICITUD
		);

		fetch cuLockRcByPk into orcLDC_RESPUESTA_CAUSAL;
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
		orcLDC_RESPUESTA_CAUSAL  out styLDC_RESPUESTA_CAUSAL
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_RESPUESTA_CAUSAL;
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
		itbLDC_RESPUESTA_CAUSAL  in out nocopy tytbLDC_RESPUESTA_CAUSAL
	)
	IS
	BEGIN
			rcRecOfTab.RESPCAUS_OSF.delete;
			rcRecOfTab.TIPOSOLICITUD.delete;
			rcRecOfTab.EQUIVALENCIA_SSPD.delete;
			rcRecOfTab.TIPORESPUESTA.delete;
			rcRecOfTab.FECHA_INICIAL.delete;
			rcRecOfTab.FECHA_FINAL.delete;
			rcRecOfTab.RESOLUCION.delete;
			rcRecOfTab.USUARIO.delete;
			rcRecOfTab.FECHA_REGISTRO.delete;
			rcRecOfTab.CLASIFICACION.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_RESPUESTA_CAUSAL  in out nocopy tytbLDC_RESPUESTA_CAUSAL,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_RESPUESTA_CAUSAL);

		for n in itbLDC_RESPUESTA_CAUSAL.first .. itbLDC_RESPUESTA_CAUSAL.last loop
			rcRecOfTab.RESPCAUS_OSF(n) := itbLDC_RESPUESTA_CAUSAL(n).RESPCAUS_OSF;
			rcRecOfTab.TIPOSOLICITUD(n) := itbLDC_RESPUESTA_CAUSAL(n).TIPOSOLICITUD;
			rcRecOfTab.EQUIVALENCIA_SSPD(n) := itbLDC_RESPUESTA_CAUSAL(n).EQUIVALENCIA_SSPD;
			rcRecOfTab.TIPORESPUESTA(n) := itbLDC_RESPUESTA_CAUSAL(n).TIPORESPUESTA;
			rcRecOfTab.FECHA_INICIAL(n) := itbLDC_RESPUESTA_CAUSAL(n).FECHA_INICIAL;
			rcRecOfTab.FECHA_FINAL(n) := itbLDC_RESPUESTA_CAUSAL(n).FECHA_FINAL;
			rcRecOfTab.RESOLUCION(n) := itbLDC_RESPUESTA_CAUSAL(n).RESOLUCION;
			rcRecOfTab.USUARIO(n) := itbLDC_RESPUESTA_CAUSAL(n).USUARIO;
			rcRecOfTab.FECHA_REGISTRO(n) := itbLDC_RESPUESTA_CAUSAL(n).FECHA_REGISTRO;
			rcRecOfTab.CLASIFICACION(n) := itbLDC_RESPUESTA_CAUSAL(n).CLASIFICACION;
			rcRecOfTab.row_id(n) := itbLDC_RESPUESTA_CAUSAL(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuRESPCAUS_OSF in LDC_RESPUESTA_CAUSAL.RESPCAUS_OSF%type,
		inuTIPOSOLICITUD in LDC_RESPUESTA_CAUSAL.TIPOSOLICITUD%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuRESPCAUS_OSF,
			inuTIPOSOLICITUD
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
		inuRESPCAUS_OSF in LDC_RESPUESTA_CAUSAL.RESPCAUS_OSF%type,
		inuTIPOSOLICITUD in LDC_RESPUESTA_CAUSAL.TIPOSOLICITUD%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuRESPCAUS_OSF = rcData.RESPCAUS_OSF AND
			inuTIPOSOLICITUD = rcData.TIPOSOLICITUD
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
		inuRESPCAUS_OSF in LDC_RESPUESTA_CAUSAL.RESPCAUS_OSF%type,
		inuTIPOSOLICITUD in LDC_RESPUESTA_CAUSAL.TIPOSOLICITUD%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuRESPCAUS_OSF,
			inuTIPOSOLICITUD
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuRESPCAUS_OSF in LDC_RESPUESTA_CAUSAL.RESPCAUS_OSF%type,
		inuTIPOSOLICITUD in LDC_RESPUESTA_CAUSAL.TIPOSOLICITUD%type
	)
	IS
		rcError styLDC_RESPUESTA_CAUSAL;
	BEGIN		rcError.RESPCAUS_OSF:=inuRESPCAUS_OSF;		rcError.TIPOSOLICITUD:=inuTIPOSOLICITUD;

		Load
		(
			inuRESPCAUS_OSF,
			inuTIPOSOLICITUD
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
		inuRESPCAUS_OSF in LDC_RESPUESTA_CAUSAL.RESPCAUS_OSF%type,
		inuTIPOSOLICITUD in LDC_RESPUESTA_CAUSAL.TIPOSOLICITUD%type
	)
	IS
	BEGIN
		Load
		(
			inuRESPCAUS_OSF,
			inuTIPOSOLICITUD
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuRESPCAUS_OSF in LDC_RESPUESTA_CAUSAL.RESPCAUS_OSF%type,
		inuTIPOSOLICITUD in LDC_RESPUESTA_CAUSAL.TIPOSOLICITUD%type,
		orcRecord out nocopy styLDC_RESPUESTA_CAUSAL
	)
	IS
		rcError styLDC_RESPUESTA_CAUSAL;
	BEGIN		rcError.RESPCAUS_OSF:=inuRESPCAUS_OSF;		rcError.TIPOSOLICITUD:=inuTIPOSOLICITUD;

		Load
		(
			inuRESPCAUS_OSF,
			inuTIPOSOLICITUD
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuRESPCAUS_OSF in LDC_RESPUESTA_CAUSAL.RESPCAUS_OSF%type,
		inuTIPOSOLICITUD in LDC_RESPUESTA_CAUSAL.TIPOSOLICITUD%type
	)
	RETURN styLDC_RESPUESTA_CAUSAL
	IS
		rcError styLDC_RESPUESTA_CAUSAL;
	BEGIN
		rcError.RESPCAUS_OSF:=inuRESPCAUS_OSF;
		rcError.TIPOSOLICITUD:=inuTIPOSOLICITUD;

		Load
		(
			inuRESPCAUS_OSF,
			inuTIPOSOLICITUD
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuRESPCAUS_OSF in LDC_RESPUESTA_CAUSAL.RESPCAUS_OSF%type,
		inuTIPOSOLICITUD in LDC_RESPUESTA_CAUSAL.TIPOSOLICITUD%type
	)
	RETURN styLDC_RESPUESTA_CAUSAL
	IS
		rcError styLDC_RESPUESTA_CAUSAL;
	BEGIN
		rcError.RESPCAUS_OSF:=inuRESPCAUS_OSF;
		rcError.TIPOSOLICITUD:=inuTIPOSOLICITUD;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuRESPCAUS_OSF,
			inuTIPOSOLICITUD
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuRESPCAUS_OSF,
			inuTIPOSOLICITUD
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_RESPUESTA_CAUSAL
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_RESPUESTA_CAUSAL
	)
	IS
		rfLDC_RESPUESTA_CAUSAL tyrfLDC_RESPUESTA_CAUSAL;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_RESPUESTA_CAUSAL.*, LDC_RESPUESTA_CAUSAL.rowid FROM LDC_RESPUESTA_CAUSAL';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_RESPUESTA_CAUSAL for sbFullQuery;

		fetch rfLDC_RESPUESTA_CAUSAL bulk collect INTO otbResult;

		close rfLDC_RESPUESTA_CAUSAL;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_RESPUESTA_CAUSAL.*, LDC_RESPUESTA_CAUSAL.rowid FROM LDC_RESPUESTA_CAUSAL';
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
		ircLDC_RESPUESTA_CAUSAL in styLDC_RESPUESTA_CAUSAL
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_RESPUESTA_CAUSAL,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_RESPUESTA_CAUSAL in styLDC_RESPUESTA_CAUSAL,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_RESPUESTA_CAUSAL.RESPCAUS_OSF is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|RESPCAUS_OSF');
			raise ex.controlled_error;
		end if;
		if ircLDC_RESPUESTA_CAUSAL.TIPOSOLICITUD is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|TIPOSOLICITUD');
			raise ex.controlled_error;
		end if;

		insert into LDC_RESPUESTA_CAUSAL
		(
			RESPCAUS_OSF,
			TIPOSOLICITUD,
			EQUIVALENCIA_SSPD,
			TIPORESPUESTA,
			FECHA_INICIAL,
			FECHA_FINAL,
			RESOLUCION,
			USUARIO,
			FECHA_REGISTRO,
			CLASIFICACION
		)
		values
		(
			ircLDC_RESPUESTA_CAUSAL.RESPCAUS_OSF,
			ircLDC_RESPUESTA_CAUSAL.TIPOSOLICITUD,
			ircLDC_RESPUESTA_CAUSAL.EQUIVALENCIA_SSPD,
			ircLDC_RESPUESTA_CAUSAL.TIPORESPUESTA,
			ircLDC_RESPUESTA_CAUSAL.FECHA_INICIAL,
			ircLDC_RESPUESTA_CAUSAL.FECHA_FINAL,
			ircLDC_RESPUESTA_CAUSAL.RESOLUCION,
			ircLDC_RESPUESTA_CAUSAL.USUARIO,
			ircLDC_RESPUESTA_CAUSAL.FECHA_REGISTRO,
			ircLDC_RESPUESTA_CAUSAL.CLASIFICACION
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_RESPUESTA_CAUSAL));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_RESPUESTA_CAUSAL in out nocopy tytbLDC_RESPUESTA_CAUSAL
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_RESPUESTA_CAUSAL,blUseRowID);
		forall n in iotbLDC_RESPUESTA_CAUSAL.first..iotbLDC_RESPUESTA_CAUSAL.last
			insert into LDC_RESPUESTA_CAUSAL
			(
				RESPCAUS_OSF,
				TIPOSOLICITUD,
				EQUIVALENCIA_SSPD,
				TIPORESPUESTA,
				FECHA_INICIAL,
				FECHA_FINAL,
				RESOLUCION,
				USUARIO,
				FECHA_REGISTRO,
				CLASIFICACION
			)
			values
			(
				rcRecOfTab.RESPCAUS_OSF(n),
				rcRecOfTab.TIPOSOLICITUD(n),
				rcRecOfTab.EQUIVALENCIA_SSPD(n),
				rcRecOfTab.TIPORESPUESTA(n),
				rcRecOfTab.FECHA_INICIAL(n),
				rcRecOfTab.FECHA_FINAL(n),
				rcRecOfTab.RESOLUCION(n),
				rcRecOfTab.USUARIO(n),
				rcRecOfTab.FECHA_REGISTRO(n),
				rcRecOfTab.CLASIFICACION(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuRESPCAUS_OSF in LDC_RESPUESTA_CAUSAL.RESPCAUS_OSF%type,
		inuTIPOSOLICITUD in LDC_RESPUESTA_CAUSAL.TIPOSOLICITUD%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_RESPUESTA_CAUSAL;
	BEGIN
		rcError.RESPCAUS_OSF := inuRESPCAUS_OSF;
		rcError.TIPOSOLICITUD := inuTIPOSOLICITUD;

		if inuLock=1 then
			LockByPk
			(
				inuRESPCAUS_OSF,
				inuTIPOSOLICITUD,
				rcData
			);
		end if;


		delete
		from LDC_RESPUESTA_CAUSAL
		where
       		RESPCAUS_OSF=inuRESPCAUS_OSF and
       		TIPOSOLICITUD=inuTIPOSOLICITUD;
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
		rcError  styLDC_RESPUESTA_CAUSAL;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_RESPUESTA_CAUSAL
		where
			rowid = iriRowID
		returning
			RESPCAUS_OSF,
			TIPOSOLICITUD
		into
			rcError.RESPCAUS_OSF,
			rcError.TIPOSOLICITUD;
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
		iotbLDC_RESPUESTA_CAUSAL in out nocopy tytbLDC_RESPUESTA_CAUSAL,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_RESPUESTA_CAUSAL;
	BEGIN
		FillRecordOfTables(iotbLDC_RESPUESTA_CAUSAL, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_RESPUESTA_CAUSAL.first .. iotbLDC_RESPUESTA_CAUSAL.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_RESPUESTA_CAUSAL.first .. iotbLDC_RESPUESTA_CAUSAL.last
				delete
				from LDC_RESPUESTA_CAUSAL
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_RESPUESTA_CAUSAL.first .. iotbLDC_RESPUESTA_CAUSAL.last loop
					LockByPk
					(
						rcRecOfTab.RESPCAUS_OSF(n),
						rcRecOfTab.TIPOSOLICITUD(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_RESPUESTA_CAUSAL.first .. iotbLDC_RESPUESTA_CAUSAL.last
				delete
				from LDC_RESPUESTA_CAUSAL
				where
		         	RESPCAUS_OSF = rcRecOfTab.RESPCAUS_OSF(n) and
		         	TIPOSOLICITUD = rcRecOfTab.TIPOSOLICITUD(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_RESPUESTA_CAUSAL in styLDC_RESPUESTA_CAUSAL,
		inuLock in number default 0
	)
	IS
		nuRESPCAUS_OSF	LDC_RESPUESTA_CAUSAL.RESPCAUS_OSF%type;
		nuTIPOSOLICITUD	LDC_RESPUESTA_CAUSAL.TIPOSOLICITUD%type;
	BEGIN
		if ircLDC_RESPUESTA_CAUSAL.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_RESPUESTA_CAUSAL.rowid,rcData);
			end if;
			update LDC_RESPUESTA_CAUSAL
			set
				EQUIVALENCIA_SSPD = ircLDC_RESPUESTA_CAUSAL.EQUIVALENCIA_SSPD,
				TIPORESPUESTA = ircLDC_RESPUESTA_CAUSAL.TIPORESPUESTA,
				FECHA_INICIAL = ircLDC_RESPUESTA_CAUSAL.FECHA_INICIAL,
				FECHA_FINAL = ircLDC_RESPUESTA_CAUSAL.FECHA_FINAL,
				RESOLUCION = ircLDC_RESPUESTA_CAUSAL.RESOLUCION,
				USUARIO = ircLDC_RESPUESTA_CAUSAL.USUARIO,
				FECHA_REGISTRO = ircLDC_RESPUESTA_CAUSAL.FECHA_REGISTRO,
				CLASIFICACION = ircLDC_RESPUESTA_CAUSAL.CLASIFICACION
			where
				rowid = ircLDC_RESPUESTA_CAUSAL.rowid
			returning
				RESPCAUS_OSF,
				TIPOSOLICITUD
			into
				nuRESPCAUS_OSF,
				nuTIPOSOLICITUD;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_RESPUESTA_CAUSAL.RESPCAUS_OSF,
					ircLDC_RESPUESTA_CAUSAL.TIPOSOLICITUD,
					rcData
				);
			end if;

			update LDC_RESPUESTA_CAUSAL
			set
				EQUIVALENCIA_SSPD = ircLDC_RESPUESTA_CAUSAL.EQUIVALENCIA_SSPD,
				TIPORESPUESTA = ircLDC_RESPUESTA_CAUSAL.TIPORESPUESTA,
				FECHA_INICIAL = ircLDC_RESPUESTA_CAUSAL.FECHA_INICIAL,
				FECHA_FINAL = ircLDC_RESPUESTA_CAUSAL.FECHA_FINAL,
				RESOLUCION = ircLDC_RESPUESTA_CAUSAL.RESOLUCION,
				USUARIO = ircLDC_RESPUESTA_CAUSAL.USUARIO,
				FECHA_REGISTRO = ircLDC_RESPUESTA_CAUSAL.FECHA_REGISTRO,
				CLASIFICACION = ircLDC_RESPUESTA_CAUSAL.CLASIFICACION
			where
				RESPCAUS_OSF = ircLDC_RESPUESTA_CAUSAL.RESPCAUS_OSF and
				TIPOSOLICITUD = ircLDC_RESPUESTA_CAUSAL.TIPOSOLICITUD
			returning
				RESPCAUS_OSF,
				TIPOSOLICITUD
			into
				nuRESPCAUS_OSF,
				nuTIPOSOLICITUD;
		end if;
		if
			nuRESPCAUS_OSF is NULL OR
			nuTIPOSOLICITUD is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_RESPUESTA_CAUSAL));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_RESPUESTA_CAUSAL in out nocopy tytbLDC_RESPUESTA_CAUSAL,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_RESPUESTA_CAUSAL;
	BEGIN
		FillRecordOfTables(iotbLDC_RESPUESTA_CAUSAL,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_RESPUESTA_CAUSAL.first .. iotbLDC_RESPUESTA_CAUSAL.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_RESPUESTA_CAUSAL.first .. iotbLDC_RESPUESTA_CAUSAL.last
				update LDC_RESPUESTA_CAUSAL
				set
					EQUIVALENCIA_SSPD = rcRecOfTab.EQUIVALENCIA_SSPD(n),
					TIPORESPUESTA = rcRecOfTab.TIPORESPUESTA(n),
					FECHA_INICIAL = rcRecOfTab.FECHA_INICIAL(n),
					FECHA_FINAL = rcRecOfTab.FECHA_FINAL(n),
					RESOLUCION = rcRecOfTab.RESOLUCION(n),
					USUARIO = rcRecOfTab.USUARIO(n),
					FECHA_REGISTRO = rcRecOfTab.FECHA_REGISTRO(n),
					CLASIFICACION = rcRecOfTab.CLASIFICACION(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_RESPUESTA_CAUSAL.first .. iotbLDC_RESPUESTA_CAUSAL.last loop
					LockByPk
					(
						rcRecOfTab.RESPCAUS_OSF(n),
						rcRecOfTab.TIPOSOLICITUD(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_RESPUESTA_CAUSAL.first .. iotbLDC_RESPUESTA_CAUSAL.last
				update LDC_RESPUESTA_CAUSAL
				SET
					EQUIVALENCIA_SSPD = rcRecOfTab.EQUIVALENCIA_SSPD(n),
					TIPORESPUESTA = rcRecOfTab.TIPORESPUESTA(n),
					FECHA_INICIAL = rcRecOfTab.FECHA_INICIAL(n),
					FECHA_FINAL = rcRecOfTab.FECHA_FINAL(n),
					RESOLUCION = rcRecOfTab.RESOLUCION(n),
					USUARIO = rcRecOfTab.USUARIO(n),
					FECHA_REGISTRO = rcRecOfTab.FECHA_REGISTRO(n),
					CLASIFICACION = rcRecOfTab.CLASIFICACION(n)
				where
					RESPCAUS_OSF = rcRecOfTab.RESPCAUS_OSF(n) and
					TIPOSOLICITUD = rcRecOfTab.TIPOSOLICITUD(n)
;
		end if;
	END;
	PROCEDURE updEQUIVALENCIA_SSPD
	(
		inuRESPCAUS_OSF in LDC_RESPUESTA_CAUSAL.RESPCAUS_OSF%type,
		inuTIPOSOLICITUD in LDC_RESPUESTA_CAUSAL.TIPOSOLICITUD%type,
		inuEQUIVALENCIA_SSPD$ in LDC_RESPUESTA_CAUSAL.EQUIVALENCIA_SSPD%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_RESPUESTA_CAUSAL;
	BEGIN
		rcError.RESPCAUS_OSF := inuRESPCAUS_OSF;
		rcError.TIPOSOLICITUD := inuTIPOSOLICITUD;
		if inuLock=1 then
			LockByPk
			(
				inuRESPCAUS_OSF,
				inuTIPOSOLICITUD,
				rcData
			);
		end if;

		update LDC_RESPUESTA_CAUSAL
		set
			EQUIVALENCIA_SSPD = inuEQUIVALENCIA_SSPD$
		where
			RESPCAUS_OSF = inuRESPCAUS_OSF and
			TIPOSOLICITUD = inuTIPOSOLICITUD;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.EQUIVALENCIA_SSPD:= inuEQUIVALENCIA_SSPD$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updTIPORESPUESTA
	(
		inuRESPCAUS_OSF in LDC_RESPUESTA_CAUSAL.RESPCAUS_OSF%type,
		inuTIPOSOLICITUD in LDC_RESPUESTA_CAUSAL.TIPOSOLICITUD%type,
		inuTIPORESPUESTA$ in LDC_RESPUESTA_CAUSAL.TIPORESPUESTA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_RESPUESTA_CAUSAL;
	BEGIN
		rcError.RESPCAUS_OSF := inuRESPCAUS_OSF;
		rcError.TIPOSOLICITUD := inuTIPOSOLICITUD;
		if inuLock=1 then
			LockByPk
			(
				inuRESPCAUS_OSF,
				inuTIPOSOLICITUD,
				rcData
			);
		end if;

		update LDC_RESPUESTA_CAUSAL
		set
			TIPORESPUESTA = inuTIPORESPUESTA$
		where
			RESPCAUS_OSF = inuRESPCAUS_OSF and
			TIPOSOLICITUD = inuTIPOSOLICITUD;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TIPORESPUESTA:= inuTIPORESPUESTA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFECHA_INICIAL
	(
		inuRESPCAUS_OSF in LDC_RESPUESTA_CAUSAL.RESPCAUS_OSF%type,
		inuTIPOSOLICITUD in LDC_RESPUESTA_CAUSAL.TIPOSOLICITUD%type,
		idtFECHA_INICIAL$ in LDC_RESPUESTA_CAUSAL.FECHA_INICIAL%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_RESPUESTA_CAUSAL;
	BEGIN
		rcError.RESPCAUS_OSF := inuRESPCAUS_OSF;
		rcError.TIPOSOLICITUD := inuTIPOSOLICITUD;
		if inuLock=1 then
			LockByPk
			(
				inuRESPCAUS_OSF,
				inuTIPOSOLICITUD,
				rcData
			);
		end if;

		update LDC_RESPUESTA_CAUSAL
		set
			FECHA_INICIAL = idtFECHA_INICIAL$
		where
			RESPCAUS_OSF = inuRESPCAUS_OSF and
			TIPOSOLICITUD = inuTIPOSOLICITUD;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FECHA_INICIAL:= idtFECHA_INICIAL$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFECHA_FINAL
	(
		inuRESPCAUS_OSF in LDC_RESPUESTA_CAUSAL.RESPCAUS_OSF%type,
		inuTIPOSOLICITUD in LDC_RESPUESTA_CAUSAL.TIPOSOLICITUD%type,
		idtFECHA_FINAL$ in LDC_RESPUESTA_CAUSAL.FECHA_FINAL%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_RESPUESTA_CAUSAL;
	BEGIN
		rcError.RESPCAUS_OSF := inuRESPCAUS_OSF;
		rcError.TIPOSOLICITUD := inuTIPOSOLICITUD;
		if inuLock=1 then
			LockByPk
			(
				inuRESPCAUS_OSF,
				inuTIPOSOLICITUD,
				rcData
			);
		end if;

		update LDC_RESPUESTA_CAUSAL
		set
			FECHA_FINAL = idtFECHA_FINAL$
		where
			RESPCAUS_OSF = inuRESPCAUS_OSF and
			TIPOSOLICITUD = inuTIPOSOLICITUD;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FECHA_FINAL:= idtFECHA_FINAL$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRESOLUCION
	(
		inuRESPCAUS_OSF in LDC_RESPUESTA_CAUSAL.RESPCAUS_OSF%type,
		inuTIPOSOLICITUD in LDC_RESPUESTA_CAUSAL.TIPOSOLICITUD%type,
		isbRESOLUCION$ in LDC_RESPUESTA_CAUSAL.RESOLUCION%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_RESPUESTA_CAUSAL;
	BEGIN
		rcError.RESPCAUS_OSF := inuRESPCAUS_OSF;
		rcError.TIPOSOLICITUD := inuTIPOSOLICITUD;
		if inuLock=1 then
			LockByPk
			(
				inuRESPCAUS_OSF,
				inuTIPOSOLICITUD,
				rcData
			);
		end if;

		update LDC_RESPUESTA_CAUSAL
		set
			RESOLUCION = isbRESOLUCION$
		where
			RESPCAUS_OSF = inuRESPCAUS_OSF and
			TIPOSOLICITUD = inuTIPOSOLICITUD;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.RESOLUCION:= isbRESOLUCION$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updUSUARIO
	(
		inuRESPCAUS_OSF in LDC_RESPUESTA_CAUSAL.RESPCAUS_OSF%type,
		inuTIPOSOLICITUD in LDC_RESPUESTA_CAUSAL.TIPOSOLICITUD%type,
		inuUSUARIO$ in LDC_RESPUESTA_CAUSAL.USUARIO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_RESPUESTA_CAUSAL;
	BEGIN
		rcError.RESPCAUS_OSF := inuRESPCAUS_OSF;
		rcError.TIPOSOLICITUD := inuTIPOSOLICITUD;
		if inuLock=1 then
			LockByPk
			(
				inuRESPCAUS_OSF,
				inuTIPOSOLICITUD,
				rcData
			);
		end if;

		update LDC_RESPUESTA_CAUSAL
		set
			USUARIO = inuUSUARIO$
		where
			RESPCAUS_OSF = inuRESPCAUS_OSF and
			TIPOSOLICITUD = inuTIPOSOLICITUD;

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
		inuRESPCAUS_OSF in LDC_RESPUESTA_CAUSAL.RESPCAUS_OSF%type,
		inuTIPOSOLICITUD in LDC_RESPUESTA_CAUSAL.TIPOSOLICITUD%type,
		idtFECHA_REGISTRO$ in LDC_RESPUESTA_CAUSAL.FECHA_REGISTRO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_RESPUESTA_CAUSAL;
	BEGIN
		rcError.RESPCAUS_OSF := inuRESPCAUS_OSF;
		rcError.TIPOSOLICITUD := inuTIPOSOLICITUD;
		if inuLock=1 then
			LockByPk
			(
				inuRESPCAUS_OSF,
				inuTIPOSOLICITUD,
				rcData
			);
		end if;

		update LDC_RESPUESTA_CAUSAL
		set
			FECHA_REGISTRO = idtFECHA_REGISTRO$
		where
			RESPCAUS_OSF = inuRESPCAUS_OSF and
			TIPOSOLICITUD = inuTIPOSOLICITUD;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FECHA_REGISTRO:= idtFECHA_REGISTRO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCLASIFICACION
	(
		inuRESPCAUS_OSF in LDC_RESPUESTA_CAUSAL.RESPCAUS_OSF%type,
		inuTIPOSOLICITUD in LDC_RESPUESTA_CAUSAL.TIPOSOLICITUD%type,
		inuCLASIFICACION$ in LDC_RESPUESTA_CAUSAL.CLASIFICACION%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_RESPUESTA_CAUSAL;
	BEGIN
		rcError.RESPCAUS_OSF := inuRESPCAUS_OSF;
		rcError.TIPOSOLICITUD := inuTIPOSOLICITUD;
		if inuLock=1 then
			LockByPk
			(
				inuRESPCAUS_OSF,
				inuTIPOSOLICITUD,
				rcData
			);
		end if;

		update LDC_RESPUESTA_CAUSAL
		set
			CLASIFICACION = inuCLASIFICACION$
		where
			RESPCAUS_OSF = inuRESPCAUS_OSF and
			TIPOSOLICITUD = inuTIPOSOLICITUD;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CLASIFICACION:= inuCLASIFICACION$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetRESPCAUS_OSF
	(
		inuRESPCAUS_OSF in LDC_RESPUESTA_CAUSAL.RESPCAUS_OSF%type,
		inuTIPOSOLICITUD in LDC_RESPUESTA_CAUSAL.TIPOSOLICITUD%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RESPUESTA_CAUSAL.RESPCAUS_OSF%type
	IS
		rcError styLDC_RESPUESTA_CAUSAL;
	BEGIN

		rcError.RESPCAUS_OSF := inuRESPCAUS_OSF;
		rcError.TIPOSOLICITUD := inuTIPOSOLICITUD;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRESPCAUS_OSF,
		 		inuTIPOSOLICITUD
			 )
		then
			 return(rcData.RESPCAUS_OSF);
		end if;
		Load
		(
		 		inuRESPCAUS_OSF,
		 		inuTIPOSOLICITUD
		);
		return(rcData.RESPCAUS_OSF);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetTIPOSOLICITUD
	(
		inuRESPCAUS_OSF in LDC_RESPUESTA_CAUSAL.RESPCAUS_OSF%type,
		inuTIPOSOLICITUD in LDC_RESPUESTA_CAUSAL.TIPOSOLICITUD%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RESPUESTA_CAUSAL.TIPOSOLICITUD%type
	IS
		rcError styLDC_RESPUESTA_CAUSAL;
	BEGIN

		rcError.RESPCAUS_OSF := inuRESPCAUS_OSF;
		rcError.TIPOSOLICITUD := inuTIPOSOLICITUD;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRESPCAUS_OSF,
		 		inuTIPOSOLICITUD
			 )
		then
			 return(rcData.TIPOSOLICITUD);
		end if;
		Load
		(
		 		inuRESPCAUS_OSF,
		 		inuTIPOSOLICITUD
		);
		return(rcData.TIPOSOLICITUD);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetEQUIVALENCIA_SSPD
	(
		inuRESPCAUS_OSF in LDC_RESPUESTA_CAUSAL.RESPCAUS_OSF%type,
		inuTIPOSOLICITUD in LDC_RESPUESTA_CAUSAL.TIPOSOLICITUD%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RESPUESTA_CAUSAL.EQUIVALENCIA_SSPD%type
	IS
		rcError styLDC_RESPUESTA_CAUSAL;
	BEGIN

		rcError.RESPCAUS_OSF := inuRESPCAUS_OSF;
		rcError.TIPOSOLICITUD := inuTIPOSOLICITUD;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRESPCAUS_OSF,
		 		inuTIPOSOLICITUD
			 )
		then
			 return(rcData.EQUIVALENCIA_SSPD);
		end if;
		Load
		(
		 		inuRESPCAUS_OSF,
		 		inuTIPOSOLICITUD
		);
		return(rcData.EQUIVALENCIA_SSPD);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetTIPORESPUESTA
	(
		inuRESPCAUS_OSF in LDC_RESPUESTA_CAUSAL.RESPCAUS_OSF%type,
		inuTIPOSOLICITUD in LDC_RESPUESTA_CAUSAL.TIPOSOLICITUD%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RESPUESTA_CAUSAL.TIPORESPUESTA%type
	IS
		rcError styLDC_RESPUESTA_CAUSAL;
	BEGIN

		rcError.RESPCAUS_OSF := inuRESPCAUS_OSF;
		rcError.TIPOSOLICITUD := inuTIPOSOLICITUD;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRESPCAUS_OSF,
		 		inuTIPOSOLICITUD
			 )
		then
			 return(rcData.TIPORESPUESTA);
		end if;
		Load
		(
		 		inuRESPCAUS_OSF,
		 		inuTIPOSOLICITUD
		);
		return(rcData.TIPORESPUESTA);
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
		inuRESPCAUS_OSF in LDC_RESPUESTA_CAUSAL.RESPCAUS_OSF%type,
		inuTIPOSOLICITUD in LDC_RESPUESTA_CAUSAL.TIPOSOLICITUD%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RESPUESTA_CAUSAL.FECHA_INICIAL%type
	IS
		rcError styLDC_RESPUESTA_CAUSAL;
	BEGIN

		rcError.RESPCAUS_OSF := inuRESPCAUS_OSF;
		rcError.TIPOSOLICITUD := inuTIPOSOLICITUD;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRESPCAUS_OSF,
		 		inuTIPOSOLICITUD
			 )
		then
			 return(rcData.FECHA_INICIAL);
		end if;
		Load
		(
		 		inuRESPCAUS_OSF,
		 		inuTIPOSOLICITUD
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
	FUNCTION fdtGetFECHA_FINAL
	(
		inuRESPCAUS_OSF in LDC_RESPUESTA_CAUSAL.RESPCAUS_OSF%type,
		inuTIPOSOLICITUD in LDC_RESPUESTA_CAUSAL.TIPOSOLICITUD%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RESPUESTA_CAUSAL.FECHA_FINAL%type
	IS
		rcError styLDC_RESPUESTA_CAUSAL;
	BEGIN

		rcError.RESPCAUS_OSF := inuRESPCAUS_OSF;
		rcError.TIPOSOLICITUD := inuTIPOSOLICITUD;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRESPCAUS_OSF,
		 		inuTIPOSOLICITUD
			 )
		then
			 return(rcData.FECHA_FINAL);
		end if;
		Load
		(
		 		inuRESPCAUS_OSF,
		 		inuTIPOSOLICITUD
		);
		return(rcData.FECHA_FINAL);
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
		inuRESPCAUS_OSF in LDC_RESPUESTA_CAUSAL.RESPCAUS_OSF%type,
		inuTIPOSOLICITUD in LDC_RESPUESTA_CAUSAL.TIPOSOLICITUD%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RESPUESTA_CAUSAL.RESOLUCION%type
	IS
		rcError styLDC_RESPUESTA_CAUSAL;
	BEGIN

		rcError.RESPCAUS_OSF := inuRESPCAUS_OSF;
		rcError.TIPOSOLICITUD := inuTIPOSOLICITUD;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRESPCAUS_OSF,
		 		inuTIPOSOLICITUD
			 )
		then
			 return(rcData.RESOLUCION);
		end if;
		Load
		(
		 		inuRESPCAUS_OSF,
		 		inuTIPOSOLICITUD
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
	FUNCTION fnuGetUSUARIO
	(
		inuRESPCAUS_OSF in LDC_RESPUESTA_CAUSAL.RESPCAUS_OSF%type,
		inuTIPOSOLICITUD in LDC_RESPUESTA_CAUSAL.TIPOSOLICITUD%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RESPUESTA_CAUSAL.USUARIO%type
	IS
		rcError styLDC_RESPUESTA_CAUSAL;
	BEGIN

		rcError.RESPCAUS_OSF := inuRESPCAUS_OSF;
		rcError.TIPOSOLICITUD := inuTIPOSOLICITUD;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRESPCAUS_OSF,
		 		inuTIPOSOLICITUD
			 )
		then
			 return(rcData.USUARIO);
		end if;
		Load
		(
		 		inuRESPCAUS_OSF,
		 		inuTIPOSOLICITUD
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
		inuRESPCAUS_OSF in LDC_RESPUESTA_CAUSAL.RESPCAUS_OSF%type,
		inuTIPOSOLICITUD in LDC_RESPUESTA_CAUSAL.TIPOSOLICITUD%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RESPUESTA_CAUSAL.FECHA_REGISTRO%type
	IS
		rcError styLDC_RESPUESTA_CAUSAL;
	BEGIN

		rcError.RESPCAUS_OSF := inuRESPCAUS_OSF;
		rcError.TIPOSOLICITUD := inuTIPOSOLICITUD;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRESPCAUS_OSF,
		 		inuTIPOSOLICITUD
			 )
		then
			 return(rcData.FECHA_REGISTRO);
		end if;
		Load
		(
		 		inuRESPCAUS_OSF,
		 		inuTIPOSOLICITUD
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
	FUNCTION fnuGetCLASIFICACION
	(
		inuRESPCAUS_OSF in LDC_RESPUESTA_CAUSAL.RESPCAUS_OSF%type,
		inuTIPOSOLICITUD in LDC_RESPUESTA_CAUSAL.TIPOSOLICITUD%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RESPUESTA_CAUSAL.CLASIFICACION%type
	IS
		rcError styLDC_RESPUESTA_CAUSAL;
	BEGIN

		rcError.RESPCAUS_OSF := inuRESPCAUS_OSF;
		rcError.TIPOSOLICITUD := inuTIPOSOLICITUD;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRESPCAUS_OSF,
		 		inuTIPOSOLICITUD
			 )
		then
			 return(rcData.CLASIFICACION);
		end if;
		Load
		(
		 		inuRESPCAUS_OSF,
		 		inuTIPOSOLICITUD
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
end DALDC_RESPUESTA_CAUSAL;
/
PROMPT Otorgando permisos de ejecucion a DALDC_RESPUESTA_CAUSAL
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_RESPUESTA_CAUSAL', 'ADM_PERSON');
END;
/