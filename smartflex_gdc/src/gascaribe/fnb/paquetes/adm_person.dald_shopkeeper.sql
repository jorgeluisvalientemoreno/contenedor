CREATE OR REPLACE PACKAGE adm_person.DALD_shopkeeper
is
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     : DALD_SHOPKEEPER
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
    inuShopkeeper_Id in LD_shopkeeper.Shopkeeper_Id%type
  )
  IS
    SELECT LD_shopkeeper.*,LD_shopkeeper.rowid
    FROM LD_shopkeeper
    WHERE
      Shopkeeper_Id = inuShopkeeper_Id;


  /* Cursor general para acceso por RowId */
  CURSOR cuRecordByRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_shopkeeper.*,LD_shopkeeper.rowid
    FROM LD_shopkeeper
    WHERE
      rowId = irirowid;


  /* Subtipos */
  subtype styLD_shopkeeper  is  cuRecord%rowtype;
  type tyRefCursor is  REF CURSOR;

  /*Tipos*/
  type tytbLD_shopkeeper is table of styLD_shopkeeper index by binary_integer;
  type tyrfRecords is ref cursor return styLD_shopkeeper;

  /* Tipos referenciando al registro */
  type tytbShopkeeper_Id is table of LD_shopkeeper.Shopkeeper_Id%type index by binary_integer;
  type tytbName is table of LD_shopkeeper.Name%type index by binary_integer;
  type tytbIdentifica_Type_Id is table of LD_shopkeeper.Identifica_Type_Id%type index by binary_integer;
  type tytbIdentification_Id is table of LD_shopkeeper.Identification_Id%type index by binary_integer;
  type tytbAddress_Id is table of LD_shopkeeper.Address_Id%type index by binary_integer;
  type tytbPhone_Number is table of LD_shopkeeper.Phone_Number%type index by binary_integer;
  type tytbEmail is table of LD_shopkeeper.Email%type index by binary_integer;
  type tytbGeographic_Location_Id is table of LD_shopkeeper.Geographic_Location_Id%type index by binary_integer;
  type tytbrowid is table of rowid index by binary_integer;

  type tyrcLD_shopkeeper is record
  (

    Shopkeeper_Id   tytbShopkeeper_Id,
    Name   tytbName,
    Identifica_Type_Id   tytbIdentifica_Type_Id,
    Identification_Id   tytbIdentification_Id,
    Address_Id   tytbAddress_Id,
    Phone_Number   tytbPhone_Number,
    Email   tytbEmail,
    Geographic_Location_Id   tytbGeographic_Location_Id,
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
    inuShopkeeper_Id in LD_shopkeeper.Shopkeeper_Id%type
  )
  RETURN boolean;

   PROCEDURE AccKey
   (
     inuShopkeeper_Id in LD_shopkeeper.Shopkeeper_Id%type
  );

  PROCEDURE AccKeyByRowId
  (
    iriRowID    in rowid
  );

  PROCEDURE ValDuplicate
  (
     inuShopkeeper_Id in LD_shopkeeper.Shopkeeper_Id%type
  );

  PROCEDURE getRecord
  (
    inuShopkeeper_Id in LD_shopkeeper.Shopkeeper_Id%type,
    orcRecord out nocopy styLD_shopkeeper
  );

  FUNCTION frcGetRcData
  (
    inuShopkeeper_Id in LD_shopkeeper.Shopkeeper_Id%type
  )
  RETURN styLD_shopkeeper;

  FUNCTION frcGetRcData
  RETURN styLD_shopkeeper;

  FUNCTION frcGetRecord
  (
    inuShopkeeper_Id in LD_shopkeeper.Shopkeeper_Id%type
  )
  RETURN styLD_shopkeeper;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_shopkeeper
  );

  FUNCTION frfGetRecords
  (
    isbCriteria in varchar2 default null,
    iblLock in boolean default false
  )
  RETURN tyRefCursor;

  PROCEDURE insRecord
  (
    ircLD_shopkeeper in styLD_shopkeeper
  );

     PROCEDURE insRecord
  (
    ircLD_shopkeeper in styLD_shopkeeper,
    orirowid   out varchar2
  );

  PROCEDURE insRecords
  (
    iotbLD_shopkeeper in out nocopy tytbLD_shopkeeper
  );

  PROCEDURE delRecord
  (
    inuShopkeeper_Id in LD_shopkeeper.Shopkeeper_Id%type,
    inuLock in number default 1
  );

  PROCEDURE delByRowID
  (
    iriRowID    in rowid,
    inuLock in number default 1
  );

  PROCEDURE delRecords
  (
    iotbLD_shopkeeper in out nocopy tytbLD_shopkeeper,
    inuLock in number default 1
  );

  PROCEDURE updRecord
  (
    ircLD_shopkeeper in styLD_shopkeeper,
    inuLock    in number default 0
  );

  PROCEDURE updRecords
  (
    iotbLD_shopkeeper in out nocopy tytbLD_shopkeeper,
    inuLock in number default 1
  );

    PROCEDURE updName
    (
        inuShopkeeper_Id   in LD_shopkeeper.Shopkeeper_Id%type,
        isbName$  in LD_shopkeeper.Name%type,
        inuLock    in number default 0
      );

    PROCEDURE updIdentifica_Type_Id
    (
        inuShopkeeper_Id   in LD_shopkeeper.Shopkeeper_Id%type,
        inuIdentifica_Type_Id$  in LD_shopkeeper.Identifica_Type_Id%type,
        inuLock    in number default 0
      );

    PROCEDURE updIdentification_Id
    (
        inuShopkeeper_Id   in LD_shopkeeper.Shopkeeper_Id%type,
        isbIdentification_Id$  in LD_shopkeeper.Identification_Id%type,
        inuLock    in number default 0
      );

    PROCEDURE updAddress_Id
    (
        inuShopkeeper_Id   in LD_shopkeeper.Shopkeeper_Id%type,
        inuAddress_Id$  in LD_shopkeeper.Address_Id%type,
        inuLock    in number default 0
      );

    PROCEDURE updPhone_Number
    (
        inuShopkeeper_Id   in LD_shopkeeper.Shopkeeper_Id%type,
        isbPhone_Number$  in LD_shopkeeper.Phone_Number%type,
        inuLock    in number default 0
      );

    PROCEDURE updEmail
    (
        inuShopkeeper_Id   in LD_shopkeeper.Shopkeeper_Id%type,
        isbEmail$  in LD_shopkeeper.Email%type,
        inuLock    in number default 0
      );

    PROCEDURE updGeographic_Location_Id
    (
        inuShopkeeper_Id   in LD_shopkeeper.Shopkeeper_Id%type,
        inuGeographic_Location_Id$  in LD_shopkeeper.Geographic_Location_Id%type,
        inuLock    in number default 0
      );

      FUNCTION fnuGetShopkeeper_Id
      (
          inuShopkeeper_Id in LD_shopkeeper.Shopkeeper_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_shopkeeper.Shopkeeper_Id%type;

      FUNCTION fsbGetName
      (
          inuShopkeeper_Id in LD_shopkeeper.Shopkeeper_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_shopkeeper.Name%type;

      FUNCTION fnuGetIdentifica_Type_Id
      (
          inuShopkeeper_Id in LD_shopkeeper.Shopkeeper_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_shopkeeper.Identifica_Type_Id%type;

      FUNCTION fsbGetIdentification_Id
      (
          inuShopkeeper_Id in LD_shopkeeper.Shopkeeper_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_shopkeeper.Identification_Id%type;

      FUNCTION fnuGetAddress_Id
      (
          inuShopkeeper_Id in LD_shopkeeper.Shopkeeper_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_shopkeeper.Address_Id%type;

      FUNCTION fsbGetPhone_Number
      (
          inuShopkeeper_Id in LD_shopkeeper.Shopkeeper_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_shopkeeper.Phone_Number%type;

      FUNCTION fsbGetEmail
      (
          inuShopkeeper_Id in LD_shopkeeper.Shopkeeper_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_shopkeeper.Email%type;

      FUNCTION fnuGetGeographic_Location_Id
      (
          inuShopkeeper_Id in LD_shopkeeper.Shopkeeper_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_shopkeeper.Geographic_Location_Id%type;


  PROCEDURE LockByPk
  (
    inuShopkeeper_Id in LD_shopkeeper.Shopkeeper_Id%type,
    orcLD_shopkeeper  out styLD_shopkeeper
  );

  PROCEDURE LockByRowID
  (
    irirowid    in  varchar2,
    orcLD_shopkeeper  out styLD_shopkeeper
  );

  PROCEDURE SetUseCache
  (
    iblUseCache    in  boolean
  );
END DALD_shopkeeper;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_shopkeeper
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO159429';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_SHOPKEEPER';
    cnuGeEntityId constant varchar2(30) := 7240; -- Id de Ge_entity

  /* Cursor para bloqueo de un registro por llave primaria */
  CURSOR cuLockRcByPk
  (
    inuShopkeeper_Id in LD_shopkeeper.Shopkeeper_Id%type
  )
  IS
    SELECT LD_shopkeeper.*,LD_shopkeeper.rowid
    FROM LD_shopkeeper
    WHERE  Shopkeeper_Id = inuShopkeeper_Id
    FOR UPDATE NOWAIT;

  /* Cursor para bloqueo de un registro por rowid */
  CURSOR cuLockRcbyRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_shopkeeper.*,LD_shopkeeper.rowid
    FROM LD_shopkeeper
    WHERE
      rowId = irirowid
    FOR UPDATE NOWAIT;
  /*Tipos*/
  type tyrfLD_shopkeeper is ref cursor;

  /*Variables Globales*/
  rcRecOfTab tyrcLD_shopkeeper;

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

  FUNCTION fsbPrimaryKey( rcI in styLD_shopkeeper default rcData )
  return varchar2
  IS
    sbPk varchar2(500);
  BEGIN
    sbPk:='[';
    sbPk:=sbPk||ut_convert.fsbToChar(rcI.Shopkeeper_Id);
    sbPk:=sbPk||']';
    return sbPk;
  END;

  PROCEDURE LockByPk
  (
    inuShopkeeper_Id in LD_shopkeeper.Shopkeeper_Id%type,
    orcLD_shopkeeper  out styLD_shopkeeper
  )
  IS
    rcError styLD_shopkeeper;
  BEGIN
    rcError.Shopkeeper_Id := inuShopkeeper_Id;

    Open cuLockRcByPk
    (
      inuShopkeeper_Id
    );

    fetch cuLockRcByPk into orcLD_shopkeeper;
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
    orcLD_shopkeeper  out styLD_shopkeeper
  )
  IS
  BEGIN
    Open cuLockRcbyRowId
    (
      irirowid
    );

    fetch cuLockRcbyRowId into orcLD_shopkeeper;
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
    itbLD_shopkeeper  in out nocopy tytbLD_shopkeeper
  )
  IS
  BEGIN
      rcRecOfTab.Shopkeeper_Id.delete;
      rcRecOfTab.Name.delete;
      rcRecOfTab.Identifica_Type_Id.delete;
      rcRecOfTab.Identification_Id.delete;
      rcRecOfTab.Address_Id.delete;
      rcRecOfTab.Phone_Number.delete;
      rcRecOfTab.Email.delete;
      rcRecOfTab.Geographic_Location_Id.delete;
      rcRecOfTab.row_id.delete;
  END;
  PROCEDURE FillRecordOfTables
  (
    itbLD_shopkeeper  in out nocopy tytbLD_shopkeeper,
    oblUseRowId out boolean
  )
  IS
  BEGIN
    DelRecordOfTables(itbLD_shopkeeper);
    for n in itbLD_shopkeeper.first .. itbLD_shopkeeper.last loop
      rcRecOfTab.Shopkeeper_Id(n) := itbLD_shopkeeper(n).Shopkeeper_Id;
      rcRecOfTab.Name(n) := itbLD_shopkeeper(n).Name;
      rcRecOfTab.Identifica_Type_Id(n) := itbLD_shopkeeper(n).Identifica_Type_Id;
      rcRecOfTab.Identification_Id(n) := itbLD_shopkeeper(n).Identification_Id;
      rcRecOfTab.Address_Id(n) := itbLD_shopkeeper(n).Address_Id;
      rcRecOfTab.Phone_Number(n) := itbLD_shopkeeper(n).Phone_Number;
      rcRecOfTab.Email(n) := itbLD_shopkeeper(n).Email;
      rcRecOfTab.Geographic_Location_Id(n) := itbLD_shopkeeper(n).Geographic_Location_Id;
      rcRecOfTab.row_id(n) := itbLD_shopkeeper(n).rowid;
      -- Indica si el rowid es Nulo
      oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
    end loop;
  END;


  PROCEDURE Load
  (
    inuShopkeeper_Id in LD_shopkeeper.Shopkeeper_Id%type
  )
  IS
    rcRecordNull cuRecord%rowtype;
  BEGIN
    if cuRecord%isopen then
      close cuRecord;
    end if;
    open cuRecord
    (
      inuShopkeeper_Id
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
    inuShopkeeper_Id in LD_shopkeeper.Shopkeeper_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    if (
      inuShopkeeper_Id = rcData.Shopkeeper_Id
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
    inuShopkeeper_Id in LD_shopkeeper.Shopkeeper_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    Load
    (
      inuShopkeeper_Id
    );
    return(TRUE);
  EXCEPTION
    when no_data_found then
      return(FALSE);
  END;

  PROCEDURE AccKey
  (
    inuShopkeeper_Id in LD_shopkeeper.Shopkeeper_Id%type
  )
  IS
    rcError styLD_shopkeeper;
  BEGIN    rcError.Shopkeeper_Id:=inuShopkeeper_Id;

    Load
    (
      inuShopkeeper_Id
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
    inuShopkeeper_Id in LD_shopkeeper.Shopkeeper_Id%type
  )
  IS
  BEGIN
    Load
    (
      inuShopkeeper_Id
    );
    Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
    raise ex.CONTROLLED_ERROR;

  EXCEPTION
    when no_data_found then
      null;
  END;

  PROCEDURE getRecord
  (
    inuShopkeeper_Id in LD_shopkeeper.Shopkeeper_Id%type,
    orcRecord out nocopy styLD_shopkeeper
  )
  IS
    rcError styLD_shopkeeper;
  BEGIN    rcError.Shopkeeper_Id:=inuShopkeeper_Id;

    Load
    (
      inuShopkeeper_Id
    );
    orcRecord := rcData;
  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRecord
  (
    inuShopkeeper_Id in LD_shopkeeper.Shopkeeper_Id%type
  )
  RETURN styLD_shopkeeper
  IS
    rcError styLD_shopkeeper;
  BEGIN
    rcError.Shopkeeper_Id:=inuShopkeeper_Id;

    Load
    (
      inuShopkeeper_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  (
    inuShopkeeper_Id in LD_shopkeeper.Shopkeeper_Id%type
  )
  RETURN styLD_shopkeeper
  IS
    rcError styLD_shopkeeper;
  BEGIN
    rcError.Shopkeeper_Id:=inuShopkeeper_Id;
        -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
         inuShopkeeper_Id
       )
    then
       return(rcData);
    end if;
    Load
    (
      inuShopkeeper_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  RETURN styLD_shopkeeper
  IS
  BEGIN
    return(rcData);
  END;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_shopkeeper
  )
  IS
    rfLD_shopkeeper tyrfLD_shopkeeper;
    n number(4) := 1;
    sbFullQuery VARCHAR2 (32000) := 'SELECT
                LD_shopkeeper.Shopkeeper_Id,
                LD_shopkeeper.Name,
                LD_shopkeeper.Identifica_Type_Id,
                LD_shopkeeper.Identification_Id,
                LD_shopkeeper.Address_Id,
                LD_shopkeeper.Phone_Number,
                LD_shopkeeper.Email,
                LD_shopkeeper.Geographic_Location_Id,
                LD_shopkeeper.rowid
                FROM LD_shopkeeper';
    nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
  BEGIN
    otbResult.delete;
    if isbQuery is not NULL and length(isbQuery) > 0 then
      sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
    end if;
    open rfLD_shopkeeper for sbFullQuery;
    fetch rfLD_shopkeeper bulk collect INTO otbResult;
    close rfLD_shopkeeper;
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
                LD_shopkeeper.Shopkeeper_Id,
                LD_shopkeeper.Name,
                LD_shopkeeper.Identifica_Type_Id,
                LD_shopkeeper.Identification_Id,
                LD_shopkeeper.Address_Id,
                LD_shopkeeper.Phone_Number,
                LD_shopkeeper.Email,
                LD_shopkeeper.Geographic_Location_Id,
                LD_shopkeeper.rowid
                FROM LD_shopkeeper';
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
    ircLD_shopkeeper in styLD_shopkeeper
  )
  IS
    rirowid varchar2(200);
  BEGIN
    insRecord(ircLD_shopkeeper,rirowid);
  END;

  PROCEDURE insRecord
  (
    ircLD_shopkeeper in styLD_shopkeeper,
    orirowid   out varchar2
  )
  IS
  BEGIN
    if ircLD_shopkeeper.Shopkeeper_Id is NULL then
      Errors.SetError(cnuINS_PK_NULL,
                      fsbGetMessageDescription||'|Shopkeeper_Id');
      raise ex.controlled_error;
    end if;
    insert into LD_shopkeeper
    (
      Shopkeeper_Id,
      Name,
      Identifica_Type_Id,
      Identification_Id,
      Address_Id,
      Phone_Number,
      Email,
      Geographic_Location_Id
    )
    values
    (
      ircLD_shopkeeper.Shopkeeper_Id,
      ircLD_shopkeeper.Name,
      ircLD_shopkeeper.Identifica_Type_Id,
      ircLD_shopkeeper.Identification_Id,
      ircLD_shopkeeper.Address_Id,
      ircLD_shopkeeper.Phone_Number,
      ircLD_shopkeeper.Email,
      ircLD_shopkeeper.Geographic_Location_Id
    )
            returning
      rowid
    into
      orirowid;
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_shopkeeper));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE insRecords
  (
    iotbLD_shopkeeper in out nocopy tytbLD_shopkeeper
  )
  IS
    blUseRowID boolean;
  BEGIN
    FillRecordOfTables(iotbLD_shopkeeper, blUseRowID);
    forall n in iotbLD_shopkeeper.first..iotbLD_shopkeeper.last
      insert into LD_shopkeeper
      (
      Shopkeeper_Id,
      Name,
      Identifica_Type_Id,
      Identification_Id,
      Address_Id,
      Phone_Number,
      Email,
      Geographic_Location_Id
    )
    values
    (
      rcRecOfTab.Shopkeeper_Id(n),
      rcRecOfTab.Name(n),
      rcRecOfTab.Identifica_Type_Id(n),
      rcRecOfTab.Identification_Id(n),
      rcRecOfTab.Address_Id(n),
      rcRecOfTab.Phone_Number(n),
      rcRecOfTab.Email(n),
      rcRecOfTab.Geographic_Location_Id(n)
      );
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE delRecord
  (
    inuShopkeeper_Id in LD_shopkeeper.Shopkeeper_Id%type,
    inuLock in number default 1
  )
  IS
    rcError styLD_shopkeeper;
  BEGIN
    rcError.Shopkeeper_Id:=inuShopkeeper_Id;

    if inuLock=1 then
      LockByPk
      (
        inuShopkeeper_Id,
        rcData
      );
    end if;

    delete
    from LD_shopkeeper
    where
           Shopkeeper_Id=inuShopkeeper_Id;
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
    rcError  styLD_shopkeeper;
  BEGIN
    if inuLock=1 then
      LockByRowId(iriRowID,rcData);
    end if;

    delete
    from LD_shopkeeper
    where
      rowid = iriRowID
    returning
   Shopkeeper_Id
    into
      rcError.Shopkeeper_Id;

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
    iotbLD_shopkeeper in out nocopy tytbLD_shopkeeper,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_shopkeeper;
  BEGIN
    FillRecordOfTables(iotbLD_shopkeeper, blUseRowID);
       if ( blUseRowId ) then
      if inuLock = 1 then
        for n in iotbLD_shopkeeper.first .. iotbLD_shopkeeper.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_shopkeeper.first .. iotbLD_shopkeeper.last
        delete
        from LD_shopkeeper
        where
          rowid = rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_shopkeeper.first .. iotbLD_shopkeeper.last loop
          LockByPk
          (
              rcRecOfTab.Shopkeeper_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_shopkeeper.first .. iotbLD_shopkeeper.last
        delete
        from LD_shopkeeper
        where
               Shopkeeper_Id = rcRecOfTab.Shopkeeper_Id(n);
    end if;
  EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecord
  (
    ircLD_shopkeeper in styLD_shopkeeper,
    inuLock    in number default 0
  )
  IS
    nuShopkeeper_Id LD_shopkeeper.Shopkeeper_Id%type;

  BEGIN
    if ircLD_shopkeeper.rowid is not null then
      if inuLock=1 then
        LockByRowId(ircLD_shopkeeper.rowid,rcData);
      end if;
      update LD_shopkeeper
      set

        Name = ircLD_shopkeeper.Name,
        Identifica_Type_Id = ircLD_shopkeeper.Identifica_Type_Id,
        Identification_Id = ircLD_shopkeeper.Identification_Id,
        Address_Id = ircLD_shopkeeper.Address_Id,
        Phone_Number = ircLD_shopkeeper.Phone_Number,
        Email = ircLD_shopkeeper.Email,
        Geographic_Location_Id = ircLD_shopkeeper.Geographic_Location_Id
      where
        rowid = ircLD_shopkeeper.rowid
      returning
    Shopkeeper_Id
      into
        nuShopkeeper_Id;

    else
      if inuLock=1 then
        LockByPk
        (
          ircLD_shopkeeper.Shopkeeper_Id,
          rcData
        );
      end if;

      update LD_shopkeeper
      set
        Name = ircLD_shopkeeper.Name,
        Identifica_Type_Id = ircLD_shopkeeper.Identifica_Type_Id,
        Identification_Id = ircLD_shopkeeper.Identification_Id,
        Address_Id = ircLD_shopkeeper.Address_Id,
        Phone_Number = ircLD_shopkeeper.Phone_Number,
        Email = ircLD_shopkeeper.Email,
        Geographic_Location_Id = ircLD_shopkeeper.Geographic_Location_Id
      where
             Shopkeeper_Id = ircLD_shopkeeper.Shopkeeper_Id
      returning
    Shopkeeper_Id
      into
        nuShopkeeper_Id;
    end if;

    if
      nuShopkeeper_Id is NULL
    then
      raise no_data_found;
    end if;

  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_shopkeeper));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecords
  (
    iotbLD_shopkeeper in out nocopy tytbLD_shopkeeper,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_shopkeeper;
  BEGIN
    FillRecordOfTables(iotbLD_shopkeeper,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_shopkeeper.first .. iotbLD_shopkeeper.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_shopkeeper.first .. iotbLD_shopkeeper.last
        update LD_shopkeeper
        set

            Name = rcRecOfTab.Name(n),
            Identifica_Type_Id = rcRecOfTab.Identifica_Type_Id(n),
            Identification_Id = rcRecOfTab.Identification_Id(n),
            Address_Id = rcRecOfTab.Address_Id(n),
            Phone_Number = rcRecOfTab.Phone_Number(n),
            Email = rcRecOfTab.Email(n),
            Geographic_Location_Id = rcRecOfTab.Geographic_Location_Id(n)
          where
          rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_shopkeeper.first .. iotbLD_shopkeeper.last loop
          LockByPk
          (
              rcRecOfTab.Shopkeeper_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_shopkeeper.first .. iotbLD_shopkeeper.last
        update LD_shopkeeper
        set
          Name = rcRecOfTab.Name(n),
          Identifica_Type_Id = rcRecOfTab.Identifica_Type_Id(n),
          Identification_Id = rcRecOfTab.Identification_Id(n),
          Address_Id = rcRecOfTab.Address_Id(n),
          Phone_Number = rcRecOfTab.Phone_Number(n),
          Email = rcRecOfTab.Email(n),
          Geographic_Location_Id = rcRecOfTab.Geographic_Location_Id(n)
          where
          Shopkeeper_Id = rcRecOfTab.Shopkeeper_Id(n)
;
    end if;
  END;

  PROCEDURE updName
  (
    inuShopkeeper_Id in LD_shopkeeper.Shopkeeper_Id%type,
    isbName$ in LD_shopkeeper.Name%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_shopkeeper;
  BEGIN
    rcError.Shopkeeper_Id := inuShopkeeper_Id;
    if inuLock=1 then
      LockByPk
      (
        inuShopkeeper_Id,
        rcData
      );
    end if;

    update LD_shopkeeper
    set
      Name = isbName$
    where
      Shopkeeper_Id = inuShopkeeper_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Name:= isbName$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updIdentifica_Type_Id
  (
    inuShopkeeper_Id in LD_shopkeeper.Shopkeeper_Id%type,
    inuIdentifica_Type_Id$ in LD_shopkeeper.Identifica_Type_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_shopkeeper;
  BEGIN
    rcError.Shopkeeper_Id := inuShopkeeper_Id;
    if inuLock=1 then
      LockByPk
      (
        inuShopkeeper_Id,
        rcData
      );
    end if;

    update LD_shopkeeper
    set
      Identifica_Type_Id = inuIdentifica_Type_Id$
    where
      Shopkeeper_Id = inuShopkeeper_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Identifica_Type_Id:= inuIdentifica_Type_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updIdentification_Id
  (
    inuShopkeeper_Id in LD_shopkeeper.Shopkeeper_Id%type,
    isbIdentification_Id$ in LD_shopkeeper.Identification_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_shopkeeper;
  BEGIN
    rcError.Shopkeeper_Id := inuShopkeeper_Id;
    if inuLock=1 then
      LockByPk
      (
        inuShopkeeper_Id,
        rcData
      );
    end if;

    update LD_shopkeeper
    set
      Identification_Id = isbIdentification_Id$
    where
      Shopkeeper_Id = inuShopkeeper_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Identification_Id:= isbIdentification_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updAddress_Id
  (
    inuShopkeeper_Id in LD_shopkeeper.Shopkeeper_Id%type,
    inuAddress_Id$ in LD_shopkeeper.Address_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_shopkeeper;
  BEGIN
    rcError.Shopkeeper_Id := inuShopkeeper_Id;
    if inuLock=1 then
      LockByPk
      (
        inuShopkeeper_Id,
        rcData
      );
    end if;

    update LD_shopkeeper
    set
      Address_Id = inuAddress_Id$
    where
      Shopkeeper_Id = inuShopkeeper_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Address_Id:= inuAddress_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updPhone_Number
  (
    inuShopkeeper_Id in LD_shopkeeper.Shopkeeper_Id%type,
    isbPhone_Number$ in LD_shopkeeper.Phone_Number%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_shopkeeper;
  BEGIN
    rcError.Shopkeeper_Id := inuShopkeeper_Id;
    if inuLock=1 then
      LockByPk
      (
        inuShopkeeper_Id,
        rcData
      );
    end if;

    update LD_shopkeeper
    set
      Phone_Number = isbPhone_Number$
    where
      Shopkeeper_Id = inuShopkeeper_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Phone_Number:= isbPhone_Number$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updEmail
  (
    inuShopkeeper_Id in LD_shopkeeper.Shopkeeper_Id%type,
    isbEmail$ in LD_shopkeeper.Email%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_shopkeeper;
  BEGIN
    rcError.Shopkeeper_Id := inuShopkeeper_Id;
    if inuLock=1 then
      LockByPk
      (
        inuShopkeeper_Id,
        rcData
      );
    end if;

    update LD_shopkeeper
    set
      Email = isbEmail$
    where
      Shopkeeper_Id = inuShopkeeper_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Email:= isbEmail$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updGeographic_Location_Id
  (
    inuShopkeeper_Id in LD_shopkeeper.Shopkeeper_Id%type,
    inuGeographic_Location_Id$ in LD_shopkeeper.Geographic_Location_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_shopkeeper;
  BEGIN
    rcError.Shopkeeper_Id := inuShopkeeper_Id;
    if inuLock=1 then
      LockByPk
      (
        inuShopkeeper_Id,
        rcData
      );
    end if;

    update LD_shopkeeper
    set
      Geographic_Location_Id = inuGeographic_Location_Id$
    where
      Shopkeeper_Id = inuShopkeeper_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Geographic_Location_Id:= inuGeographic_Location_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;


  FUNCTION fnuGetShopkeeper_Id
  (
    inuShopkeeper_Id in LD_shopkeeper.Shopkeeper_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_shopkeeper.Shopkeeper_Id%type
  IS
    rcError styLD_shopkeeper;
  BEGIN

    rcError.Shopkeeper_Id := inuShopkeeper_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuShopkeeper_Id
       )
    then
       return(rcData.Shopkeeper_Id);
    end if;
    Load
    (
      inuShopkeeper_Id
    );
    return(rcData.Shopkeeper_Id);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fsbGetName
  (
    inuShopkeeper_Id in LD_shopkeeper.Shopkeeper_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_shopkeeper.Name%type
  IS
    rcError styLD_shopkeeper;
  BEGIN

    rcError.Shopkeeper_Id:=inuShopkeeper_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuShopkeeper_Id
       )
    then
       return(rcData.Name);
    end if;
    Load
    (
      inuShopkeeper_Id
    );
    return(rcData.Name);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetIdentifica_Type_Id
  (
    inuShopkeeper_Id in LD_shopkeeper.Shopkeeper_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_shopkeeper.Identifica_Type_Id%type
  IS
    rcError styLD_shopkeeper;
  BEGIN

    rcError.Shopkeeper_Id := inuShopkeeper_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuShopkeeper_Id
       )
    then
       return(rcData.Identifica_Type_Id);
    end if;
    Load
    (
      inuShopkeeper_Id
    );
    return(rcData.Identifica_Type_Id);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fsbGetIdentification_Id
  (
    inuShopkeeper_Id in LD_shopkeeper.Shopkeeper_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_shopkeeper.Identification_Id%type
  IS
    rcError styLD_shopkeeper;
  BEGIN

    rcError.Shopkeeper_Id:=inuShopkeeper_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuShopkeeper_Id
       )
    then
       return(rcData.Identification_Id);
    end if;
    Load
    (
      inuShopkeeper_Id
    );
    return(rcData.Identification_Id);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetAddress_Id
  (
    inuShopkeeper_Id in LD_shopkeeper.Shopkeeper_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_shopkeeper.Address_Id%type
  IS
    rcError styLD_shopkeeper;
  BEGIN

    rcError.Shopkeeper_Id := inuShopkeeper_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuShopkeeper_Id
       )
    then
       return(rcData.Address_Id);
    end if;
    Load
    (
      inuShopkeeper_Id
    );
    return(rcData.Address_Id);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fsbGetPhone_Number
  (
    inuShopkeeper_Id in LD_shopkeeper.Shopkeeper_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_shopkeeper.Phone_Number%type
  IS
    rcError styLD_shopkeeper;
  BEGIN

    rcError.Shopkeeper_Id:=inuShopkeeper_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuShopkeeper_Id
       )
    then
       return(rcData.Phone_Number);
    end if;
    Load
    (
      inuShopkeeper_Id
    );
    return(rcData.Phone_Number);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fsbGetEmail
  (
    inuShopkeeper_Id in LD_shopkeeper.Shopkeeper_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_shopkeeper.Email%type
  IS
    rcError styLD_shopkeeper;
  BEGIN

    rcError.Shopkeeper_Id:=inuShopkeeper_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuShopkeeper_Id
       )
    then
       return(rcData.Email);
    end if;
    Load
    (
      inuShopkeeper_Id
    );
    return(rcData.Email);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetGeographic_Location_Id
  (
    inuShopkeeper_Id in LD_shopkeeper.Shopkeeper_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_shopkeeper.Geographic_Location_Id%type
  IS
    rcError styLD_shopkeeper;
  BEGIN

    rcError.Shopkeeper_Id := inuShopkeeper_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuShopkeeper_Id
       )
    then
       return(rcData.Geographic_Location_Id);
    end if;
    Load
    (
      inuShopkeeper_Id
    );
    return(rcData.Geographic_Location_Id);
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
end DALD_shopkeeper;
/
PROMPT Otorgando permisos de ejecucion a DALD_SHOPKEEPER
BEGIN
    pkg_utilidades.praplicarpermisos('DALD_SHOPKEEPER', 'ADM_PERSON');
END;
/