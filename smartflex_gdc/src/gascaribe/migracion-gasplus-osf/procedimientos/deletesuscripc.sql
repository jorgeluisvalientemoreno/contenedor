CREATE OR REPLACE PROCEDURE Deletesuscripc (numinicio number ,numfinal number,pbd number)
AS

CURSOR cupagos
is
select rowid FROM   pagos WHERE pagosusc in (select susccodi FROM suscripc WHERE
not exists (select 'x' FROM pr_product
WHERE subscription_id=susccodi)
AND susccodi <>-1 );

CURSOR cucupones
is
SELECT rowid FROM  cupon WHERE cuposusc in (select susccodi FROM suscripc WHERE
not exists (select 'x' FROM pr_product
WHERE subscription_id=susccodi)
AND susccodi <>-1 );

CURSOR cufacturas
is
SELECT rowid FROM  factura WHERE factsusc in (select susccodi FROM suscripc WHERE
not exists (select 'x' FROM pr_product
WHERE subscription_id=susccodi)
AND susccodi <>-1 );


CURSOR cususcripc
IS
SELECT rowid FROM  suscripc WHERE
not exists (select 'x' FROM pr_product
WHERE subscription_id=susccodi)
AND susccodi <>-1;
  sberrormessage number;
  nuLogError number;
  nuErrorCode number;
BEGIN

   update migr_rango_procesos set raprfein=sysdate,RAPRTERM='P' where raprcodi=8600 and raprbase=pbd and raprrain=numinicio and raprrafi=NUMFINAL;
   commit;
   PKLOG_MIGRACION.prInsLogMigra (8600,8600,1,'DELETESUSCRIPC',0,0,'Inicia Proceso','INICIO',nuLogError);
   commit;

    for r in  cupagos
    loop
       DELETE FROM pagos WHERE rowid=r.rowid;
       commit;
    END loop;
    

    for r in  cucupones
    loop
       DELETE FROM cupon WHERE rowid=r.rowid;
       commit;
    END loop;
    

    for r in  cufacturas
    loop
       DELETE FROM factura WHERE rowid=r.rowid;
       commit;
    END loop;
    

    for r in  cususcripc
    loop
       DELETE FROM suscripc WHERE rowid=r.rowid;
       commit;
    END loop;

    update migr_rango_procesos set raprfefi=sysdate,RAPRTERM='T' where raprcodi=8600 and raprbase=pbd and raprrain=numinicio and raprrafi=NUMFINAL;
   commit;
   PKLOG_MIGRACION.prInsLogMigra (8600,8600,3,'DELETESUSCRIPC',0,0,'Finaliza Proceso','TERMINA',nuLogError);
   commit;

EXCEPTION
  when others then
    PKLOG_MIGRACION.prInsLogMigra ( 8600,8600,2,'DELETESUSCRIPC',1,0,'- Error: '||sbErrorMessage,to_char(nuErrorCode),nuLogError);


END; 
/
