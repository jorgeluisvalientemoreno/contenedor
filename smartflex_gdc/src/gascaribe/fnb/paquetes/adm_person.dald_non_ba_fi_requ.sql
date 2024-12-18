CREATE OR REPLACE PACKAGE adm_person.DALD_non_ba_fi_requ IS
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
  CURSOR cuRecord(
		inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type) IS
		SELECT LD_non_ba_fi_requ.*,LD_non_ba_fi_requ.rowid
		FROM LD_non_ba_fi_requ
		WHERE
			NON_BA_FI_REQU_Id = inuNON_BA_FI_REQU_Id;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId(
		irirowid in varchar2) IS
		SELECT LD_non_ba_fi_requ.*,LD_non_ba_fi_requ.rowid
		FROM LD_non_ba_fi_requ
		WHERE rowId = irirowid;


	/* Subtipos */
	subtype styLD_non_ba_fi_requ  is  cuRecord%rowtype;
	type tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_non_ba_fi_requ is table of styLD_non_ba_fi_requ index by binary_integer;
	type tyrfRecords is ref cursor return styLD_non_ba_fi_requ;

	/* Tipos referenciando al registro */
	type tytbNon_Ba_Fi_Requ_Id is table of LD_non_ba_fi_requ.Non_Ba_Fi_Requ_Id%type index by binary_integer;
	type tytbFirst_Bill_Id is table of LD_non_ba_fi_requ.First_Bill_Id%type index by binary_integer;
	type tytbSecond_Bill_Id is table of LD_non_ba_fi_requ.Second_Bill_Id%type index by binary_integer;
	type tytbCredit_Quota is table of LD_non_ba_fi_requ.Credit_Quota%type index by binary_integer;
	type tytbUsed_Quote is table of LD_non_ba_fi_requ.Used_Quote%type index by binary_integer;
	type tytbUsed_Extra_Quote is table of LD_non_ba_fi_requ.Used_Extra_Quote%type index by binary_integer;
	type tytbManual_Quota_Used is table of LD_non_ba_fi_requ.Manual_Quota_Used%type index by binary_integer;
	type tytbTake_Grace_Period is table of LD_non_ba_fi_requ.Take_Grace_Period%type index by binary_integer;
	type tytbDelivery_Point is table of LD_non_ba_fi_requ.Delivery_Point%type index by binary_integer;
	type tytbPayment is table of LD_non_ba_fi_requ.Payment%type index by binary_integer;
	type tytbTrasfer_Quota is table of LD_non_ba_fi_requ.Trasfer_Quota%type index by binary_integer;
	type tytbSale_Date is table of LD_non_ba_fi_requ.Sale_Date%type index by binary_integer;
	type tytbDigital_Prom_Note_Cons is table of LD_non_ba_fi_requ.Digital_Prom_Note_Cons%type index by binary_integer;
	type tytbManual_Prom_Note_Cons is table of LD_non_ba_fi_requ.Manual_Prom_Note_Cons%type index by binary_integer;
	type tytbSales_Status is table of LD_non_ba_fi_requ.Sales_Status%type index by binary_integer;
	type tytbQuota_Aprox_Month is table of LD_non_ba_fi_requ.Quota_Aprox_Month%type index by binary_integer;
	type tytbValue_Aprox_Insurance is table of LD_non_ba_fi_requ.Value_Aprox_Insurance%type index by binary_integer;
	type tytbValue_Total is table of LD_non_ba_fi_requ.Value_Total%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_non_ba_fi_requ is record(

		Non_Ba_Fi_Requ_Id   tytbNon_Ba_Fi_Requ_Id,
		First_Bill_Id   tytbFirst_Bill_Id,
		Second_Bill_Id   tytbSecond_Bill_Id,
		Credit_Quota   tytbCredit_Quota,
		Used_Quote   tytbUsed_Quote,
		Used_Extra_Quote   tytbUsed_Extra_Quote,
		Manual_Quota_Used   tytbManual_Quota_Used,
		Take_Grace_Period   tytbTake_Grace_Period,
		Delivery_Point   tytbDelivery_Point,
		Payment   tytbPayment,
		Trasfer_Quota   tytbTrasfer_Quota,
		Sale_Date   tytbSale_Date,
		Digital_Prom_Note_Cons   tytbDigital_Prom_Note_Cons,
		Manual_Prom_Note_Cons   tytbManual_Prom_Note_Cons,
		Sales_Status   tytbSales_Status,
		Quota_Aprox_Month   tytbQuota_Aprox_Month,
		Value_Aprox_Insurance   tytbValue_Aprox_Insurance,
		Value_Total   tytbValue_Total,
		row_id tytbrowid);


	 /***** Metodos Publicos ****/
	/*Obtener el ID de la tabla en Ge_Entity*/
	FUNCTION fnuGetEntityIdByName(isbTName IN ge_entity.name_%TYPE)
	   RETURN ge_entity.entity_id%TYPE;
    FUNCTION fsbVersion RETURN varchar2;

	FUNCTION fsbGetMessageDescription return varchar2;

	PROCEDURE ClearMemory;

   FUNCTION fblExist(
		inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type) RETURN boolean;

	 PROCEDURE AccKey(
		 inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type);

	PROCEDURE AccKeyByRowId(
		iriRowID    in rowid);

	PROCEDURE ValDuplicate(
		 inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type);

	PROCEDURE getRecord(
		inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
		orcRecord out nocopy styLD_non_ba_fi_requ
	);

	FUNCTION frcGetRcData(
		inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type)
	RETURN styLD_non_ba_fi_requ;

	FUNCTION frcGetRcData
	RETURN styLD_non_ba_fi_requ;

	FUNCTION frcGetRecord(
		inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type)
	RETURN styLD_non_ba_fi_requ;

	PROCEDURE getRecords(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_non_ba_fi_requ
	);

	FUNCTION frfGetRecords(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false)
	RETURN tyRefCursor;

	PROCEDURE insRecord(
		ircLD_non_ba_fi_requ in styLD_non_ba_fi_requ
	);

 	  PROCEDURE insRecord(
		ircLD_non_ba_fi_requ in styLD_non_ba_fi_requ,
		orirowid   out varchar2);

	PROCEDURE insRecords(
		iotbLD_non_ba_fi_requ in out nocopy tytbLD_non_ba_fi_requ
	);

	PROCEDURE delRecord(
		inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type, inuLock in number default 1);

	PROCEDURE delByRowID(
		iriRowID    in rowid,
		inuLock in number default 1);

	PROCEDURE delRecords
	(
		iotbLD_non_ba_fi_requ in out nocopy tytbLD_non_ba_fi_requ,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_non_ba_fi_requ in styLD_non_ba_fi_requ,
		inuLock	  in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_non_ba_fi_requ in out nocopy tytbLD_non_ba_fi_requ,
		inuLock in number default 1
	);

		PROCEDURE updFirst_Bill_Id
		(
				inuNON_BA_FI_REQU_Id   in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
				inuFirst_Bill_Id$  in LD_non_ba_fi_requ.First_Bill_Id%type,
				inuLock	  in number default 0);

		PROCEDURE updSecond_Bill_Id
		(
				inuNON_BA_FI_REQU_Id   in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
				inuSecond_Bill_Id$  in LD_non_ba_fi_requ.Second_Bill_Id%type,
				inuLock	  in number default 0);

		PROCEDURE updCredit_Quota
		(
				inuNON_BA_FI_REQU_Id   in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
				inuCredit_Quota$  in LD_non_ba_fi_requ.Credit_Quota%type,
				inuLock	  in number default 0);

		PROCEDURE updUsed_Quote
		(
				inuNON_BA_FI_REQU_Id   in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
				inuUsed_Quote$  in LD_non_ba_fi_requ.Used_Quote%type,
				inuLock	  in number default 0);

		PROCEDURE updUsed_Extra_Quote
		(
				inuNON_BA_FI_REQU_Id   in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
				inuUsed_Extra_Quote$  in LD_non_ba_fi_requ.Used_Extra_Quote%type,
				inuLock	  in number default 0);

		PROCEDURE updManual_Quota_Used
		(
				inuNON_BA_FI_REQU_Id   in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
				inuManual_Quota_Used$  in LD_non_ba_fi_requ.Manual_Quota_Used%type,
				inuLock	  in number default 0);

		PROCEDURE updTake_Grace_Period
		(
				inuNON_BA_FI_REQU_Id   in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
				isbTake_Grace_Period$  in LD_non_ba_fi_requ.Take_Grace_Period%type,
				inuLock	  in number default 0);

		PROCEDURE updDelivery_Point
		(
				inuNON_BA_FI_REQU_Id   in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
				isbDelivery_Point$  in LD_non_ba_fi_requ.Delivery_Point%type,
				inuLock	  in number default 0);

		PROCEDURE updPayment
		(
				inuNON_BA_FI_REQU_Id   in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
				inuPayment$  in LD_non_ba_fi_requ.Payment%type,
				inuLock	  in number default 0);

		PROCEDURE updTrasfer_Quota
		(
				inuNON_BA_FI_REQU_Id   in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
				isbTrasfer_Quota$  in LD_non_ba_fi_requ.Trasfer_Quota%type,
				inuLock	  in number default 0);

		PROCEDURE updSale_Date
		(
				inuNON_BA_FI_REQU_Id   in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
				idtSale_Date$  in LD_non_ba_fi_requ.Sale_Date%type,
				inuLock	  in number default 0);

		PROCEDURE updDigital_Prom_Note_Cons
		(
				inuNON_BA_FI_REQU_Id   in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
				isbDigital_Prom_Note_Cons$  in LD_non_ba_fi_requ.Digital_Prom_Note_Cons%type,
				inuLock	  in number default 0);

		PROCEDURE updManual_Prom_Note_Cons
		(
				inuNON_BA_FI_REQU_Id   in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
				isbManual_Prom_Note_Cons$  in LD_non_ba_fi_requ.Manual_Prom_Note_Cons%type,
				inuLock	  in number default 0);

		PROCEDURE updSales_Status
		(
				inuNON_BA_FI_REQU_Id   in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
				inuSales_Status$  in LD_non_ba_fi_requ.Sales_Status%type,
				inuLock	  in number default 0);

		PROCEDURE updQuota_Aprox_Month
		(
				inuNON_BA_FI_REQU_Id   in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
				inuQuota_Aprox_Month$  in LD_non_ba_fi_requ.Quota_Aprox_Month%type,
				inuLock	  in number default 0);

		PROCEDURE updValue_Aprox_Insurance
		(
				inuNON_BA_FI_REQU_Id   in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
				inuValue_Aprox_Insurance$  in LD_non_ba_fi_requ.Value_Aprox_Insurance%type,
				inuLock	  in number default 0);

		PROCEDURE updValue_Total
		(
				inuNON_BA_FI_REQU_Id   in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
				inuValue_Total$  in LD_non_ba_fi_requ.Value_Total%type,
				inuLock	  in number default 0);

    	FUNCTION fnuGetNon_Ba_Fi_Requ_Id
    	(
    	    inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_non_ba_fi_requ.Non_Ba_Fi_Requ_Id%type;

    	FUNCTION fnuGetFirst_Bill_Id
    	(
    	    inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_non_ba_fi_requ.First_Bill_Id%type;

    	FUNCTION fnuGetSecond_Bill_Id
    	(
    	    inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_non_ba_fi_requ.Second_Bill_Id%type;

    	FUNCTION fnuGetCredit_Quota
    	(
    	    inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_non_ba_fi_requ.Credit_Quota%type;

    	FUNCTION fnuGetUsed_Quote
    	(
    	    inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_non_ba_fi_requ.Used_Quote%type;

    	FUNCTION fnuGetUsed_Extra_Quote
    	(
    	    inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_non_ba_fi_requ.Used_Extra_Quote%type;

    	FUNCTION fnuGetManual_Quota_Used
    	(
    	    inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_non_ba_fi_requ.Manual_Quota_Used%type;

    	FUNCTION fsbGetTake_Grace_Period
    	(
    	    inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_non_ba_fi_requ.Take_Grace_Period%type;

    	FUNCTION fsbGetDelivery_Point
    	(
    	    inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_non_ba_fi_requ.Delivery_Point%type;

    	FUNCTION fnuGetPayment
    	(
    	    inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_non_ba_fi_requ.Payment%type;

    	FUNCTION fsbGetTrasfer_Quota
    	(
    	    inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_non_ba_fi_requ.Trasfer_Quota%type;

    	FUNCTION fdtGetSale_Date
    	(
    	    inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
          inuRaiseError in number default 1
    	)
      RETURN LD_non_ba_fi_requ.Sale_Date%type;

    	FUNCTION fsbGetDigital_Prom_Note_Cons
    	(
    	    inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_non_ba_fi_requ.Digital_Prom_Note_Cons%type;

    	FUNCTION fsbGetManual_Prom_Note_Cons
    	(
    	    inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_non_ba_fi_requ.Manual_Prom_Note_Cons%type;

    	FUNCTION fnuGetSales_Status
    	(
    	    inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_non_ba_fi_requ.Sales_Status%type;

    	FUNCTION fnuGetQuota_Aprox_Month
    	(
    	    inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_non_ba_fi_requ.Quota_Aprox_Month%type;

    	FUNCTION fnuGetValue_Aprox_Insurance
    	(
    	    inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_non_ba_fi_requ.Value_Aprox_Insurance%type;

    	FUNCTION fnuGetValue_Total
    	(
    	    inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_non_ba_fi_requ.Value_Total%type;


	PROCEDURE LockByPk
	(
		inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
		orcLD_non_ba_fi_requ  out styLD_non_ba_fi_requ
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_non_ba_fi_requ  out styLD_non_ba_fi_requ
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_non_ba_fi_requ;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_non_ba_fi_requ
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO139854';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_NON_BA_FI_REQU';
	  cnuGeEntityId constant varchar2(30) := fnuGetEntityIdByName('LD_NON_BA_FI_REQU'); -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type
	)
	IS
		SELECT LD_non_ba_fi_requ.*,LD_non_ba_fi_requ.rowid
		FROM LD_non_ba_fi_requ
		WHERE  NON_BA_FI_REQU_Id = inuNON_BA_FI_REQU_Id
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_non_ba_fi_requ.*,LD_non_ba_fi_requ.rowid
		FROM LD_non_ba_fi_requ
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;
	/*Tipos*/
	type tyrfLD_non_ba_fi_requ is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_non_ba_fi_requ;

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

	FUNCTION fsbPrimaryKey( rcI in styLD_non_ba_fi_requ default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.NON_BA_FI_REQU_Id);
		sbPk:=sbPk||']';
		return sbPk;
	END;

	PROCEDURE LockByPk
	(
		inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
		orcLD_non_ba_fi_requ  out styLD_non_ba_fi_requ
	)
	IS
		rcError styLD_non_ba_fi_requ;
	BEGIN
		rcError.NON_BA_FI_REQU_Id := inuNON_BA_FI_REQU_Id;

		Open cuLockRcByPk
		(
			inuNON_BA_FI_REQU_Id
		);

		fetch cuLockRcByPk into orcLD_non_ba_fi_requ;
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
		orcLD_non_ba_fi_requ  out styLD_non_ba_fi_requ
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_non_ba_fi_requ;
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
		itbLD_non_ba_fi_requ  in out nocopy tytbLD_non_ba_fi_requ
	)
	IS
	BEGIN
			rcRecOfTab.Non_Ba_Fi_Requ_Id.delete;
			rcRecOfTab.First_Bill_Id.delete;
			rcRecOfTab.Second_Bill_Id.delete;
			rcRecOfTab.Credit_Quota.delete;
			rcRecOfTab.Used_Quote.delete;
			rcRecOfTab.Used_Extra_Quote.delete;
			rcRecOfTab.Manual_Quota_Used.delete;
			rcRecOfTab.Take_Grace_Period.delete;
			rcRecOfTab.Delivery_Point.delete;
			rcRecOfTab.Payment.delete;
			rcRecOfTab.Trasfer_Quota.delete;
			rcRecOfTab.Sale_Date.delete;
			rcRecOfTab.Digital_Prom_Note_Cons.delete;
			rcRecOfTab.Manual_Prom_Note_Cons.delete;
			rcRecOfTab.Sales_Status.delete;
			rcRecOfTab.Quota_Aprox_Month.delete;
			rcRecOfTab.Value_Aprox_Insurance.delete;
			rcRecOfTab.Value_Total.delete;
	    rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_non_ba_fi_requ  in out nocopy tytbLD_non_ba_fi_requ,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_non_ba_fi_requ);
		for n in itbLD_non_ba_fi_requ.first .. itbLD_non_ba_fi_requ.last loop
			rcRecOfTab.Non_Ba_Fi_Requ_Id(n) := itbLD_non_ba_fi_requ(n).Non_Ba_Fi_Requ_Id;
			rcRecOfTab.First_Bill_Id(n) := itbLD_non_ba_fi_requ(n).First_Bill_Id;
			rcRecOfTab.Second_Bill_Id(n) := itbLD_non_ba_fi_requ(n).Second_Bill_Id;
			rcRecOfTab.Credit_Quota(n) := itbLD_non_ba_fi_requ(n).Credit_Quota;
			rcRecOfTab.Used_Quote(n) := itbLD_non_ba_fi_requ(n).Used_Quote;
			rcRecOfTab.Used_Extra_Quote(n) := itbLD_non_ba_fi_requ(n).Used_Extra_Quote;
			rcRecOfTab.Manual_Quota_Used(n) := itbLD_non_ba_fi_requ(n).Manual_Quota_Used;
			rcRecOfTab.Take_Grace_Period(n) := itbLD_non_ba_fi_requ(n).Take_Grace_Period;
			rcRecOfTab.Delivery_Point(n) := itbLD_non_ba_fi_requ(n).Delivery_Point;
			rcRecOfTab.Payment(n) := itbLD_non_ba_fi_requ(n).Payment;
			rcRecOfTab.Trasfer_Quota(n) := itbLD_non_ba_fi_requ(n).Trasfer_Quota;
			rcRecOfTab.Sale_Date(n) := itbLD_non_ba_fi_requ(n).Sale_Date;
			rcRecOfTab.Digital_Prom_Note_Cons(n) := itbLD_non_ba_fi_requ(n).Digital_Prom_Note_Cons;
			rcRecOfTab.Manual_Prom_Note_Cons(n) := itbLD_non_ba_fi_requ(n).Manual_Prom_Note_Cons;
			rcRecOfTab.Sales_Status(n) := itbLD_non_ba_fi_requ(n).Sales_Status;
			rcRecOfTab.Quota_Aprox_Month(n) := itbLD_non_ba_fi_requ(n).Quota_Aprox_Month;
			rcRecOfTab.Value_Aprox_Insurance(n) := itbLD_non_ba_fi_requ(n).Value_Aprox_Insurance;
			rcRecOfTab.Value_Total(n) := itbLD_non_ba_fi_requ(n).Value_Total;
			rcRecOfTab.row_id(n) := itbLD_non_ba_fi_requ(n).rowid;
			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;


	PROCEDURE Load
	(
		inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuNON_BA_FI_REQU_Id
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
		inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuNON_BA_FI_REQU_Id = rcData.NON_BA_FI_REQU_Id
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
		inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuNON_BA_FI_REQU_Id
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;

	PROCEDURE AccKey
	(
		inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type
	)
	IS
		rcError styLD_non_ba_fi_requ;
	BEGIN		rcError.NON_BA_FI_REQU_Id:=inuNON_BA_FI_REQU_Id;

		Load
		(
			inuNON_BA_FI_REQU_Id
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
		inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type
	)
	IS
	BEGIN
		Load
		(
			inuNON_BA_FI_REQU_Id
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;

	PROCEDURE getRecord
	(
		inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
		orcRecord out nocopy styLD_non_ba_fi_requ
	)
	IS
		rcError styLD_non_ba_fi_requ;
	BEGIN		rcError.NON_BA_FI_REQU_Id:=inuNON_BA_FI_REQU_Id;

		Load
		(
			inuNON_BA_FI_REQU_Id
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRecord
	(
		inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type
	)
	RETURN styLD_non_ba_fi_requ
	IS
		rcError styLD_non_ba_fi_requ;
	BEGIN
		rcError.NON_BA_FI_REQU_Id:=inuNON_BA_FI_REQU_Id;

		Load
		(
			inuNON_BA_FI_REQU_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	(
		inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type
	)
	RETURN styLD_non_ba_fi_requ
	IS
		rcError styLD_non_ba_fi_requ;
	BEGIN
		rcError.NON_BA_FI_REQU_Id:=inuNON_BA_FI_REQU_Id;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuNON_BA_FI_REQU_Id
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuNON_BA_FI_REQU_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_non_ba_fi_requ
	IS
	BEGIN
		return(rcData);
	END;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_non_ba_fi_requ
	)
	IS
		rfLD_non_ba_fi_requ tyrfLD_non_ba_fi_requ;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LD_non_ba_fi_requ.*,
		            LD_non_ba_fi_requ.rowid
                FROM LD_non_ba_fi_requ';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;
		open rfLD_non_ba_fi_requ for sbFullQuery;
		fetch rfLD_non_ba_fi_requ bulk collect INTO otbResult;
		close rfLD_non_ba_fi_requ;
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
		sbSQL  VARCHAR2 (32000) := 'select LD_non_ba_fi_requ.*,
		            LD_non_ba_fi_requ.rowid
                FROM LD_non_ba_fi_requ';
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
		ircLD_non_ba_fi_requ in styLD_non_ba_fi_requ
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_non_ba_fi_requ,rirowid);
	END;

	PROCEDURE insRecord
	(
		ircLD_non_ba_fi_requ in styLD_non_ba_fi_requ,
		orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_non_ba_fi_requ.NON_BA_FI_REQU_Id is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|NON_BA_FI_REQU_Id');
			raise ex.controlled_error;
		end if;
		insert into LD_non_ba_fi_requ
		(
			Non_Ba_Fi_Requ_Id,
			First_Bill_Id,
			Second_Bill_Id,
			Credit_Quota,
			Used_Quote,
			Used_Extra_Quote,
			Manual_Quota_Used,
			Take_Grace_Period,
			Delivery_Point,
			Payment,
			Trasfer_Quota,
			Sale_Date,
			Digital_Prom_Note_Cons,
			Manual_Prom_Note_Cons,
			Sales_Status,
			Quota_Aprox_Month,
			Value_Aprox_Insurance,
			Value_Total
		)
		values
		(
			ircLD_non_ba_fi_requ.Non_Ba_Fi_Requ_Id,
			ircLD_non_ba_fi_requ.First_Bill_Id,
			ircLD_non_ba_fi_requ.Second_Bill_Id,
			ircLD_non_ba_fi_requ.Credit_Quota,
			ircLD_non_ba_fi_requ.Used_Quote,
			ircLD_non_ba_fi_requ.Used_Extra_Quote,
			ircLD_non_ba_fi_requ.Manual_Quota_Used,
			ircLD_non_ba_fi_requ.Take_Grace_Period,
			ircLD_non_ba_fi_requ.Delivery_Point,
			ircLD_non_ba_fi_requ.Payment,
			ircLD_non_ba_fi_requ.Trasfer_Quota,
			ircLD_non_ba_fi_requ.Sale_Date,
			ircLD_non_ba_fi_requ.Digital_Prom_Note_Cons,
			ircLD_non_ba_fi_requ.Manual_Prom_Note_Cons,
			ircLD_non_ba_fi_requ.Sales_Status,
			ircLD_non_ba_fi_requ.Quota_Aprox_Month,
			ircLD_non_ba_fi_requ.Value_Aprox_Insurance,
			ircLD_non_ba_fi_requ.Value_Total
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_non_ba_fi_requ));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE insRecords
	(
		iotbLD_non_ba_fi_requ in out nocopy tytbLD_non_ba_fi_requ
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_non_ba_fi_requ, blUseRowID);
		forall n in iotbLD_non_ba_fi_requ.first..iotbLD_non_ba_fi_requ.last
			insert into LD_non_ba_fi_requ
			(
			Non_Ba_Fi_Requ_Id,
			First_Bill_Id,
			Second_Bill_Id,
			Credit_Quota,
			Used_Quote,
			Used_Extra_Quote,
			Manual_Quota_Used,
			Take_Grace_Period,
			Delivery_Point,
			Payment,
			Trasfer_Quota,
			Sale_Date,
			Digital_Prom_Note_Cons,
			Manual_Prom_Note_Cons,
			Sales_Status,
			Quota_Aprox_Month,
			Value_Aprox_Insurance,
			Value_Total
		)
		values
		(
			rcRecOfTab.Non_Ba_Fi_Requ_Id(n),
			rcRecOfTab.First_Bill_Id(n),
			rcRecOfTab.Second_Bill_Id(n),
			rcRecOfTab.Credit_Quota(n),
			rcRecOfTab.Used_Quote(n),
			rcRecOfTab.Used_Extra_Quote(n),
			rcRecOfTab.Manual_Quota_Used(n),
			rcRecOfTab.Take_Grace_Period(n),
			rcRecOfTab.Delivery_Point(n),
			rcRecOfTab.Payment(n),
			rcRecOfTab.Trasfer_Quota(n),
			rcRecOfTab.Sale_Date(n),
			rcRecOfTab.Digital_Prom_Note_Cons(n),
			rcRecOfTab.Manual_Prom_Note_Cons(n),
			rcRecOfTab.Sales_Status(n),
			rcRecOfTab.Quota_Aprox_Month(n),
			rcRecOfTab.Value_Aprox_Insurance(n),
			rcRecOfTab.Value_Total(n)
			);
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE delRecord
	(
		inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_non_ba_fi_requ;
	BEGIN
		rcError.NON_BA_FI_REQU_Id:=inuNON_BA_FI_REQU_Id;

		if inuLock=1 then
			LockByPk
			(
				inuNON_BA_FI_REQU_Id,
				rcData
			);
		end if;

		delete
		from LD_non_ba_fi_requ
		where
       		NON_BA_FI_REQU_Id=inuNON_BA_FI_REQU_Id;
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
		rcError  styLD_non_ba_fi_requ;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;

		delete
		from LD_non_ba_fi_requ
		where
			rowid = iriRowID
		returning
   NON_BA_FI_REQU_Id
		into
			rcError.NON_BA_FI_REQU_Id;

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
		iotbLD_non_ba_fi_requ in out nocopy tytbLD_non_ba_fi_requ,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_non_ba_fi_requ;
	BEGIN
		FillRecordOfTables(iotbLD_non_ba_fi_requ, blUseRowID);
       if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_non_ba_fi_requ.first .. iotbLD_non_ba_fi_requ.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_non_ba_fi_requ.first .. iotbLD_non_ba_fi_requ.last
				delete
				from LD_non_ba_fi_requ
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_non_ba_fi_requ.first .. iotbLD_non_ba_fi_requ.last loop
					LockByPk
					(
							rcRecOfTab.NON_BA_FI_REQU_Id(n),
							rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_non_ba_fi_requ.first .. iotbLD_non_ba_fi_requ.last
				delete
				from LD_non_ba_fi_requ
				where
		         	NON_BA_FI_REQU_Id = rcRecOfTab.NON_BA_FI_REQU_Id(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updRecord
	(
		ircLD_non_ba_fi_requ in styLD_non_ba_fi_requ,
		inuLock	  in number default 0
	)
	IS
		nuNON_BA_FI_REQU_Id LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type;

	BEGIN
		if ircLD_non_ba_fi_requ.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_non_ba_fi_requ.rowid,rcData);
			end if;
			update LD_non_ba_fi_requ
			set

        First_Bill_Id = ircLD_non_ba_fi_requ.First_Bill_Id,
        Second_Bill_Id = ircLD_non_ba_fi_requ.Second_Bill_Id,
        Credit_Quota = ircLD_non_ba_fi_requ.Credit_Quota,
        Used_Quote = ircLD_non_ba_fi_requ.Used_Quote,
        Used_Extra_Quote = ircLD_non_ba_fi_requ.Used_Extra_Quote,
        Manual_Quota_Used = ircLD_non_ba_fi_requ.Manual_Quota_Used,
        Take_Grace_Period = ircLD_non_ba_fi_requ.Take_Grace_Period,
        Delivery_Point = ircLD_non_ba_fi_requ.Delivery_Point,
        Payment = ircLD_non_ba_fi_requ.Payment,
        Trasfer_Quota = ircLD_non_ba_fi_requ.Trasfer_Quota,
        Sale_Date = ircLD_non_ba_fi_requ.Sale_Date,
        Digital_Prom_Note_Cons = ircLD_non_ba_fi_requ.Digital_Prom_Note_Cons,
        Manual_Prom_Note_Cons = ircLD_non_ba_fi_requ.Manual_Prom_Note_Cons,
        Sales_Status = ircLD_non_ba_fi_requ.Sales_Status,
        Quota_Aprox_Month = ircLD_non_ba_fi_requ.Quota_Aprox_Month,
        Value_Aprox_Insurance = ircLD_non_ba_fi_requ.Value_Aprox_Insurance,
        Value_Total = ircLD_non_ba_fi_requ.Value_Total
			where
				rowid = ircLD_non_ba_fi_requ.rowid
			returning
    NON_BA_FI_REQU_Id
			into
				nuNON_BA_FI_REQU_Id;

		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_non_ba_fi_requ.NON_BA_FI_REQU_Id,
					rcData
				);
			end if;

			update LD_non_ba_fi_requ
			set
        First_Bill_Id = ircLD_non_ba_fi_requ.First_Bill_Id,
        Second_Bill_Id = ircLD_non_ba_fi_requ.Second_Bill_Id,
        Credit_Quota = ircLD_non_ba_fi_requ.Credit_Quota,
        Used_Quote = ircLD_non_ba_fi_requ.Used_Quote,
        Used_Extra_Quote = ircLD_non_ba_fi_requ.Used_Extra_Quote,
        Manual_Quota_Used = ircLD_non_ba_fi_requ.Manual_Quota_Used,
        Take_Grace_Period = ircLD_non_ba_fi_requ.Take_Grace_Period,
        Delivery_Point = ircLD_non_ba_fi_requ.Delivery_Point,
        Payment = ircLD_non_ba_fi_requ.Payment,
        Trasfer_Quota = ircLD_non_ba_fi_requ.Trasfer_Quota,
        Sale_Date = ircLD_non_ba_fi_requ.Sale_Date,
        Digital_Prom_Note_Cons = ircLD_non_ba_fi_requ.Digital_Prom_Note_Cons,
        Manual_Prom_Note_Cons = ircLD_non_ba_fi_requ.Manual_Prom_Note_Cons,
        Sales_Status = ircLD_non_ba_fi_requ.Sales_Status,
        Quota_Aprox_Month = ircLD_non_ba_fi_requ.Quota_Aprox_Month,
        Value_Aprox_Insurance = ircLD_non_ba_fi_requ.Value_Aprox_Insurance,
        Value_Total = ircLD_non_ba_fi_requ.Value_Total
			where
	         	NON_BA_FI_REQU_Id = ircLD_non_ba_fi_requ.NON_BA_FI_REQU_Id
			returning
    NON_BA_FI_REQU_Id
			into
				nuNON_BA_FI_REQU_Id;
		end if;

		if
			nuNON_BA_FI_REQU_Id is NULL
		then
			raise no_data_found;
		end if;

	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_non_ba_fi_requ));
			raise ex.CONTROLLED_ERROR;
	END;

  PROCEDURE updRecords
  (
    iotbLD_non_ba_fi_requ in out nocopy tytbLD_non_ba_fi_requ,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_non_ba_fi_requ;
  BEGIN
    FillRecordOfTables(iotbLD_non_ba_fi_requ,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_non_ba_fi_requ.first .. iotbLD_non_ba_fi_requ.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_non_ba_fi_requ.first .. iotbLD_non_ba_fi_requ.last
        update LD_non_ba_fi_requ
        set

            First_Bill_Id = rcRecOfTab.First_Bill_Id(n),
            Second_Bill_Id = rcRecOfTab.Second_Bill_Id(n),
            Credit_Quota = rcRecOfTab.Credit_Quota(n),
            Used_Quote = rcRecOfTab.Used_Quote(n),
            Used_Extra_Quote = rcRecOfTab.Used_Extra_Quote(n),
            Manual_Quota_Used = rcRecOfTab.Manual_Quota_Used(n),
            Take_Grace_Period = rcRecOfTab.Take_Grace_Period(n),
            Delivery_Point = rcRecOfTab.Delivery_Point(n),
            Payment = rcRecOfTab.Payment(n),
            Trasfer_Quota = rcRecOfTab.Trasfer_Quota(n),
            Sale_Date = rcRecOfTab.Sale_Date(n),
            Digital_Prom_Note_Cons = rcRecOfTab.Digital_Prom_Note_Cons(n),
            Manual_Prom_Note_Cons = rcRecOfTab.Manual_Prom_Note_Cons(n),
            Sales_Status = rcRecOfTab.Sales_Status(n),
            Quota_Aprox_Month = rcRecOfTab.Quota_Aprox_Month(n),
            Value_Aprox_Insurance = rcRecOfTab.Value_Aprox_Insurance(n),
            Value_Total = rcRecOfTab.Value_Total(n)
          where
					rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_non_ba_fi_requ.first .. iotbLD_non_ba_fi_requ.last loop
          LockByPk
          (
              rcRecOfTab.NON_BA_FI_REQU_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_non_ba_fi_requ.first .. iotbLD_non_ba_fi_requ.last
        update LD_non_ba_fi_requ
        set
					First_Bill_Id = rcRecOfTab.First_Bill_Id(n),
					Second_Bill_Id = rcRecOfTab.Second_Bill_Id(n),
					Credit_Quota = rcRecOfTab.Credit_Quota(n),
					Used_Quote = rcRecOfTab.Used_Quote(n),
					Used_Extra_Quote = rcRecOfTab.Used_Extra_Quote(n),
					Manual_Quota_Used = rcRecOfTab.Manual_Quota_Used(n),
					Take_Grace_Period = rcRecOfTab.Take_Grace_Period(n),
					Delivery_Point = rcRecOfTab.Delivery_Point(n),
					Payment = rcRecOfTab.Payment(n),
					Trasfer_Quota = rcRecOfTab.Trasfer_Quota(n),
					Sale_Date = rcRecOfTab.Sale_Date(n),
					Digital_Prom_Note_Cons = rcRecOfTab.Digital_Prom_Note_Cons(n),
					Manual_Prom_Note_Cons = rcRecOfTab.Manual_Prom_Note_Cons(n),
					Sales_Status = rcRecOfTab.Sales_Status(n),
					Quota_Aprox_Month = rcRecOfTab.Quota_Aprox_Month(n),
					Value_Aprox_Insurance = rcRecOfTab.Value_Aprox_Insurance(n),
					Value_Total = rcRecOfTab.Value_Total(n)
          where
          NON_BA_FI_REQU_Id = rcRecOfTab.NON_BA_FI_REQU_Id(n)
;
    end if;
  END;

	PROCEDURE updFirst_Bill_Id
	(
		inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
		inuFirst_Bill_Id$ in LD_non_ba_fi_requ.First_Bill_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_non_ba_fi_requ;
	BEGIN
		rcError.NON_BA_FI_REQU_Id := inuNON_BA_FI_REQU_Id;
		if inuLock=1 then
			LockByPk
			(
				inuNON_BA_FI_REQU_Id,
				rcData
			);
		end if;

		update LD_non_ba_fi_requ
		set
			First_Bill_Id = inuFirst_Bill_Id$
		where
			NON_BA_FI_REQU_Id = inuNON_BA_FI_REQU_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.First_Bill_Id:= inuFirst_Bill_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updSecond_Bill_Id
	(
		inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
		inuSecond_Bill_Id$ in LD_non_ba_fi_requ.Second_Bill_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_non_ba_fi_requ;
	BEGIN
		rcError.NON_BA_FI_REQU_Id := inuNON_BA_FI_REQU_Id;
		if inuLock=1 then
			LockByPk
			(
				inuNON_BA_FI_REQU_Id,
				rcData
			);
		end if;

		update LD_non_ba_fi_requ
		set
			Second_Bill_Id = inuSecond_Bill_Id$
		where
			NON_BA_FI_REQU_Id = inuNON_BA_FI_REQU_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Second_Bill_Id:= inuSecond_Bill_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updCredit_Quota
	(
		inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
		inuCredit_Quota$ in LD_non_ba_fi_requ.Credit_Quota%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_non_ba_fi_requ;
	BEGIN
		rcError.NON_BA_FI_REQU_Id := inuNON_BA_FI_REQU_Id;
		if inuLock=1 then
			LockByPk
			(
				inuNON_BA_FI_REQU_Id,
				rcData
			);
		end if;

		update LD_non_ba_fi_requ
		set
			Credit_Quota = inuCredit_Quota$
		where
			NON_BA_FI_REQU_Id = inuNON_BA_FI_REQU_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Credit_Quota:= inuCredit_Quota$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updUsed_Quote
	(
		inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
		inuUsed_Quote$ in LD_non_ba_fi_requ.Used_Quote%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_non_ba_fi_requ;
	BEGIN
		rcError.NON_BA_FI_REQU_Id := inuNON_BA_FI_REQU_Id;
		if inuLock=1 then
			LockByPk
			(
				inuNON_BA_FI_REQU_Id,
				rcData
			);
		end if;

		update LD_non_ba_fi_requ
		set
			Used_Quote = inuUsed_Quote$
		where
			NON_BA_FI_REQU_Id = inuNON_BA_FI_REQU_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Used_Quote:= inuUsed_Quote$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updUsed_Extra_Quote
	(
		inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
		inuUsed_Extra_Quote$ in LD_non_ba_fi_requ.Used_Extra_Quote%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_non_ba_fi_requ;
	BEGIN
		rcError.NON_BA_FI_REQU_Id := inuNON_BA_FI_REQU_Id;
		if inuLock=1 then
			LockByPk
			(
				inuNON_BA_FI_REQU_Id,
				rcData
			);
		end if;

		update LD_non_ba_fi_requ
		set
			Used_Extra_Quote = inuUsed_Extra_Quote$
		where
			NON_BA_FI_REQU_Id = inuNON_BA_FI_REQU_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Used_Extra_Quote:= inuUsed_Extra_Quote$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updManual_Quota_Used
	(
		inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
		inuManual_Quota_Used$ in LD_non_ba_fi_requ.Manual_Quota_Used%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_non_ba_fi_requ;
	BEGIN
		rcError.NON_BA_FI_REQU_Id := inuNON_BA_FI_REQU_Id;
		if inuLock=1 then
			LockByPk
			(
				inuNON_BA_FI_REQU_Id,
				rcData
			);
		end if;

		update LD_non_ba_fi_requ
		set
			Manual_Quota_Used = inuManual_Quota_Used$
		where
			NON_BA_FI_REQU_Id = inuNON_BA_FI_REQU_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Manual_Quota_Used:= inuManual_Quota_Used$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updTake_Grace_Period
	(
		inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
		isbTake_Grace_Period$ in LD_non_ba_fi_requ.Take_Grace_Period%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_non_ba_fi_requ;
	BEGIN
		rcError.NON_BA_FI_REQU_Id := inuNON_BA_FI_REQU_Id;
		if inuLock=1 then
			LockByPk
			(
				inuNON_BA_FI_REQU_Id,
				rcData
			);
		end if;

		update LD_non_ba_fi_requ
		set
			Take_Grace_Period = isbTake_Grace_Period$
		where
			NON_BA_FI_REQU_Id = inuNON_BA_FI_REQU_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Take_Grace_Period:= isbTake_Grace_Period$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updDelivery_Point
	(
		inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
		isbDelivery_Point$ in LD_non_ba_fi_requ.Delivery_Point%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_non_ba_fi_requ;
	BEGIN
		rcError.NON_BA_FI_REQU_Id := inuNON_BA_FI_REQU_Id;
		if inuLock=1 then
			LockByPk
			(
				inuNON_BA_FI_REQU_Id,
				rcData
			);
		end if;

		update LD_non_ba_fi_requ
		set
			Delivery_Point = isbDelivery_Point$
		where
			NON_BA_FI_REQU_Id = inuNON_BA_FI_REQU_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Delivery_Point:= isbDelivery_Point$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updPayment
	(
		inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
		inuPayment$ in LD_non_ba_fi_requ.Payment%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_non_ba_fi_requ;
	BEGIN
		rcError.NON_BA_FI_REQU_Id := inuNON_BA_FI_REQU_Id;
		if inuLock=1 then
			LockByPk
			(
				inuNON_BA_FI_REQU_Id,
				rcData
			);
		end if;

		update LD_non_ba_fi_requ
		set
			Payment = inuPayment$
		where
			NON_BA_FI_REQU_Id = inuNON_BA_FI_REQU_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Payment:= inuPayment$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updTrasfer_Quota
	(
		inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
		isbTrasfer_Quota$ in LD_non_ba_fi_requ.Trasfer_Quota%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_non_ba_fi_requ;
	BEGIN
		rcError.NON_BA_FI_REQU_Id := inuNON_BA_FI_REQU_Id;
		if inuLock=1 then
			LockByPk
			(
				inuNON_BA_FI_REQU_Id,
				rcData
			);
		end if;

		update LD_non_ba_fi_requ
		set
			Trasfer_Quota = isbTrasfer_Quota$
		where
			NON_BA_FI_REQU_Id = inuNON_BA_FI_REQU_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Trasfer_Quota:= isbTrasfer_Quota$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updSale_Date
	(
		inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
		idtSale_Date$ in LD_non_ba_fi_requ.Sale_Date%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_non_ba_fi_requ;
	BEGIN
		rcError.NON_BA_FI_REQU_Id := inuNON_BA_FI_REQU_Id;
		if inuLock=1 then
			LockByPk
			(
				inuNON_BA_FI_REQU_Id,
				rcData
			);
		end if;

		update LD_non_ba_fi_requ
		set
			Sale_Date = idtSale_Date$
		where
			NON_BA_FI_REQU_Id = inuNON_BA_FI_REQU_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Sale_Date:= idtSale_Date$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updDigital_Prom_Note_Cons
	(
		inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
		isbDigital_Prom_Note_Cons$ in LD_non_ba_fi_requ.Digital_Prom_Note_Cons%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_non_ba_fi_requ;
	BEGIN
		rcError.NON_BA_FI_REQU_Id := inuNON_BA_FI_REQU_Id;
		if inuLock=1 then
			LockByPk
			(
				inuNON_BA_FI_REQU_Id,
				rcData
			);
		end if;

		update LD_non_ba_fi_requ
		set
			Digital_Prom_Note_Cons = isbDigital_Prom_Note_Cons$
		where
			NON_BA_FI_REQU_Id = inuNON_BA_FI_REQU_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Digital_Prom_Note_Cons:= isbDigital_Prom_Note_Cons$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updManual_Prom_Note_Cons
	(
		inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
		isbManual_Prom_Note_Cons$ in LD_non_ba_fi_requ.Manual_Prom_Note_Cons%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_non_ba_fi_requ;
	BEGIN
		rcError.NON_BA_FI_REQU_Id := inuNON_BA_FI_REQU_Id;
		if inuLock=1 then
			LockByPk
			(
				inuNON_BA_FI_REQU_Id,
				rcData
			);
		end if;

		update LD_non_ba_fi_requ
		set
			Manual_Prom_Note_Cons = isbManual_Prom_Note_Cons$
		where
			NON_BA_FI_REQU_Id = inuNON_BA_FI_REQU_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Manual_Prom_Note_Cons:= isbManual_Prom_Note_Cons$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updSales_Status
	(
		inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
		inuSales_Status$ in LD_non_ba_fi_requ.Sales_Status%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_non_ba_fi_requ;
	BEGIN
		rcError.NON_BA_FI_REQU_Id := inuNON_BA_FI_REQU_Id;
		if inuLock=1 then
			LockByPk
			(
				inuNON_BA_FI_REQU_Id,
				rcData
			);
		end if;

		update LD_non_ba_fi_requ
		set
			Sales_Status = inuSales_Status$
		where
			NON_BA_FI_REQU_Id = inuNON_BA_FI_REQU_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Sales_Status:= inuSales_Status$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updQuota_Aprox_Month
	(
		inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
		inuQuota_Aprox_Month$ in LD_non_ba_fi_requ.Quota_Aprox_Month%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_non_ba_fi_requ;
	BEGIN
		rcError.NON_BA_FI_REQU_Id := inuNON_BA_FI_REQU_Id;
		if inuLock=1 then
			LockByPk
			(
				inuNON_BA_FI_REQU_Id,
				rcData
			);
		end if;

		update LD_non_ba_fi_requ
		set
			Quota_Aprox_Month = inuQuota_Aprox_Month$
		where
			NON_BA_FI_REQU_Id = inuNON_BA_FI_REQU_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Quota_Aprox_Month:= inuQuota_Aprox_Month$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updValue_Aprox_Insurance
	(
		inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
		inuValue_Aprox_Insurance$ in LD_non_ba_fi_requ.Value_Aprox_Insurance%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_non_ba_fi_requ;
	BEGIN
		rcError.NON_BA_FI_REQU_Id := inuNON_BA_FI_REQU_Id;
		if inuLock=1 then
			LockByPk
			(
				inuNON_BA_FI_REQU_Id,
				rcData
			);
		end if;

		update LD_non_ba_fi_requ
		set
			Value_Aprox_Insurance = inuValue_Aprox_Insurance$
		where
			NON_BA_FI_REQU_Id = inuNON_BA_FI_REQU_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Value_Aprox_Insurance:= inuValue_Aprox_Insurance$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updValue_Total
	(
		inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
		inuValue_Total$ in LD_non_ba_fi_requ.Value_Total%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_non_ba_fi_requ;
	BEGIN
		rcError.NON_BA_FI_REQU_Id := inuNON_BA_FI_REQU_Id;
		if inuLock=1 then
			LockByPk
			(
				inuNON_BA_FI_REQU_Id,
				rcData
			);
		end if;

		update LD_non_ba_fi_requ
		set
			Value_Total = inuValue_Total$
		where
			NON_BA_FI_REQU_Id = inuNON_BA_FI_REQU_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Value_Total:= inuValue_Total$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;


	FUNCTION fnuGetNon_Ba_Fi_Requ_Id
	(
		inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_non_ba_fi_requ.Non_Ba_Fi_Requ_Id%type
	IS
		rcError styLD_non_ba_fi_requ;
	BEGIN

		rcError.NON_BA_FI_REQU_Id := inuNON_BA_FI_REQU_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuNON_BA_FI_REQU_Id
			 )
		then
			 return(rcData.Non_Ba_Fi_Requ_Id);
		end if;
		Load
		(
			inuNON_BA_FI_REQU_Id
		);
		return(rcData.Non_Ba_Fi_Requ_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetFirst_Bill_Id
	(
		inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_non_ba_fi_requ.First_Bill_Id%type
	IS
		rcError styLD_non_ba_fi_requ;
	BEGIN

		rcError.NON_BA_FI_REQU_Id := inuNON_BA_FI_REQU_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuNON_BA_FI_REQU_Id
			 )
		then
			 return(rcData.First_Bill_Id);
		end if;
		Load
		(
			inuNON_BA_FI_REQU_Id
		);
		return(rcData.First_Bill_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetSecond_Bill_Id
	(
		inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_non_ba_fi_requ.Second_Bill_Id%type
	IS
		rcError styLD_non_ba_fi_requ;
	BEGIN

		rcError.NON_BA_FI_REQU_Id := inuNON_BA_FI_REQU_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuNON_BA_FI_REQU_Id
			 )
		then
			 return(rcData.Second_Bill_Id);
		end if;
		Load
		(
			inuNON_BA_FI_REQU_Id
		);
		return(rcData.Second_Bill_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetCredit_Quota
	(
		inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_non_ba_fi_requ.Credit_Quota%type
	IS
		rcError styLD_non_ba_fi_requ;
	BEGIN

		rcError.NON_BA_FI_REQU_Id := inuNON_BA_FI_REQU_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuNON_BA_FI_REQU_Id
			 )
		then
			 return(rcData.Credit_Quota);
		end if;
		Load
		(
			inuNON_BA_FI_REQU_Id
		);
		return(rcData.Credit_Quota);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetUsed_Quote
	(
		inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_non_ba_fi_requ.Used_Quote%type
	IS
		rcError styLD_non_ba_fi_requ;
	BEGIN

		rcError.NON_BA_FI_REQU_Id := inuNON_BA_FI_REQU_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuNON_BA_FI_REQU_Id
			 )
		then
			 return(rcData.Used_Quote);
		end if;
		Load
		(
			inuNON_BA_FI_REQU_Id
		);
		return(rcData.Used_Quote);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetUsed_Extra_Quote
	(
		inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_non_ba_fi_requ.Used_Extra_Quote%type
	IS
		rcError styLD_non_ba_fi_requ;
	BEGIN

		rcError.NON_BA_FI_REQU_Id := inuNON_BA_FI_REQU_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuNON_BA_FI_REQU_Id
			 )
		then
			 return(rcData.Used_Extra_Quote);
		end if;
		Load
		(
			inuNON_BA_FI_REQU_Id
		);
		return(rcData.Used_Extra_Quote);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetManual_Quota_Used
	(
		inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_non_ba_fi_requ.Manual_Quota_Used%type
	IS
		rcError styLD_non_ba_fi_requ;
	BEGIN

		rcError.NON_BA_FI_REQU_Id := inuNON_BA_FI_REQU_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuNON_BA_FI_REQU_Id
			 )
		then
			 return(rcData.Manual_Quota_Used);
		end if;
		Load
		(
			inuNON_BA_FI_REQU_Id
		);
		return(rcData.Manual_Quota_Used);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fsbGetTake_Grace_Period
	(
		inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_non_ba_fi_requ.Take_Grace_Period%type
	IS
		rcError styLD_non_ba_fi_requ;
	BEGIN

		rcError.NON_BA_FI_REQU_Id:=inuNON_BA_FI_REQU_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuNON_BA_FI_REQU_Id
			 )
		then
			 return(rcData.Take_Grace_Period);
		end if;
		Load
		(
			inuNON_BA_FI_REQU_Id
		);
		return(rcData.Take_Grace_Period);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fsbGetDelivery_Point
	(
		inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_non_ba_fi_requ.Delivery_Point%type
	IS
		rcError styLD_non_ba_fi_requ;
	BEGIN

		rcError.NON_BA_FI_REQU_Id:=inuNON_BA_FI_REQU_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuNON_BA_FI_REQU_Id
			 )
		then
			 return(rcData.Delivery_Point);
		end if;
		Load
		(
			inuNON_BA_FI_REQU_Id
		);
		return(rcData.Delivery_Point);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetPayment
	(
		inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_non_ba_fi_requ.Payment%type
	IS
		rcError styLD_non_ba_fi_requ;
	BEGIN

		rcError.NON_BA_FI_REQU_Id := inuNON_BA_FI_REQU_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuNON_BA_FI_REQU_Id
			 )
		then
			 return(rcData.Payment);
		end if;
		Load
		(
			inuNON_BA_FI_REQU_Id
		);
		return(rcData.Payment);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fsbGetTrasfer_Quota
	(
		inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_non_ba_fi_requ.Trasfer_Quota%type
	IS
		rcError styLD_non_ba_fi_requ;
	BEGIN

		rcError.NON_BA_FI_REQU_Id:=inuNON_BA_FI_REQU_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuNON_BA_FI_REQU_Id
			 )
		then
			 return(rcData.Trasfer_Quota);
		end if;
		Load
		(
			inuNON_BA_FI_REQU_Id
		);
		return(rcData.Trasfer_Quota);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fdtGetSale_Date
	(
		inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_non_ba_fi_requ.Sale_Date%type
	IS
		rcError styLD_non_ba_fi_requ;
	BEGIN

		rcError.NON_BA_FI_REQU_Id:=inuNON_BA_FI_REQU_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuNON_BA_FI_REQU_Id
			 )
		then
			 return(rcData.Sale_Date);
		end if;
		Load
		(
		 		inuNON_BA_FI_REQU_Id
		);
		return(rcData.Sale_Date);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fsbGetDigital_Prom_Note_Cons
	(
		inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_non_ba_fi_requ.Digital_Prom_Note_Cons%type
	IS
		rcError styLD_non_ba_fi_requ;
	BEGIN

		rcError.NON_BA_FI_REQU_Id:=inuNON_BA_FI_REQU_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuNON_BA_FI_REQU_Id
			 )
		then
			 return(rcData.Digital_Prom_Note_Cons);
		end if;
		Load
		(
			inuNON_BA_FI_REQU_Id
		);
		return(rcData.Digital_Prom_Note_Cons);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fsbGetManual_Prom_Note_Cons
	(
		inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_non_ba_fi_requ.Manual_Prom_Note_Cons%type
	IS
		rcError styLD_non_ba_fi_requ;
	BEGIN

		rcError.NON_BA_FI_REQU_Id:=inuNON_BA_FI_REQU_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuNON_BA_FI_REQU_Id
			 )
		then
			 return(rcData.Manual_Prom_Note_Cons);
		end if;
		Load
		(
			inuNON_BA_FI_REQU_Id
		);
		return(rcData.Manual_Prom_Note_Cons);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetSales_Status
	(
		inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_non_ba_fi_requ.Sales_Status%type
	IS
		rcError styLD_non_ba_fi_requ;
	BEGIN

		rcError.NON_BA_FI_REQU_Id := inuNON_BA_FI_REQU_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuNON_BA_FI_REQU_Id
			 )
		then
			 return(rcData.Sales_Status);
		end if;
		Load
		(
			inuNON_BA_FI_REQU_Id
		);
		return(rcData.Sales_Status);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetQuota_Aprox_Month
	(
		inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_non_ba_fi_requ.Quota_Aprox_Month%type
	IS
		rcError styLD_non_ba_fi_requ;
	BEGIN

		rcError.NON_BA_FI_REQU_Id := inuNON_BA_FI_REQU_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuNON_BA_FI_REQU_Id
			 )
		then
			 return(rcData.Quota_Aprox_Month);
		end if;
		Load
		(
			inuNON_BA_FI_REQU_Id
		);
		return(rcData.Quota_Aprox_Month);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetValue_Aprox_Insurance
	(
		inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_non_ba_fi_requ.Value_Aprox_Insurance%type
	IS
		rcError styLD_non_ba_fi_requ;
	BEGIN

		rcError.NON_BA_FI_REQU_Id := inuNON_BA_FI_REQU_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuNON_BA_FI_REQU_Id
			 )
		then
			 return(rcData.Value_Aprox_Insurance);
		end if;
		Load
		(
			inuNON_BA_FI_REQU_Id
		);
		return(rcData.Value_Aprox_Insurance);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetValue_Total
	(
		inuNON_BA_FI_REQU_Id in LD_non_ba_fi_requ.NON_BA_FI_REQU_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_non_ba_fi_requ.Value_Total%type
	IS
		rcError styLD_non_ba_fi_requ;
	BEGIN

		rcError.NON_BA_FI_REQU_Id := inuNON_BA_FI_REQU_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuNON_BA_FI_REQU_Id
			 )
		then
			 return(rcData.Value_Total);
		end if;
		Load
		(
			inuNON_BA_FI_REQU_Id
		);
		return(rcData.Value_Total);
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
end DALD_non_ba_fi_requ;
/
PROMPT Otorgando permisos de ejecucion a DALD_NON_BA_FI_REQU
BEGIN
    pkg_utilidades.praplicarpermisos('DALD_NON_BA_FI_REQU', 'ADM_PERSON');
END;
/