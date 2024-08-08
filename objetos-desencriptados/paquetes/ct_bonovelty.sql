PACKAGE BODY CT_BONovelty
IS

























































































    
    
    
    CSBVERSION                  CONSTANT VARCHAR2(10) := 'SAO483096';
    
    GNUORDERID_CACHE            NUMBER;
    GSBTECH_OPERUNIT_CACHE      OR_ORDER_COMMENT.ORDER_COMMENT%TYPE;
    GSBOBSERVATION_CACHE        OR_ORDER_COMMENT.ORDER_COMMENT%TYPE;

    CNUERROR901201              CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 901201;
    
    
    
    
    
    
    FUNCTION FSBVERSION
    RETURN VARCHAR2 IS
    BEGIN
        RETURN CSBVERSION;
    END;

    
    
    

















    FUNCTION FNUGETTOTALNOVELTYBYCERT
    (
        INUCERTID   IN  GE_ACTA.ID_ACTA%TYPE
    ) RETURN NUMBER
    IS
        
    BEGIN
        
        UT_TRACE.TRACE('CT_BONovelty.fnuGetTotalNoveltyByCert',8);
        
        RETURN CT_BCNOVELTY.FNUGETTOTALNOVELTYBYCERT(INUCERTID);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;
    

    




















    PROCEDURE GETCOMMENTTYPELOV
    (
        ORFDATA          IN OUT NOCOPY  CONSTANTS.TYREFCURSOR
    )
    IS
    BEGIN
    
        UT_TRACE.TRACE('Inicio - CT_BONovelty.getCommentTypeLov',1);
        
        GE_BCCOMMENTTYPE.GETCOMMENTTYPEBYCLASS(CT_BOCONSTANTS.FNUNOVELTYCOMMENTCLASS,
                                               ORFDATA);
        
        UT_TRACE.TRACE('Fin - CT_BONovelty.getCommentTypeLov',1);
        
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETCOMMENTTYPELOV;

    



































    PROCEDURE CREATENOVELTYAUTO
    (
        INUCONTRACTOR    IN             GE_CONTRATISTA.ID_CONTRATISTA%TYPE,
        INUCONTRACT      IN             GE_CONTRATO.ID_CONTRATO%TYPE,
        INUOPERUNIT      IN             OR_OPERATING_UNIT.OPERATING_UNIT_ID%TYPE,
        INUITEM          IN             CT_ITEM_NOVELTY.ITEMS_ID%TYPE,
        INUTECUNIT       IN             GE_PERSON.PERSON_ID%TYPE,
        INUORDERID       IN             OR_ORDER.ORDER_ID%TYPE,
        INUVALUE         IN             NUMBER,
        INUAMOUNT        IN             NUMBER,
        INUUSERID        IN             SA_USER.USER_ID%TYPE,
        INUCOMMENTYPE    IN             GE_COMMENT_TYPE.COMMENT_TYPE_ID%TYPE,
        ISBCOMMENT       IN             OR_ORDER_COMMENT.ORDER_COMMENT%TYPE,
        ONUORDER         OUT            OR_ORDER.ORDER_ID%TYPE,
        INURELTYPE       IN             GE_TRANSITION_TYPE.TRANSITION_TYPE_ID%TYPE
                                            DEFAULT CT_BOCONSTANTS.CNUTRANS_TYPE_NOVE_ORDER,
        IBOISAUTOM       IN             BOOLEAN   DEFAULT FALSE

    )
    IS
        PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN

        UT_TRACE.TRACE('INICIO - CT_BONovelty.CreateNoveltyAuto',1);

        CREATENOVELTY
        (
            INUCONTRACTOR => INUCONTRACTOR,
            INUCONTRACT   => INUCONTRACT,
            INUOPERUNIT   => INUOPERUNIT,
            INUITEM       => INUITEM,
            INUTECUNIT    => INUTECUNIT,
            INUORDERID    => INUORDERID,
            INUVALUE      => INUVALUE,
            INUAMOUNT     => INUAMOUNT,
            INUUSERID     => INUUSERID,
            INUCOMMENTYPE => INUCOMMENTYPE,
            ISBCOMMENT    => ISBCOMMENT,
            INURELTYPE    => INURELTYPE,
            IBOISAUTOM    => IBOISAUTOM,
            ONUORDER      => ONUORDER
        );
        
        UT_TRACE.TRACE('Commit la creacion de la novedad',1);
        COMMIT;

        UT_TRACE.TRACE('FIN - CT_BONovelty.CreateNoveltyAuto',1);

    EXCEPTION

        WHEN EX.CONTROLLED_ERROR THEN
            ROLLBACK;
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ROLLBACK;
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;

    END CREATENOVELTYAUTO;
    
    


































































    PROCEDURE CREATENOVELTY
    (
        INUCONTRACTOR    IN             GE_CONTRATISTA.ID_CONTRATISTA%TYPE,
        INUOPERUNIT      IN             OR_OPERATING_UNIT.OPERATING_UNIT_ID%TYPE,
        INUITEM          IN             CT_ITEM_NOVELTY.ITEMS_ID%TYPE,
        INUTECUNIT       IN             GE_PERSON.PERSON_ID%TYPE,
        INUORDERID       IN             OR_ORDER.ORDER_ID%TYPE,
        INUVALUE         IN             NUMBER,
        INUAMOUNT        IN             NUMBER,
        INUUSERID        IN             SA_USER.USER_ID%TYPE,
        INUCOMMENTYPE    IN             GE_COMMENT_TYPE.COMMENT_TYPE_ID%TYPE,
        ISBCOMMENT       IN             OR_ORDER_COMMENT.ORDER_COMMENT%TYPE,
        ONUORDER         OUT            OR_ORDER.ORDER_ID%TYPE,
        INURELTYPE       IN             GE_TRANSITION_TYPE.TRANSITION_TYPE_ID%TYPE
                                        DEFAULT CT_BOCONSTANTS.CNUTRANS_TYPE_NOVE_ORDER,
        IBOISAUTOM       IN             BOOLEAN   DEFAULT FALSE,
        INUCONTRACT      IN             GE_CONTRATO.ID_CONTRATO%TYPE DEFAULT NULL
    )
    IS
        NUPERSONID       GE_PERSON.PERSON_ID%TYPE;
        NUAMOUNT         OR_ORDER_ITEMS.LEGAL_ITEM_AMOUNT%TYPE;
        NUADDRESSID      AB_ADDRESS.ADDRESS_ID%TYPE;
        RCOPERUNIT       DAOR_OPERATING_UNIT.STYOR_OPERATING_UNIT;
        SBCOMMENT        OR_ORDER_COMMENT.ORDER_COMMENT%TYPE;

        ONUCONTRACTORID  GE_CONTRATO.ID_CONTRATISTA%TYPE;
        NUCONTRACT       GE_CONTRATO.ID_CONTRATO%TYPE;
        NUCONTRACTID     GE_CONTRATO.ID_CONTRATO%TYPE;
        RCORDER          DAOR_ORDER.STYOR_ORDER;
    BEGIN

        UT_TRACE.TRACE('Inicio - CT_BONovelty.CreateNovelty',1);
        
        
        IF ( INUUSERID IS NULL) THEN
            
            NUPERSONID := GE_BOPERSONAL.FNUGETPERSONID;
        ELSE
            
            NUPERSONID := GE_BCPERSON.FNUGETFIRSTPERSONBYUSERID(INUUSERID);
        END IF;
        UT_TRACE.TRACE('nuPersonId: '||NUPERSONID,1);

        
        
        IF ( INUAMOUNT IS NULL )
        THEN
            NUAMOUNT := 1;
        ELSE
            NUAMOUNT := INUAMOUNT;
        END IF;
        UT_TRACE.TRACE('nuAmount: '||NUAMOUNT,1);

        
        DAOR_OPERATING_UNIT.GETRECORD(INUOPERUNIT, RCOPERUNIT);

        IF ( RCOPERUNIT.STARTING_ADDRESS IS NULL )
        THEN
           NUADDRESSID := DAGE_BASE_ADMINISTRA.FNUGETDIRECCION( RCOPERUNIT.ADMIN_BASE_ID, 0 );
        ELSE
           NUADDRESSID := RCOPERUNIT.STARTING_ADDRESS;
        END IF;
        UT_TRACE.TRACE('nuAddressId: '||NUADDRESSID,1);
        
        
        
        
        
        IF ( INUTECUNIT IS NOT NULL )
        THEN
                SBCOMMENT := SUBSTR('[' ||
                                TO_CHAR(INUTECUNIT) ||
                                ' - ' ||
                                REPLACE(REPLACE(REPLACE(DAGE_PERSON.FSBGETNAME_(INUTECUNIT, 0),'%','%37'),'[','%91'),']','%93') ||
                                '] - [' ||
                                REPLACE(REPLACE(REPLACE(ISBCOMMENT,'%','%37'),'[','%91'),']','%93') ||
                                ']', 1, 2000);
        ELSE
                SBCOMMENT := REPLACE(REPLACE(REPLACE(ISBCOMMENT,'%','%37'),'[','%91'),']','%93');
        END IF;

        
        OR_BOORDER.CREATECLOSEORDER(
            INUOPERUNITID    => INUOPERUNIT,
            INUACTIVITY      => INUITEM,
            INUADDRESSID     => NUADDRESSID,
            IDTFINISHDATE    => NULL,
            INUITEMAMOUNT    => NUAMOUNT,
            INUREFVALUE      => INUVALUE,
            INUCAUSAL        => OR_BOCONSTANTS.CNUSUCCESCAUSAL,
            INURELATIONTYPE  => INURELTYPE,
            IONUORDERID      => ONUORDER,
            INUORDERRELAID   => INUORDERID,
            INUCOMMENTTYPEID => INUCOMMENTYPE,
            ISBCOMMENT       => SBCOMMENT,
            INUPERSONID      => NUPERSONID
        );

        IF (ONUORDER IS NOT NULL)
        THEN
            UT_TRACE.TRACE('inuOrderId: '||INUORDERID,1);
            UT_TRACE.TRACE('onuOrder: '||ONUORDER,1);
            
            IF (INUORDERID IS NOT NULL)
            THEN
                
                IF  ( DAOR_ORDER.FSBGETIS_PENDING_LIQ(INUORDERID) = CT_BOCONSTANTS.CSBEXCLUDEDORDER )
                THEN
                    DAOR_ORDER.UPDIS_PENDING_LIQ(ONUORDER, CT_BOCONSTANTS.CSBEXCLUDEDORDER);

                    UT_TRACE.TRACE('Se excluye la novedad ',1);
                END IF;
            END IF;
            
            
            IF ( IBOISAUTOM )
            THEN
                UT_TRACE.TRACE('Es autom�tica ',1);
                
                IF(INUORDERID IS NOT NULL)
                THEN
                    
                    NUCONTRACT := DAOR_ORDER.FNUGETDEFINED_CONTRACT_ID(INUORDERID);
                    UT_TRACE.TRACE('Contrato para liq seg�n orden '||NUCONTRACT,1);

                    
                    OR_BCORDER.UPDSAVECONTRORDERDATA
                    (
                        ONUORDER,
                        CT_BOCONSTANTS.FSBSAVEDDATAVALUEAUTO,
                        NUCONTRACT
                    );
                ELSE
                    
                    DAOR_ORDER.UPDSAVED_DATA_VALUES
                    (
                        ONUORDER,
                        CT_BOCONSTANTS.FSBSAVEDDATAVALUEAUTO,
                        0
                    );
                END IF;
            END IF;
            
            IF ( INUCONTRACT IS NOT NULL )
            THEN
                NUCONTRACT := INUCONTRACT;
            ELSE
                IF ( INUORDERID IS NOT NULL  )
                THEN
                    
                    NUCONTRACT := DAOR_ORDER.FNUGETDEFINED_CONTRACT_ID(INUORDERID);
                    IF (    NUCONTRACT IS NOT NULL AND
                            DAGE_CONTRATO.FSBGETSTATUS(NUCONTRACT) = CT_BOCONSTANTS.FSBGETCLOSEDSTATUS
                        )
                    THEN
                        NUCONTRACT := NULL;
                    END IF;
                END IF;
                
                 IF (NUCONTRACT IS NULL)
                    THEN
                        
                        CT_BOCONTRACT.GETCONTRACTTOLIQORDER
                        (
                            ONUORDER,
                            ONUCONTRACTORID,
                            NUCONTRACT
                        );
                    END IF;
                    
            END IF;

            UT_TRACE.TRACE('inuContract '||INUCONTRACT,1);
            UT_TRACE.TRACE('Contrato a usar '||NUCONTRACT,1);

            DAOR_ORDER.GETRECORD(ONUORDER, RCORDER);
            
            
            IF ( RCORDER.DEFINED_CONTRACT_ID IS NULL)
            THEN
                UT_TRACE.TRACE('Actualiza el contrato para la orden generada',1);
                
                DAOR_ORDER.UPDDEFINED_CONTRACT_ID(ONUORDER,NUCONTRACT);
            END IF;
        END IF;
        
        UT_TRACE.TRACE('Fin - CT_BONovelty.CreateNovelty',1);
        
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END CREATENOVELTY;


    







































    PROCEDURE VALIDATENOVELTY
    (
        INUOPERUNIT      IN             OR_OPERATING_UNIT.OPERATING_UNIT_ID%TYPE,
        INUITEM          IN             CT_ITEM_NOVELTY.ITEMS_ID%TYPE,
        INUTECUNIT       IN             GE_PERSON.PERSON_ID%TYPE,
        INUORDERID       IN             OR_ORDER.ORDER_ID%TYPE,
        INUVALUE         IN             NUMBER,
        INUAMOUNT        IN             NUMBER,
        INUUSERID        IN             SA_USER.USER_ID%TYPE,
        INUCOMMENTYPE    IN             GE_COMMENT_TYPE.COMMENT_TYPE_ID%TYPE,
        ISBCOMMENT       IN             OR_ORDER_COMMENT.ORDER_COMMENT%TYPE,
        IBOVERFINPRO     IN             BOOLEAN DEFAULT TRUE
    )
    IS
        BOVALIDATE       BOOLEAN;
        NUCONTRACTORID   GE_CONTRATISTA.ID_CONTRATISTA%TYPE;
        NUOPERUNIT       OR_OPERATING_UNIT.OPERATING_UNIT_ID%TYPE;
        SBUSERMASK       SA_USER.MASK%TYPE;
        NUUSERID         SA_USER.USER_ID%TYPE;
        NUMAX_AMOUNT     NUMBER;
    BEGIN

        UT_TRACE.TRACE('Inicio - CT_BONovelty.ValidateNovelty',5);
        
        
        IF ( INUUSERID IS NULL) THEN
            NUUSERID    := SA_BOUSER.FNUGETUSERID();
        ELSE
            NUUSERID    := INUUSERID;
        END IF;


        
        IF( INUOPERUNIT IS NULL AND INUITEM IS NULL AND INUCOMMENTYPE IS NULL ) THEN

            GE_BOERRORS.SETERRORCODE( CT_BOCONSTANTS.CNUERRREQNOVEDATA );

        END IF;

        
        BOVALIDATE := DAOR_OPERATING_UNIT.FBLEXIST( INUOPERUNIT );

        IF BOVALIDATE THEN
            
            NUCONTRACTORID := DAOR_OPERATING_UNIT.FNUGETCONTRACTOR_ID( INUOPERUNIT, 0 );
        ELSE
            GE_BOERRORS.SETERRORCODE( CT_BOCONSTANTS.CNUERRUNITWORKNOTEXIST );
        END IF;

        
        IF ( NUCONTRACTORID IS NULL ) THEN
            GE_BOERRORS.SETERRORCODE( CT_BOCONSTANTS.CNUERRUNITWORK );
        END IF;

        
        BOVALIDATE := DACT_ITEM_NOVELTY.FBLEXIST( INUITEM );

        IF ( BOVALIDATE = FALSE ) THEN
            GE_BOERRORS.SETERRORCODE( CT_BOCONSTANTS.CNUERRNOVEITEM );
        END IF;

        
        
        IF INUTECUNIT IS NOT NULL THEN

            BOVALIDATE := DAOR_OPER_UNIT_PERSONS.FBLEXIST(
                INUOPERUNIT,
                INUTECUNIT
            );

            IF ( BOVALIDATE = FALSE ) THEN
                GE_BOERRORS.SETERRORCODE( CT_BOCONSTANTS.CNUERRTECHUNIT );
            END IF;


        END IF;

        
        
        
        IF (  INUORDERID IS NOT NULL ) THEN
            
            BOVALIDATE := DAOR_ORDER.FBLEXIST( INUORDERID );

            IF ( BOVALIDATE = FALSE ) THEN
                GE_BOERRORS.SETERRORCODE( CT_BOCONSTANTS.CNUERRNOTVALIORDER );
            END IF;
            
            NUOPERUNIT := DAOR_ORDER.FNUGETOPERATING_UNIT_ID(INUORDERID, 0);

            
            
            IF ( INUOPERUNIT != NUOPERUNIT ) THEN
                GE_BOERRORS.SETERRORCODE( CT_BOCONSTANTS.CNUERRUNITWORKNOTORDER );

            END IF;

            
            IF ( CT_BCNOVELTY.FBOISNOVELTYORDER ( INUORDERID ) ) THEN
            
                GE_BOERRORS.SETERRORCODE( CT_BOCONSTANTS.CNUERRNOTVALIORDER );
                
            END IF;

            
            IF ( CT_BCNOVELTY.FBOISNOVELTYORDERBYITEM(
                    INUORDERID,
                    INUITEM)
                ) THEN

                GE_BOERRORS.SETERRORCODE( CT_BOCONSTANTS.CNUERRNOTVALIORDER );

            END IF;

        END IF;

        
        
        IF ( INUVALUE IS NOT NULL ) THEN

            IF ( INUAMOUNT IS NOT NULL ) THEN
                GE_BOERRORS.SETERRORCODE( CT_BOCONSTANTS.CNUERRVALUE );
            END IF;

            
            IF ( INUVALUE <= 0) THEN
                GE_BOERRORS.SETERRORCODE( CT_BOCONSTANTS.CNUERRVALUE );
            END IF;

            
            
            IF (IBOVERFINPRO) THEN
                UT_TRACE.TRACE('Si valida el tope del perfil financiero.',5);
                IF ( GE_BOFINANCIALPROFILE.FNUCANADDNOVELTYAMOUNT(
                        NUUSERID,
                        INUITEM,
                        INUVALUE
                        ) <> 1
                 ) THEN
                    
                    NUMAX_AMOUNT := GE_BOFINANCIALPROFILE.FNUMAXAMOUNTBYUSER(GE_BOCONSTANTS.CNUFINACTIONCONTNOVE , NUUSERID);
                    GE_BOERRORS.SETERRORCODEARGUMENT(CNUERROR901201,INUVALUE||'|'||NUMAX_AMOUNT);
                END IF;
            END IF;
        END IF;

        
        
        IF ( INUAMOUNT IS NOT NULL ) THEN

            IF ( INUVALUE IS NOT NULL ) THEN
                GE_BOERRORS.SETERRORCODE( CT_BOCONSTANTS.CNUERRAMOUNT );
            END IF;

            IF ( INUAMOUNT <= 0 ) THEN
                GE_BOERRORS.SETERRORCODE( CT_BOCONSTANTS.CNUERRAMOUNT );
            END IF;

            
            IF ( INUAMOUNT != UT_MATH.FNUCEIL( INUAMOUNT ) ) THEN
                GE_BOERRORS.SETERRORCODE( CT_BOCONSTANTS.CNUERRAMOUNT );
            END IF;

        END IF;

         
        BOVALIDATE := DAGE_COMMENT_TYPE.FBLEXIST( INUCOMMENTYPE );

        IF ( BOVALIDATE = FALSE ) THEN
                GE_BOERRORS.SETERRORCODE( CT_BOCONSTANTS.CNUERRCLASSCOMMTYPE );
        END IF;

        
        IF ( DAGE_COMMENT_TYPE.FNUGETCOMMENT_CLASS_ID( INUCOMMENTYPE, 0) !=
             CT_BOCONSTANTS.FNUNOVELTYCOMMENTCLASS ) THEN
                GE_BOERRORS.SETERRORCODE( CT_BOCONSTANTS.CNUERRCLASSCOMMTYPE );
        END IF;

        UT_TRACE.TRACE('Fin - CT_BONovelty.ValidateNovelty',1);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END VALIDATENOVELTY;


     



























    PROCEDURE VERIFYNOVELTYTOREVERSE
    (
        INUORDERID       IN             OR_ORDER.ORDER_ID%TYPE,
        IBOVERFINPRO     IN             BOOLEAN DEFAULT FALSE
    )
    IS
    
        BOVALIDATE       BOOLEAN;
        TBRELATEDORDERS  DAOR_RELATED_ORDER.TYTBOR_RELATED_ORDER;
        
        NUITEM           CT_ITEM_NOVELTY.ITEMS_ID%TYPE;
        NUVALUEREF       OR_ORDER_ACTIVITY.VALUE_REFERENCE%TYPE;
        RFNOVELTYORDER   CONSTANTS.TYREFCURSOR;
        
        NUUSERID         SA_USER.USER_ID%TYPE;
        
        NUMAX_AMOUNT     NUMBER;
    BEGIN
    
        UT_TRACE.TRACE('Inicio - CT_BONovelty.VerifyNoveltyToReverse',1);
        
        
        IF (  INUORDERID IS NOT NULL ) THEN
        
            
            BOVALIDATE := DAOR_ORDER.FBLEXIST( INUORDERID );

            IF ( BOVALIDATE = FALSE ) THEN
            
                GE_BOERRORS.SETERRORCODE( CT_BOCONSTANTS.CNUERRORDERNOTEXIST );
            
            END IF;
            
            
            IF ( CT_BCNOVELTY.FBOISNOVELTYORDER ( INUORDERID ) = FALSE ) THEN
            
                GE_BOERRORS.SETERRORCODE( CT_BOCONSTANTS.CNUERRNOTNOVEORDER );
            
            END IF;

            







            IF ( CT_BCNOVELTY.FBOISREVERTORDER( INUORDERID ) ) THEN

                GE_BOERRORS.SETERRORCODE( CT_BOCONSTANTS.CNUERREXISTREVENOVE );

            END IF;

            
            IF ( CT_BCNOVELTY.FBOISORDERCERTIFICA( INUORDERID ) ) THEN
            
                GE_BOERRORS.SETERRORCODE( CT_BOCONSTANTS.CNUERRISORDERCERTI );
                             
            END IF;
            
            
            CT_BCNOVELTY.GETNOVELTYORDER( INUORDERID, RFNOVELTYORDER);

            FETCH RFNOVELTYORDER INTO NUITEM, NUVALUEREF;

            IF (RFNOVELTYORDER %ISOPEN)THEN
               CLOSE  RFNOVELTYORDER;
            END IF;
            
            NUUSERID := SA_BOUSER.FNUGETUSERID();
            
            
            
            IF (IBOVERFINPRO) THEN
                UT_TRACE.TRACE('Si valida el tope del perfil financiero.',5);
                IF (GE_BOFINANCIALPROFILE.FNUCANADDNOVELTYAMOUNT
                    (
                        NUUSERID,
                        NUITEM,
                        NUVALUEREF,
                        1
                    )
                    <> 1
                ) THEN
                    
                    NUMAX_AMOUNT := GE_BOFINANCIALPROFILE.FNUMAXAMOUNTBYUSER(GE_BOCONSTANTS.CNUFINACTIONCONTNOVE , NUUSERID);
                 
                    ERRORS.SETERROR(CNUERROR901201,TO_CHAR(NUVALUEREF)||'|'||TO_CHAR(NUMAX_AMOUNT));
                    RAISE  EX.CONTROLLED_ERROR;
                END IF;
            END IF;

        END IF; 
        
        UT_TRACE.TRACE('Fin - CT_BONovelty.VerifyNoveltyToReverse',1);
        
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END VERIFYNOVELTYTOREVERSE;

     



















    PROCEDURE REVERSENOVELTY
    (
        INUORDERID       IN             OR_ORDER.ORDER_ID%TYPE,
        IDTDATE          IN             OR_ORDER_ACTIVITY.REGISTER_DATE%TYPE,
        ISBCOMMENT       IN             OR_ORDER_COMMENT.ORDER_COMMENT%TYPE
    )
    IS

        RCORDER          DAOR_ORDER.STYOR_ORDER;
        NUPERSONID       GE_PERSON.PERSON_ID%TYPE;
        NUCONTRACTORID   GE_CONTRATISTA.ID_CONTRATISTA%TYPE;
        BOISAUTOM        BOOLEAN;
        NUORDER          OR_ORDER.ORDER_ID%TYPE;
        RFNOVELTYORDER   CONSTANTS.TYREFCURSOR;
        NUITEM           CT_ITEM_NOVELTY.ITEMS_ID%TYPE;
        NUVALUEREF       OR_ORDER_ACTIVITY.VALUE_REFERENCE%TYPE;
        NUCOMMENTTYPE    GE_COMMENT_TYPE.COMMENT_TYPE_ID%TYPE;

    BEGIN

        UT_TRACE.TRACE('Inicio - CT_BONovelty.ReverseNovelty',1);

        
        DAOR_ORDER.GETRECORD(INUORDERID, RCORDER);
        
        NUCONTRACTORID := DAOR_OPERATING_UNIT.FNUGETCONTRACTOR_ID(RCORDER.OPERATING_UNIT_ID, 0);
        
        
        
        IF ( RCORDER.SAVED_DATA_VALUES = CT_BOCONSTANTS.FSBSAVEDDATAVALUEAUTO ) THEN
        
            BOISAUTOM := TRUE;

        ELSE
        
            BOISAUTOM := FALSE;
        
        END IF;
        
        CT_BCNOVELTY.GETNOVELTYORDER( INUORDERID, RFNOVELTYORDER);
        
        FETCH RFNOVELTYORDER INTO NUITEM, NUVALUEREF;
        
        IF (RFNOVELTYORDER %ISOPEN)THEN
           CLOSE  RFNOVELTYORDER;
        END IF;
        
        NUCOMMENTTYPE := CT_BCNOVELTY.FNUCOMMTYPEBYNOVEORDER( INUORDERID );
        
        
        
        CREATENOVELTY(
               INUCONTRACTOR => NUCONTRACTORID,
               INUOPERUNIT   => RCORDER.OPERATING_UNIT_ID,
               INUITEM       => NUITEM,
               INUTECUNIT    => NULL,
               INUORDERID    => INUORDERID,
               INUVALUE      => NUVALUEREF,
               INUAMOUNT     => NULL,
               INUUSERID     => NULL,
               INUCOMMENTYPE => NUCOMMENTTYPE,
               ISBCOMMENT    => ISBCOMMENT,
               INURELTYPE    => CT_BOCONSTANTS.CNUTRANS_TYPE_REVE_NOVE,
               IBOISAUTOM    => BOISAUTOM,
               ONUORDER      => NUORDER
        );
        
        UT_TRACE.TRACE('Fin - CT_BONovelty.ReverseNovelty',1);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            IF (RFNOVELTYORDER %ISOPEN)THEN
               CLOSE  RFNOVELTYORDER;
            END IF;

            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            IF (RFNOVELTYORDER %ISOPEN)THEN
               CLOSE  RFNOVELTYORDER;
            END IF;

            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END REVERSENOVELTY;


    




































    PROCEDURE CREATENOVELTYRULE
    (
        INUOPERUNIT     IN  OR_OPERATING_UNIT.OPERATING_UNIT_ID%TYPE,
        INUITEM         IN  CT_ITEM_NOVELTY.ITEMS_ID%TYPE,
        INUTECUNIT      IN  GE_PERSON.PERSON_ID%TYPE,
        INUORDERID      IN  OR_ORDER.ORDER_ID%TYPE,
        INUVALUE        IN  NUMBER,
        INUAMOUNT       IN  NUMBER,
        INUUSERID       IN  SA_USER.USER_ID%TYPE,
        INUCOMMENTYPE   IN  GE_COMMENT_TYPE.COMMENT_TYPE_ID%TYPE,
        ISBCOMMENT      IN  OR_ORDER_COMMENT.ORDER_COMMENT%TYPE
    )
    IS
        
        BLHASERROR          BOOLEAN := FALSE;
        NUCONTRACTORID      GE_CONTRATISTA.ID_CONTRATISTA%TYPE;
        ONUORDER            NUMBER;
        NUUSERID            SA_USER.USER_ID%TYPE := INUUSERID;
        
        SBFINALDATE         GE_BOINSTANCECONTROL.STYSBVALUE;
        DTFINALDATE         DATE;
        
        SBCONTRACT          GE_BOINSTANCECONTROL.STYSBVALUE;
        NUCONTRACT          GE_CONTRATO.ID_CONTRATO%TYPE;
        NUTASKTYPE          OR_ORDER.TASK_TYPE_ID%TYPE;
    BEGIN
        
        UT_TRACE.TRACE('INICIO CT_BONovelty.CreateNoveltyRule',5);

        
        
        BEGIN
            
            CT_BONOVELTY.VALIDATENOVELTY
            (
                INUOPERUNIT,
                INUITEM,
                INUTECUNIT,
                INUORDERID,
                INUVALUE,
                INUAMOUNT,
                INUUSERID,
                INUCOMMENTYPE,
                ISBCOMMENT,
                FALSE       
            );
        EXCEPTION
            WHEN OTHERS THEN
                BLHASERROR := TRUE;
                ERRORS.SETERROR;
        END;
        

        IF (NUUSERID IS NULL) THEN
            NUUSERID := SA_BOSYSTEM.GETSYSTEMUSERID;
        END IF;
        
        NUCONTRACTORID := DAOR_OPERATING_UNIT.FNUGETCONTRACTOR_ID(INUOPERUNIT, 0);

        
        IF (NOT BLHASERROR) THEN
            CT_BONOVELTY.CREATENOVELTY
            (
                NUCONTRACTORID,
                INUOPERUNIT,
                INUITEM,
                INUTECUNIT,
                INUORDERID,
                INUVALUE,
                INUAMOUNT,
                NUUSERID,
                INUCOMMENTYPE,
                ISBCOMMENT,
                ONUORDER,
                CT_BOCONSTANTS.CNUTRANS_TYPE_NOVE_ORDER,
                TRUE
            );
            
            IF (ONUORDER IS NOT NULL) THEN
                CT_BOCERTIFICATECONTROL.BLINSERTNOVORDERS := TRUE;
                
                GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(CT_BOCONSTANTS.FSBGETCONTRACTORINSTANCENAME,
                                                  NULL,
                                                  'GE_PERIODO_CERT',
                                                   CT_BOCONSTANTS.FSBGETBREAKDATEATTRNAME,
                                                  SBFINALDATE);
                DTFINALDATE := TO_DATE(SBFINALDATE,  UT_DATE.FSBDATE_FORMAT);
                
                IF DTFINALDATE < DAOR_ORDER.FDTGETEXECUTION_FINAL_DATE(ONUORDER) THEN
                
                    
                    DAOR_ORDER.UPDEXECUTION_FINAL_DATE(ONUORDER, DTFINALDATE);

                END IF;

                
                GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(CT_BOCONSTANTS.FSBGETCONTRACTORINSTANCENAME,
                                                  NULL,
                                                  'GE_CONTRATO',
                                                  'ID_CONTRATO',
                                                  SBCONTRACT);

                
                NUCONTRACT := TO_NUMBER(SBCONTRACT);
                
                
                NUTASKTYPE := DAOR_ORDER.FNUGETTASK_TYPE_ID(ONUORDER);
                
                
                
                IF CT_BCCONTRACT.FBLHASCONTRACTTASKTYPES(NUCONTRACT) THEN
                    
                    IF CT_BCCONTRACT.FBLAPPLYCONTBYTASKTYPE(NUCONTRACT, NUTASKTYPE) THEN
                        
                        DAOR_ORDER.UPDDEFINED_CONTRACT_ID(ONUORDER,NUCONTRACT);
                    END IF;
                
                ELSIF CT_BCCONTRACT.FBLHASCONTTYPETASKTYPES(NUCONTRACT) THEN
                    
                    IF CT_BCCONTRACT.FBLAPPLYCONTTYPEBYTSKTYPE(DAGE_CONTRATO.FNUGETID_TIPO_CONTRATO(NUCONTRACT),NUTASKTYPE) THEN
                        
                        DAOR_ORDER.UPDDEFINED_CONTRACT_ID(ONUORDER,NUCONTRACT);
                    END IF;
                ELSE
                    
                    
                    DAOR_ORDER.UPDDEFINED_CONTRACT_ID(ONUORDER,NUCONTRACT);

                END IF;
            END IF;
        END IF;
    
        UT_TRACE.TRACE('FIN CT_BONovelty.CreateNoveltyRule',5);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END CREATENOVELTYRULE;
    
    


















    PROCEDURE REVERSENOVELTYFORMASSPROC
    (
        INUORDER        IN  OR_ORDER.ORDER_ID%TYPE,
        ISBCOMMENT      IN  OR_ORDER_COMMENT.ORDER_COMMENT%TYPE
    )
    IS
        
    BEGIN
        
        UT_TRACE.TRACE('INICIO CT_BONovelty.ReverseNoveltyForMassProc',5);

        
        CT_BONOVELTY.VERIFYNOVELTYTOREVERSE(INUORDER);

        
        CT_BONOVELTY.REVERSENOVELTY
        (
            INUORDER,
            UT_DATE.FDTSYSDATE,
            ISBCOMMENT
        );

        UT_TRACE.TRACE('FIN CT_BONovelty.ReverseNoveltyForMassProc',5);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END REVERSENOVELTYFORMASSPROC;
    
    




















    PROCEDURE DELAUTONOVELTYBYCERT
    (
        INUCERTIFICATEID IN  GE_ACTA.ID_ACTA%TYPE
    )
    IS
        TBAUTNOVORDERSID        DAOR_ORDER.TYTBORDER_ID;
    BEGIN
        
        UT_TRACE.TRACE('INICIO CT_BONovelty.delAutoNoveltyByCert',5);

        
        
        CT_BCNOVELTY.GETAUTONNOVORDERS
        (
            INUCERTIFICATEID,
            TBAUTNOVORDERSID
        );
        
        
        IF TBAUTNOVORDERSID.COUNT > 0 THEN
        
            CT_BONOVELTY.DELAUTOMORDERS(TBAUTNOVORDERSID);
        
        END IF;

        UT_TRACE.TRACE('FIN CT_BONovelty.delAutoNoveltyByCert',5);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END DELAUTONOVELTYBYCERT;
    
    
    














    FUNCTION FSBTECNOPERUNIT
    (
        INUORDERID  IN  OR_ORDER.ORDER_ID%TYPE
    ) RETURN VARCHAR2
    IS
        SBCOMMENT       OR_ORDER_COMMENT.ORDER_COMMENT%TYPE;
        NUPOS2          NUMBER;
    BEGIN
        
        IF (GNUORDERID_CACHE IS NULL OR INUORDERID != GNUORDERID_CACHE) THEN
            GNUORDERID_CACHE := INUORDERID;

            SBCOMMENT   := OR_BCORDERCOMMENT.FSBGETFIRSTCOMMENT(INUORDERID);

            
            IF ( SUBSTR(SBCOMMENT,1,1) = '[' ) THEN
                NUPOS2 := INSTR(SBCOMMENT,']',1,1);
                GSBTECH_OPERUNIT_CACHE := REPLACE(REPLACE(REPLACE(SUBSTR(SBCOMMENT,2,NUPOS2-2),'%93',']'),'%91','['),'%37','%');
                
                NUPOS2 := INSTR(SBCOMMENT,'[',1,2);
                GSBOBSERVATION_CACHE := REPLACE(REPLACE(REPLACE(SUBSTR(SBCOMMENT,NUPOS2+1,LENGTH(SBCOMMENT)-NUPOS2-1),'%93',']'),'%91','['),'%37','%');
            ELSE
                GSBTECH_OPERUNIT_CACHE := '';
                GSBOBSERVATION_CACHE := REPLACE(REPLACE(REPLACE(SBCOMMENT,'%93',']'),'%91','['),'%37','%');
            END IF;
        END IF;
        
        RETURN GSBTECH_OPERUNIT_CACHE;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FSBTECNOPERUNIT;
    
    
    













    FUNCTION FSBOBSERVATIONNOVEL
    (
        INUORDERID  IN  OR_ORDER.ORDER_ID%TYPE
    ) RETURN VARCHAR2
    IS
        SBAUX   VARCHAR2(2000);
    BEGIN
        
        SBAUX := FSBTECNOPERUNIT(INUORDERID);
        RETURN GSBOBSERVATION_CACHE;
        
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FSBOBSERVATIONNOVEL;
    
    















    PROCEDURE DELAUTOMORDERS
    (
        ITBORDERS   IN     DAOR_ORDER.TYTBORDER_ID
    )
    IS
    BEGIN
        
        UT_TRACE.TRACE('INICIO CT_BONovelty.delAutomOrders',5);

        
        CT_BCNOVELTY.DELAUTONOVORDERFROMCERT(ITBORDERS);

        
        CT_BCNOVELTY.DELAUTONOVORDERFROMDETAIL(ITBORDERS);

        
        CT_BCNOVELTY.DELAUTONOVORDERFROMRELATION(ITBORDERS);

        
        CT_BCNOVELTY.DELACTIVFROMAUTONOVORDER(ITBORDERS);

        
        CT_BCNOVELTY.DELITEMSFROMAUTONOVORDER(ITBORDERS);

        
        CT_BCNOVELTY.DELSTATCHANGEFROMAUTONOVORDER(ITBORDERS);

        
        CT_BCNOVELTY.DELPERSONFROMAUTONOVORDER(ITBORDERS);

        
        CT_BCNOVELTY.DELEXTERNFROMAUTONOVORDER(ITBORDERS);

        
        CT_BCNOVELTY.DELPROCESSLOGBYAOTORDER(ITBORDERS);
        
        
        FORALL NUINDEX IN ITBORDERS.FIRST..ITBORDERS.LAST
            DELETE CT_EXCLUDED_ORDER
            WHERE  ORDER_ID = ITBORDERS(NUINDEX);

        
        CT_BCNOVELTY.DELCOMMENTBYAOTORDER(ITBORDERS);

        
        CT_BCNOVELTY.DELAUTONOVORDER(ITBORDERS);

        UT_TRACE.TRACE('FIN CT_BONovelty.delAutomOrders',5);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END DELAUTOMORDERS;
    
    














    FUNCTION FBLHASREVERTNOVELTY
    (
        INUORDERID       IN  OR_ORDER.ORDER_ID%TYPE
    )
    RETURN BOOLEAN
    IS
        NUCOUNT NUMBER;
    BEGIN
        
        UT_TRACE.TRACE('INICIO CT_BONovelty.fblHasRevertNovelty',5);

        RETURN CT_BCNOVELTY.FBLHASREVERTNOVELTY(INUORDERID);

        UT_TRACE.TRACE('FIN CT_BONovelty.fblHasRevertNovelty',5);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FBLHASREVERTNOVELTY;
    
    














    FUNCTION FNUISREVERTORDER
    (
        INUORDERID       IN  OR_ORDER.ORDER_ID%TYPE
    )
    RETURN NUMBER
    IS
        NUCOUNT NUMBER;
    BEGIN
        
        UT_TRACE.TRACE('INICIO CT_BONovelty.fnuIsRevertOrder',5);

        IF CT_BCNOVELTY.FBLISREVERTORDER(INUORDERID) THEN
            RETURN 1;
        END IF;
        
        RETURN 0;

        UT_TRACE.TRACE('FIN CT_BONovelty.fnuIsRevertOrder',5);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FNUISREVERTORDER;
    
    














    FUNCTION FSBISNOVELTYORDER
    (
       INUORDERID  IN OR_ORDER.ORDER_ID%TYPE
    )
    RETURN VARCHAR2
    IS
    BEGIN
        UT_TRACE.TRACE('INICIO CT_BONovelty.fnuIsRevertOrder',5);

        IF (CT_BCNOVELTY.FBOISNOVELTYORDER(INUORDERID)) THEN
            RETURN CT_BOCONSTANTS.CSBYES;
        END IF;

        UT_TRACE.TRACE('INICIO CT_BONovelty.fnuIsRevertOrder',5);
        RETURN CT_BOCONSTANTS.CSBNO;



     EXCEPTION
         WHEN EX.CONTROLLED_ERROR THEN
             RAISE EX.CONTROLLED_ERROR;
         WHEN OTHERS THEN
             ERRORS.SETERROR;
             RAISE EX.CONTROLLED_ERROR;
    END FSBISNOVELTYORDER;

END CT_BONOVELTY;