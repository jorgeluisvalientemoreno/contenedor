BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('LDC_ATECLIREPO_',
'CREATE OR REPLACE PACKAGE LDC_ATECLIREPO_ IS ' || chr(10) ||
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
'tb2_3 ty2_3;type ty3_0 is table of GE_ATTR_ALLOWED_VALUES.ATTR_ALLOW_VALUE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_0 ty3_0; ' || chr(10) ||
'tb3_0 ty3_0;type ty3_1 is table of GE_ATTR_ALLOWED_VALUES.ENTITY_ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_1 ty3_1; ' || chr(10) ||
'tb3_1 ty3_1; ' || chr(10) ||
'  type tyCatalogTagName is table of ge_catalog.tag_name%type index by varchar2(200); ' || chr(10) ||
'  tbEntityAttributeName tyCatalogTagName; ' || chr(10) ||
' ' || chr(10) ||
'END LDC_ATECLIREPO_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:LDC_ATECLIREPO_******************************'); END;
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
            WHERE   ENTITY_ID in (SELECT ENTITY_ID FROM GE_ENTITY WHERE NAME_='LDC_ATECLIREPO')
            UNION
            SELECT  INIT_EXPRESSION_ID
            FROM    GE_ENTITY_ATTRIBUTES
            WHERE   ENTITY_ID in (SELECT ENTITY_ID FROM GE_ENTITY WHERE NAME_='LDC_ATECLIREPO')
        )
        AND     USER_OBJECTS.object_name(+) = GR_CONFIG_EXPRESSION.OBJECT_NAME;
BEGIN
    ut_trace.trace('Referencias asociadas a atributos borrados', 1);
    
if (not LDC_ATECLIREPO_.blProcessStatus) then
 return;
end if;

    if (cuConfigExpression%ISOPEN) then
        CLOSE cuConfigExpression;
    end if;
    
    DELETE FROM GE_ATTR_VAL_EXPRESS WHERE (ENTITY_ATTRIBUTE_ID) in (SELECT ENTITY_ATTRIBUTE_ID FROM GE_ENTITY_ATTRIBUTES WHERE (ENTITY_ID) in (SELECT ENTITY_ID FROM GE_ENTITY WHERE NAME_='LDC_ATECLIREPO'));
    DELETE FROM GE_ATTR_ALLOWED_VALUES WHERE (ENTITY_ATTRIBUTE_ID) in (SELECT ENTITY_ATTRIBUTE_ID FROM GE_ENTITY_ATTRIBUTES WHERE (ENTITY_ID) in (SELECT ENTITY_ID FROM GE_ENTITY WHERE NAME_='LDC_ATECLIREPO'));
    
    OPEN    cuConfigExpression;
    
    UPDATE  GE_ENTITY_ATTRIBUTES
    SET     INIT_EXPRESSION_ID = NULL, VALID_EXPRESSION_ID = NULL
    WHERE   ENTITY_ID in (SELECT ENTITY_ID FROM GE_ENTITY WHERE NAME_='LDC_ATECLIREPO');

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
  LDC_ATECLIREPO_.tbEntityAttributeName(90043169) := 'LDC_ATECLIREPO@ATECLIREPO_ID'; 
  LDC_ATECLIREPO_.tbEntityAttributeName(90043170) := 'LDC_ATECLIREPO@TIPO_REPORTE'; 
  LDC_ATECLIREPO_.tbEntityAttributeName(90043171) := 'LDC_ATECLIREPO@ANO_REPORTE'; 
  LDC_ATECLIREPO_.tbEntityAttributeName(90043172) := 'LDC_ATECLIREPO@MES_REPORTE'; 
  LDC_ATECLIREPO_.tbEntityAttributeName(90043173) := 'LDC_ATECLIREPO@APROBADO'; 
  LDC_ATECLIREPO_.tbEntityAttributeName(90043551) := 'LDC_ATECLIREPO@FECHA_APROBACION'; 
END;
/

BEGIN

if (not LDC_ATECLIREPO_.blProcessStatus) then
 return;
end if;

LDC_ATECLIREPO_.old_tb0_0(0):='LDC_ATECLIREPO'
;
LDC_ATECLIREPO_.tb0_0(0):='LDC_ATECLIREPO';
LDC_ATECLIREPO_.old_tb0_1(0):=8764;
LDC_ATECLIREPO_.tb0_1(0):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(LDC_ATECLIREPO_.tb0_0(0), 'ENTITY', 'GE_BOSEQUENCE.NEXTGE_ENTITY');
LDC_ATECLIREPO_.tb0_1(0):=LDC_ATECLIREPO_.tb0_1(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ENTITY fila (0)',1);
UPDATE GE_ENTITY SET NAME_=LDC_ATECLIREPO_.tb0_0(0),
ENTITY_ID=LDC_ATECLIREPO_.tb0_1(0),
MODULE_ID=61,
SELEC_TYPE_OBJECT_ID=null,
INS_SEQ=1,
IN_PERSIST='Y'
,
DESCRIPTION='Reportes de atención al cliente'
,
DISPLAY_NAME='Reporte de atención al cliente'
,
LOAD_CARTRIDGE='N'
,
TABLESPACE='TSD_DEFAULT'
,
CREATION_DATE=to_date('07-10-2013 09:03:11','DD-MM-YYYY HH24:MI:SS'),
LAST_MODIFY_DATE=to_date('11-10-2013 09:13:02','DD-MM-YYYY HH24:MI:SS'),
STATUS='G'
,
ALLOWED_FULL_SCAN='N'

 WHERE ENTITY_ID = LDC_ATECLIREPO_.tb0_1(0);
if not (sql%found) then
INSERT INTO GE_ENTITY(NAME_,ENTITY_ID,MODULE_ID,SELEC_TYPE_OBJECT_ID,INS_SEQ,IN_PERSIST,DESCRIPTION,DISPLAY_NAME,LOAD_CARTRIDGE,TABLESPACE,CREATION_DATE,LAST_MODIFY_DATE,STATUS,ALLOWED_FULL_SCAN) 
VALUES (LDC_ATECLIREPO_.tb0_0(0),
LDC_ATECLIREPO_.tb0_1(0),
61,
null,
1,
'Y'
,
'Reportes de atención al cliente'
,
'Reporte de atención al cliente'
,
'N'
,
'TSD_DEFAULT'
,
to_date('07-10-2013 09:03:11','DD-MM-YYYY HH24:MI:SS'),
to_date('11-10-2013 09:13:02','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
);
end if;

exception when others then
LDC_ATECLIREPO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDC_ATECLIREPO_.blProcessStatus) then
 return;
end if;

LDC_ATECLIREPO_.tb1_0(0):=LDC_ATECLIREPO_.tb0_1(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ENTITY_ADITIONAL fila (0)',1);
UPDATE GE_ENTITY_ADITIONAL SET ENTITY_ID=LDC_ATECLIREPO_.tb1_0(0),
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

 WHERE ENTITY_ID = LDC_ATECLIREPO_.tb1_0(0);
if not (sql%found) then
INSERT INTO GE_ENTITY_ADITIONAL(ENTITY_ID,STATEMENT_ID,QUERY_SERVICE_NAME,PROCESS_SERVICE_NAME,BASE_ENTITY_NAME,BASE_ID_NAME,PRIMARY_KEY_ATTRIBUTE,FOREING_KEY_ATTRIBUTE,ICON,IS_SEARCH,SEARCH_SERVICE_NAME,CONTEXT_MENU_SERVICE,HEADER_TITLES,WINDOWS_TITLE,BATCH_SERVICE_NAME,TIME_EXECUTE_BATCH,EXECUTABLE_NAME_EXECUTE,IS_CUSTOM_ENTITY) 
VALUES (LDC_ATECLIREPO_.tb1_0(0),
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
LDC_ATECLIREPO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDC_ATECLIREPO_.blProcessStatus) then
 return;
end if;

LDC_ATECLIREPO_.tb2_0(0):=LDC_ATECLIREPO_.tb0_1(0);
LDC_ATECLIREPO_.old_tb2_1(0):=90043169;
LDC_ATECLIREPO_.tb2_1(0):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(LDC_ATECLIREPO_.TBENTITYATTRIBUTENAME(LDC_ATECLIREPO_.old_tb2_1(0)), 'ATTRIBUTE', GE_BOSEQUENCE.NEXTGE_ENTITY_ATTRIBUTES);
LDC_ATECLIREPO_.tb2_1(0):=LDC_ATECLIREPO_.tb2_1(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ENTITY_ATTRIBUTES fila (0)',1);
UPDATE GE_ENTITY_ATTRIBUTES SET ENTITY_ID=LDC_ATECLIREPO_.tb2_0(0),
ENTITY_ATTRIBUTE_ID=LDC_ATECLIREPO_.tb2_1(0),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
GI_COMPONENT_ID=null,
MASK_ID=null,
REFERENCE=null,
ATTRIBUTE_TYPE_ID=1,
TECHNICAL_NAME='ATECLIREPO_ID'
,
SECUENCE_=0,
KEY_='Y'
,
IS_NULL='N'
,
DISPLAY_NAME='Identificador del Reporte'
,
VIEWER_DISPLAY='Y'
,
PRECISION=10,
DEFAULT_VALUE=null,
SCALE=0,
LENGTH=10,
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
 WHERE ENTITY_ATTRIBUTE_ID = LDC_ATECLIREPO_.tb2_1(0);
if not (sql%found) then
INSERT INTO GE_ENTITY_ATTRIBUTES(ENTITY_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,GI_COMPONENT_ID,MASK_ID,REFERENCE,ATTRIBUTE_TYPE_ID,TECHNICAL_NAME,SECUENCE_,KEY_,IS_NULL,DISPLAY_NAME,VIEWER_DISPLAY,PRECISION,DEFAULT_VALUE,SCALE,LENGTH,COMMENT_,TAG_ELEMENT,STATUS,IS_DESCRIPTION,IS_LOV_DESCRIPTION,IS_CHECK_BOX,CHECKED_VALUE,UNCHECKED_VALUE,PROTECTOR_TEXT) 
VALUES (LDC_ATECLIREPO_.tb2_0(0),
LDC_ATECLIREPO_.tb2_1(0),
null,
null,
null,
null,
null,
1,
'ATECLIREPO_ID'
,
0,
'Y'
,
'N'
,
'Identificador del Reporte'
,
'Y'
,
10,
null,
0,
10,
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
LDC_ATECLIREPO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDC_ATECLIREPO_.blProcessStatus) then
 return;
end if;

LDC_ATECLIREPO_.tb2_0(1):=LDC_ATECLIREPO_.tb0_1(0);
LDC_ATECLIREPO_.old_tb2_1(1):=90043170;
LDC_ATECLIREPO_.tb2_1(1):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(LDC_ATECLIREPO_.TBENTITYATTRIBUTENAME(LDC_ATECLIREPO_.old_tb2_1(1)), 'ATTRIBUTE', GE_BOSEQUENCE.NEXTGE_ENTITY_ATTRIBUTES);
LDC_ATECLIREPO_.tb2_1(1):=LDC_ATECLIREPO_.tb2_1(1);
ut_trace.trace('Actualizar o insertar tabla: GE_ENTITY_ATTRIBUTES fila (1)',1);
UPDATE GE_ENTITY_ATTRIBUTES SET ENTITY_ID=LDC_ATECLIREPO_.tb2_0(1),
ENTITY_ATTRIBUTE_ID=LDC_ATECLIREPO_.tb2_1(1),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
GI_COMPONENT_ID=null,
MASK_ID=null,
REFERENCE=null,
ATTRIBUTE_TYPE_ID=2,
TECHNICAL_NAME='TIPO_REPORTE'
,
SECUENCE_=1,
KEY_='N'
,
IS_NULL='N'
,
DISPLAY_NAME='Tipo de reporte formato [A, B, I ] anexo A, anexo B, Itansuca'
,
VIEWER_DISPLAY='Y'
,
PRECISION=null,
DEFAULT_VALUE=null,
SCALE=null,
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
 WHERE ENTITY_ATTRIBUTE_ID = LDC_ATECLIREPO_.tb2_1(1);
if not (sql%found) then
INSERT INTO GE_ENTITY_ATTRIBUTES(ENTITY_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,GI_COMPONENT_ID,MASK_ID,REFERENCE,ATTRIBUTE_TYPE_ID,TECHNICAL_NAME,SECUENCE_,KEY_,IS_NULL,DISPLAY_NAME,VIEWER_DISPLAY,PRECISION,DEFAULT_VALUE,SCALE,LENGTH,COMMENT_,TAG_ELEMENT,STATUS,IS_DESCRIPTION,IS_LOV_DESCRIPTION,IS_CHECK_BOX,CHECKED_VALUE,UNCHECKED_VALUE,PROTECTOR_TEXT) 
VALUES (LDC_ATECLIREPO_.tb2_0(1),
LDC_ATECLIREPO_.tb2_1(1),
null,
null,
null,
null,
null,
2,
'TIPO_REPORTE'
,
1,
'N'
,
'N'
,
'Tipo de reporte formato [A, B, I ] anexo A, anexo B, Itansuca'
,
'Y'
,
null,
null,
null,
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
LDC_ATECLIREPO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDC_ATECLIREPO_.blProcessStatus) then
 return;
end if;

LDC_ATECLIREPO_.tb2_0(2):=LDC_ATECLIREPO_.tb0_1(0);
LDC_ATECLIREPO_.old_tb2_1(2):=90043171;
LDC_ATECLIREPO_.tb2_1(2):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(LDC_ATECLIREPO_.TBENTITYATTRIBUTENAME(LDC_ATECLIREPO_.old_tb2_1(2)), 'ATTRIBUTE', GE_BOSEQUENCE.NEXTGE_ENTITY_ATTRIBUTES);
LDC_ATECLIREPO_.tb2_1(2):=LDC_ATECLIREPO_.tb2_1(2);
ut_trace.trace('Actualizar o insertar tabla: GE_ENTITY_ATTRIBUTES fila (2)',1);
UPDATE GE_ENTITY_ATTRIBUTES SET ENTITY_ID=LDC_ATECLIREPO_.tb2_0(2),
ENTITY_ATTRIBUTE_ID=LDC_ATECLIREPO_.tb2_1(2),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
GI_COMPONENT_ID=null,
MASK_ID=null,
REFERENCE=null,
ATTRIBUTE_TYPE_ID=1,
TECHNICAL_NAME='ANO_REPORTE'
,
SECUENCE_=2,
KEY_='N'
,
IS_NULL='N'
,
DISPLAY_NAME='Año del reporte'
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
 WHERE ENTITY_ATTRIBUTE_ID = LDC_ATECLIREPO_.tb2_1(2);
if not (sql%found) then
INSERT INTO GE_ENTITY_ATTRIBUTES(ENTITY_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,GI_COMPONENT_ID,MASK_ID,REFERENCE,ATTRIBUTE_TYPE_ID,TECHNICAL_NAME,SECUENCE_,KEY_,IS_NULL,DISPLAY_NAME,VIEWER_DISPLAY,PRECISION,DEFAULT_VALUE,SCALE,LENGTH,COMMENT_,TAG_ELEMENT,STATUS,IS_DESCRIPTION,IS_LOV_DESCRIPTION,IS_CHECK_BOX,CHECKED_VALUE,UNCHECKED_VALUE,PROTECTOR_TEXT) 
VALUES (LDC_ATECLIREPO_.tb2_0(2),
LDC_ATECLIREPO_.tb2_1(2),
null,
null,
null,
null,
null,
1,
'ANO_REPORTE'
,
2,
'N'
,
'N'
,
'Año del reporte'
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
LDC_ATECLIREPO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDC_ATECLIREPO_.blProcessStatus) then
 return;
end if;

LDC_ATECLIREPO_.tb2_0(3):=LDC_ATECLIREPO_.tb0_1(0);
LDC_ATECLIREPO_.old_tb2_1(3):=90043172;
LDC_ATECLIREPO_.tb2_1(3):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(LDC_ATECLIREPO_.TBENTITYATTRIBUTENAME(LDC_ATECLIREPO_.old_tb2_1(3)), 'ATTRIBUTE', GE_BOSEQUENCE.NEXTGE_ENTITY_ATTRIBUTES);
LDC_ATECLIREPO_.tb2_1(3):=LDC_ATECLIREPO_.tb2_1(3);
ut_trace.trace('Actualizar o insertar tabla: GE_ENTITY_ATTRIBUTES fila (3)',1);
UPDATE GE_ENTITY_ATTRIBUTES SET ENTITY_ID=LDC_ATECLIREPO_.tb2_0(3),
ENTITY_ATTRIBUTE_ID=LDC_ATECLIREPO_.tb2_1(3),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
GI_COMPONENT_ID=null,
MASK_ID=null,
REFERENCE=null,
ATTRIBUTE_TYPE_ID=1,
TECHNICAL_NAME='MES_REPORTE'
,
SECUENCE_=3,
KEY_='N'
,
IS_NULL='N'
,
DISPLAY_NAME='Mes del reporte'
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
 WHERE ENTITY_ATTRIBUTE_ID = LDC_ATECLIREPO_.tb2_1(3);
if not (sql%found) then
INSERT INTO GE_ENTITY_ATTRIBUTES(ENTITY_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,GI_COMPONENT_ID,MASK_ID,REFERENCE,ATTRIBUTE_TYPE_ID,TECHNICAL_NAME,SECUENCE_,KEY_,IS_NULL,DISPLAY_NAME,VIEWER_DISPLAY,PRECISION,DEFAULT_VALUE,SCALE,LENGTH,COMMENT_,TAG_ELEMENT,STATUS,IS_DESCRIPTION,IS_LOV_DESCRIPTION,IS_CHECK_BOX,CHECKED_VALUE,UNCHECKED_VALUE,PROTECTOR_TEXT) 
VALUES (LDC_ATECLIREPO_.tb2_0(3),
LDC_ATECLIREPO_.tb2_1(3),
null,
null,
null,
null,
null,
1,
'MES_REPORTE'
,
3,
'N'
,
'N'
,
'Mes del reporte'
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
LDC_ATECLIREPO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDC_ATECLIREPO_.blProcessStatus) then
 return;
end if;

LDC_ATECLIREPO_.tb2_0(4):=LDC_ATECLIREPO_.tb0_1(0);
LDC_ATECLIREPO_.old_tb2_1(4):=90043173;
LDC_ATECLIREPO_.tb2_1(4):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(LDC_ATECLIREPO_.TBENTITYATTRIBUTENAME(LDC_ATECLIREPO_.old_tb2_1(4)), 'ATTRIBUTE', GE_BOSEQUENCE.NEXTGE_ENTITY_ATTRIBUTES);
LDC_ATECLIREPO_.tb2_1(4):=LDC_ATECLIREPO_.tb2_1(4);
ut_trace.trace('Actualizar o insertar tabla: GE_ENTITY_ATTRIBUTES fila (4)',1);
UPDATE GE_ENTITY_ATTRIBUTES SET ENTITY_ID=LDC_ATECLIREPO_.tb2_0(4),
ENTITY_ATTRIBUTE_ID=LDC_ATECLIREPO_.tb2_1(4),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
GI_COMPONENT_ID=null,
MASK_ID=null,
REFERENCE=null,
ATTRIBUTE_TYPE_ID=2,
TECHNICAL_NAME='APROBADO'
,
SECUENCE_=4,
KEY_='N'
,
IS_NULL='N'
,
DISPLAY_NAME='Aprobación SI[S] NO[N]'
,
VIEWER_DISPLAY='Y'
,
PRECISION=null,
DEFAULT_VALUE=null,
SCALE=null,
LENGTH=1,
COMMENT_=null,
TAG_ELEMENT=null,
STATUS='G'
,
IS_DESCRIPTION='N'
,
IS_LOV_DESCRIPTION='Y'
,
IS_CHECK_BOX='N'
,
CHECKED_VALUE=null,
UNCHECKED_VALUE=null,
PROTECTOR_TEXT=null
 WHERE ENTITY_ATTRIBUTE_ID = LDC_ATECLIREPO_.tb2_1(4);
if not (sql%found) then
INSERT INTO GE_ENTITY_ATTRIBUTES(ENTITY_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,GI_COMPONENT_ID,MASK_ID,REFERENCE,ATTRIBUTE_TYPE_ID,TECHNICAL_NAME,SECUENCE_,KEY_,IS_NULL,DISPLAY_NAME,VIEWER_DISPLAY,PRECISION,DEFAULT_VALUE,SCALE,LENGTH,COMMENT_,TAG_ELEMENT,STATUS,IS_DESCRIPTION,IS_LOV_DESCRIPTION,IS_CHECK_BOX,CHECKED_VALUE,UNCHECKED_VALUE,PROTECTOR_TEXT) 
VALUES (LDC_ATECLIREPO_.tb2_0(4),
LDC_ATECLIREPO_.tb2_1(4),
null,
null,
null,
null,
null,
2,
'APROBADO'
,
4,
'N'
,
'N'
,
'Aprobación SI[S] NO[N]'
,
'Y'
,
null,
null,
null,
1,
null,
null,
'G'
,
'N'
,
'Y'
,
'N'
,
null,
null,
null);
end if;

exception when others then
LDC_ATECLIREPO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDC_ATECLIREPO_.blProcessStatus) then
 return;
end if;

LDC_ATECLIREPO_.tb3_0(0):=11;
LDC_ATECLIREPO_.tb3_1(0):=LDC_ATECLIREPO_.tb2_1(4);
ut_trace.trace('Actualizar o insertar tabla: GE_ATTR_ALLOWED_VALUES fila (0)',1);
UPDATE GE_ATTR_ALLOWED_VALUES SET ATTR_ALLOW_VALUE_ID=LDC_ATECLIREPO_.tb3_0(0),
ENTITY_ATTRIBUTE_ID=LDC_ATECLIREPO_.tb3_1(0),
VALUE_='S'
,
DESCRIPTION='SI'

 WHERE ATTR_ALLOW_VALUE_ID = LDC_ATECLIREPO_.tb3_0(0);
if not (sql%found) then
INSERT INTO GE_ATTR_ALLOWED_VALUES(ATTR_ALLOW_VALUE_ID,ENTITY_ATTRIBUTE_ID,VALUE_,DESCRIPTION) 
VALUES (LDC_ATECLIREPO_.tb3_0(0),
LDC_ATECLIREPO_.tb3_1(0),
'S'
,
'SI'
);
end if;

exception when others then
LDC_ATECLIREPO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDC_ATECLIREPO_.blProcessStatus) then
 return;
end if;

LDC_ATECLIREPO_.tb3_0(1):=12;
LDC_ATECLIREPO_.tb3_1(1):=LDC_ATECLIREPO_.tb2_1(4);
ut_trace.trace('Actualizar o insertar tabla: GE_ATTR_ALLOWED_VALUES fila (1)',1);
UPDATE GE_ATTR_ALLOWED_VALUES SET ATTR_ALLOW_VALUE_ID=LDC_ATECLIREPO_.tb3_0(1),
ENTITY_ATTRIBUTE_ID=LDC_ATECLIREPO_.tb3_1(1),
VALUE_='N'
,
DESCRIPTION='No'

 WHERE ATTR_ALLOW_VALUE_ID = LDC_ATECLIREPO_.tb3_0(1);
if not (sql%found) then
INSERT INTO GE_ATTR_ALLOWED_VALUES(ATTR_ALLOW_VALUE_ID,ENTITY_ATTRIBUTE_ID,VALUE_,DESCRIPTION) 
VALUES (LDC_ATECLIREPO_.tb3_0(1),
LDC_ATECLIREPO_.tb3_1(1),
'N'
,
'No'
);
end if;

exception when others then
LDC_ATECLIREPO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDC_ATECLIREPO_.blProcessStatus) then
 return;
end if;

LDC_ATECLIREPO_.tb2_0(5):=LDC_ATECLIREPO_.tb0_1(0);
LDC_ATECLIREPO_.old_tb2_1(5):=90043551;
LDC_ATECLIREPO_.tb2_1(5):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(LDC_ATECLIREPO_.TBENTITYATTRIBUTENAME(LDC_ATECLIREPO_.old_tb2_1(5)), 'ATTRIBUTE', GE_BOSEQUENCE.NEXTGE_ENTITY_ATTRIBUTES);
LDC_ATECLIREPO_.tb2_1(5):=LDC_ATECLIREPO_.tb2_1(5);
ut_trace.trace('Actualizar o insertar tabla: GE_ENTITY_ATTRIBUTES fila (5)',1);
UPDATE GE_ENTITY_ATTRIBUTES SET ENTITY_ID=LDC_ATECLIREPO_.tb2_0(5),
ENTITY_ATTRIBUTE_ID=LDC_ATECLIREPO_.tb2_1(5),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
GI_COMPONENT_ID=null,
MASK_ID=null,
REFERENCE=null,
ATTRIBUTE_TYPE_ID=3,
TECHNICAL_NAME='FECHA_APROBACION'
,
SECUENCE_=4,
KEY_='N'
,
IS_NULL='Y'
,
DISPLAY_NAME='Fecha de aprobaci¿n'
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
 WHERE ENTITY_ATTRIBUTE_ID = LDC_ATECLIREPO_.tb2_1(5);
if not (sql%found) then
INSERT INTO GE_ENTITY_ATTRIBUTES(ENTITY_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,GI_COMPONENT_ID,MASK_ID,REFERENCE,ATTRIBUTE_TYPE_ID,TECHNICAL_NAME,SECUENCE_,KEY_,IS_NULL,DISPLAY_NAME,VIEWER_DISPLAY,PRECISION,DEFAULT_VALUE,SCALE,LENGTH,COMMENT_,TAG_ELEMENT,STATUS,IS_DESCRIPTION,IS_LOV_DESCRIPTION,IS_CHECK_BOX,CHECKED_VALUE,UNCHECKED_VALUE,PROTECTOR_TEXT) 
VALUES (LDC_ATECLIREPO_.tb2_0(5),
LDC_ATECLIREPO_.tb2_1(5),
null,
null,
null,
null,
null,
3,
'FECHA_APROBACION'
,
4,
'N'
,
'Y'
,
'Fecha de aprobaci¿n'
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
LDC_ATECLIREPO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
DECLARE
  nuerr number;
  sberr varchar2(4000);
BEGIN

if (not LDC_ATECLIREPO_.blProcessStatus) then
 return;
end if;
  commit;
  gi_boframeworkentityattribute.UpdateEntityReferences('LDC_ATECLIREPO');
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

begin
SA_BOCreatePackages.DropPackage('LDC_ATECLIREPO_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:LDC_ATECLIREPO_******************************'); end;
/

