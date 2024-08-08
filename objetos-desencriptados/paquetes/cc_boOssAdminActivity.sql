PACKAGE BODY cc_boOssAdminActivity
IS

    
    
    
    
    CSBVERSION  CONSTANT VARCHAR2(250)  := 'SAO199002';
    
    CNUNULL_ATTRIBUTE       CONSTANT NUMBER := 119742;
    CNUNOTEXISTSUBSCRIBER   CONSTANT NUMBER := 13261;
    
    CNUENTITY_PACKAGE       CONSTANT NUMBER := DAGE_PARAMETER.FSBGETVALUE(MO_BOCONSTANTS.CSBENTITY_PACKAGES); 
    CNUENTITY_MOTIVE        CONSTANT NUMBER := DAGE_PARAMETER.FSBGETVALUE(MO_BOCONSTANTS.CSBENTITY_MOTIVE); 
    CNUENTITY_COMPONENT     CONSTANT NUMBER := DAGE_PARAMETER.FSBGETVALUE(MO_BOCONSTANTS.CSBENTITY_COMPONENT); 
    
    
    
    SBADMACTLOGATTRIB       VARCHAR2(32000);
    
    TBADMINACTATTRIB        CC_TYTBATTRIBUTE;
    TBADMACTLOGATTRIB       CC_TYTBATTRIBUTE;
    
    
    
    FUNCTION FSBVERSION  RETURN VARCHAR2 IS
    BEGIN
        RETURN CSBVERSION;
    END;

    PROCEDURE VALIDATESEARCHDATA
    (
        INUPERSON           GE_PERSON.PERSON_ID%TYPE,
        INUORGAREA          GE_ORGANIZAT_AREA.ORGANIZAT_AREA_ID%TYPE,
        INUPACKAGEID        MO_PACKAGES.PACKAGE_ID%TYPE,
        INUADMINACTIVITYID  MO_ADMIN_ACTIVITY.ADMIN_ACTIVITY_ID%TYPE,
        ISBSTATUS           VARCHAR2,
        INUUNITTYPEID       MO_ADMIN_ACTIVITY.UNIT_TYPE_ID%TYPE,
        INUIDENTTYPEID      GE_IDENTIFICA_TYPE.IDENT_TYPE_ID%TYPE,
        ISBIDENTIFICATION   GE_SUBSCRIBER.IDENTIFICATION%TYPE,
        ONUSUBSCRIBERID     OUT GE_SUBSCRIBER.SUBSCRIBER_ID%TYPE
    )
    IS
        
        BLSUBSCFOUND BOOLEAN;
    BEGIN
        IF (INUPACKAGEID IS NULL) AND (INUADMINACTIVITYID IS NULL) THEN
            IF (INUPERSON IS NULL) AND (INUORGAREA IS NULL) THEN
                ERRORS.SETERROR (CNUNULL_ATTRIBUTE, 'Persona Asignada o Area Organizacional');
                RAISE EX.CONTROLLED_ERROR;
            END IF;
        END IF;

        
        IF (INUPERSON IS NOT NULL) OR (INUORGAREA IS NOT NULL) THEN
            IF (ISBSTATUS IS NULL) THEN
                ERRORS.SETERROR (CNUNULL_ATTRIBUTE, 'Estado');
                RAISE EX.CONTROLLED_ERROR;
            END IF;
        END IF;

        
        IF (INUUNITTYPEID IS NULL) THEN
            ERRORS.SETERROR (CNUNULL_ATTRIBUTE, 'Tipo de Proceso Administrativo');
            RAISE EX.CONTROLLED_ERROR;
        END IF;

        
        IF (INUIDENTTYPEID IS NOT NULL) AND (ISBIDENTIFICATION IS NOT NULL) THEN
            
            BLSUBSCFOUND := GE_BOSUBSCRIBER.VALIDIDENTIFICATION(ISBIDENTIFICATION, INUIDENTTYPEID, ONUSUBSCRIBERID);
            UT_TRACE.TRACE('Cliente encontrado '||ONUSUBSCRIBERID, 5);
            
            IF (NOT BLSUBSCFOUND) THEN
                ERRORS.SETERROR (CNUNOTEXISTSUBSCRIBER, TO_CHAR(INUIDENTTYPEID)||'|'||ISBIDENTIFICATION);
                RAISE EX.CONTROLLED_ERROR;
            END IF;
        END IF;


    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;
    

	PROCEDURE FILLADMINACTATTRIBUTES
	IS
        SBPRIORITY      VARCHAR2(200);
        SBENTITY        VARCHAR2(200);
        SBACTTYPE       VARCHAR2(200);
        SBORGAREA       VARCHAR2(200);
        SBSTATUS        VARCHAR2(200);
        SBPACKAGE       VARCHAR2(200);
        SBLIMITDATE     VARCHAR2(200);
        SBASSIGUSER     VARCHAR2(200);
        SBCOMMENTTYPE   VARCHAR2(200);
        SBCOMMENT       VARCHAR2(200);
    BEGIN
        
        SBADMINACTATTRIB := NULL;

        SBPRIORITY := 'mo_admin_activity.priority_id' || CC_BOBOSSUTIL.CSBSEPARATOR || 'dage_priority.fsbGetDescription(mo_admin_activity.priority_id)';
        SBENTITY := 'mo_admin_activity.entity_id' || CC_BOBOSSUTIL.CSBSEPARATOR || 'dage_entity.fsbGetDescription(mo_admin_activity.entity_id)';
        SBACTTYPE := 'mo_admin_activity.unit_type_id' || CC_BOBOSSUTIL.CSBSEPARATOR || 'dawf_unit_type.fsbGetDescription(mo_admin_activity.unit_type_id)';
        SBORGAREA := 'cc_boOssAdmActData.fsbGetReceiverArea(mo_admin_activity.admin_activity_id)';
        SBSTATUS := 'CC_BOOssAdmActData.fsbGetActivityStatus(mo_admin_activity.admin_activity_id)';
        SBPACKAGE := 'cc_boOssAdmActData.fnuGetPackage(mo_admin_activity.entity_id, mo_admin_activity.external_id)';
        SBLIMITDATE := 'cc_boOssAdmActData.fdtGetLogLimitDate(mo_admin_activity.admin_activity_id)';
        SBASSIGUSER := 'CC_BOOssAdmActData.fsbGetActivityPerson(mo_admin_activity.admin_activity_id)';
        SBCOMMENTTYPE := 'CC_BOOssAdmActData.fsbGetActivityCommentType(mo_admin_activity.admin_activity_id)';
        SBCOMMENT := 'CC_BOOssAdmActData.fsbGetActivityComment(mo_admin_activity.admin_activity_id)';
        
        CC_BOBOSSUTIL.ADDATTRIBUTE ('mo_admin_activity.admin_activity_id', 'admin_activity_id',   CC_BOBOSSUTIL.CNUNUMBER,   SBADMINACTATTRIB, TBADMINACTATTRIB, TRUE);
        CC_BOBOSSUTIL.ADDATTRIBUTE (SBENTITY,                              'entity',              CC_BOBOSSUTIL.CNUVARCHAR2, SBADMINACTATTRIB, TBADMINACTATTRIB);
        CC_BOBOSSUTIL.ADDATTRIBUTE ('mo_admin_activity.external_id',       'external_id',         CC_BOBOSSUTIL.CNUNUMBER,   SBADMINACTATTRIB, TBADMINACTATTRIB);
        CC_BOBOSSUTIL.ADDATTRIBUTE (SBPACKAGE,                             'package_id',          CC_BOBOSSUTIL.CNUNUMBER,   SBADMINACTATTRIB, TBADMINACTATTRIB);
        CC_BOBOSSUTIL.ADDATTRIBUTE (SBACTTYPE,                             'activity_type',       CC_BOBOSSUTIL.CNUNUMBER,   SBADMINACTATTRIB, TBADMINACTATTRIB);
        CC_BOBOSSUTIL.ADDATTRIBUTE (SBSTATUS,                              'activity_status',     CC_BOBOSSUTIL.CNUNUMBER,   SBADMINACTATTRIB, TBADMINACTATTRIB);
        CC_BOBOSSUTIL.ADDATTRIBUTE (SBORGAREA,                             'organizational_area', CC_BOBOSSUTIL.CNUNUMBER,   SBADMINACTATTRIB, TBADMINACTATTRIB);
        CC_BOBOSSUTIL.ADDATTRIBUTE (SBASSIGUSER,                           'person',              CC_BOBOSSUTIL.CNUVARCHAR2, SBADMINACTATTRIB, TBADMINACTATTRIB);
        CC_BOBOSSUTIL.ADDATTRIBUTE (SBPRIORITY,                            'priority',            CC_BOBOSSUTIL.CNUVARCHAR2, SBADMINACTATTRIB, TBADMINACTATTRIB);
        CC_BOBOSSUTIL.ADDATTRIBUTE ('mo_admin_activity.register_date',     'register_date',       CC_BOBOSSUTIL.CNUDATE,     SBADMINACTATTRIB, TBADMINACTATTRIB);
        CC_BOBOSSUTIL.ADDATTRIBUTE ('mo_admin_activity.limit_attend_date', 'limit_att_date',      CC_BOBOSSUTIL.CNUDATE,     SBADMINACTATTRIB, TBADMINACTATTRIB);
        CC_BOBOSSUTIL.ADDATTRIBUTE (SBLIMITDATE,                           'limit_log_att_date',  CC_BOBOSSUTIL.CNUDATE,     SBADMINACTATTRIB, TBADMINACTATTRIB);
        CC_BOBOSSUTIL.ADDATTRIBUTE ('mo_admin_activity.attention_date',    'attention_date',      CC_BOBOSSUTIL.CNUDATE,     SBADMINACTATTRIB, TBADMINACTATTRIB);
        CC_BOBOSSUTIL.ADDATTRIBUTE ('mo_admin_activity.priority_id',       'Priority_Id',         CC_BOBOSSUTIL.CNUNUMBER,   SBADMINACTATTRIB, TBADMINACTATTRIB);
        CC_BOBOSSUTIL.ADDATTRIBUTE (SBCOMMENTTYPE,                         'comment_type',        CC_BOBOSSUTIL.CNUVARCHAR2, SBADMINACTATTRIB, TBADMINACTATTRIB);
        CC_BOBOSSUTIL.ADDATTRIBUTE (SBCOMMENT,                             'comment_',            CC_BOBOSSUTIL.CNUVARCHAR2, SBADMINACTATTRIB, TBADMINACTATTRIB);
        CC_BOBOSSUTIL.ADDATTRIBUTE (':parent_id',                          'parent_id',           CC_BOBOSSUTIL.CNUNUMBER,   SBADMINACTATTRIB, TBADMINACTATTRIB);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

	PROCEDURE GETADMINACTIVITY
        (
            INUADMINACTIVITYID  MO_ADMIN_ACTIVITY.ADMIN_ACTIVITY_ID%TYPE,
            OCUCURSOR           OUT CONSTANTS.TYREFCURSOR
        )
	IS
        SBSQL     VARCHAR2(32767);
	BEGIN
        UT_TRACE.TRACE('Iniciando cc_boOssAdminActivity.GetAdminActivity Proceso['||INUADMINACTIVITYID||']', 5);

        
        SBADMINACTATTRIB := NULL;

        FILLADMINACTATTRIBUTES;

        SBSQL := 'SELECT '|| SBADMINACTATTRIB ||CHR(10)||
                 'FROM mo_admin_activity'||CHR(10)||
                 'WHERE mo_admin_activity.admin_activity_id = :inuAdminActivityId';

        UT_TRACE.TRACE('Consulta los procesos administrativos por id ['||SBSQL||']', 5);

        OPEN OCUCURSOR FOR SBSQL USING CC_BOBOSSUTIL.CNUNULL, INUADMINACTIVITYID;

        UT_TRACE.TRACE('Fin cc_boOssAdminActivity.GetAdminActivity', 5);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;
    
    













































	PROCEDURE GETADMINACTIVITIES
        (
            INUPERSON           GE_PERSON.PERSON_ID%TYPE,
            INUORGAREA          GE_ORGANIZAT_AREA.ORGANIZAT_AREA_ID%TYPE,
            INUPACKAGEID        MO_PACKAGES.PACKAGE_ID%TYPE,
            INUADMINACTIVITYID  MO_ADMIN_ACTIVITY.ADMIN_ACTIVITY_ID%TYPE,
            ISBSTATUS           VARCHAR2,
            INUPROCTYPE         MO_ADMIN_ACTIVITY.UNIT_TYPE_ID%TYPE,
            INUPRIORITY         MO_ADMIN_ACTIVITY.PRIORITY_ID%TYPE,
            IDTINITIALDATE      MO_ADMIN_ACTIVITY.LIMIT_ATTEND_DATE%TYPE,
            IDTFINALDATE        MO_ADMIN_ACTIVITY.LIMIT_ATTEND_DATE%TYPE,
            ISBEXPIRED          VARCHAR2,
            INUIDENTTYPEID      GE_IDENTIFICA_TYPE.IDENT_TYPE_ID%TYPE,
            ISBIDENTIFICATION   GE_SUBSCRIBER.IDENTIFICATION%TYPE,
            OCUCURSOR           OUT CONSTANTS.TYREFCURSOR
        )
	IS
        NUPERSON           NUMBER;
        NUORGAREA          NUMBER;
        NUPACKAGEID        NUMBER;
        NUADMINACTIVITYID  NUMBER;
        SBSTATUS           VARCHAR2(100);
        NUPROCTYPE         NUMBER;
        NUPRIORITY         NUMBER;
        DTINITIALDATE      DATE := IDTINITIALDATE;
        DTFINALDATE        DATE := IDTFINALDATE;
        SBWHERE            VARCHAR2(5000);
        SBSQL              VARCHAR2(32767);
        SBFROM             VARCHAR2(5000) := ' ';
        SBFROMINIT         GE_BOUTILITIES.STYSTATEMENTATTRIBUTE;
        BLADMINACTIVITY    BOOLEAN := FALSE;
        RCCURRENTLOG       DAMO_ACTIVITY_LOG.STYMO_ACTIVITY_LOG;
        NUSUBSCRIBERID     GE_SUBSCRIBER.SUBSCRIBER_ID%TYPE := NULL;
	BEGIN
        UT_TRACE.TRACE('Iniciando cc_boOssAdminActivity.GetAdminActivities', 5);

        VALIDATESEARCHDATA(INUPERSON, INUORGAREA, INUPACKAGEID, INUADMINACTIVITYID,
                           ISBSTATUS, INUPROCTYPE, INUIDENTTYPEID, ISBIDENTIFICATION,
                           NUSUBSCRIBERID);
        UT_TRACE.TRACE('Cliente obtenido '||NUSUBSCRIBERID, 6);

        NUPERSON           := NVL(INUPERSON,CC_BOCONSTANTS.CNUAPPLICATIONNULL);
        NUORGAREA          := NVL(INUORGAREA,CC_BOCONSTANTS.CNUAPPLICATIONNULL);
        NUPACKAGEID        := NVL(INUPACKAGEID,CC_BOCONSTANTS.CNUAPPLICATIONNULL);
        NUADMINACTIVITYID  := NVL(INUADMINACTIVITYID,CC_BOCONSTANTS.CNUAPPLICATIONNULL);
        SBSTATUS           := NVL(ISBSTATUS, CC_BOCONSTANTS.CSBNULLSTRING);
        NUPROCTYPE         := NVL(INUPROCTYPE,CC_BOCONSTANTS.CNUAPPLICATIONNULL);
        NUPRIORITY         := NVL(INUPRIORITY,CC_BOCONSTANTS.CNUAPPLICATIONNULL);
        NUSUBSCRIBERID     := NVL(NUSUBSCRIBERID,CC_BOCONSTANTS.CNUAPPLICATIONNULL);

        
        FILLADMINACTATTRIBUTES;

        SBWHERE := NULL;

        
        IF NUADMINACTIVITYID != CC_BOCONSTANTS.CNUAPPLICATIONNULL THEN
            SBWHERE := 'mo_admin_activity.admin_activity_id = :AdmActId'||CHR(10)||' AND ';
        ELSE
            SBWHERE := CHR(39)|| TO_CHAR(NUADMINACTIVITYID) ||CHR(39)||' = :AdmActId'||CHR(10)||' AND ';
        END IF;

        
        IF NUORGAREA != CC_BOCONSTANTS.CNUAPPLICATIONNULL THEN
            SBWHERE := SBWHERE || 'mo_activity_log.receiver_area_id = :OrgArea'||CHR(10)||' AND ';
        ELSE
            SBWHERE := SBWHERE || CHR(39)|| TO_CHAR(NUORGAREA) ||CHR(39)||' = :OrgArea'||CHR(10)||' AND ';
        END IF;

        
        IF NUPERSON != CC_BOCONSTANTS.CNUAPPLICATIONNULL THEN
            SBWHERE := SBWHERE || 'mo_activity_log.receiver_person_id = :nuPerson'||CHR(10)||' AND ';
        ELSE
            SBWHERE := SBWHERE || CHR(39)|| TO_CHAR(NUPERSON) ||CHR(39)||' = :nuPerson'||CHR(10)||' AND ';
        END IF;

        
        IF NUPROCTYPE != CC_BOCONSTANTS.CNUAPPLICATIONNULL THEN
            SBWHERE := SBWHERE || 'mo_admin_activity.unit_type_id = :nuProcType'||CHR(10)||' AND ';
        ELSE
            SBWHERE := SBWHERE || CHR(39)|| TO_CHAR(NUPROCTYPE) ||CHR(39)||' = :nuProcType'||CHR(10)||' AND ';
        END IF;

        
        IF NUPRIORITY != CC_BOCONSTANTS.CNUAPPLICATIONNULL THEN
            SBWHERE := SBWHERE || 'mo_admin_activity.priority_id = :nuPriority'||CHR(10)||' AND ';
        ELSE
            SBWHERE := SBWHERE || CHR(39)|| TO_CHAR(NUPRIORITY) ||CHR(39)||' = :nuPriority'||CHR(10)||' AND ';
        END IF;

        
        IF SBSTATUS != CC_BOCONSTANTS.CSBNULLSTRING THEN
            IF SBSTATUS = '0' THEN
                SBWHERE := SBWHERE || 'mo_admin_activity.attention_date IS NULL'||CHR(10)||' AND ';
            ELSE
                SBWHERE := SBWHERE || 'mo_admin_activity.attention_date IS not NULL'||CHR(10)||' AND ';
            END IF;
        END IF;

        
        IF NUPACKAGEID != CC_BOCONSTANTS.CSBNULLSTRING THEN
            SBFROMINIT := '( '||CHR(10)||
                'SELECT  /*+ index(Mo_Component IDX_MO_COMPONENT_2) */ b.component_id, '||
                    CHR(39)|| TO_CHAR(CNUENTITY_COMPONENT) ||CHR(39)|| ' entity'||CHR(10)||
                'FROM Mo_Component b  '||CHR(10)||
                'WHERE b.Package_Id = :nuPackageId  union all '||CHR(10)||
                'SELECT  /*+ index(Mo_Motive IDX_MO_MOTIVE_02) */ b.motive_id, '||
                    CHR(39)|| TO_CHAR(CNUENTITY_MOTIVE) ||CHR(39)|| ' entity'||CHR(10)||
                'FROM Mo_Motive b  '||CHR(10)||
                'WHERE b.Package_Id = :nuPackageId  union all '||CHR(10)||
                'SELECT  /*+ index(mo_packages PK_MO_PACKAGES) */ b.package_id, '||
                    CHR(39)|| TO_CHAR(CNUENTITY_PACKAGE) ||CHR(39)|| ' entity'||CHR(10)||
                'FROM mo_packages b  '||CHR(10)||
                'WHERE b.package_id = :nuPackageId '||') package,'||CHR(10);
                
            SBWHERE := SBWHERE || ' mo_admin_activity.External_Id = package.Component_Id' || CHR(10) ||
                       'AND mo_admin_activity.Entity_Id = package.entity'||CHR(10)||' AND ';
        ELSE
            SBFROMINIT := ' ';
            SBWHERE := CHR(39)|| TO_CHAR(NUPACKAGEID) ||CHR(39)||' = :nuPackageId'||CHR(10)||' AND ' || SBWHERE;
            SBWHERE := CHR(39)|| TO_CHAR(NUPACKAGEID) ||CHR(39)||' = :nuPackageId'||CHR(10)||' AND ' || SBWHERE;
            SBWHERE := CHR(39)|| TO_CHAR(NUPACKAGEID) ||CHR(39)||' = :nuPackageId'||CHR(10)||' AND ' || SBWHERE;
        END IF;

        
        IF (NUSUBSCRIBERID != CC_BOCONSTANTS.CNUAPPLICATIONNULL) THEN
            SBWHERE := SBWHERE || 'mo_admin_activity.external_id in( '||CHR(10)||
                'SELECT b.component_id '||CHR(10)||
                'FROM Mo_Component b, mo_packages c '||CHR(10)||
                'WHERE mo_admin_activity.External_Id = b.Component_Id '||CHR(10)||
                'AND mo_admin_activity.entity_id = '|| CHR(39)|| TO_CHAR(CNUENTITY_COMPONENT) ||CHR(39)||CHR(10)||
                'AND b.Package_Id = c.Package_Id '||CHR(10)||
                'AND c.subscriber_id  = :cliente '||CHR(10)||
                'union all '||CHR(10)||
                'SELECT b.motive_id '||CHR(10)||
                'FROM Mo_Motive b, mo_packages c '||CHR(10)||
                'WHERE mo_admin_activity.External_Id = b.Motive_Id '||CHR(10)||
                'AND mo_admin_activity.Entity_Id = '|| CHR(39)|| TO_CHAR(CNUENTITY_MOTIVE) ||CHR(39)||CHR(10)||
                'AND b.Package_Id = c.Package_Id '||CHR(10)||
                'AND c.subscriber_id  = :cliente  '||CHR(10)||
                'union all '||CHR(10)||
                'SELECT b.package_id  '||CHR(10)||
                'FROM mo_packages b  '||CHR(10)||
                'WHERE mo_admin_activity.External_Id = b.package_id  '||CHR(10)||
                'AND mo_admin_activity.Entity_Id = '|| CHR(39)|| TO_CHAR(CNUENTITY_PACKAGE) ||CHR(39)||CHR(10)||
                'AND b.subscriber_id  = :cliente )'||CHR(10)||' AND ';
        ELSE
            SBWHERE := SBWHERE || CHR(39)|| TO_CHAR(NUSUBSCRIBERID) ||CHR(39)||' = :cliente'||CHR(10)||' AND ';
            SBWHERE := SBWHERE || CHR(39)|| TO_CHAR(NUSUBSCRIBERID) ||CHR(39)||' = :cliente'||CHR(10)||' AND ';
            SBWHERE := SBWHERE || CHR(39)|| TO_CHAR(NUSUBSCRIBERID) ||CHR(39)||' = :cliente'||CHR(10)||' AND ';
        END IF;

        
        IF ISBEXPIRED = MO_BOPARAMETER.FSBGETYES THEN
            SBWHERE := SBWHERE || '(Mo_Activity_Log.limit_date < sysdate OR Mo_Admin_Activity.limit_attend_date < sysdate)'||CHR(10)||' AND ';
        END IF;

        
        IF (DTINITIALDATE IS NOT NULL) OR (DTFINALDATE IS NOT NULL) THEN
            CC_BOBOSSUTIL.QUERYTYPEDATES (CC_BOBOSSUTIL.FNUQUERYBYBETWEEN, NULL, DTINITIALDATE, DTFINALDATE);
            SBWHERE := SBWHERE || 'Mo_Activity_Log.limit_date >= :dtInitialDate'||CHR(10)||' AND '||
                                  'Mo_Activity_Log.limit_date <= :dtFinalDate'||CHR(10)||' AND ';
        END IF;

        
        IF (NUORGAREA != CC_BOCONSTANTS.CNUAPPLICATIONNULL) OR (NUPERSON != CC_BOCONSTANTS.CNUAPPLICATIONNULL)
            OR (ISBEXPIRED = MO_BOPARAMETER.FSBGETYES) OR (DTINITIALDATE IS NOT NULL) THEN

            SBFROM := ', (SELECT /*+ index(mo_activity_log IDX_MO_ACTIVITY_LOG_03 )*/
                                          activity_log_id,rank() over(partition BY admin_activity_id ORDER BY register_date desc) rank
                                          FROM mo_activity_log
                                          where  ';
                                          
            IF NUPERSON != CC_BOCONSTANTS.CNUAPPLICATIONNULL THEN
                SBFROM := SBFROM || 'mo_activity_log.receiver_person_id = :nuPerson'||CHR(10)||' AND ';
            ELSE
                SBFROM := SBFROM || CHR(39)|| TO_CHAR(NUPERSON) ||CHR(39)||' = :nuPerson'||CHR(10)||' AND ';
            END IF;

            IF NUORGAREA != CC_BOCONSTANTS.CNUAPPLICATIONNULL THEN
                SBFROM := SBFROM || 'mo_activity_log.receiver_area_id = :OrgArea ';
            ELSE
                SBFROM := SBFROM || CHR(39)|| TO_CHAR(NUORGAREA) ||CHR(39)||' = :OrgArea ';
            END IF;

            SBFROM := SBFROM ||') b ';
            
            
            SBWHERE := SBWHERE || ' mo_activity_log.activity_log_id = b.activity_log_id   AND
                                    rank = 1  AND ';
            
            BLADMINACTIVITY := TRUE;
            
            
        END IF;
        
        SBWHERE := SUBSTR (SBWHERE, 0, LENGTH (SBWHERE) - 5);

        
        SBSQL := 'SELECT  /*+ index(mo_admin_activity IDX_MO_ADMIN_ACTIVITY03) use_nl(mo_admin_activity mo_activity_log)  */  unique '|| SBADMINACTATTRIB ||CHR(10)||
                 'FROM ' || SBFROMINIT ||'mo_admin_activity, mo_activity_log  '||SBFROM||CHR(10)||' /*+ cc_boOssAdminActivity.GetAdminActivities */'||CHR(10)||
                 'WHERE mo_admin_activity.admin_activity_id = mo_activity_log.admin_activity_id AND '||CHR(10)||SBWHERE ||
                 'ORDER BY  mo_admin_activity.priority_id desc, mo_admin_activity.limit_attend_date asc';

        UT_TRACE.TRACE('B�squeda de procesos administrativos ['||SBSQL||']', 5);
        
        
        IF BLADMINACTIVITY THEN

            
            IF (DTINITIALDATE IS NULL) OR (DTFINALDATE IS NULL) THEN
                IF NUPACKAGEID != CC_BOCONSTANTS.CSBNULLSTRING THEN
                    OPEN OCUCURSOR FOR SBSQL USING  CC_BOBOSSUTIL.CNUNULL, NUPACKAGEID, NUPACKAGEID, NUPACKAGEID, NUPERSON, NUORGAREA, NUADMINACTIVITYID,
                                                    NUORGAREA, NUPERSON, NUPROCTYPE, NUPRIORITY, NUSUBSCRIBERID, NUSUBSCRIBERID, NUSUBSCRIBERID;
                ELSE
                    OPEN OCUCURSOR FOR SBSQL USING  CC_BOBOSSUTIL.CNUNULL, NUPERSON, NUORGAREA, NUPACKAGEID, NUPACKAGEID, NUPACKAGEID, NUADMINACTIVITYID,
                                                    NUORGAREA, NUPERSON, NUPROCTYPE, NUPRIORITY, NUSUBSCRIBERID, NUSUBSCRIBERID, NUSUBSCRIBERID;
                END IF;

            ELSE
            
                IF NUPACKAGEID != CC_BOCONSTANTS.CSBNULLSTRING THEN
                    OPEN OCUCURSOR FOR SBSQL USING  CC_BOBOSSUTIL.CNUNULL, NUPACKAGEID, NUPACKAGEID, NUPACKAGEID, NUPERSON, NUORGAREA, NUADMINACTIVITYID,
                                                    NUORGAREA, NUPERSON, NUPROCTYPE, NUPRIORITY, NUSUBSCRIBERID, NUSUBSCRIBERID, NUSUBSCRIBERID,
                                                    DTINITIALDATE, DTFINALDATE;
                ELSE
                    OPEN OCUCURSOR FOR SBSQL USING  CC_BOBOSSUTIL.CNUNULL, NUPERSON, NUORGAREA, NUPACKAGEID, NUPACKAGEID, NUPACKAGEID, NUADMINACTIVITYID,
                                                    NUORGAREA, NUPERSON, NUPROCTYPE, NUPRIORITY, NUSUBSCRIBERID, NUSUBSCRIBERID, NUSUBSCRIBERID,
                                                    DTINITIALDATE, DTFINALDATE;
                END IF;

            END IF;
        
        ELSE
        
                    
            IF (DTINITIALDATE IS NULL) OR (DTFINALDATE IS NULL) THEN
                OPEN OCUCURSOR FOR SBSQL USING  CC_BOBOSSUTIL.CNUNULL, NUPACKAGEID, NUPACKAGEID, NUPACKAGEID, NUADMINACTIVITYID, NUORGAREA,
                                                NUPERSON, NUPROCTYPE, NUPRIORITY, NUSUBSCRIBERID, NUSUBSCRIBERID, NUSUBSCRIBERID;
            ELSE
                OPEN OCUCURSOR FOR SBSQL USING  CC_BOBOSSUTIL.CNUNULL, NUPACKAGEID, NUPACKAGEID, NUPACKAGEID, NUADMINACTIVITYID, NUORGAREA,
                                                NUPERSON, NUPROCTYPE, NUPRIORITY, NUSUBSCRIBERID, NUSUBSCRIBERID, NUSUBSCRIBERID,
                                                DTINITIALDATE, DTFINALDATE;
            END IF;
        
        END IF;

        UT_TRACE.TRACE('Fin cc_boOssAdminActivity.GetAdminActivities', 5);
        
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;


	PROCEDURE FILLADMACTLOGATTRIBUTES
	IS
        SBACTION        VARCHAR2(300);
        SBSOURCEPERSON  VARCHAR2(300);
        SBRECPERSON     VARCHAR2(300);
        SBSOURCEAREA    VARCHAR2(300);
        SBRECAREA       VARCHAR2(300);
        SBCOMMTYPE      VARCHAR2(300);
        SBNOTLOG        VARCHAR2(300);
    BEGIN
        
        SBADMACTLOGATTRIB := NULL;
        
        SBACTION := 'mo_activity_log.action_id' || CC_BOBOSSUTIL.CSBSEPARATOR || 'dage_action_module.fsbGetDescription(mo_activity_log.action_id)';
        SBSOURCEPERSON := 'mo_activity_log.source_person_id' || CC_BOBOSSUTIL.CSBSEPARATOR || 'cc_boossdescription.fsbPerson(mo_activity_log.source_person_id)';
        SBRECPERSON := 'mo_activity_log.receiver_person_id' || CC_BOBOSSUTIL.CSBSEPARATOR || 'cc_boossdescription.fsbPerson(mo_activity_log.receiver_person_id)';
        SBSOURCEAREA := 'mo_activity_log.source_area_id' || CC_BOBOSSUTIL.CSBSEPARATOR || 'dage_organizat_area.fsbGetName_(mo_activity_log.source_area_id)';
        SBRECAREA := 'mo_activity_log.receiver_area_id' || CC_BOBOSSUTIL.CSBSEPARATOR || 'dage_organizat_area.fsbGetName_(mo_activity_log.receiver_area_id)';
        SBCOMMTYPE := 'mo_activity_log.comment_type_id' || CC_BOBOSSUTIL.CSBSEPARATOR || 'dage_comment_type.fsbGetDescription(mo_activity_log.comment_type_id)';
        

        CC_BOBOSSUTIL.ADDATTRIBUTE ('mo_activity_log.activity_log_id',      'activity_log_id',     CC_BOBOSSUTIL.CNUNUMBER,   SBADMACTLOGATTRIB, TBADMACTLOGATTRIB, TRUE);
        CC_BOBOSSUTIL.ADDATTRIBUTE (SBACTION,                               'action_id',           CC_BOBOSSUTIL.CNUVARCHAR2, SBADMACTLOGATTRIB, TBADMACTLOGATTRIB);
        CC_BOBOSSUTIL.ADDATTRIBUTE (SBSOURCEPERSON,                         'source_person_id',    CC_BOBOSSUTIL.CNUVARCHAR2, SBADMACTLOGATTRIB, TBADMACTLOGATTRIB);
        CC_BOBOSSUTIL.ADDATTRIBUTE (SBRECPERSON,                            'receiver_person_id',  CC_BOBOSSUTIL.CNUVARCHAR2, SBADMACTLOGATTRIB, TBADMACTLOGATTRIB);
        CC_BOBOSSUTIL.ADDATTRIBUTE (SBSOURCEAREA,                           'source_area_id',      CC_BOBOSSUTIL.CNUVARCHAR2, SBADMACTLOGATTRIB, TBADMACTLOGATTRIB);
        CC_BOBOSSUTIL.ADDATTRIBUTE (SBRECAREA,                              'receiver_area_id',    CC_BOBOSSUTIL.CNUVARCHAR2, SBADMACTLOGATTRIB, TBADMACTLOGATTRIB);
        CC_BOBOSSUTIL.ADDATTRIBUTE ('mo_activity_log.register_date',        'register_date',       CC_BOBOSSUTIL.CNUDATE,     SBADMACTLOGATTRIB, TBADMACTLOGATTRIB);
        CC_BOBOSSUTIL.ADDATTRIBUTE (SBCOMMTYPE,                             'comment_type_id',     CC_BOBOSSUTIL.CNUVARCHAR2, SBADMACTLOGATTRIB, TBADMACTLOGATTRIB);
        CC_BOBOSSUTIL.ADDATTRIBUTE ('mo_activity_log.comment_',             'comment_',            CC_BOBOSSUTIL.CNUVARCHAR2, SBADMACTLOGATTRIB, TBADMACTLOGATTRIB);
        CC_BOBOSSUTIL.ADDATTRIBUTE ('mo_activity_log.limit_date',           'limit_date',          CC_BOBOSSUTIL.CNUDATE,     SBADMACTLOGATTRIB, TBADMACTLOGATTRIB);
        CC_BOBOSSUTIL.ADDATTRIBUTE ('mo_activity_log.notification_log_id',  'notification_log_id', CC_BOBOSSUTIL.CNUNUMBER,   SBADMACTLOGATTRIB, TBADMACTLOGATTRIB);
        CC_BOBOSSUTIL.ADDATTRIBUTE (':parent_id',                           'parent_id',           CC_BOBOSSUTIL.CNUNUMBER,   SBADMACTLOGATTRIB, TBADMACTLOGATTRIB);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

	PROCEDURE GETADMINACTIVITYLOG
        (
            INUADMACTLOGID      MO_ACTIVITY_LOG.ACTIVITY_LOG_ID%TYPE,
            OCUCURSOR           OUT CONSTANTS.TYREFCURSOR
        )
	IS
        SBSQL     VARCHAR2(32767);
	BEGIN
        UT_TRACE.TRACE('Iniciando cc_boOssAdminActivity.GetAdminActivityLog Bit�cora['||INUADMACTLOGID||']', 5);

        
        SBADMACTLOGATTRIB := NULL;

        FILLADMACTLOGATTRIBUTES;

        SBSQL := 'SELECT '|| SBADMACTLOGATTRIB ||CHR(10)||
                 'FROM mo_activity_log'||CHR(10)||
                 'WHERE mo_activity_log.activity_log_id = :inuAdmActLogId';

        UT_TRACE.TRACE('Consulta los logs de los procesos administrativos por log id ['||SBSQL||']', 5);

        OPEN OCUCURSOR FOR SBSQL USING CC_BOBOSSUTIL.CNUNULL, INUADMACTLOGID;

        UT_TRACE.TRACE('Fin cc_boOssAdminActivity.GetAdminActivityLog', 5);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

	PROCEDURE GETLOGSBYADMINACT
        (
            INUADMINACTIVITYID  MO_ADMIN_ACTIVITY.ADMIN_ACTIVITY_ID%TYPE,
            OCUCURSOR           OUT CONSTANTS.TYREFCURSOR
        )
	IS
        SBSQL     VARCHAR2(32767);
	BEGIN
        UT_TRACE.TRACE('Iniciando cc_boOssAdminActivity.GetLogByAdminAct Proceso['||INUADMINACTIVITYID||']', 5);

        
        SBADMACTLOGATTRIB := NULL;

        FILLADMACTLOGATTRIBUTES;

        SBSQL := 'SELECT '|| SBADMACTLOGATTRIB ||CHR(10)||
                 'FROM mo_activity_log'||CHR(10)||
                 'WHERE mo_activity_log.admin_activity_id = :inuAdminActivityId'||CHR(10)||
                 'ORDER BY mo_activity_log.register_date desc';

        UT_TRACE.TRACE('Consulta los logs de los procesos administrativos por proceso ['||SBSQL||']', 5);

        OPEN OCUCURSOR FOR SBSQL USING INUADMINACTIVITYID, INUADMINACTIVITYID;

        UT_TRACE.TRACE('Fin cc_boOssAdminActivity.GetLogByAdminAct', 5);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    PROCEDURE GETADMINACTIVITYID
    (
        INULOGID        IN NUMBER,
        ONUADMINACTID   OUT NUMBER
    )
    IS
    BEGIN
        IF INULOGID IS NULL THEN
            ONUADMINACTID := NULL;
            RETURN;
        END IF;

        DAMO_ACTIVITY_LOG.ACCKEY (INULOGID);

        ONUADMINACTID := DAMO_ACTIVITY_LOG.FNUGETADMIN_ACTIVITY_ID(INULOGID);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ONUADMINACTID := NULL;

        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;
    

END CC_BOOSSADMINACTIVITY;