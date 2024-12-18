CREATE OR REPLACE PACKAGE ADM_PERSON.DALD_PROMISSORY_PU
is
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     : DALD_PROMISSORY_PU
    Descripcion	 : 
    
    Parametro	    Descripcion
    ============	==============================
    
    Historia de Modificaciones
    Fecha   	           Autor            Modificacion
    ====================   =========        ====================
    31/05/2024              PAcosta         OSF-2767: Cambio de esquema ADM_PERSON                                              
    ****************************************************************/       
    
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type
	)
	IS
		SELECT LD_PROMISSORY_PU.*,LD_PROMISSORY_PU.rowid
		FROM LD_PROMISSORY_PU
		WHERE
		    PROMISSORY_ID = inuPROMISSORY_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LD_PROMISSORY_PU.*,LD_PROMISSORY_PU.rowid
		FROM LD_PROMISSORY_PU
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_PROMISSORY_PU  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_PROMISSORY_PU is table of styLD_PROMISSORY_PU index by binary_integer;
	type tyrfRecords is ref cursor return styLD_PROMISSORY_PU;

	/* Tipos referenciando al registro */
	type tytbADDRESS_PARSED is table of LD_PROMISSORY_PU.ADDRESS_PARSED%type index by binary_integer;
	type tytbPROMISSORY_ID is table of LD_PROMISSORY_PU.PROMISSORY_ID%type index by binary_integer;
	type tytbHOLDER_BILL is table of LD_PROMISSORY_PU.HOLDER_BILL%type index by binary_integer;
	type tytbDEBTORNAME is table of LD_PROMISSORY_PU.DEBTORNAME%type index by binary_integer;
	type tytbIDENTIFICATION is table of LD_PROMISSORY_PU.IDENTIFICATION%type index by binary_integer;
	type tytbIDENT_TYPE_ID is table of LD_PROMISSORY_PU.IDENT_TYPE_ID%type index by binary_integer;
	type tytbCONTRACT_TYPE_ID is table of LD_PROMISSORY_PU.CONTRACT_TYPE_ID%type index by binary_integer;
	type tytbFORWARDINGPLACE is table of LD_PROMISSORY_PU.FORWARDINGPLACE%type index by binary_integer;
	type tytbFORWARDINGDATE is table of LD_PROMISSORY_PU.FORWARDINGDATE%type index by binary_integer;
	type tytbGENDER is table of LD_PROMISSORY_PU.GENDER%type index by binary_integer;
	type tytbCIVIL_STATE_ID is table of LD_PROMISSORY_PU.CIVIL_STATE_ID%type index by binary_integer;
	type tytbCATEGORY_ID is table of LD_PROMISSORY_PU.CATEGORY_ID%type index by binary_integer;
	type tytbSUBCATEGORY_ID is table of LD_PROMISSORY_PU.SUBCATEGORY_ID%type index by binary_integer;
	type tytbBIRTHDAYDATE is table of LD_PROMISSORY_PU.BIRTHDAYDATE%type index by binary_integer;
	type tytbSCHOOL_DEGREE_ is table of LD_PROMISSORY_PU.SCHOOL_DEGREE_%type index by binary_integer;
	type tytbADDRESS_ID is table of LD_PROMISSORY_PU.ADDRESS_ID%type index by binary_integer;
	type tytbPROPERTYPHONE_ID is table of LD_PROMISSORY_PU.PROPERTYPHONE_ID%type index by binary_integer;
	type tytbDEPENDENTSNUMBER is table of LD_PROMISSORY_PU.DEPENDENTSNUMBER%type index by binary_integer;
	type tytbHOUSINGTYPE is table of LD_PROMISSORY_PU.HOUSINGTYPE%type index by binary_integer;
	type tytbHOUSINGMONTH is table of LD_PROMISSORY_PU.HOUSINGMONTH%type index by binary_integer;
	type tytbHOLDERRELATION is table of LD_PROMISSORY_PU.HOLDERRELATION%type index by binary_integer;
	type tytbOCCUPATION is table of LD_PROMISSORY_PU.OCCUPATION%type index by binary_integer;
	type tytbCOMPANYNAME is table of LD_PROMISSORY_PU.COMPANYNAME%type index by binary_integer;
	type tytbCOMPANYADDRESS_ID is table of LD_PROMISSORY_PU.COMPANYADDRESS_ID%type index by binary_integer;
	type tytbPHONE1_ID is table of LD_PROMISSORY_PU.PHONE1_ID%type index by binary_integer;
	type tytbPHONE2_ID is table of LD_PROMISSORY_PU.PHONE2_ID%type index by binary_integer;
	type tytbMOVILPHONE_ID is table of LD_PROMISSORY_PU.MOVILPHONE_ID%type index by binary_integer;
	type tytbOLDLABOR is table of LD_PROMISSORY_PU.OLDLABOR%type index by binary_integer;
	type tytbACTIVITY is table of LD_PROMISSORY_PU.ACTIVITY%type index by binary_integer;
	type tytbMONTHLYINCOME is table of LD_PROMISSORY_PU.MONTHLYINCOME%type index by binary_integer;
	type tytbEXPENSESINCOME is table of LD_PROMISSORY_PU.EXPENSESINCOME%type index by binary_integer;
	type tytbCOMMERREFERENCE is table of LD_PROMISSORY_PU.COMMERREFERENCE%type index by binary_integer;
	type tytbPHONECOMMREFE is table of LD_PROMISSORY_PU.PHONECOMMREFE%type index by binary_integer;
	type tytbMOVILPHOCOMMREFE is table of LD_PROMISSORY_PU.MOVILPHOCOMMREFE%type index by binary_integer;
	type tytbADDRESSCOMMREFE is table of LD_PROMISSORY_PU.ADDRESSCOMMREFE%type index by binary_integer;
	type tytbFAMILIARREFERENCE is table of LD_PROMISSORY_PU.FAMILIARREFERENCE%type index by binary_integer;
	type tytbPHONEFAMIREFE is table of LD_PROMISSORY_PU.PHONEFAMIREFE%type index by binary_integer;
	type tytbMOVILPHOFAMIREFE is table of LD_PROMISSORY_PU.MOVILPHOFAMIREFE%type index by binary_integer;
	type tytbADDRESSFAMIREFE is table of LD_PROMISSORY_PU.ADDRESSFAMIREFE%type index by binary_integer;
	type tytbPERSONALREFERENCE is table of LD_PROMISSORY_PU.PERSONALREFERENCE%type index by binary_integer;
	type tytbPHONEPERSREFE is table of LD_PROMISSORY_PU.PHONEPERSREFE%type index by binary_integer;
	type tytbMOVILPHOPERSREFE is table of LD_PROMISSORY_PU.MOVILPHOPERSREFE%type index by binary_integer;
	type tytbADDRESSPERSREFE is table of LD_PROMISSORY_PU.ADDRESSPERSREFE%type index by binary_integer;
	type tytbEMAIL is table of LD_PROMISSORY_PU.EMAIL%type index by binary_integer;
	type tytbPACKAGE_ID is table of LD_PROMISSORY_PU.PACKAGE_ID%type index by binary_integer;
	type tytbPROMISSORY_TYPE is table of LD_PROMISSORY_PU.PROMISSORY_TYPE%type index by binary_integer;
	type tytbLAST_NAME is table of LD_PROMISSORY_PU.LAST_NAME%type index by binary_integer;
	type tytbSOLIDARITY_DEBTOR is table of LD_PROMISSORY_PU.SOLIDARITY_DEBTOR%type index by binary_integer;
	type tytbCAUSAL_ID is table of LD_PROMISSORY_PU.CAUSAL_ID%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_PROMISSORY_PU is record
	(
		ADDRESS_PARSED   tytbADDRESS_PARSED,
		PROMISSORY_ID   tytbPROMISSORY_ID,
		HOLDER_BILL   tytbHOLDER_BILL,
		DEBTORNAME   tytbDEBTORNAME,
		IDENTIFICATION   tytbIDENTIFICATION,
		IDENT_TYPE_ID   tytbIDENT_TYPE_ID,
		CONTRACT_TYPE_ID   tytbCONTRACT_TYPE_ID,
		FORWARDINGPLACE   tytbFORWARDINGPLACE,
		FORWARDINGDATE   tytbFORWARDINGDATE,
		GENDER   tytbGENDER,
		CIVIL_STATE_ID   tytbCIVIL_STATE_ID,
		CATEGORY_ID   tytbCATEGORY_ID,
		SUBCATEGORY_ID   tytbSUBCATEGORY_ID,
		BIRTHDAYDATE   tytbBIRTHDAYDATE,
		SCHOOL_DEGREE_   tytbSCHOOL_DEGREE_,
		ADDRESS_ID   tytbADDRESS_ID,
		PROPERTYPHONE_ID   tytbPROPERTYPHONE_ID,
		DEPENDENTSNUMBER   tytbDEPENDENTSNUMBER,
		HOUSINGTYPE   tytbHOUSINGTYPE,
		HOUSINGMONTH   tytbHOUSINGMONTH,
		HOLDERRELATION   tytbHOLDERRELATION,
		OCCUPATION   tytbOCCUPATION,
		COMPANYNAME   tytbCOMPANYNAME,
		COMPANYADDRESS_ID   tytbCOMPANYADDRESS_ID,
		PHONE1_ID   tytbPHONE1_ID,
		PHONE2_ID   tytbPHONE2_ID,
		MOVILPHONE_ID   tytbMOVILPHONE_ID,
		OLDLABOR   tytbOLDLABOR,
		ACTIVITY   tytbACTIVITY,
		MONTHLYINCOME   tytbMONTHLYINCOME,
		EXPENSESINCOME   tytbEXPENSESINCOME,
		COMMERREFERENCE   tytbCOMMERREFERENCE,
		PHONECOMMREFE   tytbPHONECOMMREFE,
		MOVILPHOCOMMREFE   tytbMOVILPHOCOMMREFE,
		ADDRESSCOMMREFE   tytbADDRESSCOMMREFE,
		FAMILIARREFERENCE   tytbFAMILIARREFERENCE,
		PHONEFAMIREFE   tytbPHONEFAMIREFE,
		MOVILPHOFAMIREFE   tytbMOVILPHOFAMIREFE,
		ADDRESSFAMIREFE   tytbADDRESSFAMIREFE,
		PERSONALREFERENCE   tytbPERSONALREFERENCE,
		PHONEPERSREFE   tytbPHONEPERSREFE,
		MOVILPHOPERSREFE   tytbMOVILPHOPERSREFE,
		ADDRESSPERSREFE   tytbADDRESSPERSREFE,
		EMAIL   tytbEMAIL,
		PACKAGE_ID   tytbPACKAGE_ID,
		PROMISSORY_TYPE   tytbPROMISSORY_TYPE,
		LAST_NAME   tytbLAST_NAME,
		SOLIDARITY_DEBTOR   tytbSOLIDARITY_DEBTOR,
		CAUSAL_ID   tytbCAUSAL_ID,
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
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type
	);

	PROCEDURE getRecord
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		orcRecord out nocopy styLD_PROMISSORY_PU
	);

	FUNCTION frcGetRcData
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type
	)
	RETURN styLD_PROMISSORY_PU;

	FUNCTION frcGetRcData
	RETURN styLD_PROMISSORY_PU;

	FUNCTION frcGetRecord
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type
	)
	RETURN styLD_PROMISSORY_PU;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_PROMISSORY_PU
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_PROMISSORY_PU in styLD_PROMISSORY_PU
	);

	PROCEDURE insRecord
	(
		ircLD_PROMISSORY_PU in styLD_PROMISSORY_PU,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_PROMISSORY_PU in out nocopy tytbLD_PROMISSORY_PU
	);

	PROCEDURE delRecord
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_PROMISSORY_PU in out nocopy tytbLD_PROMISSORY_PU,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_PROMISSORY_PU in styLD_PROMISSORY_PU,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_PROMISSORY_PU in out nocopy tytbLD_PROMISSORY_PU,
		inuLock in number default 1
	);

	PROCEDURE updADDRESS_PARSED
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		isbADDRESS_PARSED$ in LD_PROMISSORY_PU.ADDRESS_PARSED%type,
		inuLock in number default 0
	);

	PROCEDURE updHOLDER_BILL
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		isbHOLDER_BILL$ in LD_PROMISSORY_PU.HOLDER_BILL%type,
		inuLock in number default 0
	);

	PROCEDURE updDEBTORNAME
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		isbDEBTORNAME$ in LD_PROMISSORY_PU.DEBTORNAME%type,
		inuLock in number default 0
	);

	PROCEDURE updIDENTIFICATION
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		isbIDENTIFICATION$ in LD_PROMISSORY_PU.IDENTIFICATION%type,
		inuLock in number default 0
	);

	PROCEDURE updIDENT_TYPE_ID
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuIDENT_TYPE_ID$ in LD_PROMISSORY_PU.IDENT_TYPE_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updCONTRACT_TYPE_ID
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuCONTRACT_TYPE_ID$ in LD_PROMISSORY_PU.CONTRACT_TYPE_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updFORWARDINGPLACE
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuFORWARDINGPLACE$ in LD_PROMISSORY_PU.FORWARDINGPLACE%type,
		inuLock in number default 0
	);

	PROCEDURE updFORWARDINGDATE
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		idtFORWARDINGDATE$ in LD_PROMISSORY_PU.FORWARDINGDATE%type,
		inuLock in number default 0
	);

	PROCEDURE updGENDER
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		isbGENDER$ in LD_PROMISSORY_PU.GENDER%type,
		inuLock in number default 0
	);

	PROCEDURE updCIVIL_STATE_ID
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuCIVIL_STATE_ID$ in LD_PROMISSORY_PU.CIVIL_STATE_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updCATEGORY_ID
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuCATEGORY_ID$ in LD_PROMISSORY_PU.CATEGORY_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updSUBCATEGORY_ID
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuSUBCATEGORY_ID$ in LD_PROMISSORY_PU.SUBCATEGORY_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updBIRTHDAYDATE
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		idtBIRTHDAYDATE$ in LD_PROMISSORY_PU.BIRTHDAYDATE%type,
		inuLock in number default 0
	);

	PROCEDURE updSCHOOL_DEGREE_
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuSCHOOL_DEGREE_$ in LD_PROMISSORY_PU.SCHOOL_DEGREE_%type,
		inuLock in number default 0
	);

	PROCEDURE updADDRESS_ID
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuADDRESS_ID$ in LD_PROMISSORY_PU.ADDRESS_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updPROPERTYPHONE_ID
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuPROPERTYPHONE_ID$ in LD_PROMISSORY_PU.PROPERTYPHONE_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updDEPENDENTSNUMBER
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuDEPENDENTSNUMBER$ in LD_PROMISSORY_PU.DEPENDENTSNUMBER%type,
		inuLock in number default 0
	);

	PROCEDURE updHOUSINGTYPE
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuHOUSINGTYPE$ in LD_PROMISSORY_PU.HOUSINGTYPE%type,
		inuLock in number default 0
	);

	PROCEDURE updHOUSINGMONTH
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuHOUSINGMONTH$ in LD_PROMISSORY_PU.HOUSINGMONTH%type,
		inuLock in number default 0
	);

	PROCEDURE updHOLDERRELATION
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuHOLDERRELATION$ in LD_PROMISSORY_PU.HOLDERRELATION%type,
		inuLock in number default 0
	);

	PROCEDURE updOCCUPATION
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		isbOCCUPATION$ in LD_PROMISSORY_PU.OCCUPATION%type,
		inuLock in number default 0
	);

	PROCEDURE updCOMPANYNAME
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		isbCOMPANYNAME$ in LD_PROMISSORY_PU.COMPANYNAME%type,
		inuLock in number default 0
	);

	PROCEDURE updCOMPANYADDRESS_ID
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuCOMPANYADDRESS_ID$ in LD_PROMISSORY_PU.COMPANYADDRESS_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updPHONE1_ID
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuPHONE1_ID$ in LD_PROMISSORY_PU.PHONE1_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updPHONE2_ID
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuPHONE2_ID$ in LD_PROMISSORY_PU.PHONE2_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updMOVILPHONE_ID
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuMOVILPHONE_ID$ in LD_PROMISSORY_PU.MOVILPHONE_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updOLDLABOR
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuOLDLABOR$ in LD_PROMISSORY_PU.OLDLABOR%type,
		inuLock in number default 0
	);

	PROCEDURE updACTIVITY
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		isbACTIVITY$ in LD_PROMISSORY_PU.ACTIVITY%type,
		inuLock in number default 0
	);

	PROCEDURE updMONTHLYINCOME
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuMONTHLYINCOME$ in LD_PROMISSORY_PU.MONTHLYINCOME%type,
		inuLock in number default 0
	);

	PROCEDURE updEXPENSESINCOME
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuEXPENSESINCOME$ in LD_PROMISSORY_PU.EXPENSESINCOME%type,
		inuLock in number default 0
	);

	PROCEDURE updCOMMERREFERENCE
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		isbCOMMERREFERENCE$ in LD_PROMISSORY_PU.COMMERREFERENCE%type,
		inuLock in number default 0
	);

	PROCEDURE updPHONECOMMREFE
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		isbPHONECOMMREFE$ in LD_PROMISSORY_PU.PHONECOMMREFE%type,
		inuLock in number default 0
	);

	PROCEDURE updMOVILPHOCOMMREFE
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		isbMOVILPHOCOMMREFE$ in LD_PROMISSORY_PU.MOVILPHOCOMMREFE%type,
		inuLock in number default 0
	);

	PROCEDURE updADDRESSCOMMREFE
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuADDRESSCOMMREFE$ in LD_PROMISSORY_PU.ADDRESSCOMMREFE%type,
		inuLock in number default 0
	);

	PROCEDURE updFAMILIARREFERENCE
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		isbFAMILIARREFERENCE$ in LD_PROMISSORY_PU.FAMILIARREFERENCE%type,
		inuLock in number default 0
	);

	PROCEDURE updPHONEFAMIREFE
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		isbPHONEFAMIREFE$ in LD_PROMISSORY_PU.PHONEFAMIREFE%type,
		inuLock in number default 0
	);

	PROCEDURE updMOVILPHOFAMIREFE
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		isbMOVILPHOFAMIREFE$ in LD_PROMISSORY_PU.MOVILPHOFAMIREFE%type,
		inuLock in number default 0
	);

	PROCEDURE updADDRESSFAMIREFE
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuADDRESSFAMIREFE$ in LD_PROMISSORY_PU.ADDRESSFAMIREFE%type,
		inuLock in number default 0
	);

	PROCEDURE updPERSONALREFERENCE
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		isbPERSONALREFERENCE$ in LD_PROMISSORY_PU.PERSONALREFERENCE%type,
		inuLock in number default 0
	);

	PROCEDURE updPHONEPERSREFE
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		isbPHONEPERSREFE$ in LD_PROMISSORY_PU.PHONEPERSREFE%type,
		inuLock in number default 0
	);

	PROCEDURE updMOVILPHOPERSREFE
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		isbMOVILPHOPERSREFE$ in LD_PROMISSORY_PU.MOVILPHOPERSREFE%type,
		inuLock in number default 0
	);

	PROCEDURE updADDRESSPERSREFE
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuADDRESSPERSREFE$ in LD_PROMISSORY_PU.ADDRESSPERSREFE%type,
		inuLock in number default 0
	);

	PROCEDURE updEMAIL
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		isbEMAIL$ in LD_PROMISSORY_PU.EMAIL%type,
		inuLock in number default 0
	);

	PROCEDURE updPACKAGE_ID
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuPACKAGE_ID$ in LD_PROMISSORY_PU.PACKAGE_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updPROMISSORY_TYPE
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		isbPROMISSORY_TYPE$ in LD_PROMISSORY_PU.PROMISSORY_TYPE%type,
		inuLock in number default 0
	);

	PROCEDURE updLAST_NAME
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		isbLAST_NAME$ in LD_PROMISSORY_PU.LAST_NAME%type,
		inuLock in number default 0
	);

	PROCEDURE updSOLIDARITY_DEBTOR
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		isbSOLIDARITY_DEBTOR$ in LD_PROMISSORY_PU.SOLIDARITY_DEBTOR%type,
		inuLock in number default 0
	);

	PROCEDURE updCAUSAL_ID
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuCAUSAL_ID$ in LD_PROMISSORY_PU.CAUSAL_ID%type,
		inuLock in number default 0
	);

	FUNCTION fsbGetADDRESS_PARSED
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.ADDRESS_PARSED%type;

	FUNCTION fnuGetPROMISSORY_ID
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.PROMISSORY_ID%type;

	FUNCTION fsbGetHOLDER_BILL
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.HOLDER_BILL%type;

	FUNCTION fsbGetDEBTORNAME
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.DEBTORNAME%type;

	FUNCTION fsbGetIDENTIFICATION
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.IDENTIFICATION%type;

	FUNCTION fnuGetIDENT_TYPE_ID
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.IDENT_TYPE_ID%type;

	FUNCTION fnuGetCONTRACT_TYPE_ID
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.CONTRACT_TYPE_ID%type;

	FUNCTION fnuGetFORWARDINGPLACE
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.FORWARDINGPLACE%type;

	FUNCTION fdtGetFORWARDINGDATE
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.FORWARDINGDATE%type;

	FUNCTION fsbGetGENDER
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.GENDER%type;

	FUNCTION fnuGetCIVIL_STATE_ID
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.CIVIL_STATE_ID%type;

	FUNCTION fnuGetCATEGORY_ID
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.CATEGORY_ID%type;

	FUNCTION fnuGetSUBCATEGORY_ID
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.SUBCATEGORY_ID%type;

	FUNCTION fdtGetBIRTHDAYDATE
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.BIRTHDAYDATE%type;

	FUNCTION fnuGetSCHOOL_DEGREE_
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.SCHOOL_DEGREE_%type;

	FUNCTION fnuGetADDRESS_ID
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.ADDRESS_ID%type;

	FUNCTION fnuGetPROPERTYPHONE_ID
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.PROPERTYPHONE_ID%type;

	FUNCTION fnuGetDEPENDENTSNUMBER
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.DEPENDENTSNUMBER%type;

	FUNCTION fnuGetHOUSINGTYPE
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.HOUSINGTYPE%type;

	FUNCTION fnuGetHOUSINGMONTH
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.HOUSINGMONTH%type;

	FUNCTION fnuGetHOLDERRELATION
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.HOLDERRELATION%type;

	FUNCTION fsbGetOCCUPATION
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.OCCUPATION%type;

	FUNCTION fsbGetCOMPANYNAME
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.COMPANYNAME%type;

	FUNCTION fnuGetCOMPANYADDRESS_ID
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.COMPANYADDRESS_ID%type;

	FUNCTION fnuGetPHONE1_ID
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.PHONE1_ID%type;

	FUNCTION fnuGetPHONE2_ID
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.PHONE2_ID%type;

	FUNCTION fnuGetMOVILPHONE_ID
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.MOVILPHONE_ID%type;

	FUNCTION fnuGetOLDLABOR
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.OLDLABOR%type;

	FUNCTION fsbGetACTIVITY
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.ACTIVITY%type;

	FUNCTION fnuGetMONTHLYINCOME
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.MONTHLYINCOME%type;

	FUNCTION fnuGetEXPENSESINCOME
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.EXPENSESINCOME%type;

	FUNCTION fsbGetCOMMERREFERENCE
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.COMMERREFERENCE%type;

	FUNCTION fsbGetPHONECOMMREFE
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.PHONECOMMREFE%type;

	FUNCTION fsbGetMOVILPHOCOMMREFE
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.MOVILPHOCOMMREFE%type;

	FUNCTION fnuGetADDRESSCOMMREFE
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.ADDRESSCOMMREFE%type;

	FUNCTION fsbGetFAMILIARREFERENCE
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.FAMILIARREFERENCE%type;

	FUNCTION fsbGetPHONEFAMIREFE
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.PHONEFAMIREFE%type;

	FUNCTION fsbGetMOVILPHOFAMIREFE
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.MOVILPHOFAMIREFE%type;

	FUNCTION fnuGetADDRESSFAMIREFE
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.ADDRESSFAMIREFE%type;

	FUNCTION fsbGetPERSONALREFERENCE
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.PERSONALREFERENCE%type;

	FUNCTION fsbGetPHONEPERSREFE
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.PHONEPERSREFE%type;

	FUNCTION fsbGetMOVILPHOPERSREFE
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.MOVILPHOPERSREFE%type;

	FUNCTION fnuGetADDRESSPERSREFE
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.ADDRESSPERSREFE%type;

	FUNCTION fsbGetEMAIL
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.EMAIL%type;

	FUNCTION fnuGetPACKAGE_ID
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.PACKAGE_ID%type;

	FUNCTION fsbGetPROMISSORY_TYPE
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.PROMISSORY_TYPE%type;

	FUNCTION fsbGetLAST_NAME
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.LAST_NAME%type;

	FUNCTION fsbGetSOLIDARITY_DEBTOR
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.SOLIDARITY_DEBTOR%type;

	FUNCTION fnuGetCAUSAL_ID
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.CAUSAL_ID%type;


	PROCEDURE LockByPk
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		orcLD_PROMISSORY_PU  out styLD_PROMISSORY_PU
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_PROMISSORY_PU  out styLD_PROMISSORY_PU
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_PROMISSORY_PU;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALD_PROMISSORY_PU
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_PROMISSORY_PU';
	 cnuGeEntityId constant varchar2(30) := 7972; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type
	)
	IS
		SELECT LD_PROMISSORY_PU.*,LD_PROMISSORY_PU.rowid
		FROM LD_PROMISSORY_PU
		WHERE  PROMISSORY_ID = inuPROMISSORY_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_PROMISSORY_PU.*,LD_PROMISSORY_PU.rowid
		FROM LD_PROMISSORY_PU
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLD_PROMISSORY_PU is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_PROMISSORY_PU;

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
	FUNCTION fsbPrimaryKey( rcI in styLD_PROMISSORY_PU default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.PROMISSORY_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		orcLD_PROMISSORY_PU  out styLD_PROMISSORY_PU
	)
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN
		rcError.PROMISSORY_ID := inuPROMISSORY_ID;

		Open cuLockRcByPk
		(
			inuPROMISSORY_ID
		);

		fetch cuLockRcByPk into orcLD_PROMISSORY_PU;
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
		orcLD_PROMISSORY_PU  out styLD_PROMISSORY_PU
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_PROMISSORY_PU;
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
		itbLD_PROMISSORY_PU  in out nocopy tytbLD_PROMISSORY_PU
	)
	IS
	BEGIN
			rcRecOfTab.ADDRESS_PARSED.delete;
			rcRecOfTab.PROMISSORY_ID.delete;
			rcRecOfTab.HOLDER_BILL.delete;
			rcRecOfTab.DEBTORNAME.delete;
			rcRecOfTab.IDENTIFICATION.delete;
			rcRecOfTab.IDENT_TYPE_ID.delete;
			rcRecOfTab.CONTRACT_TYPE_ID.delete;
			rcRecOfTab.FORWARDINGPLACE.delete;
			rcRecOfTab.FORWARDINGDATE.delete;
			rcRecOfTab.GENDER.delete;
			rcRecOfTab.CIVIL_STATE_ID.delete;
			rcRecOfTab.CATEGORY_ID.delete;
			rcRecOfTab.SUBCATEGORY_ID.delete;
			rcRecOfTab.BIRTHDAYDATE.delete;
			rcRecOfTab.SCHOOL_DEGREE_.delete;
			rcRecOfTab.ADDRESS_ID.delete;
			rcRecOfTab.PROPERTYPHONE_ID.delete;
			rcRecOfTab.DEPENDENTSNUMBER.delete;
			rcRecOfTab.HOUSINGTYPE.delete;
			rcRecOfTab.HOUSINGMONTH.delete;
			rcRecOfTab.HOLDERRELATION.delete;
			rcRecOfTab.OCCUPATION.delete;
			rcRecOfTab.COMPANYNAME.delete;
			rcRecOfTab.COMPANYADDRESS_ID.delete;
			rcRecOfTab.PHONE1_ID.delete;
			rcRecOfTab.PHONE2_ID.delete;
			rcRecOfTab.MOVILPHONE_ID.delete;
			rcRecOfTab.OLDLABOR.delete;
			rcRecOfTab.ACTIVITY.delete;
			rcRecOfTab.MONTHLYINCOME.delete;
			rcRecOfTab.EXPENSESINCOME.delete;
			rcRecOfTab.COMMERREFERENCE.delete;
			rcRecOfTab.PHONECOMMREFE.delete;
			rcRecOfTab.MOVILPHOCOMMREFE.delete;
			rcRecOfTab.ADDRESSCOMMREFE.delete;
			rcRecOfTab.FAMILIARREFERENCE.delete;
			rcRecOfTab.PHONEFAMIREFE.delete;
			rcRecOfTab.MOVILPHOFAMIREFE.delete;
			rcRecOfTab.ADDRESSFAMIREFE.delete;
			rcRecOfTab.PERSONALREFERENCE.delete;
			rcRecOfTab.PHONEPERSREFE.delete;
			rcRecOfTab.MOVILPHOPERSREFE.delete;
			rcRecOfTab.ADDRESSPERSREFE.delete;
			rcRecOfTab.EMAIL.delete;
			rcRecOfTab.PACKAGE_ID.delete;
			rcRecOfTab.PROMISSORY_TYPE.delete;
			rcRecOfTab.LAST_NAME.delete;
			rcRecOfTab.SOLIDARITY_DEBTOR.delete;
			rcRecOfTab.CAUSAL_ID.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_PROMISSORY_PU  in out nocopy tytbLD_PROMISSORY_PU,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_PROMISSORY_PU);

		for n in itbLD_PROMISSORY_PU.first .. itbLD_PROMISSORY_PU.last loop
			rcRecOfTab.ADDRESS_PARSED(n) := itbLD_PROMISSORY_PU(n).ADDRESS_PARSED;
			rcRecOfTab.PROMISSORY_ID(n) := itbLD_PROMISSORY_PU(n).PROMISSORY_ID;
			rcRecOfTab.HOLDER_BILL(n) := itbLD_PROMISSORY_PU(n).HOLDER_BILL;
			rcRecOfTab.DEBTORNAME(n) := itbLD_PROMISSORY_PU(n).DEBTORNAME;
			rcRecOfTab.IDENTIFICATION(n) := itbLD_PROMISSORY_PU(n).IDENTIFICATION;
			rcRecOfTab.IDENT_TYPE_ID(n) := itbLD_PROMISSORY_PU(n).IDENT_TYPE_ID;
			rcRecOfTab.CONTRACT_TYPE_ID(n) := itbLD_PROMISSORY_PU(n).CONTRACT_TYPE_ID;
			rcRecOfTab.FORWARDINGPLACE(n) := itbLD_PROMISSORY_PU(n).FORWARDINGPLACE;
			rcRecOfTab.FORWARDINGDATE(n) := itbLD_PROMISSORY_PU(n).FORWARDINGDATE;
			rcRecOfTab.GENDER(n) := itbLD_PROMISSORY_PU(n).GENDER;
			rcRecOfTab.CIVIL_STATE_ID(n) := itbLD_PROMISSORY_PU(n).CIVIL_STATE_ID;
			rcRecOfTab.CATEGORY_ID(n) := itbLD_PROMISSORY_PU(n).CATEGORY_ID;
			rcRecOfTab.SUBCATEGORY_ID(n) := itbLD_PROMISSORY_PU(n).SUBCATEGORY_ID;
			rcRecOfTab.BIRTHDAYDATE(n) := itbLD_PROMISSORY_PU(n).BIRTHDAYDATE;
			rcRecOfTab.SCHOOL_DEGREE_(n) := itbLD_PROMISSORY_PU(n).SCHOOL_DEGREE_;
			rcRecOfTab.ADDRESS_ID(n) := itbLD_PROMISSORY_PU(n).ADDRESS_ID;
			rcRecOfTab.PROPERTYPHONE_ID(n) := itbLD_PROMISSORY_PU(n).PROPERTYPHONE_ID;
			rcRecOfTab.DEPENDENTSNUMBER(n) := itbLD_PROMISSORY_PU(n).DEPENDENTSNUMBER;
			rcRecOfTab.HOUSINGTYPE(n) := itbLD_PROMISSORY_PU(n).HOUSINGTYPE;
			rcRecOfTab.HOUSINGMONTH(n) := itbLD_PROMISSORY_PU(n).HOUSINGMONTH;
			rcRecOfTab.HOLDERRELATION(n) := itbLD_PROMISSORY_PU(n).HOLDERRELATION;
			rcRecOfTab.OCCUPATION(n) := itbLD_PROMISSORY_PU(n).OCCUPATION;
			rcRecOfTab.COMPANYNAME(n) := itbLD_PROMISSORY_PU(n).COMPANYNAME;
			rcRecOfTab.COMPANYADDRESS_ID(n) := itbLD_PROMISSORY_PU(n).COMPANYADDRESS_ID;
			rcRecOfTab.PHONE1_ID(n) := itbLD_PROMISSORY_PU(n).PHONE1_ID;
			rcRecOfTab.PHONE2_ID(n) := itbLD_PROMISSORY_PU(n).PHONE2_ID;
			rcRecOfTab.MOVILPHONE_ID(n) := itbLD_PROMISSORY_PU(n).MOVILPHONE_ID;
			rcRecOfTab.OLDLABOR(n) := itbLD_PROMISSORY_PU(n).OLDLABOR;
			rcRecOfTab.ACTIVITY(n) := itbLD_PROMISSORY_PU(n).ACTIVITY;
			rcRecOfTab.MONTHLYINCOME(n) := itbLD_PROMISSORY_PU(n).MONTHLYINCOME;
			rcRecOfTab.EXPENSESINCOME(n) := itbLD_PROMISSORY_PU(n).EXPENSESINCOME;
			rcRecOfTab.COMMERREFERENCE(n) := itbLD_PROMISSORY_PU(n).COMMERREFERENCE;
			rcRecOfTab.PHONECOMMREFE(n) := itbLD_PROMISSORY_PU(n).PHONECOMMREFE;
			rcRecOfTab.MOVILPHOCOMMREFE(n) := itbLD_PROMISSORY_PU(n).MOVILPHOCOMMREFE;
			rcRecOfTab.ADDRESSCOMMREFE(n) := itbLD_PROMISSORY_PU(n).ADDRESSCOMMREFE;
			rcRecOfTab.FAMILIARREFERENCE(n) := itbLD_PROMISSORY_PU(n).FAMILIARREFERENCE;
			rcRecOfTab.PHONEFAMIREFE(n) := itbLD_PROMISSORY_PU(n).PHONEFAMIREFE;
			rcRecOfTab.MOVILPHOFAMIREFE(n) := itbLD_PROMISSORY_PU(n).MOVILPHOFAMIREFE;
			rcRecOfTab.ADDRESSFAMIREFE(n) := itbLD_PROMISSORY_PU(n).ADDRESSFAMIREFE;
			rcRecOfTab.PERSONALREFERENCE(n) := itbLD_PROMISSORY_PU(n).PERSONALREFERENCE;
			rcRecOfTab.PHONEPERSREFE(n) := itbLD_PROMISSORY_PU(n).PHONEPERSREFE;
			rcRecOfTab.MOVILPHOPERSREFE(n) := itbLD_PROMISSORY_PU(n).MOVILPHOPERSREFE;
			rcRecOfTab.ADDRESSPERSREFE(n) := itbLD_PROMISSORY_PU(n).ADDRESSPERSREFE;
			rcRecOfTab.EMAIL(n) := itbLD_PROMISSORY_PU(n).EMAIL;
			rcRecOfTab.PACKAGE_ID(n) := itbLD_PROMISSORY_PU(n).PACKAGE_ID;
			rcRecOfTab.PROMISSORY_TYPE(n) := itbLD_PROMISSORY_PU(n).PROMISSORY_TYPE;
			rcRecOfTab.LAST_NAME(n) := itbLD_PROMISSORY_PU(n).LAST_NAME;
			rcRecOfTab.SOLIDARITY_DEBTOR(n) := itbLD_PROMISSORY_PU(n).SOLIDARITY_DEBTOR;
			rcRecOfTab.CAUSAL_ID(n) := itbLD_PROMISSORY_PU(n).CAUSAL_ID;
			rcRecOfTab.row_id(n) := itbLD_PROMISSORY_PU(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuPROMISSORY_ID
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
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuPROMISSORY_ID = rcData.PROMISSORY_ID
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
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuPROMISSORY_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type
	)
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN		rcError.PROMISSORY_ID:=inuPROMISSORY_ID;

		Load
		(
			inuPROMISSORY_ID
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
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuPROMISSORY_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		orcRecord out nocopy styLD_PROMISSORY_PU
	)
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN		rcError.PROMISSORY_ID:=inuPROMISSORY_ID;

		Load
		(
			inuPROMISSORY_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type
	)
	RETURN styLD_PROMISSORY_PU
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN
		rcError.PROMISSORY_ID:=inuPROMISSORY_ID;

		Load
		(
			inuPROMISSORY_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type
	)
	RETURN styLD_PROMISSORY_PU
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN
		rcError.PROMISSORY_ID:=inuPROMISSORY_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuPROMISSORY_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuPROMISSORY_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_PROMISSORY_PU
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_PROMISSORY_PU
	)
	IS
		rfLD_PROMISSORY_PU tyrfLD_PROMISSORY_PU;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LD_PROMISSORY_PU.*, LD_PROMISSORY_PU.rowid FROM LD_PROMISSORY_PU';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLD_PROMISSORY_PU for sbFullQuery;

		fetch rfLD_PROMISSORY_PU bulk collect INTO otbResult;

		close rfLD_PROMISSORY_PU;
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
		sbSQL VARCHAR2 (32000) := 'select LD_PROMISSORY_PU.*, LD_PROMISSORY_PU.rowid FROM LD_PROMISSORY_PU';
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
		ircLD_PROMISSORY_PU in styLD_PROMISSORY_PU
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_PROMISSORY_PU,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLD_PROMISSORY_PU in styLD_PROMISSORY_PU,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_PROMISSORY_PU.PROMISSORY_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|PROMISSORY_ID');
			raise ex.controlled_error;
		end if;

		insert into LD_PROMISSORY_PU
		(
			ADDRESS_PARSED,
			PROMISSORY_ID,
			HOLDER_BILL,
			DEBTORNAME,
			IDENTIFICATION,
			IDENT_TYPE_ID,
			CONTRACT_TYPE_ID,
			FORWARDINGPLACE,
			FORWARDINGDATE,
			GENDER,
			CIVIL_STATE_ID,
			CATEGORY_ID,
			SUBCATEGORY_ID,
			BIRTHDAYDATE,
			SCHOOL_DEGREE_,
			ADDRESS_ID,
			PROPERTYPHONE_ID,
			DEPENDENTSNUMBER,
			HOUSINGTYPE,
			HOUSINGMONTH,
			HOLDERRELATION,
			OCCUPATION,
			COMPANYNAME,
			COMPANYADDRESS_ID,
			PHONE1_ID,
			PHONE2_ID,
			MOVILPHONE_ID,
			OLDLABOR,
			ACTIVITY,
			MONTHLYINCOME,
			EXPENSESINCOME,
			COMMERREFERENCE,
			PHONECOMMREFE,
			MOVILPHOCOMMREFE,
			ADDRESSCOMMREFE,
			FAMILIARREFERENCE,
			PHONEFAMIREFE,
			MOVILPHOFAMIREFE,
			ADDRESSFAMIREFE,
			PERSONALREFERENCE,
			PHONEPERSREFE,
			MOVILPHOPERSREFE,
			ADDRESSPERSREFE,
			EMAIL,
			PACKAGE_ID,
			PROMISSORY_TYPE,
			LAST_NAME,
			SOLIDARITY_DEBTOR,
			CAUSAL_ID
		)
		values
		(
			ircLD_PROMISSORY_PU.ADDRESS_PARSED,
			ircLD_PROMISSORY_PU.PROMISSORY_ID,
			ircLD_PROMISSORY_PU.HOLDER_BILL,
			ircLD_PROMISSORY_PU.DEBTORNAME,
			ircLD_PROMISSORY_PU.IDENTIFICATION,
			ircLD_PROMISSORY_PU.IDENT_TYPE_ID,
			ircLD_PROMISSORY_PU.CONTRACT_TYPE_ID,
			ircLD_PROMISSORY_PU.FORWARDINGPLACE,
			ircLD_PROMISSORY_PU.FORWARDINGDATE,
			ircLD_PROMISSORY_PU.GENDER,
			ircLD_PROMISSORY_PU.CIVIL_STATE_ID,
			ircLD_PROMISSORY_PU.CATEGORY_ID,
			ircLD_PROMISSORY_PU.SUBCATEGORY_ID,
			ircLD_PROMISSORY_PU.BIRTHDAYDATE,
			ircLD_PROMISSORY_PU.SCHOOL_DEGREE_,
			ircLD_PROMISSORY_PU.ADDRESS_ID,
			ircLD_PROMISSORY_PU.PROPERTYPHONE_ID,
			ircLD_PROMISSORY_PU.DEPENDENTSNUMBER,
			ircLD_PROMISSORY_PU.HOUSINGTYPE,
			ircLD_PROMISSORY_PU.HOUSINGMONTH,
			ircLD_PROMISSORY_PU.HOLDERRELATION,
			ircLD_PROMISSORY_PU.OCCUPATION,
			ircLD_PROMISSORY_PU.COMPANYNAME,
			ircLD_PROMISSORY_PU.COMPANYADDRESS_ID,
			ircLD_PROMISSORY_PU.PHONE1_ID,
			ircLD_PROMISSORY_PU.PHONE2_ID,
			ircLD_PROMISSORY_PU.MOVILPHONE_ID,
			ircLD_PROMISSORY_PU.OLDLABOR,
			ircLD_PROMISSORY_PU.ACTIVITY,
			ircLD_PROMISSORY_PU.MONTHLYINCOME,
			ircLD_PROMISSORY_PU.EXPENSESINCOME,
			ircLD_PROMISSORY_PU.COMMERREFERENCE,
			ircLD_PROMISSORY_PU.PHONECOMMREFE,
			ircLD_PROMISSORY_PU.MOVILPHOCOMMREFE,
			ircLD_PROMISSORY_PU.ADDRESSCOMMREFE,
			ircLD_PROMISSORY_PU.FAMILIARREFERENCE,
			ircLD_PROMISSORY_PU.PHONEFAMIREFE,
			ircLD_PROMISSORY_PU.MOVILPHOFAMIREFE,
			ircLD_PROMISSORY_PU.ADDRESSFAMIREFE,
			ircLD_PROMISSORY_PU.PERSONALREFERENCE,
			ircLD_PROMISSORY_PU.PHONEPERSREFE,
			ircLD_PROMISSORY_PU.MOVILPHOPERSREFE,
			ircLD_PROMISSORY_PU.ADDRESSPERSREFE,
			ircLD_PROMISSORY_PU.EMAIL,
			ircLD_PROMISSORY_PU.PACKAGE_ID,
			ircLD_PROMISSORY_PU.PROMISSORY_TYPE,
			ircLD_PROMISSORY_PU.LAST_NAME,
			ircLD_PROMISSORY_PU.SOLIDARITY_DEBTOR,
			ircLD_PROMISSORY_PU.CAUSAL_ID
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_PROMISSORY_PU));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLD_PROMISSORY_PU in out nocopy tytbLD_PROMISSORY_PU
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_PROMISSORY_PU,blUseRowID);
		forall n in iotbLD_PROMISSORY_PU.first..iotbLD_PROMISSORY_PU.last
			insert into LD_PROMISSORY_PU
			(
				ADDRESS_PARSED,
				PROMISSORY_ID,
				HOLDER_BILL,
				DEBTORNAME,
				IDENTIFICATION,
				IDENT_TYPE_ID,
				CONTRACT_TYPE_ID,
				FORWARDINGPLACE,
				FORWARDINGDATE,
				GENDER,
				CIVIL_STATE_ID,
				CATEGORY_ID,
				SUBCATEGORY_ID,
				BIRTHDAYDATE,
				SCHOOL_DEGREE_,
				ADDRESS_ID,
				PROPERTYPHONE_ID,
				DEPENDENTSNUMBER,
				HOUSINGTYPE,
				HOUSINGMONTH,
				HOLDERRELATION,
				OCCUPATION,
				COMPANYNAME,
				COMPANYADDRESS_ID,
				PHONE1_ID,
				PHONE2_ID,
				MOVILPHONE_ID,
				OLDLABOR,
				ACTIVITY,
				MONTHLYINCOME,
				EXPENSESINCOME,
				COMMERREFERENCE,
				PHONECOMMREFE,
				MOVILPHOCOMMREFE,
				ADDRESSCOMMREFE,
				FAMILIARREFERENCE,
				PHONEFAMIREFE,
				MOVILPHOFAMIREFE,
				ADDRESSFAMIREFE,
				PERSONALREFERENCE,
				PHONEPERSREFE,
				MOVILPHOPERSREFE,
				ADDRESSPERSREFE,
				EMAIL,
				PACKAGE_ID,
				PROMISSORY_TYPE,
				LAST_NAME,
				SOLIDARITY_DEBTOR,
				CAUSAL_ID
			)
			values
			(
				rcRecOfTab.ADDRESS_PARSED(n),
				rcRecOfTab.PROMISSORY_ID(n),
				rcRecOfTab.HOLDER_BILL(n),
				rcRecOfTab.DEBTORNAME(n),
				rcRecOfTab.IDENTIFICATION(n),
				rcRecOfTab.IDENT_TYPE_ID(n),
				rcRecOfTab.CONTRACT_TYPE_ID(n),
				rcRecOfTab.FORWARDINGPLACE(n),
				rcRecOfTab.FORWARDINGDATE(n),
				rcRecOfTab.GENDER(n),
				rcRecOfTab.CIVIL_STATE_ID(n),
				rcRecOfTab.CATEGORY_ID(n),
				rcRecOfTab.SUBCATEGORY_ID(n),
				rcRecOfTab.BIRTHDAYDATE(n),
				rcRecOfTab.SCHOOL_DEGREE_(n),
				rcRecOfTab.ADDRESS_ID(n),
				rcRecOfTab.PROPERTYPHONE_ID(n),
				rcRecOfTab.DEPENDENTSNUMBER(n),
				rcRecOfTab.HOUSINGTYPE(n),
				rcRecOfTab.HOUSINGMONTH(n),
				rcRecOfTab.HOLDERRELATION(n),
				rcRecOfTab.OCCUPATION(n),
				rcRecOfTab.COMPANYNAME(n),
				rcRecOfTab.COMPANYADDRESS_ID(n),
				rcRecOfTab.PHONE1_ID(n),
				rcRecOfTab.PHONE2_ID(n),
				rcRecOfTab.MOVILPHONE_ID(n),
				rcRecOfTab.OLDLABOR(n),
				rcRecOfTab.ACTIVITY(n),
				rcRecOfTab.MONTHLYINCOME(n),
				rcRecOfTab.EXPENSESINCOME(n),
				rcRecOfTab.COMMERREFERENCE(n),
				rcRecOfTab.PHONECOMMREFE(n),
				rcRecOfTab.MOVILPHOCOMMREFE(n),
				rcRecOfTab.ADDRESSCOMMREFE(n),
				rcRecOfTab.FAMILIARREFERENCE(n),
				rcRecOfTab.PHONEFAMIREFE(n),
				rcRecOfTab.MOVILPHOFAMIREFE(n),
				rcRecOfTab.ADDRESSFAMIREFE(n),
				rcRecOfTab.PERSONALREFERENCE(n),
				rcRecOfTab.PHONEPERSREFE(n),
				rcRecOfTab.MOVILPHOPERSREFE(n),
				rcRecOfTab.ADDRESSPERSREFE(n),
				rcRecOfTab.EMAIL(n),
				rcRecOfTab.PACKAGE_ID(n),
				rcRecOfTab.PROMISSORY_TYPE(n),
				rcRecOfTab.LAST_NAME(n),
				rcRecOfTab.SOLIDARITY_DEBTOR(n),
				rcRecOfTab.CAUSAL_ID(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN
		rcError.PROMISSORY_ID := inuPROMISSORY_ID;

		if inuLock=1 then
			LockByPk
			(
				inuPROMISSORY_ID,
				rcData
			);
		end if;


		delete
		from LD_PROMISSORY_PU
		where
       		PROMISSORY_ID=inuPROMISSORY_ID;
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
		rcError  styLD_PROMISSORY_PU;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LD_PROMISSORY_PU
		where
			rowid = iriRowID
		returning
			ADDRESS_PARSED
		into
			rcError.ADDRESS_PARSED;
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
		iotbLD_PROMISSORY_PU in out nocopy tytbLD_PROMISSORY_PU,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_PROMISSORY_PU;
	BEGIN
		FillRecordOfTables(iotbLD_PROMISSORY_PU, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_PROMISSORY_PU.first .. iotbLD_PROMISSORY_PU.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_PROMISSORY_PU.first .. iotbLD_PROMISSORY_PU.last
				delete
				from LD_PROMISSORY_PU
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_PROMISSORY_PU.first .. iotbLD_PROMISSORY_PU.last loop
					LockByPk
					(
						rcRecOfTab.PROMISSORY_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_PROMISSORY_PU.first .. iotbLD_PROMISSORY_PU.last
				delete
				from LD_PROMISSORY_PU
				where
		         	PROMISSORY_ID = rcRecOfTab.PROMISSORY_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLD_PROMISSORY_PU in styLD_PROMISSORY_PU,
		inuLock in number default 0
	)
	IS
		nuPROMISSORY_ID	LD_PROMISSORY_PU.PROMISSORY_ID%type;
	BEGIN
		if ircLD_PROMISSORY_PU.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_PROMISSORY_PU.rowid,rcData);
			end if;
			update LD_PROMISSORY_PU
			set
				ADDRESS_PARSED = ircLD_PROMISSORY_PU.ADDRESS_PARSED,
				HOLDER_BILL = ircLD_PROMISSORY_PU.HOLDER_BILL,
				DEBTORNAME = ircLD_PROMISSORY_PU.DEBTORNAME,
				IDENTIFICATION = ircLD_PROMISSORY_PU.IDENTIFICATION,
				IDENT_TYPE_ID = ircLD_PROMISSORY_PU.IDENT_TYPE_ID,
				CONTRACT_TYPE_ID = ircLD_PROMISSORY_PU.CONTRACT_TYPE_ID,
				FORWARDINGPLACE = ircLD_PROMISSORY_PU.FORWARDINGPLACE,
				FORWARDINGDATE = ircLD_PROMISSORY_PU.FORWARDINGDATE,
				GENDER = ircLD_PROMISSORY_PU.GENDER,
				CIVIL_STATE_ID = ircLD_PROMISSORY_PU.CIVIL_STATE_ID,
				CATEGORY_ID = ircLD_PROMISSORY_PU.CATEGORY_ID,
				SUBCATEGORY_ID = ircLD_PROMISSORY_PU.SUBCATEGORY_ID,
				BIRTHDAYDATE = ircLD_PROMISSORY_PU.BIRTHDAYDATE,
				SCHOOL_DEGREE_ = ircLD_PROMISSORY_PU.SCHOOL_DEGREE_,
				ADDRESS_ID = ircLD_PROMISSORY_PU.ADDRESS_ID,
				PROPERTYPHONE_ID = ircLD_PROMISSORY_PU.PROPERTYPHONE_ID,
				DEPENDENTSNUMBER = ircLD_PROMISSORY_PU.DEPENDENTSNUMBER,
				HOUSINGTYPE = ircLD_PROMISSORY_PU.HOUSINGTYPE,
				HOUSINGMONTH = ircLD_PROMISSORY_PU.HOUSINGMONTH,
				HOLDERRELATION = ircLD_PROMISSORY_PU.HOLDERRELATION,
				OCCUPATION = ircLD_PROMISSORY_PU.OCCUPATION,
				COMPANYNAME = ircLD_PROMISSORY_PU.COMPANYNAME,
				COMPANYADDRESS_ID = ircLD_PROMISSORY_PU.COMPANYADDRESS_ID,
				PHONE1_ID = ircLD_PROMISSORY_PU.PHONE1_ID,
				PHONE2_ID = ircLD_PROMISSORY_PU.PHONE2_ID,
				MOVILPHONE_ID = ircLD_PROMISSORY_PU.MOVILPHONE_ID,
				OLDLABOR = ircLD_PROMISSORY_PU.OLDLABOR,
				ACTIVITY = ircLD_PROMISSORY_PU.ACTIVITY,
				MONTHLYINCOME = ircLD_PROMISSORY_PU.MONTHLYINCOME,
				EXPENSESINCOME = ircLD_PROMISSORY_PU.EXPENSESINCOME,
				COMMERREFERENCE = ircLD_PROMISSORY_PU.COMMERREFERENCE,
				PHONECOMMREFE = ircLD_PROMISSORY_PU.PHONECOMMREFE,
				MOVILPHOCOMMREFE = ircLD_PROMISSORY_PU.MOVILPHOCOMMREFE,
				ADDRESSCOMMREFE = ircLD_PROMISSORY_PU.ADDRESSCOMMREFE,
				FAMILIARREFERENCE = ircLD_PROMISSORY_PU.FAMILIARREFERENCE,
				PHONEFAMIREFE = ircLD_PROMISSORY_PU.PHONEFAMIREFE,
				MOVILPHOFAMIREFE = ircLD_PROMISSORY_PU.MOVILPHOFAMIREFE,
				ADDRESSFAMIREFE = ircLD_PROMISSORY_PU.ADDRESSFAMIREFE,
				PERSONALREFERENCE = ircLD_PROMISSORY_PU.PERSONALREFERENCE,
				PHONEPERSREFE = ircLD_PROMISSORY_PU.PHONEPERSREFE,
				MOVILPHOPERSREFE = ircLD_PROMISSORY_PU.MOVILPHOPERSREFE,
				ADDRESSPERSREFE = ircLD_PROMISSORY_PU.ADDRESSPERSREFE,
				EMAIL = ircLD_PROMISSORY_PU.EMAIL,
				PACKAGE_ID = ircLD_PROMISSORY_PU.PACKAGE_ID,
				PROMISSORY_TYPE = ircLD_PROMISSORY_PU.PROMISSORY_TYPE,
				LAST_NAME = ircLD_PROMISSORY_PU.LAST_NAME,
				SOLIDARITY_DEBTOR = ircLD_PROMISSORY_PU.SOLIDARITY_DEBTOR,
				CAUSAL_ID = ircLD_PROMISSORY_PU.CAUSAL_ID
			where
				rowid = ircLD_PROMISSORY_PU.rowid
			returning
				PROMISSORY_ID
			into
				nuPROMISSORY_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_PROMISSORY_PU.PROMISSORY_ID,
					rcData
				);
			end if;

			update LD_PROMISSORY_PU
			set
				ADDRESS_PARSED = ircLD_PROMISSORY_PU.ADDRESS_PARSED,
				HOLDER_BILL = ircLD_PROMISSORY_PU.HOLDER_BILL,
				DEBTORNAME = ircLD_PROMISSORY_PU.DEBTORNAME,
				IDENTIFICATION = ircLD_PROMISSORY_PU.IDENTIFICATION,
				IDENT_TYPE_ID = ircLD_PROMISSORY_PU.IDENT_TYPE_ID,
				CONTRACT_TYPE_ID = ircLD_PROMISSORY_PU.CONTRACT_TYPE_ID,
				FORWARDINGPLACE = ircLD_PROMISSORY_PU.FORWARDINGPLACE,
				FORWARDINGDATE = ircLD_PROMISSORY_PU.FORWARDINGDATE,
				GENDER = ircLD_PROMISSORY_PU.GENDER,
				CIVIL_STATE_ID = ircLD_PROMISSORY_PU.CIVIL_STATE_ID,
				CATEGORY_ID = ircLD_PROMISSORY_PU.CATEGORY_ID,
				SUBCATEGORY_ID = ircLD_PROMISSORY_PU.SUBCATEGORY_ID,
				BIRTHDAYDATE = ircLD_PROMISSORY_PU.BIRTHDAYDATE,
				SCHOOL_DEGREE_ = ircLD_PROMISSORY_PU.SCHOOL_DEGREE_,
				ADDRESS_ID = ircLD_PROMISSORY_PU.ADDRESS_ID,
				PROPERTYPHONE_ID = ircLD_PROMISSORY_PU.PROPERTYPHONE_ID,
				DEPENDENTSNUMBER = ircLD_PROMISSORY_PU.DEPENDENTSNUMBER,
				HOUSINGTYPE = ircLD_PROMISSORY_PU.HOUSINGTYPE,
				HOUSINGMONTH = ircLD_PROMISSORY_PU.HOUSINGMONTH,
				HOLDERRELATION = ircLD_PROMISSORY_PU.HOLDERRELATION,
				OCCUPATION = ircLD_PROMISSORY_PU.OCCUPATION,
				COMPANYNAME = ircLD_PROMISSORY_PU.COMPANYNAME,
				COMPANYADDRESS_ID = ircLD_PROMISSORY_PU.COMPANYADDRESS_ID,
				PHONE1_ID = ircLD_PROMISSORY_PU.PHONE1_ID,
				PHONE2_ID = ircLD_PROMISSORY_PU.PHONE2_ID,
				MOVILPHONE_ID = ircLD_PROMISSORY_PU.MOVILPHONE_ID,
				OLDLABOR = ircLD_PROMISSORY_PU.OLDLABOR,
				ACTIVITY = ircLD_PROMISSORY_PU.ACTIVITY,
				MONTHLYINCOME = ircLD_PROMISSORY_PU.MONTHLYINCOME,
				EXPENSESINCOME = ircLD_PROMISSORY_PU.EXPENSESINCOME,
				COMMERREFERENCE = ircLD_PROMISSORY_PU.COMMERREFERENCE,
				PHONECOMMREFE = ircLD_PROMISSORY_PU.PHONECOMMREFE,
				MOVILPHOCOMMREFE = ircLD_PROMISSORY_PU.MOVILPHOCOMMREFE,
				ADDRESSCOMMREFE = ircLD_PROMISSORY_PU.ADDRESSCOMMREFE,
				FAMILIARREFERENCE = ircLD_PROMISSORY_PU.FAMILIARREFERENCE,
				PHONEFAMIREFE = ircLD_PROMISSORY_PU.PHONEFAMIREFE,
				MOVILPHOFAMIREFE = ircLD_PROMISSORY_PU.MOVILPHOFAMIREFE,
				ADDRESSFAMIREFE = ircLD_PROMISSORY_PU.ADDRESSFAMIREFE,
				PERSONALREFERENCE = ircLD_PROMISSORY_PU.PERSONALREFERENCE,
				PHONEPERSREFE = ircLD_PROMISSORY_PU.PHONEPERSREFE,
				MOVILPHOPERSREFE = ircLD_PROMISSORY_PU.MOVILPHOPERSREFE,
				ADDRESSPERSREFE = ircLD_PROMISSORY_PU.ADDRESSPERSREFE,
				EMAIL = ircLD_PROMISSORY_PU.EMAIL,
				PACKAGE_ID = ircLD_PROMISSORY_PU.PACKAGE_ID,
				PROMISSORY_TYPE = ircLD_PROMISSORY_PU.PROMISSORY_TYPE,
				LAST_NAME = ircLD_PROMISSORY_PU.LAST_NAME,
				SOLIDARITY_DEBTOR = ircLD_PROMISSORY_PU.SOLIDARITY_DEBTOR,
				CAUSAL_ID = ircLD_PROMISSORY_PU.CAUSAL_ID
			where
				PROMISSORY_ID = ircLD_PROMISSORY_PU.PROMISSORY_ID
			returning
				PROMISSORY_ID
			into
				nuPROMISSORY_ID;
		end if;
		if
			nuPROMISSORY_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_PROMISSORY_PU));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLD_PROMISSORY_PU in out nocopy tytbLD_PROMISSORY_PU,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_PROMISSORY_PU;
	BEGIN
		FillRecordOfTables(iotbLD_PROMISSORY_PU,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLD_PROMISSORY_PU.first .. iotbLD_PROMISSORY_PU.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_PROMISSORY_PU.first .. iotbLD_PROMISSORY_PU.last
				update LD_PROMISSORY_PU
				set
					ADDRESS_PARSED = rcRecOfTab.ADDRESS_PARSED(n),
					HOLDER_BILL = rcRecOfTab.HOLDER_BILL(n),
					DEBTORNAME = rcRecOfTab.DEBTORNAME(n),
					IDENTIFICATION = rcRecOfTab.IDENTIFICATION(n),
					IDENT_TYPE_ID = rcRecOfTab.IDENT_TYPE_ID(n),
					CONTRACT_TYPE_ID = rcRecOfTab.CONTRACT_TYPE_ID(n),
					FORWARDINGPLACE = rcRecOfTab.FORWARDINGPLACE(n),
					FORWARDINGDATE = rcRecOfTab.FORWARDINGDATE(n),
					GENDER = rcRecOfTab.GENDER(n),
					CIVIL_STATE_ID = rcRecOfTab.CIVIL_STATE_ID(n),
					CATEGORY_ID = rcRecOfTab.CATEGORY_ID(n),
					SUBCATEGORY_ID = rcRecOfTab.SUBCATEGORY_ID(n),
					BIRTHDAYDATE = rcRecOfTab.BIRTHDAYDATE(n),
					SCHOOL_DEGREE_ = rcRecOfTab.SCHOOL_DEGREE_(n),
					ADDRESS_ID = rcRecOfTab.ADDRESS_ID(n),
					PROPERTYPHONE_ID = rcRecOfTab.PROPERTYPHONE_ID(n),
					DEPENDENTSNUMBER = rcRecOfTab.DEPENDENTSNUMBER(n),
					HOUSINGTYPE = rcRecOfTab.HOUSINGTYPE(n),
					HOUSINGMONTH = rcRecOfTab.HOUSINGMONTH(n),
					HOLDERRELATION = rcRecOfTab.HOLDERRELATION(n),
					OCCUPATION = rcRecOfTab.OCCUPATION(n),
					COMPANYNAME = rcRecOfTab.COMPANYNAME(n),
					COMPANYADDRESS_ID = rcRecOfTab.COMPANYADDRESS_ID(n),
					PHONE1_ID = rcRecOfTab.PHONE1_ID(n),
					PHONE2_ID = rcRecOfTab.PHONE2_ID(n),
					MOVILPHONE_ID = rcRecOfTab.MOVILPHONE_ID(n),
					OLDLABOR = rcRecOfTab.OLDLABOR(n),
					ACTIVITY = rcRecOfTab.ACTIVITY(n),
					MONTHLYINCOME = rcRecOfTab.MONTHLYINCOME(n),
					EXPENSESINCOME = rcRecOfTab.EXPENSESINCOME(n),
					COMMERREFERENCE = rcRecOfTab.COMMERREFERENCE(n),
					PHONECOMMREFE = rcRecOfTab.PHONECOMMREFE(n),
					MOVILPHOCOMMREFE = rcRecOfTab.MOVILPHOCOMMREFE(n),
					ADDRESSCOMMREFE = rcRecOfTab.ADDRESSCOMMREFE(n),
					FAMILIARREFERENCE = rcRecOfTab.FAMILIARREFERENCE(n),
					PHONEFAMIREFE = rcRecOfTab.PHONEFAMIREFE(n),
					MOVILPHOFAMIREFE = rcRecOfTab.MOVILPHOFAMIREFE(n),
					ADDRESSFAMIREFE = rcRecOfTab.ADDRESSFAMIREFE(n),
					PERSONALREFERENCE = rcRecOfTab.PERSONALREFERENCE(n),
					PHONEPERSREFE = rcRecOfTab.PHONEPERSREFE(n),
					MOVILPHOPERSREFE = rcRecOfTab.MOVILPHOPERSREFE(n),
					ADDRESSPERSREFE = rcRecOfTab.ADDRESSPERSREFE(n),
					EMAIL = rcRecOfTab.EMAIL(n),
					PACKAGE_ID = rcRecOfTab.PACKAGE_ID(n),
					PROMISSORY_TYPE = rcRecOfTab.PROMISSORY_TYPE(n),
					LAST_NAME = rcRecOfTab.LAST_NAME(n),
					SOLIDARITY_DEBTOR = rcRecOfTab.SOLIDARITY_DEBTOR(n),
					CAUSAL_ID = rcRecOfTab.CAUSAL_ID(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_PROMISSORY_PU.first .. iotbLD_PROMISSORY_PU.last loop
					LockByPk
					(
						rcRecOfTab.PROMISSORY_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_PROMISSORY_PU.first .. iotbLD_PROMISSORY_PU.last
				update LD_PROMISSORY_PU
				SET
					ADDRESS_PARSED = rcRecOfTab.ADDRESS_PARSED(n),
					HOLDER_BILL = rcRecOfTab.HOLDER_BILL(n),
					DEBTORNAME = rcRecOfTab.DEBTORNAME(n),
					IDENTIFICATION = rcRecOfTab.IDENTIFICATION(n),
					IDENT_TYPE_ID = rcRecOfTab.IDENT_TYPE_ID(n),
					CONTRACT_TYPE_ID = rcRecOfTab.CONTRACT_TYPE_ID(n),
					FORWARDINGPLACE = rcRecOfTab.FORWARDINGPLACE(n),
					FORWARDINGDATE = rcRecOfTab.FORWARDINGDATE(n),
					GENDER = rcRecOfTab.GENDER(n),
					CIVIL_STATE_ID = rcRecOfTab.CIVIL_STATE_ID(n),
					CATEGORY_ID = rcRecOfTab.CATEGORY_ID(n),
					SUBCATEGORY_ID = rcRecOfTab.SUBCATEGORY_ID(n),
					BIRTHDAYDATE = rcRecOfTab.BIRTHDAYDATE(n),
					SCHOOL_DEGREE_ = rcRecOfTab.SCHOOL_DEGREE_(n),
					ADDRESS_ID = rcRecOfTab.ADDRESS_ID(n),
					PROPERTYPHONE_ID = rcRecOfTab.PROPERTYPHONE_ID(n),
					DEPENDENTSNUMBER = rcRecOfTab.DEPENDENTSNUMBER(n),
					HOUSINGTYPE = rcRecOfTab.HOUSINGTYPE(n),
					HOUSINGMONTH = rcRecOfTab.HOUSINGMONTH(n),
					HOLDERRELATION = rcRecOfTab.HOLDERRELATION(n),
					OCCUPATION = rcRecOfTab.OCCUPATION(n),
					COMPANYNAME = rcRecOfTab.COMPANYNAME(n),
					COMPANYADDRESS_ID = rcRecOfTab.COMPANYADDRESS_ID(n),
					PHONE1_ID = rcRecOfTab.PHONE1_ID(n),
					PHONE2_ID = rcRecOfTab.PHONE2_ID(n),
					MOVILPHONE_ID = rcRecOfTab.MOVILPHONE_ID(n),
					OLDLABOR = rcRecOfTab.OLDLABOR(n),
					ACTIVITY = rcRecOfTab.ACTIVITY(n),
					MONTHLYINCOME = rcRecOfTab.MONTHLYINCOME(n),
					EXPENSESINCOME = rcRecOfTab.EXPENSESINCOME(n),
					COMMERREFERENCE = rcRecOfTab.COMMERREFERENCE(n),
					PHONECOMMREFE = rcRecOfTab.PHONECOMMREFE(n),
					MOVILPHOCOMMREFE = rcRecOfTab.MOVILPHOCOMMREFE(n),
					ADDRESSCOMMREFE = rcRecOfTab.ADDRESSCOMMREFE(n),
					FAMILIARREFERENCE = rcRecOfTab.FAMILIARREFERENCE(n),
					PHONEFAMIREFE = rcRecOfTab.PHONEFAMIREFE(n),
					MOVILPHOFAMIREFE = rcRecOfTab.MOVILPHOFAMIREFE(n),
					ADDRESSFAMIREFE = rcRecOfTab.ADDRESSFAMIREFE(n),
					PERSONALREFERENCE = rcRecOfTab.PERSONALREFERENCE(n),
					PHONEPERSREFE = rcRecOfTab.PHONEPERSREFE(n),
					MOVILPHOPERSREFE = rcRecOfTab.MOVILPHOPERSREFE(n),
					ADDRESSPERSREFE = rcRecOfTab.ADDRESSPERSREFE(n),
					EMAIL = rcRecOfTab.EMAIL(n),
					PACKAGE_ID = rcRecOfTab.PACKAGE_ID(n),
					PROMISSORY_TYPE = rcRecOfTab.PROMISSORY_TYPE(n),
					LAST_NAME = rcRecOfTab.LAST_NAME(n),
					SOLIDARITY_DEBTOR = rcRecOfTab.SOLIDARITY_DEBTOR(n),
					CAUSAL_ID = rcRecOfTab.CAUSAL_ID(n)
				where
					PROMISSORY_ID = rcRecOfTab.PROMISSORY_ID(n)
;
		end if;
	END;
	PROCEDURE updADDRESS_PARSED
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		isbADDRESS_PARSED$ in LD_PROMISSORY_PU.ADDRESS_PARSED%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN
		rcError.PROMISSORY_ID := inuPROMISSORY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPROMISSORY_ID,
				rcData
			);
		end if;

		update LD_PROMISSORY_PU
		set
			ADDRESS_PARSED = isbADDRESS_PARSED$
		where
			PROMISSORY_ID = inuPROMISSORY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ADDRESS_PARSED:= isbADDRESS_PARSED$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updHOLDER_BILL
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		isbHOLDER_BILL$ in LD_PROMISSORY_PU.HOLDER_BILL%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN
		rcError.PROMISSORY_ID := inuPROMISSORY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPROMISSORY_ID,
				rcData
			);
		end if;

		update LD_PROMISSORY_PU
		set
			HOLDER_BILL = isbHOLDER_BILL$
		where
			PROMISSORY_ID = inuPROMISSORY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.HOLDER_BILL:= isbHOLDER_BILL$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updDEBTORNAME
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		isbDEBTORNAME$ in LD_PROMISSORY_PU.DEBTORNAME%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN
		rcError.PROMISSORY_ID := inuPROMISSORY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPROMISSORY_ID,
				rcData
			);
		end if;

		update LD_PROMISSORY_PU
		set
			DEBTORNAME = isbDEBTORNAME$
		where
			PROMISSORY_ID = inuPROMISSORY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DEBTORNAME:= isbDEBTORNAME$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updIDENTIFICATION
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		isbIDENTIFICATION$ in LD_PROMISSORY_PU.IDENTIFICATION%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN
		rcError.PROMISSORY_ID := inuPROMISSORY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPROMISSORY_ID,
				rcData
			);
		end if;

		update LD_PROMISSORY_PU
		set
			IDENTIFICATION = isbIDENTIFICATION$
		where
			PROMISSORY_ID = inuPROMISSORY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.IDENTIFICATION:= isbIDENTIFICATION$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updIDENT_TYPE_ID
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuIDENT_TYPE_ID$ in LD_PROMISSORY_PU.IDENT_TYPE_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN
		rcError.PROMISSORY_ID := inuPROMISSORY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPROMISSORY_ID,
				rcData
			);
		end if;

		update LD_PROMISSORY_PU
		set
			IDENT_TYPE_ID = inuIDENT_TYPE_ID$
		where
			PROMISSORY_ID = inuPROMISSORY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.IDENT_TYPE_ID:= inuIDENT_TYPE_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCONTRACT_TYPE_ID
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuCONTRACT_TYPE_ID$ in LD_PROMISSORY_PU.CONTRACT_TYPE_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN
		rcError.PROMISSORY_ID := inuPROMISSORY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPROMISSORY_ID,
				rcData
			);
		end if;

		update LD_PROMISSORY_PU
		set
			CONTRACT_TYPE_ID = inuCONTRACT_TYPE_ID$
		where
			PROMISSORY_ID = inuPROMISSORY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CONTRACT_TYPE_ID:= inuCONTRACT_TYPE_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFORWARDINGPLACE
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuFORWARDINGPLACE$ in LD_PROMISSORY_PU.FORWARDINGPLACE%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN
		rcError.PROMISSORY_ID := inuPROMISSORY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPROMISSORY_ID,
				rcData
			);
		end if;

		update LD_PROMISSORY_PU
		set
			FORWARDINGPLACE = inuFORWARDINGPLACE$
		where
			PROMISSORY_ID = inuPROMISSORY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FORWARDINGPLACE:= inuFORWARDINGPLACE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFORWARDINGDATE
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		idtFORWARDINGDATE$ in LD_PROMISSORY_PU.FORWARDINGDATE%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN
		rcError.PROMISSORY_ID := inuPROMISSORY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPROMISSORY_ID,
				rcData
			);
		end if;

		update LD_PROMISSORY_PU
		set
			FORWARDINGDATE = idtFORWARDINGDATE$
		where
			PROMISSORY_ID = inuPROMISSORY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FORWARDINGDATE:= idtFORWARDINGDATE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updGENDER
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		isbGENDER$ in LD_PROMISSORY_PU.GENDER%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN
		rcError.PROMISSORY_ID := inuPROMISSORY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPROMISSORY_ID,
				rcData
			);
		end if;

		update LD_PROMISSORY_PU
		set
			GENDER = isbGENDER$
		where
			PROMISSORY_ID = inuPROMISSORY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.GENDER:= isbGENDER$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCIVIL_STATE_ID
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuCIVIL_STATE_ID$ in LD_PROMISSORY_PU.CIVIL_STATE_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN
		rcError.PROMISSORY_ID := inuPROMISSORY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPROMISSORY_ID,
				rcData
			);
		end if;

		update LD_PROMISSORY_PU
		set
			CIVIL_STATE_ID = inuCIVIL_STATE_ID$
		where
			PROMISSORY_ID = inuPROMISSORY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CIVIL_STATE_ID:= inuCIVIL_STATE_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCATEGORY_ID
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuCATEGORY_ID$ in LD_PROMISSORY_PU.CATEGORY_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN
		rcError.PROMISSORY_ID := inuPROMISSORY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPROMISSORY_ID,
				rcData
			);
		end if;

		update LD_PROMISSORY_PU
		set
			CATEGORY_ID = inuCATEGORY_ID$
		where
			PROMISSORY_ID = inuPROMISSORY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CATEGORY_ID:= inuCATEGORY_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSUBCATEGORY_ID
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuSUBCATEGORY_ID$ in LD_PROMISSORY_PU.SUBCATEGORY_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN
		rcError.PROMISSORY_ID := inuPROMISSORY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPROMISSORY_ID,
				rcData
			);
		end if;

		update LD_PROMISSORY_PU
		set
			SUBCATEGORY_ID = inuSUBCATEGORY_ID$
		where
			PROMISSORY_ID = inuPROMISSORY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SUBCATEGORY_ID:= inuSUBCATEGORY_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updBIRTHDAYDATE
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		idtBIRTHDAYDATE$ in LD_PROMISSORY_PU.BIRTHDAYDATE%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN
		rcError.PROMISSORY_ID := inuPROMISSORY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPROMISSORY_ID,
				rcData
			);
		end if;

		update LD_PROMISSORY_PU
		set
			BIRTHDAYDATE = idtBIRTHDAYDATE$
		where
			PROMISSORY_ID = inuPROMISSORY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.BIRTHDAYDATE:= idtBIRTHDAYDATE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSCHOOL_DEGREE_
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuSCHOOL_DEGREE_$ in LD_PROMISSORY_PU.SCHOOL_DEGREE_%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN
		rcError.PROMISSORY_ID := inuPROMISSORY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPROMISSORY_ID,
				rcData
			);
		end if;

		update LD_PROMISSORY_PU
		set
			SCHOOL_DEGREE_ = inuSCHOOL_DEGREE_$
		where
			PROMISSORY_ID = inuPROMISSORY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SCHOOL_DEGREE_:= inuSCHOOL_DEGREE_$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updADDRESS_ID
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuADDRESS_ID$ in LD_PROMISSORY_PU.ADDRESS_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN
		rcError.PROMISSORY_ID := inuPROMISSORY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPROMISSORY_ID,
				rcData
			);
		end if;

		update LD_PROMISSORY_PU
		set
			ADDRESS_ID = inuADDRESS_ID$
		where
			PROMISSORY_ID = inuPROMISSORY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ADDRESS_ID:= inuADDRESS_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPROPERTYPHONE_ID
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuPROPERTYPHONE_ID$ in LD_PROMISSORY_PU.PROPERTYPHONE_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN
		rcError.PROMISSORY_ID := inuPROMISSORY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPROMISSORY_ID,
				rcData
			);
		end if;

		update LD_PROMISSORY_PU
		set
			PROPERTYPHONE_ID = inuPROPERTYPHONE_ID$
		where
			PROMISSORY_ID = inuPROMISSORY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PROPERTYPHONE_ID:= inuPROPERTYPHONE_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updDEPENDENTSNUMBER
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuDEPENDENTSNUMBER$ in LD_PROMISSORY_PU.DEPENDENTSNUMBER%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN
		rcError.PROMISSORY_ID := inuPROMISSORY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPROMISSORY_ID,
				rcData
			);
		end if;

		update LD_PROMISSORY_PU
		set
			DEPENDENTSNUMBER = inuDEPENDENTSNUMBER$
		where
			PROMISSORY_ID = inuPROMISSORY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DEPENDENTSNUMBER:= inuDEPENDENTSNUMBER$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updHOUSINGTYPE
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuHOUSINGTYPE$ in LD_PROMISSORY_PU.HOUSINGTYPE%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN
		rcError.PROMISSORY_ID := inuPROMISSORY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPROMISSORY_ID,
				rcData
			);
		end if;

		update LD_PROMISSORY_PU
		set
			HOUSINGTYPE = inuHOUSINGTYPE$
		where
			PROMISSORY_ID = inuPROMISSORY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.HOUSINGTYPE:= inuHOUSINGTYPE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updHOUSINGMONTH
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuHOUSINGMONTH$ in LD_PROMISSORY_PU.HOUSINGMONTH%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN
		rcError.PROMISSORY_ID := inuPROMISSORY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPROMISSORY_ID,
				rcData
			);
		end if;

		update LD_PROMISSORY_PU
		set
			HOUSINGMONTH = inuHOUSINGMONTH$
		where
			PROMISSORY_ID = inuPROMISSORY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.HOUSINGMONTH:= inuHOUSINGMONTH$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updHOLDERRELATION
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuHOLDERRELATION$ in LD_PROMISSORY_PU.HOLDERRELATION%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN
		rcError.PROMISSORY_ID := inuPROMISSORY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPROMISSORY_ID,
				rcData
			);
		end if;

		update LD_PROMISSORY_PU
		set
			HOLDERRELATION = inuHOLDERRELATION$
		where
			PROMISSORY_ID = inuPROMISSORY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.HOLDERRELATION:= inuHOLDERRELATION$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updOCCUPATION
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		isbOCCUPATION$ in LD_PROMISSORY_PU.OCCUPATION%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN
		rcError.PROMISSORY_ID := inuPROMISSORY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPROMISSORY_ID,
				rcData
			);
		end if;

		update LD_PROMISSORY_PU
		set
			OCCUPATION = isbOCCUPATION$
		where
			PROMISSORY_ID = inuPROMISSORY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.OCCUPATION:= isbOCCUPATION$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCOMPANYNAME
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		isbCOMPANYNAME$ in LD_PROMISSORY_PU.COMPANYNAME%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN
		rcError.PROMISSORY_ID := inuPROMISSORY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPROMISSORY_ID,
				rcData
			);
		end if;

		update LD_PROMISSORY_PU
		set
			COMPANYNAME = isbCOMPANYNAME$
		where
			PROMISSORY_ID = inuPROMISSORY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.COMPANYNAME:= isbCOMPANYNAME$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCOMPANYADDRESS_ID
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuCOMPANYADDRESS_ID$ in LD_PROMISSORY_PU.COMPANYADDRESS_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN
		rcError.PROMISSORY_ID := inuPROMISSORY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPROMISSORY_ID,
				rcData
			);
		end if;

		update LD_PROMISSORY_PU
		set
			COMPANYADDRESS_ID = inuCOMPANYADDRESS_ID$
		where
			PROMISSORY_ID = inuPROMISSORY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.COMPANYADDRESS_ID:= inuCOMPANYADDRESS_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPHONE1_ID
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuPHONE1_ID$ in LD_PROMISSORY_PU.PHONE1_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN
		rcError.PROMISSORY_ID := inuPROMISSORY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPROMISSORY_ID,
				rcData
			);
		end if;

		update LD_PROMISSORY_PU
		set
			PHONE1_ID = inuPHONE1_ID$
		where
			PROMISSORY_ID = inuPROMISSORY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PHONE1_ID:= inuPHONE1_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPHONE2_ID
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuPHONE2_ID$ in LD_PROMISSORY_PU.PHONE2_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN
		rcError.PROMISSORY_ID := inuPROMISSORY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPROMISSORY_ID,
				rcData
			);
		end if;

		update LD_PROMISSORY_PU
		set
			PHONE2_ID = inuPHONE2_ID$
		where
			PROMISSORY_ID = inuPROMISSORY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PHONE2_ID:= inuPHONE2_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updMOVILPHONE_ID
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuMOVILPHONE_ID$ in LD_PROMISSORY_PU.MOVILPHONE_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN
		rcError.PROMISSORY_ID := inuPROMISSORY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPROMISSORY_ID,
				rcData
			);
		end if;

		update LD_PROMISSORY_PU
		set
			MOVILPHONE_ID = inuMOVILPHONE_ID$
		where
			PROMISSORY_ID = inuPROMISSORY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.MOVILPHONE_ID:= inuMOVILPHONE_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updOLDLABOR
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuOLDLABOR$ in LD_PROMISSORY_PU.OLDLABOR%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN
		rcError.PROMISSORY_ID := inuPROMISSORY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPROMISSORY_ID,
				rcData
			);
		end if;

		update LD_PROMISSORY_PU
		set
			OLDLABOR = inuOLDLABOR$
		where
			PROMISSORY_ID = inuPROMISSORY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.OLDLABOR:= inuOLDLABOR$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updACTIVITY
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		isbACTIVITY$ in LD_PROMISSORY_PU.ACTIVITY%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN
		rcError.PROMISSORY_ID := inuPROMISSORY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPROMISSORY_ID,
				rcData
			);
		end if;

		update LD_PROMISSORY_PU
		set
			ACTIVITY = isbACTIVITY$
		where
			PROMISSORY_ID = inuPROMISSORY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ACTIVITY:= isbACTIVITY$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updMONTHLYINCOME
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuMONTHLYINCOME$ in LD_PROMISSORY_PU.MONTHLYINCOME%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN
		rcError.PROMISSORY_ID := inuPROMISSORY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPROMISSORY_ID,
				rcData
			);
		end if;

		update LD_PROMISSORY_PU
		set
			MONTHLYINCOME = inuMONTHLYINCOME$
		where
			PROMISSORY_ID = inuPROMISSORY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.MONTHLYINCOME:= inuMONTHLYINCOME$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updEXPENSESINCOME
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuEXPENSESINCOME$ in LD_PROMISSORY_PU.EXPENSESINCOME%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN
		rcError.PROMISSORY_ID := inuPROMISSORY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPROMISSORY_ID,
				rcData
			);
		end if;

		update LD_PROMISSORY_PU
		set
			EXPENSESINCOME = inuEXPENSESINCOME$
		where
			PROMISSORY_ID = inuPROMISSORY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.EXPENSESINCOME:= inuEXPENSESINCOME$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCOMMERREFERENCE
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		isbCOMMERREFERENCE$ in LD_PROMISSORY_PU.COMMERREFERENCE%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN
		rcError.PROMISSORY_ID := inuPROMISSORY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPROMISSORY_ID,
				rcData
			);
		end if;

		update LD_PROMISSORY_PU
		set
			COMMERREFERENCE = isbCOMMERREFERENCE$
		where
			PROMISSORY_ID = inuPROMISSORY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.COMMERREFERENCE:= isbCOMMERREFERENCE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPHONECOMMREFE
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		isbPHONECOMMREFE$ in LD_PROMISSORY_PU.PHONECOMMREFE%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN
		rcError.PROMISSORY_ID := inuPROMISSORY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPROMISSORY_ID,
				rcData
			);
		end if;

		update LD_PROMISSORY_PU
		set
			PHONECOMMREFE = isbPHONECOMMREFE$
		where
			PROMISSORY_ID = inuPROMISSORY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PHONECOMMREFE:= isbPHONECOMMREFE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updMOVILPHOCOMMREFE
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		isbMOVILPHOCOMMREFE$ in LD_PROMISSORY_PU.MOVILPHOCOMMREFE%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN
		rcError.PROMISSORY_ID := inuPROMISSORY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPROMISSORY_ID,
				rcData
			);
		end if;

		update LD_PROMISSORY_PU
		set
			MOVILPHOCOMMREFE = isbMOVILPHOCOMMREFE$
		where
			PROMISSORY_ID = inuPROMISSORY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.MOVILPHOCOMMREFE:= isbMOVILPHOCOMMREFE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updADDRESSCOMMREFE
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuADDRESSCOMMREFE$ in LD_PROMISSORY_PU.ADDRESSCOMMREFE%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN
		rcError.PROMISSORY_ID := inuPROMISSORY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPROMISSORY_ID,
				rcData
			);
		end if;

		update LD_PROMISSORY_PU
		set
			ADDRESSCOMMREFE = inuADDRESSCOMMREFE$
		where
			PROMISSORY_ID = inuPROMISSORY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ADDRESSCOMMREFE:= inuADDRESSCOMMREFE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFAMILIARREFERENCE
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		isbFAMILIARREFERENCE$ in LD_PROMISSORY_PU.FAMILIARREFERENCE%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN
		rcError.PROMISSORY_ID := inuPROMISSORY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPROMISSORY_ID,
				rcData
			);
		end if;

		update LD_PROMISSORY_PU
		set
			FAMILIARREFERENCE = isbFAMILIARREFERENCE$
		where
			PROMISSORY_ID = inuPROMISSORY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FAMILIARREFERENCE:= isbFAMILIARREFERENCE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPHONEFAMIREFE
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		isbPHONEFAMIREFE$ in LD_PROMISSORY_PU.PHONEFAMIREFE%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN
		rcError.PROMISSORY_ID := inuPROMISSORY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPROMISSORY_ID,
				rcData
			);
		end if;

		update LD_PROMISSORY_PU
		set
			PHONEFAMIREFE = isbPHONEFAMIREFE$
		where
			PROMISSORY_ID = inuPROMISSORY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PHONEFAMIREFE:= isbPHONEFAMIREFE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updMOVILPHOFAMIREFE
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		isbMOVILPHOFAMIREFE$ in LD_PROMISSORY_PU.MOVILPHOFAMIREFE%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN
		rcError.PROMISSORY_ID := inuPROMISSORY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPROMISSORY_ID,
				rcData
			);
		end if;

		update LD_PROMISSORY_PU
		set
			MOVILPHOFAMIREFE = isbMOVILPHOFAMIREFE$
		where
			PROMISSORY_ID = inuPROMISSORY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.MOVILPHOFAMIREFE:= isbMOVILPHOFAMIREFE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updADDRESSFAMIREFE
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuADDRESSFAMIREFE$ in LD_PROMISSORY_PU.ADDRESSFAMIREFE%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN
		rcError.PROMISSORY_ID := inuPROMISSORY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPROMISSORY_ID,
				rcData
			);
		end if;

		update LD_PROMISSORY_PU
		set
			ADDRESSFAMIREFE = inuADDRESSFAMIREFE$
		where
			PROMISSORY_ID = inuPROMISSORY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ADDRESSFAMIREFE:= inuADDRESSFAMIREFE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPERSONALREFERENCE
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		isbPERSONALREFERENCE$ in LD_PROMISSORY_PU.PERSONALREFERENCE%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN
		rcError.PROMISSORY_ID := inuPROMISSORY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPROMISSORY_ID,
				rcData
			);
		end if;

		update LD_PROMISSORY_PU
		set
			PERSONALREFERENCE = isbPERSONALREFERENCE$
		where
			PROMISSORY_ID = inuPROMISSORY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PERSONALREFERENCE:= isbPERSONALREFERENCE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPHONEPERSREFE
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		isbPHONEPERSREFE$ in LD_PROMISSORY_PU.PHONEPERSREFE%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN
		rcError.PROMISSORY_ID := inuPROMISSORY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPROMISSORY_ID,
				rcData
			);
		end if;

		update LD_PROMISSORY_PU
		set
			PHONEPERSREFE = isbPHONEPERSREFE$
		where
			PROMISSORY_ID = inuPROMISSORY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PHONEPERSREFE:= isbPHONEPERSREFE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updMOVILPHOPERSREFE
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		isbMOVILPHOPERSREFE$ in LD_PROMISSORY_PU.MOVILPHOPERSREFE%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN
		rcError.PROMISSORY_ID := inuPROMISSORY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPROMISSORY_ID,
				rcData
			);
		end if;

		update LD_PROMISSORY_PU
		set
			MOVILPHOPERSREFE = isbMOVILPHOPERSREFE$
		where
			PROMISSORY_ID = inuPROMISSORY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.MOVILPHOPERSREFE:= isbMOVILPHOPERSREFE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updADDRESSPERSREFE
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuADDRESSPERSREFE$ in LD_PROMISSORY_PU.ADDRESSPERSREFE%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN
		rcError.PROMISSORY_ID := inuPROMISSORY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPROMISSORY_ID,
				rcData
			);
		end if;

		update LD_PROMISSORY_PU
		set
			ADDRESSPERSREFE = inuADDRESSPERSREFE$
		where
			PROMISSORY_ID = inuPROMISSORY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ADDRESSPERSREFE:= inuADDRESSPERSREFE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updEMAIL
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		isbEMAIL$ in LD_PROMISSORY_PU.EMAIL%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN
		rcError.PROMISSORY_ID := inuPROMISSORY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPROMISSORY_ID,
				rcData
			);
		end if;

		update LD_PROMISSORY_PU
		set
			EMAIL = isbEMAIL$
		where
			PROMISSORY_ID = inuPROMISSORY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.EMAIL:= isbEMAIL$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPACKAGE_ID
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuPACKAGE_ID$ in LD_PROMISSORY_PU.PACKAGE_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN
		rcError.PROMISSORY_ID := inuPROMISSORY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPROMISSORY_ID,
				rcData
			);
		end if;

		update LD_PROMISSORY_PU
		set
			PACKAGE_ID = inuPACKAGE_ID$
		where
			PROMISSORY_ID = inuPROMISSORY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PACKAGE_ID:= inuPACKAGE_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPROMISSORY_TYPE
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		isbPROMISSORY_TYPE$ in LD_PROMISSORY_PU.PROMISSORY_TYPE%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN
		rcError.PROMISSORY_ID := inuPROMISSORY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPROMISSORY_ID,
				rcData
			);
		end if;

		update LD_PROMISSORY_PU
		set
			PROMISSORY_TYPE = isbPROMISSORY_TYPE$
		where
			PROMISSORY_ID = inuPROMISSORY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PROMISSORY_TYPE:= isbPROMISSORY_TYPE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updLAST_NAME
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		isbLAST_NAME$ in LD_PROMISSORY_PU.LAST_NAME%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN
		rcError.PROMISSORY_ID := inuPROMISSORY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPROMISSORY_ID,
				rcData
			);
		end if;

		update LD_PROMISSORY_PU
		set
			LAST_NAME = isbLAST_NAME$
		where
			PROMISSORY_ID = inuPROMISSORY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.LAST_NAME:= isbLAST_NAME$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSOLIDARITY_DEBTOR
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		isbSOLIDARITY_DEBTOR$ in LD_PROMISSORY_PU.SOLIDARITY_DEBTOR%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN
		rcError.PROMISSORY_ID := inuPROMISSORY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPROMISSORY_ID,
				rcData
			);
		end if;

		update LD_PROMISSORY_PU
		set
			SOLIDARITY_DEBTOR = isbSOLIDARITY_DEBTOR$
		where
			PROMISSORY_ID = inuPROMISSORY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SOLIDARITY_DEBTOR:= isbSOLIDARITY_DEBTOR$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCAUSAL_ID
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuCAUSAL_ID$ in LD_PROMISSORY_PU.CAUSAL_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN
		rcError.PROMISSORY_ID := inuPROMISSORY_ID;
		if inuLock=1 then
			LockByPk
			(
				inuPROMISSORY_ID,
				rcData
			);
		end if;

		update LD_PROMISSORY_PU
		set
			CAUSAL_ID = inuCAUSAL_ID$
		where
			PROMISSORY_ID = inuPROMISSORY_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CAUSAL_ID:= inuCAUSAL_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fsbGetADDRESS_PARSED
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.ADDRESS_PARSED%type
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN

		rcError.PROMISSORY_ID := inuPROMISSORY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPROMISSORY_ID
			 )
		then
			 return(rcData.ADDRESS_PARSED);
		end if;
		Load
		(
		 		inuPROMISSORY_ID
		);
		return(rcData.ADDRESS_PARSED);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetPROMISSORY_ID
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.PROMISSORY_ID%type
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN

		rcError.PROMISSORY_ID := inuPROMISSORY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPROMISSORY_ID
			 )
		then
			 return(rcData.PROMISSORY_ID);
		end if;
		Load
		(
		 		inuPROMISSORY_ID
		);
		return(rcData.PROMISSORY_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetHOLDER_BILL
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.HOLDER_BILL%type
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN

		rcError.PROMISSORY_ID := inuPROMISSORY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPROMISSORY_ID
			 )
		then
			 return(rcData.HOLDER_BILL);
		end if;
		Load
		(
		 		inuPROMISSORY_ID
		);
		return(rcData.HOLDER_BILL);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetDEBTORNAME
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.DEBTORNAME%type
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN

		rcError.PROMISSORY_ID := inuPROMISSORY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPROMISSORY_ID
			 )
		then
			 return(rcData.DEBTORNAME);
		end if;
		Load
		(
		 		inuPROMISSORY_ID
		);
		return(rcData.DEBTORNAME);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetIDENTIFICATION
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.IDENTIFICATION%type
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN

		rcError.PROMISSORY_ID := inuPROMISSORY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPROMISSORY_ID
			 )
		then
			 return(rcData.IDENTIFICATION);
		end if;
		Load
		(
		 		inuPROMISSORY_ID
		);
		return(rcData.IDENTIFICATION);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetIDENT_TYPE_ID
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.IDENT_TYPE_ID%type
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN

		rcError.PROMISSORY_ID := inuPROMISSORY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPROMISSORY_ID
			 )
		then
			 return(rcData.IDENT_TYPE_ID);
		end if;
		Load
		(
		 		inuPROMISSORY_ID
		);
		return(rcData.IDENT_TYPE_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCONTRACT_TYPE_ID
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.CONTRACT_TYPE_ID%type
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN

		rcError.PROMISSORY_ID := inuPROMISSORY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPROMISSORY_ID
			 )
		then
			 return(rcData.CONTRACT_TYPE_ID);
		end if;
		Load
		(
		 		inuPROMISSORY_ID
		);
		return(rcData.CONTRACT_TYPE_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetFORWARDINGPLACE
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.FORWARDINGPLACE%type
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN

		rcError.PROMISSORY_ID := inuPROMISSORY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPROMISSORY_ID
			 )
		then
			 return(rcData.FORWARDINGPLACE);
		end if;
		Load
		(
		 		inuPROMISSORY_ID
		);
		return(rcData.FORWARDINGPLACE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetFORWARDINGDATE
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.FORWARDINGDATE%type
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN

		rcError.PROMISSORY_ID := inuPROMISSORY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPROMISSORY_ID
			 )
		then
			 return(rcData.FORWARDINGDATE);
		end if;
		Load
		(
		 		inuPROMISSORY_ID
		);
		return(rcData.FORWARDINGDATE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetGENDER
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.GENDER%type
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN

		rcError.PROMISSORY_ID := inuPROMISSORY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPROMISSORY_ID
			 )
		then
			 return(rcData.GENDER);
		end if;
		Load
		(
		 		inuPROMISSORY_ID
		);
		return(rcData.GENDER);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCIVIL_STATE_ID
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.CIVIL_STATE_ID%type
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN

		rcError.PROMISSORY_ID := inuPROMISSORY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPROMISSORY_ID
			 )
		then
			 return(rcData.CIVIL_STATE_ID);
		end if;
		Load
		(
		 		inuPROMISSORY_ID
		);
		return(rcData.CIVIL_STATE_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCATEGORY_ID
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.CATEGORY_ID%type
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN

		rcError.PROMISSORY_ID := inuPROMISSORY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPROMISSORY_ID
			 )
		then
			 return(rcData.CATEGORY_ID);
		end if;
		Load
		(
		 		inuPROMISSORY_ID
		);
		return(rcData.CATEGORY_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetSUBCATEGORY_ID
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.SUBCATEGORY_ID%type
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN

		rcError.PROMISSORY_ID := inuPROMISSORY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPROMISSORY_ID
			 )
		then
			 return(rcData.SUBCATEGORY_ID);
		end if;
		Load
		(
		 		inuPROMISSORY_ID
		);
		return(rcData.SUBCATEGORY_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetBIRTHDAYDATE
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.BIRTHDAYDATE%type
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN

		rcError.PROMISSORY_ID := inuPROMISSORY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPROMISSORY_ID
			 )
		then
			 return(rcData.BIRTHDAYDATE);
		end if;
		Load
		(
		 		inuPROMISSORY_ID
		);
		return(rcData.BIRTHDAYDATE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetSCHOOL_DEGREE_
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.SCHOOL_DEGREE_%type
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN

		rcError.PROMISSORY_ID := inuPROMISSORY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPROMISSORY_ID
			 )
		then
			 return(rcData.SCHOOL_DEGREE_);
		end if;
		Load
		(
		 		inuPROMISSORY_ID
		);
		return(rcData.SCHOOL_DEGREE_);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetADDRESS_ID
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.ADDRESS_ID%type
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN

		rcError.PROMISSORY_ID := inuPROMISSORY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPROMISSORY_ID
			 )
		then
			 return(rcData.ADDRESS_ID);
		end if;
		Load
		(
		 		inuPROMISSORY_ID
		);
		return(rcData.ADDRESS_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetPROPERTYPHONE_ID
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.PROPERTYPHONE_ID%type
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN

		rcError.PROMISSORY_ID := inuPROMISSORY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPROMISSORY_ID
			 )
		then
			 return(rcData.PROPERTYPHONE_ID);
		end if;
		Load
		(
		 		inuPROMISSORY_ID
		);
		return(rcData.PROPERTYPHONE_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetDEPENDENTSNUMBER
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.DEPENDENTSNUMBER%type
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN

		rcError.PROMISSORY_ID := inuPROMISSORY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPROMISSORY_ID
			 )
		then
			 return(rcData.DEPENDENTSNUMBER);
		end if;
		Load
		(
		 		inuPROMISSORY_ID
		);
		return(rcData.DEPENDENTSNUMBER);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetHOUSINGTYPE
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.HOUSINGTYPE%type
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN

		rcError.PROMISSORY_ID := inuPROMISSORY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPROMISSORY_ID
			 )
		then
			 return(rcData.HOUSINGTYPE);
		end if;
		Load
		(
		 		inuPROMISSORY_ID
		);
		return(rcData.HOUSINGTYPE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetHOUSINGMONTH
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.HOUSINGMONTH%type
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN

		rcError.PROMISSORY_ID := inuPROMISSORY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPROMISSORY_ID
			 )
		then
			 return(rcData.HOUSINGMONTH);
		end if;
		Load
		(
		 		inuPROMISSORY_ID
		);
		return(rcData.HOUSINGMONTH);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetHOLDERRELATION
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.HOLDERRELATION%type
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN

		rcError.PROMISSORY_ID := inuPROMISSORY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPROMISSORY_ID
			 )
		then
			 return(rcData.HOLDERRELATION);
		end if;
		Load
		(
		 		inuPROMISSORY_ID
		);
		return(rcData.HOLDERRELATION);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetOCCUPATION
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.OCCUPATION%type
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN

		rcError.PROMISSORY_ID := inuPROMISSORY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPROMISSORY_ID
			 )
		then
			 return(rcData.OCCUPATION);
		end if;
		Load
		(
		 		inuPROMISSORY_ID
		);
		return(rcData.OCCUPATION);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetCOMPANYNAME
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.COMPANYNAME%type
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN

		rcError.PROMISSORY_ID := inuPROMISSORY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPROMISSORY_ID
			 )
		then
			 return(rcData.COMPANYNAME);
		end if;
		Load
		(
		 		inuPROMISSORY_ID
		);
		return(rcData.COMPANYNAME);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCOMPANYADDRESS_ID
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.COMPANYADDRESS_ID%type
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN

		rcError.PROMISSORY_ID := inuPROMISSORY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPROMISSORY_ID
			 )
		then
			 return(rcData.COMPANYADDRESS_ID);
		end if;
		Load
		(
		 		inuPROMISSORY_ID
		);
		return(rcData.COMPANYADDRESS_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetPHONE1_ID
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.PHONE1_ID%type
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN

		rcError.PROMISSORY_ID := inuPROMISSORY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPROMISSORY_ID
			 )
		then
			 return(rcData.PHONE1_ID);
		end if;
		Load
		(
		 		inuPROMISSORY_ID
		);
		return(rcData.PHONE1_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetPHONE2_ID
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.PHONE2_ID%type
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN

		rcError.PROMISSORY_ID := inuPROMISSORY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPROMISSORY_ID
			 )
		then
			 return(rcData.PHONE2_ID);
		end if;
		Load
		(
		 		inuPROMISSORY_ID
		);
		return(rcData.PHONE2_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetMOVILPHONE_ID
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.MOVILPHONE_ID%type
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN

		rcError.PROMISSORY_ID := inuPROMISSORY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPROMISSORY_ID
			 )
		then
			 return(rcData.MOVILPHONE_ID);
		end if;
		Load
		(
		 		inuPROMISSORY_ID
		);
		return(rcData.MOVILPHONE_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetOLDLABOR
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.OLDLABOR%type
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN

		rcError.PROMISSORY_ID := inuPROMISSORY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPROMISSORY_ID
			 )
		then
			 return(rcData.OLDLABOR);
		end if;
		Load
		(
		 		inuPROMISSORY_ID
		);
		return(rcData.OLDLABOR);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetACTIVITY
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.ACTIVITY%type
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN

		rcError.PROMISSORY_ID := inuPROMISSORY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPROMISSORY_ID
			 )
		then
			 return(rcData.ACTIVITY);
		end if;
		Load
		(
		 		inuPROMISSORY_ID
		);
		return(rcData.ACTIVITY);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetMONTHLYINCOME
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.MONTHLYINCOME%type
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN

		rcError.PROMISSORY_ID := inuPROMISSORY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPROMISSORY_ID
			 )
		then
			 return(rcData.MONTHLYINCOME);
		end if;
		Load
		(
		 		inuPROMISSORY_ID
		);
		return(rcData.MONTHLYINCOME);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetEXPENSESINCOME
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.EXPENSESINCOME%type
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN

		rcError.PROMISSORY_ID := inuPROMISSORY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPROMISSORY_ID
			 )
		then
			 return(rcData.EXPENSESINCOME);
		end if;
		Load
		(
		 		inuPROMISSORY_ID
		);
		return(rcData.EXPENSESINCOME);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetCOMMERREFERENCE
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.COMMERREFERENCE%type
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN

		rcError.PROMISSORY_ID := inuPROMISSORY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPROMISSORY_ID
			 )
		then
			 return(rcData.COMMERREFERENCE);
		end if;
		Load
		(
		 		inuPROMISSORY_ID
		);
		return(rcData.COMMERREFERENCE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetPHONECOMMREFE
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.PHONECOMMREFE%type
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN

		rcError.PROMISSORY_ID := inuPROMISSORY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPROMISSORY_ID
			 )
		then
			 return(rcData.PHONECOMMREFE);
		end if;
		Load
		(
		 		inuPROMISSORY_ID
		);
		return(rcData.PHONECOMMREFE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetMOVILPHOCOMMREFE
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.MOVILPHOCOMMREFE%type
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN

		rcError.PROMISSORY_ID := inuPROMISSORY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPROMISSORY_ID
			 )
		then
			 return(rcData.MOVILPHOCOMMREFE);
		end if;
		Load
		(
		 		inuPROMISSORY_ID
		);
		return(rcData.MOVILPHOCOMMREFE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetADDRESSCOMMREFE
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.ADDRESSCOMMREFE%type
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN

		rcError.PROMISSORY_ID := inuPROMISSORY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPROMISSORY_ID
			 )
		then
			 return(rcData.ADDRESSCOMMREFE);
		end if;
		Load
		(
		 		inuPROMISSORY_ID
		);
		return(rcData.ADDRESSCOMMREFE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetFAMILIARREFERENCE
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.FAMILIARREFERENCE%type
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN

		rcError.PROMISSORY_ID := inuPROMISSORY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPROMISSORY_ID
			 )
		then
			 return(rcData.FAMILIARREFERENCE);
		end if;
		Load
		(
		 		inuPROMISSORY_ID
		);
		return(rcData.FAMILIARREFERENCE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetPHONEFAMIREFE
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.PHONEFAMIREFE%type
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN

		rcError.PROMISSORY_ID := inuPROMISSORY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPROMISSORY_ID
			 )
		then
			 return(rcData.PHONEFAMIREFE);
		end if;
		Load
		(
		 		inuPROMISSORY_ID
		);
		return(rcData.PHONEFAMIREFE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetMOVILPHOFAMIREFE
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.MOVILPHOFAMIREFE%type
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN

		rcError.PROMISSORY_ID := inuPROMISSORY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPROMISSORY_ID
			 )
		then
			 return(rcData.MOVILPHOFAMIREFE);
		end if;
		Load
		(
		 		inuPROMISSORY_ID
		);
		return(rcData.MOVILPHOFAMIREFE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetADDRESSFAMIREFE
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.ADDRESSFAMIREFE%type
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN

		rcError.PROMISSORY_ID := inuPROMISSORY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPROMISSORY_ID
			 )
		then
			 return(rcData.ADDRESSFAMIREFE);
		end if;
		Load
		(
		 		inuPROMISSORY_ID
		);
		return(rcData.ADDRESSFAMIREFE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetPERSONALREFERENCE
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.PERSONALREFERENCE%type
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN

		rcError.PROMISSORY_ID := inuPROMISSORY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPROMISSORY_ID
			 )
		then
			 return(rcData.PERSONALREFERENCE);
		end if;
		Load
		(
		 		inuPROMISSORY_ID
		);
		return(rcData.PERSONALREFERENCE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetPHONEPERSREFE
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.PHONEPERSREFE%type
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN

		rcError.PROMISSORY_ID := inuPROMISSORY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPROMISSORY_ID
			 )
		then
			 return(rcData.PHONEPERSREFE);
		end if;
		Load
		(
		 		inuPROMISSORY_ID
		);
		return(rcData.PHONEPERSREFE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetMOVILPHOPERSREFE
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.MOVILPHOPERSREFE%type
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN

		rcError.PROMISSORY_ID := inuPROMISSORY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPROMISSORY_ID
			 )
		then
			 return(rcData.MOVILPHOPERSREFE);
		end if;
		Load
		(
		 		inuPROMISSORY_ID
		);
		return(rcData.MOVILPHOPERSREFE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetADDRESSPERSREFE
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.ADDRESSPERSREFE%type
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN

		rcError.PROMISSORY_ID := inuPROMISSORY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPROMISSORY_ID
			 )
		then
			 return(rcData.ADDRESSPERSREFE);
		end if;
		Load
		(
		 		inuPROMISSORY_ID
		);
		return(rcData.ADDRESSPERSREFE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetEMAIL
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.EMAIL%type
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN

		rcError.PROMISSORY_ID := inuPROMISSORY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPROMISSORY_ID
			 )
		then
			 return(rcData.EMAIL);
		end if;
		Load
		(
		 		inuPROMISSORY_ID
		);
		return(rcData.EMAIL);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetPACKAGE_ID
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.PACKAGE_ID%type
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN

		rcError.PROMISSORY_ID := inuPROMISSORY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPROMISSORY_ID
			 )
		then
			 return(rcData.PACKAGE_ID);
		end if;
		Load
		(
		 		inuPROMISSORY_ID
		);
		return(rcData.PACKAGE_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetPROMISSORY_TYPE
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.PROMISSORY_TYPE%type
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN

		rcError.PROMISSORY_ID := inuPROMISSORY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPROMISSORY_ID
			 )
		then
			 return(rcData.PROMISSORY_TYPE);
		end if;
		Load
		(
		 		inuPROMISSORY_ID
		);
		return(rcData.PROMISSORY_TYPE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetLAST_NAME
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.LAST_NAME%type
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN

		rcError.PROMISSORY_ID := inuPROMISSORY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPROMISSORY_ID
			 )
		then
			 return(rcData.LAST_NAME);
		end if;
		Load
		(
		 		inuPROMISSORY_ID
		);
		return(rcData.LAST_NAME);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetSOLIDARITY_DEBTOR
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.SOLIDARITY_DEBTOR%type
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN

		rcError.PROMISSORY_ID := inuPROMISSORY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPROMISSORY_ID
			 )
		then
			 return(rcData.SOLIDARITY_DEBTOR);
		end if;
		Load
		(
		 		inuPROMISSORY_ID
		);
		return(rcData.SOLIDARITY_DEBTOR);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCAUSAL_ID
	(
		inuPROMISSORY_ID in LD_PROMISSORY_PU.PROMISSORY_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_PROMISSORY_PU.CAUSAL_ID%type
	IS
		rcError styLD_PROMISSORY_PU;
	BEGIN

		rcError.PROMISSORY_ID := inuPROMISSORY_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuPROMISSORY_ID
			 )
		then
			 return(rcData.CAUSAL_ID);
		end if;
		Load
		(
		 		inuPROMISSORY_ID
		);
		return(rcData.CAUSAL_ID);
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
end DALD_PROMISSORY_PU;
/
PROMPT Otorgando permisos de ejecucion a DALD_PROMISSORY_PU
BEGIN
    pkg_utilidades.praplicarpermisos('DALD_PROMISSORY_PU', 'ADM_PERSON');
END;
/
