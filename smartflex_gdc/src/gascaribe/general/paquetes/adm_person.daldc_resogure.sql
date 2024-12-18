CREATE OR REPLACE PACKAGE ADM_PERSON.DALDC_RESOGURE
is
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     : DALDC_RESOGURE
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
    isbREGRRESO in LDC_RESOGURE.RESOLUCION%type,
    idtREGRFEIN in LDC_RESOGURE.INI_VIGENCIA%type,
    inuREGRLOC in LDC_RESOGURE.LOCALIDAD%type
  )
  IS
    SELECT LDC_RESOGURE.*,LDC_RESOGURE.rowid
    FROM LDC_RESOGURE
    WHERE
        RESOLUCION = isbREGRRESO
        and INI_VIGENCIA = idtREGRFEIN
        and LOCALIDAD = inuREGRLOC;


  /* Cursor general para acceso por RowId */
  CURSOR cuRecordByRowId
  (
    irirowid in varchar2
  )
  IS
        SELECT LDC_RESOGURE.*,LDC_RESOGURE.rowid
    FROM LDC_RESOGURE
    WHERE
      rowId = irirowid;


  /* Subtipos */
  subtype styLDC_RESOGURE  is  cuRecord%rowtype;
  type    tyRefCursor is  REF CURSOR;

  /*Tipos*/
  type tytbLDC_RESOGURE is table of styLDC_RESOGURE index by binary_integer;
  type tyrfRecords is ref cursor return styLDC_RESOGURE;

  /* Tipos referenciando al registro */
  type tytbREGRTDOC is table of LDC_RESOGURE.CODIGO%type index by binary_integer;
  type tytbREGRLOC is table of LDC_RESOGURE.LOCALIDAD%type index by binary_integer;
  type tytbREGROBS is table of LDC_RESOGURE.OBSERVACION%type index by binary_integer;
  type tytbREGRRESO is table of LDC_RESOGURE.RESOLUCION%type index by binary_integer;
  type tytbREGRFEIN is table of LDC_RESOGURE.INI_VIGENCIA%type index by binary_integer;
  type tytbREGRTIPO is table of LDC_RESOGURE.TIPO%type index by binary_integer;
  type tytbrowid is table of rowid index by binary_integer;

  type tyrcLDC_RESOGURE is record
  (
    REGRTDOC   tytbREGRTDOC,
    REGRLOC   tytbREGRLOC,
    REGROBS   tytbREGROBS,
    REGRRESO   tytbREGRRESO,
    REGRFEIN   tytbREGRFEIN,
    REGRTIPO   tytbREGRTIPO,
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
    isbREGRRESO in LDC_RESOGURE.RESOLUCION%type,
    idtREGRFEIN in LDC_RESOGURE.INI_VIGENCIA%type,
    inuREGRLOC in LDC_RESOGURE.LOCALIDAD%type
  )
  RETURN boolean;

  PROCEDURE AccKey
  (
    isbREGRRESO in LDC_RESOGURE.RESOLUCION%type,
    idtREGRFEIN in LDC_RESOGURE.INI_VIGENCIA%type,
    inuREGRLOC in LDC_RESOGURE.LOCALIDAD%type
  );

  PROCEDURE AccKeyByRowId
  (
    iriRowID    in rowid
  );

  PROCEDURE ValDuplicate
  (
    isbREGRRESO in LDC_RESOGURE.RESOLUCION%type,
    idtREGRFEIN in LDC_RESOGURE.INI_VIGENCIA%type,
    inuREGRLOC in LDC_RESOGURE.LOCALIDAD%type
  );

  PROCEDURE getRecord
  (
    isbREGRRESO in LDC_RESOGURE.RESOLUCION%type,
    idtREGRFEIN in LDC_RESOGURE.INI_VIGENCIA%type,
    inuREGRLOC in LDC_RESOGURE.LOCALIDAD%type,
    orcRecord out nocopy styLDC_RESOGURE
  );

  FUNCTION frcGetRcData
  (
    isbREGRRESO in LDC_RESOGURE.RESOLUCION%type,
    idtREGRFEIN in LDC_RESOGURE.INI_VIGENCIA%type,
    inuREGRLOC in LDC_RESOGURE.LOCALIDAD%type
  )
  RETURN styLDC_RESOGURE;

  FUNCTION frcGetRcData
  RETURN styLDC_RESOGURE;

  FUNCTION frcGetRecord
  (
    isbREGRRESO in LDC_RESOGURE.RESOLUCION%type,
    idtREGRFEIN in LDC_RESOGURE.INI_VIGENCIA%type,
    inuREGRLOC in LDC_RESOGURE.LOCALIDAD%type
  )
  RETURN styLDC_RESOGURE;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLDC_RESOGURE
  );

  FUNCTION frfGetRecords
  (
    isbCriteria in varchar2 default null,
    iblLock in boolean default false
  )
  RETURN tyRefCursor;

  PROCEDURE insRecord
  (
    ircLDC_RESOGURE in styLDC_RESOGURE
  );

  PROCEDURE insRecord
  (
    ircLDC_RESOGURE in styLDC_RESOGURE,
        orirowid   out varchar2
  );

  PROCEDURE insRecords
  (
    iotbLDC_RESOGURE in out nocopy tytbLDC_RESOGURE
  );

  PROCEDURE delRecord
  (
    isbREGRRESO in LDC_RESOGURE.RESOLUCION%type,
    idtREGRFEIN in LDC_RESOGURE.INI_VIGENCIA%type,
    inuREGRLOC in LDC_RESOGURE.LOCALIDAD%type,
    inuLock in number default 1
  );

  PROCEDURE delByRowID
  (
    iriRowID    in rowid,
    inuLock in number default 1
  );

  PROCEDURE delRecords
  (
    iotbLDC_RESOGURE in out nocopy tytbLDC_RESOGURE,
    inuLock in number default 1
  );

  PROCEDURE updRecord
  (
    ircLDC_RESOGURE in styLDC_RESOGURE,
    inuLock in number default 0
  );

  PROCEDURE updRecords
  (
    iotbLDC_RESOGURE in out nocopy tytbLDC_RESOGURE,
    inuLock in number default 1
  );

  PROCEDURE updREGRTDOC
  (
    isbREGRRESO in LDC_RESOGURE.RESOLUCION%type,
    idtREGRFEIN in LDC_RESOGURE.INI_VIGENCIA%type,
    inuREGRLOC in LDC_RESOGURE.LOCALIDAD%type,
    isbREGRTDOC$ in LDC_RESOGURE.CODIGO%type,
    inuLock in number default 0
  );

  PROCEDURE updREGROBS
  (
    isbREGRRESO in LDC_RESOGURE.RESOLUCION%type,
    idtREGRFEIN in LDC_RESOGURE.INI_VIGENCIA%type,
    inuREGRLOC in LDC_RESOGURE.LOCALIDAD%type,
    isbREGROBS$ in LDC_RESOGURE.OBSERVACION%type,
    inuLock in number default 0
  );

  FUNCTION fsbGetREGRTDOC
  (
    isbREGRRESO in LDC_RESOGURE.RESOLUCION%type,
    idtREGRFEIN in LDC_RESOGURE.INI_VIGENCIA%type,
    inuREGRLOC in LDC_RESOGURE.LOCALIDAD%type,
    inuRaiseError in number default 1
  )
  RETURN LDC_RESOGURE.CODIGO%type;

  FUNCTION fnuGetREGRLOC
  (
    isbREGRRESO in LDC_RESOGURE.RESOLUCION%type,
    idtREGRFEIN in LDC_RESOGURE.INI_VIGENCIA%type,
    inuREGRLOC in LDC_RESOGURE.LOCALIDAD%type,
    inuRaiseError in number default 1
  )
  RETURN LDC_RESOGURE.LOCALIDAD%type;

  FUNCTION fsbGetREGROBS
  (
    isbREGRRESO in LDC_RESOGURE.RESOLUCION%type,
    idtREGRFEIN in LDC_RESOGURE.INI_VIGENCIA%type,
    inuREGRLOC in LDC_RESOGURE.LOCALIDAD%type,
    inuRaiseError in number default 1
  )
  RETURN LDC_RESOGURE.OBSERVACION%type;

  FUNCTION fsbGetREGRRESO
  (
    isbREGRRESO in LDC_RESOGURE.RESOLUCION%type,
    idtREGRFEIN in LDC_RESOGURE.INI_VIGENCIA%type,
    inuREGRLOC in LDC_RESOGURE.LOCALIDAD%type,
    inuRaiseError in number default 1
  )
  RETURN LDC_RESOGURE.RESOLUCION%type;

  FUNCTION fdtGetREGRFEIN
  (
    isbREGRRESO in LDC_RESOGURE.RESOLUCION%type,
    idtREGRFEIN in LDC_RESOGURE.INI_VIGENCIA%type,
    inuREGRLOC in LDC_RESOGURE.LOCALIDAD%type,
    inuRaiseError in number default 1
  )
  RETURN LDC_RESOGURE.INI_VIGENCIA%type;


  PROCEDURE LockByPk
  (
    isbREGRRESO in LDC_RESOGURE.RESOLUCION%type,
    idtREGRFEIN in LDC_RESOGURE.INI_VIGENCIA%type,
    inuREGRLOC in LDC_RESOGURE.LOCALIDAD%type,
    orcLDC_RESOGURE  out styLDC_RESOGURE
  );

  PROCEDURE LockByRowID
  (
    irirowid    in  varchar2,
    orcLDC_RESOGURE  out styLDC_RESOGURE
  );

  PROCEDURE SetUseCache
  (
    iblUseCache    in  boolean
  );
END DALDC_RESOGURE;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALDC_RESOGURE
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_RESOGURE';
   cnuGeEntityId constant varchar2(30) := 3630; -- Id de Ge_entity

  /* Cursor para bloqueo de un registro por llave primaria */
  CURSOR cuLockRcByPk
  (
    isbREGRRESO in LDC_RESOGURE.RESOLUCION%type,
    idtREGRFEIN in LDC_RESOGURE.INI_VIGENCIA%type,
    inuREGRLOC in LDC_RESOGURE.LOCALIDAD%type
  )
  IS
    SELECT LDC_RESOGURE.*,LDC_RESOGURE.rowid
    FROM LDC_RESOGURE
    WHERE  RESOLUCION = isbREGRRESO
      and INI_VIGENCIA = idtREGRFEIN
      and LOCALIDAD = inuREGRLOC
    FOR UPDATE NOWAIT;

  /* Cursor para bloqueo de un registro por rowid */
  CURSOR cuLockRcbyRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LDC_RESOGURE.*,LDC_RESOGURE.rowid
    FROM LDC_RESOGURE
    WHERE
      rowId = irirowid
    FOR UPDATE NOWAIT;


  /*Tipos*/
  type tyrfLDC_RESOGURE is ref cursor;

  /*Variables Globales*/
  rcRecOfTab tyrcLDC_RESOGURE;

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
  FUNCTION fsbPrimaryKey( rcI in styLDC_RESOGURE default rcData )
  return varchar2
  IS
    sbPk varchar2(500);
  BEGIN
    sbPk:='[';
    sbPk:=sbPk||ut_convert.fsbToChar(rcI.RESOLUCION);
    sbPk:=sbPk||','||ut_convert.fsbToChar(rcI.INI_VIGENCIA);
    sbPk:=sbPk||','||ut_convert.fsbToChar(rcI.LOCALIDAD);
    sbPk:=sbPk||']';
    return sbPk;
  END;
  PROCEDURE LockByPk
  (
    isbREGRRESO in LDC_RESOGURE.RESOLUCION%type,
    idtREGRFEIN in LDC_RESOGURE.INI_VIGENCIA%type,
    inuREGRLOC in LDC_RESOGURE.LOCALIDAD%type,
    orcLDC_RESOGURE  out styLDC_RESOGURE
  )
  IS
    rcError styLDC_RESOGURE;
  BEGIN
    rcError.resolucion := isbREGRRESO;
    rcError.ini_vigencia := idtREGRFEIN;
    rcError.localidad := inuREGRLOC;

    Open cuLockRcByPk
    (
      isbREGRRESO,
      idtREGRFEIN,
      inuREGRLOC
    );

    fetch cuLockRcByPk into orcLDC_RESOGURE;
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
    orcLDC_RESOGURE  out styLDC_RESOGURE
  )
  IS
  BEGIN
    Open cuLockRcbyRowId
    (
      irirowid
    );

    fetch cuLockRcbyRowId into orcLDC_RESOGURE;
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
    itbLDC_RESOGURE  in out nocopy tytbLDC_RESOGURE
  )
  IS
  BEGIN
      rcRecOfTab.REGRTDOC.delete;
      rcRecOfTab.REGRLOC.delete;
      rcRecOfTab.REGROBS.delete;
      rcRecOfTab.REGRRESO.delete;
      rcRecOfTab.REGRFEIN.delete;
      rcRecOfTab.row_id.delete;
  END;
  PROCEDURE FillRecordOfTables
  (
    itbLDC_RESOGURE  in out nocopy tytbLDC_RESOGURE,
    oblUseRowId out boolean
  )
  IS
  BEGIN
    DelRecordOfTables(itbLDC_RESOGURE);

    for n in itbLDC_RESOGURE.first .. itbLDC_RESOGURE.last loop
      rcRecOfTab.REGRTDOC(n) := itbLDC_RESOGURE(n).codigo;
      rcRecOfTab.REGRLOC(n) := itbLDC_RESOGURE(n).localidad;
      rcRecOfTab.REGROBS(n) := itbLDC_RESOGURE(n).observacion;
      rcRecOfTab.REGRRESO(n) := itbLDC_RESOGURE(n).resolucion;
      rcRecOfTab.REGRFEIN(n) := itbLDC_RESOGURE(n).ini_vigencia;
      rcRecOfTab.REGRTIPO(n) := itbLDC_RESOGURE(n).tipo;
      rcRecOfTab.row_id(n) := itbLDC_RESOGURE(n).rowid;

      -- Indica si el rowid es Nulo
      oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
    end loop;
  END;

  PROCEDURE Load
  (
    isbREGRRESO in LDC_RESOGURE.RESOLUCION%type,
    idtREGRFEIN in LDC_RESOGURE.INI_VIGENCIA%type,
    inuREGRLOC in LDC_RESOGURE.LOCALIDAD%type
  )
  IS
    rcRecordNull cuRecord%rowtype;
  BEGIN
    if cuRecord%isopen then
      close cuRecord;
    end if;
    open cuRecord
    (
      isbREGRRESO,
      idtREGRFEIN,
      inuREGRLOC
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
    isbREGRRESO in LDC_RESOGURE.RESOLUCION%type,
    idtREGRFEIN in LDC_RESOGURE.INI_VIGENCIA%type,
    inuREGRLOC in LDC_RESOGURE.LOCALIDAD%type
  )
  RETURN boolean
  IS
  BEGIN
    if (
      isbREGRRESO = rcData.resolucion AND
      idtREGRFEIN = rcData.ini_vigencia AND
      inuREGRLOC = rcData.localidad
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
    isbREGRRESO in LDC_RESOGURE.RESOLUCION%type,
    idtREGRFEIN in LDC_RESOGURE.INI_VIGENCIA%type,
    inuREGRLOC in LDC_RESOGURE.LOCALIDAD%type
  )
  RETURN boolean
  IS
  BEGIN
    Load
    (
      isbREGRRESO,
      idtREGRFEIN,
      inuREGRLOC
    );
    return(TRUE);
  EXCEPTION
    when no_data_found then
      return(FALSE);
  END;
  PROCEDURE AccKey
  (
    isbREGRRESO in LDC_RESOGURE.RESOLUCION%type,
    idtREGRFEIN in LDC_RESOGURE.INI_VIGENCIA%type,
    inuREGRLOC in LDC_RESOGURE.LOCALIDAD%type
  )
  IS
    rcError styLDC_RESOGURE;
  BEGIN    rcError.resolucion:=isbREGRRESO;    rcError.ini_vigencia:=idtREGRFEIN;    rcError.localidad:=inuREGRLOC;

    Load
    (
      isbREGRRESO,
      idtREGRFEIN,
      inuREGRLOC
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
    isbREGRRESO in LDC_RESOGURE.RESOLUCION%type,
    idtREGRFEIN in LDC_RESOGURE.INI_VIGENCIA%type,
    inuREGRLOC in LDC_RESOGURE.LOCALIDAD%type
  )
  IS
  BEGIN
    Load
    (
      isbREGRRESO,
      idtREGRFEIN,
      inuREGRLOC
    );
    Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
    raise ex.CONTROLLED_ERROR;

  EXCEPTION
    when no_data_found then
      null;
  END;
  PROCEDURE getRecord
  (
    isbREGRRESO in LDC_RESOGURE.RESOLUCION%type,
    idtREGRFEIN in LDC_RESOGURE.INI_VIGENCIA%type,
    inuREGRLOC in LDC_RESOGURE.LOCALIDAD%type,
    orcRecord out nocopy styLDC_RESOGURE
  )
  IS
    rcError styLDC_RESOGURE;
  BEGIN    rcError.resolucion:=isbREGRRESO;    rcError.ini_vigencia:=idtREGRFEIN;    rcError.localidad:=inuREGRLOC;

    Load
    (
      isbREGRRESO,
      idtREGRFEIN,
      inuREGRLOC
    );
    orcRecord := rcData;
  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;
  FUNCTION frcGetRecord
  (
    isbREGRRESO in LDC_RESOGURE.RESOLUCION%type,
    idtREGRFEIN in LDC_RESOGURE.INI_VIGENCIA%type,
    inuREGRLOC in LDC_RESOGURE.LOCALIDAD%type
  )
  RETURN styLDC_RESOGURE
  IS
    rcError styLDC_RESOGURE;
  BEGIN
    rcError.resolucion:=isbREGRRESO;
    rcError.ini_vigencia:=idtREGRFEIN;
    rcError.localidad:=inuREGRLOC;

    Load
    (
      isbREGRRESO,
      idtREGRFEIN,
      inuREGRLOC
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;
  FUNCTION frcGetRcData
  (
    isbREGRRESO in LDC_RESOGURE.RESOLUCION%type,
    idtREGRFEIN in LDC_RESOGURE.INI_VIGENCIA%type,
    inuREGRLOC in LDC_RESOGURE.LOCALIDAD%type
  )
  RETURN styLDC_RESOGURE
  IS
    rcError styLDC_RESOGURE;
  BEGIN
    rcError.resolucion:=isbREGRRESO;
    rcError.ini_vigencia:=idtREGRFEIN;
    rcError.localidad:=inuREGRLOC;
        -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
      isbREGRRESO,
      idtREGRFEIN,
      inuREGRLOC
       )
    then
       return(rcData);
    end if;
    Load
    (
      isbREGRRESO,
      idtREGRFEIN,
      inuREGRLOC
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  RETURN styLDC_RESOGURE
  IS
  BEGIN
    return(rcData);
  END;
  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLDC_RESOGURE
  )
  IS
    rfLDC_RESOGURE tyrfLDC_RESOGURE;
    n number(4) := 1;
    sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_RESOGURE.*, LDC_RESOGURE.rowid FROM LDC_RESOGURE';
    nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
  BEGIN
    otbResult.delete;
    if isbQuery is not NULL and length(isbQuery) > 0 then
      sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
    end if;

    open rfLDC_RESOGURE for sbFullQuery;

    fetch rfLDC_RESOGURE bulk collect INTO otbResult;

    close rfLDC_RESOGURE;
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
    sbSQL VARCHAR2 (32000) := 'select LDC_RESOGURE.*, LDC_RESOGURE.rowid FROM LDC_RESOGURE';
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
    ircLDC_RESOGURE in styLDC_RESOGURE
  )
  IS
    rirowid varchar2(200);
  BEGIN
    insRecord(ircLDC_RESOGURE,rirowid);
  END;
  PROCEDURE insRecord
  (
    ircLDC_RESOGURE in styLDC_RESOGURE,
        orirowid   out varchar2
  )
  IS
  BEGIN
    if ircLDC_RESOGURE.resolucion is NULL then
      Errors.SetError(cnuINS_PK_NULL,
                      fsbGetMessageDescription||'|resolucion');
      raise ex.controlled_error;
    end if;
    if ircLDC_RESOGURE.ini_vigencia is NULL then
      Errors.SetError(cnuINS_PK_NULL,
                      fsbGetMessageDescription||'|ini_vigencia');
      raise ex.controlled_error;
    end if;
    if ircLDC_RESOGURE.localidad is NULL then
      Errors.SetError(cnuINS_PK_NULL,
                      fsbGetMessageDescription||'|localidad');
      raise ex.controlled_error;
    end if;

    insert into LDC_RESOGURE
    (
      codigo,
      localidad,
      observacion,
      resolucion,
      ini_vigencia,
      tipo
    )
    values
    (
      ircLDC_RESOGURE.codigo,
      ircLDC_RESOGURE.localidad,
      ircLDC_RESOGURE.observacion,
      ircLDC_RESOGURE.resolucion,
      ircLDC_RESOGURE.ini_vigencia,
      ircLDC_RESOGURE.tipo
    )
            returning
      rowid
    into
      orirowid;
  EXCEPTION
    when dup_val_on_index then
      Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_RESOGURE));
      raise ex.CONTROLLED_ERROR;
  END;
  PROCEDURE insRecords
  (
    iotbLDC_RESOGURE in out nocopy tytbLDC_RESOGURE
  )
  IS
    blUseRowID boolean;
  BEGIN
    FillRecordOfTables(iotbLDC_RESOGURE,blUseRowID);
    forall n in iotbLDC_RESOGURE.first..iotbLDC_RESOGURE.last
      insert into LDC_RESOGURE
      (
        codigo,
        localidad,
        observacion,
        resolucion,
        ini_vigencia,
        tipo
      )
      values
      (
        rcRecOfTab.REGRTDOC(n),
        rcRecOfTab.REGRLOC(n),
        rcRecOfTab.REGROBS(n),
        rcRecOfTab.REGRRESO(n),
        rcRecOfTab.REGRFEIN(n),
        rcRecOfTab.REGRTIPO(n)
      );
  EXCEPTION
    when dup_val_on_index then
      Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
      raise ex.CONTROLLED_ERROR;
  END;
  PROCEDURE delRecord
  (
    isbREGRRESO in LDC_RESOGURE.RESOLUCION%type,
    idtREGRFEIN in LDC_RESOGURE.INI_VIGENCIA%type,
    inuREGRLOC in LDC_RESOGURE.LOCALIDAD%type,
    inuLock in number default 1
  )
  IS
    rcError styLDC_RESOGURE;
  BEGIN
    rcError.resolucion := isbREGRRESO;
    rcError.ini_vigencia := idtREGRFEIN;
    rcError.localidad := inuREGRLOC;

    if inuLock=1 then
      LockByPk
      (
        isbREGRRESO,
        idtREGRFEIN,
        inuREGRLOC,
        rcData
      );
    end if;


    delete
    from LDC_RESOGURE
    where
           resolucion=isbREGRRESO and
           ini_vigencia=idtREGRFEIN and
           localidad=inuREGRLOC;
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
    rcError  styLDC_RESOGURE;
  BEGIN
    if inuLock=1 then
      LockByRowId(iriRowID,rcData);
    end if;


    delete
    from LDC_RESOGURE
    where
      rowid = iriRowID
    returning
      codigo,
      localidad,
      observacion
    into
      rcError.codigo,
      rcError.localidad,
      rcError.observacion;
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
    iotbLDC_RESOGURE in out nocopy tytbLDC_RESOGURE,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLDC_RESOGURE;
  BEGIN
    FillRecordOfTables(iotbLDC_RESOGURE, blUseRowID);
        if ( blUseRowId ) then
      if inuLock = 1 then
        for n in iotbLDC_RESOGURE.first .. iotbLDC_RESOGURE.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLDC_RESOGURE.first .. iotbLDC_RESOGURE.last
        delete
        from LDC_RESOGURE
        where
          rowid = rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLDC_RESOGURE.first .. iotbLDC_RESOGURE.last loop
          LockByPk
          (
            rcRecOfTab.REGRRESO(n),
            rcRecOfTab.REGRFEIN(n),
            rcRecOfTab.REGRLOC(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLDC_RESOGURE.first .. iotbLDC_RESOGURE.last
        delete
        from LDC_RESOGURE
        where
               resolucion = rcRecOfTab.REGRRESO(n) and
               ini_vigencia = rcRecOfTab.REGRFEIN(n) and
               localidad = rcRecOfTab.REGRLOC(n);
    end if;
  EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
  END;
  PROCEDURE updRecord
  (
    ircLDC_RESOGURE in styLDC_RESOGURE,
    inuLock in number default 0
  )
  IS
    isbREGRRESO  LDC_RESOGURE.RESOLUCION%type;
    idtREGRFEIN  LDC_RESOGURE.INI_VIGENCIA%type;
    inuREGRLOC  LDC_RESOGURE.LOCALIDAD%type;
  BEGIN
    if ircLDC_RESOGURE.rowid is not null then
      if inuLock=1 then
        LockByRowId(ircLDC_RESOGURE.rowid,rcData);
      end if;
      update LDC_RESOGURE
      set
        codigo = ircLDC_RESOGURE.codigo,
        observacion = ircLDC_RESOGURE.observacion
      where
        rowid = ircLDC_RESOGURE.rowid
      returning
        resolucion,
        ini_vigencia,
        localidad
      into
        isbREGRRESO,
        idtREGRFEIN,
        inuREGRLOC;
    else
      if inuLock=1 then
        LockByPk
        (
          ircLDC_RESOGURE.resolucion,
          ircLDC_RESOGURE.ini_vigencia,
          ircLDC_RESOGURE.localidad,
          rcData
        );
      end if;

      update LDC_RESOGURE
      set
        codigo = ircLDC_RESOGURE.codigo,
        observacion = ircLDC_RESOGURE.observacion
      where
        resolucion = ircLDC_RESOGURE.resolucion and
        ini_vigencia = ircLDC_RESOGURE.ini_vigencia and
        localidad = ircLDC_RESOGURE.localidad
      returning
        resolucion,
        ini_vigencia,
        localidad
      into
        isbREGRRESO,
        idtREGRFEIN,
        inuREGRLOC;
    end if;
    if
      isbREGRRESO is NULL OR
      idtREGRFEIN is NULL OR
      inuREGRLOC is NULL
    then
      raise no_data_found;
    end if;
  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_RESOGURE));
      raise ex.CONTROLLED_ERROR;
  END;
  PROCEDURE updRecords
  (
    iotbLDC_RESOGURE in out nocopy tytbLDC_RESOGURE,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLDC_RESOGURE;
  BEGIN
    FillRecordOfTables(iotbLDC_RESOGURE,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLDC_RESOGURE.first .. iotbLDC_RESOGURE.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLDC_RESOGURE.first .. iotbLDC_RESOGURE.last
        update LDC_RESOGURE
        set
          codigo = rcRecOfTab.REGRTDOC(n),
          observacion = rcRecOfTab.REGROBS(n)
        where
          rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLDC_RESOGURE.first .. iotbLDC_RESOGURE.last loop
          LockByPk
          (
            rcRecOfTab.REGRRESO(n),
            rcRecOfTab.REGRFEIN(n),
            rcRecOfTab.REGRLOC(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLDC_RESOGURE.first .. iotbLDC_RESOGURE.last
        update LDC_RESOGURE
        SET
          codigo = rcRecOfTab.REGRTDOC(n),
          observacion = rcRecOfTab.REGROBS(n)
        where
          resolucion = rcRecOfTab.REGRRESO(n) and
          ini_vigencia = rcRecOfTab.REGRFEIN(n) and
          localidad = rcRecOfTab.REGRLOC(n)
;
    end if;
  END;
  PROCEDURE updREGRTDOC
  (
    isbREGRRESO in LDC_RESOGURE.resolucion%type,
		idtREGRFEIN in LDC_RESOGURE.ini_vigencia%type,
		inuREGRLOC in LDC_RESOGURE.localidad%type,
		isbREGRTDOC$ in LDC_RESOGURE.codigo%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_RESOGURE;
	BEGIN
		rcError.resolucion := isbREGRRESO;
		rcError.ini_vigencia := idtREGRFEIN;
		rcError.localidad := inuREGRLOC;
		if inuLock=1 then
			LockByPk
			(
				isbREGRRESO,
				idtREGRFEIN,
				inuREGRLOC,
				rcData
			);
		end if;

		update LDC_RESOGURE
		set
			codigo = isbREGRTDOC$
		where
			resolucion = isbREGRRESO and
			ini_vigencia = idtREGRFEIN and
			localidad = inuREGRLOC;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.codigo:= isbREGRTDOC$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updREGROBS
	(
		isbREGRRESO in LDC_RESOGURE.resolucion%type,
		idtREGRFEIN in LDC_RESOGURE.ini_vigencia%type,
		inuREGRLOC in LDC_RESOGURE.localidad%type,
		isbREGROBS$ in LDC_RESOGURE.observacion%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_RESOGURE;
	BEGIN
		rcError.resolucion := isbREGRRESO;
		rcError.ini_vigencia := idtREGRFEIN;
		rcError.localidad := inuREGRLOC;
		if inuLock=1 then
			LockByPk
			(
				isbREGRRESO,
				idtREGRFEIN,
				inuREGRLOC,
				rcData
			);
		end if;

		update LDC_RESOGURE
		set
			observacion = isbREGROBS$
		where
			resolucion = isbREGRRESO and
			ini_vigencia = idtREGRFEIN and
			localidad = inuREGRLOC;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.observacion:= isbREGROBS$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fsbGetREGRTDOC
	(
		isbREGRRESO in LDC_RESOGURE.resolucion%type,
		idtREGRFEIN in LDC_RESOGURE.ini_vigencia%type,
		inuREGRLOC in LDC_RESOGURE.localidad%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RESOGURE.CODIGO%type
	IS
		rcError styLDC_RESOGURE;
	BEGIN

		rcError.resolucion := isbREGRRESO;
		rcError.ini_vigencia := idtREGRFEIN;
		rcError.localidad := inuREGRLOC;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		isbREGRRESO,
		 		idtREGRFEIN,
		 		inuREGRLOC
			 )
		then
			 return(rcData.Codigo);
		end if;
		Load
		(
		 		isbREGRRESO,
		 		idtREGRFEIN,
		 		inuREGRLOC
		);
		return(rcData.codigo);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetREGRLOC
	(
		isbREGRRESO in LDC_RESOGURE.resolucion%type,
		idtREGRFEIN in LDC_RESOGURE.ini_vigencia%type,
		inuREGRLOC in LDC_RESOGURE.localidad%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RESOGURE.localidad%type
	IS
		rcError styLDC_RESOGURE;
	BEGIN

		rcError.resolucion := isbREGRRESO;
		rcError.ini_vigencia := idtREGRFEIN;
		rcError.localidad := inuREGRLOC;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		isbREGRRESO,
		 		idtREGRFEIN,
		 		inuREGRLOC
			 )
		then
			 return(rcData.localidad);
		end if;
		Load
		(
		 		isbREGRRESO,
		 		idtREGRFEIN,
		 		inuREGRLOC
		);
		return(rcData.localidad);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetREGROBS
	(
		isbREGRRESO in LDC_RESOGURE.resolucion%type,
		idtREGRFEIN in LDC_RESOGURE.ini_vigencia%type,
		inuREGRLOC in LDC_RESOGURE.localidad%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RESOGURE.observacion%type
	IS
		rcError styLDC_RESOGURE;
	BEGIN

		rcError.resolucion := isbREGRRESO;
		rcError.ini_vigencia := idtREGRFEIN;
		rcError.localidad := inuREGRLOC;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		isbREGRRESO,
		 		idtREGRFEIN,
		 		inuREGRLOC
			 )
		then
			 return(rcData.observacion);
		end if;
		Load
		(
		 		isbREGRRESO,
		 		idtREGRFEIN,
		 		inuREGRLOC
		);
		return(rcData.observacion);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetREGRRESO
	(
		isbREGRRESO in LDC_RESOGURE.resolucion%type,
		idtREGRFEIN in LDC_RESOGURE.ini_vigencia%type,
		inuREGRLOC in LDC_RESOGURE.localidad%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RESOGURE.resolucion%type
	IS
		rcError styLDC_RESOGURE;
	BEGIN

		rcError.resolucion := isbREGRRESO;
		rcError.ini_vigencia := idtREGRFEIN;
		rcError.localidad := inuREGRLOC;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		isbREGRRESO,
		 		idtREGRFEIN,
		 		inuREGRLOC
			 )
		then
			 return(rcData.resolucion);
		end if;
		Load
		(
		 		isbREGRRESO,
		 		idtREGRFEIN,
		 		inuREGRLOC
		);
		return(rcData.resolucion);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetREGRFEIN
	(
		isbREGRRESO in LDC_RESOGURE.resolucion%type,
		idtREGRFEIN in LDC_RESOGURE.ini_vigencia%type,
		inuREGRLOC in LDC_RESOGURE.localidad%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_RESOGURE.ini_vigencia%type
	IS
		rcError styLDC_RESOGURE;
	BEGIN

		rcError.resolucion := isbREGRRESO;
		rcError.ini_vigencia := idtREGRFEIN;
		rcError.localidad := inuREGRLOC;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		isbREGRRESO,
		 		idtREGRFEIN,
		 		inuREGRLOC
			 )
		then
			 return(rcData.ini_vigencia);
		end if;
		Load
		(
		 		isbREGRRESO,
		 		idtREGRFEIN,
		 		inuREGRLOC
		);
		return(rcData.ini_vigencia);
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
end DALDC_RESOGURE;
/
PROMPT Otorgando permisos de ejecucion a DALDC_RESOGURE
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_RESOGURE', 'ADM_PERSON');
END;
/