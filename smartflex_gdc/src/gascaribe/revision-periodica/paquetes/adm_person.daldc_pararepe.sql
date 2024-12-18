CREATE OR REPLACE PACKAGE adm_person.DALDC_PARAREPE
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
		isbPARECODI in LDC_PARAREPE.PARECODI%type
	)
	IS
		SELECT LDC_PARAREPE.*,LDC_PARAREPE.rowid
		FROM LDC_PARAREPE
		WHERE
		    PARECODI = isbPARECODI;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_PARAREPE.*,LDC_PARAREPE.rowid
		FROM LDC_PARAREPE
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_PARAREPE  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_PARAREPE is table of styLDC_PARAREPE index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_PARAREPE;

	/* Tipos referenciando al registro */
	type tytbPARECODI is table of LDC_PARAREPE.PARECODI%type index by binary_integer;
	type tytbPARADESC is table of LDC_PARAREPE.PARADESC%type index by binary_integer;
	type tytbPAREVANU is table of LDC_PARAREPE.PAREVANU%type index by binary_integer;
	type tytbPARAVAST is table of LDC_PARAREPE.PARAVAST%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_PARAREPE is record
	(
		PARECODI   tytbPARECODI,
		PARADESC   tytbPARADESC,
		PAREVANU   tytbPAREVANU,
		PARAVAST   tytbPARAVAST,
		row_id tytbrowid
	);


	/***** Metodos Publicos ****/

    FUNCTION fsbVersion
    RETURN varchar2;
	/**************************************************************************
	  Proceso     : fsbVersion
	  Autor       : Horbath
	  Fecha       : 2020-01-22
	  Ticket      : 176
	  Descripcion : devuelve version instalada

	  Parametros Entrada


	  Parametros de salida

	  HISTORIA DE MODIFICACIONES
	  FECHA        AUTOR       DESCRIPCION
	***************************************************************************/

	FUNCTION fsbGetMessageDescription
	return varchar2;
	/**************************************************************************
	  Proceso     : fsbGetMessageDescription
	  Autor       : Horbath
	  Fecha       : 2020-01-22
	  Ticket      : 176
	  Descripcion : devuelve la descripcion de la entidad

	  Parametros Entrada


	  Parametros de salida

	  HISTORIA DE MODIFICACIONES
	  FECHA        AUTOR       DESCRIPCION
	***************************************************************************/

	PROCEDURE ClearMemory;
    /**************************************************************************
	  Proceso     : ClearMemory
	  Autor       : Horbath
	  Fecha       : 2020-01-22
	  Ticket      : 176
	  Descripcion : elimina registros de memoria

	  Parametros Entrada


	  Parametros de salida

	  HISTORIA DE MODIFICACIONES
	  FECHA        AUTOR       DESCRIPCION
	***************************************************************************/
	FUNCTION fblExist
	(
		isbPARECODI in LDC_PARAREPE.PARECODI%type
	)
	RETURN boolean;
	/**************************************************************************
	  Proceso     : fblExist
	  Autor       : horbath
	  Fecha       : 2020-01-22
	  Ticket      : 176
	  Descripcion : valida si existe registro

	  Parametros Entrada
        isbPARECODI   codigo del parametro

	  Parametros de salida

	  HISTORIA DE MODIFICACIONES
	  FECHA        AUTOR       DESCRIPCION
	***************************************************************************/

	PROCEDURE AccKey
	(
		isbPARECODI in LDC_PARAREPE.PARECODI%type
	);
	/**************************************************************************
	  Proceso     : AccKey
	  Autor       : horbath
	  Fecha       : 2020-01-22
	  Ticket      : 176
	  Descripcion : consulta registro por llave

	  Parametros Entrada
        isbPARECODI   codigo del parametro

	  Parametros de salida

	  HISTORIA DE MODIFICACIONES
	  FECHA        AUTOR       DESCRIPCION
	***************************************************************************/


	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);
	/**************************************************************************
	  Proceso     : AccKeyByRowId
	  Autor       : horbath
	  Fecha       : 2020-01-22
	  Ticket      : 176
	  Descripcion : consulta registro por rowid

	  Parametros Entrada
        isbPARECODI   codigo del parametro

	  Parametros de salida

	  HISTORIA DE MODIFICACIONES
	  FECHA        AUTOR       DESCRIPCION
	***************************************************************************/


	PROCEDURE ValDuplicate
	(
		isbPARECODI in LDC_PARAREPE.PARECODI%type
	);
	/**************************************************************************
	  Proceso     : ValDuplicate
	  Autor       : horbath
	  Fecha       : 2020-01-22
	  Ticket      : 176
	  Descripcion : valida registro duplicado

	  Parametros Entrada
        isbPARECODI   codigo del parametro

	  Parametros de salida

	  HISTORIA DE MODIFICACIONES
	  FECHA        AUTOR       DESCRIPCION
	***************************************************************************/

	PROCEDURE getRecord
	(
		isbPARECODI in LDC_PARAREPE.PARECODI%type,
		orcRecord out nocopy styLDC_PARAREPE
	);
	/**************************************************************************
	  Proceso     : getRecord
	  Autor       : horbath
	  Fecha       : 2020-01-22
	  Ticket      : 176
	  Descripcion : retorna un registro de parametro por el codigo

	  Parametros Entrada
        isbPARECODI   codigo del parametro
        orcRecord  registro
	  Parametros de salida

	  HISTORIA DE MODIFICACIONES
	  FECHA        AUTOR       DESCRIPCION
	***************************************************************************/

	FUNCTION frcGetRcData
	(
		isbPARECODI in LDC_PARAREPE.PARECODI%type
	)
	RETURN styLDC_PARAREPE;
	/**************************************************************************
	  Proceso     : frcGetRcData
	  Autor       : horbath
	  Fecha       : 2020-01-22
	  Ticket      : 176
	  Descripcion :funcion que retorna un registro del parametro por el codigo

	  Parametros Entrada
        isbPARECODI   codigo del parametro

	  Parametros de salida

	  HISTORIA DE MODIFICACIONES
	  FECHA        AUTOR       DESCRIPCION
	***************************************************************************/

	FUNCTION frcGetRcData
	RETURN styLDC_PARAREPE;
	/**************************************************************************
	  Proceso     : frcGetRcData
	  Autor       : horbath
	  Fecha       : 2020-01-22
	  Ticket      : 176
	  Descripcion :funcion que retorna un registro del parametro que esta en memoria

	  Parametros Entrada

	  Parametros de salida

	  HISTORIA DE MODIFICACIONES
	  FECHA        AUTOR       DESCRIPCION
	***************************************************************************/

	FUNCTION frcGetRecord
	(
		isbPARECODI in LDC_PARAREPE.PARECODI%type
	)
	RETURN styLDC_PARAREPE;
	/**************************************************************************
	  Proceso     : frcGetRecord
	  Autor       : horbath
	  Fecha       : 2020-01-22
	  Ticket      : 176
	  Descripcion :funcion que retorna un registro del parametro por codigo del parametro

	  Parametros Entrada
       isbPARECODI  codigo del parametro

	  Parametros de salida

	  HISTORIA DE MODIFICACIONES
	  FECHA        AUTOR       DESCRIPCION
	***************************************************************************/

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_PARAREPE
	);
	/**************************************************************************
	  Proceso     : getRecords
	  Autor       : horbath
	  Fecha       : 2020-01-22
	  Ticket      : 176
	  Descripcion : proceso que devuelve una tabla de parametro por un query

	  Parametros Entrada
       isbQuery  query

	  Parametros de salida
	   otbResult tabla de paramtros

	  HISTORIA DE MODIFICACIONES
	  FECHA        AUTOR       DESCRIPCION
	***************************************************************************/

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;
	/**************************************************************************
	  Proceso     : frfGetRecords
	  Autor       : horbath
	  Fecha       : 2020-01-22
	  Ticket      : 176
	  Descripcion : proceo que devuelve una tabla de parametro por un query

	  Parametros Entrada
       isbCriteria  query
	   iblLock  bloquea
	  Parametros de salida


	  HISTORIA DE MODIFICACIONES
	  FECHA        AUTOR       DESCRIPCION
	***************************************************************************/

	PROCEDURE insRecord
	(
		ircLDC_PARAREPE in styLDC_PARAREPE
	);
	/**************************************************************************
	  Proceso     : insRecord
	  Autor       : horbath
	  Fecha       : 2020-01-22
	  Ticket      : 176
	  Descripcion : insert registro en tabla LDC_PARAREPE

	  Parametros Entrada
       ircLDC_PARAREPE registro de parametro
	  Parametros de salida


	  HISTORIA DE MODIFICACIONES
	  FECHA        AUTOR       DESCRIPCION
	***************************************************************************/

	PROCEDURE insRecord
	(
		ircLDC_PARAREPE in styLDC_PARAREPE,
        orirowid   out varchar2
	);
	/**************************************************************************
	  Proceso     : insRecord
	  Autor       : horbath
	  Fecha       : 2020-01-22
	  Ticket      : 176
	  Descripcion : insert registro en tabla LDC_PARAREPE

	  Parametros Entrada
       ircLDC_PARAREPE registro de parametro
	  Parametros de salida
	   orirowid rowid el registro

	  HISTORIA DE MODIFICACIONES
	  FECHA        AUTOR       DESCRIPCION
	***************************************************************************/

	PROCEDURE insRecords
	(
		iotbLDC_PARAREPE in out nocopy tytbLDC_PARAREPE
	);
	/**************************************************************************
	  Proceso     : insRecords
	  Autor       : horbath
	  Fecha       : 2020-01-22
	  Ticket      : 176
	  Descripcion : insert registro en tabla LDC_PARAREPE

	  Parametros Entrada
       iotbLDC_PARAREPE registro de parametro
	  Parametros de salida


	  HISTORIA DE MODIFICACIONES
	  FECHA        AUTOR       DESCRIPCION
	***************************************************************************/

	PROCEDURE delRecord
	(
		isbPARECODI in LDC_PARAREPE.PARECODI%type,
		inuLock in number default 1
	);
	/**************************************************************************
	  Proceso     : delRecord
	  Autor       : horbath
	  Fecha       : 2020-01-22
	  Ticket      : 176
	  Descripcion : elimina registro en tabla LDC_PARAREPE por codigo

	  Parametros Entrada
       isbPARECODI  codigo del parametro
	   inuLock   bloquea registro si o no
	  Parametros de salida


	  HISTORIA DE MODIFICACIONES
	  FECHA        AUTOR       DESCRIPCION
	***************************************************************************/

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);
	/**************************************************************************
	  Proceso     : delByRowID
	  Autor       : horbath
	  Fecha       : 2020-01-22
	  Ticket      : 176
	  Descripcion : elimina registro en tabla LDC_PARAREPE por rowid

	  Parametros Entrada
       iriRowID  codigo del rowid
	   inuLock   bloquea registro si o no
	  Parametros de salida


	  HISTORIA DE MODIFICACIONES
	  FECHA        AUTOR       DESCRIPCION
	***************************************************************************/


	PROCEDURE delRecords
	(
		iotbLDC_PARAREPE in out nocopy tytbLDC_PARAREPE,
		inuLock in number default 1
	);
	/**************************************************************************
	  Proceso     : delRecords
	  Autor       : horbath
	  Fecha       : 2020-01-22
	  Ticket      : 176
	  Descripcion : elimina registro en tabla LDC_PARAREPE por registros

	  Parametros Entrada
       iotbLDC_PARAREPE  tabla de registros  LDC_PARAREPE
	   inuLock   bloquea registro si o no
	  Parametros de salida


	  HISTORIA DE MODIFICACIONES
	  FECHA        AUTOR       DESCRIPCION
	***************************************************************************/


	PROCEDURE updRecord
	(
		ircLDC_PARAREPE in styLDC_PARAREPE,
		inuLock in number default 0
	);
	/**************************************************************************
	  Proceso     : updRecord
	  Autor       : horbath
	  Fecha       : 2020-01-22
	  Ticket      : 176
	  Descripcion : actualiza  registro en tabla LDC_PARAREPE

	  Parametros Entrada
       ircLDC_PARAREPE  tabla de registros  LDC_PARAREPE
	   inuLock   bloquea registro si o no
	  Parametros de salida


	  HISTORIA DE MODIFICACIONES
	  FECHA        AUTOR       DESCRIPCION
	***************************************************************************/


	PROCEDURE updRecords
	(
		iotbLDC_PARAREPE in out nocopy tytbLDC_PARAREPE,
		inuLock in number default 1
	);
	/**************************************************************************
	  Proceso     : updRecords
	  Autor       : horbath
	  Fecha       : 2020-01-22
	  Ticket      : 176
	  Descripcion : actualiza  registros en tabla LDC_PARAREPE

	  Parametros Entrada
       iotbLDC_PARAREPE  tabla de registros  LDC_PARAREPE
	   inuLock   bloquea registro si o no
	  Parametros de salida


	  HISTORIA DE MODIFICACIONES
	  FECHA        AUTOR       DESCRIPCION
	***************************************************************************/

	PROCEDURE updPARADESC
	(
		isbPARECODI in LDC_PARAREPE.PARECODI%type,
		isbPARADESC$ in LDC_PARAREPE.PARADESC%type,
		inuLock in number default 0
	);
	/**************************************************************************
	  Proceso     : updPARADESC
	  Autor       : horbath
	  Fecha       : 2020-01-22
	  Ticket      : 176
	  Descripcion : actualiza  registros en tabla LDC_PARAREPE

	  Parametros Entrada
       isbPARECODI   codigo del parametro
	   isbPARADESC$   descripcion
	   inuLock  bloqueo 1 no 0
	  Parametros de salida


	  HISTORIA DE MODIFICACIONES
	  FECHA        AUTOR       DESCRIPCION
	***************************************************************************/


	PROCEDURE updPAREVANU
	(
		isbPARECODI in LDC_PARAREPE.PARECODI%type,
		inuPAREVANU$ in LDC_PARAREPE.PAREVANU%type,
		inuLock in number default 0
	);
	/**************************************************************************
	  Proceso     : updPAREVANU
	  Autor       : horbath
	  Fecha       : 2020-01-22
	  Ticket      : 176
	  Descripcion : actualiza  valor numerico en la tabla LDC_PARAREPE

	  Parametros Entrada
       isbPARECODI   codigo del parametro
	   inuPAREVANU$   valor numerico
	   inuLock  bloqueo 1 no 0
	  Parametros de salida


	  HISTORIA DE MODIFICACIONES
	  FECHA        AUTOR       DESCRIPCION
	***************************************************************************/


	PROCEDURE updPARAVAST
	(
		isbPARECODI in LDC_PARAREPE.PARECODI%type,
		isbPARAVAST$ in LDC_PARAREPE.PARAVAST%type,
		inuLock in number default 0
	);
	/**************************************************************************
	  Proceso     : updPARAVAST
	  Autor       : horbath
	  Fecha       : 2020-01-22
	  Ticket      : 176
	  Descripcion : actualiza valor cadena en tabla LDC_PARAREPE

	  Parametros Entrada
       isbPARECODI   codigo del parametro
	   isbPARAVAST$   descripcion
	   inuLock  bloqueo 1 no 0
	  Parametros de salida


	  HISTORIA DE MODIFICACIONES
	  FECHA        AUTOR       DESCRIPCION
	***************************************************************************/

	FUNCTION fsbGetPARECODI
	(
		isbPARECODI in LDC_PARAREPE.PARECODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PARAREPE.PARECODI%type;
	/**************************************************************************
	  Proceso     : fsbGetPARECODI
	  Autor       : horbath
	  Fecha       : 2020-01-22
	  Ticket      : 176
	  Descripcion : retorna codigo del parametro

	  Parametros Entrada
       isbPARECODI   codigo del parametro
	   inuRaiseError   error

	  Parametros de salida


	  HISTORIA DE MODIFICACIONES
	  FECHA        AUTOR       DESCRIPCION
	***************************************************************************/


	FUNCTION fsbGetPARADESC
	(
		isbPARECODI in LDC_PARAREPE.PARECODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PARAREPE.PARADESC%type;
    /**************************************************************************
	  Proceso     : fsbGetPARADESC
	  Autor       : horbath
	  Fecha       : 2020-01-22
	  Ticket      : 176
	  Descripcion : retorna descripcion del parametro

	  Parametros Entrada
       isbPARECODI   codigo del parametro
	   inuRaiseError   error

	  Parametros de salida


	  HISTORIA DE MODIFICACIONES
	  FECHA        AUTOR       DESCRIPCION
	***************************************************************************/
	FUNCTION fnuGetPAREVANU
	(
		isbPARECODI in LDC_PARAREPE.PARECODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PARAREPE.PAREVANU%type;
     /**************************************************************************
	  Proceso     : fnuGetPAREVANU
	  Autor       : horbath
	  Fecha       : 2020-01-22
	  Ticket      : 176
	  Descripcion : retorna valor numerico del parametro

	  Parametros Entrada
       isbPARECODI   codigo del parametro
	   inuRaiseError   error

	  Parametros de salida


	  HISTORIA DE MODIFICACIONES
	  FECHA        AUTOR       DESCRIPCION
	***************************************************************************/

	FUNCTION fsbGetPARAVAST
	(
		isbPARECODI in LDC_PARAREPE.PARECODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PARAREPE.PARAVAST%type;
    /**************************************************************************
	  Proceso     : fsbGetPARAVAST
	  Autor       : horbath
	  Fecha       : 2020-01-22
	  Ticket      : 176
	  Descripcion : retorna valor cadena del parametro

	  Parametros Entrada
       isbPARECODI   codigo del parametro
	   inuRaiseError   error

	  Parametros de salida


	  HISTORIA DE MODIFICACIONES
	  FECHA        AUTOR       DESCRIPCION
	***************************************************************************/

	PROCEDURE LockByPk
	(
		isbPARECODI in LDC_PARAREPE.PARECODI%type,
		orcLDC_PARAREPE  out styLDC_PARAREPE
	);
	/**************************************************************************
	  Proceso     : LockByPk
	  Autor       : horbath
	  Fecha       : 2020-01-22
	  Ticket      : 176
	  Descripcion : bloquea por llave primaria

	  Parametros Entrada
       isbPARECODI   codigo del parametro
	   orcLDC_PARAREPE   registro

	  Parametros de salida


	  HISTORIA DE MODIFICACIONES
	  FECHA        AUTOR       DESCRIPCION
	***************************************************************************/


	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_PARAREPE  out styLDC_PARAREPE
	);
	/**************************************************************************
	  Proceso     : LockByRowID
	  Autor       : horbath
	  Fecha       : 2020-01-22
	  Ticket      : 176
	  Descripcion : bloquea por rowid

	  Parametros Entrada
       irirowid   rowid del parametro
	   orcLDC_PARAREPE   registro

	  Parametros de salida


	  HISTORIA DE MODIFICACIONES
	  FECHA        AUTOR       DESCRIPCION
	***************************************************************************/

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
	/**************************************************************************
	  Proceso     : SetUseCache
	  Autor       : horbath
	  Fecha       : 2020-01-22
	  Ticket      : 176
	  Descripcion : guarda o no cache

	  Parametros Entrada
       iblUseCache usa cache

	  Parametros de salida


	  HISTORIA DE MODIFICACIONES
	  FECHA        AUTOR       DESCRIPCION
	***************************************************************************/


END DALDC_PARAREPE;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALDC_PARAREPE
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO1';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_PARAREPE';
	 cnuGeEntityId constant varchar2(30) := 5625; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		isbPARECODI in LDC_PARAREPE.PARECODI%type
	)
	IS
		SELECT LDC_PARAREPE.*,LDC_PARAREPE.rowid
		FROM LDC_PARAREPE
		WHERE  PARECODI = isbPARECODI
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_PARAREPE.*,LDC_PARAREPE.rowid
		FROM LDC_PARAREPE
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_PARAREPE is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_PARAREPE;

	rcData cuRecord%rowtype;

    blDAO_USE_CACHE    boolean := null;


	/* Metodos privados */
	FUNCTION fsbGetMessageDescription
	return varchar2
	is
	/**************************************************************************
	  Proceso     : fsbGetMessageDescription
	  Autor       : Horbath
	  Fecha       : 2020-01-22
	  Ticket      : 176
	  Descripcion : devuelve la descripcion de la entidad

	  Parametros Entrada


	  Parametros de salida

	  HISTORIA DE MODIFICACIONES
	  FECHA        AUTOR       DESCRIPCION
	***************************************************************************/

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
	/**************************************************************************
	  Proceso     : GetDAO_USE_CACHE
	  Autor       : Horbath
	  Fecha       : 2020-01-22
	  Ticket      : 176
	  Descripcion : devuelve uso de cache

	  Parametros Entrada


	  Parametros de salida

	  HISTORIA DE MODIFICACIONES
	  FECHA        AUTOR       DESCRIPCION
	***************************************************************************/
	BEGIN
	    if ( blDAO_USE_CACHE is null ) then
	        blDAO_USE_CACHE :=  ge_boparameter.fsbget('DAO_USE_CACHE') = 'Y';
	    end if;
	END;
	FUNCTION fsbPrimaryKey( rcI in styLDC_PARAREPE default rcData )
	return varchar2
	IS
	/**************************************************************************
	  Proceso     : fsbPrimaryKey
	  Autor       : Horbath
	  Fecha       : 2020-01-22
	  Ticket      : 176
	  Descripcion : devuelve nombre de la llave primaria

	  Parametros Entrada


	  Parametros de salida

	  HISTORIA DE MODIFICACIONES
	  FECHA        AUTOR       DESCRIPCION
	***************************************************************************/
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.PARECODI);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		isbPARECODI in LDC_PARAREPE.PARECODI%type,
		orcLDC_PARAREPE  out styLDC_PARAREPE
	)
	IS
	/**************************************************************************
	  Proceso     : LockByPk
	  Autor       : horbath
	  Fecha       : 2020-01-22
	  Ticket      : 176
	  Descripcion : bloquea por llave primaria

	  Parametros Entrada
       isbPARECODI   codigo del parametro
	   orcLDC_PARAREPE   registro

	  Parametros de salida


	  HISTORIA DE MODIFICACIONES
	  FECHA        AUTOR       DESCRIPCION
	***************************************************************************/

		rcError styLDC_PARAREPE;
	BEGIN
		rcError.PARECODI := isbPARECODI;

		Open cuLockRcByPk
		(
			isbPARECODI
		);

		fetch cuLockRcByPk into orcLDC_PARAREPE;
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
		orcLDC_PARAREPE  out styLDC_PARAREPE
	)
	IS
	/**************************************************************************
	  Proceso     : LockByRowID
	  Autor       : horbath
	  Fecha       : 2020-01-22
	  Ticket      : 176
	  Descripcion : bloquea por rowid

	  Parametros Entrada
       irirowid   rowid del parametro
	   orcLDC_PARAREPE   registro

	  Parametros de salida


	  HISTORIA DE MODIFICACIONES
	  FECHA        AUTOR       DESCRIPCION
	***************************************************************************/

	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_PARAREPE;
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
		itbLDC_PARAREPE  in out nocopy tytbLDC_PARAREPE
	)
	IS
	/**************************************************************************
	  Proceso     : DelRecordOfTables
	  Autor       : horbath
	  Fecha       : 2020-01-22
	  Ticket      : 176
	  Descripcion : elimina registros

	  Parametros Entrada
       iitbLDC_PARAREPE registro de parametros

	  Parametros de salida


	  HISTORIA DE MODIFICACIONES
	  FECHA        AUTOR       DESCRIPCION
	***************************************************************************/

	BEGIN
			rcRecOfTab.PARECODI.delete;
			rcRecOfTab.PARADESC.delete;
			rcRecOfTab.PAREVANU.delete;
			rcRecOfTab.PARAVAST.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_PARAREPE  in out nocopy tytbLDC_PARAREPE,
		oblUseRowId out boolean
	)
	IS
	/**************************************************************************
	  Proceso     : FillRecordOfTables
	  Autor       : horbath
	  Fecha       : 2020-01-22
	  Ticket      : 176
	  Descripcion : consulta todos los registros de LDC_PARAREPE

	  Parametros Entrada
       itbLDC_PARAREPE registro de parametros
	    oblUseRowId uso de rowid
	  Parametros de salida


	  HISTORIA DE MODIFICACIONES
	  FECHA        AUTOR       DESCRIPCION
	***************************************************************************/

	BEGIN
		DelRecordOfTables(itbLDC_PARAREPE);

		for n in itbLDC_PARAREPE.first .. itbLDC_PARAREPE.last loop
			rcRecOfTab.PARECODI(n) := itbLDC_PARAREPE(n).PARECODI;
			rcRecOfTab.PARADESC(n) := itbLDC_PARAREPE(n).PARADESC;
			rcRecOfTab.PAREVANU(n) := itbLDC_PARAREPE(n).PAREVANU;
			rcRecOfTab.PARAVAST(n) := itbLDC_PARAREPE(n).PARAVAST;
			rcRecOfTab.row_id(n) := itbLDC_PARAREPE(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		isbPARECODI in LDC_PARAREPE.PARECODI%type
	)
	IS
	/**************************************************************************
	  Proceso     : Load
	  Autor       : horbath
	  Fecha       : 2020-01-22
	  Ticket      : 176
	  Descripcion : cargar registros

	  Parametros Entrada
       isbPARECODI codigo del parametro
	  Parametros de salida


	  HISTORIA DE MODIFICACIONES
	  FECHA        AUTOR       DESCRIPCION
	***************************************************************************/
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			isbPARECODI
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
	/**************************************************************************
	  Proceso     : LoadByRowId
	  Autor       : horbath
	  Fecha       : 2020-01-22
	  Ticket      : 176
	  Descripcion : cargar registros por rowid

	  Parametros Entrada
       irirowid   rowid del registro
	  Parametros de salida


	  HISTORIA DE MODIFICACIONES
	  FECHA        AUTOR       DESCRIPCION
	***************************************************************************/

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
		isbPARECODI in LDC_PARAREPE.PARECODI%type
	)
	RETURN boolean
	/**************************************************************************
	  Proceso     : fblAlreadyLoaded
	  Autor       : horbath
	  Fecha       : 2020-01-22
	  Ticket      : 176
	  Descripcion : valida si el registro esta cargado

	  Parametros Entrada
       isbPARECODI codigo del parametro

	  Parametros de salida


	  HISTORIA DE MODIFICACIONES
	  FECHA        AUTOR       DESCRIPCION
	***************************************************************************/

	IS
	BEGIN
		if (
			isbPARECODI = rcData.PARECODI
		   ) then
			return ( true );
		end if;
		return (false);
	END;

	/***** Fin metodos privados *****/

	/***** Metodos publicos ******/
    FUNCTION fsbVersion
    RETURN varchar2
	/**************************************************************************
	  Proceso     : fsbVersion
	  Autor       : Horbath
	  Fecha       : 2020-01-22
	  Ticket      : 176
	  Descripcion : devuelve version instalada

	  Parametros Entrada


	  Parametros de salida

	  HISTORIA DE MODIFICACIONES
	  FECHA        AUTOR       DESCRIPCION
	***************************************************************************/
	IS
	BEGIN
		return csbVersion;
	END;
	PROCEDURE ClearMemory
	IS
	/**************************************************************************
	  Proceso     : ClearMemory
	  Autor       : Horbath
	  Fecha       : 2020-01-22
	  Ticket      : 176
	  Descripcion : elimina registros de memoria

	  Parametros Entrada


	  Parametros de salida

	  HISTORIA DE MODIFICACIONES
	  FECHA        AUTOR       DESCRIPCION
	***************************************************************************/
		rcRecordNull cuRecord%rowtype;
	BEGIN
		rcData := rcRecordNull;
	END;
	FUNCTION fblExist
	(
		isbPARECODI in LDC_PARAREPE.PARECODI%type
	)
	RETURN boolean
	IS
	/**************************************************************************
	  Proceso     : fblExist
	  Autor       : horbath
	  Fecha       : 2020-01-22
	  Ticket      : 176
	  Descripcion : valdia si existe registro

	  Parametros Entrada
        isbPARECODI   codigo del parametro

	  Parametros de salida

	  HISTORIA DE MODIFICACIONES
	  FECHA        AUTOR       DESCRIPCION
	***************************************************************************/

	BEGIN
		Load
		(
			isbPARECODI
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		isbPARECODI in LDC_PARAREPE.PARECODI%type
	)
	IS
	/**************************************************************************
	  Proceso     : AccKey
	  Autor       : horbath
	  Fecha       : 2020-01-22
	  Ticket      : 176
	  Descripcion : consulta registro por llave

	  Parametros Entrada
        isbPARECODI   codigo del parametro

	  Parametros de salida

	  HISTORIA DE MODIFICACIONES
	  FECHA        AUTOR       DESCRIPCION
	***************************************************************************/


		rcError styLDC_PARAREPE;
	BEGIN		rcError.PARECODI:=isbPARECODI;

		Load
		(
			isbPARECODI
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
	/**************************************************************************
	  Proceso     : AccKeyByRowId
	  Autor       : horbath
	  Fecha       : 2020-01-22
	  Ticket      : 176
	  Descripcion : consulta registro por rowid

	  Parametros Entrada
        isbPARECODI   codigo del parametro

	  Parametros de salida

	  HISTORIA DE MODIFICACIONES
	  FECHA        AUTOR       DESCRIPCION
	***************************************************************************/
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
		isbPARECODI in LDC_PARAREPE.PARECODI%type
	)
	IS
	/**************************************************************************
	  Proceso     : ValDuplicate
	  Autor       : horbath
	  Fecha       : 2020-01-22
	  Ticket      : 176
	  Descripcion : valida registro duplicado

	  Parametros Entrada
        isbPARECODI   codigo del parametro

	  Parametros de salida

	  HISTORIA DE MODIFICACIONES
	  FECHA        AUTOR       DESCRIPCION
	***************************************************************************/
	BEGIN
		Load
		(
			isbPARECODI
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		isbPARECODI in LDC_PARAREPE.PARECODI%type,
		orcRecord out nocopy styLDC_PARAREPE
	)
	IS
	/**************************************************************************
	  Proceso     : getRecord
	  Autor       : horbath
	  Fecha       : 2020-01-22
	  Ticket      : 176
	  Descripcion : retorna un registro de parametro por el codigo

	  Parametros Entrada
        isbPARECODI   codigo del parametro
        orcRecord  registro
	  Parametros de salida

	  HISTORIA DE MODIFICACIONES
	  FECHA        AUTOR       DESCRIPCION
	***************************************************************************/
		rcError styLDC_PARAREPE;
	BEGIN		rcError.PARECODI:=isbPARECODI;

		Load
		(
			isbPARECODI
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		isbPARECODI in LDC_PARAREPE.PARECODI%type
	)
	RETURN styLDC_PARAREPE
	IS
	/**************************************************************************
	  Proceso     : frcGetRecord
	  Autor       : horbath
	  Fecha       : 2020-01-22
	  Ticket      : 176
	  Descripcion :funcion que retorna un registro del parametro por codigo del parametro

	  Parametros Entrada
       isbPARECODI  codigo del parametro

	  Parametros de salida

	  HISTORIA DE MODIFICACIONES
	  FECHA        AUTOR       DESCRIPCION
	***************************************************************************/
		rcError styLDC_PARAREPE;
	BEGIN
		rcError.PARECODI:=isbPARECODI;

		Load
		(
			isbPARECODI
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		isbPARECODI in LDC_PARAREPE.PARECODI%type
	)
	RETURN styLDC_PARAREPE
	IS
	/**************************************************************************
	  Proceso     : frcGetRcData
	  Autor       : horbath
	  Fecha       : 2020-01-22
	  Ticket      : 176
	  Descripcion :funcion que retorna un registro del parametro por el codigo

	  Parametros Entrada
        isbPARECODI   codigo del parametro

	  Parametros de salida

	  HISTORIA DE MODIFICACIONES
	  FECHA        AUTOR       DESCRIPCION
	***************************************************************************/
		rcError styLDC_PARAREPE;
	BEGIN
		rcError.PARECODI:=isbPARECODI;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			isbPARECODI
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			isbPARECODI
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_PARAREPE
	IS
	/**************************************************************************
	  Proceso     : frcGetRcData
	  Autor       : horbath
	  Fecha       : 2020-01-22
	  Ticket      : 176
	  Descripcion :funcion que retorna un registro del parametro que esta en memoria

	  Parametros Entrada

	  Parametros de salida

	  HISTORIA DE MODIFICACIONES
	  FECHA        AUTOR       DESCRIPCION
	***************************************************************************/
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_PARAREPE
	)
	IS
	/**************************************************************************
	  Proceso     : getRecords
	  Autor       : horbath
	  Fecha       : 2020-01-22
	  Ticket      : 176
	  Descripcion : proceo que devuelve una tabla de parametro por un query

	  Parametros Entrada
       isbQuery  query

	  Parametros de salida
	   otbResult tabla de paramtros

	  HISTORIA DE MODIFICACIONES
	  FECHA        AUTOR       DESCRIPCION
	***************************************************************************/
		rfLDC_PARAREPE tyrfLDC_PARAREPE;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_PARAREPE.*, LDC_PARAREPE.rowid FROM LDC_PARAREPE';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_PARAREPE for sbFullQuery;

		fetch rfLDC_PARAREPE bulk collect INTO otbResult;

		close rfLDC_PARAREPE;
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
    /**************************************************************************
	  Proceso     : frfGetRecords
	  Autor       : horbath
	  Fecha       : 2020-01-22
	  Ticket      : 176
	  Descripcion : proceo que devuelve una tabla de parametro por un query

	  Parametros Entrada
       isbCriteria  query
	   iblLock  bloquea
	  Parametros de salida


	  HISTORIA DE MODIFICACIONES
	  FECHA        AUTOR       DESCRIPCION
	***************************************************************************/
	rfQuery tyRefCursor;
		sbSQL VARCHAR2 (32000) := 'select LDC_PARAREPE.*, LDC_PARAREPE.rowid FROM LDC_PARAREPE';
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
		ircLDC_PARAREPE in styLDC_PARAREPE
	)
	IS
	/**************************************************************************
	  Proceso     : insRecord
	  Autor       : horbath
	  Fecha       : 2020-01-22
	  Ticket      : 176
	  Descripcion : insert registro en tabla LDC_PARAREPE

	  Parametros Entrada
       ircLDC_PARAREPE registro de parametro
	  Parametros de salida


	  HISTORIA DE MODIFICACIONES
	  FECHA        AUTOR       DESCRIPCION
	***************************************************************************/

		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_PARAREPE,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_PARAREPE in styLDC_PARAREPE,
        orirowid   out varchar2
	)
	IS
	/**************************************************************************
	  Proceso     : insRecord
	  Autor       : horbath
	  Fecha       : 2020-01-22
	  Ticket      : 176
	  Descripcion : insert registro en tabla LDC_PARAREPE

	  Parametros Entrada
       ircLDC_PARAREPE registro de parametro
	  Parametros de salida
	   orirowid rowid el registro

	  HISTORIA DE MODIFICACIONES
	  FECHA        AUTOR       DESCRIPCION
	***************************************************************************/
	BEGIN
		if ircLDC_PARAREPE.PARECODI is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|PARECODI');
			raise ex.controlled_error;
		end if;

		insert into LDC_PARAREPE
		(
			PARECODI,
			PARADESC,
			PAREVANU,
			PARAVAST
		)
		values
		(
			ircLDC_PARAREPE.PARECODI,
			ircLDC_PARAREPE.PARADESC,
			ircLDC_PARAREPE.PAREVANU,
			ircLDC_PARAREPE.PARAVAST
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_PARAREPE));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_PARAREPE in out nocopy tytbLDC_PARAREPE
	)
	IS
	/**************************************************************************
	  Proceso     : insRecords
	  Autor       : horbath
	  Fecha       : 2020-01-22
	  Ticket      : 176
	  Descripcion : insert registro en tabla LDC_PARAREPE

	  Parametros Entrada
       iotbLDC_PARAREPE registro de parametro
	  Parametros de salida


	  HISTORIA DE MODIFICACIONES
	  FECHA        AUTOR       DESCRIPCION
	***************************************************************************/
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_PARAREPE,blUseRowID);
		forall n in iotbLDC_PARAREPE.first..iotbLDC_PARAREPE.last
			insert into LDC_PARAREPE
			(
				PARECODI,
				PARADESC,
				PAREVANU,
				PARAVAST
			)
			values
			(
				rcRecOfTab.PARECODI(n),
				rcRecOfTab.PARADESC(n),
				rcRecOfTab.PAREVANU(n),
				rcRecOfTab.PARAVAST(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		isbPARECODI in LDC_PARAREPE.PARECODI%type,
		inuLock in number default 1
	)
	IS
	/**************************************************************************
	  Proceso     : delRecord
	  Autor       : horbath
	  Fecha       : 2020-01-22
	  Ticket      : 176
	  Descripcion : elimina registro en tabla LDC_PARAREPE por codigo

	  Parametros Entrada
       isbPARECODI  codigo del parametro
	   inuLock   bloquea registro si o no
	  Parametros de salida


	  HISTORIA DE MODIFICACIONES
	  FECHA        AUTOR       DESCRIPCION
	***************************************************************************/
		rcError styLDC_PARAREPE;
	BEGIN
		rcError.PARECODI := isbPARECODI;

		if inuLock=1 then
			LockByPk
			(
				isbPARECODI,
				rcData
			);
		end if;


		delete
		from LDC_PARAREPE
		where
       		PARECODI=isbPARECODI;
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
		rcError  styLDC_PARAREPE;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_PARAREPE
		where
			rowid = iriRowID
		returning
			PARECODI
		into
			rcError.PARECODI;
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
		iotbLDC_PARAREPE in out nocopy tytbLDC_PARAREPE,
		inuLock in number default 1
	)
	IS
	/**************************************************************************
	  Proceso     : delRecords
	  Autor       : horbath
	  Fecha       : 2020-01-22
	  Ticket      : 176
	  Descripcion : elimina registro en tabla LDC_PARAREPE por registros

	  Parametros Entrada
       iotbLDC_PARAREPE  tabla de registros  LDC_PARAREPE
	   inuLock   bloquea registro si o no
	  Parametros de salida


	  HISTORIA DE MODIFICACIONES
	  FECHA        AUTOR       DESCRIPCION
	***************************************************************************/
		blUseRowID boolean;
		rcAux styLDC_PARAREPE;
	BEGIN
		FillRecordOfTables(iotbLDC_PARAREPE, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_PARAREPE.first .. iotbLDC_PARAREPE.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_PARAREPE.first .. iotbLDC_PARAREPE.last
				delete
				from LDC_PARAREPE
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_PARAREPE.first .. iotbLDC_PARAREPE.last loop
					LockByPk
					(
						rcRecOfTab.PARECODI(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_PARAREPE.first .. iotbLDC_PARAREPE.last
				delete
				from LDC_PARAREPE
				where
		         	PARECODI = rcRecOfTab.PARECODI(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_PARAREPE in styLDC_PARAREPE,
		inuLock in number default 0
	)
	IS
	/**************************************************************************
	  Proceso     : updRecord
	  Autor       : horbath
	  Fecha       : 2020-01-22
	  Ticket      : 176
	  Descripcion : actualiza  registro en tabla LDC_PARAREPE

	  Parametros Entrada
       ircLDC_PARAREPE  tabla de registros  LDC_PARAREPE
	   inuLock   bloquea registro si o no
	  Parametros de salida


	  HISTORIA DE MODIFICACIONES
	  FECHA        AUTOR       DESCRIPCION
	***************************************************************************/
		sbPARECODI	LDC_PARAREPE.PARECODI%type;
	BEGIN
		if ircLDC_PARAREPE.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_PARAREPE.rowid,rcData);
			end if;
			update LDC_PARAREPE
			set
				PARADESC = ircLDC_PARAREPE.PARADESC,
				PAREVANU = ircLDC_PARAREPE.PAREVANU,
				PARAVAST = ircLDC_PARAREPE.PARAVAST
			where
				rowid = ircLDC_PARAREPE.rowid
			returning
				PARECODI
			into
				sbPARECODI;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_PARAREPE.PARECODI,
					rcData
				);
			end if;

			update LDC_PARAREPE
			set
				PARADESC = ircLDC_PARAREPE.PARADESC,
				PAREVANU = ircLDC_PARAREPE.PAREVANU,
				PARAVAST = ircLDC_PARAREPE.PARAVAST
			where
				PARECODI = ircLDC_PARAREPE.PARECODI
			returning
				PARECODI
			into
				sbPARECODI;
		end if;
		if
			sbPARECODI is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_PARAREPE));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_PARAREPE in out nocopy tytbLDC_PARAREPE,
		inuLock in number default 1
	)
	IS
	/**************************************************************************
	  Proceso     : updRecords
	  Autor       : horbath
	  Fecha       : 2020-01-22
	  Ticket      : 176
	  Descripcion : actualiza  registros en tabla LDC_PARAREPE

	  Parametros Entrada
       iotbLDC_PARAREPE  tabla de registros  LDC_PARAREPE
	   inuLock   bloquea registro si o no
	  Parametros de salida


	  HISTORIA DE MODIFICACIONES
	  FECHA        AUTOR       DESCRIPCION
	***************************************************************************/
		blUseRowID boolean;
		rcAux styLDC_PARAREPE;
	BEGIN
		FillRecordOfTables(iotbLDC_PARAREPE,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_PARAREPE.first .. iotbLDC_PARAREPE.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_PARAREPE.first .. iotbLDC_PARAREPE.last
				update LDC_PARAREPE
				set
					PARADESC = rcRecOfTab.PARADESC(n),
					PAREVANU = rcRecOfTab.PAREVANU(n),
					PARAVAST = rcRecOfTab.PARAVAST(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_PARAREPE.first .. iotbLDC_PARAREPE.last loop
					LockByPk
					(
						rcRecOfTab.PARECODI(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_PARAREPE.first .. iotbLDC_PARAREPE.last
				update LDC_PARAREPE
				SET
					PARADESC = rcRecOfTab.PARADESC(n),
					PAREVANU = rcRecOfTab.PAREVANU(n),
					PARAVAST = rcRecOfTab.PARAVAST(n)
				where
					PARECODI = rcRecOfTab.PARECODI(n)
;
		end if;
	END;
	PROCEDURE updPARADESC
	(
		isbPARECODI in LDC_PARAREPE.PARECODI%type,
		isbPARADESC$ in LDC_PARAREPE.PARADESC%type,
		inuLock in number default 0
	)
	IS
	/**************************************************************************
	  Proceso     : updPARADESC
	  Autor       : horbath
	  Fecha       : 2020-01-22
	  Ticket      : 176
	  Descripcion : actualiza  registros en tabla LDC_PARAREPE

	  Parametros Entrada
       isbPARECODI   codigo del parametro
	   isbPARADESC$   descripcion
	   inuLock  bloqueo 1 no 0
	  Parametros de salida


	  HISTORIA DE MODIFICACIONES
	  FECHA        AUTOR       DESCRIPCION
	***************************************************************************/
		rcError styLDC_PARAREPE;
	BEGIN
		rcError.PARECODI := isbPARECODI;
		if inuLock=1 then
			LockByPk
			(
				isbPARECODI,
				rcData
			);
		end if;

		update LDC_PARAREPE
		set
			PARADESC = isbPARADESC$
		where
			PARECODI = isbPARECODI;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PARADESC:= isbPARADESC$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPAREVANU
	(
		isbPARECODI in LDC_PARAREPE.PARECODI%type,
		inuPAREVANU$ in LDC_PARAREPE.PAREVANU%type,
		inuLock in number default 0
	)
	IS
	/**************************************************************************
	  Proceso     : updPAREVANU
	  Autor       : horbath
	  Fecha       : 2020-01-22
	  Ticket      : 176
	  Descripcion : actualiza  valor numerico en la tabla LDC_PARAREPE

	  Parametros Entrada
       isbPARECODI   codigo del parametro
	   inuPAREVANU$   valor numerico
	   inuLock  bloqueo 1 no 0
	  Parametros de salida


	  HISTORIA DE MODIFICACIONES
	  FECHA        AUTOR       DESCRIPCION
	***************************************************************************/
		rcError styLDC_PARAREPE;
	BEGIN
		rcError.PARECODI := isbPARECODI;
		if inuLock=1 then
			LockByPk
			(
				isbPARECODI,
				rcData
			);
		end if;

		update LDC_PARAREPE
		set
			PAREVANU = inuPAREVANU$
		where
			PARECODI = isbPARECODI;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PAREVANU:= inuPAREVANU$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPARAVAST
	(
		isbPARECODI in LDC_PARAREPE.PARECODI%type,
		isbPARAVAST$ in LDC_PARAREPE.PARAVAST%type,
		inuLock in number default 0
	)
	IS
	/**************************************************************************
	  Proceso     : updPARAVAST
	  Autor       : horbath
	  Fecha       : 2020-01-22
	  Ticket      : 176
	  Descripcion : actualiza valor cadena en tabla LDC_PARAREPE

	  Parametros Entrada
       isbPARECODI   codigo del parametro
	   isbPARAVAST$   descripcion
	   inuLock  bloqueo 1 no 0
	  Parametros de salida


	  HISTORIA DE MODIFICACIONES
	  FECHA        AUTOR       DESCRIPCION
	***************************************************************************/
		rcError styLDC_PARAREPE;
	BEGIN
		rcError.PARECODI := isbPARECODI;
		if inuLock=1 then
			LockByPk
			(
				isbPARECODI,
				rcData
			);
		end if;

		update LDC_PARAREPE
		set
			PARAVAST = isbPARAVAST$
		where
			PARECODI = isbPARECODI;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PARAVAST:= isbPARAVAST$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fsbGetPARECODI
	(
		isbPARECODI in LDC_PARAREPE.PARECODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PARAREPE.PARECODI%type
	IS
	/**************************************************************************
	  Proceso     : fsbGetPARECODI
	  Autor       : horbath
	  Fecha       : 2020-01-22
	  Ticket      : 176
	  Descripcion : retorna codigo del parametro

	  Parametros Entrada
       isbPARECODI   codigo del parametro
	   inuRaiseError   error

	  Parametros de salida


	  HISTORIA DE MODIFICACIONES
	  FECHA        AUTOR       DESCRIPCION
	***************************************************************************/
		rcError styLDC_PARAREPE;
	BEGIN

		rcError.PARECODI := isbPARECODI;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		isbPARECODI
			 )
		then
			 return(rcData.PARECODI);
		end if;
		Load
		(
		 		isbPARECODI
		);
		return(rcData.PARECODI);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetPARADESC
	(
		isbPARECODI in LDC_PARAREPE.PARECODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PARAREPE.PARADESC%type
	IS
	/**************************************************************************
	  Proceso     : fsbGetPARADESC
	  Autor       : horbath
	  Fecha       : 2020-01-22
	  Ticket      : 176
	  Descripcion : retorna descripcion del parametro

	  Parametros Entrada
       isbPARECODI   codigo del parametro
	   inuRaiseError   error

	  Parametros de salida


	  HISTORIA DE MODIFICACIONES
	  FECHA        AUTOR       DESCRIPCION
	***************************************************************************/
		rcError styLDC_PARAREPE;
	BEGIN

		rcError.PARECODI := isbPARECODI;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		isbPARECODI
			 )
		then
			 return(rcData.PARADESC);
		end if;
		Load
		(
		 		isbPARECODI
		);
		return(rcData.PARADESC);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetPAREVANU
	(
		isbPARECODI in LDC_PARAREPE.PARECODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PARAREPE.PAREVANU%type
	IS
	/**************************************************************************
	  Proceso     : fnuGetPAREVANU
	  Autor       : horbath
	  Fecha       : 2020-01-22
	  Ticket      : 176
	  Descripcion : retorna valor numerico del parametro

	  Parametros Entrada
       isbPARECODI   codigo del parametro
	   inuRaiseError   error

	  Parametros de salida


	  HISTORIA DE MODIFICACIONES
	  FECHA        AUTOR       DESCRIPCION
	***************************************************************************/
		rcError styLDC_PARAREPE;
	BEGIN

		rcError.PARECODI := isbPARECODI;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		isbPARECODI
			 )
		then
			 return(rcData.PAREVANU);
		end if;
		Load
		(
		 		isbPARECODI
		);
		return(rcData.PAREVANU);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetPARAVAST
	(
		isbPARECODI in LDC_PARAREPE.PARECODI%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_PARAREPE.PARAVAST%type
	IS
	/**************************************************************************
	  Proceso     : fsbGetPARAVAST
	  Autor       : horbath
	  Fecha       : 2020-01-22
	  Ticket      : 176
	  Descripcion : retorna valor cadena del parametro

	  Parametros Entrada
       isbPARECODI   codigo del parametro
	   inuRaiseError   error

	  Parametros de salida


	  HISTORIA DE MODIFICACIONES
	  FECHA        AUTOR       DESCRIPCION
	***************************************************************************/
		rcError styLDC_PARAREPE;
	BEGIN

		rcError.PARECODI := isbPARECODI;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		isbPARECODI
			 )
		then
			 return(rcData.PARAVAST);
		end if;
		Load
		(
		 		isbPARECODI
		);
		return(rcData.PARAVAST);
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
	/**************************************************************************
	  Proceso     : SetUseCache
	  Autor       : horbath
	  Fecha       : 2020-01-22
	  Ticket      : 176
	  Descripcion : guarda o no cache

	  Parametros Entrada
       iblUseCache usa cache

	  Parametros de salida


	  HISTORIA DE MODIFICACIONES
	  FECHA        AUTOR       DESCRIPCION
	***************************************************************************/
	Begin
	    blDAO_USE_CACHE := iblUseCache;
	END;

begin
    GetDAO_USE_CACHE;
end DALDC_PARAREPE;
/
PROMPT Otorgando permisos de ejecucion a DALDC_PARAREPE
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_PARAREPE', 'ADM_PERSON');
END;
/