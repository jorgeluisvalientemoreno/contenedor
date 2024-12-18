CREATE OR REPLACE PACKAGE adm_person.daldc_coll_mgmt_pro_fin
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  11/06/2024   Adrianavg   OSF-2813: Migrar del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type
	)
	IS
		SELECT LDC_COLL_MGMT_PRO_FIN.*,LDC_COLL_MGMT_PRO_FIN.rowid
		FROM LDC_COLL_MGMT_PRO_FIN
		WHERE
		    COLL_MGMT_PRO_FIN_ID = inuCOLL_MGMT_PRO_FIN_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_COLL_MGMT_PRO_FIN.*,LDC_COLL_MGMT_PRO_FIN.rowid
		FROM LDC_COLL_MGMT_PRO_FIN
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_COLL_MGMT_PRO_FIN  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_COLL_MGMT_PRO_FIN is table of styLDC_COLL_MGMT_PRO_FIN index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_COLL_MGMT_PRO_FIN;

	/* Tipos referenciando al registro */
	type tytbCOLL_MGMT_PRO_FIN_ID is table of LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type index by binary_integer;
	type tytbORDER_ID is table of LDC_COLL_MGMT_PRO_FIN.ORDER_ID%type index by binary_integer;
	type tytbEXEC_PROCESS_NAME is table of LDC_COLL_MGMT_PRO_FIN.EXEC_PROCESS_NAME%type index by binary_integer;
	type tytbCOLL_MGMT_PROC_CR_ID is table of LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PROC_CR_ID%type index by binary_integer;
	type tytbIS_LEVEL_MAIN is table of LDC_COLL_MGMT_PRO_FIN.IS_LEVEL_MAIN%type index by binary_integer;
	type tytbSUBSCRIBER_ID is table of LDC_COLL_MGMT_PRO_FIN.SUBSCRIBER_ID%type index by binary_integer;
	type tytbSUBSCRIPTION_ID is table of LDC_COLL_MGMT_PRO_FIN.SUBSCRIPTION_ID%type index by binary_integer;
	type tytbPRODUCT_ID is table of LDC_COLL_MGMT_PRO_FIN.PRODUCT_ID%type index by binary_integer;
	type tytbDEBT_AGE is table of LDC_COLL_MGMT_PRO_FIN.DEBT_AGE%type index by binary_integer;
	type tytbTOTAL_DEBT is table of LDC_COLL_MGMT_PRO_FIN.TOTAL_DEBT%type index by binary_integer;
	type tytbOUTSTANDING_DEBT is table of LDC_COLL_MGMT_PRO_FIN.OUTSTANDING_DEBT%type index by binary_integer;
	type tytbOVERDUE_DEBT is table of LDC_COLL_MGMT_PRO_FIN.OVERDUE_DEBT%type index by binary_integer;
	type tytbDEFERRED_DEBT is table of LDC_COLL_MGMT_PRO_FIN.DEFERRED_DEBT%type index by binary_integer;
	type tytbPUNI_OVER_DEBT is table of LDC_COLL_MGMT_PRO_FIN.PUNI_OVER_DEBT%type index by binary_integer;
	type tytbREFINANCI_TIMES is table of LDC_COLL_MGMT_PRO_FIN.REFINANCI_TIMES%type index by binary_integer;
	type tytbFINANCING_PLAN_ID is table of LDC_COLL_MGMT_PRO_FIN.FINANCING_PLAN_ID%type index by binary_integer;
	type tytbOPERATING_UNIT_ID is table of LDC_COLL_MGMT_PRO_FIN.OPERATING_UNIT_ID%type index by binary_integer;
	type tytbTOTAL_COLLECTED is table of LDC_COLL_MGMT_PRO_FIN.TOTAL_COLLECTED%type index by binary_integer;
	type tytbDATE_REGISTER is table of LDC_COLL_MGMT_PRO_FIN.DATE_REGISTER%type index by binary_integer;
	type tytbDIAS_CORTE is table of LDC_COLL_MGMT_PRO_FIN.DIAS_CORTE%type index by binary_integer;
	type tytbDEPTO is table of LDC_COLL_MGMT_PRO_FIN.DEPTO%type index by binary_integer;
	type tytbLOCALIDAD is table of LDC_COLL_MGMT_PRO_FIN.LOCALIDAD%type index by binary_integer;
	type tytbIS_VOIDED is table of LDC_COLL_MGMT_PRO_FIN.IS_VOIDED%type index by binary_integer;
	type tytbESTAFINA is table of LDC_COLL_MGMT_PRO_FIN.ESTAFINA%type index by binary_integer;
	type tytbGEOGRAP_LOCATION_ID is table of LDC_COLL_MGMT_PRO_FIN.GEOGRAP_LOCATION_ID%type index by binary_integer;
	type tytbPROCESADO is table of LDC_COLL_MGMT_PRO_FIN.PROCESADO%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_COLL_MGMT_PRO_FIN is record
	(
		COLL_MGMT_PRO_FIN_ID   tytbCOLL_MGMT_PRO_FIN_ID,
		ORDER_ID   tytbORDER_ID,
		EXEC_PROCESS_NAME   tytbEXEC_PROCESS_NAME,
		COLL_MGMT_PROC_CR_ID   tytbCOLL_MGMT_PROC_CR_ID,
		IS_LEVEL_MAIN   tytbIS_LEVEL_MAIN,
		SUBSCRIBER_ID   tytbSUBSCRIBER_ID,
		SUBSCRIPTION_ID   tytbSUBSCRIPTION_ID,
		PRODUCT_ID   tytbPRODUCT_ID,
		DEBT_AGE   tytbDEBT_AGE,
		TOTAL_DEBT   tytbTOTAL_DEBT,
		OUTSTANDING_DEBT   tytbOUTSTANDING_DEBT,
		OVERDUE_DEBT   tytbOVERDUE_DEBT,
		DEFERRED_DEBT   tytbDEFERRED_DEBT,
		PUNI_OVER_DEBT   tytbPUNI_OVER_DEBT,
		REFINANCI_TIMES   tytbREFINANCI_TIMES,
		FINANCING_PLAN_ID   tytbFINANCING_PLAN_ID,
		OPERATING_UNIT_ID   tytbOPERATING_UNIT_ID,
		TOTAL_COLLECTED   tytbTOTAL_COLLECTED,
		DATE_REGISTER   tytbDATE_REGISTER,
		DIAS_CORTE   tytbDIAS_CORTE,
		DEPTO   tytbDEPTO,
		LOCALIDAD   tytbLOCALIDAD,
		IS_VOIDED   tytbIS_VOIDED,
		ESTAFINA   tytbESTAFINA,
		GEOGRAP_LOCATION_ID   tytbGEOGRAP_LOCATION_ID,
		PROCESADO   tytbPROCESADO,
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
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type
	);

	PROCEDURE getRecord
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		orcRecord out nocopy styLDC_COLL_MGMT_PRO_FIN
	);

	FUNCTION frcGetRcData
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type
	)
	RETURN styLDC_COLL_MGMT_PRO_FIN;

	FUNCTION frcGetRcData
	RETURN styLDC_COLL_MGMT_PRO_FIN;

	FUNCTION frcGetRecord
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type
	)
	RETURN styLDC_COLL_MGMT_PRO_FIN;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_COLL_MGMT_PRO_FIN
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_COLL_MGMT_PRO_FIN in styLDC_COLL_MGMT_PRO_FIN
	);

	PROCEDURE insRecord
	(
		ircLDC_COLL_MGMT_PRO_FIN in styLDC_COLL_MGMT_PRO_FIN,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_COLL_MGMT_PRO_FIN in out nocopy tytbLDC_COLL_MGMT_PRO_FIN
	);

	PROCEDURE delRecord
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_COLL_MGMT_PRO_FIN in out nocopy tytbLDC_COLL_MGMT_PRO_FIN,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_COLL_MGMT_PRO_FIN in styLDC_COLL_MGMT_PRO_FIN,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_COLL_MGMT_PRO_FIN in out nocopy tytbLDC_COLL_MGMT_PRO_FIN,
		inuLock in number default 1
	);

	PROCEDURE updORDER_ID
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuORDER_ID$ in LDC_COLL_MGMT_PRO_FIN.ORDER_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updEXEC_PROCESS_NAME
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		isbEXEC_PROCESS_NAME$ in LDC_COLL_MGMT_PRO_FIN.EXEC_PROCESS_NAME%type,
		inuLock in number default 0
	);

	PROCEDURE updCOLL_MGMT_PROC_CR_ID
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuCOLL_MGMT_PROC_CR_ID$ in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PROC_CR_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updIS_LEVEL_MAIN
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		isbIS_LEVEL_MAIN$ in LDC_COLL_MGMT_PRO_FIN.IS_LEVEL_MAIN%type,
		inuLock in number default 0
	);

	PROCEDURE updSUBSCRIBER_ID
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuSUBSCRIBER_ID$ in LDC_COLL_MGMT_PRO_FIN.SUBSCRIBER_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updSUBSCRIPTION_ID
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuSUBSCRIPTION_ID$ in LDC_COLL_MGMT_PRO_FIN.SUBSCRIPTION_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updPRODUCT_ID
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuPRODUCT_ID$ in LDC_COLL_MGMT_PRO_FIN.PRODUCT_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updDEBT_AGE
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuDEBT_AGE$ in LDC_COLL_MGMT_PRO_FIN.DEBT_AGE%type,
		inuLock in number default 0
	);

	PROCEDURE updTOTAL_DEBT
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuTOTAL_DEBT$ in LDC_COLL_MGMT_PRO_FIN.TOTAL_DEBT%type,
		inuLock in number default 0
	);

	PROCEDURE updOUTSTANDING_DEBT
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuOUTSTANDING_DEBT$ in LDC_COLL_MGMT_PRO_FIN.OUTSTANDING_DEBT%type,
		inuLock in number default 0
	);

	PROCEDURE updOVERDUE_DEBT
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuOVERDUE_DEBT$ in LDC_COLL_MGMT_PRO_FIN.OVERDUE_DEBT%type,
		inuLock in number default 0
	);

	PROCEDURE updDEFERRED_DEBT
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuDEFERRED_DEBT$ in LDC_COLL_MGMT_PRO_FIN.DEFERRED_DEBT%type,
		inuLock in number default 0
	);

	PROCEDURE updPUNI_OVER_DEBT
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuPUNI_OVER_DEBT$ in LDC_COLL_MGMT_PRO_FIN.PUNI_OVER_DEBT%type,
		inuLock in number default 0
	);

	PROCEDURE updREFINANCI_TIMES
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuREFINANCI_TIMES$ in LDC_COLL_MGMT_PRO_FIN.REFINANCI_TIMES%type,
		inuLock in number default 0
	);

	PROCEDURE updFINANCING_PLAN_ID
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuFINANCING_PLAN_ID$ in LDC_COLL_MGMT_PRO_FIN.FINANCING_PLAN_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updOPERATING_UNIT_ID
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuOPERATING_UNIT_ID$ in LDC_COLL_MGMT_PRO_FIN.OPERATING_UNIT_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updTOTAL_COLLECTED
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuTOTAL_COLLECTED$ in LDC_COLL_MGMT_PRO_FIN.TOTAL_COLLECTED%type,
		inuLock in number default 0
	);

	PROCEDURE updDATE_REGISTER
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		idtDATE_REGISTER$ in LDC_COLL_MGMT_PRO_FIN.DATE_REGISTER%type,
		inuLock in number default 0
	);

	PROCEDURE updDIAS_CORTE
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuDIAS_CORTE$ in LDC_COLL_MGMT_PRO_FIN.DIAS_CORTE%type,
		inuLock in number default 0
	);

	PROCEDURE updDEPTO
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuDEPTO$ in LDC_COLL_MGMT_PRO_FIN.DEPTO%type,
		inuLock in number default 0
	);

	PROCEDURE updLOCALIDAD
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuLOCALIDAD$ in LDC_COLL_MGMT_PRO_FIN.LOCALIDAD%type,
		inuLock in number default 0
	);

	PROCEDURE updIS_VOIDED
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		isbIS_VOIDED$ in LDC_COLL_MGMT_PRO_FIN.IS_VOIDED%type,
		inuLock in number default 0
	);

	PROCEDURE updESTAFINA
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		isbESTAFINA$ in LDC_COLL_MGMT_PRO_FIN.ESTAFINA%type,
		inuLock in number default 0
	);

	PROCEDURE updGEOGRAP_LOCATION_ID
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuGEOGRAP_LOCATION_ID$ in LDC_COLL_MGMT_PRO_FIN.GEOGRAP_LOCATION_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updPROCESADO
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		isbPROCESADO$ in LDC_COLL_MGMT_PRO_FIN.PROCESADO%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetCOLL_MGMT_PRO_FIN_ID
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type;

	FUNCTION fnuGetORDER_ID
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COLL_MGMT_PRO_FIN.ORDER_ID%type;

	FUNCTION fsbGetEXEC_PROCESS_NAME
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COLL_MGMT_PRO_FIN.EXEC_PROCESS_NAME%type;

	FUNCTION fnuGetCOLL_MGMT_PROC_CR_ID
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PROC_CR_ID%type;

	FUNCTION fsbGetIS_LEVEL_MAIN
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COLL_MGMT_PRO_FIN.IS_LEVEL_MAIN%type;

	FUNCTION fnuGetSUBSCRIBER_ID
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COLL_MGMT_PRO_FIN.SUBSCRIBER_ID%type;

	FUNCTION fnuGetSUBSCRIPTION_ID
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COLL_MGMT_PRO_FIN.SUBSCRIPTION_ID%type;

	FUNCTION fnuGetPRODUCT_ID
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COLL_MGMT_PRO_FIN.PRODUCT_ID%type;

	FUNCTION fnuGetDEBT_AGE
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COLL_MGMT_PRO_FIN.DEBT_AGE%type;

	FUNCTION fnuGetTOTAL_DEBT
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COLL_MGMT_PRO_FIN.TOTAL_DEBT%type;

	FUNCTION fnuGetOUTSTANDING_DEBT
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COLL_MGMT_PRO_FIN.OUTSTANDING_DEBT%type;

	FUNCTION fnuGetOVERDUE_DEBT
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COLL_MGMT_PRO_FIN.OVERDUE_DEBT%type;

	FUNCTION fnuGetDEFERRED_DEBT
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COLL_MGMT_PRO_FIN.DEFERRED_DEBT%type;

	FUNCTION fnuGetPUNI_OVER_DEBT
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COLL_MGMT_PRO_FIN.PUNI_OVER_DEBT%type;

	FUNCTION fnuGetREFINANCI_TIMES
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COLL_MGMT_PRO_FIN.REFINANCI_TIMES%type;

	FUNCTION fnuGetFINANCING_PLAN_ID
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COLL_MGMT_PRO_FIN.FINANCING_PLAN_ID%type;

	FUNCTION fnuGetOPERATING_UNIT_ID
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COLL_MGMT_PRO_FIN.OPERATING_UNIT_ID%type;

	FUNCTION fnuGetTOTAL_COLLECTED
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COLL_MGMT_PRO_FIN.TOTAL_COLLECTED%type;

	FUNCTION fdtGetDATE_REGISTER
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COLL_MGMT_PRO_FIN.DATE_REGISTER%type;

	FUNCTION fnuGetDIAS_CORTE
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COLL_MGMT_PRO_FIN.DIAS_CORTE%type;

	FUNCTION fnuGetDEPTO
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COLL_MGMT_PRO_FIN.DEPTO%type;

	FUNCTION fnuGetLOCALIDAD
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COLL_MGMT_PRO_FIN.LOCALIDAD%type;

	FUNCTION fsbGetIS_VOIDED
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COLL_MGMT_PRO_FIN.IS_VOIDED%type;

	FUNCTION fsbGetESTAFINA
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COLL_MGMT_PRO_FIN.ESTAFINA%type;

	FUNCTION fnuGetGEOGRAP_LOCATION_ID
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COLL_MGMT_PRO_FIN.GEOGRAP_LOCATION_ID%type;

	FUNCTION fsbGetPROCESADO
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COLL_MGMT_PRO_FIN.PROCESADO%type;


	PROCEDURE LockByPk
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		orcLDC_COLL_MGMT_PRO_FIN  out styLDC_COLL_MGMT_PRO_FIN
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_COLL_MGMT_PRO_FIN  out styLDC_COLL_MGMT_PRO_FIN
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_COLL_MGMT_PRO_FIN;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALDC_COLL_MGMT_PRO_FIN
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_COLL_MGMT_PRO_FIN';
	 cnuGeEntityId constant varchar2(30) := 8332; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type
	)
	IS
		SELECT LDC_COLL_MGMT_PRO_FIN.*,LDC_COLL_MGMT_PRO_FIN.rowid
		FROM LDC_COLL_MGMT_PRO_FIN
		WHERE  COLL_MGMT_PRO_FIN_ID = inuCOLL_MGMT_PRO_FIN_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_COLL_MGMT_PRO_FIN.*,LDC_COLL_MGMT_PRO_FIN.rowid
		FROM LDC_COLL_MGMT_PRO_FIN
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_COLL_MGMT_PRO_FIN is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_COLL_MGMT_PRO_FIN;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_COLL_MGMT_PRO_FIN default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.COLL_MGMT_PRO_FIN_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		orcLDC_COLL_MGMT_PRO_FIN  out styLDC_COLL_MGMT_PRO_FIN
	)
	IS
		rcError styLDC_COLL_MGMT_PRO_FIN;
	BEGIN
		rcError.COLL_MGMT_PRO_FIN_ID := inuCOLL_MGMT_PRO_FIN_ID;

		Open cuLockRcByPk
		(
			inuCOLL_MGMT_PRO_FIN_ID
		);

		fetch cuLockRcByPk into orcLDC_COLL_MGMT_PRO_FIN;
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
		orcLDC_COLL_MGMT_PRO_FIN  out styLDC_COLL_MGMT_PRO_FIN
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_COLL_MGMT_PRO_FIN;
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
		itbLDC_COLL_MGMT_PRO_FIN  in out nocopy tytbLDC_COLL_MGMT_PRO_FIN
	)
	IS
	BEGIN
			rcRecOfTab.COLL_MGMT_PRO_FIN_ID.delete;
			rcRecOfTab.ORDER_ID.delete;
			rcRecOfTab.EXEC_PROCESS_NAME.delete;
			rcRecOfTab.COLL_MGMT_PROC_CR_ID.delete;
			rcRecOfTab.IS_LEVEL_MAIN.delete;
			rcRecOfTab.SUBSCRIBER_ID.delete;
			rcRecOfTab.SUBSCRIPTION_ID.delete;
			rcRecOfTab.PRODUCT_ID.delete;
			rcRecOfTab.DEBT_AGE.delete;
			rcRecOfTab.TOTAL_DEBT.delete;
			rcRecOfTab.OUTSTANDING_DEBT.delete;
			rcRecOfTab.OVERDUE_DEBT.delete;
			rcRecOfTab.DEFERRED_DEBT.delete;
			rcRecOfTab.PUNI_OVER_DEBT.delete;
			rcRecOfTab.REFINANCI_TIMES.delete;
			rcRecOfTab.FINANCING_PLAN_ID.delete;
			rcRecOfTab.OPERATING_UNIT_ID.delete;
			rcRecOfTab.TOTAL_COLLECTED.delete;
			rcRecOfTab.DATE_REGISTER.delete;
			rcRecOfTab.DIAS_CORTE.delete;
			rcRecOfTab.DEPTO.delete;
			rcRecOfTab.LOCALIDAD.delete;
			rcRecOfTab.IS_VOIDED.delete;
			rcRecOfTab.ESTAFINA.delete;
			rcRecOfTab.GEOGRAP_LOCATION_ID.delete;
			rcRecOfTab.PROCESADO.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_COLL_MGMT_PRO_FIN  in out nocopy tytbLDC_COLL_MGMT_PRO_FIN,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_COLL_MGMT_PRO_FIN);

		for n in itbLDC_COLL_MGMT_PRO_FIN.first .. itbLDC_COLL_MGMT_PRO_FIN.last loop
			rcRecOfTab.COLL_MGMT_PRO_FIN_ID(n) := itbLDC_COLL_MGMT_PRO_FIN(n).COLL_MGMT_PRO_FIN_ID;
			rcRecOfTab.ORDER_ID(n) := itbLDC_COLL_MGMT_PRO_FIN(n).ORDER_ID;
			rcRecOfTab.EXEC_PROCESS_NAME(n) := itbLDC_COLL_MGMT_PRO_FIN(n).EXEC_PROCESS_NAME;
			rcRecOfTab.COLL_MGMT_PROC_CR_ID(n) := itbLDC_COLL_MGMT_PRO_FIN(n).COLL_MGMT_PROC_CR_ID;
			rcRecOfTab.IS_LEVEL_MAIN(n) := itbLDC_COLL_MGMT_PRO_FIN(n).IS_LEVEL_MAIN;
			rcRecOfTab.SUBSCRIBER_ID(n) := itbLDC_COLL_MGMT_PRO_FIN(n).SUBSCRIBER_ID;
			rcRecOfTab.SUBSCRIPTION_ID(n) := itbLDC_COLL_MGMT_PRO_FIN(n).SUBSCRIPTION_ID;
			rcRecOfTab.PRODUCT_ID(n) := itbLDC_COLL_MGMT_PRO_FIN(n).PRODUCT_ID;
			rcRecOfTab.DEBT_AGE(n) := itbLDC_COLL_MGMT_PRO_FIN(n).DEBT_AGE;
			rcRecOfTab.TOTAL_DEBT(n) := itbLDC_COLL_MGMT_PRO_FIN(n).TOTAL_DEBT;
			rcRecOfTab.OUTSTANDING_DEBT(n) := itbLDC_COLL_MGMT_PRO_FIN(n).OUTSTANDING_DEBT;
			rcRecOfTab.OVERDUE_DEBT(n) := itbLDC_COLL_MGMT_PRO_FIN(n).OVERDUE_DEBT;
			rcRecOfTab.DEFERRED_DEBT(n) := itbLDC_COLL_MGMT_PRO_FIN(n).DEFERRED_DEBT;
			rcRecOfTab.PUNI_OVER_DEBT(n) := itbLDC_COLL_MGMT_PRO_FIN(n).PUNI_OVER_DEBT;
			rcRecOfTab.REFINANCI_TIMES(n) := itbLDC_COLL_MGMT_PRO_FIN(n).REFINANCI_TIMES;
			rcRecOfTab.FINANCING_PLAN_ID(n) := itbLDC_COLL_MGMT_PRO_FIN(n).FINANCING_PLAN_ID;
			rcRecOfTab.OPERATING_UNIT_ID(n) := itbLDC_COLL_MGMT_PRO_FIN(n).OPERATING_UNIT_ID;
			rcRecOfTab.TOTAL_COLLECTED(n) := itbLDC_COLL_MGMT_PRO_FIN(n).TOTAL_COLLECTED;
			rcRecOfTab.DATE_REGISTER(n) := itbLDC_COLL_MGMT_PRO_FIN(n).DATE_REGISTER;
			rcRecOfTab.DIAS_CORTE(n) := itbLDC_COLL_MGMT_PRO_FIN(n).DIAS_CORTE;
			rcRecOfTab.DEPTO(n) := itbLDC_COLL_MGMT_PRO_FIN(n).DEPTO;
			rcRecOfTab.LOCALIDAD(n) := itbLDC_COLL_MGMT_PRO_FIN(n).LOCALIDAD;
			rcRecOfTab.IS_VOIDED(n) := itbLDC_COLL_MGMT_PRO_FIN(n).IS_VOIDED;
			rcRecOfTab.ESTAFINA(n) := itbLDC_COLL_MGMT_PRO_FIN(n).ESTAFINA;
			rcRecOfTab.GEOGRAP_LOCATION_ID(n) := itbLDC_COLL_MGMT_PRO_FIN(n).GEOGRAP_LOCATION_ID;
			rcRecOfTab.PROCESADO(n) := itbLDC_COLL_MGMT_PRO_FIN(n).PROCESADO;
			rcRecOfTab.row_id(n) := itbLDC_COLL_MGMT_PRO_FIN(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuCOLL_MGMT_PRO_FIN_ID
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
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuCOLL_MGMT_PRO_FIN_ID = rcData.COLL_MGMT_PRO_FIN_ID
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
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuCOLL_MGMT_PRO_FIN_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type
	)
	IS
		rcError styLDC_COLL_MGMT_PRO_FIN;
	BEGIN		rcError.COLL_MGMT_PRO_FIN_ID:=inuCOLL_MGMT_PRO_FIN_ID;

		Load
		(
			inuCOLL_MGMT_PRO_FIN_ID
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
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuCOLL_MGMT_PRO_FIN_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		orcRecord out nocopy styLDC_COLL_MGMT_PRO_FIN
	)
	IS
		rcError styLDC_COLL_MGMT_PRO_FIN;
	BEGIN		rcError.COLL_MGMT_PRO_FIN_ID:=inuCOLL_MGMT_PRO_FIN_ID;

		Load
		(
			inuCOLL_MGMT_PRO_FIN_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type
	)
	RETURN styLDC_COLL_MGMT_PRO_FIN
	IS
		rcError styLDC_COLL_MGMT_PRO_FIN;
	BEGIN
		rcError.COLL_MGMT_PRO_FIN_ID:=inuCOLL_MGMT_PRO_FIN_ID;

		Load
		(
			inuCOLL_MGMT_PRO_FIN_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type
	)
	RETURN styLDC_COLL_MGMT_PRO_FIN
	IS
		rcError styLDC_COLL_MGMT_PRO_FIN;
	BEGIN
		rcError.COLL_MGMT_PRO_FIN_ID:=inuCOLL_MGMT_PRO_FIN_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuCOLL_MGMT_PRO_FIN_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuCOLL_MGMT_PRO_FIN_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_COLL_MGMT_PRO_FIN
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_COLL_MGMT_PRO_FIN
	)
	IS
		rfLDC_COLL_MGMT_PRO_FIN tyrfLDC_COLL_MGMT_PRO_FIN;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_COLL_MGMT_PRO_FIN.*, LDC_COLL_MGMT_PRO_FIN.rowid FROM LDC_COLL_MGMT_PRO_FIN';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_COLL_MGMT_PRO_FIN for sbFullQuery;

		fetch rfLDC_COLL_MGMT_PRO_FIN bulk collect INTO otbResult;

		close rfLDC_COLL_MGMT_PRO_FIN;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_COLL_MGMT_PRO_FIN.*, LDC_COLL_MGMT_PRO_FIN.rowid FROM LDC_COLL_MGMT_PRO_FIN';
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
		ircLDC_COLL_MGMT_PRO_FIN in styLDC_COLL_MGMT_PRO_FIN
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_COLL_MGMT_PRO_FIN,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_COLL_MGMT_PRO_FIN in styLDC_COLL_MGMT_PRO_FIN,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|COLL_MGMT_PRO_FIN_ID');
			raise ex.controlled_error;
		end if;

		insert into LDC_COLL_MGMT_PRO_FIN
		(
			COLL_MGMT_PRO_FIN_ID,
			ORDER_ID,
			EXEC_PROCESS_NAME,
			COLL_MGMT_PROC_CR_ID,
			IS_LEVEL_MAIN,
			SUBSCRIBER_ID,
			SUBSCRIPTION_ID,
			PRODUCT_ID,
			DEBT_AGE,
			TOTAL_DEBT,
			OUTSTANDING_DEBT,
			OVERDUE_DEBT,
			DEFERRED_DEBT,
			PUNI_OVER_DEBT,
			REFINANCI_TIMES,
			FINANCING_PLAN_ID,
			OPERATING_UNIT_ID,
			TOTAL_COLLECTED,
			DATE_REGISTER,
			DIAS_CORTE,
			DEPTO,
			LOCALIDAD,
			IS_VOIDED,
			ESTAFINA,
			GEOGRAP_LOCATION_ID,
			PROCESADO
		)
		values
		(
			ircLDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID,
			ircLDC_COLL_MGMT_PRO_FIN.ORDER_ID,
			ircLDC_COLL_MGMT_PRO_FIN.EXEC_PROCESS_NAME,
			ircLDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PROC_CR_ID,
			ircLDC_COLL_MGMT_PRO_FIN.IS_LEVEL_MAIN,
			ircLDC_COLL_MGMT_PRO_FIN.SUBSCRIBER_ID,
			ircLDC_COLL_MGMT_PRO_FIN.SUBSCRIPTION_ID,
			ircLDC_COLL_MGMT_PRO_FIN.PRODUCT_ID,
			ircLDC_COLL_MGMT_PRO_FIN.DEBT_AGE,
			ircLDC_COLL_MGMT_PRO_FIN.TOTAL_DEBT,
			ircLDC_COLL_MGMT_PRO_FIN.OUTSTANDING_DEBT,
			ircLDC_COLL_MGMT_PRO_FIN.OVERDUE_DEBT,
			ircLDC_COLL_MGMT_PRO_FIN.DEFERRED_DEBT,
			ircLDC_COLL_MGMT_PRO_FIN.PUNI_OVER_DEBT,
			ircLDC_COLL_MGMT_PRO_FIN.REFINANCI_TIMES,
			ircLDC_COLL_MGMT_PRO_FIN.FINANCING_PLAN_ID,
			ircLDC_COLL_MGMT_PRO_FIN.OPERATING_UNIT_ID,
			ircLDC_COLL_MGMT_PRO_FIN.TOTAL_COLLECTED,
			ircLDC_COLL_MGMT_PRO_FIN.DATE_REGISTER,
			ircLDC_COLL_MGMT_PRO_FIN.DIAS_CORTE,
			ircLDC_COLL_MGMT_PRO_FIN.DEPTO,
			ircLDC_COLL_MGMT_PRO_FIN.LOCALIDAD,
			ircLDC_COLL_MGMT_PRO_FIN.IS_VOIDED,
			ircLDC_COLL_MGMT_PRO_FIN.ESTAFINA,
			ircLDC_COLL_MGMT_PRO_FIN.GEOGRAP_LOCATION_ID,
			ircLDC_COLL_MGMT_PRO_FIN.PROCESADO
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_COLL_MGMT_PRO_FIN));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_COLL_MGMT_PRO_FIN in out nocopy tytbLDC_COLL_MGMT_PRO_FIN
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_COLL_MGMT_PRO_FIN,blUseRowID);
		forall n in iotbLDC_COLL_MGMT_PRO_FIN.first..iotbLDC_COLL_MGMT_PRO_FIN.last
			insert into LDC_COLL_MGMT_PRO_FIN
			(
				COLL_MGMT_PRO_FIN_ID,
				ORDER_ID,
				EXEC_PROCESS_NAME,
				COLL_MGMT_PROC_CR_ID,
				IS_LEVEL_MAIN,
				SUBSCRIBER_ID,
				SUBSCRIPTION_ID,
				PRODUCT_ID,
				DEBT_AGE,
				TOTAL_DEBT,
				OUTSTANDING_DEBT,
				OVERDUE_DEBT,
				DEFERRED_DEBT,
				PUNI_OVER_DEBT,
				REFINANCI_TIMES,
				FINANCING_PLAN_ID,
				OPERATING_UNIT_ID,
				TOTAL_COLLECTED,
				DATE_REGISTER,
				DIAS_CORTE,
				DEPTO,
				LOCALIDAD,
				IS_VOIDED,
				ESTAFINA,
				GEOGRAP_LOCATION_ID,
				PROCESADO
			)
			values
			(
				rcRecOfTab.COLL_MGMT_PRO_FIN_ID(n),
				rcRecOfTab.ORDER_ID(n),
				rcRecOfTab.EXEC_PROCESS_NAME(n),
				rcRecOfTab.COLL_MGMT_PROC_CR_ID(n),
				rcRecOfTab.IS_LEVEL_MAIN(n),
				rcRecOfTab.SUBSCRIBER_ID(n),
				rcRecOfTab.SUBSCRIPTION_ID(n),
				rcRecOfTab.PRODUCT_ID(n),
				rcRecOfTab.DEBT_AGE(n),
				rcRecOfTab.TOTAL_DEBT(n),
				rcRecOfTab.OUTSTANDING_DEBT(n),
				rcRecOfTab.OVERDUE_DEBT(n),
				rcRecOfTab.DEFERRED_DEBT(n),
				rcRecOfTab.PUNI_OVER_DEBT(n),
				rcRecOfTab.REFINANCI_TIMES(n),
				rcRecOfTab.FINANCING_PLAN_ID(n),
				rcRecOfTab.OPERATING_UNIT_ID(n),
				rcRecOfTab.TOTAL_COLLECTED(n),
				rcRecOfTab.DATE_REGISTER(n),
				rcRecOfTab.DIAS_CORTE(n),
				rcRecOfTab.DEPTO(n),
				rcRecOfTab.LOCALIDAD(n),
				rcRecOfTab.IS_VOIDED(n),
				rcRecOfTab.ESTAFINA(n),
				rcRecOfTab.GEOGRAP_LOCATION_ID(n),
				rcRecOfTab.PROCESADO(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_COLL_MGMT_PRO_FIN;
	BEGIN
		rcError.COLL_MGMT_PRO_FIN_ID := inuCOLL_MGMT_PRO_FIN_ID;

		if inuLock=1 then
			LockByPk
			(
				inuCOLL_MGMT_PRO_FIN_ID,
				rcData
			);
		end if;


		delete
		from LDC_COLL_MGMT_PRO_FIN
		where
       		COLL_MGMT_PRO_FIN_ID=inuCOLL_MGMT_PRO_FIN_ID;
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
		iriRowID    in rowid,
		inuLock in number default 1
	)
	IS
		rcRecordNull cuRecord%rowtype;
		rcError  styLDC_COLL_MGMT_PRO_FIN;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_COLL_MGMT_PRO_FIN
		where
			rowid = iriRowID
		returning
			COLL_MGMT_PRO_FIN_ID
		into
			rcError.COLL_MGMT_PRO_FIN_ID;
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
		iotbLDC_COLL_MGMT_PRO_FIN in out nocopy tytbLDC_COLL_MGMT_PRO_FIN,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_COLL_MGMT_PRO_FIN;
	BEGIN
		FillRecordOfTables(iotbLDC_COLL_MGMT_PRO_FIN, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_COLL_MGMT_PRO_FIN.first .. iotbLDC_COLL_MGMT_PRO_FIN.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_COLL_MGMT_PRO_FIN.first .. iotbLDC_COLL_MGMT_PRO_FIN.last
				delete
				from LDC_COLL_MGMT_PRO_FIN
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_COLL_MGMT_PRO_FIN.first .. iotbLDC_COLL_MGMT_PRO_FIN.last loop
					LockByPk
					(
						rcRecOfTab.COLL_MGMT_PRO_FIN_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_COLL_MGMT_PRO_FIN.first .. iotbLDC_COLL_MGMT_PRO_FIN.last
				delete
				from LDC_COLL_MGMT_PRO_FIN
				where
		         	COLL_MGMT_PRO_FIN_ID = rcRecOfTab.COLL_MGMT_PRO_FIN_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_COLL_MGMT_PRO_FIN in styLDC_COLL_MGMT_PRO_FIN,
		inuLock in number default 0
	)
	IS
		nuCOLL_MGMT_PRO_FIN_ID	LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type;
	BEGIN
		if ircLDC_COLL_MGMT_PRO_FIN.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_COLL_MGMT_PRO_FIN.rowid,rcData);
			end if;
			update LDC_COLL_MGMT_PRO_FIN
			set
				ORDER_ID = ircLDC_COLL_MGMT_PRO_FIN.ORDER_ID,
				EXEC_PROCESS_NAME = ircLDC_COLL_MGMT_PRO_FIN.EXEC_PROCESS_NAME,
				COLL_MGMT_PROC_CR_ID = ircLDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PROC_CR_ID,
				IS_LEVEL_MAIN = ircLDC_COLL_MGMT_PRO_FIN.IS_LEVEL_MAIN,
				SUBSCRIBER_ID = ircLDC_COLL_MGMT_PRO_FIN.SUBSCRIBER_ID,
				SUBSCRIPTION_ID = ircLDC_COLL_MGMT_PRO_FIN.SUBSCRIPTION_ID,
				PRODUCT_ID = ircLDC_COLL_MGMT_PRO_FIN.PRODUCT_ID,
				DEBT_AGE = ircLDC_COLL_MGMT_PRO_FIN.DEBT_AGE,
				TOTAL_DEBT = ircLDC_COLL_MGMT_PRO_FIN.TOTAL_DEBT,
				OUTSTANDING_DEBT = ircLDC_COLL_MGMT_PRO_FIN.OUTSTANDING_DEBT,
				OVERDUE_DEBT = ircLDC_COLL_MGMT_PRO_FIN.OVERDUE_DEBT,
				DEFERRED_DEBT = ircLDC_COLL_MGMT_PRO_FIN.DEFERRED_DEBT,
				PUNI_OVER_DEBT = ircLDC_COLL_MGMT_PRO_FIN.PUNI_OVER_DEBT,
				REFINANCI_TIMES = ircLDC_COLL_MGMT_PRO_FIN.REFINANCI_TIMES,
				FINANCING_PLAN_ID = ircLDC_COLL_MGMT_PRO_FIN.FINANCING_PLAN_ID,
				OPERATING_UNIT_ID = ircLDC_COLL_MGMT_PRO_FIN.OPERATING_UNIT_ID,
				TOTAL_COLLECTED = ircLDC_COLL_MGMT_PRO_FIN.TOTAL_COLLECTED,
				DATE_REGISTER = ircLDC_COLL_MGMT_PRO_FIN.DATE_REGISTER,
				DIAS_CORTE = ircLDC_COLL_MGMT_PRO_FIN.DIAS_CORTE,
				DEPTO = ircLDC_COLL_MGMT_PRO_FIN.DEPTO,
				LOCALIDAD = ircLDC_COLL_MGMT_PRO_FIN.LOCALIDAD,
				IS_VOIDED = ircLDC_COLL_MGMT_PRO_FIN.IS_VOIDED,
				ESTAFINA = ircLDC_COLL_MGMT_PRO_FIN.ESTAFINA,
				GEOGRAP_LOCATION_ID = ircLDC_COLL_MGMT_PRO_FIN.GEOGRAP_LOCATION_ID,
				PROCESADO = ircLDC_COLL_MGMT_PRO_FIN.PROCESADO
			where
				rowid = ircLDC_COLL_MGMT_PRO_FIN.rowid
			returning
				COLL_MGMT_PRO_FIN_ID
			into
				nuCOLL_MGMT_PRO_FIN_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID,
					rcData
				);
			end if;

			update LDC_COLL_MGMT_PRO_FIN
			set
				ORDER_ID = ircLDC_COLL_MGMT_PRO_FIN.ORDER_ID,
				EXEC_PROCESS_NAME = ircLDC_COLL_MGMT_PRO_FIN.EXEC_PROCESS_NAME,
				COLL_MGMT_PROC_CR_ID = ircLDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PROC_CR_ID,
				IS_LEVEL_MAIN = ircLDC_COLL_MGMT_PRO_FIN.IS_LEVEL_MAIN,
				SUBSCRIBER_ID = ircLDC_COLL_MGMT_PRO_FIN.SUBSCRIBER_ID,
				SUBSCRIPTION_ID = ircLDC_COLL_MGMT_PRO_FIN.SUBSCRIPTION_ID,
				PRODUCT_ID = ircLDC_COLL_MGMT_PRO_FIN.PRODUCT_ID,
				DEBT_AGE = ircLDC_COLL_MGMT_PRO_FIN.DEBT_AGE,
				TOTAL_DEBT = ircLDC_COLL_MGMT_PRO_FIN.TOTAL_DEBT,
				OUTSTANDING_DEBT = ircLDC_COLL_MGMT_PRO_FIN.OUTSTANDING_DEBT,
				OVERDUE_DEBT = ircLDC_COLL_MGMT_PRO_FIN.OVERDUE_DEBT,
				DEFERRED_DEBT = ircLDC_COLL_MGMT_PRO_FIN.DEFERRED_DEBT,
				PUNI_OVER_DEBT = ircLDC_COLL_MGMT_PRO_FIN.PUNI_OVER_DEBT,
				REFINANCI_TIMES = ircLDC_COLL_MGMT_PRO_FIN.REFINANCI_TIMES,
				FINANCING_PLAN_ID = ircLDC_COLL_MGMT_PRO_FIN.FINANCING_PLAN_ID,
				OPERATING_UNIT_ID = ircLDC_COLL_MGMT_PRO_FIN.OPERATING_UNIT_ID,
				TOTAL_COLLECTED = ircLDC_COLL_MGMT_PRO_FIN.TOTAL_COLLECTED,
				DATE_REGISTER = ircLDC_COLL_MGMT_PRO_FIN.DATE_REGISTER,
				DIAS_CORTE = ircLDC_COLL_MGMT_PRO_FIN.DIAS_CORTE,
				DEPTO = ircLDC_COLL_MGMT_PRO_FIN.DEPTO,
				LOCALIDAD = ircLDC_COLL_MGMT_PRO_FIN.LOCALIDAD,
				IS_VOIDED = ircLDC_COLL_MGMT_PRO_FIN.IS_VOIDED,
				ESTAFINA = ircLDC_COLL_MGMT_PRO_FIN.ESTAFINA,
				GEOGRAP_LOCATION_ID = ircLDC_COLL_MGMT_PRO_FIN.GEOGRAP_LOCATION_ID,
				PROCESADO = ircLDC_COLL_MGMT_PRO_FIN.PROCESADO
			where
				COLL_MGMT_PRO_FIN_ID = ircLDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID
			returning
				COLL_MGMT_PRO_FIN_ID
			into
				nuCOLL_MGMT_PRO_FIN_ID;
		end if;
		if
			nuCOLL_MGMT_PRO_FIN_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_COLL_MGMT_PRO_FIN));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_COLL_MGMT_PRO_FIN in out nocopy tytbLDC_COLL_MGMT_PRO_FIN,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_COLL_MGMT_PRO_FIN;
	BEGIN
		FillRecordOfTables(iotbLDC_COLL_MGMT_PRO_FIN,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_COLL_MGMT_PRO_FIN.first .. iotbLDC_COLL_MGMT_PRO_FIN.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_COLL_MGMT_PRO_FIN.first .. iotbLDC_COLL_MGMT_PRO_FIN.last
				update LDC_COLL_MGMT_PRO_FIN
				set
					ORDER_ID = rcRecOfTab.ORDER_ID(n),
					EXEC_PROCESS_NAME = rcRecOfTab.EXEC_PROCESS_NAME(n),
					COLL_MGMT_PROC_CR_ID = rcRecOfTab.COLL_MGMT_PROC_CR_ID(n),
					IS_LEVEL_MAIN = rcRecOfTab.IS_LEVEL_MAIN(n),
					SUBSCRIBER_ID = rcRecOfTab.SUBSCRIBER_ID(n),
					SUBSCRIPTION_ID = rcRecOfTab.SUBSCRIPTION_ID(n),
					PRODUCT_ID = rcRecOfTab.PRODUCT_ID(n),
					DEBT_AGE = rcRecOfTab.DEBT_AGE(n),
					TOTAL_DEBT = rcRecOfTab.TOTAL_DEBT(n),
					OUTSTANDING_DEBT = rcRecOfTab.OUTSTANDING_DEBT(n),
					OVERDUE_DEBT = rcRecOfTab.OVERDUE_DEBT(n),
					DEFERRED_DEBT = rcRecOfTab.DEFERRED_DEBT(n),
					PUNI_OVER_DEBT = rcRecOfTab.PUNI_OVER_DEBT(n),
					REFINANCI_TIMES = rcRecOfTab.REFINANCI_TIMES(n),
					FINANCING_PLAN_ID = rcRecOfTab.FINANCING_PLAN_ID(n),
					OPERATING_UNIT_ID = rcRecOfTab.OPERATING_UNIT_ID(n),
					TOTAL_COLLECTED = rcRecOfTab.TOTAL_COLLECTED(n),
					DATE_REGISTER = rcRecOfTab.DATE_REGISTER(n),
					DIAS_CORTE = rcRecOfTab.DIAS_CORTE(n),
					DEPTO = rcRecOfTab.DEPTO(n),
					LOCALIDAD = rcRecOfTab.LOCALIDAD(n),
					IS_VOIDED = rcRecOfTab.IS_VOIDED(n),
					ESTAFINA = rcRecOfTab.ESTAFINA(n),
					GEOGRAP_LOCATION_ID = rcRecOfTab.GEOGRAP_LOCATION_ID(n),
					PROCESADO = rcRecOfTab.PROCESADO(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_COLL_MGMT_PRO_FIN.first .. iotbLDC_COLL_MGMT_PRO_FIN.last loop
					LockByPk
					(
						rcRecOfTab.COLL_MGMT_PRO_FIN_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_COLL_MGMT_PRO_FIN.first .. iotbLDC_COLL_MGMT_PRO_FIN.last
				update LDC_COLL_MGMT_PRO_FIN
				SET
					ORDER_ID = rcRecOfTab.ORDER_ID(n),
					EXEC_PROCESS_NAME = rcRecOfTab.EXEC_PROCESS_NAME(n),
					COLL_MGMT_PROC_CR_ID = rcRecOfTab.COLL_MGMT_PROC_CR_ID(n),
					IS_LEVEL_MAIN = rcRecOfTab.IS_LEVEL_MAIN(n),
					SUBSCRIBER_ID = rcRecOfTab.SUBSCRIBER_ID(n),
					SUBSCRIPTION_ID = rcRecOfTab.SUBSCRIPTION_ID(n),
					PRODUCT_ID = rcRecOfTab.PRODUCT_ID(n),
					DEBT_AGE = rcRecOfTab.DEBT_AGE(n),
					TOTAL_DEBT = rcRecOfTab.TOTAL_DEBT(n),
					OUTSTANDING_DEBT = rcRecOfTab.OUTSTANDING_DEBT(n),
					OVERDUE_DEBT = rcRecOfTab.OVERDUE_DEBT(n),
					DEFERRED_DEBT = rcRecOfTab.DEFERRED_DEBT(n),
					PUNI_OVER_DEBT = rcRecOfTab.PUNI_OVER_DEBT(n),
					REFINANCI_TIMES = rcRecOfTab.REFINANCI_TIMES(n),
					FINANCING_PLAN_ID = rcRecOfTab.FINANCING_PLAN_ID(n),
					OPERATING_UNIT_ID = rcRecOfTab.OPERATING_UNIT_ID(n),
					TOTAL_COLLECTED = rcRecOfTab.TOTAL_COLLECTED(n),
					DATE_REGISTER = rcRecOfTab.DATE_REGISTER(n),
					DIAS_CORTE = rcRecOfTab.DIAS_CORTE(n),
					DEPTO = rcRecOfTab.DEPTO(n),
					LOCALIDAD = rcRecOfTab.LOCALIDAD(n),
					IS_VOIDED = rcRecOfTab.IS_VOIDED(n),
					ESTAFINA = rcRecOfTab.ESTAFINA(n),
					GEOGRAP_LOCATION_ID = rcRecOfTab.GEOGRAP_LOCATION_ID(n),
					PROCESADO = rcRecOfTab.PROCESADO(n)
				where
					COLL_MGMT_PRO_FIN_ID = rcRecOfTab.COLL_MGMT_PRO_FIN_ID(n)
;
		end if;
	END;
	PROCEDURE updORDER_ID
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuORDER_ID$ in LDC_COLL_MGMT_PRO_FIN.ORDER_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COLL_MGMT_PRO_FIN;
	BEGIN
		rcError.COLL_MGMT_PRO_FIN_ID := inuCOLL_MGMT_PRO_FIN_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCOLL_MGMT_PRO_FIN_ID,
				rcData
			);
		end if;

		update LDC_COLL_MGMT_PRO_FIN
		set
			ORDER_ID = inuORDER_ID$
		where
			COLL_MGMT_PRO_FIN_ID = inuCOLL_MGMT_PRO_FIN_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ORDER_ID:= inuORDER_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updEXEC_PROCESS_NAME
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		isbEXEC_PROCESS_NAME$ in LDC_COLL_MGMT_PRO_FIN.EXEC_PROCESS_NAME%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COLL_MGMT_PRO_FIN;
	BEGIN
		rcError.COLL_MGMT_PRO_FIN_ID := inuCOLL_MGMT_PRO_FIN_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCOLL_MGMT_PRO_FIN_ID,
				rcData
			);
		end if;

		update LDC_COLL_MGMT_PRO_FIN
		set
			EXEC_PROCESS_NAME = isbEXEC_PROCESS_NAME$
		where
			COLL_MGMT_PRO_FIN_ID = inuCOLL_MGMT_PRO_FIN_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.EXEC_PROCESS_NAME:= isbEXEC_PROCESS_NAME$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCOLL_MGMT_PROC_CR_ID
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuCOLL_MGMT_PROC_CR_ID$ in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PROC_CR_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COLL_MGMT_PRO_FIN;
	BEGIN
		rcError.COLL_MGMT_PRO_FIN_ID := inuCOLL_MGMT_PRO_FIN_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCOLL_MGMT_PRO_FIN_ID,
				rcData
			);
		end if;

		update LDC_COLL_MGMT_PRO_FIN
		set
			COLL_MGMT_PROC_CR_ID = inuCOLL_MGMT_PROC_CR_ID$
		where
			COLL_MGMT_PRO_FIN_ID = inuCOLL_MGMT_PRO_FIN_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.COLL_MGMT_PROC_CR_ID:= inuCOLL_MGMT_PROC_CR_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updIS_LEVEL_MAIN
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		isbIS_LEVEL_MAIN$ in LDC_COLL_MGMT_PRO_FIN.IS_LEVEL_MAIN%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COLL_MGMT_PRO_FIN;
	BEGIN
		rcError.COLL_MGMT_PRO_FIN_ID := inuCOLL_MGMT_PRO_FIN_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCOLL_MGMT_PRO_FIN_ID,
				rcData
			);
		end if;

		update LDC_COLL_MGMT_PRO_FIN
		set
			IS_LEVEL_MAIN = isbIS_LEVEL_MAIN$
		where
			COLL_MGMT_PRO_FIN_ID = inuCOLL_MGMT_PRO_FIN_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.IS_LEVEL_MAIN:= isbIS_LEVEL_MAIN$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSUBSCRIBER_ID
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuSUBSCRIBER_ID$ in LDC_COLL_MGMT_PRO_FIN.SUBSCRIBER_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COLL_MGMT_PRO_FIN;
	BEGIN
		rcError.COLL_MGMT_PRO_FIN_ID := inuCOLL_MGMT_PRO_FIN_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCOLL_MGMT_PRO_FIN_ID,
				rcData
			);
		end if;

		update LDC_COLL_MGMT_PRO_FIN
		set
			SUBSCRIBER_ID = inuSUBSCRIBER_ID$
		where
			COLL_MGMT_PRO_FIN_ID = inuCOLL_MGMT_PRO_FIN_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SUBSCRIBER_ID:= inuSUBSCRIBER_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSUBSCRIPTION_ID
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuSUBSCRIPTION_ID$ in LDC_COLL_MGMT_PRO_FIN.SUBSCRIPTION_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COLL_MGMT_PRO_FIN;
	BEGIN
		rcError.COLL_MGMT_PRO_FIN_ID := inuCOLL_MGMT_PRO_FIN_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCOLL_MGMT_PRO_FIN_ID,
				rcData
			);
		end if;

		update LDC_COLL_MGMT_PRO_FIN
		set
			SUBSCRIPTION_ID = inuSUBSCRIPTION_ID$
		where
			COLL_MGMT_PRO_FIN_ID = inuCOLL_MGMT_PRO_FIN_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SUBSCRIPTION_ID:= inuSUBSCRIPTION_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPRODUCT_ID
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuPRODUCT_ID$ in LDC_COLL_MGMT_PRO_FIN.PRODUCT_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COLL_MGMT_PRO_FIN;
	BEGIN
		rcError.COLL_MGMT_PRO_FIN_ID := inuCOLL_MGMT_PRO_FIN_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCOLL_MGMT_PRO_FIN_ID,
				rcData
			);
		end if;

		update LDC_COLL_MGMT_PRO_FIN
		set
			PRODUCT_ID = inuPRODUCT_ID$
		where
			COLL_MGMT_PRO_FIN_ID = inuCOLL_MGMT_PRO_FIN_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PRODUCT_ID:= inuPRODUCT_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updDEBT_AGE
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuDEBT_AGE$ in LDC_COLL_MGMT_PRO_FIN.DEBT_AGE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COLL_MGMT_PRO_FIN;
	BEGIN
		rcError.COLL_MGMT_PRO_FIN_ID := inuCOLL_MGMT_PRO_FIN_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCOLL_MGMT_PRO_FIN_ID,
				rcData
			);
		end if;

		update LDC_COLL_MGMT_PRO_FIN
		set
			DEBT_AGE = inuDEBT_AGE$
		where
			COLL_MGMT_PRO_FIN_ID = inuCOLL_MGMT_PRO_FIN_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DEBT_AGE:= inuDEBT_AGE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updTOTAL_DEBT
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuTOTAL_DEBT$ in LDC_COLL_MGMT_PRO_FIN.TOTAL_DEBT%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COLL_MGMT_PRO_FIN;
	BEGIN
		rcError.COLL_MGMT_PRO_FIN_ID := inuCOLL_MGMT_PRO_FIN_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCOLL_MGMT_PRO_FIN_ID,
				rcData
			);
		end if;

		update LDC_COLL_MGMT_PRO_FIN
		set
			TOTAL_DEBT = inuTOTAL_DEBT$
		where
			COLL_MGMT_PRO_FIN_ID = inuCOLL_MGMT_PRO_FIN_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TOTAL_DEBT:= inuTOTAL_DEBT$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updOUTSTANDING_DEBT
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuOUTSTANDING_DEBT$ in LDC_COLL_MGMT_PRO_FIN.OUTSTANDING_DEBT%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COLL_MGMT_PRO_FIN;
	BEGIN
		rcError.COLL_MGMT_PRO_FIN_ID := inuCOLL_MGMT_PRO_FIN_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCOLL_MGMT_PRO_FIN_ID,
				rcData
			);
		end if;

		update LDC_COLL_MGMT_PRO_FIN
		set
			OUTSTANDING_DEBT = inuOUTSTANDING_DEBT$
		where
			COLL_MGMT_PRO_FIN_ID = inuCOLL_MGMT_PRO_FIN_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.OUTSTANDING_DEBT:= inuOUTSTANDING_DEBT$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updOVERDUE_DEBT
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuOVERDUE_DEBT$ in LDC_COLL_MGMT_PRO_FIN.OVERDUE_DEBT%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COLL_MGMT_PRO_FIN;
	BEGIN
		rcError.COLL_MGMT_PRO_FIN_ID := inuCOLL_MGMT_PRO_FIN_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCOLL_MGMT_PRO_FIN_ID,
				rcData
			);
		end if;

		update LDC_COLL_MGMT_PRO_FIN
		set
			OVERDUE_DEBT = inuOVERDUE_DEBT$
		where
			COLL_MGMT_PRO_FIN_ID = inuCOLL_MGMT_PRO_FIN_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.OVERDUE_DEBT:= inuOVERDUE_DEBT$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updDEFERRED_DEBT
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuDEFERRED_DEBT$ in LDC_COLL_MGMT_PRO_FIN.DEFERRED_DEBT%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COLL_MGMT_PRO_FIN;
	BEGIN
		rcError.COLL_MGMT_PRO_FIN_ID := inuCOLL_MGMT_PRO_FIN_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCOLL_MGMT_PRO_FIN_ID,
				rcData
			);
		end if;

		update LDC_COLL_MGMT_PRO_FIN
		set
			DEFERRED_DEBT = inuDEFERRED_DEBT$
		where
			COLL_MGMT_PRO_FIN_ID = inuCOLL_MGMT_PRO_FIN_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DEFERRED_DEBT:= inuDEFERRED_DEBT$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPUNI_OVER_DEBT
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuPUNI_OVER_DEBT$ in LDC_COLL_MGMT_PRO_FIN.PUNI_OVER_DEBT%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COLL_MGMT_PRO_FIN;
	BEGIN
		rcError.COLL_MGMT_PRO_FIN_ID := inuCOLL_MGMT_PRO_FIN_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCOLL_MGMT_PRO_FIN_ID,
				rcData
			);
		end if;

		update LDC_COLL_MGMT_PRO_FIN
		set
			PUNI_OVER_DEBT = inuPUNI_OVER_DEBT$
		where
			COLL_MGMT_PRO_FIN_ID = inuCOLL_MGMT_PRO_FIN_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PUNI_OVER_DEBT:= inuPUNI_OVER_DEBT$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updREFINANCI_TIMES
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuREFINANCI_TIMES$ in LDC_COLL_MGMT_PRO_FIN.REFINANCI_TIMES%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COLL_MGMT_PRO_FIN;
	BEGIN
		rcError.COLL_MGMT_PRO_FIN_ID := inuCOLL_MGMT_PRO_FIN_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCOLL_MGMT_PRO_FIN_ID,
				rcData
			);
		end if;

		update LDC_COLL_MGMT_PRO_FIN
		set
			REFINANCI_TIMES = inuREFINANCI_TIMES$
		where
			COLL_MGMT_PRO_FIN_ID = inuCOLL_MGMT_PRO_FIN_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.REFINANCI_TIMES:= inuREFINANCI_TIMES$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFINANCING_PLAN_ID
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuFINANCING_PLAN_ID$ in LDC_COLL_MGMT_PRO_FIN.FINANCING_PLAN_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COLL_MGMT_PRO_FIN;
	BEGIN
		rcError.COLL_MGMT_PRO_FIN_ID := inuCOLL_MGMT_PRO_FIN_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCOLL_MGMT_PRO_FIN_ID,
				rcData
			);
		end if;

		update LDC_COLL_MGMT_PRO_FIN
		set
			FINANCING_PLAN_ID = inuFINANCING_PLAN_ID$
		where
			COLL_MGMT_PRO_FIN_ID = inuCOLL_MGMT_PRO_FIN_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FINANCING_PLAN_ID:= inuFINANCING_PLAN_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updOPERATING_UNIT_ID
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuOPERATING_UNIT_ID$ in LDC_COLL_MGMT_PRO_FIN.OPERATING_UNIT_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COLL_MGMT_PRO_FIN;
	BEGIN
		rcError.COLL_MGMT_PRO_FIN_ID := inuCOLL_MGMT_PRO_FIN_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCOLL_MGMT_PRO_FIN_ID,
				rcData
			);
		end if;

		update LDC_COLL_MGMT_PRO_FIN
		set
			OPERATING_UNIT_ID = inuOPERATING_UNIT_ID$
		where
			COLL_MGMT_PRO_FIN_ID = inuCOLL_MGMT_PRO_FIN_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.OPERATING_UNIT_ID:= inuOPERATING_UNIT_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updTOTAL_COLLECTED
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuTOTAL_COLLECTED$ in LDC_COLL_MGMT_PRO_FIN.TOTAL_COLLECTED%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COLL_MGMT_PRO_FIN;
	BEGIN
		rcError.COLL_MGMT_PRO_FIN_ID := inuCOLL_MGMT_PRO_FIN_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCOLL_MGMT_PRO_FIN_ID,
				rcData
			);
		end if;

		update LDC_COLL_MGMT_PRO_FIN
		set
			TOTAL_COLLECTED = inuTOTAL_COLLECTED$
		where
			COLL_MGMT_PRO_FIN_ID = inuCOLL_MGMT_PRO_FIN_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TOTAL_COLLECTED:= inuTOTAL_COLLECTED$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updDATE_REGISTER
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		idtDATE_REGISTER$ in LDC_COLL_MGMT_PRO_FIN.DATE_REGISTER%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COLL_MGMT_PRO_FIN;
	BEGIN
		rcError.COLL_MGMT_PRO_FIN_ID := inuCOLL_MGMT_PRO_FIN_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCOLL_MGMT_PRO_FIN_ID,
				rcData
			);
		end if;

		update LDC_COLL_MGMT_PRO_FIN
		set
			DATE_REGISTER = idtDATE_REGISTER$
		where
			COLL_MGMT_PRO_FIN_ID = inuCOLL_MGMT_PRO_FIN_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DATE_REGISTER:= idtDATE_REGISTER$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updDIAS_CORTE
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuDIAS_CORTE$ in LDC_COLL_MGMT_PRO_FIN.DIAS_CORTE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COLL_MGMT_PRO_FIN;
	BEGIN
		rcError.COLL_MGMT_PRO_FIN_ID := inuCOLL_MGMT_PRO_FIN_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCOLL_MGMT_PRO_FIN_ID,
				rcData
			);
		end if;

		update LDC_COLL_MGMT_PRO_FIN
		set
			DIAS_CORTE = inuDIAS_CORTE$
		where
			COLL_MGMT_PRO_FIN_ID = inuCOLL_MGMT_PRO_FIN_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DIAS_CORTE:= inuDIAS_CORTE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updDEPTO
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuDEPTO$ in LDC_COLL_MGMT_PRO_FIN.DEPTO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COLL_MGMT_PRO_FIN;
	BEGIN
		rcError.COLL_MGMT_PRO_FIN_ID := inuCOLL_MGMT_PRO_FIN_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCOLL_MGMT_PRO_FIN_ID,
				rcData
			);
		end if;

		update LDC_COLL_MGMT_PRO_FIN
		set
			DEPTO = inuDEPTO$
		where
			COLL_MGMT_PRO_FIN_ID = inuCOLL_MGMT_PRO_FIN_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DEPTO:= inuDEPTO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updLOCALIDAD
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuLOCALIDAD$ in LDC_COLL_MGMT_PRO_FIN.LOCALIDAD%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COLL_MGMT_PRO_FIN;
	BEGIN
		rcError.COLL_MGMT_PRO_FIN_ID := inuCOLL_MGMT_PRO_FIN_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCOLL_MGMT_PRO_FIN_ID,
				rcData
			);
		end if;

		update LDC_COLL_MGMT_PRO_FIN
		set
			LOCALIDAD = inuLOCALIDAD$
		where
			COLL_MGMT_PRO_FIN_ID = inuCOLL_MGMT_PRO_FIN_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.LOCALIDAD:= inuLOCALIDAD$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updIS_VOIDED
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		isbIS_VOIDED$ in LDC_COLL_MGMT_PRO_FIN.IS_VOIDED%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COLL_MGMT_PRO_FIN;
	BEGIN
		rcError.COLL_MGMT_PRO_FIN_ID := inuCOLL_MGMT_PRO_FIN_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCOLL_MGMT_PRO_FIN_ID,
				rcData
			);
		end if;

		update LDC_COLL_MGMT_PRO_FIN
		set
			IS_VOIDED = isbIS_VOIDED$
		where
			COLL_MGMT_PRO_FIN_ID = inuCOLL_MGMT_PRO_FIN_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.IS_VOIDED:= isbIS_VOIDED$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updESTAFINA
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		isbESTAFINA$ in LDC_COLL_MGMT_PRO_FIN.ESTAFINA%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COLL_MGMT_PRO_FIN;
	BEGIN
		rcError.COLL_MGMT_PRO_FIN_ID := inuCOLL_MGMT_PRO_FIN_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCOLL_MGMT_PRO_FIN_ID,
				rcData
			);
		end if;

		update LDC_COLL_MGMT_PRO_FIN
		set
			ESTAFINA = isbESTAFINA$
		where
			COLL_MGMT_PRO_FIN_ID = inuCOLL_MGMT_PRO_FIN_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ESTAFINA:= isbESTAFINA$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updGEOGRAP_LOCATION_ID
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuGEOGRAP_LOCATION_ID$ in LDC_COLL_MGMT_PRO_FIN.GEOGRAP_LOCATION_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COLL_MGMT_PRO_FIN;
	BEGIN
		rcError.COLL_MGMT_PRO_FIN_ID := inuCOLL_MGMT_PRO_FIN_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCOLL_MGMT_PRO_FIN_ID,
				rcData
			);
		end if;

		update LDC_COLL_MGMT_PRO_FIN
		set
			GEOGRAP_LOCATION_ID = inuGEOGRAP_LOCATION_ID$
		where
			COLL_MGMT_PRO_FIN_ID = inuCOLL_MGMT_PRO_FIN_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.GEOGRAP_LOCATION_ID:= inuGEOGRAP_LOCATION_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPROCESADO
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		isbPROCESADO$ in LDC_COLL_MGMT_PRO_FIN.PROCESADO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_COLL_MGMT_PRO_FIN;
	BEGIN
		rcError.COLL_MGMT_PRO_FIN_ID := inuCOLL_MGMT_PRO_FIN_ID;
		if inuLock=1 then
			LockByPk
			(
				inuCOLL_MGMT_PRO_FIN_ID,
				rcData
			);
		end if;

		update LDC_COLL_MGMT_PRO_FIN
		set
			PROCESADO = isbPROCESADO$
		where
			COLL_MGMT_PRO_FIN_ID = inuCOLL_MGMT_PRO_FIN_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PROCESADO:= isbPROCESADO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetCOLL_MGMT_PRO_FIN_ID
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type
	IS
		rcError styLDC_COLL_MGMT_PRO_FIN;
	BEGIN

		rcError.COLL_MGMT_PRO_FIN_ID := inuCOLL_MGMT_PRO_FIN_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCOLL_MGMT_PRO_FIN_ID
			 )
		then
			 return(rcData.COLL_MGMT_PRO_FIN_ID);
		end if;
		Load
		(
		 		inuCOLL_MGMT_PRO_FIN_ID
		);
		return(rcData.COLL_MGMT_PRO_FIN_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetORDER_ID
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COLL_MGMT_PRO_FIN.ORDER_ID%type
	IS
		rcError styLDC_COLL_MGMT_PRO_FIN;
	BEGIN

		rcError.COLL_MGMT_PRO_FIN_ID := inuCOLL_MGMT_PRO_FIN_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCOLL_MGMT_PRO_FIN_ID
			 )
		then
			 return(rcData.ORDER_ID);
		end if;
		Load
		(
		 		inuCOLL_MGMT_PRO_FIN_ID
		);
		return(rcData.ORDER_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetEXEC_PROCESS_NAME
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COLL_MGMT_PRO_FIN.EXEC_PROCESS_NAME%type
	IS
		rcError styLDC_COLL_MGMT_PRO_FIN;
	BEGIN

		rcError.COLL_MGMT_PRO_FIN_ID := inuCOLL_MGMT_PRO_FIN_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCOLL_MGMT_PRO_FIN_ID
			 )
		then
			 return(rcData.EXEC_PROCESS_NAME);
		end if;
		Load
		(
		 		inuCOLL_MGMT_PRO_FIN_ID
		);
		return(rcData.EXEC_PROCESS_NAME);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCOLL_MGMT_PROC_CR_ID
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PROC_CR_ID%type
	IS
		rcError styLDC_COLL_MGMT_PRO_FIN;
	BEGIN

		rcError.COLL_MGMT_PRO_FIN_ID := inuCOLL_MGMT_PRO_FIN_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCOLL_MGMT_PRO_FIN_ID
			 )
		then
			 return(rcData.COLL_MGMT_PROC_CR_ID);
		end if;
		Load
		(
		 		inuCOLL_MGMT_PRO_FIN_ID
		);
		return(rcData.COLL_MGMT_PROC_CR_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetIS_LEVEL_MAIN
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COLL_MGMT_PRO_FIN.IS_LEVEL_MAIN%type
	IS
		rcError styLDC_COLL_MGMT_PRO_FIN;
	BEGIN

		rcError.COLL_MGMT_PRO_FIN_ID := inuCOLL_MGMT_PRO_FIN_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCOLL_MGMT_PRO_FIN_ID
			 )
		then
			 return(rcData.IS_LEVEL_MAIN);
		end if;
		Load
		(
		 		inuCOLL_MGMT_PRO_FIN_ID
		);
		return(rcData.IS_LEVEL_MAIN);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetSUBSCRIBER_ID
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COLL_MGMT_PRO_FIN.SUBSCRIBER_ID%type
	IS
		rcError styLDC_COLL_MGMT_PRO_FIN;
	BEGIN

		rcError.COLL_MGMT_PRO_FIN_ID := inuCOLL_MGMT_PRO_FIN_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCOLL_MGMT_PRO_FIN_ID
			 )
		then
			 return(rcData.SUBSCRIBER_ID);
		end if;
		Load
		(
		 		inuCOLL_MGMT_PRO_FIN_ID
		);
		return(rcData.SUBSCRIBER_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetSUBSCRIPTION_ID
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COLL_MGMT_PRO_FIN.SUBSCRIPTION_ID%type
	IS
		rcError styLDC_COLL_MGMT_PRO_FIN;
	BEGIN

		rcError.COLL_MGMT_PRO_FIN_ID := inuCOLL_MGMT_PRO_FIN_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCOLL_MGMT_PRO_FIN_ID
			 )
		then
			 return(rcData.SUBSCRIPTION_ID);
		end if;
		Load
		(
		 		inuCOLL_MGMT_PRO_FIN_ID
		);
		return(rcData.SUBSCRIPTION_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetPRODUCT_ID
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COLL_MGMT_PRO_FIN.PRODUCT_ID%type
	IS
		rcError styLDC_COLL_MGMT_PRO_FIN;
	BEGIN

		rcError.COLL_MGMT_PRO_FIN_ID := inuCOLL_MGMT_PRO_FIN_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCOLL_MGMT_PRO_FIN_ID
			 )
		then
			 return(rcData.PRODUCT_ID);
		end if;
		Load
		(
		 		inuCOLL_MGMT_PRO_FIN_ID
		);
		return(rcData.PRODUCT_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetDEBT_AGE
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COLL_MGMT_PRO_FIN.DEBT_AGE%type
	IS
		rcError styLDC_COLL_MGMT_PRO_FIN;
	BEGIN

		rcError.COLL_MGMT_PRO_FIN_ID := inuCOLL_MGMT_PRO_FIN_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCOLL_MGMT_PRO_FIN_ID
			 )
		then
			 return(rcData.DEBT_AGE);
		end if;
		Load
		(
		 		inuCOLL_MGMT_PRO_FIN_ID
		);
		return(rcData.DEBT_AGE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetTOTAL_DEBT
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COLL_MGMT_PRO_FIN.TOTAL_DEBT%type
	IS
		rcError styLDC_COLL_MGMT_PRO_FIN;
	BEGIN

		rcError.COLL_MGMT_PRO_FIN_ID := inuCOLL_MGMT_PRO_FIN_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCOLL_MGMT_PRO_FIN_ID
			 )
		then
			 return(rcData.TOTAL_DEBT);
		end if;
		Load
		(
		 		inuCOLL_MGMT_PRO_FIN_ID
		);
		return(rcData.TOTAL_DEBT);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetOUTSTANDING_DEBT
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COLL_MGMT_PRO_FIN.OUTSTANDING_DEBT%type
	IS
		rcError styLDC_COLL_MGMT_PRO_FIN;
	BEGIN

		rcError.COLL_MGMT_PRO_FIN_ID := inuCOLL_MGMT_PRO_FIN_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCOLL_MGMT_PRO_FIN_ID
			 )
		then
			 return(rcData.OUTSTANDING_DEBT);
		end if;
		Load
		(
		 		inuCOLL_MGMT_PRO_FIN_ID
		);
		return(rcData.OUTSTANDING_DEBT);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetOVERDUE_DEBT
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COLL_MGMT_PRO_FIN.OVERDUE_DEBT%type
	IS
		rcError styLDC_COLL_MGMT_PRO_FIN;
	BEGIN

		rcError.COLL_MGMT_PRO_FIN_ID := inuCOLL_MGMT_PRO_FIN_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCOLL_MGMT_PRO_FIN_ID
			 )
		then
			 return(rcData.OVERDUE_DEBT);
		end if;
		Load
		(
		 		inuCOLL_MGMT_PRO_FIN_ID
		);
		return(rcData.OVERDUE_DEBT);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetDEFERRED_DEBT
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COLL_MGMT_PRO_FIN.DEFERRED_DEBT%type
	IS
		rcError styLDC_COLL_MGMT_PRO_FIN;
	BEGIN

		rcError.COLL_MGMT_PRO_FIN_ID := inuCOLL_MGMT_PRO_FIN_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCOLL_MGMT_PRO_FIN_ID
			 )
		then
			 return(rcData.DEFERRED_DEBT);
		end if;
		Load
		(
		 		inuCOLL_MGMT_PRO_FIN_ID
		);
		return(rcData.DEFERRED_DEBT);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetPUNI_OVER_DEBT
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COLL_MGMT_PRO_FIN.PUNI_OVER_DEBT%type
	IS
		rcError styLDC_COLL_MGMT_PRO_FIN;
	BEGIN

		rcError.COLL_MGMT_PRO_FIN_ID := inuCOLL_MGMT_PRO_FIN_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCOLL_MGMT_PRO_FIN_ID
			 )
		then
			 return(rcData.PUNI_OVER_DEBT);
		end if;
		Load
		(
		 		inuCOLL_MGMT_PRO_FIN_ID
		);
		return(rcData.PUNI_OVER_DEBT);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetREFINANCI_TIMES
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COLL_MGMT_PRO_FIN.REFINANCI_TIMES%type
	IS
		rcError styLDC_COLL_MGMT_PRO_FIN;
	BEGIN

		rcError.COLL_MGMT_PRO_FIN_ID := inuCOLL_MGMT_PRO_FIN_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCOLL_MGMT_PRO_FIN_ID
			 )
		then
			 return(rcData.REFINANCI_TIMES);
		end if;
		Load
		(
		 		inuCOLL_MGMT_PRO_FIN_ID
		);
		return(rcData.REFINANCI_TIMES);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetFINANCING_PLAN_ID
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COLL_MGMT_PRO_FIN.FINANCING_PLAN_ID%type
	IS
		rcError styLDC_COLL_MGMT_PRO_FIN;
	BEGIN

		rcError.COLL_MGMT_PRO_FIN_ID := inuCOLL_MGMT_PRO_FIN_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCOLL_MGMT_PRO_FIN_ID
			 )
		then
			 return(rcData.FINANCING_PLAN_ID);
		end if;
		Load
		(
		 		inuCOLL_MGMT_PRO_FIN_ID
		);
		return(rcData.FINANCING_PLAN_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetOPERATING_UNIT_ID
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COLL_MGMT_PRO_FIN.OPERATING_UNIT_ID%type
	IS
		rcError styLDC_COLL_MGMT_PRO_FIN;
	BEGIN

		rcError.COLL_MGMT_PRO_FIN_ID := inuCOLL_MGMT_PRO_FIN_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCOLL_MGMT_PRO_FIN_ID
			 )
		then
			 return(rcData.OPERATING_UNIT_ID);
		end if;
		Load
		(
		 		inuCOLL_MGMT_PRO_FIN_ID
		);
		return(rcData.OPERATING_UNIT_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetTOTAL_COLLECTED
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COLL_MGMT_PRO_FIN.TOTAL_COLLECTED%type
	IS
		rcError styLDC_COLL_MGMT_PRO_FIN;
	BEGIN

		rcError.COLL_MGMT_PRO_FIN_ID := inuCOLL_MGMT_PRO_FIN_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCOLL_MGMT_PRO_FIN_ID
			 )
		then
			 return(rcData.TOTAL_COLLECTED);
		end if;
		Load
		(
		 		inuCOLL_MGMT_PRO_FIN_ID
		);
		return(rcData.TOTAL_COLLECTED);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetDATE_REGISTER
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COLL_MGMT_PRO_FIN.DATE_REGISTER%type
	IS
		rcError styLDC_COLL_MGMT_PRO_FIN;
	BEGIN

		rcError.COLL_MGMT_PRO_FIN_ID := inuCOLL_MGMT_PRO_FIN_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCOLL_MGMT_PRO_FIN_ID
			 )
		then
			 return(rcData.DATE_REGISTER);
		end if;
		Load
		(
		 		inuCOLL_MGMT_PRO_FIN_ID
		);
		return(rcData.DATE_REGISTER);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetDIAS_CORTE
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COLL_MGMT_PRO_FIN.DIAS_CORTE%type
	IS
		rcError styLDC_COLL_MGMT_PRO_FIN;
	BEGIN

		rcError.COLL_MGMT_PRO_FIN_ID := inuCOLL_MGMT_PRO_FIN_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCOLL_MGMT_PRO_FIN_ID
			 )
		then
			 return(rcData.DIAS_CORTE);
		end if;
		Load
		(
		 		inuCOLL_MGMT_PRO_FIN_ID
		);
		return(rcData.DIAS_CORTE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetDEPTO
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COLL_MGMT_PRO_FIN.DEPTO%type
	IS
		rcError styLDC_COLL_MGMT_PRO_FIN;
	BEGIN

		rcError.COLL_MGMT_PRO_FIN_ID := inuCOLL_MGMT_PRO_FIN_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCOLL_MGMT_PRO_FIN_ID
			 )
		then
			 return(rcData.DEPTO);
		end if;
		Load
		(
		 		inuCOLL_MGMT_PRO_FIN_ID
		);
		return(rcData.DEPTO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetLOCALIDAD
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COLL_MGMT_PRO_FIN.LOCALIDAD%type
	IS
		rcError styLDC_COLL_MGMT_PRO_FIN;
	BEGIN

		rcError.COLL_MGMT_PRO_FIN_ID := inuCOLL_MGMT_PRO_FIN_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCOLL_MGMT_PRO_FIN_ID
			 )
		then
			 return(rcData.LOCALIDAD);
		end if;
		Load
		(
		 		inuCOLL_MGMT_PRO_FIN_ID
		);
		return(rcData.LOCALIDAD);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetIS_VOIDED
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COLL_MGMT_PRO_FIN.IS_VOIDED%type
	IS
		rcError styLDC_COLL_MGMT_PRO_FIN;
	BEGIN

		rcError.COLL_MGMT_PRO_FIN_ID := inuCOLL_MGMT_PRO_FIN_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCOLL_MGMT_PRO_FIN_ID
			 )
		then
			 return(rcData.IS_VOIDED);
		end if;
		Load
		(
		 		inuCOLL_MGMT_PRO_FIN_ID
		);
		return(rcData.IS_VOIDED);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetESTAFINA
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COLL_MGMT_PRO_FIN.ESTAFINA%type
	IS
		rcError styLDC_COLL_MGMT_PRO_FIN;
	BEGIN

		rcError.COLL_MGMT_PRO_FIN_ID := inuCOLL_MGMT_PRO_FIN_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCOLL_MGMT_PRO_FIN_ID
			 )
		then
			 return(rcData.ESTAFINA);
		end if;
		Load
		(
		 		inuCOLL_MGMT_PRO_FIN_ID
		);
		return(rcData.ESTAFINA);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetGEOGRAP_LOCATION_ID
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COLL_MGMT_PRO_FIN.GEOGRAP_LOCATION_ID%type
	IS
		rcError styLDC_COLL_MGMT_PRO_FIN;
	BEGIN

		rcError.COLL_MGMT_PRO_FIN_ID := inuCOLL_MGMT_PRO_FIN_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCOLL_MGMT_PRO_FIN_ID
			 )
		then
			 return(rcData.GEOGRAP_LOCATION_ID);
		end if;
		Load
		(
		 		inuCOLL_MGMT_PRO_FIN_ID
		);
		return(rcData.GEOGRAP_LOCATION_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetPROCESADO
	(
		inuCOLL_MGMT_PRO_FIN_ID in LDC_COLL_MGMT_PRO_FIN.COLL_MGMT_PRO_FIN_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_COLL_MGMT_PRO_FIN.PROCESADO%type
	IS
		rcError styLDC_COLL_MGMT_PRO_FIN;
	BEGIN

		rcError.COLL_MGMT_PRO_FIN_ID := inuCOLL_MGMT_PRO_FIN_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuCOLL_MGMT_PRO_FIN_ID
			 )
		then
			 return(rcData.PROCESADO);
		end if;
		Load
		(
		 		inuCOLL_MGMT_PRO_FIN_ID
		);
		return(rcData.PROCESADO);
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
end DALDC_COLL_MGMT_PRO_FIN;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALDC_COLL_MGMT_PRO_FIN
BEGIN
    pkg_utilidades.prAplicarPermisos('DALDC_COLL_MGMT_PRO_FIN', 'ADM_PERSON'); 
END;
/

