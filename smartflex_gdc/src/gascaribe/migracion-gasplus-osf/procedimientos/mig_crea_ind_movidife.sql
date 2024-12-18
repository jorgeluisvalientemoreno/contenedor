CREATE OR REPLACE PROCEDURE MIG_CREA_IND_MOVIDIFE IS
sbsql varchar2(800);
BEGIN
sbsql:='CREATE INDEX "OPEN"."IX_MOVIDIFE01" ON "OPEN"."MOVIDIFE" ("MODIDIFE")';
execute immediate sbsql;
commit;
sbsql:='CREATE INDEX "OPEN"."IX_MOVIDIFE02" ON "OPEN"."MOVIDIFE" ("MODISUSC", "MODINUSE")';
execute immediate sbsql;
commit;
sbsql:='CREATE INDEX "OPEN"."IX_MOVIDIFE03" ON "OPEN"."MOVIDIFE" ("MODIFECA", "MODIDIFE")';
execute immediate sbsql;
commit;
sbsql:='CREATE INDEX "OPEN"."IX_MOVIDIFE04" ON "OPEN"."MOVIDIFE" ("MODIFECH")';
execute immediate sbsql;
commit;
sbsql:='CREATE INDEX "OPEN"."IX_MOVIDIFE06" ON "OPEN"."MOVIDIFE" ("MODINUSE")';
execute immediate sbsql;
commit;
sbsql:='CREATE INDEX "OPEN"."IX_MOVIDIFE07" ON "OPEN"."MOVIDIFE" ("MODISUSC")';
execute immediate sbsql;
commit;
sbsql:='CREATE INDEX "OPEN"."IX_MOVIDIFE08" ON "OPEN"."MOVIDIFE" ("MODISIGN")';
execute immediate sbsql;
commit;
sbsql:='CREATE INDEX "OPEN"."IX_MOVIDIFE09" ON "OPEN"."MOVIDIFE" ("MODICACA")';
execute immediate sbsql;
commit;
END;
/
