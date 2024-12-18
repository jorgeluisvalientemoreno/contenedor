CREATE OR REPLACE PACKAGE adm_person.dald_fnb_warranty
is
/***************************************************************************
   Historia de Modificaciones
   Autor       Fecha        Descripcion.
   Adrianavg   11/06/2024   OSF-2813: Migrar del esquema OPEN al esquema ADM_PERSON
   ***************************************************************************/
  /* Cursor general para acceso por Llave Primaria */
  CURSOR cuRecord
  (
    inuFnb_warranty_Id in LD_fnb_warranty.Fnb_warranty_Id%type
  )
  IS
    SELECT LD_fnb_warranty.*,LD_fnb_warranty.rowid
    FROM LD_fnb_warranty
    WHERE
      Fnb_warranty_Id = inuFnb_warranty_Id;


  /* Cursor general para acceso por RowId */
  CURSOR cuRecordByRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_fnb_warranty.*,LD_fnb_warranty.rowid
    FROM LD_fnb_warranty
    WHERE
      rowId = irirowid;


  /* Subtipos */
  subtype styLD_fnb_warranty  is  cuRecord%rowtype;
  type tyRefCursor is  REF CURSOR;

  /*Tipos*/
  type tytbLD_fnb_warranty is table of styLD_fnb_warranty index by binary_integer;
  type tyrfRecords is ref cursor return styLD_fnb_warranty;

  /* Tipos referenciando al registro */
  type tytbFnb_Warranty_Id is table of LD_fnb_warranty.Fnb_Warranty_Id%type index by binary_integer;
  type tytbPackage_Id is table of LD_fnb_warranty.Package_Id%type index by binary_integer;
  type tytbPackage_Sale_Id is table of LD_fnb_warranty.Package_Sale_Id%type index by binary_integer;
  type tytbCausal_Id is table of LD_fnb_warranty.Causal_Id%type index by binary_integer;
  type tytbItem_Id is table of LD_fnb_warranty.Item_Id%type index by binary_integer;
  type tytbComments is table of LD_fnb_warranty.Comments%type index by binary_integer;
  type tytbrowid is table of rowid index by binary_integer;

  type tyrcLD_fnb_warranty is record
  (

    Fnb_Warranty_Id   tytbFnb_Warranty_Id,
    Package_Id   tytbPackage_Id,
    Package_Sale_Id   tytbPackage_Sale_Id,
    Causal_Id   tytbCausal_Id,
    Item_Id   tytbItem_Id,
    Comments   tytbComments,
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
    inuFnb_warranty_Id in LD_fnb_warranty.Fnb_warranty_Id%type
  )
  RETURN boolean;

   PROCEDURE AccKey
   (
     inuFnb_warranty_Id in LD_fnb_warranty.Fnb_warranty_Id%type
  );

  PROCEDURE AccKeyByRowId
  (
    iriRowID    in rowid
  );

  PROCEDURE ValDuplicate
  (
     inuFnb_warranty_Id in LD_fnb_warranty.Fnb_warranty_Id%type
  );

  PROCEDURE getRecord
  (
    inuFnb_warranty_Id in LD_fnb_warranty.Fnb_warranty_Id%type,
    orcRecord out nocopy styLD_fnb_warranty
  );

  FUNCTION frcGetRcData
  (
    inuFnb_warranty_Id in LD_fnb_warranty.Fnb_warranty_Id%type
  )
  RETURN styLD_fnb_warranty;

  FUNCTION frcGetRcData
  RETURN styLD_fnb_warranty;

  FUNCTION frcGetRecord
  (
    inuFnb_warranty_Id in LD_fnb_warranty.Fnb_warranty_Id%type
  )
  RETURN styLD_fnb_warranty;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_fnb_warranty
  );

  FUNCTION frfGetRecords
  (
    isbCriteria in varchar2 default null,
    iblLock in boolean default false
  )
  RETURN tyRefCursor;

  PROCEDURE insRecord
  (
    ircLD_fnb_warranty in styLD_fnb_warranty
  );

     PROCEDURE insRecord
  (
    ircLD_fnb_warranty in styLD_fnb_warranty,
    orirowid   out varchar2
  );

  PROCEDURE insRecords
  (
    iotbLD_fnb_warranty in out nocopy tytbLD_fnb_warranty
  );

  PROCEDURE delRecord
  (
    inuFnb_warranty_Id in LD_fnb_warranty.Fnb_warranty_Id%type,
    inuLock in number default 1
  );

  PROCEDURE delByRowID
  (
    iriRowID    in rowid,
    inuLock in number default 1
  );

  PROCEDURE delRecords
  (
    iotbLD_fnb_warranty in out nocopy tytbLD_fnb_warranty,
    inuLock in number default 1
  );

  PROCEDURE updRecord
  (
    ircLD_fnb_warranty in styLD_fnb_warranty,
    inuLock    in number default 0
  );

  PROCEDURE updRecords
  (
    iotbLD_fnb_warranty in out nocopy tytbLD_fnb_warranty,
    inuLock in number default 1
  );

    PROCEDURE updPackage_Id
    (
        inuFnb_warranty_Id   in LD_fnb_warranty.Fnb_warranty_Id%type,
        inuPackage_Id$  in LD_fnb_warranty.Package_Id%type,
        inuLock    in number default 0
      );

    PROCEDURE updPackage_Sale_Id
    (
        inuFnb_warranty_Id   in LD_fnb_warranty.Fnb_warranty_Id%type,
        inuPackage_Sale_Id$  in LD_fnb_warranty.Package_Sale_Id%type,
        inuLock    in number default 0
      );

    PROCEDURE updCausal_Id
    (
        inuFnb_warranty_Id   in LD_fnb_warranty.Fnb_warranty_Id%type,
        inuCausal_Id$  in LD_fnb_warranty.Causal_Id%type,
        inuLock    in number default 0
      );

    PROCEDURE updItem_Id
    (
        inuFnb_warranty_Id   in LD_fnb_warranty.Fnb_warranty_Id%type,
        inuItem_Id$  in LD_fnb_warranty.Item_Id%type,
        inuLock    in number default 0
      );

    PROCEDURE updComments
    (
        inuFnb_warranty_Id   in LD_fnb_warranty.Fnb_warranty_Id%type,
        isbComments$  in LD_fnb_warranty.Comments%type,
        inuLock    in number default 0
      );

      FUNCTION fnuGetFnb_Warranty_Id
      (
          inuFnb_warranty_Id in LD_fnb_warranty.Fnb_warranty_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_fnb_warranty.Fnb_Warranty_Id%type;

      FUNCTION fnuGetPackage_Id
      (
          inuFnb_warranty_Id in LD_fnb_warranty.Fnb_warranty_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_fnb_warranty.Package_Id%type;

      FUNCTION fnuGetPackage_Sale_Id
      (
          inuFnb_warranty_Id in LD_fnb_warranty.Fnb_warranty_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_fnb_warranty.Package_Sale_Id%type;

      FUNCTION fnuGetCausal_Id
      (
          inuFnb_warranty_Id in LD_fnb_warranty.Fnb_warranty_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_fnb_warranty.Causal_Id%type;

      FUNCTION fnuGetItem_Id
      (
          inuFnb_warranty_Id in LD_fnb_warranty.Fnb_warranty_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_fnb_warranty.Item_Id%type;

      FUNCTION fsbGetComments
      (
          inuFnb_warranty_Id in LD_fnb_warranty.Fnb_warranty_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_fnb_warranty.Comments%type;


  PROCEDURE LockByPk
  (
    inuFnb_warranty_Id in LD_fnb_warranty.Fnb_warranty_Id%type,
    orcLD_fnb_warranty  out styLD_fnb_warranty
  );

  PROCEDURE LockByRowID
  (
    irirowid    in  varchar2,
    orcLD_fnb_warranty  out styLD_fnb_warranty
  );

  PROCEDURE SetUseCache
  (
    iblUseCache    in  boolean
  );
END DALD_fnb_warranty;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_fnb_warranty
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO159480';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_FNB_WARRANTY';
    cnuGeEntityId constant varchar2(30) := 8632; -- Id de Ge_entity

  /* Cursor para bloqueo de un registro por llave primaria */
  CURSOR cuLockRcByPk
  (
    inuFnb_warranty_Id in LD_fnb_warranty.Fnb_warranty_Id%type
  )
  IS
    SELECT LD_fnb_warranty.*,LD_fnb_warranty.rowid
    FROM LD_fnb_warranty
    WHERE  Fnb_warranty_Id = inuFnb_warranty_Id
    FOR UPDATE NOWAIT;

  /* Cursor para bloqueo de un registro por rowid */
  CURSOR cuLockRcbyRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_fnb_warranty.*,LD_fnb_warranty.rowid
    FROM LD_fnb_warranty
    WHERE
      rowId = irirowid
    FOR UPDATE NOWAIT;
  /*Tipos*/
  type tyrfLD_fnb_warranty is ref cursor;

  /*Variables Globales*/
  rcRecOfTab tyrcLD_fnb_warranty;

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

  FUNCTION fsbPrimaryKey( rcI in styLD_fnb_warranty default rcData )
  return varchar2
  IS
    sbPk varchar2(500);
  BEGIN
    sbPk:='[';
    sbPk:=sbPk||ut_convert.fsbToChar(rcI.Fnb_warranty_Id);
    sbPk:=sbPk||']';
    return sbPk;
  END;

  PROCEDURE LockByPk
  (
    inuFnb_warranty_Id in LD_fnb_warranty.Fnb_warranty_Id%type,
    orcLD_fnb_warranty  out styLD_fnb_warranty
  )
  IS
    rcError styLD_fnb_warranty;
  BEGIN
    rcError.Fnb_warranty_Id := inuFnb_warranty_Id;

    Open cuLockRcByPk
    (
      inuFnb_warranty_Id
    );

    fetch cuLockRcByPk into orcLD_fnb_warranty;
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
    orcLD_fnb_warranty  out styLD_fnb_warranty
  )
  IS
  BEGIN
    Open cuLockRcbyRowId
    (
      irirowid
    );

    fetch cuLockRcbyRowId into orcLD_fnb_warranty;
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
    itbLD_fnb_warranty  in out nocopy tytbLD_fnb_warranty
  )
  IS
  BEGIN
      rcRecOfTab.Fnb_Warranty_Id.delete;
      rcRecOfTab.Package_Id.delete;
      rcRecOfTab.Package_Sale_Id.delete;
      rcRecOfTab.Causal_Id.delete;
      rcRecOfTab.Item_Id.delete;
      rcRecOfTab.Comments.delete;
      rcRecOfTab.row_id.delete;
  END;
  PROCEDURE FillRecordOfTables
  (
    itbLD_fnb_warranty  in out nocopy tytbLD_fnb_warranty,
    oblUseRowId out boolean
  )
  IS
  BEGIN
    DelRecordOfTables(itbLD_fnb_warranty);
    for n in itbLD_fnb_warranty.first .. itbLD_fnb_warranty.last loop
      rcRecOfTab.Fnb_Warranty_Id(n) := itbLD_fnb_warranty(n).Fnb_Warranty_Id;
      rcRecOfTab.Package_Id(n) := itbLD_fnb_warranty(n).Package_Id;
      rcRecOfTab.Package_Sale_Id(n) := itbLD_fnb_warranty(n).Package_Sale_Id;
      rcRecOfTab.Causal_Id(n) := itbLD_fnb_warranty(n).Causal_Id;
      rcRecOfTab.Item_Id(n) := itbLD_fnb_warranty(n).Item_Id;
      rcRecOfTab.Comments(n) := itbLD_fnb_warranty(n).Comments;
      rcRecOfTab.row_id(n) := itbLD_fnb_warranty(n).rowid;
      -- Indica si el rowid es Nulo
      oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
    end loop;
  END;


  PROCEDURE Load
  (
    inuFnb_warranty_Id in LD_fnb_warranty.Fnb_warranty_Id%type
  )
  IS
    rcRecordNull cuRecord%rowtype;
  BEGIN
    if cuRecord%isopen then
      close cuRecord;
    end if;
    open cuRecord
    (
      inuFnb_warranty_Id
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
    inuFnb_warranty_Id in LD_fnb_warranty.Fnb_warranty_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    if (
      inuFnb_warranty_Id = rcData.Fnb_warranty_Id
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
    inuFnb_warranty_Id in LD_fnb_warranty.Fnb_warranty_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    Load
    (
      inuFnb_warranty_Id
    );
    return(TRUE);
  EXCEPTION
    when no_data_found then
      return(FALSE);
  END;

  PROCEDURE AccKey
  (
    inuFnb_warranty_Id in LD_fnb_warranty.Fnb_warranty_Id%type
  )
  IS
    rcError styLD_fnb_warranty;
  BEGIN    rcError.Fnb_warranty_Id:=inuFnb_warranty_Id;

    Load
    (
      inuFnb_warranty_Id
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
    inuFnb_warranty_Id in LD_fnb_warranty.Fnb_warranty_Id%type
  )
  IS
  BEGIN
    Load
    (
      inuFnb_warranty_Id
    );
    Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
    raise ex.CONTROLLED_ERROR;

  EXCEPTION
    when no_data_found then
      null;
  END;

  PROCEDURE getRecord
  (
    inuFnb_warranty_Id in LD_fnb_warranty.Fnb_warranty_Id%type,
    orcRecord out nocopy styLD_fnb_warranty
  )
  IS
    rcError styLD_fnb_warranty;
  BEGIN    rcError.Fnb_warranty_Id:=inuFnb_warranty_Id;

    Load
    (
      inuFnb_warranty_Id
    );
    orcRecord := rcData;
  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRecord
  (
    inuFnb_warranty_Id in LD_fnb_warranty.Fnb_warranty_Id%type
  )
  RETURN styLD_fnb_warranty
  IS
    rcError styLD_fnb_warranty;
  BEGIN
    rcError.Fnb_warranty_Id:=inuFnb_warranty_Id;

    Load
    (
      inuFnb_warranty_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  (
    inuFnb_warranty_Id in LD_fnb_warranty.Fnb_warranty_Id%type
  )
  RETURN styLD_fnb_warranty
  IS
    rcError styLD_fnb_warranty;
  BEGIN
    rcError.Fnb_warranty_Id:=inuFnb_warranty_Id;
        -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
         inuFnb_warranty_Id
       )
    then
       return(rcData);
    end if;
    Load
    (
      inuFnb_warranty_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  RETURN styLD_fnb_warranty
  IS
  BEGIN
    return(rcData);
  END;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_fnb_warranty
  )
  IS
    rfLD_fnb_warranty tyrfLD_fnb_warranty;
    n number(4) := 1;
    sbFullQuery VARCHAR2 (32000) := 'SELECT
                LD_fnb_warranty.Fnb_Warranty_Id,
                LD_fnb_warranty.Package_Id,
                LD_fnb_warranty.Package_Sale_Id,
                LD_fnb_warranty.Causal_Id,
                LD_fnb_warranty.Item_Id,
                LD_fnb_warranty.Comments,
                LD_fnb_warranty.rowid
                FROM LD_fnb_warranty';
    nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
  BEGIN
    otbResult.delete;
    if isbQuery is not NULL and length(isbQuery) > 0 then
      sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
    end if;
    open rfLD_fnb_warranty for sbFullQuery;
    fetch rfLD_fnb_warranty bulk collect INTO otbResult;
    close rfLD_fnb_warranty;
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
                LD_fnb_warranty.Fnb_Warranty_Id,
                LD_fnb_warranty.Package_Id,
                LD_fnb_warranty.Package_Sale_Id,
                LD_fnb_warranty.Causal_Id,
                LD_fnb_warranty.Item_Id,
                LD_fnb_warranty.Comments,
                LD_fnb_warranty.rowid
                FROM LD_fnb_warranty';
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
    ircLD_fnb_warranty in styLD_fnb_warranty
  )
  IS
    rirowid varchar2(200);
  BEGIN
    insRecord(ircLD_fnb_warranty,rirowid);
  END;

  PROCEDURE insRecord
  (
    ircLD_fnb_warranty in styLD_fnb_warranty,
    orirowid   out varchar2
  )
  IS
  BEGIN
    if ircLD_fnb_warranty.Fnb_warranty_Id is NULL then
      Errors.SetError(cnuINS_PK_NULL,
                      fsbGetMessageDescription||'|Fnb_warranty_Id');
      raise ex.controlled_error;
    end if;
    insert into LD_fnb_warranty
    (
      Fnb_Warranty_Id,
      Package_Id,
      Package_Sale_Id,
      Causal_Id,
      Item_Id,
      Comments
    )
    values
    (
      ircLD_fnb_warranty.Fnb_Warranty_Id,
      ircLD_fnb_warranty.Package_Id,
      ircLD_fnb_warranty.Package_Sale_Id,
      ircLD_fnb_warranty.Causal_Id,
      ircLD_fnb_warranty.Item_Id,
      ircLD_fnb_warranty.Comments
    )
            returning
      rowid
    into
      orirowid;
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_fnb_warranty));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE insRecords
  (
    iotbLD_fnb_warranty in out nocopy tytbLD_fnb_warranty
  )
  IS
    blUseRowID boolean;
  BEGIN
    FillRecordOfTables(iotbLD_fnb_warranty, blUseRowID);
    forall n in iotbLD_fnb_warranty.first..iotbLD_fnb_warranty.last
      insert into LD_fnb_warranty
      (
      Fnb_Warranty_Id,
      Package_Id,
      Package_Sale_Id,
      Causal_Id,
      Item_Id,
      Comments
    )
    values
    (
      rcRecOfTab.Fnb_Warranty_Id(n),
      rcRecOfTab.Package_Id(n),
      rcRecOfTab.Package_Sale_Id(n),
      rcRecOfTab.Causal_Id(n),
      rcRecOfTab.Item_Id(n),
      rcRecOfTab.Comments(n)
      );
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE delRecord
  (
    inuFnb_warranty_Id in LD_fnb_warranty.Fnb_warranty_Id%type,
    inuLock in number default 1
  )
  IS
    rcError styLD_fnb_warranty;
  BEGIN
    rcError.Fnb_warranty_Id:=inuFnb_warranty_Id;

    if inuLock=1 then
      LockByPk
      (
        inuFnb_warranty_Id,
        rcData
      );
    end if;

    delete
    from LD_fnb_warranty
    where
           Fnb_warranty_Id=inuFnb_warranty_Id;
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
    rcError  styLD_fnb_warranty;
  BEGIN
    if inuLock=1 then
      LockByRowId(iriRowID,rcData);
    end if;

    delete
    from LD_fnb_warranty
    where
      rowid = iriRowID
    returning
   Fnb_warranty_Id
    into
      rcError.Fnb_warranty_Id;

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
    iotbLD_fnb_warranty in out nocopy tytbLD_fnb_warranty,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_fnb_warranty;
  BEGIN
    FillRecordOfTables(iotbLD_fnb_warranty, blUseRowID);
       if ( blUseRowId ) then
      if inuLock = 1 then
        for n in iotbLD_fnb_warranty.first .. iotbLD_fnb_warranty.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_fnb_warranty.first .. iotbLD_fnb_warranty.last
        delete
        from LD_fnb_warranty
        where
          rowid = rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_fnb_warranty.first .. iotbLD_fnb_warranty.last loop
          LockByPk
          (
              rcRecOfTab.Fnb_warranty_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_fnb_warranty.first .. iotbLD_fnb_warranty.last
        delete
        from LD_fnb_warranty
        where
               Fnb_warranty_Id = rcRecOfTab.Fnb_warranty_Id(n);
    end if;
  EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecord
  (
    ircLD_fnb_warranty in styLD_fnb_warranty,
    inuLock    in number default 0
  )
  IS
    nuFnb_warranty_Id LD_fnb_warranty.Fnb_warranty_Id%type;

  BEGIN
    if ircLD_fnb_warranty.rowid is not null then
      if inuLock=1 then
        LockByRowId(ircLD_fnb_warranty.rowid,rcData);
      end if;
      update LD_fnb_warranty
      set

        Package_Id = ircLD_fnb_warranty.Package_Id,
        Package_Sale_Id = ircLD_fnb_warranty.Package_Sale_Id,
        Causal_Id = ircLD_fnb_warranty.Causal_Id,
        Item_Id = ircLD_fnb_warranty.Item_Id,
        Comments = ircLD_fnb_warranty.Comments
      where
        rowid = ircLD_fnb_warranty.rowid
      returning
    Fnb_warranty_Id
      into
        nuFnb_warranty_Id;

    else
      if inuLock=1 then
        LockByPk
        (
          ircLD_fnb_warranty.Fnb_warranty_Id,
          rcData
        );
      end if;

      update LD_fnb_warranty
      set
        Package_Id = ircLD_fnb_warranty.Package_Id,
        Package_Sale_Id = ircLD_fnb_warranty.Package_Sale_Id,
        Causal_Id = ircLD_fnb_warranty.Causal_Id,
        Item_Id = ircLD_fnb_warranty.Item_Id,
        Comments = ircLD_fnb_warranty.Comments
      where
             Fnb_warranty_Id = ircLD_fnb_warranty.Fnb_warranty_Id
      returning
    Fnb_warranty_Id
      into
        nuFnb_warranty_Id;
    end if;

    if
      nuFnb_warranty_Id is NULL
    then
      raise no_data_found;
    end if;

  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_fnb_warranty));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecords
  (
    iotbLD_fnb_warranty in out nocopy tytbLD_fnb_warranty,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_fnb_warranty;
  BEGIN
    FillRecordOfTables(iotbLD_fnb_warranty,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_fnb_warranty.first .. iotbLD_fnb_warranty.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_fnb_warranty.first .. iotbLD_fnb_warranty.last
        update LD_fnb_warranty
        set

            Package_Id = rcRecOfTab.Package_Id(n),
            Package_Sale_Id = rcRecOfTab.Package_Sale_Id(n),
            Causal_Id = rcRecOfTab.Causal_Id(n),
            Item_Id = rcRecOfTab.Item_Id(n),
            Comments = rcRecOfTab.Comments(n)
          where
          rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_fnb_warranty.first .. iotbLD_fnb_warranty.last loop
          LockByPk
          (
              rcRecOfTab.Fnb_warranty_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_fnb_warranty.first .. iotbLD_fnb_warranty.last
        update LD_fnb_warranty
        set
          Package_Id = rcRecOfTab.Package_Id(n),
          Package_Sale_Id = rcRecOfTab.Package_Sale_Id(n),
          Causal_Id = rcRecOfTab.Causal_Id(n),
          Item_Id = rcRecOfTab.Item_Id(n),
          Comments = rcRecOfTab.Comments(n)
          where
          Fnb_warranty_Id = rcRecOfTab.Fnb_warranty_Id(n)
;
    end if;
  END;

  PROCEDURE updPackage_Id
  (
    inuFnb_warranty_Id in LD_fnb_warranty.Fnb_warranty_Id%type,
    inuPackage_Id$ in LD_fnb_warranty.Package_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_fnb_warranty;
  BEGIN
    rcError.Fnb_warranty_Id := inuFnb_warranty_Id;
    if inuLock=1 then
      LockByPk
      (
        inuFnb_warranty_Id,
        rcData
      );
    end if;

    update LD_fnb_warranty
    set
      Package_Id = inuPackage_Id$
    where
      Fnb_warranty_Id = inuFnb_warranty_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Package_Id:= inuPackage_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updPackage_Sale_Id
  (
    inuFnb_warranty_Id in LD_fnb_warranty.Fnb_warranty_Id%type,
    inuPackage_Sale_Id$ in LD_fnb_warranty.Package_Sale_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_fnb_warranty;
  BEGIN
    rcError.Fnb_warranty_Id := inuFnb_warranty_Id;
    if inuLock=1 then
      LockByPk
      (
        inuFnb_warranty_Id,
        rcData
      );
    end if;

    update LD_fnb_warranty
    set
      Package_Sale_Id = inuPackage_Sale_Id$
    where
      Fnb_warranty_Id = inuFnb_warranty_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Package_Sale_Id:= inuPackage_Sale_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updCausal_Id
  (
    inuFnb_warranty_Id in LD_fnb_warranty.Fnb_warranty_Id%type,
    inuCausal_Id$ in LD_fnb_warranty.Causal_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_fnb_warranty;
  BEGIN
    rcError.Fnb_warranty_Id := inuFnb_warranty_Id;
    if inuLock=1 then
      LockByPk
      (
        inuFnb_warranty_Id,
        rcData
      );
    end if;

    update LD_fnb_warranty
    set
      Causal_Id = inuCausal_Id$
    where
      Fnb_warranty_Id = inuFnb_warranty_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Causal_Id:= inuCausal_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updItem_Id
  (
    inuFnb_warranty_Id in LD_fnb_warranty.Fnb_warranty_Id%type,
    inuItem_Id$ in LD_fnb_warranty.Item_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_fnb_warranty;
  BEGIN
    rcError.Fnb_warranty_Id := inuFnb_warranty_Id;
    if inuLock=1 then
      LockByPk
      (
        inuFnb_warranty_Id,
        rcData
      );
    end if;

    update LD_fnb_warranty
    set
      Item_Id = inuItem_Id$
    where
      Fnb_warranty_Id = inuFnb_warranty_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Item_Id:= inuItem_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updComments
  (
    inuFnb_warranty_Id in LD_fnb_warranty.Fnb_warranty_Id%type,
    isbComments$ in LD_fnb_warranty.Comments%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_fnb_warranty;
  BEGIN
    rcError.Fnb_warranty_Id := inuFnb_warranty_Id;
    if inuLock=1 then
      LockByPk
      (
        inuFnb_warranty_Id,
        rcData
      );
    end if;

    update LD_fnb_warranty
    set
      Comments = isbComments$
    where
      Fnb_warranty_Id = inuFnb_warranty_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Comments:= isbComments$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;


  FUNCTION fnuGetFnb_Warranty_Id
  (
    inuFnb_warranty_Id in LD_fnb_warranty.Fnb_warranty_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_fnb_warranty.Fnb_Warranty_Id%type
  IS
    rcError styLD_fnb_warranty;
  BEGIN

    rcError.Fnb_warranty_Id := inuFnb_warranty_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuFnb_warranty_Id
       )
    then
       return(rcData.Fnb_Warranty_Id);
    end if;
    Load
    (
      inuFnb_warranty_Id
    );
    return(rcData.Fnb_Warranty_Id);
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
    inuFnb_warranty_Id in LD_fnb_warranty.Fnb_warranty_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_fnb_warranty.Package_Id%type
  IS
    rcError styLD_fnb_warranty;
  BEGIN

    rcError.Fnb_warranty_Id := inuFnb_warranty_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuFnb_warranty_Id
       )
    then
       return(rcData.Package_Id);
    end if;
    Load
    (
      inuFnb_warranty_Id
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

  FUNCTION fnuGetPackage_Sale_Id
  (
    inuFnb_warranty_Id in LD_fnb_warranty.Fnb_warranty_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_fnb_warranty.Package_Sale_Id%type
  IS
    rcError styLD_fnb_warranty;
  BEGIN

    rcError.Fnb_warranty_Id := inuFnb_warranty_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuFnb_warranty_Id
       )
    then
       return(rcData.Package_Sale_Id);
    end if;
    Load
    (
      inuFnb_warranty_Id
    );
    return(rcData.Package_Sale_Id);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetCausal_Id
  (
    inuFnb_warranty_Id in LD_fnb_warranty.Fnb_warranty_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_fnb_warranty.Causal_Id%type
  IS
    rcError styLD_fnb_warranty;
  BEGIN

    rcError.Fnb_warranty_Id := inuFnb_warranty_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuFnb_warranty_Id
       )
    then
       return(rcData.Causal_Id);
    end if;
    Load
    (
      inuFnb_warranty_Id
    );
    return(rcData.Causal_Id);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetItem_Id
  (
    inuFnb_warranty_Id in LD_fnb_warranty.Fnb_warranty_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_fnb_warranty.Item_Id%type
  IS
    rcError styLD_fnb_warranty;
  BEGIN

    rcError.Fnb_warranty_Id := inuFnb_warranty_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuFnb_warranty_Id
       )
    then
       return(rcData.Item_Id);
    end if;
    Load
    (
      inuFnb_warranty_Id
    );
    return(rcData.Item_Id);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fsbGetComments
  (
    inuFnb_warranty_Id in LD_fnb_warranty.Fnb_warranty_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_fnb_warranty.Comments%type
  IS
    rcError styLD_fnb_warranty;
  BEGIN

    rcError.Fnb_warranty_Id:=inuFnb_warranty_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuFnb_warranty_Id
       )
    then
       return(rcData.Comments);
    end if;
    Load
    (
      inuFnb_warranty_Id
    );
    return(rcData.Comments);
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
end DALD_fnb_warranty;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALD_FNB_WARRANTY
BEGIN
    pkg_utilidades.prAplicarPermisos('DALD_FNB_WARRANTY', 'ADM_PERSON'); 
END;
/
