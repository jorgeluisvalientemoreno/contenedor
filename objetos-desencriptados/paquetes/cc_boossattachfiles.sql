PACKAGE BODY cc_boOssAttachFiles
AS
    
    
    
    
    CSBVERSION CONSTANT VARCHAR2(10) := 'SAO198301';
    
    
    CNUCUSTOMERLEVEL NUMBER := 1198;
    
    
    CSBREQUESTENTITY VARCHAR2(10) := 'REQUEST';
    
    
    

    
    
    

    
    
    

    CSBATTACH_FILE_MODE     CONSTANT GE_PARAMETER.PARAMETER_ID%TYPE := 'ATTACH_FILE_MODE';
    CSBFILE_SYSTEMS         CONSTANT GE_PARAMETER.VALUE%TYPE := 'FILE_SYSTEMS';

    
    
    

FUNCTION FSBVERSION
RETURN VARCHAR2
IS
BEGIN
    RETURN CSBVERSION;

EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
        RAISE EX.CONTROLLED_ERROR;

    WHEN OTHERS THEN
        ERRORS.SETERROR;
        RAISE EX.CONTROLLED_ERROR;
END;




















PROCEDURE FILLATTACHFILEATTRIBUTES
IS
    SBFILETYPE   VARCHAR2(200);
BEGIN

    
    IF ( SBATTACHFILEATT IS NOT NULL ) THEN
        RETURN;
    END IF;

    SBFILETYPE  := 'cc_file.file_type_id'  ||CC_BOBOSSUTIL.CSBSEPARATOR||'cc_boOssDescription.fsbGetFileTypeDesc (cc_file.file_type_id)';

    
    CC_BOBOSSUTIL.ADDATTRIBUTE ('cc_file.file_id',          'file_id',       CC_BOBOSSUTIL.CNUNUMBER,   SBATTACHFILEATT, TBATTACHFILEATTRIBUTE, TRUE);
    CC_BOBOSSUTIL.ADDATTRIBUTE (SBFILETYPE,                 'file_type',     CC_BOBOSSUTIL.CNUVARCHAR2, SBATTACHFILEATT, TBATTACHFILEATTRIBUTE);
    CC_BOBOSSUTIL.ADDATTRIBUTE ('cc_file.file_name',        'file_name',     CC_BOBOSSUTIL.CNUVARCHAR2, SBATTACHFILEATT, TBATTACHFILEATTRIBUTE);
    CC_BOBOSSUTIL.ADDATTRIBUTE ('cc_file.observation',      'observation',   CC_BOBOSSUTIL.CNUVARCHAR2, SBATTACHFILEATT, TBATTACHFILEATTRIBUTE);
    CC_BOBOSSUTIL.ADDATTRIBUTE ('cc_file.file_size',        'file_size',     CC_BOBOSSUTIL.CNUNUMBER,   SBATTACHFILEATT, TBATTACHFILEATTRIBUTE);
    CC_BOBOSSUTIL.ADDATTRIBUTE ('cc_file.load_date',        'load_date',     CC_BOBOSSUTIL.CNUDATE,     SBATTACHFILEATT, TBATTACHFILEATTRIBUTE);
    CC_BOBOSSUTIL.ADDATTRIBUTE (':parent_id',               'parent_id',     CC_BOBOSSUTIL.CNUNUMBER,   SBATTACHFILEATT, TBATTACHFILEATTRIBUTE);

EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
        RAISE EX.CONTROLLED_ERROR;
    WHEN OTHERS THEN
        ERRORS.SETERROR;
        RAISE EX.CONTROLLED_ERROR;
END;



PROCEDURE ATTATTACHFILE
(
    OCUCURSOR OUT CONSTANTS.TYREFCURSOR
)
IS
BEGIN
    FILLATTACHFILEATTRIBUTES;

    OPEN OCUCURSOR FOR
        SELECT * FROM TABLE (CAST (TBATTACHFILEATTRIBUTE AS CC_TYTBATTRIBUTE));

EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
        RAISE EX.CONTROLLED_ERROR;

    WHEN OTHERS THEN
        ERRORS.SETERROR;
        RAISE EX.CONTROLLED_ERROR;
END;



PROCEDURE GETATTACHFILE
(
    INUFILE             IN   CC_FILE.FILE_ID%TYPE,
    OCUATTACHFILE       OUT  CONSTANTS.TYREFCURSOR
)
IS
    SB_SQL              VARCHAR2(32000);
BEGIN

    UT_TRACE.TRACE('Inicio de cc_boOssAttachFiles.GetAttachFile Archivo['||INUFILE||']', 5);

    SB_SQL           :=  NULL;

    FILLATTACHFILEATTRIBUTES;

    
    SB_SQL  :=   ' SELECT '|| SBATTACHFILEATT || CHR(10) ||
                 ' FROM    cc_file'  || CHR(10) ||
                 ' WHERE cc_file.file_id = :FileId';


    UT_TRACE.TRACE('Consulta ['||SB_SQL||']', 5);

    OPEN OCUATTACHFILE FOR SB_SQL USING CC_BOBOSSUTIL.CNUNULL, INUFILE;

    UT_TRACE.TRACE('Fin de cc_boOssAttachFiles.GetAttachFile', 5);

EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
        RAISE EX.CONTROLLED_ERROR;
    WHEN OTHERS THEN
        ERRORS.SETERROR;
        RAISE EX.CONTROLLED_ERROR;
END;




PROCEDURE GETATTACHFILES
(
    SBFILENAME          IN   CC_FILE.FILE_NAME%TYPE,
    OCUATTACHFILES      OUT  CONSTANTS.TYREFCURSOR
)
IS
    SB_SQL              VARCHAR2(32000);
    SBFILTERS           VARCHAR2(4000);
BEGIN
    UT_TRACE.TRACE('Inicio de cc_boOssAttachFiles.GetAttachFiles Nombre archivo['||SBFILENAME||']', 5);

    SB_SQL           :=  NULL;

    FILLATTACHFILEATTRIBUTES;
    
    SBFILTERS := NULL;
    
    
    IF SBFILENAME != CC_BOCONSTANTS.CSBNULLSTRING THEN
        SBFILTERS := SBFILTERS ||' upper(cc_file.file_name) LIKE upper('||CHR(39)||'%'||SBFILENAME||'%'||CHR(39)||')'||CHR(10);
    END IF;

    
    SB_SQL  :=   ' SELECT '|| SBATTACHFILEATT || CHR(10) ||
                 ' FROM    cc_file'  || CHR(10) ||
                 ' WHERE '|| SBFILTERS;


    UT_TRACE.TRACE('Consulta ['||SB_SQL||']', 5);

    OPEN OCUATTACHFILES FOR SB_SQL USING CC_BOBOSSUTIL.CNUNULL;

    UT_TRACE.TRACE('Fin de cc_boOssAttachFiles.GetAttachFiles', 5);

EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
        RAISE EX.CONTROLLED_ERROR;
    WHEN OTHERS THEN
        ERRORS.SETERROR;
        RAISE EX.CONTROLLED_ERROR;
END;



    PROCEDURE GETPARENTID
    (
        INUFILE          IN   CC_FILE.FILE_ID%TYPE,
        ONUPARENTID      OUT  NUMBER
    )
    IS
        SBOBJECT_LEVEL   CC_FILE.OBJECT_LEVEL%TYPE;
    BEGIN
    UT_TRACE.TRACE('Inicio de cc_boOssAttachFiles.GetParentId Archivo['||INUFILE||']', 5);

        IF INUFILE IS NULL THEN
            ONUPARENTID := NULL;
            RETURN;
        END IF;

        
        DACC_FILE.ACCKEY (INUFILE);

        
        SBOBJECT_LEVEL := DACC_FILE.FSBGETOBJECT_LEVEL(INUFILE);
        IF (SBOBJECT_LEVEL = CC_BOCONSTANTS.FSBCUSTOMERNODELEVEL) THEN
            ONUPARENTID := DACC_FILE.FNUGETOBJECT_ID (INUFILE);
        ELSE
            ONUPARENTID := NULL;
        END IF;

        UT_TRACE.TRACE('ParentId ['||ONUPARENTID||']', 4);

    UT_TRACE.TRACE('Fin de cc_boOssAttachFiles.GetParentId', 5);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ONUPARENTID := NULL;

        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    
























    PROCEDURE GETATTACHEDFILES
    (
       ISBOBJECTLEVEL   IN      CC_FILE.OBJECT_LEVEL%TYPE,
       INUOBJECTID      IN      CC_FILE.OBJECT_ID%TYPE,
       ORFCURSOR        OUT     CONSTANTS.TYREFCURSOR
    )
    IS
    BEGIN
        UT_TRACE.TRACE('Inicio CC_BOOssAttachFiles.GetAttachedFiles['||ISBOBJECTLEVEL||']['||INUOBJECTID||']', 5);

        
        IF  (DAGE_PARAMETER.FSBGETVALUE(CSBATTACH_FILE_MODE) = CSBFILE_SYSTEMS) THEN
            
            CC_BOATTACHFILES.GETFILEATRIBUTES(ISBOBJECTLEVEL, INUOBJECTID, ORFCURSOR);
        ELSE
            CC_BOOSSATTACHFILES.FILLATTACHFILEATTRIBUTES;
        
            
            OPEN    ORFCURSOR
            FOR     'SELECT /*+ index(cc_file UX_CC_FILE01) */' || SBATTACHFILEATT || CHR(10) ||
                    'FROM cc_file'  || CHR(10) ||
                    '/*+ CC_BOOssAttachFiles.GetAttachedFiles */' || CHR(10) ||
                    'WHERE cc_file.object_id = :ObjectId' || CHR(10) ||
                    'AND cc_file.object_level = :ObjectLevel'
            USING   INUOBJECTID, INUOBJECTID, ISBOBJECTLEVEL;
            
        END IF;
        
        UT_TRACE.TRACE('Fin CC_boOssAttachFiles.GetAttachedFiles', 5);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETATTACHEDFILES;
    
    
















    PROCEDURE GETATTACHEDFILES
    (
       ITBOBJECTLEVEL   IN      GE_TYTBSTRING,
       INUOBJECTID      IN      CC_FILE.OBJECT_ID%TYPE,
       ORFCURSOR        OUT     CONSTANTS.TYREFCURSOR
    )
    IS
    BEGIN
        UT_TRACE.TRACE('Inicio cc_boOssAttachFiles.GetAttachedFiles['||ITBOBJECTLEVEL.COUNT||']['||INUOBJECTID||']', 5);
        
        
        IF  (ITBOBJECTLEVEL.COUNT = 1) THEN
            CC_BOOSSATTACHFILES.GETATTACHEDFILES(ITBOBJECTLEVEL(ITBOBJECTLEVEL.FIRST), INUOBJECTID, ORFCURSOR);
        ELSE
            
            IF  (DAGE_PARAMETER.FSBGETVALUE(CSBATTACH_FILE_MODE) = CSBFILE_SYSTEMS) THEN
                
                CC_BOATTACHFILES.GETFILEATRIBUTES(ITBOBJECTLEVEL(ITBOBJECTLEVEL.FIRST), INUOBJECTID, ORFCURSOR);
            ELSE
                CC_BOOSSATTACHFILES.FILLATTACHFILEATTRIBUTES;

                
                OPEN    ORFCURSOR
                FOR     'SELECT /*+ index(cc_file UX_CC_FILE01) */' || SBATTACHFILEATT || CHR(10) ||
                        'FROM    cc_file'  || CHR(10) ||
                        '/*+ CC_BOOssAttachFiles.GetAttachedFiles */' || CHR(10) ||
                        'WHERE cc_file.object_id = :ObjectId' || CHR(10) ||
                        'AND cc_file.object_level IN (SELECT  column_value FROM TABLE(CAST(:ObjectLevel AS ge_tytbString)))'
                USING   INUOBJECTID, INUOBJECTID, ITBOBJECTLEVEL;

            END IF;
        
        END IF;
        
        UT_TRACE.TRACE('Fin cc_boOssAttachFiles.GetAttachedFiles', 5);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETATTACHEDFILES;

    

















    PROCEDURE GETDAMAGESATTACHEDFILES
    (
       ISBOBJECTTYPE    IN      GE_ENTITY.NAME_%TYPE,
       INUOBJECTID      IN      CC_FILE.OBJECT_ID%TYPE,
       ORFCURSOR        OUT     CONSTANTS.TYREFCURSOR
    )
    IS
        SB_SQL              VARCHAR2(32000);
        ATTACHFILEMODE      GE_PARAMETER.VALUE%TYPE;
        NUREQENTITY         GE_ENTITY.ENTITY_ID%TYPE;
    BEGIN
        UT_TRACE.TRACE('Iniciando cc_boOssAttachFiles.GetDamagesAttachedFiles ObjectType['||ISBOBJECTTYPE||'] ObjectId['||INUOBJECTID||']', 5);

        SB_SQL            :=  NULL;

        FILLATTACHFILEATTRIBUTES;

        
        ATTACHFILEMODE := DAGE_PARAMETER.FSBGETVALUE(CSBATTACH_FILE_MODE);
        IF(ATTACHFILEMODE = CSBFILE_SYSTEMS) THEN
            
            CC_BOATTACHFILES.GETFILEATRIBUTES( ISBOBJECTTYPE, INUOBJECTID, ORFCURSOR );
        ELSE

            
            SB_SQL  :=   ' SELECT '|| SBATTACHFILEATT || CHR(10) ||
                         ' FROM    cc_file'  || CHR(10) ||
                         ' WHERE cc_file.object_id = :ObjectId' || CHR(10) ||
                         ' AND cc_file.object_level IN ('''||ISBOBJECTTYPE||''', '''||CSBREQUESTENTITY||''')';

            UT_TRACE.TRACE('Consulta ['||SB_SQL||']', 5);

            OPEN ORFCURSOR FOR SB_SQL USING INUOBJECTID, INUOBJECTID;
        END IF;
        UT_TRACE.TRACE('Fin de cc_boOssAttachFiles.GetDamagesAttachedFiles', 5);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    

















    PROCEDURE GETNTLATTACHFILES
    (
        INUNTLID            IN   FM_POSSIBLE_NTL.POSSIBLE_NTL_ID%TYPE,
        OCUATTACHFILES      OUT  CONSTANTS.TYREFCURSOR
        
    )
    IS
        NUPACKAGEID     MO_PACKAGES.PACKAGE_ID%TYPE;
    BEGIN
    
        NUPACKAGEID := DAFM_POSSIBLE_NTL.FNUGETPACKAGE_ID(INUNTLID, 0);
        
        IF NUPACKAGEID IS NULL THEN
            RETURN;
        END IF;

        CC_BOOSSPACKAGE.GETATTACHFILES(NUPACKAGEID, OCUATTACHFILES);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

BEGIN
    SBATTACHFILEATT := NULL;

END CC_BOOSSATTACHFILES;