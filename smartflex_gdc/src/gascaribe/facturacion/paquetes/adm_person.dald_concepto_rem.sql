CREATE OR REPLACE PACKAGE adm_person.dald_concepto_rem IS
/***************************************************************************
   Historia de Modificaciones
   Autor       Fecha        Descripcion.
   Adrianavg   11/06/2024   OSF-2813: Migrar del esquema OPEN al esquema ADM_PERSON
   ***************************************************************************/
  /* Cursor general para acceso por Llave Primaria */
  CURSOR cuRecord(
    inuCONCEPTO_REM_Id in LD_concepto_rem.CONCEPTO_REM_Id%type) IS
    SELECT LD_concepto_rem.*,LD_concepto_rem.rowid
    FROM LD_concepto_rem
    WHERE
      CONCEPTO_REM_Id = inuCONCEPTO_REM_Id;


  /* Cursor general para acceso por RowId */
  CURSOR cuRecordByRowId(
    irirowid in varchar2) IS
    SELECT LD_concepto_rem.*,LD_concepto_rem.rowid
    FROM LD_concepto_rem
    WHERE rowId = irirowid;


  /* Subtipos */
  subtype styLD_concepto_rem  is  cuRecord%rowtype;
  type tyRefCursor is  REF CURSOR;

  /*Tipos*/
  type tytbLD_concepto_rem is table of styLD_concepto_rem index by binary_integer;
  type tyrfRecords is ref cursor return styLD_concepto_rem;

  /* Tipos referenciando al registro */
  type tytbConcepto_Rem_Id is table of LD_concepto_rem.Concepto_Rem_Id%type index by binary_integer;
  type tytbUbication_Id is table of LD_concepto_rem.Ubication_Id%type index by binary_integer;
  type tytbAsig_Value is table of LD_concepto_rem.Asig_Value%type index by binary_integer;
  type tytbSesion is table of LD_concepto_rem.Sesion%type index by binary_integer;
  type tytbCreate_Date is table of LD_concepto_rem.Create_Date%type index by binary_integer;
  type tytbrowid is table of rowid index by binary_integer;

  type tyrcLD_concepto_rem is record(

    Concepto_Rem_Id   tytbConcepto_Rem_Id,
    Ubication_Id   tytbUbication_Id,
    Asig_Value   tytbAsig_Value,
    Sesion   tytbSesion,
    Create_Date   tytbCreate_Date,
    row_id tytbrowid);


   /***** Metodos Publicos ****/
  /*Obtener el ID de la tabla en Ge_Entity*/
  FUNCTION fnuGetEntityIdByName(isbTName IN ge_entity.name_%TYPE)
     RETURN ge_entity.entity_id%TYPE;
    FUNCTION fsbVersion RETURN varchar2;

  FUNCTION fsbGetMessageDescription return varchar2;

  PROCEDURE ClearMemory;

   FUNCTION fblExist(
    inuCONCEPTO_REM_Id in LD_concepto_rem.CONCEPTO_REM_Id%type) RETURN boolean;

   PROCEDURE AccKey(
     inuCONCEPTO_REM_Id in LD_concepto_rem.CONCEPTO_REM_Id%type);

  PROCEDURE AccKeyByRowId(
    iriRowID    in rowid);

  PROCEDURE ValDuplicate(
     inuCONCEPTO_REM_Id in LD_concepto_rem.CONCEPTO_REM_Id%type);

  PROCEDURE getRecord(
    inuCONCEPTO_REM_Id in LD_concepto_rem.CONCEPTO_REM_Id%type,
    orcRecord out nocopy styLD_concepto_rem
  );

  FUNCTION frcGetRcData(
    inuCONCEPTO_REM_Id in LD_concepto_rem.CONCEPTO_REM_Id%type)
  RETURN styLD_concepto_rem;

  FUNCTION frcGetRcData
  RETURN styLD_concepto_rem;

  FUNCTION frcGetRecord(
    inuCONCEPTO_REM_Id in LD_concepto_rem.CONCEPTO_REM_Id%type)
  RETURN styLD_concepto_rem;

  PROCEDURE getRecords(
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_concepto_rem
  );

  FUNCTION frfGetRecords(
    isbCriteria in varchar2 default null,
    iblLock in boolean default false)
  RETURN tyRefCursor;

  PROCEDURE insRecord(
    ircLD_concepto_rem in styLD_concepto_rem
  );

     PROCEDURE insRecord(
    ircLD_concepto_rem in styLD_concepto_rem,
    orirowid   out varchar2);

  PROCEDURE insRecords(
    iotbLD_concepto_rem in out nocopy tytbLD_concepto_rem
  );

  PROCEDURE delRecord(
    inuCONCEPTO_REM_Id in LD_concepto_rem.CONCEPTO_REM_Id%type, inuLock in number default 1);

  PROCEDURE delByRowID(
    iriRowID    in rowid,
    inuLock in number default 1);

  PROCEDURE delRecords
  (
    iotbLD_concepto_rem in out nocopy tytbLD_concepto_rem,
    inuLock in number default 1
  );

  PROCEDURE updRecord
  (
    ircLD_concepto_rem in styLD_concepto_rem,
    inuLock    in number default 0
  );

  PROCEDURE updRecords
  (
    iotbLD_concepto_rem in out nocopy tytbLD_concepto_rem,
    inuLock in number default 1
  );

    PROCEDURE updUbication_Id
    (
        inuCONCEPTO_REM_Id   in LD_concepto_rem.CONCEPTO_REM_Id%type,
        inuUbication_Id$  in LD_concepto_rem.Ubication_Id%type,
        inuLock    in number default 0);

    PROCEDURE updAsig_Value
    (
        inuCONCEPTO_REM_Id   in LD_concepto_rem.CONCEPTO_REM_Id%type,
        inuAsig_Value$  in LD_concepto_rem.Asig_Value%type,
        inuLock    in number default 0);

    PROCEDURE updSesion
    (
        inuCONCEPTO_REM_Id   in LD_concepto_rem.CONCEPTO_REM_Id%type,
        inuSesion$  in LD_concepto_rem.Sesion%type,
        inuLock    in number default 0);

    PROCEDURE updCreate_Date
    (
        inuCONCEPTO_REM_Id   in LD_concepto_rem.CONCEPTO_REM_Id%type,
        idtCreate_Date$  in LD_concepto_rem.Create_Date%type,
        inuLock    in number default 0);

      FUNCTION fnuGetConcepto_Rem_Id
      (
          inuCONCEPTO_REM_Id in LD_concepto_rem.CONCEPTO_REM_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_concepto_rem.Concepto_Rem_Id%type;

      FUNCTION fnuGetUbication_Id
      (
          inuCONCEPTO_REM_Id in LD_concepto_rem.CONCEPTO_REM_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_concepto_rem.Ubication_Id%type;

      FUNCTION fnuGetAsig_Value
      (
          inuCONCEPTO_REM_Id in LD_concepto_rem.CONCEPTO_REM_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_concepto_rem.Asig_Value%type;

      FUNCTION fnuGetSesion
      (
          inuCONCEPTO_REM_Id in LD_concepto_rem.CONCEPTO_REM_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_concepto_rem.Sesion%type;

      FUNCTION fdtGetCreate_Date
      (
          inuCONCEPTO_REM_Id in LD_concepto_rem.CONCEPTO_REM_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_concepto_rem.Create_Date%type;


  PROCEDURE LockByPk
  (
    inuCONCEPTO_REM_Id in LD_concepto_rem.CONCEPTO_REM_Id%type,
    orcLD_concepto_rem  out styLD_concepto_rem
  );

  PROCEDURE LockByRowID
  (
    irirowid    in  varchar2,
    orcLD_concepto_rem  out styLD_concepto_rem
  );

  PROCEDURE SetUseCache
  (
    iblUseCache    in  boolean
  );
END DALD_concepto_rem;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_concepto_rem
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO156577';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_CONCEPTO_REM';
    cnuGeEntityId constant varchar2(30) := fnuGetEntityIdByName('LD_CONCEPTO_REM'); -- Id de Ge_entity

  /* Cursor para bloqueo de un registro por llave primaria */
  CURSOR cuLockRcByPk
  (
    inuCONCEPTO_REM_Id in LD_concepto_rem.CONCEPTO_REM_Id%type
  )
  IS
    SELECT LD_concepto_rem.*,LD_concepto_rem.rowid
    FROM LD_concepto_rem
    WHERE  CONCEPTO_REM_Id = inuCONCEPTO_REM_Id
    FOR UPDATE NOWAIT;

  /* Cursor para bloqueo de un registro por rowid */
  CURSOR cuLockRcbyRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_concepto_rem.*,LD_concepto_rem.rowid
    FROM LD_concepto_rem
    WHERE
      rowId = irirowid
    FOR UPDATE NOWAIT;
  /*Tipos*/
  type tyrfLD_concepto_rem is ref cursor;

  /*Variables Globales*/
  rcRecOfTab tyrcLD_concepto_rem;

  rcData cuRecord%rowtype;

   blDAO_USE_CACHE    boolean := null;

  /* Metodos privados */
  /*Obtener el ID de la tabla en Ge_Entity*/
  FUNCTION fnuGetEntityIdByName(isbTName IN ge_entity.name_%TYPE)
     RETURN ge_entity.entity_id%TYPE IS
     nuEntityId ge_entity.entity_id%TYPE;
     BEGIN
     SELECT ge_entity.entity_id
     INTO   nuEntityId
     FROM   ge_entity
     WHERE  ge_entity.name_ = isbTName;
     RETURN nuEntityId;
  EXCEPTION
     WHEN ex.CONTROLLED_ERROR THEN
          RAISE ex.CONTROLLED_ERROR;
     WHEN OTHERS THEN
          Errors.setError;
          RAISE ex.CONTROLLED_ERROR;
  END;
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

  FUNCTION fsbPrimaryKey( rcI in styLD_concepto_rem default rcData )
  return varchar2
  IS
    sbPk varchar2(500);
  BEGIN
    sbPk:='[';
    sbPk:=sbPk||ut_convert.fsbToChar(rcI.CONCEPTO_REM_Id);
    sbPk:=sbPk||']';
    return sbPk;
  END;

  PROCEDURE LockByPk
  (
    inuCONCEPTO_REM_Id in LD_concepto_rem.CONCEPTO_REM_Id%type,
    orcLD_concepto_rem  out styLD_concepto_rem
  )
  IS
    rcError styLD_concepto_rem;
  BEGIN
    rcError.CONCEPTO_REM_Id := inuCONCEPTO_REM_Id;

    Open cuLockRcByPk
    (
      inuCONCEPTO_REM_Id
    );

    fetch cuLockRcByPk into orcLD_concepto_rem;
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
    orcLD_concepto_rem  out styLD_concepto_rem
  )
  IS
  BEGIN
    Open cuLockRcbyRowId
    (
      irirowid
    );

    fetch cuLockRcbyRowId into orcLD_concepto_rem;
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
    itbLD_concepto_rem  in out nocopy tytbLD_concepto_rem
  )
  IS
  BEGIN
      rcRecOfTab.Concepto_Rem_Id.delete;
      rcRecOfTab.Ubication_Id.delete;
      rcRecOfTab.Asig_Value.delete;
      rcRecOfTab.Sesion.delete;
      rcRecOfTab.Create_Date.delete;
      rcRecOfTab.row_id.delete;
  END;
  PROCEDURE FillRecordOfTables
  (
    itbLD_concepto_rem  in out nocopy tytbLD_concepto_rem,
    oblUseRowId out boolean
  )
  IS
  BEGIN
    DelRecordOfTables(itbLD_concepto_rem);
    for n in itbLD_concepto_rem.first .. itbLD_concepto_rem.last loop
      rcRecOfTab.Concepto_Rem_Id(n) := itbLD_concepto_rem(n).Concepto_Rem_Id;
      rcRecOfTab.Ubication_Id(n) := itbLD_concepto_rem(n).Ubication_Id;
      rcRecOfTab.Asig_Value(n) := itbLD_concepto_rem(n).Asig_Value;
      rcRecOfTab.Sesion(n) := itbLD_concepto_rem(n).Sesion;
      rcRecOfTab.Create_Date(n) := itbLD_concepto_rem(n).Create_Date;
      rcRecOfTab.row_id(n) := itbLD_concepto_rem(n).rowid;
      -- Indica si el rowid es Nulo
      oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
    end loop;
  END;


  PROCEDURE Load
  (
    inuCONCEPTO_REM_Id in LD_concepto_rem.CONCEPTO_REM_Id%type
  )
  IS
    rcRecordNull cuRecord%rowtype;
  BEGIN
    if cuRecord%isopen then
      close cuRecord;
    end if;
    open cuRecord
    (
      inuCONCEPTO_REM_Id
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
    inuCONCEPTO_REM_Id in LD_concepto_rem.CONCEPTO_REM_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    if (
      inuCONCEPTO_REM_Id = rcData.CONCEPTO_REM_Id
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
    inuCONCEPTO_REM_Id in LD_concepto_rem.CONCEPTO_REM_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    Load
    (
      inuCONCEPTO_REM_Id
    );
    return(TRUE);
  EXCEPTION
    when no_data_found then
      return(FALSE);
  END;

  PROCEDURE AccKey
  (
    inuCONCEPTO_REM_Id in LD_concepto_rem.CONCEPTO_REM_Id%type
  )
  IS
    rcError styLD_concepto_rem;
  BEGIN    rcError.CONCEPTO_REM_Id:=inuCONCEPTO_REM_Id;

    Load
    (
      inuCONCEPTO_REM_Id
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
    inuCONCEPTO_REM_Id in LD_concepto_rem.CONCEPTO_REM_Id%type
  )
  IS
  BEGIN
    Load
    (
      inuCONCEPTO_REM_Id
    );
    Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
    raise ex.CONTROLLED_ERROR;

  EXCEPTION
    when no_data_found then
      null;
  END;

  PROCEDURE getRecord
  (
    inuCONCEPTO_REM_Id in LD_concepto_rem.CONCEPTO_REM_Id%type,
    orcRecord out nocopy styLD_concepto_rem
  )
  IS
    rcError styLD_concepto_rem;
  BEGIN    rcError.CONCEPTO_REM_Id:=inuCONCEPTO_REM_Id;

    Load
    (
      inuCONCEPTO_REM_Id
    );
    orcRecord := rcData;
  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRecord
  (
    inuCONCEPTO_REM_Id in LD_concepto_rem.CONCEPTO_REM_Id%type
  )
  RETURN styLD_concepto_rem
  IS
    rcError styLD_concepto_rem;
  BEGIN
    rcError.CONCEPTO_REM_Id:=inuCONCEPTO_REM_Id;

    Load
    (
      inuCONCEPTO_REM_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  (
    inuCONCEPTO_REM_Id in LD_concepto_rem.CONCEPTO_REM_Id%type
  )
  RETURN styLD_concepto_rem
  IS
    rcError styLD_concepto_rem;
  BEGIN
    rcError.CONCEPTO_REM_Id:=inuCONCEPTO_REM_Id;
        -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
         inuCONCEPTO_REM_Id
       )
    then
       return(rcData);
    end if;
    Load
    (
      inuCONCEPTO_REM_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  RETURN styLD_concepto_rem
  IS
  BEGIN
    return(rcData);
  END;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_concepto_rem
  )
  IS
    rfLD_concepto_rem tyrfLD_concepto_rem;
    n number(4) := 1;
    sbFullQuery VARCHAR2 (32000) := 'SELECT LD_concepto_rem.*,
                LD_concepto_rem.rowid
                FROM LD_concepto_rem';
    nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
  BEGIN
    otbResult.delete;
    if isbQuery is not NULL and length(isbQuery) > 0 then
      sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
    end if;
    open rfLD_concepto_rem for sbFullQuery;
    fetch rfLD_concepto_rem bulk collect INTO otbResult;
    close rfLD_concepto_rem;
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
    sbSQL  VARCHAR2 (32000) := 'select LD_concepto_rem.*,
                LD_concepto_rem.rowid
                FROM LD_concepto_rem';
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
    ircLD_concepto_rem in styLD_concepto_rem
  )
  IS
    rirowid varchar2(200);
  BEGIN
    insRecord(ircLD_concepto_rem,rirowid);
  END;

  PROCEDURE insRecord
  (
    ircLD_concepto_rem in styLD_concepto_rem,
    orirowid   out varchar2
  )
  IS
  BEGIN
    if ircLD_concepto_rem.CONCEPTO_REM_Id is NULL then
      Errors.SetError(cnuINS_PK_NULL,
                      fsbGetMessageDescription||'|CONCEPTO_REM_Id');
      raise ex.controlled_error;
    end if;
    insert into LD_concepto_rem
    (
      Concepto_Rem_Id,
      Ubication_Id,
      Asig_Value,
      Sesion,
      Create_Date
    )
    values
    (
      ircLD_concepto_rem.Concepto_Rem_Id,
      ircLD_concepto_rem.Ubication_Id,
      ircLD_concepto_rem.Asig_Value,
      ircLD_concepto_rem.Sesion,
      ircLD_concepto_rem.Create_Date
    )
            returning
      rowid
    into
      orirowid;
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_concepto_rem));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE insRecords
  (
    iotbLD_concepto_rem in out nocopy tytbLD_concepto_rem
  )
  IS
    blUseRowID boolean;
  BEGIN
    FillRecordOfTables(iotbLD_concepto_rem, blUseRowID);
    forall n in iotbLD_concepto_rem.first..iotbLD_concepto_rem.last
      insert into LD_concepto_rem
      (
      Concepto_Rem_Id,
      Ubication_Id,
      Asig_Value,
      Sesion,
      Create_Date
    )
    values
    (
      rcRecOfTab.Concepto_Rem_Id(n),
      rcRecOfTab.Ubication_Id(n),
      rcRecOfTab.Asig_Value(n),
      rcRecOfTab.Sesion(n),
      rcRecOfTab.Create_Date(n)
      );
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE delRecord
  (
    inuCONCEPTO_REM_Id in LD_concepto_rem.CONCEPTO_REM_Id%type,
    inuLock in number default 1
  )
  IS
    rcError styLD_concepto_rem;
  BEGIN
    rcError.CONCEPTO_REM_Id:=inuCONCEPTO_REM_Id;

    if inuLock=1 then
      LockByPk
      (
        inuCONCEPTO_REM_Id,
        rcData
      );
    end if;

    delete
    from LD_concepto_rem
    where
           CONCEPTO_REM_Id=inuCONCEPTO_REM_Id;
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
    rcError  styLD_concepto_rem;
  BEGIN
    if inuLock=1 then
      LockByRowId(iriRowID,rcData);
    end if;

    delete
    from LD_concepto_rem
    where
      rowid = iriRowID
    returning
   CONCEPTO_REM_Id
    into
      rcError.CONCEPTO_REM_Id;

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
    iotbLD_concepto_rem in out nocopy tytbLD_concepto_rem,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_concepto_rem;
  BEGIN
    FillRecordOfTables(iotbLD_concepto_rem, blUseRowID);
       if ( blUseRowId ) then
      if inuLock = 1 then
        for n in iotbLD_concepto_rem.first .. iotbLD_concepto_rem.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_concepto_rem.first .. iotbLD_concepto_rem.last
        delete
        from LD_concepto_rem
        where
          rowid = rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_concepto_rem.first .. iotbLD_concepto_rem.last loop
          LockByPk
          (
              rcRecOfTab.CONCEPTO_REM_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_concepto_rem.first .. iotbLD_concepto_rem.last
        delete
        from LD_concepto_rem
        where
               CONCEPTO_REM_Id = rcRecOfTab.CONCEPTO_REM_Id(n);
    end if;
  EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecord
  (
    ircLD_concepto_rem in styLD_concepto_rem,
    inuLock    in number default 0
  )
  IS
    nuCONCEPTO_REM_Id LD_concepto_rem.CONCEPTO_REM_Id%type;

  BEGIN
    if ircLD_concepto_rem.rowid is not null then
      if inuLock=1 then
        LockByRowId(ircLD_concepto_rem.rowid,rcData);
      end if;
      update LD_concepto_rem
      set

        Ubication_Id = ircLD_concepto_rem.Ubication_Id,
        Asig_Value = ircLD_concepto_rem.Asig_Value,
        Sesion = ircLD_concepto_rem.Sesion,
        Create_Date = ircLD_concepto_rem.Create_Date
      where
        rowid = ircLD_concepto_rem.rowid
      returning
    CONCEPTO_REM_Id
      into
        nuCONCEPTO_REM_Id;

    else
      if inuLock=1 then
        LockByPk
        (
          ircLD_concepto_rem.CONCEPTO_REM_Id,
          rcData
        );
      end if;

      update LD_concepto_rem
      set
        Ubication_Id = ircLD_concepto_rem.Ubication_Id,
        Asig_Value = ircLD_concepto_rem.Asig_Value,
        Sesion = ircLD_concepto_rem.Sesion,
        Create_Date = ircLD_concepto_rem.Create_Date
      where
             CONCEPTO_REM_Id = ircLD_concepto_rem.CONCEPTO_REM_Id
      returning
    CONCEPTO_REM_Id
      into
        nuCONCEPTO_REM_Id;
    end if;

    if
      nuCONCEPTO_REM_Id is NULL
    then
      raise no_data_found;
    end if;

  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_concepto_rem));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecords
  (
    iotbLD_concepto_rem in out nocopy tytbLD_concepto_rem,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_concepto_rem;
  BEGIN
    FillRecordOfTables(iotbLD_concepto_rem,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_concepto_rem.first .. iotbLD_concepto_rem.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_concepto_rem.first .. iotbLD_concepto_rem.last
        update LD_concepto_rem
        set

            Ubication_Id = rcRecOfTab.Ubication_Id(n),
            Asig_Value = rcRecOfTab.Asig_Value(n),
            Sesion = rcRecOfTab.Sesion(n),
            Create_Date = rcRecOfTab.Create_Date(n)
          where
          rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_concepto_rem.first .. iotbLD_concepto_rem.last loop
          LockByPk
          (
              rcRecOfTab.CONCEPTO_REM_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_concepto_rem.first .. iotbLD_concepto_rem.last
        update LD_concepto_rem
        set
          Ubication_Id = rcRecOfTab.Ubication_Id(n),
          Asig_Value = rcRecOfTab.Asig_Value(n),
          Sesion = rcRecOfTab.Sesion(n),
          Create_Date = rcRecOfTab.Create_Date(n)
          where
          CONCEPTO_REM_Id = rcRecOfTab.CONCEPTO_REM_Id(n)
;
    end if;
  END;

  PROCEDURE updUbication_Id
  (
    inuCONCEPTO_REM_Id in LD_concepto_rem.CONCEPTO_REM_Id%type,
    inuUbication_Id$ in LD_concepto_rem.Ubication_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_concepto_rem;
  BEGIN
    rcError.CONCEPTO_REM_Id := inuCONCEPTO_REM_Id;
    if inuLock=1 then
      LockByPk
      (
        inuCONCEPTO_REM_Id,
        rcData
      );
    end if;

    update LD_concepto_rem
    set
      Ubication_Id = inuUbication_Id$
    where
      CONCEPTO_REM_Id = inuCONCEPTO_REM_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Ubication_Id:= inuUbication_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updAsig_Value
  (
    inuCONCEPTO_REM_Id in LD_concepto_rem.CONCEPTO_REM_Id%type,
    inuAsig_Value$ in LD_concepto_rem.Asig_Value%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_concepto_rem;
  BEGIN
    rcError.CONCEPTO_REM_Id := inuCONCEPTO_REM_Id;
    if inuLock=1 then
      LockByPk
      (
        inuCONCEPTO_REM_Id,
        rcData
      );
    end if;

    update LD_concepto_rem
    set
      Asig_Value = inuAsig_Value$
    where
      CONCEPTO_REM_Id = inuCONCEPTO_REM_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Asig_Value:= inuAsig_Value$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updSesion
  (
    inuCONCEPTO_REM_Id in LD_concepto_rem.CONCEPTO_REM_Id%type,
    inuSesion$ in LD_concepto_rem.Sesion%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_concepto_rem;
  BEGIN
    rcError.CONCEPTO_REM_Id := inuCONCEPTO_REM_Id;
    if inuLock=1 then
      LockByPk
      (
        inuCONCEPTO_REM_Id,
        rcData
      );
    end if;

    update LD_concepto_rem
    set
      Sesion = inuSesion$
    where
      CONCEPTO_REM_Id = inuCONCEPTO_REM_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Sesion:= inuSesion$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updCreate_Date
  (
    inuCONCEPTO_REM_Id in LD_concepto_rem.CONCEPTO_REM_Id%type,
    idtCreate_Date$ in LD_concepto_rem.Create_Date%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_concepto_rem;
  BEGIN
    rcError.CONCEPTO_REM_Id := inuCONCEPTO_REM_Id;
    if inuLock=1 then
      LockByPk
      (
        inuCONCEPTO_REM_Id,
        rcData
      );
    end if;

    update LD_concepto_rem
    set
      Create_Date = idtCreate_Date$
    where
      CONCEPTO_REM_Id = inuCONCEPTO_REM_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Create_Date:= idtCreate_Date$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;


  FUNCTION fnuGetConcepto_Rem_Id
  (
    inuCONCEPTO_REM_Id in LD_concepto_rem.CONCEPTO_REM_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_concepto_rem.Concepto_Rem_Id%type
  IS
    rcError styLD_concepto_rem;
  BEGIN

    rcError.CONCEPTO_REM_Id := inuCONCEPTO_REM_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuCONCEPTO_REM_Id
       )
    then
       return(rcData.Concepto_Rem_Id);
    end if;
    Load
    (
      inuCONCEPTO_REM_Id
    );
    return(rcData.Concepto_Rem_Id);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetUbication_Id
  (
    inuCONCEPTO_REM_Id in LD_concepto_rem.CONCEPTO_REM_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_concepto_rem.Ubication_Id%type
  IS
    rcError styLD_concepto_rem;
  BEGIN

    rcError.CONCEPTO_REM_Id := inuCONCEPTO_REM_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuCONCEPTO_REM_Id
       )
    then
       return(rcData.Ubication_Id);
    end if;
    Load
    (
      inuCONCEPTO_REM_Id
    );
    return(rcData.Ubication_Id);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetAsig_Value
  (
    inuCONCEPTO_REM_Id in LD_concepto_rem.CONCEPTO_REM_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_concepto_rem.Asig_Value%type
  IS
    rcError styLD_concepto_rem;
  BEGIN

    rcError.CONCEPTO_REM_Id := inuCONCEPTO_REM_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuCONCEPTO_REM_Id
       )
    then
       return(rcData.Asig_Value);
    end if;
    Load
    (
      inuCONCEPTO_REM_Id
    );
    return(rcData.Asig_Value);
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
    inuCONCEPTO_REM_Id in LD_concepto_rem.CONCEPTO_REM_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_concepto_rem.Sesion%type
  IS
    rcError styLD_concepto_rem;
  BEGIN

    rcError.CONCEPTO_REM_Id := inuCONCEPTO_REM_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuCONCEPTO_REM_Id
       )
    then
       return(rcData.Sesion);
    end if;
    Load
    (
      inuCONCEPTO_REM_Id
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

  FUNCTION fdtGetCreate_Date
  (
    inuCONCEPTO_REM_Id in LD_concepto_rem.CONCEPTO_REM_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_concepto_rem.Create_Date%type
  IS
    rcError styLD_concepto_rem;
  BEGIN

    rcError.CONCEPTO_REM_Id:=inuCONCEPTO_REM_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
         inuCONCEPTO_REM_Id
       )
    then
       return(rcData.Create_Date);
    end if;
    Load
    (
         inuCONCEPTO_REM_Id
    );
    return(rcData.Create_Date);
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
end DALD_concepto_rem;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALD_CONCEPTO_REM
BEGIN
    pkg_utilidades.prAplicarPermisos('DALD_CONCEPTO_REM', 'ADM_PERSON'); 
END;
/