CREATE OR REPLACE PACKAGE adm_person.daldci_transoma
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  11/06/2024   Adrianavg   OSF-2813: Migrar del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
  /* Cursor general para acceso por Llave Primaria */
  CURSOR cuRecord
  (
    inutrsmcodi in LDCI_TRANSOMA.trsmcodi%type
  )
  IS
    SELECT LDCI_TRANSOMA.*,LDCI_TRANSOMA.rowid
    FROM LDCI_TRANSOMA
    WHERE
      trsmcodi = inutrsmcodi;


  /* Cursor general para acceso por RowId */
  CURSOR cuRecordByRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LDCI_TRANSOMA.*,LDCI_TRANSOMA.rowid
    FROM LDCI_TRANSOMA
    WHERE
      rowId = irirowid;


  /* Subtipos */
  subtype styLDCI_TRANSOMA  is  cuRecord%rowtype;
  type tyRefCursor is  REF CURSOR;

  /*Tipos*/
  type tytbLDCI_TRANSOMA is table of styLDCI_TRANSOMA index by binary_integer;
  type tyrfRecords is ref cursor return styLDCI_TRANSOMA;

  /* Tipos referenciando al registro */
  type tytbtrsmcodi is table of LDCI_TRANSOMA.trsmcodi%type index by binary_integer;
  type tytbtrsmcont is table of LDCI_TRANSOMA.trsmcont%type index by binary_integer;
  type tytbtrsmprov is table of LDCI_TRANSOMA.trsmprov%type index by binary_integer;
  type tytbtrsmunop is table of LDCI_TRANSOMA.trsmunop%type index by binary_integer;
  type tytbtrsmfecr is table of LDCI_TRANSOMA.trsmfecr%type index by binary_integer;
  type tytbtrsmesta is table of LDCI_TRANSOMA.trsmesta%type index by binary_integer;
  type tytbtrsmofve is table of LDCI_TRANSOMA.trsmofve%type index by binary_integer;
  type tytbtrsmvtot is table of LDCI_TRANSOMA.trsmvtot%type index by binary_integer;
  type tytbtrsmdore is table of LDCI_TRANSOMA.trsmdore%type index by binary_integer;
  type tytbtrsmdsre is table of LDCI_TRANSOMA.trsmdsre%type index by binary_integer;
  type tytbtrsmmdpe is table of LDCI_TRANSOMA.trsmmdpe%type index by binary_integer;
  type tytbtrsmusmo is table of LDCI_TRANSOMA.trsmusmo%type index by binary_integer;

  type tytbrowid is table of rowid index by binary_integer;

  type tyrcLDCI_TRANSOMA is record
  (
  trsmcodi   tytbtrsmcodi,
  trsmcont tytbtrsmcont,
  trsmprov tytbtrsmprov,
  trsmunop tytbtrsmunop,
  trsmfecr tytbtrsmfecr,
  trsmesta tytbtrsmesta,
  trsmofve tytbtrsmofve,
  trsmvtot tytbtrsmvtot,
  trsmdore tytbtrsmdore,
  trsmdsre tytbtrsmdsre,
  trsmmdpe tytbtrsmmdpe,
  trsmusmo tytbtrsmusmo,
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
    inutrsmcodi in LDCI_TRANSOMA.trsmcodi%type
  )
  RETURN boolean;

   PROCEDURE AccKey
   (
     inutrsmcodi in LDCI_TRANSOMA.trsmcodi%type
  );

  PROCEDURE AccKeyByRowId
  (
    iriRowID    in rowid
  );

  PROCEDURE ValDuplicate
  (
     inutrsmcodi in LDCI_TRANSOMA.trsmcodi%type
  );

  PROCEDURE getRecord
  (
    inutrsmcodi in LDCI_TRANSOMA.trsmcodi%type,
    orcRecord out nocopy styLDCI_TRANSOMA
  );

  FUNCTION frcGetRcData
  (
    inutrsmcodi in LDCI_TRANSOMA.trsmcodi%type
  )
  RETURN styLDCI_TRANSOMA;

  FUNCTION frcGetRcData
  RETURN styLDCI_TRANSOMA;

  FUNCTION frcGetRecord
  (
    inutrsmcodi in LDCI_TRANSOMA.trsmcodi%type
  )
  RETURN styLDCI_TRANSOMA;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLDCI_TRANSOMA
  );

  FUNCTION frfGetRecords
  (
    isbCriteria in varchar2 default null,
    iblLock in boolean default false
  )
  RETURN tyRefCursor;

  PROCEDURE insRecord
  (
    ircLDCI_TRANSOMA in styLDCI_TRANSOMA
  );

     PROCEDURE insRecord
  (
    ircLDCI_TRANSOMA in styLDCI_TRANSOMA,
    orirowid   out varchar2
  );

  PROCEDURE insRecords
  (
    iotbLDCI_TRANSOMA in out nocopy tytbLDCI_TRANSOMA
  );

  PROCEDURE delRecord
  (
    inutrsmcodi in LDCI_TRANSOMA.trsmcodi%type,
    inuLock in number default 1
  );

  PROCEDURE delByRowID
  (
    iriRowID    in rowid,
    inuLock in number default 1
  );

  PROCEDURE delRecords
  (
    iotbLDCI_TRANSOMA in out nocopy tytbLDCI_TRANSOMA,
    inuLock in number default 1
  );

  PROCEDURE updRecord
  (
    ircLDCI_TRANSOMA in styLDCI_TRANSOMA,
    inuLock    in number default 0
  );

  PROCEDURE updRecords
  (
    iotbLDCI_TRANSOMA in out nocopy tytbLDCI_TRANSOMA,
    inuLock in number default 1
  );



      FUNCTION fnuGettrsmcodi
      (
          inutrsmcodi in LDCI_TRANSOMA.trsmcodi%type,
          inuRaiseError in number default 1
      )
      RETURN LDCI_TRANSOMA.trsmcodi%type;




  PROCEDURE LockByPk
  (
    inutrsmcodi in LDCI_TRANSOMA.trsmcodi%type,
    orcLDCI_TRANSOMA  out styLDCI_TRANSOMA
  );

  PROCEDURE LockByRowID
  (
    irirowid    in  varchar2,
    orcLDCI_TRANSOMA  out styLDCI_TRANSOMA
  );

  PROCEDURE SetUseCache
  (
    iblUseCache    in  boolean
  );
END DALDCI_TRANSOMA;
/
CREATE OR REPLACE PACKAGE BODY adm_person.daLDCI_TRANSOMA
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO156922';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDCI_TRANSOMA';
    cnuGeEntityId constant varchar2(30) := 7359; -- Id de Ge_entity

  /* Cursor para bloqueo de un registro por llave primaria */
  CURSOR cuLockRcByPk
  (
    inutrsmcodi in LDCI_TRANSOMA.trsmcodi%type
  )
  IS
    SELECT LDCI_TRANSOMA.*,LDCI_TRANSOMA.rowid
    FROM LDCI_TRANSOMA
    WHERE  trsmcodi = inutrsmcodi
    FOR UPDATE NOWAIT;

  /* Cursor para bloqueo de un registro por rowid */
  CURSOR cuLockRcbyRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LDCI_TRANSOMA.*,LDCI_TRANSOMA.rowid
    FROM LDCI_TRANSOMA
    WHERE
      rowId = irirowid
    FOR UPDATE NOWAIT;
  /*Tipos*/
  type tyrfLDCI_TRANSOMA is ref cursor;

  /*Variables Globales*/
  rcRecOfTab tyrcLDCI_TRANSOMA;

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

  FUNCTION fsbPrimaryKey( rcI in styLDCI_TRANSOMA default rcData )
  return varchar2
  IS
    sbPk varchar2(500);
  BEGIN
    sbPk:='[';
    sbPk:=sbPk||ut_convert.fsbToChar(rcI.trsmcodi);
    sbPk:=sbPk||']';
    return sbPk;
  END;

  PROCEDURE LockByPk
  (
    inutrsmcodi in LDCI_TRANSOMA.trsmcodi%type,
    orcLDCI_TRANSOMA  out styLDCI_TRANSOMA
  )
  IS
    rcError styLDCI_TRANSOMA;
  BEGIN
    rcError.trsmcodi := inutrsmcodi;

    Open cuLockRcByPk
    (
      inutrsmcodi
    );

    fetch cuLockRcByPk into orcLDCI_TRANSOMA;
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
    orcLDCI_TRANSOMA  out styLDCI_TRANSOMA
  )
  IS
  BEGIN
    Open cuLockRcbyRowId
    (
      irirowid
    );

    fetch cuLockRcbyRowId into orcLDCI_TRANSOMA;
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
    itbLDCI_TRANSOMA  in out nocopy tytbLDCI_TRANSOMA
  )
  IS
  BEGIN
      rcRecOfTab.trsmcodi.delete;
      rcRecOfTab.trsmcont.delete;
      rcRecOfTab.trsmprov.delete;
      rcRecOfTab.trsmunop.delete;
      rcRecOfTab.trsmfecr.delete;
      rcRecOfTab.trsmesta.delete;
      rcRecOfTab.trsmofve.delete;
      rcRecOfTab.trsmvtot.delete;
      rcRecOfTab.trsmdore.delete;
      rcRecOfTab.trsmdsre.delete;
      rcRecOfTab.trsmmdpe.delete;
      rcRecOfTab.trsmusmo.delete;
      rcRecOfTab.row_id.delete;
  END;
  PROCEDURE FillRecordOfTables
  (
    itbLDCI_TRANSOMA  in out nocopy tytbLDCI_TRANSOMA,
    oblUseRowId out boolean
  )
  IS
  BEGIN
    DelRecordOfTables(itbLDCI_TRANSOMA);
    for n in itbLDCI_TRANSOMA.first .. itbLDCI_TRANSOMA.last loop
      rcRecOfTab.trsmcodi(n) := itbLDCI_TRANSOMA(n).trsmcodi;
      rcRecOfTab.trsmcont(n) := itbLDCI_TRANSOMA(n).trsmcont;
      rcRecOfTab.trsmprov(n) := itbLDCI_TRANSOMA(n).trsmprov;
      rcRecOfTab.trsmunop(n) := itbLDCI_TRANSOMA(n).trsmunop;
      rcRecOfTab.trsmfecr(n) := itbLDCI_TRANSOMA(n).trsmfecr;
      rcRecOfTab.trsmesta(n) := itbLDCI_TRANSOMA(n).trsmesta;
      rcRecOfTab.trsmofve(n) := itbLDCI_TRANSOMA(n).trsmofve;
      rcRecOfTab.trsmvtot(n) := itbLDCI_TRANSOMA(n).trsmvtot;
      rcRecOfTab.trsmdore(n) := itbLDCI_TRANSOMA(n).trsmdore;
      rcRecOfTab.trsmdsre(n) := itbLDCI_TRANSOMA(n).trsmdsre;
      rcRecOfTab.trsmmdpe(n) := itbLDCI_TRANSOMA(n).trsmmdpe;
      rcRecOfTab.trsmusmo(n) := itbLDCI_TRANSOMA(n).trsmusmo;
      rcRecOfTab.row_id(n) := itbLDCI_TRANSOMA(n).rowid;
      -- Indica si el rowid es Nulo
      oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
    end loop;
  END;


  PROCEDURE Load
  (
    inutrsmcodi in LDCI_TRANSOMA.trsmcodi%type
  )
  IS
    rcRecordNull cuRecord%rowtype;
  BEGIN
    if cuRecord%isopen then
      close cuRecord;
    end if;
    open cuRecord
    (
      inutrsmcodi
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
    inutrsmcodi in LDCI_TRANSOMA.trsmcodi%type
  )
  RETURN boolean
  IS
  BEGIN
    if (
      inutrsmcodi = rcData.trsmcodi
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
    inutrsmcodi in LDCI_TRANSOMA.trsmcodi%type
  )
  RETURN boolean
  IS
  BEGIN
    Load
    (
      inutrsmcodi
    );
    return(TRUE);
  EXCEPTION
    when no_data_found then
      return(FALSE);
  END;

  PROCEDURE AccKey
  (
    inutrsmcodi in LDCI_TRANSOMA.trsmcodi%type
  )
  IS
    rcError styLDCI_TRANSOMA;
  BEGIN    rcError.trsmcodi:=inutrsmcodi;

    Load
    (
      inutrsmcodi
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
    inutrsmcodi in LDCI_TRANSOMA.trsmcodi%type
  )
  IS
  BEGIN
    Load
    (
      inutrsmcodi
    );
    Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
    raise ex.CONTROLLED_ERROR;

  EXCEPTION
    when no_data_found then
      null;
  END;

  PROCEDURE getRecord
  (
    inutrsmcodi in LDCI_TRANSOMA.trsmcodi%type,
    orcRecord out nocopy styLDCI_TRANSOMA
  )
  IS
    rcError styLDCI_TRANSOMA;
  BEGIN    rcError.trsmcodi:=inutrsmcodi;

    Load
    (
      inutrsmcodi
    );
    orcRecord := rcData;
  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRecord
  (
    inutrsmcodi in LDCI_TRANSOMA.trsmcodi%type
  )
  RETURN styLDCI_TRANSOMA
  IS
    rcError styLDCI_TRANSOMA;
  BEGIN
    rcError.trsmcodi:=inutrsmcodi;

    Load
    (
      inutrsmcodi
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  (
    inutrsmcodi in LDCI_TRANSOMA.trsmcodi%type
  )
  RETURN styLDCI_TRANSOMA
  IS
    rcError styLDCI_TRANSOMA;
  BEGIN
    rcError.trsmcodi:=inutrsmcodi;
        -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
         inutrsmcodi
       )
    then
       return(rcData);
    end if;
    Load
    (
      inutrsmcodi
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  RETURN styLDCI_TRANSOMA
  IS
  BEGIN
    return(rcData);
  END;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLDCI_TRANSOMA
  )
  IS
    rfLDCI_TRANSOMA tyrfLDCI_TRANSOMA;
    n number(4) := 1;
    sbFullQuery VARCHAR2 (32000) := 'SELECT
                trsmcodi,
                trsmcont,
                trsmprov,
                trsmunop,
                trsmfecr,
                trsmesta,
                trsmofve,
                trsmvtot,
                trsmdore,
                trsmdsre,
                trsmmdpe,
                trsmusmo
                LDCI_TRANSOMA.rowid
                FROM LDCI_TRANSOMA';
    nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
  BEGIN
    otbResult.delete;
    if isbQuery is not NULL and length(isbQuery) > 0 then
      sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
    end if;
    open rfLDCI_TRANSOMA for sbFullQuery;
    fetch rfLDCI_TRANSOMA bulk collect INTO otbResult;
    close rfLDCI_TRANSOMA;
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
                trsmcodi,
                trsmcont,
                trsmprov,
                trsmunop,
                trsmfecr,
                trsmesta,
                trsmofve,
                trsmvtot,
                trsmdore,
                trsmdsre,
                trsmmdpe,
                trsmusmo
                FROM LDCI_TRANSOMA';
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
    ircLDCI_TRANSOMA in styLDCI_TRANSOMA
  )
  IS
    rirowid varchar2(200);
  BEGIN
    insRecord(ircLDCI_TRANSOMA,rirowid);
  END;

  PROCEDURE insRecord
  (
    ircLDCI_TRANSOMA in styLDCI_TRANSOMA,
    orirowid   out varchar2
  )
  IS
  BEGIN
    if ircLDCI_TRANSOMA.trsmcodi is NULL then
      Errors.SetError(cnuINS_PK_NULL,
                      fsbGetMessageDescription||'|trsmcodi');
      raise ex.controlled_error;
    end if;
    insert into LDCI_TRANSOMA
    (
      trsmcodi,
      trsmcont,
      trsmprov,
      trsmunop,
      trsmfecr,
      trsmesta,
      trsmofve,
      trsmvtot,
      trsmdore,
      trsmdsre,
      trsmmdpe,
      trsmusmo
    )
    values
    (
      ircLDCI_TRANSOMA.trsmcodi,
      ircLDCI_TRANSOMA.trsmcont,
      ircLDCI_TRANSOMA.trsmprov,
      ircLDCI_TRANSOMA.trsmunop,
      ircLDCI_TRANSOMA.trsmfecr,
      ircLDCI_TRANSOMA.trsmesta,
      ircLDCI_TRANSOMA.trsmofve,
      ircLDCI_TRANSOMA.trsmvtot,
      ircLDCI_TRANSOMA.trsmdore,
      ircLDCI_TRANSOMA.trsmdsre,
      ircLDCI_TRANSOMA.trsmmdpe,
      ircLDCI_TRANSOMA.trsmusmo
    )
            returning
      rowid
    into
      orirowid;
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDCI_TRANSOMA));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE insRecords
  (
    iotbLDCI_TRANSOMA in out nocopy tytbLDCI_TRANSOMA
  )
  IS
    blUseRowID boolean;
  BEGIN
    FillRecordOfTables(iotbLDCI_TRANSOMA, blUseRowID);
    forall n in iotbLDCI_TRANSOMA.first..iotbLDCI_TRANSOMA.last
      insert into LDCI_TRANSOMA
      (
      trsmcodi,
      trsmcont,
      trsmprov,
      trsmunop,
      trsmfecr,
      trsmesta,
      trsmofve,
      trsmvtot,
      trsmdore,
      trsmdsre,
      trsmmdpe,
      trsmusmo
    )
    values
    (
      rcRecOfTab.trsmcodi(n),
      rcRecOfTab.trsmcont(n),
      rcRecOfTab.trsmprov(n),
      rcRecOfTab.trsmunop(n),
      rcRecOfTab.trsmfecr(n),
      rcRecOfTab.trsmesta(n),
      rcRecOfTab.trsmofve(n),
      rcRecOfTab.trsmvtot(n),
      rcRecOfTab.trsmdore(n),
      rcRecOfTab.trsmdsre(n),
      rcRecOfTab.trsmmdpe(n),
      rcRecOfTab.trsmusmo(n)

      );
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE delRecord
  (
    inutrsmcodi in LDCI_TRANSOMA.trsmcodi%type,
    inuLock in number default 1
  )
  IS
    rcError styLDCI_TRANSOMA;
  BEGIN
    rcError.trsmcodi:=inutrsmcodi;

    if inuLock=1 then
      LockByPk
      (
        inutrsmcodi,
        rcData
      );
    end if;

    delete
    from LDCI_TRANSOMA
    where
           trsmcodi=inutrsmcodi;
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
    rcError  styLDCI_TRANSOMA;
  BEGIN
    if inuLock=1 then
      LockByRowId(iriRowID,rcData);
    end if;

    delete
    from LDCI_TRANSOMA
    where
      rowid = iriRowID
    returning
   trsmcodi
    into
      rcError.trsmcodi;

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
    iotbLDCI_TRANSOMA in out nocopy tytbLDCI_TRANSOMA,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLDCI_TRANSOMA;
  BEGIN
    FillRecordOfTables(iotbLDCI_TRANSOMA, blUseRowID);
       if ( blUseRowId ) then
      if inuLock = 1 then
        for n in iotbLDCI_TRANSOMA.first .. iotbLDCI_TRANSOMA.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLDCI_TRANSOMA.first .. iotbLDCI_TRANSOMA.last
        delete
        from LDCI_TRANSOMA
        where
          rowid = rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLDCI_TRANSOMA.first .. iotbLDCI_TRANSOMA.last loop
          LockByPk
          (
              rcRecOfTab.trsmcodi(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLDCI_TRANSOMA.first .. iotbLDCI_TRANSOMA.last
        delete
        from LDCI_TRANSOMA
        where
               trsmcodi = rcRecOfTab.trsmcodi(n);
    end if;
  EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecord
  (
    ircLDCI_TRANSOMA in styLDCI_TRANSOMA,
    inuLock    in number default 0
  )
  IS
    nutrsmcodi LDCI_TRANSOMA.trsmcodi%type;

  BEGIN
    if ircLDCI_TRANSOMA.rowid is not null then
      if inuLock=1 then
        LockByRowId(ircLDCI_TRANSOMA.rowid,rcData);
      end if;
      update LDCI_TRANSOMA
      set
        trsmcont = ircLDCI_TRANSOMA.trsmcont,
        trsmprov = ircLDCI_TRANSOMA.trsmprov,
        trsmunop = ircLDCI_TRANSOMA.trsmunop,
        trsmfecr = ircLDCI_TRANSOMA.trsmfecr,
        trsmesta = ircLDCI_TRANSOMA.trsmesta,
        trsmofve = ircLDCI_TRANSOMA.trsmofve,
        trsmvtot = ircLDCI_TRANSOMA.trsmvtot,
        trsmdore = ircLDCI_TRANSOMA.trsmdore,
        trsmdsre = ircLDCI_TRANSOMA.trsmdsre,
        trsmmdpe = ircLDCI_TRANSOMA.trsmmdpe,
        trsmusmo = ircLDCI_TRANSOMA.trsmusmo
      where
        rowid = ircLDCI_TRANSOMA.rowid
      returning
    trsmcodi
      into
        nutrsmcodi;

    else
      if inuLock=1 then
        LockByPk
        (
          ircLDCI_TRANSOMA.trsmcodi,
          rcData
        );
      end if;

      update LDCI_TRANSOMA
      set
        trsmcont = ircLDCI_TRANSOMA.trsmcont,
        trsmprov = ircLDCI_TRANSOMA.trsmprov,
        trsmunop = ircLDCI_TRANSOMA.trsmunop,
        trsmfecr = ircLDCI_TRANSOMA.trsmfecr,
        trsmesta = ircLDCI_TRANSOMA.trsmesta,
        trsmofve = ircLDCI_TRANSOMA.trsmofve,
        trsmvtot = ircLDCI_TRANSOMA.trsmvtot,
        trsmdore = ircLDCI_TRANSOMA.trsmdore,
        trsmdsre = ircLDCI_TRANSOMA.trsmdsre,
        trsmmdpe = ircLDCI_TRANSOMA.trsmmdpe,
        trsmusmo = ircLDCI_TRANSOMA.trsmusmo

      where
             trsmcodi = ircLDCI_TRANSOMA.trsmcodi
      returning
    trsmcodi
      into
        nutrsmcodi;
    end if;

    if
      nutrsmcodi is NULL
    then
      raise no_data_found;
    end if;

  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDCI_TRANSOMA));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecords
  (
    iotbLDCI_TRANSOMA in out nocopy tytbLDCI_TRANSOMA,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLDCI_TRANSOMA;
  BEGIN
    FillRecordOfTables(iotbLDCI_TRANSOMA,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLDCI_TRANSOMA.first .. iotbLDCI_TRANSOMA.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLDCI_TRANSOMA.first .. iotbLDCI_TRANSOMA.last
        update LDCI_TRANSOMA
        set
        trsmcont = rcRecOfTab.trsmcont(n),
        trsmprov = rcRecOfTab.trsmprov(n),
        trsmunop = rcRecOfTab.trsmunop(n),
        trsmfecr = rcRecOfTab.trsmfecr(n),
        trsmesta = rcRecOfTab.trsmesta(n),
        trsmofve = rcRecOfTab.trsmofve(n),
        trsmvtot = rcRecOfTab.trsmvtot(n),
        trsmdore = rcRecOfTab.trsmdore(n),
        trsmdsre = rcRecOfTab.trsmdsre(n),
        trsmmdpe = rcRecOfTab.trsmmdpe(n),
        trsmusmo = rcRecOfTab.trsmusmo(n)

          where
          rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLDCI_TRANSOMA.first .. iotbLDCI_TRANSOMA.last loop
          LockByPk
          (
              rcRecOfTab.trsmcodi(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLDCI_TRANSOMA.first .. iotbLDCI_TRANSOMA.last
        update LDCI_TRANSOMA
        set
        trsmcont = rcRecOfTab.trsmcont(n),
        trsmprov = rcRecOfTab.trsmprov(n),
        trsmunop = rcRecOfTab.trsmunop(n),
        trsmfecr = rcRecOfTab.trsmfecr(n),
        trsmesta = rcRecOfTab.trsmesta(n),
        trsmofve = rcRecOfTab.trsmofve(n),
        trsmvtot = rcRecOfTab.trsmvtot(n),
        trsmdore = rcRecOfTab.trsmdore(n),
        trsmdsre = rcRecOfTab.trsmdsre(n),
        trsmmdpe = rcRecOfTab.trsmmdpe(n),
        trsmusmo = rcRecOfTab.trsmusmo(n)
          where
          trsmcodi = rcRecOfTab.trsmcodi(n)
;
    end if;
  END;


  FUNCTION fnuGettrsmcodi
  (
    inutrsmcodi in LDCI_TRANSOMA.trsmcodi%type,
    inuRaiseError in number default 1
  )
    RETURN LDCI_TRANSOMA.trsmcodi%type
  IS
    rcError styLDCI_TRANSOMA;
  BEGIN

    rcError.trsmcodi := inutrsmcodi;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inutrsmcodi
       )
    then
       return(rcData.trsmcodi);
    end if;
    Load
    (
      inutrsmcodi
    );
    return(rcData.trsmcodi);
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
end DALDCI_TRANSOMA;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALDCI_TRANSOMA
BEGIN
    pkg_utilidades.prAplicarPermisos('DALDCI_TRANSOMA', 'ADM_PERSON'); 
END;
/  