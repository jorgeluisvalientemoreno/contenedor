
  CREATE OR REPLACE PROCEDURE "OPEN"."ACTDIF" (ini number,fin number) is
cursor di is select  * from diferido where difesusc>=ini and difesusc<fin;
fumo date;
fein date;
SV NUMBER;
CT NUMBER;
CUENTAS NUMBER;
DIFES NUMBER;
PLDI NUMBER;
van number;
nuLogError number;
cursor ux is select sesunuse,SESUSERV from servsusc where sesuserv in (7053,7055) and sesususc>=ini and sesususc<fin;
cursor db is select * from diferido WHERE DIFECUPA=0 and difenuse>70000000 and difesusc>=ini and difesusc<fin;
fd date;
delta number;
begin
     van:=0;
     PKLOG_MIGRACION.prInsLogMigra (283,283,1,'ACTDIF',0,0,'Inicia Proceso','INICIO',nuLogError);
     update diferido set difepldi=73 where difesusc>1000000 and difepldi=7 and difesusc>=ini and difesusc<fin;
     commit;
     for d in di loop
         SELECT SESUSERV,SESUCATE INTO SV,CT FROM SERVSUSC WHERE SESUNUSE=D.DIFENUSE;
         PLDI:=D.DIFEPLDI;
         IF SV=7053 THEN
            PLDI:=50;
         ELSE
            IF SV=7055 THEN
               IF CT=1 THEN
                  IF D.DIFECONC=49 THEN
                     PLDI:=41;
                  ELSE
                     PLDI:=42;
                 END IF;
               ELSE
                  IF CT=2 THEN
                     PLDI:=40;
                  END IF;
               END IF;
            END IF;
         END IF;
         UPDATE DIFERIDO SET DIFEPLDI=PLDI WHERE DIFECODI=D.DIFECODI;
         van:=van+1;
         update movidife set modipoin=d.difeinte where modidife=d.difecodi;
         fumo:=null;
         begin
              select max(modifech) into fumo from movidife where modidife=d.difecodi;
              begin
                   select modifech into fein from movidife where modidife=d.difecodi and modicuap=0;
              exception
                   when others then
                        fein:=d.difefein;
              end;

         exception
              when others then
                   fumo:=null;
         end;
         if fumo is not null then
            update diferido set difefumo=fumo,difefein=fein where difecodi=d.difecodi;
         end if;
         if van=1000 then
            commit;
            van:=0;
         end if;

     end loop;
     COMMIT;

     for e in db loop
         if e.difesusc>1000000 then
            delta:=10000000;
         else
            delta:=0;
         end if;
        fd:=null;
         begin
            select CARGFECR INTO FD FROM CARGOS WHERE CARGNUSE=E.DIFENUSE AND CARGDOSO LIKE 'SID-%' AND
            TO_NUMBER (SUBSTR (cargdoso, 5, (INSTR (cargdoso, ' ') - 4))) =  E.difecodi-DELTA;
         exception
            when others then
                 fd:=null;
         end;
         if fd is not null then
            update diferido set difefumo=fd where difecodi=e.difecodi;
         end if;
     end loop;

     for u in ux loop
         IF U.SESUSERV=7053 THEN
            UPDATE PR_PRODUCT SET COMMERCIAL_PLAN_ID=26 WHERE PRODUCT_ID=U.SESUNUSE;
            UPDATE CUENCOBR SET CUCOPLSU=26 WHERE CUCONUSE=U.SESUNUSE;
            update servsusc set sesuplfa=26 where sesunuse=u.sesunuse;
         ELSE
            UPDATE PR_PRODUCT SET COMMERCIAL_PLAN_ID=28 WHERE PRODUCT_ID=U.SESUNUSE;
            UPDATE CUENCOBR SET CUCOPLSU=28 WHERE CUCONUSE=U.SESUNUSE;
            update servsusc set sesuplfa=28 where sesunuse=u.sesunuse;
         END IF;
         COMMIT;
     end loop;

	PKLOG_MIGRACION.prInsLogMigra (283,283,3,'ACTDIF',0,0,'Termina Proceso','FIN',nuLogError);
end;
/
