CREATE OR REPLACE procedure  PR_OR_ORDER_LECTELME (NUMINICIO number, NUMFINAL number,inudatabase number )
as

nuComplementoPR   number;
   nuComplementoSU   number;
   nuComplementoFA   number;
   nuComplementoCU   number;
   nuComplementoDI  number;
  vfecha_ini          DATE;
   vfecha_fin          DATE;
   vprograma           VARCHAR2 (100);
   verror              VARCHAR2 (4000);
   vcont               NUMBER;
   nuREg               NUMBER := 0;
   vcontLec               NUMBER := 0;
   vcontIns               NUMBER := 0;
   nuSuscriptor        number := 0;
   sbLectura           VARCHAR2(30) := null;

cursor cuorder1
is
SELECT  lect.rowid,lect.*,act.ORDER_ACTIVITY_ID oract,ord.legalization_date,ord.execution_final_date
FROM    OR_order ORD, OR_ORDER_ACTIVITY act, pr_product prod, lectelme lect,perifact pf
WHERE   ord.task_type_id in (12521, 10169, 12526, 12528, 10546, 10547)
        AND ord.order_id = act.order_id
        AND prod.product_id = act.product_id
        AND prod.product_status_id = 2
        AND lect.leemsesu = prod.product_id
        AND lect.leemclec = 'T'
        and lect.leempefa=pf.pefacodi
        AND lect.leemdocu IS null
        AND trunc(ord.legalization_date) between pf.pefafimo and pf.pefaffmo;
               
        
cursor cuorder2
is
SELECT  lect.rowid,lect.*,act.ORDER_ACTIVITY_ID oract,ord.legalization_date,ord.execution_final_date
FROM    OR_order ORD, OR_ORDER_ACTIVITY act, pr_product prod, lectelme lect,perifact pf
WHERE   ord.task_type_id in (12521, 10169, 12526, 12528, 10546, 10547)
        AND ord.order_id = act.order_id
        AND prod.product_id = act.product_id
        AND prod.product_status_id = 2
        AND lect.leemsesu = prod.product_id
        AND lect.leemclec = 'T'
        and lect.leempefa=pf.pefacodi
        AND trunc(lect.leemfele) = trunc(ord.legalization_date)
        AND lect.leemdocu IS null;       

cursor cuorder3
is
SELECT  lect.rowid,lect.*,act.ORDER_ACTIVITY_ID oract,ord.legalization_date,ord.execution_final_date
FROM    OR_order ORD, OR_ORDER_ACTIVITY act, pr_product prod, lectelme lect,perifact pf
WHERE   ord.task_type_id in (12521, 10169, 12526, 12528, 10546, 10547)
        AND ord.order_id = act.order_id
        AND prod.product_id = act.product_id
        AND prod.product_status_id = 2
        AND lect.leemsesu = prod.product_id
        AND lect.leemclec = 'T'
        and lect.leempefa=pf.pefacodi
        --AND trunc(ord.legalization_date) between pf.pefafimo and pf.pefaffmo
        --AND trunc(lect.leemfele) = trunc(ord.legalization_date)
        AND trunc(lect.leemfele) = trunc(ord.execution_final_date)
        AND lect.leemdocu IS null;                       

    nuLogError NUMBER;
    nuTotalRegs number := 0;
    nuErrores number := 0;
    nl number;
begin

  PKLOG_MIGRACION.prInsLogMigra (4881,4881,1,'PR_OR_ORDER_LECTELME',0,0,'Inicia Proceso','INICIO',nuLogError);
  UPDATE  MIGR_RANGO_PROCESOS SET RAPRTERM='P', RAPRFEIN=sysdate WHERE raprbase=inudatabase AND raprrain=NUMINICIO AND raprrafi=NUMFINAL AND raprcodi=4881;
  commit;
        
       for r in cuorder1
       loop
            begin
        
                update lectelme set leemdocu=r.oract where rowid=r.rowid;
                commit;
            exception
            when others then
             PKLOG_MIGRACION.prInsLogMigra (4881,4881,2,'PR_OR_ORDER_LECTELME',0,0,'Error: '||verror,to_char(sqlcode),nuLogError);
                   
            end;
        
       end loop;
       
       for r in cuorder2
       loop
            begin
        
                update lectelme set leemdocu=r.oract where rowid=r.rowid;
                commit;
            exception
            when others then
             PKLOG_MIGRACION.prInsLogMigra (4881,4881,2,'PR_OR_ORDER_LECTELME',0,0,'Error: '||verror,to_char(sqlcode),nuLogError);
                   
            end;
        
       end loop;
       
       for r in cuorder3
       loop
            begin
        
                update lectelme set leemdocu=r.oract where rowid=r.rowid;
                commit;
            exception
            when others then
             PKLOG_MIGRACION.prInsLogMigra (4881,4881,2,'PR_OR_ORDER_LECTELME',0,0,'Error: '||verror,to_char(sqlcode),nuLogError);
                   
            end;
        
       end loop;
        
 -- Termina Log
   PKLOG_MIGRACION.prInsLogMigra (4881,4881,3,' PR_OR_ORDER_LECTELME',vcontIns,nuErrores,'TERMINO PROCESO #regs: '||vcontIns,'FIN',nuLogError);
   UPDATE  MIGR_RANGO_PROCESOS SET RAPRTERM='T', RAPRFEFI=sysdate WHERE raprbase=inudatabase AND raprrain=NUMINICIO AND raprrafi=NUMFINAL AND raprcodi=4881;
   commit;
end; 
/
