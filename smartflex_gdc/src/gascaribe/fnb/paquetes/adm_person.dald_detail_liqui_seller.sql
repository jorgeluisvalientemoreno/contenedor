CREATE OR REPLACE PACKAGE adm_person.dald_detail_liqui_seller IS

  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  04/06/2024   Adrianavg   OSF-2766: Se migra del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
  CURSOR cuRecord(
		inuDETAIL_LIQUI_SELLER_Id in LD_detail_liqui_seller.DETAIL_LIQUI_SELLER_Id%type) IS
		SELECT LD_detail_liqui_seller.*,LD_detail_liqui_seller.rowid
		FROM LD_detail_liqui_seller
		WHERE
			DETAIL_LIQUI_SELLER_Id = inuDETAIL_LIQUI_SELLER_Id;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId(
		irirowid in varchar2) IS
		SELECT LD_detail_liqui_seller.*,LD_detail_liqui_seller.rowid
		FROM LD_detail_liqui_seller
		WHERE rowId = irirowid;


	/* Subtipos */
	subtype styLD_detail_liqui_seller  is  cuRecord%rowtype;
	type tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_detail_liqui_seller is table of styLD_detail_liqui_seller index by binary_integer;
	type tyrfRecords is ref cursor return styLD_detail_liqui_seller;

	/* Tipos referenciando al registro */
	type tytbDetail_Liqui_Seller_Id is table of LD_detail_liqui_seller.Detail_Liqui_Seller_Id%type index by binary_integer;
	type tytbLiquidation_Seller_Id is table of LD_detail_liqui_seller.Liquidation_Seller_Id%type index by binary_integer;
	type tytbId_Contratista is table of LD_detail_liqui_seller.Id_Contratista%type index by binary_integer;
	type tytbArticle_Id is table of LD_detail_liqui_seller.Article_Id%type index by binary_integer;
	type tytbConccodi is table of LD_detail_liqui_seller.Conccodi%type index by binary_integer;
	type tytbPercentage_Liquidation is table of LD_detail_liqui_seller.Percentage_Liquidation%type index by binary_integer;
	type tytbValue_Paid is table of LD_detail_liqui_seller.Value_Paid%type index by binary_integer;
	type tytbBase_Order_Id is table of LD_detail_liqui_seller.Base_Order_Id%type index by binary_integer;
	type tytbValue_Base is table of LD_detail_liqui_seller.Value_Base%type index by binary_integer;
	type tytbInclu_Vat_Reco_Commi is table of LD_detail_liqui_seller.Inclu_Vat_Reco_Commi%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_detail_liqui_seller is record(

		Detail_Liqui_Seller_Id   tytbDetail_Liqui_Seller_Id,
		Liquidation_Seller_Id   tytbLiquidation_Seller_Id,
		Id_Contratista   tytbId_Contratista,
		Article_Id   tytbArticle_Id,
		Conccodi   tytbConccodi,
		Percentage_Liquidation   tytbPercentage_Liquidation,
		Value_Paid   tytbValue_Paid,
		Base_Order_Id   tytbBase_Order_Id,
		Value_Base   tytbValue_Base,
		Inclu_Vat_Reco_Commi   tytbInclu_Vat_Reco_Commi,
		row_id tytbrowid);


	 /***** Metodos Publicos ****/
	/*Obtener el ID de la tabla en Ge_Entity*/
	FUNCTION fnuGetEntityIdByName(isbTName IN ge_entity.name_%TYPE)
	   RETURN ge_entity.entity_id%TYPE;
    FUNCTION fsbVersion RETURN varchar2;

	FUNCTION fsbGetMessageDescription return varchar2;

	PROCEDURE ClearMemory;

   FUNCTION fblExist(
		inuDETAIL_LIQUI_SELLER_Id in LD_detail_liqui_seller.DETAIL_LIQUI_SELLER_Id%type) RETURN boolean;

	 PROCEDURE AccKey(
		 inuDETAIL_LIQUI_SELLER_Id in LD_detail_liqui_seller.DETAIL_LIQUI_SELLER_Id%type);

	PROCEDURE AccKeyByRowId(
		iriRowID    in rowid);

	PROCEDURE ValDuplicate(
		 inuDETAIL_LIQUI_SELLER_Id in LD_detail_liqui_seller.DETAIL_LIQUI_SELLER_Id%type);

	PROCEDURE getRecord(
		inuDETAIL_LIQUI_SELLER_Id in LD_detail_liqui_seller.DETAIL_LIQUI_SELLER_Id%type,
		orcRecord out nocopy styLD_detail_liqui_seller
	);

	FUNCTION frcGetRcData(
		inuDETAIL_LIQUI_SELLER_Id in LD_detail_liqui_seller.DETAIL_LIQUI_SELLER_Id%type)
	RETURN styLD_detail_liqui_seller;

	FUNCTION frcGetRcData
	RETURN styLD_detail_liqui_seller;

	FUNCTION frcGetRecord(
		inuDETAIL_LIQUI_SELLER_Id in LD_detail_liqui_seller.DETAIL_LIQUI_SELLER_Id%type)
	RETURN styLD_detail_liqui_seller;

	PROCEDURE getRecords(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_detail_liqui_seller
	);

	FUNCTION frfGetRecords(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false)
	RETURN tyRefCursor;

	PROCEDURE insRecord(
		ircLD_detail_liqui_seller in styLD_detail_liqui_seller
	);

 	  PROCEDURE insRecord(
		ircLD_detail_liqui_seller in styLD_detail_liqui_seller,
		orirowid   out varchar2);

	PROCEDURE insRecords(
		iotbLD_detail_liqui_seller in out nocopy tytbLD_detail_liqui_seller
	);

	PROCEDURE delRecord(
		inuDETAIL_LIQUI_SELLER_Id in LD_detail_liqui_seller.DETAIL_LIQUI_SELLER_Id%type, inuLock in number default 1);

	PROCEDURE delByRowID(
		iriRowID    in rowid,
		inuLock in number default 1);

	PROCEDURE delRecords
	(
		iotbLD_detail_liqui_seller in out nocopy tytbLD_detail_liqui_seller,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_detail_liqui_seller in styLD_detail_liqui_seller,
		inuLock	  in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_detail_liqui_seller in out nocopy tytbLD_detail_liqui_seller,
		inuLock in number default 1
	);

		PROCEDURE updLiquidation_Seller_Id
		(
				inuDETAIL_LIQUI_SELLER_Id   in LD_detail_liqui_seller.DETAIL_LIQUI_SELLER_Id%type,
				inuLiquidation_Seller_Id$  in LD_detail_liqui_seller.Liquidation_Seller_Id%type,
				inuLock	  in number default 0);

		PROCEDURE updId_Contratista
		(
				inuDETAIL_LIQUI_SELLER_Id   in LD_detail_liqui_seller.DETAIL_LIQUI_SELLER_Id%type,
				inuId_Contratista$  in LD_detail_liqui_seller.Id_Contratista%type,
				inuLock	  in number default 0);

		PROCEDURE updArticle_Id
		(
				inuDETAIL_LIQUI_SELLER_Id   in LD_detail_liqui_seller.DETAIL_LIQUI_SELLER_Id%type,
				inuArticle_Id$  in LD_detail_liqui_seller.Article_Id%type,
				inuLock	  in number default 0);

		PROCEDURE updConccodi
		(
				inuDETAIL_LIQUI_SELLER_Id   in LD_detail_liqui_seller.DETAIL_LIQUI_SELLER_Id%type,
				inuConccodi$  in LD_detail_liqui_seller.Conccodi%type,
				inuLock	  in number default 0);

		PROCEDURE updPercentage_Liquidation
		(
				inuDETAIL_LIQUI_SELLER_Id   in LD_detail_liqui_seller.DETAIL_LIQUI_SELLER_Id%type,
				inuPercentage_Liquidation$  in LD_detail_liqui_seller.Percentage_Liquidation%type,
				inuLock	  in number default 0);

		PROCEDURE updValue_Paid
		(
				inuDETAIL_LIQUI_SELLER_Id   in LD_detail_liqui_seller.DETAIL_LIQUI_SELLER_Id%type,
				inuValue_Paid$  in LD_detail_liqui_seller.Value_Paid%type,
				inuLock	  in number default 0);

		PROCEDURE updBase_Order_Id
		(
				inuDETAIL_LIQUI_SELLER_Id   in LD_detail_liqui_seller.DETAIL_LIQUI_SELLER_Id%type,
				inuBase_Order_Id$  in LD_detail_liqui_seller.Base_Order_Id%type,
				inuLock	  in number default 0);

		PROCEDURE updValue_Base
		(
				inuDETAIL_LIQUI_SELLER_Id   in LD_detail_liqui_seller.DETAIL_LIQUI_SELLER_Id%type,
				inuValue_Base$  in LD_detail_liqui_seller.Value_Base%type,
				inuLock	  in number default 0);

		PROCEDURE updInclu_Vat_Reco_Commi
		(
				inuDETAIL_LIQUI_SELLER_Id   in LD_detail_liqui_seller.DETAIL_LIQUI_SELLER_Id%type,
				isbInclu_Vat_Reco_Commi$  in LD_detail_liqui_seller.Inclu_Vat_Reco_Commi%type,
				inuLock	  in number default 0);

    	FUNCTION fnuGetDetail_Liqui_Seller_Id
    	(
    	    inuDETAIL_LIQUI_SELLER_Id in LD_detail_liqui_seller.DETAIL_LIQUI_SELLER_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_detail_liqui_seller.Detail_Liqui_Seller_Id%type;

    	FUNCTION fnuGetLiquidation_Seller_Id
    	(
    	    inuDETAIL_LIQUI_SELLER_Id in LD_detail_liqui_seller.DETAIL_LIQUI_SELLER_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_detail_liqui_seller.Liquidation_Seller_Id%type;

    	FUNCTION fnuGetId_Contratista
    	(
    	    inuDETAIL_LIQUI_SELLER_Id in LD_detail_liqui_seller.DETAIL_LIQUI_SELLER_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_detail_liqui_seller.Id_Contratista%type;

    	FUNCTION fnuGetArticle_Id
    	(
    	    inuDETAIL_LIQUI_SELLER_Id in LD_detail_liqui_seller.DETAIL_LIQUI_SELLER_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_detail_liqui_seller.Article_Id%type;

    	FUNCTION fnuGetConccodi
    	(
    	    inuDETAIL_LIQUI_SELLER_Id in LD_detail_liqui_seller.DETAIL_LIQUI_SELLER_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_detail_liqui_seller.Conccodi%type;

    	FUNCTION fnuGetPercentage_Liquidation
    	(
    	    inuDETAIL_LIQUI_SELLER_Id in LD_detail_liqui_seller.DETAIL_LIQUI_SELLER_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_detail_liqui_seller.Percentage_Liquidation%type;

    	FUNCTION fnuGetValue_Paid
    	(
    	    inuDETAIL_LIQUI_SELLER_Id in LD_detail_liqui_seller.DETAIL_LIQUI_SELLER_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_detail_liqui_seller.Value_Paid%type;

    	FUNCTION fnuGetBase_Order_Id
    	(
    	    inuDETAIL_LIQUI_SELLER_Id in LD_detail_liqui_seller.DETAIL_LIQUI_SELLER_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_detail_liqui_seller.Base_Order_Id%type;

    	FUNCTION fnuGetValue_Base
    	(
    	    inuDETAIL_LIQUI_SELLER_Id in LD_detail_liqui_seller.DETAIL_LIQUI_SELLER_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_detail_liqui_seller.Value_Base%type;

    	FUNCTION fsbGetInclu_Vat_Reco_Commi
    	(
    	    inuDETAIL_LIQUI_SELLER_Id in LD_detail_liqui_seller.DETAIL_LIQUI_SELLER_Id%type,
		      inuRaiseError in number default 1
    	)
      RETURN LD_detail_liqui_seller.Inclu_Vat_Reco_Commi%type;


	PROCEDURE LockByPk
	(
		inuDETAIL_LIQUI_SELLER_Id in LD_detail_liqui_seller.DETAIL_LIQUI_SELLER_Id%type,
		orcLD_detail_liqui_seller  out styLD_detail_liqui_seller
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_detail_liqui_seller  out styLD_detail_liqui_seller
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_detail_liqui_seller;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALD_detail_liqui_seller
IS
    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO156917';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_DETAIL_LIQUI_SELLER';
	  cnuGeEntityId constant varchar2(30) := fnuGetEntityIdByName('LD_DETAIL_LIQUI_SELLER'); -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuDETAIL_LIQUI_SELLER_Id in LD_detail_liqui_seller.DETAIL_LIQUI_SELLER_Id%type
	)
	IS
		SELECT LD_detail_liqui_seller.*,LD_detail_liqui_seller.rowid
		FROM LD_detail_liqui_seller
		WHERE  DETAIL_LIQUI_SELLER_Id = inuDETAIL_LIQUI_SELLER_Id
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_detail_liqui_seller.*,LD_detail_liqui_seller.rowid
		FROM LD_detail_liqui_seller
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;
	/*Tipos*/
	type tyrfLD_detail_liqui_seller is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_detail_liqui_seller;

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

	FUNCTION fsbPrimaryKey( rcI in styLD_detail_liqui_seller default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.DETAIL_LIQUI_SELLER_Id);
		sbPk:=sbPk||']';
		return sbPk;
	END;

	PROCEDURE LockByPk
	(
		inuDETAIL_LIQUI_SELLER_Id in LD_detail_liqui_seller.DETAIL_LIQUI_SELLER_Id%type,
		orcLD_detail_liqui_seller  out styLD_detail_liqui_seller
	)
	IS
		rcError styLD_detail_liqui_seller;
	BEGIN
		rcError.DETAIL_LIQUI_SELLER_Id := inuDETAIL_LIQUI_SELLER_Id;

		Open cuLockRcByPk
		(
			inuDETAIL_LIQUI_SELLER_Id
		);

		fetch cuLockRcByPk into orcLD_detail_liqui_seller;
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
		orcLD_detail_liqui_seller  out styLD_detail_liqui_seller
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_detail_liqui_seller;
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
		itbLD_detail_liqui_seller  in out nocopy tytbLD_detail_liqui_seller
	)
	IS
	BEGIN
			rcRecOfTab.Detail_Liqui_Seller_Id.delete;
			rcRecOfTab.Liquidation_Seller_Id.delete;
			rcRecOfTab.Id_Contratista.delete;
			rcRecOfTab.Article_Id.delete;
			rcRecOfTab.Conccodi.delete;
			rcRecOfTab.Percentage_Liquidation.delete;
			rcRecOfTab.Value_Paid.delete;
			rcRecOfTab.Base_Order_Id.delete;
			rcRecOfTab.Value_Base.delete;
			rcRecOfTab.Inclu_Vat_Reco_Commi.delete;
	    rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_detail_liqui_seller  in out nocopy tytbLD_detail_liqui_seller,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_detail_liqui_seller);
		for n in itbLD_detail_liqui_seller.first .. itbLD_detail_liqui_seller.last loop
			rcRecOfTab.Detail_Liqui_Seller_Id(n) := itbLD_detail_liqui_seller(n).Detail_Liqui_Seller_Id;
			rcRecOfTab.Liquidation_Seller_Id(n) := itbLD_detail_liqui_seller(n).Liquidation_Seller_Id;
			rcRecOfTab.Id_Contratista(n) := itbLD_detail_liqui_seller(n).Id_Contratista;
			rcRecOfTab.Article_Id(n) := itbLD_detail_liqui_seller(n).Article_Id;
			rcRecOfTab.Conccodi(n) := itbLD_detail_liqui_seller(n).Conccodi;
			rcRecOfTab.Percentage_Liquidation(n) := itbLD_detail_liqui_seller(n).Percentage_Liquidation;
			rcRecOfTab.Value_Paid(n) := itbLD_detail_liqui_seller(n).Value_Paid;
			rcRecOfTab.Base_Order_Id(n) := itbLD_detail_liqui_seller(n).Base_Order_Id;
			rcRecOfTab.Value_Base(n) := itbLD_detail_liqui_seller(n).Value_Base;
			rcRecOfTab.Inclu_Vat_Reco_Commi(n) := itbLD_detail_liqui_seller(n).Inclu_Vat_Reco_Commi;
			rcRecOfTab.row_id(n) := itbLD_detail_liqui_seller(n).rowid;
			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;


	PROCEDURE Load
	(
		inuDETAIL_LIQUI_SELLER_Id in LD_detail_liqui_seller.DETAIL_LIQUI_SELLER_Id%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuDETAIL_LIQUI_SELLER_Id
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
		inuDETAIL_LIQUI_SELLER_Id in LD_detail_liqui_seller.DETAIL_LIQUI_SELLER_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuDETAIL_LIQUI_SELLER_Id = rcData.DETAIL_LIQUI_SELLER_Id
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
		inuDETAIL_LIQUI_SELLER_Id in LD_detail_liqui_seller.DETAIL_LIQUI_SELLER_Id%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuDETAIL_LIQUI_SELLER_Id
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;

	PROCEDURE AccKey
	(
		inuDETAIL_LIQUI_SELLER_Id in LD_detail_liqui_seller.DETAIL_LIQUI_SELLER_Id%type
	)
	IS
		rcError styLD_detail_liqui_seller;
	BEGIN		rcError.DETAIL_LIQUI_SELLER_Id:=inuDETAIL_LIQUI_SELLER_Id;

		Load
		(
			inuDETAIL_LIQUI_SELLER_Id
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
		inuDETAIL_LIQUI_SELLER_Id in LD_detail_liqui_seller.DETAIL_LIQUI_SELLER_Id%type
	)
	IS
	BEGIN
		Load
		(
			inuDETAIL_LIQUI_SELLER_Id
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;

	PROCEDURE getRecord
	(
		inuDETAIL_LIQUI_SELLER_Id in LD_detail_liqui_seller.DETAIL_LIQUI_SELLER_Id%type,
		orcRecord out nocopy styLD_detail_liqui_seller
	)
	IS
		rcError styLD_detail_liqui_seller;
	BEGIN		rcError.DETAIL_LIQUI_SELLER_Id:=inuDETAIL_LIQUI_SELLER_Id;

		Load
		(
			inuDETAIL_LIQUI_SELLER_Id
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRecord
	(
		inuDETAIL_LIQUI_SELLER_Id in LD_detail_liqui_seller.DETAIL_LIQUI_SELLER_Id%type
	)
	RETURN styLD_detail_liqui_seller
	IS
		rcError styLD_detail_liqui_seller;
	BEGIN
		rcError.DETAIL_LIQUI_SELLER_Id:=inuDETAIL_LIQUI_SELLER_Id;

		Load
		(
			inuDETAIL_LIQUI_SELLER_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	(
		inuDETAIL_LIQUI_SELLER_Id in LD_detail_liqui_seller.DETAIL_LIQUI_SELLER_Id%type
	)
	RETURN styLD_detail_liqui_seller
	IS
		rcError styLD_detail_liqui_seller;
	BEGIN
		rcError.DETAIL_LIQUI_SELLER_Id:=inuDETAIL_LIQUI_SELLER_Id;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuDETAIL_LIQUI_SELLER_Id
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuDETAIL_LIQUI_SELLER_Id
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_detail_liqui_seller
	IS
	BEGIN
		return(rcData);
	END;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_detail_liqui_seller
	)
	IS
		rfLD_detail_liqui_seller tyrfLD_detail_liqui_seller;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LD_detail_liqui_seller.*,
		            LD_detail_liqui_seller.rowid
                FROM LD_detail_liqui_seller';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;
		open rfLD_detail_liqui_seller for sbFullQuery;
		fetch rfLD_detail_liqui_seller bulk collect INTO otbResult;
		close rfLD_detail_liqui_seller;
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
		sbSQL  VARCHAR2 (32000) := 'select LD_detail_liqui_seller.*,
		            LD_detail_liqui_seller.rowid
                FROM LD_detail_liqui_seller';
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
		ircLD_detail_liqui_seller in styLD_detail_liqui_seller
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_detail_liqui_seller,rirowid);
	END;

	PROCEDURE insRecord
	(
		ircLD_detail_liqui_seller in styLD_detail_liqui_seller,
		orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_detail_liqui_seller.DETAIL_LIQUI_SELLER_Id is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|DETAIL_LIQUI_SELLER_Id');
			raise ex.controlled_error;
		end if;
		insert into LD_detail_liqui_seller
		(
			Detail_Liqui_Seller_Id,
			Liquidation_Seller_Id,
			Id_Contratista,
			Article_Id,
			Conccodi,
			Percentage_Liquidation,
			Value_Paid,
			Base_Order_Id,
			Value_Base,
			Inclu_Vat_Reco_Commi
		)
		values
		(
			ircLD_detail_liqui_seller.Detail_Liqui_Seller_Id,
			ircLD_detail_liqui_seller.Liquidation_Seller_Id,
			ircLD_detail_liqui_seller.Id_Contratista,
			ircLD_detail_liqui_seller.Article_Id,
			ircLD_detail_liqui_seller.Conccodi,
			ircLD_detail_liqui_seller.Percentage_Liquidation,
			ircLD_detail_liqui_seller.Value_Paid,
			ircLD_detail_liqui_seller.Base_Order_Id,
			ircLD_detail_liqui_seller.Value_Base,
			ircLD_detail_liqui_seller.Inclu_Vat_Reco_Commi
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_detail_liqui_seller));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE insRecords
	(
		iotbLD_detail_liqui_seller in out nocopy tytbLD_detail_liqui_seller
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_detail_liqui_seller, blUseRowID);
		forall n in iotbLD_detail_liqui_seller.first..iotbLD_detail_liqui_seller.last
			insert into LD_detail_liqui_seller
			(
			Detail_Liqui_Seller_Id,
			Liquidation_Seller_Id,
			Id_Contratista,
			Article_Id,
			Conccodi,
			Percentage_Liquidation,
			Value_Paid,
			Base_Order_Id,
			Value_Base,
			Inclu_Vat_Reco_Commi
		)
		values
		(
			rcRecOfTab.Detail_Liqui_Seller_Id(n),
			rcRecOfTab.Liquidation_Seller_Id(n),
			rcRecOfTab.Id_Contratista(n),
			rcRecOfTab.Article_Id(n),
			rcRecOfTab.Conccodi(n),
			rcRecOfTab.Percentage_Liquidation(n),
			rcRecOfTab.Value_Paid(n),
			rcRecOfTab.Base_Order_Id(n),
			rcRecOfTab.Value_Base(n),
			rcRecOfTab.Inclu_Vat_Reco_Commi(n)
			);
	EXCEPTION
		when dup_val_on_index then
						Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE delRecord
	(
		inuDETAIL_LIQUI_SELLER_Id in LD_detail_liqui_seller.DETAIL_LIQUI_SELLER_Id%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_detail_liqui_seller;
	BEGIN
		rcError.DETAIL_LIQUI_SELLER_Id:=inuDETAIL_LIQUI_SELLER_Id;

		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_LIQUI_SELLER_Id,
				rcData
			);
		end if;

		delete
		from LD_detail_liqui_seller
		where
       		DETAIL_LIQUI_SELLER_Id=inuDETAIL_LIQUI_SELLER_Id;
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
		rcError  styLD_detail_liqui_seller;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;

		delete
		from LD_detail_liqui_seller
		where
			rowid = iriRowID
		returning
   DETAIL_LIQUI_SELLER_Id
		into
			rcError.DETAIL_LIQUI_SELLER_Id;

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
		iotbLD_detail_liqui_seller in out nocopy tytbLD_detail_liqui_seller,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_detail_liqui_seller;
	BEGIN
		FillRecordOfTables(iotbLD_detail_liqui_seller, blUseRowID);
       if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_detail_liqui_seller.first .. iotbLD_detail_liqui_seller.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_detail_liqui_seller.first .. iotbLD_detail_liqui_seller.last
				delete
				from LD_detail_liqui_seller
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_detail_liqui_seller.first .. iotbLD_detail_liqui_seller.last loop
					LockByPk
					(
							rcRecOfTab.DETAIL_LIQUI_SELLER_Id(n),
							rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_detail_liqui_seller.first .. iotbLD_detail_liqui_seller.last
				delete
				from LD_detail_liqui_seller
				where
		         	DETAIL_LIQUI_SELLER_Id = rcRecOfTab.DETAIL_LIQUI_SELLER_Id(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                                    Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updRecord
	(
		ircLD_detail_liqui_seller in styLD_detail_liqui_seller,
		inuLock	  in number default 0
	)
	IS
		nuDETAIL_LIQUI_SELLER_Id LD_detail_liqui_seller.DETAIL_LIQUI_SELLER_Id%type;

	BEGIN
		if ircLD_detail_liqui_seller.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_detail_liqui_seller.rowid,rcData);
			end if;
			update LD_detail_liqui_seller
			set

        Liquidation_Seller_Id = ircLD_detail_liqui_seller.Liquidation_Seller_Id,
        Id_Contratista = ircLD_detail_liqui_seller.Id_Contratista,
        Article_Id = ircLD_detail_liqui_seller.Article_Id,
        Conccodi = ircLD_detail_liqui_seller.Conccodi,
        Percentage_Liquidation = ircLD_detail_liqui_seller.Percentage_Liquidation,
        Value_Paid = ircLD_detail_liqui_seller.Value_Paid,
        Base_Order_Id = ircLD_detail_liqui_seller.Base_Order_Id,
        Value_Base = ircLD_detail_liqui_seller.Value_Base,
        Inclu_Vat_Reco_Commi = ircLD_detail_liqui_seller.Inclu_Vat_Reco_Commi
			where
				rowid = ircLD_detail_liqui_seller.rowid
			returning
    DETAIL_LIQUI_SELLER_Id
			into
				nuDETAIL_LIQUI_SELLER_Id;

		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_detail_liqui_seller.DETAIL_LIQUI_SELLER_Id,
					rcData
				);
			end if;

			update LD_detail_liqui_seller
			set
        Liquidation_Seller_Id = ircLD_detail_liqui_seller.Liquidation_Seller_Id,
        Id_Contratista = ircLD_detail_liqui_seller.Id_Contratista,
        Article_Id = ircLD_detail_liqui_seller.Article_Id,
        Conccodi = ircLD_detail_liqui_seller.Conccodi,
        Percentage_Liquidation = ircLD_detail_liqui_seller.Percentage_Liquidation,
        Value_Paid = ircLD_detail_liqui_seller.Value_Paid,
        Base_Order_Id = ircLD_detail_liqui_seller.Base_Order_Id,
        Value_Base = ircLD_detail_liqui_seller.Value_Base,
        Inclu_Vat_Reco_Commi = ircLD_detail_liqui_seller.Inclu_Vat_Reco_Commi
			where
	         	DETAIL_LIQUI_SELLER_Id = ircLD_detail_liqui_seller.DETAIL_LIQUI_SELLER_Id
			returning
    DETAIL_LIQUI_SELLER_Id
			into
				nuDETAIL_LIQUI_SELLER_Id;
		end if;

		if
			nuDETAIL_LIQUI_SELLER_Id is NULL
		then
			raise no_data_found;
		end if;

	EXCEPTION
		when no_data_found then
						Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_detail_liqui_seller));
			raise ex.CONTROLLED_ERROR;
	END;

  PROCEDURE updRecords
  (
    iotbLD_detail_liqui_seller in out nocopy tytbLD_detail_liqui_seller,
    inuLock in number default 1
  )
  IS
    blUseRowID boolean;
    rcAux styLD_detail_liqui_seller;
  BEGIN
    FillRecordOfTables(iotbLD_detail_liqui_seller,blUseRowID);
    if blUseRowID then
      if inuLock = 1 then
        for n in iotbLD_detail_liqui_seller.first .. iotbLD_detail_liqui_seller.last loop
          LockByRowId
          (
            rcRecOfTab.row_id(n),
            rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_detail_liqui_seller.first .. iotbLD_detail_liqui_seller.last
        update LD_detail_liqui_seller
        set

            Liquidation_Seller_Id = rcRecOfTab.Liquidation_Seller_Id(n),
            Id_Contratista = rcRecOfTab.Id_Contratista(n),
            Article_Id = rcRecOfTab.Article_Id(n),
            Conccodi = rcRecOfTab.Conccodi(n),
            Percentage_Liquidation = rcRecOfTab.Percentage_Liquidation(n),
            Value_Paid = rcRecOfTab.Value_Paid(n),
            Base_Order_Id = rcRecOfTab.Base_Order_Id(n),
            Value_Base = rcRecOfTab.Value_Base(n),
            Inclu_Vat_Reco_Commi = rcRecOfTab.Inclu_Vat_Reco_Commi(n)
          where
					rowid =  rcRecOfTab.row_id(n);
    else
      if inuLock = 1 then
        for n in iotbLD_detail_liqui_seller.first .. iotbLD_detail_liqui_seller.last loop
          LockByPk
          (
              rcRecOfTab.DETAIL_LIQUI_SELLER_Id(n),
              rcAux
          );
        end loop;
      end if;

      forall n in iotbLD_detail_liqui_seller.first .. iotbLD_detail_liqui_seller.last
        update LD_detail_liqui_seller
        set
					Liquidation_Seller_Id = rcRecOfTab.Liquidation_Seller_Id(n),
					Id_Contratista = rcRecOfTab.Id_Contratista(n),
					Article_Id = rcRecOfTab.Article_Id(n),
					Conccodi = rcRecOfTab.Conccodi(n),
					Percentage_Liquidation = rcRecOfTab.Percentage_Liquidation(n),
					Value_Paid = rcRecOfTab.Value_Paid(n),
					Base_Order_Id = rcRecOfTab.Base_Order_Id(n),
					Value_Base = rcRecOfTab.Value_Base(n),
					Inclu_Vat_Reco_Commi = rcRecOfTab.Inclu_Vat_Reco_Commi(n)
          where
          DETAIL_LIQUI_SELLER_Id = rcRecOfTab.DETAIL_LIQUI_SELLER_Id(n)
;
    end if;
  END;

	PROCEDURE updLiquidation_Seller_Id
	(
		inuDETAIL_LIQUI_SELLER_Id in LD_detail_liqui_seller.DETAIL_LIQUI_SELLER_Id%type,
		inuLiquidation_Seller_Id$ in LD_detail_liqui_seller.Liquidation_Seller_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_detail_liqui_seller;
	BEGIN
		rcError.DETAIL_LIQUI_SELLER_Id := inuDETAIL_LIQUI_SELLER_Id;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_LIQUI_SELLER_Id,
				rcData
			);
		end if;

		update LD_detail_liqui_seller
		set
			Liquidation_Seller_Id = inuLiquidation_Seller_Id$
		where
			DETAIL_LIQUI_SELLER_Id = inuDETAIL_LIQUI_SELLER_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Liquidation_Seller_Id:= inuLiquidation_Seller_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updId_Contratista
	(
		inuDETAIL_LIQUI_SELLER_Id in LD_detail_liqui_seller.DETAIL_LIQUI_SELLER_Id%type,
		inuId_Contratista$ in LD_detail_liqui_seller.Id_Contratista%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_detail_liqui_seller;
	BEGIN
		rcError.DETAIL_LIQUI_SELLER_Id := inuDETAIL_LIQUI_SELLER_Id;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_LIQUI_SELLER_Id,
				rcData
			);
		end if;

		update LD_detail_liqui_seller
		set
			Id_Contratista = inuId_Contratista$
		where
			DETAIL_LIQUI_SELLER_Id = inuDETAIL_LIQUI_SELLER_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Id_Contratista:= inuId_Contratista$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updArticle_Id
	(
		inuDETAIL_LIQUI_SELLER_Id in LD_detail_liqui_seller.DETAIL_LIQUI_SELLER_Id%type,
		inuArticle_Id$ in LD_detail_liqui_seller.Article_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_detail_liqui_seller;
	BEGIN
		rcError.DETAIL_LIQUI_SELLER_Id := inuDETAIL_LIQUI_SELLER_Id;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_LIQUI_SELLER_Id,
				rcData
			);
		end if;

		update LD_detail_liqui_seller
		set
			Article_Id = inuArticle_Id$
		where
			DETAIL_LIQUI_SELLER_Id = inuDETAIL_LIQUI_SELLER_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Article_Id:= inuArticle_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updConccodi
	(
		inuDETAIL_LIQUI_SELLER_Id in LD_detail_liqui_seller.DETAIL_LIQUI_SELLER_Id%type,
		inuConccodi$ in LD_detail_liqui_seller.Conccodi%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_detail_liqui_seller;
	BEGIN
		rcError.DETAIL_LIQUI_SELLER_Id := inuDETAIL_LIQUI_SELLER_Id;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_LIQUI_SELLER_Id,
				rcData
			);
		end if;

		update LD_detail_liqui_seller
		set
			Conccodi = inuConccodi$
		where
			DETAIL_LIQUI_SELLER_Id = inuDETAIL_LIQUI_SELLER_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Conccodi:= inuConccodi$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updPercentage_Liquidation
	(
		inuDETAIL_LIQUI_SELLER_Id in LD_detail_liqui_seller.DETAIL_LIQUI_SELLER_Id%type,
		inuPercentage_Liquidation$ in LD_detail_liqui_seller.Percentage_Liquidation%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_detail_liqui_seller;
	BEGIN
		rcError.DETAIL_LIQUI_SELLER_Id := inuDETAIL_LIQUI_SELLER_Id;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_LIQUI_SELLER_Id,
				rcData
			);
		end if;

		update LD_detail_liqui_seller
		set
			Percentage_Liquidation = inuPercentage_Liquidation$
		where
			DETAIL_LIQUI_SELLER_Id = inuDETAIL_LIQUI_SELLER_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Percentage_Liquidation:= inuPercentage_Liquidation$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updValue_Paid
	(
		inuDETAIL_LIQUI_SELLER_Id in LD_detail_liqui_seller.DETAIL_LIQUI_SELLER_Id%type,
		inuValue_Paid$ in LD_detail_liqui_seller.Value_Paid%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_detail_liqui_seller;
	BEGIN
		rcError.DETAIL_LIQUI_SELLER_Id := inuDETAIL_LIQUI_SELLER_Id;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_LIQUI_SELLER_Id,
				rcData
			);
		end if;

		update LD_detail_liqui_seller
		set
			Value_Paid = inuValue_Paid$
		where
			DETAIL_LIQUI_SELLER_Id = inuDETAIL_LIQUI_SELLER_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Value_Paid:= inuValue_Paid$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updBase_Order_Id
	(
		inuDETAIL_LIQUI_SELLER_Id in LD_detail_liqui_seller.DETAIL_LIQUI_SELLER_Id%type,
		inuBase_Order_Id$ in LD_detail_liqui_seller.Base_Order_Id%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_detail_liqui_seller;
	BEGIN
		rcError.DETAIL_LIQUI_SELLER_Id := inuDETAIL_LIQUI_SELLER_Id;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_LIQUI_SELLER_Id,
				rcData
			);
		end if;

		update LD_detail_liqui_seller
		set
			Base_Order_Id = inuBase_Order_Id$
		where
			DETAIL_LIQUI_SELLER_Id = inuDETAIL_LIQUI_SELLER_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Base_Order_Id:= inuBase_Order_Id$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updValue_Base
	(
		inuDETAIL_LIQUI_SELLER_Id in LD_detail_liqui_seller.DETAIL_LIQUI_SELLER_Id%type,
		inuValue_Base$ in LD_detail_liqui_seller.Value_Base%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_detail_liqui_seller;
	BEGIN
		rcError.DETAIL_LIQUI_SELLER_Id := inuDETAIL_LIQUI_SELLER_Id;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_LIQUI_SELLER_Id,
				rcData
			);
		end if;

		update LD_detail_liqui_seller
		set
			Value_Base = inuValue_Base$
		where
			DETAIL_LIQUI_SELLER_Id = inuDETAIL_LIQUI_SELLER_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Value_Base:= inuValue_Base$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updInclu_Vat_Reco_Commi
	(
		inuDETAIL_LIQUI_SELLER_Id in LD_detail_liqui_seller.DETAIL_LIQUI_SELLER_Id%type,
		isbInclu_Vat_Reco_Commi$ in LD_detail_liqui_seller.Inclu_Vat_Reco_Commi%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_detail_liqui_seller;
	BEGIN
		rcError.DETAIL_LIQUI_SELLER_Id := inuDETAIL_LIQUI_SELLER_Id;
		if inuLock=1 then
			LockByPk
			(
				inuDETAIL_LIQUI_SELLER_Id,
				rcData
			);
		end if;

		update LD_detail_liqui_seller
		set
			Inclu_Vat_Reco_Commi = isbInclu_Vat_Reco_Commi$
		where
			DETAIL_LIQUI_SELLER_Id = inuDETAIL_LIQUI_SELLER_Id;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.Inclu_Vat_Reco_Commi:= isbInclu_Vat_Reco_Commi$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;


	FUNCTION fnuGetDetail_Liqui_Seller_Id
	(
		inuDETAIL_LIQUI_SELLER_Id in LD_detail_liqui_seller.DETAIL_LIQUI_SELLER_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_detail_liqui_seller.Detail_Liqui_Seller_Id%type
	IS
		rcError styLD_detail_liqui_seller;
	BEGIN

		rcError.DETAIL_LIQUI_SELLER_Id := inuDETAIL_LIQUI_SELLER_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuDETAIL_LIQUI_SELLER_Id
			 )
		then
			 return(rcData.Detail_Liqui_Seller_Id);
		end if;
		Load
		(
			inuDETAIL_LIQUI_SELLER_Id
		);
		return(rcData.Detail_Liqui_Seller_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetLiquidation_Seller_Id
	(
		inuDETAIL_LIQUI_SELLER_Id in LD_detail_liqui_seller.DETAIL_LIQUI_SELLER_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_detail_liqui_seller.Liquidation_Seller_Id%type
	IS
		rcError styLD_detail_liqui_seller;
	BEGIN

		rcError.DETAIL_LIQUI_SELLER_Id := inuDETAIL_LIQUI_SELLER_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuDETAIL_LIQUI_SELLER_Id
			 )
		then
			 return(rcData.Liquidation_Seller_Id);
		end if;
		Load
		(
			inuDETAIL_LIQUI_SELLER_Id
		);
		return(rcData.Liquidation_Seller_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetId_Contratista
	(
		inuDETAIL_LIQUI_SELLER_Id in LD_detail_liqui_seller.DETAIL_LIQUI_SELLER_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_detail_liqui_seller.Id_Contratista%type
	IS
		rcError styLD_detail_liqui_seller;
	BEGIN

		rcError.DETAIL_LIQUI_SELLER_Id := inuDETAIL_LIQUI_SELLER_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuDETAIL_LIQUI_SELLER_Id
			 )
		then
			 return(rcData.Id_Contratista);
		end if;
		Load
		(
			inuDETAIL_LIQUI_SELLER_Id
		);
		return(rcData.Id_Contratista);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetArticle_Id
	(
		inuDETAIL_LIQUI_SELLER_Id in LD_detail_liqui_seller.DETAIL_LIQUI_SELLER_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_detail_liqui_seller.Article_Id%type
	IS
		rcError styLD_detail_liqui_seller;
	BEGIN

		rcError.DETAIL_LIQUI_SELLER_Id := inuDETAIL_LIQUI_SELLER_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuDETAIL_LIQUI_SELLER_Id
			 )
		then
			 return(rcData.Article_Id);
		end if;
		Load
		(
			inuDETAIL_LIQUI_SELLER_Id
		);
		return(rcData.Article_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetConccodi
	(
		inuDETAIL_LIQUI_SELLER_Id in LD_detail_liqui_seller.DETAIL_LIQUI_SELLER_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_detail_liqui_seller.Conccodi%type
	IS
		rcError styLD_detail_liqui_seller;
	BEGIN

		rcError.DETAIL_LIQUI_SELLER_Id := inuDETAIL_LIQUI_SELLER_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuDETAIL_LIQUI_SELLER_Id
			 )
		then
			 return(rcData.Conccodi);
		end if;
		Load
		(
			inuDETAIL_LIQUI_SELLER_Id
		);
		return(rcData.Conccodi);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetPercentage_Liquidation
	(
		inuDETAIL_LIQUI_SELLER_Id in LD_detail_liqui_seller.DETAIL_LIQUI_SELLER_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_detail_liqui_seller.Percentage_Liquidation%type
	IS
		rcError styLD_detail_liqui_seller;
	BEGIN

		rcError.DETAIL_LIQUI_SELLER_Id := inuDETAIL_LIQUI_SELLER_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuDETAIL_LIQUI_SELLER_Id
			 )
		then
			 return(rcData.Percentage_Liquidation);
		end if;
		Load
		(
			inuDETAIL_LIQUI_SELLER_Id
		);
		return(rcData.Percentage_Liquidation);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetValue_Paid
	(
		inuDETAIL_LIQUI_SELLER_Id in LD_detail_liqui_seller.DETAIL_LIQUI_SELLER_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_detail_liqui_seller.Value_Paid%type
	IS
		rcError styLD_detail_liqui_seller;
	BEGIN

		rcError.DETAIL_LIQUI_SELLER_Id := inuDETAIL_LIQUI_SELLER_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuDETAIL_LIQUI_SELLER_Id
			 )
		then
			 return(rcData.Value_Paid);
		end if;
		Load
		(
			inuDETAIL_LIQUI_SELLER_Id
		);
		return(rcData.Value_Paid);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetBase_Order_Id
	(
		inuDETAIL_LIQUI_SELLER_Id in LD_detail_liqui_seller.DETAIL_LIQUI_SELLER_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_detail_liqui_seller.Base_Order_Id%type
	IS
		rcError styLD_detail_liqui_seller;
	BEGIN

		rcError.DETAIL_LIQUI_SELLER_Id := inuDETAIL_LIQUI_SELLER_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuDETAIL_LIQUI_SELLER_Id
			 )
		then
			 return(rcData.Base_Order_Id);
		end if;
		Load
		(
			inuDETAIL_LIQUI_SELLER_Id
		);
		return(rcData.Base_Order_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fnuGetValue_Base
	(
		inuDETAIL_LIQUI_SELLER_Id in LD_detail_liqui_seller.DETAIL_LIQUI_SELLER_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_detail_liqui_seller.Value_Base%type
	IS
		rcError styLD_detail_liqui_seller;
	BEGIN

		rcError.DETAIL_LIQUI_SELLER_Id := inuDETAIL_LIQUI_SELLER_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuDETAIL_LIQUI_SELLER_Id
			 )
		then
			 return(rcData.Value_Base);
		end if;
		Load
		(
			inuDETAIL_LIQUI_SELLER_Id
		);
		return(rcData.Value_Base);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fsbGetInclu_Vat_Reco_Commi
	(
		inuDETAIL_LIQUI_SELLER_Id in LD_detail_liqui_seller.DETAIL_LIQUI_SELLER_Id%type,
		inuRaiseError in number default 1
	)
    RETURN LD_detail_liqui_seller.Inclu_Vat_Reco_Commi%type
	IS
		rcError styLD_detail_liqui_seller;
	BEGIN

		rcError.DETAIL_LIQUI_SELLER_Id:=inuDETAIL_LIQUI_SELLER_Id;

		-- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
				inuDETAIL_LIQUI_SELLER_Id
			 )
		then
			 return(rcData.Inclu_Vat_Reco_Commi);
		end if;
		Load
		(
			inuDETAIL_LIQUI_SELLER_Id
		);
		return(rcData.Inclu_Vat_Reco_Commi);
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
end DALD_detail_liqui_seller;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALD_DETAIL_LIQUI_SELLER
BEGIN
    pkg_utilidades.prAplicarPermisos('DALD_DETAIL_LIQUI_SELLER', 'ADM_PERSON'); 
END;
/
