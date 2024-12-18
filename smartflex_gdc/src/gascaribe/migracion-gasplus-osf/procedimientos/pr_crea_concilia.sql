CREATE OR REPLACE PROCEDURE      "PR_CREA_CONCILIA" (INI NUMBER,FIN NUMBER,pbd number) is
cursor cubanco is select distinct banchomo
 from ldc_mig_banco where banchomo in (select banccodi from banco) and basedato=pbd;
nc number;
vprograma           VARCHAR2 (100);
nuLogError number;
N NUMBER;
begin
     UPDATE migr_rango_procesos set raprfeIN=sysdate,raprterm='P' where raprcodi=1111 and raprbase=pbd and raprrain=INI and raprrafi=FIN;
     PKLOG_MIGRACION.prInsLogMigra (1111,1111,1,'pr_crea_concilia',0,0,'Inicia Proceso','INICIO',nuLogError);

     -- por cada banco se va a crear una conciliacion en OSF
     for b in cubanco loop
         SELECT COUNT(1) INTO N FROM CONCILIA WHERE CONCBANC=B.BANCHOMO;
         IF N=0 THEN
            select sq_concilia_183049.nextval into nc from dual;
            insert into concilia (CONCBANC,CONCFEPA,CONCNUCU,CONCCAPA,CONCVATO,CONCFERE,
                               CONCFLPR,CONCPRRE,CONCFUNC,CONCFECI,CONCSIST,CONCCIAU,CONCCONS)
                       values (b.banchomo,sysdate,0,0,0,SYSDATE,
        'S',0,200,SYSDATE,99,'S',nc);
            commit;
         END IF;
   end loop;
   UPDATE migr_rango_procesos set raprfeFI=sysdate,raprterm='T' where raprcodi=1111 and raprbase=pbd and raprrain=INI and raprrafi=FIN;
   COMMIT;
   PKLOG_MIGRACION.prInsLogMigra (1111,1111,3,'pr_crea_concilia',0,0,'Termina Proceso','FIN',nuLogError);
end; 
/
