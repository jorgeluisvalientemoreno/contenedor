CREATE OR REPLACE PACKAGE adm_person.DALD_temp_clob_fact
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
    inuTEMP_CLOB_FACT_Id in LD_temp_clob_fact.TEMP_CLOB_FACT_Id%type
  )
  IS
    SELECT LD_temp_clob_fact.*,LD_temp_clob_fact.rowid
    FROM LD_temp_clob_fact
    WHERE
      TEMP_CLOB_FACT_Id = inuTEMP_CLOB_FACT_Id;


  /* Cursor general para acceso por RowId */
  CURSOR cuRecordByRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_temp_clob_fact.*,LD_temp_clob_fact.rowid
    FROM LD_temp_clob_fact
    WHERE
      rowId = irirowid;


  /* Subtipos */
  subtype styLD_temp_clob_fact  is  cuRecord%rowtype;
  type tyRefCursor is  REF CURSOR;

  /*Tipos*/
  type tytbLD_temp_clob_fact is table of styLD_temp_clob_fact index by binary_integer;
  type tyrfRecords is ref cursor return styLD_temp_clob_fact;

  /* Tipos referenciando al registro */
  type tytbTemp_Clob_Fact_Id is table of LD_temp_clob_fact.Temp_Clob_Fact_Id%type index by binary_integer;
  type tytbTemplate_Id is table of LD_temp_clob_fact.Template_Id%type index by binary_integer;
  type tytbSesion is table of LD_temp_clob_fact.Sesion%type index by binary_integer;
  type tytbDocudocu is table of LD_temp_clob_fact.Docudocu%type index by binary_integer;
  type tytbPackage_Id is table of LD_temp_clob_fact.Package_Id%type index by binary_integer;
  type tytbrowid is table of rowid index by binary_integer;

  type tyrcLD_temp_clob_fact is record
  (

    Temp_Clob_Fact_Id   tytbTemp_Clob_Fact_Id,
    Template_Id   tytbTemplate_Id,
    Sesion   tytbSesion,
    Docudocu   tytbDocudocu,
    Package_Id   tytbPackage_Id,
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
    inuTEMP_CLOB_FACT_Id in LD_temp_clob_fact.TEMP_CLOB_FACT_Id%type
  )
  RETURN boolean;

   PROCEDURE AccKey
   (
     inuTEMP_CLOB_FACT_Id in LD_temp_clob_fact.TEMP_CLOB_FACT_Id%type
  );

  PROCEDURE AccKeyByRowId
  (
    iriRowID    in rowid
  );

  PROCEDURE ValDuplicate
  (
     inuTEMP_CLOB_FACT_Id in LD_temp_clob_fact.TEMP_CLOB_FACT_Id%type
  );

  PROCEDURE getRecord
  (
    inuTEMP_CLOB_FACT_Id in LD_temp_clob_fact.TEMP_CLOB_FACT_Id%type,
    orcRecord out nocopy styLD_temp_clob_fact
  );

  FUNCTION frcGetRcData
  (
    inuTEMP_CLOB_FACT_Id in LD_temp_clob_fact.TEMP_CLOB_FACT_Id%type
  )
  RETURN styLD_temp_clob_fact;

  FUNCTION frcGetRcData
  RETURN styLD_temp_clob_fact;

  FUNCTION frcGetRecord
  (
    inuTEMP_CLOB_FACT_Id in LD_temp_clob_fact.TEMP_CLOB_FACT_Id%type
  )
  RETURN styLD_temp_clob_fact;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_temp_clob_fact
  );

  FUNCTION frfGetRecords
  (
    isbCriteria in varchar2 default null,
    iblLock in boolean default false
  )
  RETURN tyRefCursor;

  PROCEDURE insRecord
  (
    ircLD_temp_clob_fact in styLD_temp_clob_fact
  );

     PROCEDURE insRecord
  (
    ircLD_temp_clob_fact in styLD_temp_clob_fact,
    orirowid   out varchar2
  );

  PROCEDURE insRecords
  (
    iotbLD_temp_clob_fact in out nocopy tytbLD_temp_clob_fact
  );

  PROCEDURE delRecord
  (
    inuTEMP_CLOB_FACT_Id in LD_temp_clob_fact.TEMP_CLOB_FACT_Id%type,
    inuLock in number default 1
  );

  PROCEDURE delByRowID
  (
    iriRowID    in rowid,
    inuLock in number default 1
  );

  PROCEDURE delRecords
  (
    iotbLD_temp_clob_fact in out nocopy tytbLD_temp_clob_fact,
    inuLock in number default 1
  );

  PROCEDURE updRecord
  (
    ircLD_temp_clob_fact in styLD_temp_clob_fact,
    inuLock    in number default 0
  );

  PROCEDURE updRecords
  (
    iotbLD_temp_clob_fact in out nocopy tytbLD_temp_clob_fact,
    inuLock in number default 1
  );

    PROCEDURE updTemplate_Id
    (
        inuTEMP_CLOB_FACT_Id   in LD_temp_clob_fact.TEMP_CLOB_FACT_Id%type,
        isbTemplate_Id$  in LD_temp_clob_fact.Template_Id%type,
        inuLock    in number default 0
      );

    PROCEDURE updSesion
    (
        inuTEMP_CLOB_FACT_Id   in LD_temp_clob_fact.TEMP_CLOB_FACT_Id%type,
        inuSesion$  in LD_temp_clob_fact.Sesion%type,
        inuLock    in number default 0
      );

    PROCEDURE updDocudocu
    (
        inuTEMP_CLOB_FACT_Id   in LD_temp_clob_fact.TEMP_CLOB_FACT_Id%type,
        inuLock    in number default 0
      );

    PROCEDURE updPackage_Id
    (
        inuTEMP_CLOB_FACT_Id   in LD_temp_clob_fact.TEMP_CLOB_FACT_Id%type,
        inuPackage_Id$  in LD_temp_clob_fact.Package_Id%type,
        inuLock    in number default 0
      );

      FUNCTION fnuGetTemp_Clob_Fact_Id
      (
          inuTEMP_CLOB_FACT_Id in LD_temp_clob_fact.TEMP_CLOB_FACT_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_temp_clob_fact.Temp_Clob_Fact_Id%type;

      FUNCTION fsbGetTemplate_Id
      (
          inuTEMP_CLOB_FACT_Id in LD_temp_clob_fact.TEMP_CLOB_FACT_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_temp_clob_fact.Template_Id%type;

      FUNCTION fnuGetSesion
      (
          inuTEMP_CLOB_FACT_Id in LD_temp_clob_fact.TEMP_CLOB_FACT_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_temp_clob_fact.Sesion%type;


      FUNCTION fnuGetPackage_Id
      (
          inuTEMP_CLOB_FACT_Id in LD_temp_clob_fact.TEMP_CLOB_FACT_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_temp_clob_fact.Package_Id%type;


  PROCEDURE LockByPk
  (
    inuTEMP_CLOB_FACT_Id in LD_temp_clob_fact.TEMP_CLOB_FACT_Id%type,
    orcLD_temp_clob_fact  out styLD_temp_clob_fact
  );

  PROCEDURE LockByRowID
  (
    irirowid    in  varchar2,
    orcLD_temp_clob_fact  out styLD_temp_clob_fact
  );

  PROCEDURE SetUseCache
  (
    iblUseCache    in  boolean
  );
END DALD_temp_clob_fact;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_temp_clob_fact
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO156577';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_TEMP_CLOB_FACT';
    cnuGeEntityId constant varchar2(30) := 8402; -- Id de Ge_entity

  /* Cursor para bloqueo de un registro por llave primaria */
  CURSOR cuLockRcByPk
  (
    inuTEMP_CLOB_FACT_Id in LD_temp_clob_fact.TEMP_CLOB_FACT_Id%type
  )
  IS
    SELECT LD_temp_clob_fact.*,LD_temp_clob_fact.rowid
    FROM LD_temp_clob_fact
    WHERE  TEMP_CLOB_FACT_Id = inuTEMP_CLOB_FACT_Id
    FOR UPDATE NOWAIT;

  /* Cursor para bloqueo de un registro por rowid */
  CURSOR cuLockRcbyRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_temp_clob_fact.*,LD_temp_clob_fact.rowid
    FROM LD_temp_clob_fact
    WHERE
      rowId = irirowid
    FOR UPDATE NOWAIT;
  /*Tipos*/
  type tyrfLD_temp_clob_fact is ref cursor;

  /*Variables Globales*/
  rcRecOfTab tyrcLD_temp_clob_fact;

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

  FUNCTION fsbPrimaryKey( rcI in styLD_temp_clob_fact default rcData )
  return varchar2
  IS
    sbPk varchar2(500);
  BEGIN
    sbPk:='[';
    sbPk:=sbPk||ut_convert.fsbToChar(rcI.TEMP_CLOB_FACT_Id);
    sbPk:=sbPk||']';
    return sbPk;
  END;

  PROCEDURE LockByPk
  (
    inuTEMP_CLOB_FACT_Id in LD_temp_clob_fact.TEMP_CLOB_FACT_Id%type,
    orcLD_temp_clob_fact  out styLD_temp_clob_fact
  )
  IS
    rcError styLD_temp_clob_fact;
  BEGIN
    rcError.TEMP_CLOB_FACT_Id := inuTEMP_CLOB_FACT_Id;

    Open cuLockRcByPk
    (
      inuTEMP_CLOB_FACT_Id
    );

    fetch cuLockRcByPk into orcLD_temp_clob_fact;
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
    orcLD_temp_clob_fact  out styLD_temp_clob_fact
  )
  IS
  BEGIN
    Open cuLockRcbyRowId
    (
      irirowid
    );

    fetch cuLockRcbyRowId into orcLD_temp_clob_fact;
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
    itbLD_temp_clob_fact  in out nocopy tytbLD_temp_clob_fact
  )
  IS
  BEGIN
      rcRecOfTab.Temp_Clob_Fact_Id.delete;
      rcRecOfTab.Template_Id.delete;
      rcRecOfTab.Sesion.delete;
      rcRecOfTab.Docudocu.delete;
      rcRecOfTab.Package_Id.delete;
      rcRecOfTab.row_id.delete;
  END;
  PROCEDURE FillRecordOfTables
  (
    itbLD_temp_clob_fact  in out nocopy tytbLD_temp_clob_fact,
    oblUseRowId out boolean
  )
  IS
  BEGIN
    DelRecordOfTables(itbLD_temp_clob_fact);
    for n in itbLD_temp_clob_fact.first .. itbLD_temp_clob_fact.last loop
      rcRecOfTab.Temp_Clob_Fact_Id(n) := itbLD_temp_clob_fact(n).Temp_Clob_Fact_Id;
      rcRecOfTab.Template_Id(n) := itbLD_temp_clob_fact(n).Template_Id;
      rcRecOfTab.Sesion(n) := itbLD_temp_clob_fact(n).Sesion;
      rcRecOfTab.Docudocu(n) := itbLD_temp_clob_fact(n).Docudocu;
      rcRecOfTab.Package_Id(n) := itbLD_temp_clob_fact(n).Package_Id;
      rcRecOfTab.row_id(n) := itbLD_temp_clob_fact(n).rowid;
      -- Indica si el rowid es Nulo
      oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
    end loop;
  END;


  PROCEDURE Load
  (
    inuTEMP_CLOB_FACT_Id in LD_temp_clob_fact.TEMP_CLOB_FACT_Id%type
  )
  IS
    rcRecordNull cuRecord%rowtype;
  BEGIN
    if cuRecord%isopen then
      close cuRecord;
    end if;
    open cuRecord
    (
      inuTEMP_CLOB_FACT_Id
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
    inuTEMP_CLOB_FACT_Id in LD_temp_clob_fact.TEMP_CLOB_FACT_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    if (
      inuTEMP_CLOB_FACT_Id = rcData.TEMP_CLOB_FACT_Id
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
    inuTEMP_CLOB_FACT_Id in LD_temp_clob_fact.TEMP_CLOB_FACT_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    Load
    (
      inuTEMP_CLOB_FACT_Id
    );
    return(TRUE);
  EXCEPTION
    when no_data_found then
      return(FALSE);
  END;

  PROCEDURE AccKey
  (
    inuTEMP_CLOB_FACT_Id in LD_temp_clob_fact.TEMP_CLOB_FACT_Id%type
  )
  IS
    rcError styLD_temp_clob_fact;
  BEGIN    rcError.TEMP_CLOB_FACT_Id:=inuTEMP_CLOB_FACT_Id;

    Load
    (
      inuTEMP_CLOB_FACT_Id
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
    inuTEMP_CLOB_FACT_Id in LD_temp_clob_fact.TEMP_CLOB_FACT_Id%type
  )
  IS
  BEGIN
    Load
    (
      inuTEMP_CLOB_FACT_Id
    );
    Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
    raise ex.CONTROLLED_ERROR;

  EXCEPTION
    when no_data_found then
      null;
  END;

  PROCEDURE getRecord
  (
    inuTEMP_CLOB_FACT_Id in LD_temp_clob_fact.TEMP_CLOB_FACT_Id%type,
    orcRecord out nocopy styLD_temp_clob_fact
  )
  IS
    rcError styLD_temp_clob_fact;
  BEGIN    rcError.TEMP_CLOB_FACT_Id:=inuTEMP_CLOB_FACT_Id;

    Load
    (
      inuTEMP_CLOB_FACT_Id
    );
    orcRecord := rcData;
  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRecord
  (
    inuTEMP_CLOB_FACT_Id in LD_temp_clob_fact.TEMP_CLOB_FACT_Id%type
  )
  RETURN styLD_temp_clob_fact
  IS
    rcError styLD_temp_clob_fact;
  BEGIN
    rcError.TEMP_CLOB_FACT_Id:=inuTEMP_CLOB_FACT_Id;

    Load
    (
      inuTEMP_CLOB_FACT_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  (
    inuTEMP_CLOB_FACT_Id in LD_temp_clob_fact.TEMP_CLOB_FACT_Id%type
  )
  RETURN styLD_temp_clob_fact
  IS
    rcError styLD_temp_clob_fact;
  BEGIN
    rcError.TEMP_CLOB_FACT_Id:=inuTEMP_CLOB_FACT_Id;
        -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
         inuTEMP_CLOB_FACT_Id
       )
    then
       return(rcData);
    end if;
    Load
    (
      inuTEMP_CLOB_FACT_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  RETURN styLD_temp_clob_fact
  IS
  BEGIN
    return(rcData);
  END;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_temp_clob_fact
  )
  IS
    rfLD_temp_clob_fact tyrfLD_temp_clob_fact;
    n number(4) := 1;
    sbFullQuery VARCHAR2 (32000) := 'SELECT
                LD_temp_clob_fact.Temp_Clob_Fact_Id,
                LD_temp_clob_fact.Template_Id,
                LD_temp_clob_fact.Sesion,
                LD_temp_clob_fact.Docudocu,
                LD_temp_clob_fact.Package_Id,
                LD_temp_clob_fact.rowid
                FROM LD_temp_clob_fact';
    nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
  BEGIN
    otbResult.delete;
    if isbQuery is not NULL and length(isbQuery) > 0 then
      sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
    end if;
    open rfLD_temp_clob_fact for sbFullQuery;
    fetch rfLD_temp_clob_fact bulk collect INTO otbResult;
    close rfLD_temp_clob_fact;
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
    sbSQL  VARCHAR2 (32000) := 'select
                LD_temp_clob_fact.Temp_Clob_Fact_Id,
                LD_temp_clob_fact.Template_Id,
                LD_temp_clob_fact.Sesion,
                LD_temp_clob_fact.Docudocu,
                LD_temp_clob_fact.Package_Id,
                LD_temp_clob_fact.rowid
                FROM LD_temp_clob_fact';
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
    ircLD_temp_clob_fact in styLD_temp_clob_fact
  )
  IS
    rirowid varchar2(200);
  BEGIN
    insRecord(ircLD_temp_clob_fact,rirowid);
  END;

  PROCEDURE insRecord
  (
    ircLD_temp_clob_fact in styLD_temp_clob_fact,
    orirowid   out varchar2
  )
  IS
  BEGIN
    if ircLD_temp_clob_fact.TEMP_CLOB_FACT_Id is NULL then
      Errors.SetError(cnuINS_PK_NULL,
                      fsbGetMessageDescription||'|TEMP_CLOB_FACT_Id');
      raise ex.controlled_error;
    end if;
    insert into LD_temp_clob_fact
    (
      Temp_Clob_Fact_Id,
      Template_Id,
      Sesion,
      Docudocu,
      Package_Id
    )
    values
    (
      ircLD_temp_clob_fact.Temp_Clob_Fact_Id,
      ircLD_temp_clob_fact.Template_Id,
      ircLD_temp_clob_fact.Sesion,
      ircLD_temp_clob_fact.Docudocu,
      ircLD_temp_clob_fact.Package_Id
    )
            returning
      rowid
    into
      orirowid;
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_temp_clob_fact));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE insRecords
  (
    iotbLD_temp_clob_fact in out nocopy tytbLD_temp_clob_fact
  )
  IS
    blUseRowID boolean;
  BEGIN
    FillRecordOfTables(iotbLD_temp_clob_fact, blUseRowID);
    forall n in iotbLD_temp_clob_fact.first..iotbLD_temp_clob_fact.last
      insert into LD_temp_clob_fact
      (
      Temp_Clob_Fact_Id,
      Template_Id,
      Sesion,
      Docudocu,
      Package_Id
    )
    values
    (
      rcRecOfTab.Temp_Clob_Fact_Id(n),
      rcRecOfTab.Template_Id(n),
      rcRecOfTab.Sesion(n),
      rcRecOfTab.Docudocu(n),
      rcRecOfTab.Package_Id(n)
      );
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE delRecord
  (
    inuTEMP_CLOB_FACT_Id in LD_temp_clob_fact.TEMP_CLOB_FACT_Id%type,
    inuLock in number default 1
  )
  IS
    rcError styLD_temp_clob_fact;
  BEGIN
    rcError.TEMP_CLOB_FACT_Id:=inuTEMP_CLOB_FACT_Id;

    if inuLock=1 then
      LockByPk
      (
        inuTEMP_CLOB_FACT_Id,
        rcData
      );
    end if;

    delete
    from LD_temp_clob_fact
    where
           TEMP_CLOB_FACT_Id=inuTEMP_CLOB_FACT_Id;
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
    iriRowID   in rowid,
    inuLock    in number default 1
  )
  IS
    rcRecordNull cuRecord%rowtype;
    rcError  styLD_temp_clob_fact;
  BEGIN
    if inuLock=1 then
      LockByRowId(iriRowID,rcData);
    end if;

    delete
    from LD_temp_clob_fact
    where
      rowid = iriRowID
    returning
   TEMP_CLOB_FACT_Id
    into
      rcError.TEMP_CLOB_FACT_Id;

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
    iotbLD_temp_clob_fact in out nocopy tytbLD_temp_clob_fact,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_temp_clob_fact;
  BEGIN
    FillRecordOfTables(iotbLD_temp_clob_fact, blUseRowID);
       if ( blUseRowId ) then
      if inuLock = 1 then
        for n in iotbLD_temp_clob_fact.first .. iotbLD_temp_clob_fact.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_temp_clob_fact.first .. iotbLD_temp_clob_fact.last
        delete
        from LD_temp_clob_fact
        where
          rowid = rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_temp_clob_fact.first .. iotbLD_temp_clob_fact.last loop
          LockByPk
          (
              rcRecOfTab.TEMP_CLOB_FACT_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_temp_clob_fact.first .. iotbLD_temp_clob_fact.last
        delete
        from LD_temp_clob_fact
        where
               TEMP_CLOB_FACT_Id = rcRecOfTab.TEMP_CLOB_FACT_Id(n);
    end if;
  EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecord
  (
    ircLD_temp_clob_fact in styLD_temp_clob_fact,
    inuLock    in number default 0
  )
  IS
    nuTEMP_CLOB_FACT_Id LD_temp_clob_fact.TEMP_CLOB_FACT_Id%type;

  BEGIN
    if ircLD_temp_clob_fact.rowid is not null then
      if inuLock=1 then
        LockByRowId(ircLD_temp_clob_fact.rowid,rcData);
      end if;
      update LD_temp_clob_fact
      set

        Template_Id = ircLD_temp_clob_fact.Template_Id,
        Sesion = ircLD_temp_clob_fact.Sesion,
        Docudocu = ircLD_temp_clob_fact.Docudocu,
        Package_Id = ircLD_temp_clob_fact.Package_Id
      where
        rowid = ircLD_temp_clob_fact.rowid
      returning
    TEMP_CLOB_FACT_Id
      into
        nuTEMP_CLOB_FACT_Id;

    else
      if inuLock=1 then
        LockByPk
        (
          ircLD_temp_clob_fact.TEMP_CLOB_FACT_Id,
          rcData
        );
      end if;

      update LD_temp_clob_fact
      set
        Template_Id = ircLD_temp_clob_fact.Template_Id,
        Sesion = ircLD_temp_clob_fact.Sesion,
        Docudocu = ircLD_temp_clob_fact.Docudocu,
        Package_Id = ircLD_temp_clob_fact.Package_Id
      where
             TEMP_CLOB_FACT_Id = ircLD_temp_clob_fact.TEMP_CLOB_FACT_Id
      returning
    TEMP_CLOB_FACT_Id
      into
        nuTEMP_CLOB_FACT_Id;
    end if;

    if
      nuTEMP_CLOB_FACT_Id is NULL
    then
      raise no_data_found;
    end if;

  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_temp_clob_fact));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecords
  (
    iotbLD_temp_clob_fact in out nocopy tytbLD_temp_clob_fact,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_temp_clob_fact;
  BEGIN
    FillRecordOfTables(iotbLD_temp_clob_fact,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_temp_clob_fact.first .. iotbLD_temp_clob_fact.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_temp_clob_fact.first .. iotbLD_temp_clob_fact.last
        update LD_temp_clob_fact
        set

            Template_Id = rcRecOfTab.Template_Id(n),
            Sesion = rcRecOfTab.Sesion(n),
            Docudocu = rcRecOfTab.Docudocu(n),
            Package_Id = rcRecOfTab.Package_Id(n)
          where
          rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_temp_clob_fact.first .. iotbLD_temp_clob_fact.last loop
          LockByPk
          (
              rcRecOfTab.TEMP_CLOB_FACT_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_temp_clob_fact.first .. iotbLD_temp_clob_fact.last
        update LD_temp_clob_fact
        set
          Template_Id = rcRecOfTab.Template_Id(n),
          Sesion = rcRecOfTab.Sesion(n),
          Docudocu = rcRecOfTab.Docudocu(n),
          Package_Id = rcRecOfTab.Package_Id(n)
          where
          TEMP_CLOB_FACT_Id = rcRecOfTab.TEMP_CLOB_FACT_Id(n)
;
    end if;
  END;

  PROCEDURE updTemplate_Id
  (
    inuTEMP_CLOB_FACT_Id in LD_temp_clob_fact.TEMP_CLOB_FACT_Id%type,
    isbTemplate_Id$ in LD_temp_clob_fact.Template_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_temp_clob_fact;
  BEGIN
    rcError.TEMP_CLOB_FACT_Id := inuTEMP_CLOB_FACT_Id;
    if inuLock=1 then
      LockByPk
      (
        inuTEMP_CLOB_FACT_Id,
        rcData
      );
    end if;

    update LD_temp_clob_fact
    set
      Template_Id = isbTemplate_Id$
    where
      TEMP_CLOB_FACT_Id = inuTEMP_CLOB_FACT_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Template_Id:= isbTemplate_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updSesion
  (
    inuTEMP_CLOB_FACT_Id in LD_temp_clob_fact.TEMP_CLOB_FACT_Id%type,
    inuSesion$ in LD_temp_clob_fact.Sesion%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_temp_clob_fact;
  BEGIN
    rcError.TEMP_CLOB_FACT_Id := inuTEMP_CLOB_FACT_Id;
    if inuLock=1 then
      LockByPk
      (
        inuTEMP_CLOB_FACT_Id,
        rcData
      );
    end if;

    update LD_temp_clob_fact
    set
      Sesion = inuSesion$
    where
      TEMP_CLOB_FACT_Id = inuTEMP_CLOB_FACT_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Sesion:= inuSesion$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updDocudocu
  (
    inuTEMP_CLOB_FACT_Id in LD_temp_clob_fact.TEMP_CLOB_FACT_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_temp_clob_fact;
  BEGIN
    rcError.TEMP_CLOB_FACT_Id := inuTEMP_CLOB_FACT_Id;
    if inuLock=1 then
      LockByPk
      (
        inuTEMP_CLOB_FACT_Id,
        rcData
      );
    end if;

    /*update LD_temp_clob_fact
    set
    where
      TEMP_CLOB_FACT_Id = inuTEMP_CLOB_FACT_Id;

    if sql%notfound then
      raise no_data_found;
    end if;*/


  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updPackage_Id
  (
    inuTEMP_CLOB_FACT_Id in LD_temp_clob_fact.TEMP_CLOB_FACT_Id%type,
    inuPackage_Id$ in LD_temp_clob_fact.Package_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_temp_clob_fact;
  BEGIN
    rcError.TEMP_CLOB_FACT_Id := inuTEMP_CLOB_FACT_Id;
    if inuLock=1 then
      LockByPk
      (
        inuTEMP_CLOB_FACT_Id,
        rcData
      );
    end if;

    update LD_temp_clob_fact
    set
      Package_Id = inuPackage_Id$
    where
      TEMP_CLOB_FACT_Id = inuTEMP_CLOB_FACT_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Package_Id:= inuPackage_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;


  FUNCTION fnuGetTemp_Clob_Fact_Id
  (
    inuTEMP_CLOB_FACT_Id in LD_temp_clob_fact.TEMP_CLOB_FACT_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_temp_clob_fact.Temp_Clob_Fact_Id%type
  IS
    rcError styLD_temp_clob_fact;
  BEGIN

    rcError.TEMP_CLOB_FACT_Id := inuTEMP_CLOB_FACT_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuTEMP_CLOB_FACT_Id
       )
    then
       return(rcData.Temp_Clob_Fact_Id);
    end if;
    Load
    (
      inuTEMP_CLOB_FACT_Id
    );
    return(rcData.Temp_Clob_Fact_Id);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fsbGetTemplate_Id
  (
    inuTEMP_CLOB_FACT_Id in LD_temp_clob_fact.TEMP_CLOB_FACT_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_temp_clob_fact.Template_Id%type
  IS
    rcError styLD_temp_clob_fact;
  BEGIN

    rcError.TEMP_CLOB_FACT_Id:=inuTEMP_CLOB_FACT_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuTEMP_CLOB_FACT_Id
       )
    then
       return(rcData.Template_Id);
    end if;
    Load
    (
      inuTEMP_CLOB_FACT_Id
    );
    return(rcData.Template_Id);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetSesion
  (
    inuTEMP_CLOB_FACT_Id in LD_temp_clob_fact.TEMP_CLOB_FACT_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_temp_clob_fact.Sesion%type
  IS
    rcError styLD_temp_clob_fact;
  BEGIN

    rcError.TEMP_CLOB_FACT_Id := inuTEMP_CLOB_FACT_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuTEMP_CLOB_FACT_Id
       )
    then
       return(rcData.Sesion);
    end if;
    Load
    (
      inuTEMP_CLOB_FACT_Id
    );
    return(rcData.Sesion);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetPackage_Id
  (
    inuTEMP_CLOB_FACT_Id in LD_temp_clob_fact.TEMP_CLOB_FACT_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_temp_clob_fact.Package_Id%type
  IS
    rcError styLD_temp_clob_fact;
  BEGIN

    rcError.TEMP_CLOB_FACT_Id := inuTEMP_CLOB_FACT_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuTEMP_CLOB_FACT_Id
       )
    then
       return(rcData.Package_Id);
    end if;
    Load
    (
      inuTEMP_CLOB_FACT_Id
    );
    return(rcData.Package_Id);
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
end DALD_temp_clob_fact;
/
PROMPT Otorgando permisos de ejecucion a DALD_TEMP_CLOB_FACT
BEGIN
    pkg_utilidades.praplicarpermisos('DALD_TEMP_CLOB_FACT', 'ADM_PERSON');
END;
/