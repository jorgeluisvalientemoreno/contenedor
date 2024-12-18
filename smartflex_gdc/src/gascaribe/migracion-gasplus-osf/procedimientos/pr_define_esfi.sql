CREATE OR REPLACE PROCEDURE      "PR_DEFINE_ESFI" (ini number, fin number,pbd number) is
cursor u is select sesunuse,sesuesfn,sesuserv,sesuesco from servsusc WHERE SESUSUSC>=INI AND SESUSUSC<FIN;

cursor cucastigados 
is 
select sesunuse 
from ldc_temp_servsusc_sge 
where sesuesfi=1
and SESUSUSC>=INI AND SESUSUSC<FIN;
nuLogError number;
van number;
CC SERVSUSC.SESUESFN%TYPE;
gef number;
sw number;
m number;
n number;
nc1 number;
begin
   PKLOG_MIGRACION.prInsLogMigra (1998,1998,1,'PR_DEFINE_ESFI',0,0,'Inicia Proceso','INICIO',nuLogError);   
  UPDATE migr_rango_procesos set raprfein=sysdate,raprterm='P' where raprcodi=1998 and raprbase=pbd and raprrain=INI and raprrafi=FIn;
    commit;
    for s in u loop
     begin   
         gef:=-1;
         SW:=0;
         cc:=null;
         n:=0;
         m:=0;
         IF SW=0 THEN
            select /*+ index( cuencobr IX_CUENCOBR03)*/
                   count(1)
                   into n
                   from cuencobr
                   where cuconuse=s.sesunuse and
                         nvl(cucosacu,0)>0;
            select /*+ index( cuencobr IX_CUENCOBR03)*/ count(1)
                   into m
                   from cuencobr
                   where cuconuse=s.sesunuse and
                         nvl(cucosacu,0)>0 and
                         sysdate>cucofeve;
            if n>=2 then
               cc:='M';
            ELSE
               IF N=0 THEN
                  CC:='A';
               ELSE
                  IF M=1 THEN
                     CC:='M';
                  ELSE
                    CC:='D';
                  END IF;
               END IF;
            END IF;
         END IF;
         UPDATE SERVSUSC
                   SET SESUESFN=CC
                   WHERE SESUNUSE=S.SESUNUSE;
         if s.sesuserv=7014 and (s.sesuesco=3 or s.sesuesco=5) then
            update servsusc set sesufeco=sysdate where sesunuse=s.sesunuse;
         end if;
         commit;
    exception
        when others then
          PKLOG_MIGRACION.prInsLogMigra ( 1998,1998,2,'PR_DEFINE_ESFI',0,0,'SERVICIO : '||s.sesunuse||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);

    end;
   end loop;
   
   if pbd=4 then
      begin
           for r in cucastigados
           loop
               
               UPDATE SERVSUSC
                   SET SESUESFN='C'
                   WHERE SESUNUSE=r.SESUNUSE;         
           end loop;
      end;
   end if;
   
   if pbd = 4 then
       UPDATE CUENCOBR SET CUCOSACU=NULL WHERE CUCOSACU<>0 AND CUCONUSE IN (SELECT SESUNUSE FROM SERVSUSC WHERE SESUESFN='C');
   end if;
       
   PKLOG_MIGRACION.prInsLogMigra (1998,1998,3,'PR_DEFINE_ESFI',0,0,'Inicia Proceso','INICIO',nuLogError);   
   UPDATE migr_rango_procesos set raprfeFi=sysdate,raprterm='T' where raprcodi=1998 and raprbase=pbd and raprrain=INI and raprrafi=FIN;
   commit;
exception
 when others then
    null;
end; 
/
