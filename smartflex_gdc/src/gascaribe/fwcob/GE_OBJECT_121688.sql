BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('GE_OBJECT_121688_',
'CREATE OR REPLACE PACKAGE GE_OBJECT_121688_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyGE_OBJECTRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_OBJECTRowId tyGE_OBJECTRowId;type tyGE_OBJECT_PARAMETERRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_OBJECT_PARAMETERRowId tyGE_OBJECT_PARAMETERRowId;type tyGR_CONFTYPE_OBJECTRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFTYPE_OBJECTRowId tyGR_CONFTYPE_OBJECTRowId;type ty0_0 is table of GE_OBJECT.OBJECT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty0_2 is table of GE_OBJECT.NAME_%type index by binary_integer; ' || chr(10) ||
'old_tb0_2 ty0_2; ' || chr(10) ||
'tb0_2 ty0_2;type ty1_0 is table of GE_OBJECT_PARAMETER.OBJECT_NAME%type index by binary_integer; ' || chr(10) ||
'old_tb1_0 ty1_0; ' || chr(10) ||
'tb1_0 ty1_0;type ty1_1 is table of GE_OBJECT_PARAMETER.PARAMETER_NAME%type index by binary_integer; ' || chr(10) ||
'old_tb1_1 ty1_1; ' || chr(10) ||
'tb1_1 ty1_1;type ty2_0 is table of GR_CONFTYPE_OBJECT.CONFIGURA_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_0 ty2_0; ' || chr(10) ||
'tb2_0 ty2_0;type ty2_1 is table of GR_CONFTYPE_OBJECT.OBJECT_NAME%type index by binary_integer; ' || chr(10) ||
'old_tb2_1 ty2_1; ' || chr(10) ||
'tb2_1 ty2_1; ' || chr(10) ||
'END GE_OBJECT_121688_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:GE_OBJECT_121688_******************************'); END;
/


BEGIN

if (not GE_OBJECT_121688_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_OBJECT_PARAMETER',1);
  DELETE FROM GE_OBJECT_PARAMETER WHERE (OBJECT_NAME) in (SELECT NAME_ FROM GE_OBJECT WHERE OBJECT_ID=121688);

exception when others then
GE_OBJECT_121688_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not GE_OBJECT_121688_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GR_CONFTYPE_OBJECT',1);
  DELETE FROM GR_CONFTYPE_OBJECT WHERE (OBJECT_NAME) in (SELECT NAME_ FROM GE_OBJECT WHERE OBJECT_ID=121688);

exception when others then
GE_OBJECT_121688_.blProcessStatus := false;
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
FROM GE_OBJECT WHERE OBJECT_ID=121688;
nuIndex binary_integer;
BEGIN

if (not GE_OBJECT_121688_.blProcessStatus) then
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
GE_OBJECT_121688_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not GE_OBJECT_121688_.blProcessStatus) then
 return;
end if;

GE_OBJECT_121688_.tb0_0(0):=121688;
GE_OBJECT_121688_.tb0_2(0):='LDC_PRGETPACKAGEINST'
;
ut_trace.trace('Actualizar o insertar tabla: GE_OBJECT fila (0)',1);
UPDATE GE_OBJECT SET OBJECT_ID=GE_OBJECT_121688_.tb0_0(0),
OBJECT_TYPE_ID=20,
NAME_=GE_OBJECT_121688_.tb0_2(0),
MODULE_ID=61,
DESCRIPTION='Obtiene la Solicitud Durante los cobros de la solicitud 271 para el concepto de certificacion'
,
COMMENT_='Obtiene la Solicitud Durante los cobros de la solicitud 271 para el concepto de certificacion'
,
PARAMETERS='(_e_)'
,
OBJECT_CLASS='P'
,
RETURN_TYPE=null
 WHERE OBJECT_ID = GE_OBJECT_121688_.tb0_0(0);
if not (sql%found) then
INSERT INTO GE_OBJECT(OBJECT_ID,OBJECT_TYPE_ID,NAME_,MODULE_ID,DESCRIPTION,COMMENT_,PARAMETERS,OBJECT_CLASS,RETURN_TYPE) 
VALUES (GE_OBJECT_121688_.tb0_0(0),
20,
GE_OBJECT_121688_.tb0_2(0),
61,
'Obtiene la Solicitud Durante los cobros de la solicitud 271 para el concepto de certificacion'
,
'Obtiene la Solicitud Durante los cobros de la solicitud 271 para el concepto de certificacion'
,
'(_e_)'
,
'P'
,
null);
end if;

exception when others then
GE_OBJECT_121688_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not GE_OBJECT_121688_.blProcessStatus) then
 return;
end if;

GE_OBJECT_121688_.tb1_0(0):=GE_OBJECT_121688_.tb0_2(0);
GE_OBJECT_121688_.tb1_1(0):='ONUSOLICITUD'
;
ut_trace.trace('insertando tabla: GE_OBJECT_PARAMETER fila (0)',1);
INSERT INTO GE_OBJECT_PARAMETER(OBJECT_NAME,PARAMETER_NAME,DATA_TYPE,IN_OUT,COMMENT_,SEQUENCE) 
VALUES (GE_OBJECT_121688_.tb1_0(0),
GE_OBJECT_121688_.tb1_1(0),
'NUMBER'
,
'OUT'
,
'Solicitud'
,
1);

exception when others then
GE_OBJECT_121688_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not GE_OBJECT_121688_.blProcessStatus) then
 return;
end if;

GE_OBJECT_121688_.tb2_0(0):=93;
GE_OBJECT_121688_.tb2_1(0):=GE_OBJECT_121688_.tb0_2(0);
ut_trace.trace('insertando tabla: GR_CONFTYPE_OBJECT fila (0)',1);
INSERT INTO GR_CONFTYPE_OBJECT(CONFIGURA_TYPE_ID,OBJECT_NAME) 
VALUES (GE_OBJECT_121688_.tb2_0(0),
GE_OBJECT_121688_.tb2_1(0));

exception when others then
GE_OBJECT_121688_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('GE_OBJECT_121688_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:GE_OBJECT_121688_******************************'); end;
/
