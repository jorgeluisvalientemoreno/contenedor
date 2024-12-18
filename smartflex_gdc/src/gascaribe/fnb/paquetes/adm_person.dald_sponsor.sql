CREATE OR REPLACE PACKAGE ADM_PERSON.DALD_sponsor
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
    06/06/2024              PAcosta         OSF-2778: Cambio de esquema ADM_PERSON                              
    ****************************************************************/    
    
  /* Cursor general para acceso por Llave Primaria */
  CURSOR cuRecord
  (
    inuSPONSOR_Id in LD_sponsor.SPONSOR_Id%type
  )
  IS
    SELECT LD_sponsor.*,LD_sponsor.rowid
    FROM LD_sponsor
    WHERE
      SPONSOR_Id = inuSPONSOR_Id;


  /* Cursor general para acceso por RowId */
  CURSOR cuRecordByRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_sponsor.*,LD_sponsor.rowid
    FROM LD_sponsor
    WHERE
      rowId = irirowid;


  /* Subtipos */
  subtype styLD_sponsor  is  cuRecord%rowtype;
  type tyRefCursor is  REF CURSOR;

  /*Tipos*/
  type tytbLD_sponsor is table of styLD_sponsor index by binary_integer;
  type tyrfRecords is ref cursor return styLD_sponsor;

  /* Tipos referenciando al registro */
  type tytbSponsor_Id is table of LD_sponsor.Sponsor_Id%type index by binary_integer;
  type tytbDescription is table of LD_sponsor.Description%type index by binary_integer;
  type tytbrowid is table of rowid index by binary_integer;

  type tyrcLD_sponsor is record
  (

    Sponsor_Id   tytbSponsor_Id,
    Description   tytbDescription,
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
    inuSPONSOR_Id in LD_sponsor.SPONSOR_Id%type
  )
  RETURN boolean;

   PROCEDURE AccKey
   (
     inuSPONSOR_Id in LD_sponsor.SPONSOR_Id%type
  );

  PROCEDURE AccKeyByRowId
  (
    iriRowID    in rowid
  );

  PROCEDURE ValDuplicate
  (
     inuSPONSOR_Id in LD_sponsor.SPONSOR_Id%type
  );

  PROCEDURE getRecord
  (
    inuSPONSOR_Id in LD_sponsor.SPONSOR_Id%type,
    orcRecord out nocopy styLD_sponsor
  );

  FUNCTION frcGetRcData
  (
    inuSPONSOR_Id in LD_sponsor.SPONSOR_Id%type
  )
  RETURN styLD_sponsor;

  FUNCTION frcGetRcData
  RETURN styLD_sponsor;

  FUNCTION frcGetRecord
  (
    inuSPONSOR_Id in LD_sponsor.SPONSOR_Id%type
  )
  RETURN styLD_sponsor;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_sponsor
  );

  FUNCTION frfGetRecords
  (
    isbCriteria in varchar2 default null,
    iblLock in boolean default false
  )
  RETURN tyRefCursor;

  PROCEDURE insRecord
  (
    ircLD_sponsor in styLD_sponsor
  );

     PROCEDURE insRecord
  (
    ircLD_sponsor in styLD_sponsor,
    orirowid   out varchar2
  );

  PROCEDURE insRecords
  (
    iotbLD_sponsor in out nocopy tytbLD_sponsor
  );

  PROCEDURE delRecord
  (
    inuSPONSOR_Id in LD_sponsor.SPONSOR_Id%type,
    inuLock in number default 1
  );

  PROCEDURE delByRowID
  (
    iriRowID    in rowid,
    inuLock in number default 1
  );

  PROCEDURE delRecords
  (
    iotbLD_sponsor in out nocopy tytbLD_sponsor,
    inuLock in number default 1
  );

  PROCEDURE updRecord
  (
    ircLD_sponsor in styLD_sponsor,
    inuLock    in number default 0
  );

  PROCEDURE updRecords
  (
    iotbLD_sponsor in out nocopy tytbLD_sponsor,
    inuLock in number default 1
  );

    PROCEDURE updDescription
    (
        inuSPONSOR_Id   in LD_sponsor.SPONSOR_Id%type,
        isbDescription$  in LD_sponsor.Description%type,
        inuLock    in number default 0
      );

      FUNCTION fnuGetSponsor_Id
      (
          inuSPONSOR_Id in LD_sponsor.SPONSOR_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_sponsor.Sponsor_Id%type;

      FUNCTION fsbGetDescription
      (
          inuSPONSOR_Id in LD_sponsor.SPONSOR_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_sponsor.Description%type;


  PROCEDURE LockByPk
  (
    inuSPONSOR_Id in LD_sponsor.SPONSOR_Id%type,
    orcLD_sponsor  out styLD_sponsor
  );

  PROCEDURE LockByRowID
  (
    irirowid    in  varchar2,
    orcLD_sponsor  out styLD_sponsor
  );

  PROCEDURE SetUseCache
  (
    iblUseCache    in  boolean
  );
END DALD_sponsor;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALD_sponsor
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO156577';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_SPONSOR';
    cnuGeEntityId constant varchar2(30) := 8382; -- Id de Ge_entity

  /* Cursor para bloqueo de un registro por llave primaria */
  CURSOR cuLockRcByPk
  (
    inuSPONSOR_Id in LD_sponsor.SPONSOR_Id%type
  )
  IS
    SELECT LD_sponsor.*,LD_sponsor.rowid
    FROM LD_sponsor
    WHERE  SPONSOR_Id = inuSPONSOR_Id
    FOR UPDATE NOWAIT;

  /* Cursor para bloqueo de un registro por rowid */
  CURSOR cuLockRcbyRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_sponsor.*,LD_sponsor.rowid
    FROM LD_sponsor
    WHERE
      rowId = irirowid
    FOR UPDATE NOWAIT;
  /*Tipos*/
  type tyrfLD_sponsor is ref cursor;

  /*Variables Globales*/
  rcRecOfTab tyrcLD_sponsor;

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

  FUNCTION fsbPrimaryKey( rcI in styLD_sponsor default rcData )
  return varchar2
  IS
    sbPk varchar2(500);
  BEGIN
    sbPk:='[';
    sbPk:=sbPk||ut_convert.fsbToChar(rcI.SPONSOR_Id);
    sbPk:=sbPk||']';
    return sbPk;
  END;

  PROCEDURE LockByPk
  (
    inuSPONSOR_Id in LD_sponsor.SPONSOR_Id%type,
    orcLD_sponsor  out styLD_sponsor
  )
  IS
    rcError styLD_sponsor;
  BEGIN
    rcError.SPONSOR_Id := inuSPONSOR_Id;

    Open cuLockRcByPk
    (
      inuSPONSOR_Id
    );

    fetch cuLockRcByPk into orcLD_sponsor;
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
    orcLD_sponsor  out styLD_sponsor
  )
  IS
  BEGIN
    Open cuLockRcbyRowId
    (
      irirowid
    );

    fetch cuLockRcbyRowId into orcLD_sponsor;
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
    itbLD_sponsor  in out nocopy tytbLD_sponsor
  )
  IS
  BEGIN
      rcRecOfTab.Sponsor_Id.delete;
      rcRecOfTab.Description.delete;
      rcRecOfTab.row_id.delete;
  END;
  PROCEDURE FillRecordOfTables
  (
    itbLD_sponsor  in out nocopy tytbLD_sponsor,
    oblUseRowId out boolean
  )
  IS
  BEGIN
    DelRecordOfTables(itbLD_sponsor);
    for n in itbLD_sponsor.first .. itbLD_sponsor.last loop
      rcRecOfTab.Sponsor_Id(n) := itbLD_sponsor(n).Sponsor_Id;
      rcRecOfTab.Description(n) := itbLD_sponsor(n).Description;
      rcRecOfTab.row_id(n) := itbLD_sponsor(n).rowid;
      -- Indica si el rowid es Nulo
      oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
    end loop;
  END;


  PROCEDURE Load
  (
    inuSPONSOR_Id in LD_sponsor.SPONSOR_Id%type
  )
  IS
    rcRecordNull cuRecord%rowtype;
  BEGIN
    if cuRecord%isopen then
      close cuRecord;
    end if;
    open cuRecord
    (
      inuSPONSOR_Id
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
    inuSPONSOR_Id in LD_sponsor.SPONSOR_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    if (
      inuSPONSOR_Id = rcData.SPONSOR_Id
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
    inuSPONSOR_Id in LD_sponsor.SPONSOR_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    Load
    (
      inuSPONSOR_Id
    );
    return(TRUE);
  EXCEPTION
    when no_data_found then
      return(FALSE);
  END;

  PROCEDURE AccKey
  (
    inuSPONSOR_Id in LD_sponsor.SPONSOR_Id%type
  )
  IS
    rcError styLD_sponsor;
  BEGIN    rcError.SPONSOR_Id:=inuSPONSOR_Id;

    Load
    (
      inuSPONSOR_Id
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
    inuSPONSOR_Id in LD_sponsor.SPONSOR_Id%type
  )
  IS
  BEGIN
    Load
    (
      inuSPONSOR_Id
    );
    Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
    raise ex.CONTROLLED_ERROR;

  EXCEPTION
    when no_data_found then
      null;
  END;

  PROCEDURE getRecord
  (
    inuSPONSOR_Id in LD_sponsor.SPONSOR_Id%type,
    orcRecord out nocopy styLD_sponsor
  )
  IS
    rcError styLD_sponsor;
  BEGIN    rcError.SPONSOR_Id:=inuSPONSOR_Id;

    Load
    (
      inuSPONSOR_Id
    );
    orcRecord := rcData;
  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRecord
  (
    inuSPONSOR_Id in LD_sponsor.SPONSOR_Id%type
  )
  RETURN styLD_sponsor
  IS
    rcError styLD_sponsor;
  BEGIN
    rcError.SPONSOR_Id:=inuSPONSOR_Id;

    Load
    (
      inuSPONSOR_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  (
    inuSPONSOR_Id in LD_sponsor.SPONSOR_Id%type
  )
  RETURN styLD_sponsor
  IS
    rcError styLD_sponsor;
  BEGIN
    rcError.SPONSOR_Id:=inuSPONSOR_Id;
        -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
         inuSPONSOR_Id
       )
    then
       return(rcData);
    end if;
    Load
    (
      inuSPONSOR_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  RETURN styLD_sponsor
  IS
  BEGIN
    return(rcData);
  END;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_sponsor
  )
  IS
    rfLD_sponsor tyrfLD_sponsor;
    n number(4) := 1;
    sbFullQuery VARCHAR2 (32000) := 'SELECT
                LD_sponsor.Sponsor_Id,
                LD_sponsor.Description,
                LD_sponsor.rowid
                FROM LD_sponsor';
    nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
  BEGIN
    otbResult.delete;
    if isbQuery is not NULL and length(isbQuery) > 0 then
      sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
    end if;
    open rfLD_sponsor for sbFullQuery;
    fetch rfLD_sponsor bulk collect INTO otbResult;
    close rfLD_sponsor;
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
                LD_sponsor.Sponsor_Id,
                LD_sponsor.Description,
                LD_sponsor.rowid
                FROM LD_sponsor';
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
    ircLD_sponsor in styLD_sponsor
  )
  IS
    rirowid varchar2(200);
  BEGIN
    insRecord(ircLD_sponsor,rirowid);
  END;

  PROCEDURE insRecord
  (
    ircLD_sponsor in styLD_sponsor,
    orirowid   out varchar2
  )
  IS
  BEGIN
    if ircLD_sponsor.SPONSOR_Id is NULL then
      Errors.SetError(cnuINS_PK_NULL,
                      fsbGetMessageDescription||'|SPONSOR_Id');
      raise ex.controlled_error;
    end if;
    insert into LD_sponsor
    (
      Sponsor_Id,
      Description
    )
    values
    (
      ircLD_sponsor.Sponsor_Id,
      ircLD_sponsor.Description
    )
            returning
      rowid
    into
      orirowid;
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_sponsor));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE insRecords
  (
    iotbLD_sponsor in out nocopy tytbLD_sponsor
  )
  IS
    blUseRowID boolean;
  BEGIN
    FillRecordOfTables(iotbLD_sponsor, blUseRowID);
    forall n in iotbLD_sponsor.first..iotbLD_sponsor.last
      insert into LD_sponsor
      (
      Sponsor_Id,
      Description
    )
    values
    (
      rcRecOfTab.Sponsor_Id(n),
      rcRecOfTab.Description(n)
      );
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE delRecord
  (
    inuSPONSOR_Id in LD_sponsor.SPONSOR_Id%type,
    inuLock in number default 1
  )
  IS
    rcError styLD_sponsor;
  BEGIN
    rcError.SPONSOR_Id:=inuSPONSOR_Id;

    if inuLock=1 then
      LockByPk
      (
        inuSPONSOR_Id,
        rcData
      );
    end if;

    delete
    from LD_sponsor
    where
           SPONSOR_Id=inuSPONSOR_Id;
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
    rcError  styLD_sponsor;
  BEGIN
    if inuLock=1 then
      LockByRowId(iriRowID,rcData);
    end if;

    delete
    from LD_sponsor
    where
      rowid = iriRowID
    returning
   SPONSOR_Id
    into
      rcError.SPONSOR_Id;

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
    iotbLD_sponsor in out nocopy tytbLD_sponsor,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_sponsor;
  BEGIN
    FillRecordOfTables(iotbLD_sponsor, blUseRowID);
       if ( blUseRowId ) then
      if inuLock = 1 then
        for n in iotbLD_sponsor.first .. iotbLD_sponsor.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_sponsor.first .. iotbLD_sponsor.last
        delete
        from LD_sponsor
        where
          rowid = rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_sponsor.first .. iotbLD_sponsor.last loop
          LockByPk
          (
              rcRecOfTab.SPONSOR_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_sponsor.first .. iotbLD_sponsor.last
        delete
        from LD_sponsor
        where
               SPONSOR_Id = rcRecOfTab.SPONSOR_Id(n);
    end if;
  EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecord
  (
    ircLD_sponsor in styLD_sponsor,
    inuLock    in number default 0
  )
  IS
    nuSPONSOR_Id LD_sponsor.SPONSOR_Id%type;

  BEGIN
    if ircLD_sponsor.rowid is not null then
      if inuLock=1 then
        LockByRowId(ircLD_sponsor.rowid,rcData);
      end if;
      update LD_sponsor
      set

        Description = ircLD_sponsor.Description
      where
        rowid = ircLD_sponsor.rowid
      returning
    SPONSOR_Id
      into
        nuSPONSOR_Id;

    else
      if inuLock=1 then
        LockByPk
        (
          ircLD_sponsor.SPONSOR_Id,
          rcData
        );
      end if;

      update LD_sponsor
      set
        Description = ircLD_sponsor.Description
      where
             SPONSOR_Id = ircLD_sponsor.SPONSOR_Id
      returning
    SPONSOR_Id
      into
        nuSPONSOR_Id;
    end if;

    if
      nuSPONSOR_Id is NULL
    then
      raise no_data_found;
    end if;

  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_sponsor));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecords
  (
    iotbLD_sponsor in out nocopy tytbLD_sponsor,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_sponsor;
  BEGIN
    FillRecordOfTables(iotbLD_sponsor,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_sponsor.first .. iotbLD_sponsor.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_sponsor.first .. iotbLD_sponsor.last
        update LD_sponsor
        set

            Description = rcRecOfTab.Description(n)
          where
          rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_sponsor.first .. iotbLD_sponsor.last loop
          LockByPk
          (
              rcRecOfTab.SPONSOR_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_sponsor.first .. iotbLD_sponsor.last
        update LD_sponsor
        set
          Description = rcRecOfTab.Description(n)
          where
          SPONSOR_Id = rcRecOfTab.SPONSOR_Id(n)
;
    end if;
  END;

  PROCEDURE updDescription
  (
    inuSPONSOR_Id in LD_sponsor.SPONSOR_Id%type,
    isbDescription$ in LD_sponsor.Description%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_sponsor;
  BEGIN
    rcError.SPONSOR_Id := inuSPONSOR_Id;
    if inuLock=1 then
      LockByPk
      (
        inuSPONSOR_Id,
        rcData
      );
    end if;

    update LD_sponsor
    set
      Description = isbDescription$
    where
      SPONSOR_Id = inuSPONSOR_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Description:= isbDescription$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;


  FUNCTION fnuGetSponsor_Id
  (
    inuSPONSOR_Id in LD_sponsor.SPONSOR_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_sponsor.Sponsor_Id%type
  IS
    rcError styLD_sponsor;
  BEGIN

    rcError.SPONSOR_Id := inuSPONSOR_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuSPONSOR_Id
       )
    then
       return(rcData.Sponsor_Id);
    end if;
    Load
    (
      inuSPONSOR_Id
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

  FUNCTION fsbGetDescription
  (
    inuSPONSOR_Id in LD_sponsor.SPONSOR_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_sponsor.Description%type
  IS
    rcError styLD_sponsor;
  BEGIN

    rcError.SPONSOR_Id:=inuSPONSOR_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuSPONSOR_Id
       )
    then
       return(rcData.Description);
    end if;
    Load
    (
      inuSPONSOR_Id
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
  PROCEDURE SetUseCache
  (
    iblUseCache    in  boolean
  ) IS
  Begin
      blDAO_USE_CACHE := iblUseCache;
  END;

begin
    GetDAO_USE_CACHE;
end DALD_sponsor;
/
PROMPT Otorgando permisos de ejecucion a DALD_SPONSOR
BEGIN
    pkg_utilidades.praplicarpermisos('DALD_SPONSOR', 'ADM_PERSON');
END;
/