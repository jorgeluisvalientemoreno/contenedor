CREATE OR REPLACE procedure pr_borra_periodos(NUMINICIO number,NUMFINAL number,inubasedato number) is
cursor px is select * from perifact where  pefaano<>-1;
fi date;
ff date;
dd date;
d  number;
n  number;
m number;
sbfech varchar2(100);
V NUMBER;
L NUMBER;
B NUMBER;
dx perifact.pefadesc%type;
nuLogError NUMBER;
begin
     PKLOG_MIGRACION.prInsLogMigra (287,287,1,'pr_borra_periodos',0,0,'Inicia Proceso','INICIA',nuLogError);
    UPDATE  MIGR_RANGO_PROCESOS SET RAPRTERM='P', RAPRFEIN=sysdate WHERE raprbase=inubasedato AND raprrain=NUMINICIO AND raprrafi=NUMFINAL AND raprcodi=287;
    commit;
     for p in px loop
         select count(1) into n from factura where factpefa=p.pefacodi;
         select count(1) into m from conssesu where COSSPECS=p.pefacodi;
         SELECT /*+INDEX( CARGOS IX_CARGOS06)*/ COUNT(1) INTO V FROM CARGOS WHERE CARGPEFA=P.PEFACODI;
         SELECT /*+INDEX( LECTELME IX_LECTELME18)*/COUNT(1) INTO L FROM LECTELME WHERE LEEMPEFA=P.PEFACODI;
         SELECT/*+INDEX( LECTELME IX_LECTELME11)*/ COUNT(1) INTO B FROM LECTELME WHERE LEEMPECS=P.PEFACODI;
         if (n=0 and m=0 AND V=0 AND L=0 AND B=0)   then   -- usuario de facturación indico que no solo eran los menores del 2004 21/10/2014
            delete from PROCEJEC where PREJCOPE=p.pefacodi and prejfech<sysdate;
            delete from perifact where pefacodi=p.pefacodi and pefaffmo<sysdate;
            delete from pericose where pecscons=p.pefacodi and pecsfecf<sysdate;
            commit;
         end if;
     end loop;
     commit;

    UPDATE  MIGR_RANGO_PROCESOS SET RAPRTERM='T', RAPRFEFI=sysdate WHERE raprbase=inubasedato AND raprrain=NUMINICIO AND raprrafi=NUMFINAL AND raprcodi=287;
    commit;
    
	 PKLOG_MIGRACION.prInsLogMigra (287,287,3,'pr_borra_periodos',0,0,'Termina Proceso','FIN',nuLogError);
end; 
/
