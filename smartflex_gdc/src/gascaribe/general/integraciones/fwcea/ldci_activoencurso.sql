BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('LDCI_ACTIVOENCURSO_',
'CREATE OR REPLACE PACKAGE LDCI_ACTIVOENCURSO_ IS ' || chr(10) ||
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
'tb2_3 ty2_3; ' || chr(10) ||
'  type tyCatalogTagName is table of ge_catalog.tag_name%type index by varchar2(200); ' || chr(10) ||
'  tbEntityAttributeName tyCatalogTagName; ' || chr(10) ||
' ' || chr(10) ||
'END LDCI_ACTIVOENCURSO_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:LDCI_ACTIVOENCURSO_******************************'); END;
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
            WHERE   ENTITY_ID in (SELECT ENTITY_ID FROM GE_ENTITY WHERE NAME_='LDCI_ACTIVOENCURSO')
            UNION
            SELECT  INIT_EXPRESSION_ID
            FROM    GE_ENTITY_ATTRIBUTES
            WHERE   ENTITY_ID in (SELECT ENTITY_ID FROM GE_ENTITY WHERE NAME_='LDCI_ACTIVOENCURSO')
        )
        AND     USER_OBJECTS.object_name(+) = GR_CONFIG_EXPRESSION.OBJECT_NAME;
BEGIN
    ut_trace.trace('Referencias asociadas a atributos borrados', 1);
    
if (not LDCI_ACTIVOENCURSO_.blProcessStatus) then
 return;
end if;

    if (cuConfigExpression%ISOPEN) then
        CLOSE cuConfigExpression;
    end if;
    
    DELETE FROM GE_ATTR_VAL_EXPRESS WHERE (ENTITY_ATTRIBUTE_ID) in (SELECT ENTITY_ATTRIBUTE_ID FROM GE_ENTITY_ATTRIBUTES WHERE (ENTITY_ID) in (SELECT ENTITY_ID FROM GE_ENTITY WHERE NAME_='LDCI_ACTIVOENCURSO'));
    DELETE FROM GE_ATTR_ALLOWED_VALUES WHERE (ENTITY_ATTRIBUTE_ID) in (SELECT ENTITY_ATTRIBUTE_ID FROM GE_ENTITY_ATTRIBUTES WHERE (ENTITY_ID) in (SELECT ENTITY_ID FROM GE_ENTITY WHERE NAME_='LDCI_ACTIVOENCURSO'));
    
    OPEN    cuConfigExpression;
    
    UPDATE  GE_ENTITY_ATTRIBUTES
    SET     INIT_EXPRESSION_ID = NULL, VALID_EXPRESSION_ID = NULL
    WHERE   ENTITY_ID in (SELECT ENTITY_ID FROM GE_ENTITY WHERE NAME_='LDCI_ACTIVOENCURSO');

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
  LDCI_ACTIVOENCURSO_.tbEntityAttributeName(90050209) := 'LDCI_ACTIVOENCURSO@CODIGO_ACTIVO'; 
  LDCI_ACTIVOENCURSO_.tbEntityAttributeName(90050206) := 'LDCI_ACTIVOENCURSO@SUBNUMERO'; 
  LDCI_ACTIVOENCURSO_.tbEntityAttributeName(90050207) := 'LDCI_ACTIVOENCURSO@SOCIEDAD'; 
  LDCI_ACTIVOENCURSO_.tbEntityAttributeName(90050208) := 'LDCI_ACTIVOENCURSO@TEXTO_BREVE'; 
END;
/

BEGIN

if (not LDCI_ACTIVOENCURSO_.blProcessStatus) then
 return;
end if;

LDCI_ACTIVOENCURSO_.old_tb0_0(0):='LDCI_ACTIVOENCURSO'
;
LDCI_ACTIVOENCURSO_.tb0_0(0):='LDCI_ACTIVOENCURSO';
LDCI_ACTIVOENCURSO_.old_tb0_1(0):=40;
LDCI_ACTIVOENCURSO_.tb0_1(0):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(LDCI_ACTIVOENCURSO_.tb0_0(0), 'ENTITY', 'GE_BOSEQUENCE.NEXTGE_ENTITY');
LDCI_ACTIVOENCURSO_.tb0_1(0):=LDCI_ACTIVOENCURSO_.tb0_1(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ENTITY fila (0)',1);
UPDATE GE_ENTITY SET NAME_=LDCI_ACTIVOENCURSO_.tb0_0(0),
ENTITY_ID=LDCI_ACTIVOENCURSO_.tb0_1(0),
MODULE_ID=38,
SELEC_TYPE_OBJECT_ID=null,
INS_SEQ=1,
IN_PERSIST='Y'
,
DESCRIPTION='Codigos de activos en curso'
,
DISPLAY_NAME='Activo en Curso'
,
LOAD_CARTRIDGE='N'
,
TABLESPACE='TSD_DEFAULT'
,
CREATION_DATE=to_date('02-05-2014 08:45:13','DD-MM-YYYY HH24:MI:SS'),
LAST_MODIFY_DATE=to_date('02-05-2014 08:45:13','DD-MM-YYYY HH24:MI:SS'),
STATUS='G'
,
ALLOWED_FULL_SCAN='Y'

 WHERE ENTITY_ID = LDCI_ACTIVOENCURSO_.tb0_1(0);
if not (sql%found) then
INSERT INTO GE_ENTITY(NAME_,ENTITY_ID,MODULE_ID,SELEC_TYPE_OBJECT_ID,INS_SEQ,IN_PERSIST,DESCRIPTION,DISPLAY_NAME,LOAD_CARTRIDGE,TABLESPACE,CREATION_DATE,LAST_MODIFY_DATE,STATUS,ALLOWED_FULL_SCAN) 
VALUES (LDCI_ACTIVOENCURSO_.tb0_0(0),
LDCI_ACTIVOENCURSO_.tb0_1(0),
38,
null,
1,
'Y'
,
'Codigos de activos en curso'
,
'Activo en Curso'
,
'N'
,
'TSD_DEFAULT'
,
to_date('02-05-2014 08:45:13','DD-MM-YYYY HH24:MI:SS'),
to_date('02-05-2014 08:45:13','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'Y'
);
end if;

exception when others then
LDCI_ACTIVOENCURSO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCI_ACTIVOENCURSO_.blProcessStatus) then
 return;
end if;

LDCI_ACTIVOENCURSO_.tb1_0(0):=LDCI_ACTIVOENCURSO_.tb0_1(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ENTITY_ADITIONAL fila (0)',1);
UPDATE GE_ENTITY_ADITIONAL SET ENTITY_ID=LDCI_ACTIVOENCURSO_.tb1_0(0),
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

 WHERE ENTITY_ID = LDCI_ACTIVOENCURSO_.tb1_0(0);
if not (sql%found) then
INSERT INTO GE_ENTITY_ADITIONAL(ENTITY_ID,STATEMENT_ID,QUERY_SERVICE_NAME,PROCESS_SERVICE_NAME,BASE_ENTITY_NAME,BASE_ID_NAME,PRIMARY_KEY_ATTRIBUTE,FOREING_KEY_ATTRIBUTE,ICON,IS_SEARCH,SEARCH_SERVICE_NAME,CONTEXT_MENU_SERVICE,HEADER_TITLES,WINDOWS_TITLE,BATCH_SERVICE_NAME,TIME_EXECUTE_BATCH,EXECUTABLE_NAME_EXECUTE,IS_CUSTOM_ENTITY) 
VALUES (LDCI_ACTIVOENCURSO_.tb1_0(0),
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
LDCI_ACTIVOENCURSO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCI_ACTIVOENCURSO_.blProcessStatus) then
 return;
end if;

LDCI_ACTIVOENCURSO_.tb2_0(0):=LDCI_ACTIVOENCURSO_.tb0_1(0);
LDCI_ACTIVOENCURSO_.old_tb2_1(0):=90050206;
LDCI_ACTIVOENCURSO_.tb2_1(0):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(LDCI_ACTIVOENCURSO_.TBENTITYATTRIBUTENAME(LDCI_ACTIVOENCURSO_.old_tb2_1(0)), 'ATTRIBUTE', GE_BOSEQUENCE.NEXTGE_ENTITY_ATTRIBUTES);
LDCI_ACTIVOENCURSO_.tb2_1(0):=LDCI_ACTIVOENCURSO_.tb2_1(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ENTITY_ATTRIBUTES fila (0)',1);
UPDATE GE_ENTITY_ATTRIBUTES SET ENTITY_ID=LDCI_ACTIVOENCURSO_.tb2_0(0),
ENTITY_ATTRIBUTE_ID=LDCI_ACTIVOENCURSO_.tb2_1(0),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
GI_COMPONENT_ID=null,
MASK_ID=null,
REFERENCE=null,
ATTRIBUTE_TYPE_ID=2,
TECHNICAL_NAME='SUBNUMERO'
,
SECUENCE_=1,
KEY_='Y'
,
IS_NULL='N'
,
DISPLAY_NAME='Subnumero'
,
VIEWER_DISPLAY='Y'
,
PRECISION=null,
DEFAULT_VALUE=null,
SCALE=null,
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
 WHERE ENTITY_ATTRIBUTE_ID = LDCI_ACTIVOENCURSO_.tb2_1(0);
if not (sql%found) then
INSERT INTO GE_ENTITY_ATTRIBUTES(ENTITY_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,GI_COMPONENT_ID,MASK_ID,REFERENCE,ATTRIBUTE_TYPE_ID,TECHNICAL_NAME,SECUENCE_,KEY_,IS_NULL,DISPLAY_NAME,VIEWER_DISPLAY,PRECISION,DEFAULT_VALUE,SCALE,LENGTH,COMMENT_,TAG_ELEMENT,STATUS,IS_DESCRIPTION,IS_LOV_DESCRIPTION,IS_CHECK_BOX,CHECKED_VALUE,UNCHECKED_VALUE,PROTECTOR_TEXT) 
VALUES (LDCI_ACTIVOENCURSO_.tb2_0(0),
LDCI_ACTIVOENCURSO_.tb2_1(0),
null,
null,
null,
null,
null,
2,
'SUBNUMERO'
,
1,
'Y'
,
'N'
,
'Subnumero'
,
'Y'
,
null,
null,
null,
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
LDCI_ACTIVOENCURSO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCI_ACTIVOENCURSO_.blProcessStatus) then
 return;
end if;

LDCI_ACTIVOENCURSO_.tb2_0(1):=LDCI_ACTIVOENCURSO_.tb0_1(0);
LDCI_ACTIVOENCURSO_.old_tb2_1(1):=90050207;
LDCI_ACTIVOENCURSO_.tb2_1(1):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(LDCI_ACTIVOENCURSO_.TBENTITYATTRIBUTENAME(LDCI_ACTIVOENCURSO_.old_tb2_1(1)), 'ATTRIBUTE', GE_BOSEQUENCE.NEXTGE_ENTITY_ATTRIBUTES);
LDCI_ACTIVOENCURSO_.tb2_1(1):=LDCI_ACTIVOENCURSO_.tb2_1(1);
ut_trace.trace('Actualizar o insertar tabla: GE_ENTITY_ATTRIBUTES fila (1)',1);
UPDATE GE_ENTITY_ATTRIBUTES SET ENTITY_ID=LDCI_ACTIVOENCURSO_.tb2_0(1),
ENTITY_ATTRIBUTE_ID=LDCI_ACTIVOENCURSO_.tb2_1(1),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
GI_COMPONENT_ID=null,
MASK_ID=null,
REFERENCE=null,
ATTRIBUTE_TYPE_ID=2,
TECHNICAL_NAME='SOCIEDAD'
,
SECUENCE_=2,
KEY_='Y'
,
IS_NULL='N'
,
DISPLAY_NAME='Sociedad a la que pertenece el activo'
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
 WHERE ENTITY_ATTRIBUTE_ID = LDCI_ACTIVOENCURSO_.tb2_1(1);
if not (sql%found) then
INSERT INTO GE_ENTITY_ATTRIBUTES(ENTITY_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,GI_COMPONENT_ID,MASK_ID,REFERENCE,ATTRIBUTE_TYPE_ID,TECHNICAL_NAME,SECUENCE_,KEY_,IS_NULL,DISPLAY_NAME,VIEWER_DISPLAY,PRECISION,DEFAULT_VALUE,SCALE,LENGTH,COMMENT_,TAG_ELEMENT,STATUS,IS_DESCRIPTION,IS_LOV_DESCRIPTION,IS_CHECK_BOX,CHECKED_VALUE,UNCHECKED_VALUE,PROTECTOR_TEXT) 
VALUES (LDCI_ACTIVOENCURSO_.tb2_0(1),
LDCI_ACTIVOENCURSO_.tb2_1(1),
null,
null,
null,
null,
null,
2,
'SOCIEDAD'
,
2,
'Y'
,
'N'
,
'Sociedad a la que pertenece el activo'
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
LDCI_ACTIVOENCURSO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCI_ACTIVOENCURSO_.blProcessStatus) then
 return;
end if;

LDCI_ACTIVOENCURSO_.tb2_0(2):=LDCI_ACTIVOENCURSO_.tb0_1(0);
LDCI_ACTIVOENCURSO_.old_tb2_1(2):=90050208;
LDCI_ACTIVOENCURSO_.tb2_1(2):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(LDCI_ACTIVOENCURSO_.TBENTITYATTRIBUTENAME(LDCI_ACTIVOENCURSO_.old_tb2_1(2)), 'ATTRIBUTE', GE_BOSEQUENCE.NEXTGE_ENTITY_ATTRIBUTES);
LDCI_ACTIVOENCURSO_.tb2_1(2):=LDCI_ACTIVOENCURSO_.tb2_1(2);
ut_trace.trace('Actualizar o insertar tabla: GE_ENTITY_ATTRIBUTES fila (2)',1);
UPDATE GE_ENTITY_ATTRIBUTES SET ENTITY_ID=LDCI_ACTIVOENCURSO_.tb2_0(2),
ENTITY_ATTRIBUTE_ID=LDCI_ACTIVOENCURSO_.tb2_1(2),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
GI_COMPONENT_ID=null,
MASK_ID=null,
REFERENCE=null,
ATTRIBUTE_TYPE_ID=2,
TECHNICAL_NAME='TEXTO_BREVE'
,
SECUENCE_=3,
KEY_='N'
,
IS_NULL='Y'
,
DISPLAY_NAME='Descripcion del activo'
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
 WHERE ENTITY_ATTRIBUTE_ID = LDCI_ACTIVOENCURSO_.tb2_1(2);
if not (sql%found) then
INSERT INTO GE_ENTITY_ATTRIBUTES(ENTITY_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,GI_COMPONENT_ID,MASK_ID,REFERENCE,ATTRIBUTE_TYPE_ID,TECHNICAL_NAME,SECUENCE_,KEY_,IS_NULL,DISPLAY_NAME,VIEWER_DISPLAY,PRECISION,DEFAULT_VALUE,SCALE,LENGTH,COMMENT_,TAG_ELEMENT,STATUS,IS_DESCRIPTION,IS_LOV_DESCRIPTION,IS_CHECK_BOX,CHECKED_VALUE,UNCHECKED_VALUE,PROTECTOR_TEXT) 
VALUES (LDCI_ACTIVOENCURSO_.tb2_0(2),
LDCI_ACTIVOENCURSO_.tb2_1(2),
null,
null,
null,
null,
null,
2,
'TEXTO_BREVE'
,
3,
'N'
,
'Y'
,
'Descripcion del activo'
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
LDCI_ACTIVOENCURSO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDCI_ACTIVOENCURSO_.blProcessStatus) then
 return;
end if;

LDCI_ACTIVOENCURSO_.tb2_0(3):=LDCI_ACTIVOENCURSO_.tb0_1(0);
LDCI_ACTIVOENCURSO_.old_tb2_1(3):=90050209;
LDCI_ACTIVOENCURSO_.tb2_1(3):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(LDCI_ACTIVOENCURSO_.TBENTITYATTRIBUTENAME(LDCI_ACTIVOENCURSO_.old_tb2_1(3)), 'ATTRIBUTE', GE_BOSEQUENCE.NEXTGE_ENTITY_ATTRIBUTES);
LDCI_ACTIVOENCURSO_.tb2_1(3):=LDCI_ACTIVOENCURSO_.tb2_1(3);
ut_trace.trace('Actualizar o insertar tabla: GE_ENTITY_ATTRIBUTES fila (3)',1);
UPDATE GE_ENTITY_ATTRIBUTES SET ENTITY_ID=LDCI_ACTIVOENCURSO_.tb2_0(3),
ENTITY_ATTRIBUTE_ID=LDCI_ACTIVOENCURSO_.tb2_1(3),
INIT_EXPRESSION_ID=null,
VALID_EXPRESSION_ID=null,
GI_COMPONENT_ID=null,
MASK_ID=null,
REFERENCE=null,
ATTRIBUTE_TYPE_ID=2,
TECHNICAL_NAME='CODIGO_ACTIVO'
,
SECUENCE_=0,
KEY_='Y'
,
IS_NULL='N'
,
DISPLAY_NAME='Codigo de activo'
,
VIEWER_DISPLAY='Y'
,
PRECISION=null,
DEFAULT_VALUE=null,
SCALE=null,
LENGTH=12,
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
 WHERE ENTITY_ATTRIBUTE_ID = LDCI_ACTIVOENCURSO_.tb2_1(3);
if not (sql%found) then
INSERT INTO GE_ENTITY_ATTRIBUTES(ENTITY_ID,ENTITY_ATTRIBUTE_ID,INIT_EXPRESSION_ID,VALID_EXPRESSION_ID,GI_COMPONENT_ID,MASK_ID,REFERENCE,ATTRIBUTE_TYPE_ID,TECHNICAL_NAME,SECUENCE_,KEY_,IS_NULL,DISPLAY_NAME,VIEWER_DISPLAY,PRECISION,DEFAULT_VALUE,SCALE,LENGTH,COMMENT_,TAG_ELEMENT,STATUS,IS_DESCRIPTION,IS_LOV_DESCRIPTION,IS_CHECK_BOX,CHECKED_VALUE,UNCHECKED_VALUE,PROTECTOR_TEXT) 
VALUES (LDCI_ACTIVOENCURSO_.tb2_0(3),
LDCI_ACTIVOENCURSO_.tb2_1(3),
null,
null,
null,
null,
null,
2,
'CODIGO_ACTIVO'
,
0,
'Y'
,
'N'
,
'Codigo de activo'
,
'Y'
,
null,
null,
null,
12,
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
LDCI_ACTIVOENCURSO_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
DECLARE
  nuerr number;
  sberr varchar2(4000);
BEGIN

if (not LDCI_ACTIVOENCURSO_.blProcessStatus) then
 return;
end if;
  commit;
  gi_boframeworkentityattribute.UpdateEntityReferences('LDCI_ACTIVOENCURSO');
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
SA_BOCreatePackages.DropPackage('LDCI_ACTIVOENCURSO_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:LDCI_ACTIVOENCURSO_******************************'); end;
/

