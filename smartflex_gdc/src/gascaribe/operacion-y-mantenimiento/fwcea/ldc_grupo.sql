BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('LDC_GRUPO_',
'CREATE OR REPLACE PACKAGE LDC_GRUPO_ IS ' || chr(10) ||
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
'tb1_0 ty1_0;type ty2_0 is table of GE_ENTITY_ATTRIBUTES.ENTITY_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_0 ty2_0; ' || chr(10) ||
'tb2_0 ty2_0;type ty2_1 is table of GE_ENTITY_ATTRIBUTES.ENTITY_ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_1 ty2_1; ' || chr(10) ||
'tb2_1 ty2_1;type ty2_2 is table of GE_ENTITY_ATTRIBUTES.INIT_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_2 ty2_2; ' || chr(10) ||
'tb2_2 ty2_2;type ty2_3 is table of GE_ENTITY_ATTRIBUTES.VALID_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_3 ty2_3; ' || chr(10) ||
'tb2_3 ty2_3;type ty3_0 is table of GR_CONFIG_EXPRESSION.CONFIG_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_0 ty3_0; ' || chr(10) ||
'tb3_0 ty3_0;type ty3_2 is table of GR_CONFIG_EXPRESSION.OBJECT_NAME%type index by binary_integer; ' || chr(10) ||
'old_tb3_2 ty3_2; ' || chr(10) ||
'tb3_2 ty3_2; ' || chr(10) ||
'  type tyCatalogTagName is table of ge_catalog.tag_name%type index by varchar2(200); ' || chr(10) ||
'  tbEntityAttributeName tyCatalogTagName; ' || chr(10) ||
' ' || chr(10) ||
'END LDC_GRUPO_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:LDC_GRUPO_******************************'); END;
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
            WHERE   ENTITY_ID in (SELECT ENTITY_ID FROM GE_ENTITY WHERE NAME_='LDC_GRUPO')
            UNION
            SELECT  INIT_EXPRESSION_ID
            FROM    GE_ENTITY_ATTRIBUTES
            WHERE   ENTITY_ID in (SELECT ENTITY_ID FROM GE_ENTITY WHERE NAME_='LDC_GRUPO')
        )
        AND     USER_OBJECTS.object_name(+) = GR_CONFIG_EXPRESSION.OBJECT_NAME;
BEGIN
    ut_trace.trace('Referencias asociadas a atributos borrados', 1);
    
if (not LDC_GRUPO_.blProcessStatus) then
 return;
end if;

    if (cuConfigExpression%ISOPEN) then
        CLOSE cuConfigExpression;
    end if;
    
    DELETE FROM GE_ATTR_VAL_EXPRESS WHERE (ENTITY_ATTRIBUTE_ID) in (SELECT ENTITY_ATTRIBUTE_ID FROM GE_ENTITY_ATTRIBUTES WHERE (ENTITY_ID) in (SELECT ENTITY_ID FROM GE_ENTITY WHERE NAME_='LDC_GRUPO'));
    DELETE FROM GE_ATTR_ALLOWED_VALUES WHERE (ENTITY_ATTRIBUTE_ID) in (SELECT ENTITY_ATTRIBUTE_ID FROM GE_ENTITY_ATTRIBUTES WHERE (ENTITY_ID) in (SELECT ENTITY_ID FROM GE_ENTITY WHERE NAME_='LDC_GRUPO'));
    
    OPEN    cuConfigExpression;
    
    UPDATE  GE_ENTITY_ATTRIBUTES
    SET     INIT_EXPRESSION_ID = NULL, VALID_EXPRESSION_ID = NULL
    WHERE   ENTITY_ID in (SELECT ENTITY_ID FROM GE_ENTITY WHERE NAME_='LDC_GRUPO');

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
  LDC_GRUPO_.tbEntityAttributeName(90145104) := 'LDC_GRUPO@GRUPCODI'; 
  LDC_GRUPO_.tbEntityAttributeName(90145105) := 'LDC_GRUPO@GRUPDESC'; 
  LDC_GRUPO_.tbEntityAttributeName(90145106) := 'LDC_GRUPO@GRUPTAMU'; 
  LDC_GRUPO_.tbEntityAttributeName(90166787) := 'LDC_GRUPO@VIGENCIA_INIT_DATE'; 
  LDC_GRUPO_.tbEntityAttributeName(90166788) := 'LDC_GRUPO@VIGENCIA_FINAL_DATE'; 
  LDC_GRUPO_.tbEntityAttributeName(90200341) := 'LDC_GRUPO@GRUPMURE'; 
END;
/

BEGIN

if (not LDC_GRUPO_.blProcessStatus) then
 return;
end if;

LDC_GRUPO_.old_tb0_0(0):='LDC_GRUPO'
;
LDC_GRUPO_.tb0_0(0):='LDC_GRUPO';
LDC_GRUPO_.old_tb0_1(0):=4249;
LDC_GRUPO_.tb0_1(0):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(LDC_GRUPO_.tb0_0(0), 'ENTITY', 'GE_BOSEQUENCE.NEXTGE_ENTITY');
LDC_GRUPO_.tb0_1(0):=LDC_GRUPO_.tb0_1(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ENTITY fila (0)',1);
UPDATE GE_ENTITY SET NAME_=LDC_GRUPO_.tb0_0(0),
ENTITY_ID=LDC_GRUPO_.tb0_1(0),
MODULE_ID=4,
SELEC_TYPE_OBJECT_ID=null,
INS_SEQ=null,
IN_PERSIST='Y'
,
DESCRIPTION='Tabla informacion de los grupos con su tamano de muestra'
,
DISPLAY_NAME='LDC_GRUPO'
,
LOAD_CARTRIDGE='N'
,
TABLESPACE='TSD_DEFAULT'
,
CREATION_DATE=to_date('04-04-2017 17:14:27','DD-MM-YYYY HH24:MI:SS'),
LAST_MODIFY_DATE=to_date('05-04-2017 09:35:48','DD-MM-YYYY HH24:MI:SS'),
STATUS='G'
,
ALLOWED_FULL_SCAN='Y'

 WHERE ENTITY_ID = LDC_GRUPO_.tb0_1(0);
if not (sql%found) then
INSERT INTO GE_ENTITY(NAME_,ENTITY_ID,MODULE_ID,SELEC_TYPE_OBJECT_ID,INS_SEQ,IN_PERSIST,DESCRIPTION,DISPLAY_NAME,LOAD_CARTRIDGE,TABLESPACE,CREATION_DATE,LAST_MODIFY_DATE,STATUS,ALLOWED_FULL_SCAN) 
VALUES (LDC_GRUPO_.tb0_0(0),
LDC_GRUPO_.tb0_1(0),
4,
null,
null,
'Y'
,
'Tabla informacion de los grupos con su tamano de muestra'
,
'LDC_GRUPO'
,
'N'
,
'TSD_DEFAULT'
,
to_date('04-04-2017 17:14:27','DD-MM-YYYY HH24:MI:SS'),
to_date('05-04-2017 09:35:48','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'Y'
);
end if;

exception when others then
LDC_GRUPO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDC_GRUPO_.blProcessStatus) then
 return;
end if;

LDC_GRUPO_.tb1_0(0):=LDC_GRUPO_.tb0_1(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ENTITY_ADITIONAL fila (0)',1);
UPDATE GE_ENTITY_ADITIONAL SET ENTITY_ID=LDC_GRUPO_.tb1_0(0),
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

 WHERE ENTITY_ID = LDC_GRUPO_.tb1_0(0);
if not (sql%found) then
INSERT INTO GE_ENTITY_ADITIONAL(ENTITY_ID,STATEMENT_ID,QUERY_SERVICE_NAME,PROCESS_SERVICE_NAME,BASE_ENTITY_NAME,BASE_ID_NAME,PRIMARY_KEY_ATTRIBUTE,FOREING_KEY_ATTRIBUTE,ICON,IS_SEARCH,SEARCH_SERVICE_NAME,CONTEXT_MENU_SERVICE,HEADER_TITLES,WINDOWS_TITLE,BATCH_SERVICE_NAME,TIME_EXECUTE_BATCH,EXECUTABLE_NAME_EXECUTE,IS_CUSTOM_ENTITY) 
VALUES (LDC_GRUPO_.tb1_0(0),
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
LDC_GRUPO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDC_GRUPO_.blProcessStatus) then
 return;
end if;

LDC_GRUPO_.tb2_0(0):=LDC_GRUPO_.tb0_1(0);
LDC_GRUPO_.old_tb2_1(0):=90166787;
LDC_GRUPO_.tb2_1(0):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(LDC_GRUPO_.TBENTITYATTRIBUTENAME(LDC_GRUPO_.old_tb2_1(0)), 'ATTRIBUTE', GE_BOSEQUENCE.NEXTGE_ENTITY_ATTRIBUTES);
LDC_GRUPO_.tb2_1(0):=LDC_GRUPO_.tb2_1(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ENTITY_ATTRIBUTES fila (0)',1);
UPDATE GE_ENTITY_ATTRIBUTES SET ENTITY_ID=LDC_GRUPO_.tb2_0(0),
ENTITY_ATTRIBUTE_ID=LDC_GRUPO_.tb2_1(0),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
GI_COMPONENT_ID=null,
MASK_ID=null,
REFERENCE=null,
ATTRIBUTE_TYPE_ID=3,
TECHNICAL_NAME='VIGENCIA_INIT_DATE'
,
SECUENCE_=3,
KEY_='N'
,
IS_NULL='Y'
,
DISPLAY_NAME='Fecha inicial de Vigencia'
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
 WHERE ENTITY_ATTRIBUTE_ID = LDC_GRUPO_.tb2_1(0);
if not (sql%found) then
INSERT INTO GE_ENTITY_ATTRIBUTES(ENTITY_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,GI_COMPONENT_ID,MASK_ID,REFERENCE,ATTRIBUTE_TYPE_ID,TECHNICAL_NAME,SECUENCE_,KEY_,IS_NULL,DISPLAY_NAME,VIEWER_DISPLAY,PRECISION,DEFAULT_VALUE,SCALE,LENGTH,COMMENT_,TAG_ELEMENT,STATUS,IS_DESCRIPTION,IS_LOV_DESCRIPTION,IS_CHECK_BOX,CHECKED_VALUE,UNCHECKED_VALUE,PROTECTOR_TEXT) 
VALUES (LDC_GRUPO_.tb2_0(0),
LDC_GRUPO_.tb2_1(0),
null,
null,
null,
null,
null,
3,
'VIGENCIA_INIT_DATE'
,
3,
'N'
,
'Y'
,
'Fecha inicial de Vigencia'
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
LDC_GRUPO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDC_GRUPO_.blProcessStatus) then
 return;
end if;

LDC_GRUPO_.tb2_0(1):=LDC_GRUPO_.tb0_1(0);
LDC_GRUPO_.old_tb2_1(1):=90166788;
LDC_GRUPO_.tb2_1(1):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(LDC_GRUPO_.TBENTITYATTRIBUTENAME(LDC_GRUPO_.old_tb2_1(1)), 'ATTRIBUTE', GE_BOSEQUENCE.NEXTGE_ENTITY_ATTRIBUTES);
LDC_GRUPO_.tb2_1(1):=LDC_GRUPO_.tb2_1(1);
ut_trace.trace('Actualizar o insertar tabla: GE_ENTITY_ATTRIBUTES fila (1)',1);
UPDATE GE_ENTITY_ATTRIBUTES SET ENTITY_ID=LDC_GRUPO_.tb2_0(1),
ENTITY_ATTRIBUTE_ID=LDC_GRUPO_.tb2_1(1),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
GI_COMPONENT_ID=null,
MASK_ID=null,
REFERENCE=null,
ATTRIBUTE_TYPE_ID=3,
TECHNICAL_NAME='VIGENCIA_FINAL_DATE'
,
SECUENCE_=4,
KEY_='N'
,
IS_NULL='Y'
,
DISPLAY_NAME='Fecha final de Vigencia'
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
 WHERE ENTITY_ATTRIBUTE_ID = LDC_GRUPO_.tb2_1(1);
if not (sql%found) then
INSERT INTO GE_ENTITY_ATTRIBUTES(ENTITY_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,GI_COMPONENT_ID,MASK_ID,REFERENCE,ATTRIBUTE_TYPE_ID,TECHNICAL_NAME,SECUENCE_,KEY_,IS_NULL,DISPLAY_NAME,VIEWER_DISPLAY,PRECISION,DEFAULT_VALUE,SCALE,LENGTH,COMMENT_,TAG_ELEMENT,STATUS,IS_DESCRIPTION,IS_LOV_DESCRIPTION,IS_CHECK_BOX,CHECKED_VALUE,UNCHECKED_VALUE,PROTECTOR_TEXT) 
VALUES (LDC_GRUPO_.tb2_0(1),
LDC_GRUPO_.tb2_1(1),
null,
null,
null,
null,
null,
3,
'VIGENCIA_FINAL_DATE'
,
4,
'N'
,
'Y'
,
'Fecha final de Vigencia'
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
LDC_GRUPO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDC_GRUPO_.blProcessStatus) then
 return;
end if;

LDC_GRUPO_.old_tb3_0(0):=121407351;
LDC_GRUPO_.tb3_0(0):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
LDC_GRUPO_.tb3_0(0):=LDC_GRUPO_.tb3_0(0);
LDC_GRUPO_.old_tb3_2(0):='GEGE_EXERULINI_CT67E121407351'
;
LDC_GRUPO_.tb3_2(0):=LDC_GRUPO_.tb3_0(0);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (0)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,CONFIGURA_TYPE_ID,OBJECT_NAME,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (LDC_GRUPO_.tb3_0(0),
67,
LDC_GRUPO_.tb3_2(0),
'PKGENERALSERVICES.FNUGETNEXTSEQUENCEVAL("SEQ_LDC_GRUPO")'
,
'OPEN'
,
to_date('04-04-2017 17:12:36','DD-MM-YYYY HH24:MI:SS'),
to_date('03-01-2025 14:12:27','DD-MM-YYYY HH24:MI:SS'),
to_date('03-01-2025 14:12:27','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'SEQ_LDC_GRUPO'
,
'PF'
,
null);

exception when others then
LDC_GRUPO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDC_GRUPO_.blProcessStatus) then
 return;
end if;

LDC_GRUPO_.tb2_0(2):=LDC_GRUPO_.tb0_1(0);
LDC_GRUPO_.old_tb2_1(2):=90145104;
LDC_GRUPO_.tb2_1(2):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(LDC_GRUPO_.TBENTITYATTRIBUTENAME(LDC_GRUPO_.old_tb2_1(2)), 'ATTRIBUTE', GE_BOSEQUENCE.NEXTGE_ENTITY_ATTRIBUTES);
LDC_GRUPO_.tb2_1(2):=LDC_GRUPO_.tb2_1(2);
LDC_GRUPO_.tb2_2(2):=LDC_GRUPO_.tb3_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ENTITY_ATTRIBUTES fila (2)',1);
UPDATE GE_ENTITY_ATTRIBUTES SET ENTITY_ID=LDC_GRUPO_.tb2_0(2),
ENTITY_ATTRIBUTE_ID=LDC_GRUPO_.tb2_1(2),
INIT_EXPRESSION_ID=LDC_GRUPO_.tb2_2(2),
VALID_EXPRESSION_ID=null,
GI_COMPONENT_ID=null,
MASK_ID=null,
REFERENCE=null,
ATTRIBUTE_TYPE_ID=1,
TECHNICAL_NAME='GRUPCODI'
,
SECUENCE_=0,
KEY_='Y'
,
IS_NULL='N'
,
DISPLAY_NAME='Id'
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
 WHERE ENTITY_ATTRIBUTE_ID = LDC_GRUPO_.tb2_1(2);
if not (sql%found) then
INSERT INTO GE_ENTITY_ATTRIBUTES(ENTITY_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,GI_COMPONENT_ID,MASK_ID,REFERENCE,ATTRIBUTE_TYPE_ID,TECHNICAL_NAME,SECUENCE_,KEY_,IS_NULL,DISPLAY_NAME,VIEWER_DISPLAY,PRECISION,DEFAULT_VALUE,SCALE,LENGTH,COMMENT_,TAG_ELEMENT,STATUS,IS_DESCRIPTION,IS_LOV_DESCRIPTION,IS_CHECK_BOX,CHECKED_VALUE,UNCHECKED_VALUE,PROTECTOR_TEXT) 
VALUES (LDC_GRUPO_.tb2_0(2),
LDC_GRUPO_.tb2_1(2),
LDC_GRUPO_.tb2_2(2),
null,
null,
null,
null,
1,
'GRUPCODI'
,
0,
'Y'
,
'N'
,
'Id'
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
LDC_GRUPO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDC_GRUPO_.blProcessStatus) then
 return;
end if;

LDC_GRUPO_.tb2_0(3):=LDC_GRUPO_.tb0_1(0);
LDC_GRUPO_.old_tb2_1(3):=90145105;
LDC_GRUPO_.tb2_1(3):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(LDC_GRUPO_.TBENTITYATTRIBUTENAME(LDC_GRUPO_.old_tb2_1(3)), 'ATTRIBUTE', GE_BOSEQUENCE.NEXTGE_ENTITY_ATTRIBUTES);
LDC_GRUPO_.tb2_1(3):=LDC_GRUPO_.tb2_1(3);
ut_trace.trace('Actualizar o insertar tabla: GE_ENTITY_ATTRIBUTES fila (3)',1);
UPDATE GE_ENTITY_ATTRIBUTES SET ENTITY_ID=LDC_GRUPO_.tb2_0(3),
ENTITY_ATTRIBUTE_ID=LDC_GRUPO_.tb2_1(3),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
GI_COMPONENT_ID=null,
MASK_ID=null,
REFERENCE=null,
ATTRIBUTE_TYPE_ID=2,
TECHNICAL_NAME='GRUPDESC'
,
SECUENCE_=1,
KEY_='N'
,
IS_NULL='N'
,
DISPLAY_NAME='Descripción'
,
VIEWER_DISPLAY='Y'
,
PRECISION=null,
DEFAULT_VALUE=null,
SCALE=null,
LENGTH=255,
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
 WHERE ENTITY_ATTRIBUTE_ID = LDC_GRUPO_.tb2_1(3);
if not (sql%found) then
INSERT INTO GE_ENTITY_ATTRIBUTES(ENTITY_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,GI_COMPONENT_ID,MASK_ID,REFERENCE,ATTRIBUTE_TYPE_ID,TECHNICAL_NAME,SECUENCE_,KEY_,IS_NULL,DISPLAY_NAME,VIEWER_DISPLAY,PRECISION,DEFAULT_VALUE,SCALE,LENGTH,COMMENT_,TAG_ELEMENT,STATUS,IS_DESCRIPTION,IS_LOV_DESCRIPTION,IS_CHECK_BOX,CHECKED_VALUE,UNCHECKED_VALUE,PROTECTOR_TEXT) 
VALUES (LDC_GRUPO_.tb2_0(3),
LDC_GRUPO_.tb2_1(3),
null,
null,
null,
null,
null,
2,
'GRUPDESC'
,
1,
'N'
,
'N'
,
'Descripción'
,
'Y'
,
null,
null,
null,
255,
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
LDC_GRUPO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDC_GRUPO_.blProcessStatus) then
 return;
end if;

LDC_GRUPO_.tb2_0(4):=LDC_GRUPO_.tb0_1(0);
LDC_GRUPO_.old_tb2_1(4):=90145106;
LDC_GRUPO_.tb2_1(4):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(LDC_GRUPO_.TBENTITYATTRIBUTENAME(LDC_GRUPO_.old_tb2_1(4)), 'ATTRIBUTE', GE_BOSEQUENCE.NEXTGE_ENTITY_ATTRIBUTES);
LDC_GRUPO_.tb2_1(4):=LDC_GRUPO_.tb2_1(4);
ut_trace.trace('Actualizar o insertar tabla: GE_ENTITY_ATTRIBUTES fila (4)',1);
UPDATE GE_ENTITY_ATTRIBUTES SET ENTITY_ID=LDC_GRUPO_.tb2_0(4),
ENTITY_ATTRIBUTE_ID=LDC_GRUPO_.tb2_1(4),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
GI_COMPONENT_ID=null,
MASK_ID=null,
REFERENCE=null,
ATTRIBUTE_TYPE_ID=1,
TECHNICAL_NAME='GRUPTAMU'
,
SECUENCE_=2,
KEY_='N'
,
IS_NULL='N'
,
DISPLAY_NAME='Tamaño de la Muestra'
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
 WHERE ENTITY_ATTRIBUTE_ID = LDC_GRUPO_.tb2_1(4);
if not (sql%found) then
INSERT INTO GE_ENTITY_ATTRIBUTES(ENTITY_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,GI_COMPONENT_ID,MASK_ID,REFERENCE,ATTRIBUTE_TYPE_ID,TECHNICAL_NAME,SECUENCE_,KEY_,IS_NULL,DISPLAY_NAME,VIEWER_DISPLAY,PRECISION,DEFAULT_VALUE,SCALE,LENGTH,COMMENT_,TAG_ELEMENT,STATUS,IS_DESCRIPTION,IS_LOV_DESCRIPTION,IS_CHECK_BOX,CHECKED_VALUE,UNCHECKED_VALUE,PROTECTOR_TEXT) 
VALUES (LDC_GRUPO_.tb2_0(4),
LDC_GRUPO_.tb2_1(4),
null,
null,
null,
null,
null,
1,
'GRUPTAMU'
,
2,
'N'
,
'N'
,
'Tamaño de la Muestra'
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
LDC_GRUPO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDC_GRUPO_.blProcessStatus) then
 return;
end if;

LDC_GRUPO_.tb2_0(5):=LDC_GRUPO_.tb0_1(0);
LDC_GRUPO_.old_tb2_1(5):=90200341;
LDC_GRUPO_.tb2_1(5):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(LDC_GRUPO_.TBENTITYATTRIBUTENAME(LDC_GRUPO_.old_tb2_1(5)), 'ATTRIBUTE', GE_BOSEQUENCE.NEXTGE_ENTITY_ATTRIBUTES);
LDC_GRUPO_.tb2_1(5):=LDC_GRUPO_.tb2_1(5);
ut_trace.trace('Actualizar o insertar tabla: GE_ENTITY_ATTRIBUTES fila (5)',1);
UPDATE GE_ENTITY_ATTRIBUTES SET ENTITY_ID=LDC_GRUPO_.tb2_0(5),
ENTITY_ATTRIBUTE_ID=LDC_GRUPO_.tb2_1(5),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
GI_COMPONENT_ID=null,
MASK_ID=null,
REFERENCE=null,
ATTRIBUTE_TYPE_ID=1,
TECHNICAL_NAME='GRUPMURE'
,
SECUENCE_=5,
KEY_='N'
,
IS_NULL='Y'
,
DISPLAY_NAME='Muestras Requeridas'
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
 WHERE ENTITY_ATTRIBUTE_ID = LDC_GRUPO_.tb2_1(5);
if not (sql%found) then
INSERT INTO GE_ENTITY_ATTRIBUTES(ENTITY_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,GI_COMPONENT_ID,MASK_ID,REFERENCE,ATTRIBUTE_TYPE_ID,TECHNICAL_NAME,SECUENCE_,KEY_,IS_NULL,DISPLAY_NAME,VIEWER_DISPLAY,PRECISION,DEFAULT_VALUE,SCALE,LENGTH,COMMENT_,TAG_ELEMENT,STATUS,IS_DESCRIPTION,IS_LOV_DESCRIPTION,IS_CHECK_BOX,CHECKED_VALUE,UNCHECKED_VALUE,PROTECTOR_TEXT) 
VALUES (LDC_GRUPO_.tb2_0(5),
LDC_GRUPO_.tb2_1(5),
null,
null,
null,
null,
null,
1,
'GRUPMURE'
,
5,
'N'
,
'Y'
,
'Muestras Requeridas'
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
LDC_GRUPO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
DECLARE
  nuerr number;
  sberr varchar2(4000);
BEGIN

if (not LDC_GRUPO_.blProcessStatus) then
 return;
end if;
  commit;
  gi_boframeworkentityattribute.UpdateEntityReferences('LDC_GRUPO');
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

if (not LDC_GRUPO_.blProcessStatus) then
 return;
end if;
nuRowProcess:=LDC_GRUPO_.tb3_0.first;
while (nuRowProcess is not null) loop 
ut_trace.trace('Genera expresión regla:'|| LDC_GRUPO_.tb3_0(nuRowProcess),1); 
begin
GR_BOINTERFACE_BODY.MakeExpression(LDC_GRUPO_.tb3_0(nuRowProcess)); 
exception when others then
ut_trace.trace('Fallo la generacion de la regla:'|| LDC_GRUPO_.tb3_0(nuRowProcess),1);
end;
nuRowProcess := LDC_GRUPO_.tb3_0.next(nuRowProcess);
END loop;
COMMIT;

exception when others then
LDC_GRUPO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

begin
SA_BOCreatePackages.DropPackage('LDC_GRUPO_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:LDC_GRUPO_******************************'); end;
/

