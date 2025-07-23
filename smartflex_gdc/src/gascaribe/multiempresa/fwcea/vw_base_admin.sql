BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('VW_BASE_ADMIN_',
'CREATE OR REPLACE PACKAGE VW_BASE_ADMIN_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyGE_ENTITYRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ENTITYRowId tyGE_ENTITYRowId;type tyGE_ENTITY_ATTRIBUTESRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ENTITY_ATTRIBUTESRowId tyGE_ENTITY_ATTRIBUTESRowId;type tyGE_ATTR_ALLOWED_VALUESRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTR_ALLOWED_VALUESRowId tyGE_ATTR_ALLOWED_VALUESRowId;type tyGE_ATTR_VAL_EXPRESSRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTR_VAL_EXPRESSRowId tyGE_ATTR_VAL_EXPRESSRowId;type tyGR_CONFIG_EXPRESSIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIG_EXPRESSIONRowId tyGR_CONFIG_EXPRESSIONRowId;type ty0_0 is table of GE_ENTITY.NAME_%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty0_1 is table of GE_ENTITY.ENTITY_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_1 ty0_1; ' || chr(10) ||
'tb0_1 ty0_1;type ty1_0 is table of GE_ENTITY_ATTRIBUTES.ENTITY_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_0 ty1_0; ' || chr(10) ||
'tb1_0 ty1_0;type ty1_1 is table of GE_ENTITY_ATTRIBUTES.ENTITY_ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_1 ty1_1; ' || chr(10) ||
'tb1_1 ty1_1;type ty1_2 is table of GE_ENTITY_ATTRIBUTES.INIT_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_2 ty1_2; ' || chr(10) ||
'tb1_2 ty1_2;type ty1_3 is table of GE_ENTITY_ATTRIBUTES.VALID_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_3 ty1_3; ' || chr(10) ||
'tb1_3 ty1_3; ' || chr(10) ||
'  type tyCatalogTagName is table of ge_catalog.tag_name%type index by varchar2(200); ' || chr(10) ||
'  tbEntityAttributeName tyCatalogTagName; ' || chr(10) ||
' ' || chr(10) ||
'END VW_BASE_ADMIN_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:VW_BASE_ADMIN_******************************'); END;
/

DECLARE
    nuConfigExpresionId     GR_CONFIG_EXPRESSION.CONFIG_EXPRESSION_ID%type;
    sbObjectName            USER_OBJECTS.OBJECT_NAME%type;
    sbObjectType            USER_OBJECTS.OBJECT_TYPE%type;
    sbCode                  GR_CONFIG_EXPRESSION.CODE%type;

    CURSOR  cuConfigExpression IS
        SELECT  GR_CONFIG_EXPRESSION.CONFIG_EXPRESSION_ID,
                USER_OBJECTS.OBJECT_NAME,
                USER_OBJECTS.OBJECT_TYPE,
                GR_CONFIG_EXPRESSION.CODE
        FROM    GR_CONFIG_EXPRESSION,
                USER_OBJECTS
        WHERE   GR_CONFIG_EXPRESSION.CONFIG_EXPRESSION_ID IN (
            SELECT  VALID_EXPRESSION_ID
            FROM    GE_ENTITY_ATTRIBUTES
            WHERE   ENTITY_ID in (SELECT ENTITY_ID FROM GE_ENTITY WHERE NAME_='VW_BASE_ADMIN')
            UNION
            SELECT  INIT_EXPRESSION_ID
            FROM    GE_ENTITY_ATTRIBUTES
            WHERE   ENTITY_ID in (SELECT ENTITY_ID FROM GE_ENTITY WHERE NAME_='VW_BASE_ADMIN')
        )
        AND     USER_OBJECTS.object_name(+) = GR_CONFIG_EXPRESSION.OBJECT_NAME;
BEGIN
    ut_trace.trace('Referencias asociadas a atributos borrados', 1);
    
if (not VW_BASE_ADMIN_.blProcessStatus) then
 return;
end if;

    if (cuConfigExpression%ISOPEN) then
        CLOSE cuConfigExpression;
    end if;
    
    DELETE FROM GE_ATTR_VAL_EXPRESS WHERE (ENTITY_ATTRIBUTE_ID) in (SELECT ENTITY_ATTRIBUTE_ID FROM GE_ENTITY_ATTRIBUTES WHERE (ENTITY_ID) in (SELECT ENTITY_ID FROM GE_ENTITY WHERE NAME_='VW_BASE_ADMIN'));
    DELETE FROM GE_ATTR_ALLOWED_VALUES WHERE (ENTITY_ATTRIBUTE_ID) in (SELECT ENTITY_ATTRIBUTE_ID FROM GE_ENTITY_ATTRIBUTES WHERE (ENTITY_ID) in (SELECT ENTITY_ID FROM GE_ENTITY WHERE NAME_='VW_BASE_ADMIN'));
    
    OPEN    cuConfigExpression;
    
    UPDATE  GE_ENTITY_ATTRIBUTES
    SET     INIT_EXPRESSION_ID = NULL, VALID_EXPRESSION_ID = NULL
    WHERE   ENTITY_ID in (SELECT ENTITY_ID FROM GE_ENTITY WHERE NAME_='VW_BASE_ADMIN');

    loop
        FETCH cuConfigExpression INTO nuConfigExpresionId, sbObjectName, sbObjectType, sbCode;
        EXIT WHEN cuConfigExpression%NOTFOUND;
        DELETE FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID)  = nuConfigExpresionId;
        if (sbObjectName IS NOT NULL) then
            execute immediate 'DROP ' || sbObjectType || ' ' || sbObjectName;
        end if;
    end loop;
    
    if (cuConfigExpression%ISOPEN) then
        CLOSE cuConfigExpression;
    end if;

    EXCEPTION
        when others then
            rollback;
            if (cuConfigExpression%ISOPEN) then
                CLOSE cuConfigExpression;
            end if;
            OPEN    cuConfigExpression;
            loop
                FETCH cuConfigExpression INTO nuConfigExpresionId, sbObjectName, sbObjectType, sbCode;
                EXIT WHEN cuConfigExpression%NOTFOUND;
                execute immediate sbCode;
            end loop;
            CLOSE cuConfigExpression;
            ut_trace.trace('**ERROR:'||sqlerrm);
            raise;
END;
/


BEGIN 
  VW_BASE_ADMIN_.tbEntityAttributeName(90200527) := 'VW_BASE_ADMIN@BASE_ADMINISTRATIVA'; 
  VW_BASE_ADMIN_.tbEntityAttributeName(90200528) := 'VW_BASE_ADMIN@EMPRESA'; 
END;
/

BEGIN

if (not VW_BASE_ADMIN_.blProcessStatus) then
 return;
end if;

VW_BASE_ADMIN_.old_tb0_0(0):='VW_BASE_ADMIN'
;
VW_BASE_ADMIN_.tb0_0(0):='VW_BASE_ADMIN';
VW_BASE_ADMIN_.old_tb0_1(0):=6233;
VW_BASE_ADMIN_.tb0_1(0):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(VW_BASE_ADMIN_.tb0_0(0), 'ENTITY', 'GE_BOSEQUENCE.NEXTGE_ENTITY');
VW_BASE_ADMIN_.tb0_1(0):=VW_BASE_ADMIN_.tb0_1(0);
ut_trace.trace('Actualizar tabla: GE_ENTITY fila (0)',1);
UPDATE GE_ENTITY SET DESCRIPTION='VW_BASE_ADMIN'
,
DISPLAY_NAME='VW_BASE_ADMIN'
,
ALLOWED_FULL_SCAN='N'

 WHERE ENTITY_ID = VW_BASE_ADMIN_.tb0_1(0);

exception when others then
VW_BASE_ADMIN_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not VW_BASE_ADMIN_.blProcessStatus) then
 return;
end if;

VW_BASE_ADMIN_.tb1_0(0):=VW_BASE_ADMIN_.tb0_1(0);
VW_BASE_ADMIN_.old_tb1_1(0):=90200527;
VW_BASE_ADMIN_.tb1_1(0):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(VW_BASE_ADMIN_.TBENTITYATTRIBUTENAME(VW_BASE_ADMIN_.old_tb1_1(0)), 'ATTRIBUTE', GE_BOSEQUENCE.NEXTGE_ENTITY_ATTRIBUTES);
VW_BASE_ADMIN_.tb1_1(0):=VW_BASE_ADMIN_.tb1_1(0);
ut_trace.trace('Actualizar tabla: GE_ENTITY_ATTRIBUTES fila (0)',1);
UPDATE GE_ENTITY_ATTRIBUTES SET INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
GI_COMPONENT_ID=null,
MASK_ID=null,
SECUENCE_=0,
DISPLAY_NAME='BASE_ADMINISTRATIVA'
,
VIEWER_DISPLAY='Y'
,
DEFAULT_VALUE=null,
COMMENT_='BASE_ADMINISTRATIVA'
,
TAG_ELEMENT=null,
IS_DESCRIPTION='N'
,
IS_LOV_DESCRIPTION='N'
,
IS_CHECK_BOX='N'
,
CHECKED_VALUE=null,
UNCHECKED_VALUE=null
 WHERE ENTITY_ATTRIBUTE_ID = VW_BASE_ADMIN_.tb1_1(0);

exception when others then
VW_BASE_ADMIN_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not VW_BASE_ADMIN_.blProcessStatus) then
 return;
end if;

VW_BASE_ADMIN_.tb1_0(1):=VW_BASE_ADMIN_.tb0_1(0);
VW_BASE_ADMIN_.old_tb1_1(1):=90200528;
VW_BASE_ADMIN_.tb1_1(1):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(VW_BASE_ADMIN_.TBENTITYATTRIBUTENAME(VW_BASE_ADMIN_.old_tb1_1(1)), 'ATTRIBUTE', GE_BOSEQUENCE.NEXTGE_ENTITY_ATTRIBUTES);
VW_BASE_ADMIN_.tb1_1(1):=VW_BASE_ADMIN_.tb1_1(1);
ut_trace.trace('Actualizar tabla: GE_ENTITY_ATTRIBUTES fila (1)',1);
UPDATE GE_ENTITY_ATTRIBUTES SET INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
GI_COMPONENT_ID=null,
MASK_ID=null,
SECUENCE_=1,
DISPLAY_NAME='EMPRESA'
,
VIEWER_DISPLAY='Y'
,
DEFAULT_VALUE=null,
COMMENT_='EMPRESA'
,
TAG_ELEMENT=null,
IS_DESCRIPTION='N'
,
IS_LOV_DESCRIPTION='N'
,
IS_CHECK_BOX='N'
,
CHECKED_VALUE=null,
UNCHECKED_VALUE=null
 WHERE ENTITY_ATTRIBUTE_ID = VW_BASE_ADMIN_.tb1_1(1);

exception when others then
VW_BASE_ADMIN_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('VW_BASE_ADMIN_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:VW_BASE_ADMIN_******************************'); end;
/

