PACKAGE BODY TT_BOFault
IS
    

















































































































    
    
    
    CSBVERSION                  CONSTANT VARCHAR2(10) := 'SAO206341';

    
    
    
    CSBSET_TRACE             CONSTANT GE_PARAMETER.VALUE%TYPE := GE_BOPARAMETER.FSBGET('TRACE_BD');    
    CSBTRACE_LEVEL           CONSTANT GE_PARAMETER.VALUE%TYPE := GE_BOPARAMETER.FNUGET('TRACE_LEVEL'); 
    CSBDAO_USE_CACHE         CONSTANT GE_PARAMETER.PARAMETER_ID%TYPE := 'DAO_USE_CACHE';               
    CSBDISP_PARSER_ADDRESS   CONSTANT GE_PARAMETER.VALUE%TYPE := GE_BOPARAMETER.FSBGET('DISP_PARSER_ADDRESS'); 
    
    CNUREQ_FIELD_ERROR       CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 116082; 
    CNUINV_VALUE_ERROR       CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 7352;   
    CNUSTATUS_ERROR          CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 1570;   
    CNUFAULT_IN_USE_ERROR    CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 116480; 
    CNUINVALID_PROC_ERROR    CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 901229; 
    CNUINIT_DATE_ERROR       CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 113522; 
    CNUEST_ATT_DATE_ERROR    CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 117321; 
    CNUNULL_ATT_ERROR        CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 2126;   
    CNUELEMENT_CHANGE_ERROR  CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 901392; 
    CNUINITDATE_CHAN_ERROR   CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 901393; 
    CNUFAULTTYPE_CHAN_ERROR  CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 901703; 
    CNUATTENTION_DATE_ERROR  CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 110090; 
    CNUMIN_END_DATE_ERROR    CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 900577; 
    CNUEQUAL_DATES_ERROR     CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 5887;   
    CNUCLOS_CAUSE_ERROR      CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 901163; 
    CNUCAUSAL_UPD_ERROR      CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 901394; 
    CNUNO_ELEM_ADDR_ERROR    CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 901602; 

    CNUCOMMENT_TYPE          CONSTANT GE_COMMENT_TYPE.COMMENT_TYPE_ID%TYPE := 3; 
    
    
    
    
    
    TYPE TYTBPRODUCTS IS TABLE OF PR_PRODUCT.PRODUCT_ID%TYPE INDEX BY VARCHAR2(15);

    
    
    
    GTBELEMENTS TT_BOELEMENT.TYTBELEMENTS; 
    GTBPRODUCTS TYTBPRODUCTS;              

    
    
    
    













    FUNCTION FSBVERSION
    RETURN VARCHAR2 IS
    BEGIN
        RETURN CSBVERSION;
    END FSBVERSION;

    


































    PROCEDURE REGISTERFAULT
    (
        INUFAULTTYPEID     IN  TT_DAMAGE.REG_DAMAGE_TYPE_ID%TYPE,
        IDTINITIALDATE     IN  TT_DAMAGE.INITIAL_DATE%TYPE,
        INUORDERID         IN  OR_ORDER.ORDER_ID%TYPE,
        INUTIME            IN  NUMBER,
        ISBCLASS           IN  TT_DAMAGE.CLASS%TYPE,
        ISBCOMMENT         IN  MO_COMMENT.COMMENT_%TYPE,
        INUELEMENTID       IN  TT_DAMAGE.ELEMENT_ID%TYPE,
        INUACTIVITYID      IN  GE_ITEMS.ITEMS_ID%TYPE,
        IDTESTATTENDDATE   IN  TT_DAMAGE.ESTIMAT_ATTENT_DATE%TYPE,
        INUORDERACTIVITYID IN  TT_DAMAGE.ORDER_ACTIVITY_ID%TYPE,
        ONUFAULTID         OUT TT_DAMAGE.PACKAGE_ID%TYPE
    )
    IS
        NUTIME          NUMBER;                         
        RCPACKAGE       DAMO_PACKAGES.STYMO_PACKAGES;   
        RCDAMAGE        DATT_DAMAGE.STYTT_DAMAGE;       
        RCNODE          DAIF_NODE.STYIF_NODE;           
        NUADDRESSID     AB_ADDRESS.ADDRESS_ID%TYPE;     
        RCORDERACTIVITY DAOR_ORDER_ACTIVITY.STYOR_ORDER_ACTIVITY; 
        NUACTIVITYID    GE_ITEMS.ITEMS_ID%TYPE;         
        SBUSE           GE_ITEMS.USE_%TYPE;             
        RCAB_ADDRESS    DAAB_ADDRESS.STYAB_ADDRESS;     
        RCMO_ADDRESS    DAMO_ADDRESS.STYMO_ADDRESS;     
        NUORDERID       OR_ORDER.ORDER_ID%TYPE;         
        
        NUPOSINSTANCE   NUMBER;                         
        
        RCCOMMENT       DAMO_COMMENT.STYMO_COMMENT;     
    BEGIN
        
        IF (INUTIME IS NOT NULL) THEN
            
            NUTIME := INUTIME;
        END IF;
        
        MO_BOUTILGENERATEREQUEST.GENERATEPACKAGE(NULL,                               
                                                 TT_BCCONSTANTS.CNUMASSDAMAGE,       
                                                 TT_BCCONSTANTS.CSBTAGNAMEMASSDAMAGE,
                                                 NULL,                               
                                                 TT_BCCONSTANTS.CNUTTREGISTERSTATUS, 
                                                 NULL,                               
                                                 NULL,                               
                                                 NULL,                               
                                                 NULL,                               
                                                 ISBCOMMENT,                         
                                                 NULL,                               
                                                 NULL,                               
                                                 NULL,                               
                                                 NULL,                               
                                                 NULL,                               
                                                 NULL,                               
                                                 NULL,                               
                                                 NULL,                               
                                                 NULL,                               
                                                 RCPACKAGE,                          
                                                 FALSE);                             
        
        IF (IDTESTATTENDDATE IS NULL) THEN 
            
            IF (NUTIME IS NULL) THEN
                
                RCDAMAGE.ESTIMAT_ATTENT_DATE := NULL;
            ELSE
                RCDAMAGE.ESTIMAT_ATTENT_DATE := RCPACKAGE.REQUEST_DATE + (NUTIME/24);
            END IF;
        ELSE
            RCDAMAGE.ESTIMAT_ATTENT_DATE := IDTESTATTENDDATE;
        END IF;

        
        ONUFAULTID                    := RCPACKAGE.PACKAGE_ID;
        RCDAMAGE.PACKAGE_ID           := RCPACKAGE.PACKAGE_ID;
        RCDAMAGE.REG_DAMAGE_TYPE_ID   := INUFAULTTYPEID;
        RCDAMAGE.FINAL_DAMAGE_TYPE_ID := INUFAULTTYPEID;
        RCDAMAGE.INITIAL_DATE         := IDTINITIALDATE;
        RCDAMAGE.REPORT_QUANTITY      := 1;
        RCDAMAGE.MAX_ATTENT_DATE      := NULL;
        RCDAMAGE.REG_DAMAGE_STATUS    := TT_BCCONSTANTS.CSBREGISTEREDDAMAGESTATUS;
        RCDAMAGE.ANS_ID               := NULL;
        RCDAMAGE.CLASS                := ISBCLASS;
        RCDAMAGE.ELEMENT_ID           := INUELEMENTID;
        
        IF (    (INUORDERID IS NOT NULL)
            AND (INUELEMENTID IS NULL)) THEN 
           
           RCDAMAGE.ORDER_ACTIVITY_ID := OR_BCORDERACTIVITIES.FNUGETFIRSTORDERACT(INUORDERID);
        
        ELSIF (    (INUORDERID IS NOT NULL)
               AND (INUELEMENTID IS NOT NULL)
               AND (INUACTIVITYID IS NOT NULL)
               AND (INUORDERACTIVITYID IS NULL)) THEN 
               
               RCDAMAGE.ORDER_ACTIVITY_ID := OR_BCORDERACTIVITIES.FNUGETFIRSTORDERACT(INUORDERID);
        ELSE 
           
           RCDAMAGE.ORDER_ACTIVITY_ID := INUORDERACTIVITYID;
        END IF;
        
        IF (INUELEMENTID IS NOT NULL) THEN 
            
            RCNODE := DAIF_NODE.FRCGETRECORD(INUELEMENTID);
            RCDAMAGE.OPERATING_SECTOR_ID := NVL(OR_BOFW_PROCESS.FNUGETSECTORBYADDRESS(RCNODE.ADDRESS_ID),
                                                RCNODE.OPERATING_SECTOR_ID);
            
            NUADDRESSID := RCNODE.ADDRESS_ID;
            
            
            IF (NUADDRESSID IS NULL) THEN
                ERRORS.SETERROR(CNUNO_ELEM_ADDR_ERROR);
                RAISE EX.CONTROLLED_ERROR;
            END IF;
        ELSIF (RCDAMAGE.ORDER_ACTIVITY_ID IS NOT NULL) THEN 
               
               RCORDERACTIVITY := DAOR_ORDER_ACTIVITY.FRCGETRECORD(RCDAMAGE.ORDER_ACTIVITY_ID);
               RCDAMAGE.OPERATING_SECTOR_ID := NVL(OR_BOFW_PROCESS.FNUGETSECTORBYADDRESS(RCORDERACTIVITY.ADDRESS_ID),
                                                   RCORDERACTIVITY.OPERATING_SECTOR_ID);
               
               NUADDRESSID := RCORDERACTIVITY.ADDRESS_ID;
        END IF;

        
        
        IF (DATT_DAMAGE_TYPE.FSBGETTIME_OUT(INUFAULTTYPEID) = GE_BOCONSTANTS.CSBYES) THEN
            RCDAMAGE.APPROVAL := TT_BCCONSTANTS.CSBCOMP_PENDING;
        ELSE
            RCDAMAGE.APPROVAL := TT_BCCONSTANTS.CSBCOMP_NOT_APPLICAB;
        END IF;

        
        IF (INUACTIVITYID IS NULL) THEN
            IF (RCDAMAGE.ORDER_ACTIVITY_ID IS NOT NULL) THEN 
                
                NUACTIVITYID := DAOR_ORDER_ACTIVITY.FNUGETACTIVITY_ID(RCDAMAGE.ORDER_ACTIVITY_ID);
            ELSIF (INUELEMENTID IS NOT NULL) THEN 
                   
                   NUACTIVITYID := TT_BOACTIVITYSERVICEDAMAGE.FNUGETACTIVITYBYELEMENT(INUFAULTTYPEID,
                                                                                      RCNODE.ELEMENT_TYPE_ID);
            END IF;
        ELSE 
            NUACTIVITYID := INUACTIVITYID;
        END IF;

        
        IF (NUACTIVITYID IS NOT NULL) THEN
            
            SBUSE := DAGE_ITEMS.FSBGETUSE_(NUACTIVITYID);
            IF(SBUSE IN (TT_BCCONSTANTS.CSBDIAGNOSTICACTUSE,
                         OR_BOCONSTANTS.CSBCLIENT_MAINTENA_USE)) THEN
               RCPACKAGE.MOTIVE_STATUS_ID := TT_BCCONSTANTS.CNUTTDIAGORDERSTATUS;
            ELSE
               RCPACKAGE.MOTIVE_STATUS_ID := TT_BCCONSTANTS.CNUTTREPAIRORDERSTATUS;
            END IF;
        END IF;

        
        DATT_DAMAGE.INSRECORD(RCDAMAGE);

        
        IF (ISBCOMMENT IS NOT NULL) THEN
        
            MO_BOCOMMENT.ADDFAULTCOMMENT
            (
                TT_BCCONSTANTS.CNUREGISTERCOMMENT,
                RCPACKAGE.PACKAGE_ID,
                ISBCOMMENT,
                NULL,
                NULL
            );

        END IF;

        
        IF (NUADDRESSID IS NOT NULL) THEN
            
            RCAB_ADDRESS := DAAB_ADDRESS.FRCGETRECORD(NUADDRESSID);

            RCMO_ADDRESS.ADDRESS             := RCAB_ADDRESS.ADDRESS;
            RCMO_ADDRESS.ADDRESS_ID          := MO_BOSEQUENCES.FNUGETADDRESSID;
            RCMO_ADDRESS.ADDRESS_TYPE_ID     := MO_BOADDRESS.CNUADDRESSTYPEMAIN;
            RCMO_ADDRESS.GEOGRAP_LOCATION_ID := RCAB_ADDRESS.GEOGRAP_LOCATION_ID;
            RCMO_ADDRESS.IS_ADDRESS_MAIN     := RCAB_ADDRESS.IS_MAIN;
            RCMO_ADDRESS.PACKAGE_ID          := ONUFAULTID;
            RCMO_ADDRESS.PARSER_ADDRESS_ID   := RCAB_ADDRESS.ADDRESS_ID;
            DAMO_ADDRESS.INSRECORD(RCMO_ADDRESS);
            
            



        END IF;
        
        
        DAMO_PACKAGES.UPDRECORD(RCPACKAGE);

        
        IF (    (INUORDERACTIVITYID IS NULL)
            AND (INUELEMENTID IS NOT NULL)) THEN 
            NUORDERID := INUORDERID;
            
            TT_BOCREATEACTIVITY.CREATEACTIVITY(NUACTIVITYID,                
                                               RCPACKAGE.PACKAGE_ID,        
                                               RCDAMAGE.OPERATING_SECTOR_ID,
                                               NULL,                        
                                               NULL,                        
                                               NULL,                        
                                               NUORDERID,                   
                                               NUADDRESSID);                
                                               
            
            IF (GE_BOINSTANCECONTROL.FBLISINITINSTANCECONTROL) THEN
                
                IF (GE_BOINSTANCECONTROL.FBLACCKEYINSTANCESTACK('WORK_INSTANCE',
                                                                NUPOSINSTANCE)) THEN
                    
                    IF (OR_BOCONSTANTS.CSBCREATE_ACTI_REQUEST = GE_BOCONSTANTS.CSBYES) THEN
                        
                        IF ((SBUSE NOT IN (TT_BCCONSTANTS.CSBDIAGNOSTICACTUSE,
                                           OR_BOCONSTANTS.CSBCLIENT_MAINTENA_USE)
                             OR (SBUSE IS NULL))
                            AND OR_BOORDERPROGRAMING.FBLISORDERSCHEDULABLE(NUORDERID)
                            AND (DAOR_TASK_TYPE.FSBGETCOMPROMISE_CRM(DAOR_ORDER.FNUGETTASK_TYPE_ID(NUORDERID)) = GE_BOCONSTANTS.CSBYES)) THEN
                           
                           OR_BOFW_PROCESS.CALLPROGRAMMINGFORM(NUORDERID);
                        END IF;
                    END IF;
                END IF;
            END IF;
        END IF;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END REGISTERFAULT;
    
    


















    PROCEDURE VALFAULTSTATUS
    (
        INUFAULTID IN TT_DAMAGE.PACKAGE_ID%TYPE
    )
    IS
        NUSTATUS_ID    MO_PACKAGES.MOTIVE_STATUS_ID%TYPE;       
        SBSTATUS       TT_DAMAGE.REG_DAMAGE_STATUS%TYPE;        
        TBPACKAGESASSO DAMO_PACKAGES_ASSO.TYTBMO_PACKAGES_ASSO; 
    BEGIN
        
        NUSTATUS_ID := DAMO_PACKAGES.FNUGETMOTIVE_STATUS_ID(INUFAULTID);
        
        SBSTATUS := DATT_DAMAGE.FSBGETREG_DAMAGE_STATUS(INUFAULTID);
        
        
        IF (NUSTATUS_ID IN (TT_BCCONSTANTS.CNUTTATTENSTATUS,
                            TT_BCCONSTANTS.CNUTTUNFOUNDEDSTATUS)) THEN
            ERRORS.SETERROR(CNUSTATUS_ERROR);
            RAISE EX.CONTROLLED_ERROR;
        END IF;
        IF (SBSTATUS = TT_BCCONSTANTS.CSBPROCESSINGDAMAGESTATUS) THEN
            ERRORS.SETERROR(CNUINVALID_PROC_ERROR,
                            'fallas que est�n siendo procesadas');
            RAISE EX.CONTROLLED_ERROR;
        END IF;
        
        TBPACKAGESASSO := MO_BCPACKAGES_ASSO.FTBPACKASSOBYPACKID(INUFAULTID);
        IF (TBPACKAGESASSO.COUNT > 0) THEN
            ERRORS.SETERROR(CNUINVALID_PROC_ERROR,
                            'fallas que est�n absorbidas');
            RAISE EX.CONTROLLED_ERROR;
        END IF;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END VALFAULTSTATUS;
    
    















    PROCEDURE VALFAULTTYPE
    (
        INUFAULTID IN TT_DAMAGE.PACKAGE_ID%TYPE
    )
    IS
        RCDAMAGE      DATT_DAMAGE.STYTT_DAMAGE;           
        NUFAULTTYPEID TT_DAMAGE_TYPE.DAMAGE_TYPE_ID%TYPE; 
    BEGIN
        
        DATT_DAMAGE.GETRECORD(INUFAULTID,
                              RCDAMAGE);
        
        NUFAULTTYPEID := NVL(RCDAMAGE.FINAL_DAMAGE_TYPE_ID,
                             RCDAMAGE.REG_DAMAGE_TYPE_ID);
        
        IF (NUFAULTTYPEID = TT_BCCONSTANTS.CNUCONTROL_FAULT_TYPE) THEN
            ERRORS.SETERROR(CNUINVALID_PROC_ERROR,
                            'interrupciones controladas');
            RAISE EX.CONTROLLED_ERROR;
        END IF;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END VALFAULTTYPE;
    
    

















    PROCEDURE ABSORBPACKAGE
    (
        INUFAULTID      IN  TT_DAMAGE.PACKAGE_ID%TYPE,
        INUPACKTOABSORB IN  MO_PACKAGES.PACKAGE_ID%TYPE,
        ISBPROCESSID    IN  ESTAPROG.ESPRPROG%TYPE,
        ONUASSOID       OUT MO_PACKAGES_ASSO.PACKAGES_ASSO_ID%TYPE
    )
    IS
        RCMO_PACKAGES_ASSO DAMO_PACKAGES_ASSO.STYMO_PACKAGES_ASSO; 
    BEGIN
        
        IF (TT_BOORDER.LOCKORDERS(INUPACKTOABSORB,
                                  ISBPROCESSID)) THEN
            
            RCMO_PACKAGES_ASSO := MO_BCPACKAGES_ASSO.FRCPACKASSOBYPACKS(INUPACKTOABSORB,
                                                                        INUFAULTID);
            IF (RCMO_PACKAGES_ASSO.PACKAGES_ASSO_ID IS NULL) THEN
                RCMO_PACKAGES_ASSO.PACKAGES_ASSO_ID := MO_BOSEQUENCES.FNUGETSEQ_MO_PACKAGES_ASSO;
                RCMO_PACKAGES_ASSO.PACKAGE_ID       := INUPACKTOABSORB;
                RCMO_PACKAGES_ASSO.PACKAGE_ID_ASSO  := INUFAULTID;
                DAMO_PACKAGES_ASSO.INSRECORD(RCMO_PACKAGES_ASSO);
                
                IF (DATT_DAMAGE.FBLEXIST(INUPACKTOABSORB)) THEN
                    DATT_DAMAGE.UPDDAMAGE_ABSOR_DATE(INUPACKTOABSORB,
                                                     UT_DATE.FDTSYSDATE);
                END IF;
            END IF;
            ONUASSOID := RCMO_PACKAGES_ASSO.PACKAGES_ASSO_ID;
        END IF;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END ABSORBPACKAGE;
    
    




















    PROCEDURE DESORBPACKAGE
    (
        INUPACKTODESORB IN MO_PACKAGES.PACKAGE_ID%TYPE,
        INUASSOID       IN MO_PACKAGES_ASSO.PACKAGES_ASSO_ID%TYPE
    )
    IS
        NUINDEX   BINARY_INTEGER;                      
        TBORDERS  DAOR_ORDER_ACTIVITY.TYTBORDER_ID;    
        SBCOMMENT OR_ORDER_COMMENT.ORDER_COMMENT%TYPE; 
        
        RCSCHEDPROGRAMING       DAOR_SCHED_PROGRAMING.STYOR_SCHED_PROGRAMING; 
        RCNEWSCHEDPROGRAMING    DAOR_SCHED_PROGRAMING.STYOR_SCHED_PROGRAMING; 
        
        NUERRORCODE             GE_ERROR_LOG.ERROR_LOG_ID%TYPE;               
        SBERRORMSG              GE_ERROR_LOG.DESCRIPTION%TYPE;                
    BEGIN
        
        OR_BCORDERACTIVITIES.GETACTPENDBYPACKLOCK(INUPACKTODESORB,
                                                  TRUE,
                                                  TBORDERS);

        SBCOMMENT := GE_BOPARAMETER.FSBGET(TT_BCCONSTANTS.CSBCOMENT_DES_DANO_AUTO);
        NUINDEX := TBORDERS.FIRST;
        LOOP
            EXIT WHEN NUINDEX IS NULL;
            
            OR_BOLOCKORDER.UNLOCKORDERATTDAM(TBORDERS(NUINDEX),
                                             CNUCOMMENT_TYPE,
                                             SBCOMMENT);
                                             
            
            IF (OR_BCPROGRAMING.FBLGETLASTPROGBYORDER(TBORDERS(NUINDEX),
                                                      RCSCHEDPROGRAMING)) THEN
                
                UT_TRACE.TRACE('Encuentra Cita Previa',15);
                IF (OR_BOPROGRAMING.FBLVALIDATEFREESPACE(RCSCHEDPROGRAMING,
                                                         RCNEWSCHEDPROGRAMING)) THEN
                    BEGIN
                        UT_TRACE.TRACE('Reserva la Cita',15);
                        
                        OR_BOPROGRAMING.RESERVETIMEBLOCK(RCNEWSCHEDPROGRAMING.SCHED_PROGRAMING_ID,
                                                         RCSCHEDPROGRAMING.HOUR_START,
                                                         RCSCHEDPROGRAMING.DURATION,
                                                         RCSCHEDPROGRAMING.PROGRAMING_CLASS_ID,
                                                         RCSCHEDPROGRAMING.TASK_TYPE_ID,
                                                         RCSCHEDPROGRAMING.ORDER_ID,
                                                         RCSCHEDPROGRAMING.ADDRESS_ID,
                                                         RCSCHEDPROGRAMING.PACKAGE_ID,
                                                         RCSCHEDPROGRAMING.REAL_DURATION);
                        
                        IF (RCSCHEDPROGRAMING.CONFIRMED = OR_BOCONSTANTS.CSBSI) THEN
                            OR_BOPROGRAMING.CONFIRMARCITA(RCSCHEDPROGRAMING.ORDER_ID,
                                                          NULL,
                                                          NULL);
                        END IF;
                    EXCEPTION
                        WHEN EX.CONTROLLED_ERROR THEN
                            ERRORS.GETERROR(NUERRORCODE,
                                            SBERRORMSG);
                            UT_TRACE.TRACE('ERROR al Reservar Cita: '|| NUERRORCODE ||' - ' || SBERRORMSG ,15);
                        WHEN OTHERS THEN
                            ERRORS.SETERROR;
                            RAISE EX.CONTROLLED_ERROR;
                    END;
                END IF;
            END IF;
                                             
            NUINDEX := TBORDERS.NEXT(NUINDEX);
        END LOOP;
        
        IF (DAMO_PACKAGES_ASSO.FBLEXIST(INUASSOID)) THEN
            DAMO_PACKAGES_ASSO.DELRECORD(INUASSOID);
        END IF;
        
        IF (DATT_DAMAGE.FBLEXIST(INUPACKTODESORB)) THEN
            DATT_DAMAGE.UPDDAMAGE_ABSOR_DATE(INUPACKTODESORB,
                                             NULL);
        END IF;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END DESORBPACKAGE;
    
    















    PROCEDURE UPDFAULTPRIORITY
    (
        INUFAULTID   IN TT_DAMAGE.PACKAGE_ID%TYPE,
        ISBPROCESSID IN ESTAPROG.ESPRPROG%TYPE
    )
    IS
        RCDAMAGE         DATT_DAMAGE.STYTT_DAMAGE;         
        RCNODE           DAIF_NODE.STYIF_NODE;             
        NUELEMENTTYPEID  IF_NODE.ELEMENT_TYPE_ID%TYPE;     
        NUELEMENTCLASSID IF_NODE.CLASS_ID%TYPE;            
        NULESSPRIORITY   GE_PRIORITY_CONFIG.PRIORITY%TYPE; 
    BEGIN
        
        DATT_DAMAGE.GETRECORD(INUFAULTID,
                              RCDAMAGE);
        
        RCDAMAGE.PRODUCTS_DAMAGED := TT_BCPRODUCT.FNUOBTENERTOTALPRODUCTOS(INUFAULTID);
        
        IF (RCDAMAGE.ELEMENT_ID IS NOT NULL) THEN
            DAIF_NODE.GETRECORD(RCDAMAGE.ELEMENT_ID,
                                RCNODE);
            NUELEMENTTYPEID  := RCNODE.ELEMENT_TYPE_ID;
            NUELEMENTCLASSID := RCNODE.CLASS_ID;
        END IF;
        
        NULESSPRIORITY := GE_BOPRIORITY.FNUGETDAMPRIORBYELEM(RCDAMAGE.ELEMENT_ID,
                                                             NUELEMENTTYPEID,
                                                             NUELEMENTCLASSID,
                                                             RCDAMAGE.PRODUCTS_DAMAGED,
                                                             NVL(RCDAMAGE.FINAL_DAMAGE_TYPE_ID,
                                                                 RCDAMAGE.REG_DAMAGE_TYPE_ID));
        
        RCDAMAGE.PRIORITY := NULESSPRIORITY;
        DATT_DAMAGE.UPDRECORD(RCDAMAGE);
        
        GE_BOPRIORITY.UPDPRIORITYDAMAGEORDERS(INUFAULTID,
                                              NULESSPRIORITY,
                                              ISBPROCESSID);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END UPDFAULTPRIORITY;

    
















    PROCEDURE LOCKTT_DAMAGE
    (
        INUFAULTID IN TT_DAMAGE.PACKAGE_ID%TYPE
    )
    IS
    BEGIN
        
        IF (NOT (UT_LOCK.FBLLOCKAT(TT_BCCONSTANTS.CSBTT_DAMAGE_BLOCK_TAG||INUFAULTID))) THEN
            ERRORS.SETERROR(CNUFAULT_IN_USE_ERROR,
                            INUFAULTID);
            RAISE EX.CONTROLLED_ERROR;
        END IF;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END LOCKTT_DAMAGE;
    
    















    PROCEDURE UNLOCKTT_DAMAGE
    (
        INUFAULTID IN TT_DAMAGE.PACKAGE_ID%TYPE
    )
    IS
    BEGIN
        
        UT_LOCK.UNLOCKAT(TT_BCCONSTANTS.CSBTT_DAMAGE_BLOCK_TAG||INUFAULTID);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END UNLOCKTT_DAMAGE;
    
    


















    PROCEDURE VALISINFRASTRUCTURE
    (
        INUFAULTID IN TT_DAMAGE.PACKAGE_ID%TYPE
    )
    IS
        NUPACKAGETYPEID     MO_PACKAGES.PACKAGE_TYPE_ID%TYPE; 
    BEGIN
        UT_TRACE.TRACE('TT_BOFault.valIsInfraestructure. <INICIO>',6);
        
        NUPACKAGETYPEID := DAMO_PACKAGES.FNUGETPACKAGE_TYPE_ID(INUFAULTID);
        UT_TRACE.TRACE('--> inuFaultId: ['||INUFAULTID    ||'] '
                 || '--> nuPackageTypeId: ['||NUPACKAGETYPEID ||'] ', 7);
        
        IF (NUPACKAGETYPEID != TT_BCCONSTANTS.CNUMASSDAMAGE ) THEN
            
            ERRORS.SETERROR(CNUINVALID_PROC_ERROR,
                            'fallas que no sean de infraestructura');
            RAISE EX.CONTROLLED_ERROR;
        END IF;

        UT_TRACE.TRACE('TT_BOFault.valIsInfraestructure. <FIN>',6);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END VALISINFRASTRUCTURE;

    
















    PROCEDURE UNLOCKFAULT
    (
        INUFAULTID IN TT_DAMAGE.PACKAGE_ID%TYPE,
        IBLLOCKED  IN BOOLEAN
    )
    IS
    BEGIN
        IF (IBLLOCKED) THEN
            TT_BOFAULT.UNLOCKTT_DAMAGE(INUFAULTID);
        END IF;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END UNLOCKFAULT;

    















    PROCEDURE ATTENDFAULTPROC
    (
        INUFAULTID     IN TT_DAMAGE.PACKAGE_ID%TYPE,
        IBLTOTALATTEND IN BOOLEAN
    )
    IS
        SBEJECUTAR  VARCHAR(2000);      
        NUJOBID     USER_JOBS.JOB%TYPE; 
    BEGIN
        UT_TRACE.TRACE('Inicia TT_BOFault.AttendFaultProc',15);

        
        DATT_DAMAGE.UPDREG_DAMAGE_STATUS(INUFAULTID,
                                         TT_BCCONSTANTS.CSBPROCESSINGDAMAGESTATUS);

        SBEJECUTAR :=   ' DECLARE'||CHR(10)||
                        '    nuError     NUMBER;'||CHR(10)||
                        '    sbError     VARCHAR2(2000);'||CHR(10)||
                        ' BEGIN'||CHR(10)||
                        ' '||TT_BCCONSTANTS.CSBATT_FAULT_TAG||CHR(10)||
                        ' ('||CHR(10)||
                        INUFAULTID||','||CHR(10);

        IF (IBLTOTALATTEND) THEN
            SBEJECUTAR := SBEJECUTAR || 'TRUE'||CHR(10);
        ELSE
            SBEJECUTAR := SBEJECUTAR || 'FALSE'||CHR(10);
        END IF;

        SBEJECUTAR := SBEJECUTAR || ' );'||CHR(10)||
                    '    EXCEPTION'||CHR(10)||
                    '        when ex.CONTROLLED_ERROR THEN'||CHR(10)||
                    '            raise ex.CONTROLLED_ERROR;'||CHR(10)||
                    '        when others THEN'||CHR(10)||
                    '            Errors.setError;'||CHR(10)||
                    '            raise ex.CONTROLLED_ERROR;'||CHR(10)||
                    ' END;';

        UT_TRACE.TRACE('Ejecuta ['||SBEJECUTAR||']',15);

        PKBIUT_JOBMGR.CREATEJOBVALIDATEWHATDATE
        (
                SBEJECUTAR,
                SYSDATE,
                NULL,
                NUJOBID
        );
        UT_TRACE.TRACE('nujobId ['||NUJOBID||']',15);

        UT_TRACE.TRACE('Finaliza TT_BOFault.AttendFaultProc',15);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('=>CONTROLLED_ERROR TT_BOFault.AttendFaultProc', 15);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            UT_TRACE.TRACE('=>OTHERS_ERROR TT_BOFault.AttendFaultProc', 15);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END ATTENDFAULTPROC;

    



















    PROCEDURE MARKELEMENTUPDATE
    (
        INUFAULTID         IN TT_DAMAGE.PACKAGE_ID%TYPE,
        INUELEMENTID       IN TT_DAMAGE.ELEMENT_ID%TYPE,
        INUDAMAGEELEMENTID IN TT_DAMAGE_ELEMENT.DAMAGE_ELEMENT_ID%TYPE,
        ISBREPAIRED        IN TT_DAMAGE_ELEMENT.REPAIRED%TYPE
    )
    IS
        TBDAMAGEELEMENTS     DATT_DAMAGE_ELEMENT.TYTBTT_DAMAGE_ELEMENT; 
        NUINDEX              BINARY_INTEGER;                            
        RCDAMAGE_ELEMENT     DATT_DAMAGE_ELEMENT.STYTT_DAMAGE_ELEMENT;  
        RCDAMAGE_ELEMENTNULL DATT_DAMAGE_ELEMENT.STYTT_DAMAGE_ELEMENT;  
    BEGIN
        
        DATT_DAMAGE_ELEMENT.UPDDAMAGE_ELEME_STATUS(INUDAMAGEELEMENTID,
                                                   TT_BCCONSTANTS.CSBUPDATEDDAMAGESTATUS);
        
        IF (ISBREPAIRED = TT_BCCONSTANTS.CSBPARTIAL_REPAIR) THEN
            
            TT_BCELEMENT.GETCHILDELEMENTS(INUFAULTID,
                                          INUELEMENTID,
                                          TBDAMAGEELEMENTS);
            NUINDEX := TBDAMAGEELEMENTS.FIRST;
            LOOP
                EXIT WHEN NUINDEX IS NULL;
                RCDAMAGE_ELEMENT := RCDAMAGE_ELEMENTNULL;
                RCDAMAGE_ELEMENT := TBDAMAGEELEMENTS(NUINDEX);
                
                DATT_DAMAGE_ELEMENT.UPDDAMAGE_ELEME_STATUS(RCDAMAGE_ELEMENT.DAMAGE_ELEMENT_ID,
                                                           TT_BCCONSTANTS.CSBUPDATEDDAMAGESTATUS);
                NUINDEX := TBDAMAGEELEMENTS.NEXT(NUINDEX);
            END LOOP;
        END IF;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END MARKELEMENTUPDATE;

    















































    PROCEDURE UPDATEFAULTPROCESS
    (
        INUFAULTID       IN            TT_DAMAGE.PACKAGE_ID%TYPE,
        IDTINITIALDATE   IN            TT_DAMAGE.INITIAL_DATE%TYPE,
        IDTESTATTENTDATE IN            TT_DAMAGE.ESTIMAT_ATTENT_DATE%TYPE,
        INUFAULTTYPEID   IN            TT_DAMAGE_TYPE.DAMAGE_TYPE_ID%TYPE,
        INUELEMENTID     IN            TT_DAMAGE.ELEMENT_ID%TYPE,
        INUINITASSIGID   IN            IF_ASSIGNABLE.ID%TYPE,
        INUFINALASSIGID  IN            IF_ASSIGNABLE.ID%TYPE,
        IBLATTENDING     IN            BOOLEAN,
        IBLTOTALATTEND   IN            BOOLEAN,
        IORCDAMAGE       IN OUT NOCOPY DATT_DAMAGE.STYTT_DAMAGE
    )
    IS
        NUADDRESSID          AB_ADDRESS.ADDRESS_ID%TYPE;          
        RCAB_ADDRESS         DAAB_ADDRESS.STYAB_ADDRESS;          
        RCMO_ADDRESS         DAMO_ADDRESS.STYMO_ADDRESS;          
        NUOLDFAULTTYPE       TT_DAMAGE.FINAL_DAMAGE_TYPE_ID%TYPE; 
        NUOLDELEMENTID       TT_DAMAGE.ELEMENT_ID%TYPE;           
        BLLOCKED             BOOLEAN;                             
        BLCALLUPDATEJOB      BOOLEAN;                             
        BLVALFATHERELEM      BOOLEAN;                             
        BLUPDATEADDRESS      BOOLEAN;                             

        NUINITASSIGID        IF_ASSIGNABLE.ID%TYPE := INUINITASSIGID;   
        NUFINALASSIGID       IF_ASSIGNABLE.ID%TYPE := INUFINALASSIGID;  
        TBDAMAGEELEMENTS     DATT_DAMAGE_ELEMENT.TYTBTT_DAMAGE_ELEMENT; 
        NUINDEX              BINARY_INTEGER;                            
        RCDAMAGE_ELEMENT     DATT_DAMAGE_ELEMENT.STYTT_DAMAGE_ELEMENT;  
        RCDAMAGE_ELEMENTNULL DATT_DAMAGE_ELEMENT.STYTT_DAMAGE_ELEMENT;  
        
        NUPERSONID           GE_PERSON.PERSON_ID%TYPE;                  
        
        NUDAMAGECAUSALID     TT_DAMAGE.DAMAGE_CAUSAL_ID%TYPE;           
    BEGIN
        
        IF (IDTINITIALDATE > UT_DATE.FDTSYSDATE) THEN
            
            ERRORS.SETERROR(CNUINIT_DATE_ERROR);
            RAISE EX.CONTROLLED_ERROR;
        END IF;
        IF (IDTESTATTENTDATE IS NOT NULL) THEN
            IF (IDTESTATTENTDATE < IDTINITIALDATE) THEN
                
                ERRORS.SETERROR(CNUEST_ATT_DATE_ERROR);
                RAISE EX.CONTROLLED_ERROR;
            END IF;
        END IF;
    
        
        IF (    (IORCDAMAGE.ELEMENT_ID IS NOT NULL)
            AND (INUELEMENTID IS NULL)) THEN
            ERRORS.SETERROR(CNUNULL_ATT_ERROR,
                            'C�digo del Elemento');
            RAISE EX.CONTROLLED_ERROR;
        END IF;

        
        NUOLDFAULTTYPE := NVL(IORCDAMAGE.FINAL_DAMAGE_TYPE_ID,
                              IORCDAMAGE.REG_DAMAGE_TYPE_ID);

        
        NUOLDELEMENTID := IORCDAMAGE.ELEMENT_ID;
        
        
        IF (IBLATTENDING) THEN
            NUDAMAGECAUSALID := DATT_DAMAGE.FNUGETDAMAGE_CAUSAL_ID(INUFAULTID);
        ELSE
            NUDAMAGECAUSALID := IORCDAMAGE.DAMAGE_CAUSAL_ID;
        END IF;

        
        BLCALLUPDATEJOB := FALSE;
        BLVALFATHERELEM := FALSE;
        BLUPDATEADDRESS := FALSE;
        
        IF (NUOLDFAULTTYPE <> INUFAULTTYPEID) THEN
            
            IF (NUDAMAGECAUSALID IS NOT NULL) THEN
                ERRORS.SETERROR(CNUFAULTTYPE_CHAN_ERROR);
                RAISE EX.CONTROLLED_ERROR;
            END IF;
            BLCALLUPDATEJOB := TRUE;
            BLVALFATHERELEM := TRUE;
        END IF;
        
        IF (NVL(IORCDAMAGE.INITIAL_DATE,
                TT_BCBASICDATASERVICES.FDTINITIALDATE(INUFAULTID)) <> IDTINITIALDATE) THEN
            
            IF (NOT (IBLATTENDING)) THEN
                
                IF (NUDAMAGECAUSALID IS NOT NULL) THEN
                    ERRORS.SETERROR(CNUINITDATE_CHAN_ERROR);
                    RAISE EX.CONTROLLED_ERROR;
                END IF;
            END IF;
            BLCALLUPDATEJOB := TRUE;
        END IF;
        
        IF (NUOLDELEMENTID IS NULL) THEN
            
            IF (INUELEMENTID IS NOT NULL) THEN
                
                IF (NUDAMAGECAUSALID IS NOT NULL) THEN
                    ERRORS.SETERROR(CNUELEMENT_CHANGE_ERROR);
                    RAISE EX.CONTROLLED_ERROR;
                END IF;

                
                TT_BOELEMENT.VALIDATEELEMENT(INUFAULTTYPEID,
                                             INUELEMENTID);
                
                TT_BOELEMENT.VALIDATEELEMTYPEDAMATYPE(DAIF_NODE.FNUGETELEMENT_TYPE_ID(INUELEMENTID),
                                                      INUFAULTTYPEID);

                BLCALLUPDATEJOB := TRUE;
                BLUPDATEADDRESS := TRUE;
            END IF;
        ELSE
            
            
            IF (NUOLDELEMENTID <> INUELEMENTID) THEN
               
               IF (NUDAMAGECAUSALID IS NOT NULL) THEN
                    ERRORS.SETERROR(CNUELEMENT_CHANGE_ERROR);
                    RAISE EX.CONTROLLED_ERROR;
                END IF;

                BLCALLUPDATEJOB := TRUE;
                BLVALFATHERELEM := TRUE;
                BLUPDATEADDRESS := TRUE;
            ELSE
                
                IF (INUINITASSIGID IS NOT NULL) THEN
                    IF (NUDAMAGECAUSALID IS NOT NULL) THEN
                        ERRORS.SETERROR(CNUELEMENT_CHANGE_ERROR);
                        RAISE EX.CONTROLLED_ERROR;
                    END IF;
                    
                    BLCALLUPDATEJOB := TRUE;
                END IF;
            END IF;
            
            IF (BLVALFATHERELEM) THEN
                
                TT_BOELEMENT.VALFATHERELEMENTS(INUFAULTID,
                                               INUFAULTTYPEID,
                                               NUOLDELEMENTID,
                                               INUELEMENTID);
            END IF;
        END IF;

        
        IF (BLUPDATEADDRESS) THEN
            
            NUADDRESSID := DAIF_NODE.FNUGETADDRESS_ID(INUELEMENTID);
            
            IF (NUADDRESSID IS NULL) THEN
                ERRORS.SETERROR(CNUNO_ELEM_ADDR_ERROR);
                RAISE EX.CONTROLLED_ERROR;
            END IF;
            
            IF (MO_BOADDRESS.FNUGETPARSERADDRIDBYPACK(INUFAULTID) IS NOT NULL) THEN
                MO_BOADDRESS.CHANGEADDRESSORPREMISEDATA(INUFAULTID,
                                                        NUADDRESSID);
            ELSE
                
                UT_TRACE.TRACE('La Direccion no existe en Mo_packages ['||NUADDRESSID||']',4);
                RCAB_ADDRESS := DAAB_ADDRESS.FRCGETRECORD(NUADDRESSID);

                RCMO_ADDRESS.ADDRESS             := RCAB_ADDRESS.ADDRESS;
                RCMO_ADDRESS.ADDRESS_ID          := MO_BOSEQUENCES.FNUGETADDRESSID;
                RCMO_ADDRESS.ADDRESS_TYPE_ID     := MO_BOADDRESS.CNUADDRESSTYPEMAIN;
                RCMO_ADDRESS.GEOGRAP_LOCATION_ID := RCAB_ADDRESS.GEOGRAP_LOCATION_ID;
                RCMO_ADDRESS.IS_ADDRESS_MAIN     := RCAB_ADDRESS.IS_MAIN;
                RCMO_ADDRESS.PACKAGE_ID          := INUFAULTID;
                RCMO_ADDRESS.PARSER_ADDRESS_ID   := RCAB_ADDRESS.ADDRESS_ID;
                DAMO_ADDRESS.INSRECORD(RCMO_ADDRESS);
            END IF;
            




        END IF;

        
        IORCDAMAGE.ELEMENT_ID := INUELEMENTID;

        
        IORCDAMAGE.FINAL_DAMAGE_TYPE_ID := INUFAULTTYPEID;

        
        
        IF (DATT_DAMAGE_TYPE.FSBGETTIME_OUT(INUFAULTTYPEID) = GE_BOCONSTANTS.CSBYES) THEN
            IORCDAMAGE.APPROVAL := TT_BCCONSTANTS.CSBCOMP_PENDING;
        ELSE
            IORCDAMAGE.APPROVAL := TT_BCCONSTANTS.CSBCOMP_NOT_APPLICAB;
        END IF;

        
        IORCDAMAGE.INITIAL_DATE := IDTINITIALDATE;
        
        IORCDAMAGE.ESTIMAT_ATTENT_DATE := IDTESTATTENTDATE;

        
        DATT_DAMAGE.UPDRECORD(IORCDAMAGE);

        
        IF (BLCALLUPDATEJOB) THEN
            
            IF (INUELEMENTID IS NOT NULL) THEN
                
                
                IF (    (NUOLDELEMENTID = INUELEMENTID)
                    AND (INUINITASSIGID IS NULL)
                    AND (INUFINALASSIGID IS NULL)) THEN
                    TT_BCELEMENT.GETDAMAELEMBYPACKELEM(INUFAULTID,
                                                       INUELEMENTID,
                                                       RCDAMAGE_ELEMENT);
                    
                    MARKELEMENTUPDATE(INUFAULTID,
                                      INUELEMENTID,
                                      RCDAMAGE_ELEMENT.DAMAGE_ELEMENT_ID,
                                      RCDAMAGE_ELEMENT.REPAIRED);
                ELSE
                    
                    TT_BOFAULT.UNLOCKTT_DAMAGE(INUFAULTID);
                    BLLOCKED := FALSE;

                    
                    IF (IBLATTENDING) THEN
                        NUPERSONID := IORCDAMAGE.ATENTION_PERSON_ID;
                    ELSE
                        NUPERSONID := GE_BOPERSONAL.FNUGETPERSONID;
                    END IF;

                    
                    
                    IF (NUOLDELEMENTID IS NOT NULL) THEN
                        
                        
                        IF (GE_BOPARAMETER.FSBGET(TT_BCCONSTANTS.CSBELEM_TECH_STATUS) = GE_BOCONSTANTS.CSBYES) THEN
                            TT_BOELEMENT.REPAIRELEMENT(INUFAULTID,
                                                       NUOLDELEMENTID);
                        END IF;
                    END IF;

                    
                    
                    TT_BOELEMENT.ADDELEMENTTOFAULT(INUFAULTID,    
                                                   INUELEMENTID,  
                                                   NUINITASSIGID, 
                                                   NUFINALASSIGID,
                                                   NUPERSONID,    
                                                   TRUE);         

                    
                    TT_BOFAULT.LOCKTT_DAMAGE(INUFAULTID);
                    BLLOCKED := TRUE;
                END IF;

                
                IF (NUOLDELEMENTID = INUELEMENTID) THEN
                    
                    TT_BCELEMENT.GETFATHERELEMENTS(INUFAULTID,
                                                   TBDAMAGEELEMENTS);
                    NUINDEX := TBDAMAGEELEMENTS.FIRST;
                    LOOP
                        EXIT WHEN NUINDEX IS NULL;
                        RCDAMAGE_ELEMENT := RCDAMAGE_ELEMENTNULL;
                        RCDAMAGE_ELEMENT := TBDAMAGEELEMENTS(NUINDEX);
                        IF (RCDAMAGE_ELEMENT.ELEMENT_ID <> NUOLDELEMENTID) THEN
                            
                            MARKELEMENTUPDATE(INUFAULTID,
                                              RCDAMAGE_ELEMENT.ELEMENT_ID,
                                              RCDAMAGE_ELEMENT.DAMAGE_ELEMENT_ID,
                                              RCDAMAGE_ELEMENT.REPAIRED);
                        END IF;
                        NUINDEX := TBDAMAGEELEMENTS.NEXT(NUINDEX);
                    END LOOP;
                END IF;
                
                TT_BOELEMENT.UPDATEFAULT(INUFAULTID,     
                                         IBLATTENDING,   
                                         IBLTOTALATTEND);
            ELSE
                
                TT_BOPRODUCT.UPDATEFAULT(INUFAULTID,     
                                         IBLATTENDING,   
                                         IBLTOTALATTEND);
            END IF;
        ELSE
            IF (IBLATTENDING) THEN
                
                ATTENDFAULTPROC(INUFAULTID,     
                                IBLTOTALATTEND);
            END IF;
        END IF;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UNLOCKFAULT(INUFAULTID,
                        BLLOCKED);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            UNLOCKFAULT(INUFAULTID,
                        BLLOCKED);
            RAISE EX.CONTROLLED_ERROR;
    END UPDATEFAULTPROCESS;

    




















    PROCEDURE UPDATEFAULT
    (
        INUFAULTID       IN TT_DAMAGE.PACKAGE_ID%TYPE,
        IDTINITIALDATE   IN TT_DAMAGE.INITIAL_DATE%TYPE,
        IDTESTATTENTDATE IN TT_DAMAGE.ESTIMAT_ATTENT_DATE%TYPE,
        INUFAULTTYPEID   IN TT_DAMAGE_TYPE.DAMAGE_TYPE_ID%TYPE,
        INUELEMENTID     IN TT_DAMAGE.ELEMENT_ID%TYPE,
        INUINITASSIGID   IN IF_ASSIGNABLE.ID%TYPE,
        INUFINALASSIGID  IN IF_ASSIGNABLE.ID%TYPE
    )
    IS
        RCDAMAGE             DATT_DAMAGE.STYTT_DAMAGE;            
        BLLOCKED             BOOLEAN;                             
    BEGIN
        
        TT_BOFAULT.LOCKTT_DAMAGE(INUFAULTID);
        BLLOCKED := TRUE;

        
        DATT_DAMAGE.GETRECORD(INUFAULTID,
                              RCDAMAGE);

        
        UPDATEFAULTPROCESS(INUFAULTID,      
                           IDTINITIALDATE,  
                           IDTESTATTENTDATE,
                           INUFAULTTYPEID,  
                           INUELEMENTID,    
                           INUINITASSIGID,  
                           INUFINALASSIGID, 
                           FALSE,           
                           FALSE,           
                           RCDAMAGE);       

        
        TT_BOFAULT.UNLOCKTT_DAMAGE(INUFAULTID);
        BLLOCKED := FALSE;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UNLOCKFAULT(INUFAULTID,
                        BLLOCKED);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            UNLOCKFAULT(INUFAULTID,
                        BLLOCKED);
            RAISE EX.CONTROLLED_ERROR;
    END UPDATEFAULT;
    
    






















    PROCEDURE VALATTENDFAULT
    (
        INUFAULTID        IN TT_DAMAGE.PACKAGE_ID%TYPE,
        INUFAULTTYPEID    IN TT_DAMAGE.FINAL_DAMAGE_TYPE_ID%TYPE,
        IDTINITIALDATE    IN TT_DAMAGE.INITIAL_DATE%TYPE,
        IDTENDDATE        IN TT_DAMAGE.END_DATE%TYPE,
        INUCLOSURECAUSEID IN TT_DAMAGE.DAMAGE_CAUSAL_ID%TYPE
    )
    IS
        NUCLASSCAUSALID  GE_CLASS_CAUSAL.CLASS_CAUSAL_ID%TYPE; 
        DTMINENDDATE     TT_DAMAGE.END_DATE%TYPE;              
        NUDAMAGECAUSALID TT_DAMAGE.DAMAGE_CAUSAL_ID%TYPE;      
    BEGIN
        
        IF (INUFAULTTYPEID IS NULL) THEN
            ERRORS.SETERROR(CNUREQ_FIELD_ERROR,
                            'Tipo de Falla');
            RAISE EX.CONTROLLED_ERROR;
        END IF;
        IF (IDTINITIALDATE IS NULL) THEN
            ERRORS.SETERROR(CNUREQ_FIELD_ERROR,
                            'Fecha de Inicio de Afectaci�n');
            RAISE EX.CONTROLLED_ERROR;
        END IF;
        IF (IDTENDDATE IS NULL) THEN
            ERRORS.SETERROR(CNUREQ_FIELD_ERROR,
                            'Fecha de Fin de Afectaci�n');
            RAISE EX.CONTROLLED_ERROR;
        END IF;
        IF (INUCLOSURECAUSEID IS NULL) THEN
            ERRORS.SETERROR(CNUREQ_FIELD_ERROR,
                            'Causa de Cierre');
            RAISE EX.CONTROLLED_ERROR;
        END IF;
        
        DATT_DAMAGE_TYPE.ACCKEY(INUFAULTTYPEID);
        
        IF (INUFAULTTYPEID = TT_BCCONSTANTS.CNUCONTROL_FAULT_TYPE) THEN
            ERRORS.SETERROR(CNUINV_VALUE_ERROR,
                            'Tipo de Falla');
            RAISE EX.CONTROLLED_ERROR;
        END IF;

        
        NUDAMAGECAUSALID := DATT_DAMAGE.FNUGETDAMAGE_CAUSAL_ID(INUFAULTID);
        IF (NUDAMAGECAUSALID IS NOT NULL) THEN
            IF (NUDAMAGECAUSALID <> INUCLOSURECAUSEID) THEN
                ERRORS.SETERROR(CNUCAUSAL_UPD_ERROR);
                RAISE EX.CONTROLLED_ERROR;
            END IF;
        END IF;

        
        
        IF (INUCLOSURECAUSEID <> OR_BOCONSTANTS.CNUSUCCESCAUSAL) THEN
            
            NUCLASSCAUSALID := DAGE_CAUSAL.FNUGETCLASS_CAUSAL_ID(INUCLOSURECAUSEID);
            IF (NUCLASSCAUSALID NOT IN (TT_BCCONSTANTS.CNUATTEND_CLASS_CAUSA,
                                        TT_BCCONSTANTS.CNUBASELESS_CLASS_CAU)) THEN
                ERRORS.SETERROR(CNUCLOS_CAUSE_ERROR);
                RAISE EX.CONTROLLED_ERROR;
            END IF;
        END IF;

        
        IF (IDTINITIALDATE > UT_DATE.FDTSYSDATE) THEN
            
            ERRORS.SETERROR(CNUINIT_DATE_ERROR);
            RAISE EX.CONTROLLED_ERROR;
        END IF;
        
        IF (IDTENDDATE > UT_DATE.FDTSYSDATE) THEN
            ERRORS.SETERROR(CNUATTENTION_DATE_ERROR);
            RAISE EX.CONTROLLED_ERROR;
        END IF;
        
        TT_BCBASICDATASERVICES.GETMINENDDATE(INUFAULTID,
                                             DTMINENDDATE);
        IF (DTMINENDDATE > IDTENDDATE) THEN
            ERRORS.SETERROR(CNUMIN_END_DATE_ERROR);
            RAISE EX.CONTROLLED_ERROR;
        END IF;
        
        IF (IDTENDDATE <= IDTINITIALDATE) THEN
            ERRORS.SETERROR(CNUEQUAL_DATES_ERROR);
            RAISE EX.CONTROLLED_ERROR;
        END IF;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END VALATTENDFAULT;
    
    




















	PROCEDURE SETELEMENT
    (
        INUFAULTID      IN TT_DAMAGE.PACKAGE_ID%TYPE,
        INUELEMENTID    IN IF_NODE.ID%TYPE,
        INUINITASSIGID  IN IF_ASSIGNABLE.ID%TYPE,
        INUFINALASSIGID IN IF_ASSIGNABLE.ID%TYPE,
        IBLVALIDATE     IN BOOLEAN DEFAULT TRUE
    )
    IS
        NUINITASSIGID  IF_ASSIGNABLE.ID%TYPE; 
        NUFINALASSIGID IF_ASSIGNABLE.ID%TYPE; 
    BEGIN
        
        TT_BOELEMENT.VALATTENDELEMENT(INUFAULTID,
                                      INUELEMENTID,
                                      INUINITASSIGID,
                                      INUFINALASSIGID);
        IF (IBLVALIDATE) THEN
            
            TT_BCELEMENT.GETASSIGRANGE(INUFAULTID,
                                       INUELEMENTID,
                                       NUINITASSIGID,
                                       NUFINALASSIGID);

            GTBELEMENTS(INUELEMENTID).NUELEMENTID := INUELEMENTID;
            
            
            IF (    (NUINITASSIGID = INUINITASSIGID)
                AND (NUFINALASSIGID = INUFINALASSIGID)) THEN
                GTBELEMENTS(INUELEMENTID).NUINITASSIGID  := NULL;
                GTBELEMENTS(INUELEMENTID).NUFINALASSIGID := NULL;
            ELSE
                GTBELEMENTS(INUELEMENTID).NUINITASSIGID  := INUINITASSIGID;
                GTBELEMENTS(INUELEMENTID).NUFINALASSIGID := INUFINALASSIGID;
            END IF;
        ELSE
            GTBELEMENTS(INUELEMENTID).NUELEMENTID    := INUELEMENTID;
            GTBELEMENTS(INUELEMENTID).NUINITASSIGID  := INUINITASSIGID;
            GTBELEMENTS(INUELEMENTID).NUFINALASSIGID := INUFINALASSIGID;
        END IF;
    EXCEPTION
		WHEN EX.CONTROLLED_ERROR THEN
			RAISE EX.CONTROLLED_ERROR;
		WHEN OTHERS THEN
			ERRORS.SETERROR;
			RAISE EX.CONTROLLED_ERROR;
    END SETELEMENT;

    

















	PROCEDURE SETPRODUCT
    (
        INUFAULTID   IN TT_DAMAGE.PACKAGE_ID%TYPE,
        INUPRODUCTID IN PR_PRODUCT.PRODUCT_ID%TYPE,
        IBLVALIDATE  IN BOOLEAN DEFAULT TRUE
    )
    IS
    BEGIN
        IF (IBLVALIDATE) THEN
            
            TT_BOPRODUCT.VALATTENDPRODUCT(INUFAULTID,
                                          INUPRODUCTID);
        END IF;
        GTBPRODUCTS(INUPRODUCTID) := INUPRODUCTID;
    EXCEPTION
		WHEN EX.CONTROLLED_ERROR THEN
			RAISE EX.CONTROLLED_ERROR;
		WHEN OTHERS THEN
			ERRORS.SETERROR;
			RAISE EX.CONTROLLED_ERROR;
    END SETPRODUCT;

    












    PROCEDURE DELETETABLES
    IS
    BEGIN
        GTBELEMENTS.DELETE;
        GTBPRODUCTS.DELETE;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END DELETETABLES;

    


























    PROCEDURE ATTENDFAULT
    (
        INUFAULTID        IN TT_DAMAGE.PACKAGE_ID%TYPE,
        INUFAULTTYPEID    IN TT_DAMAGE.FINAL_DAMAGE_TYPE_ID%TYPE,
        IDTINITIALDATE    IN TT_DAMAGE.INITIAL_DATE%TYPE,
        IDTENDDATE        IN TT_DAMAGE.END_DATE%TYPE,
        INUCLOSURECAUSEID IN TT_DAMAGE.DAMAGE_CAUSAL_ID%TYPE,
        ISBORDERSTOANNUL  IN VARCHAR2,
        INUPERSONID       IN GE_PERSON.PERSON_ID%TYPE
    )
    IS
        BLHASERROR       BOOLEAN;                              
        NUORDERID        OR_ORDER.ORDER_ID%TYPE;               
        BLLOCKED         BOOLEAN;                              
        RCDAMAGE         DATT_DAMAGE.STYTT_DAMAGE;             
        
        BLTOTALATTEND    BOOLEAN;                              
        
        NUCLASSCAUSALID  GE_CAUSAL.CLASS_CAUSAL_ID%TYPE;       
        
        NUINDEX          BINARY_INTEGER;                       
        RCELEMENT        TT_BOELEMENT.TYRCELEMENT;             
        
        TBDAMAGEELEMENTS     DATT_DAMAGE_ELEMENT.TYTBTT_DAMAGE_ELEMENT; 
        RCDAMAGE_ELEMENT     DATT_DAMAGE_ELEMENT.STYTT_DAMAGE_ELEMENT;  
        RCDAMAGE_ELEMENTNULL DATT_DAMAGE_ELEMENT.STYTT_DAMAGE_ELEMENT;  

        












        FUNCTION FBLISTOTALATTEND
        RETURN BOOLEAN
        IS
            NUDAMAGESINDEX  BINARY_INTEGER;                            
            TBDAMAGEPRODUCT DATT_DAMAGE_PRODUCT.TYTBTT_DAMAGE_PRODUCT; 
        BEGIN
            IF (    (GTBELEMENTS.COUNT = 0)
                AND (GTBPRODUCTS.COUNT = 0)) THEN
                RETURN TRUE;
            END IF;
            
            
            IF (RCDAMAGE.ELEMENT_ID IS NOT NULL) THEN
                
                TT_BCELEMENT.GETFATHERELEMENTS(INUFAULTID,
                                               TBDAMAGEELEMENTS);

                NUINDEX := TBDAMAGEELEMENTS.FIRST;
                LOOP
                    EXIT WHEN NUINDEX IS NULL;
                    RCDAMAGE_ELEMENT := RCDAMAGE_ELEMENTNULL;
                    RCDAMAGE_ELEMENT := TBDAMAGEELEMENTS(NUINDEX);

                    IF (GTBELEMENTS.EXISTS(RCDAMAGE_ELEMENT.ELEMENT_ID)) THEN
                        
                        IF (GTBELEMENTS(RCDAMAGE_ELEMENT.ELEMENT_ID).NUINITASSIGID IS NOT NULL) THEN
                            RETURN FALSE;
                        END IF;
                    ELSE
                        
                        RETURN FALSE;
                    END IF;

                    NUINDEX := TBDAMAGEELEMENTS.NEXT(NUINDEX);
                END LOOP;
            ELSE
                
                IF (TT_BCPRODUCT.CUOPENDAMPRDBYPACK%ISOPEN) THEN
                    CLOSE TT_BCPRODUCT.CUOPENDAMPRDBYPACK;
                END IF;

                
                OPEN TT_BCPRODUCT.CUOPENDAMPRDBYPACK(INUFAULTID);

                LOOP
                    TBDAMAGEPRODUCT.DELETE;
                    FETCH TT_BCPRODUCT.CUOPENDAMPRDBYPACK BULK COLLECT INTO TBDAMAGEPRODUCT
                                                          LIMIT 100;
                    NUDAMAGESINDEX := TBDAMAGEPRODUCT.FIRST;
                    EXIT WHEN NUDAMAGESINDEX IS NULL;
                    LOOP
                        EXIT WHEN NUDAMAGESINDEX IS NULL;

                        IF (NOT (GTBPRODUCTS.EXISTS(TBDAMAGEPRODUCT(NUDAMAGESINDEX).PRODUCT_ID))) THEN
                            
                            RETURN FALSE;
                        END IF;

                        NUDAMAGESINDEX := TBDAMAGEPRODUCT.NEXT(NUDAMAGESINDEX);
                    END LOOP;
                    COMMIT;
                END LOOP;

                CLOSE TT_BCPRODUCT.CUOPENDAMPRDBYPACK;
            END IF;
                                           
            RETURN TRUE;
        EXCEPTION
            WHEN EX.CONTROLLED_ERROR THEN
                IF (TT_BCPRODUCT.CUOPENDAMPRDBYPACK%ISOPEN) THEN
                    CLOSE TT_BCPRODUCT.CUOPENDAMPRDBYPACK;
                END IF;
                RAISE EX.CONTROLLED_ERROR;
            WHEN OTHERS THEN
                ERRORS.SETERROR;
                IF (TT_BCPRODUCT.CUOPENDAMPRDBYPACK%ISOPEN) THEN
                    CLOSE TT_BCPRODUCT.CUOPENDAMPRDBYPACK;
                END IF;
                RAISE EX.CONTROLLED_ERROR;
        END FBLISTOTALATTEND;
    BEGIN
        
        TT_BOFAULT.LOCKTT_DAMAGE(INUFAULTID);
        BLLOCKED := TRUE;
        
        
        DATT_DAMAGE.GETRECORD(INUFAULTID,
                              RCDAMAGE);
        
        
        BLTOTALATTEND := FBLISTOTALATTEND;
        
        NUCLASSCAUSALID := DAGE_CAUSAL.FNUGETCLASS_CAUSAL_ID(INUCLOSURECAUSEID);
        
        IF (NUCLASSCAUSALID = TT_BCCONSTANTS.CNUBASELESS_CLASS_CAU) THEN
            
            TT_BOORDER.ANNULPENDINGORDERS(INUFAULTID);
        ELSE
            
            
            IF (BLTOTALATTEND) THEN
                TT_BOORDER.VALPENDINGORDERS(INUFAULTID,
                                            ISBORDERSTOANNUL);
            END IF;

            
            IF (ISBORDERSTOANNUL IS NOT NULL) THEN
                TT_BOORDER.ANNULPENDINGORDERS(INUFAULTID,
                                              ISBORDERSTOANNUL);
            END IF;
        END IF;

        
        RCDAMAGE.DAMAGE_CAUSAL_ID := INUCLOSURECAUSEID;
        
        
        IF (   (RCDAMAGE.END_DATE IS NULL)
            OR (RCDAMAGE.END_DATE < IDTENDDATE)) THEN
            RCDAMAGE.END_DATE := IDTENDDATE;
        END IF;
        
        
        RCDAMAGE.ATENTION_PERSON_ID := INUPERSONID;

        
        IF (RCDAMAGE.ELEMENT_ID IS NOT NULL) THEN
            
            IF (GTBELEMENTS.COUNT = 0) THEN
                
                TT_BCELEMENT.GETFATHERELEMENTS(INUFAULTID,
                                               TBDAMAGEELEMENTS);
            
                NUINDEX := TBDAMAGEELEMENTS.FIRST;
                LOOP
                    EXIT WHEN NUINDEX IS NULL;
                    RCDAMAGE_ELEMENT := RCDAMAGE_ELEMENTNULL;
                    RCDAMAGE_ELEMENT := TBDAMAGEELEMENTS(NUINDEX);
                    TT_BOELEMENT.SETATTENDELEMENT(INUFAULTID,                 
                                                  RCDAMAGE_ELEMENT.ELEMENT_ID,
                                                  NULL,                       
                                                  NULL);                      
                    NUINDEX := TBDAMAGEELEMENTS.NEXT(NUINDEX);
                END LOOP;
            ELSE
                NUINDEX := GTBELEMENTS.FIRST;
                LOOP
                    EXIT WHEN NUINDEX IS NULL;
                    RCELEMENT := GTBELEMENTS(NUINDEX);
                    TT_BOELEMENT.SETATTENDELEMENT(INUFAULTID,
                                                  RCELEMENT.NUELEMENTID,
                                                  RCELEMENT.NUINITASSIGID,
                                                  RCELEMENT.NUFINALASSIGID);
                    NUINDEX := GTBELEMENTS.NEXT(NUINDEX);
                END LOOP;
            END IF;
        ELSE
            
            IF (GTBPRODUCTS.COUNT > 0) THEN
                NUINDEX := GTBPRODUCTS.FIRST;
                LOOP
                    EXIT WHEN NUINDEX IS NULL;
                    TT_BOPRODUCT.SETATTENDPRODUCT(INUFAULTID,
                                                  GTBPRODUCTS(NUINDEX));
                    NUINDEX := GTBPRODUCTS.NEXT(NUINDEX);
                END LOOP;
            END IF;
        END IF;

        
        TT_BOFAULT.UPDATEFAULTPROCESS(INUFAULTID,                  
                                      IDTINITIALDATE,              
                                      RCDAMAGE.ESTIMAT_ATTENT_DATE,
                                      INUFAULTTYPEID,              
                                      RCDAMAGE.ELEMENT_ID,         
                                      NULL,                        
                                      NULL,                        
                                      TRUE,                        
                                      BLTOTALATTEND,               
                                      RCDAMAGE);                   
                                      
        
        TT_BOFAULT.UNLOCKTT_DAMAGE(INUFAULTID);
        BLLOCKED := FALSE;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UNLOCKFAULT(INUFAULTID,
                        BLLOCKED);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            UNLOCKFAULT(INUFAULTID,
                        BLLOCKED);
            RAISE EX.CONTROLLED_ERROR;
    END ATTENDFAULT;
    
    
















    FUNCTION REGISTERPROCESS
    (
        INUFAULTID     IN TT_DAMAGE.PACKAGE_ID%TYPE,
        ISBTYPE        IN VARCHAR2,
        IBLTOTALATTEND IN BOOLEAN
    )
    RETURN VARCHAR2
    IS
        SBPARAMETERS        ESTAPROG.ESPRINFO%TYPE; 
        NUCONSECUTIVE       NUMBER := 0;            
        SBPROCESSID         ESTAPROG.ESPRPROG%TYPE; 
        SBMESSAGE           ESTAPROG.ESPRMESG%TYPE; 
        TBPARAMETERS        UT_STRING.TYTB_STRING;  
    BEGIN
        UT_TRACE.TRACE('Inicia TT_BOFault.RegisterProcess',15);

        
        WHILE (PKTBLESTAPROG.FBLEXIST(ISBTYPE||INUFAULTID||'_'||NUCONSECUTIVE)) LOOP
               NUCONSECUTIVE := NUCONSECUTIVE + 1;
        END LOOP;
        SBPROCESSID := ISBTYPE||INUFAULTID||'_'||NUCONSECUTIVE;

        SBMESSAGE := 'Proceso iniciado';

        PKSTATUSEXEPROGRAMMGR.VALIDATERECORDAT(SBPROCESSID);

        PKSTATUSEXEPROGRAMMGR.UPSTATUSEXEPROGRAMAT(SBPROCESSID,
                                                   SBMESSAGE,
                                                   100,
                                                   0);

        TBPARAMETERS(1) := TT_BCCONSTANTS.CSBFAULT_TAG||'='||INUFAULTID;
        
        IF (IBLTOTALATTEND) THEN
            TBPARAMETERS(2) := TT_BCCONSTANTS.CSBTOTALATTEND_TAG||'=TRUE';
        ELSE
            TBPARAMETERS(2) := TT_BCCONSTANTS.CSBTOTALATTEND_TAG||'=FALSE';
        END IF;

        SBPARAMETERS := UT_STRING.FSBSTRINGFROMTABLE(TBPARAMETERS,
                                                     ';');
        PKSTATUSEXEPROGRAMMGR.UPINFOEXEPROGRAM(SBPROCESSID,
                                               SBPARAMETERS);

        UT_TRACE.TRACE('Finaliza TT_BOFault.RegisterProcess',15);
        RETURN SBPROCESSID;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('=>CONTROLLED_ERROR TT_BOFault.RegisterProcess', 15);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            UT_TRACE.TRACE('=>OTHERS_ERROR TT_BOFault.RegisterProcess', 15);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END REGISTERPROCESS;
    
    

























    PROCEDURE ATTENDFAULTPROCESS
    (
        INUFAULTID     IN TT_DAMAGE.PACKAGE_ID%TYPE,
        IBLTOTALATTEND IN BOOLEAN,
        ISBPROCESSID   IN ESTAPROG.ESPRPROG%TYPE
    )
    IS
        BLLOCKED            BOOLEAN;        
        BLUSECACHE          BOOLEAN := GE_BOPARAMETER.FSBGET(CSBDAO_USE_CACHE) = GE_BOCONSTANTS.CSBYES; 

        RCDAMAGE            DATT_DAMAGE.STYTT_DAMAGE;       
        RCPACKAGE           DAMO_PACKAGES.STYMO_PACKAGES;   

        NUCLASSCAUSALID     GE_CLASS_CAUSAL.CLASS_CAUSAL_ID%TYPE; 
        BLATTEND            BOOLEAN;                              

        BLAUTHORIZETIMEOUT   BOOLEAN;                            

        NUINDEX             BINARY_INTEGER;                          
        TBPACKASSO          DAMO_PACKAGES_ASSO.TYTBMO_PACKAGES_ASSO; 

        
        SBPRODELESTATUS     TT_DAMAGE_PRODUCT.DAMAGE_PRODU_STATUS%TYPE;
        
        SBCOMPAPPROVAL      GE_PARAMETER.VALUE%TYPE; 
    BEGIN
        UT_TRACE.TRACE('Inicia TT_BOFault.AttendFaultProcess',15);

        
        TT_BOFAULT.LOCKTT_DAMAGE(INUFAULTID);
        BLLOCKED := TRUE;

        
        PKSTATUSEXEPROGRAMMGR.UPSTATUSEXEPROGRAMAT(ISBPROCESSID,
                                                   'Inicia la atenci�n de la falla',
                                                   100,
                                                   5);

        
        DATT_DAMAGE.GETRECORD(INUFAULTID,
                              RCDAMAGE);

        
        DAMO_PACKAGES.GETRECORD(INUFAULTID,
                                RCPACKAGE);

        BLAUTHORIZETIMEOUT := FALSE;
        SBCOMPAPPROVAL := GE_BOCONSTANTS.CSBNO;
        
        IF (RCDAMAGE.APPROVAL = TT_BCCONSTANTS.CSBCOMP_PENDING) THEN
            SBCOMPAPPROVAL := NVL(GE_BOPARAMETER.FSBGET(CSBCOMP_APPROVAL),
                                  GE_BOCONSTANTS.CSBNO);
            
            IF (SBCOMPAPPROVAL = GE_BOCONSTANTS.CSBNO) THEN
                
                BLAUTHORIZETIMEOUT := TRUE;
            END IF;
        END IF;

        BLATTEND := TRUE;
        
        IF (RCDAMAGE.DAMAGE_CAUSAL_ID <> OR_BOCONSTANTS.CNUSUCCESCAUSAL) THEN
            NUCLASSCAUSALID := DAGE_CAUSAL.FNUGETCLASS_CAUSAL_ID(RCDAMAGE.DAMAGE_CAUSAL_ID);
            
            IF (NUCLASSCAUSALID = TT_BCCONSTANTS.CNUBASELESS_CLASS_CAU) THEN
                BLATTEND := FALSE;
                
                BLAUTHORIZETIMEOUT := FALSE;
            END IF;
        END IF;

        IF (BLATTEND) THEN
            SBPRODELESTATUS := TT_BCCONSTANTS.CSBCLOSEDAMAGESTATUS;
        ELSE
            SBPRODELESTATUS := TT_BCCONSTANTS.CSBUNFOUNDEDDAMAGESTATUS;
        END IF;

        
        IF (RCDAMAGE.ELEMENT_ID IS NOT NULL) THEN
            PKSTATUSEXEPROGRAMMGR.UPSTATUSEXEPROGRAMAT(ISBPROCESSID,
                                                       'Inicia la atenci�n de la falla a elemento',
                                                       100,
                                                       10);

            
            TT_BOELEMENT.ATTENDELEMENTFAULT
            (
                INUFAULTID,
                RCDAMAGE.END_DATE,
                RCDAMAGE.ATENTION_PERSON_ID,
                SBPRODELESTATUS,
                RCDAMAGE.INITIAL_DATE,
                RCDAMAGE.APPROVAL,
                BLAUTHORIZETIMEOUT,
                BLATTEND,
                ISBPROCESSID
            );
        ELSE
            
            PKSTATUSEXEPROGRAMMGR.UPSTATUSEXEPROGRAMAT(ISBPROCESSID,
                                                       'Inicia la atenci�n de la interrupci�n de servicio',
                                                       100,
                                                       10);

            
            IF (IBLTOTALATTEND) THEN
                TT_BOPRODUCT.ATTENDALLPRODS(INUFAULTID,
                                            SBPRODELESTATUS,
                                            BLAUTHORIZETIMEOUT,
                                            RCDAMAGE.APPROVAL,
                                            RCDAMAGE.INITIAL_DATE,
                                            RCDAMAGE.END_DATE);
            ELSE
                
                TT_BOPRODUCT.ATTENDSELPRODS(INUFAULTID,
                                            SBPRODELESTATUS,
                                            BLAUTHORIZETIMEOUT,
                                            RCDAMAGE.APPROVAL,
                                            RCDAMAGE.INITIAL_DATE,
                                            RCDAMAGE.END_DATE);
            END IF;
        END IF;

        DAGE_ITEMS.SETUSECACHE(TRUE);

        PKSTATUSEXEPROGRAMMGR.UPSTATUSEXEPROGRAMAT(ISBPROCESSID,
                                                   'Inicia el cambio de estado de la falla',
                                                   100,
                                                   90);

        
        IF (RCDAMAGE.ELEMENT_ID IS NOT NULL) THEN
            
            RCPACKAGE.MOTIVE_STATUS_ID := TT_BOACTIVITYSERVICEDAMAGE.FNUGETPACKAGESTATUS(INUFAULTID);
        END IF;

        
        IF (    NOT (TT_BCPRODUCT.FBLHASPENDINGPRODS(INUFAULTID))
            AND NOT (TT_BCELEMENT.FBLHASPENDINGELEMS(INUFAULTID))) THEN
            IF (BLATTEND) THEN
                RCPACKAGE.MOTIVE_STATUS_ID := TT_BCCONSTANTS.CNUTTATTENSTATUS;
                RCDAMAGE.REG_DAMAGE_STATUS := TT_BCCONSTANTS.CSBATTENDEDDAMAGESTATUS;
                
                
                IF (    (RCDAMAGE.APPROVAL = TT_BCCONSTANTS.CSBCOMP_PENDING)
                    AND (SBCOMPAPPROVAL = GE_BOCONSTANTS.CSBNO)) THEN
                    RCDAMAGE.APPROVAL := TT_BCCONSTANTS.CSBCOMP_AUTHORIZED;
                END IF;
            ELSE
                RCPACKAGE.MOTIVE_STATUS_ID := TT_BCCONSTANTS.CNUTTUNFOUNDEDSTATUS;
                RCDAMAGE.REG_DAMAGE_STATUS := TT_BCCONSTANTS.CSBUNFOUNDEDDAMAGESTATUS;

                
                IF (RCDAMAGE.APPROVAL = TT_BCCONSTANTS.CSBCOMP_PENDING) THEN
                    RCDAMAGE.APPROVAL := TT_BCCONSTANTS.CSBCOMP_UNAUTHORIZED;
                END IF;

                
                
                TBPACKASSO := MO_BCPACKAGES_ASSO.FTBPACKASSOBYPACKID(INUFAULTID);
                NUINDEX := TBPACKASSO.FIRST;
                LOOP
                    EXIT WHEN NUINDEX IS NULL;
                    IF (DATT_DAMAGE.FBLEXIST(TBPACKASSO(NUINDEX).PACKAGE_ID_ASSO)) THEN
                        
                        DAMO_PACKAGES_ASSO.DELRECORD(TBPACKASSO(NUINDEX).PACKAGES_ASSO_ID);
                        
                        RCDAMAGE.DAMAGE_ABSOR_DATE := NULL;
                    END IF;
                    NUINDEX := TBPACKASSO.NEXT(NUINDEX);
                END LOOP;
            END IF;
            
            
            IF (RCDAMAGE.ELEMENT_ID IS NOT NULL) THEN
                
                TT_BODAMAGEALGORITHM.ATTFAULTPRODJOBCALLER(INUFAULTID, NULL);
            END IF;
            
        ELSE
            RCDAMAGE.REG_DAMAGE_STATUS := TT_BOCONSTANTS.CSBREGISTEREDDAMAGESTATUS;
        END IF;

        UT_TRACE.TRACE(' El paquete ['||INUFAULTID||'] actualiza el estado a ['||RCPACKAGE.MOTIVE_STATUS_ID||']',1);

        
        RCPACKAGE.ATTENTION_DATE := UT_DATE.FDTSYSDATE;

        PKSTATUSEXEPROGRAMMGR.UPSTATUSEXEPROGRAMAT(ISBPROCESSID,
                                                   'Inicia la actualizaci�n de la falla',
                                                   100,
                                                   95);

        
        DAMO_PACKAGES.UPDRECORD(RCPACKAGE);
        DATT_DAMAGE.UPDRECORD(RCDAMAGE);

        
        TT_BOFAULT.UNLOCKTT_DAMAGE(INUFAULTID);
        BLLOCKED := FALSE;
        
        UT_TRACE.TRACE('Finaliza TT_BOFault.AttendFaultProcess',15);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UNLOCKFAULT(INUFAULTID,
                        BLLOCKED);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            UNLOCKFAULT(INUFAULTID,
                        BLLOCKED);
            RAISE EX.CONTROLLED_ERROR;
    END ATTENDFAULTPROCESS;
    
    

















    PROCEDURE JOBATTENDFAULT
    (
        INUFAULTID     IN TT_DAMAGE.PACKAGE_ID%TYPE,
        IBLTOTALATTEND IN BOOLEAN
    )
    IS
        NUCURRTRACELVL      NUMBER;                         
        SBPROCESSID         ESTAPROG.ESPRPROG%TYPE;         
        NUERRORCODE         GE_ERROR_LOG.ERROR_LOG_ID%TYPE; 
        SBERRORMESSAGE      GE_ERROR_LOG.DESCRIPTION%TYPE;  

        BLLOCKED            BOOLEAN;        

        













        PROCEDURE MANAGEERROR
        IS
        BEGIN
            ERRORS.GETERROR(NUERRORCODE,
                            SBERRORMESSAGE);
            PKSTATUSEXEPROGRAMMGR.UPDATEESTAPROGAT(SBPROCESSID,
                                                     NUERRORCODE||' - '||SBERRORMESSAGE, 100, SYSDATE);
            
            UT_TRACE.SETLEVEL(NUCURRTRACELVL);
            ROLLBACK;
        EXCEPTION
            WHEN EX.CONTROLLED_ERROR THEN
                RAISE EX.CONTROLLED_ERROR;
            WHEN OTHERS THEN
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;
        END MANAGEERROR;
    BEGIN
        
        
        NUCURRTRACELVL := UT_TRACE.GETLEVEL;
        IF (    (CSBSET_TRACE = GE_BOCONSTANTS.CSBYES)
            AND (NUCURRTRACELVL = 0)) THEN
            UT_TRACE.SETLEVEL(CSBTRACE_LEVEL);
            UT_TRACE.SETOUTPUT(UT_TRACE.CNUTRACE_OUTPUT_DB);
        END IF;

        UT_TRACE.TRACE('Inicia TT_BOFault.JobAttendFault',15);

        SBPROCESSID := REGISTERPROCESS(INUFAULTID,
                                       TT_BCCONSTANTS.CSBPROCESS_TTAF,
                                       IBLTOTALATTEND);

        UT_TRACE.TRACE('Proceso registrado ['||SBPROCESSID||']',15);

        COMMIT;

        
        ATTENDFAULTPROCESS(INUFAULTID,    
                           IBLTOTALATTEND,
                           SBPROCESSID);  

        
        PKSTATUSEXEPROGRAMMGR.UPSTATUSEXEPROGRAMAT(SBPROCESSID,
                                                   'Proceso termin� correctamente',
                                                   100,
                                                   100);

        UT_TRACE.TRACE('Finaliza TT_BOFault.JobAttendFault',15);
        
        UT_TRACE.SETLEVEL(NUCURRTRACELVL);

        COMMIT;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            MANAGEERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            MANAGEERROR;
    END JOBATTENDFAULT;
    
    


















    PROCEDURE PROCESSPACKABSORB
    (
        INUPACKAGEID IN MO_PACKAGES.PACKAGE_ID%TYPE
    )
    IS
        BLABSORB     BOOLEAN;                                
        
        DTREQDATE    MO_PACKAGES.REQUEST_DATE%TYPE;          
        
        TBMOTIVES    DAMO_MOTIVE.TYTBMO_MOTIVE;              
        NUINDEX      BINARY_INTEGER;                         
        NUPRODUCTID  PR_PRODUCT.PRODUCT_ID%TYPE;             
        NUCAUSALID   CC_CAUSAL.CAUSAL_ID%TYPE;               
        
        TBFAULTS     DATT_DAMAGE.TYTBPACKAGE_ID;             
        NUFAULTINDEX BINARY_INTEGER;                         
        NUFAULTID    TT_DAMAGE.PACKAGE_ID%TYPE;              
        
        NUASSOID     MO_PACKAGES_ASSO.PACKAGES_ASSO_ID%TYPE; 
        
        BLLOCKED     BOOLEAN;                                
    BEGIN
        UT_TRACE.TRACE('Inicia TT_BOFault.ProcessPackAbsorb - PackageId ['||INUPACKAGEID||']',10);
        
        DTREQDATE := DAMO_PACKAGES.FDTGETREQUEST_DATE(INUPACKAGEID);
    
        
        TBMOTIVES := MO_BCMOTIVE.FTBMOTIVESBYPACKAGE(INUPACKAGEID);
        
        NUINDEX := TBMOTIVES.FIRST;
        BLABSORB := FALSE;
        
        LOOP
            EXIT WHEN (NUINDEX IS NULL) OR BLABSORB;

            NUPRODUCTID := TBMOTIVES(NUINDEX).PRODUCT_ID;
            
            IF (NUPRODUCTID IS NOT NULL) THEN
                UT_TRACE.TRACE('Procesando producto ['||NUPRODUCTID||']',15);
                TBFAULTS.DELETE;
                
                
                TT_BCFAULT.GETCONTROLFAULTS(NUPRODUCTID,
                                            DTREQDATE,
                                            TBFAULTS);
                NUFAULTINDEX := TBFAULTS.FIRST;
                IF (NUFAULTINDEX IS NOT NULL) THEN
                    BLABSORB := TRUE;
                    NUFAULTID := TBFAULTS(NUFAULTINDEX);
                    UT_TRACE.TRACE('Se absorbe en interrupci�n controlada ['||NUFAULTID||']',16);
                ELSE
                    
                    
                    NUCAUSALID := TBMOTIVES(NUINDEX).CAUSAL_ID;
                    TT_BCFAULT.GETFAULTS(NUPRODUCTID,
                                         DTREQDATE,
                                         NUCAUSALID,
                                         TBFAULTS);
                    NUFAULTINDEX := TBFAULTS.FIRST;
                    IF (NUFAULTINDEX IS NOT NULL) THEN
                        BLABSORB := TRUE;
                        NUFAULTID := TBFAULTS(NUFAULTINDEX);
                        UT_TRACE.TRACE('Se absorbe en interrupci�n de servicio ['||NUFAULTID||']',16);
                    END IF;
                END IF;
            END IF;
            
            NUINDEX := TBMOTIVES.NEXT(NUINDEX);
        END LOOP;
        
        
        IF (BLABSORB) THEN
            
            TT_BOFAULT.VALFAULTSTATUS(NUFAULTID);
            
            TT_BOFAULT.LOCKTT_DAMAGE(NUFAULTID);
            BLLOCKED := TRUE;
            
            TT_BOFAULT.ABSORBPACKAGE(NUFAULTID,   
                                     INUPACKAGEID,
                                     NULL,        
                                     NUASSOID);   
            
            TT_BOFAULT.UNLOCKTT_DAMAGE(NUFAULTID);
            BLLOCKED  := FALSE;
        ELSE
            UT_TRACE.TRACE('No hay absorci�n, se prosigue a analizar por falla autom�tica',15);
            NUPRODUCTID := MO_BOPACKAGES.FNUFINDPRODUCTID(INUPACKAGEID);
            
            IF (NOT TT_BOPRODUCT.FBLVALDAMABSORPTION(NUPRODUCTID, INUPACKAGEID)) THEN
                
                TT_BOAUTOREGISTERDAMAGE.AUTOREGDAMAGESJOB(INUPACKAGEID);
            END IF;
        END IF;
        
        UT_TRACE.TRACE('Fin TT_BOFault.ProcessPackAbsorb',10);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            IF (BLLOCKED) THEN
                TT_BOFAULT.UNLOCKTT_DAMAGE(NUFAULTID);
            END IF;
        WHEN OTHERS THEN
            IF (BLLOCKED) THEN
                TT_BOFAULT.UNLOCKTT_DAMAGE(NUFAULTID);
            END IF;
    END PROCESSPACKABSORB;
    
    


















































    PROCEDURE GETFAULT
    (
        INUFAULTID          IN  TT_DAMAGE.PACKAGE_ID%TYPE,
        OSBSTATUS           OUT VARCHAR2,
        OSBFAULTTYPE        OUT VARCHAR2,
        OSBCAUSAL           OUT VARCHAR2,
        ODTREGISTERDATE     OUT MO_PACKAGES.REQUEST_DATE%TYPE,
        ODTFIRSTINCABSORBED OUT TT_DAMAGE.DAMAGE_ABSOR_DATE%TYPE,
        ODTESTATTENDDATE    OUT TT_DAMAGE.ESTIMAT_ATTENT_DATE%TYPE,
        ODTATTENTIONDATE    OUT MO_PACKAGES.ATTENTION_DATE%TYPE,
        ODTOUTAGEINIT       OUT TT_DAMAGE.INITIAL_DATE%TYPE,
        ODTOUTAGEEND        OUT TT_DAMAGE.END_DATE%TYPE,
        OSBELEMENTCODE      OUT IF_NODE.CODE%TYPE,
        OSBELEMENTTYPE      OUT VARCHAR2,
        OSBELEMENTCLASS     OUT VARCHAR2,
        OSBCOMPENSATE       OUT VARCHAR2,
        OSBATTRIBUTABLETO   OUT VARCHAR2,
        OSBCOMPSUSCEP       OUT TT_DAMAGE_TYPE.TIME_OUT%TYPE,
        ODTVERIFICATIONDATE OUT TT_DAMAGE.VERIFICATION_DATE%TYPE,
        OSBVERIFPERSON      OUT VARCHAR2,
        OSBGEOLOCATION      OUT VARCHAR2,
        OSBNEIGHBORHOOD     OUT VARCHAR2,
        OSBADDRESS          OUT VARCHAR2,
        ONUPRIORITY         OUT TT_DAMAGE.PRIORITY%TYPE,
        ORFORDERSASSOCIATED OUT CONSTANTS.TYREFCURSOR
    )
    IS
        RCPACKAGE       DAMO_PACKAGES.STYMO_PACKAGES;   
        RCDAMAGE        DATT_DAMAGE.STYTT_DAMAGE;       
        RCELEMENT       DAIF_NODE.STYIF_NODE;           
        NUADDRESSID     AB_ADDRESS.ADDRESS_ID%TYPE;     
    BEGIN
        
        IF (INUFAULTID IS NULL) THEN
            ERRORS.SETERROR(CNUNULL_ATT_ERROR,
                            'inuFaultId');
            RAISE EX.CONTROLLED_ERROR;
        END IF;

        
        DATT_DAMAGE.GETRECORD(INUFAULTID,
                              RCDAMAGE);
        DAMO_PACKAGES.GETRECORD(INUFAULTID,
                                RCPACKAGE);

        
        OSBSTATUS := TT_BCBASICDATASERVICES.FSBGETMOTIVESTATUSDESC(RCPACKAGE.MOTIVE_STATUS_ID);
        
        IF (RCDAMAGE.FINAL_DAMAGE_TYPE_ID IS NULL) THEN
            OSBFAULTTYPE := TT_BCBASICDATASERVICES.FSBGETDAMAGETYPE(RCDAMAGE.PACKAGE_ID, RCDAMAGE.REG_DAMAGE_TYPE_ID);
            
            OSBCOMPSUSCEP := DATT_DAMAGE_TYPE.FSBGETTIME_OUT(RCDAMAGE.REG_DAMAGE_TYPE_ID);
        ELSE
            OSBFAULTTYPE := TT_BCBASICDATASERVICES.FSBGETFINALDAMAGETYPE(RCDAMAGE.FINAL_DAMAGE_TYPE_ID);
            
            OSBCOMPSUSCEP := DATT_DAMAGE_TYPE.FSBGETTIME_OUT(RCDAMAGE.FINAL_DAMAGE_TYPE_ID);
        END IF;
        
        IF (RCDAMAGE.DAMAGE_CAUSAL_ID IS NOT NULL) THEN
            OSBCAUSAL := TT_BCBASICDATASERVICES.FSBGETDAMAGECAUSAL(RCDAMAGE.DAMAGE_CAUSAL_ID);
        END IF;
        
        ODTREGISTERDATE := RCPACKAGE.REQUEST_DATE;
        
        ODTFIRSTINCABSORBED := TT_BCBASICDATASERVICES.FDTFIRSTABSPACK(RCDAMAGE.PACKAGE_ID);
        
        ODTESTATTENDDATE := RCDAMAGE.ESTIMAT_ATTENT_DATE;
        
        ODTATTENTIONDATE := RCPACKAGE.ATTENTION_DATE;
        
        ODTOUTAGEINIT := TT_BCBASICDATASERVICES.FDTINITIALDATE(RCDAMAGE.PACKAGE_ID);
        
        ODTOUTAGEEND := RCDAMAGE.END_DATE;
        
        IF (RCDAMAGE.ELEMENT_ID IS NOT NULL) THEN
            DAIF_NODE.GETRECORD(RCDAMAGE.ELEMENT_ID,
                                RCELEMENT);
            
            OSBELEMENTCODE := RCELEMENT.CODE;
            
            OSBELEMENTTYPE := TT_BCBASICDATASERVICES.FSBGETDAMAGEELEMTYPE(NULL,
                                                                          RCELEMENT.ELEMENT_TYPE_ID);
            
            OSBELEMENTCLASS := TT_BCBASICDATASERVICES.FSBGETCLASSELEMENTDESC(RCELEMENT.ELEMENT_TYPE_ID,
                                                                             RCELEMENT.CLASS_ID);
        END IF;
        
        IF (RCDAMAGE.APPROVAL = TT_BCCONSTANTS.CSBCOMP_PENDING) THEN
            OSBCOMPENSATE := RCDAMAGE.APPROVAL ||' - Pendiente';
        ELSIF (RCDAMAGE.APPROVAL = TT_BCCONSTANTS.CSBCOMP_AUTHORIZED) THEN
            OSBCOMPENSATE := RCDAMAGE.APPROVAL ||' - Autorizado';
        ELSIF (RCDAMAGE.APPROVAL = TT_BCCONSTANTS.CSBCOMP_UNAUTHORIZED) THEN
            OSBCOMPENSATE := RCDAMAGE.APPROVAL ||' - No Autorizado';
        ELSIF (RCDAMAGE.APPROVAL = TT_BCCONSTANTS.CSBCOMP_NOT_APPLICAB) THEN
            OSBCOMPENSATE := RCDAMAGE.APPROVAL ||' - No aplica';
        END IF;
        
        IF (RCDAMAGE.DAMAGE_CAUSAL_ID IS NOT NULL) THEN
            OSBATTRIBUTABLETO := TT_BCBASICDATASERVICES.FSBGETATTRIBUTEDTO(RCDAMAGE.DAMAGE_CAUSAL_ID);
        END IF;
        
        ODTVERIFICATIONDATE := RCDAMAGE.VERIFICATION_DATE;
        
        IF (RCDAMAGE.PERSON_VERIFYING IS NOT NULL) THEN
            OSBVERIFPERSON := TT_BCBASICDATASERVICES.FSBGETDAMAGATTPERSON(RCDAMAGE.PERSON_VERIFYING);
        END IF;
        
        NUADDRESSID := TT_BCBASICDATASERVICES.FNUGETPARSADDRIDBYPACK(INUFAULTID);
        IF (NUADDRESSID IS NOT NULL) THEN
            
            OSBGEOLOCATION := TT_BCBASICDATASERVICES.FSBGETDESCGEOLOCBYADDR(NUADDRESSID);
            
            OSBNEIGHBORHOOD := TT_BCBASICDATASERVICES.FSBGETDESCNEIGHBYADDR(NUADDRESSID);
            
            IF (CSBDISP_PARSER_ADDRESS = GE_BOCONSTANTS.CSBYES )THEN
                OSBADDRESS := DAAB_ADDRESS.FSBGETADDRESS_PARSED(NUADDRESSID);
            ELSE
                OSBADDRESS := DAAB_ADDRESS.FSBGETADDRESS(NUADDRESSID);
            END IF;
        END IF;

        
        ONUPRIORITY := RCDAMAGE.PRIORITY;
        
        TT_BCFAULT.GETFAULTORDERS(INUFAULTID,
                                  ORFORDERSASSOCIATED);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETFAULT;
    
    
















    PROCEDURE PROCESSREGISTERFAULT
    (
        INUFAULTTYPEID   IN  TT_DAMAGE.REG_DAMAGE_TYPE_ID%TYPE,
        INUELEMENTID     IN  TT_DAMAGE.ELEMENT_ID%TYPE,
        INUINITASSIGID   IN  IF_ASSIGNABLE.ID%TYPE,
        INUFINALASSIGID  IN  IF_ASSIGNABLE.ID%TYPE,
        IDTINITIALDATE   IN  TT_DAMAGE.INITIAL_DATE%TYPE,
        IDTESTATTENDDATE IN  TT_DAMAGE.ESTIMAT_ATTENT_DATE%TYPE,
        ISBCOMMENT       IN  MO_COMMENT.COMMENT_%TYPE,
        ISBCLASS         IN  TT_DAMAGE.CLASS%TYPE,
        ONUFAULTID       OUT TT_DAMAGE.PACKAGE_ID%TYPE
    )
    IS
        NUACTIVITYID    GE_ITEMS.ITEMS_ID%TYPE;         
        NUPERSONID      GE_PERSON.PERSON_ID%TYPE;       
        BLLOCKED        BOOLEAN;                        
        NUELEMENTTYPEID IF_NODE.ELEMENT_TYPE_ID%TYPE;   

    BEGIN
        UT_TRACE.TRACE('Inicia TT_BOFault.ProcessRegisterFault',15);

        
        TT_BOELEMENT.LOCKTT_DAM_ELEM(INUFAULTTYPEID,
                                     INUELEMENTID);
        BLLOCKED := TRUE;

        
        NUELEMENTTYPEID := DAIF_NODE.FNUGETELEMENT_TYPE_ID(INUELEMENTID);
        
        
        NUACTIVITYID := TT_BCACTBYELEMTYP.FNUGETACTIVITYBYELEMENT(INUFAULTTYPEID,
                                                                  NUELEMENTTYPEID,  
                                                                  TRUE);         

        
        TT_BOFAULT.REGISTERFAULT(INUFAULTTYPEID,   
                                 IDTINITIALDATE,   
                                 NULL,             
                                 NULL,             
                                 ISBCLASS,         
                                 ISBCOMMENT,       
                                 INUELEMENTID,     
                                 NUACTIVITYID,     
                                 IDTESTATTENDDATE, 
                                 NULL,             
                                 ONUFAULTID);      

        
        NUPERSONID := GE_BOPERSONAL.FNUGETPERSONID;

        
        
        TT_BOELEMENT.ADDELEMENTTOFAULT(ONUFAULTID,
                                       INUELEMENTID,
                                       INUINITASSIGID,
                                       INUFINALASSIGID,
                                       NUPERSONID);

        
        TT_BOELEMENT.PROCESSFAULT(ONUFAULTID,  
                                  INUELEMENTID,
                                  TRUE);       

        
        TT_BOELEMENT.UNLOCKTT_DAM_ELEM(INUELEMENTID);
        BLLOCKED := FALSE;

        UT_TRACE.TRACE('Finaliza TT_BOFault.ProcessRegisterFault',15);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('Error : ex.CONTROLLED_ERROR',15);
            IF (BLLOCKED) THEN
                TT_BOELEMENT.UNLOCKTT_DAM_ELEM(INUELEMENTID);
            END IF;
            RAISE;

        WHEN OTHERS THEN
            UT_TRACE.TRACE('Error : others',15);
            IF (BLLOCKED) THEN
                TT_BOELEMENT.UNLOCKTT_DAM_ELEM(INUELEMENTID);
            END IF;
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;
    
    














    PROCEDURE VALFAULTPARTIALATT
    (
        INUFAULTID IN TT_DAMAGE.PACKAGE_ID%TYPE
    )
    IS
        NUDAMAGECAUSALID TT_DAMAGE.DAMAGE_CAUSAL_ID%TYPE; 
    BEGIN
        
        NUDAMAGECAUSALID := DATT_DAMAGE.FNUGETDAMAGE_CAUSAL_ID(INUFAULTID);
        
        IF (NUDAMAGECAUSALID IS NOT NULL) THEN
            ERRORS.SETERROR(CNUINVALID_PROC_ERROR,
                            'fallas que est�n parcialmente atendidas');
            RAISE EX.CONTROLLED_ERROR;
        END IF;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END VALFAULTPARTIALATT;
    
    














    PROCEDURE VALFAULTUNFOUNDED
    (
        INUFAULTID IN TT_DAMAGE.PACKAGE_ID%TYPE
    )
    IS
        NUDAMAGECAUSALID TT_DAMAGE.DAMAGE_CAUSAL_ID%TYPE; 
        NUCLASSCAUSALID  GE_CAUSAL.CLASS_CAUSAL_ID%TYPE;  
    BEGIN
        
        NUDAMAGECAUSALID := DATT_DAMAGE.FNUGETDAMAGE_CAUSAL_ID(INUFAULTID);
        
        IF (NUDAMAGECAUSALID IS NOT NULL) THEN
            NUCLASSCAUSALID := DAGE_CAUSAL.FNUGETCLASS_CAUSAL_ID(NUDAMAGECAUSALID);
            
            IF (NUCLASSCAUSALID = TT_BCCONSTANTS.CNUBASELESS_CLASS_CAU) THEN
                ERRORS.SETERROR(CNUINVALID_PROC_ERROR,
                                'fallas que est�n siendo infundadas');
                RAISE EX.CONTROLLED_ERROR;
            END IF;
        END IF;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END VALFAULTUNFOUNDED;
    
    
















    PROCEDURE VALUPDATEFAULT
    (
        INUFAULTID     IN TT_DAMAGE.PACKAGE_ID%TYPE,
        INUFAULTTYPEID IN TT_DAMAGE.FINAL_DAMAGE_TYPE_ID%TYPE,
        IDTINITIALDATE IN TT_DAMAGE.INITIAL_DATE%TYPE
    )
    IS
        NUCLASSCAUSALID  GE_CLASS_CAUSAL.CLASS_CAUSAL_ID%TYPE; 
        DTMINENDDATE     TT_DAMAGE.END_DATE%TYPE;              
        NUDAMAGECAUSALID TT_DAMAGE.DAMAGE_CAUSAL_ID%TYPE;      
    BEGIN
        
        IF (INUFAULTTYPEID IS NULL) THEN
            ERRORS.SETERROR(CNUREQ_FIELD_ERROR,
                            'Tipo de Falla');
            RAISE EX.CONTROLLED_ERROR;
        END IF;
        IF (IDTINITIALDATE IS NULL) THEN
            ERRORS.SETERROR(CNUREQ_FIELD_ERROR,
                            'Fecha de Inicio de Afectaci�n');
            RAISE EX.CONTROLLED_ERROR;
        END IF;
        
        DATT_DAMAGE_TYPE.ACCKEY(INUFAULTTYPEID);
        
        IF (INUFAULTTYPEID = TT_BCCONSTANTS.CNUCONTROL_FAULT_TYPE) THEN
            ERRORS.SETERROR(CNUINV_VALUE_ERROR,
                            'Tipo de Falla');
            RAISE EX.CONTROLLED_ERROR;
        END IF;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END VALUPDATEFAULT;

END TT_BOFAULT;