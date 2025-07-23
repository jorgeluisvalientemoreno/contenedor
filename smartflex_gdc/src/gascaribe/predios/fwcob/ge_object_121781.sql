BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('GE_OBJECT_121781_',
'CREATE OR REPLACE PACKAGE GE_OBJECT_121781_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyGE_OBJECTRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_OBJECTRowId tyGE_OBJECTRowId;type tyGE_OBJECT_PARAMETERRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_OBJECT_PARAMETERRowId tyGE_OBJECT_PARAMETERRowId;type tyGR_CONFTYPE_OBJECTRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFTYPE_OBJECTRowId tyGR_CONFTYPE_OBJECTRowId;type ty0_0 is table of GE_OBJECT.OBJECT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty0_2 is table of GE_OBJECT.NAME_%type index by binary_integer; ' || chr(10) ||
'old_tb0_2 ty0_2; ' || chr(10) ||
'tb0_2 ty0_2;type ty1_0 is table of GR_CONFTYPE_OBJECT.CONFIGURA_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_0 ty1_0; ' || chr(10) ||
'tb1_0 ty1_0;type ty1_1 is table of GR_CONFTYPE_OBJECT.OBJECT_NAME%type index by binary_integer; ' || chr(10) ||
'old_tb1_1 ty1_1; ' || chr(10) ||
'tb1_1 ty1_1; ' || chr(10) ||
'END GE_OBJECT_121781_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:GE_OBJECT_121781_******************************'); END;
/


BEGIN

if (not GE_OBJECT_121781_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_OBJECT_PARAMETER',1);
  DELETE FROM GE_OBJECT_PARAMETER WHERE (OBJECT_NAME) in (SELECT NAME_ FROM GE_OBJECT WHERE OBJECT_ID=121781);

exception when others then
GE_OBJECT_121781_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not GE_OBJECT_121781_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GR_CONFTYPE_OBJECT',1);
  DELETE FROM GR_CONFTYPE_OBJECT WHERE (OBJECT_NAME) in (SELECT NAME_ FROM GE_OBJECT WHERE OBJECT_ID=121781);

exception when others then
GE_OBJECT_121781_.blProcessStatus := false;
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
FROM GE_OBJECT WHERE OBJECT_ID=121781;
nuIndex binary_integer;
BEGIN

if (not GE_OBJECT_121781_.blProcessStatus) then
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
GE_OBJECT_121781_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not GE_OBJECT_121781_.blProcessStatus) then
 return;
end if;

GE_OBJECT_121781_.tb0_0(0):=121781;
GE_OBJECT_121781_.tb0_2(0):='PRCREGLAPRECAMBIARDATOSPREDIO'
;
ut_trace.trace('Actualizar o insertar tabla: GE_OBJECT fila (0)',1);
UPDATE GE_OBJECT SET OBJECT_ID=GE_OBJECT_121781_.tb0_0(0),
OBJECT_TYPE_ID=20,
NAME_=GE_OBJECT_121781_.tb0_2(0),
MODULE_ID=61,
DESCRIPTION='Regla pre Cambio Datos de Predio'
,
COMMENT_='Regla pre Cambio Datos de Predio'
,
PARAMETERS='()'
,
OBJECT_CLASS='P'
,
RETURN_TYPE=null
 WHERE OBJECT_ID = GE_OBJECT_121781_.tb0_0(0);
if not (sql%found) then
INSERT INTO GE_OBJECT(OBJECT_ID,OBJECT_TYPE_ID,NAME_,MODULE_ID,DESCRIPTION,COMMENT_,PARAMETERS,OBJECT_CLASS,RETURN_TYPE) 
VALUES (GE_OBJECT_121781_.tb0_0(0),
20,
GE_OBJECT_121781_.tb0_2(0),
61,
'Regla pre Cambio Datos de Predio'
,
'Regla pre Cambio Datos de Predio'
,
'()'
,
'P'
,
null);
end if;

exception when others then
GE_OBJECT_121781_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not GE_OBJECT_121781_.blProcessStatus) then
 return;
end if;

GE_OBJECT_121781_.tb1_0(0):=2;
GE_OBJECT_121781_.tb1_1(0):=GE_OBJECT_121781_.tb0_2(0);
ut_trace.trace('insertando tabla: GR_CONFTYPE_OBJECT fila (0)',1);
INSERT INTO GR_CONFTYPE_OBJECT(CONFIGURA_TYPE_ID,OBJECT_NAME) 
VALUES (GE_OBJECT_121781_.tb1_0(0),
GE_OBJECT_121781_.tb1_1(0));

exception when others then
GE_OBJECT_121781_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not GE_OBJECT_121781_.blProcessStatus) then
 return;
end if;

GE_OBJECT_121781_.tb1_0(1):=7;
GE_OBJECT_121781_.tb1_1(1):=GE_OBJECT_121781_.tb0_2(0);
ut_trace.trace('insertando tabla: GR_CONFTYPE_OBJECT fila (1)',1);
INSERT INTO GR_CONFTYPE_OBJECT(CONFIGURA_TYPE_ID,OBJECT_NAME) 
VALUES (GE_OBJECT_121781_.tb1_0(1),
GE_OBJECT_121781_.tb1_1(1));

exception when others then
GE_OBJECT_121781_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not GE_OBJECT_121781_.blProcessStatus) then
 return;
end if;

GE_OBJECT_121781_.tb1_0(2):=8;
GE_OBJECT_121781_.tb1_1(2):=GE_OBJECT_121781_.tb0_2(0);
ut_trace.trace('insertando tabla: GR_CONFTYPE_OBJECT fila (2)',1);
INSERT INTO GR_CONFTYPE_OBJECT(CONFIGURA_TYPE_ID,OBJECT_NAME) 
VALUES (GE_OBJECT_121781_.tb1_0(2),
GE_OBJECT_121781_.tb1_1(2));

exception when others then
GE_OBJECT_121781_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not GE_OBJECT_121781_.blProcessStatus) then
 return;
end if;

GE_OBJECT_121781_.tb1_0(3):=9;
GE_OBJECT_121781_.tb1_1(3):=GE_OBJECT_121781_.tb0_2(0);
ut_trace.trace('insertando tabla: GR_CONFTYPE_OBJECT fila (3)',1);
INSERT INTO GR_CONFTYPE_OBJECT(CONFIGURA_TYPE_ID,OBJECT_NAME) 
VALUES (GE_OBJECT_121781_.tb1_0(3),
GE_OBJECT_121781_.tb1_1(3));

exception when others then
GE_OBJECT_121781_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not GE_OBJECT_121781_.blProcessStatus) then
 return;
end if;

GE_OBJECT_121781_.tb1_0(4):=15;
GE_OBJECT_121781_.tb1_1(4):=GE_OBJECT_121781_.tb0_2(0);
ut_trace.trace('insertando tabla: GR_CONFTYPE_OBJECT fila (4)',1);
INSERT INTO GR_CONFTYPE_OBJECT(CONFIGURA_TYPE_ID,OBJECT_NAME) 
VALUES (GE_OBJECT_121781_.tb1_0(4),
GE_OBJECT_121781_.tb1_1(4));

exception when others then
GE_OBJECT_121781_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not GE_OBJECT_121781_.blProcessStatus) then
 return;
end if;

GE_OBJECT_121781_.tb1_0(5):=19;
GE_OBJECT_121781_.tb1_1(5):=GE_OBJECT_121781_.tb0_2(0);
ut_trace.trace('insertando tabla: GR_CONFTYPE_OBJECT fila (5)',1);
INSERT INTO GR_CONFTYPE_OBJECT(CONFIGURA_TYPE_ID,OBJECT_NAME) 
VALUES (GE_OBJECT_121781_.tb1_0(5),
GE_OBJECT_121781_.tb1_1(5));

exception when others then
GE_OBJECT_121781_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not GE_OBJECT_121781_.blProcessStatus) then
 return;
end if;

GE_OBJECT_121781_.tb1_0(6):=20;
GE_OBJECT_121781_.tb1_1(6):=GE_OBJECT_121781_.tb0_2(0);
ut_trace.trace('insertando tabla: GR_CONFTYPE_OBJECT fila (6)',1);
INSERT INTO GR_CONFTYPE_OBJECT(CONFIGURA_TYPE_ID,OBJECT_NAME) 
VALUES (GE_OBJECT_121781_.tb1_0(6),
GE_OBJECT_121781_.tb1_1(6));

exception when others then
GE_OBJECT_121781_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not GE_OBJECT_121781_.blProcessStatus) then
 return;
end if;

GE_OBJECT_121781_.tb1_0(7):=22;
GE_OBJECT_121781_.tb1_1(7):=GE_OBJECT_121781_.tb0_2(0);
ut_trace.trace('insertando tabla: GR_CONFTYPE_OBJECT fila (7)',1);
INSERT INTO GR_CONFTYPE_OBJECT(CONFIGURA_TYPE_ID,OBJECT_NAME) 
VALUES (GE_OBJECT_121781_.tb1_0(7),
GE_OBJECT_121781_.tb1_1(7));

exception when others then
GE_OBJECT_121781_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not GE_OBJECT_121781_.blProcessStatus) then
 return;
end if;

GE_OBJECT_121781_.tb1_0(8):=23;
GE_OBJECT_121781_.tb1_1(8):=GE_OBJECT_121781_.tb0_2(0);
ut_trace.trace('insertando tabla: GR_CONFTYPE_OBJECT fila (8)',1);
INSERT INTO GR_CONFTYPE_OBJECT(CONFIGURA_TYPE_ID,OBJECT_NAME) 
VALUES (GE_OBJECT_121781_.tb1_0(8),
GE_OBJECT_121781_.tb1_1(8));

exception when others then
GE_OBJECT_121781_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not GE_OBJECT_121781_.blProcessStatus) then
 return;
end if;

GE_OBJECT_121781_.tb1_0(9):=26;
GE_OBJECT_121781_.tb1_1(9):=GE_OBJECT_121781_.tb0_2(0);
ut_trace.trace('insertando tabla: GR_CONFTYPE_OBJECT fila (9)',1);
INSERT INTO GR_CONFTYPE_OBJECT(CONFIGURA_TYPE_ID,OBJECT_NAME) 
VALUES (GE_OBJECT_121781_.tb1_0(9),
GE_OBJECT_121781_.tb1_1(9));

exception when others then
GE_OBJECT_121781_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not GE_OBJECT_121781_.blProcessStatus) then
 return;
end if;

GE_OBJECT_121781_.tb1_0(10):=32;
GE_OBJECT_121781_.tb1_1(10):=GE_OBJECT_121781_.tb0_2(0);
ut_trace.trace('insertando tabla: GR_CONFTYPE_OBJECT fila (10)',1);
INSERT INTO GR_CONFTYPE_OBJECT(CONFIGURA_TYPE_ID,OBJECT_NAME) 
VALUES (GE_OBJECT_121781_.tb1_0(10),
GE_OBJECT_121781_.tb1_1(10));

exception when others then
GE_OBJECT_121781_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not GE_OBJECT_121781_.blProcessStatus) then
 return;
end if;

GE_OBJECT_121781_.tb1_0(11):=33;
GE_OBJECT_121781_.tb1_1(11):=GE_OBJECT_121781_.tb0_2(0);
ut_trace.trace('insertando tabla: GR_CONFTYPE_OBJECT fila (11)',1);
INSERT INTO GR_CONFTYPE_OBJECT(CONFIGURA_TYPE_ID,OBJECT_NAME) 
VALUES (GE_OBJECT_121781_.tb1_0(11),
GE_OBJECT_121781_.tb1_1(11));

exception when others then
GE_OBJECT_121781_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not GE_OBJECT_121781_.blProcessStatus) then
 return;
end if;

GE_OBJECT_121781_.tb1_0(12):=34;
GE_OBJECT_121781_.tb1_1(12):=GE_OBJECT_121781_.tb0_2(0);
ut_trace.trace('insertando tabla: GR_CONFTYPE_OBJECT fila (12)',1);
INSERT INTO GR_CONFTYPE_OBJECT(CONFIGURA_TYPE_ID,OBJECT_NAME) 
VALUES (GE_OBJECT_121781_.tb1_0(12),
GE_OBJECT_121781_.tb1_1(12));

exception when others then
GE_OBJECT_121781_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not GE_OBJECT_121781_.blProcessStatus) then
 return;
end if;

GE_OBJECT_121781_.tb1_0(13):=37;
GE_OBJECT_121781_.tb1_1(13):=GE_OBJECT_121781_.tb0_2(0);
ut_trace.trace('insertando tabla: GR_CONFTYPE_OBJECT fila (13)',1);
INSERT INTO GR_CONFTYPE_OBJECT(CONFIGURA_TYPE_ID,OBJECT_NAME) 
VALUES (GE_OBJECT_121781_.tb1_0(13),
GE_OBJECT_121781_.tb1_1(13));

exception when others then
GE_OBJECT_121781_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not GE_OBJECT_121781_.blProcessStatus) then
 return;
end if;

GE_OBJECT_121781_.tb1_0(14):=41;
GE_OBJECT_121781_.tb1_1(14):=GE_OBJECT_121781_.tb0_2(0);
ut_trace.trace('insertando tabla: GR_CONFTYPE_OBJECT fila (14)',1);
INSERT INTO GR_CONFTYPE_OBJECT(CONFIGURA_TYPE_ID,OBJECT_NAME) 
VALUES (GE_OBJECT_121781_.tb1_0(14),
GE_OBJECT_121781_.tb1_1(14));

exception when others then
GE_OBJECT_121781_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not GE_OBJECT_121781_.blProcessStatus) then
 return;
end if;

GE_OBJECT_121781_.tb1_0(15):=45;
GE_OBJECT_121781_.tb1_1(15):=GE_OBJECT_121781_.tb0_2(0);
ut_trace.trace('insertando tabla: GR_CONFTYPE_OBJECT fila (15)',1);
INSERT INTO GR_CONFTYPE_OBJECT(CONFIGURA_TYPE_ID,OBJECT_NAME) 
VALUES (GE_OBJECT_121781_.tb1_0(15),
GE_OBJECT_121781_.tb1_1(15));

exception when others then
GE_OBJECT_121781_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not GE_OBJECT_121781_.blProcessStatus) then
 return;
end if;

GE_OBJECT_121781_.tb1_0(16):=47;
GE_OBJECT_121781_.tb1_1(16):=GE_OBJECT_121781_.tb0_2(0);
ut_trace.trace('insertando tabla: GR_CONFTYPE_OBJECT fila (16)',1);
INSERT INTO GR_CONFTYPE_OBJECT(CONFIGURA_TYPE_ID,OBJECT_NAME) 
VALUES (GE_OBJECT_121781_.tb1_0(16),
GE_OBJECT_121781_.tb1_1(16));

exception when others then
GE_OBJECT_121781_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not GE_OBJECT_121781_.blProcessStatus) then
 return;
end if;

GE_OBJECT_121781_.tb1_0(17):=64;
GE_OBJECT_121781_.tb1_1(17):=GE_OBJECT_121781_.tb0_2(0);
ut_trace.trace('insertando tabla: GR_CONFTYPE_OBJECT fila (17)',1);
INSERT INTO GR_CONFTYPE_OBJECT(CONFIGURA_TYPE_ID,OBJECT_NAME) 
VALUES (GE_OBJECT_121781_.tb1_0(17),
GE_OBJECT_121781_.tb1_1(17));

exception when others then
GE_OBJECT_121781_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not GE_OBJECT_121781_.blProcessStatus) then
 return;
end if;

GE_OBJECT_121781_.tb1_0(18):=65;
GE_OBJECT_121781_.tb1_1(18):=GE_OBJECT_121781_.tb0_2(0);
ut_trace.trace('insertando tabla: GR_CONFTYPE_OBJECT fila (18)',1);
INSERT INTO GR_CONFTYPE_OBJECT(CONFIGURA_TYPE_ID,OBJECT_NAME) 
VALUES (GE_OBJECT_121781_.tb1_0(18),
GE_OBJECT_121781_.tb1_1(18));

exception when others then
GE_OBJECT_121781_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not GE_OBJECT_121781_.blProcessStatus) then
 return;
end if;

GE_OBJECT_121781_.tb1_0(19):=67;
GE_OBJECT_121781_.tb1_1(19):=GE_OBJECT_121781_.tb0_2(0);
ut_trace.trace('insertando tabla: GR_CONFTYPE_OBJECT fila (19)',1);
INSERT INTO GR_CONFTYPE_OBJECT(CONFIGURA_TYPE_ID,OBJECT_NAME) 
VALUES (GE_OBJECT_121781_.tb1_0(19),
GE_OBJECT_121781_.tb1_1(19));

exception when others then
GE_OBJECT_121781_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not GE_OBJECT_121781_.blProcessStatus) then
 return;
end if;

GE_OBJECT_121781_.tb1_0(20):=75;
GE_OBJECT_121781_.tb1_1(20):=GE_OBJECT_121781_.tb0_2(0);
ut_trace.trace('insertando tabla: GR_CONFTYPE_OBJECT fila (20)',1);
INSERT INTO GR_CONFTYPE_OBJECT(CONFIGURA_TYPE_ID,OBJECT_NAME) 
VALUES (GE_OBJECT_121781_.tb1_0(20),
GE_OBJECT_121781_.tb1_1(20));

exception when others then
GE_OBJECT_121781_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not GE_OBJECT_121781_.blProcessStatus) then
 return;
end if;

GE_OBJECT_121781_.tb1_0(21):=401;
GE_OBJECT_121781_.tb1_1(21):=GE_OBJECT_121781_.tb0_2(0);
ut_trace.trace('insertando tabla: GR_CONFTYPE_OBJECT fila (21)',1);
INSERT INTO GR_CONFTYPE_OBJECT(CONFIGURA_TYPE_ID,OBJECT_NAME) 
VALUES (GE_OBJECT_121781_.tb1_0(21),
GE_OBJECT_121781_.tb1_1(21));

exception when others then
GE_OBJECT_121781_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not GE_OBJECT_121781_.blProcessStatus) then
 return;
end if;

GE_OBJECT_121781_.tb1_0(22):=469;
GE_OBJECT_121781_.tb1_1(22):=GE_OBJECT_121781_.tb0_2(0);
ut_trace.trace('insertando tabla: GR_CONFTYPE_OBJECT fila (22)',1);
INSERT INTO GR_CONFTYPE_OBJECT(CONFIGURA_TYPE_ID,OBJECT_NAME) 
VALUES (GE_OBJECT_121781_.tb1_0(22),
GE_OBJECT_121781_.tb1_1(22));

exception when others then
GE_OBJECT_121781_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('GE_OBJECT_121781_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:GE_OBJECT_121781_******************************'); end;
/

