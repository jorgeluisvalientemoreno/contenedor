CREATE OR REPLACE PACKAGE adm_person.DALD_prod_line_ge_cont
is
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     : DALDC_ACTBLOQ
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
    inuProd_Line_Ge_Conty_Id in LD_prod_line_ge_cont.Prod_Line_Ge_Conty_Id%type
  )
  IS
    SELECT LD_prod_line_ge_cont.*,LD_prod_line_ge_cont.rowid
    FROM LD_prod_line_ge_cont
    WHERE
      Prod_Line_Ge_Conty_Id = inuProd_Line_Ge_Conty_Id;


  /* Cursor general para acceso por RowId */
  CURSOR cuRecordByRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_prod_line_ge_cont.*,LD_prod_line_ge_cont.rowid
    FROM LD_prod_line_ge_cont
    WHERE
      rowId = irirowid;


  /* Subtipos */
  subtype styLD_prod_line_ge_cont  is  cuRecord%rowtype;
  type tyRefCursor is  REF CURSOR;

  /*Tipos*/
  type tytbLD_prod_line_ge_cont is table of styLD_prod_line_ge_cont index by binary_integer;
  type tyrfRecords is ref cursor return styLD_prod_line_ge_cont;

  /* Tipos referenciando al registro */
  type tytbProd_Line_Ge_Conty_Id is table of LD_prod_line_ge_cont.Prod_Line_Ge_Conty_Id%type index by binary_integer;
  type tytbProduct_Line_Id is table of LD_prod_line_ge_cont.Product_Line_Id%type index by binary_integer;
  type tytbContratistas_Id is table of LD_prod_line_ge_cont.Contratistas_Id%type index by binary_integer;
  type tytbrowid is table of rowid index by binary_integer;

  type tyrcLD_prod_line_ge_cont is record
  (

    Prod_Line_Ge_Conty_Id   tytbProd_Line_Ge_Conty_Id,
    Product_Line_Id   tytbProduct_Line_Id,
    Contratistas_Id   tytbContratistas_Id,
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
    inuProd_Line_Ge_Conty_Id in LD_prod_line_ge_cont.Prod_Line_Ge_Conty_Id%type
  )
  RETURN boolean;

   PROCEDURE AccKey
   (
     inuProd_Line_Ge_Conty_Id in LD_prod_line_ge_cont.Prod_Line_Ge_Conty_Id%type
  );

  PROCEDURE AccKeyByRowId
  (
    iriRowID    in rowid
  );

  PROCEDURE ValDuplicate
  (
     inuProd_Line_Ge_Conty_Id in LD_prod_line_ge_cont.Prod_Line_Ge_Conty_Id%type
  );

  PROCEDURE getRecord
  (
    inuProd_Line_Ge_Conty_Id in LD_prod_line_ge_cont.Prod_Line_Ge_Conty_Id%type,
    orcRecord out nocopy styLD_prod_line_ge_cont
  );

  FUNCTION frcGetRcData
  (
    inuProd_Line_Ge_Conty_Id in LD_prod_line_ge_cont.Prod_Line_Ge_Conty_Id%type
  )
  RETURN styLD_prod_line_ge_cont;

  FUNCTION frcGetRcData
  RETURN styLD_prod_line_ge_cont;

  FUNCTION frcGetRecord
  (
    inuProd_Line_Ge_Conty_Id in LD_prod_line_ge_cont.Prod_Line_Ge_Conty_Id%type
  )
  RETURN styLD_prod_line_ge_cont;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_prod_line_ge_cont
  );

  FUNCTION frfGetRecords
  (
    isbCriteria in varchar2 default null,
    iblLock in boolean default false
  )
  RETURN tyRefCursor;

  PROCEDURE insRecord
  (
    ircLD_prod_line_ge_cont in styLD_prod_line_ge_cont
  );

     PROCEDURE insRecord
  (
    ircLD_prod_line_ge_cont in styLD_prod_line_ge_cont,
    orirowid   out varchar2
  );

  PROCEDURE insRecords
  (
    iotbLD_prod_line_ge_cont in out nocopy tytbLD_prod_line_ge_cont
  );

  PROCEDURE delRecord
  (
    inuProd_Line_Ge_Conty_Id in LD_prod_line_ge_cont.Prod_Line_Ge_Conty_Id%type,
    inuLock in number default 1
  );

  PROCEDURE delByRowID
  (
    iriRowID    in rowid,
    inuLock in number default 1
  );

  PROCEDURE delRecords
  (
    iotbLD_prod_line_ge_cont in out nocopy tytbLD_prod_line_ge_cont,
    inuLock in number default 1
  );

  PROCEDURE updRecord
  (
    ircLD_prod_line_ge_cont in styLD_prod_line_ge_cont,
    inuLock    in number default 0
  );

  PROCEDURE updRecords
  (
    iotbLD_prod_line_ge_cont in out nocopy tytbLD_prod_line_ge_cont,
    inuLock in number default 1
  );

    PROCEDURE updProd_Line_Ge_Conty_Id
    (
        inuProd_Line_Ge_Conty_Id   in LD_prod_line_ge_cont.Prod_Line_Ge_Conty_Id%type,
        inuProd_Line_Ge_Conty_Id$  in LD_prod_line_ge_cont.Prod_Line_Ge_Conty_Id%type,
        inuLock    in number default 0
      );

    PROCEDURE updProduct_Line_Id
    (
        inuProd_Line_Ge_Conty_Id   in LD_prod_line_ge_cont.Prod_Line_Ge_Conty_Id%type,
        inuProduct_Line_Id$  in LD_prod_line_ge_cont.Product_Line_Id%type,
        inuLock    in number default 0
      );

    PROCEDURE updContratistas_Id
    (
        inuProd_Line_Ge_Conty_Id   in LD_prod_line_ge_cont.Prod_Line_Ge_Conty_Id%type,
        inuContratistas_Id$  in LD_prod_line_ge_cont.Contratistas_Id%type,
        inuLock    in number default 0
      );

      FUNCTION fnuGetProd_Line_Ge_Conty_Id
      (
          inuProd_Line_Ge_Conty_Id in LD_prod_line_ge_cont.Prod_Line_Ge_Conty_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_prod_line_ge_cont.Prod_Line_Ge_Conty_Id%type;

      FUNCTION fnuGetProduct_Line_Id
      (
          inuProd_Line_Ge_Conty_Id in LD_prod_line_ge_cont.Prod_Line_Ge_Conty_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_prod_line_ge_cont.Product_Line_Id%type;

      FUNCTION fnuGetContratistas_Id
      (
          inuProd_Line_Ge_Conty_Id in LD_prod_line_ge_cont.Prod_Line_Ge_Conty_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_prod_line_ge_cont.Contratistas_Id%type;


  PROCEDURE LockByPk
  (
    inuProd_Line_Ge_Conty_Id in LD_prod_line_ge_cont.Prod_Line_Ge_Conty_Id%type,
    orcLD_prod_line_ge_cont  out styLD_prod_line_ge_cont
  );

  PROCEDURE LockByRowID
  (
    irirowid    in  varchar2,
    orcLD_prod_line_ge_cont  out styLD_prod_line_ge_cont
  );

  PROCEDURE SetUseCache
  (
    iblUseCache    in  boolean
  );
END DALD_prod_line_ge_cont;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_prod_line_ge_cont
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO147879';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_PROD_LINE_GE_CONT';
    cnuGeEntityId constant varchar2(30) := 7365; -- Id de Ge_entity

  /* Cursor para bloqueo de un registro por llave primaria */
  CURSOR cuLockRcByPk
  (
    inuProd_Line_Ge_Conty_Id in LD_prod_line_ge_cont.Prod_Line_Ge_Conty_Id%type
  )
  IS
    SELECT LD_prod_line_ge_cont.*,LD_prod_line_ge_cont.rowid
    FROM LD_prod_line_ge_cont
    WHERE  Prod_Line_Ge_Conty_Id = inuProd_Line_Ge_Conty_Id
    FOR UPDATE NOWAIT;

  /* Cursor para bloqueo de un registro por rowid */
  CURSOR cuLockRcbyRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_prod_line_ge_cont.*,LD_prod_line_ge_cont.rowid
    FROM LD_prod_line_ge_cont
    WHERE
      rowId = irirowid
    FOR UPDATE NOWAIT;
  /*Tipos*/
  type tyrfLD_prod_line_ge_cont is ref cursor;

  /*Variables Globales*/
  rcRecOfTab tyrcLD_prod_line_ge_cont;

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

  FUNCTION fsbPrimaryKey( rcI in styLD_prod_line_ge_cont default rcData )
  return varchar2
  IS
    sbPk varchar2(500);
  BEGIN
    sbPk:='[';
    sbPk:=sbPk||ut_convert.fsbToChar(rcI.Prod_Line_Ge_Conty_Id);
    sbPk:=sbPk||']';
    return sbPk;
  END;

  PROCEDURE LockByPk
  (
    inuProd_Line_Ge_Conty_Id in LD_prod_line_ge_cont.Prod_Line_Ge_Conty_Id%type,
    orcLD_prod_line_ge_cont  out styLD_prod_line_ge_cont
  )
  IS
    rcError styLD_prod_line_ge_cont;
  BEGIN
    rcError.Prod_Line_Ge_Conty_Id := inuProd_Line_Ge_Conty_Id;

    Open cuLockRcByPk
    (
      inuProd_Line_Ge_Conty_Id
    );

    fetch cuLockRcByPk into orcLD_prod_line_ge_cont;
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
    orcLD_prod_line_ge_cont  out styLD_prod_line_ge_cont
  )
  IS
  BEGIN
    Open cuLockRcbyRowId
    (
      irirowid
    );

    fetch cuLockRcbyRowId into orcLD_prod_line_ge_cont;
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
    itbLD_prod_line_ge_cont  in out nocopy tytbLD_prod_line_ge_cont
  )
  IS
  BEGIN
      rcRecOfTab.Prod_Line_Ge_Conty_Id.delete;
      rcRecOfTab.Product_Line_Id.delete;
      rcRecOfTab.Contratistas_Id.delete;
      rcRecOfTab.row_id.delete;
  END;
  PROCEDURE FillRecordOfTables
  (
    itbLD_prod_line_ge_cont  in out nocopy tytbLD_prod_line_ge_cont,
    oblUseRowId out boolean
  )
  IS
  BEGIN
    DelRecordOfTables(itbLD_prod_line_ge_cont);
    for n in itbLD_prod_line_ge_cont.first .. itbLD_prod_line_ge_cont.last loop
      rcRecOfTab.Prod_Line_Ge_Conty_Id(n) := itbLD_prod_line_ge_cont(n).Prod_Line_Ge_Conty_Id;
      rcRecOfTab.Product_Line_Id(n) := itbLD_prod_line_ge_cont(n).Product_Line_Id;
      rcRecOfTab.Contratistas_Id(n) := itbLD_prod_line_ge_cont(n).Contratistas_Id;
      rcRecOfTab.row_id(n) := itbLD_prod_line_ge_cont(n).rowid;
      -- Indica si el rowid es Nulo
      oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
    end loop;
  END;


  PROCEDURE Load
  (
    inuProd_Line_Ge_Conty_Id in LD_prod_line_ge_cont.Prod_Line_Ge_Conty_Id%type
  )
  IS
    rcRecordNull cuRecord%rowtype;
  BEGIN
    if cuRecord%isopen then
      close cuRecord;
    end if;
    open cuRecord
    (
      inuProd_Line_Ge_Conty_Id
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
    inuProd_Line_Ge_Conty_Id in LD_prod_line_ge_cont.Prod_Line_Ge_Conty_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    if (
      inuProd_Line_Ge_Conty_Id = rcData.Prod_Line_Ge_Conty_Id
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
    inuProd_Line_Ge_Conty_Id in LD_prod_line_ge_cont.Prod_Line_Ge_Conty_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    Load
    (
      inuProd_Line_Ge_Conty_Id
    );
    return(TRUE);
  EXCEPTION
    when no_data_found then
      return(FALSE);
  END;

  PROCEDURE AccKey
  (
    inuProd_Line_Ge_Conty_Id in LD_prod_line_ge_cont.Prod_Line_Ge_Conty_Id%type
  )
  IS
    rcError styLD_prod_line_ge_cont;
  BEGIN    rcError.Prod_Line_Ge_Conty_Id:=inuProd_Line_Ge_Conty_Id;

    Load
    (
      inuProd_Line_Ge_Conty_Id
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
    inuProd_Line_Ge_Conty_Id in LD_prod_line_ge_cont.Prod_Line_Ge_Conty_Id%type
  )
  IS
  BEGIN
    Load
    (
      inuProd_Line_Ge_Conty_Id
    );
    Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
    raise ex.CONTROLLED_ERROR;

  EXCEPTION
    when no_data_found then
      null;
  END;

  PROCEDURE getRecord
  (
    inuProd_Line_Ge_Conty_Id in LD_prod_line_ge_cont.Prod_Line_Ge_Conty_Id%type,
    orcRecord out nocopy styLD_prod_line_ge_cont
  )
  IS
    rcError styLD_prod_line_ge_cont;
  BEGIN    rcError.Prod_Line_Ge_Conty_Id:=inuProd_Line_Ge_Conty_Id;

    Load
    (
      inuProd_Line_Ge_Conty_Id
    );
    orcRecord := rcData;
  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRecord
  (
    inuProd_Line_Ge_Conty_Id in LD_prod_line_ge_cont.Prod_Line_Ge_Conty_Id%type
  )
  RETURN styLD_prod_line_ge_cont
  IS
    rcError styLD_prod_line_ge_cont;
  BEGIN
    rcError.Prod_Line_Ge_Conty_Id:=inuProd_Line_Ge_Conty_Id;

    Load
    (
      inuProd_Line_Ge_Conty_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  (
    inuProd_Line_Ge_Conty_Id in LD_prod_line_ge_cont.Prod_Line_Ge_Conty_Id%type
  )
  RETURN styLD_prod_line_ge_cont
  IS
    rcError styLD_prod_line_ge_cont;
  BEGIN
    rcError.Prod_Line_Ge_Conty_Id:=inuProd_Line_Ge_Conty_Id;
        -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
         inuProd_Line_Ge_Conty_Id
       )
    then
       return(rcData);
    end if;
    Load
    (
      inuProd_Line_Ge_Conty_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  RETURN styLD_prod_line_ge_cont
  IS
  BEGIN
    return(rcData);
  END;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_prod_line_ge_cont
  )
  IS
    rfLD_prod_line_ge_cont tyrfLD_prod_line_ge_cont;
    n number(4) := 1;
    sbFullQuery VARCHAR2 (32000) := 'SELECT
                LD_prod_line_ge_cont.Prod_Line_Ge_Conty_Id,
                LD_prod_line_ge_cont.Product_Line_Id,
                LD_prod_line_ge_cont.Contratistas_Id,
                LD_prod_line_ge_cont.rowid
                FROM LD_prod_line_ge_cont';
    nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
  BEGIN
    otbResult.delete;
    if isbQuery is not NULL and length(isbQuery) > 0 then
      sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
    end if;
    open rfLD_prod_line_ge_cont for sbFullQuery;
    fetch rfLD_prod_line_ge_cont bulk collect INTO otbResult;
    close rfLD_prod_line_ge_cont;
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
                LD_prod_line_ge_cont.Prod_Line_Ge_Conty_Id,
                LD_prod_line_ge_cont.Product_Line_Id,
                LD_prod_line_ge_cont.Contratistas_Id,
                LD_prod_line_ge_cont.rowid
                FROM LD_prod_line_ge_cont';
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
    ircLD_prod_line_ge_cont in styLD_prod_line_ge_cont
  )
  IS
    rirowid varchar2(200);
  BEGIN
    insRecord(ircLD_prod_line_ge_cont,rirowid);
  END;

  PROCEDURE insRecord
  (
    ircLD_prod_line_ge_cont in styLD_prod_line_ge_cont,
    orirowid   out varchar2
  )
  IS
  BEGIN
    if ircLD_prod_line_ge_cont.Prod_Line_Ge_Conty_Id is NULL then
      Errors.SetError(cnuINS_PK_NULL,
                      fsbGetMessageDescription||'|Prod_Line_Ge_Conty_Id');
      raise ex.controlled_error;
    end if;
    insert into LD_prod_line_ge_cont
    (
      Prod_Line_Ge_Conty_Id,
      Product_Line_Id,
      Contratistas_Id
    )
    values
    (
      ircLD_prod_line_ge_cont.Prod_Line_Ge_Conty_Id,
      ircLD_prod_line_ge_cont.Product_Line_Id,
      ircLD_prod_line_ge_cont.Contratistas_Id
    )
            returning
      rowid
    into
      orirowid;
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_prod_line_ge_cont));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE insRecords
  (
    iotbLD_prod_line_ge_cont in out nocopy tytbLD_prod_line_ge_cont
  )
  IS
    blUseRowID boolean;
  BEGIN
    FillRecordOfTables(iotbLD_prod_line_ge_cont, blUseRowID);
    forall n in iotbLD_prod_line_ge_cont.first..iotbLD_prod_line_ge_cont.last
      insert into LD_prod_line_ge_cont
      (
      Prod_Line_Ge_Conty_Id,
      Product_Line_Id,
      Contratistas_Id
    )
    values
    (
      rcRecOfTab.Prod_Line_Ge_Conty_Id(n),
      rcRecOfTab.Product_Line_Id(n),
      rcRecOfTab.Contratistas_Id(n)
      );
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE delRecord
  (
    inuProd_Line_Ge_Conty_Id in LD_prod_line_ge_cont.Prod_Line_Ge_Conty_Id%type,
    inuLock in number default 1
  )
  IS
    rcError styLD_prod_line_ge_cont;
  BEGIN
    rcError.Prod_Line_Ge_Conty_Id:=inuProd_Line_Ge_Conty_Id;

    if inuLock=1 then
      LockByPk
      (
        inuProd_Line_Ge_Conty_Id,
        rcData
      );
    end if;

    delete
    from LD_prod_line_ge_cont
    where
           Prod_Line_Ge_Conty_Id=inuProd_Line_Ge_Conty_Id;
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
    rcError  styLD_prod_line_ge_cont;
  BEGIN
    if inuLock=1 then
      LockByRowId(iriRowID,rcData);
    end if;

    delete
    from LD_prod_line_ge_cont
    where
      rowid = iriRowID
    returning
   Prod_Line_Ge_Conty_Id
    into
      rcError.Prod_Line_Ge_Conty_Id;

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
    iotbLD_prod_line_ge_cont in out nocopy tytbLD_prod_line_ge_cont,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_prod_line_ge_cont;
  BEGIN
    FillRecordOfTables(iotbLD_prod_line_ge_cont, blUseRowID);
       if ( blUseRowId ) then
      if inuLock = 1 then
        for n in iotbLD_prod_line_ge_cont.first .. iotbLD_prod_line_ge_cont.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_prod_line_ge_cont.first .. iotbLD_prod_line_ge_cont.last
        delete
        from LD_prod_line_ge_cont
        where
          rowid = rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_prod_line_ge_cont.first .. iotbLD_prod_line_ge_cont.last loop
          LockByPk
          (
              rcRecOfTab.Prod_Line_Ge_Conty_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_prod_line_ge_cont.first .. iotbLD_prod_line_ge_cont.last
        delete
        from LD_prod_line_ge_cont
        where
               Prod_Line_Ge_Conty_Id = rcRecOfTab.Prod_Line_Ge_Conty_Id(n);
    end if;
  EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecord
  (
    ircLD_prod_line_ge_cont in styLD_prod_line_ge_cont,
    inuLock    in number default 0
  )
  IS
    nuProd_Line_Ge_Conty_Id LD_prod_line_ge_cont.Prod_Line_Ge_Conty_Id%type;

  BEGIN
    if ircLD_prod_line_ge_cont.rowid is not null then
      if inuLock=1 then
        LockByRowId(ircLD_prod_line_ge_cont.rowid,rcData);
      end if;
      update LD_prod_line_ge_cont
      set

        Prod_Line_Ge_Conty_Id = ircLD_prod_line_ge_cont.Prod_Line_Ge_Conty_Id,
        Product_Line_Id = ircLD_prod_line_ge_cont.Product_Line_Id,
        Contratistas_Id = ircLD_prod_line_ge_cont.Contratistas_Id
      where
        rowid = ircLD_prod_line_ge_cont.rowid
      returning
    Prod_Line_Ge_Conty_Id
      into
        nuProd_Line_Ge_Conty_Id;

    else
      if inuLock=1 then
        LockByPk
        (
          ircLD_prod_line_ge_cont.Prod_Line_Ge_Conty_Id,
          rcData
        );
      end if;

      update LD_prod_line_ge_cont
      set
        Prod_Line_Ge_Conty_Id = ircLD_prod_line_ge_cont.Prod_Line_Ge_Conty_Id,
        Product_Line_Id = ircLD_prod_line_ge_cont.Product_Line_Id,
        Contratistas_Id = ircLD_prod_line_ge_cont.Contratistas_Id
      where
             Prod_Line_Ge_Conty_Id = ircLD_prod_line_ge_cont.Prod_Line_Ge_Conty_Id
      returning
    Prod_Line_Ge_Conty_Id
      into
        nuProd_Line_Ge_Conty_Id;
    end if;

    if
      nuProd_Line_Ge_Conty_Id is NULL
    then
      raise no_data_found;
    end if;

  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_prod_line_ge_cont));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecords
  (
    iotbLD_prod_line_ge_cont in out nocopy tytbLD_prod_line_ge_cont,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_prod_line_ge_cont;
  BEGIN
    FillRecordOfTables(iotbLD_prod_line_ge_cont,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_prod_line_ge_cont.first .. iotbLD_prod_line_ge_cont.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_prod_line_ge_cont.first .. iotbLD_prod_line_ge_cont.last
        update LD_prod_line_ge_cont
        set

            Prod_Line_Ge_Conty_Id = rcRecOfTab.Prod_Line_Ge_Conty_Id(n),
            Product_Line_Id = rcRecOfTab.Product_Line_Id(n),
            Contratistas_Id = rcRecOfTab.Contratistas_Id(n)
          where
          rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_prod_line_ge_cont.first .. iotbLD_prod_line_ge_cont.last loop
          LockByPk
          (
              rcRecOfTab.Prod_Line_Ge_Conty_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_prod_line_ge_cont.first .. iotbLD_prod_line_ge_cont.last
        update LD_prod_line_ge_cont
        set
          Prod_Line_Ge_Conty_Id = rcRecOfTab.Prod_Line_Ge_Conty_Id(n),
          Product_Line_Id = rcRecOfTab.Product_Line_Id(n),
          Contratistas_Id = rcRecOfTab.Contratistas_Id(n)
          where
          Prod_Line_Ge_Conty_Id = rcRecOfTab.Prod_Line_Ge_Conty_Id(n)
;
    end if;
  END;

  PROCEDURE updProd_Line_Ge_Conty_Id
  (
    inuProd_Line_Ge_Conty_Id in LD_prod_line_ge_cont.Prod_Line_Ge_Conty_Id%type,
    inuProd_Line_Ge_Conty_Id$ in LD_prod_line_ge_cont.Prod_Line_Ge_Conty_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_prod_line_ge_cont;
  BEGIN
    rcError.Prod_Line_Ge_Conty_Id := inuProd_Line_Ge_Conty_Id;
    if inuLock=1 then
      LockByPk
      (
        inuProd_Line_Ge_Conty_Id,
        rcData
      );
    end if;

    update LD_prod_line_ge_cont
    set
      Prod_Line_Ge_Conty_Id = inuProd_Line_Ge_Conty_Id$
    where
      Prod_Line_Ge_Conty_Id = inuProd_Line_Ge_Conty_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Prod_Line_Ge_Conty_Id:= inuProd_Line_Ge_Conty_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updProduct_Line_Id
  (
    inuProd_Line_Ge_Conty_Id in LD_prod_line_ge_cont.Prod_Line_Ge_Conty_Id%type,
    inuProduct_Line_Id$ in LD_prod_line_ge_cont.Product_Line_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_prod_line_ge_cont;
  BEGIN
    rcError.Prod_Line_Ge_Conty_Id := inuProd_Line_Ge_Conty_Id;
    if inuLock=1 then
      LockByPk
      (
        inuProd_Line_Ge_Conty_Id,
        rcData
      );
    end if;

    update LD_prod_line_ge_cont
    set
      Product_Line_Id = inuProduct_Line_Id$
    where
      Prod_Line_Ge_Conty_Id = inuProd_Line_Ge_Conty_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Product_Line_Id:= inuProduct_Line_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updContratistas_Id
  (
    inuProd_Line_Ge_Conty_Id in LD_prod_line_ge_cont.Prod_Line_Ge_Conty_Id%type,
    inuContratistas_Id$ in LD_prod_line_ge_cont.Contratistas_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_prod_line_ge_cont;
  BEGIN
    rcError.Prod_Line_Ge_Conty_Id := inuProd_Line_Ge_Conty_Id;
    if inuLock=1 then
      LockByPk
      (
        inuProd_Line_Ge_Conty_Id,
        rcData
      );
    end if;

    update LD_prod_line_ge_cont
    set
      Contratistas_Id = inuContratistas_Id$
    where
      Prod_Line_Ge_Conty_Id = inuProd_Line_Ge_Conty_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Contratistas_Id:= inuContratistas_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;


  FUNCTION fnuGetProd_Line_Ge_Conty_Id
  (
    inuProd_Line_Ge_Conty_Id in LD_prod_line_ge_cont.Prod_Line_Ge_Conty_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_prod_line_ge_cont.Prod_Line_Ge_Conty_Id%type
  IS
    rcError styLD_prod_line_ge_cont;
  BEGIN

    rcError.Prod_Line_Ge_Conty_Id := inuProd_Line_Ge_Conty_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuProd_Line_Ge_Conty_Id
       )
    then
       return(rcData.Prod_Line_Ge_Conty_Id);
    end if;
    Load
    (
      inuProd_Line_Ge_Conty_Id
    );
    return(rcData.Prod_Line_Ge_Conty_Id);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetProduct_Line_Id
  (
    inuProd_Line_Ge_Conty_Id in LD_prod_line_ge_cont.Prod_Line_Ge_Conty_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_prod_line_ge_cont.Product_Line_Id%type
  IS
    rcError styLD_prod_line_ge_cont;
  BEGIN

    rcError.Prod_Line_Ge_Conty_Id := inuProd_Line_Ge_Conty_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuProd_Line_Ge_Conty_Id
       )
    then
       return(rcData.Product_Line_Id);
    end if;
    Load
    (
      inuProd_Line_Ge_Conty_Id
    );
    return(rcData.Product_Line_Id);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetContratistas_Id
  (
    inuProd_Line_Ge_Conty_Id in LD_prod_line_ge_cont.Prod_Line_Ge_Conty_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_prod_line_ge_cont.Contratistas_Id%type
  IS
    rcError styLD_prod_line_ge_cont;
  BEGIN

    rcError.Prod_Line_Ge_Conty_Id := inuProd_Line_Ge_Conty_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuProd_Line_Ge_Conty_Id
       )
    then
       return(rcData.Contratistas_Id);
    end if;
    Load
    (
      inuProd_Line_Ge_Conty_Id
    );
    return(rcData.Contratistas_Id);
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
end DALD_prod_line_ge_cont;
/
PROMPT Otorgando permisos de ejecucion a DALD_PROD_LINE_GE_CONT
BEGIN
    pkg_utilidades.praplicarpermisos('DALD_PROD_LINE_GE_CONT', 'ADM_PERSON');
END;
/