CREATE OR REPLACE PACKAGE adm_person.daldci_trsoitem
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
    19/06/2024              PAcosta         OSF-2845: Cambio de esquema ADM_PERSON                              
    ****************************************************************/       
    
  /* Cursor general para acceso por Llave Primaria */
  CURSOR cuRecord
  (
    inutsittrsm in LDCI_TRSOITEM.tsittrsm%type
  )
  IS
    SELECT LDCI_TRSOITEM.*,LDCI_TRSOITEM.rowid
    FROM LDCI_TRSOITEM
    WHERE
      tsittrsm = inutsittrsm;


  /* Cursor general para acceso por RowId */
  CURSOR cuRecordByRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LDCI_TRSOITEM.*,LDCI_TRSOITEM.rowid
    FROM LDCI_TRSOITEM
    WHERE
      rowId = irirowid;


  /* Subtipos */
  subtype styLDCI_TRSOITEM  is  cuRecord%rowtype;
  type tyRefCursor is  REF CURSOR;

  /*Tipos*/
  type tytbLDCI_TRSOITEM is table of styLDCI_TRSOITEM index by binary_integer;
  type tyrfRecords is ref cursor return styLDCI_TRSOITEM;

  /* Tipos referenciando al registro */
  type tytbtsittrsm is table of LDCI_TRSOITEM.tsittrsm%type index by binary_integer;
  type tytbtsititem is table of LDCI_TRSOITEM.tsititem%type index by binary_integer;
  type tytbtsitcant is table of LDCI_TRSOITEM.tsitcant%type index by binary_integer;
  type tytbtsitcare is table of LDCI_TRSOITEM.tsitcare%type index by binary_integer;
  type tytbtsitvuni is table of LDCI_TRSOITEM.tsitvuni%type index by binary_integer;
  type tytbtsitpiva is table of LDCI_TRSOITEM.tsitpiva%type index by binary_integer;
  type tytbtsitsafi is table of LDCI_TRSOITEM.tsitsafi%type index by binary_integer;
  type tytbtsitmabo is table of LDCI_TRSOITEM.tsitmabo%type index by binary_integer;
  type tytbtsitvalo is table of LDCI_TRSOITEM.tsitvalo%type index by binary_integer;
  type tytbtsitmdma is table of LDCI_TRSOITEM.tsitmdma%type index by binary_integer;
  type tytbtsitcude is table of LDCI_TRSOITEM.tsitcude%type index by binary_integer;

  type tytbrowid is table of rowid index by binary_integer;

  type tyrcLDCI_TRSOITEM is record
  (
  tsittrsm   tytbtsittrsm,
  tsititem tytbtsititem,
  tsitcant tytbtsitcant,
  tsitcare tytbtsitcare,
  tsitvuni tytbtsitvuni,
  tsitpiva tytbtsitpiva,
  tsitsafi tytbtsitsafi,
  tsitmabo tytbtsitmabo,
  tsitvalo tytbtsitvalo,
  tsitmdma tytbtsitmdma,
  tsitcude tytbtsitcude,
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
    inutsittrsm in LDCI_TRSOITEM.tsittrsm%type
  )
  RETURN boolean;

   PROCEDURE AccKey
   (
     inutsittrsm in LDCI_TRSOITEM.tsittrsm%type
  );

  PROCEDURE AccKeyByRowId
  (
    iriRowID    in rowid
  );

  PROCEDURE ValDuplicate
  (
     inutsittrsm in LDCI_TRSOITEM.tsittrsm%type
  );

  PROCEDURE getRecord
  (
    inutsittrsm in LDCI_TRSOITEM.tsittrsm%type,
    orcRecord out nocopy styLDCI_TRSOITEM
  );

  FUNCTION frcGetRcData
  (
    inutsittrsm in LDCI_TRSOITEM.tsittrsm%type
  )
  RETURN styLDCI_TRSOITEM;

  FUNCTION frcGetRcData
  RETURN styLDCI_TRSOITEM;

  FUNCTION frcGetRecord
  (
    inutsittrsm in LDCI_TRSOITEM.tsittrsm%type
  )
  RETURN styLDCI_TRSOITEM;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLDCI_TRSOITEM
  );

  FUNCTION frfGetRecords
  (
    isbCriteria in varchar2 default null,
    iblLock in boolean default false
  )
  RETURN tyRefCursor;

  PROCEDURE insRecord
  (
    ircLDCI_TRSOITEM in styLDCI_TRSOITEM
  );

     PROCEDURE insRecord
  (
    ircLDCI_TRSOITEM in styLDCI_TRSOITEM,
    orirowid   out varchar2
  );

  PROCEDURE insRecords
  (
    iotbLDCI_TRSOITEM in out nocopy tytbLDCI_TRSOITEM
  );

  PROCEDURE delRecord
  (
    inutsittrsm in LDCI_TRSOITEM.tsittrsm%type,
    inuLock in number default 1
  );

  PROCEDURE delByRowID
  (
    iriRowID    in rowid,
    inuLock in number default 1
  );

  PROCEDURE delRecords
  (
    iotbLDCI_TRSOITEM in out nocopy tytbLDCI_TRSOITEM,
    inuLock in number default 1
  );

  PROCEDURE updRecord
  (
    ircLDCI_TRSOITEM in styLDCI_TRSOITEM,
    inuLock    in number default 0
  );

  PROCEDURE updRecords
  (
    iotbLDCI_TRSOITEM in out nocopy tytbLDCI_TRSOITEM,
    inuLock in number default 1
  );



      FUNCTION fnuGettsittrsm
      (
          inutsittrsm in LDCI_TRSOITEM.tsittrsm%type,
          inuRaiseError in number default 1
      )
      RETURN LDCI_TRSOITEM.tsittrsm%type;




  PROCEDURE LockByPk
  (
    inutsittrsm in LDCI_TRSOITEM.tsittrsm%type,
    orcLDCI_TRSOITEM  out styLDCI_TRSOITEM
  );

  PROCEDURE LockByRowID
  (
    irirowid    in  varchar2,
    orcLDCI_TRSOITEM  out styLDCI_TRSOITEM
  );

  PROCEDURE SetUseCache
  (
    iblUseCache    in  boolean
  );
END DALDCI_TRSOITEM;
/
CREATE OR REPLACE PACKAGE BODY adm_person.daldci_trsoitem
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO156922';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDCI_TRSOITEM';
    cnuGeEntityId constant varchar2(30) := 7359; -- Id de Ge_entity

  /* Cursor para bloqueo de un registro por llave primaria */
  CURSOR cuLockRcByPk
  (
    inutsittrsm in LDCI_TRSOITEM.tsittrsm%type
  )
  IS
    SELECT LDCI_TRSOITEM.*,LDCI_TRSOITEM.rowid
    FROM LDCI_TRSOITEM
    WHERE  tsittrsm = inutsittrsm
    FOR UPDATE NOWAIT;

  /* Cursor para bloqueo de un registro por rowid */
  CURSOR cuLockRcbyRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LDCI_TRSOITEM.*,LDCI_TRSOITEM.rowid
    FROM LDCI_TRSOITEM
    WHERE
      rowId = irirowid
    FOR UPDATE NOWAIT;
  /*Tipos*/
  type tyrfLDCI_TRSOITEM is ref cursor;

  /*Variables Globales*/
  rcRecOfTab tyrcLDCI_TRSOITEM;

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

  FUNCTION fsbPrimaryKey( rcI in styLDCI_TRSOITEM default rcData )
  return varchar2
  IS
    sbPk varchar2(500);
  BEGIN
    sbPk:='[';
    sbPk:=sbPk||ut_convert.fsbToChar(rcI.tsittrsm);
    sbPk:=sbPk||']';
    return sbPk;
  END;

  PROCEDURE LockByPk
  (
    inutsittrsm in LDCI_TRSOITEM.tsittrsm%type,
    orcLDCI_TRSOITEM  out styLDCI_TRSOITEM
  )
  IS
    rcError styLDCI_TRSOITEM;
  BEGIN
    rcError.tsittrsm := inutsittrsm;

    Open cuLockRcByPk
    (
      inutsittrsm
    );

    fetch cuLockRcByPk into orcLDCI_TRSOITEM;
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
    orcLDCI_TRSOITEM  out styLDCI_TRSOITEM
  )
  IS
  BEGIN
    Open cuLockRcbyRowId
    (
      irirowid
    );

    fetch cuLockRcbyRowId into orcLDCI_TRSOITEM;
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
    itbLDCI_TRSOITEM  in out nocopy tytbLDCI_TRSOITEM
  )
  IS
  BEGIN
      rcRecOfTab.tsittrsm.delete;
      rcRecOfTab.tsititem.delete;
      rcRecOfTab.tsitcant.delete;
      rcRecOfTab.tsitcare.delete;
      rcRecOfTab.tsitvuni.delete;
      rcRecOfTab.tsitpiva.delete;
      rcRecOfTab.tsitsafi.delete;
      rcRecOfTab.tsitmabo.delete;
      rcRecOfTab.tsitvalo.delete;
      rcRecOfTab.tsitmdma.delete;
      rcRecOfTab.tsitcude.delete;
      rcRecOfTab.row_id.delete;
  END;
  PROCEDURE FillRecordOfTables
  (
    itbLDCI_TRSOITEM  in out nocopy tytbLDCI_TRSOITEM,
    oblUseRowId out boolean
  )
  IS
  BEGIN
    DelRecordOfTables(itbLDCI_TRSOITEM);
    for n in itbLDCI_TRSOITEM.first .. itbLDCI_TRSOITEM.last loop
      rcRecOfTab.tsittrsm(n) := itbLDCI_TRSOITEM(n).tsittrsm;
      rcRecOfTab.tsititem(n) := itbLDCI_TRSOITEM(n).tsititem;
      rcRecOfTab.tsitcant(n) := itbLDCI_TRSOITEM(n).tsitcant;
      rcRecOfTab.tsitcare(n) := itbLDCI_TRSOITEM(n).tsitcare;
      rcRecOfTab.tsitvuni(n) := itbLDCI_TRSOITEM(n).tsitvuni;
      rcRecOfTab.tsitpiva(n) := itbLDCI_TRSOITEM(n).tsitpiva;
      rcRecOfTab.tsitsafi(n) := itbLDCI_TRSOITEM(n).tsitsafi;
      rcRecOfTab.tsitmabo(n) := itbLDCI_TRSOITEM(n).tsitmabo;
      rcRecOfTab.tsitvalo(n) := itbLDCI_TRSOITEM(n).tsitvalo;
      rcRecOfTab.tsitmdma(n) := itbLDCI_TRSOITEM(n).tsitmdma;
      rcRecOfTab.tsitcude(n) := itbLDCI_TRSOITEM(n).tsitcude;
      rcRecOfTab.row_id(n) := itbLDCI_TRSOITEM(n).rowid;
      -- Indica si el rowid es Nulo
      oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
    end loop;
  END;


  PROCEDURE Load
  (
    inutsittrsm in LDCI_TRSOITEM.tsittrsm%type
  )
  IS
    rcRecordNull cuRecord%rowtype;
  BEGIN
    if cuRecord%isopen then
      close cuRecord;
    end if;
    open cuRecord
    (
      inutsittrsm
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
    inutsittrsm in LDCI_TRSOITEM.tsittrsm%type
  )
  RETURN boolean
  IS
  BEGIN
    if (
      inutsittrsm = rcData.tsittrsm
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
    inutsittrsm in LDCI_TRSOITEM.tsittrsm%type
  )
  RETURN boolean
  IS
  BEGIN
    Load
    (
      inutsittrsm
    );
    return(TRUE);
  EXCEPTION
    when no_data_found then
      return(FALSE);
  END;

  PROCEDURE AccKey
  (
    inutsittrsm in LDCI_TRSOITEM.tsittrsm%type
  )
  IS
    rcError styLDCI_TRSOITEM;
  BEGIN    rcError.tsittrsm:=inutsittrsm;

    Load
    (
      inutsittrsm
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
    inutsittrsm in LDCI_TRSOITEM.tsittrsm%type
  )
  IS
  BEGIN
    Load
    (
      inutsittrsm
    );
    Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
    raise ex.CONTROLLED_ERROR;

  EXCEPTION
    when no_data_found then
      null;
  END;

  PROCEDURE getRecord
  (
    inutsittrsm in LDCI_TRSOITEM.tsittrsm%type,
    orcRecord out nocopy styLDCI_TRSOITEM
  )
  IS
    rcError styLDCI_TRSOITEM;
  BEGIN    rcError.tsittrsm:=inutsittrsm;

    Load
    (
      inutsittrsm
    );
    orcRecord := rcData;
  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRecord
  (
    inutsittrsm in LDCI_TRSOITEM.tsittrsm%type
  )
  RETURN styLDCI_TRSOITEM
  IS
    rcError styLDCI_TRSOITEM;
  BEGIN
    rcError.tsittrsm:=inutsittrsm;

    Load
    (
      inutsittrsm
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  (
    inutsittrsm in LDCI_TRSOITEM.tsittrsm%type
  )
  RETURN styLDCI_TRSOITEM
  IS
    rcError styLDCI_TRSOITEM;
  BEGIN
    rcError.tsittrsm:=inutsittrsm;
        -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
         inutsittrsm
       )
    then
       return(rcData);
    end if;
    Load
    (
      inutsittrsm
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  RETURN styLDCI_TRSOITEM
  IS
  BEGIN
    return(rcData);
  END;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLDCI_TRSOITEM
  )
  IS
    rfLDCI_TRSOITEM tyrfLDCI_TRSOITEM;
    n number(4) := 1;
    sbFullQuery VARCHAR2 (32000) := 'SELECT
                tsittrsm,
                tsititem,
                tsitcant,
                tsitcare,
                tsitvuni,
                tsitpiva,
                tsitsafi,
                tsitmabo,
                tsitvalo,
                tsitmdma,
                tsitcude
                LDCI_TRSOITEM.rowid
                FROM LDCI_TRSOITEM';
    nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
  BEGIN
    otbResult.delete;
    if isbQuery is not NULL and length(isbQuery) > 0 then
      sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
    end if;
    open rfLDCI_TRSOITEM for sbFullQuery;
    fetch rfLDCI_TRSOITEM bulk collect INTO otbResult;
    close rfLDCI_TRSOITEM;
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
                tsittrsm,
                tsititem,
                tsitcant,
                tsitcare,
                tsitvuni,
                tsitpiva,
                tsitsafi,
                tsitmabo,
                tsitvalo,
                tsitmdma,
                tsitcude
                FROM LDCI_TRSOITEM';
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
    ircLDCI_TRSOITEM in styLDCI_TRSOITEM
  )
  IS
    rirowid varchar2(200);
  BEGIN
    insRecord(ircLDCI_TRSOITEM,rirowid);
  END;

  PROCEDURE insRecord
  (
    ircLDCI_TRSOITEM in styLDCI_TRSOITEM,
    orirowid   out varchar2
  )
  IS
  BEGIN
    if ircLDCI_TRSOITEM.tsittrsm is NULL then
      Errors.SetError(cnuINS_PK_NULL,
                      fsbGetMessageDescription||'|tsittrsm');
      raise ex.controlled_error;
    end if;
    insert into LDCI_TRSOITEM
    (
      tsittrsm,
      tsititem,
      tsitcant,
      tsitcare,
      tsitvuni,
      tsitpiva,
      tsitsafi,
      tsitmabo,
      tsitvalo,
      tsitmdma,
      tsitcude
    )
    values
    (
      ircLDCI_TRSOITEM.tsittrsm,
      ircLDCI_TRSOITEM.tsititem,
      ircLDCI_TRSOITEM.tsitcant,
      ircLDCI_TRSOITEM.tsitcare,
      ircLDCI_TRSOITEM.tsitvuni,
      ircLDCI_TRSOITEM.tsitpiva,
      ircLDCI_TRSOITEM.tsitsafi,
      ircLDCI_TRSOITEM.tsitmabo,
      ircLDCI_TRSOITEM.tsitvalo,
      ircLDCI_TRSOITEM.tsitmdma,
      ircLDCI_TRSOITEM.tsitcude
    )
            returning
      rowid
    into
      orirowid;
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDCI_TRSOITEM));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE insRecords
  (
    iotbLDCI_TRSOITEM in out nocopy tytbLDCI_TRSOITEM
  )
  IS
    blUseRowID boolean;
  BEGIN
    FillRecordOfTables(iotbLDCI_TRSOITEM, blUseRowID);
    forall n in iotbLDCI_TRSOITEM.first..iotbLDCI_TRSOITEM.last
      insert into LDCI_TRSOITEM
      (
      tsittrsm,
      tsititem,
      tsitcant,
      tsitcare,
      tsitvuni,
      tsitpiva,
      tsitsafi,
      tsitmabo,
      tsitvalo,
      tsitmdma,
      tsitcude
    )
    values
    (
      rcRecOfTab.tsittrsm(n),
      rcRecOfTab.tsititem(n),
      rcRecOfTab.tsitcant(n),
      rcRecOfTab.tsitcare(n),
      rcRecOfTab.tsitvuni(n),
      rcRecOfTab.tsitpiva(n),
      rcRecOfTab.tsitsafi(n),
      rcRecOfTab.tsitmabo(n),
      rcRecOfTab.tsitvalo(n),
      rcRecOfTab.tsitmdma(n),
      rcRecOfTab.tsitcude(n)

      );
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE delRecord
  (
    inutsittrsm in LDCI_TRSOITEM.tsittrsm%type,
    inuLock in number default 1
  )
  IS
    rcError styLDCI_TRSOITEM;
  BEGIN
    rcError.tsittrsm:=inutsittrsm;

    if inuLock=1 then
      LockByPk
      (
        inutsittrsm,
        rcData
      );
    end if;

    delete
    from LDCI_TRSOITEM
    where
           tsittrsm=inutsittrsm;
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
    rcError  styLDCI_TRSOITEM;
  BEGIN
    if inuLock=1 then
      LockByRowId(iriRowID,rcData);
    end if;

    delete
    from LDCI_TRSOITEM
    where
      rowid = iriRowID
    returning
   tsittrsm
    into
      rcError.tsittrsm;

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
    iotbLDCI_TRSOITEM in out nocopy tytbLDCI_TRSOITEM,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLDCI_TRSOITEM;
  BEGIN
    FillRecordOfTables(iotbLDCI_TRSOITEM, blUseRowID);
       if ( blUseRowId ) then
      if inuLock = 1 then
        for n in iotbLDCI_TRSOITEM.first .. iotbLDCI_TRSOITEM.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLDCI_TRSOITEM.first .. iotbLDCI_TRSOITEM.last
        delete
        from LDCI_TRSOITEM
        where
          rowid = rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLDCI_TRSOITEM.first .. iotbLDCI_TRSOITEM.last loop
          LockByPk
          (
              rcRecOfTab.tsittrsm(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLDCI_TRSOITEM.first .. iotbLDCI_TRSOITEM.last
        delete
        from LDCI_TRSOITEM
        where
               tsittrsm = rcRecOfTab.tsittrsm(n);
    end if;
  EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecord
  (
    ircLDCI_TRSOITEM in styLDCI_TRSOITEM,
    inuLock    in number default 0
  )
  IS
    nutsittrsm LDCI_TRSOITEM.tsittrsm%type;

  BEGIN
    if ircLDCI_TRSOITEM.rowid is not null then
      if inuLock=1 then
        LockByRowId(ircLDCI_TRSOITEM.rowid,rcData);
      end if;
      update LDCI_TRSOITEM
      set
        tsititem = ircLDCI_TRSOITEM.tsititem,
        tsitcant = ircLDCI_TRSOITEM.tsitcant,
        tsitcare = ircLDCI_TRSOITEM.tsitcare,
        tsitvuni = ircLDCI_TRSOITEM.tsitvuni,
        tsitpiva = ircLDCI_TRSOITEM.tsitpiva,
        tsitsafi = ircLDCI_TRSOITEM.tsitsafi,
        tsitmabo = ircLDCI_TRSOITEM.tsitmabo,
        tsitvalo = ircLDCI_TRSOITEM.tsitvalo,
        tsitmdma = ircLDCI_TRSOITEM.tsitmdma,
        tsitcude = ircLDCI_TRSOITEM.tsitcude
      where
        rowid = ircLDCI_TRSOITEM.rowid
      returning
    tsittrsm
      into
        nutsittrsm;

    else
      if inuLock=1 then
        LockByPk
        (
          ircLDCI_TRSOITEM.tsittrsm,
          rcData
        );
      end if;

      update LDCI_TRSOITEM
      set
        tsititem = ircLDCI_TRSOITEM.tsititem,
        tsitcant = ircLDCI_TRSOITEM.tsitcant,
        tsitcare = ircLDCI_TRSOITEM.tsitcare,
        tsitvuni = ircLDCI_TRSOITEM.tsitvuni,
        tsitpiva = ircLDCI_TRSOITEM.tsitpiva,
        tsitsafi = ircLDCI_TRSOITEM.tsitsafi,
        tsitmabo = ircLDCI_TRSOITEM.tsitmabo,
        tsitvalo = ircLDCI_TRSOITEM.tsitvalo,
        tsitmdma = ircLDCI_TRSOITEM.tsitmdma,
        tsitcude = ircLDCI_TRSOITEM.tsitcude

      where
             tsittrsm = ircLDCI_TRSOITEM.tsittrsm
      returning
    tsittrsm
      into
        nutsittrsm;
    end if;

    if
      nutsittrsm is NULL
    then
      raise no_data_found;
    end if;

  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDCI_TRSOITEM));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecords
  (
    iotbLDCI_TRSOITEM in out nocopy tytbLDCI_TRSOITEM,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLDCI_TRSOITEM;
  BEGIN
    FillRecordOfTables(iotbLDCI_TRSOITEM,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLDCI_TRSOITEM.first .. iotbLDCI_TRSOITEM.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLDCI_TRSOITEM.first .. iotbLDCI_TRSOITEM.last
        update LDCI_TRSOITEM
        set
        tsititem = rcRecOfTab.tsititem(n),
        tsitcant = rcRecOfTab.tsitcant(n),
        tsitcare = rcRecOfTab.tsitcare(n),
        tsitvuni = rcRecOfTab.tsitvuni(n),
        tsitpiva = rcRecOfTab.tsitpiva(n),
        tsitsafi = rcRecOfTab.tsitsafi(n),
        tsitmabo = rcRecOfTab.tsitmabo(n),
        tsitvalo = rcRecOfTab.tsitvalo(n),
        tsitmdma = rcRecOfTab.tsitmdma(n),
        tsitcude = rcRecOfTab.tsitcude(n)

          where
          rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLDCI_TRSOITEM.first .. iotbLDCI_TRSOITEM.last loop
          LockByPk
          (
              rcRecOfTab.tsittrsm(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLDCI_TRSOITEM.first .. iotbLDCI_TRSOITEM.last
        update LDCI_TRSOITEM
        set
        tsititem = rcRecOfTab.tsititem(n),
        tsitcant = rcRecOfTab.tsitcant(n),
        tsitcare = rcRecOfTab.tsitcare(n),
        tsitvuni = rcRecOfTab.tsitvuni(n),
        tsitpiva = rcRecOfTab.tsitpiva(n),
        tsitsafi = rcRecOfTab.tsitsafi(n),
        tsitmabo = rcRecOfTab.tsitmabo(n),
        tsitvalo = rcRecOfTab.tsitvalo(n),
        tsitmdma = rcRecOfTab.tsitmdma(n),
        tsitcude = rcRecOfTab.tsitcude(n)
          where
          tsittrsm = rcRecOfTab.tsittrsm(n)
;
    end if;
  END;


  FUNCTION fnuGettsittrsm
  (
    inutsittrsm in LDCI_TRSOITEM.tsittrsm%type,
    inuRaiseError in number default 1
  )
    RETURN LDCI_TRSOITEM.tsittrsm%type
  IS
    rcError styLDCI_TRSOITEM;
  BEGIN

    rcError.tsittrsm := inutsittrsm;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inutsittrsm
       )
    then
       return(rcData.tsittrsm);
    end if;
    Load
    (
      inutsittrsm
    );
    return(rcData.tsittrsm);
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
end DALDCI_TRSOITEM;
/
PROMPT Otorgando permisos de ejecucion a DALDCI_TRSOITEM
BEGIN
    pkg_utilidades.praplicarpermisos('DALDCI_TRSOITEM', 'ADM_PERSON');
END;
/