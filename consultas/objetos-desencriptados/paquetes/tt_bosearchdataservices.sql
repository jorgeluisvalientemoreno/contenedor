PACKAGE BODY TT_boSearchDataServices
IS

























































































































































































































































    
    GNUPARENTPRODID PR_PRODUCT.PRODUCT_ID%TYPE := NULL;

    
    CSBVERSION   CONSTANT VARCHAR2(20) := 'SAO303320';

    
    CNUERRINIDATEENDDATE CONSTANT NUMBER := 346;
    
    CNUNEEDINIDATEENDDATE CONSTANT NUMBER := 2348;
    
    CNUERROR_399              CONSTANT  GE_MESSAGE.MESSAGE_ID%TYPE := 399;
    
    CNUERROR_3061              CONSTANT  GE_MESSAGE.MESSAGE_ID%TYPE := 3061;
    
    CNUERROR_403              CONSTANT  GE_MESSAGE.MESSAGE_ID%TYPE := 403;
    
    CNUERROR_6649              CONSTANT  GE_MESSAGE.MESSAGE_ID%TYPE := 6649;
    
    CNUERROR_114823           CONSTANT  GE_MESSAGE.MESSAGE_ID%TYPE := 114823;
    
    CNUERROR_114824           CONSTANT  GE_MESSAGE.MESSAGE_ID%TYPE := 114824;
    
    CNUERROR_8923             CONSTANT  GE_MESSAGE.MESSAGE_ID%TYPE := 8923;
    CNUERROR_8941             CONSTANT  GE_MESSAGE.MESSAGE_ID%TYPE := 8941;
    CNUERROR_11322            CONSTANT  GE_MESSAGE.MESSAGE_ID%TYPE := 11322;
    CSBDISTINC                CONSTANT  VARCHAR2(10) := 'DISTINCT ';


	
    

    FUNCTION FSBVERSION  RETURN VARCHAR2 IS
    BEGIN
        RETURN CSBVERSION;
    END;

    






















    PROCEDURE FILLDAMAGEELEMATTRIB
    (
        IOSBATTRIBUTES IN OUT VARCHAR2
    )
    IS
        SBDAMAGEELEMTYPE            GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        SBELEMENTDESCRIPTION        GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        SBDAMAGEELEMCLASS           GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        SBDAMAGEELEMCODE            GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        SBDAMAGEELEMSTATUS          GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        SBCOUNTPRODBYELEM           GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        SBDAMAGEELEMADDRESS         GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        SBELEMGEOGLOCA              GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        SBELEMNEIGHBORTHOOD         GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        SBDAMAGEELEMENTSTATUS       GE_BOUTILITIES.STYSTATEMENT;
        SBCOMPOSITECODE             GE_BOUTILITIES.STYSTATEMENT;

    BEGIN

        
        SBDAMAGEELEMTYPE        := 'TT_BCBasicDataServices.fsbGetDamageElemType( tt_damage_element.damage_element_id, tt_damage_element.element_type_id)';
        SBELEMENTDESCRIPTION    := 'TT_BCBasicDataServices.fsbGetDamageElemDescription(tt_damage_element.damage_element_id)';
        SBDAMAGEELEMCLASS       := 'TT_BCBasicDataServices.fsbGetDamageElemClass(tt_damage_element.damage_element_id)';
        SBDAMAGEELEMCODE        := 'TT_BCBasicDataServices.fsbGetDamageElemCode(tt_damage_element.damage_element_id)';
        SBDAMAGEELEMSTATUS      := 'TT_BCBasicDataServices.fsbGetDamageElemStat(tt_damage_element.damage_element_id)';
        SBCOUNTPRODBYELEM       := 'TT_BCBasicDataServices.fnuCountPrByDamagElem(tt_damage_element.damage_element_id)';
        SBDAMAGEELEMADDRESS     := 'TT_BCBasicDataServices.fsbGetAddressElem(tt_damage_element.damage_element_id)';
        SBELEMGEOGLOCA          := 'TT_BCBasicDataServices.fsbGetGeogLocaDesc(tt_damage_element.damage_element_id)';
        SBELEMNEIGHBORTHOOD     := 'TT_BCBasicDataServices.fsbGetNeighborthoodDesc(tt_damage_element.damage_element_id)';
        SBDAMAGEELEMENTSTATUS   := 'tt_damage_element.damage_eleme_status'||GE_BOUTILITIES.CSBSEPARATOR ||'decode(tt_damage_element.damage_eleme_status,
                                 ''A'', ''' || GE_BOI18N.FSBGETTRASLATION('TT_FW_DAMAGE_ELEMENT.DAMAGE_ELEME_STATUS_A') || ''',
                                 ''C'', ''' || GE_BOI18N.FSBGETTRASLATION('TT_FW_DAMAGE_ELEMENT.DAMAGE_ELEME_STATUS_C') || ''',
                                 ''I'', ''' || GE_BOI18N.FSBGETTRASLATION('TT_FW_DAMAGE_ELEMENT.DAMAGE_ELEME_STATUS_I') || ''',
                                 ''R'', ''' || GE_BOI18N.FSBGETTRASLATION('TT_FW_DAMAGE_ELEMENT.DAMAGE_ELEME_STATUS_R') || ''',
                                 ''N'', ''' || GE_BOI18N.FSBGETTRASLATION('TT_FW_DAMAGE_ELEMENT.DAMAGE_ELEME_STATUS_N') || ''',
                                 null)';
        SBCOMPOSITECODE         := 'if_boelement.fsbGetCompositeCode(tt_damage_element.element_type_id, tt_damage_element.element_id)';
                                 

        GE_BOUTILITIES.ADDATTRIBUTE ('tt_damage_element.damage_element_id','DAMAGE_ELEMENT_ID',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBDAMAGEELEMTYPE,'ELEMENT_TYPE',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBELEMENTDESCRIPTION,'ELEMENT_DESCRIPTION',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBDAMAGEELEMCLASS,'ELEMENT_CLASS',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBDAMAGEELEMCODE,'ELEMENT_CODE',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBCOMPOSITECODE,'COMPOSITE_CODE',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBDAMAGEELEMSTATUS,'ELEMENT_STATUS',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBDAMAGEELEMADDRESS,'ELEMENT_ADDRESS',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBELEMGEOGLOCA,'ELEM_GEOG_LOCA',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBELEMNEIGHBORTHOOD,'ELEM_NEIGHBORTHOOD',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBCOUNTPRODBYELEM,'QUANTITY_PROD_ELEM',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBDAMAGEELEMENTSTATUS,'DAMAGE_ELEME_STATUS',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (':parent_id','parent_id',IOSBATTRIBUTES);
        
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FILLDAMAGEELEMATTRIB;


    






















    PROCEDURE FILLDAMAGEPRODATTRIB
    (
        IOSBATTRIBUTES IN OUT VARCHAR2
    )
    IS
        SBDAMAGEPRODADDRESS            GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        SBDAMAGEPRODGEOGLOCA           GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        SBDAMAGEPRODNEIG               GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        SBDAMAGEPRODTYPE               GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        SBSUBSCRIBERTYPE               GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        SBSUBSCRIBERNAME               GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        SBDAMAGEPRODSTAT               GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        SBDAMAGEPRODSTATUS             GE_BOUTILITIES.STYSTATEMENT;
        SBCOMPENSATEDTIME              GE_BOUTILITIES.STYSTATEMENTATTRIBUTE; 
    BEGIN
        
        SBDAMAGEPRODADDRESS:='TT_BCBasicDataServices.fsbGetAddressProd(tt_damage_product.damages_product_id)';
        SBDAMAGEPRODGEOGLOCA:='TT_BCBasicDataServices.fsbGetGeogLocaProdDesc(tt_damage_product.damages_product_id)';
        SBDAMAGEPRODNEIG:='TT_BCBasicDataServices.fsbGetNeigProdDesc(tt_damage_product.damages_product_id)';
        SBDAMAGEPRODTYPE:='pr_product.product_type_id'||GE_BOUTILITIES.CSBSEPARATOR|| 'cc_boOssDescription.fsbProductType (pr_product.product_type_id)';
        SBDAMAGEPRODSTAT:='pr_product.product_status_id'||GE_BOUTILITIES.CSBSEPARATOR||'cc_boOssDescription.fsbProductStatus(pr_product.product_status_id)';
        SBSUBSCRIBERTYPE:='TT_BCBasicDataServices.fsbProdSubscriberTyp(tt_damage_product.damages_product_id)';
        SBSUBSCRIBERNAME:= 'TT_BCBasicDataServices.fsbDamageProdSubscrib(tt_damage_product.damages_product_id)';
        SBDAMAGEPRODSTATUS := 'tt_damage_product.damage_produ_status'||GE_BOUTILITIES.CSBSEPARATOR ||'decode(tt_damage_product.damage_produ_status,
                                 ''A'', ''Abierto'',
                                 ''C'', ''Cerrado'',
                                 ''I'', ''Infundado'',
                                 ''N'', ''No Procesado'',
                                 null)';


        SBCOMPENSATEDTIME := '(SELECT /*+ leading(pr_component) '||
                                     'use_nl(pr_component pr_timeout_component) '||
                                     'index(pr_timeout_component IDX_PR_TIMEOUT_COMPONENT_03) '||
                                     'index(pr_component IDX_PR_TIMEOUT_COMPONENT_03 IDX_PR_COMPONENT_2) */ '||
                                     'ut_date.fsbFormatTime(pr_timeout_component.compensated_time*60) '||
                              'FROM pr_component, '||
                                   'pr_timeout_component '||
                              'WHERE pr_component.product_id = tt_damage_product.product_id '||
                                'AND pr_component.component_id = pr_timeout_component.component_id '||
                                'AND pr_timeout_component.package_id = tt_damage_product.package_id '||
                                'AND rownum = 1)';

        GE_BOUTILITIES.ADDATTRIBUTE ('tt_damage_product.damages_product_id','DAMAGES_PRODUCT_ID',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE ('tt_damage_product.product_id','PRODUCT_ID',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBDAMAGEPRODTYPE,'PRODUCT_TYPE_ID',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE ('pr_product.service_number','SERVICE_NUMBER',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBDAMAGEPRODSTAT,'PRODUCT_STATUS',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBDAMAGEPRODADDRESS,'PRODUCT_ADDRESS',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBDAMAGEPRODGEOGLOCA,'PRODUCT_GEOG_LOCA',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBDAMAGEPRODNEIG,'PRODUCT_NEIGHBORTHOOD',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBSUBSCRIBERTYPE,'SUBSCRIBER_TYPE',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBSUBSCRIBERNAME,'SUBSCRIBER_NAME',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBDAMAGEPRODSTATUS,'DAMAGE_PRODU_STATUS',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBCOMPENSATEDTIME,'COMPENSATED_TIME',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (':parent_id','PARENT_ID',IOSBATTRIBUTES);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FILLDAMAGEPRODATTRIB;


    








































































    PROCEDURE FILLDAMAGEWHERE
    (
        INUPACKAGEID          IN TT_DAMAGE.PACKAGE_ID%TYPE,
        INUDAMAGETYPEID       IN TT_DAMAGE_TYPE.DAMAGE_TYPE_ID%TYPE,
        INUPACKSTATUSID       IN PS_MOTIVE_STATUS.MOTIVE_STATUS_ID%TYPE,
        ISBDAMAGESTATUSTYPEID IN PS_MOTIVE_STATUS.IS_FINAL_STATUS%TYPE,
        INUORDERID            IN OR_ORDER.ORDER_ID%TYPE,
        IDTINITIALREQDATE     IN OUT MO_PACKAGES.REQUEST_DATE%TYPE,
        IDTFINALREQDATE       IN OUT MO_PACKAGES.REQUEST_DATE%TYPE,
        INUADDRESSID          IN MO_ADDRESS.PARSER_ADDRESS_ID%TYPE,
        INUBASEADMINISTRA     IN GE_BASE_ADMINISTRA.ID_BASE_ADMINISTRA%TYPE,
        INUOPERATINGZONE      IN OR_OPERATING_ZONE.OPERATING_ZONE_ID%TYPE,
        INUOPERSECTORID       IN OR_OPERATING_SECTOR.OPERATING_SECTOR_ID%TYPE,
        OSBDAMAGEFROM         IN OUT VARCHAR2,
        OSBDAMAGEWHERE        IN OUT VARCHAR2,
        OSBADDITIONAL         IN OUT VARCHAR2
    )
    IS
      NUADDRESSID        AB_ADDRESS.ADDRESS_ID%TYPE:=CC_BOCONSTANTS.CNUAPPLICATIONNULL;
      SBUSECOMODINES     VARCHAR2(10):= GE_BOCONSTANTS.GETYES;
      NUPERSONID         GE_PERSON.PERSON_ID%TYPE;
      NUERROR            GE_ERROR_LOG.ERROR_LOG_ID%TYPE;
      SBERRORS           GE_ERROR_LOG.DESCRIPTION%TYPE;
      TBOPERATINGUNIT    DAOR_OPER_UNIT_PERSONS.TYTBOR_OPER_UNIT_PERSONS;
      
      SBDAMAGESTATUS     GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
    BEGIN
        
        IF (IDTINITIALREQDATE IS NOT NULL OR IDTFINALREQDATE  IS NOT NULL) THEN
            CC_BOBOSSUTIL.QUERYTYPEDATES (CC_BOBOSSUTIL.FNUQUERYBYBETWEEN, NULL, IDTINITIALREQDATE, IDTFINALREQDATE);
        END IF;


        IF (INUADDRESSID IS NOT NULL) THEN
            OSBDAMAGEFROM  := OSBDAMAGEFROM  || CHR(10)||
                '    mo_address,';
            OSBDAMAGEWHERE := OSBDAMAGEWHERE ||CHR(10)||
                ' AND mo_address.package_id = mo_packages.package_id ' ||CHR(10)||
                ' AND mo_address.parser_address_id = '||INUADDRESSID||CHR(10);
        END IF;


        
        IF INUPACKAGEID IS NOT NULL THEN
            OSBDAMAGEWHERE := OSBDAMAGEWHERE ||CHR(10)||
                '    AND mo_packages.package_id = '||INUPACKAGEID;
        END IF;

        
        IF INUORDERID IS NOT NULL THEN
            OSBDAMAGEFROM  := OSBDAMAGEFROM  || CHR(10)||
                '    or_order_activity,';
            OSBDAMAGEWHERE := OSBDAMAGEWHERE || CHR(10)||
                '    AND or_order_activity.package_id = tt_damage.package_id'||CHR(10)||
                '    AND or_order_activity.order_id = '||INUORDERID;
        END IF;

        
        OSBDAMAGEWHERE := OSBDAMAGEWHERE ||' AND mo_packages.package_type_id = '||TT_BOCONSTANTS.CNUMASSDAMAGE;

        
        IF INUOPERSECTORID IS NOT NULL THEN
            IF INUDAMAGETYPEID IS NOT NULL THEN
                OSBDAMAGEWHERE := OSBDAMAGEWHERE ||CHR(10)||
                '    AND tt_damage.operating_sector_id+0 = '||INUOPERSECTORID;
            ELSE
                OSBDAMAGEWHERE := OSBDAMAGEWHERE ||CHR(10)||
                '    AND tt_damage.operating_sector_id = '||INUOPERSECTORID;
            END IF;
        END IF;
        
        IF (INUPACKSTATUSID IS NOT NULL) THEN
            OSBDAMAGEWHERE := OSBDAMAGEWHERE ||CHR(10)||
                '    AND mo_packages.motive_status_id = '||INUPACKSTATUSID;
        
        ELSIF (ISBDAMAGESTATUSTYPEID IS NOT NULL) THEN
            IF (ISBDAMAGESTATUSTYPEID = TT_BCCONSTANTS.CSBSTATUS_FINISHED) THEN
                SBDAMAGESTATUS := GE_BCCONSTANTS.CSBYES;
            ELSE
                SBDAMAGESTATUS := GE_BCCONSTANTS.CSBNO;
            END IF;

            OSBDAMAGEFROM  := OSBDAMAGEFROM  || CHR(10)||
                '    ps_motive_status,';
            OSBDAMAGEWHERE := OSBDAMAGEWHERE ||CHR(10)||
                      '    AND ps_motive_status.motive_status_id in ('||
                      TT_BOCONSTANTS.CNUTTREGISTERSTATUS||','||TT_BOCONSTANTS.CNUTTATTENSTATUS||','||
                      TT_BOCONSTANTS.CNUTTUNFOUNDEDSTATUS||','||TT_BOCONSTANTS.CNUTTDIAGORDERSTATUS||','||
                      TT_BOCONSTANTS.CNUTTDIAGREAPAIRORDERSTATUS||','||TT_BOCONSTANTS.CNUTTREPAIRORDERSTATUS||')'||
                      '    AND ps_motive_status.is_final_status = '''||SBDAMAGESTATUS||''''||CHR(10)||
                      '    AND ps_motive_status.motive_status_id = mo_packages.motive_status_id '||CHR(10);
        END IF;
        
        
        IF INUDAMAGETYPEID IS NOT NULL THEN
            OSBDAMAGEWHERE := OSBDAMAGEWHERE ||CHR(10)||
                '    AND '||INUDAMAGETYPEID||' IN (tt_damage.reg_damage_type_id,tt_damage.final_damage_type_id)';
        END IF;
        
        IF IDTINITIALREQDATE IS NOT NULL THEN
            OSBDAMAGEWHERE := OSBDAMAGEWHERE ||CHR(10)||
                '    AND mo_packages.request_date >= :dtInitialReqDate';
        END IF;
        
        IF IDTFINALREQDATE IS NOT NULL THEN
            OSBDAMAGEWHERE := OSBDAMAGEWHERE ||CHR(10)||
                '    AND mo_packages.request_date <= :dtFinalReqDate';
        END IF;

        IF (INUOPERSECTORID IS NULL) THEN
            
            IF (INUBASEADMINISTRA IS NOT NULL) THEN
                
                IF (INUOPERATINGZONE IS NULL) THEN
                    GE_BOERRORS.SETERRORCODEARGUMENT(901281,INUBASEADMINISTRA||'-'||DAGE_BASE_ADMINISTRA.FSBGETDESCRIPCION(INUBASEADMINISTRA));
                END IF;

                OSBDAMAGEFROM  := OSBDAMAGEFROM||' ge_sectorope_zona,or_zona_base_adm, ';
                OSBDAMAGEWHERE := OSBDAMAGEWHERE || CHR(10)||
                    '    AND ge_sectorope_zona.id_sector_operativo = tt_damage.operating_sector_id
                         AND or_zona_base_adm.operating_zone_id+0 = ge_sectorope_zona.id_zona_operativa
                         AND or_zona_base_adm.id_base_administra = '||INUBASEADMINISTRA||'
                         AND ge_sectorope_zona.id_zona_operativa = '||INUOPERATINGZONE;
            END IF;
        END IF;

        NUPERSONID := GE_BOPERSONAL.FNUGETPERSONID;
        
         
        IF ( DAGE_PERSON.FNUGETPERSONAL_TYPE(NUPERSONID) != OR_BCSCHED.GNUSUPERVISORPERSONAL
            
             AND NOT OR_BCOPERUNITPERSON.FBLISDISPATCHPERSON(NUPERSONID)
            
            AND OR_BOOPERUNITPERSON.FBLEXISTUNIOPERBYPERS(NUPERSONID)
             ) THEN
             
                  OSBDAMAGEWHERE := OSBDAMAGEWHERE || CHR(10)||
                    ' AND EXISTS ( '||CHR(10)||
                    '  SELECT  /*+ '||CHR(10)||
                    '             ordered '||CHR(10)||
                    '             use_nl(OR_OPER_UNIT_PERSONS) '||CHR(10)||
                    '             use_nl(OR_OPERATING_UNIT) '||CHR(10)||
                    '             use_nl(TT_DAMAGE) '||CHR(10)||
                    '             use_nl(OR_ORDER_ACTIVITY) '||CHR(10)||
                    '         */ '||CHR(10)||
                    '         null '||CHR(10)||
                    ' FROM    or_oper_unit_persons, '||CHR(10)||
                    '         or_operating_unit, '||CHR(10)||
                    '         or_order_activity, '||CHR(10)||
                    '          or_ope_uni_task_type '||CHR(10)||
                    ' WHERE   or_oper_unit_persons.person_id = '||NUPERSONID||' '||CHR(10)||
                    ' AND     or_operating_unit.operating_unit_id = or_oper_unit_persons.operating_unit_id '||CHR(10)||
                    ' AND     ( '||CHR(10)||
                    '              tt_damage.operating_sector_id IS NULL OR '||CHR(10)||
                    '              EXISTS ( '||CHR(10)||
                    '                  SELECT  /*+ '||CHR(10)||
                    '                             ordered '||CHR(10)||
                    '                             use_nl(or_zona_base_adm) '||CHR(10)||
                    '                             use_nl(ge_sectorope_zona) '||CHR(10)||
                    '                          */ '||CHR(10)||
                    '                          null '||CHR(10)||
                    '                 FROM    or_zona_base_adm, '||CHR(10)||
                    '                         ge_sectorope_zona '||CHR(10)||
                    '                 WHERE   ge_sectorope_zona.id_sector_operativo = tt_damage.operating_sector_id '||CHR(10)||
                    '                 AND     or_zona_base_adm.id_base_administra = or_operating_unit.admin_base_id '||CHR(10)||
                    '                 AND     ge_sectorope_zona.id_zona_operativa = or_zona_base_adm.operating_zone_id '||CHR(10)||
                    '             ) '||CHR(10)||
                    '         ) '||CHR(10)||
                    ' AND     or_order_activity.package_id = tt_damage.package_id '||CHR(10)||
                    ' AND     or_ope_uni_task_type.task_type_id = or_order_activity.task_type_id '||CHR(10)||
                    ' AND     or_ope_uni_task_type.operating_unit_id = or_operating_unit.operating_unit_id '||CHR(10)||
                    ' ) ';
        END IF;
        
        IF ( INUPACKAGEID IS NOT NULL ) THEN
            
            OSBADDITIONAL  := OSBADDITIONAL || ' LEADING(MO_PACKAGES TT_DAMAGE)'||CHR(10);
            OSBADDITIONAL  := OSBADDITIONAL || ' INDEX (MO_PACKAGES PK_MO_PACKAGES)'||CHR(10);
            OSBADDITIONAL  := OSBADDITIONAL || ' INDEX (TT_DAMAGE PK_TT_DAMAGE)'||CHR(10);
        ELSIF ( INUORDERID IS NOT NULL ) THEN
            
            OSBADDITIONAL  := OSBADDITIONAL || ' USE_NL(OR_ORDER_ACTIVITY TT_DAMAGE)';
        ELSIF ( INUADDRESSID IS NOT NULL ) THEN
            
            OSBADDITIONAL  := OSBADDITIONAL || ' LEADING(MO_ADDRESS MO_PACKAGES TT_DAMAGE)'||CHR(10);
            OSBADDITIONAL  := OSBADDITIONAL || ' INDEX (MO_ADDRESS IDX_MO_ADDRESS_1)'||CHR(10);
            OSBADDITIONAL  := OSBADDITIONAL || ' INDEX (MO_PACKAGES PK_MO_PACKAGES)'||CHR(10);
            OSBADDITIONAL  := OSBADDITIONAL || ' INDEX (TT_DAMAGE PK_TT_DAMAGE)'||CHR(10);
        ELSIF ( INUOPERSECTORID IS NOT NULL AND INUDAMAGETYPEID IS NULL) THEN
            
            OSBADDITIONAL  := OSBADDITIONAL || ' LEADING(TT_DAMAGE MO_PACKAGES)'||CHR(10);
            OSBADDITIONAL  := OSBADDITIONAL || ' INDEX (TT_DAMAGE IDX_TT_DAMAGE_01)'||CHR(10);
            OSBADDITIONAL  := OSBADDITIONAL || ' INDEX (MO_PACKAGES PK_MO_PACKAGES)'||CHR(10);
        ELSIF ( INUPACKSTATUSID IS NOT NULL OR ISBDAMAGESTATUSTYPEID IS NOT NULL  ) THEN
            
            OSBADDITIONAL  := OSBADDITIONAL || ' LEADING(MO_PACKAGES TT_DAMAGE)'||CHR(10);
            OSBADDITIONAL  := OSBADDITIONAL || ' INDEX (MO_PACKAGES IDX_MO_PACKAGES_024)'||CHR(10);
            OSBADDITIONAL  := OSBADDITIONAL || ' INDEX (TT_DAMAGE PK_TT_DAMAGE)'||CHR(10);
        ELSIF (INUOPERSECTORID IS NULL AND INUBASEADMINISTRA IS NOT NULL) THEN
            OSBADDITIONAL  := OSBADDITIONAL || ' USE_NL(GE_SECTOROPE_ZONA)'||CHR(10);
            OSBADDITIONAL  := OSBADDITIONAL || ' USE_NL(OR_ZONA_BASE_ADM)'||CHR(10);
            OSBADDITIONAL  := OSBADDITIONAL || ' USE_NL(TT_DAMAGE)'||CHR(10);
            OSBADDITIONAL  := OSBADDITIONAL || ' USE_NL_WITH_INDEX(TT_DAMAGE IDX_TT_DAMAGE_01)'||CHR(10);
            OSBADDITIONAL  := OSBADDITIONAL || ' INDEX(OR_ZONA_BASE_ADM IDX_OR_ZONA_BASE_ADM_01)'||CHR(10);
            OSBADDITIONAL  := OSBADDITIONAL || ' INDEX(GE_SECTOROPE_ZONA IDX_GE_SECTOROPE_ZONA_01)'||CHR(10);
            OSBADDITIONAL  := OSBADDITIONAL || ' LEADING(GE_SECTOROPE_ZONA, OR_ZONA_BASE_ADM, TT_DAMAGE, MO_PACKAGES )'||CHR(10);
        ELSE
            
            OSBADDITIONAL  := OSBADDITIONAL || ' LEADING(MO_PACKAGES TT_DAMAGE)'||CHR(10);
            OSBADDITIONAL  := OSBADDITIONAL || ' INDEX (MO_PACKAGES IDX_MO_PACKAGES_01)'||CHR(10);
            OSBADDITIONAL  := OSBADDITIONAL || ' INDEX (TT_DAMAGE PK_TT_DAMAGE)'||CHR(10);
        END IF;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FILLDAMAGEWHERE;


    
















    PROCEDURE GETDAMAGEELEMENT
    (
        INUDAMAGEELEMID     IN  TT_DAMAGE_ELEMENT.DAMAGE_ELEMENT_ID%TYPE,
        OCUDATACURSOR       OUT CONSTANTS.TYREFCURSOR
    )
    IS
      SBSQL                          VARCHAR2(8000);
      SBDAMAGEELEMFROM               GE_BOUTILITIES.STYSTATEMENT;
      SBDAMAGEELEMWHERE              GE_BOUTILITIES.STYSTATEMENT;
      SBDAMAGEELEMATTRIBUTES         GE_BOUTILITIES.STYSTATEMENT;
    BEGIN

        FILLDAMAGEELEMATTRIB(SBDAMAGEELEMATTRIBUTES);

        SBDAMAGEELEMFROM := ' tt_damage_element ';
        SBDAMAGEELEMWHERE := ' tt_damage_element.damage_element_id= :inuDamageElemId'||CHR(10);

        SBSQL := 'SELECT '|| SBDAMAGEELEMATTRIBUTES ||CHR(10)||
                  ' FROM '|| SBDAMAGEELEMFROM ||CHR(10)||
                  ' /*+ Ubicaci�n: TT_boSearchDataServices.GetDamageElement */ '||CHR(10)||
                 ' WHERE '|| SBDAMAGEELEMWHERE;

        OPEN OCUDATACURSOR FOR SBSQL USING CC_BOBOSSUTIL.CNUNULL,INUDAMAGEELEMID;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    





















    PROCEDURE GETDAMAGEELEMBYDAMAG
    (
        INUPACKAGEID    IN  TT_DAMAGE.PACKAGE_ID%TYPE,
        OCUDATACURSOR   OUT CONSTANTS.TYREFCURSOR
    )
    IS
      SBSQL                     GE_BOUTILITIES.STYSTATEMENT;
      SBDAMAGEELEMFROM               GE_BOUTILITIES.STYSTATEMENT;
      SBDAMAGEELEMWHERE              GE_BOUTILITIES.STYSTATEMENT;
      SBDAMAGEELEMATTRIBUTES         GE_BOUTILITIES.STYSTATEMENT;
    BEGIN

        FILLDAMAGEELEMATTRIB(SBDAMAGEELEMATTRIBUTES);

        SBDAMAGEELEMFROM := ' tt_damage_element ';
        SBDAMAGEELEMWHERE := ' tt_damage_element.package_id = :inuPackageId'||CHR(10);

        SBSQL := 'SELECT '|| SBDAMAGEELEMATTRIBUTES ||CHR(10)||
                  ' FROM '|| SBDAMAGEELEMFROM ||CHR(10)||
                  '/*+  Ubicaci�n: TT_boSearchDataServices.GetDamageElemByDamag */ '||CHR(10)||
                 ' WHERE '|| SBDAMAGEELEMWHERE;
                 
        UT_TRACE.TRACE('SQL:['||SBSQL||']',1);

        OPEN OCUDATACURSOR FOR SBSQL USING INUPACKAGEID,INUPACKAGEID;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETDAMAGEELEMBYDAMAG;


    























    PROCEDURE GETDAMAGEPRODUCT
    (
        INUDAMAGEPRODUCTID  IN  TT_DAMAGE_PRODUCT.DAMAGES_PRODUCT_ID%TYPE,
        OCUDATACURSOR       OUT CONSTANTS.TYREFCURSOR
    )
    IS
      SBSQL                          GE_BOUTILITIES.STYSTATEMENT;
      SBDAMAGEPRODFROM               GE_BOUTILITIES.STYSTATEMENT;
      SBDAMAGEPRODWHERE              GE_BOUTILITIES.STYSTATEMENT;
      SBDAMAGEPRODATTRIBUTES         GE_BOUTILITIES.STYSTATEMENT;
    BEGIN

        FILLDAMAGEPRODATTRIB(SBDAMAGEPRODATTRIBUTES);
        SBDAMAGEPRODFROM := ' tt_damage_product, pr_product';
        SBDAMAGEPRODWHERE := ' tt_damage_product.damages_product_id = :inuDamageProductId'||CHR(10)||
                             ' AND tt_damage_product.product_id= pr_product.product_id';

        SBSQL := 'SELECT '|| SBDAMAGEPRODATTRIBUTES ||CHR(10)||
                  ' FROM '|| SBDAMAGEPRODFROM ||CHR(10)||
                  ' /*+ Ubicaci�n: TT_boSearchDataServices.GetDamageProduct */ '||CHR(10)||
                 ' WHERE '|| SBDAMAGEPRODWHERE;

        OPEN OCUDATACURSOR FOR SBSQL USING CC_BOBOSSUTIL.CNUNULL,INUDAMAGEPRODUCTID;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    





















    PROCEDURE GETDAMAGPRODBYDAMAG
    (
        INUPACKAGEID    IN  TT_DAMAGE.PACKAGE_ID%TYPE,
        OCUDATACURSOR   OUT CONSTANTS.TYREFCURSOR
    )
    IS
        SBSQL                   GE_BOUTILITIES.STYSTATEMENT;
        SBDAMAGEPRODFROM        GE_BOUTILITIES.STYSTATEMENT;
        SBDAMAGEPRODWHERE       GE_BOUTILITIES.STYSTATEMENT;
        SBDAMAGEPRODATTRIBUTES  GE_BOUTILITIES.STYSTATEMENT;
    BEGIN

        FILLDAMAGEPRODATTRIB(SBDAMAGEPRODATTRIBUTES);

        SBDAMAGEPRODFROM  := ' tt_damage_product, pr_product ';
        SBDAMAGEPRODWHERE := ' tt_damage_product.package_id = :inuPackageId'||CHR(10)||
                             ' AND tt_damage_product.product_id = pr_product.product_id';

        SBSQL := 'SELECT '|| SBDAMAGEPRODATTRIBUTES||CHR(10)||
                  ' FROM '|| SBDAMAGEPRODFROM ||CHR(10)||
                  ' /*+ Ubicaci�n: TT_boSearchDataServices.GetDamagProdByDamag */ '||CHR(10)||
                 ' WHERE '|| SBDAMAGEPRODWHERE;
                 
        UT_TRACE.TRACE('SQL:['||SBSQL||']',1);

        OPEN OCUDATACURSOR FOR SBSQL USING INUPACKAGEID,INUPACKAGEID;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETDAMAGPRODBYDAMAG;


    PROCEDURE FILLCOMMENTATTRIBUTES
    (
        IOSBATTRIBUTES IN OUT VARCHAR2
    )
    IS
        SBCOMMENTTYPE           GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        SBMOCOMMENTID           GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        SBPERSONID              GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        SBORGANIZATAREAID       GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;

    BEGIN
        
        SBCOMMENTTYPE:='MO_COMMENT.comment_type_id'||GE_BOUTILITIES.CSBSEPARATOR|| 'ge_bobasicdataservices.fsbGetDescCommentType(MO_COMMENT.comment_type_id)';
        SBMOCOMMENTID:= 'MO_COMMENT.COMMENT_ID'||GE_BOUTILITIES.CSBSEPARATOR||'''MO_COMMENT''';
        SBPERSONID := 'MO_COMMENT.Person_id'||GE_BOUTILITIES.CSBSEPARATOR|| '(select name_ FROM ge_person WHERE ge_person.person_id = MO_COMMENT.Person_id)';
        SBORGANIZATAREAID := 'MO_COMMENT.ORGANIZAT_AREA_ID'||GE_BOUTILITIES.CSBSEPARATOR|| '(select name_ FROM ge_organizat_area WHERE organizat_area_id = MO_COMMENT.ORGANIZAT_AREA_ID)';
        
        GE_BOUTILITIES.ADDATTRIBUTE (SBMOCOMMENTID,             'COMMENT_ID',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE ('MO_COMMENT.register_date','REGISTER_DATE',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBCOMMENTTYPE,             'COMMENT_TYPE',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE ('MO_COMMENT.comment_',     'comment_',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE ('null',                    'ORDER_ID',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE ('null',                    'TASK_TYPE_ID',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBPERSONID,                'PERSON_ID',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBORGANIZATAREAID,         'ORGANIZAT_AREA_ID',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE ('MO_COMMENT.PACKAGE_ID',   'PACKAGE_ID',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (':parent_id',              'parent_id',IOSBATTRIBUTES);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FILLCOMMENTATTRIBUTES;

    
    PROCEDURE FILLORDERCOMMENTATTRIBUTES
    (
        IOSBORDERCOMMATTRIBUTES IN OUT VARCHAR2
    )
    IS
        SBORDERCOMMENTTYPE           GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        SBTASKTYPE                   GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        SBORORDERCOMMENTID           GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        SBPERSONID                   GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        SBORGANIZATAREAID            GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
    BEGIN
        
        SBORDERCOMMENTTYPE := 'OR_ORDER_COMMENT.comment_type_id'||GE_BOUTILITIES.CSBSEPARATOR||'ge_bobasicdataservices.fsbGetDescCommentType(OR_ORDER_COMMENT.comment_type_id)';
        SBTASKTYPE         := 'OR_ORDER_ACTIVITY.task_type_id'||GE_BOUTILITIES.CSBSEPARATOR||'daor_task_type.fsbGetDescription(OR_ORDER_ACTIVITY.task_type_id)';
        SBORORDERCOMMENTID := 'OR_ORDER_COMMENT.order_comment_id'||GE_BOUTILITIES.CSBSEPARATOR||'''OR_ORDER_COMMENT''';
        SBPERSONID := 'OR_ORDER_COMMENT.Person_id'||GE_BOUTILITIES.CSBSEPARATOR||'(select name_ FROM ge_person WHERE ge_person.person_id = OR_ORDER_COMMENT.Person_id)';
        SBORGANIZATAREAID := '(SELECT ge_organizat_area.organizat_area_id'||GE_BOUTILITIES.CSBSEPARATOR||'ge_organizat_area.name_ '||
                             'FROM ge_organizat_area, ge_person '||
                             'WHERE ge_person.person_id = OR_ORDER_COMMENT.Person_id '||
                             'AND ge_organizat_area.organizat_area_id = ge_person.organizat_area_id) ';
        
        GE_BOUTILITIES.ADDATTRIBUTE (SBORORDERCOMMENTID,                'ORDER_COMMENT_ID',IOSBORDERCOMMATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE ('OR_ORDER_COMMENT.register_date',  'REGISTER_DATE',IOSBORDERCOMMATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBORDERCOMMENTTYPE,                'COMMENT_TYPE',IOSBORDERCOMMATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE ('OR_ORDER_COMMENT.order_comment',  'ORDER_COMMENT',IOSBORDERCOMMATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE ('OR_ORDER_ACTIVITY.order_id',      'ORDER_ID',IOSBORDERCOMMATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBTASKTYPE,                        'TASK_TYPE_ID',IOSBORDERCOMMATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBPERSONID,                        'PERSON_ID',IOSBORDERCOMMATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBORGANIZATAREAID,                 'ORGANIZAT_AREA_ID',IOSBORDERCOMMATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE ('OR_ORDER_ACTIVITY.package_id',    'PACKAGE_ID',IOSBORDERCOMMATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (':parent_id',                      'parent_id',IOSBORDERCOMMATTRIBUTES);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FILLORDERCOMMENTATTRIBUTES;


    
    PROCEDURE FILLCOMMBYACTIVITYATTRIB
    (
        IOSBCOMMENTBYACTIVITYATTRIB IN OUT VARCHAR2
    )
    IS
      SBCOMMENTTYPE         GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
      SBTASKTYPE            GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
      SBORORDERACTIVITYID   GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
      SBREGISTERDATE        VARCHAR2(200);
    BEGIN

      
      
      SBCOMMENTTYPE      := ' ''30'' '||GE_BOUTILITIES.CSBSEPARATOR ||'Ge_boBasicDataServices.fsbGetDescCommentType(30)';
      SBTASKTYPE         := 'OR_ORDER_ACTIVITY.task_type_id'||GE_BOUTILITIES.CSBSEPARATOR||'daor_task_type.fsbGetDescription(OR_ORDER_ACTIVITY.task_type_id)';
      SBORORDERACTIVITYID:= 'OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID'||GE_BOUTILITIES.CSBSEPARATOR||'''OR_ORDER_ACTIVITY''';
      SBREGISTERDATE     := 'OR_boBasicDataServices.fdtGetOrderCreateDate(OR_ORDER_ACTIVITY.ORDER_ID)';

      
      GE_BOUTILITIES.ADDATTRIBUTE (SBORORDERACTIVITYID,             'ORDER_COMMENT_ID',IOSBCOMMENTBYACTIVITYATTRIB);
      GE_BOUTILITIES.ADDATTRIBUTE (SBREGISTERDATE,                  'REGISTER_DATE',IOSBCOMMENTBYACTIVITYATTRIB);
      GE_BOUTILITIES.ADDATTRIBUTE (SBCOMMENTTYPE,                   'COMMENT_TYPE',IOSBCOMMENTBYACTIVITYATTRIB);
      GE_BOUTILITIES.ADDATTRIBUTE ('OR_ORDER_ACTIVITY.COMMENT_',    'COMMENT_',IOSBCOMMENTBYACTIVITYATTRIB);
      GE_BOUTILITIES.ADDATTRIBUTE ('OR_ORDER_ACTIVITY.order_id',    'ORDER_ID',IOSBCOMMENTBYACTIVITYATTRIB);
      GE_BOUTILITIES.ADDATTRIBUTE (SBTASKTYPE,                      'TASK_TYPE_ID',IOSBCOMMENTBYACTIVITYATTRIB);
      GE_BOUTILITIES.ADDATTRIBUTE ('null',                          'PERSON_ID',IOSBCOMMENTBYACTIVITYATTRIB);
      GE_BOUTILITIES.ADDATTRIBUTE ('null',                          'ORGANIZAT_AREA_ID',IOSBCOMMENTBYACTIVITYATTRIB);
      GE_BOUTILITIES.ADDATTRIBUTE ('OR_ORDER_ACTIVITY.package_id',  'PACKAGE_ID',IOSBCOMMENTBYACTIVITYATTRIB);
      GE_BOUTILITIES.ADDATTRIBUTE (':parent_id',                    'parent_id',IOSBCOMMENTBYACTIVITYATTRIB);

    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
          RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
          ERRORS.SETERROR;
          RAISE EX.CONTROLLED_ERROR;
    END FILLCOMMBYACTIVITYATTRIB;


    




























    PROCEDURE GETCOMMENTBYDAMAGID
    (
        INUPACKAGEID    IN  TT_DAMAGE.PACKAGE_ID%TYPE,
        OCUDATACURSOR   OUT CONSTANTS.TYREFCURSOR
    )
    IS
        SBSQL                          GE_BOUTILITIES.STYSTATEMENT;
        SBCOMMENTATTRIBUTES            GE_BOUTILITIES.STYSTATEMENT;
        SBORDERCOMMENTATTRIBUTES       GE_BOUTILITIES.STYSTATEMENT;
        SBCOMMENTBYACTIVITYATTRIBUTES  GE_BOUTILITIES.STYSTATEMENT;
    BEGIN

        FILLCOMMENTATTRIBUTES(SBCOMMENTATTRIBUTES);
        FILLORDERCOMMENTATTRIBUTES(SBORDERCOMMENTATTRIBUTES);
        FILLCOMMBYACTIVITYATTRIB(SBCOMMENTBYACTIVITYATTRIBUTES);

        SBSQL := '(SELECT '|| SBCOMMENTATTRIBUTES ||CHR(10)||
                  ' FROM mo_Comment '||CHR(10)||
                  ' /*+ Ubicaci�n: TT_boSearchDataServices.GetCommentByDamagId */ '||CHR(10)||
                 ' WHERE mo_Comment.package_id = :PACKAGE_id)'||CHR(10)||
                 ' UNION '||CHR(10)||
                 ' (SELECT '||SBORDERCOMMENTATTRIBUTES||CHR(10)||
                  ' FROM or_order_comment, or_order_activity'||CHR(10)||
                 ' WHERE or_order_comment.order_id = or_order_activity.order_id'||CHR(10)||
                 ' AND or_order_activity.package_id = :PACKAGE_Id)'||CHR(10)||
                 ' UNION '||CHR(10)||
                 ' (SELECT '||SBCOMMENTBYACTIVITYATTRIBUTES||CHR(10)||
                  ' FROM or_order_activity'||CHR(10)||
                 ' WHERE or_order_activity.comment_ IS not null '||CHR(10)||
                 ' AND or_order_activity.package_id = :PACKAGE_Id)';


        OPEN OCUDATACURSOR FOR SBSQL USING INUPACKAGEID,INUPACKAGEID,INUPACKAGEID,INUPACKAGEID,INUPACKAGEID,INUPACKAGEID;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETCOMMENTBYDAMAGID;


    

























    PROCEDURE GETDAMAGEBYELEMENTID
    (
        INUELEMENTID        IN TT_DAMAGE_ELEMENT.ELEMENT_ID%TYPE,
        OCUDATACURSOR       OUT CONSTANTS.TYREFCURSOR
    )
    IS
      SBSQL              GE_BOUTILITIES.STYSTATEMENT;
      SBDAMAGEWHERE      GE_BOUTILITIES.STYSTATEMENT;
      SBDAMAGEATTRIBUTES GE_BOUTILITIES.STYSTATEMENT;

    BEGIN

        FILLELEMENTDAMAGEATTRIBUTES(SBDAMAGEATTRIBUTES);

        SBDAMAGEWHERE :=' mo_packages.package_id= tt_damage.package_id '||CHR(10)||
                        ' and  tt_damage.package_id = tt_damage_element.package_id '||CHR(10)||
                        ' and  tt_damage_element.element_id = :inuElementId '||CHR(10)||
                        ' AND  tt_damage_element.damage_eleme_status in ('
                        ||CHR(39)||'A'||CHR(39)||','||CHR(39)||'C'||CHR(39)||')';

        SBSQL := 'SELECT distinct '|| SBDAMAGEATTRIBUTES ||CHR(10)||
                  ' FROM  tt_damage, mo_packages, tt_damage_element '||CHR(10)||
                 ' WHERE '|| SBDAMAGEWHERE;
                 
        TT_BCBASICDATASERVICES.CLEARDAMDATACACHE;

        OPEN OCUDATACURSOR FOR SBSQL USING INUELEMENTID,INUELEMENTID;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETDAMAGEBYELEMENTID;

    PROCEDURE GETDAMAGECOMMENT
        (
        ISBCOMMENTID    IN  VARCHAR2,
        OCUDATACURSOR   OUT CONSTANTS.TYREFCURSOR
        )

    IS
        SBSQL                          GE_BOUTILITIES.STYSTATEMENT;
        SBCOMMENTATTRIBUTES            GE_BOUTILITIES.STYSTATEMENT;
        SBORDERCOMMENTATTRIBUTES       GE_BOUTILITIES.STYSTATEMENT;
        SBCOMMENTBYACTIVITYATTRIBUTES  GE_BOUTILITIES.STYSTATEMENT;
        NUCOMMENTID                    NUMBER;
    BEGIN

        FILLCOMMENTATTRIBUTES(SBCOMMENTATTRIBUTES);
        FILLORDERCOMMENTATTRIBUTES(SBORDERCOMMENTATTRIBUTES);
        FILLCOMMBYACTIVITYATTRIB(SBCOMMENTBYACTIVITYATTRIBUTES);

        IF (ISBCOMMENTID IS NOT NULL) THEN
            NUCOMMENTID := TO_NUMBER(UT_STRING.EXTSTRFIELD(ISBCOMMENTID, GE_BOCONSTANTS.CSBSEPARADOR, 1));
        END IF;

        SBSQL := '(SELECT '|| SBCOMMENTATTRIBUTES ||CHR(10)||
                  ' FROM mo_Comment '||CHR(10)||
                 ' WHERE mo_Comment.comment_id = :nuCommentId)'||CHR(10)||
                 ' UNION '||CHR(10)||
                 ' (SELECT '||SBORDERCOMMENTATTRIBUTES||CHR(10)||
                  ' FROM or_order_comment, or_order_activity'||CHR(10)||
                 ' WHERE or_order_comment.order_id = or_order_activity.order_id'||CHR(10)||
                 ' AND or_order_comment.order_comment_id = :nuCommentId)'||CHR(10)||
                 ' UNION '||CHR(10)||
                 ' (SELECT '||SBCOMMENTBYACTIVITYATTRIBUTES||CHR(10)||
                  ' FROM or_order_activity'||CHR(10)||
                 ' WHERE or_order_activity.order_activity_id = :nuCommentId)';

        UT_TRACE.TRACE('Consulta['||SBSQL||']',5 );

        OPEN OCUDATACURSOR FOR SBSQL USING CC_BOBOSSUTIL.CNUNULL, NUCOMMENTID,
                                           CC_BOBOSSUTIL.CNUNULL, NUCOMMENTID,
                                           CC_BOBOSSUTIL.CNUNULL, NUCOMMENTID;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;
    

    PROCEDURE GETDAMELEMATTACHFILES
    (
       INUDAMAGEID     IN      TT_DAMAGE.PACKAGE_ID%TYPE,
       ORFCURSOR       OUT     CONSTANTS.TYREFCURSOR
    )
    IS
    BEGIN
        UT_TRACE.TRACE('Iniciando TT_boSearchDataServices.GetDamElemAttachFiles DamageId['||INUDAMAGEID||']', 5);

        
        CC_BOOSSATTACHFILES.GETDAMAGESATTACHEDFILES(CSBTT_FW_ELEMENT_DAMAGES,INUDAMAGEID,ORFCURSOR);

        UT_TRACE.TRACE('Fin de TT_boSearchDataServices.GetDamElemAttachFiles', 5);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;


    


































    PROCEDURE FILLELEMENTDAMAGEATTRIBUTES
    (
        IOSBATTRIBUTES IN OUT VARCHAR2
    )
    IS
        SBDAMAGETYPE                GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        SBFINALDAMAGETYPE           GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        SBDAMAGESTATUS              GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        SBDAMAGECAUSAL              GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        SBPERSONREGISTER            GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        SBDAMAGEADDRESS             GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        SBDAMAGEGEOGLOCA            GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        SBDAMANEIGHBORTHOOD         GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        SBELEMENTTYPE               GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        SBELEMENTCODE               GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        SBELEMENTSTATUS             GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        SBELEMENTCLASS              GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        
        
        SBCLASS                     GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        
        SBAPPROVALCOMP              GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        
        SBATTRIBUTEDTO              GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        
        SBTIMEOUT                   GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        
        SBPERSONVERIFYING           GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        
        SBORDERID                   GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
    BEGIN

        
        SBDAMAGETYPE := 'TT_BCBasicDataServices.fsbGetDamageType(tt_damage.package_id, tt_damage.reg_damage_type_id)';
        SBFINALDAMAGETYPE := 'TT_BCBasicDataServices.fsbGetFinalDamageType(tt_damage.final_damage_type_id)';
        SBDAMAGESTATUS := 'TT_BCBasicDataServices.fsbGetDamageStatus(tt_damage.package_id)';
        SBPERSONREGISTER:= '(SELECT ge_person.person_id ||'' - ''|| ge_person.name_ FROM ge_person WHERE ge_person.person_id = mo_packages.person_id)';
        SBDAMAGEGEOGLOCA := 'TT_BCBasicDataServices.fsbGetDescGeoLocByAddr(TT_BCBasicDataServices.fnuGetParsAddrIdByPack(tt_damage.package_id))';
        SBDAMANEIGHBORTHOOD := 'TT_BCBasicDataServices.fsbGetDescNeighByAddr(TT_BCBasicDataServices.fnuGetParsAddrIdByPack(tt_damage.package_id))';
        SBDAMAGEADDRESS:= 'TT_BCBasicDataServices.fsbAddrOrPremiseByPack(tt_damage.package_id,pr_boparameter.fnuGetMainAddressType)';
        SBDAMAGECAUSAL:= 'TT_BCBasicDataServices.fsbGetDamageCausal( tt_damage.damage_causal_id)';
        SBELEMENTTYPE := 'TT_BCBasicDataServices.fsbGetDamElemTypeByPac(tt_damage.package_id)';
        SBELEMENTCODE := 'TT_BCBasicDataServices.fsbGetDamElemCodeByPac(tt_damage.package_id)';
        SBELEMENTSTATUS := 'TT_BCBasicDataServices.fsbElemStatusByPack(tt_damage.package_id)';
        SBELEMENTCLASS := 'TT_BCBasicDataServices.fsbElemClassByPack(tt_damage.package_id)';

        SBCLASS := 'decode(tt_damage.class,'''||TT_BCCONSTANTS.CSBCLASS_PROGRAM||''',''Programada'','||
                                           ''''||TT_BCCONSTANTS.CSBCLASS_NOT_PROGRAM||''',''No Programada'','||
                                           ''''||TT_BCCONSTANTS.CSBCLASS_AUTOMATIC||''',''Autom�tica'','||
                                           ''''||GE_BOUTILITIES.CSBAPPLICATIONNULL||''')';
                                              
        SBAPPROVALCOMP := 'decode(tt_damage.approval,'''||TT_BCCONSTANTS.CSBCOMP_AUTHORIZED||''',''Autorizado'','||
                                                     ''''||TT_BCCONSTANTS.CSBCOMP_UNAUTHORIZED||''',''No Autorizado'','||
                                                     ''''||TT_BCCONSTANTS.CSBCOMP_PENDING||''',''Pendiente'','||
                                                     ''''||TT_BCCONSTANTS.CSBCOMP_NOT_APPLICAB||''',''No Aplica'','||
                                                     ''''||GE_BOUTILITIES.CSBAPPLICATIONNULL||''')';
        SBATTRIBUTEDTO := 'TT_BCBasicDataServices.fsbGetAttributedTo(tt_damage.damage_causal_id)';
        SBTIMEOUT := 'TT_BCBasicDataServices.fsbGetTimeOut(nvl(tt_damage.final_damage_type_id,tt_damage.reg_damage_type_id))';
        SBPERSONVERIFYING:= 'TT_BCBasicDataServices.fsbGetDamagAttPerson(tt_damage.person_verifying)';
        SBORDERID := '(SELECT or_order_activity.order_id FROM or_order_activity WHERE or_order_activity.order_activity_id = tt_damage.order_activity_id)';

        GE_BOUTILITIES.ADDATTRIBUTE ('tt_damage.package_id','PACKAGE_ID',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBDAMAGESTATUS,'DAMAGE_STATUS',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE ('mo_packages.comment_','DAMAGE_DESC',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBORDERID,'ORDER_ID',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBELEMENTCODE,'ELEMENT_CODE',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBELEMENTTYPE,'ELEMENT_TYPE',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBELEMENTCLASS,'ELEMENT_CLASS',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBELEMENTSTATUS ,'ELEMENT_STATUS',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBDAMAGETYPE,'DAMAGE_TYPE', IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBFINALDAMAGETYPE,'FINAL_DAMAGE_TYPE', IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBDAMAGECAUSAL,'DAMAGE_CAUSAL',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE ('mo_packages.request_date','REQUEST_DATE',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE ('tt_damage.damage_absor_date','DATE_FIRST_DAMAGE',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE ('tt_damage.estimat_attent_date','ESTIMAT_ATTENT_DATE',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE ('mo_packages.attention_date','ATTENT_DATE',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE ('tt_damage.initial_date','INITIAL_DATE',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE ('tt_damage.end_date','END_DATE_AFFECT',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBCLASS,'CLASS',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBAPPROVALCOMP,'APPROVAL_COMPENSATION',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBATTRIBUTEDTO,'ATTRIBUTED_TO',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBTIMEOUT,'TIME_OUT',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE ('tt_damage.verification_date','VERIFICATION_DATE',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBPERSONVERIFYING,'PERSON_VERIFYING',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE ('tt_damage.terminal_verifying','TERMINAL_VERIFYING',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBDAMAGEGEOGLOCA,'DAMAGE_GEOG_LOCA',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBDAMANEIGHBORTHOOD,'DAMAGE_NEIGHBORTHOOD',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBDAMAGEADDRESS,'DAMAGE_ADDRESS',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE ('tt_damage.priority','PRIORITY',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBPERSONREGISTER,'DAMAGE_REGISTER',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE ('nvl(tt_damage.products_damaged,0)','PRODUCTS_DAMAGED',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (':parent_id','parent_id',IOSBATTRIBUTES);

    END FILLELEMENTDAMAGEATTRIBUTES;

    





















    PROCEDURE GETELEMENTDAMAGE
    (
        INUPACKAGEID    IN  TT_DAMAGE.PACKAGE_ID%TYPE,
        OCUDATACURSOR   OUT CONSTANTS.TYREFCURSOR
    )
    IS
      SBSQL                            GE_BOUTILITIES.STYSTATEMENT;
      SBDAMAGEFROM                     GE_BOUTILITIES.STYSTATEMENT;
      SBDAMAGEWHERE                    GE_BOUTILITIES.STYSTATEMENT;
      SBDAMAGEATTRIBUTES               GE_BOUTILITIES.STYSTATEMENT;
    BEGIN

        FILLELEMENTDAMAGEATTRIBUTES(SBDAMAGEATTRIBUTES);

        SBDAMAGEFROM := ' mo_packages, tt_damage ';
        SBDAMAGEWHERE :=' mo_packages.package_id= tt_damage.package_id '||CHR(10)||
                        '    AND mo_packages.package_type_id = '||TT_BOCONSTANTS.CNUMASSDAMAGE||
                        '    AND tt_damage.package_id = :inuPackageId ';

        SBSQL := 'SELECT '|| SBDAMAGEATTRIBUTES ||CHR(10)||
                  ' FROM '|| SBDAMAGEFROM ||CHR(10)||
                 ' WHERE '|| SBDAMAGEWHERE;
                 
        UT_TRACE.TRACE('SQL ['||SBSQL||']',15);
        
        TT_BCBASICDATASERVICES.CLEARDAMDATACACHE;

        OPEN OCUDATACURSOR FOR SBSQL USING INUPACKAGEID,INUPACKAGEID;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

     










































   PROCEDURE GETELEMENTSDAMAGE
    (
        INUPACKAGEID          IN TT_DAMAGE.PACKAGE_ID%TYPE,
        INUDAMAGETYPEID       IN TT_DAMAGE_TYPE.DAMAGE_TYPE_ID%TYPE,
        INUPACKSTATUSID       IN PS_MOTIVE_STATUS.MOTIVE_STATUS_ID%TYPE,
        ISBDAMAGESTATUSTYPEID IN PS_MOTIVE_STATUS.IS_FINAL_STATUS%TYPE,
        INUORDERID            IN OR_ORDER.ORDER_ID%TYPE,
        INUBASEADMINISTRA     IN GE_BASE_ADMINISTRA.ID_BASE_ADMINISTRA%TYPE,
        INUZONEMANAGETYPE     IN OR_OPERATING_ZONE.MANAGE_ROUTE%TYPE,
        INUOPERATINGZONE      IN OR_OPERATING_ZONE.OPERATING_ZONE_ID%TYPE,
        INUOPERSECTORID       IN OR_OPERATING_SECTOR.OPERATING_SECTOR_ID%TYPE,
        INUPERSONID           IN MO_PACKAGES.PERSON_ID%TYPE,
        IDTINITIALREQDATE     IN MO_PACKAGES.REQUEST_DATE%TYPE,
        IDTFINALREQDATE       IN MO_PACKAGES.REQUEST_DATE%TYPE,
        INUADDRESSID          IN MO_ADDRESS.PARSER_ADDRESS_ID%TYPE,
        INUINFRATYPEID        IN IF_INFRA_TYPE.INFRASTRUCTURE_TYPE%TYPE,
        INUELEMENTTYPEID      IN IF_ELEMENT_TYPE.ELEMENT_TYPE_ID%TYPE,
        INUELEMENTID          IN IF_NODE.ID%TYPE,
        OCUDATACURSOR         OUT CONSTANTS.TYREFCURSOR
    )
    IS

      SBSQL              GE_BOUTILITIES.STYSTATEMENT;
      SBDAMAGEFROM       GE_BOUTILITIES.STYSTATEMENT := '';
      SBDAMAGEWHERE      GE_BOUTILITIES.STYSTATEMENT := '';
      SBADDITIONAL       GE_BOUTILITIES.STYSTATEMENT := '';
      SBDAMAGEATTRIBUTES GE_BOUTILITIES.STYSTATEMENT := '';
      SBELEMENTS         GE_BOUTILITIES.STYSTATEMENT := '';
      DTINITIALREQDATE   MO_PACKAGES.REQUEST_DATE%TYPE;
      DTFINALREQDATE     MO_PACKAGES.REQUEST_DATE%TYPE;
      SBUSECOMODINES     VARCHAR2(10):= GE_BOCONSTANTS.GETYES;


      
      
      
      FUNCTION SINGLEDMGCRITERIA RETURN BOOLEAN
      IS
      BEGIN

          RETURN INUPACKAGEID IS NULL AND
                 INUORDERID IS NULL AND
                 INUADDRESSID IS NULL AND
                 INUBASEADMINISTRA IS NULL AND
                 INUOPERATINGZONE IS NULL AND
                 INUOPERSECTORID IS NULL AND
                 INUELEMENTID IS NULL AND
                 INUPERSONID IS NULL;

      EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
      END SINGLEDMGCRITERIA;

    BEGIN

        UT_TRACE.TRACE('TT_boSearchDataServices.GetElementsDamage',2);

        DTINITIALREQDATE:=IDTINITIALREQDATE;
        DTFINALREQDATE:=IDTFINALREQDATE;

        IF (SINGLEDMGCRITERIA()) THEN
             GE_BOERRORS.SETERRORCODE(CNUERROR_11322);
        END IF;

        FILLELEMENTDAMAGEATTRIBUTES(SBDAMAGEATTRIBUTES);
        FILLDAMAGEWHERE
        (
            INUPACKAGEID,
            INUDAMAGETYPEID,
            INUPACKSTATUSID,
            ISBDAMAGESTATUSTYPEID,
            INUORDERID,
            DTINITIALREQDATE,
            DTFINALREQDATE,
            INUADDRESSID,
            INUBASEADMINISTRA,
            INUOPERATINGZONE,
            INUOPERSECTORID,
            SBDAMAGEFROM,
            SBDAMAGEWHERE,
            SBADDITIONAL
        );
        
        IF (INUINFRATYPEID IS NOT NULL AND INUELEMENTTYPEID IS NULL) THEN
            GE_BOERRORS.SETERRORCODEARGUMENT(901280,INUINFRATYPEID||'-'||DAIF_INFRA_TYPE.FSBGETDESCRIPTION(INUINFRATYPEID));
        END IF;

        IF ( INUELEMENTID IS NOT NULL OR INUELEMENTTYPEID IS NOT NULL )  THEN
            SBDAMAGEWHERE := SBDAMAGEWHERE ||CHR(10)||
                'AND EXISTS (' ||CHR(10)||
                'SELECT /*+ USE_NL(TT_DAMAGE TT_DAMAGE_ELEMENT) */ ''X''' ||CHR(10)||
                'FROM tt_damage_element' ||CHR(10)||
                'WHERE tt_damage_element.package_id = tt_damage.package_id';
            IF ( INUELEMENTID IS NOT NULL  )  THEN
                SBDAMAGEWHERE := SBDAMAGEWHERE ||' AND tt_damage_element.element_id = '||INUELEMENTID||''||CHR(10);
            END IF;

            IF ( INUELEMENTTYPEID IS NOT NULL  )  THEN
                SBDAMAGEWHERE := SBDAMAGEWHERE ||' AND tt_damage_element.element_type_id = '||INUELEMENTTYPEID||''||CHR(10);
            END IF;

            SBDAMAGEWHERE := SBDAMAGEWHERE ||CHR(10)|| ' )';
        END IF;

        
        IF  INUPERSONID IS NOT NULL THEN
            SBDAMAGEWHERE :=SBDAMAGEWHERE||' AND mo_packages.person_id+0 ='||INUPERSONID||CHR(10);
        END IF;
        
        
        SBSQL := 'SELECT /*+'||SBADDITIONAL||' */ '||CHR(10)||
                 ' distinct '|| SBDAMAGEATTRIBUTES||CHR(10)||
                 '  FROM '|| SBDAMAGEFROM                                     ||CHR(10)||
                 '    mo_packages, '                                          ||CHR(10)||
                 '    tt_damage    '                                          ||CHR(10)||
                 ' WHERE '||CHR(10)||
                 '        tt_damage.package_id = mo_packages.package_id'||CHR(10)||
                 SBDAMAGEWHERE;


        UT_TRACE.TRACE('SQL ['||SBSQL||']',15);
        
        TT_BCBASICDATASERVICES.CLEARDAMDATACACHE;

        IF DTINITIALREQDATE IS NULL AND DTFINALREQDATE IS NULL THEN
            
            OPEN OCUDATACURSOR FOR SBSQL USING CC_BOBOSSUTIL.CNUNULL;
        ELSIF DTFINALREQDATE IS NULL THEN
            
            OPEN OCUDATACURSOR FOR SBSQL USING CC_BOBOSSUTIL.CNUNULL, DTINITIALREQDATE;
        ELSIF DTINITIALREQDATE IS NULL THEN
            
            OPEN OCUDATACURSOR FOR SBSQL USING CC_BOBOSSUTIL.CNUNULL, DTFINALREQDATE;
        ELSE
            
            OPEN OCUDATACURSOR FOR SBSQL USING CC_BOBOSSUTIL.CNUNULL, DTINITIALREQDATE,DTFINALREQDATE;
        END IF;


    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETELEMENTSDAMAGE;

    
    

























    PROCEDURE GETPRODUCTQUANTITYBYID
    (
        ISBREGISTERID   IN  VARCHAR2,
        ORFREFCURSOR    OUT CONSTANTS.TYREFCURSOR
    )
    IS
        NUPACKAGEID     VARCHAR2(47);
    BEGIN

        
        NUPACKAGEID := SUBSTR(ISBREGISTERID,INSTR(ISBREGISTERID,'|' )+1);

        OPEN ORFREFCURSOR FOR
           'SELECT  product_type_id|| ''|'' ||package_id id,
                    product_type_id|| ''-'' ||pktblservicio.fsbGetDescription(product_type_id) product_type_id,
                    count(''x'') cantidad,
                    :parent parent_id
            FROM
            (
                SELECT  pr_product.product_type_id,
                        package_id
                FROM    tt_damage_product,
                        pr_product,
                        servicio
                WHERE   tt_damage_product.product_id = pr_product.product_id
                AND     PACKAGE_id = :PackageId
            )
            GROUP BY product_type_id, package_id '
        USING NUPACKAGEID, NUPACKAGEID;


    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETPRODUCTQUANTITYBYID;

    



























    PROCEDURE GETPRODUCTQUANTITYBYDAMAGE
    (
        INUPACKAGEID    IN  TT_DAMAGE.PACKAGE_ID%TYPE,
        ORFREFCURSOR    OUT CONSTANTS.TYREFCURSOR
    )
    IS
    BEGIN

        OPEN ORFREFCURSOR FOR
            'SELECT product_type_id|| ''|'' ||package_id id,
                    product_type_id|| ''-'' ||pktblservicio.fsbGetDescription(product_type_id) product_type_id,
                    count(''x'') cantidad,
                    :parent parent_id
            FROM
            (
                SELECT  pr_product.product_type_id,
                        package_id
                FROM    tt_damage_product,
                        pr_product
                WHERE   tt_damage_product.product_id = pr_product.product_id
                AND     PACKAGE_id = :PackageId
            )
            GROUP BY product_type_id, package_id '
        USING INUPACKAGEID, INUPACKAGEID;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;


    


























    PROCEDURE GETCOMPBYPRODDAMAGE
    (
        INUPRODUCTID    IN  TT_DAMAGE_PRODUCT.PRODUCT_ID%TYPE,
        ORFREFCURSOR    OUT CONSTANTS.TYREFCURSOR
    )
    IS

        SBSQL       VARCHAR2(4000);
        SBHINT      VARCHAR2(500);

    BEGIN

        
        CC_BOOSSPRODUCTCOMPONENT.FILLCOMPONENTATTRIBUTES;
        
        SBHINT:= ' /*+ leading (damage_product) use_nl(damage_product a)'         ||CHR(10)||
                    CC_BOOSSPRODUCTCOMPONENT.SBCOMPHINTSDEF;

        SBSQL := 'SELECT '||SBHINT                                              ||CHR(10)||
                 CC_BOOSSPRODUCTCOMPONENT.SBCOMPONENTATTR                       ||CHR(10)||
                 'FROM '||CC_BOOSSPRODUCTCOMPONENT.SBCOMPONENTFROM||',tt_damage_product damage_product'||CHR(10)||
                 'WHERE damage_product.damages_product_id = :inuDamageProduct ' ||CHR(10)||
                 'AND damage_product.product_id =  a.product_id'                ||CHR(10)||
                 'AND '||CC_BOOSSPRODUCTCOMPONENT.SBCOMPONENTWHERE;
                 
        OPEN ORFREFCURSOR FOR SBSQL USING INUPRODUCTID, INUPRODUCTID;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    



















    PROCEDURE FILLRELDAMAGEINFO
    (
        IOSBATTRIBUTES IN OUT VARCHAR2
    )
    IS
        SBADDRESS               GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        SBCAUSAL                GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        SBPRODUCTTYPE           GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
    BEGIN

        
        SBADDRESS               := 'AB_BOBasicDataServices.fsbGetDescAddressParsed(pr_product.address_id)';
        SBCAUSAL                := '(SELECT cc_causal.causal_id||''-''||cc_causal.description FROM cc_causal WHERE cc_causal.causal_id = mo_motive.causal_id)';
        SBPRODUCTTYPE           := 'pktblservicio.fsbGetDescription(pr_product.product_type_id)';

        GE_BOUTILITIES.ADDATTRIBUTE ('mo_packages.package_id','PACKAGE_ID', IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE ('ge_subscriber.identification','IDENTIFICATION',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE ('ge_subscriber.subscriber_name || '' '' || ge_subscriber.subs_last_name','SUBSCRIBER_NAME',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBADDRESS,'address',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE ('cc_boOssSubscriberData.fsbGetPhone(ge_subscriber.subscriber_id)','PHONE', IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBCAUSAL,'"Causal "',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE (SBPRODUCTTYPE,'PRODUCT_TYPE',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE ('pr_product.service_number','SERVICE_NUMBER',IOSBATTRIBUTES);
        GE_BOUTILITIES.ADDATTRIBUTE ('mo_packages.request_date','REQUEST_DATE',IOSBATTRIBUTES);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FILLRELDAMAGEINFO;





















    PROCEDURE GETRELDAMAGEDBYDAMID (
                                        INUPACKAGEID    IN TT_DAMAGE.PACKAGE_ID%TYPE,
                                        OCUDATACURSOR  OUT CONSTANTS.TYREFCURSOR
                                   )
    IS
        
        SBSQL                          VARCHAR2(8000);
        
        SBDAMAGEELEMFROM               GE_BOUTILITIES.STYSTATEMENT;
        
        SBDAMAGEELEMWHERE              GE_BOUTILITIES.STYSTATEMENT;
        
        SBDAMAGEELEMATTRIBUTES         GE_BOUTILITIES.STYSTATEMENT;
    BEGIN

        FILLRELDAMAGEINFO(SBDAMAGEELEMATTRIBUTES);

        SBDAMAGEELEMFROM := ' ge_subscriber, '||CHR(10)||
                            ' suscripc, '||CHR(10)||
                            ' pr_product, '||CHR(10)||
                            ' mo_packages, '||CHR(10)||
                            ' mo_motive, '||CHR(10)||
                            ' mo_packages_asso ';

        SBDAMAGEELEMWHERE := ' mo_packages_asso.package_id_asso = '||INUPACKAGEID||' AND '||CHR(10)||
                             ' mo_packages.package_id = mo_packages_asso.package_id AND '||CHR(10)||
                             ' mo_motive.package_id = mo_packages.package_id AND '||CHR(10)||
                             ' pr_product.product_id = mo_motive.product_id AND '||CHR(10)||
                             ' suscripc.susccodi (+)= pr_product.subscription_id AND '||CHR(10)||
                             ' ge_subscriber.subscriber_id (+)= suscripc.suscclie ';

        SBSQL := 'SELECT DISTINCT '|| SBDAMAGEELEMATTRIBUTES ||CHR(10)||
                  ' FROM '|| SBDAMAGEELEMFROM ||CHR(10)||
                 ' WHERE '|| SBDAMAGEELEMWHERE;

        UT_TRACE.TRACE('SQL ['||SBSQL||']',15);

        OPEN OCUDATACURSOR FOR SBSQL;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETRELDAMAGEDBYDAMID;
    
    
















    FUNCTION FSBGETSTATUSTYPEDAM
    (
        ISBSTATUSTYPEID    IN VARCHAR2
    )
    RETURN VARCHAR2
    IS
        
        SBSTATUS    GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
    BEGIN
        UT_TRACE.TRACE('[INICIO] TT_boSearchDataServices.fsbGetStatusTypeDam['||ISBSTATUSTYPEID||']',10);
        
        IF (ISBSTATUSTYPEID = TT_BCCONSTANTS.CSBSTATUS_FINISHED) THEN
            SBSTATUS := 'Terminal';
        ELSIF(ISBSTATUSTYPEID = TT_BCCONSTANTS.CSBSTATUS_NOFINISHED) THEN
            SBSTATUS := 'No Terminal';
        END IF;

        UT_TRACE.TRACE('[FIN] TT_boSearchDataServices.fsbGetStatusTypeDam',10);
        RETURN SBSTATUS;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('Error : ex.CONTROLLED_ERROR',10);
                RAISE;
        WHEN OTHERS THEN
            UT_TRACE.TRACE('Error : others',12);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FSBGETSTATUSTYPEDAM;
    
    





















    PROCEDURE GETOUTAGEHISTORY
    (
        INUID         IN  TT_DAMAGE_PRODUCT.DAMAGES_PRODUCT_ID%TYPE,
        ORFDATACURSOR OUT CONSTANTS.TYREFCURSOR
    )
    IS
    BEGIN
        UT_TRACE.TRACE('[INICIO] TT_boSearchDataServices.GetOutageHistory['||INUID||']',10);

        OPEN ORFDATACURSOR FOR
            SELECT /*+ leading(tt_damage_product)
                       use_nl(tt_damage_product tt_damage)
                       use_nl(tt_damage mo_packages) */
                   TT_DAMAGE.PACKAGE_ID,
                   TT_DAMAGE_PRODUCT.DAMAGES_PRODUCT_ID ID,
                   TT_BCBASICDATASERVICES.FSBGETFINALDAMAGETYPE(NVL(TT_DAMAGE.FINAL_DAMAGE_TYPE_ID,
                                                                    TT_DAMAGE.REG_DAMAGE_TYPE_ID)) FAULT_TYPE,
                   (SELECT /*+ leading(pr_component)
                               use_nl(pr_component pr_timeout_component)
                               index(pr_timeout_component IDX_PR_TIMEOUT_COMPONENT_03)
                               index(pr_component IDX_PR_TIMEOUT_COMPONENT_03 IDX_PR_COMPONENT_2) */
                               UT_DATE.FSBFORMATTIME(PR_TIMEOUT_COMPONENT.COMPENSATED_TIME*60)
                    FROM PR_COMPONENT,
                         PR_TIMEOUT_COMPONENT
                    WHERE PR_COMPONENT.PRODUCT_ID = TT_DAMAGE_PRODUCT.PRODUCT_ID
                      AND PR_COMPONENT.COMPONENT_ID = PR_TIMEOUT_COMPONENT.COMPONENT_ID
                      AND PR_TIMEOUT_COMPONENT.PACKAGE_ID = TT_DAMAGE_PRODUCT.PACKAGE_ID
                      AND ROWNUM = 1) COMPENSATED_TIME,
                   DECODE(TT_DAMAGE.APPROVAL,
                          TT_BCCONSTANTS.CSBCOMP_PENDING     ,'Pendiente',
                          TT_BCCONSTANTS.CSBCOMP_AUTHORIZED  ,'Autorizado',
                          TT_BCCONSTANTS.CSBCOMP_UNAUTHORIZED,'No Autorizado',
                          'No Aplica') APPROVAL,
                   MO_PACKAGES.REQUEST_DATE,
                   TT_DAMAGE.ESTIMAT_ATTENT_DATE,
                   TT_DAMAGE_PRODUCT.ATENTION_DATE OUTAGE_END_DATE,
                   NULL PARENT_ID
            FROM   TT_DAMAGE_PRODUCT,
                   TT_DAMAGE,
                   MO_PACKAGES
                   /*+ TT_boSearchDataServices.GetOutageHistory SAO183883 */
            WHERE TT_DAMAGE_PRODUCT.DAMAGES_PRODUCT_ID = INUID
              AND TT_DAMAGE_PRODUCT.PACKAGE_ID = TT_DAMAGE.PACKAGE_ID
              
              AND TT_DAMAGE.REG_DAMAGE_STATUS = TT_BCCONSTANTS.CSBATTENDEDDAMAGESTATUS
              AND TT_DAMAGE_PRODUCT.DAMAGE_PRODU_STATUS = TT_BCCONSTANTS.CSBCLOSEDAMAGESTATUS
              AND TT_DAMAGE.PACKAGE_ID = MO_PACKAGES.PACKAGE_ID;

        UT_TRACE.TRACE('[FIN] TT_boSearchDataServices.GetOutageHistory',10);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('Error : ex.CONTROLLED_ERROR',10);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            UT_TRACE.TRACE('Error : others',12);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETOUTAGEHISTORY;
    
    


























    PROCEDURE GETPRODOUTAGEHIST
    (
        INUPRODUCTID  IN  PR_PRODUCT.PRODUCT_ID%TYPE,
        ORFDATACURSOR OUT CONSTANTS.TYREFCURSOR
    )
    IS
    BEGIN
        UT_TRACE.TRACE('[INICIO] TT_boSearchDataServices.GetProdOutageHist['||INUPRODUCTID||']',10);

        OPEN ORFDATACURSOR FOR
             SELECT /*+ leading(tt_damage_product)
                       use_nl(tt_damage_product tt_damage)
                       use_nl(tt_damage mo_packages)
                       use_nl(pr_component pr_timeout_component)
                       index(pr_timeout_component IDX_PR_TIMEOUT_COMPONENT_03)
                       index(pr_component IDX_PR_TIMEOUT_COMPONENT_03 IDX_PR_COMPONENT_2) */
                   TT_DAMAGE.PACKAGE_ID,
                   TT_DAMAGE_PRODUCT.DAMAGES_PRODUCT_ID ID,
                   TT_BCBASICDATASERVICES.FSBGETFINALDAMAGETYPE(NVL(TT_DAMAGE.FINAL_DAMAGE_TYPE_ID,
                                                                    TT_DAMAGE.REG_DAMAGE_TYPE_ID)) FAULT_TYPE,
                   UT_DATE.FSBFORMATTIME(PR_TIMEOUT_COMPONENT.COMPENSATED_TIME*60) COMPENSATED_TIME,
                   DECODE(TT_DAMAGE.APPROVAL,
                          TT_BCCONSTANTS.CSBCOMP_PENDING     ,'Pendiente',
                          TT_BCCONSTANTS.CSBCOMP_AUTHORIZED  ,'Autorizado',
                          TT_BCCONSTANTS.CSBCOMP_UNAUTHORIZED,'No Autorizado',
                          'No Aplica') APPROVAL,
                   PR_TIMEOUT_COMPONENT.INITIAL_DATE REQUEST_DATE,
                   TT_DAMAGE.ESTIMAT_ATTENT_DATE,
                   PR_TIMEOUT_COMPONENT.FINAL_DATE OUTAGE_END_DATE,
                   INUPRODUCTID PARENT_ID
            FROM   TT_DAMAGE_PRODUCT,
                   TT_DAMAGE,
                   MO_PACKAGES,
                   PR_TIMEOUT_COMPONENT,
                   PR_COMPONENT
                   /*+ TT_boSearchDataServices.GetProdOutageHist SAO183883 */
            WHERE TT_DAMAGE_PRODUCT.PRODUCT_ID = INUPRODUCTID
              AND TT_DAMAGE_PRODUCT.PACKAGE_ID = TT_DAMAGE.PACKAGE_ID
              AND PR_COMPONENT.PRODUCT_ID = TT_DAMAGE_PRODUCT.PRODUCT_ID
              AND PR_COMPONENT.COMPONENT_ID = PR_TIMEOUT_COMPONENT.COMPONENT_ID
              AND PR_TIMEOUT_COMPONENT.PACKAGE_ID = TT_DAMAGE_PRODUCT.PACKAGE_ID
              
              AND TT_DAMAGE.REG_DAMAGE_STATUS = TT_BCCONSTANTS.CSBATTENDEDDAMAGESTATUS
              AND TT_DAMAGE_PRODUCT.DAMAGE_PRODU_STATUS = TT_BCCONSTANTS.CSBCLOSEDAMAGESTATUS
              AND TT_DAMAGE.PACKAGE_ID = MO_PACKAGES.PACKAGE_ID
            UNION
            (SELECT  /*+ INDEX(pr_component IDX_PR_COMPONENT_2)
                        INDEX(pr_timeout_component IDX_PR_TIMEOUT_COMPONENT_02)
                        INDEX(mo_packages PK_MO_PACKAGES)
                        INDEX(mo_motive IDX_MO_MOTIVE_02)
                        INDEX(cc_causal PK_CC_CAUSAL)
                    */
                    MO_PACKAGES.PACKAGE_ID,
                    MO_PACKAGES.PACKAGE_ID,
                    CC_CAUSAL.DESCRIPTION FAULT_TYPE,
                    DECODE(PR_TIMEOUT_COMPONENT.COMPENSATED_TIME,
                            NULL,NULL,
                            UT_DATE.FSBFORMATTIME(PR_TIMEOUT_COMPONENT.COMPENSATED_TIME*60)
                        ) COMPENSATED_TIME,
                    DECODE( PR_TIMEOUT_COMPONENT.AUTHORIZATION_DATE,
                            NULL,'Pendiente',
                            'Autorizado'
                        ) APPROVAL,
                    PR_TIMEOUT_COMPONENT.INITIAL_DATE REQUEST_DATE,
                    MO_PACKAGES.EXPECT_ATTEN_DATE ESTIMAT_ATTENT_DATE,
                    PR_TIMEOUT_COMPONENT.FINAL_DATE OUTAGE_END_DATE,
                    INUPRODUCTID PARENT_ID
            FROM    /*+ TT_boSearchDataServices.GetProdOutageHist*/
                    PR_TIMEOUT_COMPONENT,
                    PR_COMPONENT,
                    MO_PACKAGES,
                    CC_CAUSAL,
                    MO_MOTIVE
            WHERE   PR_COMPONENT.COMPONENT_ID = PR_TIMEOUT_COMPONENT.COMPONENT_ID
            AND     PR_TIMEOUT_COMPONENT.PACKAGE_ID = MO_PACKAGES.PACKAGE_ID
            AND     MO_PACKAGES.PACKAGE_TYPE_ID = TT_BOCONSTANTS.CNUINDDAMAGE
            AND     PR_COMPONENT.PRODUCT_ID = INUPRODUCTID
            AND     MO_PACKAGES.PACKAGE_ID = MO_MOTIVE.PACKAGE_ID
            AND     MO_MOTIVE.CAUSAL_ID = CC_CAUSAL.CAUSAL_ID)
            ORDER BY OUTAGE_END_DATE DESC;
            
        GNUPARENTPRODID := INUPRODUCTID;

        UT_TRACE.TRACE('[FIN] TT_boSearchDataServices.GetProdOutageHist',10);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('Error : ex.CONTROLLED_ERROR',10);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            UT_TRACE.TRACE('Error : others',12);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETPRODOUTAGEHIST;
    
    



















    PROCEDURE GETPRODUCTBYOUTAGE
    (
        INUID        IN  TT_DAMAGE_PRODUCT.DAMAGES_PRODUCT_ID%TYPE,
        ONUPRODUCTID OUT PR_PRODUCT.PRODUCT_ID%TYPE
    )
    IS
    BEGIN
        UT_TRACE.TRACE('[INICIO] TT_boSearchDataServices.GetProdOutageHist['||INUID||']',10);

        IF (GNUPARENTPRODID IS NULL) THEN
            ONUPRODUCTID := DATT_DAMAGE_PRODUCT.FNUGETPRODUCT_ID(INUID);
        ELSE
            ONUPRODUCTID := GNUPARENTPRODID;
        END IF;

        UT_TRACE.TRACE('[FIN] TT_boSearchDataServices.GetProdOutageHist',10);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('Error : ex.CONTROLLED_ERROR',10);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            UT_TRACE.TRACE('Error : others',12);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETPRODUCTBYOUTAGE;

    



















    FUNCTION FRFGETFAULTADDDATA
    RETURN CONSTANTS.TYREFCURSOR
    IS
        RFDATACURSOR     CONSTANTS.TYREFCURSOR;                
        NUFAULTID        TT_DAMAGE.PACKAGE_ID%TYPE;            
        NUELEMENTID      TT_DAMAGE.ELEMENT_ID%TYPE;            
        SBVALUE          GE_BOUTILITIES.STYSTATEMENTATTRIBUTE; 
        NUINITASSIGID    IF_ASSIGNABLE.ID%TYPE;                
        NUFINALASSIGID   IF_ASSIGNABLE.ID%TYPE;                
        SBINITASSIGCODE  IF_ASSIGNABLE.CODE%TYPE;              
        SBFINALASSIGCODE IF_ASSIGNABLE.CODE%TYPE;              
    BEGIN
        
        GE_BOINSTANCECONTROL.GETGLOBALATTRIBUTE(GE_BOINSTANCECONSTANTS.CSBGLOBAL_ID,
                                                SBVALUE);
        NUFAULTID := TO_NUMBER(SBVALUE);

        UT_TRACE.TRACE('[INICIO] TT_boSearchDataServices.frfGetFaultAddData['||NUFAULTID||']',10);

        NUELEMENTID := DATT_DAMAGE.FNUGETELEMENT_ID(NUFAULTID);

        IF (NUELEMENTID IS NOT NULL) THEN
            TT_BCELEMENT.GETASSIGRANGE(NUFAULTID,
                                       NUELEMENTID,
                                       NUINITASSIGID,
                                       NUFINALASSIGID);
        END IF;

        IF (NUINITASSIGID IS NOT NULL) THEN
            SBINITASSIGCODE := DAIF_ASSIGNABLE.FSBGETCODE(NUINITASSIGID);
        END IF;
        
        IF (NUFINALASSIGID IS NOT NULL) THEN
            SBFINALASSIGCODE := DAIF_ASSIGNABLE.FSBGETCODE(NUFINALASSIGID);
        END IF;

        OPEN RFDATACURSOR FOR
            SELECT SBINITASSIGCODE "Elemento Inicial",
                   SBFINALASSIGCODE "Elemento Final"
            FROM DUAL;

        RETURN RFDATACURSOR;

        UT_TRACE.TRACE('[FIN] TT_boSearchDataServices.frfGetFaultAddData',10);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('Error : ex.CONTROLLED_ERROR',10);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            UT_TRACE.TRACE('Error : others',12);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FRFGETFAULTADDDATA;
    
    




















    PROCEDURE GETFAULTASSO
    (
        INUPACKAGEID    IN  TT_DAMAGE.PACKAGE_ID%TYPE,
        OCUDATACURSOR   OUT CONSTANTS.TYREFCURSOR
    )
    IS
    BEGIN
       
       TT_BOSEARCHDATASERVICES.GETELEMENTDAMAGE(INUPACKAGEID,OCUDATACURSOR);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('Error : ex.CONTROLLED_ERROR',10);
                RAISE;
        WHEN OTHERS THEN
            UT_TRACE.TRACE('Error : others',12);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETFAULTASSO;
    
    





















    PROCEDURE GETFAULTASSOBYFAULT
    (
        INUPACKAGEID    IN  TT_DAMAGE.PACKAGE_ID%TYPE,
        OCUDATACURSOR   OUT CONSTANTS.TYREFCURSOR
    )
    IS
       
      SBSQL                            GE_BOUTILITIES.STYSTATEMENT;
      
      SBDAMAGEFROM                     GE_BOUTILITIES.STYSTATEMENT;
      
      SBDAMAGEWHERE                    GE_BOUTILITIES.STYSTATEMENT;
      
      SBDAMAGEATTRIBUTES               GE_BOUTILITIES.STYSTATEMENT;
    BEGIN

        
        FILLELEMENTDAMAGEATTRIBUTES(SBDAMAGEATTRIBUTES);
        
        SBDAMAGEFROM :=  ' mo_packages_asso, tt_damage, mo_packages ';
        SBDAMAGEWHERE := ' mo_packages.package_id = tt_damage.package_id '||CHR(10)||
                         ' AND mo_packages_asso.package_id = tt_damage.package_id '||CHR(10)||
                         ' AND mo_packages_asso.package_id_asso = :inuPackageId ';

        SBSQL := 'SELECT '|| SBDAMAGEATTRIBUTES ||CHR(10)||
                  ' FROM '|| SBDAMAGEFROM ||CHR(10)||
                  ' /*+ Ubicaci�n: TT_boSearchDataServices.GetFaultAssoByFault */ '|| CHR(10)||
                 ' WHERE '|| SBDAMAGEWHERE;

        UT_TRACE.TRACE('SQL ['||SBSQL||']',15);

        TT_BCBASICDATASERVICES.CLEARDAMDATACACHE;

        OPEN OCUDATACURSOR FOR SBSQL USING INUPACKAGEID,INUPACKAGEID;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('Error:TT_boSearchDataServices.GetFaultAssoByFault ex.CONTROLLED_ERROR',10);
                RAISE;
        WHEN OTHERS THEN
            UT_TRACE.TRACE('Error:TT_boSearchDataServices.GetFaultAssoByFaultError others',12);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETFAULTASSOBYFAULT;
    
    
    




















    PROCEDURE GETDAMAGEPRODBYFAULT
    (
        INUPACKAGEID    IN  TT_DAMAGE.PACKAGE_ID%TYPE,
        ORFDATACURSOR   OUT CONSTANTS.TYREFCURSOR
    )
    IS
        
        SBSQL         GE_BOUTILITIES.STYSTATEMENT;
        
        SBHINTS       GE_BOUTILITIES.STYSTATEMENT;
    BEGIN
        
        CC_BOOSSDAMAGES.FILLDAMAGEATTRIBUTES;

        
        SBSQL :=    'SELECT '||' /*+ leading(pack_asso) '|| CHR(10)
                             ||'     use_nl(pack_asso) '|| CHR(10)
                             ||'     index(pack_asso idx_mo_packages_asso_02) '|| CHR(10)
                             || CHR(10) || CC_BOOSSDAMAGES.GSBDAMAGEHINTS || CHR(10)
                             || CHR(10) || '*/' || CHR(10)
                             || CC_BOOSSDAMAGES.GSBDAMAGEATTRIBUTES || CHR(10) ||
                     'FROM '  || CHR(10) || CC_BOOSSDAMAGES.GSBDAMAGEFROM||', mo_packages_asso pack_asso '
                             || CHR(10) ||'/*+ Ubicaci�n: TT_boSearchDataServices.GetDamageProdByFault */ ' || CHR(10) ||
                     'WHERE ' || CHR(10) || CC_BOOSSDAMAGES.GSBDAMAGEWHERE || CHR(10) ||' '||
                    'AND moti.package_id = pack_asso.package_id '|| CHR(10) ||' '||
                    'AND pack_asso.package_id_asso = :inuPackageId';

        OPEN ORFDATACURSOR FOR SBSQL USING INUPACKAGEID, INUPACKAGEID;
        
        UT_TRACE.TRACE('SQL['||SBSQL||']',10);
        
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('Error : ex.CONTROLLED_ERROR',10);
                RAISE;
        WHEN OTHERS THEN
            UT_TRACE.TRACE('Error : others',12);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETDAMAGEPRODBYFAULT;
    
    
    






















    PROCEDURE GETFAULTBYDAMAGEPROD
    (
        INUPACKAGEID    IN  MO_PACKAGES_ASSO.PACKAGE_ID%TYPE,
        ONUFAULTID      OUT  MO_PACKAGES_ASSO.PACKAGE_ID_ASSO%TYPE
    )
    IS
    BEGIN
        UT_TRACE.TRACE('[INICIO] TT_boSearchDataServices.GetFaultByDamageProd: ',10);
        ONUFAULTID := MO_BCPACKAGES_ASSO.FNUGETPACKAGEIDASSO(INUPACKAGEID);
        UT_TRACE.TRACE('[FIN] TT_boSearchDataServices.GetFaultByDamageProd: ',10);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('Error : ex.CONTROLLED_ERROR',10);
                RAISE;
        WHEN OTHERS THEN
            UT_TRACE.TRACE('Error : others',12);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETFAULTBYDAMAGEPROD;
    
     




















    
    PROCEDURE GETPROGRESSBYFAULT
    (
        INUPACKAGEID    IN  TT_DAMAGE.PACKAGE_ID%TYPE,
        OCUDATACURSOR   OUT CONSTANTS.TYREFCURSOR
    )
    IS
        SBSQL                     GE_BOUTILITIES.STYSTATEMENT;
    BEGIN
    
        SBSQL := 'SELECT  /*+ index(estaprog PK_ESTAPROG) */ ' || CHR(10) ||
                          ':nuPackageId  Package_id, estaprog.ESPRPROG, case when substr(estaprog.esprprog,1,4) = ''TTCA''' || CHR(10) ||
                          'then ''Falla autom�tica''' || CHR(10) ||
                          'when substr(estaprog.esprprog,1,4) = ''TTAI''' || CHR(10) ||
                          'then ''Actualizaci�n de Interrupci�n de Servicio''' || CHR(10) ||
                          'when substr(estaprog.esprprog,1,4) = ''TTAE''' || CHR(10) ||
                          'then ''Actualizaci�n de Fallas a elemento''' || CHR(10) ||
                          'when substr(estaprog.esprprog,1,4) = ''TTAF''' || CHR(10) ||
                          'then ''Atenci�n de Fallas''' || CHR(10) ||
                          'when substr(estaprog.esprprog,1,4) = ''TTEL''' || CHR(10) ||
                          'then ''Adici�n de Elementos a Falla a elemento''' || CHR(10) ||
                          'when substr(estaprog.esprprog,1,4) = ''TTRO''' || CHR(10) ||
                          'then ''Registro de Interrupciones Controladas''' || CHR(10) ||
                          'when substr(estaprog.esprprog,1,4) = ''TTCO''' || CHR(10) ||
                          'then ''Atenci�n de Interrupciones Controladas''' || CHR(10) ||
                          'when substr(estaprog.esprprog,1,4) = ''TTRL''' || CHR(10) ||
                          'then ''Retiro de Elementos de Falla a elemento''' || CHR(10) ||
                          'when substr(estaprog.esprprog,1,4) = ''TTRV''' || CHR(10) ||
                          'then ''Revocacion de Elementos de Falla a elemento''' || CHR(10) ||
                          'else ''''' || CHR(10) ||
                          'END PROCESS,' || CHR(10) ||
                          'ESPRMESG, ESPRFEIN, ESPRFEFI, ESPRPORC, ESPRTAPR,' || CHR(10) ||
                          ':parent_id parent_id' || CHR(10) ||
                'FROM estaprog' || CHR(10) ||
                'WHERE estaprog.esprprog like ''%TT%'||INUPACKAGEID||'%''' || CHR(10) ||
                'ORDER BY estaprog.esprfein desc';
                
        UT_TRACE.TRACE('SQL:['||SBSQL||']',1);
        OPEN OCUDATACURSOR FOR SBSQL USING INUPACKAGEID,INUPACKAGEID;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
        
    END;

END TT_BOSEARCHDATASERVICES;