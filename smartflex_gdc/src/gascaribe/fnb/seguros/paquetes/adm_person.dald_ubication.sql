CREATE OR REPLACE PACKAGE adm_person.DALD_ubication
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
    inuUBICATION_Id in LD_ubication.UBICATION_Id%type
  )
  IS
    SELECT LD_ubication.*,LD_ubication.rowid
    FROM LD_ubication
    WHERE
      UBICATION_Id = inuUBICATION_Id;


  /* Cursor general para acceso por RowId */
  CURSOR cuRecordByRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_ubication.*,LD_ubication.rowid
    FROM LD_ubication
    WHERE
      rowId = irirowid;


  /* Subtipos */
  subtype styLD_ubication  is  cuRecord%rowtype;
  type tyRefCursor is  REF CURSOR;

  /*Tipos*/
  type tytbLD_ubication is table of styLD_ubication index by binary_integer;
  type tyrfRecords is ref cursor return styLD_ubication;

  /* Tipos referenciando al registro */
  type tytbUbication_Id is table of LD_ubication.Ubication_Id%type index by binary_integer;
  type tytbSubsidy_Id is table of LD_ubication.Subsidy_Id%type index by binary_integer;
  type tytbGeogra_Location_Id is table of LD_ubication.Geogra_Location_Id%type index by binary_integer;
  type tytbSucacate is table of LD_ubication.Sucacate%type index by binary_integer;
  type tytbSucacodi is table of LD_ubication.Sucacodi%type index by binary_integer;
  type tytbAuthorize_Quantity is table of LD_ubication.Authorize_Quantity%type index by binary_integer;
  type tytbAuthorize_Value is table of LD_ubication.Authorize_Value%type index by binary_integer;
  type tytbTotal_Deliver is table of LD_ubication.Total_Deliver%type index by binary_integer;
  type tytbTotal_Available is table of LD_ubication.Total_Available%type index by binary_integer;
  type tytbrowid is table of rowid index by binary_integer;

  type tyrcLD_ubication is record
  (

    Ubication_Id   tytbUbication_Id,
    Subsidy_Id   tytbSubsidy_Id,
    Geogra_Location_Id   tytbGeogra_Location_Id,
    Sucacate   tytbSucacate,
    Sucacodi   tytbSucacodi,
    Authorize_Quantity   tytbAuthorize_Quantity,
    Authorize_Value   tytbAuthorize_Value,
    Total_Deliver   tytbTotal_Deliver,
    Total_Available   tytbTotal_Available,
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
    inuUBICATION_Id in LD_ubication.UBICATION_Id%type
  )
  RETURN boolean;

   PROCEDURE AccKey
   (
     inuUBICATION_Id in LD_ubication.UBICATION_Id%type
  );

  PROCEDURE AccKeyByRowId
  (
    iriRowID    in rowid
  );

  PROCEDURE ValDuplicate
  (
     inuUBICATION_Id in LD_ubication.UBICATION_Id%type
  );

  PROCEDURE getRecord
  (
    inuUBICATION_Id in LD_ubication.UBICATION_Id%type,
    orcRecord out nocopy styLD_ubication
  );

  FUNCTION frcGetRcData
  (
    inuUBICATION_Id in LD_ubication.UBICATION_Id%type
  )
  RETURN styLD_ubication;

  FUNCTION frcGetRcData
  RETURN styLD_ubication;

  FUNCTION frcGetRecord
  (
    inuUBICATION_Id in LD_ubication.UBICATION_Id%type
  )
  RETURN styLD_ubication;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_ubication
  );

  FUNCTION frfGetRecords
  (
    isbCriteria in varchar2 default null,
    iblLock in boolean default false
  )
  RETURN tyRefCursor;

  PROCEDURE insRecord
  (
    ircLD_ubication in styLD_ubication
  );

     PROCEDURE insRecord
  (
    ircLD_ubication in styLD_ubication,
    orirowid   out varchar2
  );

  PROCEDURE insRecords
  (
    iotbLD_ubication in out nocopy tytbLD_ubication
  );

  PROCEDURE delRecord
  (
    inuUBICATION_Id in LD_ubication.UBICATION_Id%type,
    inuLock in number default 1
  );

  PROCEDURE delByRowID
  (
    iriRowID    in rowid,
    inuLock in number default 1
  );

  PROCEDURE delRecords
  (
    iotbLD_ubication in out nocopy tytbLD_ubication,
    inuLock in number default 1
  );

  PROCEDURE updRecord
  (
    ircLD_ubication in styLD_ubication,
    inuLock    in number default 0
  );

  PROCEDURE updRecords
  (
    iotbLD_ubication in out nocopy tytbLD_ubication,
    inuLock in number default 1
  );

    PROCEDURE updSubsidy_Id
    (
        inuUBICATION_Id   in LD_ubication.UBICATION_Id%type,
        inuSubsidy_Id$  in LD_ubication.Subsidy_Id%type,
        inuLock    in number default 0
      );

    PROCEDURE updGeogra_Location_Id
    (
        inuUBICATION_Id   in LD_ubication.UBICATION_Id%type,
        inuGeogra_Location_Id$  in LD_ubication.Geogra_Location_Id%type,
        inuLock    in number default 0
      );

    PROCEDURE updSucacate
    (
        inuUBICATION_Id   in LD_ubication.UBICATION_Id%type,
        inuSucacate$  in LD_ubication.Sucacate%type,
        inuLock    in number default 0
      );

    PROCEDURE updSucacodi
    (
        inuUBICATION_Id   in LD_ubication.UBICATION_Id%type,
        inuSucacodi$  in LD_ubication.Sucacodi%type,
        inuLock    in number default 0
      );

    PROCEDURE updAuthorize_Quantity
    (
        inuUBICATION_Id   in LD_ubication.UBICATION_Id%type,
        inuAuthorize_Quantity$  in LD_ubication.Authorize_Quantity%type,
        inuLock    in number default 0
      );

    PROCEDURE updAuthorize_Value
    (
        inuUBICATION_Id   in LD_ubication.UBICATION_Id%type,
        inuAuthorize_Value$  in LD_ubication.Authorize_Value%type,
        inuLock    in number default 0
      );

    PROCEDURE updTotal_Deliver
    (
        inuUBICATION_Id   in LD_ubication.UBICATION_Id%type,
        inuTotal_Deliver$  in LD_ubication.Total_Deliver%type,
        inuLock    in number default 0
      );

    PROCEDURE updTotal_Available
    (
        inuUBICATION_Id   in LD_ubication.UBICATION_Id%type,
        inuTotal_Available$  in LD_ubication.Total_Available%type,
        inuLock    in number default 0
      );

      FUNCTION fnuGetUbication_Id
      (
          inuUBICATION_Id in LD_ubication.UBICATION_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_ubication.Ubication_Id%type;

      FUNCTION fnuGetSubsidy_Id
      (
          inuUBICATION_Id in LD_ubication.UBICATION_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_ubication.Subsidy_Id%type;

      FUNCTION fnuGetGeogra_Location_Id
      (
          inuUBICATION_Id in LD_ubication.UBICATION_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_ubication.Geogra_Location_Id%type;

      FUNCTION fnuGetSucacate
      (
          inuUBICATION_Id in LD_ubication.UBICATION_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_ubication.Sucacate%type;

      FUNCTION fnuGetSucacodi
      (
          inuUBICATION_Id in LD_ubication.UBICATION_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_ubication.Sucacodi%type;

      FUNCTION fnuGetAuthorize_Quantity
      (
          inuUBICATION_Id in LD_ubication.UBICATION_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_ubication.Authorize_Quantity%type;

      FUNCTION fnuGetAuthorize_Value
      (
          inuUBICATION_Id in LD_ubication.UBICATION_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_ubication.Authorize_Value%type;

      FUNCTION fnuGetTotal_Deliver
      (
          inuUBICATION_Id in LD_ubication.UBICATION_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_ubication.Total_Deliver%type;

      FUNCTION fnuGetTotal_Available
      (
          inuUBICATION_Id in LD_ubication.UBICATION_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_ubication.Total_Available%type;


  PROCEDURE LockByPk
  (
    inuUBICATION_Id in LD_ubication.UBICATION_Id%type,
    orcLD_ubication  out styLD_ubication
  );

  PROCEDURE LockByRowID
  (
    irirowid    in  varchar2,
    orcLD_ubication  out styLD_ubication
  );

  PROCEDURE SetUseCache
  (
    iblUseCache    in  boolean
  );

  PROCEDURE LockByPkForUpdate
  (
    inuUBICATION_Id in LD_ubication.UBICATION_Id%type,
    orcLD_ubication  out styLD_ubication
  );
END DALD_ubication;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_ubication
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO156577';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_UBICATION';
    cnuGeEntityId constant varchar2(30) := 8521; -- Id de Ge_entity

  /* Cursor para bloqueo de un registro por llave primaria */
  CURSOR cuLockRcByPk
  (
    inuUBICATION_Id in LD_ubication.UBICATION_Id%type
  )
  IS
    SELECT LD_ubication.*,LD_ubication.rowid
    FROM LD_ubication
    WHERE  UBICATION_Id = inuUBICATION_Id
    FOR UPDATE NOWAIT;

  /* Cursor para bloqueo de un registro por rowid */
  CURSOR cuLockRcbyRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_ubication.*,LD_ubication.rowid
    FROM LD_ubication
    WHERE
      rowId = irirowid
    FOR UPDATE NOWAIT;

    CURSOR cuLockRcByPkForUpdate
    (
        inuUBICATION_Id in LD_ubication.UBICATION_Id%TYPE
    )
    IS
    SELECT LD_ubication.*,LD_ubication.rowid
    FROM LD_ubication
    WHERE  UBICATION_Id = inuUBICATION_Id
    FOR UPDATE;

  /*Tipos*/
  type tyrfLD_ubication is ref cursor;

  /*Variables Globales*/
  rcRecOfTab tyrcLD_ubication;

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

  FUNCTION fsbPrimaryKey( rcI in styLD_ubication default rcData )
  return varchar2
  IS
    sbPk varchar2(500);
  BEGIN
    sbPk:='[';
    sbPk:=sbPk||ut_convert.fsbToChar(rcI.UBICATION_Id);
    sbPk:=sbPk||']';
    return sbPk;
  END;

  PROCEDURE LockByPk
  (
    inuUBICATION_Id in LD_ubication.UBICATION_Id%type,
    orcLD_ubication  out styLD_ubication
  )
  IS
    rcError styLD_ubication;
  BEGIN
    rcError.UBICATION_Id := inuUBICATION_Id;

    Open cuLockRcByPk
    (
      inuUBICATION_Id
    );

    fetch cuLockRcByPk into orcLD_ubication;
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

  PROCEDURE LockByPkForUpdate
  (
    inuUBICATION_Id in LD_ubication.UBICATION_Id%type,
    orcLD_ubication  out styLD_ubication
  )
  IS
    rcError styLD_ubication;
  BEGIN
    rcError.UBICATION_Id := inuUBICATION_Id;

    Open cuLockRcByPkForUpdate
    (
      inuUBICATION_Id
    );

    fetch cuLockRcByPkForUpdate into orcLD_ubication;
    if cuLockRcByPkForUpdate%notfound  then
      close cuLockRcByPkForUpdate;
      raise no_data_found;
    end if;
    close cuLockRcByPkForUpdate ;
  EXCEPTION
    when no_data_found then
      if cuLockRcByPkForUpdate%isopen then
        close cuLockRcByPkForUpdate;
      end if;
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
    when ex.RESOURCE_BUSY THEN
      if cuLockRcByPkForUpdate%isopen then
        close cuLockRcByPkForUpdate;
      end if;
      errors.setError(cnuAPPTABLEBUSSY,fsbPrimaryKey(rcError)||'|'|| fsbGetMessageDescription );
      raise ex.controlled_error;
    when others then
      if cuLockRcByPkForUpdate%isopen then
        close cuLockRcByPkForUpdate;
      end if;
      raise;
  END;

  PROCEDURE LockByRowID
  (
    irirowid    in  varchar2,
    orcLD_ubication  out styLD_ubication
  )
  IS
  BEGIN
    Open cuLockRcbyRowId
    (
      irirowid
    );

    fetch cuLockRcbyRowId into orcLD_ubication;
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
    itbLD_ubication  in out nocopy tytbLD_ubication
  )
  IS
  BEGIN
      rcRecOfTab.Ubication_Id.delete;
      rcRecOfTab.Subsidy_Id.delete;
      rcRecOfTab.Geogra_Location_Id.delete;
      rcRecOfTab.Sucacate.delete;
      rcRecOfTab.Sucacodi.delete;
      rcRecOfTab.Authorize_Quantity.delete;
      rcRecOfTab.Authorize_Value.delete;
      rcRecOfTab.Total_Deliver.delete;
      rcRecOfTab.Total_Available.delete;
      rcRecOfTab.row_id.delete;
  END;
  PROCEDURE FillRecordOfTables
  (
    itbLD_ubication  in out nocopy tytbLD_ubication,
    oblUseRowId out boolean
  )
  IS
  BEGIN
    DelRecordOfTables(itbLD_ubication);
    for n in itbLD_ubication.first .. itbLD_ubication.last loop
      rcRecOfTab.Ubication_Id(n) := itbLD_ubication(n).Ubication_Id;
      rcRecOfTab.Subsidy_Id(n) := itbLD_ubication(n).Subsidy_Id;
      rcRecOfTab.Geogra_Location_Id(n) := itbLD_ubication(n).Geogra_Location_Id;
      rcRecOfTab.Sucacate(n) := itbLD_ubication(n).Sucacate;
      rcRecOfTab.Sucacodi(n) := itbLD_ubication(n).Sucacodi;
      rcRecOfTab.Authorize_Quantity(n) := itbLD_ubication(n).Authorize_Quantity;
      rcRecOfTab.Authorize_Value(n) := itbLD_ubication(n).Authorize_Value;
      rcRecOfTab.Total_Deliver(n) := itbLD_ubication(n).Total_Deliver;
      rcRecOfTab.Total_Available(n) := itbLD_ubication(n).Total_Available;
      rcRecOfTab.row_id(n) := itbLD_ubication(n).rowid;
      -- Indica si el rowid es Nulo
      oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
    end loop;
  END;


  PROCEDURE Load
  (
    inuUBICATION_Id in LD_ubication.UBICATION_Id%type
  )
  IS
    rcRecordNull cuRecord%rowtype;
  BEGIN
    if cuRecord%isopen then
      close cuRecord;
    end if;
    open cuRecord
    (
      inuUBICATION_Id
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
    inuUBICATION_Id in LD_ubication.UBICATION_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    if (
      inuUBICATION_Id = rcData.UBICATION_Id
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
    inuUBICATION_Id in LD_ubication.UBICATION_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    Load
    (
      inuUBICATION_Id
    );
    return(TRUE);
  EXCEPTION
    when no_data_found then
      return(FALSE);
  END;

  PROCEDURE AccKey
  (
    inuUBICATION_Id in LD_ubication.UBICATION_Id%type
  )
  IS
    rcError styLD_ubication;
  BEGIN    rcError.UBICATION_Id:=inuUBICATION_Id;

    Load
    (
      inuUBICATION_Id
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
    inuUBICATION_Id in LD_ubication.UBICATION_Id%type
  )
  IS
  BEGIN
    Load
    (
      inuUBICATION_Id
    );
    Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
    raise ex.CONTROLLED_ERROR;

  EXCEPTION
    when no_data_found then
      null;
  END;

  PROCEDURE getRecord
  (
    inuUBICATION_Id in LD_ubication.UBICATION_Id%type,
    orcRecord out nocopy styLD_ubication
  )
  IS
    rcError styLD_ubication;
  BEGIN    rcError.UBICATION_Id:=inuUBICATION_Id;

    Load
    (
      inuUBICATION_Id
    );
    orcRecord := rcData;
  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRecord
  (
    inuUBICATION_Id in LD_ubication.UBICATION_Id%type
  )
  RETURN styLD_ubication
  IS
    rcError styLD_ubication;
  BEGIN
    rcError.UBICATION_Id:=inuUBICATION_Id;

    Load
    (
      inuUBICATION_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  (
    inuUBICATION_Id in LD_ubication.UBICATION_Id%type
  )
  RETURN styLD_ubication
  IS
    rcError styLD_ubication;
  BEGIN
    rcError.UBICATION_Id:=inuUBICATION_Id;
        -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
         inuUBICATION_Id
       )
    then
       return(rcData);
    end if;
    Load
    (
      inuUBICATION_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  RETURN styLD_ubication
  IS
  BEGIN
    return(rcData);
  END;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_ubication
  )
  IS
    rfLD_ubication tyrfLD_ubication;
    n number(4) := 1;
    sbFullQuery VARCHAR2 (32000) := 'SELECT
                LD_ubication.Ubication_Id,
                LD_ubication.Subsidy_Id,
                LD_ubication.Geogra_Location_Id,
                LD_ubication.Sucacate,
                LD_ubication.Sucacodi,
                LD_ubication.Authorize_Quantity,
                LD_ubication.Authorize_Value,
                LD_ubication.Total_Deliver,
                LD_ubication.Total_Available,
                LD_ubication.rowid
                FROM LD_ubication';
    nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
  BEGIN
    otbResult.delete;
    if isbQuery is not NULL and length(isbQuery) > 0 then
      sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
    end if;
    open rfLD_ubication for sbFullQuery;
    fetch rfLD_ubication bulk collect INTO otbResult;
    close rfLD_ubication;
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
                LD_ubication.Ubication_Id,
                LD_ubication.Subsidy_Id,
                LD_ubication.Geogra_Location_Id,
                LD_ubication.Sucacate,
                LD_ubication.Sucacodi,
                LD_ubication.Authorize_Quantity,
                LD_ubication.Authorize_Value,
                LD_ubication.Total_Deliver,
                LD_ubication.Total_Available,
                LD_ubication.rowid
                FROM LD_ubication';
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
    ircLD_ubication in styLD_ubication
  )
  IS
    rirowid varchar2(200);
  BEGIN
    insRecord(ircLD_ubication,rirowid);
  END;

  PROCEDURE insRecord
  (
    ircLD_ubication in styLD_ubication,
    orirowid   out varchar2
  )
  IS
  BEGIN
    if ircLD_ubication.UBICATION_Id is NULL then
      Errors.SetError(cnuINS_PK_NULL,
                      fsbGetMessageDescription||'|UBICATION_Id');
      raise ex.controlled_error;
    end if;
    insert into LD_ubication
    (
      Ubication_Id,
      Subsidy_Id,
      Geogra_Location_Id,
      Sucacate,
      Sucacodi,
      Authorize_Quantity,
      Authorize_Value,
      Total_Deliver,
      Total_Available
    )
    values
    (
      ircLD_ubication.Ubication_Id,
      ircLD_ubication.Subsidy_Id,
      ircLD_ubication.Geogra_Location_Id,
      ircLD_ubication.Sucacate,
      ircLD_ubication.Sucacodi,
      ircLD_ubication.Authorize_Quantity,
      ircLD_ubication.Authorize_Value,
      ircLD_ubication.Total_Deliver,
      ircLD_ubication.Total_Available
    )
            returning
      rowid
    into
      orirowid;
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_ubication));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE insRecords
  (
    iotbLD_ubication in out nocopy tytbLD_ubication
  )
  IS
    blUseRowID boolean;
  BEGIN
    FillRecordOfTables(iotbLD_ubication, blUseRowID);
    forall n in iotbLD_ubication.first..iotbLD_ubication.last
      insert into LD_ubication
      (
      Ubication_Id,
      Subsidy_Id,
      Geogra_Location_Id,
      Sucacate,
      Sucacodi,
      Authorize_Quantity,
      Authorize_Value,
      Total_Deliver,
      Total_Available
    )
    values
    (
      rcRecOfTab.Ubication_Id(n),
      rcRecOfTab.Subsidy_Id(n),
      rcRecOfTab.Geogra_Location_Id(n),
      rcRecOfTab.Sucacate(n),
      rcRecOfTab.Sucacodi(n),
      rcRecOfTab.Authorize_Quantity(n),
      rcRecOfTab.Authorize_Value(n),
      rcRecOfTab.Total_Deliver(n),
      rcRecOfTab.Total_Available(n)
      );
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE delRecord
  (
    inuUBICATION_Id in LD_ubication.UBICATION_Id%type,
    inuLock in number default 1
  )
  IS
    rcError styLD_ubication;
  BEGIN
    rcError.UBICATION_Id:=inuUBICATION_Id;

    if inuLock=1 then
      LockByPk
      (
        inuUBICATION_Id,
        rcData
      );
    end if;

    delete
    from LD_ubication
    where
           UBICATION_Id=inuUBICATION_Id;
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
    rcError  styLD_ubication;
  BEGIN
    if inuLock=1 then
      LockByRowId(iriRowID,rcData);
    end if;

    delete
    from LD_ubication
    where
      rowid = iriRowID
    returning
   UBICATION_Id
    into
      rcError.UBICATION_Id;

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
    iotbLD_ubication in out nocopy tytbLD_ubication,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_ubication;
  BEGIN
    FillRecordOfTables(iotbLD_ubication, blUseRowID);
       if ( blUseRowId ) then
      if inuLock = 1 then
        for n in iotbLD_ubication.first .. iotbLD_ubication.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_ubication.first .. iotbLD_ubication.last
        delete
        from LD_ubication
        where
          rowid = rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_ubication.first .. iotbLD_ubication.last loop
          LockByPk
          (
              rcRecOfTab.UBICATION_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_ubication.first .. iotbLD_ubication.last
        delete
        from LD_ubication
        where
               UBICATION_Id = rcRecOfTab.UBICATION_Id(n);
    end if;
  EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecord
  (
    ircLD_ubication in styLD_ubication,
    inuLock    in number default 0
  )
  IS
    nuUBICATION_Id LD_ubication.UBICATION_Id%type;

  BEGIN
    if ircLD_ubication.rowid is not null then
      if inuLock=1 then
        LockByRowId(ircLD_ubication.rowid,rcData);
      end if;
      update LD_ubication
      set

        Subsidy_Id = ircLD_ubication.Subsidy_Id,
        Geogra_Location_Id = ircLD_ubication.Geogra_Location_Id,
        Sucacate = ircLD_ubication.Sucacate,
        Sucacodi = ircLD_ubication.Sucacodi,
        Authorize_Quantity = ircLD_ubication.Authorize_Quantity,
        Authorize_Value = ircLD_ubication.Authorize_Value,
        Total_Deliver = ircLD_ubication.Total_Deliver,
        Total_Available = ircLD_ubication.Total_Available
      where
        rowid = ircLD_ubication.rowid
      returning
    UBICATION_Id
      into
        nuUBICATION_Id;

    else
      if inuLock=1 then
        LockByPk
        (
          ircLD_ubication.UBICATION_Id,
          rcData
        );
      end if;

      update LD_ubication
      set
        Subsidy_Id = ircLD_ubication.Subsidy_Id,
        Geogra_Location_Id = ircLD_ubication.Geogra_Location_Id,
        Sucacate = ircLD_ubication.Sucacate,
        Sucacodi = ircLD_ubication.Sucacodi,
        Authorize_Quantity = ircLD_ubication.Authorize_Quantity,
        Authorize_Value = ircLD_ubication.Authorize_Value,
        Total_Deliver = ircLD_ubication.Total_Deliver,
        Total_Available = ircLD_ubication.Total_Available
      where
             UBICATION_Id = ircLD_ubication.UBICATION_Id
      returning
    UBICATION_Id
      into
        nuUBICATION_Id;
    end if;

    if
      nuUBICATION_Id is NULL
    then
      raise no_data_found;
    end if;

  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_ubication));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecords
  (
    iotbLD_ubication in out nocopy tytbLD_ubication,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_ubication;
  BEGIN
    FillRecordOfTables(iotbLD_ubication,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_ubication.first .. iotbLD_ubication.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_ubication.first .. iotbLD_ubication.last
        update LD_ubication
        set

            Subsidy_Id = rcRecOfTab.Subsidy_Id(n),
            Geogra_Location_Id = rcRecOfTab.Geogra_Location_Id(n),
            Sucacate = rcRecOfTab.Sucacate(n),
            Sucacodi = rcRecOfTab.Sucacodi(n),
            Authorize_Quantity = rcRecOfTab.Authorize_Quantity(n),
            Authorize_Value = rcRecOfTab.Authorize_Value(n),
            Total_Deliver = rcRecOfTab.Total_Deliver(n),
            Total_Available = rcRecOfTab.Total_Available(n)
          where
          rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_ubication.first .. iotbLD_ubication.last loop
          LockByPk
          (
              rcRecOfTab.UBICATION_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_ubication.first .. iotbLD_ubication.last
        update LD_ubication
        set
          Subsidy_Id = rcRecOfTab.Subsidy_Id(n),
          Geogra_Location_Id = rcRecOfTab.Geogra_Location_Id(n),
          Sucacate = rcRecOfTab.Sucacate(n),
          Sucacodi = rcRecOfTab.Sucacodi(n),
          Authorize_Quantity = rcRecOfTab.Authorize_Quantity(n),
          Authorize_Value = rcRecOfTab.Authorize_Value(n),
          Total_Deliver = rcRecOfTab.Total_Deliver(n),
          Total_Available = rcRecOfTab.Total_Available(n)
          where
          UBICATION_Id = rcRecOfTab.UBICATION_Id(n)
;
    end if;
  END;

  PROCEDURE updSubsidy_Id
  (
    inuUBICATION_Id in LD_ubication.UBICATION_Id%type,
    inuSubsidy_Id$ in LD_ubication.Subsidy_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_ubication;
  BEGIN
    rcError.UBICATION_Id := inuUBICATION_Id;
    if inuLock=1 then
      LockByPk
      (
        inuUBICATION_Id,
        rcData
      );
    end if;

    update LD_ubication
    set
      Subsidy_Id = inuSubsidy_Id$
    where
      UBICATION_Id = inuUBICATION_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Subsidy_Id:= inuSubsidy_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updGeogra_Location_Id
  (
    inuUBICATION_Id in LD_ubication.UBICATION_Id%type,
    inuGeogra_Location_Id$ in LD_ubication.Geogra_Location_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_ubication;
  BEGIN
    rcError.UBICATION_Id := inuUBICATION_Id;
    if inuLock=1 then
      LockByPk
      (
        inuUBICATION_Id,
        rcData
      );
    end if;

    update LD_ubication
    set
      Geogra_Location_Id = inuGeogra_Location_Id$
    where
      UBICATION_Id = inuUBICATION_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Geogra_Location_Id:= inuGeogra_Location_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updSucacate
  (
    inuUBICATION_Id in LD_ubication.UBICATION_Id%type,
    inuSucacate$ in LD_ubication.Sucacate%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_ubication;
  BEGIN
    rcError.UBICATION_Id := inuUBICATION_Id;
    if inuLock=1 then
      LockByPk
      (
        inuUBICATION_Id,
        rcData
      );
    end if;

    update LD_ubication
    set
      Sucacate = inuSucacate$
    where
      UBICATION_Id = inuUBICATION_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Sucacate:= inuSucacate$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updSucacodi
  (
    inuUBICATION_Id in LD_ubication.UBICATION_Id%type,
    inuSucacodi$ in LD_ubication.Sucacodi%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_ubication;
  BEGIN
    rcError.UBICATION_Id := inuUBICATION_Id;
    if inuLock=1 then
      LockByPk
      (
        inuUBICATION_Id,
        rcData
      );
    end if;

    update LD_ubication
    set
      Sucacodi = inuSucacodi$
    where
      UBICATION_Id = inuUBICATION_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Sucacodi:= inuSucacodi$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updAuthorize_Quantity
  (
    inuUBICATION_Id in LD_ubication.UBICATION_Id%type,
    inuAuthorize_Quantity$ in LD_ubication.Authorize_Quantity%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_ubication;
  BEGIN
    rcError.UBICATION_Id := inuUBICATION_Id;
    if inuLock=1 then
      LockByPk
      (
        inuUBICATION_Id,
        rcData
      );
    end if;

    update LD_ubication
    set
      Authorize_Quantity = inuAuthorize_Quantity$
    where
      UBICATION_Id = inuUBICATION_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Authorize_Quantity:= inuAuthorize_Quantity$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updAuthorize_Value
  (
    inuUBICATION_Id in LD_ubication.UBICATION_Id%type,
    inuAuthorize_Value$ in LD_ubication.Authorize_Value%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_ubication;
  BEGIN
    rcError.UBICATION_Id := inuUBICATION_Id;
    if inuLock=1 then
      LockByPk
      (
        inuUBICATION_Id,
        rcData
      );
    end if;

    update LD_ubication
    set
      Authorize_Value = inuAuthorize_Value$
    where
      UBICATION_Id = inuUBICATION_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Authorize_Value:= inuAuthorize_Value$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updTotal_Deliver
  (
    inuUBICATION_Id in LD_ubication.UBICATION_Id%type,
    inuTotal_Deliver$ in LD_ubication.Total_Deliver%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_ubication;
  BEGIN
    rcError.UBICATION_Id := inuUBICATION_Id;
    if inuLock=1 then
      LockByPk
      (
        inuUBICATION_Id,
        rcData
      );
    end if;

    update LD_ubication
    set
      Total_Deliver = inuTotal_Deliver$
    where
      UBICATION_Id = inuUBICATION_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Total_Deliver:= inuTotal_Deliver$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updTotal_Available
  (
    inuUBICATION_Id in LD_ubication.UBICATION_Id%type,
    inuTotal_Available$ in LD_ubication.Total_Available%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_ubication;
  BEGIN
    rcError.UBICATION_Id := inuUBICATION_Id;
    if inuLock=1 then
      LockByPk
      (
        inuUBICATION_Id,
        rcData
      );
    end if;

    update LD_ubication
    set
      Total_Available = inuTotal_Available$
    where
      UBICATION_Id = inuUBICATION_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Total_Available:= inuTotal_Available$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;


  FUNCTION fnuGetUbication_Id
  (
    inuUBICATION_Id in LD_ubication.UBICATION_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_ubication.Ubication_Id%type
  IS
    rcError styLD_ubication;
  BEGIN

    rcError.UBICATION_Id := inuUBICATION_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuUBICATION_Id
       )
    then
       return(rcData.Ubication_Id);
    end if;
    Load
    (
      inuUBICATION_Id
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

  FUNCTION fnuGetSubsidy_Id
  (
    inuUBICATION_Id in LD_ubication.UBICATION_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_ubication.Subsidy_Id%type
  IS
    rcError styLD_ubication;
  BEGIN

    rcError.UBICATION_Id := inuUBICATION_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuUBICATION_Id
       )
    then
       return(rcData.Subsidy_Id);
    end if;
    Load
    (
      inuUBICATION_Id
    );
    return(rcData.Subsidy_Id);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetGeogra_Location_Id
  (
    inuUBICATION_Id in LD_ubication.UBICATION_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_ubication.Geogra_Location_Id%type
  IS
    rcError styLD_ubication;
  BEGIN

    rcError.UBICATION_Id := inuUBICATION_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuUBICATION_Id
       )
    then
       return(rcData.Geogra_Location_Id);
    end if;
    Load
    (
      inuUBICATION_Id
    );
    return(rcData.Geogra_Location_Id);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetSucacate
  (
    inuUBICATION_Id in LD_ubication.UBICATION_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_ubication.Sucacate%type
  IS
    rcError styLD_ubication;
  BEGIN

    rcError.UBICATION_Id := inuUBICATION_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuUBICATION_Id
       )
    then
       return(rcData.Sucacate);
    end if;
    Load
    (
      inuUBICATION_Id
    );
    return(rcData.Sucacate);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetSucacodi
  (
    inuUBICATION_Id in LD_ubication.UBICATION_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_ubication.Sucacodi%type
  IS
    rcError styLD_ubication;
  BEGIN

    rcError.UBICATION_Id := inuUBICATION_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuUBICATION_Id
       )
    then
       return(rcData.Sucacodi);
    end if;
    Load
    (
      inuUBICATION_Id
    );
    return(rcData.Sucacodi);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetAuthorize_Quantity
  (
    inuUBICATION_Id in LD_ubication.UBICATION_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_ubication.Authorize_Quantity%type
  IS
    rcError styLD_ubication;
  BEGIN

    rcError.UBICATION_Id := inuUBICATION_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuUBICATION_Id
       )
    then
       return(rcData.Authorize_Quantity);
    end if;
    Load
    (
      inuUBICATION_Id
    );
    return(rcData.Authorize_Quantity);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetAuthorize_Value
  (
    inuUBICATION_Id in LD_ubication.UBICATION_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_ubication.Authorize_Value%type
  IS
    rcError styLD_ubication;
  BEGIN

    rcError.UBICATION_Id := inuUBICATION_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuUBICATION_Id
       )
    then
       return(rcData.Authorize_Value);
    end if;
    Load
    (
      inuUBICATION_Id
    );
    return(rcData.Authorize_Value);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetTotal_Deliver
  (
    inuUBICATION_Id in LD_ubication.UBICATION_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_ubication.Total_Deliver%type
  IS
    rcError styLD_ubication;
  BEGIN

    rcError.UBICATION_Id := inuUBICATION_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuUBICATION_Id
       )
    then
       return(rcData.Total_Deliver);
    end if;
    Load
    (
      inuUBICATION_Id
    );
    return(rcData.Total_Deliver);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetTotal_Available
  (
    inuUBICATION_Id in LD_ubication.UBICATION_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_ubication.Total_Available%type
  IS
    rcError styLD_ubication;
  BEGIN

    rcError.UBICATION_Id := inuUBICATION_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuUBICATION_Id
       )
    then
       return(rcData.Total_Available);
    end if;
    Load
    (
      inuUBICATION_Id
    );
    return(rcData.Total_Available);
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
end DALD_ubication;
/
PROMPT Otorgando permisos de ejecucion a DALD_UBICATION
BEGIN
    pkg_utilidades.praplicarpermisos('DALD_UBICATION', 'ADM_PERSON');
END;
/