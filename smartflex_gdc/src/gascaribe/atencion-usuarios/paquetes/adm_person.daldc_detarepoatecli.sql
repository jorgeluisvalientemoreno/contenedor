CREATE OR REPLACE PACKAGE adm_person.DALDC_DETAREPOATECLI
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
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type
  )
  IS
    SELECT LDC_DETAREPOATECLI.*,LDC_DETAREPOATECLI.rowid
    FROM LDC_DETAREPOATECLI
    WHERE
        DETAREPOATECLI_ID = inuDETAREPOATECLI_ID;


  /* Cursor general para acceso por RowId */
  CURSOR cuRecordByRowId
  (
    irirowid in varchar2
  )
  IS
        SELECT LDC_DETAREPOATECLI.*,LDC_DETAREPOATECLI.rowid
    FROM LDC_DETAREPOATECLI
    WHERE
      rowId = irirowid;


  /* Subtipos */
  subtype styLDC_DETAREPOATECLI  is  cuRecord%rowtype;
  type    tyRefCursor is  REF CURSOR;

  /*Tipos*/
  type tytbLDC_DETAREPOATECLI is table of styLDC_DETAREPOATECLI index by binary_integer;
  type tyrfRecords is ref cursor return styLDC_DETAREPOATECLI;

  /* Tipos referenciando al registro */
  type tytbFECHA_NOTIFICACION is table of LDC_DETAREPOATECLI.FECHA_NOTIFICACION%type index by binary_integer;
  type tytbTIPO_NOTIFICACION is table of LDC_DETAREPOATECLI.TIPO_NOTIFICACION%type index by binary_integer;
  type tytbFECHA_TRASLADO is table of LDC_DETAREPOATECLI.FECHA_TRASLADO%type index by binary_integer;
  type tytbFLAG_REPORTA is table of LDC_DETAREPOATECLI.FLAG_REPORTA%type index by binary_integer;
  type tytbDETAREPOATECLI_ID is table of LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type index by binary_integer;
  type tytbATECLIREPO_ID is table of LDC_DETAREPOATECLI.ATECLIREPO_ID%type index by binary_integer;
  type tytbCODIGO_DANE is table of LDC_DETAREPOATECLI.CODIGO_DANE%type index by binary_integer;
  type tytbSERVICIO is table of LDC_DETAREPOATECLI.SERVICIO%type index by binary_integer;
  type tytbRADICADO_ING is table of LDC_DETAREPOATECLI.RADICADO_ING%type index by binary_integer;
  type tytbFECHA_REGISTRO is table of LDC_DETAREPOATECLI.FECHA_REGISTRO%type index by binary_integer;
  type tytbTIPO_TRAMITE is table of LDC_DETAREPOATECLI.TIPO_TRAMITE%type index by binary_integer;
  type tytbCAUSAL is table of LDC_DETAREPOATECLI.CAUSAL%type index by binary_integer;
  type tytbNUMERO_IDENTIFICACION is table of LDC_DETAREPOATECLI.NUMERO_IDENTIFICACION%type index by binary_integer;
  type tytbNUMERO_FACTURA is table of LDC_DETAREPOATECLI.NUMERO_FACTURA%type index by binary_integer;
  type tytbTIPO_RESPUESTA is table of LDC_DETAREPOATECLI.TIPO_RESPUESTA%type index by binary_integer;
  type tytbFECHA_RESPUESTA is table of LDC_DETAREPOATECLI.FECHA_RESPUESTA%type index by binary_integer;
  type tytbRADICADO_RES is table of LDC_DETAREPOATECLI.RADICADO_RES%type index by binary_integer;
  type tytbrowid is table of rowid index by binary_integer;

  type tyrcLDC_DETAREPOATECLI is record
  (
    FECHA_NOTIFICACION   tytbFECHA_NOTIFICACION,
    TIPO_NOTIFICACION   tytbTIPO_NOTIFICACION,
    FECHA_TRASLADO   tytbFECHA_TRASLADO,
    FLAG_REPORTA   tytbFLAG_REPORTA,
    DETAREPOATECLI_ID   tytbDETAREPOATECLI_ID,
    ATECLIREPO_ID   tytbATECLIREPO_ID,
    CODIGO_DANE   tytbCODIGO_DANE,
    SERVICIO   tytbSERVICIO,
    RADICADO_ING   tytbRADICADO_ING,
    FECHA_REGISTRO   tytbFECHA_REGISTRO,
    TIPO_TRAMITE   tytbTIPO_TRAMITE,
    CAUSAL   tytbCAUSAL,
    NUMERO_IDENTIFICACION   tytbNUMERO_IDENTIFICACION,
    NUMERO_FACTURA   tytbNUMERO_FACTURA,
    TIPO_RESPUESTA   tytbTIPO_RESPUESTA,
    FECHA_RESPUESTA   tytbFECHA_RESPUESTA,
    RADICADO_RES   tytbRADICADO_RES,
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
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type
  )
  RETURN boolean;

  PROCEDURE AccKey
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type
  );

  PROCEDURE AccKeyByRowId
  (
    iriRowID    in rowid
  );

  PROCEDURE ValDuplicate
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type
  );

  PROCEDURE getRecord
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    orcRecord out nocopy styLDC_DETAREPOATECLI
  );

  FUNCTION frcGetRcData
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type
  )
  RETURN styLDC_DETAREPOATECLI;

  FUNCTION frcGetRcData
  RETURN styLDC_DETAREPOATECLI;

  FUNCTION frcGetRecord
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type
  )
  RETURN styLDC_DETAREPOATECLI;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLDC_DETAREPOATECLI
  );

  FUNCTION frfGetRecords
  (
    isbCriteria in varchar2 default null,
    iblLock in boolean default false
  )
  RETURN tyRefCursor;

  PROCEDURE insRecord
  (
    ircLDC_DETAREPOATECLI in styLDC_DETAREPOATECLI
  );

  PROCEDURE insRecord
  (
    ircLDC_DETAREPOATECLI in styLDC_DETAREPOATECLI,
        orirowid   out varchar2
  );

  PROCEDURE insRecords
  (
    iotbLDC_DETAREPOATECLI in out nocopy tytbLDC_DETAREPOATECLI
  );

  PROCEDURE delRecord
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    inuLock in number default 1
  );

  PROCEDURE delByRowID
  (
    iriRowID    in rowid,
    inuLock in number default 1
  );

  PROCEDURE delRecords
  (
    iotbLDC_DETAREPOATECLI in out nocopy tytbLDC_DETAREPOATECLI,
    inuLock in number default 1
  );

  PROCEDURE updRecord
  (
    ircLDC_DETAREPOATECLI in styLDC_DETAREPOATECLI,
    inuLock in number default 0
  );

  PROCEDURE updRecords
  (
    iotbLDC_DETAREPOATECLI in out nocopy tytbLDC_DETAREPOATECLI,
    inuLock in number default 1
  );

  PROCEDURE updFECHA_NOTIFICACION
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    isbFECHA_NOTIFICACION$ in LDC_DETAREPOATECLI.FECHA_NOTIFICACION%type,
    inuLock in number default 0
  );

  PROCEDURE updTIPO_NOTIFICACION
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    isbTIPO_NOTIFICACION$ in LDC_DETAREPOATECLI.TIPO_NOTIFICACION%type,
    inuLock in number default 0
  );

  PROCEDURE updFECHA_TRASLADO
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    isbFECHA_TRASLADO$ in LDC_DETAREPOATECLI.FECHA_TRASLADO%type,
    inuLock in number default 0
  );

  PROCEDURE updFLAG_REPORTA
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    isbFLAG_REPORTA$ in LDC_DETAREPOATECLI.FLAG_REPORTA%type,
    inuLock in number default 0
  );

  PROCEDURE updATECLIREPO_ID
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    inuATECLIREPO_ID$ in LDC_DETAREPOATECLI.ATECLIREPO_ID%type,
    inuLock in number default 0
  );

  PROCEDURE updCODIGO_DANE
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    isbCODIGO_DANE$ in LDC_DETAREPOATECLI.CODIGO_DANE%type,
    inuLock in number default 0
  );

  PROCEDURE updSERVICIO
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    isbSERVICIO$ in LDC_DETAREPOATECLI.SERVICIO%type,
    inuLock in number default 0
  );

  PROCEDURE updRADICADO_ING
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    isbRADICADO_ING$ in LDC_DETAREPOATECLI.RADICADO_ING%type,
    inuLock in number default 0
  );

  PROCEDURE updFECHA_REGISTRO
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    isbFECHA_REGISTRO$ in LDC_DETAREPOATECLI.FECHA_REGISTRO%type,
    inuLock in number default 0
  );

  PROCEDURE updTIPO_TRAMITE
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    isbTIPO_TRAMITE$ in LDC_DETAREPOATECLI.TIPO_TRAMITE%type,
    inuLock in number default 0
  );

  PROCEDURE updCAUSAL
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    isbCAUSAL$ in LDC_DETAREPOATECLI.CAUSAL%type,
    inuLock in number default 0
  );

  PROCEDURE updNUMERO_IDENTIFICACION
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    isbNUMERO_IDENTIFICACION$ in LDC_DETAREPOATECLI.NUMERO_IDENTIFICACION%type,
    inuLock in number default 0
  );

  PROCEDURE updNUMERO_FACTURA
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    isbNUMERO_FACTURA$ in LDC_DETAREPOATECLI.NUMERO_FACTURA%type,
    inuLock in number default 0
  );

  PROCEDURE updTIPO_RESPUESTA
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    isbTIPO_RESPUESTA$ in LDC_DETAREPOATECLI.TIPO_RESPUESTA%type,
    inuLock in number default 0
  );

  PROCEDURE updFECHA_RESPUESTA
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    isbFECHA_RESPUESTA$ in LDC_DETAREPOATECLI.FECHA_RESPUESTA%type,
    inuLock in number default 0
  );

  PROCEDURE updRADICADO_RES
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    isbRADICADO_RES$ in LDC_DETAREPOATECLI.RADICADO_RES%type,
    inuLock in number default 0
  );

  FUNCTION fsbGetFECHA_NOTIFICACION
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    inuRaiseError in number default 1
  )
  RETURN LDC_DETAREPOATECLI.FECHA_NOTIFICACION%type;

  FUNCTION fsbGetTIPO_NOTIFICACION
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    inuRaiseError in number default 1
  )
  RETURN LDC_DETAREPOATECLI.TIPO_NOTIFICACION%type;

  FUNCTION fsbGetFECHA_TRASLADO
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    inuRaiseError in number default 1
  )
  RETURN LDC_DETAREPOATECLI.FECHA_TRASLADO%type;

  FUNCTION fsbGetFLAG_REPORTA
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    inuRaiseError in number default 1
  )
  RETURN LDC_DETAREPOATECLI.FLAG_REPORTA%type;

  FUNCTION fnuGetDETAREPOATECLI_ID
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    inuRaiseError in number default 1
  )
  RETURN LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type;

  FUNCTION fnuGetATECLIREPO_ID
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    inuRaiseError in number default 1
  )
  RETURN LDC_DETAREPOATECLI.ATECLIREPO_ID%type;

  FUNCTION fsbGetCODIGO_DANE
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    inuRaiseError in number default 1
  )
  RETURN LDC_DETAREPOATECLI.CODIGO_DANE%type;

  FUNCTION fsbGetSERVICIO
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    inuRaiseError in number default 1
  )
  RETURN LDC_DETAREPOATECLI.SERVICIO%type;

  FUNCTION fsbGetRADICADO_ING
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    inuRaiseError in number default 1
  )
  RETURN LDC_DETAREPOATECLI.RADICADO_ING%type;

  FUNCTION fsbGetFECHA_REGISTRO
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    inuRaiseError in number default 1
  )
  RETURN LDC_DETAREPOATECLI.FECHA_REGISTRO%type;

  FUNCTION fsbGetTIPO_TRAMITE
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    inuRaiseError in number default 1
  )
  RETURN LDC_DETAREPOATECLI.TIPO_TRAMITE%type;

  FUNCTION fsbGetCAUSAL
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    inuRaiseError in number default 1
  )
  RETURN LDC_DETAREPOATECLI.CAUSAL%type;

  FUNCTION fsbGetNUMERO_IDENTIFICACION
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    inuRaiseError in number default 1
  )
  RETURN LDC_DETAREPOATECLI.NUMERO_IDENTIFICACION%type;

  FUNCTION fsbGetNUMERO_FACTURA
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    inuRaiseError in number default 1
  )
  RETURN LDC_DETAREPOATECLI.NUMERO_FACTURA%type;

  FUNCTION fsbGetTIPO_RESPUESTA
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    inuRaiseError in number default 1
  )
  RETURN LDC_DETAREPOATECLI.TIPO_RESPUESTA%type;

  FUNCTION fsbGetFECHA_RESPUESTA
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    inuRaiseError in number default 1
  )
  RETURN LDC_DETAREPOATECLI.FECHA_RESPUESTA%type;

  FUNCTION fsbGetRADICADO_RES
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    inuRaiseError in number default 1
  )
  RETURN LDC_DETAREPOATECLI.RADICADO_RES%type;


  PROCEDURE LockByPk
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    orcLDC_DETAREPOATECLI  out styLDC_DETAREPOATECLI
  );

  PROCEDURE LockByRowID
  (
    irirowid    in  varchar2,
    orcLDC_DETAREPOATECLI  out styLDC_DETAREPOATECLI
  );

  PROCEDURE SetUseCache
  (
    iblUseCache    in  boolean
  );
END DALDC_DETAREPOATECLI;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALDC_DETAREPOATECLI
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_DETAREPOATECLI';
   cnuGeEntityId constant varchar2(30) := 8751; -- Id de Ge_entity

  /* Cursor para bloqueo de un registro por llave primaria */
  CURSOR cuLockRcByPk
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type
  )
  IS
    SELECT LDC_DETAREPOATECLI.*,LDC_DETAREPOATECLI.rowid
    FROM LDC_DETAREPOATECLI
    WHERE  DETAREPOATECLI_ID = inuDETAREPOATECLI_ID
    FOR UPDATE NOWAIT;

  /* Cursor para bloqueo de un registro por rowid */
  CURSOR cuLockRcbyRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LDC_DETAREPOATECLI.*,LDC_DETAREPOATECLI.rowid
    FROM LDC_DETAREPOATECLI
    WHERE
      rowId = irirowid
    FOR UPDATE NOWAIT;


  /*Tipos*/
  type tyrfLDC_DETAREPOATECLI is ref cursor;

  /*Variables Globales*/
  rcRecOfTab tyrcLDC_DETAREPOATECLI;

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
  FUNCTION fsbPrimaryKey( rcI in styLDC_DETAREPOATECLI default rcData )
  return varchar2
  IS
    sbPk varchar2(500);
  BEGIN
    sbPk:='[';
    sbPk:=sbPk||ut_convert.fsbToChar(rcI.DETAREPOATECLI_ID);
    sbPk:=sbPk||']';
    return sbPk;
  END;
  PROCEDURE LockByPk
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    orcLDC_DETAREPOATECLI  out styLDC_DETAREPOATECLI
  )
  IS
    rcError styLDC_DETAREPOATECLI;
  BEGIN
    rcError.DETAREPOATECLI_ID := inuDETAREPOATECLI_ID;

    Open cuLockRcByPk
    (
      inuDETAREPOATECLI_ID
    );

    fetch cuLockRcByPk into orcLDC_DETAREPOATECLI;
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
    orcLDC_DETAREPOATECLI  out styLDC_DETAREPOATECLI
  )
  IS
  BEGIN
    Open cuLockRcbyRowId
    (
      irirowid
    );

    fetch cuLockRcbyRowId into orcLDC_DETAREPOATECLI;
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
    itbLDC_DETAREPOATECLI  in out nocopy tytbLDC_DETAREPOATECLI
  )
  IS
  BEGIN
      rcRecOfTab.FECHA_NOTIFICACION.delete;
      rcRecOfTab.TIPO_NOTIFICACION.delete;
      rcRecOfTab.FECHA_TRASLADO.delete;
      rcRecOfTab.FLAG_REPORTA.delete;
      rcRecOfTab.DETAREPOATECLI_ID.delete;
      rcRecOfTab.ATECLIREPO_ID.delete;
      rcRecOfTab.CODIGO_DANE.delete;
      rcRecOfTab.SERVICIO.delete;
      rcRecOfTab.RADICADO_ING.delete;
      rcRecOfTab.FECHA_REGISTRO.delete;
      rcRecOfTab.TIPO_TRAMITE.delete;
      rcRecOfTab.CAUSAL.delete;
      rcRecOfTab.NUMERO_IDENTIFICACION.delete;
      rcRecOfTab.NUMERO_FACTURA.delete;
      rcRecOfTab.TIPO_RESPUESTA.delete;
      rcRecOfTab.FECHA_RESPUESTA.delete;
      rcRecOfTab.RADICADO_RES.delete;
      rcRecOfTab.row_id.delete;
  END;
  PROCEDURE FillRecordOfTables
  (
    itbLDC_DETAREPOATECLI  in out nocopy tytbLDC_DETAREPOATECLI,
    oblUseRowId out boolean
  )
  IS
  BEGIN
    DelRecordOfTables(itbLDC_DETAREPOATECLI);

    for n in itbLDC_DETAREPOATECLI.first .. itbLDC_DETAREPOATECLI.last loop
      rcRecOfTab.FECHA_NOTIFICACION(n) := itbLDC_DETAREPOATECLI(n).FECHA_NOTIFICACION;
      rcRecOfTab.TIPO_NOTIFICACION(n) := itbLDC_DETAREPOATECLI(n).TIPO_NOTIFICACION;
      rcRecOfTab.FECHA_TRASLADO(n) := itbLDC_DETAREPOATECLI(n).FECHA_TRASLADO;
      rcRecOfTab.FLAG_REPORTA(n) := itbLDC_DETAREPOATECLI(n).FLAG_REPORTA;
      rcRecOfTab.DETAREPOATECLI_ID(n) := itbLDC_DETAREPOATECLI(n).DETAREPOATECLI_ID;
      rcRecOfTab.ATECLIREPO_ID(n) := itbLDC_DETAREPOATECLI(n).ATECLIREPO_ID;
      rcRecOfTab.CODIGO_DANE(n) := itbLDC_DETAREPOATECLI(n).CODIGO_DANE;
      rcRecOfTab.SERVICIO(n) := itbLDC_DETAREPOATECLI(n).SERVICIO;
      rcRecOfTab.RADICADO_ING(n) := itbLDC_DETAREPOATECLI(n).RADICADO_ING;
      rcRecOfTab.FECHA_REGISTRO(n) := itbLDC_DETAREPOATECLI(n).FECHA_REGISTRO;
      rcRecOfTab.TIPO_TRAMITE(n) := itbLDC_DETAREPOATECLI(n).TIPO_TRAMITE;
      rcRecOfTab.CAUSAL(n) := itbLDC_DETAREPOATECLI(n).CAUSAL;
      rcRecOfTab.NUMERO_IDENTIFICACION(n) := itbLDC_DETAREPOATECLI(n).NUMERO_IDENTIFICACION;
      rcRecOfTab.NUMERO_FACTURA(n) := itbLDC_DETAREPOATECLI(n).NUMERO_FACTURA;
      rcRecOfTab.TIPO_RESPUESTA(n) := itbLDC_DETAREPOATECLI(n).TIPO_RESPUESTA;
      rcRecOfTab.FECHA_RESPUESTA(n) := itbLDC_DETAREPOATECLI(n).FECHA_RESPUESTA;
      rcRecOfTab.RADICADO_RES(n) := itbLDC_DETAREPOATECLI(n).RADICADO_RES;
      rcRecOfTab.row_id(n) := itbLDC_DETAREPOATECLI(n).rowid;

      -- Indica si el rowid es Nulo
      oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
    end loop;
  END;

  PROCEDURE Load
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type
  )
  IS
    rcRecordNull cuRecord%rowtype;
  BEGIN
    if cuRecord%isopen then
      close cuRecord;
    end if;
    open cuRecord
    (
      inuDETAREPOATECLI_ID
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
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type
  )
  RETURN boolean
  IS
  BEGIN
    if (
      inuDETAREPOATECLI_ID = rcData.DETAREPOATECLI_ID
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
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type
  )
  RETURN boolean
  IS
  BEGIN
    Load
    (
      inuDETAREPOATECLI_ID
    );
    return(TRUE);
  EXCEPTION
    when no_data_found then
      return(FALSE);
  END;
  PROCEDURE AccKey
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type
  )
  IS
    rcError styLDC_DETAREPOATECLI;
  BEGIN   rcError.DETAREPOATECLI_ID:=inuDETAREPOATECLI_ID;

    Load
    (
      inuDETAREPOATECLI_ID
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
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type
  )
  IS
  BEGIN
    Load
    (
      inuDETAREPOATECLI_ID
    );
    Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
    raise ex.CONTROLLED_ERROR;

  EXCEPTION
    when no_data_found then
      null;
  END;
  PROCEDURE getRecord
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    orcRecord out nocopy styLDC_DETAREPOATECLI
  )
  IS
    rcError styLDC_DETAREPOATECLI;
  BEGIN   rcError.DETAREPOATECLI_ID:=inuDETAREPOATECLI_ID;

    Load
    (
      inuDETAREPOATECLI_ID
    );
    orcRecord := rcData;
  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;
  FUNCTION frcGetRecord
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type
  )
  RETURN styLDC_DETAREPOATECLI
  IS
    rcError styLDC_DETAREPOATECLI;
  BEGIN
    rcError.DETAREPOATECLI_ID:=inuDETAREPOATECLI_ID;

    Load
    (
      inuDETAREPOATECLI_ID
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;
  FUNCTION frcGetRcData
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type
  )
  RETURN styLDC_DETAREPOATECLI
  IS
    rcError styLDC_DETAREPOATECLI;
  BEGIN
    rcError.DETAREPOATECLI_ID:=inuDETAREPOATECLI_ID;
        -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
      inuDETAREPOATECLI_ID
       )
    then
       return(rcData);
    end if;
    Load
    (
      inuDETAREPOATECLI_ID
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  RETURN styLDC_DETAREPOATECLI
  IS
  BEGIN
    return(rcData);
  END;
  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLDC_DETAREPOATECLI
  )
  IS
    rfLDC_DETAREPOATECLI tyrfLDC_DETAREPOATECLI;
    n number(4) := 1;
    sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_DETAREPOATECLI.*, LDC_DETAREPOATECLI.rowid FROM LDC_DETAREPOATECLI';
    nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
  BEGIN
    otbResult.delete;
    if isbQuery is not NULL and length(isbQuery) > 0 then
      sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
    end if;

    open rfLDC_DETAREPOATECLI for sbFullQuery;

    fetch rfLDC_DETAREPOATECLI bulk collect INTO otbResult;

    close rfLDC_DETAREPOATECLI;
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
    sbSQL VARCHAR2 (32000) := 'select LDC_DETAREPOATECLI.*, LDC_DETAREPOATECLI.rowid FROM LDC_DETAREPOATECLI';
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
    ircLDC_DETAREPOATECLI in styLDC_DETAREPOATECLI
  )
  IS
    rirowid varchar2(200);
  BEGIN
    insRecord(ircLDC_DETAREPOATECLI,rirowid);
  END;
  PROCEDURE insRecord
  (
    ircLDC_DETAREPOATECLI in styLDC_DETAREPOATECLI,
        orirowid   out varchar2
  )
  IS
  BEGIN
    if ircLDC_DETAREPOATECLI.DETAREPOATECLI_ID is NULL then
      Errors.SetError(cnuINS_PK_NULL,
                      fsbGetMessageDescription||'|DETAREPOATECLI_ID');
      raise ex.controlled_error;
    end if;

    insert into LDC_DETAREPOATECLI
    (
      FECHA_NOTIFICACION,
      TIPO_NOTIFICACION,
      FECHA_TRASLADO,
      FLAG_REPORTA,
      DETAREPOATECLI_ID,
      ATECLIREPO_ID,
      CODIGO_DANE,
      SERVICIO,
      RADICADO_ING,
      FECHA_REGISTRO,
      TIPO_TRAMITE,
      CAUSAL,
      NUMERO_IDENTIFICACION,
      NUMERO_FACTURA,
      TIPO_RESPUESTA,
      FECHA_RESPUESTA,
      RADICADO_RES,
      NOTIFICADO,
      TIPO_SOLICITUD,
      ESTADO_SOLICITUD,
      MEDIO_RECEPCION,
      CAUSAL_ID,
      RESPUESTA_AT,
      TIPO_RESPUESTA_SOL,
      FECHA_SOLICITUD,
      PACKAGE_ID,
      tipo_respuesta_osf,
      causal_lega_ot,
      dane_dpto,
      dane_municipio,
      dane_poblacion,
      detalle_causal,
      fecha_fin_ot_soli,
      fecha_ejec_tt_re,
      tipo_unidad_oper,
      medio_uso,
      codigo_homologacion,
      dias_registro,
      TIPO_REG_REPORTE,
      estado_iteraccion,
      iteraccion,
      atencion_inmediata,
      carta,
      val_ferad_feresp,
      val_feresp_fenot,
      deleysiono,
      unida_oper
    )
    values
    (
      ircLDC_DETAREPOATECLI.FECHA_NOTIFICACION,
      ircLDC_DETAREPOATECLI.TIPO_NOTIFICACION,
      ircLDC_DETAREPOATECLI.FECHA_TRASLADO,
      ircLDC_DETAREPOATECLI.FLAG_REPORTA,
      ircLDC_DETAREPOATECLI.DETAREPOATECLI_ID,
      ircLDC_DETAREPOATECLI.ATECLIREPO_ID,
      ircLDC_DETAREPOATECLI.CODIGO_DANE,
      ircLDC_DETAREPOATECLI.SERVICIO,
      ircLDC_DETAREPOATECLI.RADICADO_ING,
      ircLDC_DETAREPOATECLI.FECHA_REGISTRO,
      ircLDC_DETAREPOATECLI.TIPO_TRAMITE,
      ircLDC_DETAREPOATECLI.CAUSAL,
      ircLDC_DETAREPOATECLI.NUMERO_IDENTIFICACION,
      ircLDC_DETAREPOATECLI.NUMERO_FACTURA,
      ircLDC_DETAREPOATECLI.TIPO_RESPUESTA,
      ircLDC_DETAREPOATECLI.FECHA_RESPUESTA,
      ircLDC_DETAREPOATECLI.RADICADO_RES,
      ircLDC_DETAREPOATECLI.Notificado,
      ircLDC_DETAREPOATECLI.TIPO_SOLICITUD,
      ircLDC_DETAREPOATECLI.ESTADO_SOLICITUD,
      ircLDC_DETAREPOATECLI.MEDIO_RECEPCION,
      ircLDC_DETAREPOATECLI.CAUSAL_ID,
      ircLDC_DETAREPOATECLI.RESPUESTA_AT,
      ircLDC_DETAREPOATECLI.TIPO_RESPUESTA_SOL,
      ircLDC_DETAREPOATECLI.FECHA_SOLICITUD,
      ircLDC_DETAREPOATECLI.PACKAGE_ID,
      ircLDC_DETAREPOATECLI.tipo_respuesta_osf,
      ircLDC_DETAREPOATECLI.causal_lega_ot,
      ircLDC_DETAREPOATECLI.dane_dpto,
      ircLDC_DETAREPOATECLI.dane_municipio,
      ircLDC_DETAREPOATECLI.dane_poblacion,
      ircLDC_DETAREPOATECLI.detalle_causal,
      ircLDC_DETAREPOATECLI.fecha_fin_ot_soli,
      ircLDC_DETAREPOATECLI.fecha_ejec_tt_re,
      ircLDC_DETAREPOATECLI.tipo_unidad_oper ,
      ircLDC_DETAREPOATECLI.medio_uso,
      ircLDC_DETAREPOATECLI.codigo_homologacion,
      ircLDC_DETAREPOATECLI.DIAS_REGISTRO,
      ircLDC_DETAREPOATECLI.TIPO_REG_REPORTE,
      ircLDC_DETAREPOATECLI.estado_iteraccion,
      ircLDC_DETAREPOATECLI.iteraccion,
      ircLDC_DETAREPOATECLI.atencion_inmediata,
      ircLDC_DETAREPOATECLI.carta,
      ircLDC_DETAREPOATECLI.Val_Ferad_Feresp,
      ircLDC_DETAREPOATECLI.Val_Feresp_Fenot,
      ircLDC_DETAREPOATECLI.Deleysiono,
      ircLDC_DETAREPOATECLI.Unida_Oper
    )
            returning
      rowid
    into
      orirowid;
  EXCEPTION
    when dup_val_on_index then
      Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_DETAREPOATECLI));
      raise ex.CONTROLLED_ERROR;
  END;
  PROCEDURE insRecords
  (
    iotbLDC_DETAREPOATECLI in out nocopy tytbLDC_DETAREPOATECLI
  )
  IS
    blUseRowID boolean;
  BEGIN
    FillRecordOfTables(iotbLDC_DETAREPOATECLI,blUseRowID);
    forall n in iotbLDC_DETAREPOATECLI.first..iotbLDC_DETAREPOATECLI.last
      insert into LDC_DETAREPOATECLI
      (
        FECHA_NOTIFICACION,
        TIPO_NOTIFICACION,
        FECHA_TRASLADO,
        FLAG_REPORTA,
        DETAREPOATECLI_ID,
        ATECLIREPO_ID,
        CODIGO_DANE,
        SERVICIO,
        RADICADO_ING,
        FECHA_REGISTRO,
        TIPO_TRAMITE,
        CAUSAL,
        NUMERO_IDENTIFICACION,
        NUMERO_FACTURA,
        TIPO_RESPUESTA,
        FECHA_RESPUESTA,
        RADICADO_RES
      )
      values
      (
        rcRecOfTab.FECHA_NOTIFICACION(n),
        rcRecOfTab.TIPO_NOTIFICACION(n),
        rcRecOfTab.FECHA_TRASLADO(n),
        rcRecOfTab.FLAG_REPORTA(n),
        rcRecOfTab.DETAREPOATECLI_ID(n),
        rcRecOfTab.ATECLIREPO_ID(n),
        rcRecOfTab.CODIGO_DANE(n),
        rcRecOfTab.SERVICIO(n),
        rcRecOfTab.RADICADO_ING(n),
        rcRecOfTab.FECHA_REGISTRO(n),
        rcRecOfTab.TIPO_TRAMITE(n),
        rcRecOfTab.CAUSAL(n),
        rcRecOfTab.NUMERO_IDENTIFICACION(n),
        rcRecOfTab.NUMERO_FACTURA(n),
        rcRecOfTab.TIPO_RESPUESTA(n),
        rcRecOfTab.FECHA_RESPUESTA(n),
        rcRecOfTab.RADICADO_RES(n)
      );
  EXCEPTION
    when dup_val_on_index then
      Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
      raise ex.CONTROLLED_ERROR;
  END;
  PROCEDURE delRecord
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    inuLock in number default 1
  )
  IS
    rcError styLDC_DETAREPOATECLI;
  BEGIN
    rcError.DETAREPOATECLI_ID := inuDETAREPOATECLI_ID;

    if inuLock=1 then
      LockByPk
      (
        inuDETAREPOATECLI_ID,
        rcData
      );
    end if;


    delete
    from LDC_DETAREPOATECLI
    where
          DETAREPOATECLI_ID=inuDETAREPOATECLI_ID;
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
    rcError  styLDC_DETAREPOATECLI;
  BEGIN
    if inuLock=1 then
      LockByRowId(iriRowID,rcData);
    end if;


    delete
    from LDC_DETAREPOATECLI
    where
      rowid = iriRowID
    returning
      FECHA_NOTIFICACION
    into
      rcError.FECHA_NOTIFICACION;
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
    iotbLDC_DETAREPOATECLI in out nocopy tytbLDC_DETAREPOATECLI,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLDC_DETAREPOATECLI;
  BEGIN
    FillRecordOfTables(iotbLDC_DETAREPOATECLI, blUseRowID);
        if ( blUseRowId ) then
      if inuLock = 1 then
        for n in iotbLDC_DETAREPOATECLI.first .. iotbLDC_DETAREPOATECLI.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLDC_DETAREPOATECLI.first .. iotbLDC_DETAREPOATECLI.last
        delete
        from LDC_DETAREPOATECLI
        where
          rowid = rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLDC_DETAREPOATECLI.first .. iotbLDC_DETAREPOATECLI.last loop
          LockByPk
          (
            rcRecOfTab.DETAREPOATECLI_ID(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLDC_DETAREPOATECLI.first .. iotbLDC_DETAREPOATECLI.last
        delete
        from LDC_DETAREPOATECLI
        where
              DETAREPOATECLI_ID = rcRecOfTab.DETAREPOATECLI_ID(n);
    end if;
  EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
  END;
  PROCEDURE updRecord
  (
    ircLDC_DETAREPOATECLI in styLDC_DETAREPOATECLI,
    inuLock in number default 0
  )
  IS
    nuDETAREPOATECLI_ID LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type;
  BEGIN
    if ircLDC_DETAREPOATECLI.rowid is not null then
      if inuLock=1 then
        LockByRowId(ircLDC_DETAREPOATECLI.rowid,rcData);
      end if;
      update LDC_DETAREPOATECLI
      set
        FECHA_NOTIFICACION = ircLDC_DETAREPOATECLI.FECHA_NOTIFICACION,
        TIPO_NOTIFICACION = ircLDC_DETAREPOATECLI.TIPO_NOTIFICACION,
        FECHA_TRASLADO = ircLDC_DETAREPOATECLI.FECHA_TRASLADO,
        FLAG_REPORTA = ircLDC_DETAREPOATECLI.FLAG_REPORTA,
        ATECLIREPO_ID = ircLDC_DETAREPOATECLI.ATECLIREPO_ID,
        CODIGO_DANE = ircLDC_DETAREPOATECLI.CODIGO_DANE,
        SERVICIO = ircLDC_DETAREPOATECLI.SERVICIO,
        RADICADO_ING = ircLDC_DETAREPOATECLI.RADICADO_ING,
        FECHA_REGISTRO = ircLDC_DETAREPOATECLI.FECHA_REGISTRO,
        TIPO_TRAMITE = ircLDC_DETAREPOATECLI.TIPO_TRAMITE,
        CAUSAL = ircLDC_DETAREPOATECLI.CAUSAL,
        NUMERO_IDENTIFICACION = ircLDC_DETAREPOATECLI.NUMERO_IDENTIFICACION,
        NUMERO_FACTURA = ircLDC_DETAREPOATECLI.NUMERO_FACTURA,
        TIPO_RESPUESTA = ircLDC_DETAREPOATECLI.TIPO_RESPUESTA,
        FECHA_RESPUESTA = ircLDC_DETAREPOATECLI.FECHA_RESPUESTA,
        RADICADO_RES = ircLDC_DETAREPOATECLI.RADICADO_RES
      where
        rowid = ircLDC_DETAREPOATECLI.rowid
      returning
        DETAREPOATECLI_ID
      into
        nuDETAREPOATECLI_ID;
    else
      if inuLock=1 then
        LockByPk
        (
          ircLDC_DETAREPOATECLI.DETAREPOATECLI_ID,
          rcData
        );
      end if;

      update LDC_DETAREPOATECLI
      set
        FECHA_NOTIFICACION = ircLDC_DETAREPOATECLI.FECHA_NOTIFICACION,
        TIPO_NOTIFICACION = ircLDC_DETAREPOATECLI.TIPO_NOTIFICACION,
        FECHA_TRASLADO = ircLDC_DETAREPOATECLI.FECHA_TRASLADO,
        FLAG_REPORTA = ircLDC_DETAREPOATECLI.FLAG_REPORTA,
        ATECLIREPO_ID = ircLDC_DETAREPOATECLI.ATECLIREPO_ID,
        CODIGO_DANE = ircLDC_DETAREPOATECLI.CODIGO_DANE,
        SERVICIO = ircLDC_DETAREPOATECLI.SERVICIO,
        RADICADO_ING = ircLDC_DETAREPOATECLI.RADICADO_ING,
        FECHA_REGISTRO = ircLDC_DETAREPOATECLI.FECHA_REGISTRO,
        TIPO_TRAMITE = ircLDC_DETAREPOATECLI.TIPO_TRAMITE,
        CAUSAL = ircLDC_DETAREPOATECLI.CAUSAL,
        NUMERO_IDENTIFICACION = ircLDC_DETAREPOATECLI.NUMERO_IDENTIFICACION,
        NUMERO_FACTURA = ircLDC_DETAREPOATECLI.NUMERO_FACTURA,
        TIPO_RESPUESTA = ircLDC_DETAREPOATECLI.TIPO_RESPUESTA,
        FECHA_RESPUESTA = ircLDC_DETAREPOATECLI.FECHA_RESPUESTA,
        RADICADO_RES = ircLDC_DETAREPOATECLI.RADICADO_RES
      where
        DETAREPOATECLI_ID = ircLDC_DETAREPOATECLI.DETAREPOATECLI_ID
      returning
        DETAREPOATECLI_ID
      into
        nuDETAREPOATECLI_ID;
    end if;
    if
      nuDETAREPOATECLI_ID is NULL
    then
      raise no_data_found;
    end if;
  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_DETAREPOATECLI));
      raise ex.CONTROLLED_ERROR;
  END;
  PROCEDURE updRecords
  (
    iotbLDC_DETAREPOATECLI in out nocopy tytbLDC_DETAREPOATECLI,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLDC_DETAREPOATECLI;
  BEGIN
    FillRecordOfTables(iotbLDC_DETAREPOATECLI,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLDC_DETAREPOATECLI.first .. iotbLDC_DETAREPOATECLI.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLDC_DETAREPOATECLI.first .. iotbLDC_DETAREPOATECLI.last
        update LDC_DETAREPOATECLI
        set
          FECHA_NOTIFICACION = rcRecOfTab.FECHA_NOTIFICACION(n),
          TIPO_NOTIFICACION = rcRecOfTab.TIPO_NOTIFICACION(n),
          FECHA_TRASLADO = rcRecOfTab.FECHA_TRASLADO(n),
          FLAG_REPORTA = rcRecOfTab.FLAG_REPORTA(n),
          ATECLIREPO_ID = rcRecOfTab.ATECLIREPO_ID(n),
          CODIGO_DANE = rcRecOfTab.CODIGO_DANE(n),
          SERVICIO = rcRecOfTab.SERVICIO(n),
          RADICADO_ING = rcRecOfTab.RADICADO_ING(n),
          FECHA_REGISTRO = rcRecOfTab.FECHA_REGISTRO(n),
          TIPO_TRAMITE = rcRecOfTab.TIPO_TRAMITE(n),
          CAUSAL = rcRecOfTab.CAUSAL(n),
          NUMERO_IDENTIFICACION = rcRecOfTab.NUMERO_IDENTIFICACION(n),
          NUMERO_FACTURA = rcRecOfTab.NUMERO_FACTURA(n),
          TIPO_RESPUESTA = rcRecOfTab.TIPO_RESPUESTA(n),
          FECHA_RESPUESTA = rcRecOfTab.FECHA_RESPUESTA(n),
          RADICADO_RES = rcRecOfTab.RADICADO_RES(n)
        where
          rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLDC_DETAREPOATECLI.first .. iotbLDC_DETAREPOATECLI.last loop
          LockByPk
          (
            rcRecOfTab.DETAREPOATECLI_ID(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLDC_DETAREPOATECLI.first .. iotbLDC_DETAREPOATECLI.last
        update LDC_DETAREPOATECLI
        SET
          FECHA_NOTIFICACION = rcRecOfTab.FECHA_NOTIFICACION(n),
          TIPO_NOTIFICACION = rcRecOfTab.TIPO_NOTIFICACION(n),
          FECHA_TRASLADO = rcRecOfTab.FECHA_TRASLADO(n),
          FLAG_REPORTA = rcRecOfTab.FLAG_REPORTA(n),
          ATECLIREPO_ID = rcRecOfTab.ATECLIREPO_ID(n),
          CODIGO_DANE = rcRecOfTab.CODIGO_DANE(n),
          SERVICIO = rcRecOfTab.SERVICIO(n),
          RADICADO_ING = rcRecOfTab.RADICADO_ING(n),
          FECHA_REGISTRO = rcRecOfTab.FECHA_REGISTRO(n),
          TIPO_TRAMITE = rcRecOfTab.TIPO_TRAMITE(n),
          CAUSAL = rcRecOfTab.CAUSAL(n),
          NUMERO_IDENTIFICACION = rcRecOfTab.NUMERO_IDENTIFICACION(n),
          NUMERO_FACTURA = rcRecOfTab.NUMERO_FACTURA(n),
          TIPO_RESPUESTA = rcRecOfTab.TIPO_RESPUESTA(n),
          FECHA_RESPUESTA = rcRecOfTab.FECHA_RESPUESTA(n),
          RADICADO_RES = rcRecOfTab.RADICADO_RES(n)
        where
          DETAREPOATECLI_ID = rcRecOfTab.DETAREPOATECLI_ID(n)
;
    end if;
  END;
  PROCEDURE updFECHA_NOTIFICACION
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    isbFECHA_NOTIFICACION$ in LDC_DETAREPOATECLI.FECHA_NOTIFICACION%type,
    inuLock in number default 0
  )
  IS
    rcError styLDC_DETAREPOATECLI;
  BEGIN
    rcError.DETAREPOATECLI_ID := inuDETAREPOATECLI_ID;
    if inuLock=1 then
      LockByPk
      (
        inuDETAREPOATECLI_ID,
        rcData
      );
    end if;

    update LDC_DETAREPOATECLI
    set
      FECHA_NOTIFICACION = isbFECHA_NOTIFICACION$
    where
      DETAREPOATECLI_ID = inuDETAREPOATECLI_ID;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.FECHA_NOTIFICACION:= isbFECHA_NOTIFICACION$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;
  PROCEDURE updTIPO_NOTIFICACION
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    isbTIPO_NOTIFICACION$ in LDC_DETAREPOATECLI.TIPO_NOTIFICACION%type,
    inuLock in number default 0
  )
  IS
    rcError styLDC_DETAREPOATECLI;
  BEGIN
    rcError.DETAREPOATECLI_ID := inuDETAREPOATECLI_ID;
    if inuLock=1 then
      LockByPk
      (
        inuDETAREPOATECLI_ID,
        rcData
      );
    end if;

    update LDC_DETAREPOATECLI
    set
      TIPO_NOTIFICACION = isbTIPO_NOTIFICACION$
    where
      DETAREPOATECLI_ID = inuDETAREPOATECLI_ID;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.TIPO_NOTIFICACION:= isbTIPO_NOTIFICACION$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;
  PROCEDURE updFECHA_TRASLADO
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    isbFECHA_TRASLADO$ in LDC_DETAREPOATECLI.FECHA_TRASLADO%type,
    inuLock in number default 0
  )
  IS
    rcError styLDC_DETAREPOATECLI;
  BEGIN
    rcError.DETAREPOATECLI_ID := inuDETAREPOATECLI_ID;
    if inuLock=1 then
      LockByPk
      (
        inuDETAREPOATECLI_ID,
        rcData
      );
    end if;

    update LDC_DETAREPOATECLI
    set
      FECHA_TRASLADO = isbFECHA_TRASLADO$
    where
      DETAREPOATECLI_ID = inuDETAREPOATECLI_ID;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.FECHA_TRASLADO:= isbFECHA_TRASLADO$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;
  PROCEDURE updFLAG_REPORTA
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    isbFLAG_REPORTA$ in LDC_DETAREPOATECLI.FLAG_REPORTA%type,
    inuLock in number default 0
  )
  IS
    rcError styLDC_DETAREPOATECLI;
  BEGIN
    rcError.DETAREPOATECLI_ID := inuDETAREPOATECLI_ID;
    if inuLock=1 then
      LockByPk
      (
        inuDETAREPOATECLI_ID,
        rcData
      );
    end if;

    update LDC_DETAREPOATECLI
    set
      FLAG_REPORTA = isbFLAG_REPORTA$
    where
      DETAREPOATECLI_ID = inuDETAREPOATECLI_ID;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.FLAG_REPORTA:= isbFLAG_REPORTA$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;
  PROCEDURE updATECLIREPO_ID
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    inuATECLIREPO_ID$ in LDC_DETAREPOATECLI.ATECLIREPO_ID%type,
    inuLock in number default 0
  )
  IS
    rcError styLDC_DETAREPOATECLI;
  BEGIN
    rcError.DETAREPOATECLI_ID := inuDETAREPOATECLI_ID;
    if inuLock=1 then
      LockByPk
      (
        inuDETAREPOATECLI_ID,
        rcData
      );
    end if;

    update LDC_DETAREPOATECLI
    set
      ATECLIREPO_ID = inuATECLIREPO_ID$
    where
      DETAREPOATECLI_ID = inuDETAREPOATECLI_ID;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.ATECLIREPO_ID:= inuATECLIREPO_ID$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;
  PROCEDURE updCODIGO_DANE
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    isbCODIGO_DANE$ in LDC_DETAREPOATECLI.CODIGO_DANE%type,
    inuLock in number default 0
  )
  IS
    rcError styLDC_DETAREPOATECLI;
  BEGIN
    rcError.DETAREPOATECLI_ID := inuDETAREPOATECLI_ID;
    if inuLock=1 then
      LockByPk
      (
        inuDETAREPOATECLI_ID,
        rcData
      );
    end if;

    update LDC_DETAREPOATECLI
    set
      CODIGO_DANE = isbCODIGO_DANE$
    where
      DETAREPOATECLI_ID = inuDETAREPOATECLI_ID;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.CODIGO_DANE:= isbCODIGO_DANE$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;
  PROCEDURE updSERVICIO
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    isbSERVICIO$ in LDC_DETAREPOATECLI.SERVICIO%type,
    inuLock in number default 0
  )
  IS
    rcError styLDC_DETAREPOATECLI;
  BEGIN
    rcError.DETAREPOATECLI_ID := inuDETAREPOATECLI_ID;
    if inuLock=1 then
      LockByPk
      (
        inuDETAREPOATECLI_ID,
        rcData
      );
    end if;

    update LDC_DETAREPOATECLI
    set
      SERVICIO = isbSERVICIO$
    where
      DETAREPOATECLI_ID = inuDETAREPOATECLI_ID;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.SERVICIO:= isbSERVICIO$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;
  PROCEDURE updRADICADO_ING
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    isbRADICADO_ING$ in LDC_DETAREPOATECLI.RADICADO_ING%type,
    inuLock in number default 0
  )
  IS
    rcError styLDC_DETAREPOATECLI;
  BEGIN
    rcError.DETAREPOATECLI_ID := inuDETAREPOATECLI_ID;
    if inuLock=1 then
      LockByPk
      (
        inuDETAREPOATECLI_ID,
        rcData
      );
    end if;

    update LDC_DETAREPOATECLI
    set
      RADICADO_ING = isbRADICADO_ING$
    where
      DETAREPOATECLI_ID = inuDETAREPOATECLI_ID;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.RADICADO_ING:= isbRADICADO_ING$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;
  PROCEDURE updFECHA_REGISTRO
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    isbFECHA_REGISTRO$ in LDC_DETAREPOATECLI.FECHA_REGISTRO%type,
    inuLock in number default 0
  )
  IS
    rcError styLDC_DETAREPOATECLI;
  BEGIN
    rcError.DETAREPOATECLI_ID := inuDETAREPOATECLI_ID;
    if inuLock=1 then
      LockByPk
      (
        inuDETAREPOATECLI_ID,
        rcData
      );
    end if;

    update LDC_DETAREPOATECLI
    set
      FECHA_REGISTRO = isbFECHA_REGISTRO$
    where
      DETAREPOATECLI_ID = inuDETAREPOATECLI_ID;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.FECHA_REGISTRO:= isbFECHA_REGISTRO$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;
  PROCEDURE updTIPO_TRAMITE
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    isbTIPO_TRAMITE$ in LDC_DETAREPOATECLI.TIPO_TRAMITE%type,
    inuLock in number default 0
  )
  IS
    rcError styLDC_DETAREPOATECLI;
  BEGIN
    rcError.DETAREPOATECLI_ID := inuDETAREPOATECLI_ID;
    if inuLock=1 then
      LockByPk
      (
        inuDETAREPOATECLI_ID,
        rcData
      );
    end if;

    update LDC_DETAREPOATECLI
    set
      TIPO_TRAMITE = isbTIPO_TRAMITE$
    where
      DETAREPOATECLI_ID = inuDETAREPOATECLI_ID;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.TIPO_TRAMITE:= isbTIPO_TRAMITE$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;
  PROCEDURE updCAUSAL
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    isbCAUSAL$ in LDC_DETAREPOATECLI.CAUSAL%type,
    inuLock in number default 0
  )
  IS
    rcError styLDC_DETAREPOATECLI;
  BEGIN
    rcError.DETAREPOATECLI_ID := inuDETAREPOATECLI_ID;
    if inuLock=1 then
      LockByPk
      (
        inuDETAREPOATECLI_ID,
        rcData
      );
    end if;

    update LDC_DETAREPOATECLI
    set
      CAUSAL = isbCAUSAL$
    where
      DETAREPOATECLI_ID = inuDETAREPOATECLI_ID;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.CAUSAL:= isbCAUSAL$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;
  PROCEDURE updNUMERO_IDENTIFICACION
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    isbNUMERO_IDENTIFICACION$ in LDC_DETAREPOATECLI.NUMERO_IDENTIFICACION%type,
    inuLock in number default 0
  )
  IS
    rcError styLDC_DETAREPOATECLI;
  BEGIN
    rcError.DETAREPOATECLI_ID := inuDETAREPOATECLI_ID;
    if inuLock=1 then
      LockByPk
      (
        inuDETAREPOATECLI_ID,
        rcData
      );
    end if;

    update LDC_DETAREPOATECLI
    set
      NUMERO_IDENTIFICACION = isbNUMERO_IDENTIFICACION$
    where
      DETAREPOATECLI_ID = inuDETAREPOATECLI_ID;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.NUMERO_IDENTIFICACION:= isbNUMERO_IDENTIFICACION$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;
  PROCEDURE updNUMERO_FACTURA
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    isbNUMERO_FACTURA$ in LDC_DETAREPOATECLI.NUMERO_FACTURA%type,
    inuLock in number default 0
  )
  IS
    rcError styLDC_DETAREPOATECLI;
  BEGIN
    rcError.DETAREPOATECLI_ID := inuDETAREPOATECLI_ID;
    if inuLock=1 then
      LockByPk
      (
        inuDETAREPOATECLI_ID,
        rcData
      );
    end if;

    update LDC_DETAREPOATECLI
    set
      NUMERO_FACTURA = isbNUMERO_FACTURA$
    where
      DETAREPOATECLI_ID = inuDETAREPOATECLI_ID;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.NUMERO_FACTURA:= isbNUMERO_FACTURA$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;
  PROCEDURE updTIPO_RESPUESTA
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    isbTIPO_RESPUESTA$ in LDC_DETAREPOATECLI.TIPO_RESPUESTA%type,
    inuLock in number default 0
  )
  IS
    rcError styLDC_DETAREPOATECLI;
  BEGIN
    rcError.DETAREPOATECLI_ID := inuDETAREPOATECLI_ID;
    if inuLock=1 then
      LockByPk
      (
        inuDETAREPOATECLI_ID,
        rcData
      );
    end if;

    update LDC_DETAREPOATECLI
    set
      TIPO_RESPUESTA = isbTIPO_RESPUESTA$
    where
      DETAREPOATECLI_ID = inuDETAREPOATECLI_ID;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.TIPO_RESPUESTA:= isbTIPO_RESPUESTA$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;
  PROCEDURE updFECHA_RESPUESTA
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    isbFECHA_RESPUESTA$ in LDC_DETAREPOATECLI.FECHA_RESPUESTA%type,
    inuLock in number default 0
  )
  IS
    rcError styLDC_DETAREPOATECLI;
  BEGIN
    rcError.DETAREPOATECLI_ID := inuDETAREPOATECLI_ID;
    if inuLock=1 then
      LockByPk
      (
        inuDETAREPOATECLI_ID,
        rcData
      );
    end if;

    update LDC_DETAREPOATECLI
    set
      FECHA_RESPUESTA = isbFECHA_RESPUESTA$
    where
      DETAREPOATECLI_ID = inuDETAREPOATECLI_ID;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.FECHA_RESPUESTA:= isbFECHA_RESPUESTA$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;
  PROCEDURE updRADICADO_RES
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    isbRADICADO_RES$ in LDC_DETAREPOATECLI.RADICADO_RES%type,
    inuLock in number default 0
  )
  IS
    rcError styLDC_DETAREPOATECLI;
  BEGIN
    rcError.DETAREPOATECLI_ID := inuDETAREPOATECLI_ID;
    if inuLock=1 then
      LockByPk
      (
        inuDETAREPOATECLI_ID,
        rcData
      );
    end if;

    update LDC_DETAREPOATECLI
    set
      RADICADO_RES = isbRADICADO_RES$
    where
      DETAREPOATECLI_ID = inuDETAREPOATECLI_ID;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.RADICADO_RES:= isbRADICADO_RES$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;
  FUNCTION fsbGetFECHA_NOTIFICACION
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    inuRaiseError in number default 1
  )
  RETURN LDC_DETAREPOATECLI.FECHA_NOTIFICACION%type
  IS
    rcError styLDC_DETAREPOATECLI;
  BEGIN

    rcError.DETAREPOATECLI_ID := inuDETAREPOATECLI_ID;

        -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuDETAREPOATECLI_ID
       )
    then
       return(rcData.FECHA_NOTIFICACION);
    end if;
    Load
    (
        inuDETAREPOATECLI_ID
    );
    return(rcData.FECHA_NOTIFICACION);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;
  FUNCTION fsbGetTIPO_NOTIFICACION
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    inuRaiseError in number default 1
  )
  RETURN LDC_DETAREPOATECLI.TIPO_NOTIFICACION%type
  IS
    rcError styLDC_DETAREPOATECLI;
  BEGIN

    rcError.DETAREPOATECLI_ID := inuDETAREPOATECLI_ID;

        -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuDETAREPOATECLI_ID
       )
    then
       return(rcData.TIPO_NOTIFICACION);
    end if;
    Load
    (
        inuDETAREPOATECLI_ID
    );
    return(rcData.TIPO_NOTIFICACION);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;
  FUNCTION fsbGetFECHA_TRASLADO
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    inuRaiseError in number default 1
  )
  RETURN LDC_DETAREPOATECLI.FECHA_TRASLADO%type
  IS
    rcError styLDC_DETAREPOATECLI;
  BEGIN

    rcError.DETAREPOATECLI_ID := inuDETAREPOATECLI_ID;

        -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuDETAREPOATECLI_ID
       )
    then
       return(rcData.FECHA_TRASLADO);
    end if;
    Load
    (
        inuDETAREPOATECLI_ID
    );
    return(rcData.FECHA_TRASLADO);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;
  FUNCTION fsbGetFLAG_REPORTA
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    inuRaiseError in number default 1
  )
  RETURN LDC_DETAREPOATECLI.FLAG_REPORTA%type
  IS
    rcError styLDC_DETAREPOATECLI;
  BEGIN

    rcError.DETAREPOATECLI_ID := inuDETAREPOATECLI_ID;

        -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuDETAREPOATECLI_ID
       )
    then
       return(rcData.FLAG_REPORTA);
    end if;
    Load
    (
        inuDETAREPOATECLI_ID
    );
    return(rcData.FLAG_REPORTA);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;
  FUNCTION fnuGetDETAREPOATECLI_ID
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    inuRaiseError in number default 1
  )
  RETURN LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type
  IS
    rcError styLDC_DETAREPOATECLI;
  BEGIN

    rcError.DETAREPOATECLI_ID := inuDETAREPOATECLI_ID;

        -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuDETAREPOATECLI_ID
       )
    then
       return(rcData.DETAREPOATECLI_ID);
    end if;
    Load
    (
        inuDETAREPOATECLI_ID
    );
    return(rcData.DETAREPOATECLI_ID);
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
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    inuRaiseError in number default 1
  )
  RETURN LDC_DETAREPOATECLI.ATECLIREPO_ID%type
  IS
    rcError styLDC_DETAREPOATECLI;
  BEGIN

    rcError.DETAREPOATECLI_ID := inuDETAREPOATECLI_ID;

        -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuDETAREPOATECLI_ID
       )
    then
       return(rcData.ATECLIREPO_ID);
    end if;
    Load
    (
        inuDETAREPOATECLI_ID
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
  FUNCTION fsbGetCODIGO_DANE
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    inuRaiseError in number default 1
  )
  RETURN LDC_DETAREPOATECLI.CODIGO_DANE%type
  IS
    rcError styLDC_DETAREPOATECLI;
  BEGIN

    rcError.DETAREPOATECLI_ID := inuDETAREPOATECLI_ID;

        -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuDETAREPOATECLI_ID
       )
    then
       return(rcData.CODIGO_DANE);
    end if;
    Load
    (
        inuDETAREPOATECLI_ID
    );
    return(rcData.CODIGO_DANE);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;
  FUNCTION fsbGetSERVICIO
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    inuRaiseError in number default 1
  )
  RETURN LDC_DETAREPOATECLI.SERVICIO%type
  IS
    rcError styLDC_DETAREPOATECLI;
  BEGIN

    rcError.DETAREPOATECLI_ID := inuDETAREPOATECLI_ID;

        -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuDETAREPOATECLI_ID
       )
    then
       return(rcData.SERVICIO);
    end if;
    Load
    (
        inuDETAREPOATECLI_ID
    );
    return(rcData.SERVICIO);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;
  FUNCTION fsbGetRADICADO_ING
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    inuRaiseError in number default 1
  )
  RETURN LDC_DETAREPOATECLI.RADICADO_ING%type
  IS
    rcError styLDC_DETAREPOATECLI;
  BEGIN

    rcError.DETAREPOATECLI_ID := inuDETAREPOATECLI_ID;

        -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuDETAREPOATECLI_ID
       )
    then
       return(rcData.RADICADO_ING);
    end if;
    Load
    (
        inuDETAREPOATECLI_ID
    );
    return(rcData.RADICADO_ING);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;
  FUNCTION fsbGetFECHA_REGISTRO
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    inuRaiseError in number default 1
  )
  RETURN LDC_DETAREPOATECLI.FECHA_REGISTRO%type
  IS
    rcError styLDC_DETAREPOATECLI;
  BEGIN

    rcError.DETAREPOATECLI_ID := inuDETAREPOATECLI_ID;

        -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuDETAREPOATECLI_ID
       )
    then
       return(rcData.FECHA_REGISTRO);
    end if;
    Load
    (
        inuDETAREPOATECLI_ID
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
  FUNCTION fsbGetTIPO_TRAMITE
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    inuRaiseError in number default 1
  )
  RETURN LDC_DETAREPOATECLI.TIPO_TRAMITE%type
  IS
    rcError styLDC_DETAREPOATECLI;
  BEGIN

    rcError.DETAREPOATECLI_ID := inuDETAREPOATECLI_ID;

        -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuDETAREPOATECLI_ID
       )
    then
       return(rcData.TIPO_TRAMITE);
    end if;
    Load
    (
        inuDETAREPOATECLI_ID
    );
    return(rcData.TIPO_TRAMITE);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;
  FUNCTION fsbGetCAUSAL
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    inuRaiseError in number default 1
  )
  RETURN LDC_DETAREPOATECLI.CAUSAL%type
  IS
    rcError styLDC_DETAREPOATECLI;
  BEGIN

    rcError.DETAREPOATECLI_ID := inuDETAREPOATECLI_ID;

        -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuDETAREPOATECLI_ID
       )
    then
       return(rcData.CAUSAL);
    end if;
    Load
    (
        inuDETAREPOATECLI_ID
    );
    return(rcData.CAUSAL);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;
  FUNCTION fsbGetNUMERO_IDENTIFICACION
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    inuRaiseError in number default 1
  )
  RETURN LDC_DETAREPOATECLI.NUMERO_IDENTIFICACION%type
  IS
    rcError styLDC_DETAREPOATECLI;
  BEGIN

    rcError.DETAREPOATECLI_ID := inuDETAREPOATECLI_ID;

        -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuDETAREPOATECLI_ID
       )
    then
       return(rcData.NUMERO_IDENTIFICACION);
    end if;
    Load
    (
        inuDETAREPOATECLI_ID
    );
    return(rcData.NUMERO_IDENTIFICACION);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;
  FUNCTION fsbGetNUMERO_FACTURA
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    inuRaiseError in number default 1
  )
  RETURN LDC_DETAREPOATECLI.NUMERO_FACTURA%type
  IS
    rcError styLDC_DETAREPOATECLI;
  BEGIN

    rcError.DETAREPOATECLI_ID := inuDETAREPOATECLI_ID;

        -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuDETAREPOATECLI_ID
       )
    then
       return(rcData.NUMERO_FACTURA);
    end if;
    Load
    (
        inuDETAREPOATECLI_ID
    );
    return(rcData.NUMERO_FACTURA);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;
  FUNCTION fsbGetTIPO_RESPUESTA
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    inuRaiseError in number default 1
  )
  RETURN LDC_DETAREPOATECLI.TIPO_RESPUESTA%type
  IS
    rcError styLDC_DETAREPOATECLI;
  BEGIN

    rcError.DETAREPOATECLI_ID := inuDETAREPOATECLI_ID;

        -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuDETAREPOATECLI_ID
       )
    then
       return(rcData.TIPO_RESPUESTA);
    end if;
    Load
    (
        inuDETAREPOATECLI_ID
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
  FUNCTION fsbGetFECHA_RESPUESTA
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    inuRaiseError in number default 1
  )
  RETURN LDC_DETAREPOATECLI.FECHA_RESPUESTA%type
  IS
    rcError styLDC_DETAREPOATECLI;
  BEGIN

    rcError.DETAREPOATECLI_ID := inuDETAREPOATECLI_ID;

        -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuDETAREPOATECLI_ID
       )
    then
       return(rcData.FECHA_RESPUESTA);
    end if;
    Load
    (
        inuDETAREPOATECLI_ID
    );
    return(rcData.FECHA_RESPUESTA);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;
  FUNCTION fsbGetRADICADO_RES
  (
    inuDETAREPOATECLI_ID in LDC_DETAREPOATECLI.DETAREPOATECLI_ID%type,
    inuRaiseError in number default 1
  )
  RETURN LDC_DETAREPOATECLI.RADICADO_RES%type
  IS
    rcError styLDC_DETAREPOATECLI;
  BEGIN

    rcError.DETAREPOATECLI_ID := inuDETAREPOATECLI_ID;

        -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuDETAREPOATECLI_ID
       )
    then
       return(rcData.RADICADO_RES);
    end if;
    Load
    (
        inuDETAREPOATECLI_ID
    );
    return(rcData.RADICADO_RES);
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
end DALDC_DETAREPOATECLI;
/
PROMPT Otorgando permisos de ejecucion a DALDC_DETAREPOATECLI
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_DETAREPOATECLI', 'ADM_PERSON');
END;
/