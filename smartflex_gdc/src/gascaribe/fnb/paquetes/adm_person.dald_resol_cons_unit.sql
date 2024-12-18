CREATE OR REPLACE PACKAGE adm_person.DALD_resol_cons_unit
is
/***************************************************************
Propiedad intelectual de Sincecomp Ltda.

Unidad	     : DALD_resol_cons_unit
Descripcion	 : Paquete para la gestión de la entidad LD_resol_cons_unit (Resolución CREG por Unidades Constructivas)

Parametro	    Descripcion
============	==============================

Historia de Modificaciones
Fecha   	           Autor            Modificacion
====================   =========        ====================
DD-MM-YYYY             Autor<SAO156931>   <Descripcion de la Modificacion>
07/06/2024              PAcosta         OSF-2812: Cambio de esquema ADM_PERSON   
****************************************************************/

  /* Cursor general para acceso por Llave Primaria */
  CURSOR cuRecord
  (
    inuResol_Cons_Unit_Id in LD_resol_cons_unit.Resol_Cons_Unit_Id%type
  )
  IS
    SELECT LD_resol_cons_unit.*,LD_resol_cons_unit.rowid
    FROM LD_resol_cons_unit
    WHERE
      Resol_Cons_Unit_Id = inuResol_Cons_Unit_Id;


  /* Cursor general para acceso por RowId */
  CURSOR cuRecordByRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_resol_cons_unit.*,LD_resol_cons_unit.rowid
    FROM LD_resol_cons_unit
    WHERE
      rowId = irirowid;


  /* Subtipos */
  subtype styLD_resol_cons_unit  is  cuRecord%rowtype;
  type tyRefCursor is  REF CURSOR;

  /*Tipos*/
  type tytbLD_resol_cons_unit is table of styLD_resol_cons_unit index by binary_integer;
  type tyrfRecords is ref cursor return styLD_resol_cons_unit;

  /* Tipos referenciando al registro */
  type tytbResol_Cons_Unit_Id is table of LD_resol_cons_unit.Resol_Cons_Unit_Id%type index by binary_integer;
  type tytbCreg_Resolution_Id is table of LD_resol_cons_unit.Creg_Resolution_Id%type index by binary_integer;
  type tytbConstruct_Unit_Id is table of LD_resol_cons_unit.Construct_Unit_Id%type index by binary_integer;
  type tytbMeasuring_Unit is table of LD_resol_cons_unit.Measuring_Unit%type index by binary_integer;
  type tytbCost_Unit is table of LD_resol_cons_unit.Cost_Unit%type index by binary_integer;
  type tytbrowid is table of rowid index by binary_integer;

  type tyrcLD_resol_cons_unit is record
  (

    Resol_Cons_Unit_Id   tytbResol_Cons_Unit_Id,
    Creg_Resolution_Id   tytbCreg_Resolution_Id,
    Construct_Unit_Id   tytbConstruct_Unit_Id,
    Measuring_Unit   tytbMeasuring_Unit,
    Cost_Unit   tytbCost_Unit,
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
    inuResol_Cons_Unit_Id in LD_resol_cons_unit.Resol_Cons_Unit_Id%type
  )
  RETURN boolean;

   PROCEDURE AccKey
   (
     inuResol_Cons_Unit_Id in LD_resol_cons_unit.Resol_Cons_Unit_Id%type
  );

  PROCEDURE AccKeyByRowId
  (
    iriRowID    in rowid
  );

  PROCEDURE ValDuplicate
  (
     inuResol_Cons_Unit_Id in LD_resol_cons_unit.Resol_Cons_Unit_Id%type
  );

  PROCEDURE getRecord
  (
    inuResol_Cons_Unit_Id in LD_resol_cons_unit.Resol_Cons_Unit_Id%type,
    orcRecord out nocopy styLD_resol_cons_unit
  );

  FUNCTION frcGetRcData
  (
    inuResol_Cons_Unit_Id in LD_resol_cons_unit.Resol_Cons_Unit_Id%type
  )
  RETURN styLD_resol_cons_unit;

  FUNCTION frcGetRcData
  RETURN styLD_resol_cons_unit;

  FUNCTION frcGetRecord
  (
    inuResol_Cons_Unit_Id in LD_resol_cons_unit.Resol_Cons_Unit_Id%type
  )
  RETURN styLD_resol_cons_unit;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_resol_cons_unit
  );

  FUNCTION frfGetRecords
  (
    isbCriteria in varchar2 default null,
    iblLock in boolean default false
  )
  RETURN tyRefCursor;

  PROCEDURE insRecord
  (
    ircLD_resol_cons_unit in styLD_resol_cons_unit
  );

     PROCEDURE insRecord
  (
    ircLD_resol_cons_unit in styLD_resol_cons_unit,
    orirowid   out varchar2
  );

  PROCEDURE insRecords
  (
    iotbLD_resol_cons_unit in out nocopy tytbLD_resol_cons_unit
  );

  PROCEDURE delRecord
  (
    inuResol_Cons_Unit_Id in LD_resol_cons_unit.Resol_Cons_Unit_Id%type,
    inuLock in number default 1
  );

  PROCEDURE delByRowID
  (
    iriRowID    in rowid,
    inuLock in number default 1
  );

  PROCEDURE delRecords
  (
    iotbLD_resol_cons_unit in out nocopy tytbLD_resol_cons_unit,
    inuLock in number default 1
  );

  PROCEDURE updRecord
  (
    ircLD_resol_cons_unit in styLD_resol_cons_unit,
    inuLock    in number default 0
  );

  PROCEDURE updRecords
  (
    iotbLD_resol_cons_unit in out nocopy tytbLD_resol_cons_unit,
    inuLock in number default 1
  );

    PROCEDURE updCreg_Resolution_Id
    (
        inuResol_Cons_Unit_Id   in LD_resol_cons_unit.Resol_Cons_Unit_Id%type,
        inuCreg_Resolution_Id$  in LD_resol_cons_unit.Creg_Resolution_Id%type,
        inuLock    in number default 0
      );

    PROCEDURE updConstruct_Unit_Id
    (
        inuResol_Cons_Unit_Id   in LD_resol_cons_unit.Resol_Cons_Unit_Id%type,
        inuConstruct_Unit_Id$  in LD_resol_cons_unit.Construct_Unit_Id%type,
        inuLock    in number default 0
      );

    PROCEDURE updMeasuring_Unit
    (
        inuResol_Cons_Unit_Id   in LD_resol_cons_unit.Resol_Cons_Unit_Id%type,
        isbMeasuring_Unit$  in LD_resol_cons_unit.Measuring_Unit%type,
        inuLock    in number default 0
      );

    PROCEDURE updCost_Unit
    (
        inuResol_Cons_Unit_Id   in LD_resol_cons_unit.Resol_Cons_Unit_Id%type,
        inuCost_Unit$  in LD_resol_cons_unit.Cost_Unit%type,
        inuLock    in number default 0
      );

      FUNCTION fnuGetResol_Cons_Unit_Id
      (
          inuResol_Cons_Unit_Id in LD_resol_cons_unit.Resol_Cons_Unit_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_resol_cons_unit.Resol_Cons_Unit_Id%type;

      FUNCTION fnuGetCreg_Resolution_Id
      (
          inuResol_Cons_Unit_Id in LD_resol_cons_unit.Resol_Cons_Unit_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_resol_cons_unit.Creg_Resolution_Id%type;

      FUNCTION fnuGetConstruct_Unit_Id
      (
          inuResol_Cons_Unit_Id in LD_resol_cons_unit.Resol_Cons_Unit_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_resol_cons_unit.Construct_Unit_Id%type;

      FUNCTION fsbGetMeasuring_Unit
      (
          inuResol_Cons_Unit_Id in LD_resol_cons_unit.Resol_Cons_Unit_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_resol_cons_unit.Measuring_Unit%type;

      FUNCTION fnuGetCost_Unit
      (
          inuResol_Cons_Unit_Id in LD_resol_cons_unit.Resol_Cons_Unit_Id%type,
          inuRaiseError in number default 1
      )
      RETURN LD_resol_cons_unit.Cost_Unit%type;


  PROCEDURE LockByPk
  (
    inuResol_Cons_Unit_Id in LD_resol_cons_unit.Resol_Cons_Unit_Id%type,
    orcLD_resol_cons_unit  out styLD_resol_cons_unit
  );

  PROCEDURE LockByRowID
  (
    irirowid    in  varchar2,
    orcLD_resol_cons_unit  out styLD_resol_cons_unit
  );

  PROCEDURE SetUseCache
  (
    iblUseCache    in  boolean
  );
END DALD_resol_cons_unit;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_resol_cons_unit
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO156931';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_RESOL_CONS_UNIT';
    cnuGeEntityId constant varchar2(30) := 8336; -- Id de Ge_entity

  /* Cursor para bloqueo de un registro por llave primaria */
  CURSOR cuLockRcByPk
  (
    inuResol_Cons_Unit_Id in LD_resol_cons_unit.Resol_Cons_Unit_Id%type
  )
  IS
    SELECT LD_resol_cons_unit.*,LD_resol_cons_unit.rowid
    FROM LD_resol_cons_unit
    WHERE  Resol_Cons_Unit_Id = inuResol_Cons_Unit_Id
    FOR UPDATE NOWAIT;

  /* Cursor para bloqueo de un registro por rowid */
  CURSOR cuLockRcbyRowId
  (
    irirowid in varchar2
  )
  IS
    SELECT LD_resol_cons_unit.*,LD_resol_cons_unit.rowid
    FROM LD_resol_cons_unit
    WHERE
      rowId = irirowid
    FOR UPDATE NOWAIT;
  /*Tipos*/
  type tyrfLD_resol_cons_unit is ref cursor;

  /*Variables Globales*/
  rcRecOfTab tyrcLD_resol_cons_unit;

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

  FUNCTION fsbPrimaryKey( rcI in styLD_resol_cons_unit default rcData )
  return varchar2
  IS
    sbPk varchar2(500);
  BEGIN
    sbPk:='[';
    sbPk:=sbPk||ut_convert.fsbToChar(rcI.Resol_Cons_Unit_Id);
    sbPk:=sbPk||']';
    return sbPk;
  END;

  PROCEDURE LockByPk
  (
    inuResol_Cons_Unit_Id in LD_resol_cons_unit.Resol_Cons_Unit_Id%type,
    orcLD_resol_cons_unit  out styLD_resol_cons_unit
  )
  IS
    rcError styLD_resol_cons_unit;
  BEGIN
    rcError.Resol_Cons_Unit_Id := inuResol_Cons_Unit_Id;

    Open cuLockRcByPk
    (
      inuResol_Cons_Unit_Id
    );

    fetch cuLockRcByPk into orcLD_resol_cons_unit;
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
    orcLD_resol_cons_unit  out styLD_resol_cons_unit
  )
  IS
  BEGIN
    Open cuLockRcbyRowId
    (
      irirowid
    );

    fetch cuLockRcbyRowId into orcLD_resol_cons_unit;
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
    itbLD_resol_cons_unit  in out nocopy tytbLD_resol_cons_unit
  )
  IS
  BEGIN
      rcRecOfTab.Resol_Cons_Unit_Id.delete;
      rcRecOfTab.Creg_Resolution_Id.delete;
      rcRecOfTab.Construct_Unit_Id.delete;
      rcRecOfTab.Measuring_Unit.delete;
      rcRecOfTab.Cost_Unit.delete;
      rcRecOfTab.row_id.delete;
  END;
  PROCEDURE FillRecordOfTables
  (
    itbLD_resol_cons_unit  in out nocopy tytbLD_resol_cons_unit,
    oblUseRowId out boolean
  )
  IS
  BEGIN
    DelRecordOfTables(itbLD_resol_cons_unit);
    for n in itbLD_resol_cons_unit.first .. itbLD_resol_cons_unit.last loop
      rcRecOfTab.Resol_Cons_Unit_Id(n) := itbLD_resol_cons_unit(n).Resol_Cons_Unit_Id;
      rcRecOfTab.Creg_Resolution_Id(n) := itbLD_resol_cons_unit(n).Creg_Resolution_Id;
      rcRecOfTab.Construct_Unit_Id(n) := itbLD_resol_cons_unit(n).Construct_Unit_Id;
      rcRecOfTab.Measuring_Unit(n) := itbLD_resol_cons_unit(n).Measuring_Unit;
      rcRecOfTab.Cost_Unit(n) := itbLD_resol_cons_unit(n).Cost_Unit;
      rcRecOfTab.row_id(n) := itbLD_resol_cons_unit(n).rowid;
      -- Indica si el rowid es Nulo
      oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
    end loop;
  END;


  PROCEDURE Load
  (
    inuResol_Cons_Unit_Id in LD_resol_cons_unit.Resol_Cons_Unit_Id%type
  )
  IS
    rcRecordNull cuRecord%rowtype;
  BEGIN
    if cuRecord%isopen then
      close cuRecord;
    end if;
    open cuRecord
    (
      inuResol_Cons_Unit_Id
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
    inuResol_Cons_Unit_Id in LD_resol_cons_unit.Resol_Cons_Unit_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    if (
      inuResol_Cons_Unit_Id = rcData.Resol_Cons_Unit_Id
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
    inuResol_Cons_Unit_Id in LD_resol_cons_unit.Resol_Cons_Unit_Id%type
  )
  RETURN boolean
  IS
  BEGIN
    Load
    (
      inuResol_Cons_Unit_Id
    );
    return(TRUE);
  EXCEPTION
    when no_data_found then
      return(FALSE);
  END;

  PROCEDURE AccKey
  (
    inuResol_Cons_Unit_Id in LD_resol_cons_unit.Resol_Cons_Unit_Id%type
  )
  IS
    rcError styLD_resol_cons_unit;
  BEGIN    rcError.Resol_Cons_Unit_Id:=inuResol_Cons_Unit_Id;

    Load
    (
      inuResol_Cons_Unit_Id
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
    inuResol_Cons_Unit_Id in LD_resol_cons_unit.Resol_Cons_Unit_Id%type
  )
  IS
  BEGIN
    Load
    (
      inuResol_Cons_Unit_Id
    );
    Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
    raise ex.CONTROLLED_ERROR;

  EXCEPTION
    when no_data_found then
      null;
  END;

  PROCEDURE getRecord
  (
    inuResol_Cons_Unit_Id in LD_resol_cons_unit.Resol_Cons_Unit_Id%type,
    orcRecord out nocopy styLD_resol_cons_unit
  )
  IS
    rcError styLD_resol_cons_unit;
  BEGIN    rcError.Resol_Cons_Unit_Id:=inuResol_Cons_Unit_Id;

    Load
    (
      inuResol_Cons_Unit_Id
    );
    orcRecord := rcData;
  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRecord
  (
    inuResol_Cons_Unit_Id in LD_resol_cons_unit.Resol_Cons_Unit_Id%type
  )
  RETURN styLD_resol_cons_unit
  IS
    rcError styLD_resol_cons_unit;
  BEGIN
    rcError.Resol_Cons_Unit_Id:=inuResol_Cons_Unit_Id;

    Load
    (
      inuResol_Cons_Unit_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  (
    inuResol_Cons_Unit_Id in LD_resol_cons_unit.Resol_Cons_Unit_Id%type
  )
  RETURN styLD_resol_cons_unit
  IS
    rcError styLD_resol_cons_unit;
  BEGIN
    rcError.Resol_Cons_Unit_Id:=inuResol_Cons_Unit_Id;
        -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
         inuResol_Cons_Unit_Id
       )
    then
       return(rcData);
    end if;
    Load
    (
      inuResol_Cons_Unit_Id
    );
    return(rcData);
  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  FUNCTION frcGetRcData
  RETURN styLD_resol_cons_unit
  IS
  BEGIN
    return(rcData);
  END;

  PROCEDURE getRecords
  (
    isbQuery in varchar2,
    otbResult out nocopy tytbLD_resol_cons_unit
  )
  IS
    rfLD_resol_cons_unit tyrfLD_resol_cons_unit;
    n number(4) := 1;
    sbFullQuery VARCHAR2 (32000) := 'SELECT
                LD_resol_cons_unit.Resol_Cons_Unit_Id,
                LD_resol_cons_unit.Creg_Resolution_Id,
                LD_resol_cons_unit.Construct_Unit_Id,
                LD_resol_cons_unit.Measuring_Unit,
                LD_resol_cons_unit.Cost_Unit,
                LD_resol_cons_unit.rowid
                FROM LD_resol_cons_unit';
    nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
  BEGIN
    otbResult.delete;
    if isbQuery is not NULL and length(isbQuery) > 0 then
      sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
    end if;
    open rfLD_resol_cons_unit for sbFullQuery;
    fetch rfLD_resol_cons_unit bulk collect INTO otbResult;
    close rfLD_resol_cons_unit;
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
                LD_resol_cons_unit.Resol_Cons_Unit_Id,
                LD_resol_cons_unit.Creg_Resolution_Id,
                LD_resol_cons_unit.Construct_Unit_Id,
                LD_resol_cons_unit.Measuring_Unit,
                LD_resol_cons_unit.Cost_Unit,
                LD_resol_cons_unit.rowid
                FROM LD_resol_cons_unit';
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
    ircLD_resol_cons_unit in styLD_resol_cons_unit
  )
  IS
    rirowid varchar2(200);
  BEGIN
    insRecord(ircLD_resol_cons_unit,rirowid);
  END;

  PROCEDURE insRecord
  (
    ircLD_resol_cons_unit in styLD_resol_cons_unit,
    orirowid   out varchar2
  )
  IS
  BEGIN
    if ircLD_resol_cons_unit.Resol_Cons_Unit_Id is NULL then
      Errors.SetError(cnuINS_PK_NULL,
                      fsbGetMessageDescription||'|Resol_Cons_Unit_Id');
      raise ex.controlled_error;
    end if;
    insert into LD_resol_cons_unit
    (
      Resol_Cons_Unit_Id,
      Creg_Resolution_Id,
      Construct_Unit_Id,
      Measuring_Unit,
      Cost_Unit
    )
    values
    (
      ircLD_resol_cons_unit.Resol_Cons_Unit_Id,
      ircLD_resol_cons_unit.Creg_Resolution_Id,
      ircLD_resol_cons_unit.Construct_Unit_Id,
      ircLD_resol_cons_unit.Measuring_Unit,
      ircLD_resol_cons_unit.Cost_Unit
    )
            returning
      rowid
    into
      orirowid;
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_resol_cons_unit));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE insRecords
  (
    iotbLD_resol_cons_unit in out nocopy tytbLD_resol_cons_unit
  )
  IS
    blUseRowID boolean;
  BEGIN
    FillRecordOfTables(iotbLD_resol_cons_unit, blUseRowID);
    forall n in iotbLD_resol_cons_unit.first..iotbLD_resol_cons_unit.last
      insert into LD_resol_cons_unit
      (
      Resol_Cons_Unit_Id,
      Creg_Resolution_Id,
      Construct_Unit_Id,
      Measuring_Unit,
      Cost_Unit
    )
    values
    (
      rcRecOfTab.Resol_Cons_Unit_Id(n),
      rcRecOfTab.Creg_Resolution_Id(n),
      rcRecOfTab.Construct_Unit_Id(n),
      rcRecOfTab.Measuring_Unit(n),
      rcRecOfTab.Cost_Unit(n)
      );
  EXCEPTION
    when dup_val_on_index then
            Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE delRecord
  (
    inuResol_Cons_Unit_Id in LD_resol_cons_unit.Resol_Cons_Unit_Id%type,
    inuLock in number default 1
  )
  IS
    rcError styLD_resol_cons_unit;
  BEGIN
    rcError.Resol_Cons_Unit_Id:=inuResol_Cons_Unit_Id;

    if inuLock=1 then
      LockByPk
      (
        inuResol_Cons_Unit_Id,
        rcData
      );
    end if;

    delete
    from LD_resol_cons_unit
    where
           Resol_Cons_Unit_Id=inuResol_Cons_Unit_Id;
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
    rcError  styLD_resol_cons_unit;
  BEGIN
    if inuLock=1 then
      LockByRowId(iriRowID,rcData);
    end if;

    delete
    from LD_resol_cons_unit
    where
      rowid = iriRowID
    returning
   Resol_Cons_Unit_Id
    into
      rcError.Resol_Cons_Unit_Id;

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
    iotbLD_resol_cons_unit in out nocopy tytbLD_resol_cons_unit,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_resol_cons_unit;
  BEGIN
    FillRecordOfTables(iotbLD_resol_cons_unit, blUseRowID);
       if ( blUseRowId ) then
      if inuLock = 1 then
        for n in iotbLD_resol_cons_unit.first .. iotbLD_resol_cons_unit.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_resol_cons_unit.first .. iotbLD_resol_cons_unit.last
        delete
        from LD_resol_cons_unit
        where
          rowid = rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_resol_cons_unit.first .. iotbLD_resol_cons_unit.last loop
          LockByPk
          (
              rcRecOfTab.Resol_Cons_Unit_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_resol_cons_unit.first .. iotbLD_resol_cons_unit.last
        delete
        from LD_resol_cons_unit
        where
               Resol_Cons_Unit_Id = rcRecOfTab.Resol_Cons_Unit_Id(n);
    end if;
  EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecord
  (
    ircLD_resol_cons_unit in styLD_resol_cons_unit,
    inuLock    in number default 0
  )
  IS
    nuResol_Cons_Unit_Id LD_resol_cons_unit.Resol_Cons_Unit_Id%type;

  BEGIN
    if ircLD_resol_cons_unit.rowid is not null then
      if inuLock=1 then
        LockByRowId(ircLD_resol_cons_unit.rowid,rcData);
      end if;
      update LD_resol_cons_unit
      set

        Creg_Resolution_Id = ircLD_resol_cons_unit.Creg_Resolution_Id,
        Construct_Unit_Id = ircLD_resol_cons_unit.Construct_Unit_Id,
        Measuring_Unit = ircLD_resol_cons_unit.Measuring_Unit,
        Cost_Unit = ircLD_resol_cons_unit.Cost_Unit
      where
        rowid = ircLD_resol_cons_unit.rowid
      returning
    Resol_Cons_Unit_Id
      into
        nuResol_Cons_Unit_Id;

    else
      if inuLock=1 then
        LockByPk
        (
          ircLD_resol_cons_unit.Resol_Cons_Unit_Id,
          rcData
        );
      end if;

      update LD_resol_cons_unit
      set
        Creg_Resolution_Id = ircLD_resol_cons_unit.Creg_Resolution_Id,
        Construct_Unit_Id = ircLD_resol_cons_unit.Construct_Unit_Id,
        Measuring_Unit = ircLD_resol_cons_unit.Measuring_Unit,
        Cost_Unit = ircLD_resol_cons_unit.Cost_Unit
      where
             Resol_Cons_Unit_Id = ircLD_resol_cons_unit.Resol_Cons_Unit_Id
      returning
    Resol_Cons_Unit_Id
      into
        nuResol_Cons_Unit_Id;
    end if;

    if
      nuResol_Cons_Unit_Id is NULL
    then
      raise no_data_found;
    end if;

  EXCEPTION
    when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_resol_cons_unit));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updRecords
  (
    iotbLD_resol_cons_unit in out nocopy tytbLD_resol_cons_unit,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_resol_cons_unit;
  BEGIN
    FillRecordOfTables(iotbLD_resol_cons_unit,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_resol_cons_unit.first .. iotbLD_resol_cons_unit.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_resol_cons_unit.first .. iotbLD_resol_cons_unit.last
        update LD_resol_cons_unit
        set

            Creg_Resolution_Id = rcRecOfTab.Creg_Resolution_Id(n),
            Construct_Unit_Id = rcRecOfTab.Construct_Unit_Id(n),
            Measuring_Unit = rcRecOfTab.Measuring_Unit(n),
            Cost_Unit = rcRecOfTab.Cost_Unit(n)
          where
          rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_resol_cons_unit.first .. iotbLD_resol_cons_unit.last loop
          LockByPk
          (
              rcRecOfTab.Resol_Cons_Unit_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_resol_cons_unit.first .. iotbLD_resol_cons_unit.last
        update LD_resol_cons_unit
        set
          Creg_Resolution_Id = rcRecOfTab.Creg_Resolution_Id(n),
          Construct_Unit_Id = rcRecOfTab.Construct_Unit_Id(n),
          Measuring_Unit = rcRecOfTab.Measuring_Unit(n),
          Cost_Unit = rcRecOfTab.Cost_Unit(n)
          where
          Resol_Cons_Unit_Id = rcRecOfTab.Resol_Cons_Unit_Id(n)
;
    end if;
  END;

  PROCEDURE updCreg_Resolution_Id
  (
    inuResol_Cons_Unit_Id in LD_resol_cons_unit.Resol_Cons_Unit_Id%type,
    inuCreg_Resolution_Id$ in LD_resol_cons_unit.Creg_Resolution_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_resol_cons_unit;
  BEGIN
    rcError.Resol_Cons_Unit_Id := inuResol_Cons_Unit_Id;
    if inuLock=1 then
      LockByPk
      (
        inuResol_Cons_Unit_Id,
        rcData
      );
    end if;

    update LD_resol_cons_unit
    set
      Creg_Resolution_Id = inuCreg_Resolution_Id$
    where
      Resol_Cons_Unit_Id = inuResol_Cons_Unit_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Creg_Resolution_Id:= inuCreg_Resolution_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updConstruct_Unit_Id
  (
    inuResol_Cons_Unit_Id in LD_resol_cons_unit.Resol_Cons_Unit_Id%type,
    inuConstruct_Unit_Id$ in LD_resol_cons_unit.Construct_Unit_Id%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_resol_cons_unit;
  BEGIN
    rcError.Resol_Cons_Unit_Id := inuResol_Cons_Unit_Id;
    if inuLock=1 then
      LockByPk
      (
        inuResol_Cons_Unit_Id,
        rcData
      );
    end if;

    update LD_resol_cons_unit
    set
      Construct_Unit_Id = inuConstruct_Unit_Id$
    where
      Resol_Cons_Unit_Id = inuResol_Cons_Unit_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Construct_Unit_Id:= inuConstruct_Unit_Id$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updMeasuring_Unit
  (
    inuResol_Cons_Unit_Id in LD_resol_cons_unit.Resol_Cons_Unit_Id%type,
    isbMeasuring_Unit$ in LD_resol_cons_unit.Measuring_Unit%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_resol_cons_unit;
  BEGIN
    rcError.Resol_Cons_Unit_Id := inuResol_Cons_Unit_Id;
    if inuLock=1 then
      LockByPk
      (
        inuResol_Cons_Unit_Id,
        rcData
      );
    end if;

    update LD_resol_cons_unit
    set
      Measuring_Unit = isbMeasuring_Unit$
    where
      Resol_Cons_Unit_Id = inuResol_Cons_Unit_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Measuring_Unit:= isbMeasuring_Unit$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;

  PROCEDURE updCost_Unit
  (
    inuResol_Cons_Unit_Id in LD_resol_cons_unit.Resol_Cons_Unit_Id%type,
    inuCost_Unit$ in LD_resol_cons_unit.Cost_Unit%type,
    inuLock in number default 0
  )
  IS
    rcError styLD_resol_cons_unit;
  BEGIN
    rcError.Resol_Cons_Unit_Id := inuResol_Cons_Unit_Id;
    if inuLock=1 then
      LockByPk
      (
        inuResol_Cons_Unit_Id,
        rcData
      );
    end if;

    update LD_resol_cons_unit
    set
      Cost_Unit = inuCost_Unit$
    where
      Resol_Cons_Unit_Id = inuResol_Cons_Unit_Id;

    if sql%notfound then
      raise no_data_found;
    end if;

    rcData.Cost_Unit:= inuCost_Unit$;

  EXCEPTION
    when no_data_found then
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      raise ex.CONTROLLED_ERROR;
  END;


  FUNCTION fnuGetResol_Cons_Unit_Id
  (
    inuResol_Cons_Unit_Id in LD_resol_cons_unit.Resol_Cons_Unit_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_resol_cons_unit.Resol_Cons_Unit_Id%type
  IS
    rcError styLD_resol_cons_unit;
  BEGIN

    rcError.Resol_Cons_Unit_Id := inuResol_Cons_Unit_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuResol_Cons_Unit_Id
       )
    then
       return(rcData.Resol_Cons_Unit_Id);
    end if;
    Load
    (
      inuResol_Cons_Unit_Id
    );
    return(rcData.Resol_Cons_Unit_Id);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetCreg_Resolution_Id
  (
    inuResol_Cons_Unit_Id in LD_resol_cons_unit.Resol_Cons_Unit_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_resol_cons_unit.Creg_Resolution_Id%type
  IS
    rcError styLD_resol_cons_unit;
  BEGIN

    rcError.Resol_Cons_Unit_Id := inuResol_Cons_Unit_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuResol_Cons_Unit_Id
       )
    then
       return(rcData.Creg_Resolution_Id);
    end if;
    Load
    (
      inuResol_Cons_Unit_Id
    );
    return(rcData.Creg_Resolution_Id);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetConstruct_Unit_Id
  (
    inuResol_Cons_Unit_Id in LD_resol_cons_unit.Resol_Cons_Unit_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_resol_cons_unit.Construct_Unit_Id%type
  IS
    rcError styLD_resol_cons_unit;
  BEGIN

    rcError.Resol_Cons_Unit_Id := inuResol_Cons_Unit_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuResol_Cons_Unit_Id
       )
    then
       return(rcData.Construct_Unit_Id);
    end if;
    Load
    (
      inuResol_Cons_Unit_Id
    );
    return(rcData.Construct_Unit_Id);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fsbGetMeasuring_Unit
  (
    inuResol_Cons_Unit_Id in LD_resol_cons_unit.Resol_Cons_Unit_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_resol_cons_unit.Measuring_Unit%type
  IS
    rcError styLD_resol_cons_unit;
  BEGIN

    rcError.Resol_Cons_Unit_Id:=inuResol_Cons_Unit_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuResol_Cons_Unit_Id
       )
    then
       return(rcData.Measuring_Unit);
    end if;
    Load
    (
      inuResol_Cons_Unit_Id
    );
    return(rcData.Measuring_Unit);
  EXCEPTION
    when no_data_found then
      if inuRaiseError = 1 then
        Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  END;

  FUNCTION fnuGetCost_Unit
  (
    inuResol_Cons_Unit_Id in LD_resol_cons_unit.Resol_Cons_Unit_Id%type,
    inuRaiseError in number default 1
  )
    RETURN LD_resol_cons_unit.Cost_Unit%type
  IS
    rcError styLD_resol_cons_unit;
  BEGIN

    rcError.Resol_Cons_Unit_Id := inuResol_Cons_Unit_Id;

    -- si usa cache y esta cargado retorna
    if  blDAO_USE_CACHE AND fblAlreadyLoaded
       (
        inuResol_Cons_Unit_Id
       )
    then
       return(rcData.Cost_Unit);
    end if;
    Load
    (
      inuResol_Cons_Unit_Id
    );
    return(rcData.Cost_Unit);
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
end DALD_resol_cons_unit;
/
PROMPT Otorgando permisos de ejecucion a DALD_RESOL_CONS_UNIT
BEGIN
    pkg_utilidades.praplicarpermisos('DALD_RESOL_CONS_UNIT', 'ADM_PERSON');
END;
/