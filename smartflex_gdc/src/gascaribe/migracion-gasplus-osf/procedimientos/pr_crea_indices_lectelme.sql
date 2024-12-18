CREATE OR REPLACE PROCEDURE PR_CREA_INDICES_LECTELME(NUMINICIO number,NUMFINAL number,inudatabase number)
as
sbsql varchar2(2000);
begin


UPDATE  MIGR_RANGO_PROCESOS SET RAPRTERM='P', RAPRFEIN=sysdate WHERE raprbase=inudatabase AND raprrain=NUMINICIO AND raprrafi=NUMFINAL AND raprcodi=3901;
commit;

sbsql:='alter session set ddl_lock_timeout = 600';
execute immediate sbsql;

sbsql:='CREATE INDEX "OPEN"."IX_LECTELME01" ON "OPEN"."LECTELME" ("LEEMPEFA", "LEEMTCON")';
execute immediate sbsql;

sbsql:='CREATE INDEX "OPEN"."IX_LECTELME02" ON "OPEN"."LECTELME" ("LEEMSESU", "LEEMPEFA")';
execute immediate sbsql;

sbsql:='CREATE INDEX "OPEN"."IX_LECTELME03" ON "OPEN"."LECTELME" ("LEEMDOCU", "LEEMCONS")';
execute immediate sbsql;

sbsql:='CREATE INDEX "OPEN"."IX_LECTELME04" ON "OPEN"."LECTELME" ("LEEMSESU", "LEEMPECS", "LEEMTCON")';
execute immediate sbsql;

sbsql:='CREATE INDEX "OPEN"."IX_LECTELME05" ON "OPEN"."LECTELME" ("LEEMSESU", "LEEMTCON", "LEEMFELE")';
execute immediate sbsql;

sbsql:='CREATE INDEX "OPEN"."IX_LECTELME06" ON "OPEN"."LECTELME" ("LEEMDOCU", "LEEMSESU")';
execute immediate sbsql;

sbsql:='CREATE INDEX "OPEN"."IX_LECTELME07" ON "OPEN"."LECTELME" ("LEEMSESU", "LEEMELME", "LEEMPECS", "LEEMTCON")';
execute immediate sbsql;

sbsql:='CREATE INDEX "OPEN"."IX_LECTELME08" ON "OPEN"."LECTELME" ("LEEMOBSB")';
execute immediate sbsql;

sbsql:='CREATE INDEX "OPEN"."IX_LECTELME09" ON "OPEN"."LECTELME" ("LEEMOBSC")';
execute immediate sbsql;

sbsql:='CREATE INDEX "OPEN"."IX_LECTELME10" ON "OPEN"."LECTELME" ("LEEMDOCU")';
execute immediate sbsql;

sbsql:='CREATE INDEX "OPEN"."IX_LECTELME11" ON "OPEN"."LECTELME" ("LEEMPECS", "LEEMDOCU")';
execute immediate sbsql;

sbsql:='CREATE INDEX "OPEN"."IX_LECTELME12" ON "OPEN"."LECTELME" ("LEEMTCON")';
execute immediate sbsql;

sbsql:='CREATE INDEX "OPEN"."IX_LECTELME13" ON "OPEN"."LECTELME" ("LEEMPECS", "LEEMCLEC", "LEEMOBLE")';
execute immediate sbsql;

sbsql:='CREATE INDEX "OPEN"."IX_LECTELME14" ON "OPEN"."LECTELME" ("LEEMDOCU", "LEEMFELE", "LEEMCLEC")';
execute immediate sbsql;

sbsql:='CREATE INDEX "OPEN"."IX_LECTELME15" ON "OPEN"."LECTELME" ("LEEMFELE")';
execute immediate sbsql;

sbsql:='CREATE INDEX "OPEN"."IX_LECTELME16" ON "OPEN"."LECTELME" ("LEEMPETL")';
execute immediate sbsql;

sbsql:='CREATE INDEX "OPEN"."IX_LECTELME17" ON "OPEN"."LECTELME" ("LEEMELME")';
execute immediate sbsql;

sbsql:='CREATE INDEX "OPEN"."IX_LECTELME18" ON "OPEN"."LECTELME" ("LEEMPEFA")';
execute immediate sbsql;

sbsql:='CREATE INDEX "OPEN"."IX_LECTELME19" ON "OPEN"."LECTELME" ("LEEMCMSS")';
execute immediate sbsql;

sbsql:='CREATE INDEX "OPEN"."IX_LECTELME20" ON "OPEN"."LECTELME" ("LEEMOBLE")';
execute immediate sbsql;

sbsql:='CREATE INDEX "OPEN"."IX_LECTELME21" ON "OPEN"."LECTELME" ("LEEMSESU")';
execute immediate sbsql;

sbsql:='CREATE INDEX "OPEN"."IX_LEEM_ELME_FELE" ON "OPEN"."LECTELME" ("LEEMELME", "LEEMTCON", "LEEMFELE")';
execute immediate sbsql;

sbsql:='CREATE INDEX "OPEN"."IX_LEEM_ELME_PEFA" ON "OPEN"."LECTELME" ("LEEMELME", "LEEMPEFA", "LEEMTCON", "LEEMFELE")';
execute immediate sbsql;

sbsql:='CREATE INDEX "OPEN"."IX_LECTELME22" ON "OPEN"."LECTELME" (TRUNC("LEEMFELE"), "LEEMTCON", "LEEMSESU")
LOGGING
TABLESPACE TSI_BASICA
PCTFREE    5
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          16K
            NEXT             8K
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL';

execute immediate sbsql;

fix_elmesesufech;

UPDATE  MIGR_RANGO_PROCESOS SET RAPRTERM='T', RAPRFEFI=sysdate WHERE raprbase=inudatabase AND raprrain=NUMINICIO AND raprrafi=NUMFINAL AND raprcodi=3901;
commit;

end; 
/
