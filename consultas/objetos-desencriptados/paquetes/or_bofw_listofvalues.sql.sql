CREATE OR REPLACE PACKAGE BODY OR_BOFW_LISTOFVALUES IS
   CSBVERSION CONSTANT VARCHAR2( 20 ) := 'SAO194140';
   CSBDEFA_OPERSECT_PARAM GE_PARAMETER.PARAMETER_ID%TYPE := 'OPER_SEC_DEFAULT_IF';
   FUNCTION FSBVERSION
    RETURN VARCHAR2
    IS
    BEGIN
      RETURN CSBVERSION;
   END;
   PROCEDURE ACTIVITYLISTVALUES( ORFOUTPUT IN OUT NOCOPY CONSTANTS.TYREFCURSOR )
    IS
      SBVALATTRIBUTE VARCHAR2( 100 );
      SBVALATTRIBUTEE VARCHAR2( 100 );
      SBSQL VARCHAR2( 4000 );
      NUENTITYID GE_ENTITY.ENTITY_ID%TYPE;
      SBIDINDEX VARCHAR2( 100 );
      NUPACKAGEID MO_PACKAGES.PACKAGE_ID%TYPE;
      SBELEMTYPE VARCHAR2( 2000 );
      NUDAMAGE_TYPE_ID TT_DAMAGE.FINAL_DAMAGE_TYPE_ID%TYPE;
      NUDIAGORDER OR_ORDER.ORDER_ID%TYPE;
    BEGIN
      IF ( GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK( GE_BOINSTANCECONSTANTS.CSBWORK_INSTANCE, NULL, 'CREATE_ORDER_DATA', 'ENTITY_ID', SBIDINDEX ) = GE_BOCONSTANTS.GETTRUE ) THEN
         GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE( GE_BOINSTANCECONSTANTS.CSBWORK_INSTANCE, NULL, 'CREATE_ORDER_DATA', 'ENTITY_ID', SBVALATTRIBUTE );
         UT_TRACE.TRACE( 'sbValAttribute [' || SBVALATTRIBUTE || ']', 7 );
         NUENTITYID := TO_NUMBER( SBVALATTRIBUTE );
         IF NUENTITYID IS NOT NULL AND DAGE_ENTITY.FBLEXIST( NUENTITYID ) THEN
            IF ( GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK( GE_BOINSTANCECONSTANTS.CSBWORK_INSTANCE, NULL, 'CREATE_ORDER_DATA', 'EXTERNAL_ID', SBIDINDEX ) = GE_BOCONSTANTS.GETTRUE ) THEN
               GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE( GE_BOINSTANCECONSTANTS.CSBWORK_INSTANCE, NULL, 'CREATE_ORDER_DATA', 'EXTERNAL_ID', SBVALATTRIBUTEE );
               NUPACKAGEID := TO_NUMBER( SBVALATTRIBUTEE );
               IF DAMO_PACKAGES.FBLEXIST( NUPACKAGEID ) AND DATT_DAMAGE.FBLEXIST( NUPACKAGEID ) THEN
                  NUDAMAGE_TYPE_ID := NVL( DATT_DAMAGE.FNUGETFINAL_DAMAGE_TYPE_ID( NUPACKAGEID ), DATT_DAMAGE.FNUGETREG_DAMAGE_TYPE_ID( NUPACKAGEID ) );
                  NUDIAGORDER := TT_BOORDERDAMAGEUTILITIES.FNUGETDIAGORDER( NUPACKAGEID );
                  TT_BOFW_LISTOFVALUES.GETACTIVITYDIAGNOBYPRODTYPE( NUPACKAGEID, NUDIAGORDER, NUDAMAGE_TYPE_ID, ORFOUTPUT );
                  RETURN;
               END IF;
            END IF;
         END IF;
      END IF;
      UT_TRACE.TRACE( 'sbValAttribute 4[' || SBVALATTRIBUTE || ']', 7 );
      OPEN ORFOUTPUT FOR SELECT TASK_TYPE_ID id, DESCRIPTION description
                from OR_TASK_TYPE ;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END ACTIVITYLISTVALUES;
   PROCEDURE OPERSECTLISTVALUES( ORFOUTPUT IN OUT NOCOPY CONSTANTS.TYREFCURSOR )
    IS
    BEGIN
      OPEN ORFOUTPUT FOR SELECT OPERATING_SECTOR_ID id, DESCRIPTION description
              FROM OR_OPERATING_SECTOR;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE OPERUNITLISTVALUES( ORFOUTPUT IN OUT NOCOPY CONSTANTS.TYREFCURSOR )
    IS
      SBINSTANCE GE_BOINSTANCECONTROL.STYSBNAME;
      SBIDINDEX GE_BOINSTANCECONTROL.STYNUINDEX;
      SBOPERUNITSQL GE_BOUTILITIES.STYSTATEMENT;
      SBITEMS_ID GE_BOINSTANCECONTROL.STYSBVALUE;
      SBOPERATING_SECTOR_ID GE_BOINSTANCECONTROL.STYSBVALUE;
      NUITEMS_ID GE_ITEMS.ITEMS_ID%TYPE;
      NUOPERATING_SECTOR_ID OR_OPERATING_SECTOR.OPERATING_SECTOR_ID%TYPE;
      SBADDRESS_ID GE_BOINSTANCECONTROL.STYSBVALUE;
    BEGIN
      GE_BOINSTANCECONTROL.GETCURRENTINSTANCE( SBINSTANCE );
      IF ( GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK( SBINSTANCE, NULL, 'GE_ITEMS', 'ITEMS_ID', SBIDINDEX ) = GE_BOCONSTANTS.GETTRUE ) THEN
         SBITEMS_ID := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE( 'GE_ITEMS', 'ITEMS_ID' );
       ELSE
         IF ( GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK( GE_BOINSTANCECONSTANTS.CSBWORK_INSTANCE, NULL, 'GE_ITEMS', 'ITEMS_ID', SBIDINDEX ) = GE_BOCONSTANTS.GETTRUE ) THEN
            GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE( GE_BOINSTANCECONSTANTS.CSBWORK_INSTANCE, NULL, 'GE_ITEMS', 'ITEMS_ID', SBITEMS_ID );
         END IF;
      END IF;
      IF ( SBITEMS_ID IS NOT NULL ) THEN
         NUITEMS_ID := UT_CONVERT.FNUCHARTONUMBER( SBITEMS_ID );
      END IF;
      IF ( GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK( SBINSTANCE, NULL, 'OR_ORDER', 'OPERATING_SECTOR_ID', SBIDINDEX ) = GE_BOCONSTANTS.GETTRUE ) THEN
         SBOPERATING_SECTOR_ID := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE( 'OR_ORDER', 'OPERATING_SECTOR_ID' );
       ELSE
         IF ( GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK( GE_BOINSTANCECONSTANTS.CSBWORK_INSTANCE, NULL, 'OR_ORDER', 'OPERATING_SECTOR_ID', SBIDINDEX ) = GE_BOCONSTANTS.GETTRUE ) THEN
            GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE( GE_BOINSTANCECONSTANTS.CSBWORK_INSTANCE, NULL, 'OR_ORDER', 'OPERATING_SECTOR_ID', SBOPERATING_SECTOR_ID );
         END IF;
      END IF;
      IF ( SBOPERATING_SECTOR_ID IS NOT NULL ) THEN
         NUOPERATING_SECTOR_ID := UT_CONVERT.FNUCHARTONUMBER( SBOPERATING_SECTOR_ID );
      END IF;
      IF ( GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK( SBINSTANCE, NULL, 'AB_ADDRESS', 'ADDRESS_ID', SBIDINDEX ) = GE_BOCONSTANTS.GETTRUE ) THEN
         SBADDRESS_ID := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE( 'AB_ADDRESS', 'ADDRESS_ID' );
       ELSE
         IF ( GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK( GE_BOINSTANCECONSTANTS.CSBWORK_INSTANCE, NULL, 'AB_ADDRESS', 'ADDRESS_ID', SBIDINDEX ) = GE_BOCONSTANTS.GETTRUE ) THEN
            GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE( GE_BOINSTANCECONSTANTS.CSBWORK_INSTANCE, NULL, 'AB_ADDRESS', 'ADDRESS_ID', SBADDRESS_ID );
         END IF;
      END IF;
      IF ( SBOPERATING_SECTOR_ID IS NULL AND SBADDRESS_ID IS NOT NULL ) THEN
         NUOPERATING_SECTOR_ID := OR_BOFW_PROCESS.FNUGETSECTORBYADDRESS( UT_CONVERT.FNUCHARTONUMBER( SBADDRESS_ID ) );
      END IF;
      OPEN ORFOUTPUT FOR SELECT /*+ index(GE_SECTOROPE_ZONA IDX_GE_SECTOROPE_ZONA_02 )
                       index(OR_ZONA_BASE_ADM IDX_OR_ZONA_BASE_ADM_02 )
                       index(OR_OPERATING_UNIT IDX_OR_OPERATING_UNIT_04 )
                       index(OR_OPER_UNIT_STATUS PK_OR_OPER_UNIT_STATUS ) */
                 distinct operating_unit_id id, name description
            FROM ge_sectorope_zona, or_zona_base_adm,
                 or_operating_unit, or_oper_unit_status
            /*+ OR_BOFW_ListOfValues.OperUnitListValues SAO168500 */
            WHERE or_oper_unit_status.oper_unit_status_id =
                  or_operating_unit.oper_unit_status_id
              AND or_operating_unit.admin_base_id =
                  or_zona_base_adm.id_base_administra
              AND or_operating_unit.valid_for_assign = ge_boconstants.csbYES
              AND or_zona_base_adm.operating_zone_id =
                  ge_sectorope_zona.id_zona_operativa
              AND ge_sectorope_zona.id_sector_operativo = nuOPERATING_SECTOR_ID
              AND or_oper_unit_status.valid_for_assign = ge_boconstants.csbYES
              AND or_operating_unit.assign_type not in (or_bcorderoperatingunit.csbASSIGN_SCHED,
                                                        or_bcorderoperatingunit.csbASSIGN_ROUTE
                                                        )
              AND OR_BcActividad_Unitrab.fsbIsValidActivity
                (
                    nuITEMS_ID,
                    or_operating_unit.operating_unit_id
                ) = ge_boconstants.csbYES;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END OPERUNITLISTVALUES;
   PROCEDURE ORDERCOMMENTLISTVALUES( ORFOUTPUT IN OUT NOCOPY CONSTANTS.TYREFCURSOR )
    IS
      SBORDCOMMSQL VARCHAR2( 1024 );
      SBTASK_TYPE_ID GE_BOINSTANCECONTROL.STYSBVALUE;
      NUCOUNT NUMBER;
      CURSOR CUCOMMBYTASK( NUTASKTYPE IN OR_TASK_TYPE_COMMENT.TASK_TYPE_ID%TYPE ) IS
SELECT count(1)
               FROM or_task_type_comment, ge_comment_type
               WHERE or_task_type_comment.comment_type_id = ge_comment_type.comment_type_id
               AND or_task_type_comment.task_type_id = nvl(nuTaskType,'-1');
      PROCEDURE CLOSECURSORS
       IS
       BEGIN
         IF CUCOMMBYTASK%ISOPEN THEN
            CLOSE CUCOMMBYTASK;
         END IF;
      END;
    BEGIN
      SBTASK_TYPE_ID := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE( 'OR_ORDER', 'TASK_TYPE_ID' );
      OPEN CUCOMMBYTASK( TO_NUMBER( SBTASK_TYPE_ID ) );
      FETCH CUCOMMBYTASK
         INTO NUCOUNT;
      CLOSE CUCOMMBYTASK;
      IF NUCOUNT < 1 THEN
         SBORDCOMMSQL := ' select COMMENT_TYPE_ID id, DESCRIPTION description ' || CHR( 10 ) || ' from GE_COMMENT_TYPE ' || CHR( 10 ) || ' where GE_COMMENT_TYPE.COMMENT_CLASS_ID <> 23 ';
       ELSE
         SBORDCOMMSQL := ' select ge_comment_type.COMMENT_TYPE_ID id, ge_comment_type.DESCRIPTION description ' || CHR( 10 ) || ' from or_task_type_comment, ge_comment_type ' || CHR( 10 ) || ' where or_task_type_comment.comment_type_id = ge_comment_type.comment_type_id ' || CHR( 10 ) || ' and or_task_type_comment.task_type_id = nvl(' || SBTASK_TYPE_ID || ',''-1'') ' || CHR( 10 ) || ' and ge_comment_type.comment_class_id <> 23 ';
      END IF;
      OPEN ORFOUTPUT
           FOR SBORDCOMMSQL;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         CLOSECURSORS;
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         CLOSECURSORS;
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE OPSEOPUNITSKTYPLISTVALUES( ORFOUTPUT OUT CONSTANTS.TYREFCURSOR )
    IS
      SBOPERSECTSQL VARCHAR2( 4000 );
      SBIDINDEX GE_BOINSTANCECONTROL.STYNUINDEX;
      SBOPERSECDEFAULTID GE_PARAMETER.VAL_FUNCTION%TYPE;
      SBVALATTRIBUTE GE_BOINSTANCECONTROL.STYSBVALUE;
      NUTASKTYPEID OR_ORDER.TASK_TYPE_ID%TYPE;
      NUOPERSECDEFAULTID OR_OPERATING_SECTOR.OPERATING_SECTOR_ID%TYPE;
      NUCOUNT NUMBER;
      NUORDERID OR_ORDER.ORDER_ID%TYPE;
      NUOPERATINGSECTORID OR_ORDER.OPERATING_SECTOR_ID%TYPE;
      SBCURRENTINSTANCE VARCHAR2( 200 );
    BEGIN
      UT_TRACE.TRACE( 'INICIO - OpSeOpUniTskTypListValues' );
      GE_BOINSTANCECONTROL.GETCURRENTINSTANCE( SBCURRENTINSTANCE );
      IF ( GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK( GE_BOINSTANCECONSTANTS.CSBWORK_INSTANCE, NULL, 'OR_ORDER', 'TASK_TYPE_ID', SBIDINDEX ) = GE_BOCONSTANTS.GETTRUE ) THEN
         GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE( GE_BOINSTANCECONSTANTS.CSBWORK_INSTANCE, NULL, 'OR_ORDER', 'TASK_TYPE_ID', SBVALATTRIBUTE );
         UT_TRACE.TRACE( 'sbValAttribute [' || SBVALATTRIBUTE || ']', 7 );
         NUTASKTYPEID := TO_NUMBER( SBVALATTRIBUTE );
         UT_TRACE.TRACE( 'nuTaskTypeId [' || NUTASKTYPEID || ']', 7 );
         GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE( GE_BOINSTANCECONSTANTS.CSBWORK_INSTANCE, NULL, 'OR_ORDER', 'ORDER_ID', SBVALATTRIBUTE );
         NUORDERID := TO_NUMBER( SBVALATTRIBUTE );
         NUOPERATINGSECTORID := DAOR_ORDER.FNUGETOPERATING_SECTOR_ID( NUORDERID );
       ELSIF ( GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK( SBCURRENTINSTANCE, NULL, 'OR_ORDER', 'TASK_TYPE_ID', SBIDINDEX ) = GE_BOCONSTANTS.GETTRUE ) THEN
         GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE( SBCURRENTINSTANCE, NULL, 'OR_ORDER', 'TASK_TYPE_ID', SBVALATTRIBUTE );
         UT_TRACE.TRACE( 'sbValAttribute [' || SBVALATTRIBUTE || ']', 7 );
         NUTASKTYPEID := TO_NUMBER( SBVALATTRIBUTE );
         UT_TRACE.TRACE( 'nuTaskTypeId [' || NUTASKTYPEID || ']', 7 );
         IF ( GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK( SBCURRENTINSTANCE, NULL, 'OR_ORDER', 'ORDER_ID', SBIDINDEX ) = GE_BOCONSTANTS.GETTRUE ) THEN
            GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE( SBCURRENTINSTANCE, NULL, 'OR_ORDER', 'ORDER_ID', SBVALATTRIBUTE );
            NUORDERID := TO_NUMBER( SBVALATTRIBUTE );
            NUOPERATINGSECTORID := DAOR_ORDER.FNUGETOPERATING_SECTOR_ID( NUORDERID );
          ELSE
            NUOPERATINGSECTORID := NULL;
         END IF;
      END IF;
      IF OR_BCOPSE_OPUNT_TSKTYP.FBLEXISTTASKTYPE( NUTASKTYPEID ) THEN
         SBOPERSECTSQL := ' SELECT  or_operating_sector.operating_sector_id id, or_operating_sector.description ' || CHR( 10 ) || '   FROM  or_operating_sector, or_opse_opunt_tsktyp ' || CHR( 10 ) || '  WHERE  or_operating_sector.operating_sector_id = or_opse_opunt_tsktyp.operating_sector_id ' || CHR( 10 ) || '    AND  or_opse_opunt_tsktyp.task_type_id = :nuTaskTypeId ' || CHR( 10 ) || '  UNION ' || CHR( 10 ) || ' SELECT  or_operating_sector.operating_sector_id id, or_operating_sector.description ' || CHR( 10 ) || '   FROM  or_operating_sector ' || CHR( 10 ) || '  WHERE  or_operating_sector.operating_sector_id = :nuOperatingSectorId ' || CHR( 10 ) || 'ORDER BY 1 ';
         OPEN ORFOUTPUT
              FOR SBOPERSECTSQL
              USING IN NUTASKTYPEID, IN NUOPERATINGSECTORID;
         RETURN;
       ELSIF OR_BOOPERATINGUNIT.FBLEXISTOPEUNIFORTASKTYPE( NUTASKTYPEID ) THEN
         SBOPERSECTSQL := ' SELECT  or_operating_sector.operating_sector_id id, or_operating_sector.description ' || CHR( 10 ) || '   FROM  or_operating_sector ' || CHR( 10 ) || 'ORDER BY 1 ';
         OPEN ORFOUTPUT
              FOR SBOPERSECTSQL;
         RETURN;
      END IF;
      SBOPERSECDEFAULTID := DAGE_PARAMETER.FSBGETVALUE( 'OPER_SEC_DEFAULT_IF' );
      NUOPERSECDEFAULTID := TO_NUMBER( SBOPERSECDEFAULTID );
      SBOPERSECTSQL := ' SELECT   operating_sector_id id, description ' || CHR( 10 ) || ' FROM     or_operating_sector ' || CHR( 10 ) || ' WHERE    operating_sector_id = :nuOperSecDefaultId ';
      OPEN ORFOUTPUT
           FOR SBOPERSECTSQL
           USING IN NUOPERSECDEFAULTID;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE ACTIVITIESBYELEMENTTYPE( ORFRESULT OUT CONSTANTS.TYREFCURSOR )
    IS
      SBELEMENT_TYPE_ID GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
      SBCLASS_ID GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
      SBSQL GE_BOUTILITIES.STYSTATEMENT;
      SBIDINDEX GE_BOINSTANCECONTROL.STYNUINDEX;
    BEGIN
      UT_TRACE.TRACE( '[INICIO] OR_BOFW_ListOfValues.activitiesByElementType', 5 );
      SBELEMENT_TYPE_ID := NULL;
      IF ( GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK( GE_BOINSTANCECONSTANTS.CSBWORK_INSTANCE, NULL, 'IF_NODE', 'ELEMENT_TYPE_ID', SBIDINDEX ) = GE_BOCONSTANTS.GETTRUE ) THEN
         GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE( GE_BOINSTANCECONSTANTS.CSBWORK_INSTANCE, NULL, 'IF_NODE', 'ELEMENT_TYPE_ID', SBELEMENT_TYPE_ID );
         UT_TRACE.TRACE( 'Tipo Elemento (if_node): [' || SBELEMENT_TYPE_ID || ']', 6 );
      END IF;
      IF ( GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK( GE_BOINSTANCECONSTANTS.CSBWORK_INSTANCE, NULL, 'IF_ASSIGNABLE', 'ELEMENT_TYPE_ID', SBIDINDEX ) = GE_BOCONSTANTS.GETTRUE ) THEN
         GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE( GE_BOINSTANCECONSTANTS.CSBWORK_INSTANCE, NULL, 'IF_ASSIGNABLE', 'ELEMENT_TYPE_ID', SBELEMENT_TYPE_ID );
         UT_TRACE.TRACE( 'Tipo Elemento (if_assignable): [' || SBELEMENT_TYPE_ID || ']', 6 );
      END IF;
      SBCLASS_ID := NULL;
      IF ( GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK( GE_BOINSTANCECONSTANTS.CSBWORK_INSTANCE, NULL, 'IF_NODE', 'CLASS_ID', SBIDINDEX ) = GE_BOCONSTANTS.GETTRUE ) THEN
         GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE( GE_BOINSTANCECONSTANTS.CSBWORK_INSTANCE, NULL, 'IF_NODE', 'CLASS_ID', SBCLASS_ID );
         UT_TRACE.TRACE( 'Clase (if_node): [' || SBCLASS_ID || ']', 6 );
      END IF;
      IF ( GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK( GE_BOINSTANCECONSTANTS.CSBWORK_INSTANCE, NULL, 'IF_ASSIGNABLE', 'CLASS_ID', SBIDINDEX ) = GE_BOCONSTANTS.GETTRUE ) THEN
         GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE( GE_BOINSTANCECONSTANTS.CSBWORK_INSTANCE, NULL, 'IF_ASSIGNABLE', 'CLASS_ID', SBCLASS_ID );
         UT_TRACE.TRACE( 'Clase (if_assignable): [' || SBCLASS_ID || ']', 6 );
      END IF;
      SBSQL := '
            SELECT distinct ge_items.items_id AS id,
                ge_items.description AS description
            FROM ge_items
            WHERE items_id in (
                SELECT items_id
                FROM OR_act_by_ele_type
                WHERE element_type_id = :sbElement_type_id
                    AND class_id = :sbClass_id
            )';
      OPEN ORFRESULT
           FOR SBSQL
           USING IN SBELEMENT_TYPE_ID, IN SBCLASS_ID;
      UT_TRACE.TRACE( '[FIN] OR_BOFW_ListOfValues.activitiesByElementType', 5 );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END ACTIVITIESBYELEMENTTYPE;
   PROCEDURE OPERATINGSECTORSBYACTIVI( ORFRESULT OUT CONSTANTS.TYREFCURSOR )
    IS
      SBOPERSECTSQL GE_BOUTILITIES.STYSTATEMENT;
    BEGIN
      SBOPERSECTSQL := '
            SELECT distinct operating_sector_id AS id,
                description AS description
            FROM or_operating_sector
            WHERE operating_sector_id <> -1';
      OPEN ORFRESULT
           FOR SBOPERSECTSQL;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END OPERATINGSECTORSBYACTIVI;
   PROCEDURE TASKTYPELISTVALUES( ORFOUTPUT IN OUT NOCOPY CONSTANTS.TYREFCURSOR )
    IS
      SBVALATTRIBUTE VARCHAR2( 100 );
      SBVALATTRIBUTEE VARCHAR2( 100 );
      SBSQL VARCHAR2( 4000 );
      NUENTITYID GE_ENTITY.ENTITY_ID%TYPE;
      SBIDINDEX VARCHAR2( 100 );
      NUPRODUCT_TYPE_ID SERVICIO.SERVCODI%TYPE;
      NUPACKAGEID MO_PACKAGES.PACKAGE_ID%TYPE;
      NUPACKAGE_TYPE_ID MO_PACKAGES.PACKAGE_TYPE_ID%TYPE;
      SBELEMTYPE VARCHAR2( 2000 );
    BEGIN
      IF ( GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK( GE_BOINSTANCECONSTANTS.CSBWORK_INSTANCE, NULL, 'CREATE_ORDER_DATA', 'ENTITY_ID', SBIDINDEX ) = GE_BOCONSTANTS.GETTRUE ) THEN
         GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE( GE_BOINSTANCECONSTANTS.CSBWORK_INSTANCE, NULL, 'CREATE_ORDER_DATA', 'ENTITY_ID', SBVALATTRIBUTE );
         UT_TRACE.TRACE( 'sbValAttribute [' || SBVALATTRIBUTE || ']', 7 );
         NUENTITYID := TO_NUMBER( SBVALATTRIBUTE );
         IF NUENTITYID IS NOT NULL AND DAGE_ENTITY.FBLEXIST( NUENTITYID ) THEN
            IF ( GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK( GE_BOINSTANCECONSTANTS.CSBWORK_INSTANCE, NULL, 'CREATE_ORDER_DATA', 'EXTERNAL_ID', SBIDINDEX ) = GE_BOCONSTANTS.GETTRUE ) THEN
               GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE( GE_BOINSTANCECONSTANTS.CSBWORK_INSTANCE, NULL, 'CREATE_ORDER_DATA', 'EXTERNAL_ID', SBVALATTRIBUTEE );
               NUPACKAGEID := TO_NUMBER( SBVALATTRIBUTEE );
               IF DAMO_PACKAGES.FBLEXIST( NUPACKAGEID ) AND DATT_DAMAGE.FBLEXIST( NUPACKAGEID ) THEN
                  NUPACKAGE_TYPE_ID := DAMO_PACKAGES.FNUGETPACKAGE_TYPE_ID( NUPACKAGEID );
                  NUPRODUCT_TYPE_ID := MO_BOPACKAGES.FRCGETINITIALMOTIVE( NUPACKAGEID, FALSE ).PRODUCT_TYPE_ID;
                  IF NUPACKAGE_TYPE_ID = TT_BOCONSTANTS.CNUINDDAMAGE THEN
                     SBSQL := 'SELECT unique or_task_type.task_type_id id, or_task_type.description ' || CHR( 10 ) || '  FROM tt_tas_typ_prod_typ, or_task_type ' || CHR( 10 ) || ' WHERE tt_tas_typ_prod_typ.task_type_id = or_task_type.task_type_id ' || CHR( 10 ) || '   AND tt_tas_typ_prod_typ.product_type_id = :nuProduct_type_id ' || CHR( 10 ) || 'ORDER BY or_task_type.task_type_id';
                     OPEN ORFOUTPUT
                          FOR SBSQL
                          USING IN NUPRODUCT_TYPE_ID;
                   ELSIF TT_BCDAMAGEELEMENT.FBLEXISTDAMAGEELEMENT( NUPACKAGEID ) THEN
                     SBSQL := 'SELECT unique  or_task_type.task_type_id id, or_task_type.description ' || CHR( 10 ) || '  FROM tt_damage_element, tt_tas_typ_ele_typ, or_task_type ' || CHR( 10 ) || ' WHERE tt_damage_element.package_id = :nuPackageId ' || CHR( 10 ) || '   AND tt_damage_element.element_type_id = tt_tas_typ_ele_typ.element_type_id ' || CHR( 10 ) || '   AND tt_tas_typ_ele_typ.task_type_id =  or_task_type.task_type_id ' || CHR( 10 ) || 'ORDER BY or_task_type.task_type_id';
                     OPEN ORFOUTPUT
                          FOR SBSQL
                          USING IN NUPACKAGEID;
                   ELSE
                     SBSQL := 'SELECT unique  or_task_type.task_type_id id, or_task_type.description ' || CHR( 10 ) || '  FROM tt_ele_typ_prod_typ,  tt_tas_typ_ele_typ, or_task_type ' || CHR( 10 ) || ' WHERE tt_ele_typ_prod_typ.product_type_id =   :nuProduct_type_id ' || CHR( 10 ) || '   AND tt_ele_typ_prod_typ.element_type_id = tt_tas_typ_ele_typ.element_type_id ' || CHR( 10 ) || '   AND tt_tas_typ_ele_typ.task_type_id =   or_task_type.task_type_id ' || CHR( 10 ) || 'ORDER BY  or_task_type.inuProductTypeId ';
                     OPEN ORFOUTPUT
                          FOR SBSQL
                          USING IN NUPRODUCT_TYPE_ID;
                  END IF;
                  RETURN;
               END IF;
            END IF;
         END IF;
      END IF;
      SBSQL := ' select TASK_TYPE_ID id, DESCRIPTION description ' || CHR( 10 ) || ' from OR_TASK_TYPE ';
      OPEN ORFOUTPUT
           FOR SBSQL;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE COMMENTTYPES( ORFOUTPUT IN OUT NOCOPY CONSTANTS.TYREFCURSOR )
    IS
      SBORDCOMMSQL VARCHAR2( 1024 );
    BEGIN
      SBORDCOMMSQL := ' select COMMENT_TYPE_ID id, DESCRIPTION description ' || CHR( 10 ) || ' from GE_COMMENT_TYPE' || CHR( 10 ) || ' where GE_COMMENT_TYPE.COMMENT_CLASS_ID <> 23 ' || CHR( 10 ) || ' ORDER BY description ';
      OPEN ORFOUTPUT
           FOR SBORDCOMMSQL;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE OPUNIBYTASTYPWITHOUTSCHEDULE( ORFRESULT IN OUT NOCOPY CONSTANTS.TYREFCURSOR )
    IS
      SBINSTANCE GE_BOINSTANCECONTROL.STYSBNAME;
      SBIDINDEX GE_BOINSTANCECONTROL.STYNUINDEX;
      SBTASK_TYPE_ID GE_BOINSTANCECONTROL.STYSBVALUE;
      SBOPERATING_SECTOR_ID GE_BOINSTANCECONTROL.STYSBVALUE;
      SBORDER_ID GE_BOINSTANCECONTROL.STYSBVALUE;
      NUTASK_TYPE_ID OR_TASK_TYPE.TASK_TYPE_ID%TYPE;
      NUOPERATING_SECTOR_ID OR_OPERATING_SECTOR.OPERATING_SECTOR_ID%TYPE;
      NUORDER OR_ORDER.ORDER_ID%TYPE;
      NUSTAGEID PM_STAGE.STAGE_ID%TYPE;
      NUPROJECTID PM_PROJECT.PROJECT_ID%TYPE;
    BEGIN
      GE_BOINSTANCECONTROL.GETCURRENTINSTANCE( SBINSTANCE );
      IF ( GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK( SBINSTANCE, NULL, 'OR_ORDER', 'TASK_TYPE_ID', SBIDINDEX ) = GE_BOCONSTANTS.GETTRUE ) THEN
         SBTASK_TYPE_ID := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE( 'OR_ORDER', 'TASK_TYPE_ID' );
       ELSE
         IF ( GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK( GE_BOINSTANCECONSTANTS.CSBWORK_INSTANCE, NULL, 'OR_ORDER', 'TASK_TYPE_ID', SBIDINDEX ) = GE_BOCONSTANTS.GETTRUE ) THEN
            GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE( GE_BOINSTANCECONSTANTS.CSBWORK_INSTANCE, NULL, 'OR_ORDER', 'TASK_TYPE_ID', SBTASK_TYPE_ID );
         END IF;
      END IF;
      IF ( GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK( SBINSTANCE, NULL, 'OR_ORDER', 'OPERATING_SECTOR_ID', SBIDINDEX ) = GE_BOCONSTANTS.GETTRUE ) THEN
         SBOPERATING_SECTOR_ID := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE( 'OR_ORDER', 'OPERATING_SECTOR_ID' );
       ELSE
         IF ( GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK( GE_BOINSTANCECONSTANTS.CSBWORK_INSTANCE, NULL, 'OR_ORDER', 'OPERATING_SECTOR_ID', SBIDINDEX ) = GE_BOCONSTANTS.GETTRUE ) THEN
            GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE( GE_BOINSTANCECONSTANTS.CSBWORK_INSTANCE, NULL, 'OR_ORDER', 'OPERATING_SECTOR_ID', SBOPERATING_SECTOR_ID );
         END IF;
      END IF;
      IF ( GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK( GE_BOINSTANCECONSTANTS.CSBWORK_INSTANCE, NULL, 'OR_ORDER', 'ORDER_ID', SBIDINDEX ) = GE_BOCONSTANTS.GETTRUE ) THEN
         GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE( GE_BOINSTANCECONSTANTS.CSBWORK_INSTANCE, NULL, 'OR_ORDER', 'ORDER_ID', SBORDER_ID );
       ELSE
         IF ( GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK( GE_BOINSTANCECONSTANTS.CSBGLOBAL_INSTANCE, NULL, GE_BOINSTANCECONSTANTS.CSBGLOBAL_ENTITY, GE_BOINSTANCECONSTANTS.CSBGLOBAL_ID, SBIDINDEX ) = GE_BOCONSTANTS.GETTRUE ) THEN
            GE_BOINSTANCECONTROL.GETGLOBALATTRIBUTE( GE_BOINSTANCECONSTANTS.CSBGLOBAL_ID, SBORDER_ID );
         END IF;
      END IF;
      NUTASK_TYPE_ID := UT_CONVERT.FNUCHARTONUMBER( SBTASK_TYPE_ID );
      NUOPERATING_SECTOR_ID := UT_CONVERT.FNUCHARTONUMBER( SBOPERATING_SECTOR_ID );
      NUORDER := UT_CONVERT.FNUCHARTONUMBER( SBORDER_ID );
      NUSTAGEID := DAOR_ORDER.FNUGETSTAGE_ID( NUORDER );
      IF ( NUSTAGEID IS NULL ) THEN
         OPEN ORFRESULT FOR SELECT /*+ ordered
                           index(GE_SECTOROPE_ZONA IDX_GE_SECTOROPE_ZONA_02 )
                           index(OR_ZONA_BASE_ADM IDX_OR_ZONA_BASE_ADM_02 )
                           index(OR_OPERATING_UNIT IDX_OR_OPERATING_UNIT_04 )
                           index(OR_OPER_UNIT_STATUS PK_OR_OPER_UNIT_STATUS )
                           index(OR_OPE_UNI_TASK_TYPE PK_OR_OPE_UNI_TASK_TYPE ) */
                     distinct or_operating_unit.operating_unit_id id, or_operating_unit.name description
                FROM ge_sectorope_zona, or_zona_base_adm, or_operating_unit, or_oper_unit_status,
                     or_ope_uni_task_type
                 /*+ OR_BOFW_ListOfValues.OpUniByTasTypWithOutSchedule SAO194140 */
                WHERE or_oper_unit_status.oper_unit_status_id = or_operating_unit.oper_unit_status_id
                  AND ge_sectorope_zona.id_zona_operativa = nvl(or_operating_unit.operating_zone_id, ge_sectorope_zona.id_zona_operativa)
                  AND or_operating_unit.admin_base_id = or_zona_base_adm.id_base_administra
                  AND or_operating_unit.valid_for_assign = ge_boconstants.csbYES
                  AND or_zona_base_adm.operating_zone_id = ge_sectorope_zona.id_zona_operativa
                  AND or_ope_uni_task_type.operating_unit_id = or_operating_unit.operating_unit_id
                  AND or_ope_uni_task_type.task_type_id = nuTASK_TYPE_ID
                  AND ge_sectorope_zona.id_sector_operativo = nuOPERATING_SECTOR_ID
                  AND or_oper_unit_status.valid_for_assign = ge_boconstants.csbYES
                  AND or_operating_unit.assign_type not in (or_bcorderoperatingunit.csbASSIGN_SCHED,
                                                            or_bcorderoperatingunit.csbASSIGN_ROUTE
                                                            )
                   AND ( SELECT OR_BcActividad_Unitrab.fsbIsValidActOrder
                                (
                                    nuOrder,
                                    or_operating_unit.operating_unit_id
                                )
                            FROM dual
                        ) = ge_boconstants.csbYES;
       ELSE
         NUPROJECTID := DAPM_STAGE.FNUGETPROJECT_ID( NUSTAGEID );
         OPEN ORFRESULT FOR SELECT /*+ ordered
                           index(GE_SECTOROPE_ZONA IDX_GE_SECTOROPE_ZONA_02 )
                           index(OR_ZONA_BASE_ADM IDX_OR_ZONA_BASE_ADM_02 )
                           index(OR_OPERATING_UNIT IDX_OR_OPERATING_UNIT_04 )
                           index(OR_OPER_UNIT_STATUS PK_OR_OPER_UNIT_STATUS )
                           index(OR_OPE_UNI_TASK_TYPE PK_OR_OPE_UNI_TASK_TYPE ) */
                     distinct or_operating_unit.operating_unit_id id, or_operating_unit.name description
                FROM ge_sectorope_zona, or_zona_base_adm, or_operating_unit, or_oper_unit_status,
                     or_ope_uni_task_type,pm_unit_by_project
                /*+ OR_BOFW_ListOfValues.OpUniByTasTypWithOutSchedule SAO194140 */
                WHERE or_oper_unit_status.oper_unit_status_id = or_operating_unit.oper_unit_status_id
                  AND ge_sectorope_zona.id_zona_operativa = nvl(or_operating_unit.operating_zone_id, ge_sectorope_zona.id_zona_operativa)
                  AND or_operating_unit.admin_base_id = or_zona_base_adm.id_base_administra
                  AND or_zona_base_adm.operating_zone_id = ge_sectorope_zona.id_zona_operativa
                  AND or_ope_uni_task_type.operating_unit_id = or_operating_unit.operating_unit_id
                  AND or_ope_uni_task_type.task_type_id = nuTASK_TYPE_ID
                  AND ge_sectorope_zona.id_sector_operativo = nuOPERATING_SECTOR_ID
                  AND or_oper_unit_status.valid_for_assign = ge_boconstants.csbYES
                  AND or_operating_unit.assign_type not in (or_bcorderoperatingunit.csbASSIGN_SCHED,
                                                            or_bcorderoperatingunit.csbASSIGN_ROUTE
                                                            )
                   AND ( SELECT OR_BcActividad_Unitrab.fsbIsValidActOrder
                                (
                                    nuOrder,
                                    or_operating_unit.operating_unit_id
                                )
                            FROM dual
                        ) = ge_boconstants.csbYES
                   AND pm_unit_by_project.project_id = nuProjectId
                   AND pm_unit_by_project.operating_unit_id = or_operating_unit.operating_unit_id;
      END IF;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END OPUNIBYTASTYPWITHOUTSCHEDULE;
   PROCEDURE OPUNITSKTYPWITHOUTSCHEDULE( ORFOUTPUT OUT CONSTANTS.TYREFCURSOR )
    IS
      SBOPERUNITSQL GE_BOUTILITIES.STYSTATEMENT;
      SBINSTANCE GE_BOINSTANCECONTROL.STYSBNAME;
      SBIDINDEX GE_BOINSTANCECONTROL.STYNUINDEX;
      SBOPERATINGUNITID GE_BOINSTANCECONTROL.STYSBVALUE;
      SBTASKTYPEID GE_BOINSTANCECONTROL.STYSBVALUE;
      SBORDER_ID GE_BOINSTANCECONTROL.STYSBVALUE;
      NUTASKTYPEID OR_TASK_TYPE.TASK_TYPE_ID%TYPE;
      NUOPERATINGUNITID OR_OPERATING_UNIT.OPERATING_UNIT_ID%TYPE;
      NUORDER OR_ORDER.ORDER_ID%TYPE;
      NUSTAGEID PM_STAGE.STAGE_ID%TYPE;
      NUPROJECTID PM_PROJECT.PROJECT_ID%TYPE;
    BEGIN
      GE_BOINSTANCECONTROL.GETCURRENTINSTANCE( SBINSTANCE );
      IF ( GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK( GE_BOINSTANCECONSTANTS.CSBWORK_INSTANCE, NULL, 'OR_ORDER', 'OPERATING_UNIT_ID', SBIDINDEX ) = GE_BOCONSTANTS.GETTRUE ) THEN
         GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE( GE_BOINSTANCECONSTANTS.CSBWORK_INSTANCE, NULL, 'OR_ORDER', 'OPERATING_UNIT_ID', SBOPERATINGUNITID );
      END IF;
      IF GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK( SBINSTANCE, NULL, 'OR_ORDER', 'TASK_TYPE_ID', SBIDINDEX ) = GE_BOCONSTANTS.GETTRUE THEN
         GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE( SBINSTANCE, NULL, 'OR_ORDER', 'TASK_TYPE_ID', SBTASKTYPEID );
       ELSE
         IF ( GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK( GE_BOINSTANCECONSTANTS.CSBWORK_INSTANCE, NULL, 'OR_ORDER', 'TASK_TYPE_ID', SBIDINDEX ) = GE_BOCONSTANTS.GETTRUE ) THEN
            GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE( GE_BOINSTANCECONSTANTS.CSBWORK_INSTANCE, NULL, 'OR_ORDER', 'TASK_TYPE_ID', SBTASKTYPEID );
         END IF;
      END IF;
      IF ( GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK( GE_BOINSTANCECONSTANTS.CSBWORK_INSTANCE, NULL, 'OR_ORDER', 'ORDER_ID', SBIDINDEX ) = GE_BOCONSTANTS.GETTRUE ) THEN
         GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE( GE_BOINSTANCECONSTANTS.CSBWORK_INSTANCE, NULL, 'OR_ORDER', 'ORDER_ID', SBORDER_ID );
       ELSE
         IF ( GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK( GE_BOINSTANCECONSTANTS.CSBGLOBAL_INSTANCE, NULL, GE_BOINSTANCECONSTANTS.CSBGLOBAL_ENTITY, GE_BOINSTANCECONSTANTS.CSBGLOBAL_ID, SBIDINDEX ) = GE_BOCONSTANTS.GETTRUE ) THEN
            GE_BOINSTANCECONTROL.GETGLOBALATTRIBUTE( GE_BOINSTANCECONSTANTS.CSBGLOBAL_ID, SBORDER_ID );
         END IF;
      END IF;
      NUTASKTYPEID := UT_CONVERT.FNUCHARTONUMBER( SBTASKTYPEID );
      NUOPERATINGUNITID := UT_CONVERT.FNUCHARTONUMBER( SBOPERATINGUNITID );
      NUORDER := UT_CONVERT.FNUCHARTONUMBER( SBORDER_ID );
      NUSTAGEID := DAOR_ORDER.FNUGETSTAGE_ID( NUORDER );
      IF ( NUSTAGEID IS NULL ) THEN
         OPEN ORFOUTPUT FOR SELECT /*+
                           leading(or_ope_uni_task_type)
                           INDEX(or_ope_uni_task_type pk_or_ope_uni_task_type)
                           INDEX(or_operating_unit pk_or_operating_unit)
                           use_nl(or_ope_uni_task_type or_operating_unit)
                           INDEX(or_oper_unit_status pk_or_oper_unit_status)
                           use_nl(or_operating_unit or_oper_unit_status)
                        */
                       distinct or_operating_unit.operating_unit_id id, or_operating_unit.name description
                  FROM or_ope_uni_task_type, or_operating_unit, or_oper_unit_status
                  /*+ OR_BOFW_ListOfValues.OpUniTskTypWithOutSchedule SAO194140 */
                 WHERE or_ope_uni_task_type.operating_unit_id = or_operating_unit.operating_unit_id
                   AND or_ope_uni_task_type.task_type_id = nuTaskTypeId
                   AND or_ope_uni_task_type.operating_unit_id <> nuOperatingUnitId
                   AND or_operating_unit.oper_unit_status_id = or_oper_unit_status.oper_unit_status_id
                   AND or_operating_unit.valid_for_assign = ge_boconstants.csbYES
                   AND or_operating_unit.assign_type not in (or_bcorderoperatingunit.csbASSIGN_SCHED,
                                                             or_bcorderoperatingunit.csbASSIGN_ROUTE
                                                             )
                   AND or_oper_unit_status.valid_for_assign = ge_boconstants.csbYes
                   AND ( SELECT OR_BcActividad_Unitrab.fsbIsValidActOrder
                                (
                                    nuOrder,
                                    or_ope_uni_task_type.operating_unit_id
                                )
                            FROM dual
                        ) = ge_boconstants.csbYES;
       ELSE
         NUPROJECTID := DAPM_STAGE.FNUGETPROJECT_ID( NUSTAGEID );
         OPEN ORFOUTPUT FOR SELECT /*+
                           leading(or_ope_uni_task_type)
                           INDEX(or_ope_uni_task_type pk_or_ope_uni_task_type)
                           INDEX(or_operating_unit pk_or_operating_unit)
                           use_nl(or_ope_uni_task_type or_operating_unit)
                           INDEX(or_oper_unit_status pk_or_oper_unit_status)
                           use_nl(or_operating_unit or_oper_unit_status)
                           INDEX(pm_unit_by_project PK_PM_UNIT_BY_PROJECT)
                        */
                       distinct or_operating_unit.operating_unit_id id, or_operating_unit.name description
                  FROM or_ope_uni_task_type, or_operating_unit, or_oper_unit_status,pm_unit_by_project
                   /*+ OR_BOFW_ListOfValues.OpUniTskTypWithOutSchedule SAO194140 */
                 WHERE or_ope_uni_task_type.operating_unit_id = or_operating_unit.operating_unit_id
                   AND or_ope_uni_task_type.task_type_id = nuTaskTypeId
                   AND or_ope_uni_task_type.operating_unit_id <> nuOperatingUnitId
                   AND or_operating_unit.valid_for_assign = ge_boconstants.csbYES
                   AND or_operating_unit.oper_unit_status_id = or_oper_unit_status.oper_unit_status_id
                   AND or_operating_unit.assign_type not in (or_bcorderoperatingunit.csbASSIGN_SCHED,
                                                             or_bcorderoperatingunit.csbASSIGN_ROUTE
                                                             )
                   AND or_oper_unit_status.valid_for_assign = ge_boconstants.csbYES
                   AND ( SELECT OR_BcActividad_Unitrab.fsbIsValidActOrder
                                (
                                    nuOrder,
                                    or_ope_uni_task_type.operating_unit_id
                                )
                            FROM dual
                        ) = ge_boconstants.csbYES
                   AND pm_unit_by_project.project_id = nuProjectId
                   AND pm_unit_by_project.operating_unit_id = or_operating_unit.operating_unit_id;
      END IF;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE OPERUNITWITHOUTSCHEDULELOV( ORFOUTPUT IN OUT NOCOPY CONSTANTS.TYREFCURSOR )
    IS
      SBINSTANCE GE_BOINSTANCECONTROL.STYSBNAME;
      SBIDINDEX GE_BOINSTANCECONTROL.STYNUINDEX;
      SBOPERUNITSQL GE_BOUTILITIES.STYSTATEMENT;
      SBITEMS_ID GE_BOINSTANCECONTROL.STYSBVALUE;
      SBOPERATING_SECTOR_ID GE_BOINSTANCECONTROL.STYSBVALUE;
    BEGIN
      GE_BOINSTANCECONTROL.GETCURRENTINSTANCE( SBINSTANCE );
      IF ( GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK( SBINSTANCE, NULL, 'GE_ITEMS', 'ITEMS_ID', SBIDINDEX ) = GE_BOCONSTANTS.GETTRUE ) THEN
         SBITEMS_ID := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE( 'GE_ITEMS', 'ITEMS_ID' );
       ELSE
         IF ( GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK( GE_BOINSTANCECONSTANTS.CSBWORK_INSTANCE, NULL, 'GE_ITEMS', 'ITEMS_ID', SBIDINDEX ) = GE_BOCONSTANTS.GETTRUE ) THEN
            GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE( GE_BOINSTANCECONSTANTS.CSBWORK_INSTANCE, NULL, 'GE_ITEMS', 'ITEMS_ID', SBITEMS_ID );
         END IF;
      END IF;
      IF ( GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK( SBINSTANCE, NULL, 'OR_ORDER', 'OPERATING_SECTOR_ID', SBIDINDEX ) = GE_BOCONSTANTS.GETTRUE ) THEN
         SBOPERATING_SECTOR_ID := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE( 'OR_ORDER', 'OPERATING_SECTOR_ID' );
       ELSE
         IF ( GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK( GE_BOINSTANCECONSTANTS.CSBWORK_INSTANCE, NULL, 'OR_ORDER', 'OPERATING_SECTOR_ID', SBIDINDEX ) = GE_BOCONSTANTS.GETTRUE ) THEN
            GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE( GE_BOINSTANCECONSTANTS.CSBWORK_INSTANCE, NULL, 'OR_ORDER', 'OPERATING_SECTOR_ID', SBOPERATING_SECTOR_ID );
         END IF;
      END IF;
      SBOPERUNITSQL := '
            SELECT operating_unit_id id, name description
            FROM or_operating_unit,
                (SELECT
                    :inuActivity_id                  AS activity_id,
                    nvl(:inuOperating_sector_id, -1) AS operating_sector_id
                FROM dual) data_input
            WHERE or_operating_unit.assign_type <> ''S''
            AND operating_unit_id in (
                    SELECT operating_unit_id
                    FROM or_ope_uni_task_type
                    WHERE task_type_id in (
                        SELECT  task_type_id
                        FROM    OR_task_types_items,
                                ge_items
                        WHERE   OR_task_types_items.items_id = :data_inputactivity_id
                        AND     OR_task_types_items.items_id = ge_items.items_id
                        AND     nvl(ge_items.use_,''-'') <> OR_boconstants.fsbDiagnosticUse
                    )
                    union
                    SELECT  operating_unit_id
                    FROM    or_opse_opunt_tsktyp,
                            (
                                SELECT  OR_task_types_items.task_type_id
                                FROM    OR_task_types_items,
                                        ge_items
                                WHERE   OR_task_types_items.items_id = data_input.activity_id
                                AND     OR_task_types_items.items_id = ge_items.items_id
                                AND     nvl(ge_items.use_,''-'') <> OR_boconstants.fsbDiagnosticUse
                            ) a
                    WHERE   or_opse_opunt_tsktyp.operating_sector_id = data_input.operating_sector_id
                    AND     or_opse_opunt_tsktyp.task_type_id = a.task_type_id
                )
                AND oper_unit_status_id in (
                    SELECT oper_unit_status_id
                    FROM or_oper_unit_status
                    WHERE valid_for_assign = ge_boconstants.GetYes
                )
            ';
      OPEN ORFOUTPUT
           FOR SBOPERUNITSQL
           USING IN SBITEMS_ID, IN SBOPERATING_SECTOR_ID;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;
END OR_BOFW_LISTOFVALUES;
/


