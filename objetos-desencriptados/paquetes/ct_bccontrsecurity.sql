PACKAGE CT_BCContrSecurity
IS




























    TYPE TYTBID_CONTRATO  IS TABLE OF GE_CONTRATO.ID_CONTRATO%TYPE INDEX BY VARCHAR2(17);
    TYPE TYTBID_CONTRATOR IS TABLE OF GE_CONTRATISTA.ID_CONTRATISTA%TYPE INDEX BY VARCHAR2(17);
    TYPE TYTBID_WORKUNIT  IS TABLE OF OR_OPERATING_UNIT.OPERATING_UNIT_ID%TYPE INDEX BY VARCHAR2(17);

    
    
    

    
    
    
    
    TBCONTRACTORS   TYTBID_CONTRATOR;

    
    TBCONTRACTS     TYTBID_CONTRATO;
    
    
    TBCOSTLIST      DAGE_LIST_UNITARY_COST.TYTBLIST_UNITARY_COST_ID;
    
    
    TBWORKUNITS     TYTBID_WORKUNIT;
    

    
    
    
    
    FUNCTION FSBVERSION  RETURN VARCHAR2;

    






    FUNCTION FBLUSRHASANYCONTRACT
    (
        INUUSERID      IN    SA_USER.USER_ID%TYPE
    )RETURN BOOLEAN;

    






    FUNCTION FBLUSRHASANYCONTRACTOR
    (
        INUUSERID      IN    SA_USER.USER_ID%TYPE
    )RETURN BOOLEAN;
    
    
    






    FUNCTION FBLUSERHASCONTRACT
    (
        INUCONTRACTID  IN  GE_CONTRATO.ID_CONTRATO%TYPE
    )RETURN BOOLEAN;
    
    






    FUNCTION FBLUSERHASCONTRACTOR
    (
        INUCONTRACTORID  IN  GE_CONTRATISTA.ID_CONTRATISTA%TYPE
    )RETURN BOOLEAN;
    
    






    FUNCTION FBLUSERHASWORKUNIT
    (
        INUOPERATINGUNITID  IN    OR_OPERATING_UNIT.OPERATING_UNIT_ID%TYPE
    )RETURN BOOLEAN;
    
    
    






    FUNCTION FBLUSERHASCOSTLIST
    (
        INUCOSTLISTID  GE_LIST_UNITARY_COST.LIST_UNITARY_COST_ID%TYPE
        
    )RETURN BOOLEAN;

    





    FUNCTION FRFGETADMSBYCONTRACTOR
    (
      INUCONTRACTORID IN  GE_CONTRATISTA.ID_CONTRATISTA%TYPE
      
    )RETURN CONSTANTS.TYREFCURSOR;
    
    





    FUNCTION FRFGETAUXSBYCONTRACT
    (
      INUCONTRACTID IN  GE_CONTRATO.ID_CONTRATO%TYPE

    )RETURN CONSTANTS.TYREFCURSOR;
    
    
    






    PROCEDURE INSCONTRSECSETTINGS
    (
      INUUSERID       IN SA_USER_CONTRACTOR_SEC.USER_ID%TYPE,
      INUCONTRACTORID IN SA_USER_CONTRACTOR_SEC.CONTRACTOR_ID%TYPE,
      INUCONTRACTID   IN SA_USER_CONTRACTOR_SEC.CONTRACT_ID%TYPE,
      ISBSECURITYTYPE IN SA_USER_CONTRACTOR_SEC.SEC_TYPE%TYPE
    );
    
    






    PROCEDURE DELCONTRSECSETTINGS
    (
      INUUSERID       IN SA_USER_CONTRACTOR_SEC.USER_ID%TYPE,
      INUCONTRACTORID IN SA_USER_CONTRACTOR_SEC.CONTRACTOR_ID%TYPE,
      INUCONTRACTID   IN SA_USER_CONTRACTOR_SEC.CONTRACT_ID%TYPE,
      ISBSECURITYTYPE IN SA_USER_CONTRACTOR_SEC.SEC_TYPE%TYPE
    );
    
     




    PROCEDURE GETADMINS
    (
        INUCONTRACTORID     IN      GE_CONTRATISTA.ID_CONTRATISTA%TYPE,
        OTBPERSONS          OUT NOCOPY DAGE_PERSON.TYTBGE_PERSON
    );

    




    PROCEDURE GETAUX
    (
        INUCONTRACTID       IN      GE_CONTRATO.ID_CONTRATO%TYPE,
        OTBPERSONS          OUT NOCOPY DAGE_PERSON.TYTBGE_PERSON
    );

END CT_BCCONTRSECURITY;

PACKAGE BODY CT_BCContrSecurity
IS




























    
    
    

    CSBVERSION CONSTANT VARCHAR2(20) := 'SAO197977';
    
    
    
    
    
    
    
    
    

    
    
    

	FUNCTION FSBVERSION  RETURN VARCHAR2 IS
    BEGIN
        RETURN CSBVERSION;
    END;

    





















    FUNCTION FBLUSRHASANYCONTRACT
    (
        INUUSERID      IN    SA_USER.USER_ID%TYPE
    )
    RETURN BOOLEAN IS
        CUDATA  CONSTANTS.TYREFCURSOR;
        SBVALUE VARCHAR2(1);
    BEGIN
         IF(CUDATA %ISOPEN)THEN
            CLOSE CUDATA;
         END IF;
        
          OPEN CUDATA
           FOR
        SELECT /*+ index(sa_user_contractor_sec idx_sa_user_contractor_sec01) */
               'X'
          FROM SA_USER_CONTRACTOR_SEC
         WHERE SA_USER_CONTRACTOR_SEC.USER_ID = INUUSERID
           AND SA_USER_CONTRACTOR_SEC.SEC_TYPE = CT_BOCONSTANTS.CSBCONTR_AUX_ROLE
           AND ROWNUM = 1;

        
        FETCH CUDATA INTO SBVALUE;
        CLOSE CUDATA;

        IF SBVALUE IS NOT NULL THEN
           RETURN  TRUE;
        ELSE
           RETURN FALSE;
        END IF;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            IF(CUDATA %ISOPEN)THEN
                CLOSE CUDATA;
            END IF;
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            IF(CUDATA %ISOPEN)THEN
                CLOSE CUDATA;
            END IF;
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FBLUSRHASANYCONTRACT;

    




















    FUNCTION FBLUSRHASANYCONTRACTOR
    (
        INUUSERID      IN    SA_USER.USER_ID%TYPE
    )
    RETURN BOOLEAN IS
        CUDATA  CONSTANTS.TYREFCURSOR;
        SBVALUE VARCHAR2(1);
    BEGIN
    
          IF(CUDATA %ISOPEN)THEN
                CLOSE CUDATA;
          END IF;
            
        
          OPEN CUDATA
           FOR
        SELECT /*+ index(sa_user_contractor_sec idx_sa_user_contractor_sec01) */
               'X'
          FROM SA_USER_CONTRACTOR_SEC
         WHERE SA_USER_CONTRACTOR_SEC.USER_ID = INUUSERID
           AND SA_USER_CONTRACTOR_SEC.SEC_TYPE = CT_BOCONSTANTS.CSBCONTR_ADMIN_ROLE
           AND ROWNUM = 1;

        
        FETCH CUDATA INTO SBVALUE;
        CLOSE  CUDATA;

        IF SBVALUE IS NOT NULL THEN
           RETURN  TRUE;
        ELSE
           RETURN FALSE;
        END IF;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
             IF(CUDATA %ISOPEN)THEN
                CLOSE CUDATA;
            END IF;
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            IF(CUDATA %ISOPEN)THEN
                CLOSE CUDATA;
            END IF;
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FBLUSRHASANYCONTRACTOR;
    
    



















    FUNCTION FBLUSERHASCONTRACT
    (
      INUCONTRACTID  IN  GE_CONTRATO.ID_CONTRATO%TYPE
    )
    RETURN BOOLEAN
    IS
    BEGIN

         
          RETURN TBCONTRACTS.EXISTS(INUCONTRACTID);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FBLUSERHASCONTRACT;
    
    



















    FUNCTION FBLUSERHASCONTRACTOR
    (
        INUCONTRACTORID  IN  GE_CONTRATISTA.ID_CONTRATISTA%TYPE
    )
    RETURN BOOLEAN
    IS
    BEGIN
          
          RETURN TBCONTRACTORS.EXISTS(INUCONTRACTORID);
       
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FBLUSERHASCONTRACTOR;
    
    



















    FUNCTION FBLUSERHASWORKUNIT
    (
        INUOPERATINGUNITID  IN    OR_OPERATING_UNIT.OPERATING_UNIT_ID%TYPE
    )
    RETURN BOOLEAN IS
    BEGIN
    
       
       RETURN TBWORKUNITS.EXISTS(INUOPERATINGUNITID);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FBLUSERHASWORKUNIT;
    
    



















    FUNCTION FBLUSERHASCOSTLIST
    (
        INUCOSTLISTID  GE_LIST_UNITARY_COST.LIST_UNITARY_COST_ID%TYPE
    )
    RETURN BOOLEAN IS
    BEGIN

       
       RETURN TBCOSTLIST.EXISTS(INUCOSTLISTID);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FBLUSERHASCOSTLIST;

   



















    FUNCTION FRFGETADMSBYCONTRACTOR
    (
      INUCONTRACTORID IN  GE_CONTRATISTA.ID_CONTRATISTA%TYPE

    )RETURN CONSTANTS.TYREFCURSOR
    IS
            CUADMINUSER  CONSTANTS.TYREFCURSOR;
    BEGIN
          IF (CUADMINUSER %ISOPEN)THEN
                CLOSE  CUADMINUSER;
          END IF;
          OPEN CUADMINUSER
           FOR
        SELECT /*+
               index(sa_user_contractor_sec idx_sa_user_contractor_sec06)
               index(sa_user pk_sa_user)
               index(ge_person idx_ge_person_01)
               leading(sa_user_contractor_sec)
               use_nl(sa_user_contractor_sec sa_user)
               use_nl(sa_user sa_user_roles)
               use_nl(sa_user ge_person)
               */
               SA_USER.USER_ID,
               GE_PERSON.NAME_
          FROM SA_USER_CONTRACTOR_SEC
             , SA_USER
             , GE_PERSON
         WHERE SA_USER_CONTRACTOR_SEC.CONTRACTOR_ID = INUCONTRACTORID
           AND SA_USER_CONTRACTOR_SEC.SEC_TYPE = CT_BOCONSTANTS.CSBCONTR_ADMIN_ROLE
           AND SA_USER.USER_ID = SA_USER_CONTRACTOR_SEC.USER_ID
           AND EXISTS(
               SELECT /*+
                      index(sa_user_roles idx_sa_user_roles01)
                      index(sa_role idx_sa_role_01)
                      use_nl(sa_user_roles sa_role)
                      */
                      'x'
                 FROM SA_USER_ROLES,
                      SA_ROLE
                WHERE SA_USER_ROLES.USER_ID = SA_USER.USER_ID
                  AND SA_ROLE.ROLE_TYPE_ID = CT_BOCONSTANTS.CNUCONTRACTOR_ADM_ROLE_TY
                  AND SA_ROLE.ROLE_ID = SA_USER_ROLES.ROLE_ID
                  )
           AND GE_PERSON.USER_ID = SA_USER.USER_ID;

         RETURN CUADMINUSER;

        EXCEPTION
            WHEN EX.CONTROLLED_ERROR THEN
                IF (CUADMINUSER %ISOPEN)THEN
                   CLOSE  CUADMINUSER;
                END IF;
                RAISE EX.CONTROLLED_ERROR;
            WHEN OTHERS THEN
                 IF (CUADMINUSER %ISOPEN)THEN
                   CLOSE  CUADMINUSER;
                END IF;
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;
    END FRFGETADMSBYCONTRACTOR;


    



















    FUNCTION FRFGETAUXSBYCONTRACT
    (
      INUCONTRACTID IN  GE_CONTRATO.ID_CONTRATO%TYPE

    )RETURN CONSTANTS.TYREFCURSOR
    IS
      CUAUXUSER  CONSTANTS.TYREFCURSOR;
    BEGIN
           IF (CUAUXUSER %ISOPEN)THEN
              CLOSE  CUAUXUSER;
           END IF;
           OPEN CUAUXUSER
            FOR
         SELECT /*+
                index(sa_user_contractor_sec idx_sa_user_contractor_sec05)
                index(sa_user pk_sa_user)
                index(ge_person idx_ge_person_01)
                leading(sa_user_contractor_sec)
                use_nl(sa_user_contractor_sec sa_user)
                use_nl(sa_user sa_user_roles)
                use_nl(sa_user ge_person)
                */
                SA_USER.USER_ID
              , GE_PERSON.NAME_
           FROM SA_USER_CONTRACTOR_SEC
              , SA_USER
              , GE_PERSON
          WHERE SA_USER_CONTRACTOR_SEC.CONTRACT_ID =INUCONTRACTID
            AND SA_USER_CONTRACTOR_SEC.SEC_TYPE = CT_BOCONSTANTS.CSBCONTR_AUX_ROLE
            AND SA_USER.USER_ID = SA_USER_CONTRACTOR_SEC.USER_ID
            AND EXISTS(
                SELECT /*+
                       index(sa_user_roles idx_sa_user_roles01)
                       index(sa_role idx_sa_role_01)
                       use_nl(sa_user_roles sa_role)
                       */
                       'x'
                  FROM SA_USER_ROLES,
                       SA_ROLE
                 WHERE SA_USER_ROLES.USER_ID = SA_USER.USER_ID
                   AND SA_ROLE.ROLE_TYPE_ID = CT_BOCONSTANTS.CNUCONTRACTOR_ADM_ROLE_TY
                   AND SA_ROLE.ROLE_ID = SA_USER_ROLES.ROLE_ID
                   )
           AND GE_PERSON.USER_ID = SA_USER.USER_ID;

        RETURN CUAUXUSER;

        EXCEPTION
            WHEN EX.CONTROLLED_ERROR THEN
                IF (CUAUXUSER %ISOPEN)THEN
                   CLOSE  CUAUXUSER;
                END IF;
                RAISE EX.CONTROLLED_ERROR;
            WHEN OTHERS THEN
                 IF (CUAUXUSER %ISOPEN)THEN
                   CLOSE  CUAUXUSER;
                END IF;
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;
    END  FRFGETAUXSBYCONTRACT;

    





















    PROCEDURE INSCONTRSECSETTINGS
    (
      INUUSERID       IN SA_USER_CONTRACTOR_SEC.USER_ID%TYPE,
      INUCONTRACTORID IN SA_USER_CONTRACTOR_SEC.CONTRACTOR_ID%TYPE,
      INUCONTRACTID   IN SA_USER_CONTRACTOR_SEC.CONTRACT_ID%TYPE,
      ISBSECURITYTYPE IN SA_USER_CONTRACTOR_SEC.SEC_TYPE%TYPE
    )
    IS

    BEGIN
    
        
        INSERT INTO SA_USER_CONTRACTOR_SEC
                    ( USER_ID
                    , CONTRACTOR_ID
                    , CONTRACT_ID
                    , SEC_TYPE)
             VALUES (
                      INUUSERID
                    , INUCONTRACTORID
                    , INUCONTRACTID
                    , ISBSECURITYTYPE
                    );

    EXCEPTION
     WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
     WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
    END INSCONTRSECSETTINGS;
    
    




















    PROCEDURE DELCONTRSECSETTINGS
    (
      INUUSERID       IN SA_USER_CONTRACTOR_SEC.USER_ID%TYPE,
      INUCONTRACTORID IN SA_USER_CONTRACTOR_SEC.CONTRACTOR_ID%TYPE,
      INUCONTRACTID   IN SA_USER_CONTRACTOR_SEC.CONTRACT_ID%TYPE,
      ISBSECURITYTYPE IN SA_USER_CONTRACTOR_SEC.SEC_TYPE%TYPE
    )
    IS
    BEGIN

        
        DELETE
          FROM SA_USER_CONTRACTOR_SEC
         WHERE USER_ID = INUUSERID
           AND CONTRACTOR_ID = INUCONTRACTORID
           AND NVL(CONTRACT_ID, -1) = NVL(INUCONTRACTID, -1)
           AND SEC_TYPE = ISBSECURITYTYPE
             ;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END DELCONTRSECSETTINGS;
    
    

















    PROCEDURE GETADMINS
    (
        INUCONTRACTORID     IN      GE_CONTRATISTA.ID_CONTRATISTA%TYPE,
        OTBPERSONS          OUT NOCOPY DAGE_PERSON.TYTBGE_PERSON
    )
    IS

        CURSOR CUADMINS IS
            SELECT  /*+
                       index(sa_user_contractor_sec idx_sa_user_contractor_sec06)
                       index(sa_user pk_sa_user)
                       index(ge_person idx_ge_person_01)
                       leading(sa_user_contractor_sec)
                       use_nl(sa_user_contractor_sec sa_user)
                       use_nl(sa_user sa_user_roles)
                       use_nl(sa_user ge_person)
                    */
                    GE_PERSON.*,
                    GE_PERSON.ROWID
                    /*+ CT_BCContrSecurity.GetAdmins*/
            FROM    SA_USER_CONTRACTOR_SEC,
                    SA_USER,
                    GE_PERSON
         WHERE      SA_USER_CONTRACTOR_SEC.CONTRACTOR_ID = INUCONTRACTORID
           AND      SA_USER_CONTRACTOR_SEC.SEC_TYPE = CT_BOCONSTANTS.CSBCONTR_ADMIN_ROLE
           AND      SA_USER.USER_ID = SA_USER_CONTRACTOR_SEC.USER_ID
           AND EXISTS(
               SELECT /*+
                      index(sa_user_roles idx_sa_user_roles01)
                      index(sa_role idx_sa_role_01)
                      use_nl(sa_user_roles sa_role)
                      */
                      'x'
                 FROM SA_USER_ROLES,
                      SA_ROLE
                WHERE SA_USER_ROLES.USER_ID = SA_USER.USER_ID
                  AND SA_ROLE.ROLE_TYPE_ID = CT_BOCONSTANTS.CNUCONTRACTOR_ADM_ROLE_TY
                  AND SA_ROLE.ROLE_ID = SA_USER_ROLES.ROLE_ID
                  )
           AND GE_PERSON.USER_ID = SA_USER.USER_ID;

    BEGIN

        OPEN CUADMINS;
        FETCH CUADMINS BULK COLLECT INTO OTBPERSONS;
        CLOSE CUADMINS;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            IF (CUADMINS%ISOPEN)THEN
                CLOSE  CUADMINS;
            END IF;
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            IF (CUADMINS%ISOPEN)THEN
                CLOSE  CUADMINS;
            END IF;
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
  END GETADMINS;

  

















    PROCEDURE GETAUX
    (
        INUCONTRACTID       IN      GE_CONTRATO.ID_CONTRATO%TYPE,
        OTBPERSONS          OUT NOCOPY DAGE_PERSON.TYTBGE_PERSON
    )
    IS

        CURSOR CUAUX IS
            SELECT
                /*+
                    index(sa_user_contractor_sec idx_sa_user_contractor_sec05)
                    index(sa_user pk_sa_user)
                    index(ge_person idx_ge_person_01)
                    leading(sa_user_contractor_sec)
                    use_nl(sa_user_contractor_sec sa_user)
                    use_nl(sa_user sa_user_roles)
                    use_nl(sa_user ge_person)
                */
                GE_PERSON.*,
                GE_PERSON.ROWID
                /*+ CT_BCContrSecurity.GetAux*/
           FROM SA_USER_CONTRACTOR_SEC
              , SA_USER
              , GE_PERSON
          WHERE SA_USER_CONTRACTOR_SEC.CONTRACT_ID =INUCONTRACTID
            AND SA_USER_CONTRACTOR_SEC.SEC_TYPE = CT_BOCONSTANTS.CSBCONTR_AUX_ROLE
            AND SA_USER.USER_ID = SA_USER_CONTRACTOR_SEC.USER_ID
            AND EXISTS(
                SELECT /*+
                       index(sa_user_roles idx_sa_user_roles01)
                       index(sa_role idx_sa_role_01)
                       use_nl(sa_user_roles sa_role)
                       */
                       'x'
                  FROM SA_USER_ROLES,
                       SA_ROLE
                 WHERE SA_USER_ROLES.USER_ID = SA_USER.USER_ID
                   AND SA_ROLE.ROLE_TYPE_ID = CT_BOCONSTANTS.CNUCONTRACTOR_ADM_ROLE_TY
                   AND SA_ROLE.ROLE_ID = SA_USER_ROLES.ROLE_ID
                   )
           AND GE_PERSON.USER_ID = SA_USER.USER_ID;

    BEGIN

        OPEN CUAUX;
        FETCH CUAUX BULK COLLECT INTO OTBPERSONS;
        CLOSE CUAUX;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            IF (CUAUX%ISOPEN)THEN
                CLOSE  CUAUX;
            END IF;
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            IF (CUAUX%ISOPEN)THEN
                CLOSE  CUAUX;
            END IF;
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
  END GETAUX;

END CT_BCCONTRSECURITY;