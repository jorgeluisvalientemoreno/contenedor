CREATE OR REPLACE PACKAGE adm_person.daldc_templocfaco
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  11/06/2024   Adrianavg   OSF-2813: Migrar del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type
	)
	IS
		SELECT LDC_TEMPLOCFACO.*,LDC_TEMPLOCFACO.rowid
		FROM LDC_TEMPLOCFACO
		WHERE
		    CONSECUTIVO = inuCONSECUTIVO;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_TEMPLOCFACO.*,LDC_TEMPLOCFACO.rowid
		FROM LDC_TEMPLOCFACO
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_TEMPLOCFACO  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_TEMPLOCFACO is table of styLDC_TEMPLOCFACO index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_TEMPLOCFACO;

	/* Tipos referenciando al registro */
	type tytbCONSECUTIVO is table of LDC_TEMPLOCFACO.CONSECUTIVO%type index by binary_integer;
	type tytbTEMP_ANO is table of LDC_TEMPLOCFACO.TEMP_ANO%type index by binary_integer;
	type tytbTEMP_MES is table of LDC_TEMPLOCFACO.TEMP_MES%type index by binary_integer;
	type tytbCAPITAL is table of LDC_TEMPLOCFACO.CAPITAL%type index by binary_integer;
	type tytbVARIABLE_TEMPERATURA is table of LDC_TEMPLOCFACO.VARIABLE_TEMPERATURA%type index by binary_integer;
	type tytbVALOR is table of LDC_TEMPLOCFACO.VALOR%type index by binary_integer;
	type tytbVALOR_PROM is table of LDC_TEMPLOCFACO.VALOR_PROM%type index by binary_integer;
	type tytbFECHA_REG is table of LDC_TEMPLOCFACO.FECHA_REG%type index by binary_integer;
	type tytbFECHA_INI is table of LDC_TEMPLOCFACO.FECHA_INI%type index by binary_integer;
	type tytbFECHA_FIN is table of LDC_TEMPLOCFACO.FECHA_FIN%type index by binary_integer;
	type tytbESTADO_APRO is table of LDC_TEMPLOCFACO.ESTADO_APRO%type index by binary_integer;
	type tytbFECHA_APRO is table of LDC_TEMPLOCFACO.FECHA_APRO%type index by binary_integer;
	type tytbUSUARIO is table of LDC_TEMPLOCFACO.USUARIO%type index by binary_integer;
	type tytbTERMINAL is table of LDC_TEMPLOCFACO.TERMINAL%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_TEMPLOCFACO is record
	(
		CONSECUTIVO   tytbCONSECUTIVO,
		TEMP_ANO   tytbTEMP_ANO,
		TEMP_MES   tytbTEMP_MES,
		CAPITAL   tytbCAPITAL,
		VARIABLE_TEMPERATURA   tytbVARIABLE_TEMPERATURA,
		VALOR   tytbVALOR,
		VALOR_PROM   tytbVALOR_PROM,
		FECHA_REG   tytbFECHA_REG,
		FECHA_INI   tytbFECHA_INI,
		FECHA_FIN   tytbFECHA_FIN,
		ESTADO_APRO   tytbESTADO_APRO,
		FECHA_APRO   tytbFECHA_APRO,
		USUARIO   tytbUSUARIO,
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
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type
	);

	PROCEDURE getRecord
	(
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type,
		orcRecord out nocopy styLDC_TEMPLOCFACO
	);

	FUNCTION frcGetRcData
	(
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type
	)
	RETURN styLDC_TEMPLOCFACO;

	FUNCTION frcGetRcData
	RETURN styLDC_TEMPLOCFACO;

	FUNCTION frcGetRecord
	(
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type
	)
	RETURN styLDC_TEMPLOCFACO;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_TEMPLOCFACO
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_TEMPLOCFACO in styLDC_TEMPLOCFACO
	);

	PROCEDURE insRecord
	(
		ircLDC_TEMPLOCFACO in styLDC_TEMPLOCFACO,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_TEMPLOCFACO in out nocopy tytbLDC_TEMPLOCFACO
	);

	PROCEDURE delRecord
	(
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_TEMPLOCFACO in out nocopy tytbLDC_TEMPLOCFACO,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_TEMPLOCFACO in styLDC_TEMPLOCFACO,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_TEMPLOCFACO in out nocopy tytbLDC_TEMPLOCFACO,
		inuLock in number default 1
	);

	PROCEDURE updTEMP_ANO
	(
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type,
		inuTEMP_ANO$ in LDC_TEMPLOCFACO.TEMP_ANO%type,
		inuLock in number default 0
	);

	PROCEDURE updTEMP_MES
	(
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type,
		inuTEMP_MES$ in LDC_TEMPLOCFACO.TEMP_MES%type,
		inuLock in number default 0
	);

	PROCEDURE updCAPITAL
	(
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type,
		inuCAPITAL$ in LDC_TEMPLOCFACO.CAPITAL%type,
		inuLock in number default 0
	);

	PROCEDURE updVARIABLE_TEMPERATURA
	(
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type,
		isbVARIABLE_TEMPERATURA$ in LDC_TEMPLOCFACO.VARIABLE_TEMPERATURA%type,
		inuLock in number default 0
	);

	PROCEDURE updVALOR
	(
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type,
		inuVALOR$ in LDC_TEMPLOCFACO.VALOR%type,
		inuLock in number default 0
	);

	PROCEDURE updVALOR_PROM
	(
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type,
		inuVALOR_PROM$ in LDC_TEMPLOCFACO.VALOR_PROM%type,
		inuLock in number default 0
	);

	PROCEDURE updFECHA_REG
	(
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type,
		idtFECHA_REG$ in LDC_TEMPLOCFACO.FECHA_REG%type,
		inuLock in number default 0
	);

	PROCEDURE updFECHA_INI
	(
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type,
		idtFECHA_INI$ in LDC_TEMPLOCFACO.FECHA_INI%type,
		inuLock in number default 0
	);

	PROCEDURE updFECHA_FIN
	(
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type,
		idtFECHA_FIN$ in LDC_TEMPLOCFACO.FECHA_FIN%type,
		inuLock in number default 0
	);

	PROCEDURE updESTADO_APRO
	(
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type,
		isbESTADO_APRO$ in LDC_TEMPLOCFACO.ESTADO_APRO%type,
		inuLock in number default 0
	);

	PROCEDURE updFECHA_APRO
	(
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type,
		idtFECHA_APRO$ in LDC_TEMPLOCFACO.FECHA_APRO%type,
		inuLock in number default 0
	);

	PROCEDURE updUSUARIO
	(
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type,
		isbUSUARIO$ in LDC_TEMPLOCFACO.USUARIO%type,
		inuLock in number default 0
	);

	PROCEDURE updTERMINAL
	(
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type,
		isbTERMINAL$ in LDC_TEMPLOCFACO.TERMINAL%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetCONSECUTIVO
	(
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TEMPLOCFACO.CONSECUTIVO%type;

	FUNCTION fnuGetTEMP_ANO
	(
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TEMPLOCFACO.TEMP_ANO%type;

	FUNCTION fnuGetTEMP_MES
	(
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TEMPLOCFACO.TEMP_MES%type;

	FUNCTION fnuGetCAPITAL
	(
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TEMPLOCFACO.CAPITAL%type;

	FUNCTION fsbGetVARIABLE_TEMPERATURA
	(
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TEMPLOCFACO.VARIABLE_TEMPERATURA%type;

	FUNCTION fnuGetVALOR
	(
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TEMPLOCFACO.VALOR%type;

	FUNCTION fnuGetVALOR_PROM
	(
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TEMPLOCFACO.VALOR_PROM%type;

	FUNCTION fdtGetFECHA_REG
	(
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TEMPLOCFACO.FECHA_REG%type;

	FUNCTION fdtGetFECHA_INI
	(
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TEMPLOCFACO.FECHA_INI%type;

	FUNCTION fdtGetFECHA_FIN
	(
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TEMPLOCFACO.FECHA_FIN%type;

	FUNCTION fsbGetESTADO_APRO
	(
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TEMPLOCFACO.ESTADO_APRO%type;

	FUNCTION fdtGetFECHA_APRO
	(
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TEMPLOCFACO.FECHA_APRO%type;

	FUNCTION fsbGetUSUARIO
	(
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TEMPLOCFACO.USUARIO%type;

	FUNCTION fsbGetTERMINAL
	(
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TEMPLOCFACO.TERMINAL%type;


	PROCEDURE LockByPk
	(
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type,
		orcLDC_TEMPLOCFACO  out styLDC_TEMPLOCFACO
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_TEMPLOCFACO  out styLDC_TEMPLOCFACO
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_TEMPLOCFACO;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALDC_TEMPLOCFACO
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_TEMPLOCFACO';
	 cnuGeEntityId constant varchar2(30) := 4721; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type
	)
	IS
		SELECT LDC_TEMPLOCFACO.*,LDC_TEMPLOCFACO.rowid
		FROM LDC_TEMPLOCFACO
		WHERE  CONSECUTIVO = inuCONSECUTIVO
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_TEMPLOCFACO.*,LDC_TEMPLOCFACO.rowid
		FROM LDC_TEMPLOCFACO
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_TEMPLOCFACO is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_TEMPLOCFACO;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_TEMPLOCFACO default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.CONSECUTIVO);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type,
		orcLDC_TEMPLOCFACO  out styLDC_TEMPLOCFACO
	)
	IS
		rcError styLDC_TEMPLOCFACO;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;

		Open cuLockRcByPk
		(
			inuCONSECUTIVO
		);

		fetch cuLockRcByPk into orcLDC_TEMPLOCFACO;
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
		orcLDC_TEMPLOCFACO  out styLDC_TEMPLOCFACO
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_TEMPLOCFACO;
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
		itbLDC_TEMPLOCFACO  in out nocopy tytbLDC_TEMPLOCFACO
	)
	IS
	BEGIN
			rcRecOfTab.CONSECUTIVO.delete;
			rcRecOfTab.TEMP_ANO.delete;
			rcRecOfTab.TEMP_MES.delete;
			rcRecOfTab.CAPITAL.delete;
			rcRecOfTab.VARIABLE_TEMPERATURA.delete;
			rcRecOfTab.VALOR.delete;
			rcRecOfTab.VALOR_PROM.delete;
			rcRecOfTab.FECHA_REG.delete;
			rcRecOfTab.FECHA_INI.delete;
			rcRecOfTab.FECHA_FIN.delete;
			rcRecOfTab.ESTADO_APRO.delete;
			rcRecOfTab.FECHA_APRO.delete;
			rcRecOfTab.USUARIO.delete;
			rcRecOfTab.TERMINAL.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_TEMPLOCFACO  in out nocopy tytbLDC_TEMPLOCFACO,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_TEMPLOCFACO);

		for n in itbLDC_TEMPLOCFACO.first .. itbLDC_TEMPLOCFACO.last loop
			rcRecOfTab.CONSECUTIVO(n) := itbLDC_TEMPLOCFACO(n).CONSECUTIVO;
			rcRecOfTab.TEMP_ANO(n) := itbLDC_TEMPLOCFACO(n).TEMP_ANO;
			rcRecOfTab.TEMP_MES(n) := itbLDC_TEMPLOCFACO(n).TEMP_MES;
			rcRecOfTab.CAPITAL(n) := itbLDC_TEMPLOCFACO(n).CAPITAL;
			rcRecOfTab.VARIABLE_TEMPERATURA(n) := itbLDC_TEMPLOCFACO(n).VARIABLE_TEMPERATURA;
			rcRecOfTab.VALOR(n) := itbLDC_TEMPLOCFACO(n).VALOR;
			rcRecOfTab.VALOR_PROM(n) := itbLDC_TEMPLOCFACO(n).VALOR_PROM;
			rcRecOfTab.FECHA_REG(n) := itbLDC_TEMPLOCFACO(n).FECHA_REG;
			rcRecOfTab.FECHA_INI(n) := itbLDC_TEMPLOCFACO(n).FECHA_INI;
			rcRecOfTab.FECHA_FIN(n) := itbLDC_TEMPLOCFACO(n).FECHA_FIN;
			rcRecOfTab.ESTADO_APRO(n) := itbLDC_TEMPLOCFACO(n).ESTADO_APRO;
			rcRecOfTab.FECHA_APRO(n) := itbLDC_TEMPLOCFACO(n).FECHA_APRO;
			rcRecOfTab.USUARIO(n) := itbLDC_TEMPLOCFACO(n).USUARIO;
			rcRecOfTab.TERMINAL(n) := itbLDC_TEMPLOCFACO(n).TERMINAL;
			rcRecOfTab.row_id(n) := itbLDC_TEMPLOCFACO(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuCONSECUTIVO
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
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuCONSECUTIVO = rcData.CONSECUTIVO
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
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuCONSECUTIVO
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type
	)
	IS
		rcError styLDC_TEMPLOCFACO;
	BEGIN		rcError.CONSECUTIVO:=inuCONSECUTIVO;

		Load
		(
			inuCONSECUTIVO
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
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type
	)
	IS
	BEGIN
		Load
		(
			inuCONSECUTIVO
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type,
		orcRecord out nocopy styLDC_TEMPLOCFACO
	)
	IS
		rcError styLDC_TEMPLOCFACO;
	BEGIN		rcError.CONSECUTIVO:=inuCONSECUTIVO;

		Load
		(
			inuCONSECUTIVO
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type
	)
	RETURN styLDC_TEMPLOCFACO
	IS
		rcError styLDC_TEMPLOCFACO;
	BEGIN
		rcError.CONSECUTIVO:=inuCONSECUTIVO;

		Load
		(
			inuCONSECUTIVO
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type
	)
	RETURN styLDC_TEMPLOCFACO
	IS
		rcError styLDC_TEMPLOCFACO;
	BEGIN
		rcError.CONSECUTIVO:=inuCONSECUTIVO;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuCONSECUTIVO
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuCONSECUTIVO
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_TEMPLOCFACO
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_TEMPLOCFACO
	)
	IS
		rfLDC_TEMPLOCFACO tyrfLDC_TEMPLOCFACO;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_TEMPLOCFACO.*, LDC_TEMPLOCFACO.rowid FROM LDC_TEMPLOCFACO';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_TEMPLOCFACO for sbFullQuery;

		fetch rfLDC_TEMPLOCFACO bulk collect INTO otbResult;

		close rfLDC_TEMPLOCFACO;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_TEMPLOCFACO.*, LDC_TEMPLOCFACO.rowid FROM LDC_TEMPLOCFACO';
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
		ircLDC_TEMPLOCFACO in styLDC_TEMPLOCFACO
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_TEMPLOCFACO,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_TEMPLOCFACO in styLDC_TEMPLOCFACO,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_TEMPLOCFACO.CONSECUTIVO is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|CONSECUTIVO');
			raise ex.controlled_error;
		end if;

		insert into LDC_TEMPLOCFACO
		(
			CONSECUTIVO,
			TEMP_ANO,
			TEMP_MES,
			CAPITAL,
			VARIABLE_TEMPERATURA,
			VALOR,
			VALOR_PROM,
			FECHA_REG,
			FECHA_INI,
			FECHA_FIN,
			ESTADO_APRO,
			FECHA_APRO,
			USUARIO,
			TERMINAL
		)
		values
		(
			ircLDC_TEMPLOCFACO.CONSECUTIVO,
			ircLDC_TEMPLOCFACO.TEMP_ANO,
			ircLDC_TEMPLOCFACO.TEMP_MES,
			ircLDC_TEMPLOCFACO.CAPITAL,
			ircLDC_TEMPLOCFACO.VARIABLE_TEMPERATURA,
			ircLDC_TEMPLOCFACO.VALOR,
			ircLDC_TEMPLOCFACO.VALOR_PROM,
			ircLDC_TEMPLOCFACO.FECHA_REG,
			ircLDC_TEMPLOCFACO.FECHA_INI,
			ircLDC_TEMPLOCFACO.FECHA_FIN,
			ircLDC_TEMPLOCFACO.ESTADO_APRO,
			ircLDC_TEMPLOCFACO.FECHA_APRO,
			ircLDC_TEMPLOCFACO.USUARIO,
			ircLDC_TEMPLOCFACO.TERMINAL
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_TEMPLOCFACO));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_TEMPLOCFACO in out nocopy tytbLDC_TEMPLOCFACO
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_TEMPLOCFACO,blUseRowID);
		forall n in iotbLDC_TEMPLOCFACO.first..iotbLDC_TEMPLOCFACO.last
			insert into LDC_TEMPLOCFACO
			(
				CONSECUTIVO,
				TEMP_ANO,
				TEMP_MES,
				CAPITAL,
				VARIABLE_TEMPERATURA,
				VALOR,
				VALOR_PROM,
				FECHA_REG,
				FECHA_INI,
				FECHA_FIN,
				ESTADO_APRO,
				FECHA_APRO,
				USUARIO,
				TERMINAL
			)
			values
			(
				rcRecOfTab.CONSECUTIVO(n),
				rcRecOfTab.TEMP_ANO(n),
				rcRecOfTab.TEMP_MES(n),
				rcRecOfTab.CAPITAL(n),
				rcRecOfTab.VARIABLE_TEMPERATURA(n),
				rcRecOfTab.VALOR(n),
				rcRecOfTab.VALOR_PROM(n),
				rcRecOfTab.FECHA_REG(n),
				rcRecOfTab.FECHA_INI(n),
				rcRecOfTab.FECHA_FIN(n),
				rcRecOfTab.ESTADO_APRO(n),
				rcRecOfTab.FECHA_APRO(n),
				rcRecOfTab.USUARIO(n),
				rcRecOfTab.TERMINAL(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_TEMPLOCFACO;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;

		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;


		delete
		from LDC_TEMPLOCFACO
		where
       		CONSECUTIVO=inuCONSECUTIVO;
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
		rcError  styLDC_TEMPLOCFACO;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_TEMPLOCFACO
		where
			rowid = iriRowID
		returning
			CONSECUTIVO
		into
			rcError.CONSECUTIVO;
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
		iotbLDC_TEMPLOCFACO in out nocopy tytbLDC_TEMPLOCFACO,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_TEMPLOCFACO;
	BEGIN
		FillRecordOfTables(iotbLDC_TEMPLOCFACO, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_TEMPLOCFACO.first .. iotbLDC_TEMPLOCFACO.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_TEMPLOCFACO.first .. iotbLDC_TEMPLOCFACO.last
				delete
				from LDC_TEMPLOCFACO
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_TEMPLOCFACO.first .. iotbLDC_TEMPLOCFACO.last loop
					LockByPk
					(
						rcRecOfTab.CONSECUTIVO(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_TEMPLOCFACO.first .. iotbLDC_TEMPLOCFACO.last
				delete
				from LDC_TEMPLOCFACO
				where
		         	CONSECUTIVO = rcRecOfTab.CONSECUTIVO(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_TEMPLOCFACO in styLDC_TEMPLOCFACO,
		inuLock in number default 0
	)
	IS
		nuCONSECUTIVO	LDC_TEMPLOCFACO.CONSECUTIVO%type;
	BEGIN
		if ircLDC_TEMPLOCFACO.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_TEMPLOCFACO.rowid,rcData);
			end if;
			update LDC_TEMPLOCFACO
			set
				TEMP_ANO = ircLDC_TEMPLOCFACO.TEMP_ANO,
				TEMP_MES = ircLDC_TEMPLOCFACO.TEMP_MES,
				CAPITAL = ircLDC_TEMPLOCFACO.CAPITAL,
				VARIABLE_TEMPERATURA = ircLDC_TEMPLOCFACO.VARIABLE_TEMPERATURA,
				VALOR = ircLDC_TEMPLOCFACO.VALOR,
				VALOR_PROM = ircLDC_TEMPLOCFACO.VALOR_PROM,
				FECHA_REG = ircLDC_TEMPLOCFACO.FECHA_REG,
				FECHA_INI = ircLDC_TEMPLOCFACO.FECHA_INI,
				FECHA_FIN = ircLDC_TEMPLOCFACO.FECHA_FIN,
				ESTADO_APRO = ircLDC_TEMPLOCFACO.ESTADO_APRO,
				FECHA_APRO = ircLDC_TEMPLOCFACO.FECHA_APRO,
				USUARIO = ircLDC_TEMPLOCFACO.USUARIO,
				TERMINAL = ircLDC_TEMPLOCFACO.TERMINAL
			where
				rowid = ircLDC_TEMPLOCFACO.rowid
			returning
				CONSECUTIVO
			into
				nuCONSECUTIVO;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_TEMPLOCFACO.CONSECUTIVO,
					rcData
				);
			end if;

			update LDC_TEMPLOCFACO
			set
				TEMP_ANO = ircLDC_TEMPLOCFACO.TEMP_ANO,
				TEMP_MES = ircLDC_TEMPLOCFACO.TEMP_MES,
				CAPITAL = ircLDC_TEMPLOCFACO.CAPITAL,
				VARIABLE_TEMPERATURA = ircLDC_TEMPLOCFACO.VARIABLE_TEMPERATURA,
				VALOR = ircLDC_TEMPLOCFACO.VALOR,
				VALOR_PROM = ircLDC_TEMPLOCFACO.VALOR_PROM,
				FECHA_REG = ircLDC_TEMPLOCFACO.FECHA_REG,
				FECHA_INI = ircLDC_TEMPLOCFACO.FECHA_INI,
				FECHA_FIN = ircLDC_TEMPLOCFACO.FECHA_FIN,
				ESTADO_APRO = ircLDC_TEMPLOCFACO.ESTADO_APRO,
				FECHA_APRO = ircLDC_TEMPLOCFACO.FECHA_APRO,
				USUARIO = ircLDC_TEMPLOCFACO.USUARIO,
				TERMINAL = ircLDC_TEMPLOCFACO.TERMINAL
			where
				CONSECUTIVO = ircLDC_TEMPLOCFACO.CONSECUTIVO
			returning
				CONSECUTIVO
			into
				nuCONSECUTIVO;
		end if;
		if
			nuCONSECUTIVO is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_TEMPLOCFACO));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_TEMPLOCFACO in out nocopy tytbLDC_TEMPLOCFACO,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_TEMPLOCFACO;
	BEGIN
		FillRecordOfTables(iotbLDC_TEMPLOCFACO,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_TEMPLOCFACO.first .. iotbLDC_TEMPLOCFACO.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_TEMPLOCFACO.first .. iotbLDC_TEMPLOCFACO.last
				update LDC_TEMPLOCFACO
				set
					TEMP_ANO = rcRecOfTab.TEMP_ANO(n),
					TEMP_MES = rcRecOfTab.TEMP_MES(n),
					CAPITAL = rcRecOfTab.CAPITAL(n),
					VARIABLE_TEMPERATURA = rcRecOfTab.VARIABLE_TEMPERATURA(n),
					VALOR = rcRecOfTab.VALOR(n),
					VALOR_PROM = rcRecOfTab.VALOR_PROM(n),
					FECHA_REG = rcRecOfTab.FECHA_REG(n),
					FECHA_INI = rcRecOfTab.FECHA_INI(n),
					FECHA_FIN = rcRecOfTab.FECHA_FIN(n),
					ESTADO_APRO = rcRecOfTab.ESTADO_APRO(n),
					FECHA_APRO = rcRecOfTab.FECHA_APRO(n),
					USUARIO = rcRecOfTab.USUARIO(n),
					TERMINAL = rcRecOfTab.TERMINAL(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_TEMPLOCFACO.first .. iotbLDC_TEMPLOCFACO.last loop
					LockByPk
					(
						rcRecOfTab.CONSECUTIVO(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_TEMPLOCFACO.first .. iotbLDC_TEMPLOCFACO.last
				update LDC_TEMPLOCFACO
				SET
					TEMP_ANO = rcRecOfTab.TEMP_ANO(n),
					TEMP_MES = rcRecOfTab.TEMP_MES(n),
					CAPITAL = rcRecOfTab.CAPITAL(n),
					VARIABLE_TEMPERATURA = rcRecOfTab.VARIABLE_TEMPERATURA(n),
					VALOR = rcRecOfTab.VALOR(n),
					VALOR_PROM = rcRecOfTab.VALOR_PROM(n),
					FECHA_REG = rcRecOfTab.FECHA_REG(n),
					FECHA_INI = rcRecOfTab.FECHA_INI(n),
					FECHA_FIN = rcRecOfTab.FECHA_FIN(n),
					ESTADO_APRO = rcRecOfTab.ESTADO_APRO(n),
					FECHA_APRO = rcRecOfTab.FECHA_APRO(n),
					USUARIO = rcRecOfTab.USUARIO(n),
					TERMINAL = rcRecOfTab.TERMINAL(n)
				where
					CONSECUTIVO = rcRecOfTab.CONSECUTIVO(n)
;
		end if;
	END;
	PROCEDURE updTEMP_ANO
	(
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type,
		inuTEMP_ANO$ in LDC_TEMPLOCFACO.TEMP_ANO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_TEMPLOCFACO;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_TEMPLOCFACO
		set
			TEMP_ANO = inuTEMP_ANO$
		where
			CONSECUTIVO = inuCONSECUTIVO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TEMP_ANO:= inuTEMP_ANO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updTEMP_MES
	(
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type,
		inuTEMP_MES$ in LDC_TEMPLOCFACO.TEMP_MES%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_TEMPLOCFACO;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_TEMPLOCFACO
		set
			TEMP_MES = inuTEMP_MES$
		where
			CONSECUTIVO = inuCONSECUTIVO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TEMP_MES:= inuTEMP_MES$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCAPITAL
	(
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type,
		inuCAPITAL$ in LDC_TEMPLOCFACO.CAPITAL%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_TEMPLOCFACO;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_TEMPLOCFACO
		set
			CAPITAL = inuCAPITAL$
		where
			CONSECUTIVO = inuCONSECUTIVO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CAPITAL:= inuCAPITAL$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updVARIABLE_TEMPERATURA
	(
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type,
		isbVARIABLE_TEMPERATURA$ in LDC_TEMPLOCFACO.VARIABLE_TEMPERATURA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_TEMPLOCFACO;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_TEMPLOCFACO
		set
			VARIABLE_TEMPERATURA = isbVARIABLE_TEMPERATURA$
		where
			CONSECUTIVO = inuCONSECUTIVO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.VARIABLE_TEMPERATURA:= isbVARIABLE_TEMPERATURA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updVALOR
	(
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type,
		inuVALOR$ in LDC_TEMPLOCFACO.VALOR%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_TEMPLOCFACO;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_TEMPLOCFACO
		set
			VALOR = inuVALOR$
		where
			CONSECUTIVO = inuCONSECUTIVO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.VALOR:= inuVALOR$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updVALOR_PROM
	(
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type,
		inuVALOR_PROM$ in LDC_TEMPLOCFACO.VALOR_PROM%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_TEMPLOCFACO;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_TEMPLOCFACO
		set
			VALOR_PROM = inuVALOR_PROM$
		where
			CONSECUTIVO = inuCONSECUTIVO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.VALOR_PROM:= inuVALOR_PROM$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFECHA_REG
	(
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type,
		idtFECHA_REG$ in LDC_TEMPLOCFACO.FECHA_REG%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_TEMPLOCFACO;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_TEMPLOCFACO
		set
			FECHA_REG = idtFECHA_REG$
		where
			CONSECUTIVO = inuCONSECUTIVO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FECHA_REG:= idtFECHA_REG$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFECHA_INI
	(
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type,
		idtFECHA_INI$ in LDC_TEMPLOCFACO.FECHA_INI%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_TEMPLOCFACO;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_TEMPLOCFACO
		set
			FECHA_INI = idtFECHA_INI$
		where
			CONSECUTIVO = inuCONSECUTIVO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FECHA_INI:= idtFECHA_INI$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFECHA_FIN
	(
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type,
		idtFECHA_FIN$ in LDC_TEMPLOCFACO.FECHA_FIN%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_TEMPLOCFACO;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_TEMPLOCFACO
		set
			FECHA_FIN = idtFECHA_FIN$
		where
			CONSECUTIVO = inuCONSECUTIVO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FECHA_FIN:= idtFECHA_FIN$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updESTADO_APRO
	(
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type,
		isbESTADO_APRO$ in LDC_TEMPLOCFACO.ESTADO_APRO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_TEMPLOCFACO;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_TEMPLOCFACO
		set
			ESTADO_APRO = isbESTADO_APRO$
		where
			CONSECUTIVO = inuCONSECUTIVO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ESTADO_APRO:= isbESTADO_APRO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFECHA_APRO
	(
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type,
		idtFECHA_APRO$ in LDC_TEMPLOCFACO.FECHA_APRO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_TEMPLOCFACO;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_TEMPLOCFACO
		set
			FECHA_APRO = idtFECHA_APRO$
		where
			CONSECUTIVO = inuCONSECUTIVO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FECHA_APRO:= idtFECHA_APRO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updUSUARIO
	(
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type,
		isbUSUARIO$ in LDC_TEMPLOCFACO.USUARIO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_TEMPLOCFACO;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_TEMPLOCFACO
		set
			USUARIO = isbUSUARIO$
		where
			CONSECUTIVO = inuCONSECUTIVO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.USUARIO:= isbUSUARIO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updTERMINAL
	(
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type,
		isbTERMINAL$ in LDC_TEMPLOCFACO.TERMINAL%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_TEMPLOCFACO;
	BEGIN
		rcError.CONSECUTIVO := inuCONSECUTIVO;
		if inuLock=1 then
			LockByPk
			(
				inuCONSECUTIVO,
				rcData
			);
		end if;

		update LDC_TEMPLOCFACO
		set
			TERMINAL = isbTERMINAL$
		where
			CONSECUTIVO = inuCONSECUTIVO;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TERMINAL:= isbTERMINAL$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetCONSECUTIVO
	(
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TEMPLOCFACO.CONSECUTIVO%type
	IS
		rcError styLDC_TEMPLOCFACO;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.CONSECUTIVO);
		end if;
		Load
		(
		 		inuCONSECUTIVO
		);
		return(rcData.CONSECUTIVO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetTEMP_ANO
	(
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TEMPLOCFACO.TEMP_ANO%type
	IS
		rcError styLDC_TEMPLOCFACO;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.TEMP_ANO);
		end if;
		Load
		(
		 		inuCONSECUTIVO
		);
		return(rcData.TEMP_ANO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetTEMP_MES
	(
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TEMPLOCFACO.TEMP_MES%type
	IS
		rcError styLDC_TEMPLOCFACO;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.TEMP_MES);
		end if;
		Load
		(
		 		inuCONSECUTIVO
		);
		return(rcData.TEMP_MES);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCAPITAL
	(
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TEMPLOCFACO.CAPITAL%type
	IS
		rcError styLDC_TEMPLOCFACO;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.CAPITAL);
		end if;
		Load
		(
		 		inuCONSECUTIVO
		);
		return(rcData.CAPITAL);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetVARIABLE_TEMPERATURA
	(
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TEMPLOCFACO.VARIABLE_TEMPERATURA%type
	IS
		rcError styLDC_TEMPLOCFACO;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.VARIABLE_TEMPERATURA);
		end if;
		Load
		(
		 		inuCONSECUTIVO
		);
		return(rcData.VARIABLE_TEMPERATURA);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetVALOR
	(
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TEMPLOCFACO.VALOR%type
	IS
		rcError styLDC_TEMPLOCFACO;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.VALOR);
		end if;
		Load
		(
		 		inuCONSECUTIVO
		);
		return(rcData.VALOR);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetVALOR_PROM
	(
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TEMPLOCFACO.VALOR_PROM%type
	IS
		rcError styLDC_TEMPLOCFACO;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.VALOR_PROM);
		end if;
		Load
		(
		 		inuCONSECUTIVO
		);
		return(rcData.VALOR_PROM);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetFECHA_REG
	(
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TEMPLOCFACO.FECHA_REG%type
	IS
		rcError styLDC_TEMPLOCFACO;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.FECHA_REG);
		end if;
		Load
		(
		 		inuCONSECUTIVO
		);
		return(rcData.FECHA_REG);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetFECHA_INI
	(
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TEMPLOCFACO.FECHA_INI%type
	IS
		rcError styLDC_TEMPLOCFACO;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.FECHA_INI);
		end if;
		Load
		(
		 		inuCONSECUTIVO
		);
		return(rcData.FECHA_INI);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetFECHA_FIN
	(
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TEMPLOCFACO.FECHA_FIN%type
	IS
		rcError styLDC_TEMPLOCFACO;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.FECHA_FIN);
		end if;
		Load
		(
		 		inuCONSECUTIVO
		);
		return(rcData.FECHA_FIN);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetESTADO_APRO
	(
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TEMPLOCFACO.ESTADO_APRO%type
	IS
		rcError styLDC_TEMPLOCFACO;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.ESTADO_APRO);
		end if;
		Load
		(
		 		inuCONSECUTIVO
		);
		return(rcData.ESTADO_APRO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetFECHA_APRO
	(
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TEMPLOCFACO.FECHA_APRO%type
	IS
		rcError styLDC_TEMPLOCFACO;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.FECHA_APRO);
		end if;
		Load
		(
		 		inuCONSECUTIVO
		);
		return(rcData.FECHA_APRO);
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
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TEMPLOCFACO.USUARIO%type
	IS
		rcError styLDC_TEMPLOCFACO;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.USUARIO);
		end if;
		Load
		(
		 		inuCONSECUTIVO
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
	FUNCTION fsbGetTERMINAL
	(
		inuCONSECUTIVO in LDC_TEMPLOCFACO.CONSECUTIVO%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TEMPLOCFACO.TERMINAL%type
	IS
		rcError styLDC_TEMPLOCFACO;
	BEGIN

		rcError.CONSECUTIVO := inuCONSECUTIVO;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCONSECUTIVO
			 )
		then
			 return(rcData.TERMINAL);
		end if;
		Load
		(
		 		inuCONSECUTIVO
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
end DALDC_TEMPLOCFACO;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALDC_TEMPLOCFACO
BEGIN
    pkg_utilidades.prAplicarPermisos('DALDC_TEMPLOCFACO', 'ADM_PERSON'); 
END;
/  
