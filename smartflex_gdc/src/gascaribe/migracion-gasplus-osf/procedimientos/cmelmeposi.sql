CREATE OR REPLACE procedure      CMELMEPOSI
as

Cursor cuElemmedi
IS
select d.EMSSCOEM,f.consecutive
from ldc_info_predio a, ab_premise f, ab_address e, pr_product c, elmesesu d
where a.premise_id=f.premise_id
and   f.premise_id=e.estate_number
and  e.address_id= c.address_id
and   c.PRODUCT_ID=d.emsssesu;

nuLogError number;
begin
PKLOG_MIGRACION.prInsLogMigra (278,278,1,'CMELMEPOSI',0,0,'Inicia Proceso','INICIO',nuLogError);
for r in cuElemmedi
loop
        update elemmedi set elmeposi=r.consecutive where elmecodi=r.EMSSCOEM;
End loop;

PKLOG_MIGRACION.prInsLogMigra (278,278,3,'CMELMEPOSI',0,0,'Termina Proceso','FIN',nuLogError);
End;

/
