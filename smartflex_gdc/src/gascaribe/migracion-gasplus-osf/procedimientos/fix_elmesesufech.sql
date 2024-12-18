CREATE OR REPLACE procedure fix_elmesesufech as
cursor ce is SELECT /*+ parallel */ EMSSSESU FROM  (SELECT EMSSSESU,COUNT(1) FROM ELMESESU
GROUP BY EMSSSESU HAVING COUNT(1)=2);
fere date;
nuLogError number;
begin
   PKLOG_MIGRACION.prInsLogMigra (2151,2151,1,'fix_elmesesufech',0,0,'Inicia Proceso','INICIO',nuLogError);
	 for c in ce loop
         select nvl(min(leemfele),sysdate)
                into fere
                from lectelme
                where leemsesu=c.emsssesu and
                      leemcmss=(select EMSSCMSS
                                       from elmesesu
                                       where emsssesu=c.emsssesu and
                                             emssfere>sysdate+1000);
         update elmesesu
                set EMSSFEIN=fere
                where emsssesu=c.emsssesu and
                      emssfere>sysdate+1000;
         update elmesesu
                set EMSSFEre=fere-1
                where emsssesu=c.emsssesu and
                      nvl(emssfere,sysdate)<=sysdate;
         commit;
     end loop;
     PKLOG_MIGRACION.prInsLogMigra (2151,2151,3,'fix_elmesesufech ',0,0,'Termina Proceso','FIN',nuLogError);	 
     commit;
end; 
/
