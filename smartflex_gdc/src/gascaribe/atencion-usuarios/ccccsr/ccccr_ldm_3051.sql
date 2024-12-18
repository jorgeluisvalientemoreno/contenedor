BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('CCCCR_LDM_3051_',
'CREATE OR REPLACE PACKAGE CCCCR_LDM_3051_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyCC_LDM_ENTITYRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbCC_LDM_ENTITYRowId tyCC_LDM_ENTITYRowId;type ty0_0 is table of CC_LDM_ENTITY.LDM_ENTITY_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty0_1 is table of CC_LDM_ENTITY.LDM_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_1 ty0_1; ' || chr(10) ||
'tb0_1 ty0_1; ' || chr(10) ||
'END CCCCR_LDM_3051_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:CCCCR_LDM_3051_******************************'); END;
/


BEGIN

if (not CCCCR_LDM_3051_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla CC_LDM_ENTITY',1);
  DELETE FROM CC_LDM_ENTITY WHERE LDM_ID = 1 AND LDM_ENTITY_ID BETWEEN 100000 AND 9999999999;

exception when others then
CCCCR_LDM_3051_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE
CURSOR cuGe_entity_attibute
IS
SELECT  entity_attribute_id 
FROM    GE_ENTITY_ATTRIBUTES 
WHERE   entity_id = 8812 and technical_name = 'PROTECCION_DATOS_ID';

nuGE_ENTITY_ATTRIBUTES GE_ENTITY_ATTRIBUTES.entity_attribute_id%TYPE;
BEGIN

if (not CCCCR_LDM_3051_.blProcessStatus) then
 return;
end if;

OPEN cuGe_entity_attibute;
FETCH cuGe_entity_attibute INTO nuGE_ENTITY_ATTRIBUTES;
CLOSE cuGe_entity_attibute;

CCCCR_LDM_3051_.tb0_0(0):=100002;
CCCCR_LDM_3051_.old_tb0_1(0):=1;
CCCCR_LDM_3051_.tb0_1(0):=1;
ut_trace.trace('insertando tabla: CC_LDM_ENTITY fila (0)',1);
INSERT INTO CC_LDM_ENTITY(LDM_ENTITY_ID,LDM_ID,ENTITY_ID,PERSISTENCE_SERVICE,ENTITY_PK_ID,FOREIGN_ENTITY_ID,ENTITY_FK_ID,MIN_INSTANCES,MAX_INSTANCES,PERSISTENCE_SEQUENCE,INSTANCE_SEQUENCE,INSTANCE_SERVICE) 
VALUES (CCCCR_LDM_3051_.tb0_0(0),
CCCCR_LDM_3051_.tb0_1(0),
8812,
null,
nuGE_ENTITY_ATTRIBUTES,
3203,
90044256,
0,
1,
2,
2,
null);

exception when others then
CCCCR_LDM_3051_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('CCCCR_LDM_3051_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:CCCCR_LDM_3051_******************************'); end;
/

