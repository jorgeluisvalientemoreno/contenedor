BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('GE_OBJECT_121757_',
'CREATE OR REPLACE PACKAGE GE_OBJECT_121757_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyGE_OBJECTRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_OBJECTRowId tyGE_OBJECTRowId;type tyGE_OBJECT_PARAMETERRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_OBJECT_PARAMETERRowId tyGE_OBJECT_PARAMETERRowId;type tyGR_CONFTYPE_OBJECTRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFTYPE_OBJECTRowId tyGR_CONFTYPE_OBJECTRowId;type ty0_0 is table of GE_OBJECT.OBJECT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty0_2 is table of GE_OBJECT.NAME_%type index by binary_integer; ' || chr(10) ||
'old_tb0_2 ty0_2; ' || chr(10) ||
'tb0_2 ty0_2; ' || chr(10) ||
'END GE_OBJECT_121757_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:GE_OBJECT_121757_******************************'); END;
/


BEGIN

if (not GE_OBJECT_121757_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_OBJECT_PARAMETER',1);
  DELETE FROM GE_OBJECT_PARAMETER WHERE (OBJECT_NAME) in (SELECT NAME_ FROM GE_OBJECT WHERE OBJECT_ID=121757);

exception when others then
GE_OBJECT_121757_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not GE_OBJECT_121757_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GR_CONFTYPE_OBJECT',1);
  DELETE FROM GR_CONFTYPE_OBJECT WHERE (OBJECT_NAME) in (SELECT NAME_ FROM GE_OBJECT WHERE OBJECT_ID=121757);

exception when others then
GE_OBJECT_121757_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM GE_OBJECT WHERE OBJECT_ID=121757;
nuIndex binary_integer;
BEGIN

if (not GE_OBJECT_121757_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_OBJECT',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM GE_OBJECT WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
GE_OBJECT_121757_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not GE_OBJECT_121757_.blProcessStatus) then
 return;
end if;

GE_OBJECT_121757_.tb0_0(0):=121757;
GE_OBJECT_121757_.tb0_2(0):='PRC_ASIGLEGASUSPCDMACOM'
;
ut_trace.trace('Actualizar o insertar tabla: GE_OBJECT fila (0)',1);
UPDATE GE_OBJECT SET OBJECT_ID=GE_OBJECT_121757_.tb0_0(0),
OBJECT_TYPE_ID=14,
NAME_=GE_OBJECT_121757_.tb0_2(0),
MODULE_ID=14,
DESCRIPTION='Asigna y legaliza las actividades 100009279 y 100009280'
,
COMMENT_='Asigna y legaliza las actividades 100009279 y 100009280'
,
PARAMETERS='()'
,
OBJECT_CLASS='P'
,
RETURN_TYPE=null
 WHERE OBJECT_ID = GE_OBJECT_121757_.tb0_0(0);
if not (sql%found) then
INSERT INTO GE_OBJECT(OBJECT_ID,OBJECT_TYPE_ID,NAME_,MODULE_ID,DESCRIPTION,COMMENT_,PARAMETERS,OBJECT_CLASS,RETURN_TYPE) 
VALUES (GE_OBJECT_121757_.tb0_0(0),
14,
GE_OBJECT_121757_.tb0_2(0),
14,
'Asigna y legaliza las actividades 100009279 y 100009280'
,
'Asigna y legaliza las actividades 100009279 y 100009280'
,
'()'
,
'P'
,
null);
end if;

exception when others then
GE_OBJECT_121757_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('GE_OBJECT_121757_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:GE_OBJECT_121757_******************************'); end;
/
