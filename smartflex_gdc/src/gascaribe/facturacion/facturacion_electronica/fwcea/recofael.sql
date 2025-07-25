BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('RECOFAEL_',
'CREATE OR REPLACE PACKAGE RECOFAEL_ IS ' || chr(10) ||
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
'END RECOFAEL_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:RECOFAEL_******************************'); END;
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
            WHERE   ENTITY_ID in (SELECT ENTITY_ID FROM GE_ENTITY WHERE NAME_='RECOFAEL')
            UNION
            SELECT  INIT_EXPRESSION_ID
            FROM    GE_ENTITY_ATTRIBUTES
            WHERE   ENTITY_ID in (SELECT ENTITY_ID FROM GE_ENTITY WHERE NAME_='RECOFAEL')
        )
        AND     USER_OBJECTS.object_name(+) = GR_CONFIG_EXPRESSION.OBJECT_NAME;
BEGIN
    ut_trace.trace('Referencias asociadas a atributos borrados', 1);
    
if (not RECOFAEL_.blProcessStatus) then
 return;
end if;

    if (cuConfigExpression%ISOPEN) then
        CLOSE cuConfigExpression;
    end if;
    
    DELETE FROM GE_ATTR_VAL_EXPRESS WHERE (ENTITY_ATTRIBUTE_ID) in (SELECT ENTITY_ATTRIBUTE_ID FROM GE_ENTITY_ATTRIBUTES WHERE (ENTITY_ID) in (SELECT ENTITY_ID FROM GE_ENTITY WHERE NAME_='RECOFAEL'));
    DELETE FROM GE_ATTR_ALLOWED_VALUES WHERE (ENTITY_ATTRIBUTE_ID) in (SELECT ENTITY_ATTRIBUTE_ID FROM GE_ENTITY_ATTRIBUTES WHERE (ENTITY_ID) in (SELECT ENTITY_ID FROM GE_ENTITY WHERE NAME_='RECOFAEL'));
    
    OPEN    cuConfigExpression;
    
    UPDATE  GE_ENTITY_ATTRIBUTES
    SET     INIT_EXPRESSION_ID = NULL, VALID_EXPRESSION_ID = NULL
    WHERE   ENTITY_ID in (SELECT ENTITY_ID FROM GE_ENTITY WHERE NAME_='RECOFAEL');

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
  RECOFAEL_.tbEntityAttributeName(90199784) := 'RECOFAEL@CODIGO'; 
  RECOFAEL_.tbEntityAttributeName(90199794) := 'RECOFAEL@TIPO_DOCUMENTO'; 
  RECOFAEL_.tbEntityAttributeName(90199785) := 'RECOFAEL@PREFIJO'; 
  RECOFAEL_.tbEntityAttributeName(90199786) := 'RECOFAEL@CONS_INICIAL'; 
  RECOFAEL_.tbEntityAttributeName(90199793) := 'RECOFAEL@RESOLUCION'; 
  RECOFAEL_.tbEntityAttributeName(90199787) := 'RECOFAEL@CONS_FINAL'; 
  RECOFAEL_.tbEntityAttributeName(90199788) := 'RECOFAEL@ULTIMO_CONS'; 
  RECOFAEL_.tbEntityAttributeName(90199789) := 'RECOFAEL@ESTADO'; 
  RECOFAEL_.tbEntityAttributeName(90199790) := 'RECOFAEL@FECHA_REGISTRO'; 
  RECOFAEL_.tbEntityAttributeName(90199791) := 'RECOFAEL@USUARIO'; 
  RECOFAEL_.tbEntityAttributeName(90199792) := 'RECOFAEL@TERMINAL'; 
  RECOFAEL_.tbEntityAttributeName(90199795) := 'RECOFAEL@FECHA_RESOLUCION'; 
  RECOFAEL_.tbEntityAttributeName(90199796) := 'RECOFAEL@FECHA_INI_VIGENCIA'; 
  RECOFAEL_.tbEntityAttributeName(90199797) := 'RECOFAEL@FECHA_FIN_VIGENCIA'; 
  RECOFAEL_.tbEntityAttributeName(90200375) := 'RECOFAEL@EMPRESA'; 
END;
/

BEGIN

if (not RECOFAEL_.blProcessStatus) then
 return;
end if;

RECOFAEL_.old_tb0_0(0):='RECOFAEL'
;
RECOFAEL_.tb0_0(0):='RECOFAEL';
RECOFAEL_.old_tb0_1(0):=6176;
RECOFAEL_.tb0_1(0):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(RECOFAEL_.tb0_0(0), 'ENTITY', 'GE_BOSEQUENCE.NEXTGE_ENTITY');
RECOFAEL_.tb0_1(0):=RECOFAEL_.tb0_1(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ENTITY fila (0)',1);
UPDATE GE_ENTITY SET NAME_=RECOFAEL_.tb0_0(0),
ENTITY_ID=RECOFAEL_.tb0_1(0),
MODULE_ID=61,
SELEC_TYPE_OBJECT_ID=null,
INS_SEQ=null,
IN_PERSIST='Y'
,
DESCRIPTION='Resolucion de Consecutivo Facturacion Electronica'
,
DISPLAY_NAME='RECOFAEL '
,
LOAD_CARTRIDGE='N'
,
TABLESPACE='TSD_DEFAULT'
,
CREATION_DATE=to_date('03-01-2024 16:07:35','DD-MM-YYYY HH24:MI:SS'),
LAST_MODIFY_DATE=to_date('21-04-2025 10:59:50','DD-MM-YYYY HH24:MI:SS'),
STATUS='G'
,
ALLOWED_FULL_SCAN='Y'

 WHERE ENTITY_ID = RECOFAEL_.tb0_1(0);
if not (sql%found) then
INSERT INTO GE_ENTITY(NAME_,ENTITY_ID,MODULE_ID,SELEC_TYPE_OBJECT_ID,INS_SEQ,IN_PERSIST,DESCRIPTION,DISPLAY_NAME,LOAD_CARTRIDGE,TABLESPACE,CREATION_DATE,LAST_MODIFY_DATE,STATUS,ALLOWED_FULL_SCAN) 
VALUES (RECOFAEL_.tb0_0(0),
RECOFAEL_.tb0_1(0),
61,
null,
null,
'Y'
,
'Resolucion de Consecutivo Facturacion Electronica'
,
'RECOFAEL '
,
'N'
,
'TSD_DEFAULT'
,
to_date('03-01-2024 16:07:35','DD-MM-YYYY HH24:MI:SS'),
to_date('21-04-2025 10:59:50','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'Y'
);
end if;

exception when others then
RECOFAEL_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RECOFAEL_.blProcessStatus) then
 return;
end if;

RECOFAEL_.tb1_0(0):=RECOFAEL_.tb0_1(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ENTITY_ADITIONAL fila (0)',1);
UPDATE GE_ENTITY_ADITIONAL SET ENTITY_ID=RECOFAEL_.tb1_0(0),
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

 WHERE ENTITY_ID = RECOFAEL_.tb1_0(0);
if not (sql%found) then
INSERT INTO GE_ENTITY_ADITIONAL(ENTITY_ID,STATEMENT_ID,QUERY_SERVICE_NAME,PROCESS_SERVICE_NAME,BASE_ENTITY_NAME,BASE_ID_NAME,PRIMARY_KEY_ATTRIBUTE,FOREING_KEY_ATTRIBUTE,ICON,IS_SEARCH,SEARCH_SERVICE_NAME,CONTEXT_MENU_SERVICE,HEADER_TITLES,WINDOWS_TITLE,BATCH_SERVICE_NAME,TIME_EXECUTE_BATCH,EXECUTABLE_NAME_EXECUTE,IS_CUSTOM_ENTITY) 
VALUES (RECOFAEL_.tb1_0(0),
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
RECOFAEL_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RECOFAEL_.blProcessStatus) then
 return;
end if;

RECOFAEL_.tb2_0(0):=RECOFAEL_.tb0_1(0);
RECOFAEL_.old_tb2_1(0):=90200375;
RECOFAEL_.tb2_1(0):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(RECOFAEL_.TBENTITYATTRIBUTENAME(RECOFAEL_.old_tb2_1(0)), 'ATTRIBUTE', GE_BOSEQUENCE.NEXTGE_ENTITY_ATTRIBUTES);
RECOFAEL_.tb2_1(0):=RECOFAEL_.tb2_1(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ENTITY_ATTRIBUTES fila (0)',1);
UPDATE GE_ENTITY_ATTRIBUTES SET ENTITY_ID=RECOFAEL_.tb2_0(0),
ENTITY_ATTRIBUTE_ID=RECOFAEL_.tb2_1(0),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
GI_COMPONENT_ID=null,
MASK_ID=null,
REFERENCE=null,
ATTRIBUTE_TYPE_ID=2,
TECHNICAL_NAME='EMPRESA'
,
SECUENCE_=14,
KEY_='N'
,
IS_NULL='N'
,
DISPLAY_NAME='Empresa'
,
VIEWER_DISPLAY='Y'
,
PRECISION=null,
DEFAULT_VALUE=null,
SCALE=null,
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
 WHERE ENTITY_ATTRIBUTE_ID = RECOFAEL_.tb2_1(0);
if not (sql%found) then
INSERT INTO GE_ENTITY_ATTRIBUTES(ENTITY_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,GI_COMPONENT_ID,MASK_ID,REFERENCE,ATTRIBUTE_TYPE_ID,TECHNICAL_NAME,SECUENCE_,KEY_,IS_NULL,DISPLAY_NAME,VIEWER_DISPLAY,PRECISION,DEFAULT_VALUE,SCALE,LENGTH,COMMENT_,TAG_ELEMENT,STATUS,IS_DESCRIPTION,IS_LOV_DESCRIPTION,IS_CHECK_BOX,CHECKED_VALUE,UNCHECKED_VALUE,PROTECTOR_TEXT) 
VALUES (RECOFAEL_.tb2_0(0),
RECOFAEL_.tb2_1(0),
null,
null,
null,
null,
null,
2,
'EMPRESA'
,
14,
'N'
,
'N'
,
'Empresa'
,
'Y'
,
null,
null,
null,
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
RECOFAEL_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RECOFAEL_.blProcessStatus) then
 return;
end if;

RECOFAEL_.old_tb3_0(0):=121407539;
RECOFAEL_.tb3_0(0):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
RECOFAEL_.tb3_0(0):=RECOFAEL_.tb3_0(0);
RECOFAEL_.old_tb3_2(0):='GEGE_EXERULINI_CT67E121407539'
;
RECOFAEL_.tb3_2(0):=RECOFAEL_.tb3_0(0);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (0)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,CONFIGURA_TYPE_ID,OBJECT_NAME,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (RECOFAEL_.tb3_0(0),
67,
RECOFAEL_.tb3_2(0),
'PKGENERALSERVICES.FNUGETNEXTSEQUENCEVAL("SEQ_RECOFAEL")'
,
'OPEN'
,
to_date('03-01-2024 16:24:01','DD-MM-YYYY HH24:MI:SS'),
to_date('25-03-2025 10:53:33','DD-MM-YYYY HH24:MI:SS'),
to_date('25-03-2025 10:53:33','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'valor secuencia'
,
'PF'
,
null);

exception when others then
RECOFAEL_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RECOFAEL_.blProcessStatus) then
 return;
end if;

RECOFAEL_.tb2_0(1):=RECOFAEL_.tb0_1(0);
RECOFAEL_.old_tb2_1(1):=90199784;
RECOFAEL_.tb2_1(1):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(RECOFAEL_.TBENTITYATTRIBUTENAME(RECOFAEL_.old_tb2_1(1)), 'ATTRIBUTE', GE_BOSEQUENCE.NEXTGE_ENTITY_ATTRIBUTES);
RECOFAEL_.tb2_1(1):=RECOFAEL_.tb2_1(1);
RECOFAEL_.tb2_2(1):=RECOFAEL_.tb3_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ENTITY_ATTRIBUTES fila (1)',1);
UPDATE GE_ENTITY_ATTRIBUTES SET ENTITY_ID=RECOFAEL_.tb2_0(1),
ENTITY_ATTRIBUTE_ID=RECOFAEL_.tb2_1(1),
INIT_EXPRESSION_ID=RECOFAEL_.tb2_2(1),
VALID_EXPRESSION_ID=null,
GI_COMPONENT_ID=null,
MASK_ID=null,
REFERENCE=null,
ATTRIBUTE_TYPE_ID=1,
TECHNICAL_NAME='CODIGO'
,
SECUENCE_=0,
KEY_='N'
,
IS_NULL='N'
,
DISPLAY_NAME='Codigo'
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
 WHERE ENTITY_ATTRIBUTE_ID = RECOFAEL_.tb2_1(1);
if not (sql%found) then
INSERT INTO GE_ENTITY_ATTRIBUTES(ENTITY_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,GI_COMPONENT_ID,MASK_ID,REFERENCE,ATTRIBUTE_TYPE_ID,TECHNICAL_NAME,SECUENCE_,KEY_,IS_NULL,DISPLAY_NAME,VIEWER_DISPLAY,PRECISION,DEFAULT_VALUE,SCALE,LENGTH,COMMENT_,TAG_ELEMENT,STATUS,IS_DESCRIPTION,IS_LOV_DESCRIPTION,IS_CHECK_BOX,CHECKED_VALUE,UNCHECKED_VALUE,PROTECTOR_TEXT) 
VALUES (RECOFAEL_.tb2_0(1),
RECOFAEL_.tb2_1(1),
RECOFAEL_.tb2_2(1),
null,
null,
null,
null,
1,
'CODIGO'
,
0,
'N'
,
'N'
,
'Codigo'
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
RECOFAEL_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RECOFAEL_.blProcessStatus) then
 return;
end if;

RECOFAEL_.tb2_0(2):=RECOFAEL_.tb0_1(0);
RECOFAEL_.old_tb2_1(2):=90199785;
RECOFAEL_.tb2_1(2):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(RECOFAEL_.TBENTITYATTRIBUTENAME(RECOFAEL_.old_tb2_1(2)), 'ATTRIBUTE', GE_BOSEQUENCE.NEXTGE_ENTITY_ATTRIBUTES);
RECOFAEL_.tb2_1(2):=RECOFAEL_.tb2_1(2);
ut_trace.trace('Actualizar o insertar tabla: GE_ENTITY_ATTRIBUTES fila (2)',1);
UPDATE GE_ENTITY_ATTRIBUTES SET ENTITY_ID=RECOFAEL_.tb2_0(2),
ENTITY_ATTRIBUTE_ID=RECOFAEL_.tb2_1(2),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
GI_COMPONENT_ID=null,
MASK_ID=null,
REFERENCE=null,
ATTRIBUTE_TYPE_ID=2,
TECHNICAL_NAME='PREFIJO'
,
SECUENCE_=1,
KEY_='N'
,
IS_NULL='N'
,
DISPLAY_NAME='Prefijo'
,
VIEWER_DISPLAY='Y'
,
PRECISION=null,
DEFAULT_VALUE=null,
SCALE=null,
LENGTH=30,
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
 WHERE ENTITY_ATTRIBUTE_ID = RECOFAEL_.tb2_1(2);
if not (sql%found) then
INSERT INTO GE_ENTITY_ATTRIBUTES(ENTITY_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,GI_COMPONENT_ID,MASK_ID,REFERENCE,ATTRIBUTE_TYPE_ID,TECHNICAL_NAME,SECUENCE_,KEY_,IS_NULL,DISPLAY_NAME,VIEWER_DISPLAY,PRECISION,DEFAULT_VALUE,SCALE,LENGTH,COMMENT_,TAG_ELEMENT,STATUS,IS_DESCRIPTION,IS_LOV_DESCRIPTION,IS_CHECK_BOX,CHECKED_VALUE,UNCHECKED_VALUE,PROTECTOR_TEXT) 
VALUES (RECOFAEL_.tb2_0(2),
RECOFAEL_.tb2_1(2),
null,
null,
null,
null,
null,
2,
'PREFIJO'
,
1,
'N'
,
'N'
,
'Prefijo'
,
'Y'
,
null,
null,
null,
30,
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
RECOFAEL_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RECOFAEL_.blProcessStatus) then
 return;
end if;

RECOFAEL_.tb2_0(3):=RECOFAEL_.tb0_1(0);
RECOFAEL_.old_tb2_1(3):=90199786;
RECOFAEL_.tb2_1(3):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(RECOFAEL_.TBENTITYATTRIBUTENAME(RECOFAEL_.old_tb2_1(3)), 'ATTRIBUTE', GE_BOSEQUENCE.NEXTGE_ENTITY_ATTRIBUTES);
RECOFAEL_.tb2_1(3):=RECOFAEL_.tb2_1(3);
ut_trace.trace('Actualizar o insertar tabla: GE_ENTITY_ATTRIBUTES fila (3)',1);
UPDATE GE_ENTITY_ATTRIBUTES SET ENTITY_ID=RECOFAEL_.tb2_0(3),
ENTITY_ATTRIBUTE_ID=RECOFAEL_.tb2_1(3),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
GI_COMPONENT_ID=null,
MASK_ID=null,
REFERENCE=null,
ATTRIBUTE_TYPE_ID=1,
TECHNICAL_NAME='CONS_INICIAL'
,
SECUENCE_=2,
KEY_='N'
,
IS_NULL='N'
,
DISPLAY_NAME='Consecutivo Inicial'
,
VIEWER_DISPLAY='Y'
,
PRECISION=20,
DEFAULT_VALUE=null,
SCALE=0,
LENGTH=20,
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
 WHERE ENTITY_ATTRIBUTE_ID = RECOFAEL_.tb2_1(3);
if not (sql%found) then
INSERT INTO GE_ENTITY_ATTRIBUTES(ENTITY_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,GI_COMPONENT_ID,MASK_ID,REFERENCE,ATTRIBUTE_TYPE_ID,TECHNICAL_NAME,SECUENCE_,KEY_,IS_NULL,DISPLAY_NAME,VIEWER_DISPLAY,PRECISION,DEFAULT_VALUE,SCALE,LENGTH,COMMENT_,TAG_ELEMENT,STATUS,IS_DESCRIPTION,IS_LOV_DESCRIPTION,IS_CHECK_BOX,CHECKED_VALUE,UNCHECKED_VALUE,PROTECTOR_TEXT) 
VALUES (RECOFAEL_.tb2_0(3),
RECOFAEL_.tb2_1(3),
null,
null,
null,
null,
null,
1,
'CONS_INICIAL'
,
2,
'N'
,
'N'
,
'Consecutivo Inicial'
,
'Y'
,
20,
null,
0,
20,
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
RECOFAEL_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RECOFAEL_.blProcessStatus) then
 return;
end if;

RECOFAEL_.tb2_0(4):=RECOFAEL_.tb0_1(0);
RECOFAEL_.old_tb2_1(4):=90199787;
RECOFAEL_.tb2_1(4):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(RECOFAEL_.TBENTITYATTRIBUTENAME(RECOFAEL_.old_tb2_1(4)), 'ATTRIBUTE', GE_BOSEQUENCE.NEXTGE_ENTITY_ATTRIBUTES);
RECOFAEL_.tb2_1(4):=RECOFAEL_.tb2_1(4);
ut_trace.trace('Actualizar o insertar tabla: GE_ENTITY_ATTRIBUTES fila (4)',1);
UPDATE GE_ENTITY_ATTRIBUTES SET ENTITY_ID=RECOFAEL_.tb2_0(4),
ENTITY_ATTRIBUTE_ID=RECOFAEL_.tb2_1(4),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
GI_COMPONENT_ID=null,
MASK_ID=null,
REFERENCE=null,
ATTRIBUTE_TYPE_ID=1,
TECHNICAL_NAME='CONS_FINAL'
,
SECUENCE_=3,
KEY_='N'
,
IS_NULL='N'
,
DISPLAY_NAME='Consecutivo Final'
,
VIEWER_DISPLAY='Y'
,
PRECISION=20,
DEFAULT_VALUE=null,
SCALE=0,
LENGTH=20,
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
 WHERE ENTITY_ATTRIBUTE_ID = RECOFAEL_.tb2_1(4);
if not (sql%found) then
INSERT INTO GE_ENTITY_ATTRIBUTES(ENTITY_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,GI_COMPONENT_ID,MASK_ID,REFERENCE,ATTRIBUTE_TYPE_ID,TECHNICAL_NAME,SECUENCE_,KEY_,IS_NULL,DISPLAY_NAME,VIEWER_DISPLAY,PRECISION,DEFAULT_VALUE,SCALE,LENGTH,COMMENT_,TAG_ELEMENT,STATUS,IS_DESCRIPTION,IS_LOV_DESCRIPTION,IS_CHECK_BOX,CHECKED_VALUE,UNCHECKED_VALUE,PROTECTOR_TEXT) 
VALUES (RECOFAEL_.tb2_0(4),
RECOFAEL_.tb2_1(4),
null,
null,
null,
null,
null,
1,
'CONS_FINAL'
,
3,
'N'
,
'N'
,
'Consecutivo Final'
,
'Y'
,
20,
null,
0,
20,
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
RECOFAEL_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RECOFAEL_.blProcessStatus) then
 return;
end if;

RECOFAEL_.tb2_0(5):=RECOFAEL_.tb0_1(0);
RECOFAEL_.old_tb2_1(5):=90199788;
RECOFAEL_.tb2_1(5):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(RECOFAEL_.TBENTITYATTRIBUTENAME(RECOFAEL_.old_tb2_1(5)), 'ATTRIBUTE', GE_BOSEQUENCE.NEXTGE_ENTITY_ATTRIBUTES);
RECOFAEL_.tb2_1(5):=RECOFAEL_.tb2_1(5);
ut_trace.trace('Actualizar o insertar tabla: GE_ENTITY_ATTRIBUTES fila (5)',1);
UPDATE GE_ENTITY_ATTRIBUTES SET ENTITY_ID=RECOFAEL_.tb2_0(5),
ENTITY_ATTRIBUTE_ID=RECOFAEL_.tb2_1(5),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
GI_COMPONENT_ID=null,
MASK_ID=null,
REFERENCE=null,
ATTRIBUTE_TYPE_ID=1,
TECHNICAL_NAME='ULTIMO_CONS'
,
SECUENCE_=4,
KEY_='N'
,
IS_NULL='Y'
,
DISPLAY_NAME='Ultimo Consecutivo'
,
VIEWER_DISPLAY='Y'
,
PRECISION=20,
DEFAULT_VALUE=null,
SCALE=0,
LENGTH=20,
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
 WHERE ENTITY_ATTRIBUTE_ID = RECOFAEL_.tb2_1(5);
if not (sql%found) then
INSERT INTO GE_ENTITY_ATTRIBUTES(ENTITY_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,GI_COMPONENT_ID,MASK_ID,REFERENCE,ATTRIBUTE_TYPE_ID,TECHNICAL_NAME,SECUENCE_,KEY_,IS_NULL,DISPLAY_NAME,VIEWER_DISPLAY,PRECISION,DEFAULT_VALUE,SCALE,LENGTH,COMMENT_,TAG_ELEMENT,STATUS,IS_DESCRIPTION,IS_LOV_DESCRIPTION,IS_CHECK_BOX,CHECKED_VALUE,UNCHECKED_VALUE,PROTECTOR_TEXT) 
VALUES (RECOFAEL_.tb2_0(5),
RECOFAEL_.tb2_1(5),
null,
null,
null,
null,
null,
1,
'ULTIMO_CONS'
,
4,
'N'
,
'Y'
,
'Ultimo Consecutivo'
,
'Y'
,
20,
null,
0,
20,
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
RECOFAEL_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RECOFAEL_.blProcessStatus) then
 return;
end if;

RECOFAEL_.tb2_0(6):=RECOFAEL_.tb0_1(0);
RECOFAEL_.old_tb2_1(6):=90199789;
RECOFAEL_.tb2_1(6):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(RECOFAEL_.TBENTITYATTRIBUTENAME(RECOFAEL_.old_tb2_1(6)), 'ATTRIBUTE', GE_BOSEQUENCE.NEXTGE_ENTITY_ATTRIBUTES);
RECOFAEL_.tb2_1(6):=RECOFAEL_.tb2_1(6);
ut_trace.trace('Actualizar o insertar tabla: GE_ENTITY_ATTRIBUTES fila (6)',1);
UPDATE GE_ENTITY_ATTRIBUTES SET ENTITY_ID=RECOFAEL_.tb2_0(6),
ENTITY_ATTRIBUTE_ID=RECOFAEL_.tb2_1(6),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
GI_COMPONENT_ID=null,
MASK_ID=null,
REFERENCE=null,
ATTRIBUTE_TYPE_ID=2,
TECHNICAL_NAME='ESTADO'
,
SECUENCE_=5,
KEY_='N'
,
IS_NULL='N'
,
DISPLAY_NAME='Estado'
,
VIEWER_DISPLAY='Y'
,
PRECISION=null,
DEFAULT_VALUE='A'
,
SCALE=null,
LENGTH=1,
COMMENT_=null,
TAG_ELEMENT=null,
STATUS='G'
,
IS_DESCRIPTION='N'
,
IS_LOV_DESCRIPTION='N'
,
IS_CHECK_BOX='Y'
,
CHECKED_VALUE='A'
,
UNCHECKED_VALUE='I'
,
PROTECTOR_TEXT=null
 WHERE ENTITY_ATTRIBUTE_ID = RECOFAEL_.tb2_1(6);
if not (sql%found) then
INSERT INTO GE_ENTITY_ATTRIBUTES(ENTITY_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,GI_COMPONENT_ID,MASK_ID,REFERENCE,ATTRIBUTE_TYPE_ID,TECHNICAL_NAME,SECUENCE_,KEY_,IS_NULL,DISPLAY_NAME,VIEWER_DISPLAY,PRECISION,DEFAULT_VALUE,SCALE,LENGTH,COMMENT_,TAG_ELEMENT,STATUS,IS_DESCRIPTION,IS_LOV_DESCRIPTION,IS_CHECK_BOX,CHECKED_VALUE,UNCHECKED_VALUE,PROTECTOR_TEXT) 
VALUES (RECOFAEL_.tb2_0(6),
RECOFAEL_.tb2_1(6),
null,
null,
null,
null,
null,
2,
'ESTADO'
,
5,
'N'
,
'N'
,
'Estado'
,
'Y'
,
null,
'A'
,
null,
1,
null,
null,
'G'
,
'N'
,
'N'
,
'Y'
,
'A'
,
'I'
,
null);
end if;

exception when others then
RECOFAEL_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RECOFAEL_.blProcessStatus) then
 return;
end if;

RECOFAEL_.tb2_0(7):=RECOFAEL_.tb0_1(0);
RECOFAEL_.old_tb2_1(7):=90199790;
RECOFAEL_.tb2_1(7):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(RECOFAEL_.TBENTITYATTRIBUTENAME(RECOFAEL_.old_tb2_1(7)), 'ATTRIBUTE', GE_BOSEQUENCE.NEXTGE_ENTITY_ATTRIBUTES);
RECOFAEL_.tb2_1(7):=RECOFAEL_.tb2_1(7);
ut_trace.trace('Actualizar o insertar tabla: GE_ENTITY_ATTRIBUTES fila (7)',1);
UPDATE GE_ENTITY_ATTRIBUTES SET ENTITY_ID=RECOFAEL_.tb2_0(7),
ENTITY_ATTRIBUTE_ID=RECOFAEL_.tb2_1(7),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
GI_COMPONENT_ID=null,
MASK_ID=null,
REFERENCE=null,
ATTRIBUTE_TYPE_ID=3,
TECHNICAL_NAME='FECHA_REGISTRO'
,
SECUENCE_=6,
KEY_='N'
,
IS_NULL='Y'
,
DISPLAY_NAME='Fecha de registro'
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
 WHERE ENTITY_ATTRIBUTE_ID = RECOFAEL_.tb2_1(7);
if not (sql%found) then
INSERT INTO GE_ENTITY_ATTRIBUTES(ENTITY_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,GI_COMPONENT_ID,MASK_ID,REFERENCE,ATTRIBUTE_TYPE_ID,TECHNICAL_NAME,SECUENCE_,KEY_,IS_NULL,DISPLAY_NAME,VIEWER_DISPLAY,PRECISION,DEFAULT_VALUE,SCALE,LENGTH,COMMENT_,TAG_ELEMENT,STATUS,IS_DESCRIPTION,IS_LOV_DESCRIPTION,IS_CHECK_BOX,CHECKED_VALUE,UNCHECKED_VALUE,PROTECTOR_TEXT) 
VALUES (RECOFAEL_.tb2_0(7),
RECOFAEL_.tb2_1(7),
null,
null,
null,
null,
null,
3,
'FECHA_REGISTRO'
,
6,
'N'
,
'Y'
,
'Fecha de registro'
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
RECOFAEL_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RECOFAEL_.blProcessStatus) then
 return;
end if;

RECOFAEL_.tb2_0(8):=RECOFAEL_.tb0_1(0);
RECOFAEL_.old_tb2_1(8):=90199791;
RECOFAEL_.tb2_1(8):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(RECOFAEL_.TBENTITYATTRIBUTENAME(RECOFAEL_.old_tb2_1(8)), 'ATTRIBUTE', GE_BOSEQUENCE.NEXTGE_ENTITY_ATTRIBUTES);
RECOFAEL_.tb2_1(8):=RECOFAEL_.tb2_1(8);
ut_trace.trace('Actualizar o insertar tabla: GE_ENTITY_ATTRIBUTES fila (8)',1);
UPDATE GE_ENTITY_ATTRIBUTES SET ENTITY_ID=RECOFAEL_.tb2_0(8),
ENTITY_ATTRIBUTE_ID=RECOFAEL_.tb2_1(8),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
GI_COMPONENT_ID=null,
MASK_ID=null,
REFERENCE=null,
ATTRIBUTE_TYPE_ID=2,
TECHNICAL_NAME='USUARIO'
,
SECUENCE_=7,
KEY_='N'
,
IS_NULL='Y'
,
DISPLAY_NAME='Usuario'
,
VIEWER_DISPLAY='Y'
,
PRECISION=null,
DEFAULT_VALUE=null,
SCALE=null,
LENGTH=50,
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
 WHERE ENTITY_ATTRIBUTE_ID = RECOFAEL_.tb2_1(8);
if not (sql%found) then
INSERT INTO GE_ENTITY_ATTRIBUTES(ENTITY_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,GI_COMPONENT_ID,MASK_ID,REFERENCE,ATTRIBUTE_TYPE_ID,TECHNICAL_NAME,SECUENCE_,KEY_,IS_NULL,DISPLAY_NAME,VIEWER_DISPLAY,PRECISION,DEFAULT_VALUE,SCALE,LENGTH,COMMENT_,TAG_ELEMENT,STATUS,IS_DESCRIPTION,IS_LOV_DESCRIPTION,IS_CHECK_BOX,CHECKED_VALUE,UNCHECKED_VALUE,PROTECTOR_TEXT) 
VALUES (RECOFAEL_.tb2_0(8),
RECOFAEL_.tb2_1(8),
null,
null,
null,
null,
null,
2,
'USUARIO'
,
7,
'N'
,
'Y'
,
'Usuario'
,
'Y'
,
null,
null,
null,
50,
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
RECOFAEL_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RECOFAEL_.blProcessStatus) then
 return;
end if;

RECOFAEL_.tb2_0(9):=RECOFAEL_.tb0_1(0);
RECOFAEL_.old_tb2_1(9):=90199792;
RECOFAEL_.tb2_1(9):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(RECOFAEL_.TBENTITYATTRIBUTENAME(RECOFAEL_.old_tb2_1(9)), 'ATTRIBUTE', GE_BOSEQUENCE.NEXTGE_ENTITY_ATTRIBUTES);
RECOFAEL_.tb2_1(9):=RECOFAEL_.tb2_1(9);
ut_trace.trace('Actualizar o insertar tabla: GE_ENTITY_ATTRIBUTES fila (9)',1);
UPDATE GE_ENTITY_ATTRIBUTES SET ENTITY_ID=RECOFAEL_.tb2_0(9),
ENTITY_ATTRIBUTE_ID=RECOFAEL_.tb2_1(9),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
GI_COMPONENT_ID=null,
MASK_ID=null,
REFERENCE=null,
ATTRIBUTE_TYPE_ID=2,
TECHNICAL_NAME='TERMINAL'
,
SECUENCE_=8,
KEY_='N'
,
IS_NULL='Y'
,
DISPLAY_NAME='Terminal'
,
VIEWER_DISPLAY='Y'
,
PRECISION=null,
DEFAULT_VALUE=null,
SCALE=null,
LENGTH=50,
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
 WHERE ENTITY_ATTRIBUTE_ID = RECOFAEL_.tb2_1(9);
if not (sql%found) then
INSERT INTO GE_ENTITY_ATTRIBUTES(ENTITY_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,GI_COMPONENT_ID,MASK_ID,REFERENCE,ATTRIBUTE_TYPE_ID,TECHNICAL_NAME,SECUENCE_,KEY_,IS_NULL,DISPLAY_NAME,VIEWER_DISPLAY,PRECISION,DEFAULT_VALUE,SCALE,LENGTH,COMMENT_,TAG_ELEMENT,STATUS,IS_DESCRIPTION,IS_LOV_DESCRIPTION,IS_CHECK_BOX,CHECKED_VALUE,UNCHECKED_VALUE,PROTECTOR_TEXT) 
VALUES (RECOFAEL_.tb2_0(9),
RECOFAEL_.tb2_1(9),
null,
null,
null,
null,
null,
2,
'TERMINAL'
,
8,
'N'
,
'Y'
,
'Terminal'
,
'Y'
,
null,
null,
null,
50,
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
RECOFAEL_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RECOFAEL_.blProcessStatus) then
 return;
end if;

RECOFAEL_.tb2_0(10):=RECOFAEL_.tb0_1(0);
RECOFAEL_.old_tb2_1(10):=90199793;
RECOFAEL_.tb2_1(10):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(RECOFAEL_.TBENTITYATTRIBUTENAME(RECOFAEL_.old_tb2_1(10)), 'ATTRIBUTE', GE_BOSEQUENCE.NEXTGE_ENTITY_ATTRIBUTES);
RECOFAEL_.tb2_1(10):=RECOFAEL_.tb2_1(10);
ut_trace.trace('Actualizar o insertar tabla: GE_ENTITY_ATTRIBUTES fila (10)',1);
UPDATE GE_ENTITY_ATTRIBUTES SET ENTITY_ID=RECOFAEL_.tb2_0(10),
ENTITY_ATTRIBUTE_ID=RECOFAEL_.tb2_1(10),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
GI_COMPONENT_ID=null,
MASK_ID=null,
REFERENCE=null,
ATTRIBUTE_TYPE_ID=2,
TECHNICAL_NAME='RESOLUCION'
,
SECUENCE_=2,
KEY_='N'
,
IS_NULL='N'
,
DISPLAY_NAME='Resolucion'
,
VIEWER_DISPLAY='Y'
,
PRECISION=null,
DEFAULT_VALUE=null,
SCALE=null,
LENGTH=40,
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
 WHERE ENTITY_ATTRIBUTE_ID = RECOFAEL_.tb2_1(10);
if not (sql%found) then
INSERT INTO GE_ENTITY_ATTRIBUTES(ENTITY_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,GI_COMPONENT_ID,MASK_ID,REFERENCE,ATTRIBUTE_TYPE_ID,TECHNICAL_NAME,SECUENCE_,KEY_,IS_NULL,DISPLAY_NAME,VIEWER_DISPLAY,PRECISION,DEFAULT_VALUE,SCALE,LENGTH,COMMENT_,TAG_ELEMENT,STATUS,IS_DESCRIPTION,IS_LOV_DESCRIPTION,IS_CHECK_BOX,CHECKED_VALUE,UNCHECKED_VALUE,PROTECTOR_TEXT) 
VALUES (RECOFAEL_.tb2_0(10),
RECOFAEL_.tb2_1(10),
null,
null,
null,
null,
null,
2,
'RESOLUCION'
,
2,
'N'
,
'N'
,
'Resolucion'
,
'Y'
,
null,
null,
null,
40,
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
RECOFAEL_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RECOFAEL_.blProcessStatus) then
 return;
end if;

RECOFAEL_.tb2_0(11):=RECOFAEL_.tb0_1(0);
RECOFAEL_.old_tb2_1(11):=90199794;
RECOFAEL_.tb2_1(11):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(RECOFAEL_.TBENTITYATTRIBUTENAME(RECOFAEL_.old_tb2_1(11)), 'ATTRIBUTE', GE_BOSEQUENCE.NEXTGE_ENTITY_ATTRIBUTES);
RECOFAEL_.tb2_1(11):=RECOFAEL_.tb2_1(11);
ut_trace.trace('Actualizar o insertar tabla: GE_ENTITY_ATTRIBUTES fila (11)',1);
UPDATE GE_ENTITY_ATTRIBUTES SET ENTITY_ID=RECOFAEL_.tb2_0(11),
ENTITY_ATTRIBUTE_ID=RECOFAEL_.tb2_1(11),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
GI_COMPONENT_ID=null,
MASK_ID=null,
REFERENCE=null,
ATTRIBUTE_TYPE_ID=1,
TECHNICAL_NAME='TIPO_DOCUMENTO'
,
SECUENCE_=1,
KEY_='N'
,
IS_NULL='N'
,
DISPLAY_NAME='Tipo de documento'
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
 WHERE ENTITY_ATTRIBUTE_ID = RECOFAEL_.tb2_1(11);
if not (sql%found) then
INSERT INTO GE_ENTITY_ATTRIBUTES(ENTITY_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,GI_COMPONENT_ID,MASK_ID,REFERENCE,ATTRIBUTE_TYPE_ID,TECHNICAL_NAME,SECUENCE_,KEY_,IS_NULL,DISPLAY_NAME,VIEWER_DISPLAY,PRECISION,DEFAULT_VALUE,SCALE,LENGTH,COMMENT_,TAG_ELEMENT,STATUS,IS_DESCRIPTION,IS_LOV_DESCRIPTION,IS_CHECK_BOX,CHECKED_VALUE,UNCHECKED_VALUE,PROTECTOR_TEXT) 
VALUES (RECOFAEL_.tb2_0(11),
RECOFAEL_.tb2_1(11),
null,
null,
null,
null,
null,
1,
'TIPO_DOCUMENTO'
,
1,
'N'
,
'N'
,
'Tipo de documento'
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
RECOFAEL_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RECOFAEL_.blProcessStatus) then
 return;
end if;

RECOFAEL_.tb2_0(12):=RECOFAEL_.tb0_1(0);
RECOFAEL_.old_tb2_1(12):=90199795;
RECOFAEL_.tb2_1(12):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(RECOFAEL_.TBENTITYATTRIBUTENAME(RECOFAEL_.old_tb2_1(12)), 'ATTRIBUTE', GE_BOSEQUENCE.NEXTGE_ENTITY_ATTRIBUTES);
RECOFAEL_.tb2_1(12):=RECOFAEL_.tb2_1(12);
ut_trace.trace('Actualizar o insertar tabla: GE_ENTITY_ATTRIBUTES fila (12)',1);
UPDATE GE_ENTITY_ATTRIBUTES SET ENTITY_ID=RECOFAEL_.tb2_0(12),
ENTITY_ATTRIBUTE_ID=RECOFAEL_.tb2_1(12),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
GI_COMPONENT_ID=null,
MASK_ID=null,
REFERENCE=null,
ATTRIBUTE_TYPE_ID=3,
TECHNICAL_NAME='FECHA_RESOLUCION'
,
SECUENCE_=8,
KEY_='N'
,
IS_NULL='N'
,
DISPLAY_NAME='Fecha de Resolucion'
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
 WHERE ENTITY_ATTRIBUTE_ID = RECOFAEL_.tb2_1(12);
if not (sql%found) then
INSERT INTO GE_ENTITY_ATTRIBUTES(ENTITY_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,GI_COMPONENT_ID,MASK_ID,REFERENCE,ATTRIBUTE_TYPE_ID,TECHNICAL_NAME,SECUENCE_,KEY_,IS_NULL,DISPLAY_NAME,VIEWER_DISPLAY,PRECISION,DEFAULT_VALUE,SCALE,LENGTH,COMMENT_,TAG_ELEMENT,STATUS,IS_DESCRIPTION,IS_LOV_DESCRIPTION,IS_CHECK_BOX,CHECKED_VALUE,UNCHECKED_VALUE,PROTECTOR_TEXT) 
VALUES (RECOFAEL_.tb2_0(12),
RECOFAEL_.tb2_1(12),
null,
null,
null,
null,
null,
3,
'FECHA_RESOLUCION'
,
8,
'N'
,
'N'
,
'Fecha de Resolucion'
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
RECOFAEL_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RECOFAEL_.blProcessStatus) then
 return;
end if;

RECOFAEL_.tb2_0(13):=RECOFAEL_.tb0_1(0);
RECOFAEL_.old_tb2_1(13):=90199796;
RECOFAEL_.tb2_1(13):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(RECOFAEL_.TBENTITYATTRIBUTENAME(RECOFAEL_.old_tb2_1(13)), 'ATTRIBUTE', GE_BOSEQUENCE.NEXTGE_ENTITY_ATTRIBUTES);
RECOFAEL_.tb2_1(13):=RECOFAEL_.tb2_1(13);
ut_trace.trace('Actualizar o insertar tabla: GE_ENTITY_ATTRIBUTES fila (13)',1);
UPDATE GE_ENTITY_ATTRIBUTES SET ENTITY_ID=RECOFAEL_.tb2_0(13),
ENTITY_ATTRIBUTE_ID=RECOFAEL_.tb2_1(13),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
GI_COMPONENT_ID=null,
MASK_ID=null,
REFERENCE=null,
ATTRIBUTE_TYPE_ID=3,
TECHNICAL_NAME='FECHA_INI_VIGENCIA'
,
SECUENCE_=9,
KEY_='N'
,
IS_NULL='N'
,
DISPLAY_NAME='Fecha Inicio Vigencia'
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
 WHERE ENTITY_ATTRIBUTE_ID = RECOFAEL_.tb2_1(13);
if not (sql%found) then
INSERT INTO GE_ENTITY_ATTRIBUTES(ENTITY_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,GI_COMPONENT_ID,MASK_ID,REFERENCE,ATTRIBUTE_TYPE_ID,TECHNICAL_NAME,SECUENCE_,KEY_,IS_NULL,DISPLAY_NAME,VIEWER_DISPLAY,PRECISION,DEFAULT_VALUE,SCALE,LENGTH,COMMENT_,TAG_ELEMENT,STATUS,IS_DESCRIPTION,IS_LOV_DESCRIPTION,IS_CHECK_BOX,CHECKED_VALUE,UNCHECKED_VALUE,PROTECTOR_TEXT) 
VALUES (RECOFAEL_.tb2_0(13),
RECOFAEL_.tb2_1(13),
null,
null,
null,
null,
null,
3,
'FECHA_INI_VIGENCIA'
,
9,
'N'
,
'N'
,
'Fecha Inicio Vigencia'
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
RECOFAEL_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not RECOFAEL_.blProcessStatus) then
 return;
end if;

RECOFAEL_.tb2_0(14):=RECOFAEL_.tb0_1(0);
RECOFAEL_.old_tb2_1(14):=90199797;
RECOFAEL_.tb2_1(14):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(RECOFAEL_.TBENTITYATTRIBUTENAME(RECOFAEL_.old_tb2_1(14)), 'ATTRIBUTE', GE_BOSEQUENCE.NEXTGE_ENTITY_ATTRIBUTES);
RECOFAEL_.tb2_1(14):=RECOFAEL_.tb2_1(14);
ut_trace.trace('Actualizar o insertar tabla: GE_ENTITY_ATTRIBUTES fila (14)',1);
UPDATE GE_ENTITY_ATTRIBUTES SET ENTITY_ID=RECOFAEL_.tb2_0(14),
ENTITY_ATTRIBUTE_ID=RECOFAEL_.tb2_1(14),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
GI_COMPONENT_ID=null,
MASK_ID=null,
REFERENCE=null,
ATTRIBUTE_TYPE_ID=3,
TECHNICAL_NAME='FECHA_FIN_VIGENCIA'
,
SECUENCE_=10,
KEY_='N'
,
IS_NULL='N'
,
DISPLAY_NAME='Fecha Fin Vigencia'
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
 WHERE ENTITY_ATTRIBUTE_ID = RECOFAEL_.tb2_1(14);
if not (sql%found) then
INSERT INTO GE_ENTITY_ATTRIBUTES(ENTITY_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,GI_COMPONENT_ID,MASK_ID,REFERENCE,ATTRIBUTE_TYPE_ID,TECHNICAL_NAME,SECUENCE_,KEY_,IS_NULL,DISPLAY_NAME,VIEWER_DISPLAY,PRECISION,DEFAULT_VALUE,SCALE,LENGTH,COMMENT_,TAG_ELEMENT,STATUS,IS_DESCRIPTION,IS_LOV_DESCRIPTION,IS_CHECK_BOX,CHECKED_VALUE,UNCHECKED_VALUE,PROTECTOR_TEXT) 
VALUES (RECOFAEL_.tb2_0(14),
RECOFAEL_.tb2_1(14),
null,
null,
null,
null,
null,
3,
'FECHA_FIN_VIGENCIA'
,
10,
'N'
,
'N'
,
'Fecha Fin Vigencia'
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
RECOFAEL_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
DECLARE
  nuerr number;
  sberr varchar2(4000);
BEGIN

if (not RECOFAEL_.blProcessStatus) then
 return;
end if;
  commit;
  gi_boframeworkentityattribute.UpdateEntityReferences('RECOFAEL');
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

if (not RECOFAEL_.blProcessStatus) then
 return;
end if;
nuRowProcess:=RECOFAEL_.tb3_0.first;
while (nuRowProcess is not null) loop 
ut_trace.trace('Genera expresión regla:'|| RECOFAEL_.tb3_0(nuRowProcess),1); 
begin
GR_BOINTERFACE_BODY.MakeExpression(RECOFAEL_.tb3_0(nuRowProcess)); 
exception when others then
ut_trace.trace('Fallo la generacion de la regla:'|| RECOFAEL_.tb3_0(nuRowProcess),1);
end;
nuRowProcess := RECOFAEL_.tb3_0.next(nuRowProcess);
END loop;
COMMIT;

exception when others then
RECOFAEL_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

begin
SA_BOCreatePackages.DropPackage('RECOFAEL_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:RECOFAEL_******************************'); end;
/

