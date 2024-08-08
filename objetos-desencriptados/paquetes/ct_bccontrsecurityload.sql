
CREATE OR REPLACE PACKAGE CT_BCCONTRSECURITYLOAD IS
   FUNCTION FSBVERSION
    RETURN VARCHAR2;
   PROCEDURE DELETETEMPORARYMODEL;
   PROCEDURE LOADADMCONTRACTS( INUUSERID IN SA_USER.USER_ID%TYPE );
   PROCEDURE LOADADMCONTRACTORS( INUUSERID IN SA_USER.USER_ID%TYPE );
   PROCEDURE LOADADMWORKUNITS( INUUSERID IN SA_USER.USER_ID%TYPE );
   PROCEDURE LOADADMCOSTSLISTS( INUUSERID IN SA_USER.USER_ID%TYPE );
   PROCEDURE LOADAUXCONTRACTS( INUUSERID IN SA_USER.USER_ID%TYPE );
   PROCEDURE LOADAUXCONTRACTORS( INUUSERID IN SA_USER.USER_ID%TYPE );
   PROCEDURE LOADAUXWORKUNITS( INUUSERID IN SA_USER.USER_ID%TYPE );
   PROCEDURE LOADAUXCOSTSLISTS( INUUSERID IN SA_USER.USER_ID%TYPE );
END CT_BCCONTRSECURITYLOAD;
/


CREATE OR REPLACE PACKAGE BODY CT_BCCONTRSECURITYLOAD IS
   CSBVERSION CONSTANT VARCHAR2( 20 ) := 'SAO188073';
   CURSOR CUADMCONTRACTS( INUUSERID IN SA_USER.USER_ID%TYPE ) IS
SELECT /*+
               index(sa_user_contractor_sec IDX_SA_USER_CONTRACTOR_SEC06)
               index(ge_contrato idx_ge_contrato_01)
               leading(sa_user_contractor_sec)
               use_nl(sa_user_contractor_sec ge_contrato)
               */
               ge_contrato.id_contrato
             , sa_user_contractor_sec.contractor_id
          FROM sa_user_contractor_sec,
               ge_contrato
               /*+ ubicacion: CT_BCContrSecurityLoad.cuAdmContracts */
         WHERE sa_user_contractor_sec.user_id = inuUserId
           AND sa_user_contractor_sec.sec_type = ct_boconstants.csbCONTR_ADMIN_ROLE
           AND ge_contrato.id_contratista = sa_user_contractor_sec.contractor_id
    ;
   CURSOR CUADMCONTRACTORS( INUUSERID IN SA_USER.USER_ID%TYPE ) IS
SELECT /*+
               index (sa_user_contractor_sec IDX_SA_USER_CONTRACTOR_SEC06)
               */
               sa_user_contractor_sec.contractor_id
          FROM sa_user_contractor_sec
               /*+ ubicacion: CT_BCContrSecurityLoad.cuAdmContractors */
         WHERE sa_user_contractor_sec.user_id = inuUserId
           AND sa_user_contractor_sec.sec_type = ct_boconstants.csbCONTR_ADMIN_ROLE
    ;
   CURSOR CUADMWORKUNITS( INUUSERID IN SA_USER.USER_ID%TYPE ) IS
SELECT /*+
               index (sa_user_contractor_sec IDX_SA_USER_CONTRACTOR_SEC06)
               index (or_operating_unit idx_or_operating_unit10)
               leading(sa_user_contractor_sec)
               use_nl(sa_user_contractor_sec or_operating_unit)
               */
               or_operating_unit.operating_unit_id
             , sa_user_contractor_sec.contractor_id
          FROM sa_user_contractor_sec
             , or_operating_unit
               /*+ ubicacion: CT_BCContrSecurityLoad.cuAdmWorkUnits */
         WHERE sa_user_contractor_sec.user_id = inuUserId
           AND sa_user_contractor_sec.sec_type = ct_boconstants.csbCONTR_ADMIN_ROLE
           AND or_operating_unit.contractor_id = sa_user_contractor_sec.contractor_id
    ;
   CURSOR CUADMCOSTLISTS( INUUSERID IN SA_USER.USER_ID%TYPE ) IS
SELECT /*+
               index(sa_user_contractor_sec idx_sa_user_contractor_sec06)
               index(or_operating_unit idx_or_operating_unit10)
               index (ge_list_unitary_cost idx_ge_list_unitary_cost05)
               leading(sa_user_contractor_sec)
               use_nl (sa_user_contractor_sec or_operating_unit)
               use_nl (or_operating_unit ge_list_unitary_cost)
              */
              ge_list_unitary_cost.list_unitary_cost_id
         FROM sa_user_contractor_sec
            , or_operating_unit
            , ge_list_unitary_cost
              /*+ ubicacion: CT_BCContrSecurityLoad.cuAdmCostLists */
        WHERE sa_user_contractor_sec.user_id  = inuUserId
          AND sa_user_contractor_sec.sec_type = ct_boconstants.csbCONTR_ADMIN_ROLE
          AND or_operating_unit.contractor_id = sa_user_contractor_sec.contractor_id
          AND ge_list_unitary_cost.operating_unit_id = or_operating_unit.operating_unit_id
        UNION
         --2) Contrato: LC de los Contratos de los contratistas asociados
       SELECT /*+
               index(sa_user_contractor_sec idx_sa_user_contractor_sec06)
               index(ge_contrato idx_ge_contrato_01)
               index(ge_list_unitary_cost idx_ge_list_unitary_cost02)
               leading(sa_user_contractor_sec)
               use_nl(sa_user_contractor_sec ge_contrato)
               use_nl(ge_contrato ge_list_unitary_cost)
              */
              ge_list_unitary_cost.list_unitary_cost_id
         FROM sa_user_contractor_sec
            , ge_contrato
            , ge_list_unitary_cost
        WHERE sa_user_contractor_sec.user_id  = inuUserId
          AND sa_user_contractor_sec.sec_type = ct_boconstants.csbCONTR_ADMIN_ROLE
          AND ge_contrato.id_contratista = sa_user_contractor_sec.contractor_id
          AND ge_list_unitary_cost.contract_id= ge_contrato.id_contrato
        UNION
         --3) Contratista: LC de los contratistas due?os de los contratos asociados
       SELECT /*+
               index(sa_user_contractor_sec idx_sa_user_contractor_sec06)
               index(ge_list_unitary_cost idx_ge_list_unitary_cost04)
               leading(sa_user_contractor_sec)
               use_nl(sa_user_contractor_sec ge_list_unitary_cost)
              */
              ge_list_unitary_cost.list_unitary_cost_id
         FROM sa_user_contractor_sec
            , ge_list_unitary_cost
        WHERE sa_user_contractor_sec.user_id  = inuUserId
          AND sa_user_contractor_sec.sec_type = ct_boconstants.csbCONTR_ADMIN_ROLE
          AND ge_list_unitary_cost.contractor_id =  sa_user_contractor_sec.contractor_id
        UNION
         --4) Genericas: Ubicacion Geografica + Genericas: Todas la LC
       SELECT /*
               index (ge_list_unitary_cost idx_ge_list_unitary_cost05)
              */
              ge_list_unitary_cost.list_unitary_cost_id
         FROM ge_list_unitary_cost
        WHERE ge_list_unitary_cost.operating_unit_id iS null
          AND ge_list_unitary_cost.contractor_id is null
          AND ge_list_unitary_cost.contract_id is null
    ;
   CURSOR CUAUXCONTRACTS( INUUSERID IN SA_USER.USER_ID%TYPE ) IS
SELECT /*+
                index (sa_user_contractor_sec IDX_SA_USER_CONTRACTOR_SEC05)
                index (ge_contrato pk_ge_contrato)
                leading(sa_user_contractor_sec)
                use_nl (sa_user_contractor_sec ge_contrato)
               */
               sa_user_contractor_sec.contract_id
             , ge_contrato.id_contratista
          FROM sa_user_contractor_sec,
               ge_contrato
               /*+ ubicacion: CT_BCContrSecurityLoad.cuAuxContracts */
         WHERE sa_user_contractor_sec.user_id = inuUserId
           AND sa_user_contractor_sec.sec_type = ct_boconstants.csbCONTR_AUX_ROLE
           AND ge_contrato.id_contrato = sa_user_contractor_sec.contract_id
    ;
   CURSOR CUAUXCONTRACTORS( INUUSERID IN SA_USER.USER_ID%TYPE ) IS
SELECT /*+
                index (sa_user_contractor_sec IDX_SA_USER_CONTRACTOR_SEC05)
                index (ge_contrato pk_ge_contrato)
                leading(sa_user_contractor_sec)
                use_nl(sa_user_contractor_sec ge_contrato)
               */
               sa_user_contractor_sec.contract_id
             , ge_contrato.id_contratista
          FROM sa_user_contractor_sec,
               ge_contrato
               /*+ ubicacion: CT_BCContrSecurityLoad.cuAuxContractors */
         WHERE sa_user_contractor_sec.user_id = inuUserId
           AND sa_user_contractor_sec.sec_type = ct_boconstants.csbCONTR_AUX_ROLE
           AND ge_contrato.id_contrato = sa_user_contractor_sec.contract_id
    ;
   CURSOR CUAUXWORKUNITS( INUUSERID IN SA_USER.USER_ID%TYPE ) IS
SELECT /*+
               index  (sa_user_contractor_sec IDX_SA_USER_CONTRACTOR_SEC05)
               index  (ge_contrato pk_ge_contrato)
               index  (or_operating_unit idx_or_operating_unit10)
               leading(sa_user_contractor_sec)
               use_nl (sa_user_contractor_sec ge_contrato)
               use_nl (ge_contrato or_operating_unit)
               */
               or_operating_unit.operating_unit_id
             , ge_contrato.id_contratista
          FROM sa_user_contractor_sec
             , ge_contrato
             , or_operating_unit
               /*+ ubicacion: CT_BCContrSecurityLoad.cuAuxWorkUnits */
         WHERE sa_user_contractor_sec.user_id = inuUserId
           AND sa_user_contractor_sec.sec_type = ct_boconstants.csbCONTR_AUX_ROLE
           AND ge_contrato.id_contrato  = sa_user_contractor_sec.contract_id
           AND or_operating_unit.contractor_id = ge_contrato.id_contratista
    ;
   CURSOR CUAUXCOSTLISTS( INUUSERID IN SA_USER.USER_ID%TYPE ) IS
SELECT /*+
                index  (sa_user_contractor_sec IDX_SA_USER_CONTRACTOR_SEC05)
                index  (ge_contrato pk_ge_contrato)
                index  (or_operating_unit idx_or_operating_unit10)
                index  (ge_list_unitary_cost idx_ge_list_unitary_cost04)
                leading(sa_user_contractor_sec)
                use_nl (sa_user_contractor_sec ge_contrato)
                use_nl (ge_contrato or_operating_unit)
                use_nl (or_operating_unit ge_list_unitary_cost)
               */
               ge_list_unitary_cost.list_unitary_cost_id
          FROM sa_user_contractor_sec
             , ge_contrato
             , or_operating_unit
             , ge_list_unitary_cost
               /*+ ubicacion: CT_BCContrSecurityLoad.cuAuxCostLists */
         WHERE sa_user_contractor_sec.user_id  = inuUserId
           AND sa_user_contractor_sec.sec_type = ct_boconstants.csbCONTR_AUX_ROLE
           AND ge_contrato.id_contrato = sa_user_contractor_sec.contract_id
           AND or_operating_unit.contractor_id = ge_contrato.id_contratista
           AND ge_list_unitary_cost.operating_unit_id = or_operating_unit.operating_unit_id
         UNION
          --2) Contrato: LC de los Contratos asociados
        SELECT /*+
                index  (sa_user_contractor_sec IDX_SA_USER_CONTRACTOR_SEC05)
                index  (ge_list_unitary_cost idx_ge_list_unitary_cost02)
                leading(sa_user_contractor_sec)
                use_nl (sa_user_contractor_sec ge_list_unitary_cost)
               */
               ge_list_unitary_cost.list_unitary_cost_id
          FROM sa_user_contractor_sec
             , ge_list_unitary_cost
         WHERE sa_user_contractor_sec.user_id  = inuUserId
           AND sa_user_contractor_sec.sec_type = ct_boconstants.csbCONTR_AUX_ROLE
           AND ge_list_unitary_cost.contract_id= sa_user_contractor_sec.contract_id
         UNION
          --3) Contratista: LC de los contratistas due?os de los contratos asociados
        SELECT /*+
                index  (sa_user_contractor_sec idx_sa_user_contractor_sec05)
                index  (ge_contrato pk_ge_contrato)
                index  (ge_list_unitary_cost idx_ge_list_unitary_cost04)
                leading(sa_user_contractor_sec)
                use_nl (sa_user_contractor_sec ge_contrato)
                use_nl (ge_contrato ge_list_unitary_cost)
               */
               ge_list_unitary_cost.list_unitary_cost_id
          FROM sa_user_contractor_sec
             , ge_contrato
             , ge_list_unitary_cost
         WHERE sa_user_contractor_sec.user_id  = inuUserId
           AND sa_user_contractor_sec.sec_type = ct_boconstants.csbCONTR_AUX_ROLE
           AND ge_contrato.id_contrato = sa_user_contractor_sec.contract_id
           AND ge_list_unitary_cost.contractor_id = ge_contrato.id_contratista
         UNION
          --4) Genericas: Ubicacion Geografica + Genericas: Todas la LC
        SELECT /*
                index (ge_list_unitary_cost idx_ge_list_unitary_cost01)
               */
               ge_list_unitary_cost.list_unitary_cost_id
          FROM ge_list_unitary_cost
         WHERE ge_list_unitary_cost.operating_unit_id iS null
           AND ge_list_unitary_cost.contract_id is null
           AND ge_list_unitary_cost.contractor_id is null
    ;
   FUNCTION FSBVERSION
    RETURN VARCHAR2
    IS
    BEGIN
      RETURN CSBVERSION;
   END;
   PROCEDURE DELETETEMPORARYMODEL
    IS
    BEGIN
      CT_BCCONTRSECURITY.TBCONTRACTORS.DELETE;
      CT_BCCONTRSECURITY.TBCONTRACTS.DELETE;
      CT_BCCONTRSECURITY.TBCOSTLIST.DELETE;
      CT_BCCONTRSECURITY.TBWORKUNITS.DELETE;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END DELETETEMPORARYMODEL;
   PROCEDURE LOADADMCONTRACTS( INUUSERID IN SA_USER.USER_ID%TYPE )
    IS
    BEGIN
      UT_TRACE.TRACE( '[INICIO] CT_BCContrSecurityLoad.LoadAdmContracts', 15 );
      FOR REG IN CUADMCONTRACTS( INUUSERID )
       LOOP
         CT_BCCONTRSECURITY.TBCONTRACTS( REG.ID_CONTRATO ) := REG.CONTRACTOR_ID;
      END LOOP;
      UT_TRACE.TRACE( '[FINAL] CT_BCContrSecurityLoad.LoadAdmContracts', 15 );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END LOADADMCONTRACTS;
   PROCEDURE LOADADMCONTRACTORS( INUUSERID IN SA_USER.USER_ID%TYPE )
    IS
    BEGIN
      UT_TRACE.TRACE( '[INICIO] CT_BCContrSecurityLoad.LoadAdmContractors', 15 );
      FOR REG IN CUADMCONTRACTORS( INUUSERID )
       LOOP
         CT_BCCONTRSECURITY.TBCONTRACTORS( REG.CONTRACTOR_ID ) := REG.CONTRACTOR_ID;
      END LOOP;
      UT_TRACE.TRACE( '[FINAL] CT_BCContrSecurityLoad.LoadAdmContractors', 15 );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END LOADADMCONTRACTORS;
   PROCEDURE LOADADMWORKUNITS( INUUSERID IN SA_USER.USER_ID%TYPE )
    IS
    BEGIN
      UT_TRACE.TRACE( '[INICIO] CT_BCContrSecurityLoad.LoadAdmWorkUnits', 15 );
      FOR REG IN CUADMWORKUNITS( INUUSERID )
       LOOP
         CT_BCCONTRSECURITY.TBWORKUNITS( REG.OPERATING_UNIT_ID ) := REG.CONTRACTOR_ID;
      END LOOP;
      UT_TRACE.TRACE( '[FINAL] CT_BCContrSecurityLoad.LoadAdmWorkUnits', 15 );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END LOADADMWORKUNITS;
   PROCEDURE LOADADMCOSTSLISTS( INUUSERID IN SA_USER.USER_ID%TYPE )
    IS
    BEGIN
      UT_TRACE.TRACE( '[INICIO] CT_BCContrSecurityLoad.LoadAdmCostsLists', 15 );
      FOR REG IN CUADMCOSTLISTS( INUUSERID )
       LOOP
         CT_BCCONTRSECURITY.TBCOSTLIST( REG.LIST_UNITARY_COST_ID ) := NULL;
      END LOOP;
      UT_TRACE.TRACE( '[FINAL]  CT_BCContrSecurityLoad.LoadAdmCostsLists', 15 );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END LOADADMCOSTSLISTS;
   PROCEDURE LOADAUXCONTRACTS( INUUSERID IN SA_USER.USER_ID%TYPE )
    IS
    BEGIN
      UT_TRACE.TRACE( '[INICIO] CT_BCContrSecurityLoad.LoadAuxContracts', 15 );
      FOR REG IN CUAUXCONTRACTS( INUUSERID )
       LOOP
         CT_BCCONTRSECURITY.TBCONTRACTS( REG.CONTRACT_ID ) := REG.ID_CONTRATISTA;
      END LOOP;
      UT_TRACE.TRACE( '[FINAL]  CT_BCContrSecurityLoad.LoadAuxContracts', 15 );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END LOADAUXCONTRACTS;
   PROCEDURE LOADAUXCONTRACTORS( INUUSERID IN SA_USER.USER_ID%TYPE )
    IS
    BEGIN
      UT_TRACE.TRACE( '[INICIO] CT_BCContrSecurityLoad.LoadAuxContractors', 15 );
      FOR REG IN CUAUXCONTRACTORS( INUUSERID )
       LOOP
         CT_BCCONTRSECURITY.TBCONTRACTORS( REG.ID_CONTRATISTA ) := REG.CONTRACT_ID;
      END LOOP;
      UT_TRACE.TRACE( '[FINAL]  CT_BCContrSecurityLoad.LoadAuxContractors', 15 );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END LOADAUXCONTRACTORS;
   PROCEDURE LOADAUXWORKUNITS( INUUSERID IN SA_USER.USER_ID%TYPE )
    IS
    BEGIN
      UT_TRACE.TRACE( '[INICIO] CT_BCContrSecurityLoad.LoadAuxWorkUnits', 15 );
      FOR REG IN CUAUXWORKUNITS( INUUSERID )
       LOOP
         CT_BCCONTRSECURITY.TBWORKUNITS( REG.OPERATING_UNIT_ID ) := REG.ID_CONTRATISTA;
      END LOOP;
      UT_TRACE.TRACE( '[FINAL]  CT_BCContrSecurityLoad.LoadAuxWorkUnits', 15 );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END LOADAUXWORKUNITS;
   PROCEDURE LOADAUXCOSTSLISTS( INUUSERID IN SA_USER.USER_ID%TYPE )
    IS
    BEGIN
      UT_TRACE.TRACE( '[INICIO] CT_BCContrSecurityLoad.LoadAuxCostsLists', 15 );
      FOR REG IN CUAUXCOSTLISTS( INUUSERID )
       LOOP
         CT_BCCONTRSECURITY.TBCOSTLIST( REG.LIST_UNITARY_COST_ID ) := NULL;
      END LOOP;
      UT_TRACE.TRACE( '[FINAL]  CT_BCContrSecurityLoad.LoadAuxCostsLists', 15 );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END LOADAUXCOSTSLISTS;
END CT_BCCONTRSECURITYLOAD;
/


