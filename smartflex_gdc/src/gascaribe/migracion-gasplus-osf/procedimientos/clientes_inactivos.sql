CREATE OR REPLACE procedure CLIENTES_INACTIVOS (numinicio number, numfinal number, inubasedato number)
as

cursor cuclientesactivos
is
SELECT subscriber_id
FROM ge_subscriber WHERE  subs_status_id<>1
AND  subscriber_id>50000
and  exists (select 'x' FROM pr_product, suscripc
                WHERE    susccodi=subscription_id
                AND  product_status_id  in (1,2,15)
                AND subscriber_id=suscclie);

cursor cuclientesenpotencia
is
SELECT subscriber_id
FROM ge_subscriber WHERE  subs_status_id <>2
AND  subscriber_id>50000
and not exists (select 'x' FROM pr_product, suscripc
                WHERE    susccodi=subscription_id
                AND subscriber_id=suscclie);

cursor cuclientesinactivos
is
SELECT subscriber_id
FROM ge_subscriber WHERE  subs_status_id <>3
AND  subscriber_id>50000
and  exists (select 'x' FROM pr_product, suscripc
                WHERE    susccodi=subscription_id
                AND subscriber_id=suscclie)
AND  not exists (select 'x' FROM pr_product, suscripc
                WHERE    susccodi=subscription_id
                AND  product_status_id  in (1,2,15)
                AND subscriber_id=suscclie);

nuLogError NUMBER;
nuTotalRegs number := 0;
nuErrores number := 0;
vfecha_ini          DATE;
vfecha_fin          DATE;
vprograma           VARCHAR2 (100);
verror              VARCHAR2 (4000);
vcont               NUMBER;

begin

PKLOG_MIGRACION.prInsLogMigra (8500,8500,1,'CLIENTES_INACTIVOS',0,0,'Inicia Proceso','INICIO',nuLogError);
UPDATE  MIGRA.MIGR_RANGO_PROCESOS SET RAPRTERM='P', RAPRFEIN=sysdate WHERE raprbase=inubasedato AND raprrain=NUMINICIO AND raprrafi=NUMFINAL AND raprcodi=8500;


    for r in cuclientesactivos
    loop
        begin
            update ge_subscriber set subs_status_id=1,active='Y' where subscriber_id=r.subscriber_id;
            Commit;
        EXCEPTION
            when others then
                 BEGIN
                   verror := 'Error en el cliente C : '||r.subscriber_id||' - '|| SQLERRM;
                   nuErrores := nuErrores + 1;
                   PKLOG_MIGRACION.prInsLogMigra (8500,8500,2,'CLIENTES_INACTIVOS',0,0,'Error: '||verror,to_char(sqlcode),nuLogError);
                 END;
        END;
    end loop;

    for r in cuclientesenpotencia
    loop
        bEGIN
            update ge_subscriber set subs_status_id=2,active='Y'where subscriber_id=r.subscriber_id;
            Commit;
        EXCEPTION
            when others then
                 BEGIN
                   verror := 'Error en el cliente C : '||r.subscriber_id||' - '|| SQLERRM;
                   nuErrores := nuErrores + 1;
                   PKLOG_MIGRACION.prInsLogMigra (8500,8500,2,'CLIENTES_INACTIVOS',0,0,'Error: '||verror,to_char(sqlcode),nuLogError);
                 END;
        END;
    end loop;

    for r in cuclientesinactivos
    loop
        BEGIN
            update ge_subscriber set subs_status_id=3,active='Y' where subscriber_id=r.subscriber_id;
            Commit;
        EXCEPTION
            when others then
                 BEGIN
                   verror := 'Error en el cliente C : '||r.subscriber_id||' - '|| SQLERRM;
                   nuErrores := nuErrores + 1;
                   PKLOG_MIGRACION.prInsLogMigra (8500,8500,2,'CLIENTES_INACTIVOS',0,0,'Error: '||verror,to_char(sqlcode),nuLogError);
                 END;
        END;
    end loop;



PKLOG_MIGRACION.prInsLogMigra (8500,8500,3,'CLIENTES_INACTIVOS',0,0,'Finaliza Proceso','FIN',nuLogError);
UPDATE  MIGRA.MIGR_RANGO_PROCESOS SET RAPRTERM='T', RAPRFEFI=sysdate WHERE raprbase=inubasedato AND raprrain=NUMINICIO AND raprrafi=NUMFINAL AND raprcodi=8500;

EXCEPTION
   WHEN OTHERS
   THEN
      PKLOG_MIGRACION.prInsLogMigra (8500,8500,2,'CLIENTES_INACTIVOS',0,0,'Error: '||sqlerrm,to_char(sqlcode),nuLogError);

end; 
/
