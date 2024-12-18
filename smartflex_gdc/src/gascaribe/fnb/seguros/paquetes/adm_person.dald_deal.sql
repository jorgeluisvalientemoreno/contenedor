CREATE OR REPLACE PACKAGE adm_person.DALD_deal
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
    inuDEAL_Id in LD_deal.DEAL_Id%type
  )
  IS
    SELECT LD_deal.*,LD_deal.rowid
    FROM LD_deal
    WHERE
      DEAL_Id = inuDEAL_Id;


  /* Cursor general para acceso por RowId */
  CURSOR cuRecordByRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_deal.*,LD_deal.rowid
    FROM LD_deal
    WHERE
      rowId = irirowid;


  /* Subtipos */
  subtype styLD_deal  is  cuRecord%rowtype;
  type tyRefCursor is  REF CURSOR;

  /*Tipos*/
  type tytbLD_deal is table of styLD_deal index by binary_integer;
  type tyrfRecords is ref cursor return styLD_deal;

  /* Tipos referenciando al registro */
  type tytbDeal_Id is table of LD_deal.Deal_Id%type index by binary_integer;
  type tytbDescription is table of LD_deal.Description%type index by binary_integer;
  type tytbInitial_Date is table of LD_deal.Initial_Date%type index by binary_integer;
  type tytbFinal_Date is table of LD_deal.Final_Date%type index by binary_integer;
  type tytbTotal_Value is table of LD_deal.Total_Value%type index by binary_integer;
  type tytbSponsor_Id is table of LD_deal.Sponsor_Id%type index by binary_integer;
  type tytbDisable_Deal is table of LD_deal.Disable_Deal%type index by binary_integer;
  type tytbDisable_Date is table of LD_deal.Disable_Date%type index by binary_integer;
  type tytbrowid is table of rowid index by binary_integer;

  type tyrcLD_deal is record
  (

    Deal_Id   tytbDeal_Id,
    Description   tytbDescription,
    Initial_Date   tytbInitial_Date,
    Final_Date   tytbFinal_Date,
    Total_Value   tytbTotal_Value,
    Sponsor_Id   tytbSponsor_Id,
    Disable_Deal   tytbDisable_Deal,
    Disable_Date   tytbDisable_Date,
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
    inuDEAL_Id in LD_deal.DEAL_Id%type
  )
  RETURN boolean;

   PROCEDURE AccKey
   (
     inuDEAL_Id in LD_deal.DEAL_Id%type
  );

  PROCEDURE AccKeyByRowId
  (
    iriRowID    in rowid
  );

  PROCEDURE ValDuplicate
  (
     inuDEAL_Id in LD_deal.DEAL_Id%type
  );

  PROCEDURE getRecord
  (
    inuDEAL_Id in LD_deal.DEAL_Id%type,
    orcRecord out nocopy styLD_deal
  );

  FUNCTION frcGetRcData
  (
    inuDEAL_Id in LD_deal.DEAL_Id%type
  )
  RETURN styLD_deal;

  FUNCTION frcGetRcData
  RETURN styLD_deal;

  FUNCTION frcGetRecord
  (
    inuDEAL_Id in LD_deal.DEAL_Id%type
  )
  RETURN styLD_deal;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_deal
  );

  FUNCTION frfGetRecords
  (
    isbCriteria in varchar2 default null,
    iblLock in boolean default false
  )
  RETURN tyRefCursor;

  PROCEDURE insRecord
  (
    ircLD_deal in styLD_deal
  );

     PROCEDURE insRecord
  (
    ircLD_deal in styLD_deal,
    orirowid   out varchar2
  );

  PROCEDURE insRecords
  (
    iotbLD_deal in out nocopy tytbLD_deal
  );

  PROCEDURE delRecord
  (
    inuDEAL_Id in LD_deal.DEAL_Id%type,
    inuLock in number default 1
  );

  PROCEDURE delByRowID
  (
    iriRowID    in rowid,
    inuLock in number default 1
  );

  PROCEDURE delRecords
  (
    iotbLD_deal in out nocopy tytbLD_deal,
    inuLock in number default 1
  );

  PROCEDURE updRecord
  (
    ircLD_deal in styLD_deal,
    inuLock    in number default 0
  );

  PROCEDURE updRecords
  (
    iotbLD_deal in out nocopy tytbLD_deal,
    inuLock in number default 1
  );

    PROCEDURE updDescription
    (
        inuDEAL_Id   in LD_deal.DEAL_Id%type,
        isbDescription$  in LD_deal.Description%type,
        inuLock    in number default 0
      );

    PROCEDURE updInitial_Date
    (
        inuDEAL_Id   in LD_deal.DEAL_Id%type,
        idtInitial_Date$  in LD_deal.Initial_Date%type,
        inuLock    in number default 0
      );

    PROCEDURE updFinal_Date
    (
        inuDEAL_Id   in LD_deal.DEAL_Id%type,
        idtFinal_Date$  in LD_deal.Final_Date%type,
        inuLock    in number default 0
      );

    PROCEDURE updTotal_Value
    (
        inuDEAL_Id   in LD_deal.DEAL_Id%type,
        inuTotal_Value$  in LD_deal.Total_Value%type,
        inuLock    in number default 0
      );

    PROCEDURE updSponsor_Id
    (
        inuDEAL_Id   in LD_deal.DEAL_Id%type,
        inuSponsor_Id$  in LD_deal.Sponsor_Id%type,
        inuLock    in number default 0
      );

    PROCEDURE updDisable_Deal
    (
        inuDEAL_Id   in LD_deal.DEAL_Id%type,
        isbDisable_Deal$  in LD_deal.Disable_Deal%type,
        inuLock    in number default 0
      );

    PROCEDURE updDisable_Date
    (
        inuDEAL_Id   in LD_deal.DEAL_Id%type,
        idtDisable_Date$  in LD_deal.Disable_Date%type,
        inuLock    in number default 0
      );

      FUNCTION fnuGetDeal_Id
      (
          inuDEAL_Id in LD_deal.DEAL_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_deal.Deal_Id%type;

      FUNCTION fsbGetDescription
      (
          inuDEAL_Id in LD_deal.DEAL_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_deal.Description%type;

      FUNCTION fdtGetInitial_Date
      (
          inuDEAL_Id in LD_deal.DEAL_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_deal.Initial_Date%type;

      FUNCTION fdtGetFinal_Date
      (
          inuDEAL_Id in LD_deal.DEAL_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_deal.Final_Date%type;

      FUNCTION fnuGetTotal_Value
      (
          inuDEAL_Id in LD_deal.DEAL_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_deal.Total_Value%type;

      FUNCTION fnuGetSponsor_Id
      (
          inuDEAL_Id in LD_deal.DEAL_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_deal.Sponsor_Id%type;

      FUNCTION fsbGetDisable_Deal
      (
          inuDEAL_Id in LD_deal.DEAL_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_deal.Disable_Deal%type;

      FUNCTION fdtGetDisable_Date
      (
          inuDEAL_Id in LD_deal.DEAL_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_deal.Disable_Date%type;


  PROCEDURE LockByPk
  (
    inuDEAL_Id in LD_deal.DEAL_Id%type,
    orcLD_deal  out styLD_deal
  );

  PROCEDURE LockByRowID
  (
    irirowid    in  varchar2,
    orcLD_deal  out styLD_deal
  );

  PROCEDURE SetUseCache
  (
    iblUseCache    in  boolean
  );
END DALD_deal;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_deal
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO156577';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_DEAL';
    cnuGeEntityId constant varchar2(30) := 8626;--8386; -- Id de Ge_entity

  /* Cursor para bloqueo de un registro por llave primaria */
  CURSOR cuLockRcByPk
  (
    inuDEAL_Id in LD_deal.DEAL_Id%type
  )
  IS
    SELECT LD_deal.*,LD_deal.rowid
    FROM LD_deal
    WHERE  DEAL_Id = inuDEAL_Id
    FOR UPDATE NOWAIT;

  /* Cursor para bloqueo de un registro por rowid */
  CURSOR cuLockRcbyRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_deal.*,LD_deal.rowid
    FROM LD_deal
    WHERE
      rowId = irirowid
    FOR UPDATE NOWAIT;
  /*Tipos*/
  type tyrfLD_deal is ref cursor;

  /*Variables Globales*/
  rcRecOfTab tyrcLD_deal;

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

  FUNCTION fsbPrimaryKey( rcI in styLD_deal default rcData )
  return varchar2
  IS
    sbPk varchar2(500);
  BEGIN
    sbPk:='[';
    sbPk:=sbPk||ut_convert.fsbToChar(rcI.DEAL_Id);
    sbPk:=sbPk||']';
    return sbPk;
  END;

  PROCEDURE LockByPk
  (
    inuDEAL_Id in LD_deal.DEAL_Id%type,
    orcLD_deal  out styLD_deal
  )
  IS
    rcError styLD_deal;
  BEGIN
    rcError.DEAL_Id := inuDEAL_Id;

    Open cuLockRcByPk
    (
      inuDEAL_Id
    );

    fetch cuLockRcByPk into orcLD_deal;
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
    orcLD_deal  out styLD_deal
  )
  IS
  BEGIN
    Open cuLockRcbyRowId
    (
      irirowid
    );

    fetch cuLockRcbyRowId into orcLD_deal;
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
    itbLD_deal  in out nocopy tytbLD_deal
  )
  IS
  BEGIN
      rcRecOfTab.Deal_Id.delete;
      rcRecOfTab.Description.delete;
      rcRecOfTab.Initial_Date.delete;
      rcRecOfTab.Final_Date.delete;
      rcRecOfTab.Total_Value.delete;
      rcRecOfTab.Sponsor_Id.delete;
      rcRecOfTab.Disable_Deal.delete;
      rcRecOfTab.Disable_Date.delete;
      rcRecOfTab.row_id.delete;
  END;
  PROCEDURE FillRecordOfTables
  (
    itbLD_deal  in out nocopy tytbLD_deal,
    oblUseRowId out boolean
  )
  IS
  BEGIN
    DelRecordOfTables(itbLD_deal);
    for n in itbLD_deal.first .. itbLD_deal.last loop
      rcRecOfTab.Deal_Id(n) := itbLD_deal(n).Deal_Id;
      rcRecOfTab.Description(n) := itbLD_deal(n).Description;
      rcRecOfTab.Initial_Date(n) := itbLD_deal(n).Initial_Date;
      rcRecOfTab.Final_Date(n) := itbLD_deal(n).Final_Date;
      rcRecOfTab.Total_Value(n) := itbLD_deal(n).Total_Value;
      rcRecOfTab.Sponsor_Id(n) := itbLD_deal(n).Sponsor_Id;
      rcRecOfTab.Disable_Deal(n) := itbLD_deal(n).Disable_Deal;
      rcRecOfTab.Disable_Date(n) := itbLD_deal(n).Disable_Date;
      rcRecOfTab.row_id(n) := itbLD_deal(n).rowid;
      -- Indica si el rowid es Nulo
      oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
    end loop;
  END;


  PROCEDURE Load
  (
    inuDEAL_Id in LD_deal.DEAL_Id%type
  )
  IS
    rcRecordNull cuRecord%rowtype;
  BEGIN
    if cuRecord%isopen then
      close cuRecord;
    end if;
    open cuRecord
    (
      inuDEAL_Id
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
    inuDEAL_Id in LD_deal.DEAL_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    if (
      inuDEAL_Id = rcData.DEAL_Id
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
    inuDEAL_Id in LD_deal.DEAL_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    Load
    (
      inuDEAL_Id
    );
    return(TRUE);
  EXCEPTION
    when no_data_found then
      return(FALSE);
  END;

  PROCEDURE AccKey
  (
    inuDEAL_Id in LD_deal.DEAL_Id%type
  )
  IS
    rcError styLD_deal;
  BEGIN    rcError.DEAL_Id:=inuDEAL_Id;

    Load
    (
      inuDEAL_Id
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
    inuDEAL_Id in LD_deal.DEAL_Id%type
  )
  IS
  BEGIN
    Load
    (
      inuDEAL_Id
    );
    Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
    raise ex.CONTROLLED_ERROR;

  EXCEPTION
    when no_data_found then
      null;
  END;

  PROCEDURE getRecord
  (
    inuDEAL_Id in LD_deal.DEAL_Id%type,
    orcRecord out nocopy styLD_deal
  )
  IS
    rcError styLD_deal;
  BEGIN    rcError.DEAL_Id:=inuDEAL_Id;

    Load
    (
      inuDEAL_Id
    );
    orcRecord := rcData;
  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRecord
  (
    inuDEAL_Id in LD_deal.DEAL_Id%type
  )
  RETURN styLD_deal
  IS
    rcError styLD_deal;
  BEGIN
    rcError.DEAL_Id:=inuDEAL_Id;

    Load
    (
      inuDEAL_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  (
    inuDEAL_Id in LD_deal.DEAL_Id%type
  )
  RETURN styLD_deal
  IS
    rcError styLD_deal;
  BEGIN
    rcError.DEAL_Id:=inuDEAL_Id;
        -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
         inuDEAL_Id
       )
    then
       return(rcData);
    end if;
    Load
    (
      inuDEAL_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  RETURN styLD_deal
  IS
  BEGIN
    return(rcData);
  END;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_deal
  )
  IS
    rfLD_deal tyrfLD_deal;
    n number(4) := 1;
    sbFullQuery VARCHAR2 (32000) := 'SELECT
                LD_deal.Deal_Id,
                LD_deal.Description,
                LD_deal.Initial_Date,
                LD_deal.Final_Date,
                LD_deal.Total_Value,
                LD_deal.Sponsor_Id,
                LD_deal.Disable_Deal,
                LD_deal.Disable_Date,
                LD_deal.rowid
                FROM LD_deal';
    nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
  BEGIN
    otbResult.delete;
    if isbQuery is not NULL and length(isbQuery) > 0 then
      sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
    end if;
    open rfLD_deal for sbFullQuery;
    fetch rfLD_deal bulk collect INTO otbResult;
    close rfLD_deal;
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
                LD_deal.Deal_Id,
                LD_deal.Description,
                LD_deal.Initial_Date,
                LD_deal.Final_Date,
                LD_deal.Total_Value,
                LD_deal.Sponsor_Id,
                LD_deal.Disable_Deal,
                LD_deal.Disable_Date,
                LD_deal.rowid
                FROM LD_deal';
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
    ircLD_deal in styLD_deal
  )
  IS
    rirowid varchar2(200);
  BEGIN
    insRecord(ircLD_deal,rirowid);
  END;

  PROCEDURE insRecord
  (
    ircLD_deal in styLD_deal,
    orirowid   out varchar2
  )
  IS
  BEGIN
    if ircLD_deal.DEAL_Id is NULL then
      Errors.SetError(cnuINS_PK_NULL,
                      fsbGetMessageDescription||'|DEAL_Id');
      raise ex.controlled_error;
    end if;
    insert into LD_deal
    (
      Deal_Id,
      Description,
      Initial_Date,
      Final_Date,
      Total_Value,
      Sponsor_Id,
      Disable_Deal,
      Disable_Date
    )
    values
    (
      ircLD_deal.Deal_Id,
      ircLD_deal.Description,
      ircLD_deal.Initial_Date,
      ircLD_deal.Final_Date,
      ircLD_deal.Total_Value,
      ircLD_deal.Sponsor_Id,
      ircLD_deal.Disable_Deal,
      ircLD_deal.Disable_Date
    )
            returning
      rowid
    into
      orirowid;
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_deal));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE insRecords
  (
    iotbLD_deal in out nocopy tytbLD_deal
  )
  IS
    blUseRowID boolean;
  BEGIN
    FillRecordOfTables(iotbLD_deal, blUseRowID);
    forall n in iotbLD_deal.first..iotbLD_deal.last
      insert into LD_deal
      (
      Deal_Id,
      Description,
      Initial_Date,
      Final_Date,
      Total_Value,
      Sponsor_Id,
      Disable_Deal,
      Disable_Date
    )
    values
    (
      rcRecOfTab.Deal_Id(n),
      rcRecOfTab.Description(n),
      rcRecOfTab.Initial_Date(n),
      rcRecOfTab.Final_Date(n),
      rcRecOfTab.Total_Value(n),
      rcRecOfTab.Sponsor_Id(n),
      rcRecOfTab.Disable_Deal(n),
      rcRecOfTab.Disable_Date(n)
      );
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE delRecord
  (
    inuDEAL_Id in LD_deal.DEAL_Id%type,
    inuLock in number default 1
  )
  IS
    rcError styLD_deal;
  BEGIN
    rcError.DEAL_Id:=inuDEAL_Id;

    if inuLock=1 then
      LockByPk
      (
        inuDEAL_Id,
        rcData
      );
    end if;

    delete
    from LD_deal
    where
           DEAL_Id=inuDEAL_Id;
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
    rcError  styLD_deal;
  BEGIN
    if inuLock=1 then
      LockByRowId(iriRowID,rcData);
    end if;

    delete
    from LD_deal
    where
      rowid = iriRowID
    returning
   DEAL_Id
    into
      rcError.DEAL_Id;

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
    iotbLD_deal in out nocopy tytbLD_deal,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_deal;
  BEGIN
    FillRecordOfTables(iotbLD_deal, blUseRowID);
       if ( blUseRowId ) then
      if inuLock = 1 then
        for n in iotbLD_deal.first .. iotbLD_deal.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_deal.first .. iotbLD_deal.last
        delete
        from LD_deal
        where
          rowid = rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_deal.first .. iotbLD_deal.last loop
          LockByPk
          (
              rcRecOfTab.DEAL_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_deal.first .. iotbLD_deal.last
        delete
        from LD_deal
        where
               DEAL_Id = rcRecOfTab.DEAL_Id(n);
    end if;
  EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecord
  (
    ircLD_deal in styLD_deal,
    inuLock    in number default 0
  )
  IS
    nuDEAL_Id LD_deal.DEAL_Id%type;

  BEGIN
    if ircLD_deal.rowid is not null then
      if inuLock=1 then
        LockByRowId(ircLD_deal.rowid,rcData);
      end if;
      update LD_deal
      set

        Description = ircLD_deal.Description,
        Initial_Date = ircLD_deal.Initial_Date,
        Final_Date = ircLD_deal.Final_Date,
        Total_Value = ircLD_deal.Total_Value,
        Sponsor_Id = ircLD_deal.Sponsor_Id,
        Disable_Deal = ircLD_deal.Disable_Deal,
        Disable_Date = ircLD_deal.Disable_Date
      where
        rowid = ircLD_deal.rowid
      returning
    DEAL_Id
      into
        nuDEAL_Id;

    else
      if inuLock=1 then
        LockByPk
        (
          ircLD_deal.DEAL_Id,
          rcData
        );
      end if;

      update LD_deal
      set
        Description = ircLD_deal.Description,
        Initial_Date = ircLD_deal.Initial_Date,
        Final_Date = ircLD_deal.Final_Date,
        Total_Value = ircLD_deal.Total_Value,
        Sponsor_Id = ircLD_deal.Sponsor_Id,
        Disable_Deal = ircLD_deal.Disable_Deal,
        Disable_Date = ircLD_deal.Disable_Date
      where
             DEAL_Id = ircLD_deal.DEAL_Id
      returning
    DEAL_Id
      into
        nuDEAL_Id;
    end if;

    if
      nuDEAL_Id is NULL
    then
      raise no_data_found;
    end if;

  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_deal));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecords
  (
    iotbLD_deal in out nocopy tytbLD_deal,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_deal;
  BEGIN
    FillRecordOfTables(iotbLD_deal,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_deal.first .. iotbLD_deal.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_deal.first .. iotbLD_deal.last
        update LD_deal
        set

            Description = rcRecOfTab.Description(n),
            Initial_Date = rcRecOfTab.Initial_Date(n),
            Final_Date = rcRecOfTab.Final_Date(n),
            Total_Value = rcRecOfTab.Total_Value(n),
            Sponsor_Id = rcRecOfTab.Sponsor_Id(n),
            Disable_Deal = rcRecOfTab.Disable_Deal(n),
            Disable_Date = rcRecOfTab.Disable_Date(n)
          where
          rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_deal.first .. iotbLD_deal.last loop
          LockByPk
          (
              rcRecOfTab.DEAL_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_deal.first .. iotbLD_deal.last
        update LD_deal
        set
          Description = rcRecOfTab.Description(n),
          Initial_Date = rcRecOfTab.Initial_Date(n),
          Final_Date = rcRecOfTab.Final_Date(n),
          Total_Value = rcRecOfTab.Total_Value(n),
          Sponsor_Id = rcRecOfTab.Sponsor_Id(n),
          Disable_Deal = rcRecOfTab.Disable_Deal(n),
          Disable_Date = rcRecOfTab.Disable_Date(n)
          where
          DEAL_Id = rcRecOfTab.DEAL_Id(n)
;
    end if;
  END;

  PROCEDURE updDescription
  (
    inuDEAL_Id in LD_deal.DEAL_Id%type,
    isbDescription$ in LD_deal.Description%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_deal;
  BEGIN
    rcError.DEAL_Id := inuDEAL_Id;
    if inuLock=1 then
      LockByPk
      (
        inuDEAL_Id,
        rcData
      );
    end if;

    update LD_deal
    set
      Description = isbDescription$
    where
      DEAL_Id = inuDEAL_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Description:= isbDescription$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updInitial_Date
  (
    inuDEAL_Id in LD_deal.DEAL_Id%type,
    idtInitial_Date$ in LD_deal.Initial_Date%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_deal;
  BEGIN
    rcError.DEAL_Id := inuDEAL_Id;
    if inuLock=1 then
      LockByPk
      (
        inuDEAL_Id,
        rcData
      );
    end if;

    update LD_deal
    set
      Initial_Date = idtInitial_Date$
    where
      DEAL_Id = inuDEAL_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Initial_Date:= idtInitial_Date$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updFinal_Date
  (
    inuDEAL_Id in LD_deal.DEAL_Id%type,
    idtFinal_Date$ in LD_deal.Final_Date%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_deal;
  BEGIN
    rcError.DEAL_Id := inuDEAL_Id;
    if inuLock=1 then
      LockByPk
      (
        inuDEAL_Id,
        rcData
      );
    end if;

    update LD_deal
    set
      Final_Date = idtFinal_Date$
    where
      DEAL_Id = inuDEAL_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Final_Date:= idtFinal_Date$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updTotal_Value
  (
    inuDEAL_Id in LD_deal.DEAL_Id%type,
    inuTotal_Value$ in LD_deal.Total_Value%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_deal;
  BEGIN
    rcError.DEAL_Id := inuDEAL_Id;
    if inuLock=1 then
      LockByPk
      (
        inuDEAL_Id,
        rcData
      );
    end if;

    update LD_deal
    set
      Total_Value = inuTotal_Value$
    where
      DEAL_Id = inuDEAL_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Total_Value:= inuTotal_Value$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updSponsor_Id
  (
    inuDEAL_Id in LD_deal.DEAL_Id%type,
    inuSponsor_Id$ in LD_deal.Sponsor_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_deal;
  BEGIN
    rcError.DEAL_Id := inuDEAL_Id;
    if inuLock=1 then
      LockByPk
      (
        inuDEAL_Id,
        rcData
      );
    end if;

    update LD_deal
    set
      Sponsor_Id = inuSponsor_Id$
    where
      DEAL_Id = inuDEAL_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Sponsor_Id:= inuSponsor_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updDisable_Deal
  (
    inuDEAL_Id in LD_deal.DEAL_Id%type,
    isbDisable_Deal$ in LD_deal.Disable_Deal%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_deal;
  BEGIN
    rcError.DEAL_Id := inuDEAL_Id;
    if inuLock=1 then
      LockByPk
      (
        inuDEAL_Id,
        rcData
      );
    end if;

    update LD_deal
    set
      Disable_Deal = isbDisable_Deal$
    where
      DEAL_Id = inuDEAL_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Disable_Deal:= isbDisable_Deal$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updDisable_Date
  (
    inuDEAL_Id in LD_deal.DEAL_Id%type,
    idtDisable_Date$ in LD_deal.Disable_Date%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_deal;
  BEGIN
    rcError.DEAL_Id := inuDEAL_Id;
    if inuLock=1 then
      LockByPk
      (
        inuDEAL_Id,
        rcData
      );
    end if;

    update LD_deal
    set
      Disable_Date = idtDisable_Date$
    where
      DEAL_Id = inuDEAL_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Disable_Date:= idtDisable_Date$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;


  FUNCTION fnuGetDeal_Id
  (
    inuDEAL_Id in LD_deal.DEAL_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_deal.Deal_Id%type
  IS
    rcError styLD_deal;
  BEGIN

    rcError.DEAL_Id := inuDEAL_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuDEAL_Id
       )
    then
       return(rcData.Deal_Id);
    end if;
    Load
    (
      inuDEAL_Id
    );
    return(rcData.Deal_Id);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fsbGetDescription
  (
    inuDEAL_Id in LD_deal.DEAL_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_deal.Description%type
  IS
    rcError styLD_deal;
  BEGIN

    rcError.DEAL_Id:=inuDEAL_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuDEAL_Id
       )
    then
       return(rcData.Description);
    end if;
    Load
    (
      inuDEAL_Id
    );
    return(rcData.Description);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fdtGetInitial_Date
  (
    inuDEAL_Id in LD_deal.DEAL_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_deal.Initial_Date%type
  IS
    rcError styLD_deal;
  BEGIN

    rcError.DEAL_Id:=inuDEAL_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
         inuDEAL_Id
       )
    then
       return(rcData.Initial_Date);
    end if;
    Load
    (
         inuDEAL_Id
    );
    return(rcData.Initial_Date);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fdtGetFinal_Date
  (
    inuDEAL_Id in LD_deal.DEAL_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_deal.Final_Date%type
  IS
    rcError styLD_deal;
  BEGIN

    rcError.DEAL_Id:=inuDEAL_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
         inuDEAL_Id
       )
    then
       return(rcData.Final_Date);
    end if;
    Load
    (
         inuDEAL_Id
    );
    return(rcData.Final_Date);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetTotal_Value
  (
    inuDEAL_Id in LD_deal.DEAL_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_deal.Total_Value%type
  IS
    rcError styLD_deal;
  BEGIN

    rcError.DEAL_Id := inuDEAL_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuDEAL_Id
       )
    then
       return(rcData.Total_Value);
    end if;
    Load
    (
      inuDEAL_Id
    );
    return(rcData.Total_Value);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetSponsor_Id
  (
    inuDEAL_Id in LD_deal.DEAL_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_deal.Sponsor_Id%type
  IS
    rcError styLD_deal;
  BEGIN

    rcError.DEAL_Id := inuDEAL_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuDEAL_Id
       )
    then
       return(rcData.Sponsor_Id);
    end if;
    Load
    (
      inuDEAL_Id
    );
    return(rcData.Sponsor_Id);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fsbGetDisable_Deal
  (
    inuDEAL_Id in LD_deal.DEAL_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_deal.Disable_Deal%type
  IS
    rcError styLD_deal;
  BEGIN

    rcError.DEAL_Id:=inuDEAL_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuDEAL_Id
       )
    then
       return(rcData.Disable_Deal);
    end if;
    Load
    (
      inuDEAL_Id
    );
    return(rcData.Disable_Deal);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fdtGetDisable_Date
  (
    inuDEAL_Id in LD_deal.DEAL_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_deal.Disable_Date%type
  IS
    rcError styLD_deal;
  BEGIN

    rcError.DEAL_Id:=inuDEAL_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
         inuDEAL_Id
       )
    then
       return(rcData.Disable_Date);
    end if;
    Load
    (
         inuDEAL_Id
    );
    return(rcData.Disable_Date);
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
end DALD_deal;
/
PROMPT Otorgando permisos de ejecucion a DALD_DEAL
BEGIN
    pkg_utilidades.praplicarpermisos('DALD_DEAL', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON ADM_PERSON.dald_deal TO REXEREPORTES;
/