CREATE OR REPLACE PACKAGE ADM_PERSON.DALDC_TIPOTRAB_COTI_COM
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
    05/06/2024              PAcosta         OSF-2777: Cambio de esquema ADM_PERSON                              
    ****************************************************************/    
    
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuID_COT_COMERCIAL in LDC_TIPOTRAB_COTI_COM.ID_COT_COMERCIAL%type,
		isbABREVIATURA in LDC_TIPOTRAB_COTI_COM.ABREVIATURA%type
	)
	IS
		SELECT LDC_TIPOTRAB_COTI_COM.*,LDC_TIPOTRAB_COTI_COM.rowid
		FROM LDC_TIPOTRAB_COTI_COM
		WHERE
		    ID_COT_COMERCIAL = inuID_COT_COMERCIAL
		    and ABREVIATURA = isbABREVIATURA;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_TIPOTRAB_COTI_COM.*,LDC_TIPOTRAB_COTI_COM.rowid
		FROM LDC_TIPOTRAB_COTI_COM
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_TIPOTRAB_COTI_COM  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_TIPOTRAB_COTI_COM is table of styLDC_TIPOTRAB_COTI_COM index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_TIPOTRAB_COTI_COM;

	/* Tipos referenciando al registro */
	type tytbTIPO_TRABAJO is table of LDC_TIPOTRAB_COTI_COM.TIPO_TRABAJO%type index by binary_integer;
	type tytbABREVIATURA is table of LDC_TIPOTRAB_COTI_COM.ABREVIATURA%type index by binary_integer;
	type tytbID_COT_COMERCIAL is table of LDC_TIPOTRAB_COTI_COM.ID_COT_COMERCIAL%type index by binary_integer;
	type tytbACTIVIDAD is table of LDC_TIPOTRAB_COTI_COM.ACTIVIDAD%type index by binary_integer;
	type tytbIVA is table of LDC_TIPOTRAB_COTI_COM.IVA%type index by binary_integer;
	type tytbAPLICA_DESC is table of LDC_TIPOTRAB_COTI_COM.APLICA_DESC%type index by binary_integer;
	type tytbFECHA_REGISTRO is table of LDC_TIPOTRAB_COTI_COM.FECHA_REGISTRO%type index by binary_integer;
	type tytbUSUARIO_REGISTRA is table of LDC_TIPOTRAB_COTI_COM.USUARIO_REGISTRA%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_TIPOTRAB_COTI_COM is record
	(
		TIPO_TRABAJO   tytbTIPO_TRABAJO,
		ABREVIATURA   tytbABREVIATURA,
		ID_COT_COMERCIAL   tytbID_COT_COMERCIAL,
		ACTIVIDAD   tytbACTIVIDAD,
		IVA   tytbIVA,
		APLICA_DESC   tytbAPLICA_DESC,
		FECHA_REGISTRO   tytbFECHA_REGISTRO,
		USUARIO_REGISTRA   tytbUSUARIO_REGISTRA,
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
		inuID_COT_COMERCIAL in LDC_TIPOTRAB_COTI_COM.ID_COT_COMERCIAL%type,
		isbABREVIATURA in LDC_TIPOTRAB_COTI_COM.ABREVIATURA%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuID_COT_COMERCIAL in LDC_TIPOTRAB_COTI_COM.ID_COT_COMERCIAL%type,
		isbABREVIATURA in LDC_TIPOTRAB_COTI_COM.ABREVIATURA%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuID_COT_COMERCIAL in LDC_TIPOTRAB_COTI_COM.ID_COT_COMERCIAL%type,
		isbABREVIATURA in LDC_TIPOTRAB_COTI_COM.ABREVIATURA%type
	);

	PROCEDURE getRecord
	(
		inuID_COT_COMERCIAL in LDC_TIPOTRAB_COTI_COM.ID_COT_COMERCIAL%type,
		isbABREVIATURA in LDC_TIPOTRAB_COTI_COM.ABREVIATURA%type,
		orcRecord out nocopy styLDC_TIPOTRAB_COTI_COM
	);

	FUNCTION frcGetRcData
	(
		inuID_COT_COMERCIAL in LDC_TIPOTRAB_COTI_COM.ID_COT_COMERCIAL%type,
		isbABREVIATURA in LDC_TIPOTRAB_COTI_COM.ABREVIATURA%type
	)
	RETURN styLDC_TIPOTRAB_COTI_COM;

	FUNCTION frcGetRcData
	RETURN styLDC_TIPOTRAB_COTI_COM;

	FUNCTION frcGetRecord
	(
		inuID_COT_COMERCIAL in LDC_TIPOTRAB_COTI_COM.ID_COT_COMERCIAL%type,
		isbABREVIATURA in LDC_TIPOTRAB_COTI_COM.ABREVIATURA%type
	)
	RETURN styLDC_TIPOTRAB_COTI_COM;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_TIPOTRAB_COTI_COM
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_TIPOTRAB_COTI_COM in styLDC_TIPOTRAB_COTI_COM
	);

	PROCEDURE insRecord
	(
		ircLDC_TIPOTRAB_COTI_COM in styLDC_TIPOTRAB_COTI_COM,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_TIPOTRAB_COTI_COM in out nocopy tytbLDC_TIPOTRAB_COTI_COM
	);

	PROCEDURE delRecord
	(
		inuID_COT_COMERCIAL in LDC_TIPOTRAB_COTI_COM.ID_COT_COMERCIAL%type,
		isbABREVIATURA in LDC_TIPOTRAB_COTI_COM.ABREVIATURA%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_TIPOTRAB_COTI_COM in out nocopy tytbLDC_TIPOTRAB_COTI_COM,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_TIPOTRAB_COTI_COM in styLDC_TIPOTRAB_COTI_COM,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_TIPOTRAB_COTI_COM in out nocopy tytbLDC_TIPOTRAB_COTI_COM,
		inuLock in number default 1
	);

	PROCEDURE updTIPO_TRABAJO
	(
		inuID_COT_COMERCIAL in LDC_TIPOTRAB_COTI_COM.ID_COT_COMERCIAL%type,
		isbABREVIATURA in LDC_TIPOTRAB_COTI_COM.ABREVIATURA%type,
		inuTIPO_TRABAJO$ in LDC_TIPOTRAB_COTI_COM.TIPO_TRABAJO%type,
		inuLock in number default 0
	);

	PROCEDURE updACTIVIDAD
	(
		inuID_COT_COMERCIAL in LDC_TIPOTRAB_COTI_COM.ID_COT_COMERCIAL%type,
		isbABREVIATURA in LDC_TIPOTRAB_COTI_COM.ABREVIATURA%type,
		inuACTIVIDAD$ in LDC_TIPOTRAB_COTI_COM.ACTIVIDAD%type,
		inuLock in number default 0
	);

	PROCEDURE updIVA
	(
		inuID_COT_COMERCIAL in LDC_TIPOTRAB_COTI_COM.ID_COT_COMERCIAL%type,
		isbABREVIATURA in LDC_TIPOTRAB_COTI_COM.ABREVIATURA%type,
		inuIVA$ in LDC_TIPOTRAB_COTI_COM.IVA%type,
		inuLock in number default 0
	);

	PROCEDURE updAPLICA_DESC
	(
		inuID_COT_COMERCIAL in LDC_TIPOTRAB_COTI_COM.ID_COT_COMERCIAL%type,
		isbABREVIATURA in LDC_TIPOTRAB_COTI_COM.ABREVIATURA%type,
		isbAPLICA_DESC$ in LDC_TIPOTRAB_COTI_COM.APLICA_DESC%type,
		inuLock in number default 0
	);

	PROCEDURE updFECHA_REGISTRO
	(
		inuID_COT_COMERCIAL in LDC_TIPOTRAB_COTI_COM.ID_COT_COMERCIAL%type,
		isbABREVIATURA in LDC_TIPOTRAB_COTI_COM.ABREVIATURA%type,
		idtFECHA_REGISTRO$ in LDC_TIPOTRAB_COTI_COM.FECHA_REGISTRO%type,
		inuLock in number default 0
	);

	PROCEDURE updUSUARIO_REGISTRA
	(
		inuID_COT_COMERCIAL in LDC_TIPOTRAB_COTI_COM.ID_COT_COMERCIAL%type,
		isbABREVIATURA in LDC_TIPOTRAB_COTI_COM.ABREVIATURA%type,
		isbUSUARIO_REGISTRA$ in LDC_TIPOTRAB_COTI_COM.USUARIO_REGISTRA%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetTIPO_TRABAJO
	(
		inuID_COT_COMERCIAL in LDC_TIPOTRAB_COTI_COM.ID_COT_COMERCIAL%type,
		isbABREVIATURA in LDC_TIPOTRAB_COTI_COM.ABREVIATURA%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPOTRAB_COTI_COM.TIPO_TRABAJO%type;

	FUNCTION fsbGetABREVIATURA
	(
		inuID_COT_COMERCIAL in LDC_TIPOTRAB_COTI_COM.ID_COT_COMERCIAL%type,
		isbABREVIATURA in LDC_TIPOTRAB_COTI_COM.ABREVIATURA%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPOTRAB_COTI_COM.ABREVIATURA%type;

	FUNCTION fnuGetID_COT_COMERCIAL
	(
		inuID_COT_COMERCIAL in LDC_TIPOTRAB_COTI_COM.ID_COT_COMERCIAL%type,
		isbABREVIATURA in LDC_TIPOTRAB_COTI_COM.ABREVIATURA%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPOTRAB_COTI_COM.ID_COT_COMERCIAL%type;

	FUNCTION fnuGetACTIVIDAD
	(
		inuID_COT_COMERCIAL in LDC_TIPOTRAB_COTI_COM.ID_COT_COMERCIAL%type,
		isbABREVIATURA in LDC_TIPOTRAB_COTI_COM.ABREVIATURA%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPOTRAB_COTI_COM.ACTIVIDAD%type;

	FUNCTION fnuGetIVA
	(
		inuID_COT_COMERCIAL in LDC_TIPOTRAB_COTI_COM.ID_COT_COMERCIAL%type,
		isbABREVIATURA in LDC_TIPOTRAB_COTI_COM.ABREVIATURA%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPOTRAB_COTI_COM.IVA%type;

	FUNCTION fsbGetAPLICA_DESC
	(
		inuID_COT_COMERCIAL in LDC_TIPOTRAB_COTI_COM.ID_COT_COMERCIAL%type,
		isbABREVIATURA in LDC_TIPOTRAB_COTI_COM.ABREVIATURA%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPOTRAB_COTI_COM.APLICA_DESC%type;

	FUNCTION fdtGetFECHA_REGISTRO
	(
		inuID_COT_COMERCIAL in LDC_TIPOTRAB_COTI_COM.ID_COT_COMERCIAL%type,
		isbABREVIATURA in LDC_TIPOTRAB_COTI_COM.ABREVIATURA%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPOTRAB_COTI_COM.FECHA_REGISTRO%type;

	FUNCTION fsbGetUSUARIO_REGISTRA
	(
		inuID_COT_COMERCIAL in LDC_TIPOTRAB_COTI_COM.ID_COT_COMERCIAL%type,
		isbABREVIATURA in LDC_TIPOTRAB_COTI_COM.ABREVIATURA%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPOTRAB_COTI_COM.USUARIO_REGISTRA%type;


	PROCEDURE LockByPk
	(
		inuID_COT_COMERCIAL in LDC_TIPOTRAB_COTI_COM.ID_COT_COMERCIAL%type,
		isbABREVIATURA in LDC_TIPOTRAB_COTI_COM.ABREVIATURA%type,
		orcLDC_TIPOTRAB_COTI_COM  out styLDC_TIPOTRAB_COTI_COM
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_TIPOTRAB_COTI_COM  out styLDC_TIPOTRAB_COTI_COM
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_TIPOTRAB_COTI_COM;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALDC_TIPOTRAB_COTI_COM
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_TIPOTRAB_COTI_COM';
	 cnuGeEntityId constant varchar2(30) := 3858; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuID_COT_COMERCIAL in LDC_TIPOTRAB_COTI_COM.ID_COT_COMERCIAL%type,
		isbABREVIATURA in LDC_TIPOTRAB_COTI_COM.ABREVIATURA%type
	)
	IS
		SELECT LDC_TIPOTRAB_COTI_COM.*,LDC_TIPOTRAB_COTI_COM.rowid
		FROM LDC_TIPOTRAB_COTI_COM
		WHERE  ID_COT_COMERCIAL = inuID_COT_COMERCIAL
			and ABREVIATURA = isbABREVIATURA
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_TIPOTRAB_COTI_COM.*,LDC_TIPOTRAB_COTI_COM.rowid
		FROM LDC_TIPOTRAB_COTI_COM
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_TIPOTRAB_COTI_COM is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_TIPOTRAB_COTI_COM;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_TIPOTRAB_COTI_COM default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.ID_COT_COMERCIAL);
		sbPk:=sbPk||','||ut_convert.fsbToChar(rcI.ABREVIATURA);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuID_COT_COMERCIAL in LDC_TIPOTRAB_COTI_COM.ID_COT_COMERCIAL%type,
		isbABREVIATURA in LDC_TIPOTRAB_COTI_COM.ABREVIATURA%type,
		orcLDC_TIPOTRAB_COTI_COM  out styLDC_TIPOTRAB_COTI_COM
	)
	IS
		rcError styLDC_TIPOTRAB_COTI_COM;
	BEGIN
		rcError.ID_COT_COMERCIAL := inuID_COT_COMERCIAL;
		rcError.ABREVIATURA := isbABREVIATURA;

		Open cuLockRcByPk
		(
			inuID_COT_COMERCIAL,
			isbABREVIATURA
		);

		fetch cuLockRcByPk into orcLDC_TIPOTRAB_COTI_COM;
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
		orcLDC_TIPOTRAB_COTI_COM  out styLDC_TIPOTRAB_COTI_COM
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_TIPOTRAB_COTI_COM;
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
		itbLDC_TIPOTRAB_COTI_COM  in out nocopy tytbLDC_TIPOTRAB_COTI_COM
	)
	IS
	BEGIN
			rcRecOfTab.TIPO_TRABAJO.delete;
			rcRecOfTab.ABREVIATURA.delete;
			rcRecOfTab.ID_COT_COMERCIAL.delete;
			rcRecOfTab.ACTIVIDAD.delete;
			rcRecOfTab.IVA.delete;
			rcRecOfTab.APLICA_DESC.delete;
			rcRecOfTab.FECHA_REGISTRO.delete;
			rcRecOfTab.USUARIO_REGISTRA.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_TIPOTRAB_COTI_COM  in out nocopy tytbLDC_TIPOTRAB_COTI_COM,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_TIPOTRAB_COTI_COM);

		for n in itbLDC_TIPOTRAB_COTI_COM.first .. itbLDC_TIPOTRAB_COTI_COM.last loop
			rcRecOfTab.TIPO_TRABAJO(n) := itbLDC_TIPOTRAB_COTI_COM(n).TIPO_TRABAJO;
			rcRecOfTab.ABREVIATURA(n) := itbLDC_TIPOTRAB_COTI_COM(n).ABREVIATURA;
			rcRecOfTab.ID_COT_COMERCIAL(n) := itbLDC_TIPOTRAB_COTI_COM(n).ID_COT_COMERCIAL;
			rcRecOfTab.ACTIVIDAD(n) := itbLDC_TIPOTRAB_COTI_COM(n).ACTIVIDAD;
			rcRecOfTab.IVA(n) := itbLDC_TIPOTRAB_COTI_COM(n).IVA;
			rcRecOfTab.APLICA_DESC(n) := itbLDC_TIPOTRAB_COTI_COM(n).APLICA_DESC;
			rcRecOfTab.FECHA_REGISTRO(n) := itbLDC_TIPOTRAB_COTI_COM(n).FECHA_REGISTRO;
			rcRecOfTab.USUARIO_REGISTRA(n) := itbLDC_TIPOTRAB_COTI_COM(n).USUARIO_REGISTRA;
			rcRecOfTab.row_id(n) := itbLDC_TIPOTRAB_COTI_COM(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuID_COT_COMERCIAL in LDC_TIPOTRAB_COTI_COM.ID_COT_COMERCIAL%type,
		isbABREVIATURA in LDC_TIPOTRAB_COTI_COM.ABREVIATURA%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuID_COT_COMERCIAL,
			isbABREVIATURA
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
		inuID_COT_COMERCIAL in LDC_TIPOTRAB_COTI_COM.ID_COT_COMERCIAL%type,
		isbABREVIATURA in LDC_TIPOTRAB_COTI_COM.ABREVIATURA%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuID_COT_COMERCIAL = rcData.ID_COT_COMERCIAL AND
			isbABREVIATURA = rcData.ABREVIATURA
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
		inuID_COT_COMERCIAL in LDC_TIPOTRAB_COTI_COM.ID_COT_COMERCIAL%type,
		isbABREVIATURA in LDC_TIPOTRAB_COTI_COM.ABREVIATURA%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuID_COT_COMERCIAL,
			isbABREVIATURA
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuID_COT_COMERCIAL in LDC_TIPOTRAB_COTI_COM.ID_COT_COMERCIAL%type,
		isbABREVIATURA in LDC_TIPOTRAB_COTI_COM.ABREVIATURA%type
	)
	IS
		rcError styLDC_TIPOTRAB_COTI_COM;
	BEGIN		rcError.ID_COT_COMERCIAL:=inuID_COT_COMERCIAL;		rcError.ABREVIATURA:=isbABREVIATURA;

		Load
		(
			inuID_COT_COMERCIAL,
			isbABREVIATURA
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
		inuID_COT_COMERCIAL in LDC_TIPOTRAB_COTI_COM.ID_COT_COMERCIAL%type,
		isbABREVIATURA in LDC_TIPOTRAB_COTI_COM.ABREVIATURA%type
	)
	IS
	BEGIN
		Load
		(
			inuID_COT_COMERCIAL,
			isbABREVIATURA
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuID_COT_COMERCIAL in LDC_TIPOTRAB_COTI_COM.ID_COT_COMERCIAL%type,
		isbABREVIATURA in LDC_TIPOTRAB_COTI_COM.ABREVIATURA%type,
		orcRecord out nocopy styLDC_TIPOTRAB_COTI_COM
	)
	IS
		rcError styLDC_TIPOTRAB_COTI_COM;
	BEGIN		rcError.ID_COT_COMERCIAL:=inuID_COT_COMERCIAL;		rcError.ABREVIATURA:=isbABREVIATURA;

		Load
		(
			inuID_COT_COMERCIAL,
			isbABREVIATURA
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuID_COT_COMERCIAL in LDC_TIPOTRAB_COTI_COM.ID_COT_COMERCIAL%type,
		isbABREVIATURA in LDC_TIPOTRAB_COTI_COM.ABREVIATURA%type
	)
	RETURN styLDC_TIPOTRAB_COTI_COM
	IS
		rcError styLDC_TIPOTRAB_COTI_COM;
	BEGIN
		rcError.ID_COT_COMERCIAL:=inuID_COT_COMERCIAL;
		rcError.ABREVIATURA:=isbABREVIATURA;

		Load
		(
			inuID_COT_COMERCIAL,
			isbABREVIATURA
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuID_COT_COMERCIAL in LDC_TIPOTRAB_COTI_COM.ID_COT_COMERCIAL%type,
		isbABREVIATURA in LDC_TIPOTRAB_COTI_COM.ABREVIATURA%type
	)
	RETURN styLDC_TIPOTRAB_COTI_COM
	IS
		rcError styLDC_TIPOTRAB_COTI_COM;
	BEGIN
		rcError.ID_COT_COMERCIAL:=inuID_COT_COMERCIAL;
		rcError.ABREVIATURA:=isbABREVIATURA;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuID_COT_COMERCIAL,
			isbABREVIATURA
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuID_COT_COMERCIAL,
			isbABREVIATURA
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_TIPOTRAB_COTI_COM
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_TIPOTRAB_COTI_COM
	)
	IS
		rfLDC_TIPOTRAB_COTI_COM tyrfLDC_TIPOTRAB_COTI_COM;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_TIPOTRAB_COTI_COM.*, LDC_TIPOTRAB_COTI_COM.rowid FROM LDC_TIPOTRAB_COTI_COM';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_TIPOTRAB_COTI_COM for sbFullQuery;

		fetch rfLDC_TIPOTRAB_COTI_COM bulk collect INTO otbResult;

		close rfLDC_TIPOTRAB_COTI_COM;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_TIPOTRAB_COTI_COM.*, LDC_TIPOTRAB_COTI_COM.rowid FROM LDC_TIPOTRAB_COTI_COM';
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
		ircLDC_TIPOTRAB_COTI_COM in styLDC_TIPOTRAB_COTI_COM
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_TIPOTRAB_COTI_COM,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_TIPOTRAB_COTI_COM in styLDC_TIPOTRAB_COTI_COM,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_TIPOTRAB_COTI_COM.ID_COT_COMERCIAL is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ID_COT_COMERCIAL');
			raise ex.controlled_error;
		end if;
		if ircLDC_TIPOTRAB_COTI_COM.ABREVIATURA is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ABREVIATURA');
			raise ex.controlled_error;
		end if;

		insert into LDC_TIPOTRAB_COTI_COM
		(
			TIPO_TRABAJO,
			ABREVIATURA,
			ID_COT_COMERCIAL,
			ACTIVIDAD,
			IVA,
			APLICA_DESC,
			FECHA_REGISTRO,
			USUARIO_REGISTRA
		)
		values
		(
			ircLDC_TIPOTRAB_COTI_COM.TIPO_TRABAJO,
			ircLDC_TIPOTRAB_COTI_COM.ABREVIATURA,
			ircLDC_TIPOTRAB_COTI_COM.ID_COT_COMERCIAL,
			ircLDC_TIPOTRAB_COTI_COM.ACTIVIDAD,
			ircLDC_TIPOTRAB_COTI_COM.IVA,
			ircLDC_TIPOTRAB_COTI_COM.APLICA_DESC,
			ircLDC_TIPOTRAB_COTI_COM.FECHA_REGISTRO,
			ircLDC_TIPOTRAB_COTI_COM.USUARIO_REGISTRA
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_TIPOTRAB_COTI_COM));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_TIPOTRAB_COTI_COM in out nocopy tytbLDC_TIPOTRAB_COTI_COM
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_TIPOTRAB_COTI_COM,blUseRowID);
		forall n in iotbLDC_TIPOTRAB_COTI_COM.first..iotbLDC_TIPOTRAB_COTI_COM.last
			insert into LDC_TIPOTRAB_COTI_COM
			(
				TIPO_TRABAJO,
				ABREVIATURA,
				ID_COT_COMERCIAL,
				ACTIVIDAD,
				IVA,
				APLICA_DESC,
				FECHA_REGISTRO,
				USUARIO_REGISTRA
			)
			values
			(
				rcRecOfTab.TIPO_TRABAJO(n),
				rcRecOfTab.ABREVIATURA(n),
				rcRecOfTab.ID_COT_COMERCIAL(n),
				rcRecOfTab.ACTIVIDAD(n),
				rcRecOfTab.IVA(n),
				rcRecOfTab.APLICA_DESC(n),
				rcRecOfTab.FECHA_REGISTRO(n),
				rcRecOfTab.USUARIO_REGISTRA(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuID_COT_COMERCIAL in LDC_TIPOTRAB_COTI_COM.ID_COT_COMERCIAL%type,
		isbABREVIATURA in LDC_TIPOTRAB_COTI_COM.ABREVIATURA%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_TIPOTRAB_COTI_COM;
	BEGIN
		rcError.ID_COT_COMERCIAL := inuID_COT_COMERCIAL;
		rcError.ABREVIATURA := isbABREVIATURA;

		if inuLock=1 then
			LockByPk
			(
				inuID_COT_COMERCIAL,
				isbABREVIATURA,
				rcData
			);
		end if;


		delete
		from LDC_TIPOTRAB_COTI_COM
		where
       		ID_COT_COMERCIAL=inuID_COT_COMERCIAL and
       		ABREVIATURA=isbABREVIATURA;
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
		rcError  styLDC_TIPOTRAB_COTI_COM;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_TIPOTRAB_COTI_COM
		where
			rowid = iriRowID
		returning
			TIPO_TRABAJO,
			ABREVIATURA
		into
			rcError.TIPO_TRABAJO,
			rcError.ABREVIATURA;
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
		iotbLDC_TIPOTRAB_COTI_COM in out nocopy tytbLDC_TIPOTRAB_COTI_COM,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_TIPOTRAB_COTI_COM;
	BEGIN
		FillRecordOfTables(iotbLDC_TIPOTRAB_COTI_COM, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_TIPOTRAB_COTI_COM.first .. iotbLDC_TIPOTRAB_COTI_COM.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_TIPOTRAB_COTI_COM.first .. iotbLDC_TIPOTRAB_COTI_COM.last
				delete
				from LDC_TIPOTRAB_COTI_COM
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_TIPOTRAB_COTI_COM.first .. iotbLDC_TIPOTRAB_COTI_COM.last loop
					LockByPk
					(
						rcRecOfTab.ID_COT_COMERCIAL(n),
						rcRecOfTab.ABREVIATURA(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_TIPOTRAB_COTI_COM.first .. iotbLDC_TIPOTRAB_COTI_COM.last
				delete
				from LDC_TIPOTRAB_COTI_COM
				where
		         	ID_COT_COMERCIAL = rcRecOfTab.ID_COT_COMERCIAL(n) and
		         	ABREVIATURA = rcRecOfTab.ABREVIATURA(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_TIPOTRAB_COTI_COM in styLDC_TIPOTRAB_COTI_COM,
		inuLock in number default 0
	)
	IS
		nuID_COT_COMERCIAL	LDC_TIPOTRAB_COTI_COM.ID_COT_COMERCIAL%type;
		sbABREVIATURA	LDC_TIPOTRAB_COTI_COM.ABREVIATURA%type;
	BEGIN
		if ircLDC_TIPOTRAB_COTI_COM.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_TIPOTRAB_COTI_COM.rowid,rcData);
			end if;
			update LDC_TIPOTRAB_COTI_COM
			set
				TIPO_TRABAJO = ircLDC_TIPOTRAB_COTI_COM.TIPO_TRABAJO,
				ACTIVIDAD = ircLDC_TIPOTRAB_COTI_COM.ACTIVIDAD,
				IVA = ircLDC_TIPOTRAB_COTI_COM.IVA,
				APLICA_DESC = ircLDC_TIPOTRAB_COTI_COM.APLICA_DESC,
				FECHA_REGISTRO = ircLDC_TIPOTRAB_COTI_COM.FECHA_REGISTRO,
				USUARIO_REGISTRA = ircLDC_TIPOTRAB_COTI_COM.USUARIO_REGISTRA
			where
				rowid = ircLDC_TIPOTRAB_COTI_COM.rowid
			returning
				ID_COT_COMERCIAL,
				ABREVIATURA
			into
				nuID_COT_COMERCIAL,
				sbABREVIATURA;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_TIPOTRAB_COTI_COM.ID_COT_COMERCIAL,
					ircLDC_TIPOTRAB_COTI_COM.ABREVIATURA,
					rcData
				);
			end if;

			update LDC_TIPOTRAB_COTI_COM
			set
				TIPO_TRABAJO = ircLDC_TIPOTRAB_COTI_COM.TIPO_TRABAJO,
				ACTIVIDAD = ircLDC_TIPOTRAB_COTI_COM.ACTIVIDAD,
				IVA = ircLDC_TIPOTRAB_COTI_COM.IVA,
				APLICA_DESC = ircLDC_TIPOTRAB_COTI_COM.APLICA_DESC,
				FECHA_REGISTRO = ircLDC_TIPOTRAB_COTI_COM.FECHA_REGISTRO,
				USUARIO_REGISTRA = ircLDC_TIPOTRAB_COTI_COM.USUARIO_REGISTRA
			where
				ID_COT_COMERCIAL = ircLDC_TIPOTRAB_COTI_COM.ID_COT_COMERCIAL and
				ABREVIATURA = ircLDC_TIPOTRAB_COTI_COM.ABREVIATURA
			returning
				ID_COT_COMERCIAL,
				ABREVIATURA
			into
				nuID_COT_COMERCIAL,
				sbABREVIATURA;
		end if;
		if
			nuID_COT_COMERCIAL is NULL OR
			sbABREVIATURA is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_TIPOTRAB_COTI_COM));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_TIPOTRAB_COTI_COM in out nocopy tytbLDC_TIPOTRAB_COTI_COM,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_TIPOTRAB_COTI_COM;
	BEGIN
		FillRecordOfTables(iotbLDC_TIPOTRAB_COTI_COM,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_TIPOTRAB_COTI_COM.first .. iotbLDC_TIPOTRAB_COTI_COM.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_TIPOTRAB_COTI_COM.first .. iotbLDC_TIPOTRAB_COTI_COM.last
				update LDC_TIPOTRAB_COTI_COM
				set
					TIPO_TRABAJO = rcRecOfTab.TIPO_TRABAJO(n),
					ACTIVIDAD = rcRecOfTab.ACTIVIDAD(n),
					IVA = rcRecOfTab.IVA(n),
					APLICA_DESC = rcRecOfTab.APLICA_DESC(n),
					FECHA_REGISTRO = rcRecOfTab.FECHA_REGISTRO(n),
					USUARIO_REGISTRA = rcRecOfTab.USUARIO_REGISTRA(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_TIPOTRAB_COTI_COM.first .. iotbLDC_TIPOTRAB_COTI_COM.last loop
					LockByPk
					(
						rcRecOfTab.ID_COT_COMERCIAL(n),
						rcRecOfTab.ABREVIATURA(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_TIPOTRAB_COTI_COM.first .. iotbLDC_TIPOTRAB_COTI_COM.last
				update LDC_TIPOTRAB_COTI_COM
				SET
					TIPO_TRABAJO = rcRecOfTab.TIPO_TRABAJO(n),
					ACTIVIDAD = rcRecOfTab.ACTIVIDAD(n),
					IVA = rcRecOfTab.IVA(n),
					APLICA_DESC = rcRecOfTab.APLICA_DESC(n),
					FECHA_REGISTRO = rcRecOfTab.FECHA_REGISTRO(n),
					USUARIO_REGISTRA = rcRecOfTab.USUARIO_REGISTRA(n)
				where
					ID_COT_COMERCIAL = rcRecOfTab.ID_COT_COMERCIAL(n) and
					ABREVIATURA = rcRecOfTab.ABREVIATURA(n)
;
		end if;
	END;
	PROCEDURE updTIPO_TRABAJO
	(
		inuID_COT_COMERCIAL in LDC_TIPOTRAB_COTI_COM.ID_COT_COMERCIAL%type,
		isbABREVIATURA in LDC_TIPOTRAB_COTI_COM.ABREVIATURA%type,
		inuTIPO_TRABAJO$ in LDC_TIPOTRAB_COTI_COM.TIPO_TRABAJO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_TIPOTRAB_COTI_COM;
	BEGIN
		rcError.ID_COT_COMERCIAL := inuID_COT_COMERCIAL;
		rcError.ABREVIATURA := isbABREVIATURA;
		if inuLock=1 then
			LockByPk
			(
				inuID_COT_COMERCIAL,
				isbABREVIATURA,
				rcData
			);
		end if;

		update LDC_TIPOTRAB_COTI_COM
		set
			TIPO_TRABAJO = inuTIPO_TRABAJO$
		where
			ID_COT_COMERCIAL = inuID_COT_COMERCIAL and
			ABREVIATURA = isbABREVIATURA;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TIPO_TRABAJO:= inuTIPO_TRABAJO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updACTIVIDAD
	(
		inuID_COT_COMERCIAL in LDC_TIPOTRAB_COTI_COM.ID_COT_COMERCIAL%type,
		isbABREVIATURA in LDC_TIPOTRAB_COTI_COM.ABREVIATURA%type,
		inuACTIVIDAD$ in LDC_TIPOTRAB_COTI_COM.ACTIVIDAD%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_TIPOTRAB_COTI_COM;
	BEGIN
		rcError.ID_COT_COMERCIAL := inuID_COT_COMERCIAL;
		rcError.ABREVIATURA := isbABREVIATURA;
		if inuLock=1 then
			LockByPk
			(
				inuID_COT_COMERCIAL,
				isbABREVIATURA,
				rcData
			);
		end if;

		update LDC_TIPOTRAB_COTI_COM
		set
			ACTIVIDAD = inuACTIVIDAD$
		where
			ID_COT_COMERCIAL = inuID_COT_COMERCIAL and
			ABREVIATURA = isbABREVIATURA;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ACTIVIDAD:= inuACTIVIDAD$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updIVA
	(
		inuID_COT_COMERCIAL in LDC_TIPOTRAB_COTI_COM.ID_COT_COMERCIAL%type,
		isbABREVIATURA in LDC_TIPOTRAB_COTI_COM.ABREVIATURA%type,
		inuIVA$ in LDC_TIPOTRAB_COTI_COM.IVA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_TIPOTRAB_COTI_COM;
	BEGIN
		rcError.ID_COT_COMERCIAL := inuID_COT_COMERCIAL;
		rcError.ABREVIATURA := isbABREVIATURA;
		if inuLock=1 then
			LockByPk
			(
				inuID_COT_COMERCIAL,
				isbABREVIATURA,
				rcData
			);
		end if;

		update LDC_TIPOTRAB_COTI_COM
		set
			IVA = inuIVA$
		where
			ID_COT_COMERCIAL = inuID_COT_COMERCIAL and
			ABREVIATURA = isbABREVIATURA;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.IVA:= inuIVA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updAPLICA_DESC
	(
		inuID_COT_COMERCIAL in LDC_TIPOTRAB_COTI_COM.ID_COT_COMERCIAL%type,
		isbABREVIATURA in LDC_TIPOTRAB_COTI_COM.ABREVIATURA%type,
		isbAPLICA_DESC$ in LDC_TIPOTRAB_COTI_COM.APLICA_DESC%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_TIPOTRAB_COTI_COM;
	BEGIN
		rcError.ID_COT_COMERCIAL := inuID_COT_COMERCIAL;
		rcError.ABREVIATURA := isbABREVIATURA;
		if inuLock=1 then
			LockByPk
			(
				inuID_COT_COMERCIAL,
				isbABREVIATURA,
				rcData
			);
		end if;

		update LDC_TIPOTRAB_COTI_COM
		set
			APLICA_DESC = isbAPLICA_DESC$
		where
			ID_COT_COMERCIAL = inuID_COT_COMERCIAL and
			ABREVIATURA = isbABREVIATURA;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.APLICA_DESC:= isbAPLICA_DESC$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFECHA_REGISTRO
	(
		inuID_COT_COMERCIAL in LDC_TIPOTRAB_COTI_COM.ID_COT_COMERCIAL%type,
		isbABREVIATURA in LDC_TIPOTRAB_COTI_COM.ABREVIATURA%type,
		idtFECHA_REGISTRO$ in LDC_TIPOTRAB_COTI_COM.FECHA_REGISTRO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_TIPOTRAB_COTI_COM;
	BEGIN
		rcError.ID_COT_COMERCIAL := inuID_COT_COMERCIAL;
		rcError.ABREVIATURA := isbABREVIATURA;
		if inuLock=1 then
			LockByPk
			(
				inuID_COT_COMERCIAL,
				isbABREVIATURA,
				rcData
			);
		end if;

		update LDC_TIPOTRAB_COTI_COM
		set
			FECHA_REGISTRO = idtFECHA_REGISTRO$
		where
			ID_COT_COMERCIAL = inuID_COT_COMERCIAL and
			ABREVIATURA = isbABREVIATURA;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FECHA_REGISTRO:= idtFECHA_REGISTRO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updUSUARIO_REGISTRA
	(
		inuID_COT_COMERCIAL in LDC_TIPOTRAB_COTI_COM.ID_COT_COMERCIAL%type,
		isbABREVIATURA in LDC_TIPOTRAB_COTI_COM.ABREVIATURA%type,
		isbUSUARIO_REGISTRA$ in LDC_TIPOTRAB_COTI_COM.USUARIO_REGISTRA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_TIPOTRAB_COTI_COM;
	BEGIN
		rcError.ID_COT_COMERCIAL := inuID_COT_COMERCIAL;
		rcError.ABREVIATURA := isbABREVIATURA;
		if inuLock=1 then
			LockByPk
			(
				inuID_COT_COMERCIAL,
				isbABREVIATURA,
				rcData
			);
		end if;

		update LDC_TIPOTRAB_COTI_COM
		set
			USUARIO_REGISTRA = isbUSUARIO_REGISTRA$
		where
			ID_COT_COMERCIAL = inuID_COT_COMERCIAL and
			ABREVIATURA = isbABREVIATURA;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.USUARIO_REGISTRA:= isbUSUARIO_REGISTRA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetTIPO_TRABAJO
	(
		inuID_COT_COMERCIAL in LDC_TIPOTRAB_COTI_COM.ID_COT_COMERCIAL%type,
		isbABREVIATURA in LDC_TIPOTRAB_COTI_COM.ABREVIATURA%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPOTRAB_COTI_COM.TIPO_TRABAJO%type
	IS
		rcError styLDC_TIPOTRAB_COTI_COM;
	BEGIN

		rcError.ID_COT_COMERCIAL := inuID_COT_COMERCIAL;
		rcError.ABREVIATURA := isbABREVIATURA;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COT_COMERCIAL,
		 		isbABREVIATURA
			 )
		then
			 return(rcData.TIPO_TRABAJO);
		end if;
		Load
		(
		 		inuID_COT_COMERCIAL,
		 		isbABREVIATURA
		);
		return(rcData.TIPO_TRABAJO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetABREVIATURA
	(
		inuID_COT_COMERCIAL in LDC_TIPOTRAB_COTI_COM.ID_COT_COMERCIAL%type,
		isbABREVIATURA in LDC_TIPOTRAB_COTI_COM.ABREVIATURA%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPOTRAB_COTI_COM.ABREVIATURA%type
	IS
		rcError styLDC_TIPOTRAB_COTI_COM;
	BEGIN

		rcError.ID_COT_COMERCIAL := inuID_COT_COMERCIAL;
		rcError.ABREVIATURA := isbABREVIATURA;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COT_COMERCIAL,
		 		isbABREVIATURA
			 )
		then
			 return(rcData.ABREVIATURA);
		end if;
		Load
		(
		 		inuID_COT_COMERCIAL,
		 		isbABREVIATURA
		);
		return(rcData.ABREVIATURA);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetID_COT_COMERCIAL
	(
		inuID_COT_COMERCIAL in LDC_TIPOTRAB_COTI_COM.ID_COT_COMERCIAL%type,
		isbABREVIATURA in LDC_TIPOTRAB_COTI_COM.ABREVIATURA%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPOTRAB_COTI_COM.ID_COT_COMERCIAL%type
	IS
		rcError styLDC_TIPOTRAB_COTI_COM;
	BEGIN

		rcError.ID_COT_COMERCIAL := inuID_COT_COMERCIAL;
		rcError.ABREVIATURA := isbABREVIATURA;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COT_COMERCIAL,
		 		isbABREVIATURA
			 )
		then
			 return(rcData.ID_COT_COMERCIAL);
		end if;
		Load
		(
		 		inuID_COT_COMERCIAL,
		 		isbABREVIATURA
		);
		return(rcData.ID_COT_COMERCIAL);
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
		inuID_COT_COMERCIAL in LDC_TIPOTRAB_COTI_COM.ID_COT_COMERCIAL%type,
		isbABREVIATURA in LDC_TIPOTRAB_COTI_COM.ABREVIATURA%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPOTRAB_COTI_COM.ACTIVIDAD%type
	IS
		rcError styLDC_TIPOTRAB_COTI_COM;
	BEGIN

		rcError.ID_COT_COMERCIAL := inuID_COT_COMERCIAL;
		rcError.ABREVIATURA := isbABREVIATURA;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COT_COMERCIAL,
		 		isbABREVIATURA
			 )
		then
			 return(rcData.ACTIVIDAD);
		end if;
		Load
		(
		 		inuID_COT_COMERCIAL,
		 		isbABREVIATURA
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
	FUNCTION fnuGetIVA
	(
		inuID_COT_COMERCIAL in LDC_TIPOTRAB_COTI_COM.ID_COT_COMERCIAL%type,
		isbABREVIATURA in LDC_TIPOTRAB_COTI_COM.ABREVIATURA%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPOTRAB_COTI_COM.IVA%type
	IS
		rcError styLDC_TIPOTRAB_COTI_COM;
	BEGIN

		rcError.ID_COT_COMERCIAL := inuID_COT_COMERCIAL;
		rcError.ABREVIATURA := isbABREVIATURA;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COT_COMERCIAL,
		 		isbABREVIATURA
			 )
		then
			 return(rcData.IVA);
		end if;
		Load
		(
		 		inuID_COT_COMERCIAL,
		 		isbABREVIATURA
		);
		return(rcData.IVA);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetAPLICA_DESC
	(
		inuID_COT_COMERCIAL in LDC_TIPOTRAB_COTI_COM.ID_COT_COMERCIAL%type,
		isbABREVIATURA in LDC_TIPOTRAB_COTI_COM.ABREVIATURA%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPOTRAB_COTI_COM.APLICA_DESC%type
	IS
		rcError styLDC_TIPOTRAB_COTI_COM;
	BEGIN

		rcError.ID_COT_COMERCIAL := inuID_COT_COMERCIAL;
		rcError.ABREVIATURA := isbABREVIATURA;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COT_COMERCIAL,
		 		isbABREVIATURA
			 )
		then
			 return(rcData.APLICA_DESC);
		end if;
		Load
		(
		 		inuID_COT_COMERCIAL,
		 		isbABREVIATURA
		);
		return(rcData.APLICA_DESC);
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
		inuID_COT_COMERCIAL in LDC_TIPOTRAB_COTI_COM.ID_COT_COMERCIAL%type,
		isbABREVIATURA in LDC_TIPOTRAB_COTI_COM.ABREVIATURA%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPOTRAB_COTI_COM.FECHA_REGISTRO%type
	IS
		rcError styLDC_TIPOTRAB_COTI_COM;
	BEGIN

		rcError.ID_COT_COMERCIAL := inuID_COT_COMERCIAL;
		rcError.ABREVIATURA := isbABREVIATURA;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COT_COMERCIAL,
		 		isbABREVIATURA
			 )
		then
			 return(rcData.FECHA_REGISTRO);
		end if;
		Load
		(
		 		inuID_COT_COMERCIAL,
		 		isbABREVIATURA
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
	FUNCTION fsbGetUSUARIO_REGISTRA
	(
		inuID_COT_COMERCIAL in LDC_TIPOTRAB_COTI_COM.ID_COT_COMERCIAL%type,
		isbABREVIATURA in LDC_TIPOTRAB_COTI_COM.ABREVIATURA%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TIPOTRAB_COTI_COM.USUARIO_REGISTRA%type
	IS
		rcError styLDC_TIPOTRAB_COTI_COM;
	BEGIN

		rcError.ID_COT_COMERCIAL := inuID_COT_COMERCIAL;
		rcError.ABREVIATURA := isbABREVIATURA;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_COT_COMERCIAL,
		 		isbABREVIATURA
			 )
		then
			 return(rcData.USUARIO_REGISTRA);
		end if;
		Load
		(
		 		inuID_COT_COMERCIAL,
		 		isbABREVIATURA
		);
		return(rcData.USUARIO_REGISTRA);
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
end DALDC_TIPOTRAB_COTI_COM;
/
PROMPT Otorgando permisos de ejecucion a DALDC_TIPOTRAB_COTI_COM
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_TIPOTRAB_COTI_COM', 'ADM_PERSON');
END;
/