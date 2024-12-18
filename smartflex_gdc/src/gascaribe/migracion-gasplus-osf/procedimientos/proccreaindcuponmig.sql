CREATE OR REPLACE procedure proccreaindcuponmig(ini number,fin number,pbd number)
AS

sbsql  varchar2(2000);

BEGIN

  UPDATE migr_rango_procesos set raprfein=sysdate,raprterm='P' where raprcodi=2002 and raprbase=pbd and raprrain=ini and raprrafi=fin;
   COMMIT;




sbsql:='CREATE INDEX OPEN.IX_CUPON01 ON OPEN.CUPON
        (CUPOSUSC, CUPOFECH)
        LOGGING
        TABLESPACE TSI_DATOS
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

sbsql:='CREATE INDEX OPEN.IX_CUPON03 ON OPEN.CUPON
(CUPOCUPA)
LOGGING
TABLESPACE TSI_RECAUDO
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

sbsql:='CREATE INDEX OPEN.IX_CUPO_DOCU_TIPO ON OPEN.CUPON
(CUPODOCU, CUPOTIPO, CUPOFECH)
LOGGING
TABLESPACE TSI_DATOS
PCTFREE    10
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

UPDATE migr_rango_procesos set raprfefi=sysdate,raprterm='T' where raprcodi=2002 and raprbase=pbd and raprrain=ini and raprrafi=fin;
commit;

end; 
/
