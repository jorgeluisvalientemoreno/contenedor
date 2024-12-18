CREATE OR REPLACE procedure proccreaindmovidife(ini number,fin number,pbd number)
AS
sbsql  varchar2(2000);
BEGIN

  UPDATE migr_rango_procesos set raprfein=sysdate,raprterm='P' where raprcodi=3002 and raprbase=pbd and raprrain=ini and raprrafi=fin;
   COMMIT;

sbsql:='CREATE INDEX OPEN.IX_MOVIDIFE01 ON OPEN.MOVIDIFE (MODIDIFE)';
execute immediate sbsql;
commit;
sbsql:='CREATE INDEX OPEN.IX_MOVIDIFE02 ON OPEN.MOVIDIFE (MODISUSC, MODINUSE) NOLOGGING PARALLEL';
execute immediate sbsql;
commit;
sbsql:='CREATE INDEX OPEN.IX_MOVIDIFE03 ON OPEN.MOVIDIFE (MODIFECA, MODIDIFE) NOLOGGING PARALLEL';
execute immediate sbsql;
commit;
sbsql:='CREATE INDEX OPEN.IX_MOVIDIFE04 ON OPEN.MOVIDIFE (MODIFECH) NOLOGGING PARALLEL';
execute immediate sbsql;
commit;
sbsql:='CREATE INDEX OPEN.IX_MOVIDIFE06 ON OPEN.MOVIDIFE (MODINUSE) NOLOGGING PARALLEL';
execute immediate sbsql;
commit;
sbsql:='CREATE INDEX OPEN.IX_MOVIDIFE07 ON OPEN.MOVIDIFE (MODISUSC) NOLOGGING PARALLEL';
execute immediate sbsql;
commit;
sbsql:='CREATE INDEX OPEN.IX_MOVIDIFE08 ON OPEN.MOVIDIFE (MODISIGN) NOLOGGING PARALLEL';
execute immediate sbsql;
commit;
sbsql:='CREATE INDEX OPEN.IX_MOVIDIFE09 ON OPEN.MOVIDIFE (MODICACA) NOLOGGING PARALLEL';
execute immediate sbsql;
commit;

EXECUTE IMMEDIATE 'BEGIN DBMS_STATS.GATHER_TABLE_STATS('||chr(39)||'OPEN'||chr(39)||','||chr(39)||'DIFERIDO'||chr(39)||', ESTIMATE_PERCENT => 100, CASCADE => TRUE); END;';
EXECUTE IMMEDIATE 'BEGIN DBMS_STATS.GATHER_TABLE_STATS('||chr(39)||'OPEN'||chr(39)||','||chr(39)||'MOVIDIFE'||chr(39)||', ESTIMATE_PERCENT => 100, CASCADE => TRUE); END;'; 

UPDATE migr_rango_procesos set raprfefi=sysdate,raprterm='T' where raprcodi=3002 and raprbase=pbd and raprrain=ini and raprrafi=fin;
commit;

end; 
/
