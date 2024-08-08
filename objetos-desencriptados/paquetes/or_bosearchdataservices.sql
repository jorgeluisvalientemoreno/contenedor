PACKAGE BODY OR_boSearchDataServices IS













































































































































































































































































    CSBVERSION   CONSTANT VARCHAR2(20) := 'SAO306896';
    
    
    CNUNULL NUMBER := NULL;
    
    
    CNUERROR_12101          CONSTANT NUMBER := 12101;
    
    CNUERROR_119682         CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 119682;
    CNUERROR_NETELEMENTS    CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 51;

    CNUERROR_CRIBUS_INSUF   CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 11041;
    CNUERROR_FECHAINIDEFI   CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 11081;
    CNUERROR_FECHAFINDEFI   CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 11082;
    
    CSBDATELEGALIZ          CONSTANT  VARCHAR2(200) := ' de legalizaci?n';
    CSBDATEASIGNAC          CONSTANT  VARCHAR2(200) := ' de asignaci?n';
    CSBDATERANGE            CONSTANT  VARCHAR2(200) := ' acordada';
    CSBDATECREATION         CONSTANT  VARCHAR2(200) := ' de creaci?n';


    CSBOR_FW_OR_ORDER       CONSTANT  GE_ENTITY.NAME_%TYPE := 'OR_FW_OR_ORDER';
    CNUUOPROPIAS            CONSTANT NUMBER := -3; 
    CNUUOCONTRATISTAS       CONSTANT NUMBER := -2; 
    
    CNUNULL_ATTRIBUTE       CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 2126;
        
	
    
    PROCEDURE TRACE(ISBTRACE IN VARCHAR2, NULEVEL IN NUMBER);

    FUNCTION FSBVERSION  RETURN VARCHAR2 IS
    BEGIN
        RETURN CSBVERSION;
    END;

    PROCEDURE GETNUMBERANDSEQ
    (
        ISBNUMSEQ IN VARCHAR,
        ONUNUMERATOR OUT NUMBER ,
        ONUSEQUENCE OUT NUMBER
    )
    IS
    SBNUMERATOR VARCHAR2 (100);
    SBSEQUENCE VARCHAR2 (100);
    SBADDVARCHAR VARCHAR2 (100);
    BEGIN
        IF ISBNUMSEQ LIKE '%-%' THEN
            SBNUMERATOR := UT_STRING.EXTSTRFIELD(ISBNUMSEQ,'-',1);
            SBSEQUENCE := UT_STRING.EXTSTRFIELD(ISBNUMSEQ,'-',2);
            SBADDVARCHAR := UT_STRING.EXTSTRFIELD(ISBNUMSEQ,'-',3);
            IF  SBADDVARCHAR IS NOT NULL OR SBNUMERATOR IS NULL OR SBSEQUENCE IS NULL THEN
                RAISE EX.CONTROLLED_ERROR;
            END IF;
            IF LENGTH(SBNUMERATOR) > 4 OR LENGTH(SBSEQUENCE) > 10 THEN
                RAISE EX.CONTROLLED_ERROR;
            END IF;
            ONUNUMERATOR := TO_NUMBER(SBNUMERATOR);
            ONUSEQUENCE := TO_NUMBER(SBSEQUENCE);
        ELSE
            RAISE EX.CONTROLLED_ERROR;
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
             GE_BOERRORS.SETERRORCODE(CNUERROR_12101);
             RAISE EX.CONTROLLED_ERROR;
    END GETNUMBERANDSEQ;

    
































































    PROCEDURE FILLORDERATTRIBUTES(IOSBATTRIBUTES IN OUT GE_BOUTILITIES.STYSTATEMENT)
    IS
        SBNUMERATOR                 GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        SBTASKTYPE                  GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        SBORDERSTATUS               GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        SBOPERATINGSECTOR           GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        SBOPERATINGUNIT             GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        SBOPERAUNITSTATUS           GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        SBASSIGNEDWITH              GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        SBORDERCLASSIF              GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        SBCAUSAL                    GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        SBREALTASKTYPE              GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        SBPERSON                    GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        SBCORSCOPR                  GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        SBRUSERUTA                  GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        SBROUTENAME                 GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        SBADDRESS_PARSED            GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        SBNEIGHBORTHOOD             GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        SBGEOGRLOCATION             GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        SBSUBSCNAME                 GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        SBSUBSCLAST_NAME            GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        SBPROGCLASDESC              GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        SBPRODUCT                   GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        SBSUBSCRIBER                GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        SBISCOUNTERMAND             GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        SBCLIENTTYPE                GE_BOUTILITIES.STYSTATEMENT;
        SBCLIENTPHONE               GE_BOUTILITIES.STYSTATEMENT;
        SBSCORING                   GE_BOUTILITIES.STYSTATEMENT;
        SBDURATION                  GE_BOUTILITIES.STYSTATEMENT;
        SBCOMMENT                   GE_BOUTILITIES.STYSTATEMENT;
        SBCOMMENTTYPE               GE_BOUTILITIES.STYSTATEMENT;
        SBASSOUNIT                  GE_BOUTILITIES.STYSTATEMENT;
        SBOFFERED                   GE_BOUTILITIES.STYSTATEMENT;
        SBPROJECTNAME               GE_BOUTILITIES.STYSTATEMENT;
        SBSTAGENAME                 GE_BOUTILITIES.STYSTATEMENT;

                                                                                                
    BEGIN
        
        SBNUMERATOR         := 'OR_ORDER.numerator_id || chr(32) || chr(45) || chr(32) || OR_ORDER.sequence';
        SBTASKTYPE          := '(select or_task_type.task_type_id || chr(32) || chr(45) || chr(32) || or_task_type.description FROM or_task_type WHERE or_task_type.task_type_id = OR_order.task_type_id )';
        SBORDERSTATUS       := '(select OR_order_status.order_status_id || chr(32) || chr(45) || chr(32) || OR_order_status.description FROM OR_order_status WHERE OR_order_status.order_status_id = OR_order.order_status_id )';
        SBOPERATINGSECTOR   := '(select or_operating_sector.operating_sector_id || chr(32) || chr(45) || chr(32) || or_operating_sector.description FROM or_operating_sector WHERE OR_order.operating_sector_id = or_operating_sector.operating_sector_id )';
        SBOPERATINGUNIT     := '(select or_operating_unit.operating_unit_id || chr(32) || chr(45) || chr(32) || or_operating_unit.name FROM or_operating_unit WHERE or_operating_unit.operating_unit_id = OR_order.operating_unit_id)';
        SBOPERAUNITSTATUS   := '(select or_oper_unit_status.oper_unit_status_id || chr(32) || chr(45) || chr(32) || or_oper_unit_status.description FROM or_operating_unit, or_oper_unit_status WHERE or_operating_unit.oper_unit_status_id =  or_oper_unit_status.oper_unit_status_id AND or_operating_unit.operating_unit_id = OR_order.operating_unit_id)';
        SBASSIGNEDWITH      := 'OR_ORDER.ASSIGNED_WITH || chr(32) || chr(45) || chr(32) || decode(OR_ORDER.ASSIGNED_WITH'||
                                                                                   ',''''S'''','''''||GE_BOI18N.FSBGETTRASLATION('ASSIGNED_WITH_S')||
                                                                                   ''''',''''C'''','''''||GE_BOI18N.FSBGETTRASLATION('ASSIGNED_WITH_C')||
                                                                                   ''''',''''N'''','''''||GE_BOI18N.FSBGETTRASLATION('ASSIGNED_WITH_N')||
                                                                                   ''''',''''R'''','''''||GE_BOI18N.FSBGETTRASLATION('ASSIGNED_WITH_R')||
                                                                                   ''''',null)';
        SBORDERCLASSIF      := 'OR_ORDER.ORDER_CLASSIF_ID || chr(32) || chr(45) || chr(32) || OR_boBasicDataServices.fsbGetDescOrderClassif(OR_ORDER.ORDER_CLASSIF_ID)';
        SBCAUSAL            := '(select ge_causal.causal_id || chr(32) || chr(45) || chr(32) || ge_causal.description FROM ge_causal WHERE ge_causal.causal_id = OR_order.causal_id)';
        SBREALTASKTYPE      := '(select or_task_type.task_type_id || chr(32) || chr(45) || chr(32) || or_task_type.description FROM or_task_type WHERE or_task_type.task_type_id = or_order.real_task_type_id )';
        SBPROGCLASDESC      := 'OR_BOBasicDataServices.fsbGetProgClassDesc(or_order.order_id)';
        SBPERSON            := '(select OR_ORDER_PERSON.person_id || chr(32) || chr(45) || chr(32) || ge_person.name_ FROM ge_person, OR_ORDER_PERSON '
                              || ' WHERE ge_person.person_id = OR_ORDER_PERSON.person_id '
                              || ' AND OR_ORDER_PERSON.operating_unit_id = OR_order.operating_unit_id '
                              || ' AND OR_ORDER_PERSON.order_id = OR_order.order_id )';
        SBCORSCOPR          := 'or_order.consecutive';
        SBRUSERUTA          := 'or_order.route_id';
        SBROUTENAME         := '(select  OR_route.route_id || chr(32) || chr(45) || chr(32) || OR_route.Name FROM OR_route WHERE OR_route.route_id = or_order.route_id)';
        SBADDRESS_PARSED    := 'AB_ADDRESS.address_parsed';
        SBNEIGHBORTHOOD     := 'decode(or_order.external_address_id,null,null,ab_bobasicdataservices.fsbGetDescNeighborthoodByAddr(or_order.external_address_id))';
        SBGEOGRLOCATION     := 'decode(or_order.external_address_id,null,null,ab_bobasicdataservices.fsbGetDescGeograLocatiByAddr(or_order.external_address_id))';
        SBSUBSCNAME         := 'ge_subscriber.subscriber_name';
        SBSUBSCLAST_NAME    := 'ge_subscriber.subs_last_name';
        SBPRODUCT           := 'or_bobasicdataservices.fnuGetProductId(or_order.order_id)';
        SBSUBSCRIBER        := 'ge_subscriber.identification';
        SBCLIENTTYPE        := 'decode(ge_subscriber.subscriber_type_id, null, null,ge_subscriber.subscriber_type_id|| chr(32) || chr(45) || chr(32) ||dage_subscriber_type.fsbgetdescription(ge_subscriber.subscriber_type_id))';
        SBCLIENTPHONE       := 'or_bobasicdataservices.fsbObtTelefonoClient(or_order.order_id)';
        SBSCORING           := 'or_bobasicdataservices.fnuObtUltimoScoring(or_order.order_id)';
        SBDURATION          := 'or_bobasicdataservices.fnuEsfuerzoOrden(or_order.order_id)';
        SBCOMMENT           := 'or_bcordercomment.fsbLastCommentByOrder(or_order.order_id)';
        SBCOMMENTTYPE       := 'or_bcordercomment.fsbLastCommentTypeByOrder(or_order.order_id)';
        SBASSOUNIT          := 'or_order.asso_unit_id || chr(32) || chr(45) || chr(32) || daor_operating_unit.fsbGetName(or_order.asso_unit_id,0)';
        SBOFFERED           := 'or_order.offered';
        SBPROJECTNAME       := 'PM_BOServices.fsbGetProjectNameByStage(or_order.stage_id)';
        SBSTAGENAME         := 'or_order.stage_id || chr(32) || chr(45) || chr(32) || dapm_stage.fsbGetStage_name(or_order.stage_id,0)';
        SBISCOUNTERMAND     := 'decode(OR_ORDER.IS_COUNTERMAND,'''''|| OR_BOCONSTANTS.CSBSI || ''''','''''|| GE_BOI18N.FSBGETTRASLATION('YES') || ''''', '''''||GE_BOI18N.FSBGETTRASLATION('NO')|| ''''')';

        GE_BOUTILITIES.ADDATTRIBUTE ('OR_ORDER.ORDER_ID','ORDER_ID',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBNUMERATOR,'numerator', IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBTASKTYPE,'TASK_TYPE',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBORDERSTATUS,'ORDER_STATUS',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBOPERATINGSECTOR,'OPERATING_SECTOR',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBPRODUCT,'PRODUCT_ID',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBOPERATINGUNIT,'OPERATING_UNIT',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBOPERAUNITSTATUS,'OPERATING_UNIT_STATUS',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE ('OR_ORDER.CREATED_DATE','CREATED_DATE',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE ('OR_ORDER.ASSIGNED_DATE','ASSIGNED_DATE',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBASSIGNEDWITH,'ASSIGNED_WITH',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE ('OR_ORDER.EXEC_ESTIMATE_DATE','EXEC_ESTIMATE_DATE',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE ('OR_ORDER.MAX_DATE_TO_LEGALIZE','MAX_DATE_TO_LEGALIZE',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE ('OR_ORDER.REPROGRAM_LAST_DATE','REPROGRAM_LAST_DATE',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE ('OR_ORDER.LEGALIZATION_DATE','LEGALIZATION_DATE',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE ('OR_ORDER.EXEC_INITIAL_DATE','EXEC_INITIAL_DATE',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE ('OR_ORDER.EXECUTION_FINAL_DATE','EXECUTION_FINAL_DATE',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBCAUSAL,'CAUSAL',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBPERSON,'PERSON',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE ('OR_ORDER.ORDER_VALUE','ORDER_VALUE',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE ('nvl(OR_ORDER.PRINTING_TIME_NUMBER,0)','PRINTING_TIME_NUMBER',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE ('nvl(OR_ORDER.LEGALIZE_TRY_TIMES,0)','LEGALIZE_TRY_TIMES',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBISCOUNTERMAND,'IS_COUNTERMAND',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBREALTASKTYPE,'REAL_TASK_TYPE',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE ('OR_ORDER.PRIORITY','PRIORITY',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBPROGCLASDESC,'PROGCLASDESC',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE ('OR_ORDER.ARRANGED_HOUR','ARRANGED_HOUR',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE ('OR_ORDER.APPOINTMENT_CONFIRM','APPOINTMENT_CONFIRM',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBCORSCOPR,'CORSCOPR',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBRUSERUTA,'RUSERUTA',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBROUTENAME,'ROUTE_NAME',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBADDRESS_PARSED,'ADDRESS_PARSED',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBNEIGHBORTHOOD,'NEIGHBORTHOOD',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBGEOGRLOCATION,'GEOGRAP_LOCATION',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBSUBSCRIBER,'SUBSCRIBER_ID',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBSUBSCNAME,'SUBSC_NAME',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBSUBSCLAST_NAME,'SUBSC_LAST_NAME',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBCLIENTTYPE,'CLIENT_TYPE',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBCLIENTPHONE,'CLIENT_PHONE',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBSCORING,'SCORING',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBDURATION,'DURATION',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBCOMMENT,'ORDER_COMMENT',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBCOMMENTTYPE,'COMMENT_TYPE',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBASSOUNIT ,'ASSO_UNIT',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBOFFERED ,'OFFERED',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBPROJECTNAME,'PROJECT_NAME',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBSTAGENAME,'STAGE_NAME',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE ('OR_ORDER.ORDER_STATUS_ID','ORDER_STATUS_ID',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (':parent_id','parent_id',IOSBATTRIBUTES);
        
        GSBORDERFROM := ' FROM OR_ORDER, GE_SUBSCRIBER, AB_ADDRESS';
        GSBORDERWHERE := ' WHERE AB_ADDRESS.address_id(+) = OR_ORDER.external_address_id';

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FILLORDERATTRIBUTES;
    
    





















    PROCEDURE GETORDERBYID
    (
        INUORDERID     IN OR_ORDER.ORDER_ID%TYPE,
        OCUDATACURSOR  OUT CONSTANTS.TYREFCURSOR
    )
    IS
      SBSQL                           GE_BOUTILITIES.STYSTATEMENT;
      SBORDERFROM                     GE_BOUTILITIES.STYSTATEMENT;
      SBORDERWHERE                    GE_BOUTILITIES.STYSTATEMENT;
      SBORDERATTRIBUTES               GE_BOUTILITIES.STYSTATEMENT;
      SBRECORDBIND                    GE_BOUTILITIES.STYSTATEMENT;
      CUCURSOR                        CONSTANTS.TYREFCURSOR;
      SBUSING                         GE_BOUTILITIES.STYSTATEMENT;
    BEGIN

        FILLORDERATTRIBUTES(SBORDERATTRIBUTES);

        SBORDERFROM := GSBORDERFROM;
        SBORDERWHERE := GSBORDERWHERE || CHR(10) ||'AND GE_SUBSCRIBER.subscriber_id(+) = OR_ORDER.subscriber_id'
                        ||CHR(10)||' AND OR_order.order_id = :inuOrderId ';


        SBSQL := 'select '|| SBORDERATTRIBUTES ||CHR(10)||
                  SBORDERFROM ||CHR(10)||
                  ' /*+ OR_BOSearchDateServices.GetOrderById SAO165076 */ '|| CHR(10)||
                  SBORDERWHERE;
        SBUSING := GE_BOUTILITIES.CSBNULLSTRING || ', ' || NVL(INUORDERID,GE_BOUTILITIES.CSBNULLSTRING);

        SBRECORDBIND := 'BEGIN Open :cuCursor for ''' || SBSQL || ''' using ' || SBUSING || ';  END;';
        UT_TRACE.TRACE(SBRECORDBIND,1);
        EXECUTE IMMEDIATE SBRECORDBIND USING CUCURSOR;
        OCUDATACURSOR := CUCURSOR;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETORDERBYID;

    
    PROCEDURE GETORDERBYELEMENTCHPA
    (
        INUELEMENTID  IN IF_ASSIGNABLE.ID%TYPE,
        OCUDATACURSOR OUT CONSTANTS.TYREFCURSOR
    )
    IS
        SBORDERATTRIBUTES   GE_BOUTILITIES.STYSTATEMENT;
        SBSQL               GE_BOUTILITIES.STYSTATEMENT;
        SBORDERFROM              GE_BOUTILITIES.STYSTATEMENT;
        SBORDERWHERE             GE_BOUTILITIES.STYSTATEMENT;
        SBORDERIDPK         GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        SBCODE              IF_ASSIGNABLE.CODE%TYPE;
        SBRECORDBIND        GE_BOUTILITIES.STYSTATEMENT;
        CUCURSOR            CONSTANTS.TYREFCURSOR;
        SBUSING             GE_BOUTILITIES.STYSTATEMENT;
    BEGIN
        SBCODE := IF_BOBASICDATASERVICES.FSBGETCODEBYELEMENTID(INUELEMENTID);
        SBORDERIDPK := 'OR_ORDER.ORDER_ID || chr(32) || chr(45) || chr(32) || :inuElementId';

        GE_BOUTILITIES.ADDATTRIBUTE (SBORDERIDPK,'ORDER_ID_PK',SBORDERATTRIBUTES);
        FILLORDERATTRIBUTES(SBORDERATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (':isbCode','CODE',SBORDERATTRIBUTES);
                   
        SBORDERFROM := GSBORDERFROM;
        SBORDERWHERE := GSBORDERWHERE || CHR(10) ||'AND GE_SUBSCRIBER.subscriber_id(+) = OR_ORDER.subscriber_id'
                        ||CHR(10)||' AND OR_order.order_id IN (
            SELECT ORDER_id FROM OR_order_activity
            WHERE element_id = :inuElementId
           union
            SELECT ORDER_id FROM OR_order_items
            WHERE element_id = :inuElementId
        ) ';

        SBSQL := 'select distinct '|| SBORDERATTRIBUTES ||CHR(10)||
                 SBORDERFROM||CHR(10)||
                 SBORDERWHERE;
            
        SBUSING := INUELEMENTID || ', ' || INUELEMENTID || ', ''' || SBCODE || ''', ' || INUELEMENTID || ', ' || INUELEMENTID;

        SBRECORDBIND := 'BEGIN Open :cuCursor for ''' || SBSQL || ''' using ' || SBUSING || ';  END;';
        UT_TRACE.TRACE(SBRECORDBIND,5);
        EXECUTE IMMEDIATE SBRECORDBIND USING CUCURSOR;
        OCUDATACURSOR := CUCURSOR;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;

    END GETORDERBYELEMENTCHPA;
    
    PROCEDURE GETORDERBYELEMENTPACH
    (
        ISBORDERID     IN VARCHAR2,
        ONUELEMENTID     OUT IF_ASSIGNABLE.ID%TYPE
    )
    IS
        SBORDERATTRIBUTES          GE_BOUTILITIES.STYSTATEMENT;
        SBSQL                      GE_BOUTILITIES.STYSTATEMENT;
        SBFROM                     GE_BOUTILITIES.STYSTATEMENT;
        SBWHERE                    GE_BOUTILITIES.STYSTATEMENT;
    BEGIN
        IF INSTR(ISBORDERID, '-') != 0 THEN
            ONUELEMENTID := UT_STRING.EXTSTRFIELD(ISBORDERID,'-',2);
        END IF;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETORDERBYELEMENTPACH;
    


    





















































































































    PROCEDURE GETSEARCHORDERS
    (
        
        INUORDERID                IN OR_ORDER.ORDER_ID%TYPE,
        INUOPERATINGUNITID        IN OR_ORDER.OPERATING_UNIT_ID%TYPE,
        ISBIDENTIFSUBSCRIBERID    IN GE_SUBSCRIBER.IDENTIFICATION%TYPE,
        INUPACKAGEID              IN OR_ORDER_ACTIVITY.PACKAGE_ID%TYPE,
        IDTINITCREATEDDATE        IN OR_ORDER.CREATED_DATE%TYPE,
        IDTFINALCREATEDDATE       IN OR_ORDER.CREATED_DATE%TYPE,
        
        OCUCURSOR                 OUT CONSTANTS.TYREFCURSOR
    )
    IS
        NUORDERID                OR_ORDER.ORDER_ID%TYPE;
        NUOPERATINGUNITID        OR_ORDER.OPERATING_UNIT_ID%TYPE;
        SBIDENTIFSUBSCRIBERID    GE_SUBSCRIBER.IDENTIFICATION%TYPE;
        NUPACKAGEID              OR_EXTERN_SYSTEMS_ID.PACKAGE_ID%TYPE;
        SBHINTS                  GE_BOUTILITIES.STYSTATEMENT;
        SBORDERFROM              GE_BOUTILITIES.STYSTATEMENT;
        SBORDERWHERE             GE_BOUTILITIES.STYSTATEMENT;
        SBCURRENTSQL             GE_BOUTILITIES.STYSTATEMENT;
        SBORDERATTRIBUTES        GE_BOUTILITIES.STYSTATEMENT;
        NUPERSONA                GE_PERSON.PERSON_ID%TYPE;
        BLEXISUOBYPERSO          BOOLEAN;
        SBUSING                  GE_BOUTILITIES.STYSTATEMENT;
        SBRECORDBIND             GE_BOUTILITIES.STYSTATEMENT;
        CUCURSOR                 CONSTANTS.TYREFCURSOR;

    BEGIN
        
        SBIDENTIFSUBSCRIBERID := TRIM (CC_BOBOSSUTIL.FSBFIXCRITERION (ISBIDENTIFSUBSCRIBERID));
        BLEXISUOBYPERSO := FALSE; 
        
        NUPERSONA    := GE_BOPERSONAL.FNUGETPERSONID;

        
        IF NUPERSONA IS NOT NULL THEN
            BLEXISUOBYPERSO := OR_BOOPERUNITPERSON.FBLEXISTUNIOPERBYPERS(NUPERSONA);
        END IF;

        
        NUORDERID   := INUORDERID;
        NUOPERATINGUNITID := INUOPERATINGUNITID;
        NUPACKAGEID := INUPACKAGEID;

       
        FILLORDERATTRIBUTES(SBORDERATTRIBUTES);
        SBORDERFROM := GSBORDERFROM || CHR(10) || ', OR_OPERATING_UNIT, OR_OPER_UNIT_STATUS';
        SBORDERWHERE := GSBORDERWHERE;
        SBUSING := GE_BOUTILITIES.CSBNULLSTRING;

        
        IF SBIDENTIFSUBSCRIBERID IS NOT NULL THEN
            IF NUORDERID IS NULL AND NUPACKAGEID IS NULL AND NUOPERATINGUNITID IS NULL THEN
                SBHINTS := SBHINTS || ' leading(ge_subscriber OR_order) index(OR_ORDER IX_OR_ORDER14) ';
            END IF;
            SBORDERWHERE := SBORDERWHERE||CHR(10)||' AND GE_SUBSCRIBER.subscriber_id = OR_ORDER.subscriber_id';
            SBORDERWHERE := SBORDERWHERE||CHR(10)||' AND GE_SUBSCRIBER.IDENTIFICATION = :sbIdentifSubscriberId ' ;
            SBUSING      := SBUSING || ', ''' || SBIDENTIFSUBSCRIBERID || '''';
        ELSE
            SBORDERWHERE := SBORDERWHERE||CHR(10)||' AND GE_SUBSCRIBER.subscriber_id(+) = OR_ORDER.subscriber_id';
        END IF;

       

        
        IF BLEXISUOBYPERSO THEN
            
            IF (DAGE_PERSON.FNUGETPERSONAL_TYPE(NUPERSONA) != OR_BCSCHED.GNUSUPERVISORPERSONAL
                AND NOT OR_BCOPERUNITPERSON.FBLISDISPATCHPERSON(NUPERSONA)) THEN

                
                
                SBORDERWHERE := SBORDERWHERE||CHR(10)||' AND ( OR_ORDER.OPERATING_SECTOR_ID IS NULL OR
                exists (
                    SELECT /*+ ordered */ ge_sectorope_zona.id_sector_operativo
                    FROM or_oper_unit_persons, OR_operating_unit, or_zona_base_adm, ge_sectorope_zona
                    WHERE or_oper_unit_persons.operating_unit_id = OR_operating_unit.operating_unit_id
                    AND OR_operating_unit.admin_base_id = or_zona_base_adm.id_base_administra
                    AND or_zona_base_adm.operating_zone_id = ge_sectorope_zona.id_zona_operativa
                    AND or_oper_unit_persons.person_id = :nuPersona
                    AND ge_sectorope_zona.id_sector_operativo = OR_ORDER.OPERATING_SECTOR_ID
                    )  OR exists (
                        SELECT /*+ index(or_oper_unit_persons IDX_OR_OPER_UNIT_PERSONS_01) */ 1
                        FROM or_oper_unit_persons
                        WHERE or_oper_unit_persons.person_id = :nuPersona
                        AND OR_order.operating_unit_id = or_oper_unit_persons.operating_unit_id
                        AND OR_order.order_status_id = :cnuORDER_STAT_ASSIGNED
                    )
                )';
                SBUSING      := SBUSING || ', ' || NUPERSONA || ', ' || NUPERSONA || ', ' || OR_BOCONSTANTS.CNUORDER_STAT_ASSIGNED;

                
                SBORDERWHERE := SBORDERWHERE||CHR(10)||' AND exists (
                    SELECT task_type_id FROM or_oper_unit_persons, or_ope_uni_task_type
                    WHERE or_oper_unit_persons.operating_unit_id = or_ope_uni_task_type.operating_unit_id
                    AND person_id = :nuPersona
                    AND or_ope_uni_task_type.task_type_id = OR_ORDER.TASK_TYPE_ID
                    ) ';
                SBUSING      := SBUSING || ', ' || NUPERSONA;
                
            END IF;
        END IF;

        IF NUORDERID IS NOT NULL THEN
            SBHINTS := SBHINTS || ' index(or_order pk_or_order) ';
            SBORDERWHERE := SBORDERWHERE||CHR(10)||' AND OR_ORDER.ORDER_ID = :nuOrderId ';
            SBUSING      := SBUSING || ', ' || NUORDERID;
        END IF;

        IF (IDTINITCREATEDDATE IS NOT NULL OR IDTFINALCREATEDDATE IS NOT NULL)
            
            AND (NUORDERID IS NULL AND NUPACKAGEID IS NULL AND NUOPERATINGUNITID IS NULL) THEN
                ERRORS.SETERROR (CNUNULL_ATTRIBUTE, 'Unidad de Trabajo');
                RAISE EX.CONTROLLED_ERROR;
        END IF;

        IF NUOPERATINGUNITID IS NOT NULL THEN

        UT_TRACE.TRACE('Pasando por aqui nuOrderId[' ||NUORDERID||']nuPackageId['||NUPACKAGEID||']idtInitCreatedDate['||IDTINITCREATEDDATE||']idtFinalCreatedDate['||IDTFINALCREATEDDATE,10 );
            IF NUORDERID IS NULL AND NUPACKAGEID IS NULL THEN
                

                
                IF (IDTINITCREATEDDATE IS NULL) THEN
                    ERRORS.SETERROR (CNUNULL_ATTRIBUTE, 'Fecha Inicial de Creaci?n');
                    RAISE EX.CONTROLLED_ERROR;
                END IF;
                
                IF (IDTFINALCREATEDDATE IS NULL) THEN
                    ERRORS.SETERROR (CNUNULL_ATTRIBUTE, 'Fecha Final de Creaci?n');
                    RAISE EX.CONTROLLED_ERROR;
                END IF;

                
                IF(IDTINITCREATEDDATE > IDTFINALCREATEDDATE) THEN
                    ERRORS.SETERROR (16682);
                    RAISE EX.CONTROLLED_ERROR;
                END IF;
                
            END IF;
            SBORDERWHERE := SBORDERWHERE||CHR(10)||' AND OR_OPERATING_UNIT.operating_unit_id = OR_ORDER.operating_unit_id';
            SBORDERWHERE := SBORDERWHERE||CHR(10)||' AND OR_OPERATING_UNIT.oper_unit_status_id =  OR_OPER_UNIT_STATUS.oper_unit_status_id';
            SBORDERWHERE := SBORDERWHERE||CHR(10)||' AND OR_ORDER.OPERATING_UNIT_ID = :nuOperatingUnitId ';
            SBORDERWHERE := SBORDERWHERE||CHR(10)||' AND OR_ORDER.ORDER_STATUS_ID IN (5,6,7) ';
            SBUSING := SBUSING || ', ' || NUOPERATINGUNITID;
            
            IF ( (IDTINITCREATEDDATE IS NOT NULL) AND (IDTFINALCREATEDDATE IS NOT NULL)) THEN
            
                SBORDERWHERE := SBORDERWHERE||CHR(10)||' AND TRUNC(OR_ORDER.CREATED_DATE) BETWEEN :initDate AND :FinalDate';

                SBUSING := SBUSING || ', ut_date.fdtdatewithformat(''' || TO_CHAR(IDTINITCREATEDDATE, 'DD/MM/YYYY')||''') , ut_date.fdtdatewithformat(''' || TO_CHAR(IDTFINALCREATEDDATE, 'DD/MM/YYYY')||''') ' ;
                 
            END IF;
            
        ELSE
            SBORDERWHERE := SBORDERWHERE||CHR(10)||' AND OR_OPERATING_UNIT.operating_unit_id(+) = OR_ORDER.operating_unit_id';
            SBORDERWHERE := SBORDERWHERE||CHR(10)||' AND OR_OPERATING_UNIT.oper_unit_status_id =  OR_OPER_UNIT_STATUS.oper_unit_status_id(+)';
        END IF;

        IF NUPACKAGEID IS NOT NULL THEN
            IF NUORDERID IS NULL THEN
                SBHINTS := SBHINTS || ' leading (or_order_activity OR_order) ';
            END IF;
            SBORDERFROM := SBORDERFROM || ', OR_ORDER_ACTIVITY ';
            SBORDERWHERE := SBORDERWHERE||CHR(10)||' AND OR_ORDER.ORDER_ID = OR_ORDER_ACTIVITY.ORDER_ID';
            SBORDERWHERE := SBORDERWHERE||CHR(10)||' AND OR_ORDER_ACTIVITY.PACKAGE_ID = :nuPackageId ';
            SBUSING := SBUSING || ', ' || NUPACKAGEID;
            
            SBORDERWHERE := SBORDERWHERE || CHR(10) || ' AND NOT exists(
                    SELECT 1 FROM CT_ITEM_NOVELTY
                    WHERE  CT_ITEM_NOVELTY.items_id = OR_ORDER_ACTIVITY.activity_id
                    AND    rownum = 1
                )';
        ELSE
            
            SBORDERWHERE := SBORDERWHERE || CHR(10) || ' AND NOT exists(
            SELECT 1 FROM OR_ORDER_ACTIVITY WHERE exists (
                SELECT 1 FROM CT_ITEM_NOVELTY
                WHERE  CT_ITEM_NOVELTY.items_id = OR_ORDER_ACTIVITY.activity_id
                AND    rownum = 1
            )
            AND  OR_ORDER_ACTIVITY.ORDER_ID = OR_ORDER.ORDER_ID)';
        END IF;
        
        
        SBCURRENTSQL := 'select /*+' || SBHINTS ||'*/ distinct '|| SBORDERATTRIBUTES  ||CHR(10)||
                          SBORDERFROM                 ||CHR(10)||
                          ' /*+ Ubicaci?n : OR_boSearchDataServices.GetSearchOrders SAO302697 */ '||CHR(10)||
                          SBORDERWHERE;

        SBRECORDBIND := 'BEGIN Open :cuCursor for ''' || SBCURRENTSQL || ''' using ' || SBUSING || ';  END;';
        TRACE('sbCurrentSql: '||SBRECORDBIND, 1);
        EXECUTE IMMEDIATE SBRECORDBIND USING CUCURSOR;
        
        OCUCURSOR := CUCURSOR;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETSEARCHORDERS;
    

    


















    PROCEDURE GETSEARCHNTLORDERS
    (
        
        INUORDERID                IN OR_ORDER.ORDER_ID%TYPE,
        
        OCUCURSOR                 OUT CONSTANTS.TYREFCURSOR
    )
    IS
        NUORDERID                OR_ORDER.ORDER_ID%TYPE;

        SBORDERFROM              GE_BOUTILITIES.STYSTATEMENT;
        SBORDERWHERE             GE_BOUTILITIES.STYSTATEMENT;
        SBCURRENTSQL             GE_BOUTILITIES.STYSTATEMENT;
        SBORDERATTRIBUTES        GE_BOUTILITIES.STYSTATEMENT;

        SBUSING                  GE_BOUTILITIES.STYSTATEMENT;
        SBRECORDBIND             GE_BOUTILITIES.STYSTATEMENT;
        
        CUCURSOR                 CONSTANTS.TYREFCURSOR;
    BEGIN

        
        NUORDERID   := INUORDERID;

        
        FILLORDERATTRIBUTES(SBORDERATTRIBUTES);
        SBUSING := GE_BOUTILITIES.CSBNULLSTRING;

        
        SBORDERFROM := GSBORDERFROM;
        SBORDERWHERE := GSBORDERWHERE || CHR(10) ||'AND GE_SUBSCRIBER.subscriber_id(+) = OR_ORDER.subscriber_id'
                        ||CHR(10)||' AND OR_ORDER.ORDER_ID = OR_ORDER.ORDER_ID';


        
        SBORDERWHERE := SBORDERWHERE||CHR(10)||' AND OR_ORDER.ORDER_ID = :nuOrderId ';
        SBUSING      := SBUSING || ', ' || NUORDERID;
        
        
        SBCURRENTSQL := 'select distinct '|| SBORDERATTRIBUTES  ||CHR(10)||
                         SBORDERFROM                 ||CHR(10)||
                          ' /*+ Ubicaci?n : OR_boSearchDataServices.GetSearchNTLOrders SAO 181636 */ '||CHR(10)||
                         SBORDERWHERE;

        TRACE('sbCurrentSql: '||SBRECORDBIND, 1);
        SBRECORDBIND := 'BEGIN Open :cuCursor for ''' || SBCURRENTSQL || ''' using ' || SBUSING || ';  END;';
        TRACE('sbCurrentSql: '||SBRECORDBIND, 1);
        EXECUTE IMMEDIATE SBRECORDBIND USING CUCURSOR;

        OCUCURSOR := CUCURSOR;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETSEARCHNTLORDERS;
   
    



















 
    PROCEDURE GETORDERSBYNTL
    (
        INUPOSSIBLENTL            IN  FM_POSSIBLE_NTL.POSSIBLE_NTL_ID%TYPE,
        OCUCURSOR                 OUT CONSTANTS.TYREFCURSOR
    )
    IS
    
        SBORDERFROM              GE_BOUTILITIES.STYSTATEMENT;
        SBORDERWHERE             GE_BOUTILITIES.STYSTATEMENT;
        SBORDERATTRIBUTES        GE_BOUTILITIES.STYSTATEMENT;
    
        SBQUERY                  GE_BOUTILITIES.STYSTATEMENT;
        
        SBUSING                  GE_BOUTILITIES.STYSTATEMENT;
        SBRECORDBIND             GE_BOUTILITIES.STYSTATEMENT;

        CUCURSOR                 CONSTANTS.TYREFCURSOR;

    BEGIN
    
        UT_TRACE.TRACE('Inicio GetOrdersByNTL', 1);

        
        FILLORDERATTRIBUTES(SBORDERATTRIBUTES);

        
        SBORDERFROM  := GSBORDERFROM || ', fm_possible_ntl, mo_packages, or_order_activity';
        SBORDERWHERE := GSBORDERWHERE || CHR(10) ||'AND GE_SUBSCRIBER.subscriber_id(+) = OR_ORDER.subscriber_id'
                        ||CHR(10)||'AND fm_possible_ntl.package_id = mo_packages.package_id (+)'||CHR(10)||
                 'AND or_order.order_id = or_order_activity.order_id'||CHR(10)||
                 'AND (fm_possible_ntl.order_id = or_order.order_id OR '||CHR(10)||
                      'or_order_activity.package_id = mo_packages.package_id) '||CHR(10)||
                 'AND fm_possible_ntl.possible_ntl_id = :inuPossibleNtl';
                 
        SBUSING := INUPOSSIBLENTL||' ,'||INUPOSSIBLENTL;
        
        







        SBQUERY := 'select distinct '|| SBORDERATTRIBUTES  ||CHR(10)||
                          SBORDERFROM ||CHR(10)||
                          ' /*+ Ubicaci?n : OR_boSearchDataServices.GetOrdersByNTL */ '||CHR(10)||
                          SBORDERWHERE;
                         
        UT_TRACE.TRACE('sbQuery1 - '||SUBSTR(SBQUERY, 0, LENGTH(SBQUERY)/2), 1);
        UT_TRACE.TRACE('sbQuery2 - '||SUBSTR(SBQUERY, LENGTH(SBQUERY)/2), 1);
        UT_TRACE.TRACE('opening cursor', 1);

        SBRECORDBIND := 'BEGIN Open :cuCursor for ''' || SBQUERY || ''' using ' || SBUSING || ';  END;';
        TRACE('sbCurrentSql: '||SBRECORDBIND, 1);
        EXECUTE IMMEDIATE SBRECORDBIND USING CUCURSOR;

        OCUCURSOR := CUCURSOR;
        
        UT_TRACE.TRACE('fin GetOrdersByNTL', 1);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;
    
    
















 
    PROCEDURE GETORDERPOSSIBLENTL
    (
        INUORDERID      IN      OR_ORDER.ORDER_ID%TYPE,
        ONUPOSSIBLENTL  OUT     FM_POSSIBLE_NTL.POSSIBLE_NTL_ID%TYPE
    )
    IS
    BEGIN
    
        SELECT FM_POSSIBLE_NTL.POSSIBLE_NTL_ID INTO ONUPOSSIBLENTL
        FROM FM_POSSIBLE_NTL
        WHERE FM_POSSIBLE_NTL.ORDER_ID = INUORDERID;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    
    PROCEDURE GETSEARCHORDERSELEMENT
    (
        INUORDERID                IN OR_ORDER.ORDER_ID%TYPE,
        INUTASKTYPE               IN OR_ORDER.TASK_TYPE_ID%TYPE,
        ISBNUMSEQ                 IN VARCHAR2,
        INUORDERSTATUS            IN OR_ORDER.ORDER_STATUS_ID%TYPE,
        IDTINITLEGALIZDATE        IN OR_ORDER.LEGALIZATION_DATE%TYPE,
        IDTFINALLEGALIZDATE       IN OR_ORDER.LEGALIZATION_DATE%TYPE,
        IDTINITASSIGNDATE         IN OR_ORDER.ASSIGNED_DATE%TYPE,
        IDTFINALASSIGNDATE        IN OR_ORDER.ASSIGNED_DATE%TYPE,
        OCUCURSOR                 OUT CONSTANTS.TYREFCURSOR
    )
    IS
        SBNUMSEQ                 GE_BOUTILITIES.STYSBINPUTSEARCH;
        NUORDERID                OR_ORDER.ORDER_ID%TYPE;
        NUTASKTYPE               OR_ORDER.TASK_TYPE_ID%TYPE;
        NUORDERSTATUS            OR_ORDER.ORDER_STATUS_ID%TYPE;
        DTINITLEGALIZDATE        OR_ORDER.LEGALIZATION_DATE%TYPE;
        DTFINALLEGALIZDATE       OR_ORDER.LEGALIZATION_DATE%TYPE;
        DTINITASSIGNDATE         OR_ORDER.ASSIGNED_DATE%TYPE;
        DTFINALASSIGNDATE        OR_ORDER.ASSIGNED_DATE%TYPE;
        NUNUMERATOR              OR_ORDER.NUMERATOR_ID%TYPE;
        NUSEQUENCE               OR_ORDER.SEQUENCE%TYPE;

        SBORDERFROM              GE_BOUTILITIES.STYSTATEMENT;
        SBORDERWHERE             GE_BOUTILITIES.STYSTATEMENT;
        SBCURRENTSQL             GE_BOUTILITIES.STYSTATEMENT;
        SBORDERATTRIBUTES        GE_BOUTILITIES.STYSTATEMENT;
        SBORDERIDPK              GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;

        FBLDATELEGA              BOOLEAN :=  TRUE;
        FBLDATEASSIGN            BOOLEAN :=  TRUE;
        
        SBUSING                  GE_BOUTILITIES.STYSTATEMENT;
        SBRECORDBIND             GE_BOUTILITIES.STYSTATEMENT;
        CUCURSOR                 CONSTANTS.TYREFCURSOR;

    BEGIN
        
        SBNUMSEQ:= TRIM(CC_BOBOSSUTIL.FSBFIXCRITERION (ISBNUMSEQ));

        
        GE_BOUTILITIES.VALIDDATE(IDTINITLEGALIZDATE, IDTFINALLEGALIZDATE);
        GE_BOUTILITIES.VALIDDATE(IDTINITASSIGNDATE, IDTFINALASSIGNDATE);
        
        IF  IDTINITLEGALIZDATE  IS NULL AND
            IDTFINALLEGALIZDATE IS NULL
        THEN
            FBLDATELEGA := FALSE;
        END IF;
        
        IF  IDTINITASSIGNDATE   IS NULL AND
            IDTFINALASSIGNDATE  IS NULL
        THEN
            FBLDATEASSIGN := FALSE;
        END IF;
        
        
        DTINITLEGALIZDATE    := NVL (TO_DATE(UT_DATE.FSBSTR_DATE(IDTINITLEGALIZDATE),UT_DATE.FSBDATE_FORMAT), UT_DATE.FDTMINDATE);
        DTFINALLEGALIZDATE   := NVL (TO_DATE(UT_DATE.FSBSTR_DATE(IDTFINALLEGALIZDATE),UT_DATE.FSBDATE_FORMAT), UT_DATE.FDTMAXDATE);
        DTINITASSIGNDATE     := NVL (TO_DATE(UT_DATE.FSBSTR_DATE(IDTINITASSIGNDATE),UT_DATE.FSBDATE_FORMAT), UT_DATE.FDTMINDATE);
        DTFINALASSIGNDATE    := NVL (TO_DATE(UT_DATE.FSBSTR_DATE(IDTFINALASSIGNDATE),UT_DATE.FSBDATE_FORMAT), UT_DATE.FDTMAXDATE);

        
        NUORDERID   := INUORDERID;
        NUTASKTYPE := INUTASKTYPE;
        NUORDERSTATUS := INUORDERSTATUS;
        SBUSING := GE_BOUTILITIES.CSBNULLSTRING;
        
        
        SBORDERIDPK := 'OR_ORDER.ORDER_ID || chr(32) || chr(45) || chr(32) || IF_ASSIGNABLE.ID';
        GE_BOUTILITIES.ADDATTRIBUTE (SBORDERIDPK,'ORDER_ID_PK',SBORDERATTRIBUTES);
        FILLORDERATTRIBUTES (SBORDERATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE ('IF_ASSIGNABLE.CODE','CODE',SBORDERATTRIBUTES);


        SBORDERFROM := GSBORDERFROM ||', OR_order_activity, OR_order_items, IF_assignable ' ;
        SBORDERWHERE := GSBORDERWHERE || CHR(10) ||'AND GE_SUBSCRIBER.subscriber_id(+) = OR_ORDER.subscriber_id'
                        ||CHR(10)|| ' AND
            OR_order.order_id = or_order_activity.order_id
            AND OR_order.order_Id = OR_order_items.order_Id
            AND ( OR_order_activity.order_item_id = or_order_items.order_items_id
                OR OR_order_activity.order_activity_id = OR_order_items.order_activity_id )
            AND IF_assignable.id IN (or_order_activity.element_id, OR_order_items.element_id)
            AND IF_assignable.element_type_id IN (
                SELECT element_type_id FROM IF_element_type
                WHERE IS_measurable = CHR(89))' ;


       
        IF NUORDERID IS NOT NULL THEN
            SBORDERWHERE := SBORDERWHERE||CHR(10)||
                            'AND OR_order.order_id = :nuOrderId';
            SBUSING      := SBUSING || ', ' || NUORDERID;
        END IF;


        IF NUTASKTYPE IS NOT NULL THEN
            SBORDERWHERE := SBORDERWHERE||CHR(10)||
                            ' AND OR_ORDER.TASK_TYPE_ID = :nuTaskType';
            SBUSING      := SBUSING || ', ' || NUTASKTYPE;
        END IF;

        IF SBNUMSEQ IS NOT NULL THEN

            GETNUMBERANDSEQ(SBNUMSEQ , NUNUMERATOR,NUSEQUENCE);

            IF NUNUMERATOR IS NOT NULL AND NUSEQUENCE IS NOT NULL THEN

                SBORDERWHERE := SBORDERWHERE||CHR(10)||
                                ' AND OR_ORDER.NUMERATOR_ID = :nuNumerator'||CHR(10)||
                                ' AND OR_ORDER.SEQUENCE = :nuSequence';
                SBUSING      := SBUSING || ', ' || NUNUMERATOR;
                SBUSING      := SBUSING || ', ' || NUSEQUENCE;
            END IF;
        END IF;

        IF NUORDERSTATUS IS NOT NULL THEN
            SBORDERWHERE := SBORDERWHERE||CHR(10)||
                            ' AND OR_ORDER.ORDER_STATUS_ID =  :nuOrderStatus'||CHR(10);
            SBUSING      := SBUSING || ', ' || NUORDERSTATUS;
        END IF;

        
        IF FBLDATELEGA THEN
            SBORDERWHERE := SBORDERWHERE ||CHR(10)||' and OR_ORDER.LEGALIZATION_DATE >= to_date(:dtInitLegalizDate, ut_date.fsbDATE_FORMAT) ';
            SBORDERWHERE := SBORDERWHERE ||CHR(10)||' and OR_ORDER.LEGALIZATION_DATE <= to_date(:dtFinalLegalizDate, ut_date.fsbDATE_FORMAT) ';
            SBUSING      := SBUSING || ', ''' || TO_CHAR(DTINITLEGALIZDATE, UT_DATE.FSBDATE_FORMAT) || '''';
            SBUSING      := SBUSING || ', ''' || TO_CHAR(DTFINALLEGALIZDATE, UT_DATE.FSBDATE_FORMAT) || '''';
        END IF;
        
        IF FBLDATEASSIGN THEN
            SBORDERWHERE := SBORDERWHERE ||CHR(10)||' and OR_ORDER.ASSIGNED_DATE >= to_date(:dtInitAssignDate, ut_date.fsbDATE_FORMAT) ';
            SBORDERWHERE := SBORDERWHERE ||CHR(10)||' and OR_ORDER.ASSIGNED_DATE <= to_date(:dtFinalAssignDate, ut_date.fsbDATE_FORMAT) ';
            SBUSING      := SBUSING || ', ''' || TO_CHAR(DTINITASSIGNDATE, UT_DATE.FSBDATE_FORMAT) || '''';
            SBUSING      := SBUSING || ', ''' || TO_CHAR(DTFINALASSIGNDATE, UT_DATE.FSBDATE_FORMAT) || '''';
        END IF;


        
        SBCURRENTSQL := 'select distinct '|| SBORDERATTRIBUTES  ||CHR(10)||
                          SBORDERFROM        ||CHR(10)||
                         SBORDERWHERE;
       
        TRACE('sbCurrentSql: '||SBRECORDBIND, 1);
        SBRECORDBIND := 'BEGIN Open :cuCursor for ''' || SBCURRENTSQL || ''' using ' || SBUSING || ';  END;';
        TRACE('sbCurrentSql: '||SBRECORDBIND, 1);
        EXECUTE IMMEDIATE SBRECORDBIND USING CUCURSOR;

        OCUCURSOR := CUCURSOR;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;

    END GETSEARCHORDERSELEMENT;




    






















    PROCEDURE GETSTATCHANGEBYORDERID
    (
        ISBORDERID     IN VARCHAR2,
        OCUDATACURSOR  OUT CONSTANTS.TYREFCURSOR
    )
    IS

      NUORDERID OR_ORDER.ORDER_ID%TYPE;

       BEGIN

        IF INSTR(ISBORDERID, '-') != 0 THEN
            NUORDERID := TO_NUMBER(UT_STRING.EXTSTRFIELD(ISBORDERID,'-',1));
        ELSE
            NUORDERID := TO_NUMBER(ISBORDERID);
        END IF;

        OPEN OCUDATACURSOR FOR
            SELECT OR_ORDER_STAT_CHANGE.ORDER_STAT_CHANGE_ID ORDER_STAT_CHANGE_ID,
                   OR_ORDER_STAT_CHANGE.ORDER_ID ORDER_ID,
                   OR_ORDER_STAT_CHANGE.ACTION_ID||' - '||GE_ACTION_MODULE.DESCRIPTION ACTION,
                   OR_ORDER_STAT_CHANGE.INITIAL_STATUS_ID||' - '||INITIAL_ORDER_STATUS.DESCRIPTION INITIAL_STATUS,
                   OR_ORDER_STAT_CHANGE.FINAL_STATUS_ID||' - '||FINAL_ORDER_STATUS.DESCRIPTION FINAL_STATUS,
                   OR_ORDER_STAT_CHANGE.USER_ID USER_ID,
                   GE_BCORGANIZAT_AREA.FSBOBTORGANAREAUSUARIO(OR_ORDER_STAT_CHANGE.USER_ID) ORGANIZAT_AREA,
                   OR_ORDER_STAT_CHANGE.TERMINAL TERMINAL,
                   OR_ORDER_STAT_CHANGE.STAT_CHG_DATE STAT_CHG_DATE,
                   OR_ORDER_STAT_CHANGE.EXECUTION_DATE EXECUTION_DATE,
                   OR_ORDER_STAT_CHANGE.RANGE_DESCRIPTION RANGE_DESCRIPTION,
                   DECODE(OR_ORDER_STAT_CHANGE.PROGRAMING_CLASS_ID, NULL, NULL,
                          OR_PROGRAMING_CLASS.PREFIX||' - '||OR_PROGRAMING_CLASS.SHORT_NAME) PROGRAMING_CLASS,
                   DECODE(OR_ORDER_STAT_CHANGE.INITIAL_OPER_UNIT_ID, NULL, NULL,
                          OR_ORDER_STAT_CHANGE.INITIAL_OPER_UNIT_ID||' - '||INITIAL_OPER_UNIT.NAME) INITIAL_OPER_UNIT,
                   DECODE(OR_ORDER_STAT_CHANGE.FINAL_OPER_UNIT_ID, NULL, NULL,
                          OR_ORDER_STAT_CHANGE.FINAL_OPER_UNIT_ID||' - '||FINAL_OPER_UNIT.NAME) FINAL_OPER_UNIT,
                   DECODE(OR_ORDER_STAT_CHANGE.COMMENT_TYPE_ID, NULL, NULL,
                          OR_ORDER_STAT_CHANGE.COMMENT_TYPE_ID||' - '||GE_COMMENT_TYPE.DESCRIPTION) COMMENT_TYPE,
                   DECODE(OR_ORDER_STAT_CHANGE.CAUSAL_ID, NULL, NULL,
                          OR_ORDER_STAT_CHANGE.CAUSAL_ID||' - '||GE_CAUSAL_TYPE.DESCRIPTION) CAUSAL,
                   ISBORDERID PARENT_ID
              FROM OR_ORDER_STAT_CHANGE,
                   OR_ORDER_STATUS INITIAL_ORDER_STATUS,
                   OR_ORDER_STATUS FINAL_ORDER_STATUS,
                   GE_ACTION_MODULE,
                   OR_PROGRAMING_CLASS,
                   OR_OPERATING_UNIT INITIAL_OPER_UNIT,
                   OR_OPERATING_UNIT FINAL_OPER_UNIT,
                   GE_COMMENT_TYPE,
                   GE_CAUSAL,
                   GE_CAUSAL_TYPE
                   /*+ OR_boSearchDataServices.GetStatChangeByOrderId SAO170083 */
             WHERE INITIAL_ORDER_STATUS.ORDER_STATUS_ID = OR_ORDER_STAT_CHANGE.INITIAL_STATUS_ID
               AND FINAL_ORDER_STATUS.ORDER_STATUS_ID = OR_ORDER_STAT_CHANGE.FINAL_STATUS_ID
               AND GE_ACTION_MODULE.ACTION_ID = OR_ORDER_STAT_CHANGE.ACTION_ID
               AND OR_PROGRAMING_CLASS.PROGRAMING_CLASS_ID (+) = OR_ORDER_STAT_CHANGE.PROGRAMING_CLASS_ID
               AND INITIAL_OPER_UNIT.OPERATING_UNIT_ID (+) = OR_ORDER_STAT_CHANGE.INITIAL_OPER_UNIT_ID
               AND FINAL_OPER_UNIT.OPERATING_UNIT_ID (+) = OR_ORDER_STAT_CHANGE.FINAL_OPER_UNIT_ID
               AND GE_COMMENT_TYPE.COMMENT_TYPE_ID (+) = OR_ORDER_STAT_CHANGE.COMMENT_TYPE_ID
               AND GE_CAUSAL.CAUSAL_ID (+) = OR_ORDER_STAT_CHANGE.CAUSAL_ID
               AND GE_CAUSAL_TYPE.CAUSAL_TYPE_ID (+) = GE_CAUSAL.CAUSAL_TYPE_ID
               AND OR_ORDER_STAT_CHANGE.ORDER_ID = NUORDERID
          ORDER BY OR_ORDER_STAT_CHANGE.STAT_CHG_DATE;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETSTATCHANGEBYORDERID;






























    PROCEDURE GETCOMMENTBYORDERID
    (
        ISBORDERID IN VARCHAR2,
        OCUDATACURSOR  OUT CONSTANTS.TYREFCURSOR
    )
    IS

      SBSQL    GE_BOUTILITIES.STYSTATEMENT;
      NUORDERID OR_ORDER.ORDER_ID%TYPE;
      SBCOMMENTBYORDERATTRIBUTES               GE_BOUTILITIES.STYSTATEMENT;
      SBCOMMENTBYACTIVITYATTRIBUTES            GE_BOUTILITIES.STYSTATEMENT;
      SBCOMMENTBYREQUACTIVATTRIBUTES           GE_BOUTILITIES.STYSTATEMENT;
      
      PROCEDURE FILLCOMMENTBYORDERATTRIBUTES
      IS
          SBCOMMENTTYPE         GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
          SBORORDERCOMMENTID    GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
          SBPERSONID            GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
      BEGIN

          IF SBCOMMENTBYORDERATTRIBUTES IS NOT NULL THEN
              RETURN;
          END IF;

          UT_TRACE.TRACE('INICIO - FillCommentByOrderAttributes', 12);

          
          SBCOMMENTTYPE := 'OR_ORDER_COMMENT.COMMENT_TYPE_ID'||GE_BOUTILITIES.CSBSEPARATOR ||'Ge_boBasicDataServices.fsbGetDescCommentType(OR_ORDER_COMMENT.COMMENT_TYPE_ID)';
          SBORORDERCOMMENTID := 'OR_ORDER_COMMENT.ORDER_COMMENT_ID'||GE_BOUTILITIES.CSBSEPARATOR ||'''OR_ORDER_COMMENT''';
          SBPERSONID := 'OR_ORDER_COMMENT.PERSON_ID'||GE_BOUTILITIES.CSBSEPARATOR ||' (select name_ FROM ge_person WHERE ge_person.person_id = OR_ORDER_COMMENT.Person_id)';
          
          
          GE_BOUTILITIES.ADDATTRIBUTE (SBORORDERCOMMENTID,'ORDER_COMMENT_ID',SBCOMMENTBYORDERATTRIBUTES);
          GE_BOUTILITIES.ADDATTRIBUTE ('OR_ORDER_COMMENT.REGISTER_DATE','REGISTER_DATE',SBCOMMENTBYORDERATTRIBUTES);
          GE_BOUTILITIES.ADDATTRIBUTE (SBCOMMENTTYPE,'COMMENT_TYPE',SBCOMMENTBYORDERATTRIBUTES);
          GE_BOUTILITIES.ADDATTRIBUTE ('OR_ORDER_COMMENT.ORDER_COMMENT','ORDER_COMMENT',SBCOMMENTBYORDERATTRIBUTES);
          GE_BOUTILITIES.ADDATTRIBUTE ('OR_ORDER_COMMENT.ORDER_ID','ORDER_ID',SBCOMMENTBYORDERATTRIBUTES); 
          GE_BOUTILITIES.ADDATTRIBUTE (SBPERSONID,'PERSON_ID',SBCOMMENTBYORDERATTRIBUTES);
          GE_BOUTILITIES.ADDATTRIBUTE (':parent_id','parent_id',SBCOMMENTBYORDERATTRIBUTES);
          
          UT_TRACE.TRACE('FIN - FillCommentByOrderAttributes', 12);

      EXCEPTION
          WHEN EX.CONTROLLED_ERROR THEN
              RAISE EX.CONTROLLED_ERROR;
          WHEN OTHERS THEN
              ERRORS.SETERROR;
              RAISE EX.CONTROLLED_ERROR;
      END FILLCOMMENTBYORDERATTRIBUTES;
      
      PROCEDURE FILLCOMMBYACTIVITYATTRIB
      IS

          SBCOMMENTTYPE         GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
          SBORORDERACTIVITYID   GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;

      BEGIN

          IF SBCOMMENTBYACTIVITYATTRIBUTES IS NOT NULL THEN
              RETURN;
          END IF;

          UT_TRACE.TRACE('INICIO - FillCommByActivityAttrib', 12);
          
          
          SBCOMMENTTYPE := ' ''30'' '||GE_BOUTILITIES.CSBSEPARATOR ||'Ge_boBasicDataServices.fsbGetDescCommentType(30)';
          SBORORDERACTIVITYID := 'OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID'||GE_BOUTILITIES.CSBSEPARATOR ||'''OR_ORDER_ACTIVITY''';
          
          
          GE_BOUTILITIES.ADDATTRIBUTE (SBORORDERACTIVITYID,'ORDER_COMMENT_ID',SBCOMMENTBYACTIVITYATTRIBUTES);
          GE_BOUTILITIES.ADDATTRIBUTE ('OR_boBasicDataServices.fdtGetOrderCreateDate(OR_ORDER_ACTIVITY.ORDER_ID)','REGISTER_DATE',SBCOMMENTBYACTIVITYATTRIBUTES);
          GE_BOUTILITIES.ADDATTRIBUTE (SBCOMMENTTYPE,'COMMENT_TYPE',SBCOMMENTBYACTIVITYATTRIBUTES);
          GE_BOUTILITIES.ADDATTRIBUTE ('OR_ORDER_ACTIVITY.COMMENT_','ORDER_COMMENT',SBCOMMENTBYACTIVITYATTRIBUTES);
          GE_BOUTILITIES.ADDATTRIBUTE ('OR_ORDER_ACTIVITY.ORDER_ID','ORDER_ID',SBCOMMENTBYACTIVITYATTRIBUTES); 
          GE_BOUTILITIES.ADDATTRIBUTE ('NULL','PERSON_ID',SBCOMMENTBYACTIVITYATTRIBUTES);
          GE_BOUTILITIES.ADDATTRIBUTE (':parent_id','parent_id',SBCOMMENTBYACTIVITYATTRIBUTES);
          
          UT_TRACE.TRACE('FIN - FillCommByActivityAttrib', 12);

      EXCEPTION
          WHEN EX.CONTROLLED_ERROR THEN
              RAISE EX.CONTROLLED_ERROR;
          WHEN OTHERS THEN
              ERRORS.SETERROR;
              RAISE EX.CONTROLLED_ERROR;
      END FILLCOMMBYACTIVITYATTRIB;
      
      
      PROCEDURE FILLCOMMBYREQUESTATTRIB
      IS
          SBCOMMENTTYPE         GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
          SBMOCOMMENTID         GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
          SBPERSONID            GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
      BEGIN

          IF SBCOMMENTBYREQUACTIVATTRIBUTES IS NOT NULL THEN
              RETURN;
          END IF;

          UT_TRACE.TRACE('INICIO - FillCommByRequestAttrib', 12);

          
          SBCOMMENTTYPE := 'MO_COMMENT1.COMMENT_TYPE_ID'||GE_BOUTILITIES.CSBSEPARATOR ||'Ge_boBasicDataServices.fsbGetDescCommentType(MO_COMMENT1.COMMENT_TYPE_ID)';
          SBMOCOMMENTID := 'MO_COMMENT1.COMMENT_ID'||GE_BOUTILITIES.CSBSEPARATOR ||'''MO_COMMENT''';
          SBPERSONID    := 'MO_COMMENT1.person_id'||GE_BOUTILITIES.CSBSEPARATOR ||'(select name_ FROM ge_person WHERE ge_person.person_id = MO_COMMENT1.Person_id)';

          
          GE_BOUTILITIES.ADDATTRIBUTE (SBMOCOMMENTID,'ORDER_COMMENT_ID',SBCOMMENTBYREQUACTIVATTRIBUTES);
          GE_BOUTILITIES.ADDATTRIBUTE ('MO_COMMENT1.REGISTER_DATE','REGISTER_DATE',SBCOMMENTBYREQUACTIVATTRIBUTES);
          GE_BOUTILITIES.ADDATTRIBUTE (SBCOMMENTTYPE,'COMMENT_TYPE',SBCOMMENTBYREQUACTIVATTRIBUTES);
          GE_BOUTILITIES.ADDATTRIBUTE ('MO_COMMENT1.COMMENT_','ORDER_COMMENT',SBCOMMENTBYREQUACTIVATTRIBUTES);
          GE_BOUTILITIES.ADDATTRIBUTE ('MO_COMMENT1.ORDER_ID','ORDER_ID',SBCOMMENTBYREQUACTIVATTRIBUTES); 
          GE_BOUTILITIES.ADDATTRIBUTE (SBPERSONID,'PERSON_ID',SBCOMMENTBYREQUACTIVATTRIBUTES);
          GE_BOUTILITIES.ADDATTRIBUTE (':parent_id','parent_id',SBCOMMENTBYREQUACTIVATTRIBUTES);
          
          UT_TRACE.TRACE('FIN - FillCommByRequestAttrib', 12);

      EXCEPTION
          WHEN EX.CONTROLLED_ERROR THEN
              RAISE EX.CONTROLLED_ERROR;
          WHEN OTHERS THEN
              ERRORS.SETERROR;
              RAISE EX.CONTROLLED_ERROR;
      END FILLCOMMBYREQUESTATTRIB;
      
    BEGIN
    


        IF INSTR(ISBORDERID, '-') != 0 THEN
            NUORDERID := TO_NUMBER(UT_STRING.EXTSTRFIELD(ISBORDERID,'-',1));
        ELSE
            NUORDERID := TO_NUMBER(ISBORDERID);
        END IF;
        
        
        FILLCOMMENTBYORDERATTRIBUTES;
        FILLCOMMBYACTIVITYATTRIB;
        FILLCOMMBYREQUESTATTRIB;
        
        
        SBSQL := 'select '|| SBCOMMENTBYORDERATTRIBUTES ||CHR(10)||
                  ' from OR_ORDER_COMMENT '||CHR(10)||
                  '/*+ OR_boSearchDataServices.GetCommentByOrderId SAO173694 */'||CHR(10)||
                 ' where OR_ORDER_COMMENT.ORDER_id = :inuOrderId'||CHR(10)||
                 ' AND not exists (SELECT VW_TIPOS_COMEN_INSP.ID FROM VW_TIPOS_COMEN_INSP WHERE VW_TIPOS_COMEN_INSP.ID = OR_ORDER_COMMENT.COMMENT_TYPE_ID)';
        
        SBSQL :=  SBSQL||CHR(10)||
        ' UNION select '|| SBCOMMENTBYACTIVITYATTRIBUTES ||CHR(10)||
                  ' from OR_ORDER_ACTIVITY '||CHR(10)||
                 ' where OR_ORDER_ACTIVITY.COMMENT_ IS not null and OR_ORDER_ACTIVITY.ORDER_id = :inuOrderId ';
        
        SBSQL :=  SBSQL||CHR(10)||
        ' UNION select '|| SBCOMMENTBYREQUACTIVATTRIBUTES ||CHR(10)||
                  ' from (SELECT MO_COMMENT.*, OR_ORDER_ACTIVITY.order_id FROM MO_COMMENT, OR_ORDER_ACTIVITY '||CHR(10)||
                  ' where MO_COMMENT.COMMENT_ <> ''-'' AND MO_COMMENT.PACKAGE_ID = OR_ORDER_ACTIVITY.PACKAGE_ID '||CHR(10)||
                  ' AND OR_ORDER_ACTIVITY.ORDER_ID = :inuOrderId) MO_COMMENT1';

        
        SBSQL :=  SBSQL||CHR(10)||
        ' UNION select DISTINCT '|| SBCOMMENTBYREQUACTIVATTRIBUTES ||CHR(10)||
                  ' from (SELECT MO_COMMENT.*, OR_ORDER_ACTIVITY.order_id FROM MO_COMMENT, OR_ORDER_ACTIVITY '||CHR(10)||
                 ' where MO_COMMENT.COMMENT_ <> ''-'' AND MO_COMMENT.MOTIVE_ID = OR_ORDER_ACTIVITY.MOTIVE_ID '||CHR(10)||
                    ' AND OR_ORDER_ACTIVITY.ORDER_ID = :inuOrderId) MO_COMMENT1  ';

        UT_TRACE.TRACE(CHR(10)||'sbSql - GetCommentByOrderId '||CHR(10)||SBSQL, 2);
        
        
         OPEN OCUDATACURSOR FOR SBSQL USING
                                ISBORDERID,NUORDERID,ISBORDERID,NUORDERID,
                                ISBORDERID,NUORDERID,ISBORDERID,NUORDERID;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETCOMMENTBYORDERID;
    




    PROCEDURE GETLOGORDERACTION
    (
        ISBORDERID                IN VARCHAR2,
        OCUDATACURSOR             OUT CONSTANTS.TYREFCURSOR
    )
    IS

      SBSQL      GE_BOUTILITIES.STYSTATEMENT;
      NUORDERID  OR_LOG_ORDER_ACTION.ORDER_ID%TYPE := NULL;
      NUACTIONID OR_LOG_ORDER_ACTION.ACTION_ID%TYPE := NULL;
      
      SBLOGORDERACTIONATTRIBUTES       GE_BOUTILITIES.STYSTATEMENT;

      
      PROCEDURE FILLLOGORDERACTIONATTRIBUTES
      IS
          SBACTIONID         GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;

      BEGIN

          SBACTIONID := 'OR_LOG_ORDER_ACTION.ACTION_ID'||GE_BOUTILITIES.CSBSEPARATOR ||'Ge_boBasicDataServices.fsbGetDescAction(OR_LOG_ORDER_ACTION.ACTION_ID)';
          
          GE_BOUTILITIES.ADDATTRIBUTE ('ROWNUM','LOG_ORDER_ACTION_ID',SBLOGORDERACTIONATTRIBUTES);
          GE_BOUTILITIES.ADDATTRIBUTE ('OR_LOG_ORDER_ACTION.PROCESS_DATE','PROCESS_DATE',SBLOGORDERACTIONATTRIBUTES);
          GE_BOUTILITIES.ADDATTRIBUTE (SBACTIONID,'ACTION_ID',SBLOGORDERACTIONATTRIBUTES);
          GE_BOUTILITIES.ADDATTRIBUTE ('OR_LOG_ORDER_ACTION.ERROR_MESSAGE','ERROR_MESSAGE',SBLOGORDERACTIONATTRIBUTES);
          GE_BOUTILITIES.ADDATTRIBUTE (':parent_id','parent_id',SBLOGORDERACTIONATTRIBUTES);

      EXCEPTION
          WHEN EX.CONTROLLED_ERROR THEN
              RAISE EX.CONTROLLED_ERROR;
          WHEN OTHERS THEN
              ERRORS.SETERROR;
              RAISE EX.CONTROLLED_ERROR;
      END FILLLOGORDERACTIONATTRIBUTES;
     
    BEGIN
    
        
        NUORDERID :=  TO_NUMBER(ISBORDERID);
        FILLLOGORDERACTIONATTRIBUTES;

        
        SBSQL := 'select '|| SBLOGORDERACTIONATTRIBUTES ||CHR(10)||
                  ' from OR_LOG_ORDER_ACTION '||CHR(10)||
                 ' where ORDER_id = :inuOrderId ';
                 
        
        OPEN OCUDATACURSOR FOR SBSQL USING NUORDERID, NUORDERID;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETLOGORDERACTION;
    




    PROCEDURE GETLOGOPERUNITBYORDEN
    (
        ISBORDERID                IN VARCHAR2,
        OCUDATACURSOR             OUT CONSTANTS.TYREFCURSOR
    )
    IS

      SBSQL      GE_BOUTILITIES.STYSTATEMENT;
      NUORDERID  OR_LOG_ORDER_ACTION.ORDER_ID%TYPE := NULL;
      NUACTIONID OR_LOG_ORDER_ACTION.ACTION_ID%TYPE := NULL;

      SBLOGOPERUNITBYORDENATTRIBUTES       GE_BOUTILITIES.STYSTATEMENT;

      
      PROCEDURE FILLLOGOPERUNITBYORATTRIBUTES

      IS

          SBORIGOPERATINGUNIT             GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
          SBTARGOPERATINGUNIT             GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;

      BEGIN

          SBORIGOPERATINGUNIT := 'OR_ORDER_OPEUNI_CHAN.ORIGIN_OPER_UNIT_ID'||GE_BOUTILITIES.CSBSEPARATOR ||'OR_boBasicDataServices.fsbGetDescOperatingUnit(OR_ORDER_OPEUNI_CHAN.ORIGIN_OPER_UNIT_ID)';
          SBTARGOPERATINGUNIT := 'OR_ORDER_OPEUNI_CHAN.TARGET_OPER_UNIT_ID'||GE_BOUTILITIES.CSBSEPARATOR ||'OR_boBasicDataServices.fsbGetDescOperatingUnit(OR_ORDER_OPEUNI_CHAN.TARGET_OPER_UNIT_ID)';

          
          GE_BOUTILITIES.ADDATTRIBUTE ('OR_ORDER_OPEUNI_CHAN.ORDER_OPEUNI_CHAN_ID','ORDER_OPEUNI_CHAN_ID',SBLOGOPERUNITBYORDENATTRIBUTES);
          GE_BOUTILITIES.ADDATTRIBUTE ('OR_ORDER_OPEUNI_CHAN.REGISTER_DATE','REGISTER_DATE',SBLOGOPERUNITBYORDENATTRIBUTES);
          GE_BOUTILITIES.ADDATTRIBUTE (SBORIGOPERATINGUNIT,'ORIGIN_OPER_UNIT',SBLOGOPERUNITBYORDENATTRIBUTES);
          GE_BOUTILITIES.ADDATTRIBUTE (SBTARGOPERATINGUNIT,'TARGET_OPER_UNIT',SBLOGOPERUNITBYORDENATTRIBUTES);
          GE_BOUTILITIES.ADDATTRIBUTE ('OR_ORDER_OPEUNI_CHAN.USER_','USER_',SBLOGOPERUNITBYORDENATTRIBUTES);
          GE_BOUTILITIES.ADDATTRIBUTE ('OR_ORDER_OPEUNI_CHAN.TERMINAL','TERMINAL',SBLOGOPERUNITBYORDENATTRIBUTES);
          GE_BOUTILITIES.ADDATTRIBUTE (':parent_id','parent_id',SBLOGOPERUNITBYORDENATTRIBUTES);

      EXCEPTION
          WHEN EX.CONTROLLED_ERROR THEN
              RAISE EX.CONTROLLED_ERROR;
          WHEN OTHERS THEN
              ERRORS.SETERROR;
              RAISE EX.CONTROLLED_ERROR;
      END FILLLOGOPERUNITBYORATTRIBUTES;
     
    BEGIN

        
        NUORDERID :=  TO_NUMBER(ISBORDERID);
        FILLLOGOPERUNITBYORATTRIBUTES;

        
        SBSQL := 'select '|| SBLOGOPERUNITBYORDENATTRIBUTES ||CHR(10)||
                  ' from OR_ORDER_OPEUNI_CHAN '||CHR(10)||
                 ' where ORDER_id = :inuOrderId ';

        
        OPEN OCUDATACURSOR FOR SBSQL USING NUORDERID, NUORDERID;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETLOGOPERUNITBYORDEN;





    PROCEDURE GETNETBYORDERID
    (
        ISBORDERID IN VARCHAR2,
        OCUDATACURSOR  OUT CONSTANTS.TYREFCURSOR
    )
    IS

      SBSQL                                GE_BOUTILITIES.STYSTATEMENT;
      NUORDERID                            OR_ORDER.ORDER_ID%TYPE;

      SBNETASSIGBYORDERITEMSATTR           GE_BOUTILITIES.STYSTATEMENT;
      SBNETNODEBYORDERITEMSATTR            GE_BOUTILITIES.STYSTATEMENT;

      
      PROCEDURE FILLNETASSIGBYORDERITEMSATTR
      IS
          SBOPERATINGSECTOR    GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
          SBELEMENTTYPE        GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
          SBCLASSELEMENTTYPE   GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
          SBCOMPOSITECODE      GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
          SBIFASSIGNABLEID     GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
      BEGIN
          IF SBNETASSIGBYORDERITEMSATTR IS NOT NULL THEN
              RETURN;
          END IF;

          
          SBIFASSIGNABLEID          := 'IF_ASSIGNABLE.ID'||GE_BOUTILITIES.CSBSEPARATOR ||'''IF_ASSIGNABLE''';

          
          SBOPERATINGSECTOR := 'IF_ASSIGNABLE.OPERATING_SECTOR_ID'||GE_BOUTILITIES.CSBSEPARATOR ||'OR_boBasicDataServices.fsbGetDescOperatinSector(IF_ASSIGNABLE.OPERATING_SECTOR_ID)';
          SBELEMENTTYPE := 'IF_ASSIGNABLE.ELEMENT_TYPE_ID'||GE_BOUTILITIES.CSBSEPARATOR ||'If_boBasicDataServices.fsbGetDescElementType(IF_ASSIGNABLE.ELEMENT_TYPE_ID)';
          SBCLASSELEMENTTYPE := 'IF_ASSIGNABLE.CLASS_ID'||GE_BOUTILITIES.CSBSEPARATOR ||'If_boBasicDataServices.fsbGetDescElementClass(IF_ASSIGNABLE.ELEMENT_TYPE_ID,IF_ASSIGNABLE.CLASS_ID)';
          SBCOMPOSITECODE := 'if_boelement.fsbGetDisplay_Code(IF_ASSIGNABLE.ELEMENT_TYPE_ID,IF_ASSIGNABLE.ID)';

          
          GE_BOUTILITIES.ADDATTRIBUTE (SBIFASSIGNABLEID,'ORDER_NET_ID',SBNETASSIGBYORDERITEMSATTR);
          GE_BOUTILITIES.ADDATTRIBUTE (SBELEMENTTYPE,'ELEMENT_TYPE',SBNETASSIGBYORDERITEMSATTR);
          GE_BOUTILITIES.ADDATTRIBUTE (SBCLASSELEMENTTYPE,'CLASS',SBNETASSIGBYORDERITEMSATTR);
          GE_BOUTILITIES.ADDATTRIBUTE ('IF_ASSIGNABLE.CODE','CODE',SBNETASSIGBYORDERITEMSATTR);
          GE_BOUTILITIES.ADDATTRIBUTE (SBOPERATINGSECTOR,'OPERATING_SECTOR',SBNETASSIGBYORDERITEMSATTR);
          GE_BOUTILITIES.ADDATTRIBUTE (SBCOMPOSITECODE,'COMPOSITE_CODE',SBNETASSIGBYORDERITEMSATTR);
          GE_BOUTILITIES.ADDATTRIBUTE (':parent_id','parent_id',SBNETASSIGBYORDERITEMSATTR);
      EXCEPTION
          WHEN EX.CONTROLLED_ERROR THEN
              RAISE EX.CONTROLLED_ERROR;
          WHEN OTHERS THEN
              ERRORS.SETERROR;
              RAISE EX.CONTROLLED_ERROR;
      END FILLNETASSIGBYORDERITEMSATTR;
      
      PROCEDURE FILLNETNODEBYORDERITEMSATTR
      IS

          SBOPERATINGSECTOR    GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
          SBELEMENTTYPE        GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
          SBCLASSELEMENTTYPE   GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
          SBCOMPOSITECODE      GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
          SBIFNODEID           GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
      BEGIN

          IF SBNETNODEBYORDERITEMSATTR IS NOT NULL THEN
              RETURN;
          END IF;

          
          SBIFNODEID          := 'IF_NODE.ID'||GE_BOUTILITIES.CSBSEPARATOR ||'''IF_NODE''';

          
          SBOPERATINGSECTOR := 'IF_NODE.OPERATING_SECTOR_ID'||GE_BOUTILITIES.CSBSEPARATOR ||'OR_boBasicDataServices.fsbGetDescOperatinSector(IF_NODE.OPERATING_SECTOR_ID)';
          SBELEMENTTYPE := 'IF_NODE.ELEMENT_TYPE_ID'||GE_BOUTILITIES.CSBSEPARATOR ||'If_boBasicDataServices.fsbGetDescElementType(IF_NODE.ELEMENT_TYPE_ID)';
          SBCLASSELEMENTTYPE := 'IF_NODE.CLASS_ID'||GE_BOUTILITIES.CSBSEPARATOR ||'If_boBasicDataServices.fsbGetDescElementClass(IF_NODE.ELEMENT_TYPE_ID,IF_NODE.CLASS_ID)';
          SBCOMPOSITECODE := 'if_boelement.fsbGetDisplay_Code(IF_NODE.ELEMENT_TYPE_ID,IF_NODE.ID)';

          
          GE_BOUTILITIES.ADDATTRIBUTE (SBIFNODEID,'ORDER_NET_ID',SBNETNODEBYORDERITEMSATTR);
          GE_BOUTILITIES.ADDATTRIBUTE (SBELEMENTTYPE,'ELEMENT_TYPE',SBNETNODEBYORDERITEMSATTR);
          GE_BOUTILITIES.ADDATTRIBUTE (SBCLASSELEMENTTYPE,'CLASS',SBNETNODEBYORDERITEMSATTR);
          GE_BOUTILITIES.ADDATTRIBUTE ('IF_NODE.CODE','CODE',SBNETNODEBYORDERITEMSATTR);
          GE_BOUTILITIES.ADDATTRIBUTE (SBOPERATINGSECTOR,'OPERATING_SECTOR',SBNETNODEBYORDERITEMSATTR);
          GE_BOUTILITIES.ADDATTRIBUTE (SBCOMPOSITECODE,'COMPOSITE_CODE',SBNETNODEBYORDERITEMSATTR);
          GE_BOUTILITIES.ADDATTRIBUTE (':parent_id','parent_id',SBNETNODEBYORDERITEMSATTR);
      EXCEPTION
          WHEN EX.CONTROLLED_ERROR THEN
              RAISE EX.CONTROLLED_ERROR;
          WHEN OTHERS THEN
              ERRORS.SETERROR;
              RAISE EX.CONTROLLED_ERROR;
      END FILLNETNODEBYORDERITEMSATTR;
      
    BEGIN

        IF INSTR(ISBORDERID, '-') != 0 THEN
            NUORDERID := TO_NUMBER(UT_STRING.EXTSTRFIELD(ISBORDERID,'-',1));
        ELSE
            NUORDERID := TO_NUMBER(ISBORDERID);
        END IF;
        
        

        FILLNETASSIGBYORDERITEMSATTR;
        FILLNETNODEBYORDERITEMSATTR;

        
        

        SBSQL := 'select '|| SBNETASSIGBYORDERITEMSATTR ||CHR(10)||
                 ' from OR_ORDER_ITEMS, IF_ASSIGNABLE '||CHR(10)||
                 ' where OR_ORDER_ITEMS.ELEMENT_ID = IF_ASSIGNABLE.ID '||CHR(10)||
                 ' AND OR_ORDER_ITEMS.ORDER_ID = :inuOrderId ';
        SBSQL := SBSQL||CHR(10)||
                 ' UNION '||CHR(10)||
                 'select '|| SBNETNODEBYORDERITEMSATTR ||CHR(10)||
                 ' from OR_ORDER_ITEMS, IF_NODE '||CHR(10)||
                 ' where OR_ORDER_ITEMS.ELEMENT_ID = IF_NODE.ID '||CHR(10)||
                 ' AND OR_ORDER_ITEMS.ORDER_ID = :inuOrderId ';
        
        SBSQL := SBSQL||CHR(10)||
                 ' UNION '||CHR(10)||
                 'select '|| SBNETASSIGBYORDERITEMSATTR ||CHR(10)||
                 ' from or_order_activity, IF_ASSIGNABLE '||CHR(10)||
                 ' where or_order_activity.ELEMENT_ID = IF_ASSIGNABLE.ID '||CHR(10)||
                 ' AND or_order_activity.ORDER_ID = :inuOrderId ';
        SBSQL := SBSQL||CHR(10)||
                 ' UNION '||CHR(10)||
                 'select '|| SBNETNODEBYORDERITEMSATTR ||CHR(10)||
                 ' from or_order_activity, IF_NODE '||CHR(10)||
                 ' where or_order_activity.ELEMENT_ID = IF_NODE.ID '||CHR(10)||
                 ' AND or_order_activity.ORDER_ID = :inuOrderId ';
       
       
 
        OPEN OCUDATACURSOR FOR SBSQL USING ISBORDERID,NUORDERID,ISBORDERID,NUORDERID,
                                           ISBORDERID,NUORDERID,ISBORDERID,NUORDERID;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETNETBYORDERID;
    




    





























    PROCEDURE GETITEMSBYORDERID
    (
        ISBORDERID IN VARCHAR2,
        OCUDATACURSOR  OUT CONSTANTS.TYREFCURSOR
    )
    IS

      SBSQL    GE_BOUTILITIES.STYSTATEMENT;
      NUORDERID OR_ORDER.ORDER_ID%TYPE;
      SBITEMSBYORDERATTRIBUTES               GE_BOUTILITIES.STYSTATEMENT;
      
      PROCEDURE FILLITEMSBYORDERATTRIBUTES
      IS

          SBITEMS               GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
          NUOPERAIUVALUE        OR_ORDER.OPERATIVE_AIU_VALUE%TYPE;

      BEGIN

          IF SBITEMSBYORDERATTRIBUTES IS NOT NULL THEN
              RETURN;
          END IF;

          
          SBITEMS := 'dage_items.fsbGetCode(or_order_items.items_id,0)';
          SBITEMS := SBITEMS || GE_BOUTILITIES.CSBSEPARATOR || 'or_bobasicdataservices.fsbGetDescOrderItem(or_order_items.order_items_id)';
          
          

          GE_BOUTILITIES.ADDATTRIBUTE ('OR_ORDER_ITEMS.ORDER_ITEMS_ID','ORDER_ITEMS_ID',SBITEMSBYORDERATTRIBUTES);
          GE_BOUTILITIES.ADDATTRIBUTE (SBITEMS,'ITEMS',SBITEMSBYORDERATTRIBUTES);
          GE_BOUTILITIES.ADDATTRIBUTE ('OR_ORDER_ITEMS.ASSIGNED_ITEM_AMOUNT','ASSIGNED_ITEM_AMOUNT',SBITEMSBYORDERATTRIBUTES);
          GE_BOUTILITIES.ADDATTRIBUTE ('OR_ORDER_ITEMS.LEGAL_ITEM_AMOUNT','LEGAL_ITEM_AMOUNT',SBITEMSBYORDERATTRIBUTES);
          GE_BOUTILITIES.ADDATTRIBUTE ('OR_ORDER_ITEMS.total_price','VALUE',SBITEMSBYORDERATTRIBUTES);
          GE_BOUTILITIES.ADDATTRIBUTE ('OR_ORDER_ITEMS.ORDER_ID','ORDER_ID',SBITEMSBYORDERATTRIBUTES);
          GE_BOUTILITIES.ADDATTRIBUTE ('DECODE(OR_ORDER_ITEMS.OUT_,''Y'', ge_boi18n.fsbGetTraslation(''ITEM_USE_INSTALL''), ''N'', ge_boi18n.fsbGetTraslation(''ITEM_USE_REMOVE''))','Uso',SBITEMSBYORDERATTRIBUTES);
          GE_BOUTILITIES.ADDATTRIBUTE (':parent_id','parent_id',SBITEMSBYORDERATTRIBUTES);

      EXCEPTION
          WHEN EX.CONTROLLED_ERROR THEN
              RAISE EX.CONTROLLED_ERROR;
          WHEN OTHERS THEN
              ERRORS.SETERROR;
              RAISE EX.CONTROLLED_ERROR;
      END FILLITEMSBYORDERATTRIBUTES;
      

      
    BEGIN
        IF INSTR(ISBORDERID, '-') != 0 THEN
            NUORDERID := TO_NUMBER(UT_STRING.EXTSTRFIELD(ISBORDERID,'-',1));
        ELSE
            NUORDERID := TO_NUMBER(ISBORDERID);
        END IF;
        
        FILLITEMSBYORDERATTRIBUTES;
        

        SBSQL := 'select '|| SBITEMSBYORDERATTRIBUTES ||CHR(10)||
                 ' from OR_ORDER_ITEMS, OR_order, or_task_type '||CHR(10)||
                 ' /*+ OR_boSearchDataServices.GetItemsByOrderId SAO185809 */'||CHR(10)||
                 ' where OR_order.ORDER_id = :inuOrderId '||CHR(10)||
                 ' AND OR_order_items.order_id = OR_order.order_id '||CHR(10)||
                 ' AND OR_order.task_type_id =  or_task_type.task_type_id';

        
        UT_TRACE.TRACE('sbSql['||SBSQL||']',15);
        OPEN OCUDATACURSOR FOR SBSQL USING ISBORDERID,NUORDERID;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETITEMSBYORDERID;
    



    PROCEDURE GETADDATTRIBSBYORDERID
    (
        ISBORDERID IN VARCHAR2,
        OCUDATACURSOR  OUT CONSTANTS.TYREFCURSOR
    )
    IS

      SBSQL    GE_BOUTILITIES.STYSTATEMENT;
      NUORDERID OR_ORDER.ORDER_ID%TYPE;
      SBADDATTRIBSBYORDERATTRIBUTES               GE_BOUTILITIES.STYSTATEMENT;
      
      PROCEDURE FILLADDATTBYORDERATTRIBUTES
      IS

          SBACTIONID            GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
          SBATTRIBUTESSETID     GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;

      BEGIN

          IF SBADDATTRIBSBYORDERATTRIBUTES IS NOT NULL THEN
              RETURN;
          END IF;

          

          SBACTIONID := 'OR_REQU_DATA_VALUE.ACTION_ID'||GE_BOUTILITIES.CSBSEPARATOR ||'Ge_boBasicDataServices.fsbGetDescAction(OR_REQU_DATA_VALUE.ACTION_ID)';
          SBATTRIBUTESSETID := 'OR_REQU_DATA_VALUE.ATTRIBUTE_SET_ID'||GE_BOUTILITIES.CSBSEPARATOR ||'Ge_boBasicDataServices.fsbGetDescSetAttribs(OR_REQU_DATA_VALUE.ATTRIBUTE_SET_ID)';

          GE_BOUTILITIES.ADDATTRIBUTE ('ROWNUM','PK',SBADDATTRIBSBYORDERATTRIBUTES);
          GE_BOUTILITIES.ADDATTRIBUTE (SBACTIONID,'ACTION',SBADDATTRIBSBYORDERATTRIBUTES);
          GE_BOUTILITIES.ADDATTRIBUTE (SBATTRIBUTESSETID,'ATTRIBUTES_SET',SBADDATTRIBSBYORDERATTRIBUTES);
          GE_BOUTILITIES.ADDATTRIBUTE ('OR_REQU_DATA_VALUE.NAME_1','NAME_1',SBADDATTRIBSBYORDERATTRIBUTES);
          GE_BOUTILITIES.ADDATTRIBUTE ('OR_REQU_DATA_VALUE.VALUE_1','VALUE_1',SBADDATTRIBSBYORDERATTRIBUTES);
          GE_BOUTILITIES.ADDATTRIBUTE (':parent_id','parent_id',SBADDATTRIBSBYORDERATTRIBUTES);

      EXCEPTION
          WHEN EX.CONTROLLED_ERROR THEN
              RAISE EX.CONTROLLED_ERROR;
          WHEN OTHERS THEN
              ERRORS.SETERROR;
              RAISE EX.CONTROLLED_ERROR;
      END FILLADDATTBYORDERATTRIBUTES;
      
    BEGIN

        IF INSTR(ISBORDERID, '-') != 0 THEN
            NUORDERID := TO_NUMBER(UT_STRING.EXTSTRFIELD(ISBORDERID,'-',1));
        ELSE
            NUORDERID := TO_NUMBER(ISBORDERID);
        END IF;

        
        FILLADDATTBYORDERATTRIBUTES;
                    
        
        SBSQL :=  'SELECT '|| SBADDATTRIBSBYORDERATTRIBUTES || ' FROM ( ';
        FOR NUIDX IN 1 .. 20 LOOP
            SBSQL := SBSQL || '
                SELECT ORDER_ID, or_requ_data_value.attribute_set_id, action_id,
                    display_name name_' || NUIDX || ', value_' || NUIDX || '
                FROM or_requ_data_value, ge_attrib_set_attrib, ge_attributes
                WHERE or_requ_data_value.attribute_set_id = ge_attrib_set_attrib.attribute_set_id
                AND ge_attrib_set_attrib.attribute_id = ge_attributes.attribute_id
                AND ge_attributes.name_attribute = or_requ_data_value.name_' || NUIDX || '
                AND ORDER_id = :inuOrderId ' ;
            IF NUIDX < 20 THEN
                SBSQL := SBSQL || ' union ' ;
            END IF;
        END LOOP;
        SBSQL := SBSQL || ' ) OR_REQU_DATA_VALUE
            WHERE name_1 IS NOT NULL
            ORDER BY 4, 2 ';

       UT_TRACE.TRACE('OR_boSearchDataServices.GetAddAttribsByOrderId:',3);
       UT_TRACE.TRACE('Select:'||SBSQL,3);

       
       OPEN OCUDATACURSOR FOR SBSQL USING ISBORDERID,NUORDERID,NUORDERID,NUORDERID,NUORDERID,
                                           NUORDERID,NUORDERID,NUORDERID,NUORDERID,NUORDERID,
                                           NUORDERID,NUORDERID,NUORDERID,NUORDERID,NUORDERID,
                                           NUORDERID,NUORDERID,NUORDERID,NUORDERID,NUORDERID,
                                           NUORDERID;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;

    END GETADDATTRIBSBYORDERID;
    



     





















    PROCEDURE GETORDERRELATBYORDERID
    (
        ISBORDERID IN VARCHAR2,
        OCUDATACURSOR  OUT CONSTANTS.TYREFCURSOR
    )
    IS

      SBSQL    GE_BOUTILITIES.STYSTATEMENT;
      NUORDERID OR_ORDER.ORDER_ID%TYPE;
      SBORDERRELATBYORDERATTRIBUTES            GE_BOUTILITIES.STYSTATEMENT;
      

        PROCEDURE FILLORDERRELATATTRIBUTES
        IS
            SBNUMERATOR         GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
            SBTASKTYPE          GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
            SBORDERSTATUS       GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
            SBOPERATINGSECTOR   GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
            SBOPERATINGUNIT     GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;

        BEGIN

            IF SBORDERRELATBYORDERATTRIBUTES IS NOT NULL THEN
                RETURN;
            END IF;

            
            SBNUMERATOR := 'OR_ORDER.numerator_id'||GE_BOUTILITIES.CSBSEPARATOR ||'OR_ORDER.sequence';
            SBTASKTYPE := 'OR_ORDER.TASK_TYPE_ID'||GE_BOUTILITIES.CSBSEPARATOR ||'OR_boBasicDataServices.fsbGetDescTaskType(OR_ORDER.TASK_TYPE_ID)';
            SBORDERSTATUS := 'OR_ORDER.ORDER_STATUS_ID'||GE_BOUTILITIES.CSBSEPARATOR ||'daor_order_status.fsbGetDescription(OR_ORDER.ORDER_STATUS_ID)';
            SBOPERATINGSECTOR := 'OR_ORDER.OPERATING_SECTOR_ID'||GE_BOUTILITIES.CSBSEPARATOR ||'OR_boBasicDataServices.fsbGetDescOperatinSector(OR_ORDER.OPERATING_SECTOR_ID)';
            SBOPERATINGUNIT := 'OR_ORDER.OPERATING_UNIT_ID'||GE_BOUTILITIES.CSBSEPARATOR ||'OR_boBasicDataServices.fsbGetDescOperatingUnit(OR_ORDER.OPERATING_UNIT_ID)';

            GE_BOUTILITIES.ADDATTRIBUTE ('OR_ORDER.ORDER_ID','ORDER_ID',SBORDERRELATBYORDERATTRIBUTES);
            GE_BOUTILITIES.ADDATTRIBUTE (SBNUMERATOR,'numerator', SBORDERRELATBYORDERATTRIBUTES);
            GE_BOUTILITIES.ADDATTRIBUTE (SBTASKTYPE,'TASK_TYPE',SBORDERRELATBYORDERATTRIBUTES);
            GE_BOUTILITIES.ADDATTRIBUTE (SBORDERSTATUS,'ORDER_STATUS',SBORDERRELATBYORDERATTRIBUTES);
            GE_BOUTILITIES.ADDATTRIBUTE (SBOPERATINGSECTOR,'OPERATING_SECTOR',SBORDERRELATBYORDERATTRIBUTES);
            GE_BOUTILITIES.ADDATTRIBUTE (SBOPERATINGUNIT,'OPERATING_UNIT',SBORDERRELATBYORDERATTRIBUTES);
            GE_BOUTILITIES.ADDATTRIBUTE (':parent_id','parent_id',SBORDERRELATBYORDERATTRIBUTES);

        EXCEPTION
            WHEN EX.CONTROLLED_ERROR THEN
                RAISE EX.CONTROLLED_ERROR;

            WHEN OTHERS THEN
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;
        END FILLORDERRELATATTRIBUTES;
        
    BEGIN

        IF INSTR(ISBORDERID, '-') != 0 THEN
            NUORDERID := TO_NUMBER(UT_STRING.EXTSTRFIELD(ISBORDERID,'-',1));
        ELSE
            NUORDERID := TO_NUMBER(ISBORDERID);
        END IF;

        FILLORDERRELATATTRIBUTES;

        SBSQL := 'select UNIQUE '|| SBORDERRELATBYORDERATTRIBUTES ||CHR(10)||
                    ' , (select description FROM ge_transition_type WHERE transition_type_id = OR_RELATED_ORDER.rela_order_type_id) relation_type' ||CHR(10)||
                    ' FROM OR_ORDER,OR_RELATED_ORDER '||CHR(10)||
                    ' WHERE ' ||CHR(10)||
                    '    (OR_RELATED_ORDER.RELATED_ORDER_ID = OR_ORDER.ORDER_ID AND OR_RELATED_ORDER.ORDER_ID = :inuOrderId
                           AND OR_RELATED_ORDER.rela_order_type_id <> ' || CT_BOCONSTANTS.CNUTRANS_TYPE_NOVE_ORDER || ') ' ||CHR(10)||
                    '   OR ' ||CHR(10)||
                    '    (OR_RELATED_ORDER.ORDER_ID = OR_ORDER.ORDER_ID AND OR_RELATED_ORDER.RELATED_ORDER_ID = :inuOrderId
                           AND OR_RELATED_ORDER.rela_order_type_id <> ' || CT_BOCONSTANTS.CNUTRANS_TYPE_NOVE_ORDER || ')';

        UT_TRACE.TRACE(SBSQL);

        OPEN OCUDATACURSOR FOR SBSQL
            USING ISBORDERID,NUORDERID,NUORDERID;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
            
    END GETORDERRELATBYORDERID;


    
    
































    
    PROCEDURE GETORDERSBYPACKAGEID
    (
        INUPACKAGEID    IN  MO_PACKAGES.PACKAGE_ID%TYPE,
        OCUDATACURSOR   OUT CONSTANTS.TYREFCURSOR
    )
    IS
      SBSQL                     GE_BOUTILITIES.STYSTATEMENT;
      SBORDERFROM               GE_BOUTILITIES.STYSTATEMENT;
      SBORDERWHERE              GE_BOUTILITIES.STYSTATEMENT;
      SBORDERATTRIBUTES         GE_BOUTILITIES.STYSTATEMENT;
      
    BEGIN

        FILLORDERATTRIBUTES(SBORDERATTRIBUTES);
        SBORDERFROM := GSBORDERFROM || ', or_order_activity /* ubicacion:OR_boSearchDataServices.GetOrdersByPackageId */';
        SBORDERWHERE :=GSBORDERWHERE || CHR(10) ||'AND GE_SUBSCRIBER.subscriber_id(+) = OR_ORDER.subscriber_id'
                        ||CHR(10)|| ' AND or_order.order_id = or_order_activity.order_id'||CHR(10)||
            'AND or_order_activity.package_id = :inuPackageId ';

        SBSQL := 'SELECT /*+ leading (or_order_activity)'||CHR(10)||
                        'use_nl(or_order_activity or_order)'||CHR(10)||
                        'index(or_order_activity IDX_OR_ORDER_ACTIVITY_06)'||CHR(10)||
                        'index(or_order pk_or_order)*/'||CHR(10)||
                        'distinct '||
            SBORDERATTRIBUTES ||CHR(10)||
            SBORDERFROM ||CHR(10)||
            SBORDERWHERE;

        SBSQL := REPLACE( SBSQL, '''''', '''' );
        UT_TRACE.TRACE( SBSQL, 1 );

        OPEN OCUDATACURSOR FOR SBSQL USING INUPACKAGEID, INUPACKAGEID;



    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETORDERSBYPACKAGEID;
    
    


















    PROCEDURE GETEXTERNDATABYORDERID
    (
        INUORDERID      IN  OR_EXTERN_SYSTEMS_ID.ORDER_ID%TYPE,
        OCUDATACURSOR   OUT CONSTANTS.TYREFCURSOR
    )
    IS
          SBSQL                         GE_BOUTILITIES.STYSTATEMENT;
          SBEXTERNDATAATTRIBUTES        GE_BOUTILITIES.STYSTATEMENT;
          SBEXTERNDATAACTIVITATTRIBUTES GE_BOUTILITIES.STYSTATEMENT;

            

            PROCEDURE FILLEXTDATAATTRIBUTES
            IS
            BEGIN
                
                GE_BOUTILITIES.ADDATTRIBUTE ('or_extern_systems_id.order_id'|| GE_BOUTILITIES.CSBSEPARATOR ||' or_extern_systems_id.package_id'|| GE_BOUTILITIES.CSBSEPARATOR
                                            ||' or_extern_systems_id.product_id','ORDER_ID',SBEXTERNDATAATTRIBUTES);
                GE_BOUTILITIES.ADDATTRIBUTE ('null','order_activity',SBEXTERNDATAATTRIBUTES);
                GE_BOUTILITIES.ADDATTRIBUTE ('or_extern_systems_id.subscriber_id'|| GE_BOUTILITIES.CSBSEPARATOR ||'ge_subscriber.subscriber_name '
                                            ||'||'' ''||ge_subscriber.subs_last_name','subscriber_id',SBEXTERNDATAATTRIBUTES);
                GE_BOUTILITIES.ADDATTRIBUTE ('or_extern_systems_id.subscription_id','subscription_id',SBEXTERNDATAATTRIBUTES);
                GE_BOUTILITIES.ADDATTRIBUTE ('or_extern_systems_id.product_id','product_id',SBEXTERNDATAATTRIBUTES);
                GE_BOUTILITIES.ADDATTRIBUTE ('or_extern_systems_id.package_id','package_id',SBEXTERNDATAATTRIBUTES);
                GE_BOUTILITIES.ADDATTRIBUTE ('MO_BOBasicDataServices.fnuGetPackTypeAndDescOfPackage(or_extern_systems_id.package_id)','package_type_id',SBEXTERNDATAATTRIBUTES);
                GE_BOUTILITIES.ADDATTRIBUTE (':parent_id','parent_id',SBEXTERNDATAATTRIBUTES);
            EXCEPTION
                WHEN EX.CONTROLLED_ERROR THEN
                    RAISE EX.CONTROLLED_ERROR;
                WHEN OTHERS THEN
                    ERRORS.SETERROR;
                    RAISE EX.CONTROLLED_ERROR;
            END FILLEXTDATAATTRIBUTES;

            

            PROCEDURE FILLEXTDATAACTIVITATTRIBUTES
            IS
                SBORDERACTIVITY   GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
                SBPK              GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
            BEGIN
                SBORDERACTIVITY := 'OR_ORDER_ACTIVITY.activity_id'||GE_BOUTILITIES.CSBSEPARATOR||'ge_bobasicdataservices.fsbGetDescActivityItem(OR_ORDER_ACTIVITY.activity_id)';
                SBPK := 'OR_ORDER_ACTIVITY.order_id'|| GE_BOUTILITIES.CSBSEPARATOR ||' OR_ORDER_ACTIVITY.package_id'||
                          GE_BOUTILITIES.CSBSEPARATOR||' OR_ORDER_ACTIVITY.product_id'||
                          GE_BOUTILITIES.CSBSEPARATOR||' OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID';
                
                GE_BOUTILITIES.ADDATTRIBUTE (SBPK,'ORDER_ID',SBEXTERNDATAACTIVITATTRIBUTES);
                GE_BOUTILITIES.ADDATTRIBUTE ('or_order_activity.order_activity_id','order_activity_id',SBEXTERNDATAACTIVITATTRIBUTES);
                GE_BOUTILITIES.ADDATTRIBUTE (SBORDERACTIVITY,'order_activity',SBEXTERNDATAACTIVITATTRIBUTES);
                GE_BOUTILITIES.ADDATTRIBUTE ('or_order_activity.subscriber_id || '' - '' || ge_bobasicdataservices.fsbGetDescSubscriber(or_order_activity.subscriber_id)', 'subscriber_id', SBEXTERNDATAACTIVITATTRIBUTES);
                GE_BOUTILITIES.ADDATTRIBUTE ('OR_ORDER_ACTIVITY.subscription_id','subscription_id',SBEXTERNDATAACTIVITATTRIBUTES);
                GE_BOUTILITIES.ADDATTRIBUTE ('OR_ORDER_ACTIVITY.product_id','product_id',SBEXTERNDATAACTIVITATTRIBUTES);
                GE_BOUTILITIES.ADDATTRIBUTE ('OR_ORDER_ACTIVITY.package_id','package_id',SBEXTERNDATAACTIVITATTRIBUTES);
                GE_BOUTILITIES.ADDATTRIBUTE ('MO_BOBasicDataServices.fnuGetPackTypeAndDescOfPackage(OR_ORDER_ACTIVITY.package_id)','package_type_id',SBEXTERNDATAACTIVITATTRIBUTES);
                GE_BOUTILITIES.ADDATTRIBUTE ('ab_bobasicdataservices.fsbGetDescAddress(or_order_activity.address_id)', 'address', SBEXTERNDATAACTIVITATTRIBUTES);
                GE_BOUTILITIES.ADDATTRIBUTE ('ge_bobasicdataservices.fsbGetDescSubscPhone(or_order_activity.subscriber_id)', 'subsc_phone', SBEXTERNDATAACTIVITATTRIBUTES);
                GE_BOUTILITIES.ADDATTRIBUTE (':parent_id','parent_id',SBEXTERNDATAACTIVITATTRIBUTES);

            EXCEPTION
                WHEN EX.CONTROLLED_ERROR THEN
                    RAISE EX.CONTROLLED_ERROR;
                WHEN OTHERS THEN
                    ERRORS.SETERROR;
                    RAISE EX.CONTROLLED_ERROR;
            END FILLEXTDATAACTIVITATTRIBUTES;

            

    BEGIN


            IF INUORDERID IS NULL
                OR OR_BCORDERACTIVITIES.FNUGETCOUNTORDERACTIVITIES(INUORDERID) > 0
            THEN
                FILLEXTDATAACTIVITATTRIBUTES;
                SBSQL := 'SELECT '|| SBEXTERNDATAACTIVITATTRIBUTES ||CHR(10)||
                         'FROM OR_ORDER_ACTIVITY'||CHR(10)||
                         'WHERE OR_ORDER_ACTIVITY.order_id = :inuOrderId';
            ELSE
                FILLEXTDATAATTRIBUTES;
                SBSQL := 'SELECT '|| SBEXTERNDATAATTRIBUTES ||CHR(10)||
                         'FROM or_extern_systems_id, ge_subscriber '||CHR(10)||
                         'WHERE or_extern_systems_id.subscriber_id = ge_subscriber.subscriber_id(+)'||CHR(10)||
                         'AND or_extern_systems_id.order_id = :inuOrderId';
            END IF;

            
             OPEN OCUDATACURSOR FOR SBSQL USING INUORDERID ,INUORDERID;
         
        EXCEPTION
            WHEN EX.CONTROLLED_ERROR THEN
                RAISE EX.CONTROLLED_ERROR;
            WHEN OTHERS THEN
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;

    END GETEXTERNDATABYORDERID;


   





    PROCEDURE GETORDERSBYMOTIVEID
    (
        INUMOTIVEID     IN  MO_MOTIVE.MOTIVE_ID%TYPE,
        OCUDATACURSOR   OUT CONSTANTS.TYREFCURSOR
    )
    IS
          SBSQL                         GE_BOUTILITIES.STYSTATEMENT;
          SBEXTERNDATA                  GE_BOUTILITIES.STYSTATEMENT;
          SBORDERDATAATTRIBUTES         GE_BOUTILITIES.STYSTATEMENT;
          SBRECORDBIND                  GE_BOUTILITIES.STYSTATEMENT;
          CUCURSOR                      CONSTANTS.TYREFCURSOR;
          SBUSING                       GE_BOUTILITIES.STYSTATEMENT;
          SBORDERFROM                   GE_BOUTILITIES.STYSTATEMENT;
          SBORDERWHERE                  GE_BOUTILITIES.STYSTATEMENT;
    BEGIN
            FILLORDERATTRIBUTES(SBORDERDATAATTRIBUTES);

            SBORDERFROM := GSBORDERFROM;
            SBORDERWHERE := GSBORDERWHERE || CHR(10) ||'AND GE_SUBSCRIBER.subscriber_id(+) = OR_ORDER.subscriber_id';

            SBSQL := 'SELECT '|| SBORDERDATAATTRIBUTES ||CHR(10)||
                     SBORDERFROM || ',or_order_activity' ||CHR(10)||
                     SBORDERWHERE ||CHR(10)||'AND or_order_activity.motive_id = :inuMotiveId '||CHR(10)||
                     'AND or_order_activity.order_id = OR_order.order_id ';

            SBUSING := INUMOTIVEID|| ', ' || INUMOTIVEID;

            SBRECORDBIND := 'BEGIN Open :cuCursor for ''' || SBSQL || ''' using ' || SBUSING || ';  END;';
            UT_TRACE.TRACE(SBRECORDBIND,1);
            EXECUTE IMMEDIATE SBRECORDBIND USING CUCURSOR;
            OCUDATACURSOR := CUCURSOR;
        EXCEPTION
            WHEN EX.CONTROLLED_ERROR THEN
                RAISE EX.CONTROLLED_ERROR;
            WHEN OTHERS THEN
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;

    END GETORDERSBYMOTIVEID;

   





    PROCEDURE GETORDERSBYCOMPONENTID
    (
        INUCOMPONENTID      IN  OR_EXTERN_SYSTEMS_ID.EXTERN_SYSTEM_ID%TYPE,
        OCUDATACURSOR   OUT CONSTANTS.TYREFCURSOR
    )
    IS
          SBSQL                         GE_BOUTILITIES.STYSTATEMENT;
          SBORDERDATAATTRIBUTES         GE_BOUTILITIES.STYSTATEMENT;
          SBRECORDBIND                  GE_BOUTILITIES.STYSTATEMENT;
          CUCURSOR                      CONSTANTS.TYREFCURSOR;
          SBUSING                       GE_BOUTILITIES.STYSTATEMENT;
          SBORDERFROM                   GE_BOUTILITIES.STYSTATEMENT;
          SBORDERWHERE                  GE_BOUTILITIES.STYSTATEMENT;
    BEGIN
            FILLORDERATTRIBUTES(SBORDERDATAATTRIBUTES);

            SBORDERFROM := GSBORDERFROM;
            SBORDERWHERE := GSBORDERWHERE || CHR(10) ||'AND GE_SUBSCRIBER.subscriber_id(+) = OR_ORDER.subscriber_id';
            SBSQL := 'SELECT '|| SBORDERDATAATTRIBUTES ||CHR(10)||
                     SBORDERFROM || ', or_order_activity '||CHR(10)||
                     SBORDERWHERE || CHR(10) || 'AND or_order_activity.component_id = :inuComponentId '||CHR(10)||
                     'AND  or_order_activity.order_id = OR_order.order_id ';

            SBUSING := INUCOMPONENTID|| ', ' || INUCOMPONENTID;

            SBRECORDBIND := 'BEGIN Open :cuCursor for ''' || SBSQL || ''' using ' || SBUSING || ';  END;';
            UT_TRACE.TRACE(SBRECORDBIND,1);
            EXECUTE IMMEDIATE SBRECORDBIND USING CUCURSOR;
            OCUDATACURSOR := CUCURSOR;
        EXCEPTION
            WHEN EX.CONTROLLED_ERROR THEN
                RAISE EX.CONTROLLED_ERROR;
            WHEN OTHERS THEN
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;

    END GETORDERSBYCOMPONENTID;
    
    














    PROCEDURE FILLPLANNEDACTIVITATTRIB
    (
        IOSBATTRIBUTES IN OUT GE_BOUTILITIES.STYSTATEMENT
    )
    IS
        SBORDERACTIVITY GE_BOUTILITIES.STYSTATEMENT;

    BEGIN
        SBORDERACTIVITY := 'OR_ORDER_ACTIVITY.activity_id'||GE_BOUTILITIES.CSBSEPARATOR||'ge_bobasicdataservices.fsbGetDescActivityItem(OR_ORDER_ACTIVITY.activity_id)';

        GE_BOUTILITIES.ADDATTRIBUTE('or_order_activity.order_activity_id', 'pk', IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE(SBORDERACTIVITY, 'activity', IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE('or_order_activity.comment_', 'comment_', IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE('or_order_activity.order_id', 'order_id', IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE('OR_bobasicdataservices.fsbGetDescOrderStatusId(or_order_activity.order_id)', 'order_status_id', IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE('or_order_activity.sequence_', 'sequence', IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE(':parent_id', 'parent_id', IOSBATTRIBUTES);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;

    END FILLPLANNEDACTIVITATTRIB;
    
    
    PROCEDURE GETPLANNEDACTIVITYBYID
    (
        INUORDER_ACTIVITY_ID    IN OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE,
        ORFRESULT               OUT CONSTANTS.TYREFCURSOR
    )
    IS
        SBATTRIBUTES        GE_BOUTILITIES.STYSTATEMENT;
        SBSQL               GE_BOUTILITIES.STYSTATEMENT;
    
    BEGIN
        FILLPLANNEDACTIVITATTRIB(SBATTRIBUTES);
        
        SBSQL := '
            SELECT '|| SBATTRIBUTES ||'
            FROM OR_order_activity
            WHERE order_activity_id = :inuOrder_activity_id
                AND origin_activity_id IS not null
            ';
            
        UT_TRACE.TRACE(SBSQL);
            
        OPEN ORFRESULT FOR SBSQL
            USING CNUNULL, INUORDER_ACTIVITY_ID;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;

    END GETPLANNEDACTIVITYBYID;
    
    
    PROCEDURE GETPLANACTIVBYEXTERNDATA
    (
        ISBEXTERNDATAPK     IN VARCHAR2,
        ORFRESULT           OUT CONSTANTS.TYREFCURSOR
    )
    IS
        SBATTRIBUTES            GE_BOUTILITIES.STYSTATEMENT;
        SBSQL                   GE_BOUTILITIES.STYSTATEMENT;
        NUORIGIN_ACTIVITY_ID    OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE;

    BEGIN
        NUORIGIN_ACTIVITY_ID := UT_STRING.EXTSTRFIELD(ISBEXTERNDATAPK, '-', 4);
    
        FILLPLANNEDACTIVITATTRIB(SBATTRIBUTES);

        SBSQL := '
            SELECT '|| SBATTRIBUTES ||'
            FROM OR_order_activity
            WHERE origin_activity_id = :inuOrigin_activity_id
            ';

        OPEN ORFRESULT FOR SBSQL
            USING ISBEXTERNDATAPK, NUORIGIN_ACTIVITY_ID;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;

    END GETPLANACTIVBYEXTERNDATA;
    
    


















    PROCEDURE FILLPLANNEDITEMSATTRIB
    (
        IOSBATTRIBUTES IN OUT GE_BOUTILITIES.STYSTATEMENT
    )
    IS
    
        SBITEMS              GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        
    BEGIN

        SBITEMS := 'dage_items.fsbGetCode(or_planned_items.items_id,0)' || GE_BOUTILITIES.CSBSEPARATOR ||
                   'ge_bobasicdataservices.fsbGetDescAnyItem(or_planned_items.items_id)';
    
        GE_BOUTILITIES.ADDATTRIBUTE('or_planned_items.planned_items_id', 'pk', IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE(SBITEMS, 'items_id', IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE('or_planned_items.item_amount', 'item_amount', IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE('or_planned_items.element_code', 'element_code', IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE('or_planned_items.value', 'Costo', IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE(':parent_id', 'parent_id', IOSBATTRIBUTES);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;

    END FILLPLANNEDITEMSATTRIB;

    
    PROCEDURE GETPLANNEDITEMBYID
    (
        INUPLANNED_ITEMS_ID     IN OR_PLANNED_ITEMS.PLANNED_ITEMS_ID%TYPE,
        ORFRESULT               OUT CONSTANTS.TYREFCURSOR
    )
    IS
        SBATTRIBUTES        GE_BOUTILITIES.STYSTATEMENT;
        SBSQL               GE_BOUTILITIES.STYSTATEMENT;

    BEGIN
        FILLPLANNEDITEMSATTRIB(SBATTRIBUTES);

        SBSQL := '
            SELECT '|| SBATTRIBUTES ||'
            FROM or_planned_items
            WHERE planned_items_id = :inuPlanned_items_id
            ';

        UT_TRACE.TRACE(SBSQL);

        OPEN ORFRESULT FOR SBSQL
            USING CNUNULL, INUPLANNED_ITEMS_ID;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;

    END GETPLANNEDITEMBYID;

    
    PROCEDURE GETPLANNITEMBYPLANNACTIV
    (
        INUORDER_ACTIVITY_ID    IN OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE,
        ORFRESULT               OUT CONSTANTS.TYREFCURSOR
    )
    IS
        SBATTRIBUTES            GE_BOUTILITIES.STYSTATEMENT;
        SBSQL                   GE_BOUTILITIES.STYSTATEMENT;

    BEGIN
        FILLPLANNEDITEMSATTRIB(SBATTRIBUTES);

        SBSQL := '
            SELECT '|| SBATTRIBUTES ||'
            FROM OR_planned_items
            WHERE order_activity_id = :inuOrder_activity_id
            ';

        OPEN ORFRESULT FOR SBSQL
            USING INUORDER_ACTIVITY_ID, INUORDER_ACTIVITY_ID;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;

    END GETPLANNITEMBYPLANNACTIV;


    



    PROCEDURE GETPLANACTIVBYORDERID
    (
        INUORDERID  IN VARCHAR2,
        ORFRESULT   OUT CONSTANTS.TYREFCURSOR
    )
    IS
        SBATTRIBUTES            GE_BOUTILITIES.STYSTATEMENT;
        SBSQL                   GE_BOUTILITIES.STYSTATEMENT;

    BEGIN


        FILLPLANNEDACTIVITATTRIB(SBATTRIBUTES);

        SBSQL := '
            SELECT '|| SBATTRIBUTES ||'
            FROM OR_order_activity
            WHERE origin_activity_id IN
            (select ORDER_activity_id FROM  OR_order_activity WHERE order_id = :inuOrderId)
            ';

        OPEN ORFRESULT FOR SBSQL
            USING INUORDERID, INUORDERID;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;

    END GETPLANACTIVBYORDERID;

    PROCEDURE GETPACKAGEID
    (
        INUORDERID          IN  OR_ORDER.ORDER_ID%TYPE,
        ONUPACKAGEID        OUT MO_PACKAGES.PACKAGE_ID%TYPE
    )
    IS
        TBACTBYORDER    OR_BCORDERACTIVITIES.TBDATAACTIVITIES;
    BEGIN

        IF INUORDERID IS NULL THEN
            ONUPACKAGEID := NULL;
            RETURN;
        END IF;

        OR_BCORDERACTIVITIES.GETACTBASICDATABYORDER(INUORDERID, TBACTBYORDER);

        ONUPACKAGEID := TBACTBYORDER(TBACTBYORDER.FIRST).PACKAGE_ID;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ONUPACKAGEID := NULL;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    PROCEDURE GETORDERBYPLANNEDACT
    (
        INUORDERACTIVITYID      IN  OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE,
        ONUORDERID              OUT OR_ORDER.ORDER_ID%TYPE
    )
    IS
        NUORIGINACTIVITY    OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE;
    BEGIN

        IF INUORDERACTIVITYID IS NULL THEN
            ONUORDERID := NULL;
            RETURN;
        END IF;

        DAOR_ORDER_ACTIVITY.ACCKEY(INUORDERACTIVITYID);

        NUORIGINACTIVITY := DAOR_ORDER_ACTIVITY.FNUGETORIGIN_ACTIVITY_ID(INUORDERACTIVITYID);
        
        DAOR_ORDER_ACTIVITY.ACCKEY(NUORIGINACTIVITY);

        ONUORDERID := DAOR_ORDER_ACTIVITY.FNUGETORDER_ID(NUORIGINACTIVITY);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ONUORDERID := NULL;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    PROCEDURE GETPLANACTBYPLANITEM
    (
        INUPLANNEDITEMID        IN  OR_PLANNED_ITEMS.PLANNED_ITEMS_ID%TYPE,
        ONUORDERACTIVITYID      OUT OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE
    )
    IS
    BEGIN

        IF INUPLANNEDITEMID IS NULL THEN
            ONUORDERACTIVITYID := NULL;
            RETURN;
        END IF;

        DAOR_PLANNED_ITEMS.ACCKEY(INUPLANNEDITEMID);

        ONUORDERACTIVITYID := DAOR_PLANNED_ITEMS.FNUGETORDER_ACTIVITY_ID(INUPLANNEDITEMID);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ONUORDERACTIVITYID := NULL;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    PROCEDURE GETMOTIVEID
    (
        INUORDERID          IN  OR_ORDER.ORDER_ID%TYPE,
        ONUMOTIVEID         OUT MO_MOTIVE.MOTIVE_ID%TYPE
    )
    IS
        TBACTBYORDER    OR_BCORDERACTIVITIES.TBDATAACTIVITIES;
    BEGIN

        IF INUORDERID IS NULL THEN
            ONUMOTIVEID := NULL;
            RETURN;
        END IF;

        OR_BCORDERACTIVITIES.GETACTBASICDATABYORDER(INUORDERID, TBACTBYORDER);

        ONUMOTIVEID := TBACTBYORDER(TBACTBYORDER.FIRST).MOTIVE_ID;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ONUMOTIVEID := NULL;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    PROCEDURE GETCOMPONENTID
    (
        INUORDERID          IN  OR_ORDER.ORDER_ID%TYPE,
        ONUCOMPONENTID      OUT MO_COMPONENT.COMPONENT_ID%TYPE
    )
    IS
        TBACTBYORDER    OR_BCORDERACTIVITIES.TBDATAACTIVITIES;
    BEGIN

        IF INUORDERID IS NULL THEN
            ONUCOMPONENTID := NULL;
            RETURN;
        END IF;

        OR_BCORDERACTIVITIES.GETACTBASICDATABYORDER(INUORDERID, TBACTBYORDER);

        ONUCOMPONENTID := TBACTBYORDER(TBACTBYORDER.FIRST).COMPONENT_ID;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ONUCOMPONENTID := NULL;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    PROCEDURE GETORDERATTACHFILES
    (
       INUORDERID      IN      OR_ORDER.ORDER_ID%TYPE,
       ORFCURSOR       OUT     CONSTANTS.TYREFCURSOR
    )
    IS
    BEGIN
        UT_TRACE.TRACE('Iniciando OR_boSearchDataServices.GetOrderAttachFiles OrderId['||INUORDERID||']', 5);

        
        CC_BOOSSATTACHFILES.GETATTACHEDFILES(CSBOR_FW_OR_ORDER,INUORDERID,ORFCURSOR);

        UT_TRACE.TRACE('Fin de OR_boSearchDataServices.GetOrderAttachFiles', 5);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;





    PROCEDURE GETINSPDETABYORDERID
    (
        ISBORDERITEMSID IN  VARCHAR2,
        OCUDATACURSOR   OUT CONSTANTS.TYREFCURSOR
    )
    IS
      SBSQL                          GE_BOUTILITIES.STYSTATEMENT;
      NUORDERID                      OR_ORDER.ORDER_ID%TYPE;
      SBINSPDETABYORDERIDATTRIBUTES  GE_BOUTILITIES.STYSTATEMENT;
      
      PROCEDURE FILLINSPDETABYORDERIDATT
      IS
          SBITEMS              GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
          SBSERIE              GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
          SBMEASUREUNIT        GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
      BEGIN
          IF SBINSPDETABYORDERIDATTRIBUTES IS NOT NULL THEN
              RETURN;
          END IF;

          
          SBITEMS := 'or_items_orden_inspe.id_item_orden' || GE_BOUTILITIES.CSBSEPARATOR || 'dage_items.fsbGetCode(or_items_orden_inspe.id_item_orden,0)';
          SBITEMS := SBITEMS || GE_BOUTILITIES.CSBSEPARATOR || 'dage_items.fsbGetDescription(or_items_orden_inspe.id_item_orden,0)';
          SBMEASUREUNIT := 'dage_measure_unit.fsbgetdescription(dage_items.fnuGetMeasure_unit_id(or_items_orden_inspe.id_item_orden,0),0)';
          SBSERIE := 'dage_items_seriado.fsbGetSerie(OR_ITEMS_ORDEN_INSPE.ID_ITEMS_SERIADO,0)';

          
          GE_BOUTILITIES.ADDATTRIBUTE ('OR_ITEMS_ORDEN_INSPE.ID_ITEM_ORDENS_INSPE','ID_ITEM_ORDENS_INSPE',SBINSPDETABYORDERIDATTRIBUTES);
          GE_BOUTILITIES.ADDATTRIBUTE (SBITEMS,'ITEMS',SBINSPDETABYORDERIDATTRIBUTES);
          GE_BOUTILITIES.ADDATTRIBUTE (SBSERIE,'SERIE',SBINSPDETABYORDERIDATTRIBUTES);
          GE_BOUTILITIES.ADDATTRIBUTE (SBMEASUREUNIT,'MEASURE_UNIT',SBINSPDETABYORDERIDATTRIBUTES);
          GE_BOUTILITIES.ADDATTRIBUTE ('OR_ITEMS_ORDEN_INSPE.CANT_ITEM_LEGALIZADA','CANT_ITEM_LEGALIZADA',SBINSPDETABYORDERIDATTRIBUTES);
          GE_BOUTILITIES.ADDATTRIBUTE ('decode(OR_ITEMS_ORDEN_INSPE.INSPECCIONADA,ge_boConstants.GetYes,''Si'',''No'')','INSPECCIONADA',SBINSPDETABYORDERIDATTRIBUTES);
          GE_BOUTILITIES.ADDATTRIBUTE (':parent_id','parent_id',SBINSPDETABYORDERIDATTRIBUTES);
      EXCEPTION
          WHEN EX.CONTROLLED_ERROR THEN
              RAISE EX.CONTROLLED_ERROR;
          WHEN OTHERS THEN
              ERRORS.SETERROR;
              RAISE EX.CONTROLLED_ERROR;
      END FILLINSPDETABYORDERIDATT;
      
    BEGIN
        NUORDERID := DAOR_ORDER_ITEMS.FNUGETORDER_ID(TO_NUMBER(ISBORDERITEMSID), 0);

        
        FILLINSPDETABYORDERIDATT;
        
        
        SBSQL := 'SELECT '|| SBINSPDETABYORDERIDATTRIBUTES ||CHR(10)||
                 ' FROM OR_ITEMS_ORDEN_INSPE ' ||CHR(10)||
                 ' WHERE OR_ITEMS_ORDEN_INSPE.ID_ORDEN = :inuOrderId ' || CHR(10) ||
                 ' AND OR_ITEMS_ORDEN_INSPE.MODO_INSERCION <> CT_BOConstants.fsbgetCertificateInsMode';

        
        OPEN OCUDATACURSOR FOR SBSQL USING ISBORDERITEMSID,NUORDERID;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETINSPDETABYORDERID;





    PROCEDURE GETANOMREGBYINSPDETA
    (
        ISBITEMINSPID   IN  VARCHAR2,
        OCUDATACURSOR   OUT CONSTANTS.TYREFCURSOR
    )
    IS
      SBSQL                          GE_BOUTILITIES.STYSTATEMENT;
      NUITEMINSPID                   OR_ITEMS_ORDEN_INSPE.ID_ITEM_ORDENS_INSPE%TYPE;
      SBANOMREGBYINSPDETAATTRIBUTES  GE_BOUTILITIES.STYSTATEMENT;
      
      PROCEDURE FILLANOMREGBYINSPDETAATT
      IS
          SBTIPOCOMEN          GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
      BEGIN
          IF SBANOMREGBYINSPDETAATTRIBUTES IS NOT NULL THEN
              RETURN;
          END IF;

          
          SBTIPOCOMEN := 'or_order_comment.comment_type_id'||GE_BOUTILITIES.CSBSEPARATOR ||'dage_comment_type.fsbgetdescription(or_order_comment.comment_type_id,0)';

          
          GE_BOUTILITIES.ADDATTRIBUTE ('OR_LOG_ORDENES_INSPE.ID_LOG_ORDENES_INSPE','ID_LOG_ORDENES_INSPE',SBANOMREGBYINSPDETAATTRIBUTES);
          GE_BOUTILITIES.ADDATTRIBUTE ('OR_ORDER_COMMENT.REGISTER_DATE','FECHA_REGISTRO',SBANOMREGBYINSPDETAATTRIBUTES);
          GE_BOUTILITIES.ADDATTRIBUTE (SBTIPOCOMEN,'TIPO_COMENTARIO',SBANOMREGBYINSPDETAATTRIBUTES);
          GE_BOUTILITIES.ADDATTRIBUTE ('OR_ORDER_COMMENT.ORDER_COMMENT','ANOMALIA',SBANOMREGBYINSPDETAATTRIBUTES);
          GE_BOUTILITIES.ADDATTRIBUTE ('decode(OR_LOG_ORDENES_INSPE.VALIDO,ge_boConstants.GetYes,''Si'',''No'')','VALIDO',SBANOMREGBYINSPDETAATTRIBUTES);
          GE_BOUTILITIES.ADDATTRIBUTE (':parent_id','parent_id',SBANOMREGBYINSPDETAATTRIBUTES);
      EXCEPTION
          WHEN EX.CONTROLLED_ERROR THEN
              RAISE EX.CONTROLLED_ERROR;
          WHEN OTHERS THEN
              ERRORS.SETERROR;
              RAISE EX.CONTROLLED_ERROR;
      END FILLANOMREGBYINSPDETAATT;
      
    BEGIN
        NUITEMINSPID := TO_NUMBER(ISBITEMINSPID);

        
        FILLANOMREGBYINSPDETAATT;

        
        SBSQL := 'select '|| SBANOMREGBYINSPDETAATTRIBUTES ||CHR(10)||
                 ' from OR_LOG_ORDENES_INSPE, OR_ORDER_COMMENT ' ||CHR(10)||
                 ' where OR_LOG_ORDENES_INSPE.ID_ITEMS_ORDEN_INSPE = :inuItemInspId ' ||CHR(10)||
                 ' and OR_LOG_ORDENES_INSPE.ID_COMENTARIO_ANOMALIA = OR_ORDER_COMMENT.ORDER_COMMENT_ID';

        
        OPEN OCUDATACURSOR FOR SBSQL USING ISBITEMINSPID,NUITEMINSPID;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETANOMREGBYINSPDETA;





    PROCEDURE GETINSPDOWNBYANOMREG
    (
        ISBINSPLOGID    IN  VARCHAR2,
        OCUDATACURSOR   OUT CONSTANTS.TYREFCURSOR
    )
    IS
      SBSQL                          GE_BOUTILITIES.STYSTATEMENT;
      NUINSPLOGID                    OR_LOG_ORDENES_INSPE.ID_LOG_ORDENES_INSPE%TYPE;
      SBINSPDOWNBYANOMREGATTRIBUTES  GE_BOUTILITIES.STYSTATEMENT;
      
      PROCEDURE FILLINSPDOWNBYANOMREGATT
      IS
          SBTIPOCOMEN          GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
      BEGIN
          IF SBINSPDOWNBYANOMREGATTRIBUTES IS NOT NULL THEN
              RETURN;
          END IF;

          
          SBTIPOCOMEN := 'or_order_comment.comment_type_id'||GE_BOUTILITIES.CSBSEPARATOR ||'dage_comment_type.fsbgetdescription(or_order_comment.comment_type_id,0)';

          
          GE_BOUTILITIES.ADDATTRIBUTE ('OR_LOG_ORDENES_INSPE.ID_LOG_ORDENES_INSPE','ID_LOG_ORDENES_INSPE',SBINSPDOWNBYANOMREGATTRIBUTES);
          GE_BOUTILITIES.ADDATTRIBUTE ('OR_ORDER_COMMENT.REGISTER_DATE','FECHA_REGISTRO',SBINSPDOWNBYANOMREGATTRIBUTES);
          GE_BOUTILITIES.ADDATTRIBUTE (SBTIPOCOMEN,'TIPO_COMENTARIO',SBINSPDOWNBYANOMREGATTRIBUTES);
          GE_BOUTILITIES.ADDATTRIBUTE ('OR_ORDER_COMMENT.ORDER_COMMENT','DESCARGA',SBINSPDOWNBYANOMREGATTRIBUTES);
          GE_BOUTILITIES.ADDATTRIBUTE (':parent_id','parent_id',SBINSPDOWNBYANOMREGATTRIBUTES);
      EXCEPTION
          WHEN EX.CONTROLLED_ERROR THEN
              RAISE EX.CONTROLLED_ERROR;
          WHEN OTHERS THEN
              ERRORS.SETERROR;
              RAISE EX.CONTROLLED_ERROR;
      END FILLINSPDOWNBYANOMREGATT;
      
    BEGIN
        NUINSPLOGID := TO_NUMBER(ISBINSPLOGID);

        
        FILLINSPDOWNBYANOMREGATT;

        
        SBSQL := 'select '|| SBINSPDOWNBYANOMREGATTRIBUTES ||CHR(10)||
                 ' from OR_LOG_ORDENES_INSPE, OR_ORDER_COMMENT ' ||CHR(10)||
                 ' where OR_LOG_ORDENES_INSPE.ID_LOG_ORDENES_INSPE = :inuInspLogId ' ||CHR(10)||
                 ' and OR_LOG_ORDENES_INSPE.ID_COMENTARIO_DESCARGA = OR_ORDER_COMMENT.ORDER_COMMENT_ID';

        
        OPEN OCUDATACURSOR FOR SBSQL USING ISBINSPLOGID,NUINSPLOGID;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETINSPDOWNBYANOMREG;






    PROCEDURE GETCOMPONENTBYPROD
    (
        ISBEXTERNALID IN  VARCHAR2,
        OCUDATACURSOR OUT CONSTANTS.TYREFCURSOR
    )
    IS
        SBSQL                    GE_BOUTILITIES.STYSTATEMENT;
        NUPRODUCTID              PR_COMPONENT.PRODUCT_ID%TYPE;
        SBHINTS                  VARCHAR2(1000);
    BEGIN
        IF (ISBEXTERNALID IS NOT NULL) THEN
            
            
            IF (UT_STRING.EXTSTRFIELD(ISBEXTERNALID,'-',3) IS NOT NULL) THEN
                NUPRODUCTID := TO_NUMBER(TRIM(UT_STRING.EXTSTRFIELD(ISBEXTERNALID,'-',3)));
            ELSE
                NUPRODUCTID := NULL;
            END IF;
        ELSE
            NUPRODUCTID := NULL;
        END IF;

        
        CC_BOOSSPRODUCTCOMPONENT.FILLCOMPONENTATTRIBUTES;

        SBHINTS := ' /*+ leading(a) index(a IDX_PR_COMPONENT_2 )'                 ||CHR(10)||
                    CC_BOOSSPRODUCTCOMPONENT.SBCOMPHINTSDEF;

        
        SBSQL := 'SELECT '||SBHINTS||CC_BOOSSPRODUCTCOMPONENT.SBCOMPONENTATTR ||CHR(10)||
                 'FROM '||CC_BOOSSPRODUCTCOMPONENT.SBCOMPONENTFROM ||CHR(10)||
                 'WHERE  a.PRODUCT_ID = :nuProductId '||CHR(10)||
                 'AND '||CC_BOOSSPRODUCTCOMPONENT.SBCOMPONENTWHERE;

        
        OPEN OCUDATACURSOR FOR SBSQL USING ISBEXTERNALID,
                                           NUPRODUCTID;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETCOMPONENTBYPROD;


    



















    PROCEDURE GETDAMAGESBYORDER
    (
        ISBORDERID    IN  VARCHAR2,
        OCUDATACURSOR OUT CONSTANTS.TYREFCURSOR
    )
    IS
        SBSQL                      GE_BOUTILITIES.STYSTATEMENT;
        NUORDERID                  OR_ORDER.ORDER_ID%TYPE;
        SBDAMAGESBYORDERATTRIBUTES GE_BOUTILITIES.STYSTATEMENT;
    BEGIN
        NUORDERID := TO_NUMBER(ISBORDERID);

        
        TT_BOSEARCHDATASERVICES.FILLELEMENTDAMAGEATTRIBUTES(SBDAMAGESBYORDERATTRIBUTES);

        
        SBSQL := 'select '|| SBDAMAGESBYORDERATTRIBUTES ||CHR(10)||
                 ' from TT_DAMAGE, MO_PACKAGES, OR_ORDER_ACTIVITY ' ||CHR(10)||
                 ' where MO_PACKAGES.PACKAGE_ID = TT_DAMAGE.PACKAGE_ID ' ||CHR(10)||
                 ' and MO_PACKAGES.PACKAGE_ID = OR_ORDER_ACTIVITY.PACKAGE_ID ' ||CHR(10)||
                 ' and OR_ORDER_ACTIVITY.ORDER_ID = :inuOrderId ';

        
        OPEN OCUDATACURSOR FOR SBSQL USING ISBORDERID,
                                           NUORDERID;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETDAMAGESBYORDER;





    PROCEDURE GETPERSONBYORDER
    (
        ISBORDERID    IN  VARCHAR2,
        OCUDATACURSOR OUT CONSTANTS.TYREFCURSOR
    )
    IS
      SBSQL                      GE_BOUTILITIES.STYSTATEMENT;
      NUORDERID                  OR_ORDER.ORDER_ID%TYPE;
      SBPERSONBYORDERATTRIBUTES  GE_BOUTILITIES.STYSTATEMENT;
      RCSCHEDPROGRAMING          DAOR_SCHED_PROGRAMING.STYOR_SCHED_PROGRAMING;
      
      PROCEDURE FILLPERSONBYORDERATT
      IS
          SBPERSONALTYPE          GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
          SBORGANIZATAREA         GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
          SBADDRESS               GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
      BEGIN
          IF SBPERSONBYORDERATTRIBUTES IS NOT NULL THEN
              RETURN;
          END IF;

          
          SBPERSONALTYPE  := 'ge_person.personal_type'||GE_BOUTILITIES.CSBSEPARATOR ||'ge_personal_type.description';
          SBORGANIZATAREA := 'ge_person.organizat_area_id '||GE_BOUTILITIES.CSBSEPARATOR ||'ge_organizat_area.display_description';
          
          SBADDRESS       := '(select ab_address.address_parsed FROM ab_address WHERE ab_address.address_id = GE_PERSON.ADDRESS_ID)';

          
          GE_BOUTILITIES.ADDATTRIBUTE ('GE_PERSON.PERSON_ID','PERSON_ID',SBPERSONBYORDERATTRIBUTES);
          GE_BOUTILITIES.ADDATTRIBUTE ('GE_PERSON.NAME_','NAME_',SBPERSONBYORDERATTRIBUTES);
          GE_BOUTILITIES.ADDATTRIBUTE (SBADDRESS,'ADDRESS',SBPERSONBYORDERATTRIBUTES);
          GE_BOUTILITIES.ADDATTRIBUTE (SBPERSONALTYPE,'PERSONAL_TYPE',SBPERSONBYORDERATTRIBUTES);
          GE_BOUTILITIES.ADDATTRIBUTE ('GE_PERSON.PHONE_NUMBER','PHONE_NUMBER',SBPERSONBYORDERATTRIBUTES);
          GE_BOUTILITIES.ADDATTRIBUTE ('GE_PERSON.E_MAIL','E_MAIL',SBPERSONBYORDERATTRIBUTES);
          GE_BOUTILITIES.ADDATTRIBUTE (SBORGANIZATAREA,'ORGANIZAT_AREA',SBPERSONBYORDERATTRIBUTES);
          GE_BOUTILITIES.ADDATTRIBUTE (':parent_id','parent_id',SBPERSONBYORDERATTRIBUTES);
      EXCEPTION
          WHEN EX.CONTROLLED_ERROR THEN
              RAISE EX.CONTROLLED_ERROR;
          WHEN OTHERS THEN
              ERRORS.SETERROR;
              RAISE EX.CONTROLLED_ERROR;
      END FILLPERSONBYORDERATT;
      
    BEGIN
        NUORDERID := TO_NUMBER(ISBORDERID);

        
        FILLPERSONBYORDERATT;

        
        IF (OR_BCPROGRAMING.FBLEXISTSPROGBYORDER(NUORDERID, RCSCHEDPROGRAMING)) THEN
            
            SBSQL := 'select '|| SBPERSONBYORDERATTRIBUTES ||CHR(10)||
                     ' from OR_PERSONA_DISPONIB, GE_PERSON, GE_PERSONAL_TYPE, GE_ORGANIZAT_AREA ' ||CHR(10)||
                     ' where GE_PERSON.PERSON_ID = OR_PERSONA_DISPONIB.ID_PERSONA ' ||CHR(10)||
                     ' and GE_PERSON.PERSONAL_TYPE = GE_PERSONAL_TYPE.PERSONAL_TYPE ' ||CHR(10)||
                     ' and GE_PERSON.ORGANIZAT_AREA_ID = GE_ORGANIZAT_AREA.ORGANIZAT_AREA_ID(+) ' ||CHR(10)||
                     ' and OR_PERSONA_DISPONIB.ID_DISPONIBILIDAD = :inuDisponibilidad ';
                     
            
            OPEN OCUDATACURSOR FOR SBSQL USING ISBORDERID, RCSCHEDPROGRAMING.SCHED_AVAILABLE_ID;
        ELSE
            
            
            SBSQL := 'select '|| SBPERSONBYORDERATTRIBUTES ||CHR(10)||
                     ' from OR_OPER_UNIT_PERSONS, GE_PERSON, GE_PERSONAL_TYPE, GE_ORGANIZAT_AREA ' ||CHR(10)||
                     ' where GE_PERSON.PERSON_ID = OR_OPER_UNIT_PERSONS.PERSON_ID ' ||CHR(10)||
                     ' and GE_PERSON.PERSONAL_TYPE = GE_PERSONAL_TYPE.PERSONAL_TYPE ' ||CHR(10)||
                     ' and GE_PERSON.ORGANIZAT_AREA_ID = GE_ORGANIZAT_AREA.ORGANIZAT_AREA_ID(+) ' ||CHR(10)||
                     ' and OR_OPER_UNIT_PERSONS.OPERATING_UNIT_ID = :inuOperatingUnit ';

            
            OPEN OCUDATACURSOR FOR SBSQL USING ISBORDERID, DAOR_ORDER.FNUGETOPERATING_UNIT_ID(NUORDERID, 0);
        END IF;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETPERSONBYORDER;


    PROCEDURE FILLROLUNIDADTRABATTRIB
    (
        IOSBATTRIBUTES IN OUT GE_BOUTILITIES.STYSTATEMENT
    )
      IS
          SBTIPOCOMEN          GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
      BEGIN
          IF IOSBATTRIBUTES IS NOT NULL THEN
              RETURN;
          END IF;

          
          GE_BOUTILITIES.ADDATTRIBUTE ('OR_ROL_UNIDAD_TRAB.ID_ROL_UNIDAD_TRAB','ID_ROL_UNIDAD_TRAB',IOSBATTRIBUTES);
          GE_BOUTILITIES.ADDATTRIBUTE ('OR_ROL_UNIDAD_TRAB.id_rol','ID_ROL',IOSBATTRIBUTES);
          GE_BOUTILITIES.ADDATTRIBUTE ('sa_role.name','ROLE_NAME',IOSBATTRIBUTES);
          GE_BOUTILITIES.ADDATTRIBUTE ('sa_role.description','DESCRIPTION',IOSBATTRIBUTES);
          GE_BOUTILITIES.ADDATTRIBUTE (':parent_id','parent_id',IOSBATTRIBUTES);
      EXCEPTION
          WHEN EX.CONTROLLED_ERROR THEN
              RAISE EX.CONTROLLED_ERROR;
          WHEN OTHERS THEN
              ERRORS.SETERROR;
              RAISE EX.CONTROLLED_ERROR;
      END FILLROLUNIDADTRABATTRIB;

    PROCEDURE OBTROLPORID
    (
        INUROLUNIDADTRABID      IN OR_ROL_UNIDAD_TRAB.ID_ROL_UNIDAD_TRAB%TYPE,
        ORFRESULT               OUT CONSTANTS.TYREFCURSOR
    )
    IS
        SBATTRIBUTES        GE_BOUTILITIES.STYSTATEMENT;
        SBSQL               GE_BOUTILITIES.STYSTATEMENT;



    BEGIN
        FILLROLUNIDADTRABATTRIB(SBATTRIBUTES);

        SBSQL := '
            SELECT '|| SBATTRIBUTES ||'
            FROM or_rol_unidad_trab, sa_role
            WHERE id_rol_unidad_trab = :inuRolUnidadTrabId
            AND OR_ROL_UNIDAD_TRAB.id_rol = sa_role.role_id
            ';

        UT_TRACE.TRACE(SBSQL);

        OPEN ORFRESULT FOR SBSQL
            USING CNUNULL, INUROLUNIDADTRABID;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;

    END OBTROLPORID;

    PROCEDURE OBTROLESDEUNIDAD
    (
        INUUNIDADTRABAJOID      IN OR_ROL_UNIDAD_TRAB.ID_ROL_UNIDAD_TRAB%TYPE,
        ORFRESULT               OUT CONSTANTS.TYREFCURSOR
    )
    IS
        SBATTRIBUTES        GE_BOUTILITIES.STYSTATEMENT;
        SBSQL               GE_BOUTILITIES.STYSTATEMENT;
    BEGIN
        FILLROLUNIDADTRABATTRIB(SBATTRIBUTES);

        SBSQL := '
            SELECT '|| SBATTRIBUTES ||'
            FROM or_rol_unidad_trab, sa_role
            WHERE or_rol_unidad_trab.id_unidad_operativa = :inuUnidadTrabajoId
            AND OR_ROL_UNIDAD_TRAB.id_rol = sa_role.role_id
            ';

        UT_TRACE.TRACE(SBSQL);

        OPEN ORFRESULT FOR SBSQL
            USING INUUNIDADTRABAJOID, INUUNIDADTRABAJOID;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;

    END;
   
    PROCEDURE FILLROLACTIVIDADATTRIB
    (
        IOSBATTRIBUTES IN OUT GE_BOUTILITIES.STYSTATEMENT
    )
      IS
          SBTIPOCOMEN          GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
      BEGIN
          IF IOSBATTRIBUTES IS NOT NULL THEN
              RETURN;
          END IF;

          
          GE_BOUTILITIES.ADDATTRIBUTE ('or_actividades_rol.id_actividad_rol','ID_ACTIVIDAD_ROL',IOSBATTRIBUTES);
          GE_BOUTILITIES.ADDATTRIBUTE ('ge_items.items_id','ITEMS_ID',IOSBATTRIBUTES);
          GE_BOUTILITIES.ADDATTRIBUTE ('ge_items.description','DESCRIPTION',IOSBATTRIBUTES);
          GE_BOUTILITIES.ADDATTRIBUTE (':parent_id','parent_id',IOSBATTRIBUTES);
      EXCEPTION
          WHEN EX.CONTROLLED_ERROR THEN
              RAISE EX.CONTROLLED_ERROR;
          WHEN OTHERS THEN
              ERRORS.SETERROR;
              RAISE EX.CONTROLLED_ERROR;
      END FILLROLACTIVIDADATTRIB;

    PROCEDURE OBTACTIVIDADPORID
    (
        INUROLACTIVIDADID       IN OR_ACTIVIDADES_ROL.ID_ACTIVIDAD_ROL%TYPE,
        ORFRESULT               OUT CONSTANTS.TYREFCURSOR
    )
    IS
        SBATTRIBUTES        GE_BOUTILITIES.STYSTATEMENT;
        SBSQL               GE_BOUTILITIES.STYSTATEMENT;
    BEGIN
        FILLROLACTIVIDADATTRIB(SBATTRIBUTES);

        SBSQL := '
            SELECT '|| SBATTRIBUTES ||'
            FROM or_actividades_rol, ge_items
            WHERE id_actividad_rol = :inuRolActividadId
            AND or_actividades_rol.id_actividad = ge_items.items_id
            ';

        UT_TRACE.TRACE(SBSQL);

        OPEN ORFRESULT FOR SBSQL
            USING CNUNULL, INUROLACTIVIDADID;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;

    END OBTACTIVIDADPORID;

    PROCEDURE OBTACTIVIDADROL
    (
        INUROLID                IN OR_ACTIVIDADES_ROL.ID_ROL%TYPE,
        ORFRESULT               OUT CONSTANTS.TYREFCURSOR
    )
    IS
        SBATTRIBUTES        GE_BOUTILITIES.STYSTATEMENT;
        SBSQL               GE_BOUTILITIES.STYSTATEMENT;
    BEGIN
        FILLROLACTIVIDADATTRIB(SBATTRIBUTES);

        SBSQL := '
            SELECT '|| SBATTRIBUTES ||'
            FROM or_actividades_rol, ge_items, or_rol_unidad_trab
            WHERE or_rol_unidad_trab.id_rol_unidad_trab = :inuRolId
            AND or_actividades_rol.id_actividad = ge_items.items_id
            AND or_rol_unidad_trab.id_rol = or_actividades_rol.id_rol
            ';

        UT_TRACE.TRACE(SBSQL);

        OPEN ORFRESULT FOR SBSQL
            USING INUROLID, INUROLID;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;

    END OBTACTIVIDADROL;
   
    PROCEDURE FILLEXEPACTUNIATTRIB
    (
        IOSBATTRIBUTES IN OUT GE_BOUTILITIES.STYSTATEMENT
    )
      IS
          SBTIPOCOMEN          GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
      BEGIN
          IF IOSBATTRIBUTES IS NOT NULL THEN
              RETURN;
          END IF;

          
          GE_BOUTILITIES.ADDATTRIBUTE ('or_excep_act_unitrab.id_excep_act_unitrab','ID_EXCEP_ACT_UNITRAB',IOSBATTRIBUTES);
          GE_BOUTILITIES.ADDATTRIBUTE ('ge_items.items_id','ITEMS_ID',IOSBATTRIBUTES);
          GE_BOUTILITIES.ADDATTRIBUTE ('ge_items.description','DESCRIPTION',IOSBATTRIBUTES);
          GE_BOUTILITIES.ADDATTRIBUTE (':parent_id','parent_id',IOSBATTRIBUTES);
      EXCEPTION
          WHEN EX.CONTROLLED_ERROR THEN
              RAISE EX.CONTROLLED_ERROR;
          WHEN OTHERS THEN
              ERRORS.SETERROR;
              RAISE EX.CONTROLLED_ERROR;
      END FILLEXEPACTUNIATTRIB;

    PROCEDURE GETACTIVIDADPORID
    (
        INUEXEPACTUNIID         IN OR_EXCEP_ACT_UNITRAB.ID_EXCEP_ACT_UNITRAB%TYPE,
        ORFRESULT               OUT CONSTANTS.TYREFCURSOR
    )
    IS
        SBATTRIBUTES        GE_BOUTILITIES.STYSTATEMENT;
        SBSQL               GE_BOUTILITIES.STYSTATEMENT;
    BEGIN
        FILLEXEPACTUNIATTRIB(SBATTRIBUTES);

        SBSQL := '
            SELECT '|| SBATTRIBUTES ||'
            FROM or_excep_act_unitrab, ge_items
            WHERE id_excep_act_unitrab = :inuExepActUniId
            AND or_excep_act_unitrab.id_actividad = ge_items.items_id
            ';

        UT_TRACE.TRACE(SBSQL);

        OPEN ORFRESULT FOR SBSQL
            USING CNUNULL, INUEXEPACTUNIID;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;

    END GETACTIVIDADPORID;

    PROCEDURE GETEXEPACTPORUNIDAD
    (
        INUUNIDADTRABAJOID      IN OR_EXCEP_ACT_UNITRAB.ID_UNIDAD_OPERATIVA%TYPE,
        ORFRESULT               OUT CONSTANTS.TYREFCURSOR
    )
    IS
        SBATTRIBUTES        GE_BOUTILITIES.STYSTATEMENT;
        SBSQL               GE_BOUTILITIES.STYSTATEMENT;
    BEGIN
        FILLEXEPACTUNIATTRIB(SBATTRIBUTES);

        SBSQL := '
            SELECT '|| SBATTRIBUTES ||'
            FROM or_excep_act_unitrab, ge_items
            WHERE or_excep_act_unitrab.id_unidad_operativa = :inuUnidadTrabajoId
            AND or_excep_act_unitrab.id_actividad = ge_items.items_id
            ';

        UT_TRACE.TRACE(SBSQL);

        OPEN ORFRESULT FOR SBSQL
            USING INUUNIDADTRABAJOID, INUUNIDADTRABAJOID;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;

    END GETEXEPACTPORUNIDAD;
    
    
    















    PROCEDURE TRACE
    (
        ISBTRACE IN VARCHAR2,
        NULEVEL IN NUMBER
    )
    IS
        CNUMAXLENLINE CONSTANT  NUMBER(3) := 200;
        SBSUBTRACE              VARCHAR2(32000);
        NUSIZE                  NUMBER(3);
        SBCHAR                  VARCHAR2(1);
        NUNEXTINIT              NUMBER(10);
    BEGIN
        IF ISBTRACE IS NULL THEN
            RETURN;
        END IF;

        NUNEXTINIT := 1;
        LOOP
            NUSIZE := CNUMAXLENLINE;
            
            IF ( LENGTH(ISBTRACE) - NUNEXTINIT ) > CNUMAXLENLINE THEN
                LOOP
                    SBCHAR := UPPER(SUBSTR(ISBTRACE,NUNEXTINIT+NUSIZE,1));
                    IF      (NOT SBCHAR BETWEEN '0' AND '9')
                        AND (NOT SBCHAR BETWEEN 'A' AND 'Z')
                        AND (SBCHAR != '?')
                        AND (SBCHAR != '_') AND (SBCHAR != '.')
                    THEN
                        EXIT;
                    ELSE
                        NUSIZE := NUSIZE - 1;
                    END IF;
                    IF NUSIZE<2 THEN
                       NUSIZE := CNUMAXLENLINE;
                       EXIT;
                    END IF;
                END LOOP;
            END IF;

            SBSUBTRACE := SUBSTR(ISBTRACE,NUNEXTINIT,NUSIZE );
            UT_TRACE.TRACE(SBSUBTRACE,NULEVEL);

            NUNEXTINIT := NUNEXTINIT + NUSIZE;
            EXIT WHEN NUNEXTINIT > LENGTH(ISBTRACE);
        END LOOP;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    















    FUNCTION FSBFILLPRODUCTCERTIFICATE
    RETURN   VARCHAR2
    IS
        SBCERTIFICATE   VARCHAR2(20000);
    BEGIN
        UT_TRACE.TRACE('Inicio OR_boSearchDataServices.fsbFillSubscriberRolProduct', 5);

        SBCERTIFICATE:= '/*+'||CHR(10)||
                    'ordered'||CHR(10)||
                    'use_nl(cer ora ord pac ora_rev ord_rev ora_inv ord_inv pac_inv)'||CHR(10)||
                '*/'||CHR(10)||
                'cer.product_id,'||CHR(10)||
                'cer.certificate_id,'||CHR(10)||
                'cer.review_date,'||CHR(10)||
                'cer.register_date,  --  Fecha de creaci?n del certificado'||CHR(10)||
                'cer.Estimated_end_date, --        Fecha Estimada de fin de vigencia del certificado'||CHR(10)||
                'cer.end_date, --        Fecha de fin de vigencia del certificado'||CHR(10)||
                'ora.order_id ORD,      -- codigo de la orden de revision'||CHR(10)||
                '(select items_id || chr(32) || chr(45) || chr(32) || description FROM ge_items WHERE items_id=ora.activity_id) ACT_REV, --Actividad de Revisi?n'||CHR(10)||
                '(select operating_unit_id || chr(32) || chr(45) || chr(32) || name FROM OR_operating_unit WHERE operating_unit_id= ord.operating_unit_id) OPE_UNIT,  -- Unidad de trabajo que revisa'||CHR(10)||
                '(select PACKAGE_type_id || chr(32) || chr(45) || chr(32) || description  FROM ps_package_type WHERE PACKAGE_type_id=pac.package_type_id) PACK_TYPE, --Tipo de solicitud con que se cre? el certificado'||CHR(10)||
                'cer.package_id PACK,     --C?digo de la solicitud con que se cre? el certificado'||CHR(10)||
                '(select items_id || chr(32) || chr(45) || chr(32) || description FROM ge_items WHERE items_id=ora_rev.activity_id) ACT_CER,  -- Actividad que cre? el certificado'||CHR(10)||
                'ora_rev.order_id ORD_REV,        --C?digo de la orden que cre? el certificado'||CHR(10)||
                '(select operating_unit_id || chr(32) || chr(45) || chr(32) || name FROM OR_operating_unit WHERE operating_unit_id= ord_rev.operating_unit_id) OPE_UNIT_REV,  --Unidad de Trabajo que certifica'||CHR(10)||
                '(select PACKAGE_type_id || chr(32) || chr(45) || chr(32) || description  FROM ps_package_type WHERE PACKAGE_type_id=pac_inv.package_type_id) PACK_TYPE_INV, --Tipo de solicitud que invalid? el certificado'||CHR(10)||
                'ora_inv.package_id PACK_INV, --C?digo de la solicitud con que se invalid? el certificado'||CHR(10)||
                '(select items_id || chr(32) || chr(45) || chr(32) || description FROM ge_items WHERE items_id=ora_inv.activity_id) ACT_INV, --Actividad que invalid? el certificado'||CHR(10)||
                'ora_inv.order_id ORD_INV,   --C?digo de la orden invalid? el certificado'||CHR(10)||
                '(select operating_unit_id || chr(32) || chr(45) || chr(32) || name FROM OR_operating_unit WHERE operating_unit_id= ord_inv.operating_unit_id) OPE_UNIT_INV,  --Unidad de Trabajo que invalida'||CHR(10)||
                ':parent_id parent_id';


        UT_TRACE.TRACE('Fin de OR_boSearchDataServices.fsbFillSubscriberRolProduct', 5);
        RETURN SBCERTIFICATE;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FSBFILLPRODUCTCERTIFICATE;

    


















    PROCEDURE GETCERTIFBYPRODUCT
    (
        INUPRODUCT IN NUMBER,
        OCUCURSOR  OUT CONSTANTS.TYREFCURSOR
    )
    IS
        SBCERTIFICATE   VARCHAR2(20000);
        SBSQL           VARCHAR2(20000);
    BEGIN
        UT_TRACE.TRACE('Inicia OR_boSearchDataServices.GetCertifByProduct',15);

        
        SBCERTIFICATE := FSBFILLPRODUCTCERTIFICATE;
        SBSQL := 'SELECT '||CHR(10)||
                SBCERTIFICATE||' FROM    pr_certificate cer,'||CHR(10)||
                        'OR_order_activity ora,    -- Actividad de revision'||CHR(10)||
                        'OR_order    ord,          -- Orden de revision'||CHR(10)||
                        'mo_packages pac,'||CHR(10)||
                        'OR_order_activity ora_rev,-- Actividad que certifica'||CHR(10)||
                        'OR_order    ord_rev,      -- Orden que certifica'||CHR(10)||
                        'OR_order_activity ora_inv,-- Actividad de invalida'||CHR(10)||
                        'OR_order    ord_inv,      -- Orden que invalida'||CHR(10)||
                        'mo_packages pac_inv'||CHR(10)||
                'WHERE   ora.ORDER_ACTIVITY_ID=cer.ORDER_ACT_REVIEW_ID'||CHR(10)||
                'AND     ora_rev.ORDER_ACTIVITY_ID=cer.ORDER_ACT_CERTIF_ID'||CHR(10)||
                'AND     ora_inv.ORDER_ACTIVITY_ID(+)=cer.ORDER_ACT_CANCEL_ID'||CHR(10)||
                'AND     cer.package_id= pac.package_id'||CHR(10)||
                'AND     ora_inv.package_id=pac_inv.package_id(+)'||CHR(10)||
                'AND     ora.order_id=ord.order_id'||CHR(10)||
                'AND     ora_rev.order_id=ord_rev.order_id'||CHR(10)||
                'AND     ora_inv.order_id=ord_inv.order_id(+)'||CHR(10)||
                'AND     cer.product_id= :inuProduct'||CHR(10)||
                ' ORDER BY cer.register_date desc';
        UT_TRACE.TRACE('sql= '||SBSQL,20);
        OPEN OCUCURSOR FOR SBSQL USING INUPRODUCT, INUPRODUCT;
        UT_TRACE.TRACE('Finaliza OR_boSearchDataServices.GetCertifByProduct',15);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    

















    PROCEDURE GETCERTIFICATE
    (
        INUCERTIFICATE  IN NUMBER,
        OCUCURSOR       OUT CONSTANTS.TYREFCURSOR
    )
    IS
        SBCERTIFICATE   VARCHAR2(20000);
        SBSQL           VARCHAR2(20000);
    BEGIN
        UT_TRACE.TRACE('Inicia OR_boSearchDataServices.GetCertificate',15);

        
        SBCERTIFICATE := FSBFILLPRODUCTCERTIFICATE;
        SBSQL := 'SELECT '||SBCERTIFICATE ||CHR(10)||
                ' FROM    pr_certificate cer,'||CHR(10)||
                        'OR_order_activity ora,    -- Actividad de revision'||CHR(10)||
                        'OR_order    ord,          -- Orden de revision'||CHR(10)||
                        'mo_packages pac,'||CHR(10)||
                        'OR_order_activity ora_rev,-- Actividad que certifica'||CHR(10)||
                        'OR_order    ord_rev,      -- Orden que certifica'||CHR(10)||
                        'OR_order_activity ora_inv,-- Actividad de invalida'||CHR(10)||
                        'OR_order    ord_inv,      -- Orden que invalida'||CHR(10)||
                        'mo_packages pac_inv'||CHR(10)||
                'WHERE   ora.ORDER_ACTIVITY_ID=cer.ORDER_ACT_REVIEW_ID'||CHR(10)||
                'AND     ora_rev.ORDER_ACTIVITY_ID=cer.ORDER_ACT_CERTIF_ID'||CHR(10)||
                'AND     ora_inv.ORDER_ACTIVITY_ID(+)=cer.ORDER_ACT_CANCEL_ID'||CHR(10)||
                'AND     cer.package_id= pac.package_id'||CHR(10)||
                'AND     ora_inv.package_id=pac_inv.package_id(+)'||CHR(10)||
                'AND     ora.order_id=ord.order_id'||CHR(10)||
                'AND     ora_rev.order_id=ord_rev.order_id'||CHR(10)||
                'AND     ora_inv.order_id=ord_inv.order_id(+)'||CHR(10)||
                'AND     cer.certificate_id=:inuCertificate'||CHR(10)||
                ' ORDER BY cer.register_date desc';
        UT_TRACE.TRACE('sql= '||SBSQL,20);
        OPEN OCUCURSOR FOR SBSQL USING CC_BOBOSSUTIL.CNUNULL, INUCERTIFICATE;
        UT_TRACE.TRACE('Finaliza OR_boSearchDataServices.GetCertificate',15);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    














    FUNCTION FSBFILLCERTIFICATEREVIEW
    RETURN   VARCHAR2
    IS
        SBREVIEW   VARCHAR2(20000);
    BEGIN
        UT_TRACE.TRACE('Inicio OR_boSearchDataServices.fsbFillCertificateReview', 5);

        SBREVIEW:= '/*+'||CHR(10)||
                   '     ordered'||CHR(10)||
                   '     use_nl(cer ora ite ord)'||CHR(10)||
                   ' */'||CHR(10)||
                   ' cer.certificate_id,'||CHR(10)||
                   ' ord.ORDER_id,'||CHR(10)||
                   ' ord.numerator_id || chr(32) || chr(45) || chr(32) || ord.sequence NUME,'||CHR(10)||
                   ' (select task_type_id || chr(32) || chr(45) || chr(32) || description  FROM or_task_type WHERE task_type_id=ord.task_type_id) TASK_TYPE,'||CHR(10)||
                   ' (select items_id || chr(32) || chr(45) || chr(32) || description FROM ge_items WHERE items_id=ora.activity_id) ACT,'||CHR(10)||
                   ' (select ORDER_status_id || chr(32) || chr(45) || chr(32) || description FROM or_order_status WHERE ORDER_status_id=ord.order_status_id) ORD_STATUS,'||CHR(10)||
                   ' (select causal_id || chr(32) || chr(45) || chr(32) || description FROM ge_causal WHERE causal_id=ord.causal_id) CAUSAL,'||CHR(10)||
                   ' (select operating_unit_id || chr(32) || chr(45) || chr(32) || name FROM OR_operating_unit WHERE operating_unit_id= ord.operating_unit_id) OPE_UNI,'||CHR(10)||
                   ' ord.created_date,'||CHR(10)||
                   ' ord.assigned_date,'||CHR(10)||
                   ' ord.exec_estimate_date,'||CHR(10)||
                   ' ord.exec_initial_date,'||CHR(10)||
                   ' ord.execution_final_date,'||CHR(10)||
                   ':parent_id parent_id';
        UT_TRACE.TRACE('Fin de OR_boSearchDataServices.fsbFillCertificateReview', 5);
        RETURN SBREVIEW;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FSBFILLCERTIFICATEREVIEW;

    

















    PROCEDURE GETREVIEWBYCERTIF
    (
        INUCERTIF  IN NUMBER,
        OCUCURSOR  OUT CONSTANTS.TYREFCURSOR
    )
    IS
        NUPACKAGEID     PR_CERTIFICATE.PACKAGE_ID%TYPE;
        SBREVIEW        VARCHAR2(20000);
        SBSQL           VARCHAR2(20000);
    BEGIN
        UT_TRACE.TRACE('Inicia OR_boSearchDataServices.GetReviewByCertif',15);

        
        SBREVIEW := FSBFILLCERTIFICATEREVIEW;

        SBSQL := 'SELECT '||SBREVIEW ||CHR(10)||
                ' FROM    pr_certificate cer, OR_order_Activity ora, ge_items ite, OR_order ord'||CHR(10)||
                'WHERE   ora.activity_id=ite.items_id'||CHR(10)||
                'AND     ord.order_id=ora.order_id'||CHR(10)||
                'AND     cer.certificate_id=:inuCertif' ||CHR(10)||
                'AND     ite.use_= '''|| OR_BOCONSTANTS.CSBCLIENT_REVIEW ||''''||CHR(10)||
                'AND     ora.PACKAGE_id=cer.package_id'||CHR(10)||
                ' ORDER BY ord.created_date desc';


        OPEN OCUCURSOR FOR SBSQL USING INUCERTIF, INUCERTIF;


        UT_TRACE.TRACE('Finaliza OR_boSearchDataServices.GetReviewByCertif',15);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    
















    PROCEDURE GETREVIEW
    (
        INUORDER   IN NUMBER,
        OCUCURSOR  OUT CONSTANTS.TYREFCURSOR
    )
    IS
        NUPACKAGEID     PR_CERTIFICATE.PACKAGE_ID%TYPE;
        SBREVIEW        VARCHAR2(20000);
        SBSQL           VARCHAR2(20000);
    BEGIN
        UT_TRACE.TRACE('Inicia OR_boSearchDataServices.GetReview',15);

        
        SBREVIEW := FSBFILLCERTIFICATEREVIEW;

        SBSQL := 'SELECT '||SBREVIEW ||CHR(10)||
                ' FROM    pr_certificate cer, OR_order_Activity ora, ge_items ite, OR_order ord'||CHR(10)||
                'WHERE   ora.activity_id=ite.items_id'||CHR(10)||
                'AND     ord.order_id=ora.order_id'||CHR(10)||
                'AND     ora.order_id=:inuOrder' ||CHR(10)||
                'AND     ite.use_= '''|| OR_BOCONSTANTS.CSBCLIENT_REVIEW ||''''||CHR(10)||
                'AND     ora.PACKAGE_id=cer.package_id'||CHR(10)||
                ' ORDER BY ord.created_date desc';

        UT_TRACE.TRACE('sbSql:'||CHR(10)||SBSQL,15);
        OPEN OCUCURSOR FOR SBSQL USING CC_BOBOSSUTIL.CNUNULL, INUORDER;


        UT_TRACE.TRACE('Finaliza OR_boSearchDataServices.GetReview',15);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    














    FUNCTION FSBFILLCERTIFICATEREPAIR
    RETURN   VARCHAR2
    IS
        SBREPAIR   VARCHAR2(20000);
    BEGIN
        UT_TRACE.TRACE('Inicio OR_boSearchDataServices.fsbFillCertificateRepair', 5);

        SBREPAIR:= '/*+'||CHR(10)||
                   '    ordered'||CHR(10)||
                   '    use_nl(cer)'||CHR(10)||
                   '    use_nl(ora)'||CHR(10)||
                   '    use_nl(ite)'||CHR(10)||
                   '    use_nl(ord)'||CHR(10)||
                   '*/'||CHR(10)||
                   'cer.certificate_id,'||CHR(10)||
                   'ord.ORDER_id,'||CHR(10)||
                   'ord.numerator_id || chr(32) || chr(45) || chr(32) || ord.sequence NUME,'||CHR(10)||
                   '(select task_type_id || chr(32) || chr(45) || chr(32) || description  FROM or_task_type WHERE task_type_id=ord.task_type_id) TASK_TYPE,'||CHR(10)||
                   '(select items_id || chr(32) || chr(45) || chr(32) || description FROM ge_items WHERE items_id=ora.activity_id) ACT,'||CHR(10)||
                   '(select ORDER_status_id || chr(32) || chr(45) || chr(32) || description FROM or_order_status WHERE ORDER_status_id=ord.order_status_id) ORD_STATUS,'||CHR(10)||
                   '(select causal_id || chr(32) || chr(45) || chr(32) || description FROM ge_causal WHERE causal_id=ord.causal_id) CAUSAL,'||CHR(10)||
                   '(select operating_unit_id || chr(32) || chr(45) || chr(32) || name FROM OR_operating_unit WHERE operating_unit_id= ord.operating_unit_id) OPE_UNI,'||CHR(10)||
                   'ord.created_date,'||CHR(10)||
                   'ord.assigned_date,'||CHR(10)||
                   'ord.exec_estimate_date,'||CHR(10)||
                   'ord.exec_initial_date,'||CHR(10)||
                   'ord.execution_final_date,'||CHR(10)||
                   ':parent_id parent_id';

        UT_TRACE.TRACE('Fin de OR_boSearchDataServices.fsbFillCertificateRepair', 5);
        RETURN SBREPAIR;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FSBFILLCERTIFICATEREPAIR;

    
















    PROCEDURE GETREPAIRBYCERTIF
    (
        INUCERTIF  IN NUMBER,
        OCUCURSOR  OUT CONSTANTS.TYREFCURSOR
    )
    IS
        SBREPAIR   VARCHAR2(20000);
        SBSQL      VARCHAR2(20000);
    BEGIN
        UT_TRACE.TRACE('Inicia OR_boSearchDataServices.GetRepairByCertif',15);

        
        SBREPAIR := FSBFILLCERTIFICATEREPAIR;

        SBSQL := 'SELECT '||SBREPAIR||CHR(10)||
                ' FROM    pr_certificate cer, OR_order_Activity ora, ge_items ite, OR_order ord'||CHR(10)||
                'WHERE   ora.activity_id=ite.items_id'||CHR(10)||
                'AND     ord.order_id=ora.order_id'||CHR(10)||
                'AND     cer.certificate_id=:inuCertif'||CHR(10)||
                'AND     ite.use_= '''|| OR_BOCONSTANTS.CSBCLIENT_FIX ||''''||CHR(10)||
                'AND     ora.PACKAGE_id=cer.package_id';

        OPEN OCUCURSOR FOR SBSQL USING INUCERTIF, INUCERTIF;
        UT_TRACE.TRACE('Finaliza OR_boSearchDataServices.GetRepairByCertif',15);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('Error : ex.CONTROLLED_ERROR',15);
            RAISE;

        WHEN OTHERS THEN
            UT_TRACE.TRACE('Error : others',15);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    















    PROCEDURE GETREPAIR
    (
        INUORDER  IN NUMBER,
        OCUCURSOR  OUT CONSTANTS.TYREFCURSOR
    )
    IS
        SBREPAIR   VARCHAR2(20000);
        SBSQL      VARCHAR2(20000);
    BEGIN
        UT_TRACE.TRACE('Inicia OR_boSearchDataServices.GetRepair',15);

        
        SBREPAIR := FSBFILLCERTIFICATEREPAIR;

        SBSQL := 'SELECT '||SBREPAIR||CHR(10)||
                ' FROM    pr_certificate cer, OR_order_Activity ora, ge_items ite, OR_order ord'||CHR(10)||
                'WHERE   ora.activity_id=ite.items_id'||CHR(10)||
                'AND     ord.order_id=ora.order_id'||CHR(10)||
                'AND     ora.order_id=:inuOrder'||CHR(10)||
                'AND     ite.use_= '''|| OR_BOCONSTANTS.CSBCLIENT_FIX ||''''||CHR(10)||
                'AND     ora.PACKAGE_id=cer.package_id';

        OPEN OCUCURSOR FOR SBSQL USING CC_BOBOSSUTIL.CNUNULL, INUORDER;
        UT_TRACE.TRACE('Finaliza OR_boSearchDataServices.GetRepair',15);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('Error : ex.CONTROLLED_ERROR',15);
            RAISE;

        WHEN OTHERS THEN
            UT_TRACE.TRACE('Error : others',15);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    
















    FUNCTION FSBFILLREVIEWDEFECTS
    RETURN   VARCHAR2
    IS
        SBDEFECT   VARCHAR2(20000);
    BEGIN
        UT_TRACE.TRACE('Inicio OR_boSearchDataServices.fsbFillReviewDefects', 5);

        SBDEFECT:= '/*+'||CHR(10)||
                   'ordered'||CHR(10)||
                   '    use_nl(oad ora defe)'||CHR(10)||
                   '*/'||CHR(10)||
                   'ora.order_id,'||CHR(10)||
                   'defe.defect_id,'||CHR(10)||
                   'defe.description,'||CHR(10)||
                   'decode(defe.is_critical,''N'', ''No'',''Y'', ''Si'') is_critical,'||CHR(10)||
                   ':parent_id parent_id';

        UT_TRACE.TRACE('Fin de OR_boSearchDataServices.fsbFillReviewDefects', 5);
        RETURN SBDEFECT;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FSBFILLREVIEWDEFECTS;

    
















    PROCEDURE GETDEFECTSBYREVIEW
    (
        INUORDERID  IN  OR_ORDER.ORDER_ID%TYPE,
        OCUCURSOR   OUT CONSTANTS.TYREFCURSOR
    )
    IS
        SBDEFECT   VARCHAR2(20000);
        SBSQL      VARCHAR2(20000);
    BEGIN
        UT_TRACE.TRACE('Inicia OR_boSearchDataServices.GetDefectsByReview',15);

        
        SBDEFECT := FSBFILLREVIEWDEFECTS;
        SBSQL := 'SELECT '||SBDEFECT||CHR(10)||
                ' FROM    OR_order_activity ora, or_activ_defect oad,  ge_defect defe'||CHR(10)||
                'WHERE   oad.order_activity_id=ora.order_activity_id'||CHR(10)||
                'AND     oad.defect_id=defe.defect_id'||CHR(10)||
                'AND     ora.order_id=:inuOrderId';

        OPEN OCUCURSOR FOR SBSQL USING INUORDERID, INUORDERID;

        UT_TRACE.TRACE('Finaliza OR_boSearchDataServices.GetDefectsByReview',15);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('Error : ex.CONTROLLED_ERROR',15);
            RAISE;

        WHEN OTHERS THEN
            UT_TRACE.TRACE('Error : others',15);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    















    PROCEDURE GETDEFECT
    (
        INUDEFECT  IN  OR_ORDER.ORDER_ID%TYPE,
        OCUCURSOR   OUT CONSTANTS.TYREFCURSOR
    )
    IS
        SBDEFECT   VARCHAR2(20000);
        SBSQL      VARCHAR2(20000);
    BEGIN
        UT_TRACE.TRACE('Inicia OR_boSearchDataServices.GetDefect',15);

        
        SBDEFECT := FSBFILLREVIEWDEFECTS;
        SBSQL := 'SELECT '||SBDEFECT||CHR(10)||
                ' FROM    OR_order_activity ora, or_activ_defect oad,  ge_defect defe'||CHR(10)||
                'WHERE   oad.order_activity_id=ora.order_activity_id'||CHR(10)||
                'AND     oad.defect_id=defe.defect_id'||CHR(10)||
                'AND     oad.activ_defect_id=:inuDefect';

        OPEN OCUCURSOR FOR SBSQL USING CC_BOBOSSUTIL.CNUNULL, INUDEFECT;

        UT_TRACE.TRACE('Finaliza OR_boSearchDataServices.GetDefect',15);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('Error : ex.CONTROLLED_ERROR',15);
            RAISE;

        WHEN OTHERS THEN
            UT_TRACE.TRACE('Error : others',15);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    














    FUNCTION FSBFILLREVIEWAPPLIANCES
    RETURN   VARCHAR2
    IS
        SBAPPLIANCE   VARCHAR2(20000);
    BEGIN
        UT_TRACE.TRACE('Inicio OR_boSearchDataServices.fsbFillReviewAppliances', 5);

        SBAPPLIANCE:= '/*+'||CHR(10)||
                      ' ordered'||CHR(10)||
                      ' use_nl(ora oaa apl)'||CHR(10)||
                    '*/'||CHR(10)||
                    'ora.order_id,'||CHR(10)||
                    'apl.appliance_id,'||CHR(10)||
                    'apl.description,'||CHR(10)||
                    'oaa.amount,'||CHR(10)||
                    'apl.load,'||CHR(10)||
                    ':parent_id parent_id';

        UT_TRACE.TRACE('Fin de OR_boSearchDataServices.fsbFillReviewAppliances', 5);
        RETURN SBAPPLIANCE;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FSBFILLREVIEWAPPLIANCES;

    

















    PROCEDURE GETAPPLIANCEBYREVIEW
    (
        INUORDERID  IN  OR_ORDER.ORDER_ID%TYPE,
        OCUCURSOR   OUT CONSTANTS.TYREFCURSOR
    )
    IS
        SBAPPLIANCE   VARCHAR2(20000);
        SBSQL      VARCHAR2(20000);
    BEGIN
        UT_TRACE.TRACE('Inicia OR_boSearchDataServices.GetApplianceByReview',15);

        
        SBAPPLIANCE := FSBFILLREVIEWAPPLIANCES;

        SBSQL := 'SELECT '||SBAPPLIANCE||CHR(10)||
                ' FROM    OR_order_activity ora, or_activ_appliance oaa,  ge_appliance apl'||CHR(10)||
                'WHERE   oaa.order_activity_id=ora.order_activity_id'||CHR(10)||
                'AND     oaa.appliance_id=apl.appliance_id'||CHR(10)||
                'AND     ora.order_id=:inuOrderId';
        OPEN OCUCURSOR FOR SBSQL USING INUORDERID, INUORDERID;


        UT_TRACE.TRACE('Finaliza OR_boSearchDataServices.GetApplianceByReview',15);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('Error : ex.CONTROLLED_ERROR',15);
            RAISE;

        WHEN OTHERS THEN
            UT_TRACE.TRACE('Error : others',15);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    















    PROCEDURE GETAPPLIANCE
    (
        INUORDERID  IN  OR_ORDER.ORDER_ID%TYPE,
        OCUCURSOR   OUT CONSTANTS.TYREFCURSOR
    )
    IS
        SBAPPLIANCE   VARCHAR2(20000);
        SBSQL      VARCHAR2(20000);
    BEGIN
        UT_TRACE.TRACE('Inicia OR_boSearchDataServices.GetAppliance',15);

        
        SBAPPLIANCE := FSBFILLREVIEWAPPLIANCES;

        SBSQL := 'SELECT '||SBAPPLIANCE||CHR(10)||
                ' FROM    OR_order_activity ora, or_activ_appliance oaa,  ge_appliance apl'||CHR(10)||
                'WHERE   oaa.order_activity_id=ora.order_activity_id'||CHR(10)||
                'AND     oaa.appliance_id=apl.appliance_id'||CHR(10)||
                'AND     oaa.activ_appliance_id=:inuOrderId';
        OPEN OCUCURSOR FOR SBSQL USING CC_BOBOSSUTIL.CNUNULL, INUORDERID;


        UT_TRACE.TRACE('Finaliza OR_boSearchDataServices.GetAppliance',15);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('Error : ex.CONTROLLED_ERROR',15);
            RAISE;

        WHEN OTHERS THEN
            UT_TRACE.TRACE('Error : others',15);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    

















    FUNCTION FSBFILLREVIEWCOMPMEASU
    RETURN   VARCHAR2
    IS
        SBCOMPMEASU   VARCHAR2(20000);
    BEGIN
        UT_TRACE.TRACE('Inicio OR_boSearchDataServices.fsbFillReviewCompMeasu', 5);

        SBCOMPMEASU:= '/*+'||CHR(10)||
                      '  ordered'||CHR(10)||
                      ' use_nl(ora oam vari oip gis ite)'||CHR(10)||
                    '*/'||CHR(10)||
                    'oam.order_act_measure_id,'||CHR(10)||
                    'oam.order_id,'||CHR(10)||
                    'oam.measure_number,'||CHR(10)||
                    'vari.display_name DISPLAY_NAME,'||CHR(10)||
                    'oam.item_value,'||CHR(10)||
                    'oam.pattern_value,'||CHR(10)||
                    '(select description FROM ge_measure_unit WHERE measure_unit_id=vari.measure_unit_id) MEASURE_UNIT,'||CHR(10)||
                    'oam.error,'||CHR(10)||
                    'oam.uncertainty,'||CHR(10)||
                    '(select descripcion FROM ge_items_tipo WHERE id_items_tipo= ite.id_items_tipo) ITEM_TIPO,'||CHR(10)||
                    'ite.description,'||CHR(10)||
                    'gis.serie,'||CHR(10)||
                    ':parent_id parent_id';

        UT_TRACE.TRACE('Fin de OR_boSearchDataServices.fsbFillReviewCompMeasu', 5);
        RETURN SBCOMPMEASU;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FSBFILLREVIEWCOMPMEASU;

    

















    PROCEDURE GETCOMPMEASUBYREVIEW
    (
        INUORDERID  IN  OR_ORDER.ORDER_ID%TYPE,
        OCUCURSOR   OUT CONSTANTS.TYREFCURSOR
    )
    IS
        SBCOMPMEASU   VARCHAR2(20000);
        SBSQL      VARCHAR2(20000);
    BEGIN
        UT_TRACE.TRACE('Inicia OR_boSearchDataServices.GetCompMeasuByReview',15);

        
        SBCOMPMEASU := FSBFILLREVIEWCOMPMEASU;
        SBSQL := 'SELECT '|| SBCOMPMEASU||CHR(10)||
                'FROM'||CHR(10)||
                '        or_order_act_measure oam,'||CHR(10)||
                '        ge_variable vari,'||CHR(10)||
                '        or_item_pattern oip,'||CHR(10)||
                '        ge_items_seriado gis,'||CHR(10)||
                '        ge_items ite'||CHR(10)||
                'WHERE        oam.variable_id=vari.variable_id'||CHR(10)||
                'AND     oam.item_pattern_id=oip.id_items_seriado(+)'||CHR(10)||
                'AND     oip.id_items_seriado=gis.id_items_seriado(+)'||CHR(10)||
                'AND     gis.items_id=ite.items_id(+)'||CHR(10)||
                'AND     oam.order_id=:inuOrderId';
                
        UT_TRACE.TRACE('SQL '||SBSQL,25);
        OPEN OCUCURSOR FOR SBSQL USING INUORDERID, INUORDERID;
        
        UT_TRACE.TRACE('Finaliza OR_boSearchDataServices.GetCompMeasuByReview',15);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('Error : ex.CONTROLLED_ERROR',15);
            RAISE;

        WHEN OTHERS THEN
            UT_TRACE.TRACE('Error : others',15);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    

















    PROCEDURE GETCOMPMEASURE
    (
        INUORDERID  IN  OR_ORDER.ORDER_ID%TYPE,
        OCUCURSOR   OUT CONSTANTS.TYREFCURSOR
    )
    IS
        SBCOMPMEASU   VARCHAR2(20000);
        SBSQL      VARCHAR2(20000);
    BEGIN
        UT_TRACE.TRACE('Inicia OR_boSearchDataServices.GetCompMeasure',15);

        
        SBCOMPMEASU := FSBFILLREVIEWCOMPMEASU;
        SBSQL := 'SELECT '|| SBCOMPMEASU||CHR(10)||
                'FROM'||CHR(10)||
                '        or_order_act_measure oam,'||CHR(10)||
                '        ge_variable vari,'||CHR(10)||
                '        or_item_pattern oip,'||CHR(10)||
                '        ge_items_seriado gis,'||CHR(10)||
                '        ge_items ite'||CHR(10)||
                'WHERE        oam.variable_id=vari.variable_id'||CHR(10)||
                'AND     oam.item_pattern_id=oip.id_items_seriado(+)'||CHR(10)||
                'AND     oip.id_items_seriado=gis.id_items_seriado(+)'||CHR(10)||
                'AND     gis.items_id=ite.items_id(+)'||CHR(10)||
                'AND     oam.order_id=:inuOrderId';

        OPEN OCUCURSOR FOR SBSQL USING CC_BOBOSSUTIL.CNUNULL, INUORDERID;
        UT_TRACE.TRACE('Finaliza OR_boSearchDataServices.GetCompMeasure',15);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('Error : ex.CONTROLLED_ERROR',15);
            RAISE;

        WHEN OTHERS THEN
            UT_TRACE.TRACE('Error : others',15);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    

















    FUNCTION FSBFILLREVIEWNOCOMPMEASU
    RETURN   VARCHAR2
    IS
        SBNOCOMPMEASU   VARCHAR2(20000);
    BEGIN
        UT_TRACE.TRACE('Inicio OR_boSearchDataServices.fsbFillReviewNoCompMeasu', 5);

        SBNOCOMPMEASU:= '/*+'||CHR(10)||
                      '  ordered'||CHR(10)||
                      '  use_nl(ora oav vari oip gis ite)'||CHR(10)||
                    '*/'||CHR(10)||
                    'oav.order_act_var_det_id,'||CHR(10)||
                    'ora.order_id,'||CHR(10)||
                    'oav.measure_number,'||CHR(10)||
                    'vari.display_name DISPLAY_NAME,'||CHR(10)||
                    'oav.value,'||CHR(10)||
                    '(select description FROM ge_measure_unit WHERE measure_unit_id=vari.measure_unit_id) MEASURE_UNIT,'||CHR(10)||
                    '(select descripcion FROM ge_items_tipo WHERE id_items_tipo= ite.id_items_tipo) ITEM_TIPO,'||CHR(10)||
                    'ite.description,'||CHR(10)||
                    'gis.serie,'||CHR(10)||
                    ':parent_id parent_id';

        UT_TRACE.TRACE('Fin de OR_boSearchDataServices.fsbFillReviewNoCompMeasu', 5);
        RETURN SBNOCOMPMEASU;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FSBFILLREVIEWNOCOMPMEASU;

    

















    PROCEDURE GETNOCOMPMEASBYREVIEW
    (
        INUORDERID  IN  OR_ORDER.ORDER_ID%TYPE,
        OCUCURSOR   OUT CONSTANTS.TYREFCURSOR
    )
    IS
        SBNOCOMPMEASU   VARCHAR2(20000);
        SBSQL      VARCHAR2(20000);
    BEGIN
        UT_TRACE.TRACE('Inicia OR_boSearchDataServices.GetNoCompMeasByReview',15);

        
        SBNOCOMPMEASU := FSBFILLREVIEWNOCOMPMEASU;
        SBSQL := 'SELECT '||SBNOCOMPMEASU||CHR(10)||
                ' FROM    OR_order_activity ora,'||CHR(10)||
                '        or_order_act_var_det oav,'||CHR(10)||
                '        ge_variable vari,'||CHR(10)||
                '        or_item_pattern oip,'||CHR(10)||
                '        ge_items_seriado gis,'||CHR(10)||
                '        ge_items ite'||CHR(10)||
                'WHERE   oav.order_id=ora.order_id'||CHR(10)||
                'AND     oav.variable_id=vari.variable_id'||CHR(10)||
                'AND     oav.item_pattern_id=oip.id_items_seriado(+)'||CHR(10)||
                'AND     oip.id_items_seriado=gis.id_items_seriado(+)'||CHR(10)||
                'AND     gis.items_id=ite.items_id(+)'||CHR(10)||
                'AND     ora.order_id=:inuOrderId';

        OPEN OCUCURSOR FOR SBSQL USING INUORDERID, INUORDERID;
        UT_TRACE.TRACE('Finaliza OR_boSearchDataServices.GetNoCompMeasByReview',15);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('Error : ex.CONTROLLED_ERROR',15);
            RAISE;

        WHEN OTHERS THEN
            UT_TRACE.TRACE('Error : others',15);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    

















    PROCEDURE GETNOCOMPMEASURE
    (
        INUORDERID  IN  OR_ORDER.ORDER_ID%TYPE,
        OCUCURSOR   OUT CONSTANTS.TYREFCURSOR
    )
    IS
        SBNOCOMPMEASU   VARCHAR2(20000);
        SBSQL      VARCHAR2(20000);
    BEGIN
        UT_TRACE.TRACE('Inicia OR_boSearchDataServices.GetNoCompMeasure',15);

        
        SBNOCOMPMEASU := FSBFILLREVIEWNOCOMPMEASU;
        SBSQL := 'SELECT '||SBNOCOMPMEASU||CHR(10)||
                ' FROM    OR_order_activity ora,'||CHR(10)||
                '        or_order_act_var_det oav,'||CHR(10)||
                '        ge_variable vari,'||CHR(10)||
                '        or_item_pattern oip,'||CHR(10)||
                '        ge_items_seriado gis,'||CHR(10)||
                '        ge_items ite'||CHR(10)||
                'WHERE   oav.order_id=ora.order_id'||CHR(10)||
                'AND     oav.variable_id=vari.variable_id'||CHR(10)||
                'AND     oav.item_pattern_id=oip.id_items_seriado(+)'||CHR(10)||
                'AND     oip.id_items_seriado=gis.id_items_seriado(+)'||CHR(10)||
                'AND     gis.items_id=ite.items_id(+)'||CHR(10)||
                'AND     oav.order_id=:inuOrderId';

        OPEN OCUCURSOR FOR SBSQL USING CC_BOBOSSUTIL.CNUNULL, INUORDERID;
        UT_TRACE.TRACE('Finaliza OR_boSearchDataServices.GetNoCompMeasure',15);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('Error : ex.CONTROLLED_ERROR',15);
            RAISE;

        WHEN OTHERS THEN
            UT_TRACE.TRACE('Error : others',15);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;
    
    















    PROCEDURE GETREPAIREQUIPBYORDER
    (
        INUORDERID  IN  OR_ORDER.ORDER_ID%TYPE,
        ORFRESULT   OUT CONSTANTS.TYREFCURSOR
    )
    IS
    BEGIN


        OPEN ORFRESULT FOR
        SELECT  /*+ index(OR_order_activity IDX_OR_ORDER_ACTIVITY_05)
                index(ge_items_Seriado PK_GE_ITEMS_SERIADO) */
                OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID,
                GE_ITEMS_SERIADO.ID_ITEMS_SERIADO,
                GE_ITEMS_TIPO.ID_ITEMS_TIPO ||' - '|| GE_ITEMS_TIPO.DESCRIPCION  DESC_ITEMS_TIPO,
                GE_ITEMS.ITEMS_ID || ' - ' ||GE_ITEMS.DESCRIPTION DESC_ITEMS,
                GE_ITEMS_SERIADO.SERIE,
                DECODE(GE_ITEMS_GAMA.ID_ITEMS_GAMA, NULL, '',
                GE_ITEMS_GAMA.ID_ITEMS_GAMA ||' - '|| GE_ITEMS_GAMA.DESCRIPCION ) DESC_ITEMS_GAMA,
                GE_ITEMS_SERIADO.ID_ITEMS_ESTADO_INV ||' - '||GE_ITEMS_ESTADO_INV.DESCRIPCION DESC_ESTADO_INV,
                GE_ITEMS_SERIADO.PROPIEDAD,
                OR_OPERATING_UNIT.OPERATING_UNIT_ID ,
                OR_OPERATING_UNIT.NAME OPER_UNIT_NAME,
                OR_OPER_UNIT_CLASSIF.OPER_UNIT_CLASSIF_ID ||' - '||
                OR_OPER_UNIT_CLASSIF.DESCRIPTION OPER_UNIT_CLASSIF,
                OR_ORDER_ACTIVITY.COMMENT_ ADDITIONAL_DATA,
                OR_ORDER_ACTIVITY.ORDER_ID PARENT_ID
        FROM    OR_ORDER_ACTIVITY, GE_ITEMS_SERIADO, GE_ITEMS,
                GE_ITEMS_GAMA_ITEM, GE_ITEMS_GAMA, GE_ITEMS_TIPO ,
                GE_ITEMS_ESTADO_INV, OR_OPERATING_UNIT, OR_OPER_UNIT_CLASSIF
        WHERE OR_ORDER_ACTIVITY.ORDER_ID =  INUORDERID
        AND GE_ITEMS_SERIADO.ID_ITEMS_SERIADO = OR_ORDER_ACTIVITY.SERIAL_ITEMS_ID
        AND GE_ITEMS.ITEMS_ID = GE_ITEMS_SERIADO.ITEMS_ID
        AND GE_ITEMS_TIPO.ID_ITEMS_TIPO = GE_ITEMS.ID_ITEMS_TIPO
        AND  GE_ITEMS_GAMA_ITEM.ITEMS_ID(+) = GE_ITEMS.ITEMS_ID
        AND GE_ITEMS_GAMA_ITEM.ID_ITEMS_GAMA  = GE_ITEMS_GAMA.ID_ITEMS_GAMA(+)
        AND GE_ITEMS_ESTADO_INV.ID_ITEMS_ESTADO_INV = GE_ITEMS_SERIADO.ID_ITEMS_ESTADO_INV
        AND OR_OPERATING_UNIT.OPERATING_UNIT_ID(+) = GE_ITEMS_SERIADO.OPERATING_UNIT_ID
        AND OR_OPER_UNIT_CLASSIF.OPER_UNIT_CLASSIF_ID(+) = OR_OPERATING_UNIT.OPER_UNIT_CLASSIF_ID;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETREPAIREQUIPBYORDER;
    
    
















    PROCEDURE GETEQUIPBYACTIVITYID
    (
        INUORDERACT IN  OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE,
        ORFRESULT   OUT CONSTANTS.TYREFCURSOR
    )
    IS
    BEGIN

        OPEN ORFRESULT FOR
        SELECT /*+ index(OR_order_activity PK_OR_ORDER_ACTIVITY)
                index(ge_items_Seriado PK_GE_ITEMS_SERIADO) */
            OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID,
            GE_ITEMS_SERIADO.ID_ITEMS_SERIADO,
            GE_ITEMS_TIPO.ID_ITEMS_TIPO ||' - '|| GE_ITEMS_TIPO.DESCRIPCION  DESC_ITEMS_TIPO,
            GE_ITEMS.ITEMS_ID || ' - ' ||GE_ITEMS.DESCRIPTION DESC_ITEMS,
            GE_ITEMS_SERIADO.SERIE,
            DECODE(GE_ITEMS_GAMA.ID_ITEMS_GAMA, NULL, '', GE_ITEMS_GAMA.ID_ITEMS_GAMA ||' - '|| GE_ITEMS_GAMA.DESCRIPCION ) DESC_ITEMS_GAMA,
            GE_ITEMS_SERIADO.ID_ITEMS_ESTADO_INV ||' - '||GE_ITEMS_ESTADO_INV.DESCRIPCION DESC_ESTADO_INV,
            GE_ITEMS_SERIADO.PROPIEDAD,
            OR_OPERATING_UNIT.OPERATING_UNIT_ID ,
            OR_OPERATING_UNIT.NAME OPER_UNIT_NAME,
            OR_OPER_UNIT_CLASSIF.OPER_UNIT_CLASSIF_ID ||' - '|| OR_OPER_UNIT_CLASSIF.DESCRIPTION OPER_UNIT_CLASSIF,
            OR_ORDER_ACTIVITY.COMMENT_ ADDITIONAL_DATA,
            OR_ORDER_ACTIVITY.ORDER_ID PARENT_ID
        FROM    OR_ORDER_ACTIVITY, GE_ITEMS_SERIADO, GE_ITEMS, GE_ITEMS_GAMA_ITEM,
                GE_ITEMS_GAMA, GE_ITEMS_TIPO, GE_ITEMS_ESTADO_INV,
                OR_OPERATING_UNIT, OR_OPER_UNIT_CLASSIF
        WHERE OR_ORDER_ACTIVITY.SERIAL_ITEMS_ID = GE_ITEMS_SERIADO.ID_ITEMS_SERIADO
            AND GE_ITEMS.ITEMS_ID = GE_ITEMS_SERIADO.ITEMS_ID
            AND GE_ITEMS_TIPO.ID_ITEMS_TIPO = GE_ITEMS.ID_ITEMS_TIPO
            AND  GE_ITEMS_GAMA_ITEM.ITEMS_ID(+) = GE_ITEMS.ITEMS_ID
            AND GE_ITEMS_GAMA_ITEM.ID_ITEMS_GAMA  = GE_ITEMS_GAMA.ID_ITEMS_GAMA(+)
            AND GE_ITEMS_ESTADO_INV.ID_ITEMS_ESTADO_INV = GE_ITEMS_SERIADO.ID_ITEMS_ESTADO_INV
            AND OR_OPERATING_UNIT.OPERATING_UNIT_ID(+) = GE_ITEMS_SERIADO.OPERATING_UNIT_ID
            AND OR_OPER_UNIT_CLASSIF.OPER_UNIT_CLASSIF_ID(+) = OR_OPERATING_UNIT.OPER_UNIT_CLASSIF_ID
            AND OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID =INUORDERACT;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETEQUIPBYACTIVITYID;
    
    















    PROCEDURE GETORDERBYACTIVITYID
    (
        INUACTIVITYID   IN  OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE,
        ONUORDERID      OUT OR_ORDER.ORDER_ID%TYPE
    )
    IS
    BEGIN
        IF INUACTIVITYID IS NULL THEN
            ONUORDERID := NULL;
            RETURN;
        END IF;

        ONUORDERID := DAOR_ORDER_ACTIVITY.FNUGETORDER_ID(INUACTIVITYID);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ONUORDERID := NULL;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETORDERBYACTIVITYID;


    























    PROCEDURE GETORDERSBYSUBSCRIPC
    (
        INUSUBSCRIPTION    IN  OR_ORDER_ACTIVITY.SUBSCRIPTION_ID%TYPE,
        ORFDATACURSOR      OUT CONSTANTS.TYREFCURSOR
    )
    IS
      SBSQL                     GE_BOUTILITIES.STYSTATEMENT;
      SBORDERFROM               GE_BOUTILITIES.STYSTATEMENT;
      SBORDERWHERE              GE_BOUTILITIES.STYSTATEMENT;
      SBORDERATTRIBUTES         GE_BOUTILITIES.STYSTATEMENT;
      SBRECORDBIND              GE_BOUTILITIES.STYSTATEMENT;
      RFCURSORORDERS            CONSTANTS.TYREFCURSOR;
      SBUSING                   GE_BOUTILITIES.STYSTATEMENT;
    BEGIN
        UT_TRACE.TRACE('INICIO - OR_boSearchDataServices.GetOrdersBySubscripc', 5);

        FILLORDERATTRIBUTES(SBORDERATTRIBUTES);

        SBORDERFROM     := GSBORDERFROM;
        SBORDERWHERE    := GSBORDERWHERE || CHR(10) ||'AND GE_SUBSCRIBER.subscriber_id(+) = OR_ORDER.subscriber_id';
        SBORDERFROM     := SBORDERFROM || ', ' ||CHR(10)||
                           ' ( '||CHR(10)||
                           '   SELECT    DISTINCT or_order_activity.order_id '||CHR(10)||
                           '   FROM      or_order_activity'||CHR(10)||
                           '   WHERE     or_order_activity.subscription_id= :inuSubscriptionId'||CHR(10)||
                           ' ) activity /*+ ubicacion:OR_boSearchDataServices.GetOrdersBySubscripc */';


        SBORDERWHERE    := SBORDERWHERE || CHR(10) ||' AND or_order.order_id = activity.order_id '||CHR(10);

        SBSQL := 'SELECT '||CHR(10)||
            SBORDERATTRIBUTES ||CHR(10)||
            SBORDERFROM ||CHR(10)||
            SBORDERWHERE;

        SBUSING := INUSUBSCRIPTION|| ', ' || INUSUBSCRIPTION;


        SBRECORDBIND := 'BEGIN Open :rfCursorOrders for ''' || SBSQL || ''' using ' || SBUSING || ';  END;';
        UT_TRACE.TRACE(SBRECORDBIND,1);

        EXECUTE IMMEDIATE SBRECORDBIND USING RFCURSORORDERS;
        ORFDATACURSOR := RFCURSORORDERS;

        UT_TRACE.TRACE('FIN - OR_boSearchDataServices.GetOrdersBySubscripc', 5);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETORDERSBYSUBSCRIPC;


    





















    PROCEDURE GETORDERSBYPRODUCT
    (
        INUPRODUCT      IN      PR_PRODUCT.PRODUCT_ID%TYPE,
        ORFDATACURSOR   OUT     CONSTANTS.TYREFCURSOR
    )
    IS
      SBSQL                     GE_BOUTILITIES.STYSTATEMENT;
      SBORDERFROM               GE_BOUTILITIES.STYSTATEMENT;
      SBORDERWHERE              GE_BOUTILITIES.STYSTATEMENT;
      SBORDERATTRIBUTES         GE_BOUTILITIES.STYSTATEMENT;
      SBRECORDBIND              GE_BOUTILITIES.STYSTATEMENT;
      RFCURSORORDERS            CONSTANTS.TYREFCURSOR;
      SBUSING                   GE_BOUTILITIES.STYSTATEMENT;
    BEGIN

        FILLORDERATTRIBUTES(SBORDERATTRIBUTES);

        SBORDERFROM     := GSBORDERFROM;
        SBORDERWHERE    := GSBORDERWHERE || CHR(10) ||'AND GE_SUBSCRIBER.subscriber_id(+) = OR_ORDER.subscriber_id';
        SBORDERFROM     := SBORDERFROM || ', '||CHR(10)||
                          ' ( '||CHR(10)||
                          '   SELECT    DISTINCT or_order_activity.order_id '||CHR(10)||
                          '   FROM      or_order_activity'||CHR(10)||
                          '   WHERE     or_order_activity.product_id=:inuProductId'||CHR(10)||
                          ' ) activity /*+ ubicacion:OR_boSearchDataServices.GetOrdersByProduct */';

        SBORDERWHERE    := SBORDERWHERE || CHR(10) ||' AND or_order.order_id = activity.order_id';



        SBSQL := 'SELECT '||CHR(10)||
                SBORDERATTRIBUTES ||CHR(10)||
                SBORDERFROM ||CHR(10)||
                SBORDERWHERE;

        SBUSING := INUPRODUCT|| ', ' || INUPRODUCT;

        SBRECORDBIND := 'BEGIN Open :rfCursorOrders for ''' || SBSQL || ''' using ' || SBUSING || ';  END;';
        UT_TRACE.TRACE(SBRECORDBIND,1);
        EXECUTE IMMEDIATE SBRECORDBIND USING RFCURSORORDERS;
        ORFDATACURSOR := RFCURSORORDERS;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETORDERSBYPRODUCT;



    



















    PROCEDURE GETCENSUSAPPLIANCE
    (
        INUSUBSCRIPTION     IN  OR_ORDER_ACTIVITY.SUBSCRIPTION_ID%TYPE,
        ORFDATACURSOR       OUT CONSTANTS.TYREFCURSOR
    )
    IS
        NUORDERID       OR_ORDER.ORDER_ID%TYPE;

    BEGIN

        UT_TRACE.TRACE('INICIO - OR_boSearchDataServices.GetCensusAppliance', 5);

        


        OPEN ORFDATACURSOR FOR

        SELECT  /*+ use_nl(OR_order_activity or_activ_appliance)
                    use_nl(or_activ_appliance ge_appliance)
                    use_nl(ge_appliance ordenes)
                    index(OR_ORDER_ACTIVITY IDX_OR_ORDER_ACTIVITY_05)
                */
        
                OR_ORDER_ACTIVITY.ORDER_ID,
                GE_APPLIANCE.APPLIANCE_ID,
                GE_APPLIANCE.DESCRIPTION,
                OR_ACTIV_APPLIANCE.AMOUNT,
                GE_APPLIANCE.LOAD,
                INUSUBSCRIPTION  PARENT_ID
        FROM    OR_ORDER_ACTIVITY,
                OR_ACTIV_APPLIANCE,
                GE_APPLIANCE,
                (
                    SELECT    ORDER_ID
                    FROM      (
                                SELECT    OR_ORDER_ACTIVITY.ORDER_ID,
                                          RANK() OVER
                                                      (
                                                        PARTITION BY    PR_PRODUCT.PRODUCT_ID
                                                        ORDER BY        OR_ORDER.EXECUTION_FINAL_DATE DESC
                                                      ) RANKING
                                FROM      OR_ORDER_ACTIVITY,
                                          GE_ITEMS,
                                          OR_ORDER,
                                          PR_PRODUCT
                                WHERE
                                         OR_ORDER.ORDER_ID = OR_ORDER_ACTIVITY.ORDER_ID
                                AND      GE_ITEMS.USE_ =  OR_BOCONSTANTS.CSBCLIENT_REVIEW 
                                AND      GE_ITEMS.ITEMS_ID = OR_ORDER_ACTIVITY.ACTIVITY_ID
                                AND      OR_ORDER_ACTIVITY.STATUS =  OR_BOCONSTANTS.CSBFINISHSTATUS 
                                AND      OR_ORDER_ACTIVITY.PRODUCT_ID = PR_PRODUCT.PRODUCT_ID
                                AND      PR_PRODUCT.SUBSCRIPTION_ID = INUSUBSCRIPTION
                               )
                    WHERE     RANKING = 1
                )ORDERS /*+ OR_boSearchDataServices.GetCensusAppliance */

        WHERE   OR_ACTIV_APPLIANCE.ORDER_ACTIVITY_ID=OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID
        AND     OR_ACTIV_APPLIANCE.APPLIANCE_ID=GE_APPLIANCE.APPLIANCE_ID
        AND     OR_ORDER_ACTIVITY.ORDER_ID=ORDERS.ORDER_ID;


        UT_TRACE.TRACE('FIN - OR_boSearchDataServices.GetCensusAppliance', 5);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETCENSUSAPPLIANCE;
    
    

















    FUNCTION FSBGETMANAGEZONEDESC
    (
        ISBMANAGEZONETYPE   IN  PM_PROJECT.STATUS%TYPE
    )
    RETURN VARCHAR2
    IS
        
        SBRESULT I18N_STRING.PROMPT_TEXT%TYPE;
    BEGIN
        UT_TRACE.TRACE('[INICIO] OR_boSearchDataServices.fsbGetManageZoneDesc: ['||ISBMANAGEZONETYPE||']',10);
        SBRESULT := GE_BOUTILITIES.CSBAPPLICATIONNULL;
        CASE
            WHEN ISBMANAGEZONETYPE = OR_BOCONSTANTS.CSBZONE_ROUTE THEN
                SBRESULT := 'Por Ruta';
            WHEN ISBMANAGEZONETYPE = OR_BOCONSTANTS.CSBZONE_SECTOR THEN
                SBRESULT := 'Por Sector';
        END CASE;
        UT_TRACE.TRACE('[FIN] OR_boSearchDataServices.fsbGetManageZoneDesc: ',10);
        RETURN SBRESULT;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('Error : ex.CONTROLLED_ERROR',10);
            RAISE;
        WHEN OTHERS THEN
            UT_TRACE.TRACE('Error : others',10);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FSBGETMANAGEZONEDESC;
    
    

















    FUNCTION FSBVALIDMANAGEZONE
    (
        ISBMANAGEZONETYPE    IN      VARCHAR2
    )
    RETURN VARCHAR2
    IS
        
        SBRESULT    VARCHAR2(1) := GE_BOUTILITIES.CSBAPPLICATIONNULL;
    BEGIN
        UT_TRACE.TRACE('[INICIO] OR_boSearchDataServices.fsbValidManageZone:
                        ManageZoneType['||ISBMANAGEZONETYPE||'] ',10);
                        
        IF(ISBMANAGEZONETYPE = OR_BOCONSTANTS.CSBZONE_ROUTE) THEN
            SBRESULT := GE_BOCONSTANTS.CSBYES;
        ELSIF(ISBMANAGEZONETYPE = OR_BOCONSTANTS.CSBZONE_SECTOR) THEN
            SBRESULT := GE_BOCONSTANTS.CSBNO;
        END IF;
        UT_TRACE.TRACE('[FIN] OR_boSearchDataServices.fsbValidManageZone',10);
        RETURN SBRESULT;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('Error : ex.CONTROLLED_ERROR',10);
            RAISE;
        WHEN OTHERS THEN
            UT_TRACE.TRACE('Error : others',12);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FSBVALIDMANAGEZONE;
    
    
    

















    FUNCTION FSBFILLORDERSREVIEW
    RETURN   VARCHAR2
    IS
        SBREVIEW   VARCHAR2(20000);
    BEGIN
        UT_TRACE.TRACE('Inicio OR_boSearchDataServices.fsbFillOrdersReview', 5);

        SBREVIEW:= '/*+'||CHR(10)||
                   '     ordered'||CHR(10)||
                   '     use_nl(ora ord) */'||CHR(10)||
                   ' ord.ORDER_id,'||CHR(10)||
                   ' ord.numerator_id || chr(32) || chr(45) || chr(32) || ord.sequence NUME,'||CHR(10)||
                   ' (select task_type_id || chr(32) || chr(45) || chr(32) || description  FROM or_task_type WHERE task_type_id=ord.task_type_id) TASK_TYPE,'||CHR(10)||
                   ' (select items_id || chr(32) || chr(45) || chr(32) || description FROM ge_items WHERE items_id=ora.activity_id) ACT,'||CHR(10)||
                   ' (select ORDER_status_id || chr(32) || chr(45) || chr(32) || description FROM or_order_status WHERE ORDER_status_id=ord.order_status_id) ORD_STATUS,'||CHR(10)||
                   ' (select causal_id || chr(32) || chr(45) || chr(32) || description FROM ge_causal WHERE causal_id=ord.causal_id) CAUSAL,'||CHR(10)||
                   ' (select operating_unit_id || chr(32) || chr(45) || chr(32) || name FROM OR_operating_unit WHERE operating_unit_id= ord.operating_unit_id) OPE_UNI,'||CHR(10)||
                   ' ord.created_date,'||CHR(10)||
                   ' ord.assigned_date,'||CHR(10)||
                   ' ord.exec_estimate_date,'||CHR(10)||
                   ' ord.exec_initial_date,'||CHR(10)||
                   ' ord.execution_final_date,'||CHR(10)||
                   ' ora.package_id,'||CHR(10)||
                   ' (select package_type_id || chr(32) || chr(45) || chr(32) || description FROM ps_package_type WHERE package_type_id = mop.package_type_id) PACKAGE_TYPE,'||CHR(10)||
                   ':parent_id parent_id';

        UT_TRACE.TRACE('Fin de OR_boSearchDataServices.fsbFillOrdersReview', 5);
        RETURN SBREVIEW;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FSBFILLORDERSREVIEW;

    

















    PROCEDURE GETORDERREVIEW
    (
        INUORDERID  IN  NUMBER,
        OCUCURSOR   OUT CONSTANTS.TYREFCURSOR
    )
    IS
        NUPACKAGEID     PR_CERTIFICATE.PACKAGE_ID%TYPE;
        SBREVIEW        VARCHAR2(20000);
        SBSQL           VARCHAR2(20000);
    BEGIN
        UT_TRACE.TRACE('Inicia OR_boSearchDataServices.GetOrderReview',15);

        
        SBREVIEW := FSBFILLORDERSREVIEW;

        SBSQL :=    ' SELECT '||SBREVIEW ||CHR(10)||
                    ' FROM    OR_order_Activity ora, OR_order ord, mo_packages mop'||CHR(10)||
                    ' WHERE   ord.order_id=ora.order_id'||CHR(10)||
                    ' AND     mop.package_id = ora.package_id'||CHR(10)||
                    ' AND     ora.order_id=:inuOrder' ||CHR(10)||
                    ' ORDER BY ord.created_date desc';

        OPEN OCUCURSOR FOR SBSQL USING CC_BOBOSSUTIL.CNUNULL, INUORDERID;


        UT_TRACE.TRACE('Finaliza OR_boSearchDataServices.GetOrderReview:'||CHR(10)||SBSQL,15);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;
    
    
    

















    PROCEDURE GETREQUESTORDERREVIEW
    (
        INUPACKAGEID    IN  NUMBER,
        OCUCURSOR       OUT CONSTANTS.TYREFCURSOR
    )
    IS
        NUPACKAGEID     PR_CERTIFICATE.PACKAGE_ID%TYPE;
        SBREVIEW        VARCHAR2(20000);
        SBSQL           VARCHAR2(20000);
    BEGIN
        UT_TRACE.TRACE('Inicia OR_boSearchDataServices.GetRequestOrderReview',15);

        
        SBREVIEW := FSBFILLORDERSREVIEW;

        SBSQL :=    ' SELECT '||SBREVIEW ||CHR(10)||
                    ' FROM    OR_order_Activity ora, OR_order ord, mo_packages mop'||CHR(10)||
                    ' WHERE   ord.order_id=ora.order_id'||CHR(10)||
                    ' AND     mop.package_id = ora.package_id'||CHR(10)||
                    ' AND     ora.package_id in (select PACKAGE_id FROM mo_packages_asso WHERE PACKAGE_id_asso = :package_id union SELECT '||INUPACKAGEID||' package_id FROM dual)' ||CHR(10)||
                    ' ORDER BY ord.created_date desc';

        OPEN OCUCURSOR FOR SBSQL USING INUPACKAGEID, INUPACKAGEID;


        UT_TRACE.TRACE('Finaliza OR_boSearchDataServices.GetRequestOrderReview:'||CHR(10)||SBSQL,15);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;
    
    

















    
    PROCEDURE GETSUBSCRIBERS
    (
        INUSUBSCRIBERID    IN  GE_SUBSCRIBER.SUBSCRIBER_ID%TYPE,
        ISBIDENTIFICATION  IN  GE_SUBSCRIBER.IDENTIFICATION%TYPE,
        ISBSUBSLASTNAME    IN  GE_SUBSCRIBER.SUBS_LAST_NAME%TYPE,
        OCUCURSOR          OUT CONSTANTS.TYREFCURSOR
    )
    IS
        SBSQL                     GE_BOUTILITIES.STYSTATEMENT; 
        SBWHERE                   GE_BOUTILITIES.STYSTATEMENT; 
    BEGIN

        UT_TRACE.TRACE('Inicia OR_boSearchDataServices.GetSubscribers',15);

        SBSQL := 'SELECT subscriber_id id,' || CHR(10) ||
                 'subscriber_name ||'' ''|| subs_last_name description' || CHR(10) ||
                 'FROM ge_subscriber  /*+ Ubicaci?n: OR_boSearchDataServices.GetSubscribers*/';

        IF (INUSUBSCRIBERID IS NOT NULL) THEN
            IF (SBWHERE IS NULL) THEN
                SBWHERE := 'WHERE ge_subscriber.subscriber_id = ' ||  INUSUBSCRIBERID;
            ELSE
                SBWHERE := SBWHERE || 'AND ge_subscriber.subscriber_id = ' ||  INUSUBSCRIBERID;
            END IF;
        END IF;
        
        IF (ISBIDENTIFICATION IS NOT NULL) THEN
            IF (SBWHERE IS NULL) THEN
                SBWHERE := 'WHERE ge_subscriber.identification = ''' ||  ISBIDENTIFICATION || '''';
            ELSE
                SBWHERE := SBWHERE || 'AND ge_subscriber.identification = ''' ||  ISBIDENTIFICATION || '''';
            END IF;
        END IF;
        
        IF (ISBSUBSLASTNAME IS NOT NULL) THEN
            IF (SBWHERE IS NULL) THEN
                SBWHERE := 'WHERE ge_subscriber.subs_last_name like ''%' ||  ISBSUBSLASTNAME || '%''';
            ELSE
                SBWHERE := SBWHERE || 'AND ge_subscriber.subs_last_name like ''%' ||  ISBSUBSLASTNAME || '%''';
            END IF;
        END IF;

        SBSQL := SBSQL || CHR(10) || SBWHERE;

        OPEN OCUCURSOR FOR SBSQL;
        
        UT_TRACE.TRACE('Finaliza OR_boSearchDataServices.GetSubscribers:'||CHR(10)||SBSQL,15);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETSUBSCRIBERS;
    
    














    PROCEDURE GETORDERRELATBYORDERPNO
    (
        ISBORDERID IN VARCHAR2,
        OCUDATACURSOR  OUT CONSTANTS.TYREFCURSOR
    )
    IS
      SBSQL                          GE_BOUTILITIES.STYSTATEMENT;
      NUORDERID                      OR_ORDER.ORDER_ID%TYPE;
      SBORDERRELATBYORDERATTRIBUTES  GE_BOUTILITIES.STYSTATEMENT;

        PROCEDURE FILLORDERRELATATTRIBUTES
        IS
            SBNUMERATOR         GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
            SBTASKTYPE          GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
            SBORDERSTATUS       GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
            SBOPERATINGSECTOR   GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
            SBOPERATINGUNIT     GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;

        BEGIN

            IF SBORDERRELATBYORDERATTRIBUTES IS NOT NULL THEN
                RETURN;
            END IF;

            
            SBNUMERATOR := 'OR_ORDER.numerator_id'||GE_BOUTILITIES.CSBSEPARATOR ||'OR_ORDER.sequence';
            SBTASKTYPE := 'OR_ORDER.TASK_TYPE_ID'||GE_BOUTILITIES.CSBSEPARATOR ||'OR_boBasicDataServices.fsbGetDescTaskType(OR_ORDER.TASK_TYPE_ID)';
            SBORDERSTATUS := 'OR_ORDER.ORDER_STATUS_ID'||GE_BOUTILITIES.CSBSEPARATOR ||'daor_order_status.fsbGetDescription(OR_ORDER.ORDER_STATUS_ID)';
            SBOPERATINGSECTOR := 'OR_ORDER.OPERATING_SECTOR_ID'||GE_BOUTILITIES.CSBSEPARATOR ||'OR_boBasicDataServices.fsbGetDescOperatinSector(OR_ORDER.OPERATING_SECTOR_ID)';
            SBOPERATINGUNIT := 'OR_ORDER.OPERATING_UNIT_ID'||GE_BOUTILITIES.CSBSEPARATOR ||'OR_boBasicDataServices.fsbGetDescOperatingUnit(OR_ORDER.OPERATING_UNIT_ID)';

            GE_BOUTILITIES.ADDATTRIBUTE ('OR_ORDER.ORDER_ID','ORDER_ID',SBORDERRELATBYORDERATTRIBUTES);
            GE_BOUTILITIES.ADDATTRIBUTE (SBNUMERATOR,'numerator', SBORDERRELATBYORDERATTRIBUTES);
            GE_BOUTILITIES.ADDATTRIBUTE (SBTASKTYPE,'TASK_TYPE',SBORDERRELATBYORDERATTRIBUTES);
            GE_BOUTILITIES.ADDATTRIBUTE (SBORDERSTATUS,'ORDER_STATUS',SBORDERRELATBYORDERATTRIBUTES);
            GE_BOUTILITIES.ADDATTRIBUTE (SBOPERATINGSECTOR,'OPERATING_SECTOR',SBORDERRELATBYORDERATTRIBUTES);
            GE_BOUTILITIES.ADDATTRIBUTE (SBOPERATINGUNIT,'OPERATING_UNIT',SBORDERRELATBYORDERATTRIBUTES);
            GE_BOUTILITIES.ADDATTRIBUTE (':parent_id','parent_id',SBORDERRELATBYORDERATTRIBUTES);

        EXCEPTION
            WHEN EX.CONTROLLED_ERROR THEN
                RAISE EX.CONTROLLED_ERROR;

            WHEN OTHERS THEN
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;
        END FILLORDERRELATATTRIBUTES;

    BEGIN

        IF INSTR(ISBORDERID, '-') != 0 THEN
            NUORDERID := TO_NUMBER(UT_STRING.EXTSTRFIELD(ISBORDERID,'-',1));
        ELSE
            NUORDERID := TO_NUMBER(ISBORDERID);
        END IF;

        FILLORDERRELATATTRIBUTES;

        SBSQL := 'select /*+ index(OR_ORDER PK_OR_ORDER)
                             index(OR_RELATED_ORDER IX_OR_RELATED_ORDER01)*/'||CHR(10)||
                    'UNIQUE '|| SBORDERRELATBYORDERATTRIBUTES ||CHR(10)||
                    ' , (select description FROM ge_transition_type WHERE transition_type_id = OR_RELATED_ORDER.rela_order_type_id) relation_type' ||CHR(10)||
                    ' FROM /*+ GetOrderRelatByOrderPno.GetOrderRelatByOrderPno SAO207537 */OR_ORDER,OR_RELATED_ORDER '||CHR(10)||
                    ' WHERE ' ||CHR(10)||
                    ' OR_ORDER.ORDER_ID = OR_RELATED_ORDER.RELATED_ORDER_ID'||CHR(10)||
                    ' START WITH OR_RELATED_ORDER.ORDER_id = :inuOrderId
                      CONNECT BY OR_RELATED_ORDER.ORDER_id = PRIOR related_order_id' ;

        UT_TRACE.TRACE(SBSQL);

        OPEN OCUDATACURSOR FOR SBSQL
            USING ISBORDERID,NUORDERID;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETORDERRELATBYORDERPNO;
    
    

















    PROCEDURE GETREVIEWBYPRODUCT
    (
        INUPRODUCT IN NUMBER,
        OCUCURSOR  OUT CONSTANTS.TYREFCURSOR
    )
    IS
        NUPACKAGEID     PR_CERTIFICATE.PACKAGE_ID%TYPE;
        SBREVIEW        VARCHAR2(20000);
        SBSQL           VARCHAR2(20000);
    BEGIN
        UT_TRACE.TRACE('Inicia OR_boSearchDataServices.GetReviewByProduct',15);

        
        SBREVIEW := FSBFILLORDERSREVIEW;

        SBSQL := 'SELECT '||SBREVIEW ||CHR(10)||
                 'FROM  (SELECT /*+ leading(or_order_activity)'||CHR(10)||
                 '                  index(or_order_activity IDX_OR_ORDER_ACTIVITY_010)'||CHR(10)||
                 '                  use_nl(or_order_activity ge_items) */'||CHR(10)||
                 '              or_order_activity.*'||CHR(10)||
                 '       FROM  or_order_activity,'||CHR(10)||
                 '             ge_items'||CHR(10)||
                 '       WHERE or_order_activity.product_id = :nuProductId'||CHR(10)||
                 '       AND   or_order_activity.activity_id = ge_items.items_id'||CHR(10)||
                 '       AND   ge_items.use_ = '''||OR_BOCONSTANTS.CSBCLIENT_REVIEW||''') ora,'||CHR(10)||
                 '      or_order ord, mo_packages mop'||CHR(10)||
                 '      /*+ OR_boSearchDataServices.GetReviewByProduct SAO214100 */'||CHR(10)||
                 'WHERE ora.order_id = ord.order_id'||CHR(10)||
                 ' AND  mop.package_id = ora.package_id'||CHR(10)||
                 'ORDER BY ord.created_date desc';

        UT_TRACE.TRACE('sbSql: '||CHR(10)||SBSQL,15);
        OPEN OCUCURSOR FOR SBSQL USING INUPRODUCT,
                                       INUPRODUCT;

        UT_TRACE.TRACE('Finaliza OR_boSearchDataServices.GetReviewByProduct',15);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETREVIEWBYPRODUCT;

END OR_BOSEARCHDATASERVICES;