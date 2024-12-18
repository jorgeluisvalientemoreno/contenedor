BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('LDC_CONF_COMM_AUT_C_',
'CREATE OR REPLACE PACKAGE LDC_CONF_COMM_AUT_C_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyGE_ENTITYRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ENTITYRowId tyGE_ENTITYRowId;type tyGE_ENTITY_ADITIONALRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ENTITY_ADITIONALRowId tyGE_ENTITY_ADITIONALRowId;type tyGE_ENTITY_ATTRIBUTESRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ENTITY_ATTRIBUTESRowId tyGE_ENTITY_ATTRIBUTESRowId;type tyGE_ATTR_ALLOWED_VALUESRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTR_ALLOWED_VALUESRowId tyGE_ATTR_ALLOWED_VALUESRowId;type tyGE_ATTR_VAL_EXPRESSRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTR_VAL_EXPRESSRowId tyGE_ATTR_VAL_EXPRESSRowId;type tyGR_CONFIG_EXPRESSIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIG_EXPRESSIONRowId tyGR_CONFIG_EXPRESSIONRowId;type ty0_0 is table of GE_ENTITY.NAME_%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty0_1 is table of GE_ENTITY.ENTITY_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_1 ty0_1; ' || chr(10) ||
'tb0_1 ty0_1;type ty1_0 is table of GE_ENTITY_ADITIONAL.ENTITY_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_0 ty1_0; ' || chr(10) ||
'tb1_0 ty1_0;type ty2_0 is table of GR_CONFIG_EXPRESSION.CONFIG_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_0 ty2_0; ' || chr(10) ||
'tb2_0 ty2_0;type ty2_2 is table of GR_CONFIG_EXPRESSION.OBJECT_NAME%type index by binary_integer; ' || chr(10) ||
'old_tb2_2 ty2_2; ' || chr(10) ||
'tb2_2 ty2_2;type ty3_0 is table of GE_ENTITY_ATTRIBUTES.ENTITY_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_0 ty3_0; ' || chr(10) ||
'tb3_0 ty3_0;type ty3_1 is table of GE_ENTITY_ATTRIBUTES.ENTITY_ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_1 ty3_1; ' || chr(10) ||
'tb3_1 ty3_1;type ty3_2 is table of GE_ENTITY_ATTRIBUTES.INIT_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_2 ty3_2; ' || chr(10) ||
'tb3_2 ty3_2;type ty3_3 is table of GE_ENTITY_ATTRIBUTES.VALID_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_3 ty3_3; ' || chr(10) ||
'tb3_3 ty3_3; ' || chr(10) ||
'  type tyCatalogTagName is table of ge_catalog.tag_name%type index by varchar2(200); ' || chr(10) ||
'  tbEntityAttributeName tyCatalogTagName; ' || chr(10) ||
' ' || chr(10) ||
'END LDC_CONF_COMM_AUT_C_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:LDC_CONF_COMM_AUT_C_******************************'); END;
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
            WHERE   ENTITY_ID in (SELECT ENTITY_ID FROM GE_ENTITY WHERE NAME_='LDC_CONF_COMM_AUT_CONT')
            UNION
            SELECT  INIT_EXPRESSION_ID
            FROM    GE_ENTITY_ATTRIBUTES
            WHERE   ENTITY_ID in (SELECT ENTITY_ID FROM GE_ENTITY WHERE NAME_='LDC_CONF_COMM_AUT_CONT')
        )
        AND     USER_OBJECTS.object_name(+) = GR_CONFIG_EXPRESSION.OBJECT_NAME;
BEGIN
    ut_trace.trace('Referencias asociadas a atributos borrados', 1);
    
if (not LDC_CONF_COMM_AUT_C_.blProcessStatus) then
 return;
end if;

    if (cuConfigExpression%ISOPEN) then
        CLOSE cuConfigExpression;
    end if;
    
    DELETE FROM GE_ATTR_VAL_EXPRESS WHERE (ENTITY_ATTRIBUTE_ID) in (SELECT ENTITY_ATTRIBUTE_ID FROM GE_ENTITY_ATTRIBUTES WHERE (ENTITY_ID) in (SELECT ENTITY_ID FROM GE_ENTITY WHERE NAME_='LDC_CONF_COMM_AUT_CONT'));
    DELETE FROM GE_ATTR_ALLOWED_VALUES WHERE (ENTITY_ATTRIBUTE_ID) in (SELECT ENTITY_ATTRIBUTE_ID FROM GE_ENTITY_ATTRIBUTES WHERE (ENTITY_ID) in (SELECT ENTITY_ID FROM GE_ENTITY WHERE NAME_='LDC_CONF_COMM_AUT_CONT'));
    
    OPEN    cuConfigExpression;
    
    UPDATE  GE_ENTITY_ATTRIBUTES
    SET     INIT_EXPRESSION_ID = NULL, VALID_EXPRESSION_ID = NULL
    WHERE   ENTITY_ID in (SELECT ENTITY_ID FROM GE_ENTITY WHERE NAME_='LDC_CONF_COMM_AUT_CONT');

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
  LDC_CONF_COMM_AUT_C_.tbEntityAttributeName(90190675) := 'LDC_CONF_COMM_AUT_CONT@LDC_CONF_COMM_ID'; 
  LDC_CONF_COMM_AUT_C_.tbEntityAttributeName(90190676) := 'LDC_CONF_COMM_AUT_CONT@COMMERCIAL_PLAN_ID'; 
  LDC_CONF_COMM_AUT_C_.tbEntityAttributeName(90190677) := 'LDC_CONF_COMM_AUT_CONT@DEPARTAMENT'; 
  LDC_CONF_COMM_AUT_C_.tbEntityAttributeName(90190678) := 'LDC_CONF_COMM_AUT_CONT@CATEGORY_ID'; 
  LDC_CONF_COMM_AUT_C_.tbEntityAttributeName(90190679) := 'LDC_CONF_COMM_AUT_CONT@PERCENTAGE'; 
  LDC_CONF_COMM_AUT_C_.tbEntityAttributeName(90190680) := 'LDC_CONF_COMM_AUT_CONT@DATE_INIT'; 
  LDC_CONF_COMM_AUT_C_.tbEntityAttributeName(90190681) := 'LDC_CONF_COMM_AUT_CONT@DATE_END'; 
END;
/

BEGIN

if (not LDC_CONF_COMM_AUT_C_.blProcessStatus) then
 return;
end if;

LDC_CONF_COMM_AUT_C_.old_tb0_0(0):='LDC_CONF_COMM_AUT_CONT'
;
LDC_CONF_COMM_AUT_C_.tb0_0(0):='LDC_CONF_COMM_AUT_CONT';
LDC_CONF_COMM_AUT_C_.old_tb0_1(0):=5829;
LDC_CONF_COMM_AUT_C_.tb0_1(0):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(LDC_CONF_COMM_AUT_C_.tb0_0(0), 'ENTITY', 'GE_BOSEQUENCE.NEXTGE_ENTITY');
LDC_CONF_COMM_AUT_C_.tb0_1(0):=LDC_CONF_COMM_AUT_C_.tb0_1(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ENTITY fila (0)',1);
UPDATE GE_ENTITY SET NAME_=LDC_CONF_COMM_AUT_C_.tb0_0(0),
ENTITY_ID=LDC_CONF_COMM_AUT_C_.tb0_1(0),
MODULE_ID=16,
SELEC_TYPE_OBJECT_ID=null,
INS_SEQ=null,
IN_PERSIST='Y'
,
DESCRIPTION='Configuración para liquidacion de comisiones automaticas'
,
DISPLAY_NAME='Configuración para liquidacion de comisiones automaticas'
,
LOAD_CARTRIDGE='N'
,
TABLESPACE='TSD_DEFAULT'
,
CREATION_DATE=to_date('31-01-2022 21:19:24','DD-MM-YYYY HH24:MI:SS'),
LAST_MODIFY_DATE=to_date('31-01-2022 21:19:24','DD-MM-YYYY HH24:MI:SS'),
STATUS='G'
,
ALLOWED_FULL_SCAN='N'

 WHERE ENTITY_ID = LDC_CONF_COMM_AUT_C_.tb0_1(0);
if not (sql%found) then
INSERT INTO GE_ENTITY(NAME_,ENTITY_ID,MODULE_ID,SELEC_TYPE_OBJECT_ID,INS_SEQ,IN_PERSIST,DESCRIPTION,DISPLAY_NAME,LOAD_CARTRIDGE,TABLESPACE,CREATION_DATE,LAST_MODIFY_DATE,STATUS,ALLOWED_FULL_SCAN) 
VALUES (LDC_CONF_COMM_AUT_C_.tb0_0(0),
LDC_CONF_COMM_AUT_C_.tb0_1(0),
16,
null,
null,
'Y'
,
'Configuración para liquidacion de comisiones automaticas'
,
'Configuración para liquidacion de comisiones automaticas'
,
'N'
,
'TSD_DEFAULT'
,
to_date('31-01-2022 21:19:24','DD-MM-YYYY HH24:MI:SS'),
to_date('31-01-2022 21:19:24','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
);
end if;

exception when others then
LDC_CONF_COMM_AUT_C_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDC_CONF_COMM_AUT_C_.blProcessStatus) then
 return;
end if;

LDC_CONF_COMM_AUT_C_.tb1_0(0):=LDC_CONF_COMM_AUT_C_.tb0_1(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ENTITY_ADITIONAL fila (0)',1);
UPDATE GE_ENTITY_ADITIONAL SET ENTITY_ID=LDC_CONF_COMM_AUT_C_.tb1_0(0),
STATEMENT_ID=null,
QUERY_SERVICE_NAME=null,
PROCESS_SERVICE_NAME=null,
BASE_ENTITY_NAME=null,
BASE_ID_NAME=null,
PRIMARY_KEY_ATTRIBUTE='-1'
,
FOREING_KEY_ATTRIBUTE='-1'
,
ICON=null,
IS_SEARCH='N'
,
SEARCH_SERVICE_NAME=null,
CONTEXT_MENU_SERVICE=null,
HEADER_TITLES='<?xml version="1.0" encoding="utf-16"?><OpenQueryHeaderTitle xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><Title /><Subtitle1 /><Subtitle2 /></OpenQueryHeaderTitle>'
,
WINDOWS_TITLE=null,
BATCH_SERVICE_NAME=null,
TIME_EXECUTE_BATCH=null,
EXECUTABLE_NAME_EXECUTE=null,
IS_CUSTOM_ENTITY='Y'

 WHERE ENTITY_ID = LDC_CONF_COMM_AUT_C_.tb1_0(0);
if not (sql%found) then
INSERT INTO GE_ENTITY_ADITIONAL(ENTITY_ID,STATEMENT_ID,QUERY_SERVICE_NAME,PROCESS_SERVICE_NAME,BASE_ENTITY_NAME,BASE_ID_NAME,PRIMARY_KEY_ATTRIBUTE,FOREING_KEY_ATTRIBUTE,ICON,IS_SEARCH,SEARCH_SERVICE_NAME,CONTEXT_MENU_SERVICE,HEADER_TITLES,WINDOWS_TITLE,BATCH_SERVICE_NAME,TIME_EXECUTE_BATCH,EXECUTABLE_NAME_EXECUTE,IS_CUSTOM_ENTITY) 
VALUES (LDC_CONF_COMM_AUT_C_.tb1_0(0),
null,
null,
null,
null,
null,
'-1'
,
'-1'
,
null,
'N'
,
null,
null,
'<?xml version="1.0" encoding="utf-16"?><OpenQueryHeaderTitle xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><Title /><Subtitle1 /><Subtitle2 /></OpenQueryHeaderTitle>'
,
null,
null,
null,
null,
'Y'
);
end if;

exception when others then
LDC_CONF_COMM_AUT_C_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDC_CONF_COMM_AUT_C_.blProcessStatus) then
 return;
end if;

LDC_CONF_COMM_AUT_C_.old_tb2_0(0):=121380916;
LDC_CONF_COMM_AUT_C_.tb2_0(0):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
LDC_CONF_COMM_AUT_C_.tb2_0(0):=LDC_CONF_COMM_AUT_C_.tb2_0(0);
LDC_CONF_COMM_AUT_C_.old_tb2_2(0):='GEGE_EXERULINI_CT67E121380916'
;
LDC_CONF_COMM_AUT_C_.tb2_2(0):=LDC_CONF_COMM_AUT_C_.tb2_0(0);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (0)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,CONFIGURA_TYPE_ID,OBJECT_NAME,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (LDC_CONF_COMM_AUT_C_.tb2_0(0),
67,
LDC_CONF_COMM_AUT_C_.tb2_2(0),
'nuSeq = PKGENERALSERVICES.FNUGETNEXTSEQUENCEVAL("SEQ_LDC_CONF_COMM_AUT_CONT")'
,
'OPEN'
,
to_date('31-01-2022 21:18:21','DD-MM-YYYY HH24:MI:SS'),
to_date('31-01-2022 21:18:21','DD-MM-YYYY HH24:MI:SS'),
to_date('31-01-2022 21:18:21','DD-MM-YYYY HH24:MI:SS'),
'R'
,
'N'
,
'PU'
,
null,
'DS'
,
'Obtener valor de la secuencia'
,
'PF'
,
null);

exception when others then
LDC_CONF_COMM_AUT_C_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDC_CONF_COMM_AUT_C_.blProcessStatus) then
 return;
end if;

LDC_CONF_COMM_AUT_C_.tb3_0(0):=LDC_CONF_COMM_AUT_C_.tb0_1(0);
LDC_CONF_COMM_AUT_C_.old_tb3_1(0):=90190675;
LDC_CONF_COMM_AUT_C_.tb3_1(0):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(LDC_CONF_COMM_AUT_C_.TBENTITYATTRIBUTENAME(LDC_CONF_COMM_AUT_C_.old_tb3_1(0)), 'ATTRIBUTE', GE_BOSEQUENCE.NEXTGE_ENTITY_ATTRIBUTES);
LDC_CONF_COMM_AUT_C_.tb3_1(0):=LDC_CONF_COMM_AUT_C_.tb3_1(0);
LDC_CONF_COMM_AUT_C_.tb3_2(0):=LDC_CONF_COMM_AUT_C_.tb2_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ENTITY_ATTRIBUTES fila (0)',1);
UPDATE GE_ENTITY_ATTRIBUTES SET ENTITY_ID=LDC_CONF_COMM_AUT_C_.tb3_0(0),
ENTITY_ATTRIBUTE_ID=LDC_CONF_COMM_AUT_C_.tb3_1(0),
INIT_EXPRESSION_ID=LDC_CONF_COMM_AUT_C_.tb3_2(0),
VALID_EXPRESSION_ID=null,
GI_COMPONENT_ID=null,
MASK_ID=null,
REFERENCE=null,
ATTRIBUTE_TYPE_ID=1,
TECHNICAL_NAME='LDC_CONF_COMM_ID'
,
SECUENCE_=0,
KEY_='Y'
,
IS_NULL='N'
,
DISPLAY_NAME='Identificador del registro'
,
VIEWER_DISPLAY='Y'
,
PRECISION=4,
DEFAULT_VALUE=null,
SCALE=0,
LENGTH=4,
COMMENT_=null,
TAG_ELEMENT=null,
STATUS='G'
,
IS_DESCRIPTION='N'
,
IS_LOV_DESCRIPTION='N'
,
IS_CHECK_BOX='N'
,
CHECKED_VALUE=null,
UNCHECKED_VALUE=null,
PROTECTOR_TEXT=null
 WHERE ENTITY_ATTRIBUTE_ID = LDC_CONF_COMM_AUT_C_.tb3_1(0);
if not (sql%found) then
INSERT INTO GE_ENTITY_ATTRIBUTES(ENTITY_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,GI_COMPONENT_ID,MASK_ID,REFERENCE,ATTRIBUTE_TYPE_ID,TECHNICAL_NAME,SECUENCE_,KEY_,IS_NULL,DISPLAY_NAME,VIEWER_DISPLAY,PRECISION,DEFAULT_VALUE,SCALE,LENGTH,COMMENT_,TAG_ELEMENT,STATUS,IS_DESCRIPTION,IS_LOV_DESCRIPTION,IS_CHECK_BOX,CHECKED_VALUE,UNCHECKED_VALUE,PROTECTOR_TEXT) 
VALUES (LDC_CONF_COMM_AUT_C_.tb3_0(0),
LDC_CONF_COMM_AUT_C_.tb3_1(0),
LDC_CONF_COMM_AUT_C_.tb3_2(0),
null,
null,
null,
null,
1,
'LDC_CONF_COMM_ID'
,
0,
'Y'
,
'N'
,
'Identificador del registro'
,
'Y'
,
4,
null,
0,
4,
null,
null,
'G'
,
'N'
,
'N'
,
'N'
,
null,
null,
null);
end if;

exception when others then
LDC_CONF_COMM_AUT_C_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDC_CONF_COMM_AUT_C_.blProcessStatus) then
 return;
end if;

LDC_CONF_COMM_AUT_C_.tb3_0(1):=LDC_CONF_COMM_AUT_C_.tb0_1(0);
LDC_CONF_COMM_AUT_C_.old_tb3_1(1):=90190676;
LDC_CONF_COMM_AUT_C_.tb3_1(1):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(LDC_CONF_COMM_AUT_C_.TBENTITYATTRIBUTENAME(LDC_CONF_COMM_AUT_C_.old_tb3_1(1)), 'ATTRIBUTE', GE_BOSEQUENCE.NEXTGE_ENTITY_ATTRIBUTES);
LDC_CONF_COMM_AUT_C_.tb3_1(1):=LDC_CONF_COMM_AUT_C_.tb3_1(1);
ut_trace.trace('Actualizar o insertar tabla: GE_ENTITY_ATTRIBUTES fila (1)',1);
UPDATE GE_ENTITY_ATTRIBUTES SET ENTITY_ID=LDC_CONF_COMM_AUT_C_.tb3_0(1),
ENTITY_ATTRIBUTE_ID=LDC_CONF_COMM_AUT_C_.tb3_1(1),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
GI_COMPONENT_ID=null,
MASK_ID=null,
REFERENCE=null,
ATTRIBUTE_TYPE_ID=1,
TECHNICAL_NAME='COMMERCIAL_PLAN_ID'
,
SECUENCE_=1,
KEY_='N'
,
IS_NULL='N'
,
DISPLAY_NAME='Plan comercial'
,
VIEWER_DISPLAY='Y'
,
PRECISION=15,
DEFAULT_VALUE=null,
SCALE=0,
LENGTH=15,
COMMENT_=null,
TAG_ELEMENT=null,
STATUS='G'
,
IS_DESCRIPTION='N'
,
IS_LOV_DESCRIPTION='N'
,
IS_CHECK_BOX='N'
,
CHECKED_VALUE=null,
UNCHECKED_VALUE=null,
PROTECTOR_TEXT=null
 WHERE ENTITY_ATTRIBUTE_ID = LDC_CONF_COMM_AUT_C_.tb3_1(1);
if not (sql%found) then
INSERT INTO GE_ENTITY_ATTRIBUTES(ENTITY_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,GI_COMPONENT_ID,MASK_ID,REFERENCE,ATTRIBUTE_TYPE_ID,TECHNICAL_NAME,SECUENCE_,KEY_,IS_NULL,DISPLAY_NAME,VIEWER_DISPLAY,PRECISION,DEFAULT_VALUE,SCALE,LENGTH,COMMENT_,TAG_ELEMENT,STATUS,IS_DESCRIPTION,IS_LOV_DESCRIPTION,IS_CHECK_BOX,CHECKED_VALUE,UNCHECKED_VALUE,PROTECTOR_TEXT) 
VALUES (LDC_CONF_COMM_AUT_C_.tb3_0(1),
LDC_CONF_COMM_AUT_C_.tb3_1(1),
null,
null,
null,
null,
null,
1,
'COMMERCIAL_PLAN_ID'
,
1,
'N'
,
'N'
,
'Plan comercial'
,
'Y'
,
15,
null,
0,
15,
null,
null,
'G'
,
'N'
,
'N'
,
'N'
,
null,
null,
null);
end if;

exception when others then
LDC_CONF_COMM_AUT_C_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDC_CONF_COMM_AUT_C_.blProcessStatus) then
 return;
end if;

LDC_CONF_COMM_AUT_C_.tb3_0(2):=LDC_CONF_COMM_AUT_C_.tb0_1(0);
LDC_CONF_COMM_AUT_C_.old_tb3_1(2):=90190677;
LDC_CONF_COMM_AUT_C_.tb3_1(2):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(LDC_CONF_COMM_AUT_C_.TBENTITYATTRIBUTENAME(LDC_CONF_COMM_AUT_C_.old_tb3_1(2)), 'ATTRIBUTE', GE_BOSEQUENCE.NEXTGE_ENTITY_ATTRIBUTES);
LDC_CONF_COMM_AUT_C_.tb3_1(2):=LDC_CONF_COMM_AUT_C_.tb3_1(2);
ut_trace.trace('Actualizar o insertar tabla: GE_ENTITY_ATTRIBUTES fila (2)',1);
UPDATE GE_ENTITY_ATTRIBUTES SET ENTITY_ID=LDC_CONF_COMM_AUT_C_.tb3_0(2),
ENTITY_ATTRIBUTE_ID=LDC_CONF_COMM_AUT_C_.tb3_1(2),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
GI_COMPONENT_ID=null,
MASK_ID=null,
REFERENCE=null,
ATTRIBUTE_TYPE_ID=1,
TECHNICAL_NAME='DEPARTAMENT'
,
SECUENCE_=2,
KEY_='N'
,
IS_NULL='N'
,
DISPLAY_NAME='Departamento'
,
VIEWER_DISPLAY='Y'
,
PRECISION=6,
DEFAULT_VALUE=null,
SCALE=0,
LENGTH=6,
COMMENT_=null,
TAG_ELEMENT=null,
STATUS='G'
,
IS_DESCRIPTION='N'
,
IS_LOV_DESCRIPTION='N'
,
IS_CHECK_BOX='N'
,
CHECKED_VALUE=null,
UNCHECKED_VALUE=null,
PROTECTOR_TEXT=null
 WHERE ENTITY_ATTRIBUTE_ID = LDC_CONF_COMM_AUT_C_.tb3_1(2);
if not (sql%found) then
INSERT INTO GE_ENTITY_ATTRIBUTES(ENTITY_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,GI_COMPONENT_ID,MASK_ID,REFERENCE,ATTRIBUTE_TYPE_ID,TECHNICAL_NAME,SECUENCE_,KEY_,IS_NULL,DISPLAY_NAME,VIEWER_DISPLAY,PRECISION,DEFAULT_VALUE,SCALE,LENGTH,COMMENT_,TAG_ELEMENT,STATUS,IS_DESCRIPTION,IS_LOV_DESCRIPTION,IS_CHECK_BOX,CHECKED_VALUE,UNCHECKED_VALUE,PROTECTOR_TEXT) 
VALUES (LDC_CONF_COMM_AUT_C_.tb3_0(2),
LDC_CONF_COMM_AUT_C_.tb3_1(2),
null,
null,
null,
null,
null,
1,
'DEPARTAMENT'
,
2,
'N'
,
'N'
,
'Departamento'
,
'Y'
,
6,
null,
0,
6,
null,
null,
'G'
,
'N'
,
'N'
,
'N'
,
null,
null,
null);
end if;

exception when others then
LDC_CONF_COMM_AUT_C_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDC_CONF_COMM_AUT_C_.blProcessStatus) then
 return;
end if;

LDC_CONF_COMM_AUT_C_.tb3_0(3):=LDC_CONF_COMM_AUT_C_.tb0_1(0);
LDC_CONF_COMM_AUT_C_.old_tb3_1(3):=90190678;
LDC_CONF_COMM_AUT_C_.tb3_1(3):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(LDC_CONF_COMM_AUT_C_.TBENTITYATTRIBUTENAME(LDC_CONF_COMM_AUT_C_.old_tb3_1(3)), 'ATTRIBUTE', GE_BOSEQUENCE.NEXTGE_ENTITY_ATTRIBUTES);
LDC_CONF_COMM_AUT_C_.tb3_1(3):=LDC_CONF_COMM_AUT_C_.tb3_1(3);
ut_trace.trace('Actualizar o insertar tabla: GE_ENTITY_ATTRIBUTES fila (3)',1);
UPDATE GE_ENTITY_ATTRIBUTES SET ENTITY_ID=LDC_CONF_COMM_AUT_C_.tb3_0(3),
ENTITY_ATTRIBUTE_ID=LDC_CONF_COMM_AUT_C_.tb3_1(3),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
GI_COMPONENT_ID=null,
MASK_ID=null,
REFERENCE=null,
ATTRIBUTE_TYPE_ID=1,
TECHNICAL_NAME='CATEGORY_ID'
,
SECUENCE_=3,
KEY_='N'
,
IS_NULL='N'
,
DISPLAY_NAME='Categoría'
,
VIEWER_DISPLAY='Y'
,
PRECISION=2,
DEFAULT_VALUE=null,
SCALE=0,
LENGTH=2,
COMMENT_=null,
TAG_ELEMENT=null,
STATUS='G'
,
IS_DESCRIPTION='N'
,
IS_LOV_DESCRIPTION='N'
,
IS_CHECK_BOX='N'
,
CHECKED_VALUE=null,
UNCHECKED_VALUE=null,
PROTECTOR_TEXT=null
 WHERE ENTITY_ATTRIBUTE_ID = LDC_CONF_COMM_AUT_C_.tb3_1(3);
if not (sql%found) then
INSERT INTO GE_ENTITY_ATTRIBUTES(ENTITY_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,GI_COMPONENT_ID,MASK_ID,REFERENCE,ATTRIBUTE_TYPE_ID,TECHNICAL_NAME,SECUENCE_,KEY_,IS_NULL,DISPLAY_NAME,VIEWER_DISPLAY,PRECISION,DEFAULT_VALUE,SCALE,LENGTH,COMMENT_,TAG_ELEMENT,STATUS,IS_DESCRIPTION,IS_LOV_DESCRIPTION,IS_CHECK_BOX,CHECKED_VALUE,UNCHECKED_VALUE,PROTECTOR_TEXT) 
VALUES (LDC_CONF_COMM_AUT_C_.tb3_0(3),
LDC_CONF_COMM_AUT_C_.tb3_1(3),
null,
null,
null,
null,
null,
1,
'CATEGORY_ID'
,
3,
'N'
,
'N'
,
'Categoría'
,
'Y'
,
2,
null,
0,
2,
null,
null,
'G'
,
'N'
,
'N'
,
'N'
,
null,
null,
null);
end if;

exception when others then
LDC_CONF_COMM_AUT_C_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDC_CONF_COMM_AUT_C_.blProcessStatus) then
 return;
end if;

LDC_CONF_COMM_AUT_C_.tb3_0(4):=LDC_CONF_COMM_AUT_C_.tb0_1(0);
LDC_CONF_COMM_AUT_C_.old_tb3_1(4):=90190679;
LDC_CONF_COMM_AUT_C_.tb3_1(4):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(LDC_CONF_COMM_AUT_C_.TBENTITYATTRIBUTENAME(LDC_CONF_COMM_AUT_C_.old_tb3_1(4)), 'ATTRIBUTE', GE_BOSEQUENCE.NEXTGE_ENTITY_ATTRIBUTES);
LDC_CONF_COMM_AUT_C_.tb3_1(4):=LDC_CONF_COMM_AUT_C_.tb3_1(4);
ut_trace.trace('Actualizar o insertar tabla: GE_ENTITY_ATTRIBUTES fila (4)',1);
UPDATE GE_ENTITY_ATTRIBUTES SET ENTITY_ID=LDC_CONF_COMM_AUT_C_.tb3_0(4),
ENTITY_ATTRIBUTE_ID=LDC_CONF_COMM_AUT_C_.tb3_1(4),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
GI_COMPONENT_ID=null,
MASK_ID=null,
REFERENCE=null,
ATTRIBUTE_TYPE_ID=1,
TECHNICAL_NAME='PERCENTAGE'
,
SECUENCE_=4,
KEY_='N'
,
IS_NULL='N'
,
DISPLAY_NAME='Porcentaje de comisi�n'
,
VIEWER_DISPLAY='Y'
,
PRECISION=13,
DEFAULT_VALUE=null,
SCALE=2,
LENGTH=13,
COMMENT_=null,
TAG_ELEMENT=null,
STATUS='G'
,
IS_DESCRIPTION='N'
,
IS_LOV_DESCRIPTION='N'
,
IS_CHECK_BOX='N'
,
CHECKED_VALUE=null,
UNCHECKED_VALUE=null,
PROTECTOR_TEXT=null
 WHERE ENTITY_ATTRIBUTE_ID = LDC_CONF_COMM_AUT_C_.tb3_1(4);
if not (sql%found) then
INSERT INTO GE_ENTITY_ATTRIBUTES(ENTITY_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,GI_COMPONENT_ID,MASK_ID,REFERENCE,ATTRIBUTE_TYPE_ID,TECHNICAL_NAME,SECUENCE_,KEY_,IS_NULL,DISPLAY_NAME,VIEWER_DISPLAY,PRECISION,DEFAULT_VALUE,SCALE,LENGTH,COMMENT_,TAG_ELEMENT,STATUS,IS_DESCRIPTION,IS_LOV_DESCRIPTION,IS_CHECK_BOX,CHECKED_VALUE,UNCHECKED_VALUE,PROTECTOR_TEXT) 
VALUES (LDC_CONF_COMM_AUT_C_.tb3_0(4),
LDC_CONF_COMM_AUT_C_.tb3_1(4),
null,
null,
null,
null,
null,
1,
'PERCENTAGE'
,
4,
'N'
,
'N'
,
'Porcentaje de comisi�n'
,
'Y'
,
13,
null,
2,
13,
null,
null,
'G'
,
'N'
,
'N'
,
'N'
,
null,
null,
null);
end if;

exception when others then
LDC_CONF_COMM_AUT_C_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDC_CONF_COMM_AUT_C_.blProcessStatus) then
 return;
end if;

LDC_CONF_COMM_AUT_C_.tb3_0(5):=LDC_CONF_COMM_AUT_C_.tb0_1(0);
LDC_CONF_COMM_AUT_C_.old_tb3_1(5):=90190680;
LDC_CONF_COMM_AUT_C_.tb3_1(5):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(LDC_CONF_COMM_AUT_C_.TBENTITYATTRIBUTENAME(LDC_CONF_COMM_AUT_C_.old_tb3_1(5)), 'ATTRIBUTE', GE_BOSEQUENCE.NEXTGE_ENTITY_ATTRIBUTES);
LDC_CONF_COMM_AUT_C_.tb3_1(5):=LDC_CONF_COMM_AUT_C_.tb3_1(5);
ut_trace.trace('Actualizar o insertar tabla: GE_ENTITY_ATTRIBUTES fila (5)',1);
UPDATE GE_ENTITY_ATTRIBUTES SET ENTITY_ID=LDC_CONF_COMM_AUT_C_.tb3_0(5),
ENTITY_ATTRIBUTE_ID=LDC_CONF_COMM_AUT_C_.tb3_1(5),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
GI_COMPONENT_ID=null,
MASK_ID=null,
REFERENCE=null,
ATTRIBUTE_TYPE_ID=3,
TECHNICAL_NAME='DATE_INIT'
,
SECUENCE_=5,
KEY_='N'
,
IS_NULL='N'
,
DISPLAY_NAME='Fecha inicial'
,
VIEWER_DISPLAY='Y'
,
PRECISION=null,
DEFAULT_VALUE=null,
SCALE=null,
LENGTH=7,
COMMENT_=null,
TAG_ELEMENT=null,
STATUS='G'
,
IS_DESCRIPTION='N'
,
IS_LOV_DESCRIPTION='N'
,
IS_CHECK_BOX='N'
,
CHECKED_VALUE=null,
UNCHECKED_VALUE=null,
PROTECTOR_TEXT=null
 WHERE ENTITY_ATTRIBUTE_ID = LDC_CONF_COMM_AUT_C_.tb3_1(5);
if not (sql%found) then
INSERT INTO GE_ENTITY_ATTRIBUTES(ENTITY_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,GI_COMPONENT_ID,MASK_ID,REFERENCE,ATTRIBUTE_TYPE_ID,TECHNICAL_NAME,SECUENCE_,KEY_,IS_NULL,DISPLAY_NAME,VIEWER_DISPLAY,PRECISION,DEFAULT_VALUE,SCALE,LENGTH,COMMENT_,TAG_ELEMENT,STATUS,IS_DESCRIPTION,IS_LOV_DESCRIPTION,IS_CHECK_BOX,CHECKED_VALUE,UNCHECKED_VALUE,PROTECTOR_TEXT) 
VALUES (LDC_CONF_COMM_AUT_C_.tb3_0(5),
LDC_CONF_COMM_AUT_C_.tb3_1(5),
null,
null,
null,
null,
null,
3,
'DATE_INIT'
,
5,
'N'
,
'N'
,
'Fecha inicial'
,
'Y'
,
null,
null,
null,
7,
null,
null,
'G'
,
'N'
,
'N'
,
'N'
,
null,
null,
null);
end if;

exception when others then
LDC_CONF_COMM_AUT_C_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDC_CONF_COMM_AUT_C_.blProcessStatus) then
 return;
end if;

LDC_CONF_COMM_AUT_C_.tb3_0(6):=LDC_CONF_COMM_AUT_C_.tb0_1(0);
LDC_CONF_COMM_AUT_C_.old_tb3_1(6):=90190681;
LDC_CONF_COMM_AUT_C_.tb3_1(6):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(LDC_CONF_COMM_AUT_C_.TBENTITYATTRIBUTENAME(LDC_CONF_COMM_AUT_C_.old_tb3_1(6)), 'ATTRIBUTE', GE_BOSEQUENCE.NEXTGE_ENTITY_ATTRIBUTES);
LDC_CONF_COMM_AUT_C_.tb3_1(6):=LDC_CONF_COMM_AUT_C_.tb3_1(6);
ut_trace.trace('Actualizar o insertar tabla: GE_ENTITY_ATTRIBUTES fila (6)',1);
UPDATE GE_ENTITY_ATTRIBUTES SET ENTITY_ID=LDC_CONF_COMM_AUT_C_.tb3_0(6),
ENTITY_ATTRIBUTE_ID=LDC_CONF_COMM_AUT_C_.tb3_1(6),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
GI_COMPONENT_ID=null,
MASK_ID=null,
REFERENCE=null,
ATTRIBUTE_TYPE_ID=3,
TECHNICAL_NAME='DATE_END'
,
SECUENCE_=6,
KEY_='N'
,
IS_NULL='N'
,
DISPLAY_NAME='Fecha final'
,
VIEWER_DISPLAY='Y'
,
PRECISION=null,
DEFAULT_VALUE=null,
SCALE=null,
LENGTH=7,
COMMENT_=null,
TAG_ELEMENT=null,
STATUS='G'
,
IS_DESCRIPTION='N'
,
IS_LOV_DESCRIPTION='N'
,
IS_CHECK_BOX='N'
,
CHECKED_VALUE=null,
UNCHECKED_VALUE=null,
PROTECTOR_TEXT=null
 WHERE ENTITY_ATTRIBUTE_ID = LDC_CONF_COMM_AUT_C_.tb3_1(6);
if not (sql%found) then
INSERT INTO GE_ENTITY_ATTRIBUTES(ENTITY_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,GI_COMPONENT_ID,MASK_ID,REFERENCE,ATTRIBUTE_TYPE_ID,TECHNICAL_NAME,SECUENCE_,KEY_,IS_NULL,DISPLAY_NAME,VIEWER_DISPLAY,PRECISION,DEFAULT_VALUE,SCALE,LENGTH,COMMENT_,TAG_ELEMENT,STATUS,IS_DESCRIPTION,IS_LOV_DESCRIPTION,IS_CHECK_BOX,CHECKED_VALUE,UNCHECKED_VALUE,PROTECTOR_TEXT) 
VALUES (LDC_CONF_COMM_AUT_C_.tb3_0(6),
LDC_CONF_COMM_AUT_C_.tb3_1(6),
null,
null,
null,
null,
null,
3,
'DATE_END'
,
6,
'N'
,
'N'
,
'Fecha final'
,
'Y'
,
null,
null,
null,
7,
null,
null,
'G'
,
'N'
,
'N'
,
'N'
,
null,
null,
null);
end if;

exception when others then
LDC_CONF_COMM_AUT_C_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
DECLARE
  nuerr number;
  sberr varchar2(4000);
BEGIN

if (not LDC_CONF_COMM_AUT_C_.blProcessStatus) then
 return;
end if;
  commit;
  gi_boframeworkentityattribute.UpdateEntityReferences('LDC_CONF_COMM_AUT_CONT');
EXCEPTION
  when ex.CONTROLLED_ERROR then
     Errors.GetError(nuerr, sberr);
     ut_trace.trace('Error en actualización de referencias ' || nuerr || '-' || sberr);
  when others then
     Errors.setError;
     Errors.GetError(nuerr, sberr);
     ut_trace.trace('Error en actualización de referencias ' || nuerr || '-' || sberr);
END;
/

COMMIT
/

DECLARE
PRAGMA AUTONOMOUS_TRANSACTION;
nuRowProcess number;
BEGIN 

if (not LDC_CONF_COMM_AUT_C_.blProcessStatus) then
 return;
end if;
nuRowProcess:=LDC_CONF_COMM_AUT_C_.tb2_0.first;
while (nuRowProcess is not null) loop 
ut_trace.trace('Genera expresión regla:'|| LDC_CONF_COMM_AUT_C_.tb2_0(nuRowProcess),1); 
begin
GR_BOINTERFACE_BODY.MakeExpression(LDC_CONF_COMM_AUT_C_.tb2_0(nuRowProcess)); 
exception when others then
ut_trace.trace('Fallo la generacion de la regla:'|| LDC_CONF_COMM_AUT_C_.tb2_0(nuRowProcess),1);
end;
nuRowProcess := LDC_CONF_COMM_AUT_C_.tb2_0.next(nuRowProcess);
END loop;
COMMIT;

exception when others then
LDC_CONF_COMM_AUT_C_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

begin
SA_BOCreatePackages.DropPackage('LDC_CONF_COMM_AUT_C_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:LDC_CONF_COMM_AUT_C_******************************'); end;
/

